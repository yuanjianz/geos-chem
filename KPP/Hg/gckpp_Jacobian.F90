! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! The ODE Jacobian of Chemical Model File
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
! File                 : gckpp_Jacobian.F90
! Equation file        : gckpp.kpp
! Output root filename : gckpp
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



MODULE gckpp_Jacobian

  USE gckpp_Parameters
  USE gckpp_JacobianSP

  IMPLICIT NONE

CONTAINS


! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Jac_SP - the Jacobian of Variables in sparse matrix representation
!   Arguments :
!      V         - Concentrations of variable species (local)
!      F         - Concentrations of fixed species (local)
!      RCT       - Rate constants (local)
!      JVS       - sparse Jacobian of variables
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE Jac_SP ( V, F, RCT, JVS )

! V - Concentrations of variable species (local)
  REAL(kind=dp) :: V(NVAR)
! F - Concentrations of fixed species (local)
  REAL(kind=dp) :: F(NFIX)
! RCT - Rate constants (local)
  REAL(kind=dp) :: RCT(NREACT)
! JVS - sparse Jacobian of variables
  REAL(kind=dp) :: JVS(LU_NONZERO)


! Local variables
! B - Temporary array
  REAL(kind=dp) :: B(128)

! B(1) = dA(1)/dV(30)
  B(1) = RCT(1)*F(1)
! B(3) = dA(2)/dV(32)
  B(3) = RCT(2)
! B(4) = dA(3)/dV(32)
  B(4) = RCT(3)*F(1)
! B(6) = dA(4)/dV(32)
  B(6) = RCT(4)*F(4)
! B(8) = dA(5)/dV(32)
  B(8) = RCT(5)*F(4)
! B(10) = dA(6)/dV(32)
  B(10) = RCT(6)*F(7)
! B(12) = dA(7)/dV(32)
  B(12) = RCT(7)*F(9)
! B(14) = dA(8)/dV(32)
  B(14) = RCT(8)*F(8)
! B(16) = dA(9)/dV(32)
  B(16) = RCT(9)*F(3)
! B(18) = dA(10)/dV(32)
  B(18) = RCT(10)*F(1)
! B(20) = dA(11)/dV(22)
  B(20) = RCT(11)*F(11)
! B(22) = dA(12)/dV(22)
  B(22) = RCT(12)*F(10)
! B(24) = dA(13)/dV(32)
  B(24) = RCT(13)*F(6)
! B(26) = dA(14)/dV(30)
  B(26) = RCT(14)*F(2)
! B(28) = dA(15)/dV(27)
  B(28) = RCT(15)*F(2)
! B(30) = dA(16)/dV(27)
  B(30) = RCT(16)*F(4)
! B(32) = dA(17)/dV(27)
  B(32) = RCT(17)*F(4)
! B(34) = dA(18)/dV(27)
  B(34) = RCT(18)*F(7)
! B(36) = dA(19)/dV(27)
  B(36) = RCT(19)*F(9)
! B(38) = dA(20)/dV(27)
  B(38) = RCT(20)*F(8)
! B(40) = dA(21)/dV(27)
  B(40) = RCT(21)*F(1)
! B(42) = dA(22)/dV(27)
  B(42) = RCT(22)*F(3)
! B(44) = dA(23)/dV(27)
  B(44) = RCT(23)*F(6)
! B(46) = dA(24)/dV(24)
  B(46) = RCT(24)*F(11)
! B(48) = dA(25)/dV(24)
  B(48) = RCT(25)*F(10)
! B(50) = dA(26)/dV(30)
  B(50) = RCT(26)*F(3)
! B(52) = dA(27)/dV(29)
  B(52) = RCT(27)
! B(53) = dA(28)/dV(29)
  B(53) = RCT(28)*F(4)
! B(55) = dA(29)/dV(29)
  B(55) = RCT(29)*F(7)
! B(57) = dA(30)/dV(29)
  B(57) = RCT(30)*F(9)
! B(59) = dA(31)/dV(29)
  B(59) = RCT(31)*F(8)
! B(61) = dA(32)/dV(29)
  B(61) = RCT(32)*F(1)
! B(63) = dA(33)/dV(29)
  B(63) = RCT(33)*F(3)
! B(65) = dA(34)/dV(29)
  B(65) = RCT(34)*F(6)
! B(67) = dA(35)/dV(19)
  B(67) = RCT(35)*F(11)
! B(69) = dA(36)/dV(19)
  B(69) = RCT(36)*F(10)
! B(71) = dA(37)/dV(16)
  B(71) = RCT(37)
! B(72) = dA(38)/dV(23)
  B(72) = RCT(38)
