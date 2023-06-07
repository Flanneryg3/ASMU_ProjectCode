#!/bin/bash


#export R_LIBS_USER="~/R/libs/"
#total ASMU symptoms endorsed

3dLMEr -prefix ASMU_continuous_PubDev_GENDER -jobs 28 \
-mask  ./social_mask+tlrc \
-model 'ASMU_continuous*PubDev*GENDER+(PubDev|Subj)' \
-qVars 'PubDev,ASMU_continuous' \
-qVarsCenters '1,0' \
-dataTable @Rhit_datatable.txt
