000100151005     H option(*noDebugIo)  DftActGrp(*no) BndDir('GBSBIND')
000200151005      *-------------------------------------------------------------------------
000300151005      *
000400010918    *** FM030R - PLAN MASTER MAINTENANCE
000500010129    *** REWRITTEN FROM S/36 SOURCE
000600010129    ***           BY STEPHEN KING
000700020306    ***           ON 09/01 THRU 3/02
000800020222    ************************************************************************
000900020411     **  SCAN ON CLS FOR CLASS CODE AND REMOVE ASTERISKS
001000010918     ** MODIFICATION HISTORY
001100010918     **
001200010918     ** ### UUU CCYYMMDD X---->
001300010918     ** 000 SSK 20010918 REWRITE OF 1988 SOURCE
001400020222     **                  NIDCTRL is no longer used, disabled.
001500020604     ** 001 SSK 20020604 CHANGE EDIT OF AGE BANDS IN SECONDARY SCREEN TO A
001600020604     **                  WARNING MESSAGE; EDIT SHOULD BE HANDLED BY THIRD
001700020604     **                  SCREEN.
001800021003     **
001900021003     ** 001 SSK 20021003 CLASS AND PHN MOD TO ALLOW ABR CODES OF 'D' TO PUT
002000021003     **                    OUT A CLASS RECORD.
002100020222     **
002200030611     **     KSJ 20030611 MODIFIED TO MOVE VCP_REQ TO PCP_REQ FIELD INSTEAD
002300030611     **                  OF THE PREVIOUSLY HARD-CODED 'N'
002400040803     ** 08/03/04 dlk - add acitve code check for plan category
002500050929     ** 09/27/05 szz - Add online enrollment description and account.
002600051212     ** 12/12/05 szz - Temporarily remove ACCT per Dave A.
002700051214     ** 12/14/05 dlk - remove edit that required submst inv col heading
002800051214     **                to be non-blank for inv col selected
002900060320     ** 03/20/06 dlk - add acc# for use in displaying invoice columns only
003000070613     ** 06/13/07 szz - Remove account# validation (see 9/27/05 above).
003100071102     ** 11/02/07 dlk - add round premium field
003200081106     ** 11/06/08 rlj - allow call to plan number generator pgm
003300090129     ** 01/29/09 dlk - add debit card field
003400090430     ** 04/30/09 dlk - change use of SFADM field to indicate subsidy plan
003500091119     ** 11/18/09 rlj - remove F9 - Next Avail Plan option
003600101012     ** 10/12/10 dlk - allow carrier CAB to enter CLASS per request from
003700101012     **                SHELLY (replace PHN with CAB)
003800110824     ** 08/24/11 dlk - remove composite age banding.
003900120123     ** 01/23/12 dlk - change renewal date to renewal month only per request
004000120123     **                from admin.
004100120322     ** 03/22/12 dlk - put "round premium" field back on screen after it
004200120322     **                somehow disappeared since it was added in 2007...
004300121212     ** 12/12/12 jva - Company Paid Plan flag
004400130501     ** 05/01/13 rlj - Add call to Plan Auxiliary maint
004500130515     ** 05/14/13 dlk - remove edit for age band from = to
004600140116     ** 01/16/14 rlj - Don't allow chg to Carrier Code unless there are
004700140116     **                no MCOV records attached to plan.
004800140131     ** 01/28/14 rlj - If Carrier code chgs, set ACA flag based on CARMST2P
004900140212     ** 02/12/14 rlj - Allow for renew year entry for new ACA plans
005000150817     ** 08/17/15 B.Rees  br01
005100150817     **    Added Option to Add / Edit a SBC Link.
005200150924     ** 09/24/15 B.Rees  br01
005300150924     **    Enhanced the SBC Link Option
005400160418    5** 04/18/16 J.Torres Allowed cor Carrier Code NAD and NAE to use Class
005500160602     ** 06/02/16 dlk - retain t/s/p/a on screen 1 (Brandon S request)
005600170609      * 06/09/17 B.Rees  Added Guaridan to use Class
005700180320      * 03/20/18 B.Rees  Fixed PlnAux Record Lock Issue   br02
005800180816      * 08/16/18 B.Rees  Added F5 = Plan Copy Maintenance
005801200224      * 02/24/20 jt      Added UHC mapping files
005803200221
005900010918    ************************************************************************
006000010918     FFM030D    CF   E             WORKSTN INFDS(WSDS)
006100010918     FPLNMST    UF A E           K DISK
006200140128     FPLNAUXP   UF   E           K DISK
006300000102     FTRSMST    IF   E           K DISK
006400020219     FSUBMST    IF   E           K DISK
006500010918     FCODES     IF   E           K DISK
006600020213     FCLASS     IF   E           K DISK
006700010918     FCARMST    IF   E           K DISK
006800140128     FCARMST2P  IF   E           K DISK
006900050929     FACCMST    IF   E           K DISK
007000140116     FMCOVL1    IF   E           K DISK
007100050927     FOEPLAN    UF A E           K DISK
007200010918     FPLNHIST0  O  A E             DISK
007300060320     FAC2MST    IF   E           K DISK
007400150817br01 FShpLnkl1  uf a E           K DISK
007401200221
007402200221     fcarplnz   uf   e           k disk    rename(carplnr:uhcPlan)
007403200221
007404200224     fuhcplancrtif   e           k disk    rename(uhcpcr:uhcPlncrt) usropn
007405200221
007500150817     F*---------------------------------------------------------------------
007600010919     D WSDS            DS
007700010919     D  FKEY                 369    369A
007800150817
007900150817     D pgmsts         sDS
008000150817     D  UserName             254    263
008100150817
008200010919     D  F1             C                   CONST(X'31')
008300010919     D  F2             C                   CONST(X'32')
008400010919     D  F3             C                   CONST(X'33')
008500010919     D  F4             C                   CONST(X'34')
008600010919     D  F5             C                   CONST(X'35')
008700010919     D  F6             C                   CONST(X'36')
008800010919     D  F7             C                   CONST(X'37')
008900010919     D  F8             C                   CONST(X'38')
009000010919     D  F9             C                   CONST(X'39')
009100010919     D  F10            C                   CONST(X'3A')
009200010919     D  F11            C                   CONST(X'3B')
009300010919     D  F12            C                   CONST(X'3C')
009400010919     D  F13            C                   CONST(X'B1')
009500010919     D  F14            C                   CONST(X'B2')
009600010919     D  F15            C                   CONST(X'B3')
009700010919     D  F16            C                   CONST(X'B4')
009800010919     D  F17            C                   CONST(X'B5')
009900010919     D  F18            C                   CONST(X'B6')
010000010919     D  F19            C                   CONST(X'B7')
010100010919     D  F20            C                   CONST(X'B8')
010200010919     D  F21            C                   CONST(X'B9')
010300010919     D  F22            C                   CONST(X'BA')
010400010919     D  F23            C                   CONST(X'BB')
010500010919     D  F24            C                   CONST(X'BC')
010600010919    ***
010700010919     D                UDS
010800010919     D  @USER                100    107
010900010919     D  CONAME               201    240
0110000603200056 D  lprefix              241    241
011100010919      *
011200010919    *** TIMESTAMP FIELDS DATA STRUCTURE
011300010919      *
011400010919     D @TIMESTAMP      DS
011500010919     D  #TSCYMD                1      8S 0
011600010919     D  #TSTIME                9     14S 0
011700010919     D  @TSJOB                15     24
011800010919     D  @TSUSER               25     34
011900010919     D  #TSNBR                35     40S 0
012000010919    ***
012100140212     D M@              S             70A   DIM(40) CTDATA PERRCD(1)
012200010919     D @STEP           S              5A
012300010919     D E#              S              2S 0
012400020212     D @@SM1           S                   LIKE(SMSG)
012500020212     D @@SM2           S                   LIKE(SMSG2)
012600020212     D @@SM4           S                   LIKE(SMSG4)
012700010919    ***
012800010919     D DS@BASE       E DS                  EXTNAME(PLNMST)
012900010920     D SCREEN@DS     E DS                  EXTNAME(PLNMST) PREFIX(V:1)
013000010920     D  SCF                   58     97P 0 DIM(20)
013100010920     D  SCT                   98    137P 0 DIM(20)
013200010919    ***
013300010919     D #USO            S              8S 0
013400010919     D #ISA            S              8S 0
013500010919     D #USA            S               D   DATFMT(*USA)
013600010919     D #ISO            S               D   DATFMT(*ISO)
013700010924    ***
013800010924     D HMSG            DS
013900010924     D HMSG1                   1     50A
014000010924     D HMSG2                  51    100A
014100010919    ***
014200010919     D                 DS
014300010919     D CLR@SPAN                1    200A
014400010919     D SPAN@                   1    200A   DIM(200)
014500010919     D N#              S              3S 0
014600010919     D P#              S              3S 0
014700081111    ***
014800081111     D                 DS
014900081111     D ppplan                  1      4A
015000081111     D  pln1                   1      1A
015100081111     D  pln2                   2      2A
015200081111     D  pln3                   3      3A
015300081111     D  pln4                   4      4A
015400081111      *
015500081111     D                 DS
015600081111     D  plnx           S              1
015700081111     D  plnnmb         S              1  0
015800081111     D  plbeg          S              4
015900010919    ***
016000010919     D                 DS
016100010919     D @@FR                    1     60A
016200010919     D SFR                     1     60S 0 DIM(20)
016300010919     D   SABF01                1      3S 0
016400010919     D   SABF02                4      6S 0
016500010919     D   SABF03                7      9S 0
016600010919     D   SABF04               10     12S 0
016700010919     D   SABF05               13     15S 0
016800010919     D   SABF06               16     18S 0
016900010919     D   SABF07               19     21S 0
017000010919     D   SABF08               22     24S 0
017100010919     D   SABF09               25     27S 0
017200010919     D   SABF10               28     30S 0
017300010919     D   SABF11               31     33S 0
017400010919     D   SABF12               34     36S 0
017500010919     D   SABF13               37     39S 0
017600010919     D   SABF14               40     42S 0
017700010919     D   SABF15               43     45S 0
017800010919     D   SABF16               46     48S 0
017900010919     D   SABF17               49     51S 0
018000010919     D   SABF18               52     54S 0
018100010919     D   SABF19               55     57S 0
018200010919     D   SABF20               58     60S 0
018300010919     D                 DS
018400010919     D @@TO                    1     60A
018500010919     D STO                     1     60S 0 DIM(20)
018600010919     D   SABT01                1      3S 0
018700010919     D   SABT02                4      6S 0
018800010919     D   SABT03                7      9S 0
018900010919     D   SABT04               10     12S 0
019000010919     D   SABT05               13     15S 0
019100010919     D   SABT06               16     18S 0
019200081107     D   SABT07               19     21S 0
019300081107     D   SABT08               22     24S 0
019400010919     D   SABT09               25     27S 0
019500010919     D   SABT10               28     30S 0
019600010919     D   SABT11               31     33S 0
019700010919     D   SABT12               34     36S 0
019800010919     D   SABT13               37     39S 0
019900010919     D   SABT14               40     42S 0
020000010919     D   SABT15               43     45S 0
020100010919     D   SABT16               46     48S 0
020200010919     D   SABT17               49     51S 0
020300010919     D   SABT18               52     54S 0
020400010919     D   SABT19               55     57S 0
020500020212     D   SABT20               58     60S 0
020600020212    ***
020700020212     D @90             S             90A
020800020212     D                 DS
020900020212     D @PARMDS                 1     90A
021000020212     D P@TRS                   1      3S 0
021100020212     D P@SUB                   4      6S 0
021200020212     D P@PLN                   7     10A
021300020212     D P@TD                   11     30A
021400020212     D P@SD                   31     50A
021500020212     D P@PD                   51     90A
021600020212    ***
021700020213     D @50             S             50A
021800020213     D                 DS
021900020213     D @P2DS                   1     50A
022000020213     D P@TRS2                  1      3S 0
022100020213     D P@SUB2                  4      6S 0
022200020213     D P@PLN2                  7     10A
022300020213     D P@TD2                  11     30A
022400020213     D P@SD2                  31     50A
022500130501     D                 DS
022600140212     D @P4DS                   1     14A
022700130501     D P@TRS3                  1      3A
022800130501     D P@SUB3                  4      6A
022900130501     D P@PLN3                  7     10A
023000140212     D P@YR3                  11     14A
023100020213    ***
023200060320gsp  D ac2head         DS
023300060320gsp  D  A2IH1T
023400060320gsp  D  A2IH1B
023500060320gsp  D  A2IH2T
023600060320gsp  D  A2IH2B
023700060320gsp  D  A2IH3T
023800060320gsp  D  A2IH3B
023900060320gsp  D  A2IH4T
024000060320gsp  D  A2IH4B
024100060320gsp  D  A2IH5T
024200060320gsp  D  A2IH5B
024300060320gsp  D  A2IH6T
024400060320gsp  D  A2IH6B
024500060320gsp  D  A2IH7T
024600060320gsp  D  A2IH7B
024700060320gsp  D  A2IH8T
024800060320gsp  D  A2IH8B
024900060320gsp  D  A2IH9T
025000060320gsp  D  A2IH9B
025100060320    ***
025200060320
025300020219     D KEY@TRS         S                   LIKE(TRTRST)
025400020219     D KEY@SUB         S                   LIKE(SBSUB#)
025500020219     D KEY@PLN         S                   LIKE(PLPLAN)
025600020219     D DES@TRS         S                   LIKE(TNAME)
025700020219     D DES@SUB         S                   LIKE(SUBNAM)
025800020219     D DES@PLN         S                   LIKE(PDESCR)
025900020219     D KEY@TYPE        S                   LIKE(TYPE)
026000020219     D KEY@CODE        S                   LIKE(CODE)
026100140212     D svrenewyy       S                   LIKE(zrenewyy)
026200020219     D @T3             S              3A
026300020219     D @S3             S              3A
026400020219     D @P4             S              4A
026500060320     D @a4             S              4A
026600020219     D @TS6            S              6A
026700020219     D @TSAP           S             10A
026800020219     D @@VT            S              1A
026900020219     D @@VS            S              1A
027000020219     D @@VP            S              1A
027100020219    ***
027200020219     D @3              S              3A
027300020219     D @4              S              4A
027400020219     D @6              S              6A
027500140212     D @10             S             14A
027600020219     D @FLAG           S              1A
027700020219     D @TS40           S             40A
027800020219     D @@A             S              1A
027900020219     D @@ER            S              1A
028000020219     D @@VB            S              1A
028100020219     D @@VDTE          S              1A
028200020219     D @@VSAL          S              1A
028300020219     D #REMITP         S              3S 1
028400120123     D*#RENEW          S              8S 0
028500060320     D vlacctchar      S              4A
028600151002br01 D pos             S              4s 0
028700151005br01 D x               S             10i 0
028800151005br01 D y               S             10i 0
028900151005br01 D tokens          s            100A   varying dim(50)
029000151005br01 D SaveLink        s            255A   varying
029100160602     D h_vltrst        S                   like(vltrst) inz
029200160602     D h_vlsub#        S                   like(vlsub#) inz
029300160602     D h_vlplan        S                   like(vlplan) inz
029301200221     d poss            s              2  0
029302200221     d poss2           s              2  0
029304200221     d lenght          s              1  0
029305200221
029400151005
029500151005br01  *-------------------------
029600151005br01  *?Procedures
029700151005br01  *-------------------------
029800151005br01 D/include GBSPGM/QMODSRC,#GettokPR
029900151005
030000150817     D*---------------------------------------------------------------------
030100160602     c                   clear                   vltrst
030200160602     c                   clear                   vlsub#
030300160602     c                   clear                   vlplan
030400160602     c                   clear                   vlacct
030500160602
030600010919     C                   DOU       @STEP = 'LEAVE'
030700010919     C     @STEP         CASEQ     'PREP1'       $PREP1
030800010919     C     @STEP         CASEQ     'STEP1'       $STEP1
030900081107     C     @STEP         CASEQ     'STEP2'       $STEP2
031000081107     C     @STEP         CASEQ     'STEP3'       $STEP3
031100081107     C     @STEP         CASEQ     'STEP4'       $STEP4
031200081107     C                   ENDCS
031300081107     C                   ENDDO
031400150817     C
031500081107     C                   MOVE      *ON           *INLR
031600150817     C*---------------------------------------------------------------------
031700010919     C     *INZSR        BEGSR
031800010919    ***
031900010919     C                   MOVE      'PREP1'       @STEP
032000010919    ***
032100010919     C     KEY#SUB       KLIST
032200020219     C                   KFLD                    KEY@TRS
032300020219     C                   KFLD                    KEY@SUB
032400010919     C*
032500070613     C**   KEY#ACC       KLIST
032600070613     C**                 KFLD                    KEY@TRS
032700070613     C***********        KFLD                    KEY@SUB
032800051212     C**************     KFLD                    WACCT
032900060320     C     KEYacct       KLIST
033000081107     C                   KFLD                    KEY@TRS
033100081107     C                   KFLD                    KEY@SUB
033200081107     C                   KFLD                    vlacct
033300081107     C     KEY#AC2       KLIST
033400081107     C                   KFLD                    lprefix
033500081107     C                   KFLD                    KEY@TRS
033600081107     C                   KFLD                    KEY@SUB
033700081107     C                   KFLD                    vlacct
033800050929     C*
033900010919     C     KEY#PLAN      KLIST
034000020219     C                   KFLD                    KEY@TRS
034100020219     C                   KFLD                    KEY@SUB
034200020219     C                   KFLD                    KEY@PLN
034300081111      *
034400081111     C     plnkey        klist
034500081111     C                   kfld                    pptrst            3 0
034600081111     C                   kfld                    ppsub             3 0
034700081111     C                   kfld                    ppplan            4
034800081111     C*
034900010920     C     KEY@CODES     KLIST
035000020219     C                   KFLD                    KEY@TYPE
035100020219     C                   KFLD                    KEY@CODE
035200010919    ***
035300010919     C                   ENDSR
035400150817     C*---------------------------------------------------------------------
035500010919     C     $PREP1        BEGSR
035600010919    ***
035700160602     c                   move      vltrst        h_vltrst
035800160602     c                   move      vlsub#        h_vlsub#
035900160602     c                   move      vlplan        h_vlplan
036000160602     C**                 CLEAR                   IO01
036100140212     C                   CLEAR                   IO02
036200081110     C                   CLEAR                   IO04
036300081110     C                   MOVEL     CONAME        TITLE
036400160602      * 6/2/16 - stop clearing t/s/p when return to screen 1
036500160602     C**                 MOVE      *ZEROS        VLTRST
036600160602     C**                 MOVE      *ZEROS        VLSUB#
036700160602     C**                 MOVE      *BLANKS       VLPLAN
036800160602     c                   move      h_vltrst      vltrst
036900160602     c                   move      h_vlsub#      vlsub#
037000160602     c                   move      h_vlplan      vlplan
037100081110     C                   MOVE      'STEP1'       @STEP
037200081110    ***
037300081110     C                   ENDSR
037400150817     C*---------------------------------------------------------------------
037500010919     C     $STEP1        BEGSR
037600010919    ***
037700010919     C                   MOVEL     @@SM1         SMSG
037800010919     C                   EXFMT     IO01
037900020404     C                   MOVE      *OFF          *IN81
038000060320      * 98-off = nondisplay of acct text on screen 2
038100060320     C                   eval      *IN98 = *off
038200010919     C                   MOVE      *BLANKS       @@SM1
038300010919     C                   MOVE      *BLANKS       SMSG
038400010919     C                   MOVE      *ZEROS        E#
038500010919    *** END APP
038600010919    1C                   IF        FKEY = F7
038700010919     C                   MOVEL(P)  'LEAVE'       @STEP
038800010919     C                   LEAVESR
038900010919    1C                   ENDIF
039000010919    *** TRUST SELECTOR
039100010919    1C                   IF        FKEY = F2
039200010919     C                   EXSR      $F2PROC
039300020219    2C                   IF        @@VT = 'Y'
039400020219     C                   MOVEL(P)  DES@TRS       O_TNAME
039500020219    2C                   ENDIF
039600010919     C                   LEAVESR
039700010919    1C                   ENDIF
039800010919    *** SUB SELECTOR
039900010919    1C                   IF        FKEY = F4
040000020219     C                   MOVE      VLTRST        @T3
040100010919     C                   EXSR      $F4PROC
040200020219    2C                   IF        @@VS = 'Y'
040300020219     C                   MOVEL(P)  DES@SUB       O_SNAME
040400020219    2C                   ENDIF
040500010919     C                   LEAVESR
040600010919    1C                   ENDIF
040700180816      * Plan Master Copy
040800180816     C                   IF        FKEY = F5
040900190813     C                   CALL      'UTL130CLB'
041000180816     C                   LEAVESR
041100180816     C                   ENDIF
041200180816
041300010919    *** PLAN SELECTOR
041400010919    1C                   IF        FKEY = F6
041500020219     C                   MOVE      VLTRST        @T3
041600020219     C                   MOVE      VLSUB#        @S3
041700010919     C                   EXSR      $F6PROC
041800020219    2C                   IF        @@VP = 'Y'
041900020306     C                   MOVEL(P)  DES@PLN       VDESCR
042000020219    2C                   ENDIF
042100010919     C                   LEAVESR
042200010919    1C                   ENDIF
042300081111    *** FIND and use next available plan#
042400091119    1C******             IF        FKEY = F9
042500091119     C******             MOVE      VLTRST        @T3
042600091119     C******             MOVE      VLSUB#        @S3
042700091119     C******             MOVE      VLPLAN        ppplan
042800091119     C******             EXSR      $F09PROC
042900091119     C******             LEAVESR
043000091119    1C******             ENDIF
043100081111    * * AVAILABLE PLAN SELECTOR
043200081117    1C                   IF        FKEY = F11
043300081111     C                   MOVE      VLTRST        @T3
043400081111     C                   MOVE      VLSUB#        @S3
043500081111     C                   MOVE      VLPLAN        @P4
043600081117     C                   EXSR      $F11PROC
043700081111     C                   LEAVESR
043800081111    1C                   ENDIF
043900010919    *** VALIDATIONS
044000020404     C                   MOVE      *ON           *IN81
044100020219     C                   MOVE      VLTRST        @T3
044200010919     C                   EXSR      $CHK_TRST
044300020219    1C                   IF        @@VT = 'N'
044400010919     C                   MOVEL(P)  M@(E#)        @@SM1
044500010919     C                   LEAVESR
044600020219    1C                   ELSE
044700020219     C                   MOVEL(P)  DES@TRS       O_TNAME
044800010919    1C                   ENDIF
044900010919    ***
045000020219     C                   MOVE      VLSUB#        @S3
045100010919     C                   EXSR      $CHK_SUBD
045200020219    1C                   IF        @@VS = 'N'
045300010920     C                   MOVEL(P)  M@(E#)        @@SM1
045400020219     C                   LEAVESR
045500020219    1C                   ELSE
045600020219     C                   MOVEL(P)  DES@SUB       O_SNAME
045700020219    1C                   ENDIF
045800010919    ***
045900081110     C                   MOVE      VLPLAN        @P4
046000081110     C                   EXSR      $CHK_PLAN
046100081110    1C                   IF        @@VP = 'N'
046200081110     C                   MOVEL(P)  M@(E#)        @@SM1
046300081110     C                   LEAVESR
046400020219    1C                   ELSE
046500020225     C                   MOVEL(P)  DES@PLN       vdescr
046600020219    1C                   ENDIF
046700060320    * * validate acc# if it is entered
046800060320     c                   if        vlacct <> *zeros
046900060320     C     keyacct       chain     accmst
047000060320    1C                   IF        not %found(accmst)
047100060320     C                   MOVEL(P)  M@(36)        @@SM1
047200060320     C                   LEAVESR
047300060320    1C                   ENDIF
047400060320     c                   move      vlacct        vlacctchar
047500060320     c                   eval      *in98 = *on
047600060321     c                   movel     vlacct        o_aname
047700060321     c                   cat       acnam1:1      o_aname
047800060320    1C                   end
047900060320
048000050929     C     KEY#PLAN      Chain     OEPLAN
048100050929     C                   If        %Found(OEPLAN)
048200051212     C****               Eval      WACCT     =   OACCT
048300050929     C                   End
048400070613     C**** KEY#ACC       CHAIN(N)  ACCMSR
048500051213    1C******             IF        %FOUND(ACCMST)
048600051213     C******             Eval      ADESC     =   %Trim(ACNAM1)
048700051213     C******             Else
048800051213     C******             Eval      ADESC     =   %Trim('Account Not on File')
048900051213     C******             End
049000010920    ***
049100020213    1C                   IF        @@A = 'A' AND (TRDLTD <> 'A' OR
049200010920     C                             SBDLTD <> 'A')
049300010920     C                   MOVEL(P)  M@(30)        @@SM1
049400010920     C                   LEAVESR
049500010920    1C                   ENDIF
049600010919    ***
049700020404     C                   MOVE      *OFF          *IN81
049800010919     C                   MOVEL(P)  'STEP2'       @STEP
049900010919    ***
050000010919     C                   ENDSR
050100150817     C*---------------------------------------------------------------------
050200010919     C     $CHK_TRST     BEGSR
050300010919    ***
050400020219     C                   MOVE      'N'           @@VT
050500020219     C                   MOVE      *BLANKS       DES@TRS
050600020219    ***
050700020219     C                   TESTN                   @T3                  99
050800020219    1C                   IF        *IN99 = *OFF
050900020219     C                   Z-ADD     1             E#
051000020219     C                   LEAVESR
051100020219    1C                   ENDIF
051200020219    ***
051300020219     C                   MOVE      @T3           KEY@TRS
051400020219    ***
051500020219    1C                   IF        KEY@TRS = 0
051600010919     C                   Z-ADD     1             E#
051700020219     C                   LEAVESR
051800020219    1C                   ENDIF
051900020219    ***
052000020219     C     KEY@TRS       CHAIN(N)  TRSMSR
052100010925    2C                   IF        NOT %FOUND(TRSMST)
052200010919     C                   Z-ADD     2             E#
052300010919    2C                   ELSE
052400020219     C                   MOVEL(P)  TNAME         DES@TRS
052500020219     C                   MOVE      'Y'           @@VT
052600010919    2C                   ENDIF
052700010919    ***
052800010919     C                   ENDSR
052900150817     C*---------------------------------------------------------------------
053000010919     C     $CHK_SUBD     BEGSR
053100010919    ***
053200020219     C                   MOVE      'N'           @@VS
053300020219     C                   MOVE      *BLANKS       DES@SUB
053400020219    ***
053500020219     C                   TESTN                   @S3                  99
053600020219    1C                   IF        *IN99 = *OFF
053700020219     C                   Z-ADD     3             E#
053800020219     C                   LEAVESR
053900020219    1C                   ENDIF
054000020219    ***
054100020219     C                   MOVE      @S3           KEY@SUB
054200020219    ***
054300020219    1C                   IF        KEY@SUB = 0
054400020219     C                   Z-ADD     3             E#
054500020219     C                   LEAVESR
054600020219    1C                   ENDIF
054700020219    ***
054800020219     C                   MOVE      @T3           KEY@TRS
054900020219     C     KEY#SUB       CHAIN(N)  SUBMSR
055000020219    1C                   IF        NOT %FOUND(SUBMST)
055100020219     C                   Z-ADD     4             E#
055200020219    1C                   ELSE
055300020219     C                   MOVEL(P)  SUBNAM        DES@SUB
055400020219     C                   MOVE      'Y'           @@VS
055500020219    1C                   ENDIF
055600020219    ***
055700010919     C                   ENDSR
055800150817     C*---------------------------------------------------------------------
055900010919     C     $CHK_PLAN     BEGSR
056000010919    ***
056100020219     C                   MOVE      'N'           @@VP
056200020219     C                   MOVE      *BLANKS       DES@PLN
056300020219     C                   MOVE      *BLANKS       @@A
056400020219    ***
056500020219     C                   MOVEL(P)  @P4           KEY@PLN
056600020219    ***
056700020219    1C                   IF        KEY@PLN = *BLANKS
056800020219     C                   Z-ADD     5             E#
056900020219     C                   LEAVESR
057000020219    1C                   ENDIF
057100020219    ***
057200020219     C                   MOVE      @T3           KEY@TRS
057300020219     C                   MOVE      @S3           KEY@SUB
057400140212     C                   eval      *in36 = '1'
057500020225     C     KEY#PLAN      CHAIN     PLNMSR
057600020219    1C                   IF        %FOUND(PLNMST)
057700020219     C                   MOVEL(P)  PDESCR        DES@PLN
057800010919     C                   MOVE      'C'           @@A
057900140212     C                   eval      *in36 = '0'
058000020219    1C                   ELSE
058100010919     C                   MOVE      'A'           @@A
058200020219    1C                   ENDIF
058300020219    ***
058400020219     C                   MOVE      'Y'           @@VP
058500010925    ***
058600010925     C                   ENDSR
058700150817     C*---------------------------------------------------------------------
058800010919    *** TRUST SELECTION WINDOW
058900010919     C     $F2PROC       BEGSR
059000010919    ***
059100020219     C                   MOVE      *BLANKS       @T3
059200020219     C                   CALL      'FM006CL'
059300020219     C                   PARM                    @T3
059400020219    ***
059500020219    1C                   IF        @T3 = '*LR'
059600020219     C                   LEAVESR
059700020219    1C                   ENDIF
059800020219    ***
059900020219     C                   MOVE      @T3           VLTRST
060000020219     C                   EXSR      $CHK_TRST
060100020219    1C                   IF        @@VT = 'N'
060200020219     C                   MOVEL(P)  M@(E#)        @@SM1
060300020219    1C                   ENDIF
060400010919    ***
060500010919     C                   ENDSR
060600150817     C*---------------------------------------------------------------------
060700010919    *** SUBDIVISION SELECTION WINDOW
060800010919    ***    REQUIRES A VALID TRUST NUMBER TO CALL PROGRAM
060900010919     C     $F4PROC       BEGSR
061000010919    ***
061100020219     C                   EXSR      $CHK_TRST
061200020219     C*
061300020219    1C                   IF        @@VT = 'N'
061400020219     C                   MOVEL(P)  M@(E#)        @@SM1
061500020219     C                   LEAVESR
061600020219    1C                   ENDIF
061700020219    ***
061800020219     C                   MOVEL(P)  @T3           @TS6
061900020219    ***
062000020219     C                   CALL      'FM007CL'
062100020219     C                   PARM                    @TS6
062200020219    ***
062300020219    1C                   IF        %SUBST(@TS6:4:3) = '*LR'
062400020219     C                   LEAVESR
062500020219    1C                   ENDIF
062600020219    ***
062700020219     C                   EVAL      @S3 = %SUBST(@TS6:4:3)
062800020219     C                   MOVE      @S3           VLSUB#
062900020219     C*
063000020219     C                   EXSR      $CHK_SUBD
063100020219    1C                   IF        @@VS = 'N'
063200020219     C                   MOVEL(P)  M@(E#)        @@SM1
063300020219    1C                   ENDIF
063400010919    ***
063500010919     C                   ENDSR
063600150817     C*---------------------------------------------------------------------
063700010919    *** EXISTING PLAN NUMBER INQUIRY
063800010919    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
063900010919     C     $F6PROC       BEGSR
064000010919    ***
064100020219     C                   EXSR      $CHK_TRST
064200020219     C*
064300020219    1C                   IF        @@VT = 'N'
064400020219     C                   MOVEL(P)  M@(E#)        @@SM1
064500020219     C                   LEAVESR
064600020219    1C                   ENDIF
064700020219    ***
064800020219     C                   EXSR      $CHK_SUBD
064900020219     C*
065000020219    1C                   IF        @@VS = 'N'
065100020219     C                   MOVEL(P)  M@(E#)        @@SM1
065200020219     C                   LEAVESR
065300020219    1C                   ENDIF
065400010919    ***
065500020219     C                   EVAL      @TSAP = @T3 + @S3 + '    '
065600010925     C                   CALL      'FM004CL'
065700081110     C                   PARM                    @TSAP
065800081110    ***
065900081110    1C                   IF        %SUBST(@TSAP:7:3) = '*LR'
066000081110     C                   LEAVESR
066100020219    1C                   ENDIF
066200081110    ***
066300020219     C                   EVAL      @P4 = %SUBST(@TSAP:7:4)
066400081110     C                   MOVEL(P)  @P4           VLPLAN
066500010919     C                   EXSR      $CHK_PLAN
066600020219    1C                   IF        @@VP = 'N'
066700010919     C                   MOVEL(P)  M@(E#)        @@SM1
066800010919    1C                   ENDIF
066900010919    ***
067000010919     C                   ENDSR
067100081111    *** Find next available plan# and use it
067200081111    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
067300081117     C     $F09PROC      BEGSR
067400081111    ***
067500081111     C                   EXSR      $CHK_TRST
067600081111     C*
067700081111    1C                   IF        @@VT = 'N'
067800081111     C                   MOVEL(P)  M@(E#)        @@SM1
067900081111     C                   LEAVESR
068000081111    1C                   ENDIF
068100081111    ***
068200081111     C                   EXSR      $CHK_SUBD
068300081111     C*
068400081111    1C                   IF        @@VS = 'N'
068500081111     C                   MOVEL(P)  M@(E#)        @@SM1
068600081111     C                   LEAVESR
068700081111    1C                   ENDIF
068800081111    ***
068900081111      *     Locate Starting Point
069000081111     C                   MOVEL     @T3           pptrst
069100081111     C                   MOVEL     @S3           ppsub
069200081111      *         All blank
069300081111     C                   if        ppplan = '    '
069400081111     C                   eval      plbeg = 'AAAA'
069500081111     C                   else
069600081111      *         3 blank
069700081111     C                   if        pln4 = ' ' and pln3 = ' ' and
069800081111     C                             pln2 = ' '
069900081111     C                   eval      pln4 = 'A'
070000081111     C                   eval      pln3 = 'A'
070100081111     C                   eval      pln2 = 'A'
070200081111     C                   eval      plbeg = ppplan
070300081111     C                   else
070400081111      *         2 blank
070500081111     C                   if        pln4 = ' ' and pln3 = ' '
070600081111     C                   eval      pln4 = 'A'
070700081111     C                   eval      pln3 = 'A'
070800081111     C                   eval      plbeg = ppplan
070900081111     C                   else
071000081111      *         1 blank
071100081111     C                   if        pln4 = ' '
071200081111     C                   eval      pln4 = 'A'
071300081111     C                   eval      plbeg = ppplan
071400081111     C                   else
071500081111      *         0 blank
071600081111     C                   eval      plbeg = ppplan
071700081111     C                   endif
071800081111     C                   endif
071900081111     C                   endif
072000081111     C                   endif
072100081111      *
072200081111     C                   eval      ppplan = plbeg
072300081111      *
072400081111     C                   SETOFF                                       3495
072500081111     C     *IN34         DOUEQ     *ON
072600081111     C     *IN95         OREQ      *ON
072700081111      *
072800081111     C     plnkey        setll     plnmst                             34
072900081117     C                   read      plnmst                               3234
073000081117      *
073100081117     C                   if        *in32 = '1'
073200081117     C                   exsr      incpln
073300081117     C                   iter
073400081111     C                   endif
073500081117      *
073600081117     C                   if        ppplan <> plplan
073700081117     C                   leave
073800081117     C                   endif
073900081111      *
074000081111     C                   exsr      incpln
074100081111      *
074200081111     C                   ENDDO
074300081111      *
074400081111     C                   MOVEL(P)  ppplan        VLPLAN
074500081111    * *
074600081111     C                   ENDSR
074700081111    *** AVAILABLE PLAN NUMBER INQUIRY
074800081111    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
074900081117     C     $F11PROC      BEGSR
075000081111    ***
075100081111     C                   EXSR      $CHK_TRST
075200081111     C*
075300081111    1C                   IF        @@VT = 'N'
075400081111     C                   MOVEL(P)  M@(E#)        @@SM1
075500081111     C                   LEAVESR
075600081111    1C                   ENDIF
075700081111    ***
075800081111     C                   EXSR      $CHK_SUBD
075900081111     C*
076000081111    1C                   IF        @@VS = 'N'
076100081111     C                   MOVEL(P)  M@(E#)        @@SM1
076200081111     C                   LEAVESR
076300081111    1C                   ENDIF
076400081111    ***
076500081111     C                   EVAL      @TSAP = @T3 + @S3 + @P4
076600081111     C                   CALL      'FM014CL'
076700081111     C                   PARM                    @TSAP
076800081111    ***
076900081111    1C                   IF        %SUBST(@TSAP:8:3) = '*LR'
077000081111     C                   LEAVESR
077100081111    1C                   ENDIF
077200081111    ***
077300081111     C                   EVAL      @P4 = %SUBST(@TSAP:7:4)
077400081111     C                   MOVEL(P)  @P4           VLPLAN
077500081111     C                   EXSR      $CHK_PLAN
077600081111    1C                   IF        @@VP = 'N'
077700081111     C                   MOVEL(P)  M@(E#)        @@SM1
077800081111    1C                   ENDIF
077900081111    ***
078000081111     C                   ENDSR
078100081111      ******************************************************************
078200081111      *       SUBROUTINE - INCPLN                                      *
078300081111      *                    Increment Plan#                             *
078400081111      ******************************************************************
078500081111     C     incpln        BEGSR
078600081111      *
078700081111     C                   if        pln4 <> '9'
078800081111     C                   eval      plnx = pln4
078900081111     C                   exsr      incone
079000081111     C                   eval      pln4 = plnx
079100081111     C                   else
079200081111      *
079300081111     C                   eval      pln4 = 'A'
079400081111     C                   if        pln3 <> '9'
079500081111     C                   eval      plnx = pln3
079600081111     C                   exsr      incone
079700081111     C                   eval      pln3 = plnx
079800081111     C                   else
079900081111      *
080000081111     C                   eval      pln3 = 'A'
080100081111     C                   if        pln2 <> '9'
080200081111     C                   eval      plnx = pln2
080300081111     C                   exsr      incone
080400081111     C                   eval      pln2 = plnx
080500081111     C                   else
080600081111      *
080700081111     C                   eval      pln2 = 'A'
080800081111     C                   if        pln1 <> '9'
080900081111     C                   eval      plnx = pln1
081000081111     C                   eval      pln1 = plnx
081100081111     C                   exsr      incone
081200081111     C                   else
081300081111      *
081400081111     C                   eval      ppplan = '*LR '
081500081111     C                   leavesr
081600081111      *
081700081111     C                   endif
081800081111     C                   endif
081900081111     C                   endif
082000081111     C                   endif
082100081111      *
082200081111     C                   endsr
082300081111      ******************************************************************
082400081111      *       SUBROUTINE - INCONE                                      *
082500081111      *                    Increment 1 character by 1                  *
082600081111      ******************************************************************
082700081111     C     incone        BEGSR
082800081111      *
082900081111     C                   if        plnx >= '0' and
083000081111     C                             plnx <= '8'
083100081111     C                   movel     plnx          plnnmb
083200081111     C                   eval      plnnmb = plnnmb + 1
083300081111     C                   movel     plnnmb        plnx
083400081111     C                   leavesr
083500081111     C                   endif
083600081111      *
083700081111     C                   if        plnx = 'A'
083800081111     C                   eval      plnx = 'B'
083900081111     C                   leavesr
084000081111     C                   endif
084100081111      *
084200081111     C                   if        plnx = 'B'
084300081111     C                   eval      plnx = 'C'
084400081111     C                   leavesr
084500081111     C                   endif
084600081111      *
084700081111     C                   if        plnx = 'C'
084800081111     C                   eval      plnx = 'D'
084900081111     C                   leavesr
085000081111     C                   endif
085100081111      *
085200081111     C                   if        plnx = 'D'
085300081111     C                   eval      plnx = 'E'
085400081111     C                   leavesr
085500081111     C                   endif
085600081111      *
085700081111     C                   if        plnx = 'E'
085800081111     C                   eval      plnx = 'F'
085900081111     C                   leavesr
086000081111     C                   endif
086100081111      *
086200081111     C                   if        plnx = 'F'
086300081111     C                   eval      plnx = 'G'
086400081111     C                   leavesr
086500081111     C                   endif
086600081111      *
086700081111     C                   if        plnx = 'G'
086800081111     C                   eval      plnx = 'H'
086900081111     C                   leavesr
087000081111     C                   endif
087100081111      *   Skip I - can be confused with 1
087200081111     C                   if        plnx = 'H'
087300081111     C                   eval      plnx = 'J'
087400081111     C                   leavesr
087500081111     C                   endif
087600081111      *
087700081111     C                   if        plnx = 'J'
087800081111     C                   eval      plnx = 'K'
087900081111     C                   leavesr
088000081111     C                   endif
088100081111      *
088200081111     C                   if        plnx = 'K'
088300081111     C                   eval      plnx = 'L'
088400081111     C                   leavesr
088500081111     C                   endif
088600081111      *
088700081111     C                   if        plnx = 'L'
088800081111     C                   eval      plnx = 'M'
088900081111     C                   leavesr
089000081111     C                   endif
089100081111      *
089200081111     C                   if        plnx = 'M'
089300081111     C                   eval      plnx = 'N'
089400081111     C                   leavesr
089500081111     C                   endif
089600081111      *   Skip O - can be confused with 0
089700081111     C                   if        plnx = 'N'
089800081111     C                   eval      plnx = 'P'
089900081111     C                   leavesr
090000081111     C                   endif
090100081111      *
090200081111     C                   if        plnx = 'P'
090300081111     C                   eval      plnx = 'Q'
090400081111     C                   leavesr
090500081111     C                   endif
090600081111      *
090700081111     C                   if        plnx = 'Q'
090800081111     C                   eval      plnx = 'R'
090900081111     C                   leavesr
091000081111     C                   endif
091100081111      *
091200081111     C                   if        plnx = 'R'
091300081111     C                   eval      plnx = 'S'
091400081111     C                   leavesr
091500081111     C                   endif
091600081111      *
091700081111     C                   if        plnx = 'S'
091800081111     C                   eval      plnx = 'T'
091900081111     C                   leavesr
092000081111     C                   endif
092100081111      *
092200081111     C                   if        plnx = 'T'
092300081111     C                   eval      plnx = 'U'
092400081111     C                   leavesr
092500081111     C                   endif
092600081111      *
092700081111     C                   if        plnx = 'U'
092800081111     C                   eval      plnx = 'V'
092900081111     C                   leavesr
093000081111     C                   endif
093100081111      *
093200081111     C                   if        plnx = 'V'
093300081111     C                   eval      plnx = 'W'
093400081111     C                   leavesr
093500081111     C                   endif
093600081111      *
093700081111     C                   if        plnx = 'W'
093800081111     C                   eval      plnx = 'X'
093900081111     C                   leavesr
094000081111     C                   endif
094100081111      *
094200081111     C                   if        plnx = 'X'
094300081111     C                   eval      plnx = 'Y'
094400081111     C                   leavesr
094500081111     C                   endif
094600081111      *
094700081111     C                   if        plnx = 'Y'
094800081111     C                   eval      plnx = 'Z'
094900081111     C                   leavesr
095000081111     C                   endif
095100081111      *
095200081111     C                   if        plnx = 'Z'
095300081111     C                   eval      plnx = '0'
095400081111     C                   leavesr
095500081111     C                   endif
095600081111      *
095700081111     C                   ENDSR
095800150817     C*---------------------------------------------------------------------
095900010919     C     $STEP2        BEGSR
096000010919    ***
096100020222      /FREE
096200020222       *in31 = *off;
096300060320       // default to subdivision headings
096400060320
096500060320       ictdes = 'For This Subdivision ';
096600060320       plan#1 = ih1t + ih1b;
096700060320       plan#2 = ih2t + ih2b;
096800060320       plan#3 = ih3t + ih3b;
096900060320       plan#4 = ih4t + ih4b;
097000060320       plan#5 = ih5t + ih5b;
097100060320       plan#6 = ih6t + ih6b;
097200060320       plan#7 = ih7t + ih7b;
097300060320       plan#8 = ih8t + ih8b;
097400060320       plan#9 = ih9t + ih9b;
097500060320
097600060320       // acct override
097700060320       if vlacct <> *zero;
097800060320          chain key#ac2 ac2mst;
097900060320       if %found(ac2mst) and ac2head <> *blanks;
098000060320          clear ictdes;
098100060320          ictdes = 'For Acct ' + vlacctchar + ' Override';
098200060320          plan#1 = a2ih1t + a2ih1b;
098300060320          plan#2 = a2ih2t + a2ih2b;
098400060320          plan#3 = a2ih3t + a2ih3b;
098500060320          plan#4 = a2ih4t + a2ih4b;
098600060320          plan#5 = a2ih5t + a2ih5b;
098700060320          plan#6 = a2ih6t + a2ih6b;
098800060320          plan#7 = a2ih7t + a2ih7b;
098900060320          plan#8 = a2ih8t + a2ih8b;
099000060320          plan#9 = a2ih9t + a2ih9b;
099100060320       endif;
099200060320       endif;
099300060320
099400020222      /END-FREE
099500020222    ***
099600010920    1C                   IF        @@A = 'A'
099700020306     C                   eval      *in26 = *off
099800020521     C                   EVAL      VGRRMT = 'B'
099900071102     C                   EVAL      Vrndprm = 'N'
100000020220     C                   EXSR      $PREPHST
100100020220     C                   CLEAR                   DS@BASE
100200020220     C                   MOVEL     DS@BASE       HBEFORE
100300010920    1C                   ELSE
100400020222    2C                   IF        PLDLTD = 'A'
100500020222     C                   eval      *in26 = *off
100600020222    2C                   ELSE
100700020222     C                   eval      *in26 = *on
100800020222    2C                   ENDIF
100900020306     C                   EXSR      $FMT2SCR
101000010920    1C                   ENDIF
101100010920    ***
101200010920     C                   MOVE      'STEP3'       @STEP
101300010920    ***
101400010920     C                   ENDSR
101500150817     C*---------------------------------------------------------------------
101600010920     C     $FMT2SCR      BEGSR
101700010920    ***
101800010920     C                   EXSR      $PREPHST
101900010920     C                   MOVEL     DS@BASE       HBEFORE
102000010920    ***
102100010920     C                   CLEAR                   SCREEN@DS
102200010920     C                   MOVEL     DS@BASE       SCREEN@DS
102300050927      *
102400050927     C     KEY#PLAN      Chain     OEPLAN
102500050927     C                   If        Not %Found(OEPLAN)
102600050927     C                   Z-add     13            E#
102700050927     C                   Eval      *In42    =    *On
102800050928     C                   Eval      *In58    =    *On
102900050927     C                   Else
103000050927     C                   Eval      WDESC    =    %Trim(ODESC)
103100051212     C*************      Eval      WACCT    =    OACCT
103200051213     C*************      Eval      ADESC     =   %Trim(ACNAM1)
103300050927     C                   End
103400020213    ***
103500020213     C     PCARR         CHAIN(N)  CARMSR
103600020213    1C                   IF        NOT %FOUND(CARMST)
103700020213     C                   EVAL      O_CNAME = '*UNKNOWN'
103800020213    1C                   ENDIF
103900060703     C                   If        CGAONLY  =    'Y'
104000060703     C                   Eval      *In37    =    *On
104100060703     C                   Else
104200060703     C                   Eval      *In37    =    *Off
104300060703     C                   End
104400020213    ***
104500010925     C                   MOVE      PLNCAT        ZLNCAT
104600120123     C**                 MOVE      PRENEW        #ISO
104700120123     C**                 MOVE      #ISO          #USA
104800120123     C**                 MOVE      #USA          ZRENEW
104900120124     c                   move      prenew        zrenewmm
105000120123
105100010920     C     REMITP        MULT      10            ZEMITP
105200010920     C                   DO        20            N#
105300010920     C                   Z-ADD     SCF(N#)       SFR(N#)
105400010920     C                   Z-ADD     SCT(N#)       STO(N#)
105500010920     C                   ENDDO
105600010920    ***
105700010920     C                   ENDSR
105800150817     C*---------------------------------------------------------------------
105900010920     C     $PREPHST      BEGSR
106000010920    ***
106100010920     C                   CLEAR                   RPLNHIST
106200010920     C                   MOVE      VLTRST        HFTRST
106300010920     C                   MOVE      VLSUB#        HFSUB#
106400010920     C                   MOVEL     VLPLAN        HFPLAN
106500010920     C                   CLEAR                   @TIMESTAMP
106600020219     C                   MOVE      *BLANKS       @TS40
106700010920     C                   CALL      'TIMESTMP'
106800010920     C                   PARM                    @TS40
106900010920     C                   MOVEL     @TS40         @TIMESTAMP
107000010920     C                   MOVEL     @TSUSER       HUSERID
107100010920     C                   MOVE      #TSCYMD       HDATE
107200010920     C                   MOVE      #TSTIME       HTIME
107300020212     C                   MOVEL     @TSJOB        HJOB
107400010920     C                   MOVE      #TSNBR        HNUMBER
107500010919    ***
107600010919     C                   ENDSR
107700150817     C*---------------------------------------------------------------------
107800010919     C     $STEP3        BEGSR
107900010919    ***
108000101012      * CAB and Care First allow F5 - Class
108100101012
108200101012CLS  C                   IF        VCARR = 'CAB' OR CARBC = 'D'
108300160418  172c                             or VCARR = 'NAD' or VCARR = 'NAE'
108400170609     C                             or vCarr = 'GAD' or vCarr = 'GAL'
108500170609     C                             or vCarr = 'GAR'
108600170609CLS  C                   MOVE      *ON           *IN31
108700020419CLS  C                   ELSE
108800020212     C                   MOVE      *OFF          *IN31
108900020419CLS  C                   ENDIF
109000140116      *
109100140116     C                   eval      *in85 = '0'
109200140116     C     KEY#PLAN      setll     mcovl1                             86
109300140116     C                   dou       *in86 = '1'
109400140116     C     KEY#PLAN      reade     mcovl1                                 86
109500140116     C                   IF        *In86 = '1'
109600140116     C                   leave
109700140116     C                   endif
109800140116      *
109900140116     C                   if        enrldt <> candt
110000140116     C                   eval      *in85 = '1'
110100140116     C                   leave
110200140116     C                   endif
110300140116      *
110400140116     C                   enddo
110500140213    * *
110600140213     C***                if        svrenewyy <> 0
110700140213     C**                 eval      zrenewyy = svrenewyy
110800140213     C**                 endif
110900140213    * *
111000140116      *
111100010919     C                   MOVEL     @@SM2         SMSG2
111200150817     C                   write     Cmd01
111300010919     C                   EXFMT     IO02
111400020404     C                   MOVE      *OFF          *IN81
111500010919     C                   MOVE      *BLANKS       @@SM2
111600010919     C                   MOVE      *BLANKS       SMSG2
111700010919     C                   MOVE      *ZEROS        E#
111800010925     C                   MOVE      *BLANKS       @@ER
111900010919    *** FX KEYS
112000010919    1C                   SELECT
112100020218    1C                   WHEN      FKEY = F1
112200020213     C                   MOVEL(P)  'PREP1'       @STEP
112300010919     C                   LEAVESR
112400020222    1C                   WHEN      FKEY = F7
112500020222     C                   MOVEL(P)  'LEAVE'       @STEP
112600020222     C                   LEAVESR
112700020419CLS 1C                   WHEN      FKEY = F5
112800020419CLS  C                   EXSR      $F5CLASS
112900020419CLS  C                   LEAVESR
113000010919    1C                   WHEN      FKEY = F9
113100010919     C                   EXSR      $F9CARRIER
113200010919     C                   LEAVESR
113300010919    1C                   WHEN      FKEY = F10
113400010919     C                   EXSR      $F10CATEG
113500010919     C                   LEAVESR
113600090213    1C                   WHEN      FKEY = F11
113700090213     C                   EXSR      $F11debit
113800090213     C                   LEAVESR
113900020219    1C                   WHEN      FKEY = F8
114000020219     C                   EXSR      $F8HIST
114100010919     C                   LEAVESR
114200130501    1C                   WHEN      FKEY = F13
114300130501     C                   EXSR      $F13AUX
114400130501     C                   LEAVESR
114500020219    1C                   WHEN      FKEY = F6
114600020219     C                   EXSR      $F6HNOTE
114700010924     C                   LEAVESR
114800010919    1C                   WHEN      FKEY = F4
114900010919     C                   EXSR      $F4ACTDEL
115000010919     C                   LEAVESR
115100010919    1C                   ENDSL
115200010919    ***
115300010919     C                   EXSR      $VALIDS02
115400010920     C*
115500010925    1C                   IF        @@ER = 'E'
115600020404     C                   MOVE      *ON           *IN81
115700010920     C                   MOVEL(P)  M@(E#)        @@SM2
115800020222     C                   else
115900020306     C                   EXSR      $CONFIRM
116000010925    1C                   ENDIF
116100010920     C*
116200010920    ***
116300010919     C                   ENDSR
116400150817     C*---------------------------------------------------------------------
116500020419CLS  C     $F5CLASS      BEGSR
116600020411CLS ****
116700020419CLS  C                   CLEAR                   @90
116800020419CLS  C                   CLEAR                   @PARMDS
116900020419CLS  C                   MOVE      VLTRST        P@TRS
117000020419CLS  C                   MOVE      VLSUB#        P@SUB
117100020419CLS  C                   MOVEL(P)  VLPLAN        P@PLN
117200020419CLS  C                   MOVEL(P)  O_TNAME       P@TD
117300020419CLS  C                   MOVEL(P)  O_SNAME       P@SD
117400020419CLS  C                   MOVEL(P)  VDESCR        P@PD
117500020419CLS  C                   MOVEL     @PARMDS       @90
117600020419CLS ****
117700020419CLS  C                   CALL      'FM032R'
117800020419CLS  C                   PARM                    @90
117900020419CLS ****
118000020419CLS  C                   ENDSR
118100150817     C*---------------------------------------------------------------------
118200130501CLS  C     $F13AUX       BEGSR
118300130501CLS ****
118400130501CLS  C                   CLEAR                   @10
118500140212CLS  C                   CLEAR                   @P4DS
118600130501CLS  C                   MOVE      VLTRST        P@TRS3
118700130501CLS  C                   MOVE      VLSUB#        P@SUB3
118800130501CLS  C                   MOVEL(P)  VLPLAN        P@PLN3
118900140212CLS  C                   MOVEL(P)  zrenewyy      P@YR3
119000140212CLS  C                   MOVEL     @P4DS         @10
119100130501CLS ****
119200130501CLS  C                   CALL      'FM035CL'
119300130501CLS  C                   PARM                    @10
119400130501CLS ****
119500130501CLS  C                   ENDSR
119600150817     C*---------------------------------------------------------------------
119700010919     C     $F9CARRIER    BEGSR
119800010919    ***
119900010919     C                   MOVE      *BLANKS       @3
120000010919    ***
120100010919     C                   CALL      'FM002CL'
120200010919     C                   PARM                    @3
120300010919    ***
120400010919    1C                   IF        @3 = '*LR'
120500020306     C                   LEAVESR
120600010919    1C                   ELSE
120700010919     C                   MOVEL     @3            VCARR
120800010919    1C                   ENDIF
120900010919    ***
121000010919     C                   ENDSR
121100150817     C*---------------------------------------------------------------------
121200010919     C     $F10CATEG     BEGSR
121300010919    ***
121400010919     C                   MOVEL(P)  'P'           @3
121500010919    ***
121600010919     C                   CALL      'FM001CL'
121700010919     C                   PARM                    @3
121800010919    ***
121900010919    1C                   IF        @3 = '*LR'
122000020306     C                   LEAVESR
122100010919    1C                   ELSE
122200010925     C                   MOVE      @3            ZLNCAT
122300010919    1C                   ENDIF
122400010919    ***
122500010919     C                   ENDSR
122600090213   S* *********************************************
122700090213   S* * show debit card choices
122800090213   S* *********************************************
122900090213   S* *
123000090213     C     $F11debit     BEGSR
123100090213    *
123200090213     C                   MOVEL(P)  'a'           @3
123300090213     C                   CALL      'FM001CL'
123400090213     C                   PARM                    @3
123500090213    *
123600090213    1C                   IF        @3 = '*LR'
123700090213     C                   LEAVESR
123800090213    1C                   ELSE
123900090213     C                   MOVE      @3            vdebit
124000090213    1C                   ENDIF
124100090213    *
124200090213     C                   ENDSR
124300150817     C*------------------------------------------------------------
124400020219     C     $F8HIST       BEGSR
124500010919    ***
124600020213     C                   CLEAR                   @50
124700020213     C                   CLEAR                   @P2DS
124800020213     C                   MOVE      VLTRST        P@TRS2
124900020213     C                   MOVE      VLSUB#        P@SUB2
125000020213     C                   MOVEL(P)  VLPLAN        P@PLN2
125100020213     C                   MOVEL(P)  O_TNAME       P@TD2
125200020213     C                   MOVEL(P)  O_SNAME       P@SD2
125300020213     C                   MOVEL     @P2DS         @50
125400010919     C                   CALL      'FM031R'
125500020213     C                   PARM                    @50
125600010919    ***
125700010919     C                   ENDSR
125800150817     C*---------------------------------------------------------------------
125900020219     C     $F6HNOTE      BEGSR
126000010924    ***
126100020218     C                   DOU       FKEY = F1
126200010924     C                   EXFMT     W01
126300010924     C                   ENDDO
126400010924    ***
126500010924     C                   ENDSR
126600150817     C*---------------------------------------------------------------------
126700010919     C     $F4ACTDEL     BEGSR
126800010919    ***
126900010920    1C                   IF        VLDLTD = 'A'
127000010919     C                   MOVE      'D'           VLDLTD
127100020222     C                   eval      *in26 = *on
127200010920    1C                   ELSE
127300010919     C                   MOVE      'A'           VLDLTD
127400020222     C                   eval      *in26 = *off
127500010920    1C                   ENDIF
127600010919    ***
127700010919     C                   ENDSR
127800150817     C*---------------------------------------------------------------------
127900010919     C     $VALIDS02     BEGSR
128000010919    ***
128100020306     C                   MOVEA     '0000000000'  *IN(40)
128200020306     C                   MOVEA     '0000000000'  *IN(50)
128300020219     C                   MOVE      'E'           @@ER
128400020213     C                   MOVE      *BLANKS       O_CNAME
128500010919    ***
128600010919    1C                   IF        VDESCR = *BLANKS
128700010919     C                   Z-ADD     11            E#
128800090129     C                   EVAL      *IN40 = *ON
128900010919     C                   LEAVESR
129000010919    1C                   ENDIF
129100050929     C**
129200070613     C***  KEY#ACC       CHAIN(N)  ACCMSR
129300070613    1C***                IF        NOT %FOUND(ACCMST)
129400070613     C***                Z-ADD     36            E#
129500070613     C***                EVAL      *IN58 = *ON
129600070613     C***                LEAVESR
129700070613    1C***                ENDIF
129800010919    ***
129900120123    *** 1/23/12 - change renwal date to renewal month only
130000120123     C**                 MOVE      ZRENEW        #USO
130100120123     C**                 EXSR      $USAISO
130200120123    1C**                 IF        @@VDTE = 'N'
130300120123     C**                 Z-ADD     14            E#
130400120123     C**                 EVAL      *IN43 = *ON
130500120123     C**                 LEAVESR
130600120123    1C**                 ENDIF
130700120123     C**                 MOVE      #USO          #RENEW
130800010919     C*
130900120123      * renewal month must be 01-12
131000120123    1C                   IF        zrenewmm < 01 or zrenewmm > 12
131100120123     C                   Z-ADD     14            E#
131200120123     C                   EVAL      *IN43 = *ON
131300120123     C                   LEAVESR
131400120123    1C                   ENDIF
131500120123
131600010919    ***
131700010919    1C                   IF        VCARR = *BLANKS
131800010919     C                   Z-ADD     15            E#
131900020306     C                   EVAL      *IN44 = *ON
132000010919     C                   LEAVESR
132100010919    1C                   ENDIF
132200010919     C*
132300010919     C     VCARR         CHAIN(N)  CARMSR
132400010919    1C                   IF        NOT %FOUND(CARMST)
132500010919     C                   Z-ADD     15            E#
132600020306     C                   EVAL      *IN44 = *ON
132700010919     C                   LEAVESR
132800010919    1C                   ENDIF
132900020213     C                   EVAL      O_CNAME = %SUBST(CNAME:1:12)
133000010921     C*
133100010921    1C                   IF        CADLTD <> 'A'
133200010921     C                   Z-ADD     15            E#
133300020306     C                   EVAL      *IN44 = *ON
133400010921     C                   LEAVESR
133500010921    1C                   ENDIF
133600140128     C*/////
133700140128     C*           If Carrier chgd - set ACA flag based on CARMST2P
133800140128     C     VCARR         CHAIN(N)  CARMST2P
133900140128    1C                   IF        %FOUND(CARMST2P)
134000170104     C     key#plan      CHAIN     plnauxp
134100140131    1C                   IF        %FOUND(plnauxp)
134200150126    1C                   IF        c2acart = 'N' and
134300150126    1C                             (pxacar <> 'N')
134400150126    1C                   eval      pxacar = 'N'
134500140128     C                   update    plnauxr
134600150126     C                   else
134700150126    1C                   IF        c2acart = 'Y' and
134800150126    1C                             (pxacar = 'N')
134900150126    1C                   eval      pxacar = 'Y'
135000150126     C                   update    plnauxr
135100140128     C                   endif
135200150126     C                   endif
135300180320
135400180320
135500180320br02  * Unlock PlnAuxp if neither of the 2 conditions above are met.
135600180320     C                   Unlock    PlnAuxp
135700180320
135800140128    1C                   endif
135900140128    1C                   endif
136000140312      * renewal year must be entered for ACA plan add
136100140312    1C                   IF        *in36 = '1'
136200140212    1C                   IF        c2acart = 'Y' and zrenewyy = 0 or
136300140212    1C                             c2acart = 'Y' and zrenewyy < 2014
136400140212     C                   Z-ADD     40            E#
136500140213     C                   EVAL      *IN41 = *ON
136600140212     C                   LEAVESR
136700140212    1C                   ENDIF
136800140312    1C                   ENDIF
136900140213    * *
137000140213     C****               if        zrenewyy <> 0
137100140213     C**                 eval      svrenewyy = zrenewyy
137200140213     C*****              endif
137300140213    * *
137400140212
137500140128     C*////
137600090129      * validate debit card
137700090129
137800090213     c                   if        vdebit <> ' '
137900090213     C                   MOVE      'a'           KEY@TYPE
138000090213     C                   clear                   KEY@CODE
138100090213     C                   MOVE      vdebit        KEY@CODE
138200090213     C     KEY@CODES     CHAIN(N)  CODESR
138300090213    1C                   IF        NOT %FOUND(CODES)
138400090129     C                   Z-ADD     38            E#
138500090129     C                   EVAL      *IN82 = *ON
138600090129     C                   LEAVESR
138700090129     c                   end
138800090213     c                   end
138900090129
139000090129
139100101012CLS 1C                   IF        VCARR = 'CAB' OR CARBC = 'D'
139200021003CLS  C     KEY#PLAN      CHAIN(N)  FCLASS
139300021003CLS 2C                   IF        NOT %FOUND(CLASS)
139400101012CLS 1C                   IF        VCARR = 'CAB'
139500021003CLS  C                   Z-ADD     31            E#
139600021003     C                   ELSE
139700021003CLS  C                   Z-ADD     34            E#
139800021003     C                   ENDIF
139900020419CLS  C                   EVAL      *IN44 = *ON
140000020419CLS  C                   LEAVESR
140100020419CLS 2C                   ENDIF
140200020419CLS 1C                   ENDIF
140300010919    ***
140400020222    1C                   IF        VNVCOL = *BLANKS OR (VNVCOL <> '1' AND
140500020222     C                             VNVCOL <> '2' AND VNVCOL <> '3' AND
140600020222     C                             VNVCOL <> '4' AND VNVCOL <> '5' AND
140700020222     C                             VNVCOL <> '6' AND VNVCOL <> '7' AND
140800020222     C                             VNVCOL <> '8' AND VNVCOL <> '9')
140900020222     C                   Z-ADD     16            E#
141000020306     C                   EVAL      *IN45 = *ON
141100020222     C                   LEAVESR
141200020222    1C                   ENDIF
141300020222    ***
141400051214     C*                  IF        (VNVCOL = '1' AND plan#1 = *BLANKS) or
141500051214     C*                            (VNVCOL = '2' AND plan#2 = *BLANKS) or
141600051214     C*                            (VNVCOL = '3' AND plan#3 = *BLANKS) or
141700051214     C*                            (VNVCOL = '4' AND plan#4 = *BLANKS) or
141800051214     C*                            (VNVCOL = '5' AND plan#5 = *BLANKS) or
141900051214     C*                            (VNVCOL = '6' AND plan#6 = *BLANKS) or
142000051214     C*                            (VNVCOL = '7' AND plan#7 = *BLANKS) or
142100051214     C*                            (VNVCOL = '8' AND plan#8 = *BLANKS) or
142200051214     C*                            (VNVCOL = '9' AND plan#9 = *BLANKS)
142300051214     C*                  Z-ADD     16            E#
142400051214     C*                  EVAL      *IN45 = *ON
142500051214     C*                  LEAVESR
142600051214    1C*                  ENDIF
142700020306     C*
142800020306    1C                   IF        (@@FR <> *ALL'0' OR @@TO <> *ALL'0')
142900020306     C                             AND VABFL = 'N'
143000020328     C                   Z-ADD     18            E#
143100020306     C                   LEAVESR
143200020306    1C                   ENDIF
143300020306     C*
143400020306     C                   IF        VABFL <> 'N' AND
143500020306     C                             (@@FR = *ALL'0' OR @@TO = *ALL'0')
143600020328     C                   Z-ADD     6             E#
143700020604     C**warning*message**LEAVESR
143800020306    1C                   ENDIF
143900020222    ***
144000110824    1C                   IF        (VABFL <> 'N' AND
144100010920     C                             VABFL <> 'M' AND VABFL <> 'R') OR
144200010920     C                             VABFL = *BLANKS
144300010920     C                   Z-ADD     17            E#
144400020306     C                   EVAL      *IN46 = *ON
144500010920     C                   LEAVESR
144600010920    1C                   ENDIF
144700010919    ***
144800010925    1C                   IF        ZLNCAT = *BLANKS
144900010920     C                   Z-ADD     19            E#
145000020306     C                   EVAL      *IN47 = *ON
145100010920     C                   LEAVESR
145200010920    1C                   ENDIF
145300010920     C*
145400010920     C                   MOVE      'P'           KEY@TYPE
145500010925     C                   MOVEL(P)  ZLNCAT        KEY@CODE
145600010920     C     KEY@CODES     CHAIN(N)  CODESR
145700010920    1C                   IF        NOT %FOUND(CODES)
145800010920     C                   Z-ADD     19            E#
145900020306     C                   EVAL      *IN47 = *ON
146000010920     C                   LEAVESR
146100010920    1C                   ENDIF
146200040803
146300040803      * active category ?
146400040803    1C                   IF        cddltd <> 'A'
146500040803     C                   Z-ADD     35            E#
146600040803     C                   EVAL      *IN47 = *ON
146700040803     C                   LEAVESR
146800040803    1C                   ENDIF
146900040803
147000010920    1C                   IF        VRTYPE = *BLANKS OR (VRTYPE <> 'P' AND
147100010920     C                             VRTYPE <> 'R')
147200010920     C                   Z-ADD     20            E#
147300020306     C                   EVAL      *IN48 = *ON
147400010920     C                   LEAVESR
147500010920    1C                   ENDIF
147600010919    ***
147700010920    1C                   IF        VEMITF = *BLANKS OR
147800010920     C                             (VEMITF <> 'A' AND VEMITF <> 'L' AND
147900010920     C                             VEMITF <> 'M' AND VEMITF <> 'N')
148000010920     C                   Z-ADD     21            E#
148100020306     C                   EVAL      *IN49 = *ON
148200010920     C                   LEAVESR
148300010920    1C                   ENDIF
148400010920     C*
148500020219     C     ZEMITP        MULT      .1            #REMITP
148600010920    ***
148700010920    1C                   IF        VFADM = *BLANKS OR (VFADM <> 'N' AND
148800090430     C                             VFADM <> 'Y')
148900010920     C                   Z-ADD     23            E#
149000020306     C                   EVAL      *IN51 = *ON
149100010920     C                   LEAVESR
149200010920    1C                   ENDIF
149300010920    ***
149400010920    1C                   IF        VGRRMT = *BLANKS OR (VGRRMT <> 'N' AND
149500010920     C                             VGRRMT <> 'B')
149600010920     C                   Z-ADD     24            E#
149700020306     C                   EVAL      *IN52 = *ON
149800010920     C                   LEAVESR
149900010920    1C                   ENDIF
150000010920    ***
150100020213    1C                   IF        VRTYPE = 'R' AND VAXBEN <= 0
150200010920     C                   Z-ADD     25            E#
150300020306     C                   EVAL      *IN53 = *ON
150400010920     C                   LEAVESR
150500010920    1C                   ENDIF
150600010920    ***
150700020212    1C                   IF        ZLNCAT  = 'LF' AND VAXBEN = 0 AND VULT = 0
150800010920     C                   Z-ADD     26            E#
150900020306     C                   EVAL      *IN47 = *ON
151000020306     C                   EVAL      *IN56 = *ON
151100020306     C                   EVAL      *IN53 = *ON
151200010920     C                   LEAVESR
151300010920    1C                   ENDIF
151400010920    ***
151500010920    1C                   IF        VRNDFL <> *BLANKS AND VRNDFL <> 'U' AND
151600010920     C                             VRNDFL <> 'D'
151700010920     C                   Z-ADD     27            E#
151800020306     C                   EVAL      *IN54 = *ON
151900010920     C                   LEAVESR
152000010920    1C                   ENDIF
152100071102
152200071102    * * edit round premium field
152300071102    1C                   if        vrndprm <> 'Y' AND vrndprm <> 'N'
152400071102     C                   Z-ADD     37            E#
152500071102     C                   EVAL      *IN59 = *ON
152600071102     C                   LEAVESR
152700071102    1C                   ENDIF
152800071102    ***
152900010920    1C                   IF        VOUND <> 0 AND VOUND <> 1 AND VOUND <> 10
153000010920     C                             AND VOUND <> 100 AND VOUND <> 1000 AND
153100010920     C                             VOUND <> 10000
153200010920     C                   Z-ADD     28            E#
153300020306     C                   EVAL      *IN55 = *ON
153400010920     C                   LEAVESR
153500010920    1C                   ENDIF
153600010920    ***
153700010920     C                   EXSR      $CHKSAL
153800010920    1C                   IF        @@VSAL = 'N'
153900020306     C                   EVAL      *IN54 = *ON
154000020306     C                   EVAL      *IN56 = *ON
154100020306     C                   EVAL      *IN55 = *ON
154200010920     C                   Z-ADD     29            E#
154300010920     C                   LEAVESR
154400010920    1C                   ENDIF
154500020328    ***
154600020328    1C                   IF        VCP_REQ <> 'Y' AND VCP_REQ <> 'N'
154700020328     C                   Z-ADD     33            E#
154800020328     C                   EVAL      *IN57 = *ON
154900020328     C                   LEAVESR
155000020328    1C                   ENDIF
155100121212    ***
155200121212    1C                   IF        VFILL1 <> 'Y' AND VFILL1 <> ' '
155300121212     C                   Z-ADD     39            E#
155400121212     C                   EVAL      *IN58 = *ON
155500121212     C                   LEAVESR
155600121212    1C                   ENDIF
155700010920    ***
155800020219     C                   MOVE      'G'           @@ER
155900010920    ***
156000010919     C                   ENDSR
156100150817     C*---------------------------------------------------------------------
156200010920     C     $CHKSAL       BEGSR
156300010920    ***
156400020219     C                   MOVE      'Y'           @@VSAL
156500010920    ***
156600010920     C                   IF        VULT = 0 AND VOUND = 0 AND VRNDFL = *BLANKS
156700010920     C                   LEAVESR
156800010920     C                   ENDIF
156900010920    ***
157000010920     C                   IF        VULT <> 0 AND VOUND <> 0 AND
157100010920     C                             VRNDFL <> *BLANKS
157200010920     C                   LEAVESR
157300010920     C                   ENDIF
157400010920    ***
157500010920     C                   MOVE      'N'           @@VSAL
157600010920    ***
157700010920     C                   ENDSR
157800150817     C*---------------------------------------------------------------------
157900010919     C     $USAISO       BEGSR
158000010919    ***
158100020219     C                   MOVE      'N'           @@VDTE
158200010919    ***
158300010919     C                   IF        #USO = 0
158400010919     C                   LEAVESR
158500010919     C                   ENDIF
158600010919    ***
158700010919     C     *USA          TEST(DE)                #USO
158800010919     C                   IF        %ERROR
158900010919     C                   LEAVESR
159000010919     C                   ENDIF
159100010919    ***
159200010919     C                   MOVE      #USO          #USA
159300010919     C                   MOVE      #USA          #ISO
159400010919     C                   MOVE      #ISO          #USO
159500010919     C                   MOVE      'Y'           @@VDTE
159600010919    ***
159700010919     C                   ENDSR
159800150817     C*---------------------------------------------------------------------
159900010920     C     $CONFIRM      BEGSR
160000010920    ***
160100020306     C                   IF        VABFL <> 'N'
160200020222     C                   MOVEL(P)  'STEP4'       @STEP
160300020222     C                   LEAVESR
160400020222    1C                   ENDIF
160500020222    ***
160600020222     C                   EXSR      $UPDATES
160700020222    ***
160800020222     C                   ENDSR
160900150817     C*---------------------------------------------------------------------
161000020222     C     $UPDATES      BEGSR
161100020222    ***
161200120123     C**                 Z-ADD     #RENEW        VRENEW
161300120123     C                   Z-ADD     zrenewmm      VRENEWmm          2 0
161400010920     C                   Z-ADD     #REMITP       VEMITP
161500010920     C                   MOVE      *ZEROS        N#
161600020222    1C                   DO        20            N#
161700010920     C                   Z-ADD     SFR(N#)       SCF(N#)
161800020222     C                   Z-ADD     STO(N#)       SCT(N#)
161900020222    1C                   ENDDO
162000010925     C                   MOVEL     SCREEN@DS     DS@BASE
162100010925     C     'P'           CAT(P)    ZLNCAT:0      PLNCAT
162200121212     C                   EVAL      PFILL1 = VFILL1
162300120123
162400120123      * put screen renewal month back in original file field
162500120124     c                   z-add     zrenewmm      prenew
162600120123
162700020222    1C                   IF        @@A = 'C'
162800020222    2C                   IF        HAFTER = HBEFORE
162900020222     C                   EVAL      @@SM1 = 'NO CHANGE DETECTED; UPDATE NOT DONE'
163000020222     C                   MOVEL(P)  'STEP2'       @STEP
163100020220     C                   UNLOCK    PLNMST
163200020220     C                   LEAVESR
163300020222    2C                   ELSE
163400020220     C                   MOVEL     DS@BASE       HAFTER
163500010920     C                   WRITE     RPLNHIST
163600010920     C                   UPDATE    PLNMSR
163601200221       exsr updateUHC;
163700010920     C                   EVAL      @@SM1 = 'UPDATE PROCESSED'
163800010920     C                   MOVEL(P)  'PREP1'       @STEP
163900020222    2C                   ENDIF
164000020222    1C                   ELSE
164100020220     C                   EVAL      PLDLTD = 'A'
164200030611     C***                EVAL      PCP_REQ = 'N'
164300121212     C                   EVAL      PCP_REQ = VCP_REQ
164400121212     C                   EVAL      PFILL1 = VFILL1
164500020220     C                   MOVEL     DS@BASE       HAFTER
164600020218     C                   WRITE     RPLNHIST
164700020218     C                   WRITE     PLNMSR
164800130614      *>>>>>>
164900130614     C                   exsr      $f13aux
165000130614      *>>>>>>
165100020218     C                   EVAL      @@SM1 = 'RECORD ADDED'
165200020218     C                   MOVEL(P)  'PREP1'       @STEP
165300020222    1C                   ENDIF
165400050927     C     KEY#PLAN      Chain     OEPLAN
165500050927     C                   Eval      OTRST    =    KEY@TRS
165600050927     C                   Eval      OSUB#    =    KEY@SUB
165700050927     C                   Eval      OPLAN    =    KEY@PLN
165800050927     C                   Eval      ODESC    =    %Trim(WDESC)
165900051212     C************       Eval      OACCT    =    WACCT
166000050927     C                   If        Not %Found(OEPLAN)
166100050927     C                   Write     OEPLANR
166200050927     C                   Else
166300050927     C                   Update    OEPLANR
166400050927     C                   End
166500010920    ***
166600010920     C                   ENDSR
166700150817     C*---------------------------------------------------------------------
166800010920     C     $STEP4        BEGSR
166900010920    ***
167000010924     C                   MOVEL     @@SM4         SMSG4
167100010924     C                   EXFMT     IO04
167200020404     C                   MOVE      *OFF          *IN81
167300010924     C                   MOVE      *BLANKS       @@SM4
167400010924     C                   MOVE      *BLANKS       SMSG4
167500010924     C                   MOVE      *ZEROS        E#
167600010924    ***
167700020222    1C                   SELECT
167800020222    1C                   WHEN      FKEY = F1
167900020222     C                   MOVEl     'STEP3'       @STEP
168000020222     C                   LEAVESR
168100020404     C                   ENDSL
168200020404    ***
168300020222     C                   EXSR      $AGBEDTS
168400020222    2C                   IF        @@SM4 = *blanks
168500020222     C                   EXSR      $UPDATES
168600020222     C                   MOVEL(P)  'PREP1'       @STEP
168700020404     C                   ELSE
168800020404     C                   MOVE      *ON           *IN81
168900020222    2C                   ENDIF
169000010924    ***
169100020222     C                   ENDSR
169200150817     C*---------------------------------------------------------------------
169300020222     C     $AGBEDTS      BEGSR
169400020222    ***
169500020306     C                   MOVEA     '0000000000'  *IN(60)
169600020306     C                   MOVEA     '0000000000'  *IN(70)
169700020306    ***
169800020306     C                   IF        @@FR = *ALL'0' OR @@TO = *ALL'0'
169900020306     C                   MOVEA     M@(6)         @@SM4
170000010924     C                   LEAVESR
170100010924    1C                   ENDIF
170200010924     C*
170300010924    1C                   IF        VABFL <> 'N'
170400010924     C                   EXSR      $CHKBANDS
170500010924    2C                   IF        @@VB = 'N'
170600020306     C                   EVAL      *IN(59 + N#) = *ON
170700010924    2C                   ENDIF
170800010924    1C                   ENDIF
170900010920    ***
171000010920     C                   ENDSR
171100150817     C*---------------------------------------------------------------------
171200020306     C     $CHKBANDS     BEGSR
171300020306    ***
171400020306     C                   CLEAR                   CLR@SPAN
171500020306     C                   MOVE      'N'           @@VB
171600020306     C                   MOVE      *ZEROS        N#
171700020306     C                   MOVE      'N'           @FLAG
171800020306    ***
171900020306    1C                   DOU       @FLAG = 'Y' OR N# = 20
172000020306     C*
172100020306     C                   ADD       1             N#
172200020306     C*
172300020306     C                   IF        SFR(N#) = 0 AND STO(N#) = 0
172400020306     C                   ITER
172500020306     C                   ENDIF
172600020306     C*
172700020306    2C                   SELECT
172800020306    2C                   WHEN      SFR(N#) = 0 AND STO(N#) <> 0
172900020306     C                   MOVEA     M@(7)         @@SM4
173000020306     C                   LEAVESR
173100020306    2C                   WHEN      SFR(N#) <> 0 AND STO(N#) = 0
173200020306     C                   MOVEA     M@(8)         @@SM4
173300020306     C                   LEAVESR
173400020306    2C                   WHEN      SFR(N#) > 150 OR STO(N#) > 150
173500020306     C                   MOVEA     M@(9)         @@SM4
173600020306     C                   LEAVESR
173700130515
173800130515      * 5/14/13 - change to allow from ab = to ab
173900130515    2C                   WHEN      SFR(N#) >  STO(N#)
174000020306     C                   MOVEA     M@(10)        @@SM4
174100020306     C                   LEAVESR
174200020306    2C                   ENDSL
174300020306     C*
174400020306    2C                   IF        SFR(N#) <> 0 AND STO(N#) <> 0
174500020306     C*
174600020306     C                   Z-ADD     SFR(N#)       P#
174700020306     C*
174800020306    3C                   DOU       P# > STO(N#)
174900020306     C*
175000020306    4C                   IF        SPAN@(P#) <> *BLANKS
175100020306     C                   MOVEA     M@(32)        @@SM4
175200020306     C                   LEAVESR
175300020306    4C                   ENDIF
175400020306     C*
175500020306     C                   MOVEA     'X'           SPAN@(P#)
175600020306     C                   ADD       1             P#
175700020306     C*
175800020306    3C                   ENDDO
175900020306     C*
176000020306    2C                   ENDIF
176100020306     C*
176200020306    1C                   ENDDO
176300020306    ***
176400020306     C                   MOVE      'Y'           @@VB
176500020306    ***
176600020306     C                   ENDSR
176601200221      //=======================================================================
176602200221      // update UHC files
176603200221      //=======================================================================
176604200221
176605200221       begsr updateUHC;
176606200221
176607200224        if not %open(uhcplancrt);
176608200224         open uhcplancrt;
176609200224        endif;
176610200224
176611200221        chain (pltrst : plsub# : pxacct : plplan) uhcPlncrt;
176612200221        if %found;
176613200221
176614200221         chain ('9000000290' : pltrst : plsub# : pxacct : plplan) uhcPlan;
176615200221         if %found;
176616200221
176617200221          if plncat = 'PMM';
176618200221           poss = %scan('(':pdescr:1);
176619200221
176620200221           if poss > 0;
176621200221            poss2 = %scan(')':pdescr:poss);
176622200221             lenght = poss2 - poss - 1;
176624200221             poss = poss + 1;
176625200221            cpcid5 = %subst(pdescr:poss:lenght);
176626200221           endif;
176627200221
176628200221           update uhcPlan;
176667200221          endif;
176669200221
176670200221         endif;
176671200221
176672200221        endif;
176673200221
176674200221        unlock carplnz;
176675200224        if %open(uhcplancrt);
176676200224         close uhcplancrt;
176677200224        endif;
176678200224
176679200221       endsr;
176680200221
176681200221      //=======================================================================
176800020222000000*00111111111122222222223333333333444444
176900020222123456*89012345678901234567890123456789012345
177000010920** M@ CTDATA
177100010925TRUST NUMBER CANNOT BE ZERO
177200010925TRUST NUMBER IS NOT ON MASTER FILE
177300010925SUBDIVISION NUMBER CANNOT BE ZERO
177400010925TRUST/SUB IS NOT ON SUBDIVISION MASTER FILE
177500020222PLAN NUMBER IS BLANK, REQUIRED VALUE
177600020306AGE BANDS REQ FOR FLAG <> 'N'
177700020306FROM RANGE =  0 & TO RANGE <> 0
177800020306FROM RANGE <> 0 & TO RANGE =  0
177900020306FROM OR TO RANGE IS > 150
178000130515FROM RANGE > TO RANGE
178100010925PLAN DESCRIPTION CANNOT BE BLANK
178200010925ID CARD PRINT CODE IS BLANK OR INVALID
178300050927ONLINE ENROLLMENT DESCRIPTION CANNOT BE BLANK
178400120123INVALID RENEWAL MONTH, PLEASE CHOOSE 01-12
178500020222CARRIER CODE IS EITHER INVALID OR INACTIVE
178600020222INVOICE COL IS INVALID; MUST BE 1-9 W/HEADING
178700110824AGE BANDING IS INVALID; MUST BE M/N/R
178800020306AGE BANDS EXIST W/FLAG = 'N'
178900010925PLAN CATEGORY IS BLANK OR INVALID
179000010925RATE TYPE IS BLANK OR INVALID; MUST BE P OR R
179100020222REMITTANCE FORMAT IS INVALID; MUST BE A/L/M/N
179200020222REMITTANCE PERCENT <> ZERO WHEN FORMAT IS 'N'
179300090430SUBSIDY PLAN IS INVALID; MUST BE Y/N
179400020222S.G.R. REMIT FLAG IS INVALID; MUST E B/N
179500020222MAXIMUM BENEFIT AMOUNT <> 0 IF RATE TYPE ='R'
179600020222IF PLAN CAT = 'LF' & MULT = 0, MAX BEN <> 0.
179700071102ROUND BENEFIT FIELD MUST BE BLANK/U/D
179800020222ROUND FACTOR IS INVALID;{1,10,100,1000,10000}
179900020222SALARY BASED PLANS REQ MULT/ROUND/ROUND FLAG
180000020222CANNOT ADD TO TRUST &/OR SUB THAT IS INACTIVE
180100101012CAPITAL BLUE CROSS PLANS REQUIRE A CLASS BE ENTERED
180200020306RANGE OVERLAPS WITH ANOTHER
180300020328PCP REQUIRED FLAG MUST BE Y OR N
180400021008DELEGATED BILLING CARRIERS REQUIRE CLASS RECD
180500040803PLAN CATEGORY IS NOT ACTIVE
180600050929ACCOUNT IS NOT ON FILE
180700071102ROUND PREMIUM FIELD MUST BE Y OR N
180800090213PLEASE ENTER A VALID DEBIT CARD DELIVERY CODE
180900121212AUTO-ADD PLAN MUST BE BLANK OR Y.
181000140212RENEW YEAR REQUIRED, MUST BE > 2013