! B(73) = dA(39)/dV(31)
  B(73) = RCT(39)
! B(74) = dA(40)/dV(14)
  B(74) = RCT(40)
! B(75) = dA(41)/dV(13)
  B(75) = RCT(41)
! B(76) = dA(42)/dV(18)
  B(76) = RCT(42)
! B(77) = dA(43)/dV(17)
  B(77) = RCT(43)
! B(78) = dA(44)/dV(25)
  B(78) = RCT(44)
! B(79) = dA(45)/dV(26)
  B(79) = RCT(45)
! B(80) = dA(46)/dV(9)
  B(80) = RCT(46)
! B(81) = dA(47)/dV(8)
  B(81) = RCT(47)
! B(82) = dA(48)/dV(10)
  B(82) = RCT(48)
! B(83) = dA(49)/dV(1)
  B(83) = RCT(49)
! B(84) = dA(50)/dV(15)
  B(84) = RCT(50)
! B(85) = dA(51)/dV(21)
  B(85) = RCT(51)
! B(86) = dA(52)/dV(20)
  B(86) = RCT(52)
! B(87) = dA(53)/dV(12)
  B(87) = RCT(53)
! B(88) = dA(54)/dV(11)
  B(88) = RCT(54)
! B(89) = dA(55)/dV(16)
  B(89) = RCT(55)
! B(90) = dA(56)/dV(23)
  B(90) = RCT(56)
! B(91) = dA(57)/dV(31)
  B(91) = RCT(57)
! B(92) = dA(58)/dV(14)
  B(92) = RCT(58)
! B(93) = dA(59)/dV(13)
  B(93) = RCT(59)
! B(94) = dA(60)/dV(18)
  B(94) = RCT(60)
! B(95) = dA(61)/dV(17)
  B(95) = RCT(61)
! B(96) = dA(62)/dV(25)
  B(96) = RCT(62)
! B(97) = dA(63)/dV(26)
  B(97) = RCT(63)
! B(98) = dA(64)/dV(9)
  B(98) = RCT(64)
! B(99) = dA(65)/dV(8)
  B(99) = RCT(65)
! B(100) = dA(66)/dV(10)
  B(100) = RCT(66)
! B(101) = dA(67)/dV(15)
  B(101) = RCT(67)
! B(102) = dA(68)/dV(21)
  B(102) = RCT(68)
! B(103) = dA(69)/dV(20)
  B(103) = RCT(69)
! B(104) = dA(70)/dV(12)
  B(104) = RCT(70)
! B(105) = dA(71)/dV(11)
  B(105) = RCT(71)
! B(109) = dA(75)/dV(32)
  B(109) = RCT(75)
! B(110) = dA(76)/dV(16)
  B(110) = RCT(76)
! B(111) = dA(77)/dV(23)
  B(111) = RCT(77)
! B(112) = dA(78)/dV(31)
  B(112) = RCT(78)
! B(113) = dA(79)/dV(18)
  B(113) = RCT(79)
! B(114) = dA(80)/dV(14)
  B(114) = RCT(80)
! B(115) = dA(81)/dV(13)
  B(115) = RCT(81)
! B(116) = dA(82)/dV(17)
  B(116) = RCT(82)
! B(117) = dA(83)/dV(25)
  B(117) = RCT(83)
! B(118) = dA(84)/dV(26)
  B(118) = RCT(84)
! B(119) = dA(85)/dV(10)
  B(119) = RCT(85)
! B(120) = dA(86)/dV(9)
  B(120) = RCT(86)
! B(121) = dA(87)/dV(8)
  B(121) = RCT(87)
! B(122) = dA(88)/dV(29)
  B(122) = RCT(88)
! B(123) = dA(89)/dV(15)
  B(123) = RCT(89)
! B(124) = dA(90)/dV(21)
  B(124) = RCT(90)
! B(125) = dA(91)/dV(20)
  B(125) = RCT(91)
! B(126) = dA(92)/dV(12)
  B(126) = RCT(92)
! B(127) = dA(93)/dV(11)
  B(127) = RCT(93)
! B(128) = dA(94)/dV(28)
  B(128) = RCT(94)

! Construct the Jacobian terms from B's
! JVS(1) = Jac_FULL(1,1)
  JVS(1) = -B(83)
! JVS(2) = Jac_FULL(2,2)
  JVS(2) = 0
! JVS(3) = Jac_FULL(2,8)
  JVS(3) = B(99)
! JVS(4) = Jac_FULL(2,9)
  JVS(4) = B(98)
! JVS(5) = Jac_FULL(2,10)
  JVS(5) = B(100)
! JVS(6) = Jac_FULL(2,11)
  JVS(6) = B(105)
