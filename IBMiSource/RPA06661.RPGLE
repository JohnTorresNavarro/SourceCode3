0001009807240002 F*---------------------------------------------------------------**
0002000811110003 F* RPA06661   GROUP BENEFIT SERVICES SOFTWARE           2008      *
0003000811100005 F*            WRITTEN BY - S.ZIEN                                 *
0004000811100006 F*            DATE - 11/08                                        *
0005009807240007 F*                                                                *
000501081111      *  Program Name:  RPA06661   **   CURRENT VS. PREVIOUS MONTH **  *
000502081110      *  Written by:    S. Zien                                        *
000503081110      *  Date Written:  11/10/08                                       *
000504081110      *  Description:   Create workfile with relationship ID not found *
000505081110      *                 in previous month.                             *
000506081110      *  Called by:                                                    *
000507081110      *                                                                *
000901081110    ? *  History:                                                      *
000907081110      *            Revised by -                                        *
000908081110      *            Date -                                              *
000909081110      *            Revision:                                           *
000920010202      *                                                                *
0010009807240009 F*---------------------------------------------------------------**
001100081111     FRPA06AL2  IP   E           K DISK
001200081111     FRPA06BL2  IF   E           K DISK
001300980728     FRPA065WK  O    E           K DISK
001400980721     C*-----------------------------------------------------
001500980724     C     ACCKEY        KLIST
001600980724     C                   KFLD                    RPTRST
001700980728     C                   KFLD                    RPSUB
001800980728     C                   KFLD                    RPACC
001801081111     C                   KFLD                    RPPLAN
001802081110     c                   Kfld                    rprelid
001900971031     C*
002000081111     C     ACCKEY        SETLL     RPA06BL2
002100081111     C     ACCKEY        READE     RPA06BL2                               61
002200980727     C     *IN61         IFEQ      '1'
002201000928     C     RPTRST        IFNE      999
002300980728     C                   WRITE     RPA65W
002301000928     C                   ENDIF
002400980727     C                   END
002500971022     C*
