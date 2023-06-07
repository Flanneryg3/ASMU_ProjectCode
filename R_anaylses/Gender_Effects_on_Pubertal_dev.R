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


###############################################################################################################
#####################################################
#GENDER x AGE interaction effect on PUBERTY
###############################################################################################################
#####################################################
sex_age_model <- lmer(PubDev ~  sex + age + sex*age + (1 + age|Subj), 
                      data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(sex_age_model)
###############################################################################################################
#####################################################
#ASMU groups differ in their GENDER x AGE interaction effect on PUBERTY (assessed with SEX x AGE x ASMU-Group interaction)
###############################################################################################################
#####################################################
sex_age_model <- lmer(PubDev ~  ASMU + sex + age + SMA*sex*age + (1 + age|Subj), 
                      data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(sex_age_model)


###############################################################################################################
#plot gender x Age interaction on puberty
###############################################################################################################
plot <- interact_plot(sex_age_model, pred=age, modx=sex, modxvals = NULL, plot.points=TRUE,
                      x.label="AGE", y.label="PUBERTY",
                      legend.main="SEX", modx.labels=c('Female', 'Male'), interval=TRUE, 
                      thickness.line = 1, vary.lty=FALSE, colors = c("#7b3294", "#0571b0"))

###############################################################################################################
plot + theme_classic() + theme(
  axis.line = element_line(size = 1, colour = "black")) + theme(
    axis.ticks = element_line(size = 1, colour = "black")) + theme(
      axis.ticks.length = unit(0.15, "cm")) + theme(
        legend.text = element_text(size=12, colour = 'black')) + theme(
          legend.title = element_text(size=15, colour = 'black', face='bold')) + theme(
            axis.text = element_text(size = 12, colour='black')) + theme(
              axis.title.y = element_text(size=15, colour = 'black', face='bold')) + theme(
                axis.title.x = element_text(size=15, colour = 'black', face='bold'))


