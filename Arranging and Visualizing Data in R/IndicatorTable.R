library(tidyverse)

# read in data
micro_world <- read_csv("micro_world.csv")

# overall account ownership
overall_account <-
  micro_world %>%
  group_by(economy) %>%
  summarize(account = 100 * weighted.mean(account, w = wgt))

# account ownership by gender
account_gap_female <-
  micro_world %>%
  group_by(economy, female) %>%
  summarize(account = 100 * weighted.mean(account, w = wgt))


# gender gap in account ownership
account_gap_female <-
  micro_world %>%
  group_by(economy, female) %>%
  summarize(account = 100 * weighted.mean(account, w = wgt)) %>%
  pivot_wider(id_cols = economy,
              names_from = female,
              names_prefix = "female",
              values_from = account) %>%
  mutate(gap_female = female1 - female2) %>%
  select(economy, gap_female)

# income gap in account ownership
account_gap_inc <-
  micro_world %>%
  mutate(lower_inc = inc_q <= 2) %>%
  group_by(economy, lower_inc) %>%
  summarize(account = 100 * weighted.mean(account, w = wgt)) %>%
  pivot_wider(id_cols = economy,
              names_from = lower_inc,
              names_prefix = "lower_inc",
              values_from = account) %>%
  
mutate(gap_inc = lower_incFALSE - lower_incTRUE) %>%
select(economy, gap_inc)

# indicator table
indicator_table <-
  full_join(overall_account,
            account_gap_female,
            by = "economy") %>%
  full_join(account_gap_inc,
            by = "economy") %>%
  mutate(account = round(account),
         gap_female = round(gap_female),
         gap_inc = round(gap_inc))

write.csv(indicator_table, "indicatortable.csv" , row.names = FALSE)
