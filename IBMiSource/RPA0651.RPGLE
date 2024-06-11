0001009807240002 F*---------------------------------------------------------------**
0002009909300003 F* RPA0651    GROUP BENEFIT SERVICES SOFTWARE           1998      *
0003009807240005 F*            WRITTEN BY - MARY L FONTI                           *
0004009807240006 F*            DATE - 07/98                                        *
0005009807240007 F*                                                                *
0006009807280006 F*  DESCRIPTION - CREATE WORK FILE WITH ACCOUNTS NOT PRESENT      *
000700980728     F*                IN CURRENT MONTH.  (AGENCY, BROKER & ACCT#
000800980728     F*                ORDER)
000900980728     F*                 ** PREVIOUS VS. CURRENT MONTH **
000901010202    ? *  History:
000902010202      *            Revised by - szien                                  *
000903010202      *            Date - 2/2/01                                       *
000904010202      *            Revision:  Recompile due to addition of commission  *
000905010202      *                       method and commission split fields to    *
000906010202      *                       the RPA06CWK file.                       *
000907010202      *                                                                *
000908011011      *            Revised by - szien                                  *
000909011011      *            Date - 10/11/01                                     *
000910011011      *            Revision:  Add plan to the key and exclude 999's.   *
0010009807240009 F*---------------------------------------------------------------**
001100980728     FRPA06BWK  IP   E           K DISK
001200011011     FRPA06AWK  IF   E           K DISK    Prefix(A_) Rename(RPA60R:A_Fmt)
001300980728     FRPA065WK  O    E           K DISK
001400980721     C*-----------------------------------------------------
001500980724     C     ACCKEY        KLIST
001600980724     C                   KFLD                    RPTRST
001700980728     C                   KFLD                    RPSUB
001800980728     C                   KFLD                    RPACC
001801011011     c                   Kfld                    rpplan
001900971031     C*
002000980728     C     ACCKEY        SETLL     RPA06AWK
002100980728     C     ACCKEY        READE     RPA06AWK                               61
002200980727     C     *IN61         IFEQ      '1'
002201011011     C     RPTRST        Ifne      999
002300980728     C                   WRITE     RPA65W
002301011011     C                   End
002400980727     C                   END
002500971022     C*
