!------------------------------------------------------------------------------
!                  GEOS-Chem Global Chemical Transport Model                  !
!------------------------------------------------------------------------------
!BOP
!
! !MODULE: cleanup.F90
!
! !DESCRIPTION: Subroutine CLEANUP deallocates the memory assigned to
!  dynamically allocatable arrays just before exiting a GEOS-Chem simulation.
!\\
!\\
! !INTERFACE:
!
SUBROUTINE CLEANUP( Input_Opt, State_Grid, ERROR, RC )
!
! !USES:
!
  USE CARBON_MOD,              ONLY : CLEANUP_CARBON
  USE Carbon_Gases_Mod,        ONLY : Cleanup_Carbon_Gases
  USE CO2_MOD,                 ONLY : CLEANUP_CO2
  USE DEPO_MERCURY_MOD,        ONLY : CLEANUP_DEPO_MERCURY
  USE DRYDEP_MOD,              ONLY : CLEANUP_DRYDEP
  USE DUST_MOD,                ONLY : CLEANUP_DUST
  USE ErrCode_Mod
  USE ERROR_MOD,               ONLY : DEBUG_MSG
  USE FullChem_MOD,            ONLY : Cleanup_FullChem
  USE GLOBAL_Br_MOD,           ONLY : CLEANUP_GLOBAL_Br
  USE Grid_Registry_Mod,       ONLY : Cleanup_Grid_Registry
  USE History_Mod,             ONLY : History_Cleanup
  USE Input_Opt_Mod,           ONLY : OptInput
  USE AEROSOL_THERMODYNAMICS_MOD, ONLY : CLEANUP_ATE
  USE LAND_MERCURY_MOD,        ONLY : CLEANUP_LAND_MERCURY
  USE LINEAR_CHEM_MOD,         ONLY : CLEANUP_LINEAR_CHEM
  USE MERCURY_MOD,             ONLY : CLEANUP_MERCURY
  USE ObsPack_Mod,             ONLY : ObsPack_SpeciesMap_Cleanup
  USE OCEAN_MERCURY_MOD,       ONLY : CLEANUP_OCEAN_MERCURY
  USE PJC_PFIX_MOD,            ONLY : CLEANUP_PJC_PFIX
  USE PLANEFLIGHT_MOD,         ONLY : CLEANUP_PLANEFLIGHT
  USE POPs_Mod,                ONLY : Cleanup_POPs
  USE PRESSURE_MOD,            ONLY : CLEANUP_PRESSURE
  USE SEASALT_MOD,             ONLY : CLEANUP_SEASALT
  USE SULFATE_MOD,             ONLY : CLEANUP_SULFATE
  USE State_Grid_Mod,          ONLY : GrdState
  USE TAGGED_CO_MOD,           ONLY : CLEANUP_TAGGED_CO
  USE EMISSIONS_MOD,           ONLY : EMISSIONS_FINAL
  USE SFCVMR_MOD,              ONLY : FixSfcVmr_Final
  USE VDiff_Mod,               ONLY : Cleanup_Vdiff
#ifdef TOMAS
  USE TOMAS_MOD,               ONLY : CLEANUP_TOMAS  !sfarina, 1/16/13
#endif
#ifdef MODEL_CLASSIC
  USE TPCORE_FVDAS_MOD,        ONLY : EXIT_TPCORE
  USE TPCORE_WINDOW_MOD,       ONLY : EXIT_TPCORE_WINDOW
  USE TRANSPORT_MOD,           ONLY : CLEANUP_TRANSPORT
#endif
#ifdef RRTMG
  USE RRTMG_RAD_TRANSFER_MOD,  ONLY : Cleanup_RRTMG_Rad_Transfer
#endif

  IMPLICIT NONE
!
! !INPUT PARAMETERS:
!
  TYPE(OptInput), INTENT(IN)  :: Input_Opt    ! Input options
  TYPE(GrdState), INTENT(IN)  :: State_Grid   ! Grid state object
  LOGICAL,        INTENT(IN)  :: ERROR        ! Cleanup after error?
!
! !OUTPUT PARAMETERS:
!
  INTEGER,        INTENT(OUT) :: RC           ! Success or failure
!
! !REVISION HISTORY:
!  29 Nov 1999 - R. Yantosca - Initial version
!  See https://github.com/geoschem/geos-chem for complete history
!EOP
!------------------------------------------------------------------------------
!BOC
!
! !LOCAL VARIABLES:
!
  ! Strings
  CHARACTER(LEN=255) :: ErrMsg, ThisLoc

  !=================================================================
  ! CLEANUP begins here!
  !=================================================================

  ! Initialize
  RC      = GC_SUCCESS
  ErrMsg  = ''
  ThisLoc = ' -> at CLEANUP (in module GeosCore/cleanup.F)'

  ! Echo info
  IF ( Input_Opt%amIRoot ) THEN
     WRITE( 6, 100 )
  ENDIF
