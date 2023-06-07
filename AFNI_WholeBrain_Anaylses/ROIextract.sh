#!/bin/bash

#####################################################
# define variables
#####################################################

roi_path='path/roi_extract'
ROIs='rois'

subjects='001 044 085 124 158 003 045 086 125 160 004 046 087 126 161 005 047 088 128 162 006 048 089 130 163 007 054 090 131 166 008 055 092 132 167 009 056 093 133 169 010 057 095 134 170 011 058 096 135 172 012 059 097 136 173 013 060 098 137 174 015 061 099 138 175 017 062 102 139 176 018 063 103 140 178 019 064 104 141 179 022 065 106 142 182 023 068 107 143 184 024 070 108 144 185 025 071 110 145 186 026 072 111 147 187 027 074 112 148 188 028 075 114 149 189 029 077 115 150 190 030 078 116 151 191 032 079 117 153 192 037 080 118 154 999 038 081 119 155 040 083 122 156 043 084 123 157'

w1_subjects='005 006 008 011 012 017 018 019 023 027 028 029 030 032 037 044 045 047 048 054 055 056 060 061 068 072 075 077 078 081 085 087 088 090 092 093 095 096 097 098 099 102 103 104 106 110 111 115 116 118 123 125 133 136 137 139 140 147 151 154 155 157 158 162 163 172 173 175 182 185 186 187 188 189 190 191 999'

w2_subjects='005 006 008 011 012 017 018 019 023 027 028 029 030 032 037 044 045 047 054 055 056 060 061 062 063 068 072 075 078 079 081 085 087 088 090 092 093 095 096 098 099 103 104 106 111 116 118 119 125 133 136 139 140 147 154 155 157 158 162 163 172	173 175 182 185 186 187 188 189 190 191 193 194 198 199 200 201 203 208 209 212 218 219 220 222 228 999'

w3_subjects='005 006 008 009 011 012 017 018 019 023 027 028 029 030 032 044 045 047 054 055 056 060 061 062 063 068 075 078 085 087 088 092 093 095 096 098 099 103 104 106 111 115 116 118 119 123 125 133 136 147 151 154 155 158 162 163 172 173 175 182 185 186 187 188 189 190 191 193 194 198 199 200 201 203 205 208 209 212 220 222 226 228 999'

#################################################################################################
#  WAVE 1
#################################################################################################
cd ${roi_path}
for r in ${ROIs}; do
	gunzip ${r}_mask+tlrc.BRIK.gz
done
#####################################################
# extract mean beta values (excluding zero) within rois
#for each contract, hemishere, wave, and subject
#####################################################


cd ${roi_path}
for r in ${ROIs}; do
	for sub in ${w1_subjects}; do

		#rm ${roi_path}/${r}_beta-output/${r}_*_001_${sub}.txt

		3dROIstats -mask ${roi_path}/${r}_mask+tlrc.BRIK -nzmean path/con_rhit.nii > ${roi_path}/${r}_beta-output/${r}_Rhit_001_${sub}.txt

	done
done
#################################################################################################
#  WAVE 2
#################################################################################################

#####################################################
# extract mean beta values (excluding zero) within rois
#for each contract, hemishere, wave, and subject
#####################################################
cd ${roi_path}
for r in ${ROIs}; do
	for sub in ${w2_subjects}; do

		#rm ${roi_path}/${r}_beta-output/${r}_*_002_${sub}.txt

		3dROIstats -mask ${roi_path}/${r}_mask+tlrc.BRIK -nzmean path/con_rhit.nii > ${roi_path}/${r}_beta-output/${r}_Rhit_002_${sub}.txt

	done
done

#################################################################################################
#  WAVE 3
#################################################################################################

#####################################################
# extract mean beta values (excluding zero) within rois
#for each contract, hemishere, wave, and subject
#####################################################
cd ${roi_path}
for r in ${ROIs}; do
	for sub in ${w3_subjects}; do

		#rm ${roi_path}/${r}_beta-output/${r}_*_003_${sub}.txt

		3dROIstats -mask ${roi_path}/${r}_mask+tlrc.BRIK -nzmean path/con_rhit.nii > ${roi_path}/${r}_beta-output/${r}_Rhit_003_${sub}.txt

	done
done
###########################################
#put all subjects in one file
###########################################

for r in ${ROIs}; do
	cd ${roi_path}/${r}_beta-output/
	cat ${r}_Rhit_001_*.txt > CAT_w1_Rhit_${r}_betas.txt
done

for r in ${ROIs}; do
	cd ${roi_path}/${r}_beta-output/
	cat ${r}_Rhit_002_*.txt > CAT_w2_Rhit_${r}_betas.txt
done

for r in ${ROIs}; do
	cd ${roi_path}/${r}_beta-output/
	cat ${r}_Rhit_001_*.txt > CAT_w3_Rhit_${r}_betas.txt
done

for r in ${ROIs}; do
	cd ${roi_path}/${r}_beta-output/
	cat ${r}_Rhit_*.txt > CAT_all_Rhit_${r}_betas.txt
done

######################################################
#move final output to easily accessable place
#####################################################

rm ${roi_path}/CAT_*_betas.txt
for r in ${ROIs}; do
	mv ${roi_path}/${r}_beta-output/CAT_*_betas.txt ${roi_path}/
done
