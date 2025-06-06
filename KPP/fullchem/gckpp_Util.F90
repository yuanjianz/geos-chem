! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
! Auxiliary Routines File
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
! File                 : gckpp_Util.F90
! Equation file        : gckpp.kpp
! Output root filename : gckpp
!
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



MODULE gckpp_Util

  USE gckpp_Parameters
  IMPLICIT NONE

CONTAINS



! Begin inlined code from F90_UTIL

! End inlined code from F90_UTIL

! Begin Utility Functions from KPP_HOME/util/util
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
! UTIL - Utility functions
!   Arguments :
!
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

! ****************************************************************
!
! InitSaveData - Opens the data file for writing
!   Parameters :
!
! ****************************************************************

      SUBROUTINE InitSaveData ()

      USE gckpp_Parameters

      open(10, file='gckpp.dat')

      END SUBROUTINE InitSaveData

! End of InitSaveData function
! ****************************************************************

! ****************************************************************
!
! SaveData - Write LOOKAT species in the data file
!   Parameters :
!
! ****************************************************************

      SUBROUTINE SaveData ()

      USE gckpp_Global
      USE gckpp_Monitor

      INTEGER i

      WRITE(10,999) (TIME-TSTART)/3600.D0,  &
      (C(LOOKAT(i))/CFACTOR, i=1,NLOOKAT)
 999  FORMAT(E24.16,100(1X,E24.16))

      END SUBROUTINE SaveData

! End of SaveData function
! ****************************************************************

! ****************************************************************
!
! CloseSaveData - Close the data file
!   Parameters :
!
! ****************************************************************

      SUBROUTINE CloseSaveData ()

      USE gckpp_Parameters

      CLOSE(10)

      END SUBROUTINE CloseSaveData

! End of CloseSaveData function
! ****************************************************************

! ****************************************************************
!
! GenerateMatlab - Generates MATLAB file to load the data file
!   Parameters :
!                It will have a character string to prefix each
!                species name with.
!
! ****************************************************************

      SUBROUTINE GenerateMatlab ( PREFIX )

      USE gckpp_Parameters
      USE gckpp_Global
      USE gckpp_Monitor


      CHARACTER(LEN=8) PREFIX
      INTEGER i

      open(20, file='gckpp.m')
      write(20,*) 'load gckpp.dat;'
      write(20,990) PREFIX
990   FORMAT(A1,'c = gckpp;')
      write(20,*) 'clear gckpp;'
      write(20,991) PREFIX, PREFIX
991   FORMAT(A1,'t=',A1,'c(:,1);')
      write(20,992) PREFIX
992   FORMAT(A1,'c(:,1)=[];')

      do i=1,NLOOKAT
        write(20,993) PREFIX, SPC_NAMES(LOOKAT(i)), PREFIX, i
993     FORMAT(A1,A6,' = ',A1,'c(:,',I2,');')
      end do

      CLOSE(20)

      END SUBROUTINE GenerateMatlab

! End of GenerateMatlab function
! ****************************************************************


! ****************************************************************
!
! Integrator_Update_Options - determine whether to call Update_RCONST,
!    Update_PHOTO, and Update_SUN from within the integrator
!
!   Parameters:
!    option (input)
!        = -1 :  Do not call Update_* functions within the integrator
!        =  0 :  Status quo: Call whichever functions are normally called
!        =  1 :  Call Update_RCONST from within the integrator
!        =  2 :  Call Update_PHOTO from within the integrator
!        =  3 :  Call Update_RCONST and Update_PHOTO from within the int.
!        =  4 :  Call Update_SUN from within the integrator
!        =  5 :  Call Update_SUN and Update_RCONST from within the int.
!        =  6 :  not implemented
!        =  7 :  not implemented
!
!    Do_Update_RCONST (output):
!        =T : Calls Update_RCONST from within the integrator
!        =F : Does not call UPDATE_RCONST from w/in the int.
!
!    Do_Update_PHOTO (output):
!        =T : Calls Update_PHOTO from within the integrator
!        =F : Does not call UPDATE_PHOTO from w/in the int.
!
!    Do_Update_SUN (output):
!        =T : Calls Update_SUN from within the integrator
!        =F : Does not call UPDATE_SUN from w/in the int.
!
! ****************************************************************

      SUBROUTINE Integrator_Update_Options( option,            &
                                            Do_Update_RConst,  &
                                            Do_Update_Photo,   &
                                            Do_Update_Sun     )

      !~~~> Input variables
      INTEGER, INTENT(IN)  :: option

      !~~~> Output variables
      LOGICAL, INTENT(OUT) :: Do_Update_RCONST
      LOGICAL, INTENT(OUT) :: Do_Update_PHOTO
      LOGICAL, INTENT(OUT) :: Do_Update_SUN

      ! Option -1: turn off all Update_* calls within the integrator
      IF ( option == -1 ) THEN
         Do_Update_RCONST = .FALSE.
         Do_Update_PHOTO  = .FALSE.
         Do_Update_SUN    = .FALSE.
         RETURN
      ENDIF

      ! Otherwise determine from the value passed
      Do_Update_RCONST = ( IAND( option, 1 ) > 0 )
      Do_Update_PHOTO  = ( IAND( option, 2 ) > 0 )
      Do_Update_SUN    = ( IAND( option, 4 ) > 0 )

      END SUBROUTINE Integrator_Update_Options

