#!bin/bash/

#Small Volume Corrected Brain Mask:

#Neurosynth: “social” uniformity test of an automated metanalyses of 1302 studies

#put social mask in same spcae as the functional data

3dresample -input social_uniformity-test_z_FDR_0.01.nii -master path/to/func/data/of/one/subject.nii -prefix social_resample

gunzip social_resample+tlrc.BRIK.gz

#connect little speckled parts around big regions
3dmask_tool -input social_resample+tlrc -prefix social_mask_di -dilate_input 2

3dcalc -a social_mask_di+tlrc -expr 'ispositive(a)' -prefix social_mask_di_bi+tlrc
# make sample overlap gray matter mask
3dmask_tool -input path/sub-*sess001-GM_funcspace+tlrc -frac 0.7 -fill_holes -prefix path/group_GM_mask_70

#calculate parts that were not in graymatter mask
3dcalc -a social_mask_di_bi+tlrc -b group_GM_mask_70+tlrc -expr 'a-b' -prefix parts_tobe_removed_2

#remove parts that were not in graymatter mask
3dcalc -a social_mask_di+tlrc -b parts_tobe_removed_2+tlrc -expr 'a-b' -prefix social_mask_final
