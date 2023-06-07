#!/bin/bash


#echo 'R_LIBS_USER="~/R/libs"' >  $HOME/.Renviron


3dLMEr -prefix ASMU-Group_PubDev_GENDER -jobs 28 \
-mask  ./social_mask+tlrc \
-model 'ASMU-Group*PubDev*GENDER+(PubDev|Subj)' \
-qVars 'PubDev' \
-qVarsCenters '1' \
-dataTable @Rhit_datatable.txt
