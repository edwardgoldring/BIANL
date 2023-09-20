********************************************
*** Brothers in Arms No Longer
*** Journal of Conflict Resolution
*** Replication Files
*** Edward Goldring and Austin S. Matthews
*** September 2023
********************************************



* SET LOCAL DIRECTORY HERE
use "GoldringMatthews_BIANL_ReplicationDataset_JCR_Sept2023.dta", clear



********************************
*** Table 2: Summary statistics
********************************
label var purge "Purge"
label var purge_permissive "Purge (permissive)"
label var milsec "Coercive"
label var keycoupplotter "Key coup plotter"
label var elite_time "Elite tenure"
label var et_sq "Elite tenure2"
label var et_cb "Elite tenure3"
label var num_elites "Number of elites"
label var leader_tenure "Leader tenure"
label var cwc_anyfcoup "Failed coup"
label var pers_2pl "Personalism"

est clear
estpost tabstat purge purge_permissive milsec keycoupplotter elite_time num_elites leader_tenure cwc_anyfcoup pers_2pl purge_occurred, c(stat) stat(min max mean sd)
ereturn list



***************************
*** Table 4: Full results
***************************
local controls "num_elites elite_time et_sq et_cb leader_tenure cwc_anyfcoup pers_2pl purge_occurred"
reg purge i.milsec##i.keycoupplotter, cluster(fullname)
reg purge i.milsec##i.keycoupplotter `controls', cluster(fullname)
reg purge i.milsec##i.keycoupplotter i.leader `controls', cluster(fullname)
reg purge i.milsec##i.keycoupplotter i.leader  i.elite_year `controls', cluster(fullname)
reg purge_permissive i.milsec##i.keycoupplotter, cluster(fullname)
reg purge_permissive i.milsec##i.keycoupplotter `controls', cluster(fullname)
reg purge_permissive i.milsec##i.keycoupplotter i.leader `controls', cluster(fullname)
reg purge_permissive i.milsec##i.keycoupplotter i.leader  i.elite_year `controls', cluster(fullname)



**********************
*** Figure 1: H1 & H2
**********************
///H1
reg purge i.milsec##i.keycoupplotter i.leader i.elite_year `controls', cluster(fullname)
local fig1N=e(N) //local macro for N
margins milsec, at(keycoupplotter==0)
matrix list r(table)
matrix test = r(table)
local bciv_nkcp = test[1,1]
local llciv_nkcp = test[5,1]
local ulciv_nkcp = test[6,1]
local bco_nkcp = test[1,2]
local llco_nkcp = test[5,2]
local ulco_nkcp = test[6,2]
margins milsec, at(keycoupplotter==1)
matrix list r(table)
matrix test2 = r(table)
local bciv_kcp = test2[1,1]
local llciv_kcp = test2[5,1]
local ulciv_kcp = test2[6,1]
local bco_kcp = test2[1,2]
local llco_kcp = test2[5,2]
local ulco_kcp = test2[6,2]
margins r.milsec, at(keycoupplotter==0)
matrix list r(table)
matrix test3 = r(table)
local bmilsec = test3[1,1]
local llmilsec = test3[5,1]
local ulmilsec = test3[6,1]
local pvmilsec = test3[4,1]
margins r.keycoupplotter, at(milsec==0)
matrix list r(table)
matrix test4 = r(table)
local b_civ_kcp = test4[1,1]
local ll_civ_kcp = test4[5,1]
local ul_civ_kcp = test4[6,1]
local pv_civ_kcp = test4[4,1]
margins r.keycoupplotter, at(milsec==1)
matrix list r(table)
matrix test5 = r(table)
local b_co_kcp = test5[1,1]
local ll_co_kcp = test5[5,1]
local ul_co_kcp = test5[6,1]
local pv_co_kcp = test5[4,1]

