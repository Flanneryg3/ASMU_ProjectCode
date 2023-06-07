#load packages
library(lme4)               # fits mixed models
library(lmerTest)           # provides t-tests for fixed effects
library(ggplot2)            # use for plots
library(interactions)       # use for calculating simple intercepts and slopes
library(nlme)               # for fitting multiple groups / heteroscedastic model
library(data.table)         # v1.9.7 (devel version)
library(misty)
library(dplyr)
library(viridis)
library(lavaan)
library(lavaanPlot)


#import data
data <- read.csv("./data.csv",header=TRUE)




# Change violin plot colors by groups
p<-ggplot(data, aes(x=sex, y=SMFQ, fill=sex)) +
  geom_violin(position=position_dodge(1), lwd=1, colour='black', trim=TRUE, scale="width", width=0.5)

# Add dots
p + scale_fill_manual(
  values=c("#800080","#008080")
) + stat_summary(fun=mean, 
                 geom="crossbar", color="black", position=position_dodge(1)) + theme_classic() + theme(
                   axis.line = element_line(size = 1, colour = "black")) + theme(
                     axis.ticks = element_line(size = 1, colour = "black")) + theme(
                       axis.ticks.length = unit(0.15, "cm")) + theme(
                         legend.text = element_text(size=12, colour = 'black')) + theme(
                           legend.title = element_text(size=15, colour = 'black', face='bold')) + theme(
                             axis.text = element_text(size = 12, colour='black')) + theme(
                               axis.title.y = element_text(size=15, colour = 'black', face='bold')) + theme(
                                 axis.title.x = element_text(size=15, colour = 'black', face='bold'))