! JVS(7) = Jac_FULL(2,12)
  JVS(7) = B(104)
! JVS(8) = Jac_FULL(2,13)
  JVS(8) = B(93)
! JVS(9) = Jac_FULL(2,14)
  JVS(9) = B(92)
! JVS(10) = Jac_FULL(2,15)
  JVS(10) = B(101)
! JVS(11) = Jac_FULL(2,16)
  JVS(11) = B(89)
! JVS(12) = Jac_FULL(2,17)
  JVS(12) = B(95)
! JVS(13) = Jac_FULL(2,18)
  JVS(13) = B(94)
! JVS(14) = Jac_FULL(2,20)
  JVS(14) = B(103)
! JVS(15) = Jac_FULL(2,21)
  JVS(15) = B(102)
! JVS(16) = Jac_FULL(2,23)
  JVS(16) = B(90)
! JVS(17) = Jac_FULL(2,25)
  JVS(17) = B(96)
! JVS(18) = Jac_FULL(2,26)
  JVS(18) = B(97)
! JVS(19) = Jac_FULL(2,31)
  JVS(19) = B(91)
! JVS(20) = Jac_FULL(3,3)
  JVS(20) = 0
! JVS(21) = Jac_FULL(3,30)
  JVS(21) = B(1)+B(26)+B(50)
! JVS(22) = Jac_FULL(4,4)
  JVS(22) = 0
! JVS(23) = Jac_FULL(4,13)
  JVS(23) = B(115)
! JVS(24) = Jac_FULL(4,14)
  JVS(24) = B(114)
! JVS(25) = Jac_FULL(4,18)
  JVS(25) = 0.4*B(113)
! JVS(26) = Jac_FULL(4,20)
  JVS(26) = B(125)
! JVS(27) = Jac_FULL(4,21)
  JVS(27) = 0.67*B(124)
! JVS(28) = Jac_FULL(4,23)
  JVS(28) = 0.67*B(111)
! JVS(29) = Jac_FULL(4,25)
  JVS(29) = 0.67*B(117)
! JVS(30) = Jac_FULL(4,26)
  JVS(30) = 0.49*B(118)
! JVS(31) = Jac_FULL(4,27)
  JVS(31) = B(28)+B(30)
! JVS(32) = Jac_FULL(4,28)
  JVS(32) = B(128)
! JVS(33) = Jac_FULL(4,29)
  JVS(33) = B(52)+B(122)
! JVS(34) = Jac_FULL(4,31)
  JVS(34) = 0.49*B(112)
! JVS(35) = Jac_FULL(4,32)
  JVS(35) = B(3)+B(4)+B(6)+B(109)
! JVS(36) = Jac_FULL(5,5)
  JVS(36) = 0
! JVS(37) = Jac_FULL(5,29)
  JVS(37) = B(61)
! JVS(38) = Jac_FULL(5,30)
  JVS(38) = B(1)
! JVS(39) = Jac_FULL(6,6)
  JVS(39) = 0
! JVS(40) = Jac_FULL(6,26)
  JVS(40) = 0.35*B(118)
! JVS(41) = Jac_FULL(6,30)
  JVS(41) = B(50)
! JVS(42) = Jac_FULL(6,31)
  JVS(42) = 0.35*B(112)
! JVS(43) = Jac_FULL(7,7)
  JVS(43) = 0
! JVS(44) = Jac_FULL(7,30)
  JVS(44) = B(26)
! JVS(45) = Jac_FULL(8,8)
  JVS(45) = -B(81)-B(99)-B(121)
! JVS(46) = Jac_FULL(8,27)
  JVS(46) = B(36)
! JVS(47) = Jac_FULL(9,9)
  JVS(47) = -B(80)-B(98)-B(120)
! JVS(48) = Jac_FULL(9,27)
  JVS(48) = B(38)
! JVS(49) = Jac_FULL(10,10)
  JVS(49) = -B(82)-B(100)-B(119)
! JVS(50) = Jac_FULL(10,27)
  JVS(50) = B(40)
! JVS(51) = Jac_FULL(11,11)
  JVS(51) = -B(88)-B(105)-B(127)
! JVS(52) = Jac_FULL(11,29)
  JVS(52) = B(57)
! JVS(53) = Jac_FULL(12,12)
  JVS(53) = -B(87)-B(104)-B(126)
! JVS(54) = Jac_FULL(12,29)
  JVS(54) = B(59)
! JVS(55) = Jac_FULL(13,13)
  JVS(55) = -B(75)-B(93)-B(115)
! JVS(56) = Jac_FULL(13,32)
  JVS(56) = B(12)
