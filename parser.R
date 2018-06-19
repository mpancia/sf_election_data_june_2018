library(stringr)
library(tidyverse)
library(magrittr)
library(here)

ELECTION_DATA_FILE <- here("raw_data", "20180618_psov.tsv")

raw <- readLines(ELECTION_DATA_FILE) %>% 
  paste(collapse = "\n") %>% 
  stringr::str_split("\n\n", simplify = TRUE) %>%
  .[1,]

process_chunk <- function(chunk){
  chunk %<>%
    purrr::keep(~ stringr::str_length(.x) > 1) %>%
    purrr::discard(~ stringr::str_detect(.x, "Grand"))
  title <- chunk[[1]] %>% 
    stringr::str_remove("\\*\\*\\*") %>%
    stringr::str_trim() %>%
    stringr::str_remove("-") %>%
    stringr::str_replace_all(" ", "_") %>%
    stringr::str_replace_all("/", "_") %>%
    stringr::str_remove(",")
  remainder <- chunk[3:length(chunk)] %>% 
    paste(collapse="\n")
  df <- readr::read_tsv(remainder, progress = FALSE)
  if(nrow(df) < 100) {
    title <- paste0(title, "_district")
  } else {
    title <- paste0(title, "_precinct")
  }
  return(list(df = df, title = title))
} 

chunks <- raw %>%
  stringr::str_split("\n") %>%
  purrr::keep(~ length(.x) > 1) 

chunks %<>%
  purrr::map(process_chunk) 
  
chunks %>%
  purrr::map(~ write_tsv(.$df, here("processed_data", .$title)))

