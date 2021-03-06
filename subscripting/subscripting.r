#============================================
# Quick Subscripting and Layering with R and GGPlot2
# by Clint Newsom
# hcnewsom@gmail.com
#============================================


# Begin by reading in our file as usual. This time we're using some new data! So we'll start by snipping off our original header
# to include more readable labels. 
elec = read.delim("http://hcnewsom.org/expldata/QryCandidates_AC.txt", sep="\t",header=FALSE, col.names=c("state_name","ac_number", "ac_name","schedule", "cand_sl_no", "candidate_name", "candidate_sex", "party_abbreviation", "party_name", "symbol_number", "symbol_description", "candidate_age", "candidate_category"))

# make sure our data is correct. 
head(elec)

# check out a summary of our data. 
summary(elec)

#ggplot2
library(ggplot2)

# create a data frame. 
attach(elec)

# another way to see what's up witn your data is to
# list out your columns with the names() function. 
names(elec)

# Now, suppose we want to see the symbol_description column. Each party is required to include
# a party smybol on election ballots. This was a law put into place by parliament in order
# those who spoke/read dialects other than Hindi, or were otherwise illiterate, capable of voting.
# If you output this data to the screen you are going to get a very long list of symbols. 
elec$symbol_description

# Lets try a shortcut. let's pull out the column by its position. 
elec[11]

# one more way of doing this...
elec["symbol_description"]

# Using two brackets will return he number of levels in our column.
elec[[11]]

# try getting a summary of the levels.
str(elec[[11]])

# retrive the mode of our summary.
mode(elec[[11]])

# now lets grab some specific rows. Ask for row 10.
elec[10,]

# This returns the areoplane symbol for an Independant party running in Andrah Pradesh.
elec[505,1:11]

#now lets ask for a specific sequence of columns.
names(elec)
#return state_name, candidate_name, candidate_sex, symbol_description, candidate_age
elec[c(1,6,7,11,12)]

# Now lets asks for a squence of columns and rows. Here we're asking for rows 1 through 20 and
# columns 1 through 11.
test <- elec[1:320, 1:7]

head(test)

qplot(candidate_sex, data=test, fill=test)
ggsave("test.png")

# Candidate Age by Sex. 
# jitter fig. 1
qplot(candidate_category, candidate_age, data = elec, geom = "jitter", color=candidate_sex, binwidth=1, main="Age Distrobution by Sex:\n Indian Assembly Elections 2004") + xlab("Candidate Category") + ylab("Candidate Age")
ggsave("desktop/si618/homework/wk4/images/age_by_sex_jitter.png")

# boxplot fig. 2
qplot(candidate_category, candidate_age, data = elec, geom = "boxplot", fill=candidate_sex, binwidth=1, main="Age Distrobution by Sex:\n Indian Assembly Elections 2004") + xlab("Candidate Category") + ylab("Candidate Age")
ggsave("desktop/si618/homework/wk4/images/age_by_sex_boxplot.png")

# both boxplot and jiter. fig 3
qplot(candidate_category, candidate_age, data = elec, geom = c("jitter", "boxplot"), fill=candidate_sex, binwidth=1, main="Age Distrobution by Sex:\n Indian Assembly Elections 2004") + xlab("Candidate Category") + ylab("Candidate Age")
ggsave("desktop/si618/homework/wk4/images/age_by_sex_boxplot_jitter.png")


# now we may just want to see what's going on with the independent parties. fig. 4
onlyInd <- elec[elec$party_abbreviation == "IND",]
head(onlyInd)
qplot(candidate_sex, data=onlyInd, geom="histogram", fill = state_name, binwidth=10, main="Candidate Sex by Category (Only Independent Parties):\n 2004 State Assembly Elections")
ggsave("desktop/si618/homework/wk4/images/independent_parties_sex.png");

# similar data, displayed using dodge. fig 5.
dod <- ggplot(elec, aes(x=factor(candidate_sex), fill=factor(candidate_category))) + geom_bar(position="dodge") 
dod + xlab("Candidate Sex") + opts(title="Candidate Sex by Category (All Parties):\n State Assembly Elections 2004")
ggsave("desktop/si618/homework/wk4/images/sex_by_category_dodge.png")

# how about candidates below 50 years of age? fig 6.
below50 <- elec[elec$candidate_age < 50,]
head(below50)
qplot(candidate_age, data=below50, fill = candidate_sex, main="Distribution of Candidate Age below 50 Yrs.") + xlab("Candidate Age")
ggsave("desktop/si618/homework/wk4/images/age_hist.png");
                 

qplot(state_name, data = sub, geom = "histogram", fill = candidate_sex, binwidth=1)
ggsave("hist2.png")
# the histogram visualization doesn't work that well for us. There are too many symbols, therefore
# our colors blend too closely together.  


# now lets try subscripting for particular state. Let's try Karnataka.
karnataka <- elec[elec$state_name == "KARNATAKA",]
head(karnataka)

# now lets just look at candidates for the INC, the Indian Natinal Congress.  
INC <- karnataka[karnataka$party_abbreviation == "INC",]
names(INC)

# fig. 7
# now that we have this data, lets just grab the data we want to use, making a subset. There is bound to be a lot of
# how do our results by age differ if looking only at Kanataka?
qplot(candidate_age, data = INC, geom = "histogram", fill=candidate_category, binwidth=1, main="Age Distrobution for Indian National Congress members in Karnataka:\n Indian Assembly Elections 2004") + xlab("Candidate Age")
ggsave("desktop/si618/homework/wk4/images/kanataka_age_hist3.png");

# fig. 8
# lets try the same thing with a density diagram. 
qplot(candidate_age, data = INC, geom = "density", color=candidate_category, binwidth=1, main="Age Distrobution for Indian National Congress members in Karnataka:\n Indian Assembly Elections 2004") + xlab("Candidate Age")
ggsave("desktop/si618/homework/wk4/images/kanataka_age_density.png");

BSP <- karnataka[karnataka$party_abbreviation == "BSP",]
head(BSP)

qplot(candidate_category, candidate_age, data = BSP, geom = "jitter", color=candidate_category, binwidth=1, main="Age Distrobution for BSP members in Karnataka:\n Indian Assembly Elections 2004") + xlab("Candidate Age")
ggsave("desktop/si618/homework/wk4/images/kanataka_age_jitter.png");

# age of BSP candidates by Schedule type. 
qplot(candidate_category, candidate_age, data = BSP, geom = "jitter", color=candidate_sex, binwidth=1, main="Age Distrobution for Indian National Congress members in Karnataka:\n Indian Assembly Elections 2004") + xlab("Candidate Age")