! JVS(57) = Jac_FULL(14,14)
  JVS(57) = -B(74)-B(92)-B(114)
! JVS(58) = Jac_FULL(14,32)
  JVS(58) = B(14)
! JVS(59) = Jac_FULL(15,15)
  JVS(59) = -B(84)-B(101)-B(123)
! JVS(60) = Jac_FULL(15,29)
  JVS(60) = B(53)
! JVS(61) = Jac_FULL(16,16)
  JVS(61) = -B(71)-B(89)-B(110)
! JVS(62) = Jac_FULL(16,32)
  JVS(62) = B(8)
! JVS(63) = Jac_FULL(17,17)
  JVS(63) = -B(77)-B(95)-B(116)
! JVS(64) = Jac_FULL(17,27)
  JVS(64) = B(32)
! JVS(65) = Jac_FULL(18,18)
  JVS(65) = -B(76)-B(94)-B(113)
! JVS(66) = Jac_FULL(18,32)
  JVS(66) = B(18)
! JVS(67) = Jac_FULL(19,15)
  JVS(67) = 0.9*B(123)
! JVS(68) = Jac_FULL(19,19)
  JVS(68) = -B(67)-B(69)
! JVS(69) = Jac_FULL(19,21)
  JVS(69) = 0.25*B(124)
! JVS(70) = Jac_FULL(19,29)
  JVS(70) = B(65)
! JVS(71) = Jac_FULL(20,19)
  JVS(71) = B(67)
! JVS(72) = Jac_FULL(20,20)
  JVS(72) = -B(86)-B(103)-B(125)
! JVS(73) = Jac_FULL(20,21)
  JVS(73) = 0.01*B(124)
! JVS(74) = Jac_FULL(20,29)
  JVS(74) = B(63)
! JVS(75) = Jac_FULL(21,21)
  JVS(75) = -B(85)-B(102)-B(124)
! JVS(76) = Jac_FULL(21,29)
  JVS(76) = B(55)
! JVS(77) = Jac_FULL(22,16)
  JVS(77) = 0.9*B(110)
! JVS(78) = Jac_FULL(22,22)
  JVS(78) = -B(20)-B(22)
! JVS(79) = Jac_FULL(22,23)
  JVS(79) = 0.25*B(111)
! JVS(80) = Jac_FULL(22,32)
  JVS(80) = B(24)
! JVS(81) = Jac_FULL(23,23)
  JVS(81) = -B(72)-B(90)-B(111)
! JVS(82) = Jac_FULL(23,32)
  JVS(82) = B(10)
! JVS(83) = Jac_FULL(24,17)
  JVS(83) = 0.9*B(116)
! JVS(84) = Jac_FULL(24,24)
  JVS(84) = -B(46)-B(48)
! JVS(85) = Jac_FULL(24,25)
  JVS(85) = 0.25*B(117)
! JVS(86) = Jac_FULL(24,27)
  JVS(86) = B(44)
! JVS(87) = Jac_FULL(25,25)
  JVS(87) = -B(78)-B(96)-B(117)
! JVS(88) = Jac_FULL(25,27)
  JVS(88) = B(34)
! JVS(89) = Jac_FULL(26,24)
  JVS(89) = B(46)
! JVS(90) = Jac_FULL(26,25)
  JVS(90) = 0.01*B(117)
! JVS(91) = Jac_FULL(26,26)
  JVS(91) = -B(79)-B(97)-0.99*B(118)
! JVS(92) = Jac_FULL(26,27)
  JVS(92) = B(42)
! JVS(93) = Jac_FULL(27,8)
  JVS(93) = B(121)
! JVS(94) = Jac_FULL(27,9)
  JVS(94) = B(120)
! JVS(95) = Jac_FULL(27,10)
  JVS(95) = B(119)
! JVS(96) = Jac_FULL(27,17)
  JVS(96) = 0.1*B(116)
! JVS(97) = Jac_FULL(27,24)
  JVS(97) = B(48)
! JVS(98) = Jac_FULL(27,25)
  JVS(98) = 0.07*B(117)
! JVS(99) = Jac_FULL(27,26)
  JVS(99) = 0.15*B(118)
! JVS(100) = Jac_FULL(27,27)
  JVS(100) = -B(28)-B(30)-B(32)-B(34)-B(36)-B(38)-B(40)-B(42)-B(44)
! JVS(101) = Jac_FULL(27,30)
  JVS(101) = B(26)
! JVS(102) = Jac_FULL(28,1)
  JVS(102) = B(83)
! JVS(103) = Jac_FULL(28,8)
  JVS(103) = B(81)
! JVS(104) = Jac_FULL(28,9)
  JVS(104) = B(80)
