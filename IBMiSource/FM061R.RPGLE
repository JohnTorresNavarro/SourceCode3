000004220119
000005220119         Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000006220119                 DftActGrp(*no)  ;
000013220119
000100001213     F*---------------------------------------------------------------**
000200001213     F* FM061      GROUP BENEFIT SERVICES SOFTWARE                     *
000300010123     F*            REWRITTEN BY - SSK    FROM 36 SOURCE                *
000400001213     F*            DATE - 12/00                                        *
000500001213     F*  DESCRIPTION - COMMISSION CONTROL MAINTENANCE                  *
000600010201     F*                                                                *
000700010201     F*                                                                *
000800010201     F*  2/1/2001 KSJ - Changed "Premium Split" field (R2CMSP)         *
000900010201     F*                 max from 100% to 99.9%                         *
001000010204     F*  2.04.01 DMA - Changed text on err msg 17                      *
001100010206     F*  2.04.01 JVA - Generate next available seq#.                   *
001200010206     F*  2.06.01 JVA - Allow C or X selection.                         *
001300010219     F*  2.19.01 SSK - CORRECT VARIABLE INZ                            *
001400010329     F*  3.29.01 SSK - REMOVE CMCT12 AND ADD CMCT33                    *
001500010330     F*                REMOVE ALL REFERENCES TO SEQUENCE NUMBER        *
001600010418     F*  4.18.01 SSK - CHANGE OF PLAN NUMBER IS A NO-NO                *
001700010810     F*  8.10.01 SSK - FIX HIST REC AND AVOID SAME DAY TERM RECS       *
001800020213     F*  2.13.02 SSK - DENY ACCESS TO R2OVRA & R2OVPP IF SIZE IS 50    *
001900020213     F*                AS PER THE KETTERMAN.                           *
002000020617     F*  6.17.02 SSK - BLOCK TERMED SALESMAN FROM ADDING COMCTX RECS.  *
002100030319     F*  3.19.03 SSK - REPLACE SMAN ACCESS WITH RELATIONSHIP ACCESS    *
002200030501     F*  5.01.03 ssk - conventry project                               *
002300050520     F*  5.20.05 SSK - remove multi-relid edit for a given sman code,  *
002400050520     F*                     now it is up to users to behave.           *
002500060309      * 03/09/06 dlk - remove edit that prevents override to market    *
002600060309      *                sizes under 50.                                 *
002700070723      * 07/23/07 dlk - clear cseq# field when the comctx rec is updated*
002800070723      *                here since the cseq# field is now used as an    *
002900070723      *                indicator to show what comctx records should be *
003000070723      *                reinstated in TR110.                            *
003100070831      * 08/31/07 dlk - add edit - when prem split is used, % of comm or*
003200070831      *                % of prem must also be entered.                 *
003300080211     F* 02.11.08 SSK - ADD POP-UP WARNING ABOUT EFFECTIVE DATE PRIOR TO ACCT BEG
003400081121      * 11/20/08 dlk - add new commission history file                 *
003500081215      * 12/15/08 dlk - add primary broker (display only)               *
003600090626      * 06/26/09 dlk - change rr3 to 4.0 to handel > 999 comctx rec    *
003700091006      * 10/06/09 dlk - add history and comhist for change comctx       *
003800091006      *                cancel date                                     *
003900110204      * 02/04/11 SSK - CHANGE TO ALLOW COMMISSION SPLIT WITH FLAT FEE  *
004000111228      * 12/28/11 dlk - write LCC rec when relid change (in addittion   *
004100111228      *                to LC3 rec)                                     *
004200121016      * 10/16/12 dlk - Change cccmsp edit to 100% max. This will allow *
004300121016      *                a split to be set up as 100% for broker A while *
004400121016      *                broker B is set up as pay no comm = N for       *
004500121016      *                Coventry.                                       *
004600130920      * 09/20/13 SSK - SWITCH CMCT33 TO COMCTUNIQ                      *
004700130926      * 09/26/13 dlk - History file expansion
004800140102      * 01/02/14 SSK - HOOK IN REGION OVERRIDE FOR ACA                 *
004900130920      *                                                                *
005000180829     ** B.Rees.  Passing the Grouper Code to the call to RNW021CL
005100130920      *                                                                *
005101210429      * 04/29/21 jt  - Make UHC Plan active if commision contol rcd is
005103210429      *                made active.
005104220119      * 1/19/2022 B.Rees  Formatted for PL.
005105220119      *   * New Plan Search Window
005106220119      *   * New PL Salesmen Window.
005107220119      *
005200001213     F*---------------------------------------------------------------**
005300210429
005400001213     FFM061D    CF   E             WORKSTN INFDS(WSDS)
005500001213     F                                     SFILE(S01SFL:RR3)
005503220119     F                                     HANDLER('PROFOUNDUI(HANDLER)')
005600130920     FCOMCTUNIQ UF A E           K DISK    RENAME(COMCXR:C33)
005700130920     F*CMCT33    UF A E           K DISK    RENAME(COMCXR:C33)
005800001213     FCMCT17    IF   E           K DISK    RENAME(COMCXR:C17) PREFIX(Z:1)
005900180829     FCMCT14    IF   E           K DISK    RENAME(COMCXR:C14) PREFIX(K:1)
006000001214     FSMAN      IF   E           K DISK
006100030319     FAGENCY    IF   E           K DISK
006200030319     FSUPRAGCY  IF   E           K DISK
006300030319     FSPRAGXR2  IF   E           K DISK
006400030319     FSMANRLT   IF   E           K DISK
006500001214     FPLNMST    IF   E           K DISK
006600180829     FCARMST    IF   E           K DISK    PREFIX(XX:2)
006700010123     FMKTCARA1  IF   E           K DISK
006800001214     FTRSMST    IF   E           K DISK
006900001214     FSUBMST    IF   E           K DISK
007000001214     FACCMST    IF   E           K DISK
007100010116     FCRATE     IF   E           K DISK
007200010105     FHIST      O  A E             DISK
007300081120     Fcomhst    O  A E             DISK
007301210429
007302210429     f*caraccp   if   e           k disk    rename(caraccr:acctFile)
007303210429
007304210429     f*carplnz   uf   e           k disk    rename(carplnr:planFile)
007305210429
007306210429     fuhcplancrtuf   e           k disk    rename(uhcpcr:createPlan)
007307210429
007400210429      *================================================================
007401210429
007500001213     D                UDS
007600081120     D  @USER10              100    109
007700001213     D  CONAME               201    240
007800010204     D  #TISO                248    255  0
007900001214     ***
008000001213     D WSDS            DS
008100030319     D  FKEY                 369    369A
008200001213     ***
008300001213     D  F1             C                   CONST(X'31')
008400001213     D  F2             C                   CONST(X'32')
008500001213     D  F3             C                   CONST(X'33')
008600001213     D  F4             C                   CONST(X'34')
008700001213     D  F5             C                   CONST(X'35')
008800001213     D  F6             C                   CONST(X'36')
008900001213     D  F7             C                   CONST(X'37')
009000001213     D  F8             C                   CONST(X'38')
009100001213     D  F9             C                   CONST(X'39')
009200001213     D  F10            C                   CONST(X'3A')
009300001213     D  F11            C                   CONST(X'3B')
009400001213     D  F12            C                   CONST(X'3C')
009500001213     D  F13            C                   CONST(X'B1')
009600001213     D  F14            C                   CONST(X'B2')
009700001213     D  F15            C                   CONST(X'B3')
009800001213     D  F16            C                   CONST(X'B4')
009900001213     D  F17            C                   CONST(X'B5')
010000001213     D  F18            C                   CONST(X'B6')
010100001213     D  F19            C                   CONST(X'B7')
010200001213     D  F20            C                   CONST(X'B8')
010300001213     D  F21            C                   CONST(X'B9')
010400001213     D  F22            C                   CONST(X'BA')
010500001213     D  F23            C                   CONST(X'BB')
010600001213     D  F24            C                   CONST(X'BC')
010700010110    ***
010800001213     D                 DS
010900001213     D @P10                    1     10A
011000001213     D  #KTR                   1      3S 0
011100001213     D  @KTR                   1      3A
011200001213     D  #KSU                   4      6S 0
011300001213     D  @KSU                   4      6A
011400001213     D  #KAC                   7     10S 0
011500030319    ***
011600081121     D comhiscode      S              1A
011700081121     D A@20            S             20A
011800030319     D A@40            S             40A
011900030319     D IN@             S              1A   DIM(7)
012000030319     D I5@             S              1A   DIM(5)
012100070831     D MSG             S             70A   DIM(24) PERRCD(1) CTDATA
012200030319     D OUT@            S              1A   DIM(8)
012300030319     D O6@             S              1A   DIM(6)
012400090626     D RR3             S              4S 0
012500030319    ***
012600030319     D #CNISO          S              8S 0
012700030319     D #CNTREC         S              3S 0
012800030319     D #ECNT           S              1S 0
012900030319     D #EFISO          S              8S 0
013000030319     D #HEFDT          S              8S 0
013100030319     D #HENDT          S              8S 0
013200030319     D #ISO            S               D   DATFMT(*ISO)
013300030319     D #KCN            S                   LIKE(CMCAN)
013400030319     D #KEF            S                   LIKE(EFFDAT)
013500030319     D #USA            S               D   DATFMT(*USA)
013600030319     D #XSX            S              8S 0
013700030319     ***
013800030319     D @ACCT           S              4A
013900030319     D @ACTIVE         S              1A
014000030319     D @DUPE           S              1A
014100030319     D @KPL            S                   LIKE(CMPLAN)
014200030319     D @KSL            S                   LIKE(SLSMAN)
014300130920     D @KRE            S              8A
014400030319     D @PARM           S             10A
014500030319     D @PLPARM         S             10A
014600030319     D @PLPARM2        S              3A
014700030319     D @SFLOOP         S              1A
014800030319     D @STEP           S              5A
014900030319     D @SUBD           S              3A
015000030319     D @T              S              1A
015100030319     D @TRST           S              3A
015200030319     D @VCC            S              1A
015300030319     D @1STLOOP        S              1A
015400030319     D @2              S              2A
015500030319     D @3              S              3A
015600030319     D @35             S             35A
015700030319     D @4              S              4A
015800030319     D @5              S              5A
015900030319     D @6              S              6A
016000030319     D @7              S              7A
016100030319     D @8              S              8A
016200030319     ***
016300030319     D @@A             S              1A
016400030319     D @@CTYPE         S              1A
016500060309     **D @@CHKIT         S              1A
016600030319     D @@E             S              1A
016700030319     D @@FNDACT        S              1A
016800030319     D @@RF            S              1A
016900030319     D @@STP           S              5A
017000030319     D @@W1            S              1A
0171001309260037 D sysdateymd      S               d   datfmt(*iso)
017101210429
017102210429     d today           s              8  0
017103210429     d unique          s             10
017104210429     d runique         s             10
017105210429     d renewalMonthD   s              2  0
017106210429     d renewalMonthC   s              2
017107210429
017108210429     d updatePlan      pr                  ExtPgm('UHCPLANCL')
017109210429     d  renewalMonthC                 2
017200180829
017201220119
017202220119       dcl-pr wn0012r ExtPgm('WN0012R');
017203220119          oTrst Zoned(3);
017204220119          oSub# Zoned(3);
017205220119          oAcct Zoned(4);
017206220119          oPlan Char(4);
017207220119          oCancel Char(1);
017208220119          oCls  Char(4);
017209220119        End-Pr;
017213220119        dcl-s oTrst Zoned(3);
017214220119        dcl-s oSub# Zoned(3);
017215220119        dcl-s oAcct Zoned(4);
017216220119        dcl-s oPlan Char(4);
017217220119        dcl-s oCancel Char(1);
017218220119        dcl-s oCls  Char(4);
017219220119
017220220119
017221220119       dcl-pr wn0021c ExtPgm('WN0021C');
017222220119          oRelid Char(8);
017226220119          oCancel Char(1);
017228220119        End-Pr;
017229220119        dcl-s oRelid Char(8);
017235220119
017236220119
017237220119
017238220119
017239210429      *================================================================
017400001213     C                   DOU       @STEP = 'EXIT '
017500001214     C     @STEP         CASEQ     'STEP0'       $STEP0
017600001213     C     @STEP         CASEQ     'STEP1'       $STEP1
017700001213     C     @STEP         CASEQ     'STEP2'       $STEP2
017800001213     C     @STEP         CASEQ     'STEP3'       $STEP3
017900001213     C     @STEP         CASEQ     'STEP4'       $STEP4
018000001213     C                   ENDCS
018100001213     C                   ENDDO
018200001213     C*
018300001213     C                   MOVE      *ON           *INLR
018400001213     C*
018500001213   S***S
018600001213     C     *INZSR        BEGSR
018700001213    ***
018800001213     C     *ENTRY        PLIST
018900030319     C                   PARM                    @PARM
019000030319    ***
019100030319     C                   MOVE      'STEP0'       @STEP
019200030319     C                   MOVE      *ZEROS        RR3
019300030319     C                   MOVE      '0'           @1STLOOP
019400030319     C                   MOVE      '0'           @SFLOOP
019500030319     C                   MOVE      *BLANKS       @@A
019600030319     C                   MOVE      *ZEROS        #HEFDT
019700030319     C                   MOVE      *ZEROS        #HENDT
019800030319     C                   MOVE      *ZEROS        #ECNT
019900030319     C                   MOVE      *ZEROS        #CNTREC
020000001213    ***
020100001213     C                   MOVEL     @PARM         @P10
020200001213     C                   Z-ADD     #KTR          I_TRST
020300001213     C                   Z-ADD     #KSU          I_SUB#
020400001213     C                   Z-ADD     #KAC          I_ACCT
020500001213    ***
020600001213     C     CKEY          KLIST
020700001213     C                   KFLD                    #KTR
020800001213     C                   KFLD                    #KSU
020900001213     C                   KFLD                    #KAC
021000001213     C*
021100010329     C     C33KEY        KLIST
021200001213     C                   KFLD                    #KTR
021300001213     C                   KFLD                    #KSU
021400001213     C                   KFLD                    #KAC
021500010329     C                   KFLD                    @KPL
021600130920     C                   KFLD                    @KRE
021700010329     C                   KFLD                    #KEF
021800010330     C                   KFLD                    #KCN
021900001214     C*
022000001214     C     SUBKEY        KLIST
022100001214     C                   KFLD                    #KTR
022200001214     C                   KFLD                    #KSU
022300001214     C*
022400001214     C     ACCKEY        KLIST
022500001214     C                   KFLD                    #KTR
022600001214     C                   KFLD                    #KSU
022700001214     C                   KFLD                    #KAC
022800010123     C*
022900010123     C     MKTKEY        KLIST
023000010123     C                   KFLD                    #KTR
023100010123     C                   KFLD                    #KSU
023200010123     C                   KFLD                    #KAC
023300010123     C                   KFLD                    PCARR
023400001213     C*
023500001213     C     C17KEY        KLIST
023600001213     C                   KFLD                    #KTR
023700001213     C                   KFLD                    #KSU
023800001213     C                   KFLD                    #KAC
023900001213     C                   KFLD                    R2PLAN
024000030319     C                   KFLD                    O_SMAN
024100001214     C*
024200001214     C     PLNKEY        KLIST
024300001214     C                   KFLD                    #KTR
024400001214     C                   KFLD                    #KSU
024500030319     C                   KFLD                    @KPL
024600001214     C*
024700001213    ***
024800001213     C                   ENDSR
024900001214   S***S
025000001214     C* SETUP TEXT FIELDS
025100001214     C     $STEP0        BEGSR
025200001214    ***
025300001214     C     #KTR          CHAIN(N)  TRSMSR
025400001214     C                   IF        %FOUND(TRSMST)
025500001214     C                   MOVEL(P)  TNAME         O_TNAM
025600001214     C                   ENDIF
025700001214    ***
025800001214     C     SUBKEY        CHAIN(N)  SUBMSR
025900001214     C                   IF        %FOUND(SUBMST)
026000001214     C                   MOVEL(P)  SUBNAM        O_SUBN
026100001214     C                   ENDIF
026200001214    ***
026300001214     C     ACCKEY        CHAIN(N)  ACCMSR
026400001214     C                   IF        %FOUND(ACCMST)
026500001214     C                   MOVEL(P)  ACNAM1        O_ACCN
026600001214     C                   ENDIF
026700001214    ***
026800001214     C                   MOVEL(P)  'STEP1'       @STEP
026900001214    ***
027000001214     C                   ENDSR
027100001213   S***S
027200001213     C     $STEP1        BEGSR
027300001213    ***
027400001213     C                   MOVE      *ZEROS        #ECNT
027500001213     C                   MOVE      *ZEROS        RR3
027600001213     C                   MOVE      *ZEROS        #CNTREC
027700001213    ***
027800001213     C                   EXSR      $CLEAR
027900001213    ***
028000001213     C                   EXSR      $BUILD
028100001213     C                   MOVEL(P)  'STEP2'       @STEP
028200001213    ***
028300001213     C                   ENDSR
028400001213   S***S
028500001213     C* INITIALIZE THE SUBFILE
028600001213    ***
028700001213     C     $CLEAR        BEGSR
028800001213    ***
028900001213     C                   MOVEA     '011'         *IN(25)
029000001213     C                   WRITE     S01CTL
029100001213     C                   MOVEA     '010'         *IN(25)
029200001213     C                   Z-ADD     *ZERO         RR3
029300001213    ***
029400001213     C                   ENDSR
029500001213   S***S
029600001213     C* BUILD SUBFILE CONTROL ROUTINE
029700001213    ***
029800001213     C     $BUILD        BEGSR
029900001213    ***
030000001213     C                   MOVE      *ZEROS        #CNTREC
030100001213     C                   MOVE      '0'           @1STLOOP
030200001213     C                   MOVEA     '00'          *IN(33)
030300001213     C                   MOVE      '0'           @SFLOOP
030400001213    ***
030500010126     C     CKEY          SETLL     C14
030600010126     C                   DOU       %EOF(CMCT14) OR @SFLOOP = '1'
030700010126     C     CKEY          READE     C14
030800010126     C                   IF        NOT %EOF(CMCT14)
030900001213     C                   EXSR      $LOADSFL
031000001213     C                   ENDIF
031100001213     C                   ENDDO
031200010120    ***
031300010120     C                   IF        RR3 = 0
031400010120     C                   MOVE      *OFF          *IN60
031500010120     C                   ELSE
031600010120     C                   MOVE      *ON           *IN60
031700010120     C                   ENDIF
031800001213    ***
031900010126     C                   IF        %EOF(CMCT14)
032000001213     C                   MOVE      *OFF          *IN29
032100001213     C                   ELSE
032200001213     C                   MOVE      *ON           *IN29
032300001213     C                   ENDIF
032400001213    ***
032500001213     C                   ENDSR
032600001213   S***S
032700001213     C* LOAD SUBFILE RECORDS
032800001213    ***
032900001213     C     $LOADSFL      BEGSR
033000001213    ***
033100001213     C                   MOVE      *ON           *IN25
033200001213     C                   MOVE      *BLANKS       SEL
033300010126     C                   MOVEL(P)  KLSMAN        SFSCOD
033400030319     C                   MOVEL     KMRELID       SFRELID
033500030319    ***
033600030319     C     KMRELID       CHAIN     SRF
033700030319     C     SRSMAN        CHAIN     SMANR
033800001213     C                   IF        %FOUND(SMAN)
033900030319     C                   EXSR      $GETSNAME
034000030319     C                   MOVEL(P)  A@40          SFSLNM
034100001213     C                   ELSE
034200001213     C                   MOVE      *BLANKS       SFSLNM
034300001213     C                   ENDIF
034400030319    ***
034500010126     C                   MOVEL(P)  KMPLAN        SFPLAN
034600081215     C                   MOVEL(P)  Kree5         SFprib
034700010126     C                   MOVEL(P)  KMPLAN        @KPL
034800030319    ***
034900001214     C     PLNKEY        CHAIN(N)  PLNMSR
035000001213     C                   IF        %FOUND(PLNMST)
035100001213     C                   MOVEL(P)  PDESCR        SFPDES
035200001213     C                   ELSE
035300001213     C                   MOVE      *BLANKS       SFPDES
035400001213     C                   ENDIF
035500030319    ***
035600030319     C                   MOVE      KFFDAT        #XSX
035700010126     C                   EXSR      $ISOUSA
035800030319     C                   MOVE      #XSX          SFEFDT
035900010126     C*
036000030319     C                   MOVE      KMCAN         #XSX
036100010126     C                   EXSR      $ISOUSA
036200030319     C                   MOVE      #XSX          SFCNDT
036300010118     C*
036400010126     C                   Z-ADD     KCOVPP        SFOVPP
036500010126     C                   Z-ADD     KCOVRA        SFOVRA
036600010126     C                   Z-ADD     KCOVPC        SFOVPC
036700010126     C                   Z-ADD     KCCMSP        SFCMSP
036800010126     C                   MOVEL(P)  KCPNC         SFPNC
036900001213     C*
037000001213     C                   ADD       1             RR3
037100001213     C*
037200001213     C                   IF        @1STLOOP = '0'
037300001213     C                   Z-ADD     RR3           SFLPOS
037400001213     C                   MOVE      '1'           @1STLOOP
037500001213     C                   ENDIF
037600010204     C*
037700001213     C                   WRITE     S01SFL
037800001213     C*
037900001213     C                   ADD       1             #CNTREC
038000040422     C                   IF        #CNTREC = 20000
038100001213     C                   MOVE      '1'           @SFLOOP
038200001213     C                   ENDIF
038300001213    ***
038400001213     C                   ENDSR
038500010126   S***S
038600010126     C     $ISOUSA       BEGSR
038700030319     C                   IF        #XSX = 0
038800010126     C                   LEAVESR
038900010126     C                   ELSE
039000030319     C     *ISO          TEST (DE)               #XSX
039100010126     C                   IF        NOT %ERROR
039200030319     C                   MOVE      #XSX          #ISO
039300010126     C                   MOVE      #ISO          #USA
039400030319     C                   MOVE      #USA          #XSX
039500010126     C                   ENDIF
039600010126     C                   ENDIF
039700010126     C                   ENDSR
039800001213   S***S
039900001213     C     $STEP2        BEGSR
040000001213    ***
040100001213     C                   EXSR      $DISPLAY
040200001213     C                   MOVE      *BLANKS       S01MSG
040300001213     C                   ADD       1             #ECNT
040400001213    ***
040500001213     C                   IF        FKEY = F1
040600001213     C                   MOVEL(P)  'EXIT'        @STEP
040700001213     C                   LEAVESR
040800001213     C                   ENDIF
040900001213    ***
041000001213     C                   IF        FKEY = F6
041100010119     C                   MOVE      *OFF          *IN50
041200001213     C                   MOVEL(P)  'STEP3'       @STEP
041300001213     C                   MOVE      'A'           @@A
041400001213     C                   LEAVESR
041500001213     C                   ENDIF
041600001213    ***
041700010120     C                   IF        *IN60 = *ON
041800001213     C                   EXSR      $CHKSELC
041900010120     C                   ENDIF
042000001213    ***
042100010105     C                   IF        #ECNT >= 3
042200001213     C                   MOVEL(P)  'STEP1'       @STEP
042300001213     C                   LEAVESR
042400001213     C                   ENDIF
042500001213    ***
042600001213     C                   ENDSR
042700001213   S***S
042800001213     C* DISPLAY THE SCREEN
042900001213    ***
043000001213     C     $DISPLAY      BEGSR
043100001213    ***
043200001213     C                   WRITE     S01REC
043300001213     C                   EXFMT     S01CTL
043400001213     C*
043500001213     C                   MOVE      *BLANKS       S01MSG
043600001213    ***
043700001213     C                   ENDSR
043800001213    ***
043900001213   S***S
044000030513     C* CHECK SUBFILE SELECTION
044100030513    ***
044200030513     C     $CHKSELC      BEGSR
044300030513    ***
044400030513     C                   DOU       %EOF(FM061D)
044500030513     C                   READC     S01SFL
044600030513     C                   IF        NOT %EOF(FM061D) AND SEL <> *BLANKS
044700030513     C*
044800030513     C                   SELECT
044900030513     C                   WHEN      SEL = 'C' or SEL = 'X'
045000030513     C                   EXSR      $CHGCTL
045100030513     C*                  WHEN      SEL = 'D'
045200030513     C*                  EXSR      $DLTCTL
045300030513     C                   ENDSL
045400030513     C*
045500030513     C                   IF        S01MSG <> *BLANKS
045600030513     C                   LEAVESR
045700030513     C                   ENDIF
045800030513     C*
045900030513     C                   MOVE      *BLANKS       SEL
046000030513     C                   UPDATE    S01SFL
046100030513     C*
046200030513     C                   ENDIF
046300030513     C                   ENDDO
046400030513    ***
046500030513     C                   ENDSR
046600030513   S***S
046700001213     C     $STEP3        BEGSR
046800001213    ***
046900001213     C                   MOVE      *BLANKS       R2MSG
047000010418     C                   MOVE      *OFF          *IN80
047100001213    ***
047200001213     C                   MOVE      *BLANKS       R2PLAN
047300001213     C                   MOVE      *BLANKS       R2PDES
047400030513     C                   MOVE      *ALL'0'       R2RELID
047500030513     C                   MOVE      *BLANKS       O_SMAN
047600030513     C                   MOVE      *BLANKS       D_SMAN
047700030513     C                   MOVE      *BLANKS       O_AGCY
047800030513     C                   MOVE      *BLANKS       D_AGCY
047900030513     C                   MOVE      *BLANKS       O_SUPER
048000030513     C                   MOVE      *BLANKS       D_SUPER
048100030513     c                   eval      o_efusa = 0
048200030513     c                   eval      o_trusa = 0
048300001213     C                   MOVE      *ZEROS        R2EFDT
048400010219SSK  C                   MOVE      *ZEROS        #EFISO
048500001213     C                   MOVE      *ZEROS        R2CNDT
048600010219SSK  C                   MOVE      *ZEROS        #CNISO
048700030513     c                   move      *zeros        r2cmsp
048800010105     C                   MOVE      *ZEROS        R2OVPC
048900010105     C                   MOVE      *ZEROS        R2OVRA
049000010105     C                   MOVE      *ZEROS        R2OVPP
049100010105     C                   MOVE      *BLANKS       R2PNC
049200081215     C                   MOVE      *BLANKS       o_prib
049300001213    ***
049400001213     C                   IF        @@A = 'A'
049500001213     C                   Z-ADD     #HEFDT        R2EFDT
049600010204     C                   MOVE      *ON           *IN50
049700030325     C                   ELSE
049800030325     C                   MOVE      SFRELID       R2RELID
049900001213     C                   ENDIF
050000001213    ***
050100010204     C                   MOVE      *OFF          *IN30
050200001213     C                   MOVE      'STEP4'       @STEP
050300001213    ***
050400001213     C                   ENDSR
050500001213   S***S
050600001213     C     $STEP4        BEGSR
050700001213    ***
050800001213     C                   EXFMT     S02R
050900001214     C                   MOVE      *BLANKS       R2MSG
051000001213    ***
051100001213    1C                   IF        FKEY = F1
051200001213     C                   MOVEL(P)  'STEP1'       @STEP
051300001213     C                   LEAVESR
051400001213    1C                   ENDIF
051500030603    ***
051600030603    1C                   IF        FKEY = F9
051700030603     C                   EXFMT     hlprec1
051800030603     C                   LEAVESR
051900030603    1C                   ENDIF
052000001213    ***
052100010418    1C                   IF        FKEY = F4 AND *IN80 = *OFF
052200030319     C                   EXSR      $F4
052300001213     C                   LEAVESR
052400001213    1C                   ENDIF
052500001213    ***
052600001213    1C                   IF        FKEY = F7
052700030319     C                   EXSR      $F7
052800001213     C                   LEAVESR
052900001213    1C                   ENDIF
053000001213    ***
053100001213     C                   EXSR      $VALIDATE
053200001213    ***
053300001213     C                   IF        @VCC = 'Y'
053400001213     C                   EXSR      $UPDATE
053500001213     C                   ENDIF
053600030319    ***
053700030319     C                   ENDSR
053800030319   S***S
053900030319     C     $F4           BEGSR
054000030319    ***
054100220119     C**                   MOVEL(P)  @KTR          @PLPARM
054200220119     C**                   CAT       @KSU:0        @PLPARM
054300030319    ***
054400220119     C**                   CALL      'FM004CL'
054500220119     C**                   PARM                    @PLPARM
054600030319    ***
054700220119     C**                   MOVE      @PLPARM       @4
054800220119    2C**                   IF        @4 <> ' *LR'
054900030319    *C*
055000220119     C**                   MOVEL(P)  @4            R2PLAN
055100220119     C**                   MOVEL(P)  @4            @KPL
055101220119     C
055102220119
055103220119          oTrst = i_Trst;
055104220119          oSub# = i_Sub#;
055105220119          oAcct = i_Acct;
055106220119
055107220119          wn0012r( oTrst : oSub# : oAcct : oPlan : oCancel : oCls );
055108220119          if oCancel = '';
055109220119            r2Plan = oPlan;
055110220119            @kpl   = oPlan;
055112220119
055113220119
055114220119
055115220119     C
055200030319     C     PLNKEY        CHAIN(N)  PLNMSR
055300030319    *C*
055400030319    3C                   IF        %FOUND(PLNMST)
055500030319     C                   MOVEL(P)  PDESCR        R2PDES
055600030319    3C                   ELSE
055700030319     C                   MOVE      *BLANKS       R2PDES
055800030319    3C                   ENDIF
055900030319    *C*
056000030319    2C                   ENDIF
056100001213    ***
056200001213     C                   ENDSR
056300001213   S***S
056400030319     C     $F7           BEGSR
056500030319    ***
056501220119      *
056502220119      *  Removed... B.Rees  1/20/2022
056503220119      *  To use New PL Window.
056600220119     C*                   MOVE      *BLANKS       @35
056601220119     C*
056700220119     C*                   CALL      'FM484CL'
056800220119     C*                   PARM                    @35
056900220119    ****
057000220119    2C*                   IF        %SUBST(@35:1:3) <> '*LR'
057100220119     C**
057200220119     C*                   MOVEL     @35           R2RELID
057300030319     C*
057301220119
057302220120         oRelid = '';
057303220120         wn0021c( oRelid : oCancel );
057304220120         if oCancel = '';
057305220120           r2Relid = oRelid;
057307220120
057311220119
057312220119
057400030319     C     R2RELID       CHAIN(N)  SRF
057500030319     C*
057600030319    3C                   IF        %FOUND(SMANRLT)
057700030319     C                   EXSR      $GETDESC
057800030319     C                   EXSR      $GETLINK
057900030319    3C                   ENDIF
058000030319     C*
058100030319    2C                   ENDIF
058200030319    ***
058300030319     C                   ENDSR
058400030319   S***S
058500030319     C     $GETDESC      BEGSR
058600001213    ***
058700030319     C                   EVAL      O_SMAN = SRSMAN
058800030509     c     sreffdte      mult      10000.0001    o_efusa
058900030509     c                   if        srtrmdte > 0
059000030509     c     srtrmdte      mult      10000.0001    o_trusa
059100030509     c                   else
059200030509     c                   eval      o_trusa = 0
059300030509     c                   endif
059400030319    ***
059500030319     C     SRSMAN        CHAIN(N)  SMANR
059600030319     C                   IF        %FOUND(SMAN)
059700030319     C                   EXSR      $GETSNAME
059800030319     C                   MOVEL(P)  A@40          D_SMAN
059900030319     C                   ELSE
060000030319     C                   MOVEL(P)  '*UNKNOWN'    D_SMAN
060100030319     C                   ENDIF
060200030319    ***
060300030319     C                   ENDSR
060400030319   S***S
060500030319     C     $GETLINK      BEGSR
060600030319    ***
060700030319     C     SRASID        CHAIN     SXF
060800030319     C                   IF        NOT %FOUND(SPRAGXR2)
060900030319     C                   MOVE      *BLANKS       O_AGCY
061000030319     C                   MOVE      *BLANKS       O_SUPER
061100030319     C                   MOVE      *BLANKS       D_AGCY
061200030319     C                   MOVE      *BLANKS       D_SUPER
061300030319     C                   LEAVESR
061400030319     C                   ENDIF
061500030319    ***
061600030319     C                   EVAL      O_AGCY = SXAGCY
061700030319     C                   EVAL      O_SUPER = SXSUPER
061800030319    ***
061900030319     C     SXAGCY        CHAIN     AGENR
062000030319     C                   IF        %FOUND(AGENCY)
062100030319     C                   MOVEL(P)  AGNAM1        D_AGCY
062200030319     C                   ELSE
062300030319     C                   MOVEL(P)  '*UNKNOWN'    D_AGCY
062400030319     C                   ENDIF
062500030319    ***
062600030319     C     SXSUPER       CHAIN     SAF
062700030319     C                   IF        %FOUND(SUPRAGCY)
062800030319     C                   MOVEL(P)  SANAME1       D_SUPER
062900030319     C                   ELSE
063000030319     C                   MOVEL(P)  '*UNKNOWN'    D_SUPER
063100030319     C                   ENDIF
063200030319    ***
063300030319     C                   ENDSR
063400030319   S***S
063500030319     C     $GETSNAME     BEGSR
063600030319    ***
063700030319     C                   CLEAR                   A@20
063800030319     C                   CLEAR                   A@40
063900030319    ***
064000030319     C                   IF        SFNAME <> *BLANKS
064100030319     C                   MOVEL     SFNAME        A@20
064200030319     C                   EXSR      $LDADDR
064300030319     C                   ENDIF
064400030319    ***
064500030319     C                   IF        SMI <> *BLANKS
064600030319     C                   MOVEL     SMI           A@20
064700030319     C                   EXSR      $LDADDR
064800030319     C                   ENDIF
064900030319    ***
065000030319     C                   IF        SLNAME <> *BLANKS
065100030319     C                   MOVEL     SLNAME        A@20
065200030319     C                   EXSR      $LDADDR
065300030319     C                   ENDIF
065400030319    ***
065500030319     C                   ENDSR
065600030319   S***S
065700030319     C     $LDADDR       BEGSR
065800030319    ***
065900030319     C                   EVAL      A@20 = %TRIM(A@20)
066000030319     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
066100030319     C                   CLEAR                   A@20
066200030319    ***
066300030319     C                   ENDSR
066400030319   S***S
066500030319     C* VALIDATE VALUES
066600030319    ***
066700030319     C     $VALIDATE     BEGSR
066800030319    ***
066900030319     C                   MOVE      'N'           @VCC
067000001213     C                   MOVE      *BLANKS       R2PDES
067100030319     C                   MOVE      *BLANKS       D_SMAN
067200030319     C                   MOVE      *BLANKS       D_AGCY
067300030319     C                   MOVE      *BLANKS       D_SUPER
067400030319     C                   MOVE      *BLANKS       O_SMAN
067500030319     C                   MOVE      *BLANKS       O_AGCY
067600030319     C                   MOVE      *BLANKS       O_SUPER
067700001213    ***
067800001213    1C                   IF        R2PLAN = *BLANKS
067900001213     C                   MOVEL(P)  MSG(1)        R2MSG
068000001213     C                   LEAVESR
068100001213    1C                   ENDIF
068200030530    ***
068300030530    1C                   IF        r2pnc <> *BLANKS and r2pnc <> 'N'
068400030530     c                             and r2pnc <> 'P'
068500030530     C                   MOVEL(P)  MSG(23)       R2MSG
068600030530     C                   LEAVESR
068700030530    1C                   ENDIF
068800001213    ***
068900001214     C                   MOVEL(P)  R2PLAN        @KPL
069000001214     C     PLNKEY        CHAIN(N)  PLNMSR
069100001213    1C                   IF        %FOUND(PLNMST)
069200001213     C                   MOVEL(P)  PDESCR        R2PDES
069300001213    1C                   ELSE
069400001213     C                   MOVEL(P)  MSG(2)        R2MSG
069500001213     C                   LEAVESR
069600001213    1C                   ENDIF
069700001213    ***
069800030319    1C                   IF        R2RELID = *BLANKS
069900001213     C                   MOVEL(P)  MSG(3)        R2MSG
070000001213     C                   LEAVESR
070100001213    1C                   ENDIF
070200001213    ***
070300030319     C     R2RELID       CHAIN(N)  SRF
070400030319    1C                   IF        %FOUND(SMANRLT)
070500020617     C*
070600020617    2C                   IF        @@A = 'C'
070700030319     C                   EXSR      $GETDESC
070800030319     C                   EXSR      $GETLINK
070900020617     C*
071000020617    2C                   ELSE
071100020617     C*
071200030319    3C                   IF        SRTRMDTE = 0 OR #TISO < SRTRMDTE
071300030319     C                   EXSR      $GETDESC
071400030319     C                   EXSR      $GETLINK
071500020617    3C                   ELSE
071600020617     C                   MOVEL(P)  MSG(4)        R2MSG
071700020617     C                   LEAVESR
071800020617    3C                   ENDIF
071900020617     C*
072000020617    2C                   ENDIF
072100020617     C*
072200001213    1C                   ELSE
072300020617     C*
072400001213     C                   MOVEL(P)  MSG(4)        R2MSG
072500001213     C                   LEAVESR
072600020617     C*
072700001213    1C                   ENDIF
072800001213    ***
072900010219SSK  C                   MOVE      *ZEROS        #EFISO
073000001213     C                   IF        R2EFDT = 0
073100001213     C                   MOVEL(P)  MSG(5)        R2MSG
073200001213     C                   LEAVESR
073300001213    1C                   ENDIF
073400001213    ***
073500001213     C     *USA          TEST (DE)               R2EFDT
073600001213     C                   IF        %ERROR
073700001213     C                   MOVEL(P)  MSG(6)        R2MSG
073800001213     C                   LEAVESR
073900001213     C                   ENDIF
074000001213     C*
074100001213     C                   MOVE      R2EFDT        #USA
074200001213     C                   MOVE      #USA          #ISO
074300030319     C                   MOVE      #ISO          #EFISO
074400080211     C* NICE AND TIDY WAY OF STICKING IN A POP-UP MESSAGE ABOUT THE DATE
074500080211     C                   IF        #EFISO < GBSBDT
074600080211     C                   CALL      'FM061ACL'
074700080211     C                   ENDIF
074800001213    ***
074900010219SSK  C                   MOVE      *ZEROS        #CNISO
075000001213    1C                   IF        R2CNDT <> 0
075100001213     C     *USA          TEST (DE)               R2CNDT
075200001213    2C                   IF        %ERROR
075300001213     C                   MOVEL(P)  MSG(7)        R2MSG
075400001213     C                   LEAVESR
075500010108    2C                   ENDIF
075600001213     C                   MOVE      R2CNDT        #USA
075700001213     C                   MOVE      #USA          #ISO
075800030319     C                   MOVE      #ISO          #CNISO
075900030319    2C                   IF        #CNISO < #EFISO
076000010330     C                   MOVEL(P)  MSG(20)       R2MSG
076100010330     C                   LEAVESR
076200010330    2C                   ENDIF
076300010108    2C                   IF        #CNISO <> #EFISO
076400030319     C                   MOVE      #CNISO        @8
076500030319     C                   MOVE      @8            @2
076600010108    3C                   IF        @2 = '01'
076700010108     C                   MOVEL(P)  MSG(14)       R2MSG
076800030509     C                   LEAVESR
076900010108    3C                   ENDIF
077000001213    2C                   ENDIF
077100001213    1C                   ENDIF
077200010116    ***
077300010122     C     PCARR         CHAIN(N)  CARMSR
077400010122     C                   IF        XXMSCH = '1'
077500010116     C                   EXSR      $CHKCOM
077600010122    2C                   IF        @@RF = '0'
077700010116     C                   MOVEA     MSG(17)       R2MSG
077800010116     C                   LEAVESR
077900010122    2C                   ENDIF
078000010116    1C                   ENDIF
078100060309    *
078200060309    * *
078300060309    * * 03/09/06 - remove edit due to upcomeing conversion of alternate
078400060309    * *            cariers to new comm sched.
078500060309    * *
078600060309    1C**                 IF        XXMSCH = '2'
078700060309     C**                 EXSR      $50CHECK
078800060309     c**                 if        allowovrd = 'Y' and (r2ovra = 0.00 and
078900060309     c**                           r2ovpc = 0 and r2ovpp = 0)
079000060309     C**                 MOVEA     MSG(22)       R2MSG
079100060309     C**                 LEAVESR
079200060309    1C**                 ENDIF
079300060309    1C**                 ENDIF
079400060309    *
079500010105    1C                   SELECT
079600010105    1C                   WHEN      R2OVPC <> 0 AND (R2OVPP <> 0 OR R2OVRA <> 0
079700030530     C                             OR (R2PNC = 'N' or r2pnc = 'P'))
079800010116     C                   MOVEA     MSG(13)       R2MSG
079900010109     C                   LEAVESR
080000010105    1C                   WHEN      R2OVPP <> 0 AND (R2OVPC <> 0 OR R2OVRA <> 0
080100030530     C                             OR (R2PNC = 'N' or r2pnc = 'P'))
080200010116     C                   MOVEA     MSG(13)       R2MSG
080300010109     C                   LEAVESR
080400010105    1C                   WHEN      R2OVRA <> 0 AND (R2OVPP <> 0 OR R2OVPC <> 0
080500030530     C                             OR (R2PNC = 'N' or r2pnc = 'P'))
080600010116     C                   MOVEA     MSG(13)       R2MSG
080700010109     C                   LEAVESR
080800030530    1C                   WHEN      (R2PNC = 'N' or r2pnc = 'P') and
080900030530    1C                             (R2OVPP <> 0 OR R2OVRA <> 0 OR R2OVPC <> 0)
081000010108     C                   MOVE      MSG(13)       R2MSG
081100010109     C                   LEAVESR
081200010105     C                   WHEN      R2OVPP > 100.0000
081300010108     C                   MOVE      MSG(11)       R2MSG
081400010109     C                   LEAVESR
081500010105     C                   WHEN      R2OVPC > 100.0000
081600010108     C                   MOVE      MSG(12)       R2MSG
081700010109     C                   LEAVESR
081800121016     C                   WHEN      R2CMSP > 100
081900010118     C                   MOVE      MSG(16)       R2MSG
082000010118     C                   LEAVESR
082100010122    1C                   WHEN      R2OVPC <> 0 AND R2CMSP <> R2OVPC
082200010122     C                   Z-ADD     R2OVPC        R2CMSP
082300060309
082400060309    * *
082500060309    * * 03/09/06 - remove edit due to upcomeing conversion of alternate
082600060309    * *            cariers to new comm sched.
082700060309    * *
082800060309    1C**                 WHEN      (R2OVPC <> 0 OR R2OVRA <> 0) AND ((R2CMSP = 0
082900060309     c**                           and allowovrd = 'N' and xxmsch = '2') or (
083000060309     c**                           xxmsch = '1' and r2cmsp = 0))
083100060309    1C                   WHEN      (R2OVPC <> 0 OR R2OVRA <> 0) AND
083200060309     c                             (xxmsch = '1' and r2cmsp = 0)
083300010122     C                   MOVE      MSG(18)       R2MSG
083400010122     C                   LEAVESR
083500060309
083600070831    * * 08/31/07 - add edit - when prem split is entered the pct of comm
083700070831    * *            override or pct of prem override must also be entered.
083800070831    * *
083900070831    1C                   WHEN      R2CMSP <> 0 and
084000110204    * *
084100110204    * * SSK 02/04/11 ADD R2OVRA TO THE IF STATEMENT BELOW
084200110204    1C                             (R2OVPC = 0 and R2OVPP = 0 AND R2OVRA = 0)
084300110204    1C*****************************(R2OVPC = 0 and R2OVPP = 0)
084400110204    * *
084500070831     C                   MOVE      MSG(24)       R2MSG
084600070831     C                   LEAVESR
084700060309
084800010118     C                   ENDSL
084900010123    ***
085000010123    1C                   IF        XXMSCH = '2' AND (XXRBC = '1' OR
085100010123     C                             XXRBC = '2' OR XXRBC = '3' OR XXRBC = '4' OR
085200010123     C                             XXRBC = 'P') AND XXDLTD = 'A'
085300010123     C*
085400010123     C     MKTKEY        CHAIN(N)  RMKTCARA
085500010123    2C                   IF        %FOUND(MKTCARA1)
085600010123     C*
085700010123     C     MKTKEY        SETLL     RMKTCARA
085800010123    3C                   DOU       %EOF(MKTCARA1)
085900010123     C     MKTKEY        READE     RMKTCARA
086000010810    4C                   IF        NOT %EOF(MKTCARA1) AND
086100010810     C                             MAFRDT <> MATODT
086200010123     C*
086300010123    5C                   IF        MATODT = 0
086400010123     C                   Z-ADD     99999999      MATODT
086500010123    5C                   ENDIF
086600010123     C*
086700030509     c                   clear                   mksznum           5 0
086800030509     c                   eval      mksznum = %dec(maszcd:5:0)
086900030509    5C                   IF        mksznum > 50 AND (#EFISO >= MAFRDT
087000010123     C                             AND #EFISO <= MATODT) AND (R2PNC = ' ' AND
087100010123     C                             R2OVPC = 0 AND R2OVPP = 0 AND R2OVRA = 0)
087200010123     C                   MOVEL(P)  MSG(19)       R2MSG
087300010123     C                   LEAVESR
087400010123     C*
087500010123    5C                   ENDIF
087600010123     C*
087700010123    4C                   ENDIF
087800010123    3C                   ENDDO
087900010123     C*
088000010123    2C                   ENDIF
088100010123     C*
088200010123    1C                   ENDIF
088300060309    * *
088400060309    * * 03/09/06 - remove edit due to upcomeing conversion of alternate
088500060309    * *            cariers to new comm sched.
088600060309    * *
088700060309    1C**                 IF        XXMSCH = '2'
088800060309
088900060309    1C**                 IF        @@CHKIT = 'Y' AND allowovrd = 'N' and
089000060309     C**                           (R2OVRA <> 0 OR R2OVPP <> 0)
089100060309     C**                 MOVEL(P)  MSG(21)       R2MSG
089200060309     C**                 LEAVESR
089300060309    2C**                 ENDIF
089400060309
089500060309    1C**                 ENDIF
089600020213    ***
089700050520*********** begin 5.20.05 SSK
089800050520***********
089900050520****1C*****              IF        @@A = 'A' OR (@@A = 'C' AND
090000050520*****C*****                        R2CNDT = 0 AND SFCNDT <> 0)
090100050520*****C*****              EXSR      $CHKFORACT
090200050520****2C*****              IF        @ACTIVE = 'Y'
090300050520*****C*****              MOVEL(P)  MSG(10)       R2MSG
090400050520*****C*****              LEAVESR
090500050520****2C*****              ENDIF
090600050520****1C*****              ENDIF
090700050520***********
090800050520****1C*****              IF        @@A = 'A' OR (@@A = 'C' AND (R2PLAN <> SFPLAN
090900050520*****C*****                        OR R2EFDT <> SFEFDT OR R2CNDT <> SFCNDT OR
091000050520*****C*****                        R2RELID <> SFRELID))
091100050520*****C*****              EXSR      $CHKDUPE
091200050520*****C*****              IF        @DUPE = 'Y'
091300050520*****C*****              MOVEL(P)  MSG(9)        R2MSG
091400050520*****C*****              LEAVESR
091500050520*****C*****              ENDIF
091600050520*****C*****              ENDIF
091700050520***********
091800050520*********** end   5.20.05 SSK
091900001213    ***
092000001214     C                   MOVE      'Y'           @VCC
092100001214    ***
092200001214     C                   ENDSR
092300010116   S***S
092400060309     C**   $50CHECK      BEGSR
092500060309    *
092600060309     C**                 MOVE      'N'           @@CHKIT
092700060309     c**                 move      'N'           allowovrd         1
092800060309
092900060309     C**   MKTKEY        CHAIN(N)  RMKTCARA
093000060309    1C**                 IF        NOT %FOUND(MKTCARA1)
093100060309     C**                 EVAL      @@CHKIT = 'Y'
093200060309     C**                 LEAVESR
093300060309    1C**                 ENDIF
093400020213     C*
093500060309     C**                 MOVE      'N'           @@FNDACT
093600060309
093700060309     C**   MKTKEY        SETLL     RMKTCARA
093800060309    1C**                 DOU       %EOF(MKTCARA1) OR @@FNDACT = 'Y'
093900060309     C**   MKTKEY        READE     RMKTCARA
094000060309    2C**                 IF        NOT %EOF(MKTCARA1) AND
094100060309     C**                           MAFRDT <> MATODT AND @@FNDACT = 'N'
094200060309     C**                 IF        MATODT = 0
094300060309     C**                 Z-ADD     99999999      MATODT
094400060309     C**                 ENDIF
094500060309    3C**                 IF        #EFISO >= MAFRDT AND #EFISO <= MATODT
094600060309
094700060309     C**                 EVAL      @@FNDACT = 'Y'
094800060309
094900060309    3C**                 ENDIF
095000060309
095100060309    2C**                 ENDIF
095200060309    1C**                 ENDDO
095300060309
095400060309     c**                 clear                   mksznum           5 0
095500060309     c**                 eval      mksznum = %dec(maszcd:5:0)
095600060309    1C**                 IF        @@FNDACT = 'N' OR (@@FNDACT = 'Y' AND
095700060309     C**                           mksznum <= 50)
095800060309
095900060309     C**                 EVAL      @@CHKIT = 'Y'
096000060309     c**                 move      maou50        allowovrd
096100060309
096200060309    1C**                 ENDIF
096300060309    *
096400060309     C**                 ENDSR
096500020213   S***S
096600020213     C     $CHKCOM       BEGSR
096700020213    ***
096800030319     C                   MOVE      '0'           @@RF
096900010116    ***
097000010116     C     PLNKEY        SETLL     CRATER
097100010116    1C                   DOU       %EOF(CRATE) OR @@RF = '1'
097200010116     C     PLNKEY        READE     CRATER
097300010116    2C                   IF        NOT %EOF(CRATE) AND @@RF = '0'
097400010117    3C                   IF        STYPE = CSLSTP AND
097500010116     C                             (#EFISO >= FRDATE AND #EFISO <= TODATE)
097600010116     C                   MOVE      '1'           @@RF
097700010116    3C                   ENDIF
097800010116    2C                   ENDIF
097900010116    1C                   ENDDO
098000010116    ***
098100010116     C                   ENDSR
098200010329   S***S
098300130920*****C*****$CHKDUPE      BEGSR
098400130920*****C*****              MOVE      'N'           @DUPE
098500130920*****C*****              MOVEL(P)  R2PLAN        @KPL
098600130920*****C*****              MOVEL(P)  O_SMAN        @KSL
098700130920*****C*****              Z-ADD     R2EFDT        #XSX
098800130920*****C*****              EXSR      $USAISO
098900130920*****C*****              Z-ADD     #XSX          #KEF
099000130920*****C*****              Z-ADD     R2CNDT        #XSX
099100130920*****C*****              EXSR      $USAISO
099200130920*****C*****              Z-ADD     #XSX          #KCN
099300130920*****C*****C33KEY        CHAIN(N)  C33
099400130920*****C*****              IF        %FOUND(CMCT33)
099500130920*****C*****              MOVE      'Y'           @DUPE
099600130920*****C*****              ENDIF
099700130920*****C*****              ENDSR
099800010330   S***S
099900010330     C     $USAISO       BEGSR
100000030319     C                   IF        #XSX = 0
100100010330     C                   LEAVESR
100200010330     C                   ENDIF
100300030319     C     *USA          TEST (DE)               #XSX
100400010330     C                   IF        %ERROR
100500030319     C                   MOVE      *ZEROS        #XSX
100600010330     C                   LEAVESR
100700010330     C                   ENDIF
100800030319     C                   MOVE      #XSX          #USA
100900010330     C                   MOVE      #USA          #ISO
101000030319     C                   MOVE      #ISO          #XSX
101100010330     C                   ENDSR
101200001213   S***S
101300001213     C     $CHKFORACT    BEGSR
101400001213    ***
101500030319     C                   MOVE      'N'           @ACTIVE
101600001213     C*
101700001213     C     C17KEY        CHAIN(N)  C17
101800001213    1C                   IF        NOT %FOUND(CMCT17)
101900001213     C                   LEAVESR
102000001213    1C                   ENDIF
102100001213     C*
102200001213     C     C17KEY        SETLL     C17
102300001213    1C                   DOU       %EOF(CMCT17)
102400001213     C     C17KEY        READE     C17
102500010329    2C                   IF        NOT %EOF(CMCT17) AND ZMCAN = 0
102600001213     C                   MOVE      'Y'           @ACTIVE
102700001213    2C                   ENDIF
102800001213    1C                   ENDDO
102900001213    ***
103000001213     C                   ENDSR
103100001213   S***S
103200001213     C     $UPDATE       BEGSR
103300001213    ***
103400001214    1C                   IF        @@A = 'A'
103500001213     C                   MOVEL(P)  'STEP3'       @STEP
103600010105     C                   EXSR      $GENHIST
103700010329     C                   CLEAR                   C33
103800001213     C                   Z-ADD     #KTR          CMTRST
103900001214     C                   Z-ADD     #KSU          CSUBDV
104000001213     C                   Z-ADD     #KAC          CMACCT
104100001213     C                   MOVEL     R2PLAN        CMPLAN
104200001213     C                   MOVEL     STYPE         SLSTYP
104300030319     C                   MOVEL     R2RELID       CMRELID
104400030319     C                   MOVEL     O_SMAN        SLSMAN
104500001213     C                   MOVE      'A'           CMDLTD
104600001213     C                   Z-ADD     #EFISO        EFFDAT
104700001213     C                   Z-ADD     #CNISO        CMCAN
104800001213     C                   Z-ADD     R2EFDT        #HEFDT
104900010105     C                   Z-ADD     R2OVPC        CCOVPC
105000010105     C                   Z-ADD     R2OVPP        CCOVPP
105100010105     C                   Z-ADD     R2OVRA        CCOVRA
105200010118     C                   Z-ADD     R2CMSP        CCCMSP
105300010105     C                   MOVEL(P)  R2PNC         CCPNC
105400081215      * primary broker
105500081215     C                   MOVEL     ' '           free5
105600010329     C                   WRITE     C33
105601210429       exsr uhcPrime;
105700140102     C                   EVAL      RNW@021 = '00' + %EDITC(#KTR:'X') +
105800140102     C                             %EDITC(#KSU:'X') + %EDITC(#KAC:'X')
105900140102     C                   CALL      'RNW021CL'
106000140102     C                   PARM                    RNW@021          12
106100180829br01 C                   PARM                    xxrpcd
106200001213     C                   LEAVESR
106300001214    1C                   ENDIF
106400001213    ***
106500030319    1C                   IF        R2RELID <> CMRELID OR R2OVPC <> CCOVPC OR
106600001213     C                             #EFISO <> EFFDAT OR #CNISO <> CMCAN OR
106700010105     C                             R2OVRA <> CCOVRA OR R2OVPP <> CCOVPP OR
106800010118     C                             R2PNC <> CCPNC OR R2CMSP <> CCCMSP
106900010105     C                   EXSR      $GENHIST
107000010330     C                   MOVEL(P)  SFPLAN        @KPL
107100130920     C*******************MOVEL(P)  SFSCOD        @KSL
107200130920     C                   EVAL      @KRE = SFRELID
107300030319     C                   Z-ADD     SFEFDT        #XSX
107400010330     C                   EXSR      $USAISO
107500030319     C                   Z-ADD     #XSX          #KEF
107600030319     C                   Z-ADD     SFCNDT        #XSX
107700010330     C                   EXSR      $USAISO
107800030319     C                   Z-ADD     #XSX          #KCN
107900010329     C     C33KEY        CHAIN     C33
108000130920    2C                   IF        %FOUND(COMCTUNIQ)
108100130920    2C*******************IF        %FOUND(CMCT33)
108200001213     C                   MOVEL     STYPE         SLSTYP
108300030319     C                   MOVEL     R2RELID       CMRELID
108400030319     C                   MOVEL     O_SMAN        SLSMAN
108500001229    3C                   IF        #CNISO <> 0
108600001213     C                   MOVE      'C'           CMDLTD
108700001229    3C                   ENDIF
108800001213     C                   Z-ADD     #EFISO        EFFDAT
108900001213     C                   Z-ADD     #CNISO        CMCAN
109000030319     C                   MOVEL(P)  O_SMAN        SFSCOD
109100030319     C                   MOVEL(P)  D_SMAN        SFSLNM
109200001213     C                   MOVEL(P)  R2PDES        SFPDES
109300001213     C                   Z-ADD     R2EFDT        SFEFDT
109400001213     C                   Z-ADD     R2CNDT        SFCNDT
109500010105     C                   Z-ADD     R2OVPC        CCOVPC
109600010105     C                   Z-ADD     R2OVPP        CCOVPP
109700010105     C                   Z-ADD     R2OVRA        CCOVRA
109800010118     C                   Z-ADD     R2CMSP        CCCMSP
109900010105     C                   MOVEL(P)  R2PNC         CCPNC
110000070723     C                   clear                   cseq#
110100010329     C                   UPDATE    C33
110101210429       exsr uhcPrime;
110200010109     C                   MOVEL(P)  MSG(15)       R2MSG
110300001214    2C                   ENDIF
110400001214    1C                   ENDIF
110500001213    ***
110600001213     C                   ENDSR
110700081124
110800081124   S* *********************************
110900081124   S* * create history record and new commission history
111000081124   S* *********************************
111100010105     C     $GENHIST      BEGSR
111200010105    ***
111300081120      * Add comctx
111400010105    1C                   IF        @@A = 'A'
111500030319     C                   MOVE      '1'           @@CTYPE
111600010105     C                   EXSR      $COMNHIST
111700081121     c                   move      'A'           comhiscode
111800081121     C                   EXSR      #newcomhst
111900081121     c                   clear                   comhiscode
112000010105     C                   MOVE      'LAC'         TRCODE
112100010810     C                   Z-ADD     #EFISO        COVTDT
112200010105     C                   WRITE     HISTR
112300010105     C                   LEAVESR
112400010105    1C                   ENDIF
112500010105    ***
112600081121      * delete comctx
112700010105    1C*                  IF        @@A = 'D'
112800010105    1C                   IF        #CNISO <> CMCAN AND CMCAN = 0
112900030319     C                   MOVE      '1'           @@CTYPE
113000010105     C                   EXSR      $COMNHIST
113100081121     c                   move      'D'           comhiscode
113200081121     C                   EXSR      #newcomhst
113300081121     c                   clear                   comhiscode
113400010105     C                   MOVE      'LDC'         TRCODE
113500010810     C                   Z-ADD     #CNISO        COVTDT
113600010105     C                   WRITE     HISTR
113700010105     C                   MOVE      'D'           CMDLTD
113800081124     C                   LEAVESR
113900010105    1C                   ENDIF
114000030411    ***
114100081120      * relid change comctx
114200030411    1C                   IF        R2RELID <> CMRELID
114300030411     C                   MOVE      '4'           @@CTYPE
114400030411     C                   MOVE      'A'           CMDLTD
114500030411     C                   EXSR      $COMNHIST
114600030411     C                   MOVE      'LC3'         TRCODE
114700030411     C                   Z-ADD     #EFISO        COVTDT
114800030411     C                   WRITE     HISTR
114900030411    1C                   ENDIF
115000010105    ***
115100081120      * reinstate comctx
115200010105    1C                   IF        #CNISO <> CMCAN AND #CNISO = 0
115300030319     C                   MOVE      '1'           @@CTYPE
115400010105     C                   MOVE      'A'           CMDLTD
115500010105     C                   EXSR      $COMNHIST
115600010105     C                   MOVE      'LRC'         TRCODE
115700010810     C                   Z-ADD     #EFISO        COVTDT
115800010105     C                   WRITE     HISTR
115900010105    1C                   ENDIF
116000091006      *
116100091006      * change comctx cancel date
116200091006     C                   if        (#CNISO <> CMCAN) AND (CMCAN <> 0) and
116300091006     C                             (#CNISO <> 0)
116400091006     C                   MOVE      '5'           @@CTYPE
116500091006     C                   EXSR      $COMNHIST
116600091006     C                   MOVE      'LCT'         TRCODE
116700091006     C                   Z-ADD     #cniso        COVTDT
116800091006     C                   WRITE     HISTR
116900091006    1C                   ENDIF
117000010105     C*
117100111228      * write LCC rec when change comctx sman, effdt or relid
117200030319     C                   MOVE      '0'           @@W1
117300030319    1C                   IF        O_SMAN <> SLSMAN OR
117400111228     C                             #EFISO <> EFFDAT or
117500111228     c                             R2RELID <> CMRELID
117600030319     C                   MOVE      '2'           @@CTYPE
117700010105     C                   EXSR      $COMNHIST
117800010105     C                   MOVE      'LCC'         TRCODE
117900010109     C                   MOVE      '1'           @@W1
118000010810     C                   Z-ADD     #EFISO        COVTDT
118100010105     C                   WRITE     HISTR
118200010105    1C                   ENDIF
118300010109     C*
118400081120      * change comctx ovpc, pnc, ovra or ovpp
118500010109    1C                   IF        R2OVPC <> CCOVPC OR R2PNC <> CCPNC OR
118600081125     C                             R2OVRA <> CCOVRA OR R2OVPP <> CCOVPP or
118700081125     C                             R2CMSP <> CCCMSP
118800010109    2C                   IF        @@W1 = '0'
118900030319     C                   MOVE      '2'           @@CTYPE
119000010109     C                   EXSR      $COMNHIST
119100010109     C                   MOVE      'LCC'         TRCODE
119200010109     C                   WRITE     HISTR
119300010109    2C                   ENDIF
119400030319     C                   MOVE      '3'           @@CTYPE
119500010109     C                   EXSR      $COMNHIST
119600010109     C                   MOVE      'LC2'         TRCODE
119700010109     C                   MOVE      '1'           @@W1
119800010109     C                   WRITE     HISTR
119900010109    1C                   ENDIF
120000081124    *
120100081124      * write 1 change rec to new comm hist when any change occurs
120200081124    1C                   IF        R2RELID <> CMRELID or #EFISO <> EFFDAT or
120300081124    1C                             R2OVPC <> CCOVPC OR R2PNC <> CCPNC OR
120400081124     C                             R2OVRA <> CCOVRA OR R2OVPP <> CCOVPP or
120500081125     C                             R2CMSP <> CCCMSP or
120600091006    1C                             (#CNISO <> CMCAN AND #CNISO = 0) OR
120700091006    1C                             (#CNISO <> CMCAN AND CMCAN <> 0)
120800081124     c                   move      'C'           comhiscode
120900081124     C                   EXSR      #newcomhst
121000081124     c                   clear                   comhiscode
121100081124     c                   end
121200081124
121300010105     C                   ENDSR
121400010105   S***S
121500010105     C     $COMNHIST     BEGSR
121600010105    ***
121700010105     C                   CLEAR                   HISTR
121800030319     C                   MOVE      I_TRST        @TRST
121900030319     C                   MOVE      I_SUB#        @SUBD
122000030319     C                   MOVE      I_ACCT        @ACCT
122100010105     C     @TRST         CAT(P)    @SUBD:0       HKEY
122200010105     C                   CAT       @ACCT:0       HKEY
122300010105     C                   MOVE      'X'           TRMFLG
122400010105     C                   MOVE      'X'           TRLFLG
122500010105     C                   MOVE      'N'           DTRFLG
122600130926     C                   MOVEl     'FM061R'      HPRGNM
122700010105     C                   Z-ADD     I_TRST        HSTRST
122800010105     C                   Z-ADD     I_SUB#        HSSUB#
122900010105     C                   Z-ADD     I_ACCT        HSACCT
123000130926     C                   MOVEL     @USER10       HOPER
123100010105     C                   MOVE      'A'           HSDLTD
123200130926     C                   eval      sysdateymd = %date
123300130926     C                   MOVE      sysdateymd    trdate
123400130926     c                   eval      hstrtime = %time
123500010105    ***
123600010109    1C                   SELECT
123700010109     C*
123800010109    1C                   WHEN      @@CTYPE = '1'
123900010105     C                   MOVEL(P)  'PLAN# -'     CK#NOT
124000010105     C                   CAT       R2PLAN:1      CK#NOT
124100010105     C                   CAT       'SALESMAN -':2CK#NOT
124200030319     C                   CAT       O_SMAN:1      CK#NOT
124300010105     C                   MOVEL(P)  'EFF DATE -'  NOTE2
124400030319     C                   MOVE      #EFISO        @8
124500010105     C                   CAT       @8:1          NOTE2
124600010105     C*
124700010109    1C                   WHEN      @@CTYPE = '2'
124800010105     C                   MOVEL(P)  CMPLAN        CK#NOT
124900010105     C                   CAT       SLSMAN:3      CK#NOT
125000010105     C                   MOVE      EFFDAT        @8
125100010105     C                   CAT       @8:2          CK#NOT
125200010418     C                   MOVEL(P)  CMPLAN        NOTE2
125300030319     C                   CAT       O_SMAN:3      NOTE2
125400010105     C                   MOVE      #EFISO        @8
125500010105     C                   CAT       @8:2          NOTE2
125600010109     C*
125700010109    1C                   WHEN      @@CTYPE = '3'
125800030319     C                   MOVE      CCOVPP        @7
125900030319     C                   MOVE      '1'           @T
126000010110     C                   EXSR      $FMTVAL
126100010110     C                   MOVEL(P)  @8            CK#NOT
126200030319     C                   MOVE      CCOVRA        @5
126300010110     C                   MOVE      '2'           @T
126400010110     C                   EXSR      $FMTVAL
126500010110     C                   CAT       @6:1          CK#NOT
126600010109     C                   MOVE      CCOVPC        @7
126700010110     C                   MOVE      '1'           @T
126800010110     C                   EXSR      $FMTVAL
126900010110     C                   CAT       @8:1          CK#NOT
127000010109     C                   CAT       CCPNC:1       CK#NOT
127100010109     C                   MOVE      R2OVPP        @7
127200010109     C                   MOVEL(P)  @7            NOTE2
127300010109     C                   MOVE      R2OVRA        @5
127400010109     C                   CAT       @5:1          NOTE2
127500010109     C                   MOVE      R2OVPC        @7
127600010109     C                   CAT       @7:1          NOTE2
127700010109     C                   CAT       R2PNC:1       NOTE2
127800030411     C*
127900030411    1C                   WHEN      @@CTYPE = '4'
128000030411     C*  OLD VALUE
128100030411     C                   EVAL      CK#NOT = CMRELID
128200030411     C*  NEW VALUE
128300030411     C                   EVAL      NOTE2 = R2RELID
128400010110     C*
128500081120
128600091006      * show cancel date change
128700091006    1C                   WHEN      @@CTYPE = '5'
128800091006     C                   MOVEL(P)  CMPLAN        CK#NOT
128900091006     C                   CAT       SLSMAN:3      CK#NOT
129000091006     C                   MOVE      cmcan         @8
129100091006     C                   CAT       @8:2          CK#NOT
129200091006     C                   MOVEL(P)  CMPLAN        NOTE2
129300091006     C                   CAT       O_SMAN:3      NOTE2
129400091006     C                   MOVE      #cniso        @8
129500091006     C                   CAT       @8:2          NOTE2
129600091006     C*
129700091006    1C                   ENDSL
129800091006
129900010110     C                   ENDSR
130000081121
130100081121      **********************************************************
130200081121      * create new commission history
130300081121      **********************************************************
130400081121     C     #newcomhst    BEGSR
130500081121
130600081121      * common fields in commission history file
130700081121     c                   clear                   comhstr
130800081121     C                   move      I_TRST        chtrust
130900081121     C                   move      I_SUB#        chsub
131000081121     C                   move      I_ACCT        chacc
131100081121     C                   MOVEL     r2plan        chplan
131200081121     c                   move      #tiso         chtrdat
131300081121     c                   time                    chtrtim
131400081121     C                   MOVEL     @USER10       chuser
131500081121     C                   MOVEL     'FM061R    '  chpgm
131600081121
131700081121      * after fields
131800081121     c                   move      #efiso        chaeff
131900081121     c                   move      #cniso        chacan
132000081121     c                   move      r2relid       charel
132100081121     c                   move      r2ovpp        chapop
132200081121     c                   move      r2ovra        chaff
132300081121     c                   move      r2ovpc        chapoc
132400081121     c                   move      r2pnc         chapnc
132500081121     c                   move      r2cmsp        chacmsp
132600081215     c                   move      O_prib        chapri
132700081121
132800081121      * add new rec with after fields only
132900081121     c                   if        comhiscode = 'A'
133000081121     C                   eval      chtrcod = 'LAC'
133100081121     c                   write     comhstr
133200081121     c                   leavesr
133300081121     c                   end
133400081121
133500081121      * before fields
133600081121     c                   move      effdat        chbeff
133700081121     c                   move      cmcan         chbcan
133800081121     c                   move      cmrelid       chbrel
133900081121     c                   move      ccovpp        chbpop
134000081121     c                   move      ccovra        chbff
134100081121     c                   move      ccovpc        chbpoc
134200081121     c                   move      ccpnc         chbpnc
134300081121     c                   move      cccmsp        chbcmsp
134400081215     c                   movel     free5         chbpri
134500081121
134600081121      * set transaction code
134700081121     c                   select
134800081121     c                   when      comhiscode = 'D'
134900081121     C                   eval      chtrcod = 'LDC'
135000081121     c                   when      comhiscode = 'C'
135100081121     C                   eval      chtrcod = 'LCC'
135200081121     c                   endsl
135300081121
135400081121      * add rec with before and after fields
135500081121     c                   write     comhstr
135600081121
135700081121     C                   ENDSR
135800081121
135900081121   S*
136000010110     C     $FMTVAL       BEGSR
136100010110    ***
136200010110     C                   CLEAR                   OUT@
136300010110     C                   CLEAR                   IN@
136400010110    ***
136500010110    1C                   IF        @T = '1'
136600010110     C                   MOVEA     @7            IN@
136700010110     C                   EXSR      $PROC7
136800030319     C                   MOVEA     OUT@          @8
136900010110    1C                   ENDIF
137000010110    ***
137100010110    1C                   IF        @T = '2'
137200010116     C                   MOVEA     @5            I5@
137300010110     C                   EXSR      $PROC5
137400030319     C                   MOVEA     O6@           @6
137500030319    1C                   ENDIF
137600010105    ***
137700010105     C                   ENDSR
137800010110   S***S
137900010110     C     $PROC7        BEGSR
138000010110    ***
138100010110     C                   MOVEA     '.'           OUT@(4)
138200010110     C                   MOVE      IN@(4)        OUT@(5)
138300010110     C                   MOVE      IN@(5)        OUT@(6)
138400010110     C                   MOVE      IN@(6)        OUT@(7)
138500010110     C                   MOVE      IN@(7)        OUT@(8)
138600010110    ***
138700010116     C                   IF        IN@(1) = '0'
138800010110     C                   MOVEA     ' '           OUT@(1)
138900010110     C                   ELSE
139000010110     C                   MOVE      IN@(1)        OUT@(1)
139100010110     C                   MOVE      IN@(2)        OUT@(2)
139200010110     C                   MOVE      IN@(3)        OUT@(3)
139300010110     C                   LEAVESR
139400010110     C                   ENDIF
139500010110    ***
139600010116     C                   IF        IN@(2) = '0'
139700010110     C                   MOVEA     ' '           OUT@(2)
139800010110     C                   ELSE
139900010110     C                   MOVE      IN@(2)        OUT@(2)
140000010110     C                   MOVE      IN@(3)        OUT@(3)
140100010110     C                   LEAVESR
140200010110     C                   ENDIF
140300010110    ***
140400010116     C                   IF        IN@(3) = '0'
140500010110     C                   MOVEA     ' '           OUT@(3)
140600010110     C                   ELSE
140700010110     C                   MOVE      IN@(3)        OUT@(3)
140800010110     C                   ENDIF
140900010110    ***
141000010110     C                   ENDSR
141100001213   S***S
141200010110     C     $PROC5        BEGSR
141300010110    ***
141400010110     C                   MOVEA     '.'           OUT@(4)
141500010110     C                   MOVE      IN@(4)        OUT@(5)
141600010110     C                   MOVE      IN@(5)        OUT@(6)
141700010110    ***
141800010116     C                   IF        IN@(1) = '0'
141900010110     C                   MOVEA     ' '           OUT@(1)
142000010110     C                   ELSE
142100010110     C                   MOVE      IN@(1)        OUT@(1)
142200010110     C                   MOVE      IN@(2)        OUT@(2)
142300010110     C                   MOVE      IN@(3)        OUT@(3)
142400010110     C                   LEAVESR
142500010110     C                   ENDIF
142600010110    ***
142700010116     C                   IF        IN@(2) = '0'
142800010110     C                   MOVEA     ' '           OUT@(2)
142900010110     C                   ELSE
143000010110     C                   MOVE      IN@(2)        OUT@(2)
143100010110     C                   MOVE      IN@(3)        OUT@(3)
143200010110     C                   LEAVESR
143300010110     C                   ENDIF
143400010110    ***
143500010116     C                   IF        IN@(3) = '0'
143600010110     C                   MOVEA     ' '           OUT@(3)
143700010110     C                   ELSE
143800010110     C                   MOVE      IN@(3)        OUT@(3)
143900010110     C                   ENDIF
144000010110    ***
144100010110     C                   ENDSR
144200010110   S***S
144300001213     C* CHANGE CONTROL ROUTINE
144400001213    ***
144500001213     C     $CHGCTL       BEGSR
144600001213    ***
144700010418     C                   MOVE      *ON           *IN80
144800001214     C                   MOVE      'C'           @@A
144900001214     C                   MOVE      *OFF          *IN30
145000010119     C                   MOVE      *ON           *IN50
145100001213     C                   EXSR      $LOADNLOCK
145200001213     C*
145300001213     C                   IF        S01MSG <> *BLANKS
145400001213     C                   LEAVESR
145500001213     C                   ENDIF
145600030319    ***
145700030319     C                   MOVE      '0'           @@E
145800001214     C                   DOU       @@E = '1'
145900001214     C*
146000010418     C                   MOVE      *ON           *IN80
146100001213     C                   EXSR      $STEP4
146200001213     C*
146300001213     C                   IF        @STEP = 'STEP1'
146400001213     C                   MOVE      @@STP         @STEP
146500001214     C                   MOVE      '1'           @@E
146600001214     C                   LEAVESR
146700001213     C                   ENDIF
146800001214     C*
146900001214     C                   ENDDO
147000001213    ***
147100001213     C                   ENDSR
147200001213   S***S
147300001213     C* LOAD SCREEN 2 W/O LOCKING REC
147400001213    ***
147500001213     C     $LOADNLOCK    BEGSR
147600001213    ***
147700030319     C                   MOVE      @STEP         @@STP
147800001213     C                   EXSR      $STEP3
147900001213     C                   MOVE      @@STP         @STEP
148000010330    ***
148100010330     C                   MOVEL(P)  SFPLAN        @KPL
148200130920     C*******************MOVEL(P)  SFSCOD        @KSL
148300130920     C                   EVAL      @KRE = SFRELID
148400030319     C                   Z-ADD     SFEFDT        #XSX
148500010330     C                   EXSR      $USAISO
148600030319     C                   Z-ADD     #XSX          #KEF
148700030319     C                   Z-ADD     SFCNDT        #XSX
148800010330     C                   EXSR      $USAISO
148900030319     C                   Z-ADD     #XSX          #KCN
149000001213    ***
149100010329     C     C33KEY        CHAIN(N)  C33
149200130920     C*******************IF        NOT %FOUND(CMCT33)
149300130920     C                   IF        NOT %FOUND(COMCTUNIQ)
149400001213     C                   MOVEL(P)  MSG(11)       S01MSG
149500001213     C                   MOVEL(P)  'STEP1'       @STEP
149600001213     C                   LEAVESR
149700001213     C                   ENDIF
149800001213    ***
149900001213     C                   MOVEL     CMPLAN        R2PLAN
150000001214     C                   MOVEL(P)  CMPLAN        @KPL
150100001214     C     PLNKEY        CHAIN(N)  PLNMSR
150200001213    1C                   IF        %FOUND(PLNMST)
150300001213     C                   MOVEL(P)  PDESCR        R2PDES
150400001213    1C                   ENDIF
150500001213     C*
150600030319     C     CMRELID       CHAIN     SRF
150700030319     C                   EXSR      $GETDESC
150800030319     C                   EXSR      $GETLINK
150900001213     C*
151000001214     C                   IF        EFFDAT <> 0
151100001213     C                   MOVE      EFFDAT        #ISO
151200001213     C                   MOVE      #ISO          #USA
151300001213     C                   MOVE      #USA          R2EFDT
151400001214     C                   ELSE
151500001214     C                   MOVE      *ZEROS        R2EFDT
151600001214     C                   ENDIF
151700001213     C*
151800001214     C                   IF        CMCAN <> 0
151900001213     C                   MOVE      CMCAN         #ISO
152000001213     C                   MOVE      #ISO          #USA
152100001214     C                   MOVE      #USA          R2CNDT
152200001214     C                   ELSE
152300001214     C                   MOVE      *ZEROS        R2CNDT
152400001214     C                   ENDIF
152500010109    ***
152600010109     C                   Z-ADD     CCOVPP        R2OVPP
152700010109     C                   Z-ADD     CCOVRA        R2OVRA
152800010109     C                   Z-ADD     CCOVPC        R2OVPC
152900010109     C                   MOVE      CCPNC         R2PNC
153000081215     C                   MOVEl     free5         o_prib
153100010118     C                   Z-ADD     CCCMSP        R2CMSP
153200001213    ***
153300001213     C                   ENDSR
153301210429      //========================================================================
153302210429      // UHC Plans
153303210429      //========================================================================
153304210429
153305210429       begsr uhcPrime;
153306210429
153307210429        //unique = '0000000290';
153308210429        //runique = '9000000290';
153309210429        //today = %dec(%date);
153310210429
153311210429        //if cmcan > today or cmcan > 0;
153312210429
153314210429         //chain (unique : cmtrst : csubdv : cmacct) acctFile;
153315210429         //if %found and cacid6 = 'GBSEDIPRIME';
153316210429         // chain (runique : cmtrst : csubdv : cmacct : cmplan) planFile;
153317210429         // if %found;
153318210429         //  cpuniq = unique;
153319210429         //  update planfile;
153320210429         // endif;
153321210429         //endif;
153322210429
153323210429        //endif;
153324210429
153325210429        if cmcan > today or cmcan > 0;
153326210429         chain (cmtrst : csubdv : cmplan) plnmsr;
153327210429         if %found;
153328210429          chain (cmtrst : csubdv : cmacct : cmplan) createPlan;
153329210429          if %found;
153330210429           pprocessed = ' ';
153331210429            update createPlan;
153332210429             renewalMonthD = prenew;
153333210429            renewalMonthC = %editc(renewalMonthD:'X');
153334210429           updatePlan(renewalMonthC);
153335210429          endif;
153336210429         endif;
153337210429        endif;
153338210429
153339210429       endsr;
153340210429
153341210429      //========================================================================
153400210429
153500030513123456*890123456789012345678901234567890123456789012345678901234567890
153600030513      *  1111111111222222222233333333334444444444555555555566666666667
153700010108** CTDATA MSG
153800010108PLAN CODE CANNOT BE BLANK
153900010108PLAN CODE IS INVALID
154000030319RELATIONSHIP ID CANNOT BE BLANK
154100030319RELATIONSHIP ID IS INVALID OR TERMED
154200010108EFFECTIVE DATE CANNOT BE ZERO
154300010108EFFECTIVE DATE IS IN A NON-VALID FORMAT
154400010108CANCEL DATE IS IN A NON-VALID FORMAT
154500010108PLAN/SALESMAN ALREADY ACTIVE
154600010330PLAN/SLSMN/EFF DATE/TRM DATE ALREADY EXISTS
154700010109ACTIVE RECORD FOR THIS ACCOUNT ALREADY EXISTS
154800010108%AGE OF PREMIUM CANNOT EXCEED 100%
154900010108%AGE OF COMMISSION CANNOT EXCEED 100%
155000010108CHOOSE %AGE, AMOUNT, OR NO COMM; CAN ONLY BE ONE
155100010108CANCEL DATE CANNOT BE 01 FOR DAY
155200010109UPDATE OF RECORD COMPLETE
155300010118COMMISSION SPLIT CANNOT EXCEED 100%
155400010204COMMISSION RATE RECORD NOT FOUND
155500010122COMM SPLIT REQUIRED FOR % OF COMM & FLAT FEE
155600010123CHOOSE %AGE, AMOUNT, OR NO COMM; REQ FOR 51+ GROUP
155700010330EFFECTIVE DATE CANNOT BE GREATER THAN CANCEL DATE
15580002021350 GROUPS REQUIRE AMOUNT & % OF PREMIUM BE ZERO
155900030513CHOOSE %AGE, AMOUNT, OR NO COMM; MUST BE AT LEAST OF THEM.
156000030530NO COMM FIELD CAN ONLY BE BLANK, N, OR P.
156100070831MUST ENTER OVERRIDE (% OF COMM OR % OF PREM) WHEN PREM SPLIT IS USED