! End of Integrator_Update_Options function
! ****************************************************************
! End Utility Functions from KPP_HOME/util/util
! End of UTIL function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
! Shuffle_user2kpp - function to copy concentrations from USER to KPP
!   Arguments :
!      V_USER    - Concentration of variable species in USER's order
!      V         - Concentrations of variable species (local)
!
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE Shuffle_user2kpp ( V_USER, V )

! V_USER - Concentration of variable species in USER's order
  REAL(kind=dp) :: V_USER(NVAR)
! V - Concentrations of variable species (local)
  REAL(kind=dp) :: V(NVAR)

  V(321) = V_USER(1)
  V(233) = V_USER(2)
  V(132) = V_USER(3)
  V(197) = V_USER(4)
  V(295) = V_USER(5)
  V(283) = V_USER(6)
  V(4) = V_USER(7)
  V(326) = V_USER(8)
  V(142) = V_USER(9)
  V(249) = V_USER(10)
  V(279) = V_USER(11)
  V(300) = V_USER(12)
  V(102) = V_USER(13)
  V(69) = V_USER(14)
  V(5) = V_USER(15)
  V(126) = V_USER(16)
  V(146) = V_USER(17)
  V(263) = V_USER(18)
  V(221) = V_USER(19)
  V(201) = V_USER(20)
  V(122) = V_USER(21)
  V(240) = V_USER(22)
  V(313) = V_USER(23)
  V(244) = V_USER(24)
  V(323) = V_USER(25)
  V(204) = V_USER(26)
  V(143) = V_USER(27)
  V(203) = V_USER(28)
  V(236) = V_USER(29)
  V(117) = V_USER(30)
  V(342) = V_USER(31)
  V(148) = V_USER(32)
  V(157) = V_USER(33)
  V(59) = V_USER(34)
  V(218) = V_USER(35)
  V(347) = V_USER(36)
  V(13) = V_USER(37)
  V(349) = V_USER(38)
  V(350) = V_USER(39)
  V(6) = V_USER(40)
  V(127) = V_USER(41)
  V(212) = V_USER(42)
  V(235) = V_USER(43)
  V(71) = V_USER(44)
  V(90) = V_USER(45)
  V(60) = V_USER(46)
  V(109) = V_USER(47)
  V(183) = V_USER(48)
  V(141) = V_USER(49)
  V(140) = V_USER(50)
  V(171) = V_USER(51)
  V(172) = V_USER(52)
  V(46) = V_USER(53)
  V(47) = V_USER(54)
  V(48) = V_USER(55)
  V(49) = V_USER(56)
  V(50) = V_USER(57)
  V(51) = V_USER(58)
  V(78) = V_USER(59)
  V(79) = V_USER(60)
  V(1) = V_USER(61)
  V(2) = V_USER(62)
  V(3) = V_USER(63)
  V(325) = V_USER(64)
  V(312) = V_USER(65)
  V(105) = V_USER(66)
  V(43) = V_USER(67)
  V(241) = V_USER(68)
  V(181) = V_USER(69)
  V(52) = V_USER(70)
  V(228) = V_USER(71)
  V(81) = V_USER(72)
  V(75) = V_USER(73)
  V(340) = V_USER(74)
  V(245) = V_USER(75)
  V(76) = V_USER(76)
  V(297) = V_USER(77)
  V(317) = V_USER(78)
  V(338) = V_USER(79)
  V(110) = V_USER(80)
  V(329) = V_USER(81)
  V(7) = V_USER(82)
  V(158) = V_USER(83)
  V(94) = V_USER(84)
  V(149) = V_USER(85)
  V(156) = V_USER(86)
  V(261) = V_USER(87)
  V(70) = V_USER(88)
  V(136) = V_USER(89)
  V(83) = V_USER(90)
  V(106) = V_USER(91)
  V(234) = V_USER(92)
  V(296) = V_USER(93)
  V(118) = V_USER(94)
  V(41) = V_USER(95)
  V(213) = V_USER(96)
  V(306) = V_USER(97)
  V(270) = V_USER(98)
  V(217) = V_USER(99)
  V(61) = V_USER(100)
  V(53) = V_USER(101)
  V(54) = V_USER(102)
  V(336) = V_USER(103)
  V(264) = V_USER(104)
  V(307) = V_USER(105)
  V(72) = V_USER(106)
  V(352) = V_USER(107)
  V(238) = V_USER(108)
  V(84) = V_USER(109)
  V(85) = V_USER(110)
  V(86) = V_USER(111)
  V(87) = V_USER(112)
  V(339) = V_USER(113)
  V(265) = V_USER(114)
  V(73) = V_USER(115)
  V(88) = V_USER(116)
  V(107) = V_USER(117)
  V(89) = V_USER(118)
  V(239) = V_USER(119)
  V(327) = V_USER(120)
  V(108) = V_USER(121)
  V(337) = V_USER(122)
  V(316) = V_USER(123)
  V(333) = V_USER(124)
  V(330) = V_USER(125)
  V(154) = V_USER(126)
  V(230) = V_USER(127)
  V(133) = V_USER(128)
  V(231) = V_USER(129)
  V(135) = V_USER(130)
  V(150) = V_USER(131)
  V(144) = V_USER(132)
  V(210) = V_USER(133)
  V(331) = V_USER(134)
  V(170) = V_USER(135)
  V(44) = V_USER(136)
  V(55) = V_USER(137)
  V(42) = V_USER(138)
  V(77) = V_USER(139)
  V(215) = V_USER(140)
  V(243) = V_USER(141)
  V(104) = V_USER(142)
  V(301) = V_USER(143)
  V(182) = V_USER(144)
  V(258) = V_USER(145)
  V(119) = V_USER(146)
  V(147) = V_USER(147)
  V(174) = V_USER(148)
  V(293) = V_USER(149)
  V(206) = V_USER(150)
  V(207) = V_USER(151)
  V(198) = V_USER(152)
  V(299) = V_USER(153)
  V(180) = V_USER(154)
  V(151) = V_USER(155)
  V(286) = V_USER(156)
  V(152) = V_USER(157)
  V(285) = V_USER(158)
  V(128) = V_USER(159)
  V(268) = V_USER(160)
  V(175) = V_USER(161)
  V(168) = V_USER(162)
  V(267) = V_USER(163)
  V(305) = V_USER(164)
  V(304) = V_USER(165)
  V(271) = V_USER(166)
  V(226) = V_USER(167)
  V(223) = V_USER(168)
  V(224) = V_USER(169)
  V(232) = V_USER(170)
  V(145) = V_USER(171)
  V(8) = V_USER(172)
  V(62) = V_USER(173)
  V(310) = V_USER(174)
  V(311) = V_USER(175)
  V(222) = V_USER(176)
  V(186) = V_USER(177)
  V(284) = V_USER(178)
  V(103) = V_USER(179)
  V(252) = V_USER(180)
  V(332) = V_USER(181)
  V(91) = V_USER(182)
  V(9) = V_USER(183)
  V(10) = V_USER(184)
  V(276) = V_USER(185)
  V(205) = V_USER(186)
  V(190) = V_USER(187)
  V(266) = V_USER(188)
  V(303) = V_USER(189)
  V(320) = V_USER(190)
  V(11) = V_USER(191)
  V(12) = V_USER(192)
  V(167) = V_USER(193)
  V(281) = V_USER(194)
  V(111) = V_USER(195)
  V(137) = V_USER(196)
  V(225) = V_USER(197)
  V(56) = V_USER(198)
  V(66) = V_USER(199)
  V(74) = V_USER(200)
  V(160) = V_USER(201)
  V(176) = V_USER(202)
  V(129) = V_USER(203)
  V(138) = V_USER(204)
  V(112) = V_USER(205)
  V(161) = V_USER(206)
  V(162) = V_USER(207)
  V(255) = V_USER(208)
  V(211) = V_USER(209)
  V(237) = V_USER(210)
  V(163) = V_USER(211)
  V(177) = V_USER(212)
  V(57) = V_USER(213)
  V(130) = V_USER(214)
  V(169) = V_USER(215)
  V(262) = V_USER(216)
  V(193) = V_USER(217)
  V(277) = V_USER(218)
  V(257) = V_USER(219)
  V(278) = V_USER(220)
  V(275) = V_USER(221)
  V(273) = V_USER(222)
  V(272) = V_USER(223)
  V(274) = V_USER(224)
  V(14) = V_USER(225)
  V(15) = V_USER(226)
  V(16) = V_USER(227)
  V(17) = V_USER(228)
  V(20) = V_USER(229)
  V(21) = V_USER(230)
  V(24) = V_USER(231)
  V(23) = V_USER(232)
  V(25) = V_USER(233)
  V(26) = V_USER(234)
  V(309) = V_USER(235)
  V(259) = V_USER(236)
  V(159) = V_USER(237)
  V(308) = V_USER(238)
  V(92) = V_USER(239)
  V(324) = V_USER(240)
  V(153) = V_USER(241)
  V(194) = V_USER(242)
  V(248) = V_USER(243)
  V(216) = V_USER(244)
  V(287) = V_USER(245)
  V(253) = V_USER(246)
  V(202) = V_USER(247)
  V(246) = V_USER(248)
  V(292) = V_USER(249)
  V(113) = V_USER(250)
  V(93) = V_USER(251)
  V(294) = V_USER(252)
  V(328) = V_USER(253)
  V(282) = V_USER(254)
  V(45) = V_USER(255)
  V(256) = V_USER(256)
  V(242) = V_USER(257)
  V(164) = V_USER(258)
  V(184) = V_USER(259)
  V(80) = V_USER(260)
  V(28) = V_USER(261)
  V(191) = V_USER(262)
  V(219) = V_USER(263)
  V(314) = V_USER(264)
  V(131) = V_USER(265)
  V(208) = V_USER(266)
  V(227) = V_USER(267)
  V(288) = V_USER(268)
  V(302) = V_USER(269)
  V(254) = V_USER(270)
  V(185) = V_USER(271)
  V(67) = V_USER(272)
  V(63) = V_USER(273)
  V(214) = V_USER(274)
  V(19) = V_USER(275)
  V(64) = V_USER(276)
  V(65) = V_USER(277)
  V(346) = V_USER(278)
  V(335) = V_USER(279)
  V(351) = V_USER(280)
  V(269) = V_USER(281)
  V(95) = V_USER(282)
  V(18) = V_USER(283)
  V(343) = V_USER(284)
  V(334) = V_USER(285)
  V(341) = V_USER(286)
  V(120) = V_USER(289)
  V(68) = V_USER(290)
  V(345) = V_USER(291)
  V(96) = V_USER(292)
  V(289) = V_USER(293)
  V(280) = V_USER(294)
  V(315) = V_USER(295)
  V(139) = V_USER(296)
  V(114) = V_USER(297)
  V(195) = V_USER(298)
  V(291) = V_USER(299)
  V(229) = V_USER(300)
  V(260) = V_USER(301)
  V(123) = V_USER(302)
  V(124) = V_USER(303)
  V(250) = V_USER(304)
  V(247) = V_USER(305)
  V(290) = V_USER(306)
  V(125) = V_USER(307)
  V(115) = V_USER(308)
  V(318) = V_USER(309)
  V(251) = V_USER(310)
  V(319) = V_USER(311)
  V(97) = V_USER(312)
  V(178) = V_USER(313)
  V(165) = V_USER(314)
  V(98) = V_USER(315)
  V(196) = V_USER(316)
  V(99) = V_USER(317)
  V(100) = V_USER(318)
  V(298) = V_USER(319)
  V(322) = V_USER(320)
  V(173) = V_USER(321)
  V(187) = V_USER(322)
  V(192) = V_USER(323)
  V(209) = V_USER(324)
  V(199) = V_USER(325)
  V(116) = V_USER(326)
  V(188) = V_USER(327)
  V(155) = V_USER(328)
  V(179) = V_USER(329)
  V(166) = V_USER(330)
  V(353) = V_USER(331)
  V(344) = V_USER(332)
  V(348) = V_USER(337)
  V(134) = V_USER(338)
  V(29) = V_USER(339)
  V(30) = V_USER(340)
  V(31) = V_USER(341)
  V(220) = V_USER(342)
  V(58) = V_USER(343)
  V(121) = V_USER(344)
  V(200) = V_USER(345)
  V(82) = V_USER(346)
  V(22) = V_USER(347)
  V(101) = V_USER(348)
  V(27) = V_USER(349)
  V(32) = V_USER(350)
  V(33) = V_USER(351)
  V(189) = V_USER(352)

