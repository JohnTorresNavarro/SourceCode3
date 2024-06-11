0001009807240002 F*---------------------------------------------------------------**
0002009909300003 F* RPA065     GROUP BENEFIT SERVICES SOFTWARE           1998      *
0003009807240005 F*            WRITTEN BY - MARY L FONTI                           *
0004009807240006 F*            DATE - 07/98                                        *
0005009807240007 F*                                                                *
0006009807280006 F*  DESCRIPTION - COMMISSION RATE WORK FILE BUILD.                *
000700980728     F*              **PREVIOUS MONTH RATE VS. CURRENT MONTH RATE**
000701010202    ? *  History:
000702010202      *            Revised by - szien                                  *
000703010202      *            Date - 2/2/01                                       *
000704010202      *            Revision:  Recompile due to addition of commission  *
000705010202      *                       method and commission split fields to    *
000706010202      *                       the RPA06CWK file.                       *
000707010202      *                                                                *
0008009807240009 F*---------------------------------------------------------------**
000900980729     FRPA06BL1  IP   E           K DISK
001000980729     FRPA06AL1  IF   E           K DISK
001100980728     FRPA065WK  O    E           K DISK
001200980721     I*-----------------------------------------------------
001300980728     IRPA60R
001400980728     I              RPCMRT                      CURRAT
001500980729     I              RPSMCD                      BROKER
001600980728     C*-----------------------------------------------------
001700980724     C     ACCKEY        KLIST
001800980729     C                   KFLD                    RPSMCD
001900980724     C                   KFLD                    RPTRST
002000980728     C                   KFLD                    RPSUB
002100980728     C                   KFLD                    RPACC
002200980729     C                   KFLD                    RPGRP
002300980728     C                   KFLD                    RPPLAN
002400971031     C*
002500980729     C     ACCKEY        CHAIN     RPA06AL1                           61
002600980728     C     *IN61         IFEQ      '0'
002700980728     C     RPCMRT        IFNE      CURRAT
002800980728     C* OVERRIDE PREMIUM FIELD WITH CURRENT RATE AS WORK FIELD.
002900980728     C                   Z-ADD     0             RPPPRM
003000980728     C                   Z-ADD     CURRAT        RPPPRM
003100980728     C                   WRITE     RPA65W
003200980729     C                   END
003300980728     C                   END
003400971022     C*
