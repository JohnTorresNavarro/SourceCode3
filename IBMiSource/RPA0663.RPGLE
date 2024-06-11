0001009807240002 F*---------------------------------------------------------------**
0002009909300003 F* RPA0663    GROUP BENEFIT SERVICES SOFTWARE           1998      *
0003009807240005 F*            WRITTEN BY - MARY L FONTI                           *
0004009807240006 F*            DATE - 07/98                                        *
0005009807240007 F*                                                                *
0006009807280006 F*  DESCRIPTION - PREVIOUS MONTH COMMISSION RATES VS.             *
000700980728     F*                CURRENT MONTHS COMMISSION RATES LISTING.
000800000822    ? *  History:
000900000822      *            Revised by - szien                                  *
001000000822      *            Date - 8/22/00
001100000822      *            Revision:  Expand group to 10 characters.           *
001200000822      *                                                                *
001300001013      *            Revised by - szien                                  *
001400001013      *            Date -10/13/00
001500001013      *            Revision:  Expand group to 15 characters.           *
001600010202      *                                                                *
001700010202      *            Revised by - szien                                  *
001800010202      *            Date - 2/2/01                                       *
001900010202      *            Revision:  Add commission method and commission     *
002000010202      *                       split fields.                            *
002100001013      *                                                                *
002200030414      *            Revised by - ssk                                    *
002300030414      *            Date - 4/14/03                                      *
002400030414      *            Revision:  salesman relationship project            *
002401061228      *                                                                *
002402061228      *            Revised by - szz                                    *
002403061228      *            Date - 12/19/06                                     *
002404061228      *            Revision:  Remove paper report; add CSV file for a  *
002405061228      *                        spreadsheet.                            *
002500030414      *                                                                *
0026009807240009 F*---------------------------------------------------------------**
002700030414     FRPA065RPT1IP   E           K DISK
002701061228     FRPA0663CSVO  A E             Disk
0029009807210053 D                UDS
003000980721     D  USERID                25     32
0031009807210054 D  CONAME               201    240
003200980728     D*
003300980930     D  CURCY                256    259
003400980930     D  CURMD                260    263
003500980728     D*
003600980728     D  PRECY                275    278
003700980728     D  PREMD                279    282
003800980724     I*-----------------------------------------------------
003900980728     IRPA65W
004000980728     I                                          RPCCDE        L1
004100030414     I                                          rpsuper       L2
004200980721     C*-----------------------------------------------------
004300980728     C*
004400971031     C     *IN99         IFEQ      '0'
004401061228     C                   Exsr      WriteSpTitle
004500070116     C*************      EXCEPT    HEAD
004600971031     C                   MOVEA     '1'           *IN(99)
004700971031     C                   END
004800971031     C*
004900001013     C                   MOVE      *BLANKS       GROUP            15
005000001013     C                   MOVE      *BLANKS       ACCNAM           23
005100980728     C                   MOVEL     RPANM         ACCNAM
005200980727     C                   MOVEL     RPGRP         GROUP
005300980728     C*
005400070116     C*********          EXCEPT    DETL
005401061228     C                   Exsr      WriteSpread
005402061228     C                   Write     RPA0663CSR
005500971022     C*
005600070116     C***OF              EXCEPT    HEAD
005700971031     C*
005800070116     C***L2                 EXCEPT    SPACE
005900070116     C***L1                 EXCEPT    SPACE
006000070116     C***LRN99              EXCEPT    HEAD
006100971028     C*------------------------------------------------------
006101061228     C/EJECT
0061020612280164 C*************************************************************
0061030612280164 C*                                                           *
0061040612280164 C* Write to CSV file for Excel Spreadsheet                   *
0061050612280164 C*                                                           *
0061060612280164 C*************************************************************
006107061228     C     WriteSpread   BEGSR
006108061228      *
006109061228     C                   Eval      WKREC663  =   '"' +
006110061228     C                                                RPSUPER   + '","' +
006111061228     C                                                 RPCCDE   + '","' +
006112061228     C                                                 RPSMCD   + '","' +
006113061228     C                                                 RPSLNM   + '","' +
006114061228     C                              %Trim(%Editc(RPTRST:'P'))   + '","' +
006115061228     C                              %Trim(%Editc(RPSUB:'P'))    + '","' +
006116061228     C                              %Trim(%Editc(RPACC:'P'))    + '","' +
006117061228     C                                                 RPPLAN   + '","' +
006118061228     C                                                  RPGRP   + '","' +
006119061228     C                                                  RPANM   + '","' +
006120061228     C                                                 RPPCAR   + '","' +
006121061228     C                              %Trim(%Editc(RPCMRT:'P'))   + '","' +
006122061228     C                              %Trim(%Editc(RPPPRM:'P'))   + '","' +
006124061228     C                              %Trim(%Editc(RPPSPL:'P'))   + '","' +
006125061228     C                                                 RPMTHD   + '","' +
006126061228     C                               %Trim(%Editc(RPEFDT:'P'))  + '","' +
006127061228     C                                                RPRELID   + '",'
006128061228     C*
0061290612280320 C                   ENDSR
006130061228     C*
006131061228     C/EJECT
006132061228     C*************************************************************
006133061228     C*                                                           *
006134061228     C* Write to CSV file for Excel Spreadsheet Title             *
006135061228     C*                                                           *
006136061228     C*************************************************************
006137061228     C     WriteSpTitle  BEGSR
006138061228     C*
006139061228     C                   Eval      WKREC663  = '"' + 'Super'       + '","' +
006140061228     C                                               'AG#'         + '","' +
006141061228     C                                               'BK#'         + '","' +
006142061228     C                                               'Broker Name' + '","' +
006143061228     C                                               'Trust'       + '","' +
006144061228     C                                               'Sub'         + '","' +
006145070103     C                                               'Acct'        + '","' +
006146070103     C                                               'Plan'        + '","' +
006147061228     C                                               'Group'       + '","' +
006148061228     C                                               'Account Name'+ '","' +
006149061228     C                                               'Carrier Cd'  + '","' +
006150061228     C                                               'Prv Rate'    + '","' +
006151061228     C                                               'Current Rate'+ '","' +
006153061228     C                                               'Com Splt'    + '","' +
006154061228     C                                               'Mthd'        + '","' +
006155061228     C                                               'Effect Date' + '","' +
006156061228     C                                               'Rel ID'      + '",'
006157061228     C                   Write     RPA0663CSR
006158061228     C*
0061590612280320 C                   ENDSR
006160061228     C*
006161061228     C/EJECT
