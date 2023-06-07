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
# following-up plotting of Small-volume analysis on SMA x PUBERTY x gender on positive social feedback BRAIN responsivity
###############################################################################################################
#####################################################

#mPFC ASMU x PUB x GENDER
mPFC_model <- lmer(mPFC ~ ASMU * GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                   data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(mPFC_model)

#PCC ASMU x PUB x GENDER
PCC_model <- lmer(PCC ~ ASMU * GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                  data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(PCC_model)

#vmPFC ASMU x PUB x GENDER
vmPFC_model <- lmer(vmPFC ~ ASMU * GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                  data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(vmPFC_model)


#Rifg ASMU x PUB x GENDER
Rifg_model <- lmer(Rifg ~ ASMU * GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                    data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(Rifg_model)

###############################################################################################################
#####################################################

###############################################################################################################
#plot
###############################################################################################################
mPFC_plot <- interact_plot(mPFC_model, pred=PubDev_centered, modx=ASMU, modxvals = NULL, plot.points=TRUE,
                          x.label="PUBERTY", y.label="SOCIAL REWARD", 
                          legend.main="ASMU-GROUP", interval=TRUE, 
                          thickness.line = 1, vary.lty=FALSE, colors = c("#2171b5","#980043"))

mPFC_plot + theme_classic() + theme(
  axis.line = element_line(size = 1, colour = "black")) + theme(
    axis.ticks = element_line(size = 1, colour = "black")) + theme(
      axis.ticks.length = unit(0.15, "cm")) + theme(
        legend.text = element_text(size=12, colour = 'black')) + theme(
          legend.title = element_text(size=15, colour = 'black', face='bold')) + theme(
            axis.text = element_text(size = 12, colour='black')) + theme(
              axis.title.y = element_text(size=15, colour = 'black', face='bold')) + theme(
                axis.title.x = element_text(size=15, colour = 'black', face='bold'))

PCC_plot <- interact_plot(PCC_model, pred=PubDev_centered, modx=ASMU, modxvals = NULL, plot.points=TRUE, 
                          x.label="PUBERTY", y.label="SOCIAL REWARD", 
                          legend.main="ASMU-GROUP", interval=TRUE, 
                          thickness.line = 1, vary.lty=FALSE, colors = c("#2171b5","#980043"))

PCC_plot + theme_classic() + theme(
  axis.line = element_line(size = 1, colour = "black")) + theme(
    axis.ticks = element_line(size = 1, colour = "black")) + theme(
      axis.ticks.length = unit(0.15, "cm")) + theme(
        legend.text = element_text(size=12, colour = 'black')) + theme(
          legend.title = element_text(size=15, colour = 'black', face='bold')) + theme(
            axis.text = element_text(size = 12, colour='black')) + theme(
              axis.title.y = element_text(size=15, colour = 'black', face='bold')) + theme(
                axis.title.x = element_text(size=15, colour = 'black', face='bold'))

vmPFC_plot <- interact_plot(vmPFC_model, pred=PubDev_centered, modx=SMA, modxvals = NULL, plot.points=TRUE, 
                            x.label="PUBERTY", y.label="SOCIAL REWARD", 
                            legend.main="ASMU-GROUP", interval=TRUE, 
                            thickness.line = 1, vary.lty=FALSE, colors = c("#2171b5","#980043"))

vmPFC_plot + theme_classic() + theme(
  axis.line = element_line(size = 1, colour = "black")) + theme(
    axis.ticks = element_line(size = 1, colour = "black")) + theme(
      axis.ticks.length = unit(0.15, "cm")) + theme(
        legend.text = element_text(size=12, colour = 'black')) + theme(
          legend.title = element_text(size=15, colour = 'black', face='bold')) + theme(
            axis.text = element_text(size = 12, colour='black')) + theme(
              axis.title.y = element_text(size=15, colour = 'black', face='bold')) + theme(
                axis.title.x = element_text(size=15, colour = 'black', face='bold'))


ifg_plot <- interact_plot(ifg_model, pred=PubDev_centered, modx=SMA, modxvals = NULL, plot.points=TRUE, 
                          x.label="PUBERTY", y.label="SOCIAL REWARD", 
                          legend.main="ASMU-GROUP", interval=TRUE, 
                          thickness.line = 1, vary.lty=FALSE, colors = c("#2171b5","#980043"))

ifg_plot + theme_classic() + theme(
  axis.line = element_line(size = 1, colour = "black")) + theme(
    axis.ticks = element_line(size = 1, colour = "black")) + theme(
      axis.ticks.length = unit(0.15, "cm")) + theme(
        legend.text = element_text(size=12, colour = 'black')) + theme(
          legend.title = element_text(size=15, colour = 'black', face='bold')) + theme(
            axis.text = element_text(size = 12, colour='black')) + theme(
              axis.title.y = element_text(size=15, colour = 'black', face='bold')) + theme(
                axis.title.x = element_text(size=15, colour = 'black', face='bold'))
###############################################################################################################
#Extract slopes for mediation model
###############################################################################################################
#pub effect alone to extract slope and intercept 
model <- lmer(mPFC ~ PubDev_centered + (1 + PubDev_centered|Subj), 
              data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(model)
#effect of puberty within person
coef(model)
ranef(model)
#'coef' are sums of the fixef and ranef outputs 
#'effect puberty both within and between people


#pub effect alone to extract slope and intercept 
model <- lmer(PCC ~ PubDev_centered + (1 + PubDev_centered|Subj), 
              data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(model)
#effect of puberty within person
coef(model)
ranef(model)
#'coef' are sums of the fixef and ranef outputs 
#'effect puberty both within and between people


model <- lmer(vmPFC ~ PubDev_centered + (1 + PubDev_centered|Subj), 
              data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(model)
#effect of puberty within person
coef(model)
ranef(model)
#'coef' are sums of the fixef and ranef outputs 
#'effect puberty both within and between people

model <- lmer(ifg ~ PubDev_centered + (1 + PubDev_centered|Subj), 
              data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(model)
#effect of puberty within person
coef(model)
ranef(model)
#'coef' are sums of the fixef and ranef outputs 
#'effect puberty both within and between people

###############################################################################################################
#Extract slope contorlling for sex
###############################################################################################################
#pub effect alone to extract slope and intercept 
model <- lmer(mPFC ~ sex * PubDev_centered + (1 + PubDev_centered|Subj), 
              data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(model)
#effect of puberty within person
coef(model)
ranef(model)
#'coef' are sums of the fixef and ranef outputs 
#'effect puberty both within and between people


#pub effect alone to extract slope and intercept 
model <- lmer(PCC ~ sex * PubDev_centered + (1 + PubDev_centered|Subj), 
              data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(model)
#effect of puberty within person
coef(model)
ranef(model)
#'coef' are sums of the fixef and ranef outputs 
#'effect puberty both within and between people


model <- lmer(vmPFC ~ sex * PubDev_centered + (1 + PubDev_centered|Subj), 
              data=data, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(model)
#effect of puberty within person
coef(model)
ranef(model)
#'coef' are sums of the fixef and ranef outputs 
#'effect puberty both within and between people
 