! JVS(105) = Jac_FULL(28,10)
  JVS(105) = B(82)
! JVS(106) = Jac_FULL(28,11)
  JVS(106) = B(88)
! JVS(107) = Jac_FULL(28,12)
  JVS(107) = B(87)
! JVS(108) = Jac_FULL(28,13)
  JVS(108) = B(75)
! JVS(109) = Jac_FULL(28,14)
  JVS(109) = B(74)
! JVS(110) = Jac_FULL(28,15)
  JVS(110) = B(84)
! JVS(111) = Jac_FULL(28,16)
  JVS(111) = B(71)
! JVS(112) = Jac_FULL(28,17)
  JVS(112) = B(77)
! JVS(113) = Jac_FULL(28,18)
  JVS(113) = B(76)
! JVS(114) = Jac_FULL(28,20)
  JVS(114) = B(86)
! JVS(115) = Jac_FULL(28,21)
  JVS(115) = B(85)
! JVS(116) = Jac_FULL(28,23)
  JVS(116) = B(72)
! JVS(117) = Jac_FULL(28,25)
  JVS(117) = B(78)
! JVS(118) = Jac_FULL(28,26)
  JVS(118) = B(79)
! JVS(119) = Jac_FULL(28,27)
  JVS(119) = 0
! JVS(120) = Jac_FULL(28,28)
  JVS(120) = -B(128)
! JVS(121) = Jac_FULL(28,29)
  JVS(121) = 0
! JVS(122) = Jac_FULL(28,30)
  JVS(122) = 0
! JVS(123) = Jac_FULL(28,31)
  JVS(123) = B(73)
! JVS(124) = Jac_FULL(28,32)
  JVS(124) = 0
! JVS(125) = Jac_FULL(29,11)
  JVS(125) = B(127)
! JVS(126) = Jac_FULL(29,12)
  JVS(126) = B(126)
! JVS(127) = Jac_FULL(29,15)
  JVS(127) = 0.1*B(123)
! JVS(128) = Jac_FULL(29,19)
  JVS(128) = B(69)
! JVS(129) = Jac_FULL(29,21)
  JVS(129) = 0.07*B(124)
! JVS(130) = Jac_FULL(29,26)
  JVS(130) = 0.35*B(118)
! JVS(131) = Jac_FULL(29,27)
  JVS(131) = 0
! JVS(132) = Jac_FULL(29,29)
  JVS(132) = -B(52)-B(53)-B(55)-B(57)-B(59)-B(61)-B(63)-B(65)-B(122)
! JVS(133) = Jac_FULL(29,30)
  JVS(133) = B(50)
! JVS(134) = Jac_FULL(29,31)
  JVS(134) = 0.35*B(112)
! JVS(135) = Jac_FULL(30,13)
  JVS(135) = B(115)
! JVS(136) = Jac_FULL(30,14)
  JVS(136) = B(114)
! JVS(137) = Jac_FULL(30,18)
  JVS(137) = 0.4*B(113)
! JVS(138) = Jac_FULL(30,20)
  JVS(138) = B(125)
! JVS(139) = Jac_FULL(30,21)
  JVS(139) = 0.67*B(124)
! JVS(140) = Jac_FULL(30,23)
  JVS(140) = 0.67*B(111)
! JVS(141) = Jac_FULL(30,25)
  JVS(141) = 0.67*B(117)
! JVS(142) = Jac_FULL(30,26)
  JVS(142) = 0.49*B(118)
! JVS(143) = Jac_FULL(30,27)
  JVS(143) = B(28)+B(30)
! JVS(144) = Jac_FULL(30,28)
  JVS(144) = B(128)
! JVS(145) = Jac_FULL(30,29)
  JVS(145) = B(52)+B(122)
! JVS(146) = Jac_FULL(30,30)
  JVS(146) = -B(1)-B(26)-B(50)
! JVS(147) = Jac_FULL(30,31)
  JVS(147) = 0.49*B(112)
! JVS(148) = Jac_FULL(30,32)
  JVS(148) = B(3)+B(4)+B(6)+B(109)
! JVS(149) = Jac_FULL(31,22)
  JVS(149) = B(20)
! JVS(150) = Jac_FULL(31,23)
  JVS(150) = 0.01*B(111)
! JVS(151) = Jac_FULL(31,29)
  JVS(151) = B(61)
! JVS(152) = Jac_FULL(31,30)
  JVS(152) = 0
! JVS(153) = Jac_FULL(31,31)
  JVS(153) = -B(73)-B(91)-0.99*B(112)
! JVS(154) = Jac_FULL(31,32)
  JVS(154) = B(16)
