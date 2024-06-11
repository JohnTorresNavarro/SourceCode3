0001009807240002 F*---------------------------------------------------------------**
0002000008220003 F* RPA0664    GROUP BENEFIT SERVICES SOFTWARE           2000      *
0003000008220005 F*            WRITTEN BY - S. Zien                                *
0004000008220006 F*            DATE - 08/00                                        *
0005009807240007 F*                                                                *
0006000008220006 F*  DESCRIPTION - Current broker commission not equal to 5%       *
000700000822     F*                for medical only.                               *
000800000901    ? *  History:
000900000901      *            Revised by - szien                                  *
001000000901      *            Date - 9/1/00                                      *
001100000901      *            Revision:  Write to a file as well as the report so *
001200000901      *                       that the user may make changes in XL400. *
001300000925      *
001400000925      *            Revised by - szien                                  *
001500000925      *            Date - 9/25/00                                      *
001600000925      *            Revision:  Remove the report per Mick G.            *
001700000925      *
001800001013      *            Revised by - szien                                  *
001900001013      *            Date -10/13/00                                      *
002000001013      *            Revision:  Expand group number to 15.               *
002100001128      *                                                                *
002200001128      *            Revised by - szien                                  *
002300001128      *            Date -11/28/00                                      *
002400001128      *            Revision:  Added the group carrier field to REVCOM. *
002500001128      *                                                                *
002600010201      *            Revised by - szien                                  *
002700010201      *            Date - 2/2/01                                       *
002800010201      *            Revision:  Recompile due to addition of commission  *
002900010201      *                       method and commission split fields to    *
003000010201      *                       the RPA06CWK file.                       *
003100030416      *                                                                *
003200030416      *            Revised by - ssk                                    *
003300030416      *            Date - 4/14/03                                      *
003400030416      *            Revision:  salesman relationship project            *
003500030416      *                       reduce lines of code; over modularized.  *
003600010201      *                                                                *
0037009807240009 F*---------------------------------------------------------------**
003800030416     FRPA065RPT2IPE  E           K DISK
003900000824     FPLNMST    IF   E           K DISK
004000000901     FREVCOM    UF A E           K DISK
004100030416   X***X
004200030416    ? * PLNMST Key
004300030416    ?C     PlanKey       Klist
004400030416    ?C                   Kfld                    Rptrst
004500030416    ?C                   Kfld                    Rpsub
004600030416    ?C                   Kfld                    Rpplan
004700030416      *
004800030416    ?C     ComKey        Klist
004900030416     c                   kfld                    rpsuper
005000030416     c                   Kfld                    RPCCDE
005100030416     c                   Kfld                    RPSMCD
005200030416     c                   Kfld                    RPTRST
005300030416     c                   Kfld                    RPSUB
005400030416     c                   Kfld                    RPACC
005500030416     c                   Kfld                    RPPLAN
005600030416    ***
005700000824     c     PlanKey       chain     Plnmst
005800030416     c                   if        %found(Plnmst) and (plncat = 'PMM' or
005900030416     c                             plncat = 'PMS')
006000000824      *
006100001013     C                   MOVE      *BLANKS       GROUP            15
006200030416     C                   MOVEL     RPGRP         GROUP
006300000824     C                   MOVE      *BLANKS       ACCNAM           25
006400000824     C                   MOVEL     RPANM         ACCNAM
006500001128     C                   Movel     PCARR         CARR
006600000901      *
006700000901     c     Comkey        chain     Revcom
006800000901     c                   if        NOT %found(Revcom)
006900000901     c                   write     Revcomr
007000000901     c                   endif
007100000901      *
007200030416     c                   Endif