reg purge_permissive i.milsec##i.keycoupplotter i.leader i.elite_year `controls', cluster(fullname)
margins milsec, at(keycoupplotter==0)
matrix list r(table)
matrix test = r(table)
local pp_bciv_nkcp = test[1,1]
local pp_llciv_nkcp = test[5,1]
local pp_ulciv_nkcp = test[6,1]
local pp_bco_nkcp = test[1,2]
local pp_llco_nkcp = test[5,2]
local pp_ulco_nkcp = test[6,2]
margins milsec, at(keycoupplotter==1)
matrix list r(table)
matrix test2 = r(table)
local pp_bciv_kcp = test2[1,1]
local pp_llciv_kcp = test2[5,1]
local pp_ulciv_kcp = test2[6,1]
local pp_bco_kcp = test2[1,2]
local pp_llco_kcp = test2[5,2]
local pp_ulco_kcp = test2[6,2]
margins r.milsec, at(keycoupplotter==0)
matrix list r(table)
matrix test3 = r(table)
local pp_bmilsec = test3[1,1]
local pp_llmilsec = test3[5,1]
local pp_ulmilsec = test3[6,1]
local pp_pvmilsec = test3[4,1]
margins r.keycoupplotter, at(milsec==0)
matrix list r(table)
matrix test4 = r(table)
local pp_b_civ_kcp = test4[1,1]
local pp_ll_civ_kcp = test4[5,1]
local pp_ul_civ_kcp = test4[6,1]
local pp_pv_civ_kcp = test4[4,1]
margins r.keycoupplotter, at(milsec==1)
matrix list r(table)
matrix test5 = r(table)
local pp_b_co_kcp = test5[1,1]
local pp_ll_co_kcp = test5[5,1]
local pp_ul_co_kcp = test5[6,1]
local pp_pv_co_kcp = test5[4,1]

preserve
clear
	set obs 23
	gen label=""
	replace label="Civilian non-KCP" if _n==2
	replace label="Coercive NKCP" if _n==5
	replace label="Civilian KCP" if _n==8
	replace label="Coercive KCP" if _n==11
	replace label="Milsec FD" if _n==15
	replace label="Civ KCP FD" if _n==18
	replace label="Coercive KCP FD" if _n==21
	replace label="Civilian non-KCP (pp)" if _n==3
	replace label="Coercive NKCP (pp)" if _n==6
	replace label="Civilian KCP (pp)" if _n==9
	replace label="Coercive KCP (pp)" if _n==12
	replace label="Milsec FD (pp)" if _n==16
	replace label="Civ KCP FD (pp)" if _n==19
	replace label="Coercive KCP FD (pp)" if _n==22
	gen estimate=.
	replace estimate=`bciv_nkcp' if _n==2
	replace estimate=`bco_nkcp' if _n==5
	replace estimate=`bciv_kcp' if _n==8
	replace estimate=`bco_kcp' if _n==11
	replace estimate=`pp_bciv_nkcp' if _n==3
	replace estimate=`pp_bco_nkcp' if _n==6
	replace estimate=`pp_bciv_kcp' if _n==9
	replace estimate=`pp_bco_kcp' if _n==12
	gen ll=.
	replace ll=`llciv_nkcp' if _n==2
	replace ll=`llco_nkcp' if _n==5
	replace ll=`llciv_kcp' if _n==8
	replace ll=`llco_kcp' if _n==11
	replace ll=`pp_llciv_nkcp' if _n==3
	replace ll=`pp_llco_nkcp' if _n==6
	replace ll=`pp_llciv_kcp' if _n==9
	replace ll=`pp_llco_kcp' if _n==12
	gen ul=.
	replace ul=`ulciv_nkcp' if _n==2
	replace ul=`ulco_nkcp' if _n==5
	replace ul=`ulciv_kcp' if _n==8
	replace ul=`ulco_kcp' if _n==11
	replace ul=`pp_ulciv_nkcp' if _n==3
	replace ul=`pp_ulco_nkcp' if _n==6
	replace ul=`pp_ulciv_kcp' if _n==9
	replace ul=`pp_ulco_kcp' if _n==12
	gen fd=.
	replace fd=`bmilsec' if _n==15
	replace fd=`pp_bmilsec' if _n==16
	gen fd_ll=.
	replace fd_ll=`llmilsec' if _n==15
	replace fd_ll=`pp_llmilsec' if _n==16
	gen fd_ul=.
	replace fd_ul=`ulmilsec' if _n==15
	replace fd_ul=`pp_ulmilsec' if _n==16
	replace fd=`b_civ_kcp' if _n==18
	replace fd_ll=`ll_civ_kcp' if _n==18
	replace fd_ul=`ul_civ_kcp' if _n==18
	replace fd=`b_co_kcp' if _n==21
	replace fd_ll=`ll_co_kcp' if _n==21
	replace fd_ul=`ul_co_kcp' if _n==21
	replace fd=`pp_b_civ_kcp' if _n==19
	replace fd_ll=`pp_ll_civ_kcp' if _n==19
	replace fd_ul=`pp_ul_civ_kcp' if _n==19
	replace fd=`pp_b_co_kcp' if _n==22
	replace fd_ll=`pp_ll_co_kcp' if _n==22
	replace fd_ul=`pp_ul_co_kcp' if _n==22
	gen variable=_n
	gen perm=0
	replace perm=1 if _n==3 | _n==6 | _n==9 | _n==12 | _n==16 | _n==19 | _n==22

