0001009807240002 F*---------------------------------------------------------------**
0002009909300003 F* RPA065     GROUP BENEFIT SERVICES SOFTWARE           1998      *
0003009807240005 F*            WRITTEN BY - MARY L FONTI                           *
0004009807240006 F*            DATE - 07/98                                        *
0005009807240007 F*                                                                *
0006009807280006 F*  DESCRIPTION - CREATE WORK FILE WITH ACCOUNTS NOT PRESENT      *
000700980728     F*                IN PREVIOUS MONTH. (AGENCY, BROKER & ACCT#
000800980728     F*                ORDER)
000900980728     F*              **   CURRENT VS. PREVIOUS MONTH **
000901000928    ? *  History:
000907000928      *            Revised by - szien                                  *
000908000928      *            Date - 9/28/00                                      *
000909000928      *            Revision:  Add the plan to the key so that even if  *
000910000928      *                       a plan in the same account is found, if  *
000911000928      *                       the plan is not found, it will show us   *
000912000928      *                       on the current report as a new plan.     *
000913000928      *                       DO NOT INCLUDE TRUST 999 IN OUTPUT FILE. *
000914000928      *
000915010202      *            Revised by - szien                                  *
000916010202      *            Date - 2/2/01                                       *
000917010202      *            Revision:  Recompile due to addition of commission  *
000918010202      *                       method and commission split fields to    *
000919010202      *                       the RPA06CWK file.                       *
000920010202      *                                                                *
0010009807240009 F*---------------------------------------------------------------**
001100980724     FRPA06AWK  IP   E           K DISK
001200980724     FRPA06BWK  IF   E           K DISK
001300980728     FRPA065WK  O    E           K DISK
001400980721     C*-----------------------------------------------------
001500980724     C     ACCKEY        KLIST
001600980724     C                   KFLD                    RPTRST
001700980728     C                   KFLD                    RPSUB
001800980728     C                   KFLD                    RPACC
001801000928     c                   Kfld                    rpplan
001900971031     C*
002000980727     C     ACCKEY        SETLL     RPA06BWK
002100980727     C     ACCKEY        READE     RPA06BWK                               61
002200980727     C     *IN61         IFEQ      '1'
002201000928     C     RPTRST        IFNE      999
002300980728     C                   WRITE     RPA65W
002301000928     C                   ENDIF
002400980727     C                   END
002500971022     C*
