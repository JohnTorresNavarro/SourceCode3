000100160104     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN':'GBSBDIR')
000200140612     H ALWNULL(*USRCTL)
000300990503     H DATEDIT(*YMD)
0004009102150002 F******************************************************************
0005000004140003 F* IQ010      GROUP BENEFIT SERVICES SOFTWARE           1988      *
0006009102150004 F*                                                                *
0007009102150005 F*            WRITTEN BY - MICHAEL C. DUNPHY                      *
0008009102150006 F*            DATE - 08/08/88                                     *
0009009102150007 F*                                                                *
0010009102150008 F*                                                                *
0011009102150009 F*            REVISED: 06/20/90   WALTER J PICCININI              *
0012009102150010 F*            MODIFY GRATE PROCESSING. READ FILE & COMPARE FROM-TO*
0013009102150011 F*            DATES TO GET CORRECT GRATE RECORD.....              *
0014009102150012 F*                                                                *
0015009102150013 F*  DESCRIPTION - THIS PROGRAM WILL ALLOW INQUIRY INTO THE        *
0016009102150014 F*            MEMBERS BY SS# OR BY LIMITS ON THE LAST NAME        *
0017009807300011 F*                                                                *
0018009807300010 F*  Y2K CONVERT - 1998                                            *
0019000006130015 F*  02/99   DLK - ADD ABILITY TO ENTER A NEW ACC# FROM SCREEN     *
0020000006130015 F*                IO05 LIKE THE MEMBER SCREEN ALLOWS AND CORRECT  *
0021000006130015 F*                "POSITION CURSOR" ON SCREEN IO05 & IO03         *
002200000613     F*  7.24.99 DMA - Added "P2" as a valid coverage type for display *
002300000613     F* 06/13/00 DLK - Add "USER" to history display. Only GBS         *
0024000006130015 F*                employees will see this field, all others will  *
0025000006130015 F*                not by way of security (GBSECURE) field ISCDSP. *
0026000006130015 F*                Also move receive date to note 2 field          *
0027000006130015 F*                if it is filled. Also add date of marriage to   *
0028000006130015 F*                member screen.                                  *
002900001012     F* 10.12.00 DMA - Fixed edit code on zip to display leading 0     *
0030000006130015 F*                                                                *
003100001018     F* 10/17/00 SZZ - Add COBRA Administrative Begin Date field to the*
0032000010180015 F*                OO26 format screen.                             *
0033000010180015 F*                                                                *
0034000101190015 F* 01/19/01 SSK - CHANGE COMCTX RECORD LENGTH FROM 64 TO 91       *
0035000102070015 F*                                                                *
003600010207     F*  2/07/01 SZZ - Add GBS Administrative Begin Date field to the  *
003700010207     F*                Account Inquiry screen.                         *
0038000101190015 F*                                                                *
0039000103210015 F*  3/21/01 JVA - Allow Roll Keys in Member mode.                 *
0040000104020015 F*  3/30/01 dlk - COMCTX display changes: remove seq#, change     *
0041000104020015 F*                order to plan order and remove old display logic*
0042000104020015 F*                from this program. Now IQ011 is called that     *
0043000104020015 F*                displays a subfile.                             *
0044000104020015 F*                                                                *
004500010516@SEC F*  5/16/01 JVA - SECURE GBS ACCOUNT ACCESS FROM USERS.           *
0046000111290015 F* 11/29/01 dlk - add CMD13 for COBRA MEMBERS ONLY LIST on Acct   *
0047000111290015 F*                screen                                          *
004800011228@SEC F* 12/27/01 TWP - ADDED MORE DEPENDENT COVERAGE LINES             *
004900020103     F*  1/03/02 ssk - Add Diary Note program                          *
005000020109     F*  1/09/02 dlk - secure diary note program to internal users only. *
005100020109     F*                also highlight "DIARY" if diary records exist   *
005200020405     F*  4/05/02 dlk - Add new account search by "name contains"       *
005300020524     F*  5/24/02 szz - Recompiled over new AACODE file                 *
005400040716     F*  7/16/04 dlk - replace cobra admin fee with "parallel" field   *
0055000407160017 F*                on io05                                         *
005600041004     F* 10/04/04 dlk - add cobra service field on io05                 *
005700050411     F*  4/11/05 szz - Add Benegap beginning and end dates.            *
005800050523     F* 05/23/04 dlk - fix cobra invoice credit bal due display        *
005900050616     F* 06/15/04 dlk - add alternate id look up                        *
006000050630     F* 06/30/05 szz - Show Cobra Admin Fee.                           *
006100061103     F* 11/03/06 dlk - prevent error on primay plan screen when > 16   *
0062000611030017 F*                plans                                           *
006300061205     F* 12/05/06 szz - Remove Renewal Period & SIC Code from screen.   *
0064000612120017 F*                Add OLE data.                                   *
006500070926     F* 09/26/07 dlk - change bilrte and netrte to 6 decimal. Also     *
0066000709260017 F*                clean up prem & benamt fields on screen         *
006700080429     F*  4/01/08 szz - Add COBRA Alternate ID to the F9 COBRA screen.  *
006800080815     F*  8/15/08 rlj - Changed call to IQ011 to IQ011CL                *
006900090501     F*  5/01/09 szz - Add CFS834 Flag and Date to the display.        *
007000090513     F* 05/13/09 dlk - Add subsidy dates to OO26.                      *
007100090624     F*  6/24/09 szz - Show payroll acct#.                             *
007200090924     F* 09/24/09 dlk - show negative prem/rate on mcov line            *
007300091116     F* 11/16/09 dlk - fix IO05 display, totemp was truncated and AADDR2
0074000911160017 F*                was shifted to the right                        *
007500100802     F*  8/02/10 szz - Change dltcd to PDLTCD in file PLNMST because   *
0076001008020017 F*                same field name in other file was causing a bug.*
007700100928     F* 09/28/10 dlk - add election form return by date to OO26        *
007800101217     F* 12/16/10 dlk - add member email address to IO03 and remove     *
0079001012170017 F*                morbidity fields from member and depend screens *
008000110217     F* 02/17/11 dlk - add non-ssn indicator on IO03                   *
008100110429     F*  4/29/11 szz - Show "Dentures" instead of "Average Age" if it  *
0082001104290017 F*                is a Senior Dental account per Dave A/Cindy W.  *
008300110505     F* 05/05/11 dlk - add call to FM430 - debit card maintenance pgm  *
0084001105050017 F*                on screen io03 per request from Margie M.       *
008500110916     F* 07/20/11 dlk - add dependent email address                     *
008600110916     F* 09/16/11 dlk - add Reduced Benefit column on OO25 screen to    *
0087001109160017 F*                show when an MCOV benefit was reduced by declife*
008800111024     F* 10/14/11 jon - F6=Benefit Summary                              *
008900120514     F*  4/25/12 szz - Show PRINT INVOICE (CAFIC)                      *
009000120514     F*                 and LUMINX flag from AC2MST.                   *
009100120511     F* 05/11/12 dlk - add NOT PUBLISHED text to account invoice hist  *
0092001205110017 F*                record when appropriate.                        *
009300120601     F* 06/01/12 dlk - add NOT PUBLISHED text to account void inv rec  *
009400120620     F* 06/12/12 szz - Add call to Senior Dental Writeoff Balance Pgm. *
009500130627     F* 08/08/12 szz - Add renewal rep to account screen from A2CODE1. *
009600121106     F* 11/06/12 dlk - add enhanced coverage display                   *
009700130107     F* 12/12/12 dlk - change dependent coverage screen to a seperate  *
0098001301070017 F*                called program so a subfile window could be used*
009900130312     F* 03/12/13 szz - Most recent OLE date should show.               *
010000130912     F* 09/12/13 dlk - hist file expansion                             *
010100131213     F* 12/12/13 rlj - Add call to ACA Premiums display - IQ015CL      *
010200131213     F* 12/13/13 rlj - Use MC2V to get Mbr Premium for Mbr Detail      *
010300140115     F* 01/15/14 dlk - change 834 indicator to show ACA instead        *
010400140117     F* 01/17/14 rlj - Change logical to MCOVC and check term dt when  *
010500140117     F*                deciding if ACA Prem display is presented.      *
010600140409     F* 04/09/14 jva - highlight name if longer name exists            *
010700140606     F* 06/06/14 dlk - change date field used for aca indicator        *
010800140612     F* 06/12/14 SSK - REMOVE MC2V....JUST A BAD DREAM                 *
010900140612     F*                REPLACE WITH CALL TO GETRATE                    *
011000140626     F* 06/26/14 jva - Display full value of longer name               *
011100140710     F* 07/10/14 dlk - fix code that moves date at end of note 2 to    *
0112001407100017 F*                a viewable position on the screen.              *
011300141016     F* 10/15/14 rlj - Add call to Issues Tracking - IQ016CL           *
011400160104     F* 05/15/15 rlj - Highlight F8-Issue when issues exist            *
011500160108     F* 01/04/16 jva - Moved to dashboard logic added (SETLIBL)        *
011600160817     F* 08/17/16 dlk - Add admin fee code to io05 (field name is still *
0117001608190017 F*                OLDT06 in accmst) and clean up output edits     *
0118001608190017 F*                on some of the fields on io05 (phone, fax,      *
0119001608190017 F*                zip) so they dont show unnecessary zeros.       *
012000160831     F* 08/31/16 jva - no need to lool at ACCMSP (Dashboard change)    *
012100161129br01 F* 11/29/16 B.Rees    Added MDP to the note2 list.               *
012200170616     F* 06/16/17 dlk - put employee status description back on OO26    *
0123001706160017 F*                and remove cobra subsidy dates.                 *
012400180109     F* 01/09/18 dlk - Add "O M" trust cat code for advanced mobile    *
0125001801090017 F*                like "O N" for senior dental                    *
012600180501     F* 05/01/18 dlk - Add paid through date to account screen IO05    *
012700200107     F* 01/07/20 dlk - Add "O D" trust cat code for Care Services mgt  *
0128002001070017 F*                like "O M" for Advanced Mobile                  *
0129002104160017 F* 04/16/21 dlk - put back cobra subsidy dates.                   *
013000210519     F* 05/19/21 dlk - Add COBRA paid through date to OO26             *
013100211001     F* 10/01/21 dlk - Add 2 new parms to getptc                       *
013200211130     F* 11/30/21 dlk - make aacode external to pick up longer length   *
0133001801090017 F*                                                                *
0134009102150016 F******************************************************************
0135009102150017 F*                                                                *
0136000204170018 FTERM      CP   F 2331        WORKSTN
013700910215     F                                     SLN(LINENO)
013800910215     F                                     DEVID(DSPLY2)
013900160108     F                                     INFSR(ERRSR)
014000160108     F                                     INFDS(DSPD)
014100160108     F****                                 INFDS(ERRDS)
0142001602100025 FMEMBER    IF   F  648     9AIDISK    KEYLOC(1)
0143009807300026 FMEMBERA   IF   F  648    31AIDISK    KEYLOC(10)
0144000004060027 FMEMACC    IF   F  648    41AIDISK    KEYLOC(1)
0145009807300028 FMCOV38    IF   F   88    38AIDISK    KEYLOC(1)
0146009807300029 FDEPEND    IF   F  360     9AIDISK    KEYLOC(1)
0147009807300031 FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
0148009807300032 FGRATE     IF   F   80    15AIDISK    KEYLOC(1)
0149002111300033 FHISTALT   IF   F  216    18AIDISK    KEYLOC(1)
0150009807300034 FACCMST    IF   F  560    10AIDISK    KEYLOC(1)
0151009807300035 FACCMSTA   IF   F  560    40AIDISK    KEYLOC(11)
0152009208120036 FCODES     IF   F   64     3AIDISK    KEYLOC(1)
0153009807300038 FSMAN      IF   F  272     3AIDISK    KEYLOC(1)
0154009407290033 FAPLNP     IF   F  192    14AIDISK    KEYLOC(1)
015500000406     FMCOV14    IF   F   88    14AIDISK    KEYLOC(1)
0156001602100032 Fmemssn    IF   e           k DISK    extfile('F.MEMSSN') prefix(s_)
0157001401150032 Fcmct14    IF   e           k DISK
0158002111300034 FAACODE    IF   e           k DISK    prefix(aa_)
015900000612     FGBSECURE  IF   E           K DISK
016000080429     FMEMALTL3  IF   E           K Disk
016100020109     Fdiaryhd1  IF   E           K DISK
016200130312     FACCOSPL2  IF   E           K Disk
016300061205     FAOECOD    IF   E           K Disk
016400090413     FACCMSP    IF   E           K Disk
016500090420     FCLASS     IF   E           K Disk
016600140117     FMCOVC     IF   E           K Disk    Rename(MCOVR:MC) Prefix(C_)
016700140117     FMCOV40    IF   E           K Disk    Rename(MCOVR:M4) Prefix(A_)
016800090421     FMCOV41    IF   E           K Disk    Rename(MCOVR:M41) Prefix(B_)
016900210416     Fsubmem    IF   E           K Disk
017000110429     FTRSMST    IF   E           K Disk
017100160104     FwebpayrollIF   E           K Disk    usropn
017200120514     FAC2MST    IF   E           K Disk
017300120511     Finvdnp    IF   E           K Disk
017400120620     FACCSWB    IF   E           K Disk
017500150515     FITISSP    IF   E           K Disk
017600150515     FPLNAUXP   IF   E           K Disk
017700140409     FCFS100P   IF   E           K Disk
017800131213      *
0179009102150040 D AMS             S              9    DIM(11)
0180009102150041 D SS              S             11    DIM(19)
0181009102150042 D SEL             S              1    DIM(19)
0182009102150043 D AL              S            109    DIM(19)
0183009807310044 D PD              S             99    DIM(7)
0184009901150049 D NT              S              1    DIM(8)
0185009901150049 D N2              S              1    DIM(8)
0186009102150050 D BAL             S              9  2 DIM(12)
0187000112280050 D DSP_OO39        S               N   INZ('0')
0188001602040050 D INQ_SSNO        S              9S 0 INZ
0189001602040050 D LIB_SSNO        S              9S 0 INZ
0190001602040050 D SAV_SSNO        S              9S 0 INZ
019100120514     D Fully           S              1    Inz('F')
0192009407290041 D*                                                              *
0193009709290051 D MSG             S             75    DIM(8) CTDATA PERRCD(1)
0194009102150052 D ER              S             11    DIM(1) CTDATA PERRCD(1)
0195009109110052 D ER2             S             40    DIM(1) CTDATA PERRCD(1)
019600911022     D RE              S             10    DIM(1) CTDATA PERRCD(1)
019700120511     D dnptext         C                   CONST('NOT PUBLISHED')
0198001206270002 D systemdate      S               d   datfmt(*ISO)
019900160104     D ver             S              2s 0 inz
020000160104     D dsh             S              2s 0 inz
020100160104     D pay             S              2s 0 inz
020200160104     D selacc          S              2s 0 inz
020300160819     D aphoneout       S             14
020400160819     D faxout          S             14
020500160819     D azipout         S             10
020600180501     D ptdateout       S              8
020700180501     D parmptdate      S              8
020800210519     D cptdtmdy        S              8
020900210519
0210009102150483 D*ACCMST KEY
0211000105210484 D                 DS
0212000105210485 D  KEYACC                 1     10  0
0213009102150486 D  TRUST#                 1      3  0
0214009102150487 D  SUB#                   4      6  0
0215009102150488 D  ACCNO                  7     10  0
0216009102150489 D/SPACE
0217009407290189 D                 DS
0218009407290217 D  CDS                    1    800
021900940729     D                                     DIM(20)
022000940729     D  CDS1                   1     40
022100940729     D  CDS2                  41     80
022200940729     D  CDS3                  81    120
022300940729     D  CDS4                 121    160
022400940729     D  CDS5                 161    200
022500940729     D  CDS6                 201    240
022600940729     D  CDS7                 241    280
022700940729     D  CDS8                 281    320
022800940729     D  CDS9                 321    360
022900940729     D  CDS10                361    400
023000940729     D  CDS11                401    440
023100940729     D  CDS12                441    480
023200940729     D  CDS13                481    520
023300940729     D  CDS14                521    560
023400940729     D  CDS15                561    600
023500940729     D  CDS16                601    640
023600940729     D  CDS17                641    680
023700940729     D  CDS18                681    720
023800940729     D  CDS19                721    760
023900940729     D  CDS20                761    800
0240009407290189 D                 DS
0241009407290217 D  PDS                    1    800
024200940729     D                                     DIM(20)
024300940729     D  PDS1                   1     40
024400940729     D  PDS2                  41     80
024500940729     D  PDS3                  81    120
024600940729     D  PDS4                 121    160
024700940729     D  PDS5                 161    200
024800940729     D  PDS6                 201    240
024900940729     D  PDS7                 241    280
025000940729     D  PDS8                 281    320
025100940729     D  PDS9                 321    360
025200940729     D  PDS10                361    400
025300940729     D  PDS11                401    440
025400940729     D  PDS12                441    480
025500940729     D  PDS13                481    520
025600940729     D  PDS14                521    560
025700940729     D  PDS15                561    600
025800940729     D  PDS16                601    640
025900940729     D  PDS17                641    680
026000940729     D  PDS18                681    720
026100940729     D  PDS19                721    760
026200940729     D  PDS20                761    800
0263009407290231 D                 DS
0264009407290232 D  SL                     1     16
026500940729     D                                     DIM(16)
0266009407290232 D  SL1                    1      1
0267009407290232 D  SL2                    2      2
0268009407290232 D  SL3                    3      3
0269009407290232 D  SL4                    4      4
0270009407290232 D  SL5                    5      5
0271009407290232 D  SL6                    6      6
0272009407290232 D  SL7                    7      7
0273009407290232 D  SL8                    8      8
0274009407290232 D  SL9                    9      9
0275009407290232 D  SL10                  10     10
0276009407290232 D  SL11                  11     11
0277009407290232 D  SL12                  12     12
0278009407290232 D  SL13                  13     13
0279009407290232 D  SL14                  14     14
0280009407290232 D  SL15                  15     15
0281009407290232 D  SL16                  16     16
0282009407290231 D                 DS
0283009407290232 D  PL                     1     64
028400940729     D                                     DIM(16)
0285009407290232 D  PL1                    1      4
0286009407290232 D  PL2                    5      8
0287009407290232 D  PL3                    9     12
0288009407290232 D  PL4                   13     16
0289009407290232 D  PL5                   17     20
0290009407290232 D  PL6                   21     24
0291009407290232 D  PL7                   25     28
0292009407290232 D  PL8                   29     32
0293009407290232 D  PL9                   33     36
0294009407290232 D  PL10                  37     40
0295009407290232 D  PL11                  41     44
0296009407290232 D  PL12                  45     48
0297009407290232 D  PL13                  49     52
0298009407290232 D  PL14                  53     56
0299009407290232 D  PL15                  57     60
0300009407290232 D  PL16                  61     64
0301009407290231 D                 DS
0302009407290232 D  DS                     1    640
030300940729     D                                     DIM(16)
0304009407290232 D  DS1                    1     40
0305009407290232 D  DS2                   41     80
0306009407290232 D  DS3                   81    120
0307009407290232 D  DS4                  121    160
0308009407290232 D  DS5                  161    200
0309009407290232 D  DS6                  201    240
0310009407290232 D  DS7                  241    280
0311009407290232 D  DS8                  281    320
0312009407290232 D  DS9                  321    360
0313009407290232 D  DS10                 361    400
0314009407290232 D  DS11                 401    440
0315009407290232 D  DS12                 441    480
0316009407290232 D  DS13                 481    520
0317009407290232 D  DS14                 521    560
0318009407290232 D  DS15                 561    600
0319009407290232 D  DS16                 601    640
0320009407290231 D                 DS
0321009807310232 D  CP                     1     80
032200980730     D                                     DIM(20)
0323009807310232 D  CP1                    1      4
0324009807310232 D  CP2                    5      8
0325009807310232 D  CP3                    9     12
0326009807310232 D  CP4                   13     16
0327009807310232 D  CP5                   17     20
0328009807310232 D  CP6                   21     24
0329009807310232 D  CP7                   25     28
0330009807310232 D  CP8                   29     32
0331009807310232 D  CP9                   33     36
0332009807310232 D  CP10                  37     40
0333009807310232 D  CP11                  41     44
0334009807310232 D  CP12                  45     48
0335009807310232 D  CP13                  49     52
0336009807310232 D  CP14                  53     56
0337009807310232 D  CP15                  57     60
0338009807310232 D  CP16                  61     64
0339009807310232 D  CP17                  65     68
0340009807310232 D  CP18                  69     72
0341009807310232 D  CP19                  73     76
0342009807310232 D  CP20                  77     80
0343009407290231 D                 DS
0344009807310232 D  PP                     1     80
034500980730     D                                     DIM(20)
0346009807310232 D  PP1                    1      4
0347009807310232 D  PP2                    5      8
0348009807310232 D  PP3                    9     12
0349009807310232 D  PP4                   13     16
0350009807310232 D  PP5                   17     20
0351009807310232 D  PP6                   21     24
0352009807310232 D  PP7                   25     28
0353009807310232 D  PP8                   29     32
0354009807310232 D  PP9                   33     36
0355009807310232 D  PP10                  37     40
0356009807310232 D  PP11                  41     44
0357009807310232 D  PP12                  45     48
0358009807310232 D  PP13                  49     52
0359009807310232 D  PP14                  53     56
0360009807310232 D  PP15                  57     60
0361009807310232 D  PP16                  61     64
0362009807310232 D  PP17                  65     68
0363009807310232 D  PP18                  69     72
0364009807310232 D  PP19                  73     76
0365009807310232 D  PP20                  77     80
0366009102150490 D* MEMBER ACC/NAME LIMITS KEY
0367009102150491 D                 DS
0368009102150492 D  MALL                   1     41
0369009102150493 D  MACC#                  1     10  0
0370009102150494 D  MALFM                 11     41
0371009102150495 D/SPACE
0372009102150496 D*  GRATE KEY
0373009102150497 D                 DS
0374009102150498 D  RKEY                   1     15
0375009807310499 D  PLKEY                  1     10
0376009102150500 D  AGEBND                11     12  0
0377009102150501 D  COVTYP                13     15
0378009102150502 D/SPACE
0379009102150503 D*  CODES KEY
0380009102150504 D                 DS
0381009102150505 D  CDKEY                  1      3
0382009102150506 D  CDTYPE                 1      1
0383009102150507 D  STATUS                 2      3
038400910516     D  CD3                    3      3
0385009102150508 D/SPACE
0386009102150515 D*  PLAN DESCRIPTION LINE
0387009102150516 D                 DS
0388009807310517 D  PLINE                  1     99
0389009102150518 D  P#                     1      4
0390001109160519 D  PDSCR                  6     42
0391001109160521 D  PTCODE                44     45
0392001109160520 D  PAGBND                47     48
0393001109160522 D  PENROL                50     57
0394001109160523 D  PCANCL                59     66
0395001109160524 D  PPREM                 68     76
0396001109160525 D**PBEN$                 77     83
0397001109160525 D  PBC                   77     83
0398001109160525 D  PRB                   86     86
0399009807310526 D  PGRP#                 88     99
0400009102150527 D/SPACE
0401009102150528 D*  MEMBER ALPHA DISPLAY LINE
0402009102150529 D                 DS
0403009102150530 D  MLINE                  1    109
0404009102150531 D  MLNAME                 1     18
0405009102150532 D  MFNAME                20     31
0406009102150533 D  MMI                   33     33
0407009807310534 D  MDOB                  37     44
0408009102150535 D  MACCNM                53     92
0409009102150536 D  MSTATS                94    109
0410009102150537 D/SPACE
041100090421     D                 DS
0412000904210498 D  RateKey                1     15
041300090421     D  PlnKey                 1     10
041400090421     D  A_MCTRST               1      3  0
041500090421     D  A_MCSUB#               4      6  0
041600090421     D  A_MCPLAN               7     10
0417000904210500 D  A_MCAGEB              11     12  0
0418000904210501 D  A_MCOVTP              13     15
041900090421     D                 DS
0420000904210498 D  RateKeyB               1     15
042100090421     D  PlnKeyB                1     10
042200090421     D  B_MCTRST               1      3  0
042300090421     D  B_MCSUB#               4      6  0
042400090421     D  B_MCPLAN               7     10
0425000904210500 D  B_MCAGEB              11     12  0
0426000904210501 D  B_MCOVTP              13     15
0427009110170223 D                 DS
0428009807310224 D  CPLKEY                 1     10
0429009110170225 D  CTR#SB                 1      6  0
0430009807300226 D  CPLAN                  7     10
0431009102150538 D*  ACCOUNT ALPHA DISPLAY LINE
0432009102150539 D                 DS
0433009102150540 D  ALINE                  1    109
0434009102150541 D  AACNAM                 1     40
0435009102150542 D  AACITY                43     57
0436009102150543 D  AAST                  59     60
0437009102150544 D  AACONT                65     89
0438009807310545 D  AATERM                91     98
0439009102150547 D  AASTAT               104    109
0440009102150548 D/SPACE
0441009102150549 D*  COVARAGE THRU DATE
0442009102150555 D/SPACE
0443009110180227 D                 DS
0444000103300228 D  KIKEY                  1     14
0445009110180229 D  COMKEY                 1     10  0
0446000103300230 D  cplan2                11     14
0447009110240124 D                 DS
0448009807310125 D  MCVK14                 1     14
0449009110250126 D  MTRUST                 1      3  0
0450009110250127 D  MSUB                   4      6  0
0451009110250126 D  MACC                   7     10  0
0452009807300127 D  MPLAN                 11     14
045300160108    ? * Display file data structure
045400160108    ?D DSPD          E DS                  EXTNAME(IODSPD)
0455001601080190 D*ERRDS           DS
0456001601080566 D* WDFMT                 38     45
0457001601080191 D* ERRST            *STATUS
0458009208140563 D                 DS
0459009807310566 D  SAVHST                21     38
0460009208140567 D  SAVSS#                22     30  0
0461009208140568 D  SAVAC#                21     30  0
0462009807310568 D  SAVTR#                31     38  0
046300920817     D                 DS
046400920817     D  #SS                    1      9
046500920817     D  SS1                    1      3
046600920817     D  SS2                    4      5
046700920817     D  SS3                    6      9
0468009102150599 D/SPACE
046900941205     D                 DS
047000980731     D  TRD78                  1      8
047100980731     D  SHYY1                  1      4  0
047200980731     D  SHMM1                  5      6  0
047300980731     D  SHDD1                  7      8  0
047400010330     D                 DS
047500010330     D  parmacc#               1     10
047600010330     D  parmt                  1      3
047700010330     D  parms                  4      6
047800010330     D  parma                  7     10
047900160104     D                 DS
048000160104     D  dashacc#               1     10s 0 inz
048100160104     D  dasht                  1      3s 0 inz
048200160104     D  dashs                  4      6s 0 inz
048300160104     D  dasha                  7     10s 0 inz
048400160104
048500160104     D qcmdexc         pr                  extpgm('QCMDEXC')
048600160104     D  cmd                         256    const options(*varsize)
048700160104     D  cmdlength                    15  5 const
048800141016      *
048900141016     D                 DS
049000141016     D  parmiss                1     19
049100141016     D  pitsa                  1     10
049200141016     D  pissn                 11     19
049300141016      *
049400970928     D* TRUST SECURITY ARRAY
0495009709280189 D                 DS
0496009709280217 D  ST                     1     30  0
049700970928     D                                     DIM(10)
049800970929     D  OSCT1                  1      3  0
049900970929     D  OSCT2                  4      6  0
050000970929     D  OSCT3                  7      9  0
050100970929     D  OSCT4                 10     12  0
050200970929     D  OSCT5                 13     15  0
050300970929     D  OSCT6                 16     18  0
050400970929     D  OSCT7                 19     21  0
050500970929     D  OSCT8                 22     24  0
050600970929     D  OSCT9                 25     27  0
050700970929     D  OSCT10                28     30  0
050800050411     D  BenKey         DS
050900050411     D  Trust                  1      3  0
051000050411     D  Sub                    4      6  0
051100050411     D  Acc                    7     10  0
051200120511
051300120511      * history key field broken out by T/S/A
051400120511     D  hacc#          DS
051500120511     D  hi_trust               1      3  0
051600120511     D  hi_sub                 4      6  0
051700120511     D  hi_acc                 7     10  0
051800120511
051900120511      * history ck#not field for invoice transaction. Used to get inv#
052000120511     D                 DS
052100120511     D  ck#not                 1     30
052200120511     D  ck#notinv#             6     12  0 inz
052300120511
052400120620     D WADTA         E DS                  Extname(ACCSWB)
0525009102150600 D                UDS
0526009709290601 D  $USER                  1     10
0527009102150601 D  COMPNY               201    240
052800130312    ?D TomorISO        S               D   datfmt(*ISO)
052900160108     D OneMoreDay      S              8S 0 Inz
053000160108     D Len             S              2s 0 Inz
053100160104      *-------------------------------------------------------------------------
053200160104      *
053300160104      *  Get user lib list into variable
053400160104      *
053500160104      *-------------------------------------------------------------------------
053600160104     D IntJobID        S             16    Inz( *Blank )
053700160104     D Format          S              8    Inz( 'JOBI0700' )
053800160104     D LibsToSkip      S             10I 0
053900160104     D Pos             S             10I 0
054000160104     D QualJobName     S             26    Inz ( '*' )
054100160104     D RcvVarLen       S             10I 0 Inz( %Len( RcvVar ) )
054200160104
054300160104     d RcvVar          DS         32767
054400160104     d                               64    Inz( *Blank )
054500160104     d  NbrSysLibs                   10I 0 Inz( *Zero )
054600160104     d  NbrPrdLibs                   10I 0 Inz( *Zero )
054700160104     d  NbrCurLibs                   10I 0 Inz( *Zero )
054800160104     d  NbrUsrLibs                   10I 0 Inz( *Zero )
054900160104
055000160104     d UsrLibs         ds           550
055100160104     d TheLibs                       11    dim(50)
055200160819
055300160819     d                 ds
055400160819     d acctfax10               1     10  0
055500160819     d faxare                  1      3  0
055600160819     d fax#                    4     10  0
055700160104
055800160819     d                 ds
055900160819     d acctphone10             1     10  0
056000160819     d aarea                   1      3  0
056100160819     d aphone                  4     10  0
056200160819
056300160104     d*?Program Info
056400160104     d                SDS
056500160104     d  @PGM                   1     10
056600160104     d  @PARMS                37     39  0
056700160104     d  @JOB                 244    253
056800160104     d  @USER                254    263
056900160104     d  @JOB#                264    269  0
057000160104
057100160104      *-----------------------------------------------------------------
057200160104
057300140612   X***X
057400140612      /DEFINE CHK_ACA_PLAN_PR
057500140612      /DEFINE CHK_ACA_PLAN_FIELDS
057600140612      /COPY QCPYSRC,ACASRVPGMP
057700140612      /UNDEFINE CHK_ACA_PLAN_PR
057800140612      /UNDEFINE CHK_ACA_PLAN_FIELDS
057900160104
058000160104      /copy *libl/qmodsrc,#getverpr
058100160104      /copy *libl/qmodsrc,#commandpr
058200160104
058300140612   X***X
0584009102150053 ITERM      NS  01    1 C0    2 C1
0585009102150054 I* FORMAT-IO01
0586009102150055 I                                  3   11 0SSNO
0587009102150056 I                                 12   29  SLNAME
0588009102150059 I                                 30   39 0ACC#
0589009102150060 I                                 40   59  SACNAM
0590000204040060 I                                 60   89  sacnmcont
0591000204090060 I                                 90   90  sactive
0592000204170060 I                                 91   91  smemactive
0593009102150061 I          NS  02    1 C0    2 C2
0594009102150062 I* FORMAT-IO02
0595009102150063 I                                  3   12  SLN
0596009102150064 I                                 13   13  SEL(1)
0597009102150065 I                                 14   24  SS(1)
0598009102150066 I                                 25   25  SEL(2)
0599009102150067 I                                 26   36  SS(2)
0600009102150068 I                                 37   37  SEL(3)
0601009102150069 I                                 38   48  SS(3)
0602009102150070 I                                 49   49  SEL(4)
0603009102150071 I                                 50   60  SS(4)
0604009102150072 I                                 61   61  SEL(5)
0605009102150073 I                                 62   72  SS(5)
0606009102150074 I                                 73   73  SEL(6)
0607009102150075 I                                 74   84  SS(6)
0608009102150076 I                                 85   85  SEL(7)
0609009102150077 I                                 86   96  SS(7)
0610009102150078 I                                 97   97  SEL(8)
0611009102150079 I                                 98  108  SS(8)
0612009102150080 I                                109  109  SEL(9)
0613009102150081 I                                110  120  SS(9)
0614009102150082 I                                121  121  SEL(10)
0615009102150083 I                                122  132  SS(10)
0616009102150084 I                                133  133  SEL(11)
0617009102150085 I                                134  144  SS(11)
0618009102150086 I                                145  145  SEL(12)
0619009102150087 I                                146  156  SS(12)
0620009102150088 I                                157  157  SEL(13)
0621009102150089 I                                158  168  SS(13)
0622009102150090 I                                169  169  SEL(14)
0623009102150091 I                                170  180  SS(14)
0624009102150092 I                                181  181  SEL(15)
0625009102150093 I                                182  192  SS(15)
0626009102150094 I                                193  193  SEL(16)
0627009102150095 I                                194  204  SS(16)
0628009102150096 I                                205  205  SEL(17)
0629009102150097 I                                206  216  SS(17)
0630009102150098 I                                217  217  SEL(18)
0631009102150099 I                                218  228  SS(18)
0632009102150100 I                                229  229  SEL(19)
0633009102150101 I                                230  240  SS(19)
0634009102150102 I          NS  03    1 C0    2 C3
0635009102150103 I* FORMAT-IO03
0636009102150104 I                                  3   11 0SSNO03
0637009102150105 I                                 12   13 0DPSEQ#
0638009102150106 I          NS  04    1 C0    2 C4
0639009102150107 I* FORMAT-IO04
0640009102150108 I                                  3   12  SLN
0641009102150109 I                                 13   13  SEL(1)
0642009102150110 I                                 14   24  SS(1)
0643009102150111 I                                 25   25  SEL(2)
0644009102150112 I                                 26   36  SS(2)
0645009102150113 I                                 37   37  SEL(3)
0646009102150114 I                                 38   48  SS(3)
0647009102150115 I                                 49   49  SEL(4)
0648009102150116 I                                 50   60  SS(4)
0649009102150117 I                                 61   61  SEL(5)
0650009102150118 I                                 62   72  SS(5)
0651009102150119 I                                 73   73  SEL(6)
0652009102150120 I                                 74   84  SS(6)
0653009102150121 I                                 85   85  SEL(7)
0654009102150122 I                                 86   96  SS(7)
0655009102150123 I                                 97   97  SEL(8)
0656009102150124 I                                 98  108  SS(8)
0657009102150125 I                                109  109  SEL(9)
0658009102150126 I                                110  120  SS(9)
0659009102150127 I                                121  121  SEL(10)
0660009102150128 I                                122  132  SS(10)
0661009102150129 I                                133  133  SEL(11)
0662009102150130 I                                134  144  SS(11)
0663009102150131 I                                145  145  SEL(12)
0664009102150132 I                                146  156  SS(12)
0665009102150133 I                                157  157  SEL(13)
0666009102150134 I                                158  168  SS(13)
0667009102150135 I                                169  169  SEL(14)
0668009102150136 I                                170  180  SS(14)
0669009102150137 I                                181  181  SEL(15)
0670009102150138 I                                182  192  SS(15)
0671009102150139 I                                193  193  SEL(16)
0672009102150140 I                                194  204  SS(16)
0673009102150141 I                                205  205  SEL(17)
0674009102150142 I                                206  216  SS(17)
0675009102150143 I                                217  217  SEL(18)
0676009102150144 I                                218  228  SS(18)
0677009102150145 I                                229  229  SEL(19)
0678009102150146 I                                230  240  SS(19)
0679009102150147 I          NS  05    1 C0    2 C5
0680009102150148 I* FORMAT-IO05
0681009902050150 I                                  3   12 0ACC05
0682009902050149 I                                 13   14 0S
0683009902050150 I                                 13   14 0SELECT
0684009902050150 I                                 15   29  SALPH
0685009902050151 I                                 30   30  HTYPE
0686009102150152 I          NS  06    1 C0    2 C6
0687009102150153 I* FORMAT-OO26
0688009102150154 I          NS  07    1 C0    2 C7
0689009102150155 I* FORMAT-OO27
0690000112280154 I          NS  38    1 C3    2 C8
0691000112280155 I* FORMAT-OO38
0692000112280154 I          NS  39    1 C3    2 C9
0693000112280155 I* FORMAT-OO39
0694009407290178 I* FORMAT-IO08
0695009407290179 I          NS  70    1 CW
0696009407290183 I                                  2    2  SL1
0697009407290183 I                                  3    3  SL2
0698009407290183 I                                  4    4  SL3
0699009407290183 I                                  5    5  SL4
0700009407290183 I                                  6    6  SL5
0701009407290183 I                                  7    7  SL6
0702009407290183 I                                  8    8  SL7
0703009407290183 I                                  9    9  SL8
0704009407290183 I                                 10   10  SL9
0705009407290183 I                                 11   11  SL10
0706009407290183 I                                 12   12  SL11
0707009407290183 I                                 13   13  SL12
0708009407290183 I                                 14   14  SL13
0709009407290183 I                                 15   15  SL14
0710009407290183 I                                 16   16  SL15
0711009407290183 I                                 17   17  SL16
0712009411290178 I* FORMAT-IO99
0713009411290179 I          NS  78    1 C7    2 C8
0714009411290159 I                                  3    4 0SHMM
0715009411290159 I                                  5    6 0SHDD
0716009807300159 I                                  7   10 0SHYY
0717009407290178 I* FORMAT-IO09
0718009407290179 I          NS  71    1 CX
0719009208170156 I          NS  99
0720009102150157 IMEMBER    NS
0721009102150158 I*  MEMBER FILE
0722009102150159 I                                  1    9 0SSNO
0723009102150160 I                                 10   27  LNAME
0724009102150161 I                                 28   39  FNAME
0725009102150162 I                                 40   40  MI
0726009102150163 I                                 41   70  ADDR1
0727009102150164 I                                 71  100  ADDR2
0728009102150165 I                                101  115  CITY
0729009102150166 I                                116  117  STATE
0730009102150167 I                             P  118  122 0ZIP
0731009102150168 I                             P  123  124 0AREA
0732009102150169 I                             P  125  128 0PHONE
0733009102150170 I                                129  129  SEX
0734009102150174 I                                136  138 0TRUST#
0735009102150175 I                                139  141 0SUB#
0736009102150176 I                                142  145 0ACCNO
0737009102150177 I                                136  145 0TRSBAC
0738009102150179 I                                148  148  EMPST
0739009102150181 I                                155  156 0NODPND
074000050630     I                                158  158  NONEMP
0741009102150184 I                                159  159  HNDICP
0742009102150186 I                                166  166  COB
0743009102150187 I                                167  186  COBENM
0744009102150188 I                                187  201  COBPNM
0745009102150189 I                                202  211  COBP#
0746009102150190 I                                212  212  MEDICR
0747009102150191 I                                213  225  MED#
074800001018     I                                226  233 0GBSCDT
0749009102150199 I                             P  253  256 2DEPDMT
0750009102150200 I                             P  257  260 2DEPOOP
0751009102150201 I                             P  261  265 0SALARY
0752009102150212 I                                329  331  TERMCD
0753009102150213 I                                332  334  QECD
0754009102150214 I                                335  337  NTFYCD
0755009102150215 I                                338  340  CANCD
0756009102150218 I                                344  344  ELECRT
0757009102150223 I                             P  369  372 2PARPAY
0758009102150224 I                             P  373  376 2PRVBAL
0759009102150225 I                             P  377  380 2CURBAL
0760009102150226 I                             P  381  384 2PREMI
076100101216      * 12/15/10
076200101216      * fill66 field pos 429 - 494 temporarily used to store email and
076300101216      * nonssn until next member file change
076400101216     I                                429  493  memail
076500101216     I                                494  494  mnonssn
076600101216      *
0767009102150230 I                                498  498  AUTCAN
0768009108140233 I                                511  512  STATUS
0769009102150234 I                                512  512  STAT1
0770009807300171 I                                513  520 0BIRTH
0771009807300173 I                                513  516 0BYR
0772009807300172 I                                517  518 0BMO
0773000006130192 I                                521  528 0mardt
0774000006130192 I                                537  544 0MEDADT
0775009807300193 I                                545  552 0MEDBDT
0776009807300204 I                                553  560 0EMPDT
0777009807300206 I                                569  576 0CVTHDT
0778009807300208 I                                585  592 0QEDT
0779009807300209 I                                593  600 0NTFYDT
0780001009280209 I                                609  616 0eexpdt
0781009807300221 I                                625  632 0CEXPDT
0782009102150235 IMEMBERA   NS
0783009102150236 I*  MEMBER FILE  (ALPHA ALT INDEX)
0784009102150237 I                                  1    9 0SSNO
0785009102150238 I                                 10   40  LFM
0786009102150239 I                                 10   27  LNAME
0787009102150240 I                                 28   39  FNAME
0788009102150241 I                                 40   40  MI
0789009102150243 I                                136  138 0TRUST#
0790009102150244 I                                139  141 0SUB#
0791009102150245 I                                142  145 0ACCNO
0792009102150246 I                                511  512  STATUS
0793009807300171 I                                513  520 0BIRTH
0794000204170171 I                                577  584 0mtermdt
0795009102150247 IMEMACC    NS
0796009102150248 I*  MEMBER FILE  (ACCOUNT/ALPHA ALT INDEX)
0797009102150249 I                                  1    9 0SSNO
0798009102150250 I                                 10   40  MALFM
0799009102150251 I                                 10   27  LNAME
0800009102150252 I                                 28   39  FNAME
0801009102150253 I                                 40   40  MI
0802009102150254 I                                129  129  SEX
0803009102150258 I                                136  145 0MACC#
0804009102150259 I                                155  156 0NODPND
0805009102150261 I                             P  381  384 2PREMI
0806009102150262 I                                511  512  STATUS
0807009807300171 I                                513  520 0BIRTH
0808009807300173 I                                513  516 0BYR
0809009807300172 I                                517  518 0BMO
0810009807300204 I                                553  560 0EMPDT
0811000111280221 I                                625  632 0CEXPDT
081200980731     IMCOV14    NS
081300980731     I                                  1    9 0SS14
0814009807310037 I                                 12   14 0MTRUST
0815009807310038 I                                 15   17 0MSUB
0816009807310031 I                                 51   54 0MACC
0817009807310039 I                                 18   21  MPLAN
081800980731     I                                 64   64  MDLTCD
0819009210260265 IMCOV38    NS
082000910620     I                                  1   21  MCKEY
0821009102150268 I                                  1    9 0MCSSNO
0822009102150269 I                                 10   11 0MSEQ#
0823009807300272 I                                 18   21  PLAN#
0824009807300273 I                                 12   21  PLKEY
0825009102150274 I                                 22   23 0AGEBND
0826009102150275 I                                 24   26  COVTYP
0827009102150276 I                                 12   26  GRTKEY
0828009102150282 I                             P   39   42 2LPREM
0829009102150283 I                                 43   43 0CACTFL
0830009102150284 I                             P   44   47 0BENAMT
0831009102150286 I                                 64   64  DLTCD
0832009807300277 I                                 65   72 0ENRLDT
0833009807300281 I                                 73   80 0CANDT
0834009102150287 IPLNMST    NS
0835009102150288 I*  PLAN MASTER
083600090420     I                                  1    3 0PLTRST
083700090420     I                                  4    6 0PLSUB#
083800090420     I                                  7   10  PLPLAN
0839009102150289 I                                 11   50  PDESCR
0840009102150290 I                                 57   57  PABFL
0841009102150291 I                                163  165  PLNCAT
0842001008020292 I***************************     192  192  DLTCD
084300100802     I                                192  192  PDLTCD
0844009102150293 IACCMST    NS
0845009102150295 I                                 11   35  ACCNAM
0846009102150296 I                                 11   50  ACNAM1
0847009102150297 I                                 51   90  ACNAM2
0848009102150298 I                                 91  120  AADDR1
0849009102150299 I                                121  150  AADDR2
0850009102150300 I                                151  165  ACITY
0851009102150301 I                                166  167  ASTATE
0852009102150302 I                             P  168  172 0AZIP
0853009102150303 I                             P  173  174 0AAREA
0854009102150304 I                             P  175  178 0APHONE
0855009102150305 I                                179  208  CONTAC
0856009102150306 I                                209  209  FCSTFL
0857009102150307 I                             P  210  213 0NOEMPL
0858009102150308 I*  CLAIMS FIELDS  ************************************************
0859009102150309 I                             P  214  216 4TXDIS
0860009102150310 I                             P  217  219 4DISPER
0861000102070311 I                             P  220  221 0PREEX
0862000102070327 I                                222  229 0GBSBDT
0863009102150314 I                             P  234  238 2APRPAY
086400040920     I                                247  247  ASPHFL
086500041004     I                                248  248  acobsrv
0866009102150317 I                             P  249  253 2APREMI
0867009102150319 I                                294  296 0WAIT1
0868009102150320 I                                297  299 0WAIT2
0869009102150321 I                                300  302 0WAIT3
087000911016     I                                303  309 0TOTEMP
0871009102150322 I                                310  312 0AVGAGE
087200910906     I                             P  313  314 0FAXARE
0873009109060050 I                             P  315  318 0FAX#
0874009102150323 I                             P  361  420 2BAL
0875000506300323 I                             P  421  423 2COBADM
087600120514     I                                424  424  CAFIC
087700910510     I                                425  454  ECNTAC
087800911022     I                                455  455  RNSTCD
087900911016     I                                456  458 0RENAVG
088000911016     I                                462  465 0SICCOD
088100911016     I                             P  466  469 0MEDEMP
088200040716     I                                474  476  aprefx
088300040716     I                                480  482  AACOD
0884009102150324 I                                483  485  SMANCD
0885009102150325 I                                486  487 0RNEWPD
088600090413     I                                499  499  CFS834
088700160817      * the admin fee field is still named OLDT06 in the DDS
088800160817     I                                500  503  AFCODE
088900160817      *
0890009106110330 I                                512  512  ADLTCD
0891009807310312 I                                513  520 0ACVTDT
0892009807310312 I                                517  518 0AM
0893009807310326 I                                537  544 0ATRMDT
0894009807310327 I                                545  552 0ENROLL
0895009102150331 IACCMSTA   NS
0896009102150332 I                                  1   10 0ACC##
0897009102150333 I                                 11   50  ACNAM1
0898009102150334 I                                151  165  ACITY
0899009102150335 I                                166  167  ASTATE
0900009102150336 I                             P  168  172 0AZIP
0901009102150337 I                             P  173  174 0AAREA
0902009102150338 I                             P  175  178 0APHONE
0903009102150339 I                                179  203  ACONT
0904009102150340 I                                512  512  DLTCD
0905009807310326 I                                537  544 0ATERM
0906009102150341 I*
0907009102150342 ICODES     NS
0908009102150343 I*  CODES
0909009102150344 I                                  4   13  SDESCR
0910009102150345 I                                 14   43  LDESCR
0911009102150346 I                                 44   44  ACTION
0912009102150347 I                                 64   64  DLTCD
0913009102150348 IHISTALT   NS
0914009102150349 I*  TRANSACTION HISTORY FILE
0915009208170350 I                                  1   10  HACC#
0916009102150351 I                                  2   10 0HSSNO
0917009102150355 I                                 17   19  TRCODE
0918009102150356 I                             P   20   24 2TRAMT
0919009102150357 I                                 25   25  CM$FLG                  20
0920009102150358 I                                 26   55  CK#NOT
092100921116     I                                 26   26  SSBLNK
092200920817     I                                 27   29  SS1
092300920817     I                                 31   32  SS2
092400920817     I                                 34   37  SS3
0925009901150359 I                                 78   85  NOTE2Y
0926009204080360 I                                 56   78  NOTE2
0927009102150368 I                                128  128  DLTCD
0928009807310353 I                                129  136 0TRDATE
0929009903030354 I                                129  134 0TRYM
0930009807310362 I                                145  152 0RECVDT
0931009807310363 I                                153  160 0COVTDT
0932001309120367 I                                207  216  hoper
0933009102150369 IDEPEND    NS
0934000002170370 I*  DEPENDENTS FILE
0935009102150371 I                                  1    9 0DPSSNO
0936009102150372 I                                 10   11 0DSEQ#
0937009102150373 I                                 12   29  DLNAME
0938009102150374 I                                 30   41  DFNAME
0939009102150375 I                                 42   42  DMI
0940009102150376 I                                 43   72  DADDR1
0941009102150377 I                                 73  102  DADDR2
0942009102150378 I                                103  117  DCITY
0943009102150379 I                                118  119  DSTATE
0944009102150380 I                             P  120  124 0DZIP
0945009102150381 I                             P  125  126 0DAREA
0946009102150382 I                             P  127  130 0DPHONE
0947009102150383 I                                131  131  DSEX
0948009102150385 I                                138  140  DRELCD
0949009102150386 I                             P  141  145 0DEPSS#
0950009102150387 I                                146  146  DSTUDN
0951009102150388 I                                147  147  DHNDCP
0952009102150390 I                                154  154  DCOB
0953009102150391 I                                155  174  DCOBEN
0954009102150392 I                                175  189  DCOBPN
0955009102150393 I                                190  204  DCOBP#
0956009102150394 I                                205  205  DMEDCR
0957009102150395 I                                206  218  DMED#
0958009102150404 I                             P  249  252 2DEPDMT
0959009102150405 I                             P  253  256 2DEPOOP
0960009102150409 I                                320  320  DDEL
0961009807310384 I                                321  328 0DBIRTH
0962009807310389 I                                329  336 0DHDDT
0963009807310396 I                                337  344 0DMEDAD
0964009807310397 I                                345  352 0DMEDBD
0965009102150452 IGRATE     NS
0966009102150453 I*  GROUP RATE FILE
0967009102150454 I                                  1   15  GRTKEY
096800921222     I                                 24   34  GRP#11
0969009807310458 I                                 24   35  GROUP#
0970000709260459 I                                 53   63 6BILRTE
0971009807310455 I                                 65   72 0FRMDAT
0972009807310456 I                                 73   80 0TODAT
0973009102150460 I/SPACE
0974009102150480 ISMAN      NS
0975009102150481 I*  SALESMAN MASTER
0976009110170017 I                                  4   21  SLNAME
0977009110170018 I                                 22   33  SFNAME
0978009110170019 I                                 34   34  SMI
0979009102150482 I                                 93   95  STYPE
0980009407290111 IAPLNP     NS
0981009407290113 I                                  1   10 0AACCT#
0982009807310113 I                                 11   14  PRIPLN
098300980731     I                                 15   18  CP1
098400980731     I                                 19   22  CP2
098500980731     I                                 23   26  CP3
098600980731     I                                 27   30  CP4
098700980731     I                                 31   34  CP5
098800980731     I                                 35   38  CP6
098900980731     I                                 39   42  CP7
099000980731     I                                 43   46  CP8
099100980731     I                                 47   50  CP9
099200980731     I                                 51   54  CP10
099300980731     I                                 55   58  CP11
099400980731     I                                 59   62  CP12
099500980731     I                                 63   66  CP13
099600980731     I                                 67   70  CP14
099700980731     I                                 71   74  CP15
099800980731     I                                 75   78  CP16
099900980731     I                                 79   82  CP17
100000980731     I                                 83   86  CP18
100100980731     I                                 87   90  CP19
100200980731     I                                 91   94  CP20
100300980731     I                                 95   98  PP1
100400980731     I                                 99  102  PP2
100500980731     I                                103  106  PP3
100600980731     I                                107  110  PP4
100700980731     I                                111  114  PP5
100800980731     I                                115  118  PP6
100900980731     I                                119  122  PP7
101000980731     I                                123  126  PP8
101100980731     I                                127  130  PP9
101200980731     I                                131  134  PP10
101300980731     I                                135  138  PP11
101400980731     I                                139  142  PP12
101500980731     I                                143  146  PP13
101600980731     I                                147  150  PP14
101700980731     I                                151  154  PP15
101800980731     I                                155  158  PP16
101900980731     I                                159  162  PP17
102000980731     I                                163  166  PP18
102100980731     I                                167  170  PP19
102200980731     I                                171  174  PP20
102300131212    * *
102400150515     C     isskeym       KLIST
102500150515     C                   KFLD                    trust#
102600150515     C                   KFLD                    sub#
102700150515     C                   KFLD                    accno
102800150515     C                   KFLD                    ssno
102900150515    * *
103000150515     C     isskeya       KLIST
103100150515    ?C                   Kfld                    Trust
103200150515    ?C                   Kfld                    Sub
103300150515    ?C                   Kfld                    Acc
103400150515    * *
103500150515     C     plxkey        KLIST
103600150515     C                   KFLD                    c_mctrst
103700150515     C                   KFLD                    c_mcsub#
103800150515     C                   KFLD                    c_mcplan
103900131213    * *
104000131213     C     mc2keyb       KLIST
104100131213     C                   KFLD                    ssno
104200131213     C                   KFLD                    b_mctrst
104300131213     C                   KFLD                    b_mcsub#
104400131213     C                   KFLD                    b_mcplan
104500131213     C                   KFLD                    b_enrldt
104600131213    * *
104700131213     C     mc2keya       KLIST
104800131213     C                   KFLD                    ssno
104900131213     C                   KFLD                    a_mctrst
105000131213     C                   KFLD                    a_mcsub#
105100131213     C                   KFLD                    a_mcplan
105200131213     C                   KFLD                    a_enrldt
105300160104    * *
105400160104    * * Set the library list based on the TSA/SSN
105500160104     C                   Exsr      SETLIBL
105600131213    * *
1057009102150608 C/EJECT
1058009102150625 C*
1059009102150627 C*  END ON COMMAND 7
1060009102150628 C*
1061009102150629 C   KG              SETOFF                                       010203
1062009102150630 C   KG              SETOFF                                       040506
1063009109090631 C   KG              SETOFF                                       074647
1064000004060632 C** KGDSPLY2        REL       TERM
1065000004060632 C   KG              move      *on           *inlr
106600910909     C   KG              GOTO      END
1067009102150633 C*
106800941206     C* CLEAR TRANSACTION DATE FROM HISTORY KEY AND DATA STRUCTURE
106900941206     C*
107000010316     C   KA              MOVE      *ZEROS        SAVTR#
107100941206     C   KA              MOVE      *BLANKS       TRD78
107200941206     C   KA              MOVE      *BLANKS       SHMM
107300941206     C   KA              MOVE      *BLANKS       SHDD
107400941206     C   KA              MOVE      *BLANKS       SHYY
107500090521     C   KA              Z-ADD     0             TRDFLG
107600090521     C   KA              EXSR      CLRF5KEY
1077009408030651 C*
107800010316     C   KX              MOVE      *ZEROS        SAVTR#
107900941206     C   KX              MOVE      *BLANKS       TRD78
108000941206     C   KX              MOVE      *BLANKS       SHMM
108100941206     C   KX              MOVE      *BLANKS       SHDD
108200941206     C   KX              MOVE      *BLANKS       SHYY
108300941206     C   KX              Z-ADD     0             TRDFLG
1084009412060651 C*
1085009412060651 C*
108600940803     C   70
108700940803     CAN KA              EXSR      #ACCNT
108800940803     C   70
108900940803     CAN KA              GOTO      END
109000940803     C*
109100971216     C   34              SETOFF                                       34
1092009412050651 C*
109300941205     C* EXECUTE SUBROUTINE TO DISPLAY HISTORY BY TRANSACTION DATE
109400941205     C* GLC 12/94
109500941205     C* IF A TRANSACTION DATE IS ENTERED, USE THAT DATE TO DISPLAY
109600941205     C* IF A DATE IS NOT ENTERED, DISPLAY TRANSACTIONS NORMALLY
109700941205     C* IN NEWEST TO OLDEST FASHION.(#ACCNT SUB)
109800941205     C*
109900010319     C   78SHMM          IFNE      0
110000941205     C                   MOVE      SHMM          SHMM1
110100941205     C                   MOVE      SHDD          SHDD1
110200941205     C                   MOVE      SHYY          SHYY1
110300941205     C                   MOVE      TRD78         SAVTR#
110400941205     C                   EXSR      #ACCN2
110500941205     C                   Z-ADD     1             TRDFLG
110600941205     C                   GOTO      END
110700941205     C                   ELSE
110800010316     C                   MOVE      *ZEROS        SAVTR#
110900941205     C                   EXSR      #ACCNT
111000941205     C                   Z-ADD     0             TRDFLG            1 0
111100941205     C                   GOTO      END
111200941205     C                   END
111300941205     C*
111400940803     C   71
111500940803     CAN KA              SETOFF                                       98
111600940803     C   71
111700940803     CAN KA              MOVE      *BLANKS       SL
111800940803     C   71
111900940803     CAN KA              EXCEPT    SCRN08
112000940803     C   71
112100940803     CAN KA              GOTO      END
112200940803     C*
1123009102150634 C*  RETURN TO SCREEN 1 ON CMD 1
1124009102150635 C*
1125009102150636 C   KA              SETOFF                                       081617
1126009411300637 C   KA              SETON                                        99
1127009102150638 C   KA              GOTO      END
1128009102150639 C*
1129009102150640 C*  EXECUTE SUBROUTINE FOR SCREEN ENTERED
1130009102150641 C*
1131009102150642 C   01              EXSR      #RTRV
1132009102150643 C   02              EXSR      #SUMRY
113300011228
113400011228     C                   IF        *INKB = *ON
113500011228     C                   IF        DSP_OO39 = *OFF
1136000112280644 C                   EXSR      #DTAIL
113700011228     C                   EVAL      *INKB = *OFF
113800011228     C                   GOTO      END
113900011228     C                   ELSE
114000011228      *?IF THIRD SCREEN HAS BEEN DISPLAYED THEN DISPLAY FIRST SCREEN
114100011228     C                   EVAL      DSP_OO39 = *OFF
114200011228     C                   EVAL      *INKB = *OFF
1143000112280644 C                   EXSR      #DTAIL
114400011228     C                   GOTO      END
114500011228     C                   END
114600011228     C                   END
114700011228
1148009102150644 C   03              EXSR      #DTAIL
1149009102150645 C   04              EXSR      #ASUM
1150009102150646 C   05              EXSR      #ADTL
1151009102150647 C   06              SETOFF                                           08
1152009102150648 C   06              EXSR      #MEMBR
1153009102150649 C   07              SETOFF                                           08
1154009102150650 C   07              EXSR      #MEMBR
115500940729     C*
115600941130     C*
1157009407290306 C   70              EXSR      #PRC08
1158009407290308 C   70              GOTO      END
115900940729     C*
116000940729     C   71              EXSR      #PRC09
116100940729     C   71              GOTO      END
116200940729     C*
1163009109090626 C*
116400941206     C   46TRDFLG        IFEQ      0
116500941206     C                   EXSR      #ACCNT
116600941206     C                   ELSE
116700941206     C                   EXSR      #ACCN2
116800941206     C                   END
116900910909     C*
117000941206     C   47TRDFLG        IFEQ      0
117100941206     C                   EXSR      #ACCNT
117200941206     C                   ELSE
117300941206     C                   EXSR      #ACCN2
117400941206     C                   END
117500910807     C                   SETOFF                                       4647
1176009102150652 C     END           TAG
117700010316     C                   SETOFF                                       3536
117800940729     C   KA              SETOFF                                       KA
117900911001     C   KG              SETOFF                                       KG
118000911022     C   KX              SETOFF                                       KX
118100941130     C   KV              SETOFF                                       KV
118200911022     C   KW              SETOFF                                       KW
118300120620     C   KY              SETOFF                                       KY
1184009102150653 C*
1185009102150654 C****************************************************************
1186009102150655 C*  END OF MAINLINE CALCULATIONS                                *
1187009102150656 C****************************************************************
1188009102150657 C/EJECT
1189009102150658 C****************************************************************
1190009102150659 C*
1191009102150660 C*----------------------- RETRIEVE -----------------------------*
1192009102150661 C*
1193009102150662 C     #RTRV         BEGSR
1194009102150663 C*
1195009709291062 C***************************************************************
1196009709291221 C* SECURITY SUBROUTINE
119700970929     C                   EXSR      $SECAL
119800970929     C* TRUST SECURITY
119900970929     C     NOS           IFEQ      'N'
120000970929     C                   Z-ADD     8             X
1201009709290900 C                   SETON                                        1150
1202009709290901 C                   EXCEPT
1203009709290902 C                   SETOFF                                       1150
1204009709290903 C                   GOTO      #ENDR
120500970929     C                   END
1206009709291062 C***************************************************************
1207009102150664 C* EXECUTE MEMBER ROUTINE IF SS# ENTERED
1208009102150665 C                   Z-ADD     *ZERO         HCOUNT
1209009102150666 C*
1210009102150667 C     SSNO          IFNE      0
1211009102150668 C                   EXSR      #MEMBR
1212009102150669 C                   GOTO      #ENDR
1213009102150670 C                   END
1214009102150671 C*
1215009102150672 C*
1216009102150673 C* EXECUTE SUMMARY ROUTINE IF LAST NAME ENTERED
1217009102150674 C*     *** FUTURE ***
1218009102150675 C     SLNAME        IFNE      *BLANKS
1219009102150676 C                   EXSR      #MALPH
1220009102150677 C                   GOTO      #ENDR
1221009102150678 C                   END
1222009102150679 C*
1223009102150680 C*
1224009102150681 C* EXECUTE ACCOUNT ROUTINE IF ACC# ENTERED
1225009102150682 C*
1226009102150683 C     ACC#          IFNE      0
1227009102150684 C                   SETOFF                                       0910
122800910807     C                   MOVE      *BLANKS       AMS
122900911028     C                   MOVE      *BLANKS       KXFLAG
1230009102150685 C                   EXSR      #ACCNT
1231009102150686 C                   GOTO      #ENDR
1232009102150687 C                   END
1233009102150688 C*
1234009102150689 C*
1235009102150690 C* EXECUTE ACCOUNT SUMMARY ROUTINE IF ACC NAME ENTERED
1236009102150691 C*     *** FUTURE ***
1237009102150692 C     SACNAM        IFNE      *BLANKS
1238009102150693 C                   SETOFF                                       0910
1239009102150694 C                   EXSR      #AALPH
1240009102150695 C                   GOTO      #ENDR
1241009102150696 C                   END
124200020404
124300020404
124400020404     c* call iq012 to list accounts that contain the text entered
124500020404
1246000204050692 C                   if        sacnmcont <> *BLANKS
1247000204050684 C                   SETOFF                                       0910
124800020404     c                   move      *blanks       parmtsa          10
124900020404     c                   move      sacnmcont     parmname         30
125000020409     c                   move      sactive       parmactive        1
125100020405     c                   clear                   sacnmcont
125200020409     c                   clear                   sactive
1253000204040694 C                   call      'IQ012'
125400020404     c                   parm                    parmtsa
125500020404     c                   parm                    parmname
125600020409     c                   parm                    parmactive
125700020404
125800020404     c* move returned account # from iq012 to "ACC#" field just as if
125900020404     c* if were entered on the first screen and run the same routine.
126000020404
126100020404     c                   if        parmtsa <> *blanks
126200020404     c                   move      parmtsa       acc#
126300020404     C                   MOVE      *BLANKS       AMS
126400020404     C                   MOVE      *BLANKS       KXFLAG
126500160108    * * On return from IQ012 reset the *libl
126600160108     C                   Exsr      SETLIBL
1267000204040685 C                   EXSR      #ACCNT
1268000204040695 C                   GOTO      #ENDR
126900020405     c                   else
127000020405     c* return to screen 1 w/o error msg
1271000204050701 C                   SETON                                        11
1272000204050702 C                   EXCEPT
1273000204050703 C                   SETOFF                                       11
1274000204050695 C                   GOTO      #ENDR
127500020404     c                   end
1276000204040696 C                   END
127700050613      ************
1278000506130697  * F6 - alt ID inq
1279000506160697  * *in87 *on = user has display access only, do not allow this function
1280000506160697  *
1281000506160692 C                   if        *inKF and *in87 = *off
1282000506130684 C                   SETOFF                                       0910
128300050613     c                   move      *blanks       parmssn           9
1284000506130694 C                   call      'IQ013'
128500050613     c                   parm                    parmssn
128600050613     c* move returned SSN from iq013 to SSN field just as if
128700050613     c* if were entered on the first screen and run the same routine.
128800050613
128900050613     c                   if        parmssn <> *blanks
129000050613     c                   move      parmssn       ssno
129100160108    * * On return from IQ013 reset the *libl
129200160108     C                   Exsr      SETLIBL
1293000506130668 C                   EXSR      #MEMBR
1294000506130695 C                   GOTO      #ENDR
129500050613     c                   else
129600050613     c* return to screen 1 w/o error msg
1297000506130701 C                   SETON                                        11
1298000506130702 C                   EXCEPT
1299000506130703 C                   SETOFF                                       11
1300000506130695 C                   GOTO      #ENDR
130100050613     c                   end
1302000506130696 C                   END
130300050613
130400050613      ************
130500050613
1306009102150697 C*
1307009102150698 C* REDISPLAY SCREEN IO01 IF NO ENTRY
1308009102150699 C*
1309009102150700 C                   Z-ADD     3             X
1310009102150701 C                   SETON                                        1150
1311009102150702 C                   EXCEPT
1312009102150703 C                   SETOFF                                       1150
1313009102150704 C*
1314000204170705 C     #ENDR         ENDSR
1315009102150706 C/EJECT
1316009102150707 C****************************************************************
1317009102150708 C*
1318009102150709 C*--------------------- SUMMARY DISPLAY ------------------------*
1319009102150710 C*
1320009102150711 C     #SUMRY        BEGSR
1321009102150712 C*
1322009102150713 C* ALPHA SELECT OR ROLL
1323009102150714 C*
1324009102150715 C                   DO        19            Y
1325009102150716 C     SEL(Y)        IFNE      ' '
1326009102150717 C                   MOVE      SS(Y)         SSNO
1327000103210742 C                   MOVE      SSNO          SSNO03
1328009102150718 C                   EXSR      #MEMBR
132900020417     c                   clear                   smemactive
1330009102150719 C                   GOTO      #ENDMS
1331009102150720 C                   END
1332009102150721 C                   END
1333009102150722 C*
1334009102150723 C     SLN           IFNE      ' '
1335009102150724 C                   MOVE      *BLANKS       SAVNAM
1336009102150725 C                   MOVEL     SLN           SAVNAM
1337009102150726 C                   MOVE      *BLANKS       SLN
1338009102150727 C                   END
1339009102150728 C*
1340009102150729 C                   EXSR      #MALPH
1341009102150730 C*
1342009102150731 C     #ENDMS        ENDSR
1343009102150732 C/EJECT
1344009102150733 C****************************************************************
1345009102150734 C*
1346009102150735 C*----------------------- DTAIL --------------------------------*
1347009102150736 C*
1348009102150737 C     #DTAIL        BEGSR
1349009102150738 C*
1350009102150739 C* IF NEW SS# ENTERED RETRIEVE NEM MEMBER  - ELSE DISPLAY SCREEN 1
1351009102150740 C*
1352009102150741 C     SSNO          IFNE      SSNO03
1353000103160741 C     SSNO03        ANDNE     *ZEROS
1354009102150742 C                   MOVE      SSNO03        SSNO
1355009102150743 C                   SETOFF                                       08
1356009903030744 C                   MOVE      *ZEROS        SAVTYM            6 0
135700090521     C                   EXSR      CLRF5KEY
1358009102150745 C                   EXSR      #MEMBR
1359009102150746 C                   GOTO      #DTT01
1360009102150747 C*
1361009102150748 C                   ELSE
136200121212
136300121212      * show depend & DCOV info if a dep # was entered and simulate pressing
136400121212      * F12 to keep dependent list on screen
1365001212120749 C                   if        dpseq# <> 0
136600121212     c                   clear                   parmssno          9
136700121212     c                   movel     ssno          parmssno
136800121212     c                   clear                   parmseq           2
136900121212     c                   movel     dpseq#        parmseq
1370001212120777 C                   CALL      'IQ014CL'
1371001212120777 C                   PARM                    parmssno
1372001212120777 C                   PARM                    parmseq
137300121212     c                   clear                   dpseq#
137400121219      * simulate pressing F12 to refresh screen
137500121212     c                   eval      *inkl = *on
1376009102150759 C                   END
137700121212
1378009102150760 C*
1379009102150761 C*        RETURN TO ACCOUNT INQUIRY FROM MEMBER INQUIRY.....
1380009102150762 C*
1381009102150763 C   KY              Z-ADD     TRSBAC        ACC#
1382009106070764 C   KY              SETOFF                                         0810
1383009102150765 C   KY              EXSR      #ACCNT
1384009102150766 C   KY              GOTO      #DTT01
1385009102150768 C*
1386009102150769 C*
1387009102150770 C* IF CMD 5  DISPLAY ADDITIONAL COVERAGES AND EXIT
1388009102150771 C*
1389009102150772 C   KE              EXSR      #COVER
1390009102150773 C   KE              GOTO      #DTT01
1391009102150774 C*
1392009102150775 C*   IF CMD9 DISPLAY COB & COBRA DATA SCREENS.....
1393009102150776 C*
139400041006     c                   if        *inki
1395000410060777 C     PRVBAL        ADD       CURBAL        TOTBAL            7 2
1396000410060778 C     QECD          CHAIN     CODES                              96
139700041006
1398000410060779 C  N96              MOVE      LDESCR        QEDSC            30
1399000410060780 C     NTFYCD        CHAIN     CODES                              96
140000041006
1401000410060781 C  N96              MOVEL     LDESCR        NTFYDS           30
1402000410062701
140300041006      * employment status desc
1404001706162702 C                   MOVE      *BLANKS       CDKEY
1405001706162703 C                   MOVE      'J'           CDTYPE
1406001706162704 C                   MOVE      EMPST         CD3
140700170616     C     CDKEY         CHAIN     CODES
140800170616     c                   if        not %found(codes)
1409001706162705 C                   clear                   empstdes         30
141000170616     c                   else
141100170616     c                   movel     ldescr        empstdes
141200170616     c                   end
141300041008
141400080429     C                   Eval      AltType   =   'GBS'
141500080429     C     AltKey        Chain     MEMALTL3
141600080429     C                   If        %Found(MEMALTL3)
141700080429     C                   Eval      ALTID     =   %Trim(MAALTID)
141800080429     C                   Else
141900080504     C                   Clear                   ALTID            20
142000080429     C                   End
142100090513      *
142200090513      * show subsidy dates
142300170616      * 06/16/17 - no longer needed
142400210416      * 04/16/21 - needed again
142500210416     c                   move      99999999      allnines
142600210416     c                   move      1             subcnt            1 0
142700210416     c                   clear                   subdt1           25
142800210416     c                   clear                   subdt2           25
142900210416     C     subsidkey     setll     submem
143000210416     c                   dou       %eof(submem) or subcnt > 2
143100210416     c     ssno          readpe    submem
143200210416     c                   if        not %eof(submem)
143300210416     C                   MOVE      smfrdt        @DATIN
143400210416     C                   EXSR      #DATYM
143500210416     C                   MOVE      @datou        wkfrdt            8 0
143600210416     C                   MOVE      smtodt        @DATIN
143700210416     C                   EXSR      #DATYM
143800210416     C                   MOVE      @datou        wktodt            8 0
143900210416     c                   select
144000210416     c                   when      subcnt = 1
144100210416       subdt1 = %trim(%editw(wkfrdt:'0  /  /    ')) + ' - ' +
144200210416                %trim(%editw(wktodt:'0  /  /    '));
144300210416     c                   add       1             subcnt
144400210416     c                   when      subcnt = 2
144500210416       subdt2 = %trim(%editw(wkfrdt:'0  /  /    ')) + ' - ' +
144600210416                %trim(%editw(wktodt:'0  /  /    '));
144700210416     c                   add       1             subcnt
144800210416     c                   endsl
144900210416     c                   end
145000210416     c                   enddo
145100090513
145200090513
145300210519      *
145400210519      * get cobra paid through date
145500210519      *
145600210519       clear cptdtmdy;
145700210519       parmssn = %editc(ssno:'X');
145800210519       parmcptdate = *blanks;
145900210520       parmcitdate = *blanks;
146000211001       parmcinv    = *zeros;
146100211001       parmcadj    = *zeros;
146200211001       parmcpay    = *zeros;
146300210520       parmcpayovr = *blanks;
1464002105190694 c                   call      'GETPTCCL'
146500210519     c                   parm                    parmssn           9
146600210519     c                   parm                    parmcptdate       8
146700210520     c                   parm                    parmcitdate       8
146800211001     c                   parm                    parmcinv         11 2
146900211001     c                   parm                    parmcadj         11 2
147000211001     c                   parm                    parmcpay         11 2
147100210520     c                   parm                    parmcpayovr       1
147200210519
147300210519     c                   if        parmcptdate <> '00000000'
147400210519     C                   MOVE      parmcptdate   @DATIN
147500210519     C                   EXSR      #DATYM
147600210519     C                   MOVE      @DATOU        cptdtmdy
147700210519     c                   end
147800210519
147900210519
148000210519
1481000410060782 C                   EXCEPT    SCRN26
1482000410060783 C                   GOTO      #DTT01
148300041006     c                   end
148400041006
1485000201080774 C*
1486009802030775 C* CMD10 CALL PCP FILE MAINT PGM (IF USER IS NOT DISPLAY ONLY)
1487009711030776 C*
148800020108     C                   if        iscdsph = 'N'
148900020108
1490009711030777 C   KJ              MOVE      SSNO          SSNHLD            9
1491009711030777 C   KJ              CALL      'FM330CL'
1492009711030777 C                   PARM                    SSNHLD
1493009711030743 C   KJ              SETOFF                                       08
149400020108
149500111024     C*
149600111024     C* F6 Benefit Summary
149700111024     C*
149800111024     C                   If        *inkf = *on  and
149900130304     C                             pysts <> *blanks
150000111024     C                   z-add     ssno          inq_ssno
150100111024    ?C                   Call      'INQBSMCL'                           99
150200111024    ?C                   Parm                    TRUST#
150300111024    ?C                   Parm                    SUB#
150400111024    ?C                   Parm                    ACCNO
150500111024    ?C                   Parm                    INQ_SSNO
1506001110240743 C                   SETOFF                                       08
1507001110240743 C                   Eval      *inkf = *off
1508001110240486 C                   clear                   MC4K5             4
1509001110240486 C                   clear                   MC4K6             2 0
1510001110240486 C                   clear                   MC4K7             3
1511001110240486 C                   clear                   MC4K8             8 0
151200111024     C                   Else
1513001110240743 C                   Eval      *inkf = *off
1514001110240743 C*** causes hst not SETOFF to scroll ?                           08
1515001110240486 C                   clear                   MC4K5             4
1516001110240486 C                   clear                   MC4K6             2 0
1517001110240486 C                   clear                   MC4K7             3
1518001110240486 C                   clear                   MC4K8             8 0
151900111024     C                   End
152000111024
1521001105050774 C*
1522001105050775 C* F11 call debit card MAINT PGM (IF USER IS NOT DISPLAY ONLY)
1523001105050776 C*
152400110505     c                   if        *inkk
1525001105050777 C                   MOVE      SSNO          SSNHLD            9
1526001105050777 C                   CALL      'FM430CL'
1527001105050777 C                   PARM                    SSNHLD
1528001105050743 C                   SETOFF                                       08
152900110505     c                   end
1530001312130860 C* IF CMD 21  DISPLAY ACA Premiums
153100131212      *
153200131213     c                   if        *inkv = '1' and *in77 = '1'
153300131212     c                   move      *blanks       ssnaca            9
153400131212     c                   move      ssno          ssnaca
153500131212     c                   call      'IQ015CL'
153600131212     c                   parm                    ssnaca
1537001312130743 C                   SETOFF                                       08
153800131212     c                   end
153900110505
154000150515     C*
154100150515     C* F8 call issue tracking pgm
154200150515     C*
154300141016     c                   if        *inkh
154400150515     C                   MOVE      keyacc        pitsa
154500150515     C                   MOVE      SSNO          pissn
154600150515     C                   CALL      'IQ016CL'
154700150515     C                   PARM                    parmiss
154800150515     C                   SETOFF                                       08
154900121106     c                   end
155000121106
155100150515     C*
155200150515     C* F13 call enhanced member coverage pgm
155300150515     C*
155400141016     c                   if        *inkm
155500150515     C                   MOVE      keyacc        tsahld           10
155600150515     C                   MOVE      SSNO          SSNHLD            9
155700150515     C                   CALL      'IQC070'
155800150515     C                   PARM                    tsahld
155900150515     C                   PARM                    SSNHLD
156000150515     C                   SETOFF                                       08
156100141016     c                   end
156200141016
156300150515     C* CMD4  CALL Diary Note FILE MAINT PGM (if user is not display only)
156400020108
156500020103     c                   if        *inkd
156600150515     C                   MOVE      SSNO          SSNHLD
156700020103     C                   EVAL      @@IFC = 'I' + SSNHLD
156800150515     C                   CALL      'TR121CL'
156900150515     C                   PARM                    @@IFC            11
1570000203150743 C                   SETOFF                                       08
157100020103     c                   end
157200020108
157300020108     C                   endif
1574000201030784 C*
1575009711030784 C*
1576009902080788 C* IF CMD 12  DISPLAY DEPENDENTS
1577009902080789 C* *IN56 = POSITION CURSOR FOR DEPEND SELECTION
1578009902080861 C* REDISPLAY MEM SCREEN(IO03) TO ACCEPT POSITION CURSOR(*IN56)
1579009902080861 C* REDISPLAY MEM COV SCREEN(OO25)
1580009902080789 C*
158100011128     c                   if        *inkl
158200010323     C                   Move      'D'           F12               1
158300990208     C                   SETON                                        561325
158400990208     C                   EXCEPT
158500990208     C                   SETOFF                                         1325
1586009902080790 C                   EXSR      #DEPND
1587009902080791 C                   GOTO      #DTT01
158800990208     C                   END
158900010316     C*
1590000103190808 C                   EXSR      #MEMBR
1591009102150809 C     #DTT01        TAG
1592009102150810 C                   END
159300990208     C                   SETOFF                                       56
1594009102150811 C*
1595009102150812 C                   ENDSR
1596009102150813 C/EJECT
1597009102150814 C****************************************************************
1598009102150815 C*
1599009102150816 C*-------------------- ACCOUNT SUMMARY -------------------------*
1600009102150817 C*
1601009102150818 C     #ASUM         BEGSR
1602009102150819 C*
1603009102150820 C* ALPHA SELECT OR ROLL
1604009102150821 C*
1605009102150822 C                   DO        19            Y
1606009102150823 C     SEL(Y)        IFNE      ' '
1607009102150824 C                   MOVE      SS(Y)         ACC#
1608009102150825 C                   EXSR      #ACCNT
1609009102150826 C                   GOTO      #ENDAS
1610009102150827 C                   END
1611009102150828 C                   END
1612009102150829 C*
1613009102150830 C     SLN           IFNE      ' '
1614009208130831 C                   MOVE      *BLANKS       SAVACC           40
1615009102150832 C                   MOVEL     SLN           SAVACC
1616009102150833 C                   MOVE      *BLANKS       SLN
1617009102150834 C                   END
1618009102150835 C*
1619009102150836 C                   EXSR      #AALPH
1620009102150837 C*
1621009102150838 C     #ENDAS        ENDSR
1622009102150839 C/EJECT
1623009102150840 C****************************************************************
1624009102150841 C*
1625009102150842 C*-------------------- ACCOUNT DETAIL --------------------------*
1626009102150843 C*
1627009102150844 C     #ADTL         BEGSR
1628009902080861 C*
1629009902080861 C* 57 = POSITION CURSOR TO MEMBER SELECT
1630009902080861 C*
1631009902080862 C                   SETOFF                                       57
1632009902050738 C*
1633009902050739 C* IF NEW ACC# ENTERED DISPLAY NEW ACCOUNT INFO
1634009902050740 C*
1635009902050741 C     ACC#          IFNE      ACC05
1636009902050742 C                   MOVE      ACC05         ACC#
163700990205     C                   SETOFF                                       08
1638009903030744 C                   MOVE      *ZEROS        SAVTYM
1639009902050745 C                   EXSR      #ACCNT
1640009902050746 C                   GOTO      #ENDAD
164100990205     C                   END
1642009902050747 C*
1643009102150845 C*
1644009102150846 C* IF MEMBER SELECTED FOR DISPLAY - PROCESS THEN EXIT
1645009102150847 C*
164600910607     C                   MOVE      *BLANKS       ALFLAG            1
164700910607     C     SALPH         IFGT      *BLANKS
164800910607     C                   MOVE      *BLANKS       SAV31
164900910607     C                   MOVEL     SALPH         SAV31            31
165000910607     C                   MOVE      'Y'           ALFLAG
165100910611     C                   MOVE      *BLANKS       SALPH
165200910807     C*
165300910611     C     ACC#          CHAIN     ACCMST                             98
165400990208     C* DISPLAY IO05
165500990208     C                   EXSR      #DSP05
165600910607     C                   EXSR      #AMEM
165700910607     C                   GOTO      #ENDAD
165800910607     C                   END
165900910607     C*
1660009102150848 C     SELECT        IFNE      0
1661009102150849 C     SELECT        IFGT      11
1662009102150850 C                   MOVE      *ZEROS        SSNO
1663000103210852 C                   MOVE      *ZEROS        SSNO03
1664009102150851 C                   ELSE
1665009102150852 C                   MOVE      AMS(S)        SSNO
1666000103210852 C                   MOVE      AMS(S)        SSNO03
1667009102150853 C                   END
1668009102150854 C*
1669009102150855 C                   SETOFF                                       08
1670009903030856 C                   MOVE      *ZEROS        SAVTYM
1671009102150857 C                   EXSR      #MEMBR
1672009102150858 C                   GOTO      #ENDAD
1673000103210859 C                   ELSE
1674000103210852 C                   MOVE      *ZEROS        SSNO03
1675009102150859 C                   END
167600010402
1677000201030767 C*
1678001505150    C* CMD4  CALL Diary Note FILE MAINT PGM (if user is not display only)
167900150515     C*
168000020108     C                   if        *inkd and iscdsph = 'N'
168100020103     c                   move      acc#          parmacc#
168200020103     C                   EVAL      @@IFC = 'I' + PARMACC#
168300150515     C                   CALL      'TR121CL'
1684001505150    C                   PARM                    @@IFC
168500020108     C                   end
168600141016
168700150515     C*
168800150515     C* F8 call issue tracking pgm
168900150515     C*
169000141016     c                   if        *inkh
169100150515     C                   MOVE      acc#          pitsa
169200150515     C                   eval      pissn = '000000000'
169300150515     C                   CALL      'IQ016CL'
1694001505150    C                   PARM                    parmiss
1695001410160743 C                   SETOFF                                       08
169600141016     c                   end
169700010330
1698001401150860 C* IF CMD 09  DISPLAY commission RECORDS
169900010402     c* New Commission Control display: subfile in IQ011
170000010330
170100010330     c                   if        *inki
170200010330     c                   move      acc#          parmacc#
170300080812     c                   call      'IQ011CL'
170400010330     c                   parm                    parmt
170500010330     c                   parm                    parms
170600010330     c                   parm                    parma
170700010330     c                   end
170800131212
170900010330
1710001206200860 C* F24 Senior Dental Writeoff Balance: for termed SD accounts only
171100120620
171200120620     C                   If        ATRMDT < *DATE  AND  ATRMDT <> *Zero
171300120620     C                   If        *InKY
171400120620     C                   Move      ACC#          BenKey
171500120620     C                   Eval      SWTRST = Trust
171600120620     C                   Eval      SWSUB# = Sub
171700120620     C                   Eval      SWACCT = Acc
171800120620     C                   Eval      SWINDT = *Zeros
171900120620     C                   Eval      SWSEQ# = *Zeros
172000120620     C                   Eval      SWWOBA = *Zeros
172100120620     C                   Call      'WRKSWBCL'
172200120620     C                   Parm                    WADTA
172300120620     C                   End
172400120620     C                   End
172500120620
1726009902080861 C*
172700011128     c                   if        *inkl or *inkm
172800990208     C*
1729009902080860 C* IF CMD 12  DISPLAY MEMBERS AND EXIT
1730009902080861 C*   57 = POSITION CURSOR TO MEMBER SELECT
1731009902080861 C* REDISPLAY ACCT SCREEN(IO05) TO ACCEPT POSITION CURSOR(*IN57)
1732009902080861 C*
173300010323     C                   Move      'M'           F12               1
1734009902080862 C                   SETON                                        1557
1735009902080862 C                   EXCEPT
1736009905200862 C                   SETOFF                                       1557
1737009902080862 C                   EXSR      #AMEM
1738009902080863 C                   GOTO      #ENDAD
173900990208     C                   END
1740009102150864 C*
1741009102150865 C*
174200940729     C   KK              EXSR      #PRIPL
174300940729     C   KK              GOTO      #ENDAD
1744009102150866 C* CONTINUE - IF NOT 08  THERE IS NO MORE HIST - RETURN TO FIRST SCREEN
1745009102150867 C*
174600941205     C*-----------------------------------------------------
174700941205     C  NKVTRDFLG        IFEQ      0
174800941205     C                   EXSR      #ACCNT
174900941205     C                   ELSE
175000941205     C                   EXSR      #ACCN2
175100941205     C                   END
175200941205     C* IF CMD 21 PRESSED, DISPLAY WINDOW TO ENTER TRANSACTION DATE
175300941205     C* FOR SETTING LIMITS TO HIST. FILE FOR TRANSACTION DISPLAY.
175400941205     C* 12/94-GLC.
175500941130     C   KV              EXSR      #WINDW
175600941129     C   KV              GOTO      #ENDAD
1757009902050872 C*
1758009102150873 C     #ENDAD        ENDSR
1759009102150874 C/EJECT
1760009102150875 C****************************************************************
1761009102150876 C*
17620015051508   C*-------------------- MEMBER DETAIL DISPLAY -------------------*
1763009102150878 C*
1764009102150879 C     #MEMBR        BEGSR
1765009102150880 C*
1766009709291062 C***************************************************************
1767009709291221 C* SECURITY SUBROUTINE
176800970929     C                   MOVE      *ZEROS        ST
176900970929     C                   EXSR      $SECAL
177000970929     C                   XFOOT     ST            T##
1771009709291062 C***************************************************************
177200970929     C*
177300911014     C                   SETOFF                                           31
177400911014     C*
1775009102150881 C                   Z-ADD     *ZERO         DPSEQ#
1776009102150882 C                   Z-ADD     *ZERO         HCOUNT
1777009102150883 C* COMPLETE HISTORY ROLL IF 92 IS NOT ON
1778009102150884 C*
1779009102150890 C*
1780009102150891 C   08              GOTO      #MRT01
178100010316     C                   MOVE      *ZEROS        SAVTR#
1782000103260890 C* Reset ENDROLL counter.
178300010326     C                   MOVE      *ZEROS        ENDROLL           2 0
1784009102150892 C*
1785009102150893 C* GET MEMBERRECORD
1786009102150894 C*
1787009102150895 C     SSNO          CHAIN     MEMBER                             98
1788009102150896 C*
1789009102150897 C* IF NOT THERE  - ERROR NOT FOUND
1790009102150898 C*
1791009102150899 C   98              Z-ADD     1             X                 1 0
1792009102150900 C   98              SETON                                        1150
1793009102150901 C   98              EXCEPT
1794009102150902 C   98              SETOFF                                       1150
1795009102150903 C   98              GOTO      #ENDM
1796009102150904 C*
1797009709291062 C***************************************************************
179800970929     C* TRUST SECURITY
179900970929     C     T##           IFNE      0
180000970929     C                   MOVEL     TRUST#        T#
180100970929     C     T#            LOOKUP    ST                                     33
180200971216     C  N33
180300971216     CANN70              Z-ADD     6             X
180400971216     C  N33
1805009712160900 CANN70              SETON                                        1150
180600971216     C  N33
1807009712160901 CANN70              EXCEPT
180800971216     C  N33
1809009712160902 CANN70              SETOFF                                       1150
181000971216     C  N33
1811009712160903 CANN70              GOTO      #ENDM
181200970929     C                   END
181300010516@SEC C***************************************************************
181400010516@SEC C* GBS/IO ACCOUNT SECURITY - @ SSN
181500010516@SEC C* NOTE: POSITION 1 OF SCFAX IS NOW USED FOR ALLOW GBS ACCT ACCESS.
181600010516@SEC C***************************************************************
181700010516@SEC C                   MOVEL     ISCFAX        ALLOWGBS          1
181800010516@SEC C     ALLOWGBS      IFNE      'Y'
181900010521@SEC C     KEYACC        ANDEQ     5500010016
182000010516@SEC C                   Z-ADD     6             X
182100010516@SEC C                   SETON                                        1150
182200010516@SEC C                   EXCEPT
182300010516@SEC C                   SETOFF                                       1150
182400010516@SEC C                   GOTO      #ENDM
182500010516@SEC C                   ENDIF
1826000105161062 C***************************************************************
182700970929     C*
1828009102150907 C* FLASH STATUS TEXT IF NOT ACTIVE
1829009102150908 C*
1830009102150909 C     STAT1         IFEQ      'A'
1831009102150910 C                   SETOFF                                       89
1832009102150911 C                   ELSE
1833009102150912 C                   SETON                                        89
1834009102150913 C                   END
183500140409
183600140409     C* highlight "NAME" on screen if longer name exists (*in83=*on)
183700140409     C     CFSKEY        klist
183800140409    ?C                   kfld                    SSNO
183900140409    ?C                   kfld                    CFSEQ
184000140409     C     CFSKEY        Chain     CFS100P
184100140409     C                   if        %found(CFS100P)
184200140409     C                   eval      *in83 = *on
184300160928     C                   if        %trim(CFSMID) <> *blanks
184400160928     C                   eval      N = %trim(CFSFST) + ' ' +
184500160928     C                             %trim(CFSMID) + ' ' +
184600160928     C                             %trim(CFSLST)
184700160928     C                   else
184800160928     C                   eval      N = %trim(CFSFST) + ' ' +
184900160928     C                             %trim(CFSLST)
185000160928     C                   end
185100140409     C                   else
185200140409     C                   eval      *in83 = *off
185300140409     C                   end
185400140409
185500140409      *
1856001404090907 C* highlight "DIARY" on screen if diary records exists (*in85=*on)
1857001404090908 C*
185800020109     c                   clear                   diarykey         10
185900020109     c                   move      ssno          diarykey
186000020109     c     diarykey      chain     diaryhd1
186100020109     c                   if        %found(diaryhd1)
186200020109     c                   eval      *in85 = *on
186300020109     c                   else
186400020109     c                   eval      *in85 = *off
186500020109     c                   end
186600111024
186700111024     C* highlight "BENSUM"  screen if payroll client (*in86=*on)
186800111024     C*
186900111024     c                   eval      *in86 = *off
187000111024     C     PAYSSN        klist
187100111024    ?C                   kfld                    TRUST#
187200111024    ?C                   kfld                    SUB#
187300111024    ?C                   kfld                    ACCNO
187400111024    ?C                   kfld                    INQ_SSNO
187500111024     C                   z-add     ssno          INQ_SSNO
187600111024     C     PayKey        Klist
187700111024    ?C                   Kfld                    Trust#
187800111024    ?C                   Kfld                    Sub#
187900111024    ?C                   Kfld                    Accno
188000160831     C**   PayKey        Chain     ACCMSP
188100160831     C**                 If        %Found(ACCMSP)
188200160104     C**                 If        %trim(AMPAYR) <> *blanks  and
188300160104     C**                           %trim(AMPAYR) <> 'PAYR'
188400111024     C     PAYSSN        Chain     WEBPAYROLL
188500111024     C                   If        %found(WEBPAYROLL)
188600111024     C                   eval      *in86 = *on
188700111024     C                   End
188800160104     C**                 End
188900160831     C**                 End
1890009102150914 C*
1891009102150915 C*
1892009102150916 C* GET ACCOUNT NAME *********************************************
1893009102150917 C*
1894009102150918 C     KEYACC        CHAIN     ACCMST                             98
1895009102150919 C  N98              MOVEL     ACCNAM        NAMEO            25
1896009102150920 C*
1897009102150921 C*
1898009102150922 C* GET DESCRIPTIONS FOR SCREEN DISPLAY
1899009102150923 C*
1900009102150924 C* STATUS DESCRIPTION.
1901009102150925 C*
1902009102150926 C                   MOVE      'S'           CDTYPE
1903009102150927 C     CDKEY         CHAIN     CODES                              98
1904009102150928 C  N98              MOVE      LDESCR        STDESC           30
1905009102150929 C*
1906009102150947 C*
1907009807310948 C     *YEAR         SUB       BYR           AGE               3 0
1908009102150949 C     UMONTH        IFNE      12
1909009902150950 C     UMONTH        IFLT      BMO
1910009102150951 C                   SUB       1             AGE
1911009102150952 C                   END
1912009102150953 C                   END
1913009102150954 C*
1914009102150955 C* EXECUTE ROUTINE TO COMPRESS NAME
1915009102150956 C*
1916009102150957 C                   EXSR      #NAMEF
1917009102150958 C*
1918009102150959 C* SET COBRA TEXT TO DISPLAY FOR COBRA MEMBER
1919009102150960 C*
1920009102150961 C     CEXPDT        IFNE      0
1921009102150962 C                   SETON                                        82
1922009102150963 C                   SETOFF                                       81
1923009102150964 C                   ELSE
1924009102150965 C                   SETON                                        81
1925009102150966 C                   SETOFF                                       82
1926009102150967 C                   END
192700980731     C*
192800980731     C                   MOVE      BIRTH         @DATIN
192900980731     C                   EXSR      #DATYM
193000980731     C                   MOVE      @DATOU        BIRTH
193100980731     C*
193200000613     C*
193300980731     C                   MOVE      EMPDT         @DATIN
193400980731     C                   EXSR      #DATYM
193500980731     C                   MOVE      @DATOU        EMPDT
193600980731     C*
193700980731     C     MEDADT        IFNE      0
193800980731     C                   MOVE      MEDADT        @DATIN
193900980731     C                   EXSR      #DATYM
194000980731     C                   MOVE      @DATOU        MEDADT
194100980731     C                   END
194200980731     C*
194300980731     C     CEXPDT        IFNE      0
194400980731     C                   MOVE      CEXPDT        @DATIN
194500980731     C                   EXSR      #DATYM
194600980731     C                   MOVE      @DATOU        CEXPDT
194700980731     C                   END
194800980731     C*
194900980731     C     MEDBDT        IFNE      0
195000980731     C                   MOVE      MEDBDT        @DATIN
195100980731     C                   EXSR      #DATYM
195200980731     C                   MOVE      @DATOU        MEDBDT
195300980731     C                   END
195400980731     C*
195500980731     C     CVTHDT        IFNE      0
195600980731     C                   MOVE      CVTHDT        @DATIN
195700980731     C                   EXSR      #DATYM
195800980731     C                   MOVE      @DATOU        CVTHDT
195900980731     C                   END
196000980731     C*
196100980731     C     QEDT          IFNE      0
196200980731     C                   MOVE      QEDT          @DATIN
196300980731     C                   EXSR      #DATYM
196400980731     C                   MOVE      @DATOU        QEDT
196500980731     C                   END
196600100928     C*
196700100928     C                   clear                   eexpdtmdy         8
196800100928     C     eexpdt        IFNE      0
196900100928     C                   MOVE      eexpdt        @DATIN
197000100928     C                   EXSR      #DATYM
197100100928     C                   MOVE      @DATOU        eexpdtmdy
197200100928     C                   END
197300980731     C*
197400980731     C     NTFYDT        IFNE      0
197500980731     C                   MOVE      NTFYDT        @DATIN
197600980731     C                   EXSR      #DATYM
197700980731     C                   MOVE      @DATOU        NTFYDT
197800980731     C                   END
197900000613     C*
198000000613     C                   MOVE      *blanks       mardtout          8
198100000613     C     mardt         IFNE      0
198200000613     C                   MOVE      mardt         @DATIN
198300000613     C                   EXSR      #DATYM
198400000613     C                   MOVE      @DATOU        mardtout
198500000613     c                   end
198600980731     C*
198700001018sz   C     GBSCDT        IFNE      0
198800001018     C                   MOVE      GBSCDT        @DATIN
198900001018     C                   EXSR      #DATYM
199000001018     C                   MOVE      @DATOU        GBSCDT
199100001018     C                   END
199200110217
199300110217      * NON-SSN indicator
199400110217     c                   if        mnonssn = 'Y'
199500110217     c                   eval      *in84 = *on
199600110217     c                   else
199700110217     c                   eval      *in84 = *off
199800110217     c                   end
199900150515      * Determine if Open Issues exist for Member
200000131213      *
200100150515     C                   eval      *in88 = '0'
200200150515      *
2003001505151490 C     isskeym       setll     itissp
200400150515     C                   dou       *IN98 = '1'
2005001505151497 C     isskeym       reade     itissp                                 98
200600150515      *
200700150515     C                   IF        *IN98 = *ON or ssno <> itmssn
2008001505151379 C                   leave
2009001505151379 C                   endif
201000150515      *
201100150515     C                   IF        itsts = 'O'
201200150515     c                   eval      *in88 = '1'
2013001505151379 C                   leave
2014001505151379 C                   endif
2015001505151380  *
2016001505151379 C                   enddo
2017001505151380  *
201800150515      * Determine if ACA plans exist
201900150515      *
202000140115     c                   clear                   acatext           6
202100140115      * *in37 = reverse image field
202200140115     C                   Eval      *in37 = *off
202300131213     C                   eval      *in77 = '0'
202400131213      *
2025001401171490 C     ssno          SETLL     MCOVC
202600131213     C                   dou       *IN97 = '1'
2027001401171497 C     SSNO          READE     MCOVC                                  97
202800131213      *
202900140117     C                   IF        *IN97 = *ON or ssno <> c_mcssno
2030001312131379 C                   leave
2031001312131379 C                   endif
203200140117      *
203300140606     C                   IF        (c_candt <> 0 and c_candt <= udate8) or
203400140606     c                              c_enrldt = c_candt
2035001401171379 C                   iter
2036001401171379 C                   endif
203700131213      *
203800131213     C                   if        *in77 = '0'
2039001312131378 C     Plxkey        CHAIN     plnauxp                            98
204000140115      * this is an aca account
204100140115      * *in37 = reverse image field
204200150226     C                   if        (*in98 = '0' and pxacar = 'Y') or
204300150226     C                             (*in98 = '0' and pxacar = 'D')
204400131213     C                   eval      *in77 = '1'
204500150226     C                   eval      acatext = ' MLR  '
204600140115     C                   Eval      *in37 = *On
204700140115
2048001312131379 C                   leave
2049001312131379 C                   endif
2050001312131379 C                   endif
2051001312131380  *
2052001312131379 C                   enddo
2053001312131380  *
2054009102150968 C*
2055009102150969 C* WRITE MEMBER SCREEN
2056009102150970 C*
2057000010180971 C                   SETON                                        13
2058009102150972 C                   EXCEPT
2059009102150973 C                   SETOFF                                       13
2060009102150974 C*
2061009102150975 C* EXECUTE SUB. FOR COVERAGES DISPLAY *****
2062009102150976 C*
2063009102150977 C                   EXSR      #COVER
2064009102150978 C*
2065009102150979 C* SET LIMITS IN HISTORY FILE AND START NEW SCREEN IF CONTINUATION
2066009102150980 C*
2067009208120981 C                   Z-ADD     11            O                 3 0
2068000103190982 C     #MRT01        TAG
2069000103160983 C                   MOVE      *BLANKS       SAVHST
2070000103160984 C     SSNO          ADD       1             SSNO1             9 0
2071000103160985 C                   MOVE      SSNO1         SAVSS#            9 0
2072009102150986 C     SAVHST        SETLL     HISTALT
2073009102150987 C                   Z-ADD     12            LINENO
2074009102150988 C   08              SETON                                        23
2075009102150989 C   08              EXCEPT
2076009102150990 C   08              SETOFF                                       23
2077009102150991  *
207800010316     C   47              SUB       22            O
207900010316     C   47O             IFEQ      *ZERO
208000010316     C                   Z-ADD     11            O
208100010316     C                   END
2082000103161115  *
2083009102150992 C     O             SUB       11            Y                 3 0
2084009102150993 C     Y             IFGT      0
2085009102150994 C                   DO        Y
2086000103190995 C                   READP     HISTALT                                98
2087009102150996 C                   END
2088009102150997 C                   END
2089009102150998 C*
2090009102150999 C* LOOP AND DISPLAY HISTORY FROM PRESENT TO OLDEST
2091009102151000 C*
2092009102151001 C                   DO        11
2093009102151002 C                   SETOFF                                       98
2094000103191003 C                   READP     HISTALT                                98
2095009102151004 C   98              MOVE      *ZEROS        HSSNO
2096009102151005 C     HSSNO         IFEQ      SSNO
2097009102151007 C                   ADD       1             LINENO
2098009102151008 C                   SETON                                        08
209900010316     C                   MOVE      TRDATE        SAVTR#
2100009102151009 C     TRCODE        CHAIN     CODES                              98
2101009102151010 C*
2102009903031011 C     TRYM          IFEQ      SAVTYM
2103009102151012 C                   SETON                                        91
2104009102151013 C                   ELSE
2105009102151014 C                   SETOFF                                       91
2106009102151015 C                   END
2107009903031016 C                   MOVE      TRYM          SAVTYM
210800910910     C*
210900140710      * move last 8 bytes of note 2 (not visible) to the last visible
211000140710      * 8 bytes of note 2 on the screen so some date change transactions
211100140710      * show the hidden date, normally the "to date"
211200960521     C                   SETOFF                                       86
211300101217     C                   if        note2y <> *BLANKS and
211400101217     C                             note2y <> '-       ' and
211500140626     C                             trcode <> 'M75'      and
211600140626     C                             trcode <> 'M01'      and
211700161129br01 C                             trcode <> 'MDP'      and
211800140710     C                             trcode <> 'M02'
211900960521     C                   SETON                                        86
212000990115     C                   Z-ADD     8             XX                2 0
212100990115     C                   Z-ADD     8             ZZ                2 0
212200920605     C                   MOVEA     NOTE2Y        NT
212300920605     C     XX            DOUEQ     0
212400920605     C     NT(XX)        IFNE      *BLANKS
212500920605     C                   MOVE      NT(XX)        N2(ZZ)
212600920605     C                   SUB       1             ZZ
212700920605     C                   END
212800920605     C                   SUB       1             XX
212900101217     C                   ENDDO
213000050523     C                   END
213100920605     C*
213200980804     C*
213300980804     C     COVTDT        IFNE      *ZEROS
213400980804     C                   MOVE      COVTDT        @DATIN
213500980804     C                   EXSR      #DATYM
213600980804     C                   MOVE      @DATOU        COVOUT
213700980804     C                   END
213800980804     C*
213900000613     c                   eval      *in90 = *off
214000980804     C     RECVDT        IFNE      *ZEROS
214100000613     c                   eval      *in90 = *on
214200980804     C                   MOVE      RECVDT        @DATIN
214300980804     C                   EXSR      #DATYM
214400980804     C                   MOVE      @DATOU        RECOUT
214500980804     C                   END
214600980804     C*
214700000612     C* get user name
214800000612     C*
214900000612     c                   exsr      #getuser
215000000612
2151009102151018 C                   SETON                                        21
2152009102151019 C                   EXCEPT
2153009102151020 C                   SETOFF                                       21
215400980804     C*
2155009102151021 C                   ELSE
2156009102151022 C                   SETOFF                                       08
215700990303     C                   MOVE      *ZEROS        SAVTYM
2158009102151023 C                   END
2159009102151024 C*
2160009102151025 C                   ADD       1             O
2161009102151026 C                   END
2162009102151027 C*
2163000103261028 C* WRITE CONTINUED OR END MESSAGE LINE   (08 CONTINUED) (N08 END)
2164009102151029 C*
2165009102151030 C                   ADD       1             LINENO
2166009102151031 C   08              SETON                                        18
216700990303     C   08              MOVE      *ZEROS        SAVTYM
2168000103261027 C* Set ENDROLL counter to END.
2169000103261032 C  N08              SETON                                        19
2170000103261032 C  N08              Z-ADD     1             ENDROLL
2171009102151033 C                   EXCEPT
2172009106101034 C                   SETOFF                                       1819
2173009102151035 C*
217400010316     C   35              SETOFF                                       47
217500010316     C   36              SETOFF                                       46
2176000103161035 C*
2177009102151036 C     #ENDM         ENDSR
2178000103191037 C/EJECT
2179009102151038 C****************************************************************
2180009102151039 C*
2181009102151040 C*-------------------- ACCOUNT DISPLAY  ------------------------*
2182009102151041 C*
2183009102151042 C     #ACCNT        BEGSR
2184009102151043 C*
2185009709291062 C***************************************************************
2186009709291221 C* SECURITY SUBROUTINE
218700970929     C                   MOVE      *ZEROS        ST
218800970929     C                   EXSR      $SECAL
218900970929     C                   XFOOT     ST            T##
2190009709291062 C***************************************************************
219100970929     C*
2192009109201046 C                   SETOFF                                       10  31
219300990303     C                   Z-ADD     *ZEROS        SAVTYM
2194009102151047 C*
2195009102151048 C* COMPLETE HISTORY ROLL IF 92 IS NOT ON
2196009102151049 C*
219700980731     C     *IN08         IFEQ      *ON
2198009807311054 C     ACC#          CHAIN     ACCMST                             98
219900990208     C* DISPLAY IO05
220000990208     C                   EXSR      #DSP05
2201009807311050 C                   GOTO      #MRT04
220200980731     C                   ELSE
2203009102151051 C*
220400980731     C   KW
220500980731     COR KX              GOTO      #MRT04
220600911023     C*
220700980731     C   47              GOTO      #MRT04
220800980731     C                   END
220900910807     C*
2210009102151052 C* GET ACCOUNT RECORD AND SET CANCELLED TEXT ON SCREEN
2211009102151053 C*
2212009102151054 C     ACC#          CHAIN     ACCMST                             98
2213009102151055 C* IF NOT THERE  - ERROR NOT FOUND
2214009102151056 C*
2215009102151057 C   98              Z-ADD     2             X
2216009102151058 C   98              SETON                                        1150
2217009102151059 C   98              EXCEPT
2218009102151060 C   98              SETOFF                                       1150
2219009102151061 C   98              GOTO      #ENDA
2220009709291062 C***************************************************************
222100970929     C* TRUST SECURITY
222200970929     C     T##           IFNE      0
222300970929     C                   MOVEL     ACC#          T#
222400971216     C     T#            LOOKUP    ST                                     34
222500971216     C  N34              Z-ADD     7             X
2226009712160900 C  N34              SETON                                        1150
2227009712160901 C  N34              EXCEPT
2228009712160902 C  N34              SETOFF                                       1150
2229009712160903 C  N34              GOTO      #ENDA
223000970929     C                   END
223100010516@SEC C***************************************************************
223200010516@SEC C* GBS/IO ACCOUNT SECURITY - @ ACCT
223300010516@SEC C* NOTE: POSITION 1 OF SCFAX IS NOW USED FOR ALLOW GBS ACCT ACCESS.
223400010516@SEC C***************************************************************
223500010516@SEC C                   MOVEL     ISCFAX        ALLOWGBS
223600010516@SEC C     ALLOWGBS      IFNE      'Y'
223700010521@SEC C     ACC#          ANDEQ     5500010016
223800010516@SEC C                   Z-ADD     7             X
223900010516@SEC C                   SETON                                        1150
224000010516@SEC C                   EXCEPT
224100010516@SEC C                   SETOFF                                       1150
224200010516@SEC C                   GOTO      #ENDA
224300010516@SEC C                   ENDIF
2244009709291062 C***************************************************************
2245009709291062 C*
2246009106111063 C     ADLTCD        IFEQ      'A'
2247009102151064 C                   SETON                                        96
2248009102151065 C                   SETOFF                                       95
2249009102151066 C                   ELSE
2250009102151067 C                   SETOFF                                       96
2251009102151068 C                   SETON                                        95
2252009102151069 C                   END
225300911022     C                   MOVE      *BLANKS       REINST
225400911022     C     RNSTCD        IFEQ      'R'
225500911022     C                   MOVE      RE(1)         REINST           10
225600911022     C                   END
225700911022     C*
2258009102151070 C*
2259009102151071 C* CALCULATE TOTAL DUE
2260009102151072 C*
2261009106241073 C*          APRBAL    ADD  ACUBAL    TOTBL2  92
2262009106241074 C                   XFOOT     BAL           TOTBL2            9 2
2263009102151075 C     AM            SUB       1             AX                2 0
2264009102151076 C     AX            IFEQ      0
2265009102151077 C                   Z-ADD     12            AX
2266009102151078 C                   END
2267009106241079 C     TOTBL2        SUB       BAL(AM)       APRBAL            9 2
2268009102151080 C     APRBAL        SUB       BAL(AX)       APRBA2            9 2
2269009102151081 C                   Z-ADD     BAL(AX)       APRBA1            9 2
2270009102151082 C                   Z-ADD     BAL(AM)       ACUBAL            9 2
2271009102151083 C*
2272009111151084 C                   MOVEL     SMANCD        SALCOD            3
2273009110241085 C                   MOVEL     AZIP          ZIP#              5 0
2274001205141083 C*
2275009102151088 C     SMANCD        CHAIN     SMAN                               98
2276009102151089 C     STYPE         CHAIN     CODES                              98
2277009102151090 C     ACTION        IFEQ      'B'
2278009102151091 C                   SETON                                        16
2279009102151092 C                   ELSE
2280009102151093 C                   SETON                                        17
2281009102151094 C                   END
2282009102151095 C*
228300990208     C* DISPLAY IO05
228400990208     C                   EXSR      #DSP05
228500980731     C*
2286009102151102 C*
2287009102151103 C* SET LIMITS IN HISTORY FILE AND START NEW SCREEN IF CONTINUATION
2288009102151104 C*
2289009208121105 C                   Z-ADD     11            M                 3 0
2290009102151106 C     #MRT04        TAG
2291009102151107 C                   MOVE      *BLANKS       SAVHST
2292009102151108 C     ACC#          ADD       1             ACC#1            10 0
229300920901     C                   MOVE      ACC#          ACC#AN           10
2294009208121109 C                   MOVE      ACC#1         SAVAC#           10 0
2295009102151110 C     SAVHST        SETLL     HISTALT
2296009102151111 C                   Z-ADD     12            LINENO
2297009102151112 C   08              SETON                                        23
2298009102151113 C   08              EXCEPT
2299009102151114 C   08              SETOFF                                       23
2300009102151115  *
230100910806     C   47              SUB       22            M
230200910807     C   47M             IFEQ      *ZERO
230300910807     C                   Z-ADD     11            M
230400910807     C                   END
230500910807     C*
230600911028     C   KX              MOVE      'Y'           KXFLAG            1
230700911028     C   KW              MOVE      *BLANKS       KXFLAG
230800911028     C*
230900911022     C   KW
231000911022     COR KX              SUB       11            M
231100910806     C*
2312009208121116 C     M             SUB       11            Y
2313009108061117 C     Y             IFGT      0
2314009108061118 C                   DO        Y
2315009108061119 C                   READP     HISTALT                                98
2316009108061120 C                   END
2317009108061121 C                   END
2318009102151122 C*
2319009102151123 C* LOOP AND DISPLAY HISTORY FROM PRESENT TO OLDEST
2320009102151124 C*
2321009110221125 C                   DO        11
2322009110211126 C                   SETOFF                                       98
232300911021     C*
2324009102151127 C                   READP     HISTALT                                98
2325009102151128 C   98              MOVE      *ZEROS        HSSNO
2326009208171129 C     HACC#         IFEQ      ACC#AN
2327009102151131 C                   ADD       1             LINENO
2328009102151132 C                   SETON                                        08
2329009102151133 C     TRCODE        CHAIN     CODES                              98
2330009102151134 C*
2331009903031135 C     TRYM          IFEQ      SAVTYM
2332009102151136 C                   SETON                                        91
2333009102151137 C                   ELSE
2334009102151138 C                   SETOFF                                       91
2335009102151139 C                   END
2336009903031140 C                   MOVE      TRYM          SAVTYM
2337009102151141 C*
233800911028     C     KXFLAG        IFEQ      *BLANKS
233900911028     C                   GOTO      #SKPKX
234000911028     C                   END
234100911028     C*
2342009211161141 C* IF NOT = SS#   SKIP IT
234300921116     C*
234400921116     C     SSBLNK        IFNE      *BLANKS
234500921116     C                   GOTO      #SKPKX
234600921116     C                   END
234700921116     C*
234800911022     C     #SS           CHAIN     MEMBER                             66
234900911022     C  N66              EXSR      #NAMEF
235000911022     C  N66              MOVE      *BLANKS       NOTE2H
235100011129     C  N66              MOVE      N             NOTE2H           31
235200911022     C  N66              MOVEL     NOTE2H        NOTE2
235300911022     C     #SKPKX        TAG
235400911022     C*
235500980731     C*
235600980731     C     COVTDT        IFNE      *ZEROS
235700980731     C                   MOVE      COVTDT        @DATIN
235800980731     C                   EXSR      #DATYM
235900980731     C                   MOVE      @DATOU        COVOUT            8
236000980731     C                   END
236100980731     C*
236200000613     c                   eval      *in90 = *off
236300000613     C     RECVDT        IFNE      *ZEROS
236400000613     c                   eval      *in90 = *on
236500980731     C                   MOVE      RECVDT        @DATIN
236600980731     C                   EXSR      #DATYM
236700980731     C                   MOVE      @DATOU        RECOUT            8
236800980731     C                   END
236900000612     C*
237000000612     C*
237100000612     C* get user name
237200000612     C*
237300000612     c                   exsr      #getuser
237400120511
237500120601      * show do not publish info for invoice and void invoice
237600120601     c                   if        trcode = 'BMB' or trcode = 'AVI'
237700120511     c     keyinvdnp     chain     invdnp
237800120511     c                   if        %found(invdnp)
237900120511     c                   move      DNPTEXT       ck#not
238000120511     c                   end
238100120511     c                   end
238200120511
238300120511
238400000612
2385009108281143 C                   EXCEPT    ACCHIS
2386009102151145 C                   ELSE
2387009102151146 C                   SETOFF                                       08
2388009102151147 C                   END
2389009102151148 C                   ADD       1             M
2390009102151149 C*
239100911021     C*
2392009110221150 C                   END
2393009102151152 C*
2394009102151153 C* WRITE CONTINUED OR END MESSAGE LINE   (08 CONTINUED)
2395009102151154 C*
2396009102151155 C                   ADD       1             LINENO
2397009108281156 C   08              EXCEPT    ACONTX
2398009108281157 C  N08              EXCEPT    AEND
2399009102151160 C*
2400009102151161 C     #ENDA         ENDSR
2401009102151162 C/EJECT
2402009102151163 C****************************************************************
2403009412051038 C****************************************************************
2404009412051039 C*
2405009412051040 C*-------------------- ACCOUNT DISPLAY  ------------------------*
2406009412051041 C*
2407009412051042 C     #ACCN2        BEGSR
2408009412051043 C*
2409009412051046 C                   SETOFF                                       10  31
241000990303     C                   Z-ADD     *ZEROS        SAVTYM
2411009412051047 C*
2412009412051048 C* COMPLETE HISTORY ROLL IF 92 IS NOT ON
241300941206     C*
241400941206     C   78              GOTO      #NOROL
2415009412051049 C*
241600980731     C     *IN08         IFEQ      *ON
2417009807311054 C     ACC#          CHAIN     ACCMST                             98
241800990208     C* DISPLAY IO05
241900990208     C                   EXSR      #DSP05
2420009807311050 C                   GOTO      #MRTB4
242100980731     C                   ELSE
2422009412051051 C*
242300980731     C   KW
242400980731     COR KX              GOTO      #MRTB4
242500941205     C*
242600980731     C   47              GOTO      #MRTB4
242700980731     C                   END
242800941205     C*
2429009412051052 C* GET ACCOUNT RECORD AND SET CANCELLED TEXT ON SCREEN
2430009412051053 C*
243100941206     C     #NOROL        TAG
243200941206     C*
2433009412051054 C     ACC#          CHAIN     ACCMST                             98
2434009412051055 C* IF NOT THERE  - ERROR NOT FOUND
2435009412051056 C*
2436009412051057 C   98              Z-ADD     2             X
2437009412051058 C   98              SETON                                        1150
2438009412051059 C   98              EXCEPT
2439009412051060 C   98              SETOFF                                       1150
2440009412051061 C   98              GOTO      #ENDAB
2441009412051062 C*
2442009412051063 C     ADLTCD        IFEQ      'A'
2443009412051064 C                   SETON                                        96
2444009412051065 C                   SETOFF                                       95
2445009412051066 C                   ELSE
2446009412051067 C                   SETOFF                                       96
2447009412051068 C                   SETON                                        95
2448009412051069 C                   END
244900941205     C                   MOVE      *BLANKS       REINST
245000941205     C     RNSTCD        IFEQ      'R'
245100941205     C                   MOVE      RE(1)         REINST           10
245200941205     C                   END
245300941205     C*
2454009412051070 C*
2455009412051071 C* CALCULATE TOTAL DUE
2456009412051072 C*
2457009412051073 C*          APRBAL    ADD  ACUBAL    TOTBL2  92
2458009412051074 C                   XFOOT     BAL           TOTBL2            9 2
2459009412051075 C     AM            SUB       1             AX                2 0
2460009412051076 C     AX            IFEQ      0
2461009412051077 C                   Z-ADD     12            AX
2462009412051078 C                   END
2463009412051079 C     TOTBL2        SUB       BAL(AM)       APRBAL            9 2
2464009412051080 C     APRBAL        SUB       BAL(AX)       APRBA2            9 2
2465009412051081 C                   Z-ADD     BAL(AX)       APRBA1            9 2
2466009412051082 C                   Z-ADD     BAL(AM)       ACUBAL            9 2
2467009412051083 C*
2468009412051084 C                   MOVEL     SMANCD        SALCOD            3
2469009412051085 C                   MOVEL     AZIP          ZIP#              5 0
2470009412051088 C     SMANCD        CHAIN     SMAN                               98
2471009412051089 C     STYPE         CHAIN     CODES                              98
2472009412051090 C     ACTION        IFEQ      'B'
2473009412051091 C                   SETON                                        16
2474009412051092 C                   ELSE
2475009412051093 C                   SETON                                        17
2476009412051094 C                   END
2477009412051095 C*
247800990208     C* DISPLAY IO05
247900990208     C                   EXSR      #DSP05
2480009412051102 C*
2481009412051103 C* SET LIMITS IN HISTORY FILE AND START NEW SCREEN IF CONTINUATION
2482009412051104 C*
2483009412051105 C                   Z-ADD     11            M                 3 0
2484009412051106 C     #MRTB4        TAG
248500941205     C                   MOVE      ACC#          ACC#AN           10
2486009412051109 C                   MOVE      ACC#          SAVAC#           10 0
2487009412051110 C     SAVHST        SETLL     HISTALT
2488009412051111 C                   Z-ADD     12            LINENO
2489009412051112 C   08              SETON                                        23
2490009412051113 C   08              EXCEPT
2491009412051114 C   08              SETOFF                                       23
2492009412051115  *
249300941205     C   47              SUB       22            M
249400941205     C   47M             IFEQ      *ZERO
249500941205     C                   Z-ADD     11            M
249600941205     C                   END
249700941205     C*
249800941205     C   KX              MOVE      'Y'           KXFLAG            1
249900941205     C   KW              MOVE      *BLANKS       KXFLAG
250000941205     C*
250100941205     C   KW
250200941205     COR KX              SUB       11            M
250300941205     C*
2504009412051116 C     M             SUB       11            Y
2505009412051117 C     Y             IFGT      0
2506009412051118 C                   DO        Y
2507009412051119 C                   READ      HISTALT                                98
2508009412051120 C                   END
2509009412051121 C                   END
2510009412051122 C*
2511009412051123 C* LOOP AND DISPLAY HISTORY FROM PRESENT TO OLDEST
2512009412051124 C*
2513009412051125 C                   DO        11
2514009412051126 C                   SETOFF                                       98
251500941205     C*
2516009412051127 C                   READ      HISTALT                                98
2517009412051128 C   98              MOVE      *ZEROS        HSSNO
2518009412051129 C     HACC#         IFEQ      ACC#AN
2519009412051131 C                   ADD       1             LINENO
2520009412051132 C                   SETON                                        08
2521009412051133 C     TRCODE        CHAIN     CODES                              98
2522009412051134 C*
2523009903031135 C     TRYM          IFEQ      SAVTYM
2524009412051136 C                   SETON                                        91
2525009412051137 C                   ELSE
2526009412051138 C                   SETOFF                                       91
2527009412051139 C                   END
2528009903031140 C                   MOVE      TRYM          SAVTYM
2529009412051141 C*
253000941205     C     KXFLAG        IFEQ      *BLANKS
253100941205     C                   GOTO      #SKPK2
253200941205     C                   END
253300941205     C*
2534009412051141 C* IF NOT = SS#   SKIP IT
253500941205     C*
253600941205     C     SSBLNK        IFNE      *BLANKS
253700941205     C                   GOTO      #SKPK2
253800941205     C                   END
253900941205     C*
254000941205     C     #SS           CHAIN     MEMBER                             66
254100941205     C  N66              EXSR      #NAMEF
254200941205     C  N66              MOVE      *BLANKS       NOTE2H
254300011129     C  N66              MOVE      N             NOTE2H           31
254400941205     C  N66              MOVEL     NOTE2H        NOTE2
254500941205     C     #SKPK2        TAG
254600941205     C*
254700980731     C     COVTDT        IFNE      *ZEROS
254800980731     C                   MOVE      COVTDT        @DATIN
254900980731     C                   EXSR      #DATYM
255000980731     C                   MOVE      @DATOU        COVOUT            8
255100980731     C                   END
255200980731     C*
255300000613     c                   eval      *in90 = *off
255400000613     C     RECVDT        IFNE      *ZEROS
255500000613     c                   eval      *in90 = *on
255600980731     C                   MOVE      RECVDT        @DATIN
255700980731     C                   EXSR      #DATYM
255800980731     C                   MOVE      @DATOU        RECOUT            8
255900980731     C                   END
256000980731     C*
256100000612     C*
256200000612     C* get user name
256300000612     C*
256400000612     c                   exsr      #getuser
256500120511
256600120601      * show do not publish info for invoice and void invoice
256700120601     c                   if        trcode = 'BMB' or trcode = 'AVI'
256800120511     c     keyinvdnp     chain     invdnp
256900120511     c                   if        %found(invdnp)
257000120511     c                   move      DNPTEXT       ck#not
257100120511     c                   end
257200120511     c                   end
257300120511
257400000612
2575009412051143 C                   EXCEPT    ACCHIS
257600980731     C*
2577009412051145 C                   ELSE
2578009412051146 C                   SETOFF                                       08
2579009412051147 C                   END
2580009412051148 C                   ADD       1             M
2581009412051149 C*
258200941205     C*
2583009412051150 C                   END
2584009412051151 C*
2585009412051152 C*
2586009412051153 C* WRITE CONTINUED OR END MESSAGE LINE   (08 CONTINUED)
2587009412051154 C*
2588009412051155 C                   ADD       1             LINENO
2589009412051156 C   08              EXCEPT    ACONTX
2590009412051157 C  N08              EXCEPT    AEND
2591009412051160 C*
2592009412051161 C     #ENDAB        ENDSR
2593009412051162 C/EJECT
2594009412051163 C****************************************************************
2595009102151164 C*
2596009102151165 C*------------------ MEMBER ALPHA DISPLAY ----------------------*
2597009102151166 C*
2598009102151167 C     #MALPH        BEGSR
2599009709291166 C*
2600009709291062 C***************************************************************
2601009709291221 C* SECURITY SUBROUTINE
260200970929     C                   MOVE      *ZEROS        ST
260300970929     C                   EXSR      $SECAL
260400970929     C                   XFOOT     ST            T##
2605009709291062 C***************************************************************
260600970929     C*
2607009102151168 C*
2608009102151169 C* CLEAR FIELDS AND SET ALPHA LIMITS TO MEMBERA
2609009102151170 C*
2610009102151171 C                   MOVE      *BLANKS       SS
2611009102151172 C                   MOVE      *BLANKS       SEL
2612009102151173 C                   MOVE      *BLANKS       AL
2613009102151174 C*
2614009208121175 C   01              MOVE      *BLANKS       SAVNAM           31
2615009208121176 C   01              MOVEL     SLNAME        SAVNAM
2616009102151177 C     SAVNAM        SETLL     MEMBERA
2617009208121178 C                   Z-ADD     0             Y                    9898
2618009102151179 C*
2619009102151180 C* LOOP AND READ MEMBERS AND FILL FIELDS
2620009102151181 C*
2621009102151182 C     #MAL01        TAG
2622009102151183 C                   READ      MEMBERA                                98
2623009102151184 C   98              GOTO      #MAT02
262400020417
262500020417     c* only include active mem   ?
262600020417
262700020417     c                   if        smemactive = 'Y' and mtermdt <> 0
2628000204171236 C                   GOTO      #mal01
262900020417     c                   end
2630009709291062 C***************************************************************
263100970929     C* TRUST SECURITY
263200970929     C     T##           IFNE      0
263300970929     C                   MOVEL     TRUST#        T#
263400971216     C     T#            LOOKUP    ST                                     34
263500971216     C  N34              GOTO      #MAL01
263600970929     C                   END
2637009709291062 C***************************************************************
263800970929     C*
2639009102151185 C                   ADD       1             Y
2640009102151186 C                   MOVE      SSNO          SS(Y)
2641009102151187 C                   MOVE      *BLANKS       MLINE
2642009102151188 C                   MOVE      LNAME         MLNAME
2643009102151189 C                   MOVE      FNAME         MFNAME
2644009102151190 C                   MOVE      MI            MMI
264500980731     C*
264600980731     C                   MOVE      BIRTH         @DATIN
264700980731     C                   EXSR      #DATYM
264800980731     C                   MOVE      @DATOU        MDOB
264900980731     C*
2650009102151192 C     KEYACC        CHAIN     ACCMST                             98
2651009102151193 C  N98              MOVE      ACNAM1        MACCNM
2652009102151194 C                   MOVE      'S'           CDTYPE
2653009102151195 C     CDKEY         CHAIN     CODES                              98
2654009102151196 C  N98              MOVE      SDESCR        MSTATS
2655009102151197 C                   MOVE      MLINE         AL(Y)
2656009102151198 C*
2657009102151199 C     Y             IFEQ      19
2658009102151200 C                   MOVE      LFM           SAVNAM
2659009102151201 C                   GOTO      #MAT02
2660009102151202 C                   END
2661009102151203 C*
2662009102151204 C                   GOTO      #MAL01
2663009102151205 C*
2664009102151206 C     #MAT02        TAG
2665009102151207 C*
2666009102151208 C* WRITE ALPHA SCREEN
2667009102151209 C*
2668009102151210 C                   SETON                                        12
2669009102151211 C                   EXCEPT
2670009102151212 C                   SETOFF                                       12
2671009102151213 C*
2672009102151214 C                   ENDSR
2673009102151215 C/EJECT
2674009102151216 C****************************************************************
2675009102151217 C*
2676009102151218 C*----------------- ACCOUNT ALPHA SUMMARY ----------------------*
2677009102151219 C*
2678009102151220 C     #AALPH        BEGSR
2679009102151221 C*
2680009709291062 C***************************************************************
2681009709281221 C* SECURITY SUBROUTINE
268200970928     C                   MOVE      *ZEROS        ST
268300970928     C                   EXSR      $SECAL
268400970928     C                   XFOOT     ST            T##              10 0
2685009709291062 C***************************************************************
268600970928     C*
2687009102151222 C* CLEAR FIELDS AND SET ALPHA LIMITS TO MEMBERA
2688009102151223 C*
2689009102151224 C                   MOVE      *BLANKS       SS
2690009102151225 C                   MOVE      *BLANKS       SEL
2691009102151226 C                   MOVE      *BLANKS       AL
2692009102151227 C*
2693009102151228 C   01              MOVEL     SACNAM        SAVACC
2694009102151229 C     SAVACC        SETLL     ACCMSTA
2695009208121230 C                   Z-ADD     0             Y                    9898
2696009102151231 C*
2697000204091232 C* LOOP AND READ acounts AND FILL FIELDS
2698009102151233 C*
2699009102151234 C     #AAL01        TAG
2700009102151235 C                   READ      ACCMSTA                                98
2701009102151236 C   98              GOTO      #AAT02
270200020409
270300020409     c* only include active accts ?
270400020409
270500020409     c                   if        sactive = 'Y' and aterm <> 0
2706000204091236 C                   GOTO      #AAl01
270700020409     c                   end
2708009709291062 C***************************************************************
270900970928     C* TRUST SECURITY
271000970928     C     T##           IFNE      0
271100970928     C                   MOVEL     ACC##         T#                3 0
271200971216     C     T#            LOOKUP    ST                                     34
271300971216     C  N34              GOTO      #AAL01
271400970928     C                   END
2715009709291062 C***************************************************************
271600970928     C*
2717009709291237 C                   ADD       1             Y
271800970929     C*
2719009102151238 C                   MOVE      ACC##         SS(Y)
2720009102151239 C                   MOVE      *BLANKS       ALINE
2721009102151240 C                   MOVE      ACNAM1        AACNAM
2722009102151241 C                   MOVE      ACITY         AACITY
2723009102151242 C                   MOVE      ASTATE        AAST
2724009102151243 C                   MOVE      ACONT         AACONT
272500980731     C*
272600980803     C     ATERM         IFNE      0
272700980731     C                   MOVE      ATERM         @DATIN
272800980731     C                   EXSR      #DATYM
272900980731     C                   MOVE      @DATOU        AATERM
273000980803     C                   ELSE
273100980803     C                   MOVE      *BLANKS       AATERM
273200980803     C                   END
273300980731     C*
2734009102151246 C     DLTCD         IFEQ      'A'
2735009102151247 C                   MOVE      'ACTIVE'      AASTAT
2736009102151248 C                   ELSE
2737009102151249 C                   MOVE      'CANCEL'      AASTAT
2738009102151250 C                   END
2739009102151251 C                   MOVE      ALINE         AL(Y)
2740009102151252 C*
2741009102151253 C     Y             IFEQ      19
2742009102151254 C                   MOVE      ACNAM1        SAVACC
2743009102151255 C                   GOTO      #AAT02
2744009102151256 C                   END
2745009102151257 C*
2746009102151258 C                   GOTO      #AAL01
2747009102151259 C*
2748009102151260 C     #AAT02        TAG
2749009102151261 C*
2750009102151262 C* WRITE ALPHA SCREEN
2751009102151263 C*
2752009709281263 C*
2753009102151264 C                   SETON                                        14
2754009102151265 C                   EXCEPT
2755009102151266 C                   SETOFF                                       14
2756009102151267 C*
2757009102151268 C                   ENDSR
2758009102151269 C/EJECT
2759009102151270 C****************************************************************
2760009102151271 C*
2761000002171272 C*-------------------- DEPENDENTS DISPLAY ----------------------*
2762009102151273 C*
2763009102151274 C     #DEPND        BEGSR
2764009102151275 C*
2765009102151276 C*
2766009102151277 C                   SETOFF                                           09
2767009102151278 C*
2768000002171279 C* SET LIMITS IN DEPENDENT FILE AND DISPLAY DEPEND SCREEN
2769009102151280 C*
2770009102151281 C     HCOUNT        IFEQ      *ZERO
2771009102151282 C     SSNO          SETLL     DEPEND
2772009102151283 C                   END
2773009102151284 C                   Z-ADD     12            LINENO
2774009102151285 C                   SETON                                        24
2775009102151286 C                   EXCEPT
2776009102151287 C                   SETOFF                                       24
2777009102151288 C*
2778000002171289 C* LOOP AND DISPLAY DEPENDENTS
2779009102151290 C*
2780009102151291 C                   DO        11            S#
2781009102151292 C                   READ      DEPEND                                 09
2782009102151293 C  N09SSNO          COMP      DPSSNO                             0909
278300910606     C   09HCOUNT        IFEQ      *ZEROS
278400910611     C                   ADD       1             LINENO
278500910606     C                   EXCEPT    BLNKVL
278600910606     C                   END
2787009102151294 C   09              Z-ADD     *ZERO         HCOUNT
2788009102151295 C   09              GOTO      #DPT02
2789009102151296 C     DDEL          IFEQ      'D'
2790009102151297 C                   GOTO      #DPT02
2791009102151298 C                   ELSE
2792009102151299 C     DDEL          IFEQ      'A'
2793009102151300 C                   MOVE      '  ACTIVE'    DSTAT            10
2794009102151301 C                   ELSE
2795009102151302 C                   MOVE      '  CANCEL'    DSTAT
2796009102151303 C                   END
2797009102151304 C                   END
2798009102151305 C                   ADD       1             LINENO
2799009102151306 C                   ADD       1             HCOUNT            5 0
2800009102151307 C     DRELCD        CHAIN     CODES                              98
280100980731     C*
280200980731     C*
280300980731     C                   MOVE      DBIRTH        @DATIN
280400980731     C                   EXSR      #DATYM
280500120627     C                   MOVE      @DATOU        DBIRTHMDY         8 0
280600980731     C*
280700980731     C     DHDDT         IFNE      0
280800980731     C                   MOVE      DHDDT         @DATIN
280900980731     C                   EXSR      #DATYM
281000980731     C                   MOVE      @DATOU        DHDDT
281100980731     C                   END
281200120627
281300120627      * calc dependent age
281400120627     c                   clear                   dage              3 0
281500120627     c                   movel     dbirth        dbirthyear        4 0
281600120627     c                   move      dbirth        dbirthMD          4 0
2817001206271381 C     systemdtyear  sub       dbirthyear    dage
2818001206271382 C                   if        dage > 0 and dbirthmd > systemdtmd
2819001206271384 C                   sub       1             dage
2820001206271386 C                   end
282100121214      * format dep ssn
282200121214     c                   if        depss# <> 0
282300121214     c                   eval      depss#out = %editw(depss#:'0   -  -    ')
282400121214     c                   else
282500121214     c                   clear                   depss#out        12
282600121214     c                   end
282700120627
2828001206271308 C* write dependent line
2829009102151309 C                   SETON                                        26
2830009102151310 C                   EXCEPT
2831009102151311 C                   SETOFF                                       26
2832009102151312 C     #DPT02        TAG
2833009102151313 C                   END
2834009102151314 C*
2835009102151315 C   09              GOTO      #DPT03
2836009102151316 C                   ADD       1             LINENO
2837009102151317 C                   SETON                                        27
2838009102151318 C                   EXCEPT
2839009102151319 C                   SETOFF                                       27
2840009102151320 C     #DPT03        TAG
2841009102151321 C*
2842009102151322 C     #ENDD         ENDSR
2843009102151323 C/EJECT
2844009102151324 C****************************************************************
2845009102151325 C*
2846009102151326 C*-------------------- ACCOUNT/MEMBER DISPLAY ------------------*
2847009102151327 C*
2848009102151328 C     #AMEM         BEGSR
2849009102151329 C*
2850009102151330 C* SET LIMITS IN MEMBER FILE AND DISPLAY DEPEND SCREEN AND BLANK SS# ARRAY
2851009102151331 C*
2852009102151332 C                   MOVE      *BLANKS       AMS
2853009208121333 C  N10              MOVE      *BLANKS       SAVAN            41
2854009102151334 C  N10              MOVEL     ACC#          SAVAN
285500910607     C*
285600910607     C     ALFLAG        IFEQ      'Y'
285700910607     C                   MOVE      SAV31         SAVAN
285800910607     C                   END
285900910607     C*
2860009102151335 C     SAVAN         SETLL     MEMACC
2861009102151336 C                   SETON                                        10
2862009102151337 C                   Z-ADD     12            LINENO
2863009102151338 C                   SETON                                        28
2864009102151339 C                   EXCEPT
2865009102151340 C                   SETOFF                                       28
2866009102151341 C*
2867000111291342 C* LOOP AND DISPLAY MEMBERS - 11 per page
2868009102151343 C*
2869000111291344 C                   z-add     1             S#                2 0
2870000111291344 C                   dow       S# < 12
2871009102151345 C                   SETOFF                                           09
2872009102151346 C                   READ      MEMACC                                 09
2873009102151347 C   09              SETOFF                                           10
2874009102151348 C   09              GOTO      #AMT03
2875009102151352 C*
2876009102151353 C* EXIT IF END OF MEMBERS
2877009102151354 C*
2878009102151355 C     ACC#          IFNE      MACC#
2879009102151356 C                   SETON                                        09
2880009102151357 C                   SETOFF                                       10
2881000111291358 C**                 GOTO      #AMT02
2882000111291358 C                   leave
2883009102151359 C                   END
288400011129
288500011129     C* if cmd-13 only show cobra members
288600011129
288700011129     c                   if        *inkm and cexpdt = *zeros
288800011129     c                   iter
288900011129     c                   end
289000011129
2891009102151360 C*
2892009102151361 C* WRITE OUT MEMBER TO WINDOW AND SAVE SS#
2893009102151362 C*
2894009102151363 C                   MOVE      SSNO          AMS(S#)
2895009105131364 C                   SETOFF                                       40
289600920511     C*
289700920511     C* FIND AGE EVEN IF NO ACTIVE PLANS
289800920511     C*
2899009807311381 C     *YEAR         SUB       BYR           AGE
2900009205111382 C     UMONTH        IFNE      12
2901009902151383 C     UMONTH        IFLT      BMO
2902009205111384 C                   SUB       1             AGE
2903009205111385 C                   END
2904009205111386 C                   END
2905000111291387 C*
290600011129     C*  REVERSE IMAGE MEMBER LINE IF MEMBER IS COBRA.....
290700011129     C*
290800011129     C                   SETOFF                                       31
290900011129     C**   SSNO          CHAIN     MEMBER                             98
291000011129     C**N98CEXPDT        IFNE      *ZEROS
291100011129     C     CEXPDT        IFNE      *ZEROS
291200011129     C                   SETON                                        31
291300011129     C                   END
291400011129     C*
291500920511     C*
2916009109241365 C* FIND COVERAGE TYPE OF THE ACTIVE MAJOR MEDICAL PLAN
2917009102151366 C*
291800921222     C                   MOVE      *BLANKS       HGRP11
2919009102151367 C                   MOVEL     SSNO          MCVKEY
2920009210261368 C     MCVKEY        SETLL     MCOV38
2921009102151370 C     #AMT04        TAG
2922009210261371 C                   READ      MCOV38                                 94
292300910513     C*
2924009102151372 C     SSNO          IFNE      MCSSNO
2925009105131373 C   40              GOTO      DSP
2926009105131373 C  N40              GOTO      #AMT05
2927009102151374 C                   END
292800131212      *
2929009102151377 C   94              GOTO      #AMT05
293000930929     C     CANDT         IFNE      0
293100910924     C                   GOTO      #AMT04
293200910924     C                   END
293300910924     C*
2934009102151378 C     PLKEY         CHAIN     PLNMST                             98
2935009102151379 C   98              GOTO      #AMT04
2936009102151380 C*
293700910924     C                   MOVE      *BLANKS       TDESC             4
2938009102151388 C     PLNCAT        IFEQ      'PMM'
293900910513     C                   SETON                                        40
2940009102151389 C     COVTYP        COMP      'TIN'                                  93
2941009102151390 C   93              MOVEL     'IND.'        TDESC
2942009102151391 C     COVTYP        COMP      'TFA'                                  93
2943009102151392 C   93              MOVEL     'FAM.'        TDESC
2944009102151393 C     COVTYP        COMP      'THW'                                  93
2945009102151394 C   93              MOVEL     'H&W '        TDESC
2946009102151395 C     COVTYP        COMP      'TPC'                                  93
2947009102151396 C   93              MOVEL     'P&C '        TDESC
2948009702141395 C     COVTYP        COMP      'TDB'                                  93
2949009702141396 C   93              MOVEL     'DBL.'        TDESC
2950009907241391 C     COVTYP        COMP      'TP2'                                  93
2951009907241392 C   93              MOVEL     'P2  '        TDESC
295200911021     C*
295300911021     C                   EXSR      #GRATE
2954009102151399 C*
2955009102151400 C                   ELSE
2956009102151401 C     PLNCAT        IFEQ      'PMS'
295700910513     C                   SETON                                        40
2958009102151402 C     COVTYP        COMP      'TIN'                                  93
2959009102151403 C   93              MOVEL     'IND.'        TDESC
2960009102151404 C     COVTYP        COMP      'TFA'                                  93
2961009102151405 C   93              MOVEL     'FAM.'        TDESC
2962009102151406 C     COVTYP        COMP      'THW'                                  93
2963009102151407 C   93              MOVEL     'H&W '        TDESC
2964009102151408 C     COVTYP        COMP      'TPC'                                  93
2965009102151409 C   93              MOVEL     'P&C '        TDESC
2966009702141408 C     COVTYP        COMP      'TDB'                                  93
2967009702141409 C   93              MOVEL     'DBL.'        TDESC
2968009907241391 C     COVTYP        COMP      'TP2'                                  93
2969009907241392 C   93              MOVEL     'P2  '        TDESC
297000911021     C*
297100911021     C                   EXSR      #GRATE
2972009102151412 C*
2973009102151413 C                   ELSE
2974009102151414 C                   GOTO      #AMT04
2975009102151415 C                   END
2976009102151416 C                   END
2977009102151417 C*
2978009102151418 C     #AMT05        TAG
2979009102151419 C                   MOVE      'S'           CDTYPE
2980009102151420 C     CDKEY         CHAIN     CODES                              98
2981009102151421 C   98              MOVE      '--------'    SDESCR
2982009102151422 C*
2983009102151423 C     DSP           TAG
2984009102151424 C                   ADD       1             LINENO
298500980731     C*
298600980731     C                   MOVE      BIRTH         @DATIN
298700980731     C                   EXSR      #DATYM
298800980731     C                   MOVE      @DATOU        BIRTH
298900980731     C*
299000980731     C                   MOVE      EMPDT         @DATIN
299100980731     C                   EXSR      #DATYM
299200980731     C                   MOVE      @DATOU        EMPDT
299300980731     C*
2994009102151425 C                   SETON                                        29
2995009102151426 C                   EXCEPT
2996009811131427 C                   SETOFF                                       2931
2997000111291344 C                   add       1             S#
299800910924     C                   MOVE      *BLANKS       TDESC
2999000111291428 C**   #AMT02        TAG
3000000111291429 C                   ENDDO
3001009102151430 C*
3002009102151431 C                   MOVE      MALL          SAVAN
3003009102151432 C   09              GOTO      #AMT03
3004009102151433 C*
3005009102151434 C* WRITE OUT MORE MEMBERS TO WINDOW
3006009102151435 C*
3007009102151436 C                   ADD       1             LINENO
3008009102151437 C                   SETON                                        30
3009009102151438 C                   EXCEPT
3010009102151439 C                   SETOFF                                       30
3011009102151440 C     #AMT03        TAG
3012009102151441 C*
3013009102151442 C                   ENDSR
3014009102151443 C/EJECT
3015009102151444 C****************************************************************
3016009102151445 C*
3017009102151446 C*------------------- COMPRESS NAME FIELDS ---------------------*
3018009102151447 C*
3019009211161448 C     #NAMEF        BEGSR
3020009102151449 C*
3021000111291452 C                   MOVE      *BLANKS       N                31
302200011129     C                   MOVEL     FNAME         N
3023009102151463 C*
3024009102151464 C     MI            IFNE      ' '
302500011129     C                   CAT       MI:1          N
302600011129     C                   CAT       '.':0         N
3027009102151469 C                   END
3028009102151470 C*
302900011129     C                   CAT       lname:1       N
3030001609281470 C*
303100160928     C     CFSKEY        Chain     CFS100P
303200160928     C                   if        %found(CFS100P)
303300160928     C                   eval      *in83 = *on
303400160928     C                   if        %trim(CFSMID) <> *blanks
303500160928     C                   eval      N = %trim(CFSFST) + ' ' +
303600160928     C                             %trim(CFSMID) + ' ' +
303700160928     C                             %trim(CFSLST)
303800160928     C                   else
303900160928     C                   eval      N = %trim(CFSFST) + ' ' +
304000160928     C                             %trim(CFSLST)
304100160928     C                   end
304200160928     C                   else
304300160928     C                   eval      *in83 = *off
304400160928     C                   end
3045009102151473 C*
3046009102151474 C                   ENDSR
3047009102151475 C/EJECT
3048009102151476 C****************************************************************
3049009102151477 C*
3050009102151478 C*------------------- FILL COVERAGE ARRAY  ---------------------*
3051009102151479 C*
3052009102151480 C     #COVER        BEGSR
3053009102151481 C*
3054009102151482 C*  RETRIEVE PLAN DESCRIPTIONS
3055009102151483 C*
3056009102151486 C*
3057009102151487 C                   MOVE      *BLANKS       PD
3058000904291488 C  NKE              SETOFF                                       92
3059000904291488 C  NKE              SETOFF                                       83
3060009210261489 C  NKE              MOVEL     SSNO          MCVKEY           38
3061000904211489 C  NKE              MOVEL     SSNO          MC4K1
306200090421     C     #RESET        TAG
306300090429     C
3064000904291490 C  N92MC4KEY        SETLL     MCOV40
306500921026     C  N92              SETON                                        92
3066009102151491 C                   Z-ADD     0             Z                 2 0
3067009102151492 C*
3068009102151493 C* GET PLAN AND RATE RECORDS AND MOVE TO ARRAY FOR ACTIVE COVERAGES
3069009102151494 C*
3070009110111496 C                   SETOFF                                       97
3071009102151495 C     #CVL01        TAG
307200910620     C*
307300910620     C*
3074000904291497 C     SSNO          READE     MCOV40                                 97
307500090429     C*
307600090429     C                   IF        *IN97 = *ON
3077000904290486 C                   Movel     *ZEROS        MC4K3B
3078000904290486 C                   Movel     *ZEROS        MC4K4B
307900090429     C                   Movel     *ZEROS        MC4K9B
3080000904290486 C                   Movel     *BLANKS       MC4K5B
308100090429     C                   Movel     *ZEROS        MC4K6B
308200090429     C                   Movel     *BLANKS       MC4K7B
308300090429     C                   Movel     *HIVAL        MC4K8B
308400090429     C                   EXSR      READ41
308500090429     C                   IF        *IN79 = *ON
3086000904290486 C                   Movel     *ZEROS        MC4K3
3087000904290486 C                   Movel     *ZEROS        MC4K4
3088000904290486 C                   Movel     *BLANKS       MC4K5
308900090429     C                   Movel     *ZEROS        MC4K6
309000090429     C                   Movel     *BLANKS       MC4K7
309100090429     C                   Movel     *ZEROS        MC4K8
3092000904290486 C                   Movel     *ZEROS        MC4K3B
3093000904290486 C                   Movel     *ZEROS        MC4K4B
309400090429     C                   Movel     *ZEROS        MC4K9B
3095000904290486 C                   Movel     *BLANKS       MC4K5B
309600090429     C                   Movel     *ZEROS        MC4K6B
309700131212     C                   Movel     *BLANKS       MC4K7B
309800090429     C                   Movel     *HIVAL        MC4K8B
309900090429     C                   Eval      *IN92 = *OFF
310000090429     C                   END
310100090429     C                   GOTO      DSPLY
310200090429     C                   END
310300090429     C*
310400090429     C* Save Last Read
3105000904290486 C                   Movel     A_MCTRST      MC4K3
3106000904290486 C                   Movel     A_MCSUB#      MC4K4
3107000904290486 C                   Movel     A_MCPLAN      MC4K5
310800090429     C                   Movel     A_MCAGEB      MC4K6
310900090429     C                   Movel     A_MCOVTP      MC4K7
311000090429     C                   Movel     A_ENRLDT      MC4K8
311100090429     C*
3112009102151505 C  N97DLTCD         IFEQ      'D'
3113009102151506 C                   GOTO      #CVL01
3114009102151507 C                   END
3115009102151508 C*
3116009102151509 C  N97DLTCD         IFNE      'D'
3117009102151510 C                   ADD       1             Z
3118009102151511 C*
3119000904211512 C     PlnKey        CHAIN     PLNMST                             98
3120009102151513 C                   MOVE      *BLANKS       PLINE
3121000904211514 C**************     MOVE      PLKEY         P#
312200090421     C                   Move      A_MCPLAN      P#
3123001109161515 C  N98              MOVEL     PDESCR        PDSCR
3124001109161515 C   98              MOVEL     ER2(1)        PDSCR
312500090421     C     A_MCAGEB      IFEQ      *ZEROS
312600911024     C                   MOVE      *BLANKS       PAGBND
312700911024     C                   ELSE
3128000904211516 C                   MOVE      A_MCAGEB      PAGBND
312900911024     C                   END
313000911024     C*
3131000904211517 C                   MOVE      A_MCOVTP      PTCODE
313200110916
313300110916      * if original benefit is greater than current benefit then
313400110916      * show "Y" in Reduced Benefit column
313500110916
313600110916     c                   clear                   PRB
313700110916     c                   if        a_mcorgben > a_benamt
313800110916     c                   eval      PRB = 'Y'
313900110916     c                   end
314000110916
314100090421     C                   MOVE      A_ENRLDT      @DATIN
314200980731     C                   EXSR      #DATYM
314300980731     C                   MOVE      @DATOU        PENROL
314400980731     C*
3145000904211519 C     A_CANDT       IFGT      0
314600980731     C*
314700090421     C                   MOVE      A_CANDT       @DATIN
314800980731     C                   EXSR      #DATYM
314900980731     C                   MOVE      @DATOU        PCANCL
315000980731     C*
3151009102151521 C                   END
315200090420     C*
315300090420     C* Class
315400090420     C*
315500090420     C     ClsKey        Setll     CLASS
315600090420     C     ClsKey        Reade     CLASS
315700090420     C                   If        Not %Eof(CLASS)
315800090420     C                   Movel     CLCLASS       PBC
315900090420     C                   End
316000090420     C*
3161000904211522 C     A_BENAMT      IFGT      0
316200090421     C                   If        A_benamt <> *Zeros
316300090421     c                   eval      PBC   = %editc(A_benamt:'4')
316400090420     C                   End
3165009102151524 C                   END
3166009102151525 C*
3167009807311526 C* GRATE
3168009807311526 C*
3169009102151530 C                   MOVE      *BLANKS       ENRFLG            1
3170009102151531 C                   MOVE      *BLANKS       GERRFL
3171009807311532 C                   MOVE      UDATE8        CYMD              8 0
3172009102151540 C*
3173009102151541 C     #SETL         TAG
3174009102151542 C*
3175009102151543 C                   SETOFF                                           60
3176009102151544 C                   Z-ADD     *ZEROS        GCOUNT
3177000904211545 C     RateKey       SETLL     GRATE
3178009102151546 C*
3179009102151547 C     #READ         TAG
3180009102151548 C*
3181009102151549 C                   READ      GRATE                                  60
3182000904211550 C**N60RKEY          COMP      GRTKEY                             6060
3183000904211550 C  N60RateKey       COMP      GRTKEY                             6060
3184009102151551 C   60              GOTO      #SKIP1
3185009102151552 C*
3186009807311553 C     CYMD          IFGE      FRMDAT
3187009807311554 C     CYMD          IFLE      TODAT
3188009102151555 C                   ADD       1             GCOUNT            2 0
3189009102151556 C                   GOTO      #SKIP1
3190009102151557 C                   END
3191009102151558 C                   END
3192009102151559 C*
3193009102151560 C                   GOTO      #READ
3194009102151561 C*
3195009102151562 C     #SKIP1        TAG
3196009102151563 C*
3197009102151564 C     GCOUNT        IFEQ      *ZERO
3198009102151565 C     ENRFLG        IFNE      'Y'
3199009102151566 C                   MOVE      *BLANKS       GERRFL
3200009102151567 C                   MOVE      'Y'           ENRFLG
3201000905061568 C                   MOVE      A_ENRLDT      CYMD
3202009102151576 C*
3203009102151577 C                   GOTO      #SETL
3204009102151578 C                   END
3205009102151579 C*
3206009102151581 C                   MOVE      'Y'           GERRFL            1
3207009102151582 C                   END
3208009102151583 C*
3209009102151584 C*---------- WJP 06/90: ---------------------------------------------
321000070926
321100070926      * if grate found, show group # and default rate in premium field
321200070926
3213009102151587 C     GERRFL        IFNE      'Y'
3214009102151588 C                   MOVE      GROUP#        PGRP#
3215000709261586 C                   z-add     BILRTE        PPREM2dec         7 2
321600131213      *
3217001312131586 C                   if        bilrte = 0
321800140612    ***
321900140612     C                   MOVE      *BLANKS       @ACA              1
322000140612     C                   EVAL      @ACA = #CHK_ACA_PLAN(A_MCTRST:A_MCSUB#:
322100140612     C                                A_MCPLAN)
322200140612     C                   IF        @ACA = 'Y'
322300140612     C                   EVAL      PARMSSN = %EDITC(SSNO:'X')
322400140612     C                   EVAL      PARMSEQ = 'FA'
322500140612     c                   move      RATEKEY       parmkey
322600140612     c                   move      A_ENRLDT      parmeffymd
322700140612     c                   move      *ZEROS        parmbenamt
322800140612     C                   EXSR      #FNDRT
322900140612     C                   IF        PARMFOUND = 'Y'
323000140612     C                   MOVE      PARMBILRTE    WKBILRTE         11 6
323100140612     C                   Z-ADD     WKBILRTE      PPREM2DEC
323200140612     C                   ENDIF
323300140612     C                   ENDIF
323400140612    ***
3235001312131589 C                   endif
323600131213      *
323700090924     c****               eval      pprem = %editc(pprem2dec:'4')
323800090924      * show negative rate
323900090924     c                   eval      pprem = %editc(pprem2dec:'M')
3240009102151589 C                   ELSE
3241009102151590 C                   MOVE      ER(1)         PGRP#
324200070926     c                   clear                   pprem
3243009102151591 C                   END
324400070926
324500070926      * if the plan has been invoiced, show the last invoiced amount instead
3246000904211594 C     A_LPREM       IFGT      0
324700090924     c****               eval      pprem = %editc(A_lprem:'4')
324800090924      * show negative prem
324900090924     c                   eval      pprem = %editc(A_lprem:'M')
3250009102151596 C                   END
3251009102151597 C*
3252009102151598 C                   MOVEA     PLINE         PD(Z)
3253009102151599 C*
3254009102151600 C     Z             IFLT      7
3255009102151601 C                   GOTO      #CVL01
3256009102151602 C                   END
3257009102151603 C                   END
3258009102151604 C*
3259009102151605 C* WRITE OUT COVERAGE WINDOW
3260009102151606 C*
3261000904211607 C     DSPLY         TAG
3262000904211608 C                   SETON                                        25
3263000904211609 C                   EXCEPT
3264000904211610 C                   SETOFF                                       25
3265009102151611 C*
3266009102151612 C                   ENDSR
3267009102151613 C*
3268000904211476 C****************************************************************
326900140612   S***S
327000140612     C     #FNDRT        BEGSR
327100140612    ***
327200140612     c     grplist       plist
327300140612     c                   parm                    parmkey          15
327400140612     C                   PARM                    PARMSSN           9
327500140612     C                   PARM                    PARMSEQ           2
327600140612     c                   parm                    parmeffymd        8
327700140612     c                   parm                    parmbenamt        7
327800140612     c                   parm                    parmgroup        15
327900140612     c                   parm                    parmbilrte       11
328000140612     c                   parm                    parmnetrte       11
328100140612     c                   parm                    parmbilprem       7
328200140612     c                   parm                    parmnetprem       7
328300140612     c                   parm                    parmfound         1
328400140612    ***
328500140612     c                   clear                   parmgroup
328600140612     c                   clear                   parmbilrte
328700140612     c                   clear                   parmnetrte
328800140612     c                   clear                   parmbilprem
328900140612     c                   clear                   parmnetprem
329000140612     c                   clear                   parmfound
329100140612    ***
329200140612     c                   call      'GETRATE'     grplist
329300140612    ***
329400140612     C                   ENDSR
329500140612   S***S
3296000904211477 C*
3297000904211478 C*------------------- FILL COVERAGE ARRAY  ---------------------*
3298000904211479 C*
3299000904211480 C     READ41        BEGSR
3300000904211481 C*
3301000904211482 C*  RETRIEVE PLAN DESCRIPTIONS
3302000904211483 C*
3303000904211486 C*
330400090429     C                   IF        *IN79 = *ON
330500090429     C                   EVAL      *IN83 = *OFF
330600090429     C                   END
330700090424      *
3308000904291489 C                   MOVEL     SSNO          MC4K1B
330900090429      *
3310000904291490 C  N83MC41KEY       SETLL     MCOV41
331100090429     C  N83              SETON                                        83
3312000904211492 C*
3313000904211493 C* GET PLAN AND RATE RECORDS AND MOVE TO ARRAY FOR ACTIVE COVERAGES
3314000904211494 C*
3315000904291496 C                   SETOFF                                       79
3316000904211495 C     #CVL41        TAG
331700090421     C*
331800090421     C*
3319000904291497 C     SSNO          READE     MCOV41                                 79
332000090429     C*
332100090429     C                   If        *IN79 = *OFF
3322000904290486 C                   Movel     B_MCTRST      MC4K3B
3323000904290486 C                   Movel     B_MCSUB#      MC4K4B
332400090429     C                   Movel     B_CANDT       MC4K9B
3325000904290486 C                   Movel     B_MCPLAN      MC4K5B
332600090429     C                   Movel     B_MCAGEB      MC4K6B
332700090429     C                   Movel     B_MCOVTP      MC4K7B
332800090429     C                   Movel     *HIVAL        MC4K8B
332900090429     C                   End
333000090429     C*
3331000904291505 C  N79DLTCD         IFEQ      'D'
3332000904211506 C                   GOTO      #CVL41
3333000904211507 C                   END
3334000904211508 C*
3335000904291509 C  N79DLTCD         IFNE      'D'
3336000904211510 C                   ADD       1             Z
3337000904211511 C*
3338000904211512 C     PlnKeyB       CHAIN     PLNMST                             98
3339000904211513 C                   MOVE      *BLANKS       PLINE
334000090421     C                   Move      B_MCPLAN      P#
3341001109161515 C  N98              MOVEL     PDESCR        PDSCR
3342001109161515 C   98              MOVEL     ER2(1)        PDSCR
334300090421     C     B_MCAGEB      IFEQ      *ZEROS
334400090421     C                   MOVE      *BLANKS       PAGBND
334500090421     C                   ELSE
3346000904211516 C                   MOVE      B_MCAGEB      PAGBND
334700090421     C                   END
334800090421     C*
3349000904211517 C                   MOVE      B_MCOVTP      PTCODE
335000110916
335100110916      * if original benefit is greater than current benefit then
335200110916      * show "Y" in Reduced Benefit column
335300110916
335400110916     c                   clear                   PRB
335500110916     c                   if        b_mcorgben > b_benamt
335600110916     c                   eval      PRB = 'Y'
335700110916     c                   end
335800110916
335900090421     C                   MOVE      B_ENRLDT      @DATIN
336000090421     C                   EXSR      #DATYM
336100090421     C                   MOVE      @DATOU        PENROL
336200090421     C*
3363000904211519 C     B_CANDT       IFGT      0
336400090421     C*
336500090421     C                   MOVE      B_CANDT       @DATIN
336600090421     C                   EXSR      #DATYM
336700090421     C                   MOVE      @DATOU        PCANCL
336800090421     C*
3369000904211521 C                   END
337000090421     C*
337100090421     C* Class
337200090421     C*
337300090421     C     ClsKey        Setll     CLASS
337400090421     C     ClsKey        Reade     CLASS
337500090421     C                   If        Not %Eof(CLASS)
337600090421     C                   Movel     CLCLASS       PBC
337700090421     C                   End
337800090421     C*
3379000904211522 C     B_BENAMT      IFGT      0
338000090421     C                   If        B_benamt <> *Zeros
338100090421     c                   eval      PBC   = %editc(B_benamt:'4')
338200090421     C                   End
3383000904211524 C                   END
3384000904211525 C*
3385000904211526 C* GRATE
3386000904211526 C*
3387000904211530 C                   MOVE      *BLANKS       ENRFLG            1
3388000904211531 C                   MOVE      *BLANKS       GERRFL
3389000904211532 C                   MOVE      UDATE8        CYMD              8 0
3390000904211540 C*
3391000904211541 C     #SETL41       TAG
3392000904211542 C*
3393000904211543 C                   SETOFF                                           60
3394000904211544 C                   Z-ADD     *ZEROS        GCOUNT
3395000904211545 C     RateKeyB      SETLL     GRATE
3396000904211546 C*
3397000904211547 C     #READ41       TAG
3398000904211548 C*
3399000904211549 C                   READ      GRATE                                  60
3400000904211550 C  N60RateKeyB      COMP      GRTKEY                             6060
3401000904211551 C   60              GOTO      #SKIP141
3402000904211552 C*
3403000904211553 C     CYMD          IFGE      FRMDAT
3404000904211554 C     CYMD          IFLE      TODAT
3405000904211555 C                   ADD       1             GCOUNT            2 0
3406000904211556 C                   GOTO      #SKIP141
3407000904211557 C                   END
3408000904211558 C                   END
3409000904211559 C*
3410000904211560 C                   GOTO      #READ41
3411000904211561 C*
3412000904211562 C     #SKIP141      TAG
3413000904211563 C*
3414000904211564 C     GCOUNT        IFEQ      *ZERO
3415000904211565 C     ENRFLG        IFNE      'Y'
3416000904211566 C                   MOVE      *BLANKS       GERRFL
3417000904211567 C                   MOVE      'Y'           ENRFLG
3418000905061568 C                   MOVE      B_ENRLDT      CYMD
3419000904211576 C*
3420000904211577 C                   GOTO      #SETL41
3421000904211578 C                   END
3422000904211579 C*
3423000904211581 C                   MOVE      'Y'           GERRFL            1
3424000904211582 C                   END
3425000904211583 C*
3426000904211584 C*---------- WJP 06/90: ---------------------------------------------
342700090421
342800090421      * if grate found, show group # and default rate in premium field
342900090421
3430000904211587 C     GERRFL        IFNE      'Y'
3431000904211588 C                   MOVE      GROUP#        PGRP#
3432000904211586 C                   z-add     BILRTE        PPREM2dec         7 2
343300131213      *
3434001312131586 C                   if        bilrte = 0
343500140612    ***
343600140612     C                   MOVE      *BLANKS       @ACA              1
343700140612     C                   EVAL      @ACA = #CHK_ACA_PLAN(B_MCTRST:B_MCSUB#:
343800140612     C                                B_MCPLAN)
343900140612     C                   IF        @ACA = 'Y'
344000140612     C                   EVAL      PARMSSN = %EDITC(SSNO:'X')
344100140612     C                   EVAL      PARMSEQ = 'FA'
344200140612     C                   MOVE      RATEKEYB      PARMKEY
344300140612     C                   MOVE      B_ENRLDT      PARMEFFYMD
344400140612     C                   MOVE      *ZEROS        PARMBENAMT
344500140612     C                   EXSR      #FNDRT
344600140612     C                   IF        PARMFOUND = 'Y'
344700140612     C                   MOVE      PARMBILRTE    WKBILRTE         11 6
344800140612     C                   Z-ADD     WKBILRTE      PPREM2DEC
344900140612     C                   ENDIF
345000140612     C                   ENDIF
345100140612    ***
3452001312131589 C                   endif
345300131213      *
345400090924     c****               eval      pprem = %editc(pprem2dec:'4')
345500090924      * show negative prem
345600090924     c                   eval      pprem = %editc(pprem2dec:'M')
3457000904211589 C                   ELSE
3458000904211590 C                   MOVE      ER(1)         PGRP#
345900090421     c                   clear                   pprem
3460000904211591 C                   END
346100090421
346200090421      * if the plan has been invoiced, show the last invoiced amount instead
3463000904211594 C     B_LPREM       IFGT      0
346400090924     c****               eval      pprem = %editc(B_lprem:'4')
346500090924      * show negative prem
346600090924     c                   eval      pprem = %editc(B_lprem:'M')
3467000904211596 C                   END
3468000904211597 C*
3469000904211598 C                   MOVEA     PLINE         PD(Z)
3470000904211599 C*
3471000904211600 C     Z             IFLT      7
3472000904211601 C                   GOTO      #CVL41
3473000904211602 C                   END
3474000904211603 C                   END
347500090421      *
347600090421     C     END41         Tag
3477000904211611 C*
3478000904211612 C                   ENDSR
3479009110211526 C*
348000911021     C     #GRATE        BEGSR
348100911021     C*
3482009807311527 C* GRATE
3483009110211528 C*
3484009110211529 C*
3485009110211530 C                   MOVE      *BLANKS       ENRFLG            1
3486009212221530 C                   MOVE      *BLANKS       GRP#11
3487009110211531 C                   MOVE      *BLANKS       GERRFL
3488009807311532 C                   MOVE      UDATE8        CYMD
3489009110211540 C*
3490009110211541 C     #SETL8        TAG
3491009110211542 C*
3492009110211543 C                   SETOFF                                           60
3493009110211544 C                   Z-ADD     *ZEROS        GCOUNT
3494009110211545 C     RKEY          SETLL     GRATE
3495009110211546 C*
3496009110211547 C     #READ8        TAG
3497009110211548 C*
3498009110211549 C                   READ      GRATE                                  60
3499009110211550 C  N60RKEY          COMP      GRTKEY                             6060
3500009110211551 C   60              GOTO      #SKIP8
3501009110211552 C*
3502009807311553 C     CYMD          IFGE      FRMDAT
3503009807311554 C     CYMD          IFLE      TODAT
3504009110211555 C                   ADD       1             GCOUNT            2 0
3505009110211556 C                   GOTO      #SKIP8
3506009110211557 C                   END
3507009110211558 C                   END
3508009110211559 C*
3509009110211560 C                   GOTO      #READ8
3510009110211561 C*
3511009110211562 C     #SKIP8        TAG
3512009110211563 C*
3513009110211564 C     GCOUNT        IFEQ      *ZERO
3514009110211565 C     ENRFLG        IFNE      'Y'
3515009110211566 C                   MOVE      *BLANKS       GERRFL
3516009110211567 C                   MOVE      'Y'           ENRFLG
3517009807311532 C                   MOVE      ENRLDT        CYMD
3518009110211576 C*
3519009110211577 C                   GOTO      #SETL8
3520009110211578 C                   END
3521009110211579 C*
3522009110211581 C                   MOVE      'Y'           GERRFL            1
3523009110211582 C                   END
3524009110211583 C*
3525009110211585 C*
3526009110211587 C     GERRFL        IFNE      'Y'
3527009212221588 C                   MOVE      GRP#11        HGRP11           11
3528009110211589 C                   ELSE
3529009212221590 C                   MOVEL     ER(1)         HGRP11
3530009110211591 C                   END
3531009110211592 C*
353200911021     C     #ENDGR        ENDSR
3533009407290672 C*---------------------------------------------------------------
3534009407290673 C*
3535009407290674 C*#PRC08 SUBROUTINE - PROCESS PRIMARY PLANS         .......
3536009407290675 C*
3537009407290676 C*
3538009407290677 C     #PRC08        BEGSR
353900940729     C*
354000940729     C                   Z-ADD     1             V                 2 0
354100940729     C                   SETOFF                                           80
354200940729     C     'X'           LOOKUP    SL(V)                                  80
354300940729     C  N80              EXCEPT    SCRN08
354400940729     C  N80              GOTO      #END08
354500940729     C*
354600940729     C                   MOVEL     ACC#          APLKEY           14
354700940729     C                   MOVE      PL(V)         APLKEY
354800980803     C                   MOVE      PL(V)         HPRPL#            4
354900940729     C                   MOVE      DS(V)         HPRDSC           40
355000940729     C                   MOVE      *BLANKS       CDS
355100940729     C                   MOVE      *BLANKS       PDS
355200980731     C                   MOVE      *BLANKS       CP
355300980731     C                   MOVE      *BLANKS       PP
355400940729     C                   SETOFF                                           81
355500940729     C     APLKEY        CHAIN     APLNP                              66
355600940729     C  N66              SETON                                        81
355700940729     C  N66              EXSR      #GETPL
355800940729     C  N66              EXCEPT    SCRN09
355900940729     C*
356000940729     C     #END08        TAG
356100940729     C*
356200940729     C                   ENDSR
3563009407290678 C*
356400940729     C     #GETPL        BEGSR
356500940729     C*
356600940729     C                   MOVE      *BLANKS       CDS
356700940729     C                   MOVE      *BLANKS       PDS
356800940729     C                   MOVE      *BLANKS       ERRFLG
356900980803     C                   MOVEL     HARDCD        SKEY             10
357000940729     C                   Z-ADD     1             S                 2 0
357100940729     C                   DO        20
357200980731     C     CP(S)         IFNE      *BLANKS
357300990512     C     CP(S)         ANDNE     '0000'
357400940729     C                   MOVE      CP(S)         SKEY
357500940729     C     SKEY          CHAIN     PLNMST                             67
357600940729     C  N67              MOVEL     PDESCR        CDS(S)
357700940729     C   67              MOVEL     MSG(5)        CDS(S)
357800940729     C   67              MOVE      'Y'           ERRFLG            1
357900940729     C                   END
358000940729     C*
358100980731     C     PP(S)         IFNE      *BLANKS
358200990512     C     PP(S)         ANDNE     '0000'
358300940729     C                   MOVE      PP(S)         SKEY
358400940729     C     SKEY          CHAIN     PLNMST                             67
358500940729     C  N67              MOVE      PDESCR        PDS(S)
358600940729     C   67              MOVEL     MSG(5)        PDS(S)
358700940729     C   67              MOVE      'Y'           ERRFLG            1
358800940729     C                   END
358900940729     C*
359000940729     C                   ADD       1             S
359100940729     C                   END
359200940729     C*
359300940729     C                   ENDSR
3594009407290757 C*-------------------------------------------------------------------
3595009407290671 C*
3596009407290673 C*
3597009407290674 C*#PRC09 SUBROUTINE - PROCESS PRIMARY BENEFIT PLANS        .......
3598009407290675 C*
3599009407290676 C*
3600009407290677 C     #PRC09        BEGSR
360100940729     C*
360200940729     C                   SETOFF                                       98
360300940729     C*
3604009407290758 C*
360500940729     C* ONLY CHECK FOR DUP PLAN ON AN ADD CONDITION (IND 66 = ON)
360600940729     C*
360700940729     C*
360800940729     C*
360900940729     C*
361000940729     C                   EXSR      #GETPL
361100940729     C                   EXCEPT    SCRN09
361200940729     C     #END09        TAG
361300940729     C                   ENDSR
361400940729     C*
3615009407290827 C*----------------------------------------------------
361600941205     C* ADDED 12/94 TO DISPLAY WINDOW FOR ENTRY OF TRANSACTION
361700941205     C* DATE, TO SET LIMITS TO TRANSACTION DISPLAY. GLC.
361800940729     C*
3619009411300818 C     #WINDW        BEGSR
362000941202     C                   EXCEPT    SCRN99
362100941130     C                   ENDSR
362200941130     C*
3623009407290818 C     #PRIPL        BEGSR
3624009407290819 C*                    SETOF                         69
362500940729     C                   MOVE      *BLANKS       SL
362600940729     C                   MOVE      *BLANKS       PL
362700940729     C                   MOVE      *BLANKS       DS
362800940729     C                   Z-ADD     1             Q                 2 0
362900940729     C                   MOVEL     ACC#          SETL             14
363000940729     C     SETL          SETLL     APLNP
363100940729     C     #PREAD        TAG
363200940729     C                   READ      APLNP                                  69
363300940729     C   69              GOTO      #PEND
363400940729     C     ACC#          IFNE      AACCT#
363500940729     C                   GOTO      #PEND
363600940729     C                   END
363700940729     C*
363800940729     C                   MOVE      PRIPLN        PL(Q)
363900940729     C                   MOVEL     ACC#          KEYPLN           10
364000940729     C                   MOVE      PRIPLN        KEYPLN
364100940729     C     KEYPLN        CHAIN     PLNMST                             44
364200940729     C  N44              MOVEL     PDESCR        DS(Q)
364300940729     C                   ADD       1             Q
364400061103     c                   if        q <= 16
364500940729     C                   GOTO      #PREAD
364600061103     c                   end
364700940729     C     #PEND         TAG
364800940729     C                   EXCEPT    SCRN08
3649009407290826 C                   ENDSR
3650009108011654 C******************************************************
3651009108010448 C/EJECT
3652009108010449 C     ERRSR         BEGSR
3653009108010450 C*
3654009108010451 C*
3655009108010452 C*        IF RETURN CODE = 01122, ROLL UP WAS USED.
3656009108010453 C*        IF RETURN CODE = 01123, ROLL DOWN WAS USED.
3657009108010454 C*
3658001601080455 C     WDSTS         COMP      01122                                  46
3659001601080456 C     WDSTS         COMP      01123                                  47
366000910905     C*
366100910905     C  N46
366200910905     CANN47              SETON                                            46
3663000103210458 C*
3664000103210458 C* ON ROLL KEY, FORCE MEMBER ROLL....
366500010321     C   35
366600010326     COR 36              SETON                                        0308
3667000103260458 C*
3668000103260458 C* If page up, then reset endroll to 0's, otherwise
3669000103260458 C* If page dw, then set 08 off so page display starts at beg.
367000010326     C   35              Z-ADD     *ZEROS        ENDROLL
367100010326     C   36ENDROLL       IFNE      0
367200010326     C                   SETOFF                                       08
367300010326     C                   END
3674000103210458 C*
3675000103210458 C* BUT, IF PRIOR F12(MEMBERS) REDISPLAY ACCOUNT...
367600011128     c                   if        *inkl or *inkm
367700010323     C                   IF        F12 = 'M'
367800010323     C                   SETOFF                                       03
367900010323     C                   Else
368000010323     C                   SETOFF                                       05
368100011128     C                   SETOFF                                       KLkm
368200010323     C                   MOVE      ' '           F12
3683000103260971 C                   SETON                                        13
3684000103280972 C                   EXCEPT
3685000103260973 C                   SETOFF                                       13
368600010328     C                   END
368700010321     C                   END
3688000103210458 C* BUT, IF PRIOR F10(PCP) REDISPLAY MEMBER...
368900010321     C     *INKJ         IFEQ      *ON
369000010321     C                   SETOFF                                       KJ
369100010321     C                   END
3692009108010457 C                   ENDSR     '*DETC'
3693009108010458 C*
3694009108010459 C/EJECT
369500970928     C****************************************************************
369600970928     C* CALL SECURITY PROGRAM FOR CONTACT SEARCH
369700970928     C****************************************************************
369800970928     C     $SECAL        BEGSR
369900970928     C                   MOVEL     $USER         ISCUSR
370000970928     C                   CALL      'SC020'
370100970928     C                   PARM                    ISCUSR           10
370200970928     C                   PARM                    ISCALL            3
370300970928     C                   PARM                    ISCT1             3 0
370400970928     C                   PARM                    ISCT2             3 0
370500970928     C                   PARM                    ISCT3             3 0
370600970928     C                   PARM                    ISCT4             3 0
370700970928     C                   PARM                    ISCT5             3 0
370800970928     C                   PARM                    ISCT6             3 0
370900970928     C                   PARM                    ISCT7             3 0
371000970928     C                   PARM                    ISCT8             3 0
371100970928     C                   PARM                    ISCT9             3 0
371200970928     C                   PARM                    ISCT10            3 0
371300970928     C                   PARM                    ISCS1             3 0
371400970928     C                   PARM                    ISCS2             3 0
371500970928     C                   PARM                    ISCS3             3 0
371600970928     C                   PARM                    ISCS4             3 0
371700970928     C                   PARM                    ISCS5             3 0
371800970928     C                   PARM                    ISCS6             3 0
371900970928     C                   PARM                    ISCS7             3 0
372000970928     C                   PARM                    ISCS8             3 0
372100970928     C                   PARM                    ISCS9             3 0
372200970928     C                   PARM                    ISCS10            3 0
372300970928     C                   PARM                    ISCA1             4 0
372400970928     C                   PARM                    ISCA2             4 0
372500970928     C                   PARM                    ISCA3             4 0
372600970928     C                   PARM                    ISCA4             4 0
372700970928     C                   PARM                    ISCA5             4 0
372800970928     C                   PARM                    ISCA6             4 0
372900970928     C                   PARM                    ISCA7             4 0
373000970928     C                   PARM                    ISCA8             4 0
373100970928     C                   PARM                    ISCA9             4 0
373200970928     C                   PARM                    ISCA10            4 0
373300970928     C                   PARM                    ISAA1             3
373400970928     C                   PARM                    ISAA2             3
373500970928     C                   PARM                    ISAA3             3
373600970928     C                   PARM                    ISAA4             3
373700970928     C                   PARM                    ISAA5             3
373800970928     C                   PARM                    ISAA6             3
373900970928     C                   PARM                    ISAA7             3
374000970928     C                   PARM                    ISAA8             3
374100970928     C                   PARM                    ISAA9             3
374200970928     C                   PARM                    ISAA10            3
374300970928     C                   PARM                    ISCBRK            3
374400970928     C                   PARM                    ISCDSP            1
374500970928     C                   PARM                    ISSUPD            1
374600970928     C                   PARM                    ISCNAM           40
374700970928     C                   PARM                    ISCBUS           40
374800970928     C                   PARM                    ISCADD           40
374900970928     C                   PARM                    ISCITY           40
375000970928     C                   PARM                    ISCST             2
375100970928     C                   PARM                    ISCPHO           10
375200970928     C                   PARM                    ISCFAX           10
375300970929     C                   PARM                    NOS               1
375400000406     C***                FREE      'SC020'
375500970929     C                   MOVE      ISCT1         OSCT1
375600970929     C                   MOVE      ISCT2         OSCT2
375700970929     C                   MOVE      ISCT3         OSCT3
375800970929     C                   MOVE      ISCT4         OSCT4
375900970929     C                   MOVE      ISCT5         OSCT5
376000970929     C                   MOVE      ISCT6         OSCT6
376100970929     C                   MOVE      ISCT7         OSCT7
376200970929     C                   MOVE      ISCT8         OSCT8
376300970929     C                   MOVE      ISCT9         OSCT9
376400970929     C                   MOVE      ISCT10        OSCT10
376500970928     C                   ENDSR
376600970928     C*
3767009807310107 C*
3768009807310103 C***************************************************
3769009807310104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
3770009807310105 C***************************************************
3771009807310107 C*
3772009807310107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
3773009807310107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
3774009807310107 C*
3775009807310106 C     #DATYM        BEGSR
377600980731     C                   MOVE      @DATIN        @MD               4 0
377700980731     C                   MOVEL     @DATIN        @Y                4 0
377800980731     C                   MOVEL     @MD           @DATOU            8 0
377900980731     C                   MOVE      @Y            @DATOU
378000980731     C                   MOVE      *ZEROS        @DATIN            8 0
3781009807310120 C                   ENDSR
3782009902080107 C*
3783009902080103 C***************************************************
3784009902080104 C* DISPLAY ACCOUNT SCREEN - IO05                   *
3785009902080105 C***************************************************
3786009902080107 C*
3787009902080106 C     #DSP05        BEGSR
378800140115
378900050630     C                   Movel     COBADM        RCOBADM           5 2
379000090413     C                   Move      ACC#          BenKey
379100160819
379200160819     C                   Movel     azip          azip5             5
379300160819     C                   Move      azip          azip4             4
379400160819
379500160819      * format zip code for output
379600160819       clear azipout;
379700160819       if azip <> 0;
379800160819       azipout = azip5;
379900160819        if azip4 <> '0000';
380000160819        azipout = azip5 + '-' + azip4;
380100160819        endif;
380200160819       endif;
380300140115
380400160819      * format phone # for output
380500160819       clear aphoneout;
380600160819       if acctphone10 <> 0;
380700160819       aphoneout = %trim(%editw(acctphone10:'0(   )   -    '));
380800160819       endif;
380900160819
381000160819      * format fax # for output
381100160819       clear faxout;
381200160819       if acctfax10 <> 0;
381300160819       faxout = %trim(%editw(acctfax10:'0(   )   -    '));
381400160819       endif;
381500160819
381600180501      * get paid through date
381700180501       clear ptdateout;
381800180501       parmtsa = %editc(acc#:'X');
381900180629       parmptdate = *blanks;
3820001805010694 c                   call      'GETPTHRUCL'
382100180501     c                   parm                    parmtsa
382200180501     c                   parm                    parmptdate
382300180501
382400180501     c                   if        parmptdate <> '00000000'
382500180501     C                   MOVE      parmptdate    @DATIN
382600180501     C                   EXSR      #DATYM
382700180501     C                   MOVE      @DATOU        ptdateout
382800180501     c                   end
382900180501
383000180501
3831001401151083 C* if ACA account - display text
383200140115     c                   exsr      #checkaca
383300140115
383400140115      *---
383500140115      * Get Misc Supplemental Info:  CFS 834 Effective Date
383600140115      *---
383700090624     C                   Clear                   PAYR              4
383800090413     C     AccBen        Chain     ACCMSP
383900090413     C                   If        %Found(ACCMSP)
384000090624     C                   Movel     AMPAYR        PAYR
384100090413     C                   If        AMC8DT   <>   *Zero
384200090413     C                   Move      AMC8DT        @DATIN
384300090413     C                   Exsr      #DATYM
384400090413     C                   Move      @DATOU        CFSDT             8
384500090413     C                   Else
384600090413     C                   Eval      CFSDT    =    *Blanks
384700090413     C                   End
384800090413     C                   Else
384900090413     C                   Eval      CFSDT    =    *Blanks
385000090413     C                   End
385100120514      * Access AC2MST to retrieve Luminx flag.
385200120514     C     Ac2Key        Chain     AC2MST
385300120514     C                   If        %Found(AC2MST)
385400120514     C                   End
3855001306271084 C                   Movel     A2CODE1       RREREP            3
3856001206200914 C*
3857001206200907 C* Highlight Senior Dental Writeoff Balance("SD Bal") if any exist
3858001206200908 C*
385900120620     C     AccBen        Setll     ACCSWB
386000120620     C     AccBen        Reade     ACCSWB
386100120620     C                   If        Not %Eof(ACCSWB)
386200120620     C                   Eval      *in72 = *on
386300120620     C                   Else
386400120620     C                   Eval      *in72 = *off
386500120620     C                   End
386600061205      *---
386700061206      * Get Active OLE beginning & ending dates, code and description
386800061205      *---
386900061212     C                   Clear                   RAOBEDT
387000061212     C                   Clear                   RAOENDT
387100061212     C                   Clear                   RAEDESC
387200130312      *-------------------------------------------------------*
387300130312     C     *ISO          Move      UDATE8        TomorISO
387400130312     C                   AddDur    1:*D          TomorISO
387500130312     C     *ISO          Move      TomorISO      OneMoreDay
387600130312      *-------------------------------------------------------*
387700130312     C     AccOle        Setll     ACCOSPL2
387800130312     C     AccBen        Reade     ACCOSPL2
387900130312     C                   Dou       %Eof(ACCOSPL2)
388000130312     C                   If        Not %Eof(ACCOSPL2)
388100130312     C                   If        AOBEDT    <= OneMoreDay And
388200130312     C                             (AOENDT   >= OneMoreDay
388300061208     C                                    Or
388400130312     C                             (AOBEDT   <= OneMoreDay And
388500061208     C                              AOBEDT   <> *Zeros  And
388600061208     C                              AOENDT    = *Zeros))
388700061205     C                   IF        AOBEDT   <>   *Zero
388800061205     C                   MOVE      AOBEDT        @DATIN
388900061205     C                   EXSR      #DATYM
389000061205     C                   MOVE      @DATOU        RAOBEDT           8
389100061205     C                   Else
389200061205     C                   Eval      RAOBEDT  =    *Blanks
389300061205     C                   END
389400061205     C                   IF        AOENDT   <>   *Zero
389500061205     C                   MOVE      AOENDT        @DATIN
389600061205     C                   EXSR      #DATYM
389700061205     C                   MOVE      @DATOU        RAOENDT           8
389800061205     C                   Else
389900061205     C                   Eval      RAOENDT  =    *Blanks
390000061205     C                   END
390100061205     C     AOCODE        Chain     AOECOD
390200061205     C                   If        %Found(AOECOD)
390300061205     C                   Eval      RAEDESC   =   %Trim(AEDESC)
390400061205     C                   Else
390500061206     C                   Movel     *Blanks       RAEDESC          20
390600070402     C                   Movel     AOCODE        aocodea           2
390700070402     C                   Eval      RAEDESC   =   %Trim('OLE ' + aocodea +
390800061206     C                                           ' Not on file')
390900061205     C                   End
391000061205     C                   Leave
391100061205     C                   Else
391200061205     C                   Eval      RAOBEDT  =    *Blanks
391300061205     C                   Eval      RAOENDT  =    *Blanks
391400061206     C                   Eval      RAEDESC  =    %Trim('No Current OLE Range')
391500061205     C                   End
391600130312     C     AccBen        Reade     ACCOSPL2
391700061206     C                   End
391800061205     C                   Enddo
391900050411     C*
3920000506300207 C*****              MOVE      GBSBDT        @DATIN
3921000506300207 C*****              EXSR      #DATYM
3922000506300207 C*****              MOVE      @DATOU        GBSBDT
392300010207     C*
392400990208     C                   MOVE      ACVTDT        @DATIN
392500990208     C                   EXSR      #DATYM
392600990208     C                   MOVE      @DATOU        ACVTDT
392700990208     C*
392800990208     C                   MOVE      ENROLL        @DATIN
392900990208     C                   EXSR      #DATYM
393000990208     C                   MOVE      @DATOU        ENROLL
393100990208     C*
393200990208     C     ATRMDT        IFNE      0
393300990208     C                   MOVE      ATRMDT        @DATIN
393400990208     C                   EXSR      #DATYM
393500990208     C                   MOVE      @DATOU        ATROUT            8
393600990208     C                   ELSE
393700990208     C                   MOVE      *BLANKS       ATROUT
393800990208     C                   END
393900050630     C                   IF        GBSBDT   <>   *Zero
394000050630     C                   MOVE      GBSBDT        @DATIN
394100050630     C                   EXSR      #DATYM
394200050630     C                   MOVE      @DATOU        RGBSBDT           8
394300050630     C                   Else
394400050630     C                   Eval      RGBSBDT  =    *Blanks
394500050630     C                   END
394600130107
394700110429      *
394800180109      * Show "Dentures" rather than "Average Age" if it is Senior Dental
394900200107      * or Advanced Mobile or Care Services Management
395000110429     C     Trust         Chain     TRSMST
395100110429     C                   If        %Found(TRSMST)
395200200107     C                   If        (TSCODE = 'O N' or tscode = 'O M' or
395300200107     C                              TSCODE = 'O D')
395400110429     C                   Eval      *in86 = *On
395500120620     C                   If        ATRMDT  <> *Zero AND ATRMDT < *DATE
395600120620     C                   Eval      *In61 = *On
395700120620     C                   Else
395800120620     C                   Eval      *in61 = *Off
395900120620     C                   End
396000110429     C                   Else
396100110429     C                   Eval      *in86 = *Off
396200110429     C                   End
396300110429     C                   End
396400990208     C*
396500160819     c                   clear                   aanamout         20
396600160819     C     AACOD         CHAIN     AACODE
396700160819       if %found(aacode);
396800211130       aanamout = %subst(aa_afnam:1:1) + '.' + %subst(aa_alnam:1:18);
396900160819       else;
397000160819       aanamout = aacod + ' <-INVALID CODE';
397100160819       endif;
397200020109     C*
3973000201090907 C* highlight "DIARY" on screen if diary records exists (*in85=*on)
3974000201090908 C*
397500020109     c                   clear                   diarykey         10
397600020109     c                   move      acc#          diarykey
397700020109     c     diarykey      chain     diaryhd1
397800020109     c                   if        %found(diaryhd1)
397900020109     c                   eval      *in85 = *on
398000020109     c                   else
398100020109     c                   eval      *in85 = *off
398200020109     c                   end
3983000201090914 C*
398400150515      * Determine if Open Issues exist for Acct
398500150515      *
398600150515     C                   eval      *in88 = '0'
398700150515      *
3988001505151490 C     isskeya       setll     itissp
398900150515     C                   dou       *IN98 = '1'
3990001505151497 C     isskeya       reade     itissp                                 98
399100150515      *
399200150515     C                   IF        *IN98 = *ON or acc <> itacct
3993001505151379 C                   leave
3994001505151379 C                   endif
399500150515      *
399600150515     C                   IF        itsts = 'O'
399700150515     c                   eval      *in88 = '1'
3998001505151379 C                   leave
3999001505151379 C                   endif
4000001505151380  *
4001001505151379 C                   enddo
4002001505151380  *
400300020109     C*
400400020109     C*
400500990208     C                   SETON                                        15
400600990208     C                   EXCEPT
400700990208     C                   SETOFF                                       15
400800980731     C*
4009009902080120 C                   ENDSR
401000000612     C*
401100000612     C*
4012000006120103 C***************************************************
401300000612     C* get user name                                   *
4014000006120103 C***************************************************
401500000612     C*
4016000006120120 C     #getuser      begsr
401700000612
401800000612     c                   move      *blanks       hoperout
401900000612
402000000613     c* only show "user" field if the current user is a GBS employee,
402100000613     c* brokers and accounts do not see who performed the transaction
402200000613
402300000613     c                   if        iscdsph = 'N'
402400000613
402500000612     c                   movel     hoper         gbseckey         10
402600000612     C     gbseckey      CHAIN     GBSECURE
402700000612     c                   if        %found(gbsecure)
402800000613     c                   movel     scname        hoperout         10
402900000612     c                   end
403000000613
403100000613     c                   end
403200000613
4033000006120120 C                   ENDSR
403400000612     C*
4035001401150103 C***************************************************
403600140115     C* does this acct have any aca plans?              *
4037001401150103 C***************************************************
4038001401150120 C     #checkaca     begsr
403900140115     c                   clear                   acatext           6
404000140115     C                   Eval      *in37 = *off
404100140115
404200140115      * read commission control for an aca plan
404300140115     C     accben        setll     cmct14
404400140115     C                   dou       %eof(cmct14)
404500140115     C     accben        reade     cmct14
404600140116     c                   if        not %eof(cmct14) and
404700140116     c                             (cmcan = 0 or cmcan >= udate8)
404800140115      * is this is an aca plan?
404900140115     C     cmctspkey     CHAIN     plnauxp
405000150226     c                   if        %found(plnauxp)
405100150226     c                   if        pxacar = 'Y' or pxacar = 'D'
405200150226     c                   eval      acatext = ' MLR  '
405300140115      * *in37 = reverse image field
405400140115     C                   Eval      *in37 = *On
405500140115     c                   leave
405600150226     c                   endif
405700150226     c                   endif
405800150226     c                   endif
405900140115
406000140115     c                   enddo
406100140115
4062001401150120 C                   ENDSR
406300140115     C*
406400990208     C*
406500090521    ? *___________________________________________________________________
406600090521    ? * Clear F5 Coverage Roll Keys
406700090521    ? *___________________________________________________________________
406800090521    ?C     CLRF5KEY      Begsr
406900090521
4070000905210486 C                   Clear                   MC4K2
4071000905210486 C                   Clear                   MC4K3
4072000905210486 C                   Clear                   MC4K4
4073000905210486 C                   Clear                   MC4K5
4074000905210486 C                   Clear                   MC4K6
4075000905210486 C                   Clear                   MC4K7
4076000905210486 C                   Clear                   MC4K8
4077000905210486 C                   Clear                   MC4K2B
4078000905210486 C                   Clear                   MC4K3B
4079000905210486 C                   Clear                   MC4K4B
408000090521     C                   Clear                   MC4K9B
4081000905210486 C                   Clear                   MC4K5B
4082000905210486 C                   Clear                   MC4K6B
4083000905210486 C                   Clear                   MC4K7B
4084000905210486 C                   Clear                   MC4K8B
408500090521
408600090521     C                   Endsr
408700050411    ? *___________________________________________________________________
408800050411    ? * Key lists
408900050411    ? *___________________________________________________________________
409000050411    ?C     KLIST         Begsr
409100130312      *
409200130312     C     AccOle        Klist
409300130312    ?C                   Kfld                    Trust
409400130312    ?C                   Kfld                    Sub
409500130312    ?C                   Kfld                    Acc
409600130312     C                   Kfld                    HighDate
409700130312      *
409800110720    ?C     dep2key       Klist
409900110720    ?C                   Kfld                    dep2kssn          9 0
410000110720    ?C                   Kfld                    dep2kseq          2 0
410100110720
410200110720    ?C     AccBen        Klist
410300110720    ?C                   Kfld                    Trust
410400110720    ?C                   Kfld                    Sub
410500050411    ?C                   Kfld                    Acc
410600080429    ?C     AltKey        Klist
410700080429    ?C                   Kfld                    SSNO
410800080429    ?C                   Kfld                    AltType           4
410900090513    ?C     subsidkey     Klist
411000090513    ?C                   Kfld                    SSNO
411100090513    ?C                   Kfld                    allnines          8 0
411200090420     C     ClsKey        Klist
4113000904200037 C                   Kfld                    PLTRST
4114000904200038 C                   Kfld                    PLSUB#
4115000904200039 C                   Kfld                    PLPLAN
411600140115
411700140115     C     cmctspkey     Klist
4118001401150037 C                   Kfld                    CMTRST
4119001401150038 C                   Kfld                    CSUBDV
4120001401150039 C                   Kfld                    CMPLAN
412100140115
4122000904210484 C     MC4KEY        Klist
4123000904210485 C                   Kfld                    MC4K1             9 0
4124000904210486 C                   Kfld                    MC4K2             2 0
4125000904210486 C                   Kfld                    MC4K3             3 0
4126000904210486 C                   Kfld                    MC4K4             3 0
4127000904210486 C                   Kfld                    MC4K5             4
4128000904210486 C                   Kfld                    MC4K6             2 0
4129000904210486 C                   Kfld                    MC4K7             3
4130000904210486 C                   Kfld                    MC4K8             8 0
4131000904210484 C     MC41KEY       Klist
4132000904290485 C                   Kfld                    MC4K1B            9 0
4133000904290486 C                   Kfld                    MC4K2B            2 0
4134000904290486 C                   Kfld                    MC4K3B            3 0
4135000904290486 C                   Kfld                    MC4K4B            3 0
413600090429     C                   Kfld                    MC4K9B            8 0
4137000904290486 C                   Kfld                    MC4K5B            4
4138000904290486 C                   Kfld                    MC4K6B            2 0
4139000904290486 C                   Kfld                    MC4K7B            3
4140000904290486 C                   Kfld                    MC4K8B            8 0
414100120511
414200120511     C     keyinvdnp     Klist
414300120511     C                   Kfld                    hi_trust
414400120511    ?C                   Kfld                    hi_sub
414500120511    ?C                   Kfld                    hi_acc
414600120511    ?C                   Kfld                    ck#notinv#
414700120514     C     AC2Key        Klist
414800120514     C                   Kfld                    Fully
414900120514    ?C                   Kfld                    Trust
415000120514    ?C                   Kfld                    Sub
415100120514    ?C                   Kfld                    Acc
415200120511
415300050411    ?C                   Endsr
415400050616
415500050616
415600050616    ?C     *inzsr        begsr
415700120620     C     *DATE         Mult      10000.0001    Today             8 0
415800130312     C                   Z-add     99999999      HighDate          8 0
415900090413     C                   Move      *Blanks       CSFFLSH           6
416000050616     C                   MOVE      *BLANKS       BLANK            79
4161000506160621 C                   MOVE      *DATE         UDATE8            8 0
4162000612050622 C                   MOVE      'Y'           FCYCLE            1
416300050616     C                   MOVEL     '794001'      HARDCD            6 0
416400120627      * put system date in systemdate field (*ISO = YYYYMMDD)
416500120627      /free
416600120627       systemdate = %date();
416700120627      /end-free
416800120627     C                   MOVE      systemdate    systemdtymd       8 0
416900120627     C                   MOVEl     systemdtymd   systemdtyear      4 0
417000120627     C                   MOVE      systemdtymd   systemdtmd        4 0
417100120627
417200050616     c* get display access security for the current user
417300050616     c* if current user does not have access to see who performed the
417400050616     c* transaction, set on *in87 to make "user" heading not display.
417500050616     c* and "CMD10 - PCP display" not display
417600050616
417700050616
417800050616     c                   exsr      $secal
417900050616     c                   move      iscdsp        iscdsph           1
418000050616     c                   if        iscdsph <> 'N'
418100050616     c                   eval      *in87 = *on
418200050616     c                   end
418300050616    ?C                   Endsr
418400160104      *-----------------------------------------------------------------
418500160104      *? Set the libray list based on the TSA/SSN
418600160104      *-----------------------------------------------------------------
418700160104    ?C     SETLIBL       Begsr
418800160104
418900160104     c                   call      'QUSRJOBI'
419000160104     c                   parm                    Rcvvar
419100160104     c                   parm                    RcvVarLen
419200160104     c                   parm      'JOBI0700'    Format
419300160104     c                   parm      '*'           QualJobName
419400160104     c                   parm      *blanks       IntJobID
419500160104
419600160104      *-------------------------------------------------------------------
419700160104      *? Extract user library list and return it to caller               -
419800160104      *-------------------------------------------------------------------
419900160104     c                   eval      libsToSkip = NbrSysLibs +
420000160104     c                                          NbrPrdLibs +
420100160104     c                                          NbrCurLibs
420200160104     C
420300160104     c                   eval      pos = ( LibsToSkip * 11 ) + 81
420400160104     C
420500160104     c                   eval      usrLibs = %Subst(
420600160104     c                                               RcvVar          :
420700160104     c                                               Pos             :
420800160104     c                                               NbrUsrLibs * 11
420900160104     c                                             )
421000160104
421100160104      * check for RPGSPDASH in current library list
421200160104     C                   eval      dsh = %lookup('RPGSPDASH':theLibs)
421300160104
421400160104      * check for RPGSPPAYR in current library list
421500160104     C                   eval      pay = %lookup('RPGSPPAYR':theLibs)
421600160108
421700160108      * reset some fields
421800160108     C                   select
421900160108     C                   when      %trim(WDLSTF) = 'IO01'
422000160108     C                   clear                   ss
422100160108     C                   clear                   sel
422200160108     C                   clear                   selacc
422300160108     C                   clear                   ssno03
422400160108     C                   clear                   acc05
422500160108     C                   when      %trim(WDLSTF) = 'IO02'
422600160108     C                   clear                   ssno
422700160108     C                   clear                   ssno03
422800160108     C                   clear                   selacc
422900160108     C                   clear                   acc#
423000160108     C                   clear                   acc05
423100160108     C                   when      %trim(WDLSTF) = 'IO03'
423200160108     C                   clear                   ss
423300160108     C                   clear                   sel
423400160108     C                   clear                   selacc
423500160108     C                   clear                   acc#
423600160108     C                   clear                   acc05
423700160108     C                   when      %trim(WDLSTF) = 'IO04'
423800160108     C                   clear                   ssno
423900160108     C                   clear                   ssno03
424000160108     C                   clear                   selacc
424100160108     C                   clear                   acc#
424200160108     C                   clear                   acc05
424300160108     C                   when      %trim(WDLSTF) = 'IO05'
424400160108     C                   clear                   ssno
424500160108     C                   clear                   ssno03
424600160108     C                   clear                   ss
424700160108     C                   clear                   sel
424800160108     C                   clear                   selacc
424900160108     C                   endsl
425000160104
425100160104      * check for selected account
425200160104     C                   eval      selacc = %lookup('X':sel)
425300160108     C                   if        selacc > 0
425400160108     C                   eval      len = %len(%trim(ss(selacc)))
425500160108     C                   If        len = 10
425600160104     C                   move      ss(selacc)    acc05
425700160108     C                   else
425800160108     C                   move      ss(selacc)    ssno
425900160108     C                   end
426000160104     C                   end
426100160204
426200160104
426300160113      * If neither(PAYR or DASH), leave alone must be programmer/beta
426400160104     C                   if        dsh = 0 and
426500160104     C                             pay = 0
426600160108     C                   exsr      opnpayroll
426700160104     C                   LeaveSR
426800160104     C                   end
426900160204
427000160204      * use a work field
427100160204     C                   eval      LIB_SSNO = 0
427200160204     C                   If        ssno   <> 0 and
427300160204     C                             ssno03 <> 0
427400160204     C                   eval      LIB_SSNO = ssno03
427500160204     C                   else
427600160204     C                   eval      LIB_SSNO = ssno
427700160204     C                   end
427800160104
427900160104      * get the TSA
428000160104     C                   select
428100160104     C                   when      acc05 <> 0
428200160104     C                   move      acc05         dashacc#
428300160104     C                   when      acc# <> 0
428400160104     C                   move      acc#          dashacc#
428500160204     C                   when      LIB_SSNO  <> 0
428600160204     C                   eval      SAV_SSNO = SSNO
428700160210     C     LIB_SSNO      chain     memssn
428800160210     C                   If        %found(memssn)
428900160204     C                   eval      SSNO = SAV_SSNO
429000160210     C                   eval      dasht = S_MBTRST
429100160210     C                   eval      dashs = S_MBSUB#
429200160210     C                   eval      dasha = S_MBACCT
429300160104     C                   end
429400160104     C                   Other
429500160104     C                   eval      dasht = 0
429600160104     C                   eval      dashs = 0
429700160104     C                   eval      dasha = 0
429800160104     C                   endsl
429900160104
430000160104      * get current version of OLE
430100160104     C                   eval      ver = #getver(dasht:dashs:dasha)
430200160104
430300160104      * determine if library list should change
430400160104     C                   select
430500160104      * non-dashboard, leave libl alone
430600160104     C                   when      dsh = 0 and
430700160104     C                             ver < 8
430800160108     C                   exsr      opnpayroll
430900160104     C                   LeaveSR
431000160104
431100160104      * dashboard, leave libl alone
431200160104     C                   when      dsh >  0 and
431300160104     C                             ver >= 8
431400160108     C                   exsr      opnpayroll
431500160104     C                   LeaveSR
431600160104
431700160104      * non-dashboard, but should be dashboard
431800160104     C                   when      dsh =  0 and
431900160104     C                             ver >= 8
432000160104     C                   exsr      switchtodash
432100160104
432200160104      * dashboard, but shouldn't be dashboard
432300160104     C                   when      dsh > 0 and
432400160104     C                             ver < 8
432500160104     C                   exsr      switchtopayr
432600160104
432700160104     C                   endsl
432800160104
432900160104    ?C                   Endsr
433000160108      *-----------------------------------------------------------------
433100160108      *? Open WEBPAYROLL file
433200160108      *-----------------------------------------------------------------
433300160108    ?C     opnpayroll    Begsr
433400160108
433500160108      /free
433600160108
433700160108       //?close the file if open
433800160108         if %open(WEBPAYROLL) ;
433900160108          close WEBPAYROLL ;
434000160108         endif ;
434100160108
434200160108       //?re-open the file
434300160108          open WEBPAYROLL ;
434400160108
434500160108      /end-free
434600160108
434700160108    ?C                   Endsr
434800160104      *-----------------------------------------------------------------
434900160104      *? Set the libray list to dashboard
435000160104      *-----------------------------------------------------------------
435100160104    ?C     switchtodash  Begsr
435200160104
435300160104      /free
435400160104
435500160104       //?close the file if open
435600160104         if %open(WEBPAYROLL) ;
435700160104          close WEBPAYROLL ;
435800160104         endif ;
435900160104
436000160104
436100160104       //?replace payroll with dashboard
436200160104       CmdString = 'RmvLible RPGSPPAYR' ;
436300160104       #Command(CmdString : %len(%Trim(CmdString))) ;
436400160104
436500160104       CmdString = 'AddLible RPGSPDASH' ;
436600160104       #Command(CmdString : %len(%Trim(CmdString))) ;
436700160104
436800160104       //?re-open the file
436900160104          open WEBPAYROLL ;
437000160104
437100160104      /end-free
437200160104
437300160104    ?C                   Endsr
437400160104      *-----------------------------------------------------------------
437500160108      *? Set the libray list to payroll
437600160104      *-----------------------------------------------------------------
437700160104    ?C     switchtopayr  Begsr
437800160104
437900160104      /free
438000160104
438100160104       //?close the file if open
438200160104         if %open(WEBPAYROLL) ;
438300160104          close WEBPAYROLL ;
438400160104         endif ;
438500160104
438600160104
438700160104       //?replace dashboard with payroll
438800160104       CmdString = 'RmvLible RPGSPDASH' ;
438900160104       #Command(CmdString : %len(%Trim(CmdString))) ;
439000160104
439100160104       CmdString = 'AddLible RPGSPPAYR' ;
439200160104       #Command(CmdString : %len(%Trim(CmdString))) ;
439300160104
439400160104       //?re-open the file
439500160104          open WEBPAYROLL ;
439600160104
439700160104      /end-free
439800160104
439900160104    ?C                   Endsr
440000160104      *-----------------------------------------------------------------
4401009807311656 O******************************************************
4402009208171655 O*  OUTPUT SPECIFICATIONS                             *
4403009102151656 O******************************************************
4404009102151657 O*
4405009411301658 OTERM      D    99N1P
4406009411301658 O         OR    1PN99
4407009208171659 O                                           K8 'IO01    '
4408009102151660 O                       COMPNY              40
4409009102151661 O          E    11
4410009102151662 O                                           K8 'IO01    '
4411009102151663 O                       COMPNY              40
4412009102151664 O               50      SSNO                49
4413009102151668 O               50      ACC#                77
4414009102151669 O               50      SACNAM              97
4415009102151670 O               50      MSG(X)             172
4416000204040060 O                       sacnmcont          202
4417000204090060 O                       sactive            203
4418000204170060 O                       smemactive         204
4419009102151671 O          E    12
4420009102151672 O                                           K8 'IO02    '
4421009102151673 O                       COMPNY              40
4422009102151674 O                       SLN                 50
4423009102151675 O                       SS(1)               61
4424009102151676 O                       AL(1)              170
4425009102151677 O                       SS(2)              181
4426009102151678 O                       AL(2)              290
4427009102151679 O                       SS(3)              301
4428009102151680 O                       AL(3)              410
4429009102151681 O                       SS(4)              421
4430009102151682 O                       AL(4)              530
4431009102151683 O                       SS(5)              541
4432009102151684 O                       AL(5)              650
4433009102151685 O                       SS(6)              661
4434009102151686 O                       AL(6)              770
4435009102151687 O                       SS(7)              781
4436009102151688 O                       AL(7)              890
4437009102151689 O                       SS(8)              901
4438009102151690 O                       AL(8)             1010
4439009102151691 O                       SS(9)             1021
4440009102151692 O                       AL(9)             1130
4441009102151693 O                       SS(10)            1141
4442009102151694 O                       AL(10)            1250
4443009102151695 O                       SS(11)            1261
4444009102151696 O                       AL(11)            1370
4445009102151697 O                       SS(12)            1381
4446009102151698 O                       AL(12)            1490
4447009102151699 O                       SS(13)            1501
4448009102151700 O                       AL(13)            1610
4449009102151701 O                       SS(14)            1621
4450009102151702 O                       AL(14)            1730
4451009102151703 O                       SS(15)            1741
4452009102151704 O                       AL(15)            1850
4453009102151705 O                       SS(16)            1861
4454009102151706 O                       AL(16)            1970
4455009102151707 O                       SS(17)            1981
4456009102151708 O                       AL(17)            2090
4457009102151709 O                       SS(18)            2101
4458009102151710 O                       AL(18)            2210
4459009102151711 O                       SS(19)            2221
4460009102151712 O                       AL(19)            2330
4461000204171712 O                       smemactive        2331
4462009102151713 O          E    13
4463009102151714 O                                           K8 'IO03    '
4464009102151715 O                       SSNO                 9
4465009102151716 O                       COMPNY              49
4466009902081717 O                       TRUST#              52
4467009902081718 O                       SUB#                55
4468009902081719 O                       ACCNO               59
4469009902081720 O                       STDESC              89
447000140115     O                       acatext             95
4471000904131721 O                       ACCNAM             120
4472000904131722 O                       N                  151
4473000904131723 O                       ADDR1              181
4474000904131723 O                       ADDR2              211
4475000904131724 O                       CITY               226
4476000904131726 O                       ZIP                238 '0     -    '
4477000904131725 O                       STATE              228
4478000904131727 O                                          239 '('
4479000904131727 O                       AREA               242
4480000904131727 O                                          243 ')'
4481000904131728 O                       PHONE              252 '0   -    '
4482000904131729 O                       mardtout           260
4483000904131729 O                       SEX                261
4484000904131730 O                       BIRTH              269
4485000904131731 O                       AGE           Z    272
4486000904131732 O                       EMPDT              280
4487000904131733 O                       HNDICP             281
4488000904131735 O                       COB                282
4489000904131736 O                       SALARY             292 '      ,  0'
4490000904131737 O                       MEDICR             293
4491001012161737 O                       memail             358
4492001012161738 O                       PREMI              367 '  ,  0.  '
4493001012161739 O                       DPSEQ#         B   369
4494009102151740 O          E    14
4495009102151741 O                                           K8 'IO04    '
4496009102151742 O                       COMPNY              40
4497009102151743 O                       SLN                 50
4498009102151744 O                       SS(1)               61
4499009102151745 O                       AL(1)              170
4500009102151746 O                       SS(2)              181
4501009102151747 O                       AL(2)              290
4502009102151748 O                       SS(3)              301
4503009102151749 O                       AL(3)              410
4504009102151750 O                       SS(4)              421
4505009102151751 O                       AL(4)              530
4506009102151752 O                       SS(5)              541
4507009102151753 O                       AL(5)              650
4508009102151754 O                       SS(6)              661
4509009102151755 O                       AL(6)              770
4510009102151756 O                       SS(7)              781
4511009102151757 O                       AL(7)              890
4512009102151758 O                       SS(8)              901
4513009102151759 O                       AL(8)             1010
4514009102151760 O                       SS(9)             1021
4515009102151761 O                       AL(9)             1130
4516009102151762 O                       SS(10)            1141
4517009102151763 O                       AL(10)            1250
4518009102151764 O                       SS(11)            1261
4519009102151765 O                       AL(11)            1370
4520009102151766 O                       SS(12)            1381
4521009102151767 O                       AL(12)            1490
4522009102151768 O                       SS(13)            1501
4523009102151769 O                       AL(13)            1610
4524009102151770 O                       SS(14)            1621
4525009102151771 O                       AL(14)            1730
4526009102151772 O                       SS(15)            1741
4527009102151773 O                       AL(15)            1850
4528009102151774 O                       SS(16)            1861
4529009102151775 O                       AL(16)            1970
4530009102151776 O                       SS(17)            1981
4531009102151777 O                       AL(17)            2090
4532009102151778 O                       SS(18)            2101
4533009102151779 O                       AL(18)            2210
4534009102151780 O                       SS(19)            2221
4535009102151781 O                       AL(19)            2330
4536000204171781 O                       sactive           2331
4537009102151782 O          E    15
4538009102151783 O                                           K8 'IO05    '
4539009902051784 O                       COMPNY              40
4540009902051785 O                       ACC#                50
454100990205     O                       REINST              60
454200140115     O                       acatext             66
4543000904131786 O                       ACNAM1             106
4544000904131787 O                       APREMI        C    118
454500090413     O                       CFS834             119
454600090413     O                       CFSDT              127
454700090624     O                       PAYR               131
4548000906241788 O                       ACNAM2             171
4549000906241789 O                       NOEMPL        Z    178
455000090624     O                       MEDEMP        Z    185
455100091116     O                       TOTEMP        Z    192
4552000906241790 O                       APRBA2        C    204
4553000906241791 O                       AADDR1             234
4554000906241792 O                       FCSTFL             235
4555000906241792 O                       acobsrv            236
455600090624     O                       RCOBADM            241
4557000906241792 O                       aprefx             244
4558000906241793 O                       APRBA1        C    256
4559000911161794 O                       AADDR2             286
456000160819     O                       ASPHFL             287
4561001608191798 O                       ACUBAL        C    299
4562001608191799 O                       ACITY              314
4563001805011800 O                       ASTATE             316
4564001608191801 O                       AZIPout            326
4565001805011801 O                       ptdateout          334
4566001805011803 O                       TOTBL2        C    346
4567001805011805 O                       APHONEout          360
4568001805011805 O                       FAXout             374
456900180501     O                       RAOBEDT            382
457000180501     O                       RAOENDT            390
457100180501     O                       RAEDESC            410
4572001805011807 O                       CONTAC             440
457300180501     O                       ACVTDT             448
4574001805011810 O                       ENROLL             456
4575001805011809 O                       ATROUT             464
4576001805010207 O                       RGBSBDT            472
457700180501     O                       ECNTAC             502
457800180501     O                       CAFIC              503
457900180501     O                       afcode             507
4580001805011812 O                       AAnamout           527
4581001805011813 O                       SALCOD             530
458200180501     O                       RREREP             533
458300180501     O                       SALPH          B   548
4584001805011814 O                       HTYPE              549
4585009807310895 O          E            SCRN99
4586009412020896 O                                           K4 'IO99'
458700941202     O                       SHMM                 2
458800941202     O                       SHDD                 4
458900980731     O                       SHYY                 8
4590009102151815 O          E    25
4591009102151816 O                                           K8 'OO25    '
4592009807311817 O                       PD(1)               99
4593009807311818 O                       PD(2)              198
4594009807311819 O                       PD(3)              297
4595009807311820 O                       PD(4)              396
4596009807311821 O                       PD(5)              495
4597009807311822 O                       PD(6)              594
4598009807311823 O                       PD(7)              693
4599009102151824 O          E    21
4600009102151825 O                                           K8 'OO21    '
4601009903031826 O                       TRDATE         B    10 '    /  /  '
4602009903031827 O               91                           5 '     '
4603009903031828 O                       LDESCR         B    41
4604009903031829 O                       CM$FLG         B    43
4605009903031830 O              N20                          44 '-'
4606009903031831 O                       CK#NOT         B    74
4607001401171832 O                       NOTE2          B    98
4608001401171832 O               86      N2             B    98
4609001401171834 O               90                          90 ' RD='
4610001401171834 O               90      RECOUT         B    98
4611000006121833 O                       COVOUT         B   108
4612000006131834 O                       hoperout           119
4613009903241835 O                       TRAMT         MB   131
4614009108281824 O          E            ACCHIS
4615009108281825 O                                           K8 'OO21A   '
4616009903031826 O                       TRDATE         B    10 '    /  /  '
4617009903031827 O               91                           5 '     '
4618009903031828 O                       LDESCR         B    41
4619009903031829 O                       CM$FLG         B    43
4620009903031830 O              N20                          44 '-'
4621009903031831 O                       CK#NOT         B    74
4622009903031832 O                       NOTE2          B    99
4623000006131834 O               90                          91 'RD='
4624000006131834 O               90      RECOUT         B    99
4625009903031833 O                       COVOUT         B   108
4626000006131834 O                       hoperout           119
4627009903241835 O                       TRAMT         MB   131
4628009807311836 O          E    23
4629009102151837 O                                           K8 'OO23    '
4630009807311838 O          E    24
4631009102151839 O                                           K8 'OO24    '
4632009807311840 O          E    26
4633009102151841 O                                           K8 'OO21    '
4634009102151842 O                       DSEQ#                2
4635009102151843 O                       SDESCR         B    13
4636009102151844 O                       DFNAME              29
4637009102151845 O                       DMI                 31
4638001212141846 O                       DEPSS#out           45
4639001206271847 O                       DBIRTHMDY           56 '  /  /    '
4640001206271847 O                       Dage          z     60
4641001206271848 O                       DSEX                64
4642009102151849 O                       DSTUDN              68
4643009102151850 O                       DHNDCP              73
4644001212141851 O                       DHDDT               82 '  /  /    '
4645009102151852 O                       DCOB                85
4646009102151853 O                       DCOBPN             101
4647009102151854 O                       DMEDCR             104
4648009102151855 O                       DMED#              119
4649009102151856 O                       DSTAT              131
4650009807311857 O          E    27
4651009102151858 O                                           K8 'OO21    '
4652001212121859 O                                           30 '* CMD 12 - MORE DEPENDEN'
4653009102151860 O                                           34 'TS *'
4654009807311861 O          E    28
4655009102151862 O                                           K8 'OO28    '
4656009807311863 O          E            BLNKVL
4657009807311864 O                                           K8 'OO21    '
4658009807311863 O          E    29
4659009102151864 O                                           K8 'OO21    '
4660009102151865 O                       S#                   2
4661009102151866 O                       SSNO                16 '0   -  -    '
4662009102151867 O                       LNAME               36
4663009102151868 O                       FNAME               49
4664009102151869 O                       MI                  51
4665009807311870 O                       BIRTH               63
4666009102151871 O                       AGE           Z     70
4667009102151873 O                       SEX                 75
4668009807311874 O                       EMPDT               88
4669009102151875 O                       TDESC               95
467000980804     O                       HGRP11             108
4671009808041877 O                       PREMI         1    119
4672009102151878 O                       SDESCR             131
4673009807311879 O          E    30
4674009102151880 O                                           K8 'OO21    '
4675000111291881 O               kl                          71 '    *** F12 - MORE MEMBERS'
4676000111291881 O               kl                          75 ' ***'
4677000111291882 O               km                          71 '    *** F13 - MORE COBRA O'
4678000111291883 O               km                          87 'NLY MEMBERS *** '
4679009807311884 O          E            ACONTX
4680009108281885 O                                           K8 'OO21A   '
4681009108281886 O                                           30 '********************'
4682009108281887 O                                           50 '      CONTINUED     '
4683009108281888 O                                           70 '********************'
4684009807311889 O          E            AEND
4685009108281890 O                                           K8 'OO21A   '
4686009108281891 O                                           30 '********************'
4687009108281892 O                                           50 '         END        '
4688009108281893 O                                           70 '********************'
4689009807311884 O          E    18
4690009102151885 O                                           K8 'OO21    '
4691009102151886 O                                           30 '********************'
4692009102151887 O                                           50 '      CONTINUED     '
4693009102151888 O                                           70 '********************'
4694009807311889 O          E    19
4695009102151890 O                                           K8 'OO21    '
4696009102151891 O                                           30 '********************'
4697009102151892 O                                           50 '         END        '
4698009102151893 O                                           70 '********************'
4699009807311894 O          E            SCRN26
4700009102151895 O                                           K8 'OO26    '
4701009807311896 O                       MEDADT               8
4702009807311897 O                       CEXPDT              16
4703009210121898 O                       PRVBAL        K     26
4704009807311899 O                       MEDBDT              34
4705009807311900 O                       CVTHDT              42
4706009210121901 O                       CURBAL        K     52
470700210519     o                       cptdtmdy            60
4708002105191902 O                       TOTBAL        KB    70
4709002105191903 O                       ELECRT              71
4710002105191903 O                       eexpdtmdy           79
4711002105191903 O                       subdt1             104
4712002105191909 O                       QEDT               112
4713002105191910 O                       QEDSC          B   142
4714002105191903 O                       subdt2             167
4715002105191911 O                       NTFYDT             175
4716002105191912 O                       NTFYDS         B   205
471700210519     O                       GBSCDT             213
471800210519     O                       empst              214
471900210519     O                       empstdes           244
472000210519     O                       NONEMP             245
472100210519     O                       ALTID              265
4722009807311863 O          E            BLNKV2
4723009110181864 O                                           K8 'OO30    '
4724009407290895 O          E            SCRN08
4725009407290896 O                                           K8 'IO08    '
4726009407290838 O                       COMPNY              40
4727009408010838 O                       ACC#                52 '   -   -   0'
4728009407290838 O                       ACNAM1              92
472900940729     O                       BLANK              171
4730009407290897 O                       SL1                172
4731009407290897 O                       PL1                176
4732009407290897 O                       DS1                216
4733009407290897 O                       SL2                217
4734009407290897 O                       PL2                221
4735009407290897 O                       DS2                261
4736009407290897 O                       SL3                262
4737009407290897 O                       PL3                266
4738009407290897 O                       DS3                306
4739009407290897 O                       SL4                307
4740009407290897 O                       PL4                311
4741009407290897 O                       DS4                351
4742009407290897 O                       SL5                352
4743009407290897 O                       PL5                356
4744009407290897 O                       DS5                396
4745009407290897 O                       SL6                397
4746009407290897 O                       PL6                401
4747009407290897 O                       DS6                441
4748009407290897 O                       SL7                442
4749009407290897 O                       PL7                446
4750009407290897 O                       DS7                486
4751009407290897 O                       SL8                487
4752009407290897 O                       PL8                491
4753009407290897 O                       DS8                531
4754009407290897 O                       SL9                532
4755009407290897 O                       PL9                536
4756009407290897 O                       DS9                576
4757009407290897 O                       SL10               577
4758009407290897 O                       PL10               581
4759009407290897 O                       DS10               621
4760009407290897 O                       SL11               622
4761009407290897 O                       PL11               626
4762009407290897 O                       DS11               666
4763009407290897 O                       SL12               667
4764009407290897 O                       PL12               671
4765009407290897 O                       DS12               711
4766009407290897 O                       SL13               712
4767009407290897 O                       PL13               716
4768009407290897 O                       DS13               756
4769009407290897 O                       SL14               757
4770009407290897 O                       PL14               761
4771009407290897 O                       DS14               801
4772009407290897 O                       SL15               802
4773009407290897 O                       PL15               806
4774009407290897 O                       DS15               846
4775009407290897 O                       SL16               847
4776009407290897 O                       PL16               851
4777009407290897 O                       DS16               891
4778009407290895 O          E            SCRN09
4779009407290896 O                                           K8 'IO09    '
478000940729     O                       ACC#                12 '   -   -   0'
478100940804     O                       ACNAM1              52
478200940729     O                       HPRPL#              56
478300940729     O                       HPRDSC              96
478400980731     O                       CP1                100
478500940729     O                       CDS1               140
478600980731     O                       CP2                144
478700940729     O                       CDS2               184
478800980731     O                       CP3                188
478900940729     O                       CDS3               228
479000980731     O                       CP4                232
479100940729     O                       CDS4               272
479200980731     O                       CP5                276
479300940729     O                       CDS5               316
479400980731     O                       CP6                320
479500940729     O                       CDS6               360
479600980731     O                       CP7                364
479700940729     O                       CDS7               404
479800980731     O                       CP8                408
479900940729     O                       CDS8               448
480000980731     O                       CP9                452
480100940729     O                       CDS9               492
480200980731     O                       CP10               496
480300940729     O                       CDS10              536
480400980731     O                       CP11               540
480500940729     O                       CDS11              580
480600980731     O                       CP12               584
480700940729     O                       CDS12              624
480800980731     O                       CP13               628
480900940729     O                       CDS13              668
481000980731     O                       CP14               672
481100940729     O                       CDS14              712
481200980731     O                       CP15               716
481300940729     O                       CDS15              756
481400980731     O                       CP16               760
481500940729     O                       CDS16              800
481600980731     O                       CP17               804
481700940729     O                       CDS17              844
481800980731     O                       CP18               848
481900940729     O                       CDS18              888
482000980731     O                       CP19               892
482100940729     O                       CDS19              932
482200980731     O                       CP20               936
482300940729     O                       CDS20              976
482400980731     O                       PP1                980
482500940729     O                       PDS1              1020
482600980731     O                       PP2               1024
482700940729     O                       PDS2              1064
482800980731     O                       PP3               1068
482900940729     O                       PDS3              1108
483000980731     O                       PP4               1112
483100940729     O                       PDS4              1152
483200980731     O                       PP5               1156
483300940729     O                       PDS5              1196
483400980731     O                       PP6               1200
483500940729     O                       PDS6              1240
483600980731     O                       PP7               1244
483700940729     O                       PDS7              1284
483800980731     O                       PP8               1288
483900940729     O                       PDS8              1328
484000980731     O                       PP9               1332
484100940729     O                       PDS9              1372
484200980731     O                       PP10              1376
484300940729     O                       PDS10             1416
484400980731     O                       PP11              1420
484500940729     O                       PDS11             1460
484600980731     O                       PP12              1464
484700940729     O                       PDS12             1504
484800980731     O                       PP13              1508
484900940729     O                       PDS13             1548
485000980731     O                       PP14              1552
485100940729     O                       PDS14             1592
485200980731     O                       PP15              1596
485300940729     O                       PDS15             1636
485400980731     O                       PP16              1640
485500940729     O                       PDS16             1680
485600980731     O                       PP17              1684
485700940729     O                       PDS17             1724
485800980731     O                       PP18              1728
485900940729     O                       PDS18             1768
486000980731     O                       PP19              1772
486100940729     O                       PDS19             1812
486200980731     O                       PP20              1816
486300940729     O                       PDS20             1856
486400970929     O*******************************
486500911022** ERROR MESSAGE ARRAY
486600910215 -- SS #  NOT FOUND                                                      --
486700910215 -- ACCOUNT # NOT FOUND                                                  --
486800910215 -- NO ENTRY TO PROCESS                                                  --
486900161121 -- DEPENDENT SEQUENCE # ENTERED IS INVALID                              --
487000970929     ********** PLAN # INVALID  **********
487100970929 -- NOT SECURED TO THIS SSN                                              --
487200970929 -- NOT SECURED TO THIS ACCOUNT                                          --
487300970929 -- YOU ARE NOT SECURED TO THIS PROGRAM                                  --
487400910215**
487500910215 * ERROR *
487600910911**
487700910911 *************** E R R O R **************
487800911022**
487900911022REINSTATED