! JVS(155) = Jac_FULL(32,16)
  JVS(155) = 0.1*B(110)
! JVS(156) = Jac_FULL(32,18)
  JVS(156) = 0.6*B(113)
! JVS(157) = Jac_FULL(32,22)
  JVS(157) = B(22)
! JVS(158) = Jac_FULL(32,23)
  JVS(158) = 0.07*B(111)
! JVS(159) = Jac_FULL(32,30)
  JVS(159) = B(1)
! JVS(160) = Jac_FULL(32,31)
  JVS(160) = 0.15*B(112)
! JVS(161) = Jac_FULL(32,32)
  JVS(161) = -B(3)-B(4)-B(6)-B(8)-B(10)-B(12)-B(14)-B(16)-B(18)-B(24)-B(109)
      
END SUBROUTINE Jac_SP

! End of Jac_SP function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Jac_SP_Vec - function for sparse multiplication: sparse Jacobian times vector
!   Arguments :
!      JVS       - sparse Jacobian of variables
!      UV        - User vector for variables
!      JUV       - Jacobian times user vector
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE Jac_SP_Vec ( JVS, UV, JUV )

! JVS - sparse Jacobian of variables
  REAL(kind=dp) :: JVS(LU_NONZERO)
! UV - User vector for variables
  REAL(kind=dp) :: UV(NVAR)
! JUV - Jacobian times user vector
  REAL(kind=dp) :: JUV(NVAR)

  JUV(1) = JVS(1)*UV(1)
  JUV(2) = JVS(2)*UV(2)+JVS(3)*UV(8)+JVS(4)*UV(9)+JVS(5)*UV(10)+JVS(6)*UV(11)+JVS(7)*UV(12)+JVS(8)*UV(13)+JVS(9)*UV(14)&
             &+JVS(10)*UV(15)+JVS(11)*UV(16)+JVS(12)*UV(17)+JVS(13)*UV(18)+JVS(14)*UV(20)+JVS(15)*UV(21)+JVS(16)*UV(23)&
             &+JVS(17)*UV(25)+JVS(18)*UV(26)+JVS(19)*UV(31)
  JUV(3) = JVS(20)*UV(3)+JVS(21)*UV(30)
  JUV(4) = JVS(22)*UV(4)+JVS(23)*UV(13)+JVS(24)*UV(14)+JVS(25)*UV(18)+JVS(26)*UV(20)+JVS(27)*UV(21)+JVS(28)*UV(23)&
             &+JVS(29)*UV(25)+JVS(30)*UV(26)+JVS(31)*UV(27)+JVS(32)*UV(28)+JVS(33)*UV(29)+JVS(34)*UV(31)+JVS(35)*UV(32)
  JUV(5) = JVS(36)*UV(5)+JVS(37)*UV(29)+JVS(38)*UV(30)
  JUV(6) = JVS(39)*UV(6)+JVS(40)*UV(26)+JVS(41)*UV(30)+JVS(42)*UV(31)
  JUV(7) = JVS(43)*UV(7)+JVS(44)*UV(30)
  JUV(8) = JVS(45)*UV(8)+JVS(46)*UV(27)
  JUV(9) = JVS(47)*UV(9)+JVS(48)*UV(27)
  JUV(10) = JVS(49)*UV(10)+JVS(50)*UV(27)
  JUV(11) = JVS(51)*UV(11)+JVS(52)*UV(29)
  JUV(12) = JVS(53)*UV(12)+JVS(54)*UV(29)
  JUV(13) = JVS(55)*UV(13)+JVS(56)*UV(32)
  JUV(14) = JVS(57)*UV(14)+JVS(58)*UV(32)
  JUV(15) = JVS(59)*UV(15)+JVS(60)*UV(29)
  JUV(16) = JVS(61)*UV(16)+JVS(62)*UV(32)
  JUV(17) = JVS(63)*UV(17)+JVS(64)*UV(27)
  JUV(18) = JVS(65)*UV(18)+JVS(66)*UV(32)
  JUV(19) = JVS(67)*UV(15)+JVS(68)*UV(19)+JVS(69)*UV(21)+JVS(70)*UV(29)
  JUV(20) = JVS(71)*UV(19)+JVS(72)*UV(20)+JVS(73)*UV(21)+JVS(74)*UV(29)
  JUV(21) = JVS(75)*UV(21)+JVS(76)*UV(29)
  JUV(22) = JVS(77)*UV(16)+JVS(78)*UV(22)+JVS(79)*UV(23)+JVS(80)*UV(32)
  JUV(23) = JVS(81)*UV(23)+JVS(82)*UV(32)
  JUV(24) = JVS(83)*UV(17)+JVS(84)*UV(24)+JVS(85)*UV(25)+JVS(86)*UV(27)
  JUV(25) = JVS(87)*UV(25)+JVS(88)*UV(27)
  JUV(26) = JVS(89)*UV(24)+JVS(90)*UV(25)+JVS(91)*UV(26)+JVS(92)*UV(27)
  JUV(27) = JVS(93)*UV(8)+JVS(94)*UV(9)+JVS(95)*UV(10)+JVS(96)*UV(17)+JVS(97)*UV(24)+JVS(98)*UV(25)+JVS(99)*UV(26)&
              &+JVS(100)*UV(27)+JVS(101)*UV(30)
  JUV(28) = JVS(102)*UV(1)+JVS(103)*UV(8)+JVS(104)*UV(9)+JVS(105)*UV(10)+JVS(106)*UV(11)+JVS(107)*UV(12)+JVS(108)*UV(13)&
              &+JVS(109)*UV(14)+JVS(110)*UV(15)+JVS(111)*UV(16)+JVS(112)*UV(17)+JVS(113)*UV(18)+JVS(114)*UV(20)+JVS(115)&
              &*UV(21)+JVS(116)*UV(23)+JVS(117)*UV(25)+JVS(118)*UV(26)+JVS(120)*UV(28)+JVS(123)*UV(31)
  JUV(29) = JVS(125)*UV(11)+JVS(126)*UV(12)+JVS(127)*UV(15)+JVS(128)*UV(19)+JVS(129)*UV(21)+JVS(130)*UV(26)+JVS(132)&
              &*UV(29)+JVS(133)*UV(30)+JVS(134)*UV(31)
  JUV(30) = JVS(135)*UV(13)+JVS(136)*UV(14)+JVS(137)*UV(18)+JVS(138)*UV(20)+JVS(139)*UV(21)+JVS(140)*UV(23)+JVS(141)&
              &*UV(25)+JVS(142)*UV(26)+JVS(143)*UV(27)+JVS(144)*UV(28)+JVS(145)*UV(29)+JVS(146)*UV(30)+JVS(147)*UV(31)&
              &+JVS(148)*UV(32)
  JUV(31) = JVS(149)*UV(22)+JVS(150)*UV(23)+JVS(151)*UV(29)+JVS(153)*UV(31)+JVS(154)*UV(32)
  JUV(32) = JVS(155)*UV(16)+JVS(156)*UV(18)+JVS(157)*UV(22)+JVS(158)*UV(23)+JVS(159)*UV(30)+JVS(160)*UV(31)+JVS(161)&
              &*UV(32)
      
