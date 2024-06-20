library(healthds)
library(tidyverse)

# Quiz 1
set.seed(1234)
sims = simulate_t(rep = 1000, mean1 = 3.0, mean2 = 3.0, n1 = 25, n2 = 25, sd = 0.5)
hist(sims$t)

library(healthds)
set.seed(1234)
sims = simulate_t(rep = 1000, mean1 = 4.5, mean2 = 3.0, 
                  n1 = 25, n2 = 25, sd = 0.5)
hist(sims$t)
mean(sims$t)

sims = simulate_t(rep = 1000, mean1 = 4.5, mean2 = 3.0, 
                  n1 = 25, n2 = 25, sd = 0.5)
curve(dt(x, df = 48), col="darkblue", lwd=2, yaxt="n", 
      from = -2, to = 16)
hist(sims$t, add = TRUE, probability = TRUE)







data("BPUrban300")