END SUBROUTINE Shuffle_user2kpp

! End of Shuffle_user2kpp function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
! Shuffle_kpp2user - function to restore concentrations from KPP to USER
!   Arguments :
!      V         - Concentrations of variable species (local)
!      V_USER    - Concentration of variable species in USER's order
!
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE Shuffle_kpp2user ( V, V_USER )

! V - Concentrations of variable species (local)
  REAL(kind=dp) :: V(NVAR)
! V_USER - Concentration of variable species in USER's order
  REAL(kind=dp) :: V_USER(NVAR)

  V_USER(1) = V(321)
  V_USER(2) = V(233)
  V_USER(3) = V(132)
  V_USER(4) = V(197)
  V_USER(5) = V(295)
  V_USER(6) = V(283)
  V_USER(7) = V(4)
  V_USER(8) = V(326)
  V_USER(9) = V(142)
  V_USER(10) = V(249)
  V_USER(11) = V(279)
  V_USER(12) = V(300)
  V_USER(13) = V(102)
  V_USER(14) = V(69)
  V_USER(15) = V(5)
  V_USER(16) = V(126)
  V_USER(17) = V(146)
  V_USER(18) = V(263)
  V_USER(19) = V(221)
  V_USER(20) = V(201)
  V_USER(21) = V(122)
  V_USER(22) = V(240)
  V_USER(23) = V(313)
  V_USER(24) = V(244)
  V_USER(25) = V(323)
  V_USER(26) = V(204)
  V_USER(27) = V(143)
  V_USER(28) = V(203)
  V_USER(29) = V(236)
  V_USER(30) = V(117)
  V_USER(31) = V(342)
  V_USER(32) = V(148)
  V_USER(33) = V(157)
  V_USER(34) = V(59)
  V_USER(35) = V(218)
  V_USER(36) = V(347)
  V_USER(37) = V(13)
  V_USER(38) = V(349)
  V_USER(39) = V(350)
  V_USER(40) = V(6)
  V_USER(41) = V(127)
  V_USER(42) = V(212)
  V_USER(43) = V(235)
  V_USER(44) = V(71)
  V_USER(45) = V(90)
  V_USER(46) = V(60)
  V_USER(47) = V(109)
  V_USER(48) = V(183)
  V_USER(49) = V(141)
  V_USER(50) = V(140)
  V_USER(51) = V(171)
  V_USER(52) = V(172)
  V_USER(53) = V(46)
  V_USER(54) = V(47)
  V_USER(55) = V(48)
  V_USER(56) = V(49)
  V_USER(57) = V(50)
  V_USER(58) = V(51)
  V_USER(59) = V(78)
  V_USER(60) = V(79)
  V_USER(61) = V(1)
  V_USER(62) = V(2)
  V_USER(63) = V(3)
  V_USER(64) = V(325)
  V_USER(65) = V(312)
  V_USER(66) = V(105)
  V_USER(67) = V(43)
  V_USER(68) = V(241)
  V_USER(69) = V(181)
  V_USER(70) = V(52)
  V_USER(71) = V(228)
  V_USER(72) = V(81)
  V_USER(73) = V(75)
  V_USER(74) = V(340)
  V_USER(75) = V(245)
  V_USER(76) = V(76)
  V_USER(77) = V(297)
  V_USER(78) = V(317)
  V_USER(79) = V(338)
  V_USER(80) = V(110)
  V_USER(81) = V(329)
  V_USER(82) = V(7)
  V_USER(83) = V(158)
  V_USER(84) = V(94)
  V_USER(85) = V(149)
  V_USER(86) = V(156)
  V_USER(87) = V(261)
  V_USER(88) = V(70)
  V_USER(89) = V(136)
  V_USER(90) = V(83)
  V_USER(91) = V(106)
  V_USER(92) = V(234)
  V_USER(93) = V(296)
  V_USER(94) = V(118)
  V_USER(95) = V(41)
  V_USER(96) = V(213)
  V_USER(97) = V(306)
  V_USER(98) = V(270)
  V_USER(99) = V(217)
  V_USER(100) = V(61)
  V_USER(101) = V(53)
  V_USER(102) = V(54)
  V_USER(103) = V(336)
  V_USER(104) = V(264)
  V_USER(105) = V(307)
  V_USER(106) = V(72)
  V_USER(107) = V(352)
  V_USER(108) = V(238)
  V_USER(109) = V(84)
  V_USER(110) = V(85)
  V_USER(111) = V(86)
  V_USER(112) = V(87)
  V_USER(113) = V(339)
  V_USER(114) = V(265)
  V_USER(115) = V(73)
  V_USER(116) = V(88)
  V_USER(117) = V(107)
  V_USER(118) = V(89)
  V_USER(119) = V(239)
  V_USER(120) = V(327)
  V_USER(121) = V(108)
  V_USER(122) = V(337)
  V_USER(123) = V(316)
  V_USER(124) = V(333)
  V_USER(125) = V(330)
  V_USER(126) = V(154)
  V_USER(127) = V(230)
  V_USER(128) = V(133)
  V_USER(129) = V(231)
  V_USER(130) = V(135)
  V_USER(131) = V(150)
  V_USER(132) = V(144)
  V_USER(133) = V(210)
  V_USER(134) = V(331)
  V_USER(135) = V(170)
  V_USER(136) = V(44)
  V_USER(137) = V(55)
  V_USER(138) = V(42)
  V_USER(139) = V(77)
  V_USER(140) = V(215)
  V_USER(141) = V(243)
  V_USER(142) = V(104)
  V_USER(143) = V(301)
  V_USER(144) = V(182)
  V_USER(145) = V(258)
  V_USER(146) = V(119)
  V_USER(147) = V(147)
  V_USER(148) = V(174)
  V_USER(149) = V(293)
  V_USER(150) = V(206)
  V_USER(151) = V(207)
  V_USER(152) = V(198)
  V_USER(153) = V(299)
  V_USER(154) = V(180)
  V_USER(155) = V(151)
  V_USER(156) = V(286)
  V_USER(157) = V(152)
  V_USER(158) = V(285)
  V_USER(159) = V(128)
  V_USER(160) = V(268)
  V_USER(161) = V(175)
  V_USER(162) = V(168)
  V_USER(163) = V(267)
  V_USER(164) = V(305)
  V_USER(165) = V(304)
  V_USER(166) = V(271)
  V_USER(167) = V(226)
  V_USER(168) = V(223)
  V_USER(169) = V(224)
  V_USER(170) = V(232)
  V_USER(171) = V(145)
  V_USER(172) = V(8)
  V_USER(173) = V(62)
  V_USER(174) = V(310)
  V_USER(175) = V(311)
  V_USER(176) = V(222)
  V_USER(177) = V(186)
  V_USER(178) = V(284)
  V_USER(179) = V(103)
  V_USER(180) = V(252)
  V_USER(181) = V(332)
  V_USER(182) = V(91)
  V_USER(183) = V(9)
  V_USER(184) = V(10)
  V_USER(185) = V(276)
  V_USER(186) = V(205)
  V_USER(187) = V(190)
  V_USER(188) = V(266)
  V_USER(189) = V(303)
  V_USER(190) = V(320)
  V_USER(191) = V(11)
  V_USER(192) = V(12)
  V_USER(193) = V(167)
  V_USER(194) = V(281)
  V_USER(195) = V(111)
  V_USER(196) = V(137)
  V_USER(197) = V(225)
  V_USER(198) = V(56)
  V_USER(199) = V(66)
  V_USER(200) = V(74)
  V_USER(201) = V(160)
  V_USER(202) = V(176)
  V_USER(203) = V(129)
  V_USER(204) = V(138)
  V_USER(205) = V(112)
  V_USER(206) = V(161)
  V_USER(207) = V(162)
  V_USER(208) = V(255)
  V_USER(209) = V(211)
  V_USER(210) = V(237)
  V_USER(211) = V(163)
  V_USER(212) = V(177)
  V_USER(213) = V(57)
  V_USER(214) = V(130)
  V_USER(215) = V(169)
  V_USER(216) = V(262)
  V_USER(217) = V(193)
  V_USER(218) = V(277)
  V_USER(219) = V(257)
  V_USER(220) = V(278)
  V_USER(221) = V(275)
  V_USER(222) = V(273)
  V_USER(223) = V(272)
  V_USER(224) = V(274)
  V_USER(225) = V(14)
  V_USER(226) = V(15)
  V_USER(227) = V(16)
  V_USER(228) = V(17)
  V_USER(229) = V(20)
  V_USER(230) = V(21)
  V_USER(231) = V(24)
  V_USER(232) = V(23)
  V_USER(233) = V(25)
  V_USER(234) = V(26)
  V_USER(235) = V(309)
  V_USER(236) = V(259)
  V_USER(237) = V(159)
  V_USER(238) = V(308)
  V_USER(239) = V(92)
  V_USER(240) = V(324)
  V_USER(241) = V(153)
  V_USER(242) = V(194)
  V_USER(243) = V(248)
  V_USER(244) = V(216)
  V_USER(245) = V(287)
  V_USER(246) = V(253)
  V_USER(247) = V(202)
  V_USER(248) = V(246)
  V_USER(249) = V(292)
  V_USER(250) = V(113)
  V_USER(251) = V(93)
  V_USER(252) = V(294)
  V_USER(253) = V(328)
  V_USER(254) = V(282)
  V_USER(255) = V(45)
  V_USER(256) = V(256)
  V_USER(257) = V(242)
  V_USER(258) = V(164)
  V_USER(259) = V(184)
  V_USER(260) = V(80)
  V_USER(261) = V(28)
  V_USER(262) = V(191)
  V_USER(263) = V(219)
  V_USER(264) = V(314)
  V_USER(265) = V(131)
  V_USER(266) = V(208)
  V_USER(267) = V(227)
  V_USER(268) = V(288)
  V_USER(269) = V(302)
  V_USER(270) = V(254)
  V_USER(271) = V(185)
  V_USER(272) = V(67)
  V_USER(273) = V(63)
  V_USER(274) = V(214)
  V_USER(275) = V(19)
  V_USER(276) = V(64)
  V_USER(277) = V(65)
  V_USER(278) = V(346)
  V_USER(279) = V(335)
  V_USER(280) = V(351)
  V_USER(281) = V(269)
  V_USER(282) = V(95)
  V_USER(283) = V(18)
  V_USER(284) = V(343)
  V_USER(285) = V(334)
  V_USER(286) = V(341)
  V_USER(289) = V(120)
  V_USER(290) = V(68)
  V_USER(291) = V(345)
  V_USER(292) = V(96)
  V_USER(293) = V(289)
  V_USER(294) = V(280)
  V_USER(295) = V(315)
  V_USER(296) = V(139)
  V_USER(297) = V(114)
  V_USER(298) = V(195)
  V_USER(299) = V(291)
  V_USER(300) = V(229)
  V_USER(301) = V(260)
  V_USER(302) = V(123)
  V_USER(303) = V(124)
  V_USER(304) = V(250)
  V_USER(305) = V(247)
  V_USER(306) = V(290)
  V_USER(307) = V(125)
  V_USER(308) = V(115)
  V_USER(309) = V(318)
  V_USER(310) = V(251)
  V_USER(311) = V(319)
  V_USER(312) = V(97)
  V_USER(313) = V(178)
  V_USER(314) = V(165)
  V_USER(315) = V(98)
  V_USER(316) = V(196)
  V_USER(317) = V(99)
  V_USER(318) = V(100)
  V_USER(319) = V(298)
  V_USER(320) = V(322)
  V_USER(321) = V(173)
  V_USER(322) = V(187)
  V_USER(323) = V(192)
  V_USER(324) = V(209)
  V_USER(325) = V(199)
  V_USER(326) = V(116)
  V_USER(327) = V(188)
  V_USER(328) = V(155)
  V_USER(329) = V(179)
  V_USER(330) = V(166)
  V_USER(331) = V(353)
  V_USER(332) = V(344)
  V_USER(337) = V(348)
  V_USER(338) = V(134)
  V_USER(339) = V(29)
  V_USER(340) = V(30)
  V_USER(341) = V(31)
  V_USER(342) = V(220)
  V_USER(343) = V(58)
  V_USER(344) = V(121)
  V_USER(345) = V(200)
  V_USER(346) = V(82)
  V_USER(347) = V(22)
  V_USER(348) = V(101)
  V_USER(349) = V(27)
  V_USER(350) = V(32)
  V_USER(351) = V(33)
  V_USER(352) = V(189)

