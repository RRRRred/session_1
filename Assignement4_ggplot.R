# ggplot 2 exercise
# Assignment 4

library(ggplot2)
library(tidyverse)
d <- read.csv("C:/Users/Eigenaar/Documents/R cursus EUR/ad_readability.csv")
str(d)
glimpse(d)
d$MAG <- factor( d$MAG, levels = 1:9, labels = c( "Scientific American", "Fortune", 
                                                  "The New Yorker Group", 
                                                  "Sports Illustrated", "Newsweek", 
                                                  "People", "National Enquirer", "Grit", 
                                                  "True Confessions" ) )
d$GRP <- factor ( d$GRP, levels = 1:3, labels = c( "Highest educational level",
                                                   "Medium educational level",
                                                   "Lowest educational level"))
colnames(d) <- c( "Num.Words", "Num.Sentences", "Num.3.Syllable.Words", "Magazine", "Educational.Level" )
levels(d$Educational.Level) <- c("Highest", "Medium", "Lowest") 


g <- ggplot(d, aes(x = Num.Words)) 
    g + geom_histogram(binwidth = 5) +
    labs(x = "Words", y = "Observations",
         title = "Histogram of Number of Words in Various Ads")
    
g <- ggplot(d, aes(x = Num.Sentences)) 
  g + geom_histogram(binwidth = 2) + 
    labs(x = "Sentences", y = "Observations", 
        title = "Histogram of Number of Sentences in Various Ads")

ggplot(d, aes(x = Num.3.Syllable.Words)) + 
  geom_histogram(binwidth = 5) + 
  labs(x = "3 Syllable Words", y = "Observations",
       title = "Histogram of 3 Syllable Words")

ggplot(d, aes(x = Num.Words, fill = Magazine)) + 
  geom_histogram(binwidth = 10)

ggplot(d, aes(x = Num.Words, fill = Educational.Level)) + 
  geom_histogram(binwidth = 10)

ggplot(d, aes(x = Num.Words)) + geom_histogram(binwidth = 10) + 
  facet_grid(Educational.Level ~ .)

g <- ggplot(d, aes(x = Num.Sentences)) 
g + geom_histogram(binwidth = 2) + facet_grid(Educational.Level ~ .)
g + geom_histogram(binwidth = 2) + facet_grid(Educational.Level ~ .) + 
  scale_x_continuous(breaks = c(5, 10, 15, 20, 25), name = "Sentences") + 
  scale_y_continuous(breaks = c(1, 3, 5), name = "Observations") + 
  labs(title = "Number of Sentences in Ads by Education of Readers")
ggsave( "C:/Users/Eigenaar/Documents/R cursus EUR/histogram_num_sentences_by_ed.pdf" )
ggsave( "C:/Users/Eigenaar/Documents/R cursus EUR/histogram_num_sentences_by_ed.png" )

