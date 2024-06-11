0001009807240002 F*---------------------------------------------------------------**
0002009909300003 F* RPA066     GROUP BENEFIT SERVICES SOFTWARE           1998      *
0003009807240005 F*            WRITTEN BY - MARY L FONTI                           *
0004009807240006 F*            DATE - 07/98                                        *
0005009807240007 F*                                                                *
0006009807280006 F*  DESCRIPTION - CURRENT MONTH COMMISSION ACCOUNTS VS.           *
000700980728     F*                PREVIOUS MONTHS COMMISSION ACCOUNTS LISTING.
000800000828    ? *  History:
000900000828      *            Revised by - szien                                  *
001000000828      *            Date - 8/28/00
001100000828      *            Revision:  Expand group to 10 characters.           *
001200000928      *                                                                *
001300001013      *            Revised by - szien                                  *
001400001013      *            Date -10/13/00
001500001013      *            Revision:  Expand group to 15 characters.           *
001600001013      *                                                                *
001700010201      *            Revised by - szien                                  *
001800010201      *            Date - 2/2/01                                       *
001900010201      *            Revision:  Add commission method and commission     *
002000010201      *                       split fields.                            *
002100010201      *                                                                *
002200030414      *            Revised by - ssk                                    *
002300030414      *            Date - 4/14/03                                      *
002400030414      *            Revision:  salesman relationship project            *
002401061219      *                                                                *
002402061219      *            Revised by - szz                                    *
002403061219      *            Date - 12/19/06                                     *
002404061219      *            Revision:  Remove paper report; add CSV file for a  *
002405061219      *                        spreadsheet.                            *
0025009807240009 F*---------------------------------------------------------------**
002600030414     FRPA065RPT1IP   E           K DISK
002601061219     FRPA066CSV O  A E             Disk
0028009807210053 D                UDS
002900980721     D  USERID                25     32
0030009807210054 D  CONAME               201    240
003100980728     D*
003200980930     D  CURCY                256    259
003300980930     D  CURMD                260    263
003400980728     D*
003500980728     D  PRECY                275    278
003600980728     D  PREMD                279    282
003700980724     I*-----------------------------------------------------
003800980728     IRPA65W
003900030414     I                                          RPCCDE        L1
004000980721     C*-----------------------------------------------------
004100971031     C*
004200971031     C     *IN99         IFEQ      '0'
004201061219     C                   Exsr      WriteSpTitle
004300070116     C***************    EXCEPT    HEAD
004400971031     C                   MOVEA     '1'           *IN(99)
004500971031     C                   END
004600971031     C*
004700001013     C                   MOVE      *BLANKS       GROUP            15
004800001013     C                   MOVE      *BLANKS       ACCNAM           23
004900980728     C                   MOVEL     RPANM         ACCNAM
005000980727     C                   MOVEL     RPGRP         GROUP
005100000928     C*
005200070116     C************       EXCEPT    DETL
005202061219     C                   Exsr      WriteSpread
005203061219     C                   Write     RPA066CSVR
005300971022     C*
005400070116     C** OF              EXCEPT    HEAD
005500971031     C*
005600070116     C*****L1                 EXCEPT    SPACE
005700070116     C*****LRN99              EXCEPT    HEAD
005800971028     C*------------------------------------------------------
005801061219     C/EJECT
0058020612190164 C*************************************************************
0058030612190164 C*                                                           *
0058040612190164 C* Write to CSV file for Excel Spreadsheet                   *
0058050612190164 C*                                                           *
0058060612190164 C*************************************************************
005807061219     C     WriteSpread   BEGSR
005808061219      *
005855061219     C                   Eval      WKREC66   =   '"' +
005856061219     C                                                RPSUPER   + '","' +
005857061219     C                                                 RPCCDE   + '","' +
005858061219     C                                                 RPSMCD   + '","' +
005859061219     C                                                 RPSLNM   + '","' +
005861061219     C                              %Trim(%Editc(RPTRST:'P'))   + '","' +
005862061219     C                              %Trim(%Editc(RPSUB:'P'))    + '","' +
005863061219     C                              %Trim(%Editc(RPACC:'P'))    + '","' +
005864061219     C                                                 RPPLAN   + '","' +
005865061219     C                                                  RPGRP   + '","' +
005866061219     C                                                  RPANM   + '","' +
005867061219     C                                                 RPPCAR   + '","' +
005868061219     C                              %Trim(%Editc(RPCMRT:'P'))   + '","' +
005869061219     C                              %Trim(%Editc(RPPPRM:'P'))   + '","' +
005870061219     C                              %Trim(%Editc(RPPCOM:'P'))   + '","' +
005871061219     C                              %Trim(%Editc(RPPSPL:'P'))   + '","' +
005872061219     C                                                 RPMTHD   + '","' +
005873061219     C                               %Trim(%Editc(RPEFDT:'P'))  + '","' +
005874061219     C                                                RPRELID   + '",'
005880061219     C*
0058810612190320 C                   ENDSR
005882061219     C*
005883061219     C/EJECT
005884061219     C*************************************************************
005885061219     C*                                                           *
005886061219     C* Write to CSV file for Excel Spreadsheet Title             *
005887061219     C*                                                           *
005888061219     C*************************************************************
005889061219     C     WriteSpTitle  BEGSR
005890061219     C*
005891061219     C                   Eval      WKREC66   = '"' + 'Super'       + '","' +
005892061219     C                                               'AG#'         + '","' +
005893061219     C                                               'BK#'         + '","' +
005894061219     C                                               'Broker Name' + '","' +
005895061219     C                                               'Trust'       + '","' +
005896061219     C                                               'Sub'         + '","' +
005898061219     C                                               'Acct'        + '","' +
005899070103     C                                               'Plan'        + '","' +
005900061219     C                                               'Group'       + '","' +
005901061219     C                                               'Account Name'+ '","' +
005902061219     C                                               'Carrier Cd'  + '","' +
005903061219     C                                               'Rate'        + '","' +
005904061219     C                                               'Premium'     + '","' +
005905061219     C                                               'Comm'        + '","' +
005906061219     C                                               'Com Splt'    + '","' +
005907061219     C                                               'Mthd'        + '","' +
005908061219     C                                               'Effect Date' + '","' +
005909061219     C                                               'Rel ID'      + '",'
005910061219     C                   Write     RPA066CSVR
005911061219     C*
0059120612190320 C                   ENDSR
005913061219     C*
005914061219     C/EJECT