100 FORMAT( '     - CLEANUP: deallocating arrays now...' )

  !=================================================================
  !         ***** H I S T O R Y   C L E A N U P *****
  !
  ! Finalize the History Component.
  ! Also closes all netCDF files that may still be open.
  !=================================================================

  ! Finalize the history component
  CALL History_Cleanup( RC )
  IF ( RC /= GC_SUCCESS ) THEN
     ErrMsg = 'Error encountered in "History_Cleanup"!'
     CALL GC_Error( ErrMsg, RC, ThisLoc )
     RETURN
  ENDIF

  !=================================================================
  ! Cleanup HEMCO
  !=================================================================
  CALL EMISSIONS_FINAL( ERROR, RC )

  ! Cleanup surface mixing concentration module
  CALL FixSfcVmr_Final( RC )

  !=================================================================
  ! Call cleanup routines from individual F90 modules
  !=================================================================
  CALL CLEANUP_CARBON()
  CALL CLEANUP_CO2()
  CALL CLEANUP_DRYDEP()
  CALL CLEANUP_DUST()
  CALL CLEANUP_ATE()
  CALL CLEANUP_PJC_PFIX()
  CALL CLEANUP_PRESSURE()
  CALL CLEANUP_SEASALT()
  CALL CLEANUP_SULFATE()
  CALL CLEANUP_LINEAR_CHEM()

  CALL Cleanup_FullChem( RC )
  IF ( RC /= GC_SUCCESS ) THEN
     ErrMsg = 'Error encountered in "Cleanup_FlexChem"!'
     CALL GC_Error( ErrMsg, RC, ThisLoc )
     RETURN
  ENDIF

  CALL Cleanup_Carbon_Gases( RC )
  IF ( RC /= GC_SUCCESS ) THEN
     ErrMsg = 'Error encountered in "Cleanup_Carbon_Gases"!'
     CALL GC_Error( ErrMsg, RC, ThisLoc )
     RETURN
  ENDIF

  CALL Cleanup_Grid_Registry( RC )
  IF ( RC /= GC_SUCCESS ) THEN
     ErrMsg = 'Error encountered in "Cleanup_Grid_Registry"!'
     CALL GC_Error( ErrMsg, RC, ThisLoc )
     RETURN
  ENDIF

#if defined( MODEL_CLASSIC )
  IF ( State_Grid%NestedGrid ) THEN
     CALL EXIT_TPCORE_WINDOW()
  ELSE
     CALL EXIT_TPCORE()
  ENDIF
#endif

  ! Cleanup Tagged CO code
  CALL CLEANUP_TAGGED_CO( RC )
  IF ( RC /= GC_SUCCESS ) THEN
     ErrMsg = 'Error encountered in "Cleanup_Tagged_CO"!'
     CALL GC_Error( ErrMsg, RC, ThisLoc )
     RETURN
  ENDIF

  CALL CLEANUP_MERCURY()
  CALL CLEANUP_OCEAN_MERCURY()
  CALL CLEANUP_DEPO_MERCURY()
  CALL CLEANUP_LAND_MERCURY()
  CALL CLEANUP_PLANEFLIGHT()

  CALL Cleanup_Global_Br( RC )
  IF ( RC /= GC_SUCCESS ) THEN
     ErrMsg = 'Error encountered in "Cleanup_Global_Br"!'
     CALL GC_Error( ErrMsg, RC, ThisLoc )
     RETURN
  ENDIF

  CALL Cleanup_POPs( RC )
  IF ( RC /= GC_SUCCESS ) THEN
     ErrMsg = 'Error encountered in "Cleanup_POPs"!'
     CALL GC_Error( ErrMsg, RC, ThisLoc )
     RETURN
  ENDIF

  CALL CleanUp_Vdiff( RC )
  IF ( RC /= GC_SUCCESS ) THEN
     ErrMsg = 'Error encountered in "Cleanup_Vdiff"!'
     CALL GC_Error( ErrMsg, RC, ThisLoc )
     RETURN
  ENDIF

#ifdef RRTMG
  CALL Cleanup_RRTMG_Rad_Transfer( RC )
  IF ( RC /= GC_SUCCESS ) THEN
     ErrMsg = 'Error encountered in "Cleanup_RRTMG_Rad_Transfer"!'
     CALL GC_Error( ErrMsg, RC, ThisLoc )
     RETURN
  ENDIF
#endif

#ifdef TOMAS
  CALL CLEANUP_TOMAS()
#endif

#if defined( MODEL_CLASSIC )
  CALL CLEANUP_TRANSPORT()
#endif

END SUBROUTINE CLEANUP
!EOC
