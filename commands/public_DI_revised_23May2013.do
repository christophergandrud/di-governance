////////////////////////////////
// Reproducible Tables for "Competing Risks Analysis & Deposit Insurance Governance Convergence"
// Models with revised data
// Author Christopher Gandrud
// Updated 23 May 2012 
// Using Stata 12 & R 2.14
////////////////////////////////

/////////
// Fine \& Gray Competing Risks Coefficients for Creating \emph{MoF} Controlled 1st Deposit Insurer (others competing)
/////////

use "~/public_DI_replication_data_v23May2013.dta", clear

    ///// stset data   
        stset year, id(country) failure(di_state == 2) origin(min) enter(di_state == 1) exit(di_state == 2 3 4) 

    ///// Base Fine & Gray output for tables /////

		stcrreg eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office) noshr	
		
		stcrreg udems_mean eu1994 time_in_office, compete(di_state == 3 4) tvc(time_in_office) noshr
		
		stcrreg dem5 eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office) noshr
		
		stcrreg dbagdp eu1994 time_in_office, compete(di_state == 3 4) tvc(dbagdp time_in_office) noshr
		
		stcrreg banking_crisis eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office) noshr
		
		stcrreg peer_region_mof eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office) noshr
		
		stcrreg kaopen eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(kaopen time_in_office) noshr
		
		stcrreg imf_2 eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office) noshr
		
		stcrreg banking_crisis imf_2 eu1994 gdp_pcapita time_in_office, compete(di_state == 3 4) tvc(time_in_office) noshr
		
		stcrreg banking_crisis imf_2 dbagdp eu1994 time_in_office, compete(di_state == 3 4) tvc(dbagdp time_in_office) noshr
		
		stcrreg dem5 banking_crisis dbagdp peer_region_mof kaopen eu1994, compete(di_state == 3 4) tvc(kaopen) noshr
		
		stcrreg dem5 banking_crisis dbagdp peer_region_mof kaopen eu1994 time_in_office, compete(di_state == 3 4) tvc(kaopen time_in_office) noshr
		
		
/////////
// Fine \& Gray Competing Risks Coefficients for Creating \emph{Specialised \& Independently} Controlled 1st Deposit Insurer (others competing)
/////////

use "~/public_DI_replication_data_v23May2013.dta", clear

    /// stset data
    stset year, id(country) failure(di_state == 4) origin(min) enter(di_state == 1) exit(di_state == 2 3 4)

		stcrreg eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office) noshr

		stcrreg udems_mean eu1994 time_in_office, compete(di_state == 2 3) tvc(udems_mean gdp_pcapita time_in_office) noshr

		stcrreg dem5 eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office) noshr

		stcrreg dbagdp eu1994 time_in_office, compete(di_state == 2 3) tvc(time_in_office) noshr

		stcrreg banking_crisis eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office) noshr

		stcrreg peer_region_ind eu1994 time_in_office, compete(di_state == 2 3) tvc(time_in_office) noshr

		stcrreg kaopen eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office) noshr

		stcrreg imf_2 eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office) noshr

		stcrreg banking_crisis imf_2 eu1994 gdp_pcapita time_in_office, compete(di_state == 2 3) tvc(time_in_office) noshr

		stcrreg udems_mean dem5 peer_region_ind eu1994, compete(di_state == 2 3) tvc(udems_mean) noshr

		stcrreg udems_mean dem5 peer_region_ind eu1994 time_in_office, compete(di_state == 2 3) tvc(udems_mean time_in_office) noshr

			
