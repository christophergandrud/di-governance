////////////////////////////////
// Reproducible Tables for "Competing Risks Analysis & Deposit Insurance Governance Convergence"
// Author Christopher Gandrud
// Updated 26 June 2012 
// Using Stata 12 & R 2.14
////////////////////////////////


cd "~/DI_replication_tables"

/////////
// Fine \& Gray Competing Risks Coefficients for Creating \emph{MoF} Controlled 1st Deposit Insurer (others competing)
/////////

use "http://dl.dropbox.com/u/12581470/code/Replicability_code/DI_Replication/public_DI_replication_data.dta", clear

    ///// stset data   
        stset year, id(country) failure(di_state == 2) origin(min) enter(di_state == 1) exit(di_state == 2 3 4) 
        
    ///// Base Fine & Gray output for tables /////

		stcrreg eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office)
			regsave using "mof_est.dta", detail(all) replace table(A1, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg udems_mean eu1994 time_in_office, compete(di_state == 3 4) tvc(time_in_office)
			regsave using "mof_est.dta", append detail(all) table(A2, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg dem5 eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office)
			regsave using "mof_est.dta", append detail(all) table(A3, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
		
		stcrreg dbagdp eu1994 time_in_office, compete(di_state == 3 4) tvc(dbagdp time_in_office)
			regsave using "mof_est.dta", append detail(all) table(A4, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg banking_crisis eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office)
			regsave using "mof_est.dta", append detail(all) table(A5, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg peer_region_mof eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office)
			regsave using "mof_est.dta", append detail(all) table(A6, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg kaopen eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(kaopen time_in_office)
			regsave using "mof_est.dta", append detail(all) table(A7, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
		
		stcrreg imf_2 eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office)
			regsave using "mof_est.dta", append detail(all) table(A8, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg banking_crisis imf_2 eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office)
			regsave using "mof_est.dta", append detail(all) table(A9, order(regvars r2) format(%5.3f) paren(stderr) asterisk())

		stcrreg banking_crisis imf_2 dbagdp eu1994 time_in_office, compete(di_state == 3 4) tvc(dbagdp time_in_office)
			regsave using "mof_est.dta", append detail(all) table(A10, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg dem5 banking_crisis dbagdp peer_region_mof kaopen eu1994, compete(di_state == 3 4) tvc(kaopen)
			regsave using "mof_est.dta", append detail(all) table(A11, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg dem5 banking_crisis dbagdp peer_region_mof kaopen eu1994 time_in_office, compete(di_state == 3 4) tvc(kaopen time_in_office)
			regsave using "mof_est.dta", append detail(all) table(A12, order(regvars r2) format(%5.3f) paren(stderr) asterisk())


    ///// Create .tex file /////
    use "mof_est.dta", clear	

        //rename variables
        
        generate order = 99 
        
        replace var = "Democracy (UDS)" if var == "main:udems_mean_coef"
            replace order = 1 if var == "Democracy (UDS)"
            replace order = 2 if var == "main:udems_mean_stderr"
            
        replace var = "New Democracy" if var == "main:dem5_coef"
            replace order = 3 if var == "New Democracy"
            replace order = 4 if var == "main:dem5_stderr"
            
        replace var = "DB Assets/GDP" if var == "main:dbagdp_coef"
            replace order = 5 if var == "DB Assets/GDP"
            replace order = 6 if var == "main:dbagdp_stderr"

        replace var = "Crisis Dummy" if var == "main:banking_crisis_coef"
            replace order = 7 if var == "Crisis Dummy"
            replace order = 8 if var == "main:banking_crisis_stderr"
            
        replace var = "Regional Peer SE (MoF)" if var == "main:peer_region_mof_coef"
            replace order = 9 if var == "Regional Peer SE (MoF)"
            replace order = 10 if var == "main:peer_region_mof_stderr"
            
        replace var = "Capital Openness (KAOPEN)" if var == "main:kaopen_coef"
            replace order = 11 if var == "Capital Openness (KAOPEN)"
            replace order = 12 if var == "main:kaopen_stderr" 
           
        replace var = "IMF Stand-by" if var == "main:imf_2_coef"
            replace order = 13 if var == "IMF Stand-by"
            replace order = 14 if var == "main:imf_2_stderr"

        replace var = "EU (from 1994)" if var == "main:eu1994_coef"
            replace order = 15 if var == "EU (from 1994)"
            replace order = 16 if var == "main:eu1994_stderr"

        replace var = "GDP/Capita" if var == "main:gdp_pcapita_coef"
            replace order = 17 if var == "GDP/Capita"
            replace order = 18 if var == "main:gdp_pcapita_stderr" 
            
        replace var = "CBG Tenure" if var == "main:time_in_office_coef"
            replace order = 19 if var == "CBG Tenure"
            replace order = 20 if var == "main:time_in_office_stderr"
            
        // Time interaction label
        
        replace var = "{\bf{Time Interactions}}" if var == "which"
            replace order = 21 if var == "{\bf{Time Interactions}}"
            
        replace var = "Capital Openness (KAOPEN) (tvc)" if var == "tvc:kaopen_coef"
            replace order = 22 if var == "Capital Openness (KAOPEN) (tvc)" 
            replace order = 23 if var == "tvc:kaopen_stderr"
            
        replace var = "CBG Tenure (tvc)" if var == "tvc:time_in_office_coef"
            replace order = 24 if var == "CBG Tenure (tvc)"
            replace order = 25 if var == "tvc:time_in_office_stderr"
            
        replace var = "DB Assets/GDP (tvc)" if var == "tvc:dbagdp_coef"
            replace order = 26 if var == "DB Assets/GDP (tvc)"   
            replace order = 27 if var == "tvc:dbagdp_stderr"
            
        replace var = "Countries at Risk" if var == "N_clust"
            replace order = 28 if var == "Countries at Risk"
            
        replace var = "No. of MoF Created" if var == "N_fail"
            replace order = 29 if var == "No. of MoF Created"
        
        replace var = "Pseudo log-likelihood" if var == "ll"
            replace order = 30 if var == "Pseudo log-likelihood"
        
        replace order = 31 if var == "chi2"

        replace order = 32 if var == "p"
        
        
        generate _stderr = regexm(var, "_stderr")
            replace var = "" if _stderr == 1
            
        replace var = subinstr(var, "(tvc)", "", 1)
        
        replace A1 = "" if var == "{\bf{Time Interactions}}"
        replace A2 = "" if var == "{\bf{Time Interactions}}"
        replace A3 = "" if var == "{\bf{Time Interactions}}"
        replace A4 = "" if var == "{\bf{Time Interactions}}"
        replace A5 = "" if var == "{\bf{Time Interactions}}"
        replace A6 = "" if var == "{\bf{Time Interactions}}"
        replace A7 = "" if var == "{\bf{Time Interactions}}"
        replace A8 = "" if var == "{\bf{Time Interactions}}"
        replace A9 = "" if var == "{\bf{Time Interactions}}"
        replace A10 = "" if var == "{\bf{Time Interactions}}"
        replace A11 = "" if var == "{\bf{Time Interactions}}"
        replace A12 = "" if var == "{\bf{Time Interactions}}"        
 
        replace A1 = "$<$0.001" if A1 == "0" & var == "p"
        replace A2 = "$<$0.001" if A2 == "0" & var == "p"
        replace A3 = "$<$0.001" if A3 == "0" & var == "p"
        replace A4 = "$<$0.001" if A4 == "0" & var == "p"
        replace A5 = "$<$0.001" if A5 == "0" & var == "p"
        replace A6 = "$<$0.001" if A6 == "0" & var == "p"
        replace A7 = "$<$0.001" if A7 == "0" & var == "p"
        replace A8 = "$<$0.001" if A8 == "0" & var == "p"
        replace A9 = "$<$0.001" if A9 == "0" & var == "p"
        replace A10 = "$<$0.001" if A10 == "0" & var == "p"
        replace A11 = "$<$0.001" if A11 == "0" & var == "p"
        replace A12 = "$<$0.001" if A12 == "0" & var == "p"

        replace A1 = subinstr(A1, "-", "$-$", 1)
        replace A2 = subinstr(A2, "-", "$-$", 1)
        replace A3 = subinstr(A3, "-", "$-$", 1)
        replace A4 = subinstr(A4, "-", "$-$", 1)
        replace A5 = subinstr(A5, "-", "$-$", 1)
        replace A6 = subinstr(A6, "-", "$-$", 1)
        replace A7 = subinstr(A7, "-", "$-$", 1)
        replace A8 = subinstr(A8, "-", "$-$", 1)
        replace A9 = subinstr(A9, "-", "$-$", 1)
        replace A10 = subinstr(A10, "-", "$-$", 1)
        replace A11 = subinstr(A11, "-", "$-$", 1)
        replace A12 = subinstr(A12, "-", "$-$", 1)

 	    drop if order == 99
        
   	    rename var Variable
        sort order
	        drop order _stderr
	    compress
	
	texsave using "mof_est.tex", title(Fine \& Gray Competing Risks Coefficients for Creating \emph{MoF} Controlled 1st Deposit Insurer (others competing)) size(footnotesize) width(22cm) marker(di_mof_estimates) footnote("Standard errors in parentheses. {*}/{*}{*}/{*}{*}{*} at 10/5/1\% significance levels. GDP/capita was dropped from models with Democracy (UDS) and Deposit Bank Assets/GDP due to high correlations (0.693 and 0.708 respectively). The governance quality indicators are not shown for the same reason. Only significant time interactions are shown.") frag nofix hlines(20, 27) replace


///// Graphs for examining Time-varying coefficients

stcrreg dem5 banking_crisis dbagdp peer_region_mof kaopen eu1994 time_in_office, compete(di_state == 3 4) tvc(kaopen time_in_office)

	twoway (function shr_kaopen = exp([main]_b[kaopen]+x*[tvc]_b[kaopen]), range(2 24) ytitle("Sub-hazard Ratio--exp(b)") xtitle("") yline(1) graphregion(color(white))) || (function shr_kaopen = exp([main]_b[time_in_office]+x*[tvc]_b[time_in_office]), range(2 24) ytitle("Sub-hazard Ratio--exp(b)") xtitle("") yline(1) graphregion(color(white)))
		


////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


/////////
// Fine \& Gray Competing Risks Coefficients for Creating \emph{Specialised \& Independently} Controlled 1st Deposit Insurer (others competing)
/////////

use "http://dl.dropbox.com/u/12581470/code/Replicability_code/DI_Replication/public_DI_replication_data.dta", clear

    /// stset data
    stset year, id(country) failure(di_state == 4) origin(min) enter(di_state == 1) exit(di_state == 2 3 4) 

		stcrreg eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office)
			regsave using "ind_est.dta", detail(all) replace table(B1, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg udems_mean eu1994 time_in_office, compete(di_state == 2 3) tvc(udems_mean gdp_pcapita time_in_office)
			regsave using "ind_est.dta", append detail(all) table(B2, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg dem5 eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office)
			regsave using "ind_est.dta", append detail(all) table(B3, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
		
		stcrreg dbagdp eu1994 time_in_office, compete(di_state == 2 3) tvc(time_in_office)
			regsave using "ind_est.dta", append detail(all) table(B4, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg banking_crisis eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office)
			regsave using "ind_est.dta", append detail(all) table(B5, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg peer_region_ind eu1994 time_in_office, compete(di_state == 2 3) tvc(time_in_office)
			regsave using "ind_est.dta", append detail(all) table(B6, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg kaopen eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office)
			regsave using "ind_est.dta", append detail(all) table(B7, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
		
		stcrreg imf_2 eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office)
			regsave using "ind_est.dta", append detail(all) table(B8, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
			
		stcrreg banking_crisis imf_2 eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office)
			regsave using "ind_est.dta", append detail(all) table(B9, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
	
		stcrreg udems_mean dem5 peer_region_ind eu1994, compete(di_state == 2 3) tvc(udems_mean)
			regsave using "ind_est.dta", append detail(all) table(B10, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
						
		stcrreg udems_mean dem5 peer_region_ind eu1994 time_in_office, compete(di_state == 2 3) tvc(udems_mean time_in_office)
			regsave using "ind_est.dta", append detail(all) table(B11, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
	

    ///// Create .tex file /////	
    use "ind_est.dta", clear	
	
	//rename variables
        
        generate order = 99 
        
        replace var = "Democracy (UDS)" if var == "main:udems_mean_coef"
            replace order = 1 if var == "Democracy (UDS)"
            replace order = 2 if var == "main:udems_mean_stderr"
            
        replace var = "New Democracy" if var == "main:dem5_coef"
            replace order = 3 if var == "New Democracy"
            replace order = 4 if var == "main:dem5_stderr"
            
        replace var = "DB Assets/GDP" if var == "main:dbagdp_coef"
            replace order = 5 if var == "DB Assets/GDP"
            replace order = 6 if var == "main:dbagdp_stderr"

        replace var = "Crisis Dummy" if var == "main:banking_crisis_coef"
            replace order = 7 if var == "Crisis Dummy"
            replace order = 8 if var == "main:banking_crisis_stderr"
            
        replace var = "Regional Peer SE (Ind.)" if var == "main:peer_region_ind_coef"
            replace order = 9 if var == "Regional Peer SE (Ind.)"
            replace order = 10 if var == "main:peer_region_ind_stderr"
            
        replace var = "Capital Openness (KAOPEN)" if var == "main:kaopen_coef"
            replace order = 11 if var == "Capital Openness (KAOPEN)"
            replace order = 12 if var == "main:kaopen_stderr" 
           
        replace var = "IMF Stand-by" if var == "main:imf_2_coef"
            replace order = 13 if var == "IMF Stand-by"
            replace order = 14 if var == "main:imf_2_stderr"

        replace var = "EU (from 1994)" if var == "main:eu1994_coef"
            replace order = 15 if var == "EU (from 1994)"
            replace order = 16 if var == "main:eu1994_stderr"

        replace var = "GDP/Capita" if var == "main:gdp_pcapita_coef"
            replace order = 17 if var == "GDP/Capita"
            replace order = 18 if var == "main:gdp_pcapita_stderr" 
            
        replace var = "CBG Tenure" if var == "main:time_in_office_coef"
            replace order = 19 if var == "CBG Tenure"
            replace order = 20 if var == "main:time_in_office_stderr"
            
        // Time interaction label
        
        replace var = "{\bf{Time Interactions}}" if var == "which"
            replace order = 21 if var == "{\bf{Time Interactions}}"
            
        replace var = "Democrary (UDS) (tvc)" if var == "tvc:udems_mean_coef"
            replace order = 22 if var == "Democrary (UDS) (tvc)" 
            replace order = 23 if var == "tvc:udems_mean_stderr"
            
        replace var = "CBG Tenure (tvc)" if var == "tvc:time_in_office_coef"
            replace order = 24 if var == "CBG Tenure (tvc)"
            replace order = 25 if var == "tvc:time_in_office_stderr"
            
        replace var = "Countries at Risk" if var == "N_clust"
            replace order = 26 if var == "Countries at Risk"
            
        replace var = "No. of MoF Created" if var == "N_fail"
            replace order = 27 if var == "No. of MoF Created"
        
        replace var = "Pseudo log-likelihood" if var == "ll"
            replace order = 28 if var == "Pseudo log-likelihood"
        
        replace order = 29 if var == "chi2"

        replace order = 30 if var == "p"
        
        
        generate _stderr = regexm(var, "_stderr")
            replace var = "" if _stderr == 1
            
        replace var = subinstr(var, "(tvc)", "", 1)
        
        replace B1 = "" if var == "{\bf{Time Interactions}}"
        replace B2 = "" if var == "{\bf{Time Interactions}}"
        replace B3 = "" if var == "{\bf{Time Interactions}}"
        replace B4 = "" if var == "{\bf{Time Interactions}}"
        replace B5 = "" if var == "{\bf{Time Interactions}}"
        replace B6 = "" if var == "{\bf{Time Interactions}}"
        replace B7 = "" if var == "{\bf{Time Interactions}}"
        replace B8 = "" if var == "{\bf{Time Interactions}}"
        replace B9 = "" if var == "{\bf{Time Interactions}}"
        replace B10 = "" if var == "{\bf{Time Interactions}}"
        replace B11 = "" if var == "{\bf{Time Interactions}}"

        replace B1 = "$<$0.001" if B1 == "0.000" & var == "p"
        replace B2 = "$<$0.001" if B2 == "0.000" & var == "p"
        replace B3 = "$<$0.001" if B3 == "0.000" & var == "p"
        replace B4 = "$<$0.001" if B4 == "0.000" & var == "p"
        replace B5 = "$<$0.001" if B5 == "0.000" & var == "p"
        replace B6 = "$<$0.001" if B6 == "0.000" & var == "p"
        replace B7 = "$<$0.001" if B7 == "0.000" & var == "p"
        replace B8 = "$<$0.001" if B8 == "0.000" & var == "p"
        replace B9 = "$<$0.001" if B9 == "0.000" & var == "p"
        replace B10 = "$<$0.001" if B10 == "0.000" & var == "p"
        replace B11 = "$<$0.001" if B11 == "0.000" & var == "p"        

        replace B1 = subinstr(B1, "-", "$-$", 1)
        replace B2 = subinstr(B2, "-", "$-$", 1)
        replace B3 = subinstr(B3, "-", "$-$", 1)
        replace B4 = subinstr(B4, "-", "$-$", 1)
        replace B5 = subinstr(B5, "-", "$-$", 1)
        replace B6 = subinstr(B6, "-", "$-$", 1)
        replace B7 = subinstr(B7, "-", "$-$", 1)
        replace B8 = subinstr(B8, "-", "$-$", 1)
        replace B9 = subinstr(B9, "-", "$-$", 1)
        replace B10 = subinstr(B10, "-", "$-$", 1)
        replace B11 = subinstr(B11, "-", "$-$", 1)

 	    drop if order == 99
        
   	    rename var Variable
        sort order
	        drop order _stderr
	    compress

	
	texsave using "ind_est.tex", title(Fine \& Gray Competing Risks Coefficients for Creating \emph{Specialised \& Independently} Controlled 1st Deposit Insurer (others competing)) size(footnotesize) width(22cm) marker(di_ind_estimates) footnote("Standard errors in parentheses. {*}/{*}{*}/{*}{*}{*} at 10/5/1\% significance levels. GDP/capita was dropped from models with Unified Democracy Score and Deposit Bank Assets/GDP due to high correlations (0.693 and 0.708 respectively). The governance quality indicators are not shown for the same reason. Only significant time interactions are shown.") frag nofix hlines(20, 25) replace	
		
		
		
	
		// Graph for examining time-varying coefficients across time
		
stcrreg dem5 banking_crisis dbagdp peer_region_mof kaopen eu1994 time_in_office, compete(di_state == 3 4) tvc(kaopen time_in_office)

		twoway (function shr_udems_mean = exp([main]_b[udems_mean]+x*[tvc]_b[udems_mean]), range(2 24) ytitle("Sub-hazard Ratio--exp(b)") xtitle("") yline(1) graphregion(color(white))) || (function shr_time_in_office = exp([main]_b[time_in_office]+x*[tvc]_b[time_in_office]), range(2 24) ytitle("Sub-hazard Ratio--exp(b)") xtitle("") yline(1) graphregion(color(white))) 
		
		twoway (function per_change_dem5 = ((exp([main]_b[dem5])-1)*100)+x*0, range(2 24) ytitle("") xtitle("") yline(1) graphregion(color(white)))
				
		twoway (function shr_udems_mean = exp([main]_b[udems_mean]+x*[tvc]_b[udems_mean]), range(2 24) ytitle("Sub-hazard Ratio--exp(b)") xtitle("") yline(1) graphregion(color(white))) || (function shr_time_in_office = exp([main]_b[time_in_office]+x*[tvc]_b[time_in_office]), range(2 24) ytitle("Sub-hazard Ratio--exp(b)") xtitle("") yline(1) graphregion(color(white))) 


////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

////////
// Comparing FG-CREHA Results with Cox PH transition-specific hazards
///////
		
cd "~/Cox_FG_CREHA_Compare/"

******************************************** Transitions to MoF ******************
** Cox PH (Transition-Specific Hazard)
use "http://dl.dropbox.com/u/12581470/code/Replicability_code/DI_Replication/public_DI_replication_data.dta", clear

	stset year, id(country) failure(di_state == 2) origin(min) enter(di_state == 1) exit(di_state == 2 3 4) 

	stcox dem5 banking_crisis dbagdp peer_region_mof kaopen eu1994 time_in_office, tvc(dbagdp) cluster(country) nohr
		regsave using cox_FG_Compare.dta, ci replace

** Clean up		
use cox_FG_Compare.dta, clear
	rename coef CoxCoefMoF
	rename ci_lower CoxLowerMoF
	rename ci_upper CoxUpperMoF
	drop stderr N
	
    replace var = "New Dem" if var == "main:dem5"
        replace var = "DBA/GDP" if var == "main:dbagdp"
        replace var = "Crisis" if var == "main:banking_crisis"
        replace var = "Peer SE (MoF)" if var == "main:peer_region_mof"
        replace var = "KAOPEN" if var == "main:kaopen"
        replace var = "EU" if var == "main:eu1994"
        replace var = "CBG" if var == "main:time_in_office"
        replace var = "DBA/GDP (tvc)" if var == "tvc:dbagdp"
        replace var = "CBG (tvc)" if var == "tvc:time_in_office"
        
    sort var
    save, replace
    
** FG-CREHA (Hazards of the Subdistribution)
use "http://dl.dropbox.com/u/12581470/code/Replicability_code/DI_Replication/public_DI_replication_data.dta", clear

	stset year, id(country) failure(di_state == 2) origin(min) enter(di_state == 1) exit(di_state == 2 3 4) 

	stcrreg dem5 banking_crisis dbagdp peer_region_mof kaopen eu1994 time_in_office, compete(di_state == 3 4) tvc(kaopen time_in_office)
		regsave using temp1.dta, ci replace
		
** Clean up
	use temp1.dta, clear
	rename coef fgCoefMoF
	rename ci_lower fgLowerMoF
	rename ci_upper fgUpperMoF
	drop stderr N
	
    replace var = "New Dem" if var == "main:dem5"
        replace var = "DBA/GDP" if var == "main:dbagdp"
        replace var = "Crisis" if var == "main:banking_crisis"
        replace var = "Peer SE (MoF)" if var == "main:peer_region_mof"
        replace var = "KAOPEN" if var == "main:kaopen"
        replace var = "EU" if var == "main:eu1994"
        replace var = "CBG" if var == "main:time_in_office"
        replace var = "KAOPEN (tvc)" if var == "tvc:kaopen"
        replace var = "CBG (tvc)" if var == "tvc:time_in_office"
        
	sort var
	save, replace
	
******************************************** Transitions to Ind ******************
** Cox PH (Transition-Specific Hazard)
use "http://dl.dropbox.com/u/12581470/code/Replicability_code/DI_Replication/public_DI_replication_data.dta", clear

	stset year, id(country) failure(di_state == 4) origin(min) enter(di_state == 1) exit(di_state == 2 3 4) 

		stcox udems_mean dem5 peer_region_ind eu1994 time_in_office, tvc(dem5 eu1994) cluster(country) nohr
		regsave using temp2.dta, ci replace

** Clean up		
use temp2, clear
	rename coef CoxCoefInd
	rename ci_lower CoxLowerInd
	rename ci_upper CoxUpperInd
	drop stderr N
	
    replace var = "New Dem" if var == "main:dem5"
        replace var = "UDS" if var == "main:udems_mean"
        replace var = "DBA/GDP" if var == "main:dbagdp"
        replace var = "Crisis" if var == "main:banking_crisis"
        replace var = "Peer SE (Ind)" if var == "main:peer_region_ind"
        replace var = "KAOPEN" if var == "main:kaopen"
        replace var = "EU" if var == "main:eu1994"
        replace var = "CBG" if var == "main:time_in_office"
        replace var = "EU (tvc)" if var == "tvc:eu1994"
        replace var = "New Dem (tvc)" if var == "tvc:dem5"
        
    sort var
    save, replace
    
** FG-CREHA (Hazards of the Subdistribution)
use "http://dl.dropbox.com/u/12581470/code/Replicability_code/DI_Replication/public_DI_replication_data.dta", clear

    stset year, id(country) failure(di_state == 4) origin(min) enter(di_state == 1) exit(di_state == 2 3 4) 

	stcrreg udems_mean dem5 peer_region_ind eu1994 time_in_office, compete(di_state == 2 3) tvc(udems_mean time_in_office)
		regsave using temp3.dta, ci replace
		
** Clean up
	use temp3.dta, clear
	rename coef fgCoefInd
	rename ci_lower fgLowerInd
	rename ci_upper fgUpperInd
	drop stderr N
	
    replace var = "New Dem" if var == "main:dem5"
        replace var = "UDS" if var == "main:udems_mean"
        replace var = "DBA/GDP" if var == "main:dbagdp"
        replace var = "Crisis" if var == "main:banking_crisis"
        replace var = "Peer SE (Ind)" if var == "main:peer_region_ind"
        replace var = "KAOPEN" if var == "main:kaopen"
        replace var = "EU" if var == "main:eu1994"
        replace var = "CBG" if var == "main:time_in_office"
        replace var = "UDS (tvc)" if var == "tvc:udems_mean"
        replace var = "CBG (tvc)" if var == "tvc:time_in_office"
        
	sort var
	save, replace
	
******* Merge Data sets ****************
use cox_FG_Compare.dta, clear
	merge var using temp1.dta
	sort var
	drop _merge

	merge var using temp2.dta
	sort var
	drop _merge
	
	merge var using temp3.dta
	sort var
	drop _merge	

saveold "Cox_FG_Comparison_clean.dta", replace	


/* R code to create comparative point and range plots

library(foreign)
library(gdata)
library(ggplot2)
library(gridExtra)

################# Compare Cox and FG-CREHA Coef Estimates ############################

estimates <- read.dta("Cox_FG_Comparison_clean.dta")

### Melt & Merge data
### MoF ###
coef.vars.MoF <- c("var", "CoxCoefMoF", "fgCoefMoF", "CoxCoefInd", "fgCoefInd")
coef.MoF <- estimates[coef.vars.MoF]  
coef.MoF.Molten <- melt(coef.MoF, id = c("var"), measure = c(2:3))
coef.MoF.Molten <- rename.vars(coef.MoF.Molten, from = "value", to = "Coef", info = FALSE)
coef.MoF.Molten$method[coef.MoF.Molten$variable == "CoxCoefMoF"] <- "Cox PH" 
coef.MoF.Molten$method[coef.MoF.Molten$variable == "fgCoefMoF"] <- "FG-CREHA" 
coef.MoF.Molten <- coef.MoF.Molten[c(-2)]

lower.vars.MoF <- c("var", "CoxLowerMoF", "fgLowerMoF")
lower.MoF <- estimates[lower.vars.MoF]
lower.MoF.Molten <- melt(lower.MoF, id = c("var"), measure = c(2:3))
lower.MoF.Molten <- rename.vars(lower.MoF.Molten, from = "value", to = "lower", info = FALSE)
lower.MoF.Molten$method[lower.MoF.Molten$variable == "CoxLowerMoF"] <- "Cox PH" 
lower.MoF.Molten$method[lower.MoF.Molten$variable == "fgLowerMoF"] <- "FG-CREHA" 
lower.MoF.Molten <- lower.MoF.Molten[c(-2)]

upper.vars.MoF <- c("var", "CoxUpperMoF", "fgUpperMoF")
upper.MoF <- estimates[upper.vars.MoF]
upper.MoF.Molten <- melt(upper.MoF, id = c("var"), measure = c(2:3))
upper.MoF.Molten <- rename.vars(upper.MoF.Molten, from = "value", to = "upper", info = FALSE)  
upper.MoF.Molten$method[upper.MoF.Molten$variable == "CoxUpperMoF"] <- "Cox PH" 
upper.MoF.Molten$method[upper.MoF.Molten$variable == "fgUpperMoF"] <- "FG-CREHA" 
upper.MoF.Molten <- upper.MoF.Molten[c(-2)]

MoF.compare.df <- merge(coef.MoF.Molten, lower.MoF.Molten, by = c("var", "method"))
MoF.compare.df <- merge(MoF.compare.df, upper.MoF.Molten, by = c("var", "method"))

MoF.compare.df$type <- "MoF"

### Ind ###

coef.vars.Ind <- c("var", "CoxCoefInd", "fgCoefInd", "CoxCoefInd", "fgCoefInd")
coef.Ind <- estimates[coef.vars.Ind]  
coef.Ind.Molten <- melt(coef.Ind, id = c("var"), measure = c(2:3))
coef.Ind.Molten <- rename.vars(coef.Ind.Molten, from = "value", to = "Coef", info = FALSE)
coef.Ind.Molten$method[coef.Ind.Molten$variable == "CoxCoefInd"] <- "Cox PH" 
coef.Ind.Molten$method[coef.Ind.Molten$variable == "fgCoefInd"] <- "FG-CREHA" 
coef.Ind.Molten <- coef.Ind.Molten[c(-2)]

lower.vars.Ind <- c("var", "CoxLowerInd", "fgLowerInd")
lower.Ind <- estimates[lower.vars.Ind]
lower.Ind.Molten <- melt(lower.Ind, id = c("var"), measure = c(2:3))
lower.Ind.Molten <- rename.vars(lower.Ind.Molten, from = "value", to = "lower", info = FALSE)
lower.Ind.Molten$method[lower.Ind.Molten$variable == "CoxLowerInd"] <- "Cox PH" 
lower.Ind.Molten$method[lower.Ind.Molten$variable == "fgLowerInd"] <- "FG-CREHA" 
lower.Ind.Molten <- lower.Ind.Molten[c(-2)]

upper.vars.Ind <- c("var", "CoxUpperInd", "fgUpperInd")
upper.Ind <- estimates[upper.vars.Ind]
upper.Ind.Molten <- melt(upper.Ind, id = c("var"), measure = c(2:3))
upper.Ind.Molten <- rename.vars(upper.Ind.Molten, from = "value", to = "upper", info = FALSE)  
upper.Ind.Molten$method[upper.Ind.Molten$variable == "CoxUpperInd"] <- "Cox PH" 
upper.Ind.Molten$method[upper.Ind.Molten$variable == "fgUpperInd"] <- "FG-CREHA" 
upper.Ind.Molten <- upper.Ind.Molten[c(-2)]

Ind.compare.df <- merge(coef.Ind.Molten, lower.Ind.Molten, by = c("var", "method"))
Ind.compare.df <- merge(Ind.compare.df, upper.Ind.Molten, by = c("var", "method"))


Ind.compare.df$type <- "Ind"

### Combine melted data into one data.frame

compare.df <- rbind(MoF.compare.df, Ind.compare.df)

### Colours
cols <- c("#EB3B00", "#516F91")

##### Create comparison plot
est.plot <- ggplot(compare.df, aes(var, Coef, ymin = lower, ymax = upper, color = method)) +
  facet_grid(.~type) +
  opts(
        strip.text.x = theme_text(size = 30),
        axis.text.x = theme_text(size = 20),
        axis.text.y = theme_text(size = 20),
        legend.text = theme_text(size = 20),
        panel.background = theme_blank(),
        panel.border = theme_rect(colour = "grey90"),
        panel.grid.minor = theme_blank(), 
        panel.grid.major = theme_line(colour = "grey90"),
        plot.background = theme_blank()
        ) +
  scale_y_continuous(breaks = c(-40, -20, -5, 0, 5)) +
  geom_pointrange(size = 1, alpha = 0.75) +
  geom_hline(aes(intercept= 0), linetype = "dotted") +
  scale_color_manual(values = cols, name = "") +                            
  xlab("") + ylab("") +
  coord_flip() 

est.plot


*/

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

///////
// Cox PH Estimated Coefficients for Creating \emph{Deposit Insurance}
///////

use "http://dl.dropbox.com/u/12581470/code/Replicability_code/DI_Replication/public_DI_replication_data.dta", clear

	// Create combined DI failure, i.e. first deposit insurer
		gen di_fail = 1 if di_state > 1
		replace di_fail = 0 if di_state == 1
		order di_fail, after(di_state) 

	// Cox PRM for creating deposit insurance
	
	// stset data
	stset year, id(country) failure(di_fail == 1) origin(min) enter(di_fail == 0) exit(di_fail == 1)

	stcox eu1994 gdp_pcapita, tvc(time_in_office) vce(robust)
		regsave using "di_fail_est_paper.dta", detail(all) replace table(C1, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
	
	stcox udems_mean eu1994 gdp_pcapita, tvc(time_in_office) vce(robust)
		regsave using "di_fail_est_paper.dta", append detail(all) table(C2, order(regvars r2) format(%5.3f) paren(stderr) asterisk())

	stcox dem5 eu1994 gdp_pcapita, tvc(time_in_office) vce(robust)
		regsave using "di_fail_est_paper.dta", append detail(all) table(C3, order(regvars r2) format(%5.3f) paren(stderr) asterisk())

	stcox dbagdp eu1994 gdp_pcapita, tvc(time_in_office) vce(robust)
		regsave using "di_fail_est_paper.dta", append detail(all) table(C4, order(regvars r2) format(%5.3f) paren(stderr) asterisk())

	stcox eu1994 gdp_pcapita, tvc(banking_crisis time_in_office) vce(robust)
		regsave using "di_fail_est_paper.dta", append detail(all) table(C5, order(regvars r2) format(%5.3f) paren(stderr) asterisk())

	stcox eu1994 gdp_pcapita, tvc(peer_region_ind time_in_office) vce(robust)
		regsave using "di_fail_est_paper.dta", append detail(all) table(C6, order(regvars r2) format(%5.3f) paren(stderr) asterisk())

	stcox eu1994 gdp_pcapita, tvc(peer_region_mof  time_in_office) vce(robust)
		regsave using "di_fail_est_paper.dta", append detail(all) table(C7, order(regvars r2) format(%5.3f) paren(stderr) asterisk())
	
	stcox kaopen eu1994 gdp_pcapita, tvc(time_in_office) vce(robust)
		regsave using "di_fail_est_paper.dta", append detail(all) table(C8, order(regvars r2) format(%5.3f) paren(stderr) asterisk())

	stcox eu1994 gdp_pcapita, tvc(imf_2 time_in_office) vce(robust)
		regsave using "di_fail_est_paper.dta", append detail(all) table(C9, order(regvars r2) format(%5.3f) paren(stderr) asterisk())

	stcox udems_mean kaopen eu1994 gdp_pcapita, tvc(banking_crisis peer_region_ind imf_2 time_in_office) vce(robust)
		regsave using "di_fail_est_paper.dta", append detail(all) table(C10, order(regvars r2) format(%5.3f) paren(stderr) asterisk())

    ///// Create .tex file /////
    use "di_fail_est_paper.dta", clear	
    
        //rename variables
        
        generate order = 99 
        
        replace var = "Democracy (UDS)" if var == "main:udems_mean_coef"
            replace order = 1 if var == "Democracy (UDS)"
            replace order = 2 if var == "main:udems_mean_stderr"
            
        replace var = "New Democracy" if var == "main:dem5_coef"
            replace order = 3 if var == "New Democracy"
            replace order = 4 if var == "main:dem5_stderr"
            
        replace var = "DB Assets/GDP" if var == "main:dbagdp_coef"
            replace order = 5 if var == "DB Assets/GDP"
            replace order = 6 if var == "main:dbagdp_stderr"
            
        replace var = "Capital Openness (KAOPEN)" if var == "main:kaopen_coef"
            replace order = 7 if var == "Capital Openness (KAOPEN)"
            replace order = 8 if var == "main:kaopen_stderr" 

        replace var = "EU (from 1994)" if var == "main:eu1994_coef"
            replace order = 9 if var == "EU (from 1994)"
            replace order = 10 if var == "main:eu1994_stderr"

        replace var = "GDP/Capita" if var == "main:gdp_pcapita_coef"
            replace order = 11 if var == "GDP/Capita"
            replace order = 12 if var == "main:gdp_pcapita_stderr" 
            
        // Time interaction label
        
        replace var = "{\bf{Time Interactions}}" if var == "clustvar"
            replace order = 13 if var == "{\bf{Time Interactions}}"
            
        replace var = "Crisis Dummy" if var == "tvc:banking_crisis_coef"
            replace order = 14 if var == "Crisis Dummy"
            replace order = 15 if var == "tvc:banking_crisis_stderr"
            
        replace var = "Regional Peer SE (Ind.)" if var == "tvc:peer_region_ind_coef"
            replace order = 16 if var == "Regional Peer SE (Ind.)" 
            replace order = 17 if var == "tvc:peer_region_ind_stderr"
            
        replace var = "Regional Peer SE (MoF)" if var == "tvc:peer_region_mof_coef"
            replace order = 18 if var == "Regional Peer SE (MoF)" 
            replace order = 19 if var == "tvc:peer_region_mof_stderr"
            
        replace var = "IMF Stand-by" if var == "tvc:imf_2_coef"
            replace order = 20 if var == "IMF Stand-by"
            replace order = 21 if var == "tvc:imf_2_stderr"
            
        replace var = "CBG Tenure" if var == "tvc:time_in_office_coef"
            replace order = 22 if var == "CBG Tenure"
            replace order = 23 if var == "tvc:time_in_office_stderr"
        
        replace var = "Countries at Risk" if var == "N_clust"
            replace order = 24 if var == "Countries at Risk"
            
        replace var = "No. of MoF Created" if var == "N_fail"
            replace order = 25 if var == "No. of DI Created"
        
        replace var = "Pseudo log-likelihood" if var == "ll"
            replace order = 26 if var == "Pseudo log-likelihood"
        
        replace order = 27 if var == "chi2"

        replace order = 28 if var == "p"
        
        
        generate _stderr = regexm(var, "_stderr")
            replace var = "" if _stderr == 1
                    
        replace C1 = "" if var == "{\bf{Time Interactions}}"
        replace C2 = "" if var == "{\bf{Time Interactions}}"
        replace C3 = "" if var == "{\bf{Time Interactions}}"
        replace C4 = "" if var == "{\bf{Time Interactions}}"
        replace C5 = "" if var == "{\bf{Time Interactions}}"
        replace C6 = "" if var == "{\bf{Time Interactions}}"
        replace C7 = "" if var == "{\bf{Time Interactions}}"
        replace C8 = "" if var == "{\bf{Time Interactions}}"
        replace C9 = "" if var == "{\bf{Time Interactions}}"
        replace C10 = "" if var == "{\bf{Time Interactions}}"
            	  
        replace C1 = "$<$0.001" if C1 == "0" & var == "p"
        replace C2 = "$<$0.001" if C2 == "0" & var == "p"
        replace C3 = "$<$0.001" if C3 == "0" & var == "p"
        replace C4 = "$<$0.001" if C4 == "0" & var == "p"
        replace C5 = "$<$0.001" if C5 == "0" & var == "p"
        replace C6 = "$<$0.001" if C6 == "0" & var == "p"
        replace C7 = "$<$0.001" if C7 == "0" & var == "p"
        replace C8 = "$<$0.001" if C8 == "0" & var == "p"
        replace C9 = "$<$0.001" if C9 == "0" & var == "p"
        replace C10 = "$<$0.001" if C10 == "0" & var == "p"

        replace C1 = subinstr(C1, "-", "$-$", 1)
        replace C2 = subinstr(C2, "-", "$-$", 1)
        replace C3 = subinstr(C3, "-", "$-$", 1)
        replace C4 = subinstr(C4, "-", "$-$", 1)
        replace C5 = subinstr(C5, "-", "$-$", 1)
        replace C6 = subinstr(C6, "-", "$-$", 1)
        replace C7 = subinstr(C7, "-", "$-$", 1)
        replace C8 = subinstr(C8, "-", "$-$", 1)
        replace C9 = subinstr(C9, "-", "$-$", 1)
        replace C10 = subinstr(C10, "-", "$-$", 1)

 	    drop if order == 99
        
   	    rename var Variable
        sort order
	        drop order _stderr
	    compress
    


texsave using "di_fail_est_paper.tex", title(Cox PH Coefficients for Creating \emph{Deposit Insurance}) size(footnotesize) width(22cm) marker(di_estimates) footnote("Standard errors in parentheses. {*}/{*}{*}/{*}{*}{*} at 10/5/1\% significance levels. Many of the variables are time-varying in that the estimated coefficient increases or decreases over-time.") frag nofix hlines(12, 23) replace

// Note: manually entered Prob > chi2 from Stata output