END SUBROUTINE Jac_SP_Vec

! End of Jac_SP_Vec function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! JacTR_SP_Vec - sparse multiplication: sparse Jacobian transposed times vector
!   Arguments :
!      JVS       - sparse Jacobian of variables
!      UV        - User vector for variables
!      JTUV      - Jacobian transposed times user vector
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE JacTR_SP_Vec ( JVS, UV, JTUV )

! JVS - sparse Jacobian of variables
  REAL(kind=dp) :: JVS(LU_NONZERO)
! UV - User vector for variables
  REAL(kind=dp) :: UV(NVAR)
! JTUV - Jacobian transposed times user vector
  REAL(kind=dp) :: JTUV(NVAR)

  JTUV(1) = JVS(1)*UV(1)+JVS(102)*UV(28)
  JTUV(2) = JVS(2)*UV(2)
  JTUV(3) = JVS(20)*UV(3)
  JTUV(4) = JVS(22)*UV(4)
  JTUV(5) = JVS(36)*UV(5)
  JTUV(6) = JVS(39)*UV(6)
  JTUV(7) = JVS(43)*UV(7)
  JTUV(8) = JVS(3)*UV(2)+JVS(45)*UV(8)+JVS(93)*UV(27)+JVS(103)*UV(28)
  JTUV(9) = JVS(4)*UV(2)+JVS(47)*UV(9)+JVS(94)*UV(27)+JVS(104)*UV(28)
  JTUV(10) = JVS(5)*UV(2)+JVS(49)*UV(10)+JVS(95)*UV(27)+JVS(105)*UV(28)
  JTUV(11) = JVS(6)*UV(2)+JVS(51)*UV(11)+JVS(106)*UV(28)+JVS(125)*UV(29)
  JTUV(12) = JVS(7)*UV(2)+JVS(53)*UV(12)+JVS(107)*UV(28)+JVS(126)*UV(29)
  JTUV(13) = JVS(8)*UV(2)+JVS(23)*UV(4)+JVS(55)*UV(13)+JVS(108)*UV(28)+JVS(135)*UV(30)
  JTUV(14) = JVS(9)*UV(2)+JVS(24)*UV(4)+JVS(57)*UV(14)+JVS(109)*UV(28)+JVS(136)*UV(30)
  JTUV(15) = JVS(10)*UV(2)+JVS(59)*UV(15)+JVS(67)*UV(19)+JVS(110)*UV(28)+JVS(127)*UV(29)
  JTUV(16) = JVS(11)*UV(2)+JVS(61)*UV(16)+JVS(77)*UV(22)+JVS(111)*UV(28)+JVS(155)*UV(32)
  JTUV(17) = JVS(12)*UV(2)+JVS(63)*UV(17)+JVS(83)*UV(24)+JVS(96)*UV(27)+JVS(112)*UV(28)
  JTUV(18) = JVS(13)*UV(2)+JVS(25)*UV(4)+JVS(65)*UV(18)+JVS(113)*UV(28)+JVS(137)*UV(30)+JVS(156)*UV(32)
  JTUV(19) = JVS(68)*UV(19)+JVS(71)*UV(20)+JVS(128)*UV(29)
  JTUV(20) = JVS(14)*UV(2)+JVS(26)*UV(4)+JVS(72)*UV(20)+JVS(114)*UV(28)+JVS(138)*UV(30)
  JTUV(21) = JVS(15)*UV(2)+JVS(27)*UV(4)+JVS(69)*UV(19)+JVS(73)*UV(20)+JVS(75)*UV(21)+JVS(115)*UV(28)+JVS(129)*UV(29)&
               &+JVS(139)*UV(30)
  JTUV(22) = JVS(78)*UV(22)+JVS(149)*UV(31)+JVS(157)*UV(32)
  JTUV(23) = JVS(16)*UV(2)+JVS(28)*UV(4)+JVS(79)*UV(22)+JVS(81)*UV(23)+JVS(116)*UV(28)+JVS(140)*UV(30)+JVS(150)*UV(31)&
               &+JVS(158)*UV(32)
  JTUV(24) = JVS(84)*UV(24)+JVS(89)*UV(26)+JVS(97)*UV(27)
  JTUV(25) = JVS(17)*UV(2)+JVS(29)*UV(4)+JVS(85)*UV(24)+JVS(87)*UV(25)+JVS(90)*UV(26)+JVS(98)*UV(27)+JVS(117)*UV(28)&
               &+JVS(141)*UV(30)
  JTUV(26) = JVS(18)*UV(2)+JVS(30)*UV(4)+JVS(40)*UV(6)+JVS(91)*UV(26)+JVS(99)*UV(27)+JVS(118)*UV(28)+JVS(130)*UV(29)&
               &+JVS(142)*UV(30)
  JTUV(27) = JVS(31)*UV(4)+JVS(46)*UV(8)+JVS(48)*UV(9)+JVS(50)*UV(10)+JVS(64)*UV(17)+JVS(86)*UV(24)+JVS(88)*UV(25)&
               &+JVS(92)*UV(26)+JVS(100)*UV(27)+JVS(143)*UV(30)
  JTUV(28) = JVS(32)*UV(4)+JVS(120)*UV(28)+JVS(144)*UV(30)
  JTUV(29) = JVS(33)*UV(4)+JVS(37)*UV(5)+JVS(52)*UV(11)+JVS(54)*UV(12)+JVS(60)*UV(15)+JVS(70)*UV(19)+JVS(74)*UV(20)&
               &+JVS(76)*UV(21)+JVS(132)*UV(29)+JVS(145)*UV(30)+JVS(151)*UV(31)
  JTUV(30) = JVS(21)*UV(3)+JVS(38)*UV(5)+JVS(41)*UV(6)+JVS(44)*UV(7)+JVS(101)*UV(27)+JVS(133)*UV(29)+JVS(146)*UV(30)&
               &+JVS(159)*UV(32)
  JTUV(31) = JVS(19)*UV(2)+JVS(34)*UV(4)+JVS(42)*UV(6)+JVS(123)*UV(28)+JVS(134)*UV(29)+JVS(147)*UV(30)+JVS(153)*UV(31)&
               &+JVS(160)*UV(32)
  JTUV(32) = JVS(35)*UV(4)+JVS(56)*UV(13)+JVS(58)*UV(14)+JVS(62)*UV(16)+JVS(66)*UV(18)+JVS(80)*UV(22)+JVS(82)*UV(23)&
               &+JVS(148)*UV(30)+JVS(154)*UV(31)+JVS(161)*UV(32)
      
END SUBROUTINE JacTR_SP_Vec

! End of JacTR_SP_Vec function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



END MODULE gckpp_Jacobian

