# Extract election results from HTML pages on electionresults.govt.nz
# -- David Friggens, 2017-10-07

library(magrittr)
library(dplyr)
library(purrr)
library(rvest)
library(stringr)

download_and_process_electorate_results <- function(id) {
  the_html <-
    paste0("http://electionresults.govt.nz/electionresults_2017/electorate-details-",
           if_else(id < 10, "0", ""), id,
           ".html") %>% 
    read_html()

  the_electorate_name <- 
    the_html %>% 
    html_node("div.page-title h2") %>% 
    html_text() %>% 
    str_replace(" - Official Result", "")
  
  the_id <- id
  
  untidy_table <-
    the_html %>% 
    html_node("#partyCandidatesResultsTable") %>% 
    html_table() %>% 
    mutate(Candidate_Name = Candidates %>% str_extract("^[^\\n]+"),
           Candidate_Votes = Candidates %>% str_extract("[0-9]+$") %>% as.integer(),
           Party_Name = Party %>% str_extract("^[^\\n]+"),
           Party_Votes = Party %>% str_extract("[0-9]+$") %>% as.integer()) %>% 
    select(-Candidates, -Party) %>% 
    filter(!str_detect(Party_Name, "TOTAL:"))
  
  candidate_votes <-
    untidy_table %>% 
    filter(!is.na(Candidate_Votes)) %>% 
    mutate(id = the_id,
           electorate_name = the_electorate_name,
           Party_Name = if_else(str_detect(Party_Name, "Informal"), "Informal Candidate Votes", Party_Name),
           Candidate_Name = if_else(str_detect(Candidate_Name, "Informal"), "Informal Candidate Votes", Candidate_Name),
           VotingType = "Candidate") %>% 
    select(id,
           electorate_name,
           Party = Party_Name,
           Votes = Candidate_Votes,
           VotingType,
           Candidate = Candidate_Name) 
  
  party_votes <-
    untidy_table %>% 
    mutate(id = the_id,
           electorate_name = the_electorate_name,
           Party_Name = if_else(str_detect(Party_Name, "Informal"), "Informal Party Votes", Party_Name),
           Candidate = NA_character_,
           VotingType = "Party") %>% 
    select(id,
           electorate_name,
           Party = Party_Name,
           Votes = Party_Votes,
           VotingType,
           Candidate)
  
  return(bind_rows(candidate_votes, party_votes))
}


GE2017 <-
  1:71 %>% 
  map_df(download_and_process_electorate_results)

save(GE2017, file = "data_votes/GE2017.rda")