END SUBROUTINE Shuffle_kpp2user

! End of Shuffle_kpp2user function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
! GetMass - compute total mass of selected atoms
!   Arguments :
!      CL        - Concentration of all species (local)
!      Mass      - value of mass balance
!
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE GetMass ( CL, Mass )

! CL - Concentration of all species (local)
  REAL(kind=dp) :: CL(NSPEC)
! Mass - value of mass balance
  REAL(kind=dp) :: Mass(1)


END SUBROUTINE GetMass

! End of GetMass function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

! Get_OHreactivity - returns the OH reactivity
! The OH reactivity is defined as the inverse of its lifetime.
! This routine was auto-generated using script OHreact_parser.py.
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE Get_OHreactivity ( CC, RR, OHreact )

! CC - Concentrations of species (local)
  REAL(kind=dp) :: CC(NSPEC)
! RR - reaction rates (local)
  REAL(kind=dp) :: RR(NREACT)
! OHreact - OH reactivity [s-1]
  REAL(kind=dp) :: OHreact

  OHreact = RR(12)*CC(89) + RR(14)*CC(341) + 2*RR(18) + 2*RR(19) + RR(20)*CC(337) &
          + RR(21)*CC(264) + RR(24)*CC(329) + RR(25)*CC(228) + RR(31)*CC(328) + RR(32)*CC(164) &
          + RR(33)*CC(244) + RR(34)*CC(325) + RR(35)*CC(335) + RR(36)*CC(327) + RR(37)*CC(346) &
          + RR(38)*CC(239) + RR(41)*CC(108) + RR(44)*CC(351) + RR(47)*CC(265) + RR(48)*CC(282) &
          + RR(51)*CC(326) + RR(55)*CC(139) + RR(57)*CC(183) + RR(61)*CC(141) + RR(62)*CC(141) &
          + RR(66)*CC(69) + RR(71)*CC(98) + RR(72)*CC(196) + RR(75)*CC(140) + RR(80)*CC(127) &
          + RR(81)*CC(233) + RR(88)*CC(126) + RR(89)*CC(142) + RR(102)*CC(251) + RR(103)*CC(279) &
          + RR(104)*CC(283) + RR(105)*CC(298) + RR(108)*CC(124) + RR(111)*CC(295) + RR(122)*CC(292) &
          + RR(126)*CC(113) + RR(140)*CC(156) + RR(141)*CC(188) + RR(149)*CC(290) + RR(151)*CC(306) &
          + RR(152)*CC(306) + RR(153)*CC(306) + RR(160)*CC(114) + RR(161)*CC(72) + RR(163)*CC(270) &
          + RR(164)*CC(294) + RR(167)*CC(307) + RR(168)*CC(307) + RR(169)*CC(125) + RR(170)*CC(118) &
          + RR(171)*CC(99) + RR(172)*CC(100) + RR(173)*CC(97) + RR(174)*CC(102) + RR(175)*CC(155) &
          + RR(176)*CC(123) + RR(177)*CC(24) + RR(178)*CC(92) + RR(199)*CC(94) + RR(200)*CC(94) &
          + RR(202)*CC(348) + RR(206)*CC(352) + RR(211)*CC(148) + RR(214)*CC(347) + RR(223)*CC(81) &
          + RR(224)*CC(78) + RR(225)*CC(105) + RR(234)*CC(354) + RR(235)*CC(343) + RR(239)*CC(68) &
          + RR(273)*CC(245) + RR(275)*CC(338) + RR(276)*CC(338) + RR(277)*CC(120) + RR(278)*CC(76) &
          + RR(279)*CC(339) + RR(280)*CC(333) + RR(281)*CC(297) + RR(282)*CC(317) + RR(283)*CC(181) &
          + RR(284)*CC(79) + RR(285)*CC(75) + RR(286)*CC(43) + RR(287)*CC(87) + RR(288)*CC(85) &
          + RR(289)*CC(86) + RR(290)*CC(84) + RR(352)*CC(170) + RR(353)*CC(73) + RR(354)*CC(330) &
          + RR(359)*CC(52) + RR(360)*CC(261) + RR(361)*CC(247) + RR(378)*CC(167) + RR(380)*CC(219) &
          + RR(382)*CC(191) + RR(387)*CC(111) + RR(388)*CC(137) + RR(390)*CC(225) + RR(396)*CC(74) &
          + RR(397)*CC(66) + RR(402)*CC(160) + RR(403)*CC(176) + RR(407)*CC(138) + RR(408)*CC(112) &
          + RR(409)*CC(129) + RR(415)*CC(161) + RR(416)*CC(162) + RR(420)*CC(255) + RR(423)*CC(237) &
          + RR(426)*CC(211) + RR(433)*CC(163) + RR(435)*CC(177) + RR(441)*CC(169) + RR(442)*CC(130) &
          + RR(447)*CC(229) + RR(450)*CC(193) + RR(453)*CC(262) + RR(481)*CC(256) + RR(482)*CC(242) &
          + RR(488)*CC(154) + RR(489)*CC(93) + RR(490)*CC(83) + RR(491)*CC(91) + RR(492)*CC(95) &
          + RR(494)*CC(276) + RR(495)*CC(276) + RR(496)*CC(276) + RR(497)*CC(276) + RR(524)*CC(230) &
          + RR(525)*CC(231) + RR(526)*CC(150) + RR(527)*CC(144) + RR(528)*CC(238) + RR(529)*CC(215) &
          + RR(530)*CC(119) + RR(531)*CC(187) + RR(532)*CC(187) + RR(533)*CC(192) + RR(534)*CC(192) &
          + RR(535)*CC(187) + RR(536)*CC(192) + RR(537)*CC(209) + RR(538)*CC(199) + RR(551)*CC(128) &
          + RR(552)*CC(151) + RR(553)*CC(151) + RR(554)*CC(152) + RR(555)*CC(152) + RR(574)*CC(175) &
          + RR(575)*CC(175) + RR(576)*CC(168) + RR(577)*CC(168) + RR(578)*CC(268) + RR(579)*CC(268) &
          + RR(580)*CC(267) + RR(581)*CC(267) + RR(582)*CC(268) + RR(583)*CC(267) + RR(621)*CC(222) &
          + RR(622)*CC(186) + RR(623)*CC(222) + RR(624)*CC(186) + RR(625)*CC(186) + RR(626)*CC(222) &
          + RR(627)*CC(186) + RR(628)*CC(186) + RR(637)*CC(301) + RR(638)*CC(301) + RR(641)*CC(299) &
          + RR(644)*CC(314) + RR(646)*CC(309) + RR(647)*CC(309) + RR(650)*CC(302) + RR(651)*CC(288) &
          + RR(652)*CC(287) + RR(653)*CC(248) + RR(654)*CC(216) + RR(661)*CC(194) + RR(662)*CC(185) &
          + RR(663)*CC(131) + RR(664)*CC(227) + RR(665)*CC(208) + RR(666)*CC(153) + RR(672)*CC(159) &
          + RR(684)*CC(184) + RR(685)*CC(107) + RR(686)*CC(258) + RR(687)*CC(147) + RR(688)*CC(174) &
          + RR(689)*CC(198) + RR(690)*CC(266) + RR(691)*CC(303) + RR(693)*CC(115) + RR(694)*CC(88) &
          + RR(696)*CC(210) + RR(697)*CC(210) + RR(698)*CC(19) + RR(701)*CC(173) + RR(702)*CC(220) &
          + RR(705)*CC(149) + RR(707)*CC(200) + RR(711)*CC(116) + RR(713)*CC(109) + RR(714)*CC(60) &
          + RR(721)*CC(70) + RR(722)*CC(136) + RR(723)*CC(136) + RR(724)*CC(143) + RR(725)*CC(82) &
          + RR(726)*CC(101) + RR(732)*CC(58) + RR(735)*CC(146) + RR(740)*CC(122) + RR(741)*CC(195) &
          + RR(743)*CC(158) + RR(745)*CC(202) + RR(748)*CC(204) + RR(753)*CC(71) + RR(755)*CC(90) &
          + RR(760)*CC(117) + RR(763)*CC(269) + RR(767)*CC(221) + RR(770)*CC(201) + RR(780)*CC(41) &
          + RR(791)*CC(353) + RR(792)*CC(344)

END SUBROUTINE Get_OHreactivity
! End of Get_OHreactivity subroutine
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

END MODULE gckpp_Util
