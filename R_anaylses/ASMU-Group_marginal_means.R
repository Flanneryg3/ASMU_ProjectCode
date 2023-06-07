
#load packages
library(lme4)               # fits mixed models
library(lmerTest)           # provides t-tests for fixed effects
library(ggplot2)            # use for plots
library(interactions)       # use for calculating simple intercepts and slopes
library(nlme)               # for fitting multiple groups / heteroscedastic model
library(data.table)         # v1.9.7 (devel version)
library(misty)

#import data
data_highASMU <- read.csv("./followup_high-ASMU_group.csv",header=TRUE)
data_lowASMU <- read.csv("./followup_low-ASMU_group.csv",header=TRUE)

###############################################################################
mPFC_model <- lmer(mPFC ~ GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                    data_highASMU, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(mPFC_model)
###############################################################################
mPFC_model <- lmer(mPFC ~ GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                    data_lowASMU, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(mPFC_model)
###############################################################################
#SMA x PUBERTY
PCC_model <- lmer(PCC ~ GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                  data_highASMU, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(PCC_model)
###############################################################################
#SMA x PUBERTY
PCC_model <- lmer(PCC ~ GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                  data_lowASMU, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(PCC_model)
###############################################################################
#SMA x PUBERTY
vmPFC_model <- lmer(vmPFC ~ GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                    data_highASMU, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(vmPFC_model)
###############################################################################
#SMA x PUBERTY
vmPFC_model <- lmer(vmPFC ~ GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                    data_lowASMU, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(vmPFC_model)
###############################################################################
#SMA x PUBERTY
rIFG_model <- lmer(rIFG ~ GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                    data_highASMU, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(rIFG_model)
###############################################################################
#SMA x PUBERTY
rIFG_model <- lmer(rIFG ~ GENDER * PubDev_centered + (1 + PubDev_centered|Subj), 
                    data_lowASMU, control=lmerControl(optimizer="bobyqa",optCtrl=list(maxfun= 2e5)))
summary(rIFG_model)
###############################################################################

