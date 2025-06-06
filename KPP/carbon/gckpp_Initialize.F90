! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Initialization File
! 
! Generated by KPP-3.2.0 symbolic chemistry Kinetics PreProcessor
!       (https:/github.com/KineticPreProcessor/KPP
! KPP is distributed under GPL, the general public licence
!       (http://www.gnu.org/copyleft/gpl.html)
! (C) 1995-1997, V. Damian & A. Sandu, CGRER, Univ. Iowa
! (C) 1997-2022, A. Sandu, Michigan Tech, Virginia Tech
!     With important contributions from:
!        M. Damian,   Villanova University, Philadelphia, PA, USA
!        R. Sander,   Max-Planck Institute for Chemistry, Mainz, Germany
!        M. Long,     Renaissance Fiber, LLC, North Carolina, USA
!        H. Lin,      Harvard University, Cambridge, MA, USA
!        R. Yantosca, Harvard University, Cambridge, MA, USA
! 
! File                 : gckpp_Initialize.F90
! Equation file        : gckpp.kpp
! Output root filename : gckpp
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



MODULE gckpp_Initialize

  USE gckpp_Parameters, ONLY: dp, NVAR, NFIX
  IMPLICIT NONE

CONTAINS


! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Initialize - function to initialize concentrations
!   Arguments :
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE Initialize ( )


  USE gckpp_Global

  USE gckpp_Parameters

  INTEGER :: i
  REAL(kind=dp) :: x

! ~~~ Define scale factor for units
  CFACTOR = 1.000000e+00_dp

! ~~~ Zero C array
  C = 0.0_dp

! ~~~ Set initial species concentrations

! Begin constant rate coefficients
! End constant rate coefficients

! Begin inlined code from F90_INIT

! End inlined code from F90_INIT

      
END SUBROUTINE Initialize

! End of Initialize function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



END MODULE gckpp_Initialize

