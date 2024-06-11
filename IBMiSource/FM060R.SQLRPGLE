000100221110     H  OPTION(*NODEBUGIO : *SRCSTMT) bnddir('ALLSRVPGMN':'GBSBIND')
000101221110     H  actgrp(*caller)
000200130918     h  dftactgrp(*no)
000300130918      *---------------------------------------------------------------------
000400010129    *** FM060R - ACCOUNT MASTER MAINTENANCE
000500010129    *** REWRITTEN FROM S/36 SOURCE
000600010129    ***           BY STEPHEN KING
000700010129    ***           ON 12/00 THRU 01/01
000800010129    ***
000900010206    ***  02/06/01 JVA - COVERAGE THRU DATE LOGIC ADDED.
001000010207    ***  02/07/01 JVA - MOVE UPDATE TO SUBMST TO CORRECT ACCT GEN ISSUE.
001100010207    ***  02/07/01 JVA - ADD INVALID ACCT NUMBER ERROR MSG AND LOGIC.
001200010207    ***  02/07/01 JVA - ADD AACODE UPDATE LOGIC WHEN CHANGE FIELD.
001300010220    ***  02.20.01 SSK - PREFIX SMAN CODE FILE
001400010710    ***  04.19.01 TWP - ADDED ADDITIONAL SCREEN CODE - F16
001500010823    ***  08.23.01 SSK - FUNCTION AVAILABLE ON CHANGE MODE ONLY
001600020524     **  5/24/02 szz - Recompiled over new AACODE file                 *
001700030427     **  11/27/02 KSJ - ADDED CFS ENTITY DATE FIELD (STORED IN CFSEDT IN ACCMST)
001800030320     **  02/14/03 KSJ - ADDED GBS BEGIN GA DATE FIELD
001900040728     **  07/28/04 KSJ - ADDED "DUMMY" PARMS (@@PARM2 & @@PARM3) TO WORK WITH CHA
002000040728     **                   TO FM063CL
002100040824     **   8/24/04 szz - Add special handling field.                     *
002200040929     **  09/29/04 dlk - Add COBRA service field
002300050317     **   3/17/05 szz - Add function key to get to Benegap data screen.
002400050413     **   4/13/05 szz - Add history transaction codes for Benegap
002500050610s610 **   6/10/05 szz - Add Cobra Admin Fee field to the screen.
002600050610s610 **                  If Cobra Full Service, force user to either enter a
002700050705s610 **                  fee or confirm that there is no fee.  Per Dave K.,
002800050705s610 **                  show a warning for amount less than 2.50- also.
002900060331     **  03/31/06 dlk - Add admin fee and bonus draw override function
003000060331     **                 keys (calls FM064CL)
003100060417     **  04/17/06 dlk - Add Carrier begin date function Key
003200060417     **                 (calls FM065CL)
003300060428s610 **   4/28/06 szz - Add STD & LTD %contribution fields and a flag which
003400060428s610 **                  shows whether the volume should be seen on the web.
003500061011s610 **  10/11/06 szz - Add required Parity field.
003600061130s610 **  11/30/06 szz - Add online enrollment (OE) code function.
003700070312s610 **   1/05/07 szz - When Parity Flag was added to accounts with no
003800070105     **                  AC2MST record, the added record was blank.
003900070312s610 **   3/12/07 szz - Allow use of F20 (OE Codes) only when password
004000070312     **                  is correct per Dave A.
004100070516s610 **   5/16/07 szz - Recompile due to addition of new fields to ACCBSP.
004200070612     **   6/12/07 szz - Per Carol Fab diary note Benegap run-out days change.
004300090224     **   6/11/08 szz - Remove password protection for OLE.
004400090224     **   2/13/09 szz - Allow special handling codes:  P (Private Pay
004500090224     **                  no Medicaid), D (Direct Pay Medicaid where
004600090224     **                  check is not received by facility) F (Medicaid
004700090224     **                  check goes to facility).
004800090224     **                 New field RCFS834 indicates 834 rather than
004900090224     **                  flat file. (Y or Blank allowed).
005000090304     **   3/04/09 szz - Auto fill address info from facility file if special
005100090304     **                  handling flag is 'F' when creating a new account.
005200090319     **                 Add ACH module (F15).
005300090408     **   4/08/09 szz - Add new Misc. supplemental file which holds the CFS
005400090408     **                  834 effective date if the CFS 834 flag is Y.
005500090520     **   5/20/09 szz - Edit required Renewal Period and AA Code on Screen2.
005600090521     **                  Warn if tax ID is blank for an Onsite Dental trust.
005700090707     **                  The ACH effective date cannot be prior to the GBS
005800090707     **                  GBS Begin Admin Date or Enrollment Date.
005900090828     **   8/28/09 szz - In email of 8/28/09, Lisa K requested that the Tax
006000090828     **                  ID warning be removed.
006100090904     **   9/04/09 szz - In email of 9/04/09, Dave A requested a date time
006200090904     **                  stamp on when CFS834 flag became Y. They will be
006300090904     **                  stored in ACCMSP.
006400100215     **   2/15/10 szz - Cindy W. requested that the Subdivision name (ie
006500100215     **                  the facility) be shown in Account Name 2.
006600100323     **   3/23/10 szz - Add a history note for a change to GBS Begin Admin
006700100323     **                  Date (L52).
006800100514     **   5/14/10 szz - Special Handling flag:change from/to in History.*
006900100517     **   5/17/10 szz - BOM data should be updated to ACCMST if Special
007000100517     **                  Handling Flag is changed to Facility.
007100100624     **   6/24/10 szz - Call Onsite Dental Contact Management System
007200101008     **  10/08/10 szz - Per Shelly & Dave A populate with Subdivison
007300101008     **                  Description rather than Subdivision Name if
007400101008     **                  pay type is Facility.
007500110201     **   2/01/11 szz - Auto fill address info from facility file if special
007600110201     **                  handling flag is 'F' even when it is not a new
007700110201     **                  account per Angie W.
007800110429     **   4/29/11 szz - Show "Dentures" instead of "Average Age" it it is a
007900110429     **                  Senior Dental Account per Dave A/Cindy W.
008000110805     **   8/05/11 dlk - add effective date to LAA hist rec
008100120508      *  05/09/12 szz -INVOICE PRINT is added to the Additional Screen using
008200120508      *             the CAFIC field from ACCMST.  P, N and O are valid values.
008300120718      *  07/18/12   If user does not enter, P or O must be defaulted to B/O.
008400120515      *  05/15/12 szz -Hardcode authorized ACH users.
008500120524      *  05/24/12 szz -If Facility paid, use BOM phone number per Angie W.
008600120606      *  05/31/12 SSK - REVERSE IMAGE IF COBRA INITIAL NOTICE SERVICE ACTIVE
008700120809      *  08/08/12 szz -Add Renewal Rep from AC2MST field A2CODE1 per D.A.
008800130501      *  05/01/13 szz -Add history for a change to AA (TRCODE = 'LAR')
008900130918      *  09/16/13 dpb -Add logic for county validation if state is MD
009000130918      *                and zip validation against USPS table
009100131029      *  09/26/13 dlk -History file expansion
009200140114      *  01/14/2014 dpb Add PA to county validation logic
009300140128    *** 01.28.2014 SSK HOOK UP REGION RENEWAL
009400140206    *** 02.06.2014 SSK ADD L53 COUNTY CHANGE HISTORY NOTE
009500140225    *** 02.25.2014 SSK ADD RATING COUNTY AND DESCRIPTION
009600140624    *** 03.26.2014 SSK ADD AMY TO ACH
009700140402    *** 04.02.2014 SSK MORE MODIFICATION TO RATING COUNTY
009800150707    *** 07/07/15 dlk - change angie W to Lisa K for ach access
009900150813    *** 08/13/15 dlk - replace Thelma H with Ashley R for ACH access
010000151014    *** 10/14/15 dlk - change AmyC to AmyD for ACH Access
010100160616    *** 06/16/16 dlk - change to find next available acc# by reading
010200160616    ***                accmst instead of using the last acc# field in
010300160616    ***                submst since Admin now wants to be able to pick the
010400160617    ***                new account # sometimes. Also add record lock check
010500160617    ***                for submst since that will still be needed to avoid
010600160617    ***                duplicate account #'s.
010700160620    *** 06/20/16 dlk - add record lock check for accmst also
010800160808    *** 08/08/16 dlk - add ACOSTI for ACH Access
010900170124    *** 01/24/17 sbt - add CT to MD & PA hardcoding
011000170404    *** 04/04/17 dlk - add other Amwins CT users to ACH Access
011100170615     ** 06.15.17 dma - add Brandon and Ron to ACH Access.  Remove Dave K and Jon
011200180109    *** 01/09/18 rlj - Allow Adv Mbl (trust 76) to access Onsite Dtl logic
011300221110      * 06/13/18 jt  - Added code to update contact information on Account Master file
011400221110      *                Added info to parms on wrkocncl call
011500180619
011600191216    *** 12/16/2019  B.Rees  Retrieve the user who has the AccMst File locked.
011700191216      *    Mod: Br01
011800200115    *** 01/15/20 rlj - Allow CSMi (TSCODE O D) to access Onsite Dtl logic
011900201208    *** 12/08/20 B.Rees - Added Eric D to ACH.
011901220118      *  1/18/2022  B.Rees  Converted Green Screen to Profound Logic.
011902220118      *    Mod:  BR02
011903220118      *    * Changed Calls to Green Screen Search windows to PL Programs.
011904220120      *    * Add Notes Program
011905220118      *
011906221110      * 11/10/22 jt  - Called procedure to get user color when record gets updated
011907221110      *                and now updates the File Transfer Formatted Files records,
011908221110      *                Last Recvd OE Autoload files.
011909220118      *
011910230217      * 02/17/23 jt  - Calling pgmauth for ACH program. Eliminated hardcoded users.
011911230217
012000010206    ************************************************************************
012100010206    ************************************************************************
012200010129    *** FILES  & DESCRIPTIONS
012300010129    *** ACCMST - ACCOUNT MASTER FILE
012400061011     ** AC2MST - Additional Account Master File
012500010129    *** TRSMST - TRUST MASTER FILE
012600010129    *** SUBMST - SUBDIVISION MASTER FILE
012700010129    *** SMAN   - SALESMAN MASTER FILE
012800010129    *** AACODE - ACCOUNT ADMINISTRATION CODES MASTER FILE (NOT OVERRIDDEN, JUST
012900120606    *** COB440W2 - ACCOUNT SETUP FOR COBRA INITIAL NOTICE
013000010129    ***
013100010129    ***
013200010129    ***
013300010129    ***
013400010129    ***
013500010129    ***
013600010129   X***X
013700010103     FFM060D    CF   E             WORKSTN INFDS(WSDS)
013703220118     F                                     HANDLER('PROFOUNDUI(HANDLER)')
013800010103     FACCMST    UF A E           K DISK
013900160616     Facmunique if   E           K DISK    rename(accmsr:acmur) prefix(ACM_)
014000061011     FAC2MST    UF A E           K Disk
014100050318     FACCBSP    IF   E           K Disk
014200061129     FACCOSP    IF   E           K Disk
014300090319     FACCACH    IF   E           K Disk
014400140226     FCOUNTYCOL1IF   E           K DISK
014500090408     FACCMSP    UF A E           K Disk
014600140402     FACARGRP   IF   E           K Disk
014700090306     FODCNTCP   IF   E           K Disk
014800000102     FTRSMST    IF   E           K DISK
014900160617     FSUBMST    UF   E           K DISK
015000010220     FSMAN      IF   E           K DISK    PREFIX(S_)
015100010104     FAACODE    IF   E           K DISK
015200090304     FODFACP    IF   E           K Disk
015300100625     FCMISSP    IF   E           K Disk
015400100831     FCM8ACL2   IF   E           K Disk
015500120606     FCOB440W2  IF   E           K Disk
015600010104     FHIST      O  A E             DISK
015601221110
015602221110       dcl-f ftFmtFil keyed usage(*update);
015604221110
015605221110       dcl-f amw0001lf keyed usage(*update);
015606221110
015607221110       dcl-f amw0002p keyed usage(*update);
015608221110
015700000102   X***X
0158001310290037 D sysdateymd      S               d   datfmt(*iso)
015900160620s824 D  MSG            S             70A   DIM(49) PERRCD(1) CTDATA
016000010104    ***
016100010129     D #ISO            S               D   DATFMT(*ISO)
016200010129     D #USA            S               D   DATFMT(*USA)
016300010104    ***
016400010104     D*ALPHANUMERICS
016500010104     D*
016600010129     D @STEP           S              5A
016700010129???****@@45            S             45A
016800010129     D @@A             S              1A
016900010129     D @@CHGS          S              1A
017000010207     D @@VA            S              1A
017100010207     D @@VS            S              1A
017200010129     D @@VT            S              1A
017300010129     D @3P             S              3A
017400010129     D @3X             S              3A
017500010129     D @4              S              4A
017600010129     D @6P             S              6A
017700010129     D @10P            S             10A
017800010129     D @ACCT           S              4A
017900010129???****@CHGS           S              1A
018000010129     D @SUBD           S              3A
018100010129     D @TRST           S              3A
018200100527     D wortn           S              8
018300130918     D wrk_countycode  s                   like(rconty)
018400130918     D sv_zip5         s                   like(azip5)
018500010104    ***
018600010104     D*NUMERICS
018700010104     D*
018800010129     D @@00            S              2S 0
018900010129     D #4              S              4S 0
019000010129     D #9              S              9S 0
019100010129     D #GBSISO         S              8S 0
019200010129     D #ENRISO         S              8S 0
019300010129     D #TRISO          S              8S 0
019400021206     D CFSEDI          S              8S 0
019500021206     D CFSEDO          S              8S 0
019600021203     D #CFSISO         S              8S 0
019700030225     D GBGADI          S              8S 0
019800030225     D GBGADO          S              8S 0
019900030214     D #BGAISO         S              8S 0
020000040728     D @@PARM2         S              3
020100040728     D @@PARM3         S             40
020200061011     D Fully           S              1     Inz('F')
020300010104    ***
020400030225     D                 DS
020500030225     D OLDT05                  1      6A
020600030225     D OLDT05A                 1      2A
020700030225    ***
020800010104     D                 DS
020900010129     D @@TSA                   1     10A
021000010104     D  I_TRST                 1      3S 0
021100010104     D  I_SUB#                 4      6S 0
021200010104     D  I_ACCT                 7     10S 0
021300050318    ***
021400050318    *** BENEGAP
021500050318    ***
021600050318     D WDTA          E DS                  extname(ACCBSP)
021700050317    ***
021800090319     D WADTA         E DS                  extname(ACCACH)
021900061129    ***
022000100825    ?D WMDTA         E DS                  EXTNAME(CMISSP)  inz
022100061129    *** OE (On-line Enrollment)
022200061129    ***
022300061129     D WDOE          E DS                  extname(ACCOSP)
022400090225    ***
022500090306    *** ODCNTCP (Contacts)
022600090225    ***
022700090327     D WDOC          E DS                  extname(ODCNTCP) inz
022800061129    ***
022900010129     D                 DS
023000010104     D #ZIP                    1      9S 0
023100010104     D  AZIP5                  1      5S 0
023200010104     D  AZIP4                  6      9S 0
023300010104    ***
023400010129     D                 DS
023500010104     D @FAXPHN                 1     10A
023600010104     D  #3                     1      3S 0
023700010104     D  #7                     4     10S 0
023800010104    ***
023900010129     D                 DS
024000010104     D @RPHONE                 1     10A
024100010104     D  RAREA                  1      3S 0
024200010104     D  RPHONE                 4     10S 0
024300010104    ***
024400010129     D                 DS
024500010104     D @RFAX                   1     10A
024600010104     D  RAXARE                 1      3S 0
024700010104     D  RAX#                   4     10S 0
024800010104    ***
024900010206     D                 DS
025000010206     D NEWCOV                  1      8S 0
025100010206     D  NEWYY                  1      4S 0
025200010206     D  NEWMM                  5      6S 0
025300010206     D  NEWDD                  7      8S 0
025400010206    ***
025500010129     D WSDS            DS
025600000102     D  FKEY                 369    369A
025700090213    ***       Split Filler Field to use for CFS834 field.
025800010129    ***       FUNCTION KEYS
025900000102     D  F1             C                   CONST(X'31')
026000000102     D  F2             C                   CONST(X'32')
026100000102     D  F3             C                   CONST(X'33')
026200000102     D  F4             C                   CONST(X'34')
026300000102     D  F5             C                   CONST(X'35')
026400000102     D  F6             C                   CONST(X'36')
026500000102     D  F7             C                   CONST(X'37')
026600000102     D  F8             C                   CONST(X'38')
026700000102     D  F9             C                   CONST(X'39')
026800000102     D  F10            C                   CONST(X'3A')
026900000102     D  F11            C                   CONST(X'3B')
027000000102     D  F12            C                   CONST(X'3C')
027100000102     D  F13            C                   CONST(X'B1')
027200000102     D  F14            C                   CONST(X'B2')
027300000102     D  F15            C                   CONST(X'B3')
027400000102     D  F16            C                   CONST(X'B4')
027500000102     D  F17            C                   CONST(X'B5')
027600000102     D  F18            C                   CONST(X'B6')
027700000102     D  F19            C                   CONST(X'B7')
027800000102     D  F20            C                   CONST(X'B8')
027900000102     D  F21            C                   CONST(X'B9')
028000000102     D  F22            C                   CONST(X'BA')
028100000102     D  F23            C                   CONST(X'BB')
028200000102     D  F24            C                   CONST(X'BC')
028300050413    ?D BenAdd          C                   'BENEGAP DATE RANGE ADDED'
028400070612     D BenROP          C                   'BENEGAP RUN OUT DAYS CHANGED'
028500061201    ?D OEAdd           C                   'OE CODE DATE RANGE ADDED  '
028600061201    ?D OEChg           C                   'OE CODE/DATE RANGE CHANGED'
028700090319     D BOMNOF          C                   'Business Manager Not on File'
028800060331     D parmletA        s              1a   inz('A')
028900060331     D parmletB        s              1a   inz('B')
029000060331     D parmacnam1      s                   like(acnam1)
029100160616     D nextacc#        s                   like(acacct)
029200180613     d new             s              1
029201221110     d userColor       s             10
029300180613
029400220118br01   dcl-s Acct_Rrn int(10);
029500220118br01   dcl-s Lock_Info Char(30);
029600191216
029700140404     D ACARGR@       E DS                  extname(ACARGRP)
029800000102    ***
029900130918
029901220118       // Trust Search Window
029902220118br02   dcl-pr WN0014R ExtPgm('WN0014R');
029903220118         pTrst   Char(3);
029904220118         pName   Char(20);
029905220118         pcancel Char(1);
029906220118       End-Pr;
029907220118       dcl-s pTrst   Char(3);
029908220118       dcl-s pName  Char(20);
029909220118       dcl-s pCancel Char(1);
029910220118
029911220118
029912220118
029913220118       // SubDivision Search Window
029914220118br02   dcl-pr WN0015R ExtPgm('WN0015R');
029915220118         pTrst   Char(3);
029916220118         pSub#   Char(3);
029917220118         pName   Char(20);
029918220118         pcancel Char(1);
029919220118       End-Pr;
029920220118       dcl-s pSub#   Char(3);
029923220118
029924220118
029925220118
029926220118       // Account Number Search Window
029927220118br02   dcl-pr WN0016R ExtPgm('WN0016R');
029928220118         pTrst   Char(3);
029929220118         pSub#   Char(3);
029930220118         pAcct   Char(4);
029931220118         pName   Char(20);
029932220118         pcancel Char(1);
029933220118       End-Pr;
029934220118       dcl-s pAcct   Char(4);
029935220118
029936220120
029937220120
029938220120       // Check Function Authority
029939220120br02   dcl-pr ChkFncAuth ExtPgm('CHKFNCAUTH');
029940220120         Program     Char(10);
029941220120         Function    Char(20);
029942220120         DispErrMsg  Char(1);
029944220120         Continue    Char(1);
029946220120       End-Pr;
029947220120       dcl-s oProgram Char(10);
029948220120       dcl-s oContinue Char(1);
029949220120       dcl-s oFunction Char(20);
029950220120       dcl-s oDspErrMsg Char(1);
029951220120
029952220120
029953220120       // Account Master Notes
029954220120br02   dcl-pr AmNotesC ExtPgm('AMNOTESC');
029955220120         pTrst   Zoned(3);
029956220120         pSub#   Zoned(3);
029957220120         pAcct   Zoned(4);
029958220120       End-Pr;
029959220120
029960230217     d pgmname2        s             10
029961230217     d continue2       s              1
029962230217
029963230217     d ChkPgmAuth      pr                  extpgm('CHKPGMAUTH')
029964230217     d  pgmname2                     10
029965230217     d  continue2                     1
029966220120
029967221110      /Include *LIBL/QMODSRC,#aacolorPr            // Get AA Color
029968220120
030000130918      /define copy_all_protos_and_fields
030100131004      /copy qcpysrc,zipsrvpgmp
030200130918      /undefine copy_all_protos_and_fields
030300130918
030400160617      * Program status data structure
030500160617      /copy gbspgm/qrpglesrc,psds
030600160617
030606220120
030700010129    *** LOCAL DATA AREA
030800000102     D                UDS
030900050317     D  FSFund                20     20
031000131029     D  @USER                100    109
031100000102     D  CONAME               201    240
031200010129    ***
031300010129    *** RENAME OF ACCOUNT MASTER FIELD
031400010104     IACCMSR
031500010104     I              AACODE                      ACAACOD
031600000102   X***X
031700000102     C                   DOU       @STEP = 'EXIT '
031800000102     C     @STEP         CASEQ     'STEP1'       $STEP1
031900000102     C     @STEP         CASEQ     'STEP2'       $STEP2
032000000102     C     @STEP         CASEQ     'STEP3'       $STEP3
032100000102     C                   ENDCS
032200000102     C                   ENDDO
032300000102     C*
032400131004     C                   callp     #zip_closesrv()
032500000102     C                   MOVE      *ON           *INLR
032600000102     C*
032700000102   S***S
032800010129     C     *INZSR        BEGSR
032900000102    ***
033000050629     C     *DATE         Mult      10000.0001    Today             8 0
033100010104     C                   MOVE      'STEP1'       @STEP
033200160620     C***                MOVEL(P)  MSG(1)        R1MSG
033300010104     C                   MOVE      *ZEROS        @@00
033400010125     C                   MOVE      *DATE         #ISO
033500010125     C                   MOVE      #ISO          #TISO             8 0
033600000102    ***
033700000102     C     SUBKEY        KLIST
033800010103     C                   KFLD                    I_TRST
033900010103     C                   KFLD                    I_SUB#
034000010103     C*
034100000102     C     ACCKEY        KLIST
034200010103     C                   KFLD                    I_TRST
034300010103     C                   KFLD                    I_SUB#
034400010103     C                   KFLD                    I_ACCT
034500061011     C*
034600061011     C     AC2KEY        KLIST
034700061011     C                   Kfld                    Fully
034800061011     C                   KFLD                    I_TRST
034900061011     C                   KFLD                    I_SUB#
035000061011     C                   KFLD                    I_ACCT
035100050317     C*
035200050317     C     BENKEY        KLIST
035300050317     C                   Kfld                    I_TRST
035400050317     C                   Kfld                    I_SUB#
035500050317     C                   Kfld                    I_ACCT
035600070614     C*
035700010104     C     AAKEY         KLIST
035800010104     C                   KFLD                    R2AACOD
035900010104     C                   KFLD                    @@00
036000090319    ***
036100090319     C     BOMKEY        Klist
036200090319     C                   Kfld                    I_TRST
036300090319     C                   Kfld                    I_SUB#
036400090319     C                   Kfld                    I_ACCT
036500090319     C                   Kfld                    BOM               3
036600100816     C     BILKEY        Klist
036700100816     C                   Kfld                    I_TRST
036800100816     C                   Kfld                    I_SUB#
036900100816     C                   Kfld                    I_ACCT
037000100816     C                   Kfld                    BIL               3
037100090701     C     SubBOMKey     Klist
037200090701     C                   Kfld                    I_TRST
037300090701     C                   Kfld                    I_SUB#
037400090701     C                   Kfld                    BlankAccount      4 0
037500090701     C                   Kfld                    BOM               3
037600100816     C     SubBILKey     Klist
037700100816     C                   Kfld                    I_TRST
037800100816     C                   Kfld                    I_SUB#
037900100816     C                   Kfld                    BlankAccount      4 0
038000100816     C                   Kfld                    BIL               3
038100100816     C                   Eval       BOM     =    %Trim('BOM')
038200100816     C                   Eval       BIL     =    %Trim('BIL')
038300000102    ***
038400010104     C                   MOVE      *ZEROS        I_TRST
038500010104     C                   MOVE      *ZEROS        I_SUB#
038600010104     C                   MOVE      *ZEROS        I_ACCT
038700090701     C                   MOVE      *ZEROS        BlankAccount
038701220120     C
038702220120br02
038703220120       // User Allowed to Add Account Master Notes?
038704220120       ViewNotes = *off;
038705220120       oFunction = '';
038706220120       oDspErrMsg = 'N';
038707220120       oProgram = 'AMNOTESC';
038708220120
038709220120       ChkFncAuth( oProgram : oFunction : oDspErrMsg : oContinue );
038710220120       if oContinue = 'Y';
038711220120         ViewNotes = *on;
038712220120       EndIf;
038713220120
038714220120
038715220120
038716220120
038717220120     C
038800000102     C                   ENDSR
038900000102   S***S
039000000102     C     $STEP1        BEGSR
039100000102    ***
039200010103     C                   EXFMT     IO01
039300010104     C                   MOVE      *BLANKS       R1MSG
039400010103     C                   MOVE      *BLANKS       O_TNAM
039500010103     C                   MOVE      *BLANKS       O_SUBN
039501220118
039502220118br02   s_Focus = *off;
039503220118br02   a_Focus = *off;
039504220118
039505220118
039506220118
039600010103    *** END APP
039700010103    1C                   IF        FKEY = F7
039800010103     C                   MOVEL(P)  'EXIT'        @STEP
039900010103     C                   LEAVESR
040000010103    1C                   ENDIF
040100010103    *** TRUST SELECTOR
040200010103    1C                   IF        FKEY = F2
040300010103     C                   EXSR      $F2PROC
040400010103     C                   LEAVESR
040500010103    1C                   ENDIF
040600010103    *** SUB SELECTOR
040700010103    1C                   IF        FKEY = F4
040800010103     C                   EXSR      $F4PROC
040900010103     C                   LEAVESR
041000010103    1C                   ENDIF
041100010103    *** ACC SELECTOR
041200010103    1C                   IF        FKEY = F5
041300010103     C                   EXSR      $F5PROC
041400010103     C                   LEAVESR
041500010103    1C                   ENDIF
041600010103    *** VALIDATIONS
041700010103     C                   EXSR      $CHK_TRST
041800010103    1C                   IF        @@VT <> '0'
041900010103     C                   MOVEL(P)  MSG(2)        R1MSG
042000010103     C                   LEAVESR
042100010103    1C                   ENDIF
042200010103    ***
042300010103     C                   EXSR      $CHK_SUBD
042400010103    1C                   IF        @@VS <> '0'
042500010103     C                   MOVEL(P)  MSG(3)        R1MSG
042600010103     C                   LEAVESR
042700010103    1C                   ENDIF
042800010207    ***
042900010207     C                   EXSR      $CHK_ACCT
043000160617      * submst locked
043100160617     c                   if        @@va = 'S'
043200160617     C                   MOVEL(P)  MSG(47)       R1MSG
043300160617     C                   LEAVESR
043400160617    1C                   ENDIF
043500160617
043600160617      * submst full
043700160617     c                   if        @@va = '9'
043800160617     C                   MOVEL(P)  MSG(48)       R1MSG
043900160617     C                   LEAVESR
044000160617    1C                   ENDIF
044100160620
044200160620      * accmst locked
044300160620     c                   if        @@va = 'A'
044400191216br01 C*                   MOVEL(P)  MSG(49)       R1MSG
044500220118br01   r1Msg = %Trim( msg(49) ) + ' ' + Lock_Info;
044600191216     C
044700160620     C                   LEAVESR
044800160620    1C                   ENDIF
044900160620
045000160617
045100010207    1C                   IF        @@VA <> '0'
045200010207     C                   MOVEL(P)  MSG(23)       R1MSG
045300010207     C                   LEAVESR
045400010207    1C                   ENDIF
045500010103    ***
045600010103     C                   MOVEL(P)  'STEP2'       @STEP
045700010103    ***
045800010103     C                   ENDSR
045900010103   S***S
046000010103     C     $CHK_TRST     BEGSR
046100010103    ***
046200010104     C                   MOVE      '0'           @@VT
046300010103    1C                   IF        I_TRST = 0
046400010103     C                   MOVE      '1'           @@VT
046500010103    1C                   ELSE
046600010103     C     I_TRST        CHAIN(N)  TRSMSR
046700010103    2C                   IF        NOT %FOUND(TRSMST)
046800010103     C                   MOVE      '2'           @@VT
046900010103    2C                   ELSE
047000010103     C                   MOVEL     TNAME         O_TNAM
047100010103    2C                   ENDIF
047200010103    1C                   ENDIF
047300000102    ***
047400000102     C                   ENDSR
047500000102   S***S
047600010103     C     $CHK_SUBD     BEGSR
047700010103    ***
047800010104     C                   MOVE      '0'           @@VS
047900010103    1C                   IF        I_SUB# = 0
048000010103     C                   MOVE      '1'           @@VS
048100010103    1C                   ELSE
048200010103     C     SUBKEY        CHAIN(N)  SUBMSR
048300010103    2C                   IF        NOT %FOUND(SUBMST)
048400010103     C                   MOVE      '2'           @@VS
048500010103    2C                   ELSE
048600010103     C                   MOVEL     SUBNAM        O_SUBN
048700010103    2C                   ENDIF
048800010103    1C                   ENDIF
048900010103     C*
049000010103    ***
049100010103     C                   ENDSR
049200010207   S***S
049300010207     C     $CHK_ACCT     BEGSR
049400010207    ***
049500010207     C                   MOVE      '0'           @@VA
049600160616
049700160617      * next avail new acc# requested
049800010207     C                   IF        I_ACCT = 0
049900160617     c                   exsr      #locksubmst
050000160617     c                   if        @@va <> '0'
050100160617     c                   leavesr
050200160617     c                   end
050300160617      * find next available acc#
050400160617     c                   exsr      #fndnxtacc
050500160617     c                   if        @@va <> '0'
050600160617     c                   leavesr
050700160617     c                   end
050800160617      * specific acc # entered
050900010207     C                   ELSE
051000160620     C     ACCKEY        CHAIN(e)  accmst
051100160620      * check for record lock
051200160620       if %error and %status(accmst) = 1218;
051300220118         eval @@VA = 'A';
051400191216
051500191216
051600220118br01     // retrieve the user / Job who has the account locked.
051700191216
051800220118         Acct_rrn = 0;
051900220118         Lock_Info = '';
052000191216
052100220120         exec sql
052200220120           select rrn(a)
052300220120             into :Acct_rrn
052400220120             from "F.ACCMST" a
052500220120             where acTrst = :i_trst and
052600220120                   acSub# = :i_sub# and
052700220120                   acAcct = :i_acct;
052800191216
052900191216
053000220120         exec sql
053100220120           SELECT Job_Name
053200220120             into :Lock_Info
053300220120             FROM QSYS2.RECORD_LOCK_INFO
053400220120             WHERE SYSTEM_TABLE_NAME = 'F.ACCMST' AND
053500220120                   LOCK_STATE = 'UPDATE' and
053600220120                   Relative_Record_Number = :acct_rrn;
053700191216
053800191216
053900220118         leavesr;
054000160620       endif;
054100160620
054200160620      * specific new acc # add
054300160617     C                   IF        NOT %FOUND(accmst)
054400160617     c                   exsr      #locksubmst
054500160617     c                   if        @@va <> '0'
054600160617     c                   leavesr
054700160617     c                   end
054800010207     C                   ENDIF
054900160617
055000061011     C     AC2Key        Chain     ACCMSR2
055100061016     C                   If        Not %Found(AC2MST)
055200061016     C                   Move      'N'           AccFound          1
055300061016     C                   Else
055400061016     C                   Move      'Y'           AccFound
055500061016     C                   End
055600010207     C                   ENDIF
055700010207     C                   ENDSR
055800010103   S***S
055900010129    *** TRUST SELECTION WINDOW
056000010103     C     $F2PROC       BEGSR
056100010103    ***
056101220118
056102220118       // Removed B.Rees  1/18/2022
056103220118
056200220118     C***                MOVE      *BLANKS       @3P
056300220118     C***                CALL      'FM006CL'
056400220118     C***                PARM                    @3P
056500220118    1C***                IF        @3P = '*LR'
056600220118     C***                MOVEL(P)  MSG(4)        R1MSG
056700220118    1C***                ELSE
056800220118     C***                MOVE      @3P           I_TRST
056900220118    1C***                ENDIF
057000010103    ***
057001220118
057002220118br02   // New PL Trust Window
057003220118
057004220118       pCancel = '';
057005220118       wn0014R( pTrst : pName : pCancel );
057006220118       if pCancel = '';
057007220118         i_Trst = %Dec( pTrst : 3 : 0 );
057008220118         s_Focus = *on;
057009220118       EndIf;
057010220118
057011220118
057100010103    1C                   IF        I_TRST <> 0
057200010103     C                   EXSR      $CHK_TRST
057300010103    2C                   IF        @@VT <> '0'
057400010103     C                   MOVEL(P)  MSG(2)        R1MSG
057500010103    2C                   ENDIF
057600010103    1C                   ENDIF
057700010103    ***
057800010103     C                   ENDSR
057900000102   S***S
058000010129    *** SUBDIVISION SELECTION WINDOW
058100010129    ***    REQUIRES A VALID TRUST NUMBER TO CALL PROGRAM
058200010103     C     $F4PROC       BEGSR
058300010103    ***
058400010104     C                   MOVE      *BLANKS       @6P
058500010103     C                   EXSR      $CHK_TRST
058600010103     C*
058700010103    1C                   IF        @@VT <> '0'
058800010103     C                   MOVEL(P)  MSG(5)        R1MSG
058900010103     C                   LEAVESR
059000010103    1C                   ENDIF
059100010103    ***
059101220118       // Removed B.Rees  1/18/2022
059200220118     C***                MOVE      I_TRST        @3X
059300220118     C***                MOVEL     @3X           @6P
059400220118     C***                CALL      'FM007CL'
059500220118     C***                PARM                    @6P
059600220118     C***                MOVE      @6P           @3X
059700010103    ***
059800220118    1C***                IF        @3X = '*LR'
059900220118     C***                MOVEL(P)  MSG(4)        R1MSG
060000220118     C***                LEAVESR
060100220118    1C***                ENDIF
060200010103    ***
060201220118
060202220118
060203220118
060204220118br02   // New PL Subdivision Window
060205220118
060206220118       pCancel = '';
060207220118       pTrst = %Char(i_Trst);
060209220118       wn0015R( pTrst : pSub# : pName : pCancel );
060210220118       if pCancel = '';
060211220118         i_Sub# = %Dec( pSub# : 3 : 0 );
060212220118         a_Focus = *on;
060213220118       EndIf;
060214220118
060217220118
060300220118     C*                   MOVE      @3X           I_SUB#
060400220118     C     SUBKEY        CHAIN(N)  SUBMSR
060500220118    1C                   IF        NOT %FOUND(SUBMST)
060600220118     C                   MOVEL(P)  MSG(3)        R1MSG
060700220118    1C                   ELSE
060800220118     C                   MOVEL     SUBNAM        O_SUBN
060900220118    1C                   ENDIF
061000010103    ***
061013220118
061100010103     C                   ENDSR
061200010103   S***S
061300010129    *** EXISTING ACCOUNT NUMBER INQUIRY
061400010129    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
061500010103     C     $F5PROC       BEGSR
061600010103    ***
061700010104     C                   MOVE      *BLANKS       @10P
061800010103     C                   EXSR      $CHK_TRST
061900010103     C*
062000010103    1C                   IF        @@VT <> '0'
062100010103     C                   MOVEL(P)  MSG(6)        R1MSG
062200010103     C                   LEAVESR
062300010103    1C                   ENDIF
062400010103     C*
062500010103     C                   EXSR      $CHK_SUBD
062600010103     C*
062700010103    1C                   IF        @@VS <> '0'
062800010103     C                   MOVEL(P)  MSG(6)        R1MSG
062900010103     C                   LEAVESR
063000010103    1C                   ENDIF
063100010103    ***
063101220118
063102220120br02   // Removed  B.Rees  1/18/2022
063103220118
063200220118     C**                   MOVE      I_TRST        @3X
063300220118     C**                   CAT       @3X:0         @10P
063400220118     C**                   MOVE      I_SUB#        @3X
063500220118     C**                   CAT       @3X:0         @10P
063600220118     C**                   CALL      'FM008CL'
063700220118     C**                   PARM                    @10P
063800220118     C**     4             SUBST     @10P:7        @4
063900010103    ***
064000220118    1C**                   IF        @4 = '*LR '
064100220118     C**                   MOVEL(P)  MSG(4)        R1MSG
064200220118     C**                   LEAVESR
064300220118    1C**                   ENDIF
064400010103    ***
064500220118     C**                   MOVE      @4            I_ACCT
064600010103    ***
064601220118
064602220118br02   // New PL Account Window
064603220118
064604220118       pCancel = '';
064605220118       pTrst = %Char(i_Trst);
064606220118       pSub# = %Char(i_Sub#);
064607220118       wn0016R( pTrst :pSub# : pAcct : pName : pCancel );
064608220118       if pCancel = '';
064609220118         i_Acct = %Dec( pAcct : 4 : 0 );
064610220118         a_Focus = *on;
064611220118       EndIf;
064612220118
064613220118
064614220118
064615220118
064700010103     C                   ENDSR
064800010103   S***S
064900010129    *** CHECK FOR EXISTING REC, IF FOUND, LOAD TO SCREEN; ELSE GET NEXT NUMBER F
065000010129    ***
065100000102     C     $STEP2        BEGSR
065200010103    ***
065300120606     C                   EVAL      *IN70 = *OFF
065400010105     C                   MOVE      *OFF          *IN80
065500010119     C                   EXSR      $BLANKALL
065600010105    ***
065700000102    ***
065800010103     C     ACCKEY        CHAIN     ACCMSR
065900061016     C     AC2Key        Chain     ACCMSR2
066000061016     C                   If        Not %Found(AC2MST)
066100061016     C                   Eval      AccFound =    'N'
066200061016     C                   Else
066300061016     C                   Eval      AccFound =    'Y'
066400061016     C                   End
066500010103     C*
066600010105    1C                   IF        NOT %FOUND(ACCMST)
066700010823     C                   MOVE      *OFF          *IN26
066800010105     C                   MOVE      'A'           @@A
066900060515     C                   Eval      SVOWFL   =    'N'
067000010103     C                   CLEAR                   ACCMSR
067100140225     C                   EVAL      RATECOUNTY = *BLANKS
067200140225     C                   EVAL      RTECNTYDES = *BLANKS
067300010103     C                   Z-ADD     I_TRST        ACTRST
067400010103     C                   Z-ADD     I_SUB#        ACSUB#
067500010103     C                   Z-ADD     I_ACCT        ACACCT
067600010103     C                   MOVE      'A'           ACDLTD
067700010104     C                   MOVE      *ZEROS        R2GBSBDT
067800010119     C                   MOVE      *ZEROS        R2TERM
067900010104     C                   MOVE      *ZEROS        R2ENRL
068000010104     C                   MOVE      *BLANKS       R2AACOD
068100010104     C                   MOVEL     @USER         OPERID
068200021206     C                   MOVE      *ZEROS        RCFSED
068300030214     C                   MOVE      *ZEROS        R2GBSBGA
068400061011     C                   CLEAR                   ACCMSR2
068500061011     C                   Eval      A2APPL   =    'F'
068600061011     C                   Eval      A2TRST   =    I_TRST
068700061011     C                   Eval      A2SUB#   =    I_SUB#
068800061011     C                   Eval      A2ACCT   =    I_ACCT
068900061011     C                   Eval      A2TAX_ID# =   *Zeros
069000061011     C                   Eval      A2ADDRESS1 =  *Blanks
069100061011     C                   Eval      A2ADDRESS2 =  *Blanks
069200061011     C                   Eval      A2CITY     =  *Blanks
069300061011     C                   Eval      A2STATE    =  *Blanks
069400061011     C                   Eval      A2ZIP5     =  *Zeros
069500061011     C                   Eval      A2ZIP4     =  *Zeros
069600061011     C                   Eval      A2COUNTYCD =  *Blanks
069700061011     C                   Eval      A2PARTTIME =  *Blanks
069800061011     C                   Eval      A2OTHERINS =  *Blanks
069900061011     C                   Eval      A2RETIREES =  *Blanks
070000061011     C                   Eval      A2USER     =  OPERID
070100061011     C                   Eval      A2TIME     =  *Zeros
070200061011     C                   Eval      A2DATE     =  *Zeros
070300061011     C                   Eval      A2TERMPOLC =  *Blanks
070400061011     C                   Eval      A2COBRAFEE =  *Zeros
070500061011     C                   Eval      A2EMAIL1   =  *Blanks
070600061011     C                   Eval      A2EMAIL2   =  *Blanks
070700061011     C                   Eval      A2INSCYCLE =  *Blanks
070800061011     C                   Eval      A2FUNDED   =  *Blanks
070900061011     C                   Eval      A2RENEWMED =  *Zeros
071000061011     C                   Eval      A2RENEWDEN =  *Zeros
071100061011     C                   Eval      A2RENEWLIF =  *Zeros
071200061011     C                   Eval      A2MAXAGE1  =  *Blanks
071300061011     C                   Eval      A2MAXAGE2  =  *Blanks
071400061011     C                   Eval      A2MAXAGE3  =  *Blanks
071500061011     C                   Eval      A2MAXAGE4  =  *Blanks
071600061011     C                   Eval      A2MAXAGE5  =  *Blanks
071700061011     C                   Eval      A2MAXAGE6  =  *Blanks
071800061011     C                   Eval      A2MAIL_TO  =  *Blanks
071900061011     C                   Eval      A2RENWDAYM =  *Zeros
072000061011     C                   Eval      A2RENWDAYD =  *Zeros
072100061011     C                   Eval      A2RENWDAYL =  *Zeros
072200061011     C                   Eval      A2NCAPDT   =  *Zeros
072300061011     C                   Eval      A2IHEFF    =  *Zeros
072400061011     C                   Eval      A2DATE2    =  *Zeros
072500061011     C                   Eval      A2DATE3    =  *Zeros
072600061011     C                   Eval      A2IH1T     =  *Blanks
072700061011     C                   Eval      A2IH1B     =  *Blanks
072800061011     C                   Eval      A2IH2T     =  *Blanks
072900061011     C                   Eval      A2IH2B     =  *Blanks
073000061011     C                   Eval      A2IH3T     =  *Blanks
073100061011     C                   Eval      A2IH3B     =  *Blanks
073200061011     C                   Eval      A2IH4T     =  *Blanks
073300061011     C                   Eval      A2IH4B     =  *Blanks
073400061011     C                   Eval      A2IH5T     =  *Blanks
073500061011     C                   Eval      A2IH5B     =  *Blanks
073600061011     C                   Eval      A2IH6T     =  *Blanks
073700061011     C                   Eval      A2IH6B     =  *Blanks
073800061011     C                   Eval      A2IH7T     =  *Blanks
073900061011     C                   Eval      A2IH7B     =  *Blanks
074000061011     C                   Eval      A2IH8T     =  *Blanks
074100061011     C                   Eval      A2IH8B     =  *Blanks
074200061011     C                   Eval      A2IH9T     =  *Blanks
074300061011     C                   Eval      A2IH9B     =  *Blanks
074400061011     C                   Eval      A2USECC    =  *Blanks
074500061011     C                   Eval      A2PAR    =    *Blanks
074600010105    1C                   ELSE
074700120606     C     ACCKEY        CHAIN     C2F
074800120606     C                   IF        %FOUND(COB440W2) AND C2PROC = 'Y'
074900120606     C                   EVAL      *IN70 = *ON
075000120606     C                   ENDIF
075100060515     C                   If        SVOWFL   =    *Blanks
075200060515     C                   Eval      SVOWFL   =    'N'
075300060515     C                   End
075400140225    ***
075500140225     C                   EXSR      $COUNTY
075600140225    ***
075700010105     C                   MOVE      'C'           @@A
075800010823     C                   MOVE      *ON           *IN26
075900010104     C                   MOVE      ENROLL        #ISO
076000010104     C                   MOVE      #ISO          #USA
076100010105     C                   MOVE      #USA          R2ENRL
076200010104     C                   MOVE      GBSBDT        #ISO
076300010104     C                   MOVE      #ISO          #USA
076400010104     C                   MOVE      #USA          R2GBSBDT
076500010105    2C                   IF        ATRMDT <> 0
076600010105     C                   MOVE      ATRMDT        #ISO
076700010105     C                   MOVE      #ISO          #USA
076800010105     C                   MOVE      #USA          R2TERM
076900010105     C                   MOVE      *ON           *IN80
077000010108     C                   MOVE      'C'           ACDLTD
077100010119    2C                   ELSE
077200010119     C                   MOVE      *ZEROS        R2TERM
077300010105    2C                   ENDIF
077400030427     C                   IF        CFSEDT <> *ZEROS
077500030427     C                   Z-ADD     CFSEDT        CFSEDI
077600021206     C                   MOVE      CFSEDI        #ISO
077700021127     C                   MOVE      #ISO          #USA
077800021206     C                   MOVE      #USA          RCFSED
077900021127     C                   ELSE
078000021206     C                   MOVE      *ZEROS        RCFSED
078100021127     C                   ENDIF
078200030427     C                   IF        GBSGAD <> *ZEROS
078300030427     C                   Z-ADD     GBSGAD        GBGADI
078400030225     C                   MOVE      GBGADI        #ISO
078500030214     C                   MOVE      #ISO          #USA
078600030214     C                   MOVE      #USA          R2GBSBGA
078700030214     C                   ELSE
078800030214     C                   MOVE      *ZEROS        R2GBSBGA
078900030214     C                   ENDIF
079000010104     C                   MOVEL(P)  ACAACOD       R2AACOD
079100061011     C                   Eval      RPAR      =   A2PAR
079200010105    1C                   ENDIF
079300010103    ***
079400021203     C                   EXSR      $MOV2SCR
079500021203     C                   MOVEL(P)  'STEP3'       @STEP
079600021203     C                   MOVE      *ON           *IN25
079700140225    ***
079800140225     C                   ENDSR
079900140225   S***S
080000140225    *** COUNTY CODE & TEXT
080100140225     C     $COUNTY       BEGSR
080200140225    ***
080300140225     C                   EVAL      RATECOUNTY = *BLANKS
080400140225     C                   EVAL      RTECNTYDES = *BLANKS
080500140225    ***
080600140402     C     ACCKEY        CHAIN     ACARGRF
080700140402     C                   IF        NOT %FOUND(ACARGRP)
080800140402     C                   CLEAR                   ACARGR@
080900140402     C                   ELSE
081000140402     C     ACCKEY        SETGT     ACARGRF
081100140402     C     ACCKEY        READPE    ACARGRF
081200140402     C                   ENDIF
081300140402    ***
081400140226     C                   IF        ACONTY = *BLANKS AND
081500140402     C                             A2COUNTYCD = *BLANKS AND
081600140402     C                             AGCNTY = *BLANKS
081700140226     C                   LEAVESR
081800140226     C                   ENDIF
081900140226    ***
082000140225     C                   EVAL      RATECOUNTY = ACONTY
082100140225     C                   EVAL      KF@STATE = ASTATE
082200140225    ***
082300140225     C                   IF        AccFound = 'Y' AND
082400140402     C                             A2STATE <> *BLANKS
082500140226     C                   EVAL      RATECOUNTY = A2COUNTYCD
082600140226     C                   IF        A2STATE <> *BLANKS
082700140225     C                   EVAL      KF@STATE = A2STATE
082800140226     C                   ENDIF
082900140225     C                   ENDIF
083000140402    ***
083100140404     C                   IF        AGCNTY <> *BLANKS
083200140402     C                   EVAL      RATECOUNTY = AGCNTY
083300140402     C                   EVAL      KF@STATE = AGSTATE
083400140402     C                   ENDIF
083500140225    ***
083600140225     C                   EVAL      KF@COUNTY = RATECOUNTY
083700140225     C     KL#CC         KLIST
083800140225     C                   KFLD                    KF@STATE          2
083900140225     C                   KFLD                    KF@COUNTY         2
084000140226     C     KL#CC         CHAIN     COUNTYCODR
084100140226     C                   IF        %FOUND(COUNTYCOL1)
084200140226     C                   MOVEL(P)  CDESCR        RTECNTYDES
084300140226     C                   ENDIF
084400021203    ***
084500010104     C                   ENDSR
084600010119   S***S
084700010129    *** BLANK SCREEN FIELDS
084800010119     C     $BLANKALL     BEGSR
084900140225    ***
085000010119     C                   MOVE      *ZEROS        R2GBSBDT
085100010119     C                   MOVE      *ZEROS        R2TERM
085200010119     C                   MOVE      *ZEROS        R2ENRL
085300010119     C                   MOVE      *BLANKS       R2AACOD
085400010119     C                   MOVE      *BLANKS       RCNAM1
085500010119     C                   MOVE      *BLANKS       RCNAM2
085600010119     C                   MOVE      *BLANKS       RADDR1
085700010119     C                   MOVE      *BLANKS       RADDR2
085800010119     C                   MOVE      *BLANKS       RCITY
085900010119     C                   MOVE      *BLANKS       RSTATE
086000010119     C                   MOVE      *ZEROS        #ZIP
086100010119     C                   MOVE      *BLANKS       RCONTY
086200010119     C                   MOVE      *ZEROS        RAREA
086300010119     C                   MOVE      *ZEROS        RPHONE
086400010119     C                   MOVE      *ZEROS        RAXARE
086500010119     C                   MOVE      *ZEROS        RAX#
086600010119     C                   MOVE      *BLANKS       RONTAC
086700010119     C                   MOVE      *BLANKS       RCNTAC
086800010119     C                   MOVE      *ZEROS        ROTEMP
086900010119     C                   MOVE      *ZEROS        ROEMPL
087000010119     C                   MOVE      *BLANKS       RCSTFL
087100050610s610 C                   Move      *Zeros        RCOBADM
087200050610s610 C                   Move      *Blanks       RNOFEE
087300040901s824 C                   MOVE      *BLANKS       RSPHFL
087400090216s824 C                   MOVE      *BLANKS       RCFS834
087500090408     C                   Move      *Zeros        RC8DT
087600090701     C                   Move      *Zeros        AMC8DT
087700090904     C                   Move      *Blanks       AMCYUS
087800090904     C                   Move      *Zeros        AMCYDT
087900090904     C                   Move      *Zeros        AMCYTI
088000010119     C                   MOVE      *ZEROS        RRNEWPD
088100010119     C                   MOVE      *ZEROS        RREEX
088200010119     C                   MOVE      *ZEROS        RAIT1
088300010119     C                   MOVE      *ZEROS        RAIT2
088400010119     C                   MOVE      *ZEROS        RAIT3
088500010119     C                   MOVE      *ZEROS        RVGAGE
088600010119     C                   MOVE      *ZEROS        RRENAVG
088700010119     C                   MOVE      *BLANKS       RMANCD
088800120809     C                   MOVE      *BLANKS       RREREP
088900061011     C                   Eval      RPAR     =    *Blank
089000010119     C                   MOVE      *ZEROS        REDEMP
089100010119     C                   MOVE      *ZEROS        RIFPCT
089200060428     C                   MOVE      *ZEROS        RLTPCT
089300060428     C                   MOVE      *ZEROS        RSTPCT
089400060515     C                   Eval      SVOWFL   =    'N'
089500010119     C                   MOVE      *ZEROS        RICCOD
089600010119     C                   MOVE      *BLANKS       RBCFLG
089700010119     C                   MOVE      *BLANKS       RPREFX
089800021206     C                   MOVE      *ZEROS        RCFSED
089900021206     C                   MOVE      *ZEROS        CFSEDI
090000030214     C                   MOVE      *ZEROS        R2GBSBGA
090100030225     C                   MOVE      *ZEROS        GBGADI
090200010119     C                   ENDSR
090300010104   S***S
090400010129    *** MOVE FILE FIELDS TO SCREEN
090500010104     C     $MOV2SCR      BEGSR
090600010104    ***
090700200115     C                   If        TSCODE = 'O N' or TSCODE = 'O M' or
090800200115     C                             TSCODE = 'O D'
090900120508     C                   If        CAFIC    =    *Blanks
091000120508     C                   Eval      CAFIC    =    'O'
091100120508     C                   End
091200120508     C                   Else
091300120508     C                   If        CAFIC    =    *Blanks
091400120718     C                   Eval      CAFIC    =    'B'
091500120508     C                   End
091600120508     C                   End
091700120508
091800010104     C                   MOVEL(P)  ACNAM1        RCNAM1
091900010104     C                   MOVEL(P)  ACNAM2        RCNAM2
092000010104     C                   MOVEL(P)  AADDR1        RADDR1
092100010104     C                   MOVEL(P)  AADDR2        RADDR2
092200010104     C                   MOVEL(P)  ACITY         RCITY
092300010104     C                   MOVEL(P)  ASTATE        RSTATE
092400010104     C                   Z-ADD     AZIP          #ZIP
092500130918     C                   eval      sv_zip5 = azip5
092600010104     C                   MOVEL(P)  ACONTY        RCONTY
092700010104     C                   Z-ADD     AAREA         RAREA
092800010104     C                   Z-ADD     APHONE        RPHONE
092900010104     C                   Z-ADD     FAXARE        RAXARE
093000010104     C                   Z-ADD     FAX#          RAX#
093100010104     C                   MOVEL(P)  CONTAC        RONTAC
093200010104     C                   MOVEL(P)  ECNTAC        RCNTAC
093300010104     C                   Z-ADD     TOTEMP        ROTEMP
093400010104     C                   Z-ADD     NOEMPL        ROEMPL
093500010104     C                   MOVEL(P)  FCSTFL        RCSTFL
093600050620s610 C                   Z-Add     COBADM        RCOBADM
093700040929     C                   MOVEL     acobsrv       rcobsrv
093800040901s824 C                   Movel     ASPHFL        RSPHFL
093900090216s216 C                   Movel     CFS834        RCFS834
094000090630     C     AMC8DT        MULT      10000.0001    RC8DT
094100010104     C                   Z-ADD     RNEWPD        RRNEWPD
094200010104     C                   Z-ADD     PREEX         RREEX
094300010104     C                   Z-ADD     WAIT1         RAIT1
094400010104     C                   Z-ADD     WAIT2         RAIT2
094500010104     C                   Z-ADD     WAIT3         RAIT3
094600010104     C                   Z-ADD     AVGAGE        RVGAGE
094700010104     C                   Z-ADD     RENAVG        RRENAVG
094800010104     C                   MOVEL(P)  SMANCD        RMANCD
094900130626     C                   If        A2CODE1  =    *Blank
095000130626     C                   Movel(P)  SMANCD        RREREP
095100130626     C                   Else
095200120809     C                   MOVEL(P)  A2CODE1       RREREP
095300130626     C                   End
095400061011     C                   Eval      RPAR     =    A2PAR
095500010104     C                   Z-ADD     MEDEMP        REDEMP
095600010104     C                   Z-ADD     LIFPCT        RIFPCT
095700060428     C                   Z-ADD     LTDPCT        RLTPCT
095800060428     C                   Z-ADD     STDPCT        RSTPCT
095900060501     C                   Eval      RVOWFL   =    SVOWFL
096000010104     C                   Z-ADD     SICCOD        RICCOD
096100010104     C                   MOVEL(P)  ABCFLG        RBCFLG
096200010104     C                   MOVEL(P)  APREFX        RPREFX
096300010103    ***
096400101123      * If Special Handling is F, auto load facility address if ADD mode
096500110201     C                   If        RSPHFL   =    'F'
096600110201    2C***also for changes per A.W. @@A = 'A'
096700100517     C                   Exsr      FacilityBOM
096800100816     C                   Exsr      FacilityBIL
096900100517     C                   End
097000010103     C                   ENDSR
097100010103   S***S
097200010103     C     $STEP3        BEGSR
097300010103    ***
097400010129???**********************MOVEL(P)  R2MSG         @@45
097500040824s824 C                   Eval      *In28    =    *Off
097600040901s824 C                   If        RSPHFL   =    'Y'
097700061013test C                   If        *In25    =    *On
097800040901s824 C                   Movel     Msg(27)       R2MSG
097900040901s824 C                   Eval      *In28    =    *On
098000061013test C                   End
098100040901s824 C                   End
098200090304      *
098300101123      * If Special Handling is F, auto load facility address and ADD Mode
098400110201     C                   If        RSPHFL   =    'F'
098500110201    2C****also for changes per A.W.@@A = 'A'
098600100517     C                   Exsr      FacilityBOM
098700100816     C                   Exsr      FacilityBIL
098800090304     C                   End
098900061130      *
099000061130      * Determine if there is an OE record for this account
099100061130      *
099200061130     C     BENKEY        Chain     ACCOSP
099300061130     C                   If        %Found(ACCOSP) And
099400061130     C                               AOBEDT <> *Zeros
099500061130     C                   Eval      *In88    =    *On
099600061130     C                   Else
099700061130     C                   Eval      *In88    =    *Off
099800061130     C                   End
099900090319      *
100000090319      * Determine if there is an ACH record for this account
100100090319      *
100200090319     C     BENKEY        Chain     ACCACH
100300090319     C                   If        %Found(ACCACH) And
100400090319     C                               AHBEDT <> *Zeros
100500090319     C                   Eval      *In90    =    *On
100600090319     C                   Else
100700090319     C                   Eval      *In90    =    *Off
100800090319     C                   End
100900090408      * Determine if there is a Misc record for this account (CFS834 date).
101000090408      *
101100090408     C     BENKEY        Chain     ACCMSP
101200090728     C                   If        RC8DT    =    *Zeros   And
101300090728     C                             RCFS834  <>   *Blanks
101400090408     C     AMC8DT        MULT      10000.0001    RC8DT
101500090728     C                   End
101600090730      * If this is an Onsite Dental Trust, highlight Medicaid function.
101700200115     C                   If        TSCODE = 'O N' or TSCODE = 'O M' or
101800200115     C                             TSCODE = 'O D'
101900090730     C                   Eval      *In91    =    *On
102000090730     C                   Else
102100090730     C                   Eval      *In91    =    *Off
102200120508     C                   If        CAFIC    =    *Blanks
102300120718     C                   Eval      CAFIC    =    'B'
102400120508     C                   End
102500090730     C                   End
102600100625      *
102700100625      * Determine if there are OD issues for this account
102800100625      *
102900100625     C     BENKEY        Chain     CMISSP
103000100625     C                   If        %Found(CMISSP)
103100100625     C                   Eval      *In92    =    *On
103200100625     C                   Else
103300100831     C     BENKEY        Chain     CM8ACL2
103400100831     C                   If        %Found(CM8ACL2)
103500100831     C                   Eval      *In92    =    *On
103600100831     C                   Else
103700100625     C                   Eval      *In92    =    *Off
103800100625     C                   End
103900100831     C                   End
104000090225      *
104100090306      * Determine if there is a Contact record for this account
104200090225      *
104300090306     C     BENKEY        Setll     ODCNTCP
104400090306     C     BENKEY        Reade     ODCNTCP
104500090306     C                   If        Not %Eof(ODCNTCP) And
104600090306     C                              (OCTRM  =  *Zeros  Or
104700100524     C                               OCTRM  >= Today)
104800090225     C                   Eval      *In89    =    *On
104900090225     C                   Else
105000090225     C                   Eval      *In89    =    *Off
105100090225     C                   End
105200120515      *   Only hard-coded user IDs have ACH access
105300120515     C                   If        FKEY = F15
105301230217
105302230217       pgmname2 = 'WRKACHCL';
105303230217       ChkPgmAuth(pgmname2 : continue2);
105306230217       if continue2 = 'Y';
105400230217     C****               If        @USER  = 'BRANDONS  '  Or
105500230217     C****                         @USER  = 'RONM      '  Or
105600230217     C****                         @USER  = 'LISA      '  Or
105700230217     C****                         @USER  = 'SHELLY    '  Or
105800230217     C****                         @USER  = 'ASHLEYR   '  or
105900230217     C****                         @USER  = 'ACOSTI    '  or
106000230217     C****                         @USER  = 'DGUIDONE  '  or
106100230217     C****                         @USER  = 'ERICD     '  or
106200230217     C****                         @USER  = 'CNICOSIA  '  or
106201230217     C****                         @USER  = 'BREES     '  or
106300230217     C****                         @USER  = 'CSEDOR    '
106400230217     C                   Eval      AHTRST = I_TRST
106500230217     C                   Eval      AHSUB# = I_SUB#
106600230217     C                   Eval      AHACCT = I_ACCT
106700230217     C                   CALL      'WRKACHCL'
106800230217     C                   PARM                    WADTA
106900230217     C****               Else
107000230217     C****               Movel(P)  MSG(44)       R2MSG
107100230217     C                   End
107200120515     C                   End
107300061130      *
107400010104     C                   EXFMT     IO02
107500040824s824 C                   Eval      *In28    =    *Off
107600060501     C                   Eval      *In50    =    *Off
107700060501     C                   Eval      *In51    =    *Off
107800060501     C                   Eval      *In52    =    *Off
107900060501     C                   Eval      *In53    =    *Off
108000061011     C                   Eval      *In56    =    *Off
108100010104     C                   MOVE      *BLANKS       R2MSG
108200010129     C*
108300010129    *** EXIT BACK TO SELECTION SCREEN
108400010129     C*
108500010103    1C                   IF        FKEY = F1
108600010108     C                   MOVEL(P)  'STEP1'       @STEP
108700100723     C                   UNLOCK    ACCMST
108800160617     C                   UNLOCK    submst
108900160620     C                   UNLOCK    ac2mst
109000160620     C                   UNLOCK    accmsp
109100000102     C                   LEAVESR
109200010103    1C                   ENDIF
109300010129     C*
109400010129    *** ADDITIONAL INFO TOGGLE LOGIC
109500010129     C*
109600010104    1C                   IF        FKEY = F5
109700010104    2C                   IF        *IN25 = *ON
109800010104     C                   MOVE      *OFF          *IN25
109900010104    2C                   ELSE
110000010104     C                   MOVE      *ON           *IN25
110100010104    2C                   ENDIF
110200010129???**********************MOVEL(P)  @@45          R2MSG
110300010104     C                   LEAVESR
110400010104    1C                   ENDIF
110500010129     C*
110600040824s824*** Call Member Account Diary Note Maintenance Program if special handling
110700040824      *P11 is - byte 1 = S = Stand Alone Call  OR I for Interface.
110800040824      *        Bytes 2 to 11 are TRS/SUBD/ACC
110900040901s824 C                   If        RSPHFL  =     'Y'
111000040901s824 C                   Movel     'I'           P11              11
111100040901s824 C                   Move      @@TSA         P11
111200040824s824 C*
111300040901s824 C                   IF        FKEY = F8
111400040901s824 C                   CALL      'TR121CL'
111500040901s824 C                   PARM                    P11
111600040901s824 C                   ENDIF
111700040901     C                   End
111800050317      *
111900140128    *** CALL ACA REGION MAINTENANCE
112000050317      *
112100050317     C                   If        FKEY = F9
112200140128     C                   MOVE      *BLANKS       @10              10
112300140128     C                   EVAL      @10 = %EDITC(I_TRST:'X') +
112400140128     C                             %EDITC(I_SUB#:'X') + %EDITC(I_ACCT:'X')
112500140128     C                   Call      'FM520CL'
112600140128     C                   Parm                    @10
112700050317     C                   ENDIF
112800061129      *
112900061129    *** CALL OE Code Supplemental
113000061129      *
113100061130     C                   If        FKEY = F20
113200061129     C                   Eval      AOTRST = I_TRST
113300061129     C                   Eval      AOSUB# = I_SUB#
113400061129     C                   Eval      AOACCT = I_ACCT
113500061129     C                   Clear                   HisTrCd
113600080611312  C***********        Call      'PWC010'
113700080611312  C***********        Parm                    Secure            1
113800080611312  C***********        If        Secure <>     'F'
113900061129     C                   Call      'WRKOSPCL'
114000061129     C                   Parm                    WDOE
114100061129     C                   Parm                    HisTrCd           3
114200080611312  C***********        End
114300061130     C                   ENDIF
114400050317      *
114500090306    *** Call Control Maintenance Module
114600090306      *
114700090306     C                   If        FKEY = F21
114800090306     C                   Eval      OCTRST = I_TRST
114900090306     C                   Eval      OCSUB# = I_SUB#
115000090306     C                   Eval      OCACCT = I_ACCT
115100100811     C     ACCKEY        CHAIN(N)  ACCMSR
115200090306     C                   Clear                   HisTrCd
115300180619
115400180619       if asphfl = 'D';
115500220118         ocadd1 = aaddr1;
115600180619         ocadd2 = aaddr2;
115700220118         occity = acity;
115800220118         ocst = astate;
115900180619         oczip = %editc(azip:'X');
116000220118         ocphn1 = %editc(aarea:'X') + %editc(aphone:'X');
116100180619       endif;
116200180619
116300090306     C                   Call      'WRKOCNCL'
116400090306     C                   Parm                    WDOC
116500100811     C                   MOVEL(P)  'STEP2'       @STEP
116600100811     C                   LeaveSR
116700090306     C                   End
116800090730    *** Call Medicaid# Entry Program
116900090730      *
117000090730     C                   If        FKEY = F22
117100090730     C                   Unlock    ACCMSP                               99
117200090730     C                   Movel     ACTRST        @TRST
117300090730     C                   Movel     ACSUB#        @SUBD
117400090730     C                   Movel     ACACCT        @ACCT
117500090730     C                   Call      'PMTMAICL'
117600090730     C                   Parm                    @TRST
117700090730     C                   Parm                    @SUBD
117800090730     C                   Parm                    @ACCT
117900090731     C                   Parm                    @Medicaid        15
118000090730     C                   End
118100100527    *** Call OD Incidents  Program
118200100527      *
118300100527     C                   If        FKEY   = F23
118400100527     C                   Eval      CITRST = I_TRST
118500100527     C                   Eval      CISUB# = I_SUB#
118600100527     C                   Eval      CIACCT = I_ACCT
118700100825     C                   Eval      CIISS# =  1
118800100624     C                   Move      I_ACCT        wpgm
118900100624     C                   Movel     'A'           wpgm
119000100527     C                   Call      'WRKINCCL'
119100100527     C                   Parm                    WMDTA
119200100624     C                   Parm                    wpgm              5
119300100527    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
119400100527     C                   End
119500090730      *
119600090306    *** CALL COMMISSION CONTROL
119700010129     C*
119800010104    1C                   IF        FKEY = F10
119900010104     C                   CALL      'FM061CL'
120000010104     C                   PARM                    @@TSA
120100010104    1C                   ENDIF
120200010129     C*
120300010129    *** CALL ACCOUNT PRIMARY PLAN
120400010129     C*
120500010104    1C                   IF        FKEY = F11
120600010104     C                   CALL      'FM062CL'
120700010104     C                   PARM                    @@TSA
120800010104    1C                   ENDIF
120900010129     C*
121000010129    *** CALL ACCOUNT/CARRIER MARKET SIZES
121100010129     C*
121200010104    1C                   IF        FKEY = F14
121300010104     C                   CALL      'FM063CL'
121400010104     C                   PARM                    @@TSA
121500040728     C                   PARM                    @@PARM2
121600040728     C                   PARM                    @@PARM3
121700010104    1C                   ENDIF
121800090319      *
121900010710    * * CALL ADDITIONAL MAINTANENCE SCREEN
122000010710    * * IF RECORD ADDED TO ACCMST ALLOW ACCESS
122100010710
122200010710    1C                   IF        FKEY = F16
122300061017     C     Ac2Key        Setll     ACCMSR2
122400010710     C     ACCKEY        SETLL     ACCMSR
122500010710     C                   IF        NOT %EQUAL(ACCMST)
122600010710???**C                   EVAL      R2MSG  = MSG(24)
122700010710     C                   LEAVESR
122800010710     C                   END
122900010710     C                   CALL      'FM060_2R'
123000010710     C                   PARM                    @@TSA
123100010710    1C                   END
123200060331      *
123300060331    * * F17 - admin fee override
123400060331      *
123500060331    1C                   IF        FKEY = F17
123600060331     C                   move      rcnam1        parmacnam1
123700060331     C                   CALL      'FM064CL'
123800060331     C                   PARM                    parmletA
123900060331     C                   PARM                    @@TSA
124000060331     C                   PARM                    parmacnam1
124100060331    1C                   ENDIF
124200060331      *
124300060331    * * F18 - Bonus draw override
124400060331      *
124500060331    1C                   IF        FKEY = F18
124600060331     C                   move      rcnam1        parmacnam1
124700060331     C                   CALL      'FM064CL'
124800060331     C                   PARM                    parmletB
124900060331     C                   PARM                    @@TSA
125000060331     C                   PARM                    parmacnam1
125100060331    1C                   ENDIF
125200060417      *
125300060417    * * F19 - Carrier Begin Date
125400060417      *
125500060417    1C                   IF        FKEY = F19
125600060417     C                   move      rcnam1        parmacnam1
125700060417     C                   CALL      'FM065CL'
125800060417     C                   PARM                    @@TSA
125900060417     C                   PARM                    parmacnam1
126000060417    1C                   ENDIF
126100010710      *
126101220120br02   if btnNotes = *on;
126102220120         amNotesc(i_trst: i_sub#: i_Acct );
126106220120       EndIf;
126107220120
126108220120
126109220120      *
126200010710    * * VALIDATE ONE SIDE AT A TIME
126300010710      *
126400010104    1C                   IF        *IN25 = *ON
126500010104     C                   EXSR      $VALID_25
126600010129    2C                   IF        R2MSG = *BLANKS
126700010104     C                   EXSR      $VALIDN25
126800010129    2C                   ENDIF
126900010104    1C                   ELSE
127000010104     C                   EXSR      $VALIDN25
127100010129    2C                   IF        R2MSG = *BLANKS
127200010104     C                   EXSR      $VALID_25
127300010129    2C                   ENDIF
127400010104    1C                   ENDIF
127500090408     C*
127600010129     C*
127700010129    *** IF PASSED EDITS, ADD OR UPDATE RECORD.
127800010129     C*
127900010104    1C                   IF        R2MSG = *BLANKS
128000010104     C                   EXSR      $CHANGES
128100010104    2C                   IF        @@A = 'A'
128200010104     C                   EXSR      $SCR2FIL
128300180612
128400180613       new = 'Y';
128500180613       exsr writeContact;
128600180613       new = 'N';
128700180612
128800010104     C                   WRITE     ACCMSR
128900061016     C                   If        AccFound =  'N'
129000070105     C                   Eval      A2APPL   =    'F'
129100070105     C                   Eval      A2TRST   =    I_TRST
129200070105     C                   Eval      A2SUB#   =    I_SUB#
129300070105     C                   Eval      A2ACCT   =    I_ACCT
129400130226     C                   Eval      RPAR      =   A2PAR
129500130226t    C                   Eval      RREREP    =   A2CODE1
129600061011     C                   WRITE     ACCMSR2
129700061016     C                   Else
129800061016     C                   UPDATE    ACCMSR2
129900061016     C                   End
130000010104    2C                   ELSE
130100010104    3C                   IF        @@CHGS = 'Y'
130200010104     C                   MOVE      #TISO         LUPDDT
130300061017     C                   If        %Found(ACCMST)
130400180613
130500180613       new = 'N';
130600180612       exsr writeContact;
130800010104     C                   UPDATE    ACCMSR
130801221110       exsr updateFileListing;
130900061017     C                   End
131000061016     C                   If        AccFound <> 'N'
131100061011     C                   UPDATE    ACCMSR2
131200061016     C                   Else
131300070105     C                   Eval      A2APPL   =    'F'
131400070105     C                   Eval      A2TRST   =    I_TRST
131500070105     C                   Eval      A2SUB#   =    I_SUB#
131600070105     C                   Eval      A2ACCT   =    I_ACCT
131700130226     C                   Eval      RPAR      =   A2PAR
131800130226t    C                   Eval      RREREP    =   A2CODE1
131900061016     C                   Write     ACCMSR2
132000061016     C                   End
132100010104    3C                   ENDIF
132200010104    2C                   ENDIF
132300010104     C                   MOVEL(P)  'STEP2'       @STEP
132400010104    1C                   ENDIF
132500010104    ***
132600100517     C                   ENDSR
132700100517   S***S
132800100517     C     FacilityBOM   Begsr
132900101008     C**********         Eval      RCNAM2   =    %Trim('C/O ' + SUBNAM)
133000101008     C                   Eval      RCNAM2   =    %Trim('C/O ' + SUBDSC)
133100100517     C     SUBKEY        Chain     ODFACP
133200100517     C                   If        %Found(ODFACP)
133300100517     C                   Eval      RADDR1   =    S2ADD1
133400100517     C                   Eval      RADDR2   =    S2ADD2
133500100517     C                   Eval      RCITY    =    S2CITY
133600100517     C                   Eval      RSTATE   =    S2ST
133700100517     C                   Movel     S2ZIP         AZIP5
133800100517     C                   Move      S2ZIP         AZIP4
133900120524     C****************   Movel     S2PHON        RAREA
134000120524     C****************   Move      S2PHON        RPHONE
134100100517     C                   End
134200100524     C     BOMKEY        Setll     ODCNTCP
134300100524     C     BOMKEY        Reade     ODCNTCP
134400100524     C                   If        Not %Eof(ODCNTCP)
134500100524     C                   Dou       %Eof(ODCNTCP)
134600100524     C                   If        OCEFF    <=   Today   AND
134700100524     C                             (OCTRM   >=   Today   OR
134800100524     C                             OCTRM    =    *Zero)
134900100517     C                   Eval      RONTAC   =    %Trim(%Trim(OCFNAM) + ' ' +
135000100517     C                                           %Trim(OCLNAM))
135100120524sz524C                   Movel     OCPHN1        RAREA
135200120524sz524C                   Move      OCPHN1        RPHONE
135300120524sz524C                   Movel     OCFAX         RAXARE
135400120524sz524C                   Move      OCFAX         RAX#
135500100524     C                   Leave
135600110209     C                   Else
135700110209     C                   Eval      RONTAC   =    *Blanks
135800120524sz524C                   Clear                   RAREA
135900120524sz524C                   Clear                   RPHONE
136000120524sz524C                   Clear                   RAXARE
136100120524sz524C                   Clear                   RAX#
136200100524     C                   End
136300100524     C     BOMKEY        Reade     ODCNTCP
136400100524     C                   EndDo
136500100517     C                   Else
136600100524     C     SubBOMKey     Setll     ODCNTCP
136700100524     C     SubBOMKey     Reade     ODCNTCP
136800100524     C                   Dou       %Eof(ODCNTCP)
136900110131     C                   If        Not %Eof(ODCNTCP)
137000100524     C                   If        OCEFF    <=   Today   AND
137100100524     C                             (OCTRM   >=   Today   OR
137200100524     C                             OCTRM    =    *Zero)
137300100517     C                   Eval      RONTAC   =    %Trim(%Trim(OCFNAM) + ' ' +
137400100517     C                                           %Trim(OCLNAM))
137500120524sz524C                   Movel     OCPHN1        RAREA
137600120524sz524C                   Move      OCPHN1        RPHONE
137700120524sz524C                   Movel     OCFAX         RAXARE
137800120524sz524C                   Move      OCFAX         RAX#
137900100524     C                   Leave
138000110209     C                   Else
138100110209     C                   Eval      RONTAC   =    *Blanks
138200120524sz524C                   Clear                   RAREA
138300120524sz524C                   Clear                   RPHONE
138400120524sz524C                   Clear                   RAXARE
138500120524sz524C                   Clear                   RAX#
138600100517     C                   End
138700110131     C                   End
138800100524     C     SubBOMKey     Reade     ODCNTCP
138900100524     C                   EndDo
139000100517     C                   End
139100100517     C                   Endsr
139200100816      *
139300100816     C     FacilityBIL   Begsr
139400110209     C                   Eval      RCNTAC    =   *Blanks
139500100816     C     BILKEY        Setll     ODCNTCP
139600100816     C     BILKEY        Reade     ODCNTCP
139700100816     C                   If        Not %Eof(ODCNTCP)
139800100816     C                   Dou       %Eof(ODCNTCP)
139900100816     C                   If        OCEFF    <=   Today   AND
140000100816     C                             (OCTRM   >=   Today   OR
140100100816     C                             OCTRM    =    *Zero)
140200100816     C                   Eval      RCNTAC    =   %Trim(%Trim(OCFNAM)   + ' ' +
140300100816     C                                            %Trim(OCLNAM))
140400100816     C                   Leave
140500110209     C                   Else
140600110209     C                   Eval      RCNTAC    =   *Blanks
140700100816     C                   End
140800100816     C     BILKEY        Reade     ODCNTCP
140900100816     C                   EndDo
141000100816     C                   Else
141100100816     C     SubBILKey     Setll     ODCNTCP
141200100816     C     SubBILKey     Reade     ODCNTCP
141300100816     C                   Dou       %Eof(ODCNTCP)
141400110131     C                   If        Not %Eof(ODCNTCP)
141500100816     C                   If        OCEFF    <=   Today   AND
141600100816     C                             (OCTRM   >=   Today   OR
141700100816     C                             OCTRM    =    *Zero)
141800100816     C                   Eval      RCNTAC    =   %Trim(%Trim(OCFNAM)   + ' ' +
141900100816     C                                            %Trim(OCLNAM))
142000100816     C                   Leave
142100110209     C                   Else
142200110209     C                   Eval      RCNTAC    =   *Blanks
142300100816     C                   End
142400110131     C                   End
142500100816     C     SubBILKey     Reade     ODCNTCP
142600100816     C                   EndDo
142700100816     C                   End
142800100816     C                   Endsr
142900000102   S***S
143000010104     C     $VALID_25     BEGSR
143100010104    ***
143200010104    *** GBS DATE
143300010104    1C                   IF        R2GBSBDT = 0
143400010104     C                   MOVEL(P)  MSG(8)        R2MSG
143500010104     C                   LEAVESR
143600010104    1C                   ENDIF
143700090707      *
143800090707     C                   If        %Found(ACCACH)
143900090707     C     R2GBSBDT      Mult      10000.0001    GBSFlip           8 0
144000090707     C     R2ENRL        Mult      10000.0001    ENRFlip           8 0
144100090707     C                   If        GBSFlip  >    AHBEDT   Or
144200090707     C                             ENRFlip  >    AHBEDT
144300090707     C                   Movel(P)  Msg(42)       R2MSG
144400090707     C                   LeaveSr
144500090707     C                   End
144600090707     C                   End
144700010104     C*
144800010104     C     *USA          TEST(DE)                R2GBSBDT
144900010104    1C                   IF        %ERROR
145000010104     C                   MOVEL(P)  MSG(8)        R2MSG
145100010104     C                   LEAVESR
145200010104    1C                   ENDIF
145300010104     C*
145400010104     C                   MOVE      R2GBSBDT      #USA
145500010104     C                   MOVE      #USA          #ISO
145600010104     C                   MOVE      #ISO          #GBSISO
145700010105    *** TERM DATE
145800010105    1C                   IF        R2TERM <> 0
145900010105     C*
146000010105    2C                   IF        @@A = 'A'
146100010105     C                   MOVEL(P)  MSG(22)       R2MSG
146200010105     C                   LEAVESR
146300010105    2C                   ENDIF
146400010105     C*
146500010105     C     *USA          TEST(DE)                R2TERM
146600010105    2C                   IF        %ERROR
146700010105     C                   MOVEL(P)  MSG(8)        R2MSG
146800010105     C                   LEAVESR
146900010105    2C                   ENDIF
147000010105     C*
147100010105     C                   MOVE      R2TERM        #USA
147200010105     C                   MOVE      #USA          #ISO
147300010105     C                   MOVE      #ISO          #TRISO
147400010105     C*
147500010105    1C                   ELSE
147600010105     C*
147700010105     C                   MOVE      *ZEROS        #TRISO
147800010105     C*
147900010105    1C                   ENDIF
148000010129    *** DEMOGRAPHICS CHECK
148100010104    1C                   SELECT
148200010129    1C                   WHEN      RCNAM1 = *BLANKS
148300010104     C                   MOVEL(P)  MSG(16)       R2MSG
148400010129    1C                   WHEN      RADDR1 = *BLANKS
148500090520     C                   If        RSPHFL  <>    'F'
148600010104     C                   MOVEL(P)  MSG(15)       R2MSG
148700090520     C                   End
148800010129    1C                   WHEN      RCITY = *BLANKS
148900090520     C                   If        RSPHFL  <>    'F'
149000010104     C                   MOVEL(P)  MSG(14)       R2MSG
149100090520     C                   End
149200010129    1C                   WHEN      RSTATE = *BLANKS
149300090520     C                   If        RSPHFL  <>    'F'
149400010104     C                   MOVEL(P)  MSG(13)       R2MSG
149500090520     C                   End
149600010129    1C                   WHEN      AZIP5 = 0
149700090520     C                   If        RSPHFL  <>    'F'
149800010104     C                   MOVEL(P)  MSG(12)       R2MSG
149900090520     C                   End
150000010129    1C                   WHEN      RPHONE = 0
150100010104     C                   MOVEL(P)  MSG(11)       R2MSG
150200010129    1C                   WHEN      RONTAC = *BLANKS
150300010104     C                   MOVEL(P)  MSG(10)       R2MSG
150400010104    1C                   ENDSL
150500130918
150600131010      * except for Onsite dental (trusts 25 - 75) - validate zip/state
150700180109     C********           if        i_trst < 25 or i_trst > 75
150800180109      *    Replace above logic w/ TSCODE check
150900200115     C                   If        TSCODE <> 'O N' and TSCODE <> 'O M' and
151000200115     C                             TSCODE <> 'O D'
151100131010
151200130918      * if zip entered - validate against USPS zip file
151300130918     C                   if        azip5 <> 0 and #valid_zip(azip5:rstate)
151400130918     C                             = 'N'
151500130918     C                   eval      r2msg = msg(45)
151600130918     C                   endif
151700130918
151800170124      ** sbt - add CT **
151900140114      * For MD and PA - county is required
152000130918     C                   if        r2msg = *blanks and azip5 <> *zeros and
152100170124     C                             (rstate = 'MD' or rstate = 'PA' or
152200170124     C                             rstate = 'CT')
152300130918     C                   exsr      edit_county
152400170124     C                   elseif    rstate <> 'MD' and rstate <> 'PA' and
152500170124     C                              rstate <> 'CT'
152600131015     C                   clear                   rconty
152700130918     C                   endif
152800130918
152900131010     C                   endif
153000131010
153100010104    1C                   IF        R2MSG <> *BLANKS
153200010104     C                   LEAVESR
153300010104    1C                   ENDIF
153400010104    ***
153500010104     C                   ENDSR
153600010103   S***S
153700010104     C     $VALIDN25     BEGSR
153800010104    ***
153900010104    *** ENROLL DATE
154000090521
154100090521      *
154200010104    1C                   IF        R2ENRL = 0
154300010104     C                   MOVEL(P)  MSG(7)        R2MSG
154400010104     C                   LEAVESR
154500010104    1C                   ENDIF
154600010104     C*
154700010104     C     *USA          TEST(DE)                R2ENRL
154800010104    1C                   IF        %ERROR
154900010104     C                   MOVEL(P)  MSG(7)        R2MSG
155000010104     C                   LEAVESR
155100010104    1C                   ENDIF
155200010104     C*
155300010104     C                   MOVE      R2ENRL        #USA
155400010104     C                   MOVE      #USA          #ISO
155500010104     C                   MOVE      #ISO          #ENRISO
155600090520    *** Renewal Period
155700090520     C                   If        RRNEWPD   =   *Zeros   Or
155800090520     C                             RRNEWPD   >   12
155900090520s213 C                   Movel(P)  MSG(39)       R2MSG
156000090520s213 C                   Leavesr
156100090520     C                   End
156200090520      *
156300090520    *** Account Administrator Code
156400090520     C                   If        R2AACOD   =   *Blanks
156500090520s213 C                   Movel(P)  MSG(40)       R2MSG
156600090520s213 C                   Leavesr
156700090520     C                   End
156800090520      *
156900021127    *** CFS BEGIN DATE
157000021206     C                   IF        RCFSED <> *ZEROS
157100021206     C     *USA          TEST(DE)                RCFSED
157200021127    1C                   IF        %ERROR
157300021127     C                   MOVEL(P)  MSG(25)       R2MSG
157400021127     C                   LEAVESR
157500021127    1C                   ENDIF
157600021127     C*
157700021206     C                   MOVE      RCFSED        #USA
157800021127     C                   MOVE      #USA          #ISO
157900021127     C                   MOVE      #ISO          #CFSISO
158000021127    1C                   ELSE
158100021127     C                   MOVE      *ZEROS        #CFSISO
158200021127    1C                   ENDIF
158300030214    *** GBS BEGIN GA DATE
158400030214     C                   IF        R2GBSBGA <> *ZEROS
158500030214     C     *USA          TEST(DE)                R2GBSBGA
158600030214    1C                   IF        %ERROR
158700030214     C                   MOVEL(P)  MSG(26)       R2MSG
158800030214     C                   LEAVESR
158900030214    1C                   ENDIF
159000030214     C*
159100030214     C                   MOVE      R2GBSBGA      #USA
159200030214     C                   MOVE      #USA          #ISO
159300030214     C                   MOVE      #ISO          #BGAISO
159400030214    1C                   ELSE
159500030214     C                   MOVE      *ZEROS        #BGAISO
159600030214    1C                   ENDIF
159700021127    ***
159800010104    1C                   SELECT
159900090828     C************       When      R2MSG  <> Msg(41)       And
160000090828     C************                 TSCODE  = 'O N'
160100090828     C************       If        A2TAX_ID# = *Zeros
160200090828     C************       Eval      R2MSG   = Msg(41)
160300090828     C************       End
160400090521
160500010129    1C                   WHEN      RCSTFL <> 'F' AND RCSTFL <> 'S' AND
160600010104     C                             RCSTFL <> 'N'
160700010104     C                   MOVEL(P)  MSG(9)        R2MSG
160800040929
160900040929    1C                   WHEN      (rcobsrv <> 'L' AND rcobsrv <> 'B' AND
161000040929    1C                             rcobsrv <> 'F' AND rcobsrv <> ' ') or
161100040929    1C                             (RCSTFL <> 'N' and rcobsrv = ' ') or
161200040929    1C                             (RCSTFL = 'N' and rcobsrv <> ' ')
161300040929     C                   MOVEL(P)  MSG(29)       R2MSG
161400050610
161500050622     C                   When      RCOBSRV =  'F'         And
161600050622     C                             RNOFEE  <> 'Y'         And
161700050622     C                             RCOBADM =  *Zero
161800050629     C                   If        ATRMDT  >  Today       Or
161900050629     C                             ATRMDT  =  *Zero
162000050629      *---
162100050629      * Confirm zero admin fee only if one of the Cobra values have changed.
162200050629      *---
162300050629     C                   If        RCSTFL  <> FCSTFL      Or
162400050629     C                             RCOBSRV <> ACOBSRV     Or
162500050629     C                             RCOBADM <> COBADM
162600050610     C                   Eval      R2MSG   =  MSG(30)
162700050627     C                   Eval      *In55   =  *On
162800050629     C                   End
162900050629     C                   End
163000040929
163100050701     C                   When      RCOBSRV <> 'F'
163200050610     C                   If        RCOBADM <> *Zeros
163300050610     C                   Eval      R2MSG   = MSG(31)
163400050627     C                   Eval      *In54   = *On
163500050610     C                   End
163600050610
163700050701     C                   When      RCSTFL  =  'N'
163800050701     C                   If        RCOBADM <> *Zeros
163900050701     C                   Eval      R2MSG   =  MSG(31)
164000050701     C                   Eval      *In54   =  *On
164100050701     C                   End
164200050701
164300050622     C                   When      R2MSG  <> Msg(32)       And
164400050622     C                             RCOBADM > 2.50
164500050627     C                   Eval      *In54   = *On
164600050627     C                   Eval      *In55   = *On
164700050622     C                   Eval      R2MSG   = Msg(32)
164800050622
164900050705     C                   When      R2MSG  <> Msg(32)       And
165000050705     C                             RCOBADM < -2.50
165100050705     C                   Eval      *In54   = *On
165200050705     C                   Eval      *In55   = *On
165300050705     C                   Eval      R2MSG   = Msg(32)
165400050705
165500010129    1C                   WHEN      RRNEWPD = 0
165600010104     C                   MOVEL(P)  MSG(17)       R2MSG
165700010129    1C                   WHEN      RMANCD = *BLANKS
165800010104     C                   MOVEL(P)  MSG(18)       R2MSG
165900120809    1C                   When      RREREP = *BLANKS
166000120809     C                   Movel(P)  MSG(18)       R2MSG
166100061011     C                   When      RPAR   <> 'Y' And
166200061011     C                             RPAR   <> 'N'
166300061011     C                   Movel(P)  MSG(36)       R2MSG
166400061011     C                   Eval      *In56   = *On
166500010129    1C                   WHEN      R2AACOD = *BLANKS
166600010104     C                   MOVEL(P)  MSG(19)       R2MSG
166700060501    1C******             WHEN      RIFPCT > 100
166800060501     C******             MOVEL(P)  MSG(20)       R2MSG
166900060501    1C                   ENDSL
167000060501      *
167100050622      *---
167200050622      * If msg is just a warning, treat as blank second time around
167300050622      *---
167400050622     C                   If        R2MSG =  Msg(32)
167500090521     C                                                   Or
167600090521     C                             R2MSG =  Msg(41)
167700050622     C                   Add       1             WarnCtr           1 0
167800050622     C                   End
167900050622      *
168000090521     C                   If        R2MSG    <>   *Blanks      And
168100090521     C                             WarnCtr  >    1            And
168200090521     C                             (R2MSG   =    Msg(32)   Or
168300090521     C                             R2MSG    =    Msg(41))
168400090521     C                   Eval      R2MSG    =    *Blanks
168500050627     C                   Eval      *In54    =    *Off
168600050627     C                   Eval      *In55    =    *Off
168700050622     C                   Z-add     *Zeros        WarnCtr
168800090521     C                   End
168900050622      *
169000050622    1C                   IF        R2MSG <> *BLANKS
169100050622     C                   LEAVESR
169200050622    1C                   ENDIF
169300061011     C*
169400061011     C                   If        RPAR  <> 'Y' And
169500061011    1C                             RPAR  <> 'N'
169600061011     C                   MOVEL(P)  MSG(36)       R2MSG
169700061011     C                   Eval      *In56   = *On
169800061011     C                   LEAVESR
169900061011    1C                   ENDIF
170000010129     C*
170100060501      ** %-of-contribution and view-volume-on-web flag
170200060501     C                   If        *In55   =     *Off
170300060501     C                   Select
170400060501    1C                   When      RIFPCT > 100
170500060501     C                   Movel(P)  MSG(20)       R2MSG
170600060501     C                   Eval      *In50   = *On
170700060501     C                   When      RSTPCT > 100
170800060501     C                   Movel(P)  Msg(34)       R2MSG
170900060501     C                   Eval      *In51   = *On
171000060501     C                   When      RLTPCT > 100
171100060501     C                   Movel(P)  Msg(33)       R2MSG
171200060501     C                   Eval      *In52   = *On
171300060501     C                   When      RVOWFL <> 'Y'        And
171400060501     C                             RVOWFL <> 'N'
171500060501     C                   Movel(P)  Msg(35)       R2MSG
171600060501     C                   Eval      *In53   = *On
171700060501     C                   EndSl
171800060501     C                   End
171900060501     C*
172000040824s824***Valid Special Handling Flag
172100040824s824 C*
172200040901s824 C                   If        RSPHFL <> 'Y' and
172300040901s824 C                             RSPHFL <> 'N' and
172400090213s213 C                             RSPHFL <> 'P' and                            Private Pay
172500090213s213 C                             RSPHFL <> 'D' and                            Direct Pay
172600090213s213 C                             RSPHFL <> 'F' and                            Facility Pay
172700040901s824 C                             RSPHFL <> *Blanks
172800040901s824 C                   MOVEL(P)  MSG(28)       R2MSG
172900040901s824 C                   LEAVESR
173000040901s824 C                   ENDIF
173100040824s824 C*
173200090213s224***Valid CFS 834 Flag
173300090213s213 C*
173400090213s213 C                   If        RCFS834 <> 'Y' and
173500090213s213 C                             RCFS834 <> *Blanks
173600090213s213 C                   MOVEL(P)  MSG(37)       R2MSG
173700090213s213 C                   LEAVESR
173800090213s213 C                   ENDIF
173900090213s213 C*
174000090408    ***Valid CFS 834 Date Required if 834 flag is Y.
174100090408     C*
174200090408     C                   If        RCFS834 = 'Y' and
174300090408     C                             RC8DT   = *Zeros
174400090408     C                   MOVEL(P)  MSG(38)       R2MSG
174500090408     C                   LEAVESR
174600090408     C                   ENDIF
174700090408     C                   IF        RC8DT   <> *ZEROS    AND
174800090408     C                             RCFS834 =  *Blanks
174900090408     C     *USA          TEST(DE)                AMC8DT
175000090408    1C                   IF        %ERROR
175100090408     C                   MOVEL(P)  MSG(38)       R2MSG
175200090408     C                   LEAVESR
175300090408    1C                   ENDIF
175400090408    1C                   End
175500090408     C*
175600090731s224***Medicaid is a required field if Onsite Dental Account
175700090731s213 C*
175800200115     C                   If        TSCODE = 'O N' or TSCODE = 'O M' or
175900200115     C                             TSCODE = 'O D'
176000090909     C     BENKEY        Chain     ACCMSP
176100090909     C                   If        AMMAID    = *Blanks
176200090909s213 C**************     If        @Medicaid = *Blanks
176300090731s213 C                   Movel(P)  MSG(43)       R2MSG
176400090731s213 C                   LeaveSr
176500090731s213 C                   End
176600090731s213 C                   End
176700090731s213 C*
176800010129    ***VALID SALESMAN CODE
176900120809      * Salesman code is now called Servicing Broker
177000010129     C*
177100010104     C     RMANCD        CHAIN(N)  SMANR
177200010104    1C                   IF        NOT %FOUND(SMAN)
177300010104     C                   MOVEL(P)  MSG(18)       R2MSG
177400010104     C                   LEAVESR
177500010104    1C                   ENDIF
177600120809    ***Valid Renewing Rep
177700120809     C*
177800120809     C     RREREP        CHAIN(N)  SMANR
177900120809    1C                   IF        NOT %FOUND(SMAN)
178000120809     C                   MOVEL(P)  MSG(18)       R2MSG
178100120809     C                   LEAVESR
178200120809    1C                   ENDIF
178300010129     C*
178400010129    ***VALID ACCOUNT ADMIN CODE
178500010129     C*
178600010104     C     AAKEY         CHAIN(N)  AACODR
178700010104    1C                   IF        NOT %FOUND(AACODE)
178800010104     C                   MOVEL(P)  MSG(19)       R2MSG
178900010104     C                   LEAVESR
179000010104    1C                   ENDIF
179100010104    ***
179200120515     C                   ENDSR
179300010104   S***S
179400010104     C     $CHANGES      BEGSR
179500010104    ***
179600010104     C                   MOVE      'N'           @@CHGS
179700010129    *** ACCOUNT ADD
179800010104    1C                   IF        @@A = 'A'
179900010104     C                   EXSR      $COMNHIST
180000010104     C                   MOVE      'LAA'         TRCODE
180100110805     c                   move      #enriso       covtdt
180200010104     C                   WRITE     HISTR
180300110805     c                   clear                   covtdt
180400160616
180500160617      * 6/16/16 - stop using last acct # in submst
180600160616     C***                Z-ADD     I_ACCT        LSTAC#
180700160616     C***                UPDATE    SUBMSR
180800160617      * 6/17/16 - release submst rec instead
180900160617     C                   unlock    SUBMST
181000160616
181100010104     C                   LEAVESR
181200010104    1C                   ENDIF
181300010129    *** ACCOUNT NAME CHANGE
181400010104    1C                   IF        RCNAM1 <> ACNAM1
181500010104     C                   EXSR      $COMNHIST
181600010104     C                   MOVE      'L01'         TRCODE
181700010108     C*
181800010108     C                   MOVE      *BLANKS       @10              10
181900010108     C                   MOVE      ACNAM1        @10
182000010108    2C                   IF        @10 <> *BLANKS
182100010108     C                   MOVEL(P)  ACNAM1        @29              29
182200010108     C     @29           CAT       '*':0         CK#NOT
182300010108    2C                   ELSE
182400010104     C                   MOVEL     ACNAM1        CK#NOT
182500010108    2C                   ENDIF
182600010108     C*
182700010108     C                   MOVE      *BLANKS       @10              10
182800010108     C                   MOVE      RCNAM1        @10
182900010108    2C                   IF        @10 <> *BLANKS
183000010108     C                   MOVEL(P)  RCNAM1        @29              29
183100010108     C     @29           CAT       '*':0         NOTE2
183200010108    2C                   ELSE
183300010108     C                   MOVEL     RCNAM1        NOTE2
183400010108    2C                   ENDIF
183500010108     C*
183600010104     C                   MOVE      'Y'           @@CHGS
183700010104     C                   WRITE     HISTR
183800010104     C                   MOVEL(P)  RCNAM1        ACNAM1
183900010104    1C                   ENDIF
184000010129    *** ACCOUNT NAME#2 CHANGE
184100010104    1C                   IF        RCNAM2 <> ACNAM2
184200010104     C                   EXSR      $COMNHIST
184300010104     C                   MOVE      'L02'         TRCODE
184400010108     C*
184500010108     C                   MOVE      *BLANKS       @10              10
184600010108     C                   MOVE      ACNAM2        @10
184700010108    2C                   IF        @10 <> *BLANKS
184800010108     C                   MOVEL(P)  ACNAM2        @29              29
184900010108     C     @29           CAT       '*':0         CK#NOT
185000010108    2C                   ELSE
185100010108     C                   MOVEL     ACNAM2        CK#NOT
185200010108    2C                   ENDIF
185300010108     C*
185400010108     C                   MOVE      *BLANKS       @10              10
185500010108     C                   MOVE      RCNAM2        @10
185600010108    2C                   IF        @10 <> *BLANKS
185700010108     C                   MOVEL(P)  RCNAM2        @29              29
185800010108     C     @29           CAT       '*':0         NOTE2
185900010108    2C                   ELSE
186000010108     C                   MOVEL     RCNAM2        NOTE2
186100010108    2C                   ENDIF
186200010108     C*
186300010104     C                   MOVE      'Y'           @@CHGS
186400010104     C                   WRITE     HISTR
186500010104     C                   MOVEL(P)  RCNAM2        ACNAM2
186600010104    1C                   ENDIF
186700010129    *** ADDRESS LINE 1 CHANGE
186800010104    1C                   IF        RADDR1 <> AADDR1
186900010104     C                   EXSR      $COMNHIST
187000010104     C                   MOVE      'L03'         TRCODE
187100010104     C                   MOVEL     AADDR1        CK#NOT
187200010104     C                   MOVEL     RADDR1        NOTE2
187300010104     C                   MOVE      'Y'           @@CHGS
187400010104     C                   WRITE     HISTR
187500010104     C                   MOVEL(P)  RADDR1        AADDR1
187600010104    1C                   ENDIF
187700010129    *** ADDRESS LINE 2 CHANGE
187800010104    1C                   IF        RADDR2 <> AADDR2
187900010104     C                   EXSR      $COMNHIST
188000010104     C                   MOVE      'L04'         TRCODE
188100010104     C                   MOVEL     AADDR2        CK#NOT
188200010104     C                   MOVEL     RADDR2        NOTE2
188300010104     C                   MOVE      'Y'           @@CHGS
188400010104     C                   WRITE     HISTR
188500010104     C                   MOVEL(P)  RADDR2        AADDR2
188600010104    1C                   ENDIF
188700010129    *** CITY CHANGE
188800010104    1C                   IF        RCITY <> ACITY
188900010104     C                   EXSR      $COMNHIST
189000010104     C                   MOVE      'L05'         TRCODE
189100010104     C                   MOVEL     ACITY         CK#NOT
189200010104     C                   MOVEL     RCITY         NOTE2
189300010104     C                   MOVE      'Y'           @@CHGS
189400010104     C                   WRITE     HISTR
189500010104     C                   MOVEL(P)  RCITY         ACITY
189600010104    1C                   ENDIF
189700010129    *** STATE CHANGE
189800010104    1C                   IF        RSTATE <> ASTATE
189900010104     C                   EXSR      $COMNHIST
190000010104     C                   MOVE      'L06'         TRCODE
190100010104     C                   MOVEL     ASTATE        CK#NOT
190200010104     C                   MOVEL     RSTATE        NOTE2
190300010104     C                   MOVE      'Y'           @@CHGS
190400010104     C                   WRITE     HISTR
190500010104     C                   MOVEL(P)  RSTATE        ASTATE
190600010104    1C                   ENDIF
190700010129    *** ZIP CHANGE
190800010104    1C                   IF        #ZIP <> AZIP
190900010104     C                   EXSR      $COMNHIST
191000010104     C                   MOVE      'L07'         TRCODE
191100010104     C                   Z-ADD     AZIP          #9
191200010104     C                   MOVEL     #9            CK#NOT
191300010104     C                   MOVEL     #ZIP          NOTE2
191400010104     C                   MOVE      'Y'           @@CHGS
191500010104     C                   WRITE     HISTR
191600010104     C                   Z-ADD     #ZIP          AZIP
191700010104    1C                   ENDIF
191800010129    *** AREA + PHONE CHANGE
191900010104    1C                   IF        AAREA <> RAREA OR APHONE <> RPHONE
192000010104     C                   EXSR      $COMNHIST
192100010104     C                   MOVE      'L08'         TRCODE
192200010104     C                   MOVE      *ALL'0'       @FAXPHN
192300010104     C                   MOVE      AAREA         #3
192400010104     C                   MOVE      APHONE        #7
192500010104     C                   MOVEL     @FAXPHN       CK#NOT
192600010104     C                   MOVEL     @RPHONE       NOTE2
192700010104     C                   MOVE      'Y'           @@CHGS
192800010104     C                   WRITE     HISTR
192900010104     C                   Z-ADD     RAREA         AAREA
193000010104     C                   Z-ADD     RPHONE        APHONE
193100010104    1C                   ENDIF
193200010129    *** FAX AREA + PHONE CHANGE
193300010104    1C                   IF        FAXARE <> RAXARE OR FAX# <> RAX#
193400010104     C                   EXSR      $COMNHIST
193500010104     C                   MOVE      *ALL'0'       @FAXPHN
193600010104     C                   MOVE      'L09'         TRCODE
193700010104     C                   MOVE      FAXARE        #3
193800010104     C                   MOVE      FAX#          #7
193900010104     C                   MOVEL     @FAXPHN       CK#NOT
194000010104     C                   MOVEL     @RFAX         NOTE2
194100010104     C                   MOVE      'Y'           @@CHGS
194200010104     C                   WRITE     HISTR
194300010104     C                   Z-ADD     RAXARE        FAXARE
194400010104     C                   Z-ADD     RAX#          FAX#
194500010104    1C                   ENDIF
194600010129    *** CONTACT NAME CHANGE
194700010104    1C                   IF        RONTAC <> CONTAC
194800010104     C                   EXSR      $COMNHIST
194900010104     C                   MOVE      'L10'         TRCODE
195000010104     C                   MOVEL     CONTAC        CK#NOT
195100010104     C                   MOVEL     RONTAC        NOTE2
195200010104     C                   MOVE      'Y'           @@CHGS
195300010104     C                   WRITE     HISTR
195400010104     C                   MOVEL(P)  RONTAC        CONTAC
195500010104    1C                   ENDIF
195600010129    *** EXECUTIVE CONTACT NAME CHANGE
195700010104    1C                   IF        RCNTAC <> ECNTAC
195800010104     C                   EXSR      $COMNHIST
195900010104     C                   MOVE      'L11'         TRCODE
196000010104     C                   MOVEL     ECNTAC        CK#NOT
196100010104     C                   MOVEL     RCNTAC        NOTE2
196200010104     C                   MOVE      'Y'           @@CHGS
196300010104     C                   WRITE     HISTR
196400010104     C                   MOVEL(P)  RCNTAC        ECNTAC
196500010104    1C                   ENDIF
196600010129    *** TOTAL EMPLOYEES CHANGE
196700010104    1C                   IF        ROTEMP <> TOTEMP
196800010104     C                   EXSR      $COMNHIST
196900010104     C                   MOVE      'L12'         TRCODE
197000010104     C                   MOVEL     TOTEMP        CK#NOT
197100010104     C                   MOVEL     ROTEMP        NOTE2
197200010104     C                   MOVE      'Y'           @@CHGS
197300010104     C                   WRITE     HISTR
197400010104     C                   Z-ADD     ROTEMP        TOTEMP
197500010104    1C                   ENDIF
197600010129    *** NUMBER OF EMPLOYEES PARTICIPATING CHANGE
197700010104    1C                   IF        ROEMPL <> NOEMPL
197800010104     C                   EXSR      $COMNHIST
197900010104     C                   MOVE      'L13'         TRCODE
198000010104     C                   Z-ADD     NOEMPL        #7
198100010104     C                   MOVEL     #7            CK#NOT
198200010104     C                   MOVEL     ROEMPL        NOTE2
198300010104     C                   MOVE      'Y'           @@CHGS
198400010104     C                   WRITE     HISTR
198500010104     C                   Z-ADD     ROEMPL        NOEMPL
198600010104    1C                   ENDIF
198700010129    *** COBRA CITY/STATE/NONE FLAG CHANGE
198800010104    1C                   IF        RCSTFL <> FCSTFL
198900010104     C                   EXSR      $COMNHIST
199000010104     C                   MOVE      'L14'         TRCODE
199100010104     C                   MOVEL     FCSTFL        CK#NOT
199200010104     C                   MOVEL     RCSTFL        NOTE2
199300010104     C                   MOVE      'Y'           @@CHGS
199400010104     C                   WRITE     HISTR
199500010104     C                   MOVEL(P)  RCSTFL        FCSTFL
199600010104    1C                   ENDIF
199700040929
199800040929    *** COBRA CITY/STATE/NONE FLAG CHANGE
199900040929     C                   IF        rcobsrv <> acobsrv
200000040929     C                   EXSR      $COMNHIST
200100040929     C                   MOVE      'L34'         TRCODE
200200040929     C                   MOVEL     acobsrv       CK#NOT
200300040929     C                   MOVEL     rcobsrv       NOTE2
200400040929     C                   MOVE      'Y'           @@CHGS
200500040929     C                   WRITE     HISTR
200600040929     C                   MOVEL(P)  rcobsrv       acobsrv
200700040929     C                   ENDIF
200800050620
200900050620    *** COBRA ADMIN FEE CHANGE
201000050620     C                   IF        RCOBADM <>  COBADM
201100050620     C                   EXSR      $COMNHIST
201200050620     C                   MOVE      'L15'         TRCODE
201300050701     C                   Eval      CK#NOT = %Editc(COBADM:'J')
201400050620     C                   Z-Add     RCOBADM       NCOBADM           5 2
201500050701     C                   Eval      NOTE2  = %Editc(NCOBADM:'J')
201600050620     C                   MOVE      'Y'           @@CHGS
201700050620     C                   WRITE     HISTR
201800050620     C                   MOVEL(P)  RCOBADM       COBADM
201900050620     C                   ENDIF
202000040929
202100040824s824*** Special Handling Flag Change
202200040901s824 C                   IF        RSPHFL <> ASPHFL
202300040901s824 C                   EXSR      $COMNHIST
202400040901s824 C                   MOVE      'L33'         TRCODE
202500100514s824 C                   MOVEL     RSPHFL        NOTE2
202600100514s824 C                   MOVEL     ASPHFL        CK#NOT
202700040901s824 C                   MOVE      'Y'           @@CHGS
202800040901s824 C                   WRITE     HISTR
202900040901s824 C                   MOVEL(P)  RSPHFL        ASPHFL
203000040901s824 C                   ENDIF
203100010129    *** ENROLLMENT DATE CHANGE
203200010104    1C                   IF        #ENRISO <> ENROLL
203300010104     C                   EXSR      $COMNHIST
203400010104     C                   MOVE      'L17'         TRCODE
203500010104     C                   MOVEL     ENROLL        CK#NOT
203600010104     C                   MOVEL     #ENRISO       NOTE2
203700010104     C                   MOVE      'Y'           @@CHGS
203800010104     C                   WRITE     HISTR
203900010104     C                   Z-ADD     #ENRISO       ENROLL
204000010104    1C                   ENDIF
204100030214    *** CFS ENTITY DATE CHANGE
204200021206    1C                   IF        #CFSISO <> CFSEDI
204300021127     C                   EXSR      $COMNHIST
204400021204     C                   MOVE      'L30'         TRCODE
204500021206     C                   MOVEL     CFSEDI        CK#NOT
204600021127     C                   MOVEL     #CFSISO       NOTE2
204700021127     C                   MOVE      'Y'           @@CHGS
204800021127     C                   WRITE     HISTR
204900021127     C                   IF        #CFSISO <> *ZEROS
205000030427     C                   Z-ADD     #CFSISO       CFSEDT
205100021127    1C                   ELSE
205200030427     C                   Z-ADD     *ZEROS        CFSEDT
205300021127    1C                   ENDIF
205400021127    1C                   ENDIF
205500030214    *** GBS BEGIN GA DATE  CHANGE
205600030225    1C                   IF        #BGAISO <> GBGADI
205700030214     C                   EXSR      $COMNHIST
205800030214     C                   MOVE      'L32'         TRCODE
205900030225     C                   MOVEL     GBGADI        CK#NOT
206000030214     C                   MOVEL     #BGAISO       NOTE2
206100030214     C                   MOVE      'Y'           @@CHGS
206200030214     C                   WRITE     HISTR
206300030225     C                   IF        #BGAISO <> *ZEROS
206400030427     C                   Z-ADD     #BGAISO       GBSGAD
206500030225    1C                   ELSE
206600030427     C                   Z-ADD     *ZEROS        GBSGAD
206700030225    1C                   ENDIF
206800030214    1C                   ENDIF
206900021127    *** AACODE CHANGE
207000010207    1C                   IF        R2AACOD <> ACAACOD
207100130501     C                   EXSR      $COMNHIST
207200130501     C                   MOVE      'LAR'         TRCODE
207300130501     C                   MOVEL     ACAACOD       CK#NOT
207400130501     C                   MOVEL     R2AACOD       NOTE2
207500010104     C                   MOVE      'Y'           @@CHGS
207600130501     C                   WRITE     HISTR
207700130501     C                   MOVE      R2AACOD       ACAACOD
207800010104    1C                   ENDIF
207900010207    *** RENEWAL PERIOD CHANGE
208000010207    1C                   IF        RRNEWPD <> RNEWPD
208100010207     C                   EXSR      $COMNHIST
208200010207     C                   MOVE      'L18'         TRCODE
208300010207     C                   MOVEL     RNEWPD        CK#NOT
208400010207     C                   MOVEL     RRNEWPD       NOTE2
208500010207     C                   MOVE      'Y'           @@CHGS
208600010207     C                   WRITE     HISTR
208700010207     C                   Z-ADD     RRNEWPD       RNEWPD
208800010207    1C                   ENDIF
208900010129    *** PRE-EXISTING?
209000010104    1C                   IF        RREEX  <> PREEX
209100010104     C                   EXSR      $COMNHIST
209200010104     C                   MOVE      'L19'         TRCODE
209300010104     C                   Z-ADD     PREEX         #3
209400010104     C                   MOVEL     #3            CK#NOT
209500010104     C                   MOVEL     RREEX         NOTE2
209600010104     C                   MOVE      'Y'           @@CHGS
209700010104     C                   WRITE     HISTR
209800010104     C                   Z-ADD     RREEX         PREEX
209900010104    1C                   ENDIF
210000070614      *
210100070712     C                   If        HisTrCd   =   'L35'  or
210200070712     C                             HisTrCd   =   'L36'  or
210300070712     C                             HisTrCd   =   'L38'  or
210400070712     C                             HisTrCd   =   'L60'  or
210500070712     C                             HisTrCd   =   'L61'  or
210600070712     C                             HisTrCd   =   'L62'  or
210700070712     C                             HisTrCd   =   'L63'  or
210800070712     C                             HisTrCd   =   'L64'
210900070614     C     ABBEDT        MULT      10000.0001    ABBEDT
211000070621     C                   Move      ABBEDT        ABBEDTA           8
211100070621     C                   Move      ABENDT        ABENDTA           8
211200070614     C     ABRODT        MULT      10000.0001    ABRODT
211300070614     C                   Move      ABRODT        ABRODTA           8
211400070621     C                   Movel     ABROPE        ABROPEA           3
211500050413    *** Benegap Date Range Added
211600050413    1C                   IF        HisTrCd   =   'L35'
211700050413     C                   EXSR      $COMNHIST
211800050413     C                   MOVE      'L35'         TRCODE
211900050413     C                   Eval      CK#NOT    =   BenAdd
212000070614     C                   Eval      NOTE2     =   %Trim('Added ' + ABBEDTA +
212100070614     C                                                 ':' + ABENDTA)
212200050413     C                   MOVE      'Y'           @@CHGS
212300050413     C                   WRITE     HISTR
212400050413    1C                   ENDIF
212500070614    *** Benegap Date Range Changed
212600070612    1C                   IF        HisTrCd   =   'L36'
212700070612     C                   EXSR      $COMNHIST
212800070612     C                   MOVE      'L36'         TRCODE
212900070614     C                   Eval      CK#NOT    =   %Trim('BENEGAP DATE CHANGE')
213000070614     C                   Eval      NOTE2     =   %Trim('To ' + ABBEDTA +
213100070614     C                                                 ':' + ABENDTA)
213200070612     C                   MOVE      'Y'           @@CHGS
213300070612     C                   WRITE     HISTR
213400070612    1C                   ENDIF
213500070612    *** Benegap Run Out Period Days Changed
213600070612    1C                   IF        HisTrCd   =   'L38'
213700070612     C                   EXSR      $COMNHIST
213800070612     C                   MOVE      'L38'         TRCODE
213900070614     C                   Eval      CK#NOT    =   %Trim('Range ' +
214000070614     C                                           ABBEDTA + '-'   +
214100070614     C                                           ABENDTA)
214200070614     C                   Eval      NOTE2     =   %Trim('Changed to: ' +
214300070614     C                                           ABROPEA)
214400070612     C                   MOVE      'Y'           @@CHGS
214500070612     C                   WRITE     HISTR
214600070612    1C                   ENDIF
214700070614    *** Benegap Run Out Date Changed
214800070614    1C                   IF        HisTrCd   =   'L60'
214900070614     C                   EXSR      $COMNHIST
215000070614     C                   MOVE      'L60'         TRCODE
215100070614     C                   Eval      CK#NOT    =   %Trim('Range ' +
215200070614     C                                           ABBEDTA + '-'   +
215300070614     C                                           ABENDTA)
215400070614     C                   Eval      NOTE2     =   %Trim('To: ' +
215500070614     C                                           ABRODTA)
215600070614     C                   MOVE      'Y'           @@CHGS
215700070614     C                   WRITE     HISTR
215800070614    1C                   ENDIF
215900070614    *** Benegap Date & Run Out Date & Run Out Days Changed
216000070614    1C                   IF        HisTrCd   =   'L64'
216100070614     C                   EXSR      $COMNHIST
216200070614     C                   MOVE      'L64'         TRCODE
216300070614     C                   Eval      CK#NOT    =   %Trim('Range ' +
216400070614     C                                           ABBEDTA + '-'   +
216500070614     C                                           ABENDTA)
216600070614     C                   Eval      NOTE2     =   %Trim('To: ' +
216700070614     C                                           ABRODTA + '/' + ABROPEA)
216800070614     C                   MOVE      'Y'           @@CHGS
216900070614     C                   WRITE     HISTR
217000070614    1C                   ENDIF
217100070614    *** Benegap Run Out Date & Run Out Days Changed
217200070614    1C                   IF        HisTrCd   =   'L63'
217300070614     C                   EXSR      $COMNHIST
217400070614     C                   MOVE      'L63'         TRCODE
217500070614     C                   Eval      CK#NOT    =   %Trim('Range ' +
217600070614     C                                           ABBEDTA + '-'   +
217700070614     C                                           ABENDTA)
217800070614     C                   Eval      NOTE2     =   %Trim('To: ' +
217900070614     C                                           ABRODTA + '/' + ABROPEA)
218000070614     C                   MOVE      'Y'           @@CHGS
218100070614     C                   WRITE     HISTR
218200070614    1C                   ENDIF
218300070614    *** Benegap Date & Run Out Date
218400070614    1C                   IF        HisTrCd   =   'L62'
218500070614     C                   EXSR      $COMNHIST
218600070614     C                   MOVE      'L62'         TRCODE
218700070614     C                   Eval      CK#NOT    =   %Trim('Range ' +
218800070614     C                                           ABBEDTA + '-'   +
218900070614     C                                           ABENDTA)
219000070614     C                   Eval      NOTE2     =   %Trim('To: ' +
219100070614     C                                           ABRODTA)
219200070614     C                   MOVE      'Y'           @@CHGS
219300070614     C                   WRITE     HISTR
219400070614    1C                   ENDIF
219500070614    *** Benegap Date & Run Out Days
219600070614    1C                   IF        HisTrCd   =   'L61'
219700070614     C                   EXSR      $COMNHIST
219800070614     C                   MOVE      'L61'         TRCODE
219900070614     C                   Eval      CK#NOT    =   %Trim('Range ' +
220000070614     C                                           ABBEDTA + '-'   +
220100070614     C                                           ABENDTA)
220200070614     C                   Eval      NOTE2     =   %Trim('To: ' +
220300070614     C                                           ABROPEA)
220400070614     C                   MOVE      'Y'           @@CHGS
220500070614     C                   WRITE     HISTR
220600070614    1C                   ENDIF
220700070621     C                   End
220800061207    *** OLE Code Date Range Added
220900061207    1C***                IF        HisTrCd   =   'L45'
221000061207     C***                EXSR      $COMNHIST
221100061207     C***                MOVE      'L45'         TRCODE
221200061207     C***                Eval      CK#NOT    =   OEAdd
221300061207     C***                Move      AOBEDT        OEBD              8
221400061207     C***                If        AOENDT    =   *Zeros
221500061207     C***                Eval      OEED      =   'Active  '
221600061207     C***                Else
221700061207     C***                Move      AOENDT        OEED              8
221800061207     C***                End
221900061207     C***                Eval      NOTE2     =   %Trim ('Fr:' + OEBD +
222000061207     C***                                              '/To:' + OEED +
222100061207     C***                                              ' '   + AOCODE)
222200061207     C***                MOVE      'Y'           @@CHGS
222300061207     C***                WRITE     HISTR
222400061207    1C***                ENDIF
222500061129    *** OE Code Date Range Changed
222600061207    1C***                IF        HisTrCd   =   'L46'
222700061207     C***                EXSR      $COMNHIST
222800061207     C***                MOVE      'L46'         TRCODE
222900061207     C***                Eval      CK#NOT    =   OEChg
223000061207     C***                Move      AOENDT        OEED
223100061207     C***                If        AOENDT    =   *Zeros
223200061207     C***                Eval      OEED      =   'Active  '
223300061207     C***                Else
223400061207     C***                Move      AOENDT        OEED              8
223500061207     C***                End
223600061207     C***                Eval      NOTE2     =   %trim('Change: ' + 'To:' +
223700061207     C***                                        OEED + ' ' + AOCODE)
223800061207     C***                MOVE      'Y'           @@CHGS
223900061207     C***                WRITE     HISTR
224000061207    1C***                ENDIF
224100061207    ****WAITING PERIOD 1
224200010104    1C                   IF        RAIT1  <> WAIT1
224300010104     C                   EXSR      $COMNHIST
224400010104     C                   MOVE      'L20'         TRCODE
224500010104     C                   MOVEL     WAIT1         CK#NOT
224600010104     C                   MOVEL     RAIT1         NOTE2
224700010104     C                   MOVE      'Y'           @@CHGS
224800010104     C                   WRITE     HISTR
224900010104     C                   Z-ADD     RAIT1         WAIT1
225000010104    1C                   ENDIF
225100010129    *** WAITING PERIOD 2
225200010104    1C                   IF        RAIT2  <> WAIT2
225300010104     C                   EXSR      $COMNHIST
225400010104     C                   MOVE      'L21'         TRCODE
225500010104     C                   MOVEL     WAIT2         CK#NOT
225600010104     C                   MOVEL     RAIT2         NOTE2
225700010104     C                   MOVE      'Y'           @@CHGS
225800010104     C                   WRITE     HISTR
225900010104     C                   Z-ADD     RAIT2         WAIT2
226000010104    1C                   ENDIF
226100010129    *** WAITING PERIOD 3
226200010104    1C                   IF        RAIT3  <> WAIT3
226300010104     C                   EXSR      $COMNHIST
226400010104     C                   MOVE      'L22'         TRCODE
226500010104     C                   MOVEL     WAIT3         CK#NOT
226600010104     C                   MOVEL     RAIT3         NOTE2
226700010104     C                   MOVE      'Y'           @@CHGS
226800010104     C                   WRITE     HISTR
226900010104     C                   Z-ADD     RAIT3         WAIT3
227000010104    1C                   ENDIF
227100010129     C* AVERAGE AGE FOR ACCOUNT CHANGE
227200010104    1C                   IF        RVGAGE <> AVGAGE
227300010104     C                   EXSR      $COMNHIST
227400010104     C                   MOVE      'L23'         TRCODE
227500010104     C                   MOVEL     AVGAGE        CK#NOT
227600010104     C                   MOVEL     RVGAGE        NOTE2
227700010104     C                   MOVE      'Y'           @@CHGS
227800010104     C                   WRITE     HISTR
227900010104     C                   MOVEL(P)  RVGAGE        AVGAGE
228000010104    1C                   ENDIF
228100010129     C* RENEWAL AVERAGE AGE CHANGE
228200010104    1C                   IF        RRENAVG <> RENAVG
228300010104     C                   EXSR      $COMNHIST
228400010104     C                   MOVE      'L24'         TRCODE
228500010104     C                   MOVEL     RENAVG        CK#NOT
228600010104     C                   MOVEL     RRENAVG       NOTE2
228700010104     C                   MOVE      'Y'           @@CHGS
228800010104     C                   WRITE     HISTR
228900010104     C                   MOVEL(P)  RRENAVG       RENAVG
229000010104    1C                   ENDIF
229100010129     C* SALESMAN CODE CHANGE
229200010104    1C                   IF        RMANCD <> SMANCD
229300010104     C                   EXSR      $COMNHIST
229400010104     C                   MOVE      'L25'         TRCODE
229500010104     C                   MOVEL     SMANCD        CK#NOT
229600010104     C                   MOVEL     RMANCD        NOTE2
229700010104     C                   MOVE      'Y'           @@CHGS
229800010104     C                   WRITE     HISTR
229900010104     C                   MOVEL(P)  RMANCD        SMANCD
230000010104    1C                   ENDIF
230100100729    ***
230200120809     C* Renewing Rep CHANGE
230300120809    1C                   IF        RREREP <> A2CODE1
230400120809     C                   EXSR      $COMNHIST
230500120809     C                   MOVE      'LRR'         TRCODE
230600120809     C                   MOVEL     A2CODE1       CK#NOT
230700120809     C                   MOVEL     RREREP        NOTE2
230800120809     C                   MOVE      'Y'           @@CHGS
230900120809     C                   WRITE     HISTR
231000120809     C                   MOVEL(P)  RREREP        A2CODE1
231100120809    1C                   ENDIF
231200120809    ***
231300100729      * If Special Handling is F, auto load facility address.
231400100729     C                   If        RSPHFL   =    'F'
231500100729     C                   MOVEL(P)  RONTAC        CONTAC
231600100729     C                   Move      'Y'           @@CHGS
231700100729     C                   End
231800061011     C* Parity Change      E
231900061011    1C                   IF        RPAR   <> A2PAR
232000061011     C                   EXSR      $COMNHIST
232100061011     C                   MOVE      'L44'         TRCODE
232200061011     C                   MOVEL     A2PAR         CK#NOT
232300061011     C                   MOVEL     RPAR          NOTE2
232400061011     C                   MOVE      'Y'           @@CHGS
232500061011     C                   WRITE     HISTR
232600061011     C                   MOVEL(P)  RPAR          A2PAR
232700061011    1C                   ENDIF
232800090213     C* CFS 834 Change
232900090904     C                   Move      *Blanks       CFS834flagchg     1
233000090213    1C                   IF        RCFS834  <>   CFS834
233100090904     C                   Eval      CFS834flagchg =  'Y'
233200090213     C                   EXSR      $COMNHIST
233300090213     C                   MOVE      'L65'         TRCODE
233400090327     C                   MOVEL     RCFS834       NOTE2
233500090327     C                   MOVEL     CFS834        CK#NOT
233600090213     C                   MOVE      'Y'           @@CHGS
233700090213     C                   WRITE     HISTR
233800090213     C                   MOVEL(P)  RCFS834       CFS834
233900090213    1C                   ENDIF
234000090408     C* CFS 834 Effective Date Change
234100090513     C     RC8DT         MULT      10000.0001    RC8DT
234200090408    1C                   IF        RC8DT    <>   AMC8DT
234300090408     C                   EXSR      $COMNHIST
234400090408     C                   MOVE      'L93'         TRCODE
234500090513     C     RC8DT         MULT      10000.0001    RC8DT
234600090408     C                   MOVEL     RC8DT         NOTE2
234700090408     C                   MOVEL     AMC8DT        CK#NOT
234800090408     C                   MOVE      'Y'           @@CHGS
234900090408     C                   WRITE     HISTR
235000090408     ** If there is Misc Supplemental data, update or write it now.
235100090904     C                   If        CFS834flagchg = 'Y'
235200090904     C                   If        CFS834    =   'Y'
235300090904     C                   Eval      AMCYUS    =   @USER
235400090904     C                   Eval      AMCYDT    =   Today
235500090904     c                   Time                    AMCYTI
235600090904     C                   Else
235700090904     C                   Eval      AMCYUS    =   *Blanks
235800090904     C                   Eval      AMCYDT    =   *Zeros
235900090904     C                   Eval      AMCYTI    =   *Zeros
236000090904     C                   End
236100090904     C                   End
236200090408     C                   If        %Found(ACCMSP)
236300090513     C     RC8DT         MULT      10000.0001    AMC8DT
236400090408     C                   Update    ACCMSPR
236500090408     C                   Else
236600090513     C                   If        RC8DT   <> *Zeros
236700090513     C     RC8DT         MULT      10000.0001    AMC8DT
236800090408     C                   Eval      AMTRST   =    I_TRST
236900090408     C                   Eval      AMSUB#   =    I_SUB#
237000090408     C                   Eval      AMACCT   =    I_ACCT
237100090408     C                   Write     ACCMSPR
237200090408     C                   End
237300090408     C                   Endif
237400090408    1C                   ENDIF
237500010129     C* # OF EMPLOYEES WITH MEDICAL COVERAGE CHANGE
237600010104    1C                   IF        REDEMP <> MEDEMP
237700010104     C                   EXSR      $COMNHIST
237800010104     C                   MOVE      'L26'         TRCODE
237900010104     C                   Z-ADD     MEDEMP        #7
238000010104     C                   MOVEL     #7            CK#NOT
238100010104     C                   MOVEL     REDEMP        NOTE2
238200010104     C                   MOVE      'Y'           @@CHGS
238300010104     C                   WRITE     HISTR
238400010104     C                   Z-ADD     REDEMP        MEDEMP
238500010104    1C                   ENDIF
238600010129     C* LIFE CONTRIBUTION PERCENT CHANGE
238700010104    1C                   IF        RIFPCT <> LIFPCT
238800010104     C                   EXSR      $COMNHIST
238900010104     C                   MOVE      'L27'         TRCODE
239000010104     C                   MOVEL     LIFPCT        CK#NOT
239100010104     C                   MOVEL     RIFPCT        NOTE2
239200010104     C                   MOVE      'Y'           @@CHGS
239300010104     C                   WRITE     HISTR
239400010104     C                   Z-ADD     RIFPCT        LIFPCT
239500010104    1C                   ENDIF
239600060428     C* LTD CONTRIBUTION PERCENT CHANGE
239700060428    1C                   IF        RLTPCT <> LTDPCT
239800060428     C                   EXSR      $COMNHIST
239900060428     C                   MOVE      'L41'         TRCODE
240000060428     C                   MOVEL     LTDPCT        CK#NOT
240100060428     C                   MOVEL     RLTPCT        NOTE2
240200060428     C                   MOVE      'Y'           @@CHGS
240300060428     C                   WRITE     HISTR
240400060428     C                   Z-ADD     RLTPCT        LTDPCT
240500060428    1C                   ENDIF
240600060428     C* STD CONTRIBUTION PERCENT CHANGE
240700060428    1C                   IF        RSTPCT <> STDPCT
240800060428     C                   EXSR      $COMNHIST
240900060428     C                   MOVE      'L42'         TRCODE
241000060428     C                   MOVEL     STDPCT        CK#NOT
241100060428     C                   MOVEL     RSTPCT        NOTE2
241200060428     C                   MOVE      'Y'           @@CHGS
241300060428     C                   WRITE     HISTR
241400060428     C                   Z-ADD     RSTPCT        STDPCT
241500060428    1C                   ENDIF
241600060501     C* View Volume on the Web Flag Change
241700060501    1C                   IF        RVOWFL <> SVOWFL
241800060501     C                   EXSR      $COMNHIST
241900060501     C                   MOVE      'L43'         TRCODE
242000060501     C                   MOVEL     SVOWFL        CK#NOT
242100060501     C                   MOVEL     RVOWFL        NOTE2
242200060501     C                   MOVE      'Y'           @@CHGS
242300060501     C                   WRITE     HISTR
242400060501     C                   Eval      SVOWFL   =    RVOWFL
242500060501    1C                   ENDIF
242600010129     C* S.I.C. CODE CHANGE
242700010105    1C                   IF        RICCOD <> SICCOD
242800010105     C                   EXSR      $COMNHIST
242900010105     C                   MOVE      'L28'         TRCODE
243000010105     C                   Z-ADD     SICCOD        #4
243100010105     C                   MOVEL     #4            CK#NOT
243200010105     C                   MOVEL     RICCOD        NOTE2
243300010105     C                   MOVE      'Y'           @@CHGS
243400010105     C                   WRITE     HISTR
243500010105     C                   Z-ADD     RICCOD        SICCOD
243600010105    1C                   ENDIF
243700010129     C* TERM DATE CHANGE
243800010105    1C                   IF        #TRISO <> ATRMDT
243900010105     C                   EXSR      $COMNHIST
244000010105     C                   MOVE      'L29'         TRCODE
244100010105     C                   MOVEL     ATRMDT        CK#NOT
244200010105     C                   MOVEL     #TRISO        NOTE2
244300010105     C                   MOVE      'Y'           @@CHGS
244400010105     C                   WRITE     HISTR
244500010105     C                   Z-ADD     #TRISO        ATRMDT
244600010105    1C                   ENDIF
244700010129    *** GBS DATE
244800010129    1C                   IF        GBSBDT <> #GBSISO
244900100323     C                   EXSR      $COMNHIST
245000100323     C                   MOVE      'L52'         TRCODE
245100100324     C                   Clear                   GBSBDTN           8 0
245200100324     C                   Clear                   GBSBDTA           8
245300100324     C     GBSBDT        MULT      10000.0001    GBSBDTN
245400100324     C                   Move      GBSBDTN       GBSBDTA
245500100324     C                   MOVEL     GBSBDTA       CK#NOT
245600100324     C                   Clear                   GBSBDTN
245700100324     C                   Clear                   GBSBDTA
245800100324     C     #GBSISO       MULT      10000.0001    GBSBDTN
245900100324     C                   Move      GBSBDTN       GBSBDTA
246000100324     C                   MOVEL     GBSBDTA       NOTE2
246100010129     C                   MOVE      'Y'           @@CHGS
246200100324     C                   WRITE     HISTR
246300010129     C                   Z-ADD     #GBSISO       GBSBDT
246400010129    1C                   ENDIF
246500010129    *** BLUE CROSS FLAG
246600010129    1C                   IF        ABCFLG <> RBCFLG
246700010129     C                   MOVE      'Y'           @@CHGS
246800010129     C                   MOVEL(P)  RBCFLG        ABCFLG
246900010129    1C                   ENDIF
247000010129    *** PHN FLAG
247100010129    1C                   IF        APREFX <> RPREFX
247200010129     C                   MOVE      'Y'           @@CHGS
247300010129     C                   MOVEL(P)  RPREFX        APREFX
247400010129    1C                   ENDIF
247500010129    *** COUNTY
247600010129    1C                   IF        ACONTY <> RCONTY
247700140206     C                   EXSR      $COMNHIST
247800140206     C                   MOVE      'L53'         TRCODE
247900140206     C                   EVAL      CK#NOT = ACONTY
248000140206     C                   EVAL      NOTE2 = RCONTY
248100140206     C                   MOVE      'Y'           @@CHGS
248200140206     C                   WRITE     HISTR
248300010129     C                   MOVEL(P)  RCONTY        ACONTY
248400010129    1C                   ENDIF
248500140206    ***
248600010104     C                   ENDSR
248700010104   S***S
248800010104     C     $COMNHIST     BEGSR
248900010104    ***
249000010104     C                   CLEAR                   HISTR
249100010104     C                   MOVE      I_TRST        @TRST
249200010104     C                   MOVE      I_SUB#        @SUBD
249300010104     C                   MOVE      I_ACCT        @ACCT
249400010104     C     @TRST         CAT(P)    @SUBD:0       HKEY
249500010104     C                   CAT       @ACCT:0       HKEY
249600050415     C***********        MOVE      'X'           TRMFLG
249700050415     C***********        MOVE      'X'           TRLFLG
249800050415     C                   MOVE      *Blanks       TRMFLG
249900050415     C                   MOVE      *Blanks       TRLFLG
250000010104     C                   MOVE      'N'           DTRFLG
250100010104     C                   MOVE      *ZEROS        HDSEQ#
250200131029     C                   MOVEL     'FM060R'      HPRGNM
250300010104     C                   Z-ADD     I_TRST        HSTRST
250400010104     C                   Z-ADD     I_SUB#        HSSUB#
250500010104     C                   Z-ADD     I_ACCT        HSACCT
250600010104     C                   MOVEL     @USER         HOPER
250700010104     C                   MOVE      'A'           HSDLTD
250800131029     C                   eval      sysdateymd = %date
250900131029     C                   MOVE      sysdateymd    trdate
251000131029     c                   eval      hstrtime = %time
251100010104    ***
251200010104     C                   ENDSR
251300010104   S***S
251400010104     C     $SCR2FIL      BEGSR
251500010104    ***
251600010104     C                   MOVE      #GBSISO       GBSBDT
251700010104     C                   MOVE      #ENRISO       ENROLL
251800021206     C                   Z-ADD     #CFSISO       CFSEDO
251900021206     C                   IF        CFSEDO <> *ZEROS
252000030427     C                   Z-ADD     CFSEDO        CFSEDT
252100021127     C                   ELSE
252200030427     C                   Z-ADD     *ZEROS        CFSEDT
252300021127     C                   ENDIF
252400030225     C                   Z-ADD     #BGAISO       GBGADO
252500030225     C                   IF        GBGADO <> *ZEROS
252600030427     C                   Z-ADD     GBGADO        GBSGAD
252700030225     C                   ELSE
252800030427     C                   Z-ADD     *ZEROS        GBSGAD
252900030225     C                   ENDIF
253000010104     C                   MOVEL(P)  RCNAM1        ACNAM1
253100010104     C                   MOVEL(P)  RCNAM2        ACNAM2
253200010104     C                   MOVEL(P)  RADDR1        AADDR1
253300010104     C                   MOVEL(P)  RADDR2        AADDR2
253400010104     C                   MOVEL(P)  RCITY         ACITY
253500010104     C                   MOVEL(P)  RSTATE        ASTATE
253600010104     C                   Z-ADD     #ZIP          AZIP
253700010104     C                   MOVEL(P)  RCONTY        ACONTY
253800010104     C                   Z-ADD     RAREA         AAREA
253900010104     C                   Z-ADD     RPHONE        APHONE
254000010104     C                   Z-ADD     RAXARE        FAXARE
254100010104     C                   Z-ADD     RAX#          FAX#
254200010104     C                   MOVEL(P)  RONTAC        CONTAC
254300010104     C                   MOVEL(P)  RCNTAC        ECNTAC
254400010104     C                   Z-ADD     ROTEMP        TOTEMP
254500010104     C                   Z-ADD     ROEMPL        NOEMPL
254600010104     C                   MOVEL(P)  RCSTFL        FCSTFL
254700040929     C                   MOVEL     rcobsrv       acobsrv
254800050620     C                   Z-Add     RCOBADM       COBADM
254900040901s824 C                   MOVEL(P)  RSPHFL        ASPHFL
255000010104     C                   Z-ADD     RRNEWPD       RNEWPD
255100010104     C                   Z-ADD     RREEX         PREEX
255200010104     C                   Z-ADD     RAIT1         WAIT1
255300010104     C                   Z-ADD     RAIT2         WAIT2
255400010104     C                   Z-ADD     RAIT3         WAIT3
255500010104     C                   Z-ADD     RVGAGE        AVGAGE
255600010104     C                   Z-ADD     RRENAVG       RENAVG
255700010104     C                   MOVEL(P)  RMANCD        SMANCD
255800120809     C                   MOVEL(P)  RREREP        A2CODE1
255900061011     C                   Eval      A2PAR    =    RPAR
256000010104     C                   Z-ADD     REDEMP        MEDEMP
256100010104     C                   Z-ADD     RIFPCT        LIFPCT
256200060428     C                   Z-ADD     RSTPCT        STDPCT
256300060428     C                   Z-ADD     RLTPCT        LTDPCT
256400060501     C                   Eval      SVOWFL   =    RVOWFL
256500010104     C                   Z-ADD     RICCOD        SICCOD
256600010104     C                   MOVEL(P)  RBCFLG        ABCFLG
256700010104     C                   MOVE      R2AACOD       ACAACOD
256800010104     C                   MOVEL(P)  RPREFX        APREFX
256900090728s216 C                   Movel     RCFS834       CFS834
257000090904     C                   If        CFS834    =   'Y'
257100090904     C                   Eval      AMCYUS    =   @USER
257200090904     C                   Eval      AMCYDT    =   Today
257300090904     c                   Time                    AMCYTI
257400090904     C                   Else
257500090904     C                   Eval      AMCYUS    =   *Blanks
257600090904     C                   Eval      AMCYDT    =   *Zeros
257700090904     C                   Eval      AMCYTI    =   *Zeros
257800090904     C                   End
257900010104    ***
258000010206    *** SET COVERAGE THRU DATE.
258100010206     C     *DATE         MULT      10000.0001    NEWCOV
258200010206     C                   Z-ADD     01            NEWDD
258300010206     C                   SUB       1             NEWMM
258400010206     C                   IF        NEWMM  <= 0
258500010206     C                   Z-ADD     12            NEWMM
258600010206     C                   SUB       1             NEWYY
258700010206     C                   END
258800010206     C                   Z-ADD     NEWCOV        ACVTDT
258900010206    ***
259000010104     C                   ENDSR
259100130918      *---------------------------------------------------------------------
259200140114      * edit_county: edit the county (for MD & PA only right now)
259300130918      *---------------------------------------------------------------------
259400130918     C     edit_county   begsr
259500130918
259600130918      * call function to retrieve county for this zip - function can return
259700130918      * 'ER' (error) or '**' (multiple counties for zip) or a single county.
259800131017     C                   eval      wrk_countycode = #get_county(azip5:rstate)
259900130918     C                   if        wrk_countycode <> '**' and
260000130918     C                             wrk_countycode <> 'ER'
260100130918     C                   if        wrk_countycode <> rconty
260200130918     C                   eval      rconty = wrk_countycode
260300130918     C                   endif
260400130918
260500131101      * else, either mult counties or error returned from function...
260600130918     C                   elseif    (sv_zip5 <> azip5) or (#valid_county(
260700130918     c                              azip5:rstate:rconty) = 'N')
260800131017     C                   eval      wrk_countycode = #select_county(azip5:rstate)
260900130918     C                   if        wrk_countycode <> *blanks
261000130918     C                   eval      rconty = wrk_countycode
261100130918     c                   else
261200130918     C                   eval      r2msg = msg(46)
261300130918     C                   endif
261400130918
261500130918     C                   endif
261600130918
261700130918     C                   endsr
261800160616
261900160616      ***********************************************
262000160617      * Lock submst record
262100160616      ***********************************************
262200160617       begsr #locksubmst;
262300160617
262400160617      * 6/17/16 - continue locking submst even though the last acc # field
262500160617      * is no longer being used / updated in order to prevent more than 1
262600160617      * person from adding the same account #
262700160617
262800220118         chain(e) SUBKEY SUBMST;
262900160617      * if submst is locked, notify and return to screen 1
263000220118         if %error and %status(submst) = 1218;
263100220118           eval @@VA = 'S';
263200220118           leavesr;
263300220118         endif;
263400160617
263500220118         IF not %FOUND(SUBMST);
263600220118           eval @@VA = 'E';
263700220118         ENDIF;
263800160617       endsr;
263900160617
264000180613      //===========================================================================
264100221110      // Update contact on a new account or reinstate
264200180612      //===========================================================================
264300180612
264400180612       begsr writeContact;
264500180612
264600220118         if new = 'Y';
264700180613
264800220118           if rsphfl = 'F';
264900180613
265000220118             if tscode = 'O M' or tscode = 'O N' or tscode = 'O D';
265100220118               contac = rontac;
265200220118             endif;
265300180613
265400220118           endif;
265500180613
265600220118           leavesr;
265700220118         endif;
265800180612
265900220118         if trcode = 'L29';
266000180613
266100220118           if rsphfl = 'F';
266200180613
266300220118             if tscode = 'O M' or tscode = 'O N' or tscode = 'O D';
266400220118               contac = rontac;
266500220118             endif;
266600180613
266700220118           endif;
266800180613
266900220118         endif;
267000180613
267100180612       endsr;
267200180612
267201221110      //===========================================================================
267202221110      // Update file listing
267203221110      //===========================================================================
267204221110
267205221110       begsr updateFileListing;
267206221110
267207221110        userColor = #aacolor(i_trst:i_sub#:i_acct);
267208221110
267209221110        setll (i_trst:i_sub#:i_acct) r_ftfmtfil;
267210221110        reade (i_trst:i_sub#:i_acct) r_ftfmtfil;
267211221110
267212221110        dow not %eof;
267213221110
267214221110         ffasgn_aa = userColor;
267215221110         update r_ftfmtfil;
267216221110
267217221110        reade (i_trst:i_sub#:i_acct) r_ftfmtfil;
267218221110        enddo;
267219221110
267220221110        setll (i_trst:i_sub#:i_acct) r_amw0001r;
267221221110        reade (i_trst:i_sub#:i_acct) r_amw0001r;
267222221110
267223221110        dow not %eof;
267224221110
267225221110         a1assign = userColor;
267226221110         update r_amw0001r;
267227221110
267228221110        reade (i_trst:i_sub#:i_acct) r_amw0001r;
267229221110        enddo;
267230221110
267231221110        setll (i_trst:i_sub#:i_acct) r_amw0002r;
267232221110        reade (i_trst:i_sub#:i_acct) r_amw0002r;
267233221110
267234221110        dow not %eof;
267235221110
267236221110         a1assign = userColor;
267237221110         update r_amw0002r;
267238221110
267239221110        reade (i_trst:i_sub#:i_acct) r_amw0002r;
267240221110        enddo;
267241221110
267243221110       endsr;
267244221110
267300180612      //===========================================================================
267400160617      * Find next available account #
267500160617      ***********************************************
267600160617       begsr #fndnxtacc;
267700160617
267800220118         nextacc# = 1;
267900220118         setll subkey acmunique;
268000220118         dou %eof(acmunique);
268100220118           reade subkey acmunique;
268200220118           if not %eof(acmunique) and acm_acacct = nextacc# and
268300220118           nextacc# < 9999;
268400220118             nextacc# += 1;
268500220118           else;
268600220118             leave;
268700220118           endif;
268800220118         enddo;
268900160616
269000160616      * next available account # found
269100220118         if nextacc# < 9999;
269200220118           I_ACCT = nextacc#;
269300220118         else;
269400160616      * all 9999 account #'s are taken
269500220118           I_ACCT = 0;
269600220118           eval @@VA = '9';
269700220118         endif;
269800160616
269900160616       endsr;
270000160616
270100000102   X***X
270200000102123456*8901234567890123456789012345678901234567890
270300000102      *  11111111112222222222333333333344444444445
270400000102** CTDATA MSG
270500160617LEAVE ACCOUNT # ZERO FOR NEXT AVAIL ACCOUNT NUMBER                    1
270600160617TRUST NUMBER IS ZERO OR INVALID                                       2
270700160617SUB DIVISION IS ZERO, INVALID, OR BAD TR/SUB COMBO                    3
270800160617NO SELECTION MADE                                                     4
270900160617VALID TRUST REQUIRED FOR F4 SUBDIVISION SELECTION                     5
271000160617VALID TRUST & SUB REQUIRED FOR F5 ACCT SELECTION                      6
271100160617ENROLLMENT DATE IS ZERO OR INVALID VALUE/FORMAT                       7
271200160617GBS DATE IS ZERO OR INVALID VALUE/FORMAT                              8
271300160617COBRA FED/STATE FLAG NOT {F,S,N}                                      9
271400160617CONTACT PERSON IS BLANK                                               10
271500160617PHONE NUMBER IS ZERO                                                  11
271600160617ZIP CODE IS ZERO                                                      12
271700160617STATE CODE IS BLANK                                                   13
271800160617CITY IS BLANK                                                         14
271900160617ADDRESS LINE 1 IS BLANK                                               15
272000160617NAME LINE 1 IS BLANK                                                  16
272100160617RENEWAL PERIOD IS 0                                                   17
272200160617SERVICING BROKER OR RENEWAL REP INVALID OR BLANK                      18
272300160617ADMINISTRATOR CODE IS INVALID; NOT ON AA CODE FILE                    19
272400160617LIFE CONTRIBUTION MUST BE 100 OR LESS                                 20
272500160617TERMINATION DATE INVALID; MUST BE MMDDYYYY                            21
272600160617TERM DATE NOT ALLOWED ON AN 'ADD OF AN ACCOUNT'                       22
272700160617ACCOUNT NUMBER IS INVALID OR NOT FOUND                                23
272800160617ACCOUNT RECORD HAS TO BE ADDED BEFORE ACCESS F16                      24
272900160617CFS ENTITY DATE IS INVALID VALUE/FORMAT                               25
273000160617GBS BEGIN GA DATE IS INVALID VALUE/FORMAT                             26
273100160617Press F8 to see Special Handling notes.                               27
273200160617Special Handling must be Y,N,P,D,F OR Blank.                          28
273300040930COBRA SERVICE: F,L,B (leave Blank when Fed/St = N)
273400050627You must confirm with Y if there's no Cob Adm Fee.
273500050627Cobra Adm Fee must be zero for a non-Cobra Acct.
273600050620Warning:  Cobra Admin Fee is over $2.50.
273700160617LTD Contribution percentage must be 100 or less.                      33
273800160617STD Contribution percentage must be 100 or less.                      34
273900160617View Volume on the Web must by Y or N.                                35
274000160617Parity must be Y or N.                                                36
274100160617CFS-834 must be Y or Blank.                                           37
274200160617If CFS-834=Y, valid 834 Effective Date is required                    38
274300090520Renewal Period is required; must be 01 thru 12.
274400090520Account Administrator Code is required.
274500090521Warning: There is no Tax ID (OnSite Dental Trusts)
274600090707ACH Begin Date cannot be prior to GBS Adm/Enr Date
274700090731Medicaid# is required for Onsite Dental Accounts.
274800120530ACH key is only valid for Senior Dental accounts.
274900160617Invalid Zip Code or invalid zip/state combination.                    45
275000160617Invalid County or invalid county/zip combination.                     46
275100160617ANOTHER ACCT IS BEING ADDED TO THIS SUBDIVISION, PLEASE TRY LATER     47
275200160617THIS SUBDIVISION IS FULL, THERE ARE 9999 ACCOUNTS                     48
275300191216Account Locked:                                                       49
