setwd("c:\\kibira\\R-Course")
library(xlsx)
pdata <- read.xlsx("AMS.xlsx", sheetIndex=1,header=T)
install.packages("arules")
library(arules)
rules.all <- apriori(pdata)
rules.all
inspect(rules.all)

#if we are interested in only rules with rhs indicating energy use, so we setso we set
#rhs=c("Energy.use=High","Energy.use=Medium","Energy.use=Low") in the rhs
#In the above result rules.all, we can also see that the left-hand side (lhs)
#of the first rule has one element. To exclude such rules, we set minlen to 2 in the code below
#control and verbose = FALSE means leaving out report of progress of the algorithm

rules <- apriori(pdata, control = list(verbose=FALSE), parameter = list(minlen=2, supp=0.1, conf=0.8), appearance = list(rhs=c("Energy.use=High","Energy.use=Medium","Energy.use=Low"),default="lhs"))
rules.sorted <- sort(rules, by="lift")
inspect(rules.sorted)

# remove redundant rules

rules.pruned <- rules.sorted[!is.redundant(rules.sorted)]
inspect(rules.pruned)