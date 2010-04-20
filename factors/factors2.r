gelec = read.delim("desktop/si618/data/GE_2004_2.txt", sep="\t", header=TRUE)
elec = read.delim("http://hcnewsom.org/expldata/QryCandidates_AC.txt", sep="\t",header=FALSE, col.names=c("state_name","ac_number", "ac_name","schedule", "cand_sl_no", "candidate_name", "candidate_sex", "party_abbreviation", "party_name", "symbol_number", "symbol_description", "candidate_age", "candidate_category"))


#attach elec to dataframe
attach(elec)
attach(gelec)
#lets see what the first 6 rows of data are all about.
head(elec)
head(gelec)
summary(elec$candidate_category)

library(ggplot2)

#candidate sex by category. fig. 2
qplot(candidate_sex, data = elec, geom = "histogram", width=0.25, fill = candidate_category, binwidth=1, main="Candidate Sex by Category: 2004 Indian Assembly Elections") + xlab("Candidate Sex") 
ggsave("desktop/si618/homework/wk2/images/sex_by_category_hist2.png")

qplot(CAND_SEX, data = gelec, geom = "histogram", position="dodge", width=0.25, fill = CAND_CATEGORY, binwidth=1, main="Candidate Sex by Category: 2004 Indian General Elections") + xlab("Candidate Sex") 
ggsave("desktop/si618/indian_elections/factors/images/sex_by_category_hist_dodge.png")


# For the 2004 General Elections we have Place info!
# stacked
qplot(factor(POSITION), data = gelec, geom = "histogram", width=0.5, fill = CAND_SEX, binwidth=1, main="Candidate Place by Sex: 2004 Indian General Elections") + xlab("Candidate Place") + scale_x_discrete(CAND_SEX)
ggsave("desktop/si618/indian_elections/factors/images/place_by_sex_hist.png")

# dodge
qplot(factor(POSITION), data = gelec, geom = "histogram", position="dodge", width=0.75, fill = CAND_SEX, binwidth=1, main="Candidate Place by Sex: 2004 Indian General Elections") + xlab("Candidate Place") + scale_x_discrete(CAND_SEX)
ggsave("desktop/si618/indian_elections/factors/images/place_by_sex_hist_dodge.png")

qplot(factor(POSITION), data = gelec, geom = "density", position="dodge", width=0.75, color = CAND_SEX, binwidth=1, main="Candidate Place by Sex: 2004 Indian General Elections") + xlab("Candidate Place") + scale_x_discrete(CAND_SEX)
ggsave("desktop/si618/indian_elections/factors/images/place_by_sex_density_dodge.png")

################################################
# candidate category by state. fig. 3
qplot(state_name, data = elec, geom = "histogram", fill = candidate_category, binwidth=1, main="Candidate Category by State: 204 Indian Assembly Elections") + xlab("State")
ggsave("desktop/si618/homework/wk2/images/state_cand_category_hist2.png")



# separate each country into a facet. fig. 4
qplot(candidate_category, data = elec, geom = "histogram", facets=~state_name, fill = candidate_category, main="Candidate Category by State: 2004 State Assembly Elections", binwidth=1)
ggsave("desktop/si618/homework/wk2/images/facets_category_state.png")

# candidate sex as facets. fig. 5
qplot(candidate_sex, data = elec, geom = "histogram", facets =~state_name, binwidth=1)
ggsave("desktop/si618/homework/wk2/images/sex_by_state.png")


qplot(CAND_SEX, data = gelec, geom = "histogram", facets =~ST_NAME, binwidth=1)
ggsave("desktop/si618/indian_elections/factors/images/sex_by_state_ge.png")


qplot(factor(POSITION), data = gelec, color=CAND_SEX, geom = "histogram", facets =~ST_NAME, binwidth=1)
ggsave("desktop/si618/indian_elections/factors/images/place_by_sex_by_state_ge.png")

qplot(factor(POSITION), data = gelec, color=CAND_SEX, geom = "histogram", facets =~ST_NAME, binwidth=.21) + opts(axis.text.x=theme_text(size=8, hjust=1), title="Test", plot.title=theme_text(size=20), axis.text.x=theme_blank())
ggsave("desktop/si618/indian_elections/factors/images/place_by_sex_by_state_ge.png")