twoway (rspike ul ll variable, msize(vtiny) lcolor(black)) ///
	(scatter estimate variable if perm==0, mcolor(black) msymbol(O)) ///
	(scatter estimate variable if perm==1, mcolor(black) msymbol(D)) ///
	(rspike fd_ll fd_ul variable, msize(vtiny) lcolor(black)) ///
	(scatter fd variable if perm==0, mcolor(black) msymbol(O)) ///
	(scatter fd variable if perm==1, mcolor(black) msymbol(D)), ///
	ylab(-.1(.05).15, tlength(0)) yscale(r(-.1 .1)) ///
	yline(0, lcolor(gs10) lpattern(dash)) ///
	xlabel(2.5 "Civilian" 5.5 "Coercive" 8.5 `""Civilian" "KCP""' 11.5 `""Coercive" "KCP""' 15.5 `""Civilian {&rarr}" "Coercive""' 18.5 `""Civilian {&rarr}" "Civilian KCP""' 21.5 `""Coercive {&rarr}" "Coercive KCP""', valuelabel labsize(vsmall) tlength(0)) ///	
	scheme(s1mono) ///
	xtitle("") ///
	xline(13.5, lcolor(gs14)) ///
	subtitle("Predicted probabilities							First differences", size(small)) ///
	legend(pos(6) row(1) region(col(white)) size(small) order(2 "DV: {it:Purge}" 3 "DV: {it:Purge (permissive)}")) ///
	title("{it:Notes}: Bars represent 95 percent confidence intervals. {it:N}=`fig1N'.""DV = dependent variable; KCP = key coup plotter.", size(small) pos(7) color(black)) ///
	name(substantive, replace)
restore



*******************************************
*** Table A4: Logit models robustness test
*******************************************
local controls "num_elites elite_time et_sq et_cb leader_tenure cwc_anyfcoup pers_2pl"
gen interaction=milsec*keycoupplotter
label var interaction "CoerciveKey coup plotter"
logit purge milsec keycoupplotter interaction, cluster(fullname)
logit purge milsec keycoupplotter interaction `controls', cluster(fullname)
logit purge milsec keycoupplotter interaction i.leader `controls', cluster(fullname)
logit purge milsec keycoupplotter interaction i.leader i.elite_year `controls', cluster(fullname)
logit purge_permissive milsec keycoupplotter interaction, cluster(fullname)
logit purge_permissive milsec keycoupplotter interaction `controls', cluster(fullname)
logit purge_permissive milsec keycoupplotter interaction i.leader `controls', cluster(fullname)
logit purge_permissive milsec keycoupplotter interaction i.leader i.elite_year `controls', cluster(fullname)



*****************************************************************************
*** Table AX: Population, GDP per capita, and assassinations robustness test
*****************************************************************************
local controls "num_elites elite_time et_sq et_cb leader_tenure cwc_anyfcoup pers_2pl purge_occurred population gdppc assa v2cademmob"
label var population "Population (log)"
label var gdppc "GDP per capita (log)"
reg purge i.milsec##i.keycoupplotter i.leader  i.elite_year `controls', cluster(fullname)
reg purge_permissive i.milsec##i.keycoupplotter i.leader  i.elite_year `controls', cluster(fullname)



*******************************************************************************************
*** Table AX: Pro-democratic protests, civil war, and interstate conflict robustness test
*******************************************************************************************
local controls "num_elites elite_time et_sq et_cb leader_tenure cwc_anyfcoup pers_2pl purge_occurred interstate intrastate"
reg purge i.milsec##i.keycoupplotter i.leader  i.elite_year `controls', cluster(fullname)
reg purge_permissive i.milsec##i.keycoupplotter i.leader  i.elite_year `controls', cluster(fullname)


	
*****
stop
*****


	
****************************************************************
*** Figures AX: dropping each ruling institution robustness test
****************************************************************
drop interaction
local controls "num_elites elite_time et_sq et_cb leader_tenure cwc_anyfcoup pers_2pl purge_occurred"
local rc ""Daoud Presidential Cabinet" "PDPA Politburo" "High Committee of State" "Government Military Council" "Dahomey Provisional Executive" "Military Directorate" "Council of Commanders of the Armed Forces" "Military Council" "Government Military Council" "National Council of Public Safety" "KSČ Presidium" "Dominican Civil Triumvirate" "Military Junta of 1963" "Revolutionary Command Council" "Revolutionary Government Council" "National Liberation Council" "National Redemption Council (1/13/1972-10/9/75); Supreme Military Council (10/9/75-7/9/79)" "Military Council" "Military Council" "National Council of Haiti" "Haitian Military Junta" "Ba'th Revolutionary Command Council (RCC)" "Military Council" "Supreme Military Council I" "Supreme Military Council II" "Government Military Council II" "National Provisional Ruling Council High Command" "Executive Committee of the Military Revolutionary Council" "Supreme Council of the Armed Forces" "National Security Council" "Military Council of Venezuela""
local i=0

gen interaction=milsec*keycoupplotter

preserve
	clear
	set obs 31
	gen rc_omitted=""
	gen p_co_beta=.
	gen p_co_ll=.
	gen p_co_ul=.
	gen p_int_beta=.
	gen p_int_ll=.
	gen p_int_ul=.
	gen pp_co_beta=.
	gen pp_co_ll=.
	gen pp_co_ul=.
	gen pp_int_beta=.
	gen pp_int_ll=.
	gen pp_int_ul=.
	tempfile ri_robust
	save `ri_robust', replace
restore

foreach q of local rc{
	reg purge milsec keycoupplotter interaction i.leader i.elite_year `controls' if reg_rulinst!="`q'", cluster(fullname)
	matrix list r(table)
	matrix test = r(table)
	local p_co_beta=test[1,1]
	local p_co_ll=test[5,1]
	local p_co_ul=test[6,1]
	local p_int_beta=test[1,3]
	local p_int_ll=test[5,3]
	local p_int_ul=test[6,3]
	reg purge_permissive milsec keycoupplotter interaction i.leader i.elite_year `controls' if reg_rulinst!="`q'", cluster(fullname)
	matrix list r(table)
	matrix test = r(table)
	local pp_co_beta=test[1,1]
	local pp_co_ll=test[5,1]
	local pp_co_ul=test[6,1]
	local pp_int_beta=test[1,3]
	local pp_int_ll=test[5,3]
	local pp_int_ul=test[6,3]

preserve
	use `ri_robust', clear
	local i=`i'+1
	replace rc_omitted="`q'" if _n==`i'
	replace p_co_beta=`p_co_beta' if _n==`i'
	replace p_co_ll=`p_co_ll' if _n==`i'
	replace p_co_ul=`p_co_ul' if _n==`i'
	replace p_int_beta=`p_int_beta' if _n==`i'
	replace p_int_ll=`p_int_ll' if _n==`i'
	replace p_int_ul=`p_int_ul' if _n==`i'
	replace pp_co_beta=`pp_co_beta' if _n==`i'
	replace pp_co_ll=`pp_co_ll' if _n==`i'
	replace pp_co_ul=`pp_co_ul' if _n==`i'
	replace pp_int_beta=`pp_int_beta' if _n==`i'
	replace pp_int_ll=`pp_int_ll' if _n==`i'
	replace pp_int_ul=`pp_int_ul' if _n==`i'
	save `ri_robust', replace
restore

}
use `ri_robust', clear

gen counter=1
gen sec_counter=2

local n=0
levelsof rc_omitted, local(levels)
foreach l of local levels {
	local n=`n'+1
twoway (rspike p_co_ul p_co_ll counter if _n==`n', msize(vtiny) lcolor(black)) ///
	(scatter p_co_beta counter if _n==`n', mcolor(black) msymbol(O)) ///
	(rspike p_int_ul p_int_ll sec_counter if _n==`n', msize(vtiny) lcolor(black)) ///
	(scatter p_int_beta sec_counter if _n==`n', mcolor(black) msymbol(D)), ///
	ylab(-.3(.1).3, tlength(0)) yscale(r(-.3 .3)) ///
	yline(0, lcolor(gs10) lpattern(dash)) ///
	scheme(s1mono) ///
	xtitle("") ///
	xsc(r(0 3)) ///
	xlab(, nolabels tlength(0)) ///
	legend(pos(6) row(1) region(col(white)) size(small) order(2 "Coercive coefficient" 4 "Interaction coefficient")) ///
	title("RI omitted: `l'", size(small) pos(12) color(black)) ///
	name(ri_`n', replace)
}

