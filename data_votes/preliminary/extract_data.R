# Extract (preliminary) election results from HTML pages on electionresults.govt.nz
# -- David Friggens, 2017-09-28

library(magrittr)
library(dplyr)
library(purrr)
library(rvest)
library(stringr)

scalpel_please_nurse <- function(filename) {
  the_html <-
    filename %>% 
    read_html()

  the_electorate_name <- 
    the_html %>% 
    html_node("div.page-title h2") %>% 
    html_text() %>% 
    str_extract("[^ ]+")
  
  the_id <-
    the_html %>% 
    html_node("div.page-title h4") %>% 
    html_text() %>% 
    str_extract("[0-9]+") %>% 
    as.integer()
  
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


GE2017_prelim <-
  list.files(path = "data_votes/preliminary", pattern = "html", full.names = TRUE) %>% 
  map_df(scalpel_please_nurse)

save(GE2017_prelim, file = "data_votes/preliminary/GE2017_prelim.rda")


