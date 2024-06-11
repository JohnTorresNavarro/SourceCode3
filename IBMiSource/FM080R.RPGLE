000100150128     h option(*noDebugIO)
000200991019      **************************************************************************
000300991019      * FM080      GROUP BENEFIT SERVICES SOFTWARE           1988
000400991019      *  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE TO THE
000500991019      *            PLAN MASTER FILE (ADD CHANGE DELETE).
000600991019      *
000700991019      *            WRITTEN BY - MICHAEL C. DUNPHY
000800991019      *            DATE - 06/29/88
000900991019      *
001000991019      *       01/07/99 GSP  There were no modifications required of this member
001100991019      *                      to make it Y2K compliant.
001200991019      *
001300991020      *       MODIFIED by Kimberly S. Johnson 10/19/99
001400991019      *               Added Proration Rule Field
001500000801      * 08/01/00 dlk - Default CARBC to "O"
001600001204      * 12/04/00 SSK - TIME TO REVAMP THE CODE; ADD PRODUCT TYPE FIELD
001700010120      * 01/19/01 SSK - AUTOPOPULATE FILES.
001800010201      * 02.01.01 DMA - Allow entry of product type on all comm schedules
001900010203      * 02.03.01 DMA - Edit CARBC = O and COMSCH = 1
002000010823      * 08.23.01 SSK - FUNCTION KEYS AVAILABLE ON CHANGE MODE ONLY
002100010927      * 09/27/01 DLK - remove edit that forces comsch 2 for all CFS carriers
002200010927      *                Some Med Chi assoc carriers are paid on the old
002300010927      *                schedule. Also change edit on product type to relate
002400010927      *                to ABR Carrier code. Also validate commission schedule
002500010927      *                to be '1' or '2'
002600020322      * 03.22.02 SSK - ADD PREFIX TO TIE SCHEDULES TO 'F.'
002700021007      * 10/02/02 DLK - Add abr code "D" for Delegated Billing
002800030501      * 05.01.03 ssk - conventry project
002900040518      * 05.18.04 ssk - Hypercarrier project.
003000040702      * 07.02.04 szz - Require entry of area code on customer service phone#
003100040729      * 07.29.04 szz - Recompile to allow entry of website description.
003200040825      * 08.25.04 szz - Add Claims Payment Address File.
003300051028      * 10/28/05 dlk - Add abr code "N" for alternate carriers on next month
003400051028      *                schedule
003500060203      * 02/03/06 dlk - Add excel inv desc, persis bonus contract use
003600060203      *                and persis bonue prem/com use
003700060703      * 07/03/06 dlk - Add remittance threshold percent
003800090430      * 04/30/09 dlk - Add participating in state subsidy field
003900090615      * 06/15/09 dlk - Add senior dental abr code "S"
004000130415      * 04/15/13 dlk - remove use trnmit file from screen since only
004100130415      *                certain carriers use it. hard code the value in this
004200130415      *                program instead so the field is still filled properly
004300131121      * 11/21/13 rlj - Added fields from CARMST2P
004400140128      * 01/15/14 rlj - Do not allow ACA flag setting to change
004500140407      * 04/07/14 dlk - fix cust serv area code edit so rest of edits work
004600140929      * 09/29/14 SSK - EXPANSION TIME = PCP, CONTACT EMAIL, QE RULES
004700141001      *                CONVERT SOME OF IT TO FREE FORM RPG, MAKE IT MORE READABLE
004800141001      *                OVER SIZED SUB ROUTINES WERE BROKE APART
004900141001      *                WORK FIELD DEFINITIONS MOVED TO D-SPEC AND CLEARED OFF C-SPECS
005000141007      *                THERE IS ONLY F. NOW, SO REMOVE PREFIX EDIT
005100150109      *                WE HID C2/S3 AEMRELO, TO BE USED IN THE FUTURE
005200150127      * 01/27/15 sbt   Unhide AEMRELO per Shelly
005300150128      * 01/28/15 sbt   Add new field retroactivity limitation days
005400150212      * 02/12/15 dlk - Remittance threshold percent will be required for
005500150212      *                all carriers now
005600150225      * 02/25/15 sbt   Comment out excel invoice requirement edit
005700150225      * 02/25/15 B.rees Added a Chain for new Carrier...
005800150324      * 03/24/15 B.Rees Added Message Subfile.  Re-Designed the Screen2
005900150324      *                 Validation
006000150407      * 04/07/15 B.Rees Changed the locks on the CARMST File.
006100150407      *  br03           Changed Screen IO02.  Changed Field Names so they
006200150407      *                 wouldn't match the file layout.
006300150407      *                 Added Edit on the State Code.
006400150421      * 04/21/15 dlk - add new carrier group codes for CF, DQ, COV use of
006500150421      *                trnmit
006600150507      * 05/07/15 B.Rees Modifed Screen 3.  Added new fields to CarMst2p
006700150507      *  br04
006800150528      * 05/28/15 B.Rees Fixed an Error when Deleting/ Activating a carrier, we
006900150528      *                 had a previous read error.  (Needed a chain)
007000150925      * 09/25/15 dlk - add edit to prevent <a> from ever being used in case
007100150925      *                lower case are allowed one day because it is used
007200150925      *                in the payment calc pgm
007300160404      * 04/04/16 dlk - add new carrier group codes for DO, S3 use of
007400160404      *                trnmit
007500161122      * 11/21/16 dlk - convert abr code (carbc) edit to use new abrctl file
007600161123      *                and add window of available codes
007700991019      **************************************************************************
007800140930    ***
007900001204     FPRRULE    IF   E           K DISK
008000150112     FCARUNIQUE UF A E           K DISK
008100131121     FCARMST2P  UF A E           K DISK
008200141001     FSUBCAR    UF A E           K DISK
008300141001     FCODES     IF   E           K DISK
008400141001     FCODE20P   IF   E           K DISK
008500141001     FCARMKSZ4  IF   E           K DISK
008600141001     FADMNFEE1  IF   E           K DISK
008700141001     FBONUSDR1  IF   E           K DISK
008800141001     FBRKRCOM1  IF   E           K DISK
008900150407     FStateCd   if   e           k disk
009000150507
009100141001     F**AGCAROV0  O  A E             DISK
009200141001     F**AGENCY    IF   E           K DISK
009300150507
009400141001     FHYPERCARR IF   E           K DISK
009500141001     FCPAYAD    IF   E           K DISK
0096001611210015 Fabrctl    iF   E           K DISK
009700150507
009800141001     FFM080D    CF   E             WORKSTN INFDS(WSDS)
009900161121     F                                     SFILE(SF02:RR2)
010000150324
010100150406      * ------------------------------------------------------------
010200150324     D PGMD           SDS
010300150324     D  @pgmq            *proc
010400150507
010500001204   X***X
010600130415szz  D MSG             S             45    DIM(30) CTDATA PERRCD(1)
010700150109    ? * Data structure
010800150109    ?D WUICOD        E DS                  EXTNAME(CODE20P)
010900150109     D  @@CODE                 1    111A
011000150112    ?D WUHYC         E DS                  EXTNAME(HYPERCARR)
011100150112    ?D WUPRR         E DS                  EXTNAME(PRRULE)
011200150112    ?D INPCA2        E DS                  EXTNAME(CARMST2P)
011300150112    ?D HLDCA2        E DS                  EXTNAME(CARMST2P) PREFIX(Z:1)
011400150507
011500991019      * LDA INPUT FOR SCREEN TITLE
011600991019     D                UDS
011700010120     D  @USER                 25     34
011800991019     D  TITLE                201    240
011900141007     D**PREFIX               241    241
012000150507
012100040825    ?D WDDTA         E DS                  EXTNAME(CPAYAD)
012200040826     D  CarrierCode            1      3
012300150507
012400991020     D                 DS
012500991020     D ZIP#                    1      9  0
012600001205     D ZIP5@                   1      5
012700001205     D ZIP4@                   6      9
012800150507
012900010120     D A@SZCD          S              5A   DIM(20)
013000010120     D A@FRDT          S              8S 0 DIM(20)
013100010120     D A@TODT          S              8S 0 DIM(20)
013200150507
013300140930     D CSPHON7         S              7A   INZ
013400140930     D CSPHON3         S              3A   INZ
013500140930     D PRM@CAR         S              3A   INZ
013600140930     D WWRQS           S              8A   INZ
013700140930     D WUPGM           S             10A   INZ
013800140930     D WWFKV           S             60A   INZ
013900140930     D X               S              2  0 INZ
014000150507
014100140930     D #ISO            S               D   DATFMT(*ISO)
014200140930     D #SEQ            S              5S 0 INZ
014300140930     D #SQA            S              5S 0 INZ
014400140930     D #USA            S               D   DATFMT(*USA)
014500140930     D #X              S              2S 0 INZ
014600140930     D #Y              S              2S 0 INZ
014700150507
014800140930     D @@ADD           S              1A   INZ
014900140930     D @@OPNDATES      S              1A   INZ
015000140930     D @@VALID         S              1A   INZ
015100140930     D @@001P          S              3A   INZ
015200150507
015300140930     D @HCOMSCH        S              3A   INZ
015400140930     D @P3             S              3A   INZ
015500140930     D @STEP           S             10A   INZ
015600140930     D @3PARM          S              3A   INZ
015700150507
015800141001     D KF@T20          S             10A   INZ
015900141001     D KF@C20          S             20A   INZ
016000140930     D KF@TYP          S              1A   INZ
016100140930     D KF@COD          S              2A   INZ
016200140930     D KF@CAR          S              3A   INZ
016300150507
016400001204     D WSDS            DS
016500001204     D  FKEY                 369    369A
016600150507
016700150407     d Pos1            s              5s 0
016800150407     d Pos2            s              5s 0
016900161121     d rr2             s              5s 0
017000150407
017100001204     D  F1             C                   CONST(X'31')
017200001204     D  F2             C                   CONST(X'32')
017300001204     D  F3             C                   CONST(X'33')
017400001204     D  F4             C                   CONST(X'34')
017500001204     D  F5             C                   CONST(X'35')
017600001204     D  F6             C                   CONST(X'36')
017700001204     D  F7             C                   CONST(X'37')
017800001204     D  F8             C                   CONST(X'38')
017900001204     D  F9             C                   CONST(X'39')
018000001204     D  F10            C                   CONST(X'3A')
018100001204     D  F11            C                   CONST(X'3B')
018200001204     D  F12            C                   CONST(X'3C')
018300001204     D  F13            C                   CONST(X'B1')
018400001204     D  F14            C                   CONST(X'B2')
018500001204     D  F15            C                   CONST(X'B3')
018600001204     D  F16            C                   CONST(X'B4')
018700001204     D  F17            C                   CONST(X'B5')
018800001204     D  F18            C                   CONST(X'B6')
018900001204     D  F19            C                   CONST(X'B7')
019000001204     D  F20            C                   CONST(X'B8')
019100001204     D  F21            C                   CONST(X'B9')
019200001204     D  F22            C                   CONST(X'BA')
019300001204     D  F23            C                   CONST(X'BB')
019400001204     D  F24            C                   CONST(X'BC')
019500150324     D
019600150324      *----------------------------------------------------------------
019700150324      * Message Routines
019800150324     D clrpgmmsg       pr                  extpgm('QMHRMVPM')
019900150324     D   callstkent                  10a   const
020000150324     D   callstkcntr                 10i 0 const
020100150324     D   messagekey                   4a
020200150324     D   messageRmv                  10a
020300150324     D   errorcode                     *   const
020400150324
020500150324     D sndpgmmsg       pr                  extpgm('QMHSNDPM')
020600150324     D   messageid                    7a   const
020700150324     D   qualmsgf                    20a   const
020800150324     D   msgdata                    256a   const
020900150324     D   msgdtalen                   10i 0 const
021000150324     D   msgtype                     10a   const
021100150324     D   callstkent                  10a   const
021200150324     D   callstkcntr                 10i 0 const
021300150324     D   messagekey                   4a
021400150324     D   errorcode                     *   const
021500150324
021600150324     D   messageid     s              7a
021700150324     D   qualmsgf      s             20a
021800150324     D   msgdata       s            256a
021900150324     D   msgdtalen     s             10i 0
022000150324     D   msgtype       s             10a
022100150324     D   callstkent    s             10a
022200150324     D   callstkcnt    s             10i 0
022300150324     D   messagekey    s              4a
022400150324     D   messageRmv    s             10a
022500150324      *----------------------------------------------------------------
022600141001     C                   DOU       @STEP = 'LEAVE PGM '
022700141001     C     @STEP         CASEQ     'SCREEN ONE'  $SCREEN1
022800141001     C     @STEP         CASEQ     'PREP SCR 2'  $PREPSC2
022900141001     C     @STEP         CASEQ     'SCREEN TWO'  $SCREEN2
023000141001     C     @STEP         CASEQ     'PREP SCR 3'  $PREPSC3
023100141001     C     @STEP         CASEQ     'SCREEN #3 '  $SCREEN3
023200150112     C     @STEP         CASEQ     'PREP SCR 4'  $PREPSC4
023300150112     C     @STEP         CASEQ     'SCREEN #4 '  $SCREEN4
023400141001     C                   ENDCS
023500141001     C                   ENDDO
023600001204     C*
023700001204     C                   MOVE      *ON           *INLR
023800001204     C*
023900150324      *----------------------------------------------------------------
024000001204     C     *INZSR        BEGSR
024100150507
024200140930       @STEP = 'SCREEN ONE';
024300150507
024400140930     C     KL#CODES      KLIST
024500140930     C                   KFLD                    KF@TYP
024600140930     C                   KFLD                    KF@COD
024700150507
024800001204     C                   ENDSR
024900150324      *----------------------------------------------------------------
025000150324      * SCREEN 1 PROCESS FOR GETTING CARRIER CODE TO USE FOR FURTHER SCREENS
025100150324      *----------------------------------------------------------------
025200141001     C     $SCREEN1      BEGSR
025300150507
025400001204     C                   EXFMT     IO01
025500140930       E1MSG = *BLANKS;
025600150507
025700150507    *** CHECK F7 TO LEAVE APP
025800001204    ***
025900141001       IF FKEY = F7;
026000140930          @STEP = 'LEAVE PGM ';
026100140930          LEAVESR;
026200141001       ENDIF;
026300001204    ***
026400140930    *** THIS IS THE CARRIER GROUPER MAINTENANCE
026500140930    ***
026600141001       IF FKEY = F11;
026700150204     C                   CALL      'WRKHYCCL'
026800140930          LEAVESR;
026900141001       ENDIF;
027000040518    ***
027100140930    *** CHECK F9 CARRIER CODE SELECTION WINDOW PROMPT
027200140930    ***
027300141001       IF FKEY = F9;
027400140930          @P3 = *BLANKS;
027500150121     C                   CALL      'FM002CL32'
027600001204     C                   PARM                    @P3
027700141001          IF @P3 = '*LR';
027800140930             E1MSG = 'NO SELECTION WAS MADE';
027900140930             LEAVESR;
028000141001          ELSE;
028100140930             I_CARR = @P3;
028200141001          ENDIF;
028300141001       ENDIF;
028400001204    ***
028500150925    *** NO CARRIER SELECTED THEN FLAG IT
028600150925    *** "<a>" is a reserved code used in getpaid so it is not a valid code
028700150925    ***
028800150925       IF I_CARR = *BLANKS or i_carr = '<a>';
028900140930          E1MSG = 'INVALID CARRIER CODE';
029000140930          LEAVESR;
029100141001       ENDIF;
029200001204    ***
029300140930    *** ON WARD TO PREP FOR ADD/CHANGE
029400140930    ***
029500140930       @STEP = 'PREP SCR 2';
029600001204    ***
029700141001     C                   ENDSR
029800140930    ***
029900150324      *----------------------------------------------------------------
030000150324      * SCREEN 2 PREP PROCESSING
030100150324      *----------------------------------------------------------------
030200141001     C     $PREPSC2      BEGSR
030300001204    ***
030400140930    *** CLEAR THE AREA
030500140930    ***
030600140930       CLEAR CARMSR;
030700140930       CLEAR CARMST2R;
030800140930       CLEAR SUBCARR;
030900150112       CLEAR HLDCA2;
031000140930       @@ADD = 'N';
031100140930       *IN41 = *OFF;
031200140930       KF@CAR = I_CARR;
031300010122    ***
031400140930    *** IF WE FIND IT, THE CHANGE MODE [@@ADD = 'N']; ELSE IT IS AN ADD [@@ADD = 'Y'].
031500140930    ***   ALSO IF FOUND, WE HAVE NOW LOCKED THE RECORD FOR UPDATE.
031600140930    ***
031700150407       CHAIN(n) KF@CAR CARMSR;
031800150112       IF NOT %FOUND(CARUNIQUE);
031900140930          @@ADD = 'Y';
032000150407br03   Else;
032100150407          //?Load New Fields on Screen IO02;
032200150407          s2Name = cName;
032300150407          s2Namec = cNamec;
032400150407          s2Addr1 = cAddr1;
032500150407          s2Addr2 = cAddr2;
032600150407          s2City  = cCity;
032700150407          s2State = cState;
032800150407          s2Cntct = cCntct;
032900150407          s2Area  = cArea;
033000150407          s2Phone = cPhone;
033100150407          s2Webd  = cWebd;
033200150407          s2GrpCd = cGrpCd;
033300150407          s2Prrul = cPrrul;
033400150407          s2Arbc  = cArbc;
033500150407          s2Apbcc = cApbcc;
033600150407          s2Apbpc = cApbpc;
033700150407          s2Apdty = cApdty;
033800150407          s2GaOnly = cGaOnly;
033900150407br03      s2Thresh = cThresh;
034000150407br03      s2Comsch = comsch;
034100150407br03   endif;
034200150407
034300140930    ***
034400140930       @STEP = 'SCREEN TWO';
034500140930    ***
034600140930       IF @@ADD = 'Y';
034700150325          CZIP5 = 0;
034800150325          CZIP4 = 0;
034900140930          CARBC = 'O';
035000140930          CADLTD = 'A';
035100161122          s2COMSCH = '2';
035200150407br03      s2Name = *Blanks;
035300150407          s2Namec = *Blanks;
035400150407          s2Addr1 = *Blanks;
035500150407          s2Addr2 = *Blanks;
035600150407          s2City  = *Blanks;
035700150407          s2State = *Blanks;
035800150407          s2Cntct = *Blanks;
035900150407          s2Area  = *Zero;
036000150407          s2Phone = *zero;
036100150407          s2Webd  = *Blanks;
036200150407          s2Prrul = *Blanks;
036300150407          s2Arbc  = *Blanks;
036400150407          s2Apbcc = *Blanks;
036500150407          s2Apbpc = *Blanks;
036600150407          s2Apdty = *Blanks;
036700150407          s2GaOnly = *Blanks;
036800150407br03      s2Thresh = *Zero;
036900140930          *IN26 = *OFF;
037000141001          CARRCD = KF@CAR;
037100150325          SCCARR = KF@CAR;
037200140930          C2CARCD = KF@CAR;
037300150225br01      CHAIN KF@CAR CARMST2R;
037400150225br01      CHAIN KF@CAR SUBCARR;
037500140930          LEAVESR;
037600140930       ENDIF;
037700140930    ***
037800140930    *** TIME TO LOCK MATCHING FILES; IF NOT FOUND FOR SOME REASON, SET THEM UP.
037900140930    ***
038000140930       CHAIN KF@CAR SUBCARR;
038100140930       IF NOT %FOUND(SUBCAR);
038200140930          SCCARR = KF@CAR;
038300140930          WRITE SUBCARR;
038400140930          CHAIN KF@CAR SUBCARR;
038500140930       ENDIF;
038600140930    ***
038700140930       CHAIN KF@CAR CARMST2R;
038800140930       IF NOT %FOUND(CARMST2P);
038900140930          C2CARCD = KF@CAR;
039000140930          WRITE CARMST2R;
039100140930          CHAIN KF@CAR CARMST2R;
039200140930          *IN41 = *ON;
039300140930       ENDIF;
039400140930    ***
039500140930       *IN26 = *ON;
039600140930     C                   Z-ADD     CZIP          ZIP#
039700140930     C                   MOVE      ZIP5@         CZIP5
039800140930     C                   MOVE      ZIP4@         CZIP4
039900140930       @HCOMSCH = COMSCH;
040000140930    ***
040100140930       IF CADLTD = 'A';
040200140930          *IN25 = *ON;
040300150324          msgdata = 'CARRIER IS ACTIVE';
040400150324          exsr SendMsg;
040500140930       ELSE;
040600140930          *IN25 = *OFF;
040700150324         msgdata = 'CARRIER IS DELETED';
040800150324         exsr SendMsg;
040900140930       ENDIF;
041000140930    ***
041100140930       O_CDES = *BLANKS;
041200150407       IF s2APDTY <> *BLANKS;
041300140930          KF@TYP = 'N';
041400150407          KF@COD = s2APDTY;
041500140930          CHAIN KL#CODES CODESR;
041600140930          IF %FOUND(CODES);
041700010103     C                   MOVEL(P)  LDESCR        O_CDES
041800140930          ENDIF;
041900140930       ENDIF;
042000001204    ***
042100141001     C                   ENDSR
042200140930    ***
042300150324      *----------------------------------------------------------------
042400150324      * SCREEN 2 PROCESSING
042500150324      *----------------------------------------------------------------
042600150324        Begsr $Screen2;
042700150324
042800150324
042900150324           Dou FKey = F1 or FKey = F7;
043000150324
043100150324              write MSGCTL;
043200150324              Exfmt IO02;
043300150324
043400150324              exsr RemoveMsg;
043500150324
043600150324
043700150407              // Turn off all Indicators   30 - 54
043800150407              %Subarr(*in : 30 : 25) = *off;
043900150324
044000150324              PRM@CAR = KF@CAR;
044100150324              *IN43 = *OFF;
044200150324              *IN44 = *OFF;
044300150324
044400150324              if FKey = F1;
044500150324                 @STEP = 'SCREEN ONE';
044600150324                 exsr $UnLock;
044700150324                 leave;
044800150324              EndIf;
044900150324
045000150324              if FKey = F7;
045100150324                 @STEP = 'LEAVE PGM ';
045200150324                 exsr $UnLock;
045300150324                 leave;
045400150324              EndIf;
045500150324
045600150324
045700150324
045800150324              if FKey = F2;                       // Prompt
045900150324                 exsr $S2PROMPT;
046000150324                 iter;
046100150324              EndIf;
046200150324
046300150324
046400150324              if FKey = F4;                       // DEACTIVATE ACTIVE CARRIER [DELETE CARRIER]
046500150324                 exsr $SC2_F4;                    // REFER SCREEN 2 F4 KEY SUBROUTINE
046600150324                 leave;
046700150324              EndIf;
046800150324
046900150324
047000150324              if FKey = F6;                       // ACTIVATE DELETED CARRIER
047100150324                 exsr $SC2_F6;                    // REFER SCREEN 2 F6 KEY SUBROUTINE
047200150324                 leave;
047300150324              EndIf;
047400150324
047500150324
047600150324              if FKey = F8;                       // CLAIM PAYMENT ADDRESS MAINTENANCE
047700150324                 exsr $SC2_F8;                    // REFER SCREEN 2 F8 KEY SUBROUTINE
047800150324                 leave;
047900150324              EndIf;
048000150324
048100150324              // Admin Fee
048200150324              if FKey = F9;
048300150407                 IF s2COMSCH <> '2';
048400150324                    msgdata = 'F9 NOT AVAILABLE FOR COM SCH SELECTED';
048500150324                    exsr SendMsg;
048600150324                 ELSE;
048700150324     C                   CALL      'FM081CL'
048800150324     C                   PARM                    PRM@CAR
048900150324                 ENDIF;
049000150324                 iter;
049100150324              endif;
049200150324
049300150324
049400150324              // Bonus Draw
049500150324              if FKey = F11;
049600150407                 IF s2COMSCH <> '2';
049700150324                    msgdata = 'F11 NOT AVAILABLE FOR COM SCH SELECTED';
049800150324                    exsr SendMsg;
049900150324                 ELSE;
050000150324     C                   CALL      'FM082CL'
050100150324     C                   PARM                    PRM@CAR
050200150324                 ENDIF;
050300150324                 iter;
050400150324              Endif;
050500150324
050600150324
050700150324
050800150324              // Broker Commission
050900150324              if FKey = F14;
051000150407                 IF s2COMSCH <> '2';
051100150324                    msgdata = 'F14 NOT AVAILABLE FOR COM SCH SELECTED';
051200150324                    exsr SendMsg;
051300150324                 ELSE;
051400150324     C                   CALL      'FM083CL'
051500150324     C                   PARM                    PRM@CAR
051600150324                 ENDIF;
051700150324                 iter;
051800150324              EndIf;
051900150324
052000150324
052100150324
052200150324              // Market Group Size Codes
052300150324              if FKey = F17;
052400150324     C                   CALL      'FM084CL'
052500150324     C                   PARM                    PRM@CAR
052600150324                 iter;
052700150324              Endif;
052800150324
052900150324
053000150324
053100150324              // Product Type Codes Inquiry
053200150324              if FKey = F19;
053300150324                 @@001P = 'N';
053400150324     C                   CALL      'FM001CL32'
053500150324     C                   PARM                    @@001P
053600150324                 IF @@001P <> '*LR';
053700150324                    O_CDES = *BLANKS;
053800150324                    KF@TYP = 'N';
053900150407                    s2APDTY = %SUBST(@@001P:2:2);
054000150407                    KF@COD = s2APDTY;
054100150324                    CHAIN KL#CODES CODESR;
054200150324                    IF %FOUND(CODES);
054300150324                       O_CDES = %TRIM(LDESCR);
054400150324                    ENDIF;
054500150324                 ENDIF;
054600150324                 iter;
054700150324
054800150324              EndIf;
054900150324
055000150324
055100150324              // Qualifying Event Rules
055200150324              if FKey = F20;
055300150324                 IF @@ADD = 'Y';
055400150324                    msgdata = 'QUALIFY EVENT RULES CANNOT BE ADDED UNTIL ' +
055500150324                        'CARRIER IS CREATED';
055600150324                    exsr SendMsg;
055700150324                 ELSE;
055800150324                    O_CNAME = CNAME;
055900150324                    @STEP = 'PREP SCR 3';
056000150324                    leave;
056100150324                 ENDIF;
056200150324                 iter;
056300150324              EndIf;
056400150324
056500161121      ***********************
056600161121      * F21 - Show ABR codes
056700161121      ***********************
056800161121       if fkey = F21;
056900161121        exsr #dspabr;
057000161121        iter;
057100161121       endif;
057200150324
057300150324              //----------------------------------------------------------------
057400150324              // End of Function Keys
057500150324              //----------------------------------------------------------------
057600150324
057700150324              // Validate Screen 2
057800150324              exsr $VALIDATE;
057900150324
058000150324
058100150324              // Valid Record: Update or Write
058200150324              if @@Valid = 'Y';
058300150324                 exsr $UpdWrt;
058400150324                 @STEP = 'PREP SCR 2';
058500150324                 leave;
058600150324              EndIf;
058700150324
058800150324            enddo;
058900150324
059000150324         Endsr;
059100150324      *----------------------------------------------------------------
059200141001    *** UPDATE/WRITE ROUTINE
059300150324      *----------------------------------------------------------------
059400141001     C     $UPDWRT       BEGSR
059500141001    ***
059600141001       IF @@ADD = 'Y';
059700141001    ***
059800150407br03      exsr GetS2_Data;
059900141001          WRITE CARMSR;
060000141001    ***
060100141001          IF %FOUND(CARMST2P);
060200141001             UPDATE CARMST2R;
060300141001          ELSE;
060400141001             WRITE CARMST2R;
060500141001          ENDIF;
060600141001    ***
060700141001          IF %FOUND(SUBCAR);
060800141001             UPDATE SUBCARR;
060900141001          ELSE;
061000141001             WRITE SUBCARR;
061100141001          ENDIF;
061200141001    ***
061300141001          LEAVESR;
061400141001    ***
061500141001       ENDIF;
061600141001    ***
061700150407
061800150407br03   CHAIN KF@CAR CARMSR;
061900150407br03   exsr GetS2_Data;
062000150407
062100141001       UPDATE CARMSR;
062200141001       UPDATE CARMST2R;
062300141001       UPDATE SUBCARR;
062400141001    ***
062500150407       IF @HCOMSCH = '2' AND s2COMSCH = '1';
062600150324          msgdata = 'TERM MKT SIZES ON SWITCH FROM COM SCH 2 TO 1';
062700150324          exsr SendMsg;
062800141001       ENDIF;
062900141001    ***
063000140930     C                   ENDSR
063100150407    * *
063200150407      *----------------------------------------------------------------
063300150407    * * Get the Data from Screen 2
063400150407      *----------------------------------------------------------------
063500150407       Begsr GetS2_Data;
063600150407
063700150407       //?Load Values from screen 2 to Database.
063800150407          cName   = s2Name;
063900150407          cNamec = s2Namec;
064000150407          cAddr1 = s2Addr1;
064100150407          cAddr2 = s2Addr2;
064200150407          cCity  = s2City ;
064300150407          cState = s2State;
064400150407          cCntct = s2Cntct;
064500150407          cArea  = s2Area ;
064600150407          cPhone = s2Phone;
064700150407          cWebd  = s2Webd ;
064800150407          cPrrul = s2Prrul;
064900150407          cArbc  = s2Arbc ;
065000150407          cApbcc = s2Apbcc;
065100150407          cApbpc = s2Apbpc;
065200150407          cApdty = s2Apdty;
065300150407          cGaOnly = s2GaOnly;
065400150407br03      cThresh = s2Thresh;
065500150407br03      cGrpCd  = s2GrpCd;
065600150407br03      comsch  = s2Comsch;
065700150407
065800150407        Endsr;
065900150324      *----------------------------------------------------------------
066000150112    *** PROMPTS FOR SCREEN 2
066100150324      *----------------------------------------------------------------
066200150112     C     $S2PROMPT     BEGSR
066300150112    ***
066400150112     C                   IF        WSFL2 = *BLANKS
066500150112     C                   LEAVESR
066600150112     C                   ENDIF
066700150112    ***
066800150112     C                   SELECT
066900150112    *** *
067000150112     C                   WHEN      WSFL2 = 'CPRRUL'
067100150121     C                   CALL      'SLCPRR32'
067200150112    ?C                   Parm                    WIRQS                          PROGRAM REQUEST
067300150112    ?C                   Parm                    WORTN                          RETURN CODE
067400150112    ?C                   Parm                    WUPGM                          LAST PGM NAME
067500150112    ?C                   Parm                    WUPRR                          RECORD DS
067600150112     C                   IF        WORTN = *BLANKS
067700150112     C                   EVAL      CPRRUL = PRRUL
067800150112     C                   ENDIF
067900150120       *IN43 = *ON;
068000150112    *** *
068100150407     C                   WHEN      WSFL2 = 'S2GRPCD'
068200150128     C                   CALL      'SLCHYC132'
068300150112    ?C                   Parm                    WIRQS                          PROGRAM REQUEST
068400150112    ?C                   Parm                    WORTN                          RETURN CODE
068500150112    ?C                   Parm                    WUPGM                          LAST PGM NAME
068600150112    ?C                   Parm                    WUHYC                          RECORD DS
068700150112     C                   IF        WORTN = *BLANKS
068800150407     C                   EVAL      s2GRPCD = HCCODE
068900150112     C                   ENDIF
069000150120       *IN44 = *ON;
069100150112    *** *
069200150112     C                   ENDSL
069300150112    ***
069400150112     C                   EVAL      WSFL2 = *BLANKS
069500150112    ***
069600150112     C                   ENDSR
069700150112    ***
069800150324      *----------------------------------------------------------------
069900140930    *** UNLOCK RECORDS
070000150324      *----------------------------------------------------------------
070100140930     C     $UNLOCK       BEGSR
070200140930    ***
070300140930       IF @@ADD = 'N';
070400150112          UNLOCK(E) CARUNIQUE;
070500141007          UNLOCK(E) CARMST2P;
070600141007          UNLOCK(E) SUBCAR;
070700141001       ENDIF;
070800140930    ***
070900140930     C                   ENDSR
071000140930    ***
071100140930   S***S
071200140930    *** SCREEN 2 F8 PROCESS
071300140930    ***    CLAIM PAYMENT ADDRESS MAINTENANCE
071400140930    ***
071500150324      *----------------------------------------------------------------
071600140930     C     $SC2_F8       BEGSR
071700150324      *----------------------------------------------------------------
071800140930       CLEAR WDDTA;
071900140930       CHAIN  KF@CAR CPAYAR;
072000140930       IF %FOUND(CPAYAD);
072100140930     C                   CALL      'CHGCPA  '
072200141007    ?C                   PARM      'CHANGE'      WWRQS
072300141007    ?C                   PARM      'CHANGE'      WWRTN
072400140930    ?C                   PARM      'FM080R  '    WUPGM
072500140930    ?C                   PARM                    WDDTA
072600140930    ?C                   PARM      'X 03    '    WWFKV
072700140930          LEAVESR;
072800140930       ENDIF;
072900140930    ***
073000140930       CLEAR WDDTA;
073100140930       CARRIERCODE = KF@CAR;
073200141001    ***
073300140930     C                   CALL      'CHGCPA  '
073400140930    ?C                   PARM      'ADD     '    WWRQS
073500141007    ?C                   PARM      '   P    '    WWRTN             8
073600140930    ?C                   PARM      'FM080R  '    WUPGM
073700140930    ?C                   PARM                    WDDTA
073800140930    ?C                   PARM      'X 03    '    WWFKV
073900140930    ***
074000140930     C                   ENDSR
074100140930    ***
074200150324      *----------------------------------------------------------------
074300140930    *** SCREEN 2 F4 PROCESS
074400140930    ***    DEACTIVATE ACTIVE CARRIER [DELETE CARRIER]
074500150324      *----------------------------------------------------------------
074600140930     C     $SC2_F4       BEGSR
074700150324
074800140930       IF @@ADD = 'Y';
074900150324          msgdata = 'CANNOT DELETE ON ADD OF RECORD';
075000150324          exsr SendMsg;
075100140930          LEAVESR;
075200140930       ENDIF;
075300140930    ***
075400140930       EXSR $CHK4OPEN;
075500140930       IF @@OPNDATES = 'Y';
075600150324          msgdata = 'TERM MKT SIZES TO COMPLETE CARRIER CANCEL';
075700150324          exsr SendMsg;
075800140930          LEAVESR;
075900140930       ENDIF;
076000140930    ***
076100150528       CHAIN KF@CAR CARUNIQUE;
076200140930       CADLTD = 'D';
076300140930       UPDATE CARMSR;
076400140930       UPDATE CARMST2R;
076500140930       UPDATE SUBCARR;
076600141001    ***
076700140930       @STEP = 'SCREEN ONE';
076800140930       E1MSG = 'CARRIER CODE DELETED';
076900140930    ***
077000140930     C                   ENDSR
077100140930    ***
077200150324      *----------------------------------------------------------------
077300140930    *** SCREEN 2 F6 KEY SUBROUTINE
077400140930    ***    ACTIVATE DELETED CARRIER
077500150324      *----------------------------------------------------------------
077600140930     C     $SC2_F6       BEGSR
077700140930    ***
077800140930       IF @@ADD = 'Y';
077900140930          LEAVESR;
078000140930       ENDIF;
078100140930    ***
078200140930       CHAIN KF@CAR RCARMKSZ;
078300140930       IF NOT %FOUND(CARMKSZ4);
078400140930     C                   CALL      'FM084CL'
078500140930     C                   PARM                    PRM@CAR
078600140930       ENDIF;
078700140930    ***
078800140930       CHAIN KF@CAR RCARMKSZ;
078900140930       IF NOT %FOUND(CARMKSZ4);
079000150324          msgdata = 'ALL CARRIERS REQUIRE MKT SIZES';
079100150324          exsr SendMsg;
079200140930          LEAVESR;
079300140930       ENDIF;
079400140930    ***
079500150528       CHAIN KF@CAR CARUNIQUE;
079600140930       CADLTD = 'A';
079700140930    ***
079800140930       UPDATE CARMSR;
079900140930       UPDATE CARMST2R;
080000140930       UPDATE SUBCARR;
080100140930    ***
080200140930       @STEP = 'SCREEN ONE';
080300140930       E1MSG = 'CARRIER CODE ACTIVATED';
080400001204    ***
080500001204     C                   ENDSR
080600150324      *----------------------------------------------------------------
080700010126     C     $CHK4OPEN     BEGSR
080800150324
080900140930       @@OPNDATES = 'N';
081000140930    ***
081100140930       SETLL KF@CAR RCARMKSZ;
081200140930    ***                            ANY ZERO 'TO DATES' FOR CARRIER, THEN FLAG IT.
081300140930       DOU %EOF(CARMKSZ4);
081400140930          READE KF@CAR RCARMKSZ;
081500141001          IF NOT %EOF(CARMKSZ4) AND CZTODT = 0;
081600140930             @@OPNDATES = 'Y';
081700140930             LEAVESR;
081800140930          ENDIF;
081900140930       ENDDO;
082000010126    ***
082100010126     C                   ENDSR
082200140930    ***
082300150324      *----------------------------------------------------------------
082400150324       begsr $Validate;
082500150324
082600150324          // CHECK FOR REQUIRED FIELDS
082700150324          @@VALID = 'Y';
082800150324
082900150324
083000150407          IF s2NAME = *BLANKS;
083100150324             msgdata = 'NAME CANNOT BE BLANK';
083200150324             exsr SendMsg;
083300150324             *in30 = *on;
083400150324             @@VALID = 'N';
083500150324          ENDIF;
083600150324
083700150324
083800150407          IF s2ADDR1 = *BLANKS;
083900150324             msgdata = 'ADDRESS LINE 1 CANNOT BE BLANK';
084000150324             exsr SendMsg;
084100150324             *in31 = *on;
084200150324             @@VALID = 'N';
084300150324          ENDIF;
084400150324
084500150407          IF s2CITY = *BLANKS;
084600150324             msgdata = 'CITY CANNOT BE BLANK';
084700150324             exsr SendMsg;
084800150324             *in32 = *on;
084900150324             @@VALID = 'N';
085000150324          ENDIF;
085100150324
085200150407          IF s2STATE = *BLANKS;
085300150324             msgdata = 'STATE CANNNOT BE BLANK';
085400150324             exsr SendMsg;
085500150324             *in33 = *on;
085600150324             @@VALID = 'N';
085700150407          else;
085800150407             chain s2State StateCd;
085900150407             if not %Found(StateCd);
086000150407                msgdata = 'State Code is not Valid';
086100150407                exsr SendMsg;
086200150407                *in33 = *on;
086300150407                @@VALID = 'N';
086400150407             endif;
086500150407          endif;
086600150407
086700150407
086800150407
086900150324          IF CZIP5 = *ZEROS;
087000150324             msgdata = 'ZIP CANNOT BE ZERO';
087100150324             exsr SendMsg;
087200150324             *in34 = *on;
087300150324             @@VALID = 'N';
087400150324          ENDIF;
087500150324
087600150407          IF s2CNTCT = *BLANKS;
087700150324             msgdata = 'CONTACT NAME CANNOT BE BLANK';
087800150324             exsr SendMsg;
087900150324             *in35 = *on;
088000150324             @@VALID = 'N';
088100150324          ENDIF;
088200150324
088300150407
088400150407          //?Email Address
088500150407          if C2ConEml > *Blanks;
088600150407             pos1 =  %Scan('@' : c2ConEml);
088700150407             pos2 =  %Scan('.' : c2ConEml : Pos1 + 1);
088800150407
088900150407             if Pos1 = 0 or Pos2 = 0;
089000150407                msgdata = 'Email Address is not in the correct format.';
089100150407                exsr SendMsg;
089200150407                *in54 = *on;
089300150407                @@VALID = 'N';
089400150407             endif;
089500150407          endif;
089600150407
089700150407
089800150407
089900150407          IF s2AREA = 0 OR s2PHONE = 0;
090000150324             msgdata = 'AREA & PHONE CANNOT BE ZERO';
090100150324             exsr SendMsg;
090200150324             *in36 = *on;
090300150324             @@VALID = 'N';
090400150324          ENDIF;
090500150324
090600150324
090700150407          IF s2PRRUL <> *BLANKS;
090800150407             CHAIN (s2PRRUL) PRRULR;
090900150324             IF NOT %FOUND(PRRULE);
091000150324                msgdata = 'INVALID PRORATION RULE CODE';
091100150324                exsr SendMsg;
091200150324                *in45 = *on;
091300150324                *in43 = *on;
091400150324                @@VALID = 'N';
091500150324             ENDIF;
091600150324          ENDIF;
091700150324
091800150324
091900150324          IF C2820 <> 'N' AND C2820 <> 'Y' AND C2820 <> ' ';
092000150324             msgdata = '820 MUST BE Y OR N';
092100150324             exsr SendMsg;
092200150324             *in52 = *on;
092300150324             @@VALID = 'N';
092400150324          ENDIF;
092500150324
092600150324
092700150407          IF s2GRPCD = *BLANKS;
092800150324             msgdata = 'PLEASE SELECT A CARRIER GROUPER CODE';
092900150324             exsr SendMsg;
093000150324             *in46 = *on;
093100150324             *in44 = *on;
093200150324             @@VALID = 'N';
093300150324          else;
093400150407             CHAIN (s2GRPCD) RHC;
093500150324             IF NOT %FOUND(HYPERCARR);
093600150324                msgdata = 'SELECT VALID CARRIER GROUPER CODE';
093700150324                exsr SendMsg;
093800150324                *in46 = *on;
093900150324                *in44 = *on;
094000150324                @@VALID = 'N';
094100150324             endif;
094200150324          ENDIF;
094300150324
094400150324
094500150407          IF s2COMSCH <> '1' AND s2COMSCH <> '2';
094600150324             msgdata= 'COMM SCHEDULE MUST BE 1 OR 2';
094700150324             exsr SendMsg;
094800150324             *in39 = *on;
094900150324             @@VALID = 'N';
095000150324          ENDIF;
095100150324
095200150324
095300150324          IF C2REMIT <> 'N' AND C2REMIT <> 'G';
095400150324             msgdata = 'REMIT MUST BE N OR G';
095500150324             exsr SendMsg;
095600150324             *in51 = *on;
095700150324             @@VALID = 'N';
095800150324          ENDIF;
095900150324
096000161121      ******************************
096100161121      * edit ABR Code
096200161121      ******************************
096300161121       chain s2arbc abrctl;
096400161121       if not %found(abrctl);
096500161121        msgdata = 'Invalid ABR code (press F21 to show codes)';
096600161121        exsr SendMsg;
096700161121        *in38 = *on;
096800161121        @@VALID = 'N';
096900161121       endif;
097000161121
097100161121      * if carrier is new or active then ABR Code must be active in abrctl
097200161121       if (@@ADD = 'Y' or cadltd = 'A') and abcstat <> 'A';
097300161121        msgdata = 'Please select an ACTIVE ABR code';
097400161121        exsr SendMsg;
097500161121        *in38 = *on;
097600161121        @@VALID = 'N';
097700161121       endif;
097800161121
097900150324
098000161122      * only commission schedule 1 can have carrier level COM/AF/BD
098100161123      *  11/23/16 - these 3 fields were removed from the screen last year,
098200161123      *             no need no perform edit on file values since user cannot
098300161123      *             access them
098400161123      //  if (s2comsch <> '1') and
098500161123      //     (CCOMP <> 0 OR CAFP <> 0 OR CBONP <> 0);
098600161123      //     msgdata = 'COM/ADMN FEE/BONUS ONLY ALLOWED FOR COM SCH 1';
098700161123      //     exsr SendMsg;
098800161123      //     *in38 = *on;
098900161123      //     @@VALID = 'N';
099000161123      //  ENDIF;
099100150324
099200150324
099300150324          // VALIDATE PERSISTENCY BONUS CONTRACT COUNT USE
099400150407          IF s2APBCC <> 'Y' AND s2APBCC <> ' ';
099500150324             msgdata = 'PERSIS BONUS CONTRACT CNT MUST BE Y OR BLANK';
099600150324             exsr SendMsg;
099700150324             *in47 = *on;
099800150324             @@VALID = 'N';
099900150324          ENDIF;
100000150324
100100150324          //  VALIDATE PERSISTENCY BONUS PREM & COM USE
100200150407          IF s2APBPC <> 'Y' AND s2APBPC <> ' ';
100300150324             msgdata = 'PERSIS BONUS PREM/COM MUST BE Y OR BLANK';
100400150324             exsr SendMsg;
100500150324             *in48 = *on;
100600150324             @@VALID = 'N';
100700150324          ENDIF;
100800150324
100900150406
101000150406          //  PRODUCT TYPE MUST BE ENTERED FOR CFS CARRIER
101100150407          IF (s2ARBC = '1' OR s2ARBC = '2' OR
101200150407              s2ARBC = 'P' OR s2ARBC = '3' OR
101300150407              s2ARBC = '4' OR s2ARBC = 'D') AND s2APDTY = *BLANKS;
101400150406             msgdata = 'PRODUCT TYPE IS REQUIRED FOR ALL CFS CARRIERS';
101500150406             exsr SendMsg;
101600150406             *in40 = *on;
101700150406             @@VALID = 'N';
101800150406          ENDIF;
101900150406
102000150324          // Product Type
102100150407          IF s2COMSCH = '2' OR (s2COMSCH = '1' AND s2APDTY <> *BLANKS);
102200150324             KF@TYP = 'N';
102300150407             KF@COD = s2APDTY;
102400150324             CHAIN KL#CODES CODESR;
102500150324             IF %FOUND(CODES);
102600150324     C                   MOVEL(P)  LDESCR        O_CDES
102700150324             ELSE;
102800150324                msgdata = 'PRODUCT TYPE IS INVALID';
102900150324                O_CDES = *BLANKS;
103000150324                exsr SendMsg;
103100150324                *in40 = *on;
103200150324                @@VALID = 'N';
103300150324             ENDIF;
103400150324          ENDIF;
103500150324
103600150324
103700150324          //  VALIDATE REMITTANCE THRESHOLD %
103800150324          //  O & N & S MUST BE FILLED, ALL OTHERS ZERO
103900150324          //  2/12/15 - threshold must be entered for all carriers
104000150407          IF (s2THRESH <= 0 OR s2THRESH > 100.00);
104100150324             msgdata = 'REMITTANCE THRESHOLD % MUST BE 1-100';
104200150324             exsr SendMsg;
104300150324             *in49 = *on;
104400150324             @@VALID = 'N';
104500150324          ENDIF;
104600150324
104700150324
104800150407          IF C2PCPOPT <> 'Y' AND C2PCPOPT <> 'N';
104900150324             msgdata = 'PCP OPTION MUST BE Y OR N';
105000150324             exsr SendMsg;
105100150324             *in37 = *on;
105200150324             @@VALID = 'N';
105300150324          ENDIF;
105400150324
105500150324
105600150324          //CSPHON3 = %SUBST(CSPHON:1:3);
105700150324          //CSPHON7 = %SUBST(CSPHON:4:7);
105800150324          //IF CSPHON7 <> *BLANKS AND CSPHON3 = *BLANKS;
105900150324          //   msgdata = 'ENTER AN AREA CODE FOR CUSTOMER SERVICE PHONE#';
106000150324          //   LEAVESR;
106100150324          //ENDIF;
106200150324
106300150324     C                   MOVE      CZIP5         ZIP5@
106400150324     C                   MOVE      CZIP4         ZIP4@
106500150324     C                   Z-ADD     ZIP#          CZIP
106600150324
106700150324          // remove txmtyn from screen and hard code in this program
106800160404          // only care first, coventry, dentaquest and dominion use F.TRNMIT
106900150421          IF (s2GRPCD = 'CF' OR s2GRPCD = 'DQ' OR s2GRPCD = 'CH' or
107000160404              s2GRPCD = 'SC' OR s2GRPCD = 'SD' OR s2GRPCD = 'S2' or
107100160404              s2GRPCD = 'DO' OR s2GRPCD = 'S3');
107200150324             TXMTYN = 'Y';
107300150324          ELSE;
107400150324             TXMTYN = 'N';
107500150324          ENDIF;
107600150324
107700150324
107800150324          // VALIDATE CARMST2P FIELDS
107900150324          IF C2ACART <> 'Y' AND C2ACART <> 'N';
108000150324             msgdata = 'ACA RATING MUST BE Y OR N';
108100150324             exsr SendMsg;
108200150324             *in50 = *on;
108300150324             @@VALID = 'N';
108400150324          ENDIF;
108500150324
108600150324
108700150324          IF C2EXCHG <> 'Y' AND C2EXCHG <> 'N';
108800150324             msgdata = 'EXCHANGE MUST BE Y OR N';
108900150324             exsr SendMsg;
109000150324             *in53 = *on;
109100150324             @@VALID = 'N';
109200150324          ENDIF;
109300150324
109400150324
109500150324          //  SCHED1/2 EDITS ARE FINAL TESTS
109600150324          if @@Valid = 'Y';
109700150324
109800150324             // FORCE SCHEDULE 2 FILE POPULATION
109900150407             IF s2COMSCH = '2';
110000150324                EXSR $SCHED2;
110100150324             ENDIF;
110200150324
110300150324             // FORCE SCHEDULE 1 FILE POPULATION
110400150407             IF s2COMSCH = '1' AND CADLTD = 'A';
110500150324               EXSR $SCHED1;
110600150324             ENDIF;
110700150324          endif;
110800150324       Endsr;
110900150324      *----------------------------------------------------------------
111000141001    *** COMMISSION SCHEDULE 2 RULES
111100150324      *----------------------------------------------------------------
111200141001     C     $SCHED2       BEGSR
111300141001    ***
111400141001       IF @@ADD = 'N' AND @HCOMSCH <> '1';
111500141001          LEAVESR;
111600141001       ENDIF;
111700141001    ***
111800141001       CHAIN KF@CAR RCARMKSZ;
111900141001       IF NOT %FOUND(CARMKSZ4);
112000141001          PRM@CAR = KF@CAR;
112100141001     C                   CALL      'FM084CL'
112200141001     C                   PARM                    PRM@CAR
112300141001       ENDIF;
112400141001    ***
112500141001       CHAIN KF@CAR RADMNFEE;
112600141001       IF NOT %FOUND(ADMNFEE1);
112700141001          PRM@CAR = KF@CAR;
112800141001     C                   CALL      'FM081CL'
112900141001     C                   PARM                    PRM@CAR
113000141001       ENDIF;
113100141001    ***
113200141001       CHAIN KF@CAR RBONUSDR;
113300141001       IF NOT %FOUND(BONUSDR1);
113400141001          PRM@CAR = KF@CAR;
113500141001     C                   CALL      'FM082CL'
113600141001     C                   PARM                    PRM@CAR
113700141001       ENDIF;
113800141001    ***
113900141001       CHAIN KF@CAR RBRKRCOM;
114000141001       IF NOT %FOUND(BRKRCOM1);
114100141001          PRM@CAR = KF@CAR;
114200141001     C                   CALL      'FM083CL'
114300141001     C                   PARM                    PRM@CAR
114400141001       ENDIF;
114500141001    ***
114600141001       CHAIN KF@CAR RCARMKSZ;
114700141001       CHAIN KF@CAR RADMNFEE;
114800141001       CHAIN KF@CAR RBONUSDR;
114900141001       CHAIN KF@CAR RBRKRCOM;
115000141001       IF NOT %FOUND(CARMKSZ4) OR NOT %FOUND(ADMNFEE1) OR
115100141001          NOT %FOUND(BRKRCOM1) OR NOT %FOUND(BONUSDR1);
115200150324          msgdata = 'MKT SIZE/ADM FEE/BONUS DR REQUIRED SET UP';
115300141001          @@VALID = 'N';
115400141001       ENDIF;
115500141001    ***
115600141001     C                   ENDSR
115700141001    ***
115800150324      *----------------------------------------------------------------
115900141001    *** COMMISSION SCHEDULE 1 RULES
116000150324      *----------------------------------------------------------------
116100141001     C     $SCHED1       BEGSR
116200141001    ***
116300141001       CHAIN KF@CAR RCARMKSZ;
116400141001       IF NOT %FOUND(CARMKSZ4);
116500141001          PRM@CAR = KF@CAR;
116600141001     C                   CALL      'FM084CL'
116700141001     C                   PARM                    PRM@CAR
116800141001       ENDIF;
116900141001    ***
117000141001       CHAIN KF@CAR RCARMKSZ;
117100141001       IF NOT %FOUND(CARMKSZ4);
117200150324          msgdata = 'ALL CARRIERS REQUIRE MKT SIZES';
117300141001          @@VALID = 'N';
117400141001       ENDIF;
117500141001    ***
117600141001     C                   ENDSR
117700150507     C*----------------------------------------------------------------
117800150507     C* SCREEN 3 PRE-PROCESSING
117900150507     C*----------------------------------------------------------------
118000141001     C     $PREPSC3      BEGSR
118100150507
118200150507       EXSR $UNLOCK;
118300150507
118400150507
118500180522       %SubArr(*in : 50 : 16) = *off;
118600141001       CHAIN KF@CAR CARMST2R;
118700141001       IF NOT %FOUND(CARMST2P);
118800150324          msgdata = 'ERROR ON QUALIFY EVENT RULES, TRY AGAIN OR CONTACT I.T.';
118900141001          @STEP = 'PREP SCR 2';
119000141001       ENDIF;
119100150507
119200150507        //?ADD Transaction Type
119300150507        S3ACOURT  = C2ACOURT ;
119400150507        S3ADEPADD = C2ADEPADD;
119500150507        S3ADISABL = C2ADISABL;
119600150507        S3AEMPSTS = C2AEMPSTS;
119700150507        S3AEMRELO = C2AEMRELO;
119800150507        S3AMARIED = C2AMARIED;
119900150507        S3ASPSEST = C2ASPSEST;
120000150507        s3aDivorc = c2aDivorc;
120100150507
120200150507
120300150507
120400150507        //?TERM Transaction Type
120500150507        S3CCOURT  = C2CCOURT ;
120600150507        S3CDISABL = C2CDISABL;
120700150507        S3CEMPSTS = C2CEMPSTS;
120800150507        S3CMEDCAR = C2CMEDCAR;
120900150507        S3CDIVORC = C2CDIVORC;
121000150507        S3CDEPLOS = C2CDEPLOS;
121100150507        S3CSPSEST = C2CSPSEST;
121200150507        S3CSTUSTS = C2CSTUSTS;
121300180522        S3ASTUSTS = C2ASTUSTS;
121400150507        s3cBirth  = c2cBirth;
121500150507        s3cMaried = c2cMaried;
121600150507
121700150128        S3RETRODY =  C2RETRODY;
121800150507
121900141001       @STEP = 'SCREEN #3 ';
122000150507
122100150507       Endsr;
122200150324      *----------------------------------------------------------------
122300150507      *?SCREEN 3 PROCESSING
122400150324      *----------------------------------------------------------------
122500150507       Begsr $Screen3;
122600150507
122700150507          write MSGCTL;
122800150507          EXFMT IO03 ;
122900150406
123000150507          exsr RemoveMsg;
123100150507          %Subarr(*in : 50 : 19) = *off;
123200150507          %Subarr(*in : 30 : 19) = *off;
123300150507
123400150507          E3MSG = *BLANKS;
123500150507          PRM@CAR = KF@CAR;
123600150507
123700150507
123800150507          //-------------------------------------------
123900150507          //  EXIT BACK
124000150507          //-------------------------------------------
124100150507          IF FKEY = F1;
124200150507             @STEP = 'PREP SCR 2';
124300150507             EXSR $UNLOCK;
124400150507             LEAVESR;
124500150507          ENDIF;
124600150507
124700150507
124800150507          //-------------------------------------------
124900150507          //  LEAVE APPLICATION
125000150507          //-------------------------------------------
125100150507          IF FKEY = F7;
125200150507             @STEP = 'LEAVE PGM ';
125300150507             EXSR $UNLOCK;
125400150507             LEAVESR;
125500150507          ENDIF;
125600150507
125700150507
125800150507          IF FKEY = F9;
125900150507             @STEP = 'PREP SCR 4';
126000150507             LEAVESR;
126100150507          ENDIF;
126200150507
126300150507
126400150507          IF FKEY = F4;
126500150507             EXSR $S3F4;
126600150507             LEAVESR;
126700150507          ENDIF;
126800150507
126900150507
127000150507
127100150507          //-------------------------------------------
127200150507          // ?Validate
127300150507          //-------------------------------------------
127400150507          EXSR $VALSCR3;
127500150507
127600150507          IF @@Valid = 'N';
127700150507             LEAVESR;
127800150507          ENDIF;
127900150507
128000150507
128100150507          //-------------------------------------------
128200150507          // ?Update File.
128300150507          //-------------------------------------------
128400150507          C2ACOURT  = S3ACOURT ;
128500150507          C2ADEPADD = S3ADEPADD;
128600150507          C2ADISABL = S3ADISABL;
128700150507          C2AEMPSTS = S3AEMPSTS;
128800150507          C2AEMRELO = S3AEMRELO;
128900150507          C2AMARIED = S3AMARIED;
129000150507          C2ASPSEST = S3ASPSEST;
129100150507          c2aDivorc = s3aDivorc;
129200150507
129300150507          C2CCOURT  = S3CCOURT ;
129400150507          C2CDISABL = S3CDISABL;
129500150507          C2CEMPSTS = S3CEMPSTS;
129600150507          C2CMEDCAR = S3CMEDCAR;
129700150507          C2CDIVORC = S3CDIVORC;
129800150507          C2CDEPLOS = S3CDEPLOS;
129900150507          C2CSPSEST = S3CSPSEST;
130000150507          C2CSTUSTS = S3CSTUSTS;
130100150507          c2cBirth  = s3cBirth;
130200180521          C2ASTUSTS = S3ASTUSTS;
130300150507          c2cMaried = s3cMaried;
130400180521          C2ASTUSTS = S3ASTUSTS;
130500150507
130600150507          C2RETRODY = S3RETRODY;
130700150507
130800150507          UPDATE CARMST2R;
130900150507          @STEP = 'PREP SCR 2';
131000150507
131100150507       Endsr;
131200150507
131300150507       //--------------------------------------------------------------
131400150507       //? PROMPTS
131500150507       //--------------------------------------------------------------
131600150507       Begsr  $S3F4;
131700150507
131800150109       CLEAR WUICOD;
131900150109       C20TYPE = 'QUALEVENT';
132000150109    ***
132100150109     C                   IF        WSFLD = *BLANKS
132200150109     C                   LEAVESR
132300150109     C                   ENDIF
132400150109    ***
132500150128     C                   IF        WSFLD = 'S3RETRODY'
132600150128     C                   LEAVESR
132700150128     C                   ENDIF
132800150128    ***
132900150121     C                   CALL      'SLCC20C132'
133000150109    ?C                   Parm                    WIRQS             8            PROGRAM REQUEST
133100150109    ?C                   Parm                    WORTN             8            RETURN CODE
133200150109    ?C                   Parm                    WUPGM            10            LAST PGM NAME
133300150109    ?C                   Parm                    WUICOD                         RECORD DS
133400150109    ***
133500150109     C                   MOVEA     '0000000000'  *IN(50)
133600150109     C                   MOVEA     '00000'       *IN(60)
133700150507              %Subarr(*in : 50 : 19) = *off;
133800150507              %Subarr(*in : 30 : 19) = *off;
133900150507
134000150507
134100150507       //--------------------------------------------------------------
134200150507          Select;
134300150507
134400150507          When wsFld = 'S3ADEPADD';
134500150507             *in30 = *on;
134600150507             if woRtn = *Blanks;
134700150507                S3ADEPADD = C20CODE;
134800150507             endif;
134900150507
135000150507          When wsFld = 'S3ACOURT';
135100150507             *in38 = *on;
135200150507             if woRtn = *Blanks;
135300150507                S3ACOURT   = C20CODE;
135400150507             endif;
135500150507
135600150507          When wsFld = 'S3ADISABL';
135700150507             *in40 = *on;
135800150507             if woRtn = *Blanks;
135900150507                S3ADISABL  = C20CODE;
136000150507             endif;
136100150507
136200150507          When wsFld = 'S3AEMPSTS';
136300150507             *in34 = *on;
136400150507             if woRtn = *Blanks;
136500150507                S3AEMPSTS  = C20CODE;
136600150507             endif;
136700150507
136800150507          When wsFld = 'S3AEMRELO';
136900150507             *in42 = *on;
137000150507             if woRtn = *Blanks;
137100150507                S3AEMRELO  = C20CODE;
137200150507             endif;
137300150507
137400150507          When wsFld = 'S3AMARIED';
137500150507             *in32 = *on;
137600150507             if woRtn = *Blanks;
137700150507                S3AMARIED  = C20CODE;
137800150507             endif;
137900150507
138000150507          When wsFld = 'S3ASPSEST';
138100150507             *in36 = *on;
138200150507             if woRtn = *Blanks;
138300150507                S3ASPSEST  = C20CODE;
138400150507             endif;
138500150507
138600150507          When wsFld = 'S3CCOURT';
138700150507             *in39 = *on;
138800150507             if woRtn = *Blanks;
138900150507                S3CCOURT   = C20CODE;
139000150507             endif;
139100150507
139200150507          When wsFld = 'S3CDISABL';
139300150507             *in41 = *on;
139400150507             if woRtn = *Blanks;
139500150507                S3CDISABL  = C20CODE;
139600150507             endif;
139700150507
139800150507          When wsFld = 'S3CEMPSTS';
139900150507             *in35 = *on;
140000150507             if woRtn = *Blanks;
140100150507                S3CEMPSTS  = C20CODE;
140200150507             endif;
140300150507
140400150507          When wsFld = 'S3CMARIED';
140500150507             *in43 = *on;
140600150507             if woRtn = *Blanks;
140700150507                S3CMARIED  = C20CODE;
140800150507             endif;
140900150507
141000150507          When wsFld = 'S3CMEDCAR';
141100150507             *in44 = *on;
141200150507             if woRtn = *Blanks;
141300150507                S3CMEDCAR  = C20CODE;
141400150507             endif;
141500150507
141600150507          When wsFld = 'S3CDIVORC';
141700150507             *in33 = *on;
141800150507             if woRtn = *Blanks;
141900150507                S3CDIVORC  = C20CODE;
142000150507             endif;
142100150507
142200150507          When wsFld = 'S3CDEPLOS';
142300150507             *in31 = *on;
142400150507             if woRtn = *Blanks;
142500150507                S3CDEPLOS  = C20CODE;
142600150507             endif;
142700150507
142800150507          When wsFld = 'S3CSPSEST';
142900150507             *in37 = *on;
143000150507             if woRtn = *Blanks;
143100150507                S3CSPSEST  = C20CODE;
143200150507             endif;
143300150507
143400150507          When wsFld = 'S3CSTUSTS';
143500150507             *in45 = *on;
143600150507             if woRtn = *Blanks;
143700150507                S3CSTUSTS  = C20CODE;
143800150507             endif;
143900150507
144000180521          When wsFld = 'S3ASTUSTS';
144100180521             *in49 = *on;
144200180521             if woRtn = *Blanks;
144300180521                S3ASTUSTS  = C20CODE;
144400180521             endif;
144500180521
144600150507          When wsFld = 'S3CBIRTH';
144700150507             *in47 = *on;
144800150507             if woRtn = *Blanks;
144900150507                S3CBIRTH  = C20CODE;
145000150507             endif;
145100150507
145200150507          When wsFld = 'S3ADIVORC';
145300150507             *in48 = *on;
145400150507             if woRtn = *Blanks;
145500150507                S3ADIVORC  = C20CODE;
145600150507             endif;
145700150507
145800150507          Endsl;
145900150507
146000150507          wsFld = *blanks;
146100150507
146200150507
146300150507        Endsr;
146400150507
146500150324      *----------------------------------------------------------------
146600141001    *** SCREEN 3 VALIDATE
146700150324      *----------------------------------------------------------------
146800141001     C     $VALSCR3      BEGSR
146900150406
147000150406           @@Valid = 'Y';
147100150406           KF@T20 = 'QUALEVENT';
147200150406
147300150528          //---------------------------------------------
147400150528          //?Birth / Adoption
147500150528          //---------------------------------------------
147600150406          if s3ADEPADD = *Blanks;
147700150507             MsgData = 'ADD Birth / Adoption Field can not be blank';
147800150406             exsr SendMsg;
147900150406             *IN50 = *ON;
148000150507             *IN30 = *ON;
148100150406             @@Valid = 'N';
148200150406          else;
148300150406
148400150406             KF@C20 = S3ADEPADD;
148500150406             EXSR $C20CHK;
148600150406             IF E3MSG <> *BLANKS;
148700150406                MsgData  = %TRIM(E3MSG) + ' TYPE ADD BIRTH/ADOPTION';
148800150406                exsr SendMsg;
148900150406                *IN50 = *ON;
149000150507                *IN30 = *ON;
149100150406                @@Valid = 'N';
149200150406             ENDIF;
149300150406          endif;
149400150406
149500150406
149600150507          // Birth / Adoption
149700150507          if s3cBirth  = *Blanks;
149800150507             MsgData = 'TERM Birth / Adoption Field can not be blank';
149900150507             exsr SendMsg;
150000150507             *IN67 = *ON;
150100150507             *IN47 = *ON;
150200150507             @@Valid = 'N';
150300150507          else;
150400150507
150500150507             KF@C20 = S3cBirth;
150600150507             EXSR $C20CHK;
150700150507             IF E3MSG <> *BLANKS;
150800150507                MsgData  = %TRIM(E3MSG) + ' TYPE ADD BIRTH/ADOPTION';
150900150507                exsr SendMsg;
151000150507                *IN67 = *ON;
151100150507                *IN47 = *ON;
151200150507                @@Valid = 'N';
151300150507             ENDIF;
151400150507          endif;
151500150507
151600150507
151700150528          //---------------------------------------------
151800150528          //?Marriage
151900150528          //---------------------------------------------
152000150528          if S3AMARIED = *Blanks;
152100150528             MsgData = 'ADD Marriage Field can not be blank';
152200150528             exsr SendMsg;
152300150528             *IN52 = *ON;
152400150528             *IN32 = *ON;
152500150528             @@Valid = 'N';
152600150528          else;
152700150528
152800150528             KF@C20 = S3AMARIED;
152900150528             EXSR $C20CHK;
153000150528             IF E3MSG <> *BLANKS;
153100150528                MsgData = %TRIM(E3MSG) + ' TYPE ADD MARRIAGE';
153200150528                exsr SendMsg;
153300150528                *IN52 = *ON;
153400150528                *IN32 = *ON;
153500150528                @@Valid = 'N';
153600150528             ENDIF;
153700150528          endif;
153800150528
153900150528
154000150528          // Marriage
154100150528          if S3CMARIED = *Blanks;
154200150528             MsgData = 'TERM Marriage Field can not be blank';
154300150528             exsr SendMsg;
154400150528             *IN63 = *ON;
154500150528             *IN43 = *ON;
154600150528             @@Valid = 'N';
154700150528          else;
154800150528
154900150528             KF@C20 = S3CMARIED;
155000150528             EXSR $C20CHK;
155100150528             IF E3MSG <> *BLANKS;
155200150528                MsgData = %TRIM(E3MSG) + ' TYPE ADD MARRIAGE';
155300150528                exsr SendMsg;
155400150528                *IN63 = *ON;
155500150528                *IN43 = *ON;
155600150528                @@Valid = 'N';
155700150528             ENDIF;
155800150528          endif;
155900150528
156000150528
156100150528          //---------------------------------------------
156200150528          //?Employment Status
156300150528          //---------------------------------------------
156400150528          if S3AEMPSTS = *Blanks;
156500150528             MsgData = 'ADD Employment Status Field can not be blank';
156600150528             exsr SendMsg;
156700150528             *IN54 = *ON;
156800150528             *IN34 = *ON;
156900150528             @@Valid = 'N';
157000150528          else;
157100150528
157200150528             KF@C20 = S3AEMPSTS;
157300150528             EXSR $C20CHK;
157400150528             IF E3MSG <> *BLANKS;
157500150528                MsgData = %TRIM(E3MSG) + ' TYPE ADD EMPLOYMENT STATUS';
157600150528                exsr SendMsg;
157700150528                *IN54 = *ON;
157800150528                *IN34 = *ON;
157900150528                @@Valid = 'N';
158000150528             ENDIF;
158100150528          endif;
158200150528
158300150528
158400150528          // Employment Status
158500150528          if S3CEMPSTS = *Blanks;
158600150528             MsgData = 'TERM Employment Status Field can not be blank';
158700150528             exsr SendMsg;
158800150528             *IN55 = *ON;
158900150528             *IN35 = *ON;
159000150528             @@Valid = 'N';
159100150528          else;
159200150528
159300150528             KF@C20 = S3CEMPSTS;
159400150528             EXSR $C20CHK;
159500150528             IF E3MSG <> *BLANKS;
159600150528                MsgData = %TRIM(E3MSG) + ' TYPE TERM EMPLOYMENT STATUS';
159700150528                exsr SendMsg;
159800150528                *IN55 = *ON;
159900150528                *IN35 = *ON;
160000150528                @@Valid = 'N';
160100150528             ENDIF;
160200150528          endif;
160300150528
160400150528
160500150528          //---------------------------------------------
160600150528          //?ADD SPOUSE EMPLOYMENT/COVERAGE CHANGE
160700150528          //---------------------------------------------
160800150406          if S3ASPSEST = *Blanks;
160900150406             MsgData = 'ADD Spouse Employment/ Coverage ' +
161000150406                'Change Field can not be blank';
161100150406             exsr SendMsg;
161200150406             *IN56 = *ON;
161300150507             *IN36 = *ON;
161400150406             @@Valid = 'N';
161500150406          else;
161600150406
161700150406             KF@C20 = S3ASPSEST;
161800150406             EXSR $C20CHK;
161900150406             IF E3MSG <> *BLANKS;
162000150406                MsgData = %TRIM(E3MSG) +
162100150406                 ' TYPE ADD SPOUSE EMPLOYMENT/COVERAGE CHANGE';
162200150406                exsr SendMsg;
162300150406                *IN56 = *ON;
162400150507                *IN36 = *ON;
162500150406                @@Valid = 'N';
162600150406             ENDIF;
162700150406          endif;
162800150406
162900150406
163000150406
163100150406          // TERM SPOUSE EMPLOYMENT/COVERAGE CHANGE
163200150406          if S3CSPSEST = *Blanks;
163300150406             MsgData = 'TERM Spouse Employment/ Coverage ' +
163400150406                'Change Field can not be blank';
163500150406             exsr SendMsg;
163600150406             *IN57 = *ON;
163700150507             *IN37 = *ON;
163800150406             @@Valid = 'N';
163900150406          else;
164000150406
164100150406             KF@C20 = S3CSPSEST;
164200150406             EXSR $C20CHK;
164300150406             IF E3MSG <> *BLANKS;
164400150406                MsgData = %TRIM(E3MSG) +
164500150406                 ' TYPE TERM SPOUSE EMPLOYMENT/COVERAGE CHANGE';
164600150406                exsr SendMsg;
164700150406                *IN57 = *ON;
164800150507                *IN37 = *ON;
164900150406                @@Valid = 'N';
165000150406             ENDIF;
165100150406          endif;
165200150406
165300150406
165400150406
165500150528          //---------------------------------------------
165600150528          //?ADD Court Order / Judgement
165700150528          //---------------------------------------------
165800150406          if S3ACOURT = *Blanks;
165900150406             MsgData = 'ADD Court Order / Judgement ' +
166000150406                'Field can not be blank';
166100150406             exsr SendMsg;
166200150406             *IN58 = *ON;
166300150507             *IN38 = *ON;
166400150406             @@Valid = 'N';
166500150406          else;
166600150406
166700150406             KF@C20 = S3ACOURT;
166800150406             EXSR $C20CHK;
166900150406             IF E3MSG <> *BLANKS;
167000150406                MsgData = %TRIM(E3MSG) +
167100150406                 ' TYPE ADD COURT ORDER/JUDGEMENT';
167200150406                exsr SendMsg;
167300150406                *IN58 = *ON;
167400150507                *IN38 = *ON;
167500150406                @@Valid = 'N';
167600150406             ENDIF;
167700150406          endif;
167800150406
167900150406
168000150406
168100150406          // TERM Court Order / Judgement
168200150406          if S3CCOURT = *Blanks;
168300150406             MsgData = 'TERM Court Order / Judgement ' +
168400150406                'Field can not be blank';
168500150406             exsr SendMsg;
168600150406             *IN59 = *ON;
168700150507             *IN39 = *ON;
168800150406             @@Valid = 'N';
168900150406          else;
169000150406
169100150406             KF@C20 = S3CCOURT;
169200150406             EXSR $C20CHK;
169300150406             IF E3MSG <> *BLANKS;
169400150406                MsgData = %TRIM(E3MSG) +
169500150406                 ' TYPE TERM COURT ORDER/JUDGEMENT';
169600150406                exsr SendMsg;
169700150406                *IN59 = *ON;
169800150507                *IN39 = *ON;
169900150406                @@Valid = 'N';
170000150406             ENDIF;
170100150406          endif;
170200150406
170300150406
170400150528          //---------------------------------------------
170500150528          //?ADD Disabled Status
170600150528          //---------------------------------------------
170700150406          if S3ADISABL = *Blanks;
170800150406             MsgData = 'ADD Disabled Status ' +
170900150406                'Field can not be blank';
171000150406             exsr SendMsg;
171100150406             *IN60 = *ON;
171200150507             *IN40 = *ON;
171300150406             @@Valid = 'N';
171400150406          else;
171500150406
171600150406             KF@C20 = S3ADISABL;
171700150406             EXSR $C20CHK;
171800150406             IF E3MSG <> *BLANKS;
171900150406                MsgData = %TRIM(E3MSG) +
172000150406                 ' TYPE ADD DISABLED STATUS';
172100150406                exsr SendMsg;
172200150406                *IN60 = *ON;
172300150507                *IN40 = *ON;
172400150406                @@Valid = 'N';
172500150406             ENDIF;
172600150406          endif;
172700150406
172800150406
172900150406          // TERM Disabled Status
173000150406          if S3CDISABL = *Blanks;
173100150406             MsgData = 'TERM Disabled Status ' +
173200150406                'Field can not be blank';
173300150406             exsr SendMsg;
173400150406             *IN61 = *ON;
173500150507             *IN41 = *ON;
173600150406             @@Valid = 'N';
173700150406          else;
173800150406
173900150406             KF@C20 = S3CDISABL;
174000150406             EXSR $C20CHK;
174100150406             IF E3MSG <> *BLANKS;
174200150406                MsgData = %TRIM(E3MSG) +
174300150406                 ' TYPE TERM DISABLED STATUS';
174400150406                exsr SendMsg;
174500150406                *IN61 = *ON;
174600150507                *IN41 = *ON;
174700150406                @@Valid = 'N';
174800150406             ENDIF;
174900150406          endif;
175000150406
175100150406
175200150528          //---------------------------------------------
175300150528          //?Divorce
175400150528          //---------------------------------------------
175500150528          if S3CDIVORC = *Blanks;
175600150528             MsgData = 'TERM Divorce Field can not be blank';
175700150528             exsr SendMsg;
175800150528             *IN53 = *ON;
175900150528             *IN33 = *ON;
176000150528             @@Valid = 'N';
176100150528          else;
176200150528
176300150528             KF@C20 = S3CDIVORC;
176400150528             EXSR $C20CHK;
176500150528             IF E3MSG <> *BLANKS;
176600150528                MsgData = %TRIM(E3MSG) + ' TYPE TERM DIVORCE';
176700150528                exsr SendMsg;
176800150528                *IN53 = *ON;
176900150528                *IN33 = *ON;
177000150528                @@Valid = 'N';
177100150528             ENDIF;
177200150528          endif;
177300150528
177400150528
177500150528          // Divorce
177600150528          if S3ADIVORC = *Blanks;
177700150528             MsgData = 'ADD Divorce Field can not be blank';
177800150528             exsr SendMsg;
177900150528             *IN68 = *ON;
178000150528             *IN48 = *ON;
178100150528             @@Valid = 'N';
178200150528          else;
178300150528
178400150528             KF@C20 = S3ADIVORC;
178500150528             EXSR $C20CHK;
178600150528             IF E3MSG <> *BLANKS;
178700150528                MsgData = %TRIM(E3MSG) + ' TYPE TERM DIVORCE';
178800150528                exsr SendMsg;
178900150528                *IN68 = *ON;
179000150528                *IN48 = *ON;
179100150528                @@Valid = 'N';
179200150528             ENDIF;
179300150528          endif;
179400150528
179500150528
179600150528          //---------------------------------------------
179700150528          //?ADD EMPLOYEE RELOCATION
179800150528          //---------------------------------------------
179900150406          if S3AEMRELO = *Blanks;
180000150406             MsgData = 'ADD Employee Relocation ' +
180100150406                'Field can not be blank';
180200150406             exsr SendMsg;
180300150406             *IN62 = *ON;
180400150507             *IN42 = *ON;
180500150406             @@Valid = 'N';
180600150406          else;
180700150406
180800150406             KF@C20 = S3AEMRELO;
180900150406             EXSR $C20CHK;
181000150406             IF E3MSG <> *BLANKS;
181100150406                MsgData = %TRIM(E3MSG) +
181200150406                 ' TYPE ADD EMPLOYEE RELOCATION';
181300150406                exsr SendMsg;
181400150406                *IN62 = *ON;
181500150507                *IN42 = *ON;
181600150406                @@Valid = 'N';
181700150406             ENDIF;
181800150406          endif;
181900150406
182000150406
182100150528          //---------------------------------------------
182200150528          //?TERM MEDICARE/MEDICAID ELIGIBILE
182300150528          //---------------------------------------------
182400150406          if S3CMEDCAR = *Blanks;
182500150406             MsgData = 'TERM Medicare/Medicaid Eligible ' +
182600150406                'Field can not be blank';
182700150406             exsr SendMsg;
182800150406             *IN64 = *ON;
182900150507             *IN44 = *ON;
183000150406             @@Valid = 'N';
183100150406          else;
183200150406
183300150406             KF@C20 = S3CMEDCAR;
183400150406             EXSR $C20CHK;
183500150406             IF E3MSG <> *BLANKS;
183600150406                MsgData = %TRIM(E3MSG) +
183700150406                 ' TYPE TERM MEDICARE/MEDICAID ELIGIBILE';
183800150406                exsr SendMsg;
183900150406                *IN64 = *ON;
184000150507                *IN44 = *ON;
184100150406                @@Valid = 'N';
184200150406             ENDIF;
184300150406          endif;
184400150406
184500150406
184600150528          //---------------------------------------------
184700150528          //?TERM DEPENDENT LIMITING AGE/STUDENT STATUS
184800150528          //---------------------------------------------
184900150406          if S3CSTUSTS = *Blanks;
185000150406             MsgData = 'TERM Dependent Limiting age/student Status ' +
185100150406                'Field can not be blank';
185200150406             exsr SendMsg;
185300150406             *IN65 = *ON;
185400150507             *IN45 = *ON;
185500150406             @@Valid = 'N';
185600150406          else;
185700150406
185800150406             KF@C20 = S3CSTUSTS;
185900150406             EXSR $C20CHK;
186000150406             IF E3MSG <> *BLANKS;
186100150406                MsgData = %TRIM(E3MSG) +
186200150406                 ' TYPE TERM DEPENDENT LIMITING AGE/STUDENT STATUS';
186300150406                exsr SendMsg;
186400150406                *IN65 = *ON;
186500150507                *IN45 = *ON;
186600150406                @@Valid = 'N';
186700150406             ENDIF;
186800150406          endif;
186900150406
187000180521
187100180521          //---------------------------------------------
187200180521          //?ADD DEPENDENT LIMITING AGE/STUDENT STATUS
187300180521          //---------------------------------------------
187400180521          if S3ASTUSTS = *Blanks;
187500180521             MsgData = 'ADD Dependent Limiting age/student Status ' +
187600180521                'Field can not be blank';
187700180521             exsr SendMsg;
187800180521             *IN69 = *ON;
187900180521             *IN49 = *ON;
188000180521             @@Valid = 'N';
188100180521          else;
188200180521
188300180521             KF@C20 = S3ASTUSTS;
188400180521             EXSR $C20CHK;
188500180521             IF E3MSG <> *BLANKS;
188600180521                MsgData = %TRIM(E3MSG) +
188700180521                 ' TYPE ADD DEPENDENT LIMITING AGE/STUDENT STATUS';
188800180521                exsr SendMsg;
188900180521                *IN69 = *ON;
189000180521                *IN49 = *ON;
189100180521                @@Valid = 'N';
189200180521             ENDIF;
189300180521          endif;
189400180521
189500180521
189600150528          //---------------------------------------------
189700150528          //?Dependent Loss of Life
189800150528          //---------------------------------------------
189900150528          if s3CDEPLOS = *Blanks;
190000150528             MsgData = 'Dependent Loss of Life Field can not be blank';
190100150528             exsr SendMsg;
190200150528             *IN51 = *ON;
190300150528             *IN31 = *ON;
190400150528             @@Valid = 'N';
190500150528          else;
190600150528
190700150528             KF@C20 = S3CDEPLOS;
190800150528             EXSR $C20CHK;
190900150528             IF E3MSG <> *BLANKS;
191000150528                MsgData = %TRIM(E3MSG) + ' TYPE TERM DEPENDENT LOSS OF LIFE';
191100150528                exsr SendMsg;
191200150528                *IN51 = *ON;
191300150528                *IN31 = *ON;
191400150528                @@Valid = 'N';
191500150528             ENDIF;
191600150528          endif;
191700150528
191800150406
191900150528        //if s3Retrody = 0;
192000150528        //   MsgData = 'The Enrollment Processing Period can not be 0';
192100150528        //   exsr SendMsg;
192200150528        //   *IN66 = *ON;
192300150528        //   @@Valid = 'N';
192400150528        //endif;
192500150406
192600141001     C                   ENDSR
192700150324      *----------------------------------------------------------------
192800150324    *** CODE20 CHECK FOR SCREEN 3 VALUES
192900150324      *----------------------------------------------------------------
193000141001     C     $C20CHK       BEGSR
193100141001    ***
193200141001       CHAIN (KF@T20:KF@C20) CODE20F;
193300150406       e3Msg = *Blanks;
193400141001    ***
193500141001       IF NOT %FOUND(CODE20P);
193600141001          E3MSG = 'CODE NOT VALID FOR';
193700141001          LEAVESR;
193800141001       ENDIF;
193900141001    ***
194000141001       IF %FOUND(CODE20P) AND C20DLTD <> 'A';
194100141001          E3MSG = 'INACTIVE CODE ASSIGNED TO';
194200141001       ENDIF;
194300141001    ***
194400141001     C                   ENDSR
194500141001    ***
194600150324      *----------------------------------------------------------------
194700150112    *** SCREEN 4 PRE-PROCESSING
194800150324      *----------------------------------------------------------------
194900150112     C     $PREPSC4      BEGSR
195000150112    ***
195100150112       CLEAR HLDCA2;
195200150112       HLDCA2 = INPCA2;
195300150112       UNLOCK(E) CARMST2P;
195400150112       S4TOCARR = *BLANKS;
195500150112       S4CARRDESC = *BLANKS;
195600150120       *IN42 = *OFF;
195700150112    ***
195800150112       @STEP = 'SCREEN #4 ';
195900150112    ***
196000150112     C                   ENDSR
196100150112    ***
196200150112   S***S
196300150324      *----------------------------------------------------------------
196400150112    *** SCREEN 4 PROCESSING
196500150324      *----------------------------------------------------------------
196600150112     C     $SCREEN4      BEGSR
196700150112    ***
196800150112     C                   EXFMT     IO04
196900150112    ***
197000150112       E4MSG = *BLANKS;
197100150112    ***
197200150112    *** EXIT BACK
197300150112    ***
197400150112       IF FKEY = F1;
197500150112          @STEP = 'PREP SCR 2';
197600150112          LEAVESR;
197700150112       ENDIF;
197800150112    ***
197900150112    *** LEAVE APPLICATION
198000150112    ***
198100150112       IF FKEY = F7;
198200150112          @STEP = 'LEAVE PGM ';
198300150112          EXSR $UNLOCK;
198400150112          LEAVESR;
198500150112       ENDIF;
198600150112    ***
198700150120       IF FKEY = F10;
198800150120          EXSR $COPYIT;
198900150120          LEAVESR;
199000150120       ENDIF;
199100150120    ***
199200150112       IF FKEY = F4;
199300150112          EXSR $S4F4;
199400150112          LEAVESR;
199500150112       ENDIF;
199600150120    ***
199700150112       EXSR $VALSCR4;
199800150112    ***
199900150112       IF E4MSG <> *BLANKS;
200000150112          LEAVESR;
200100150120       ELSE;
200200150120          *IN42 = *ON;
200300150112       ENDIF;
200400150112    ***
200500150112    ***
200600150112     C                   ENDSR
200700150324      *----------------------------------------------------------------
200800150120     C     $COPYIT       BEGSR
200900150120    ***
201000150120       CHAIN (S4TOCARR) CARMST2R;
201100150120       C2ACOURT  = Z2ACOURT ;
201200150120       C2ADEPADD = Z2ADEPADD;
201300150120       C2ADISABL = Z2ADISABL;
201400150120       C2AEMPSTS = Z2AEMPSTS;
201500150120       C2AEMRELO = Z2AEMRELO;
201600150120       C2AMARIED = Z2AMARIED;
201700150120       C2ASPSEST = Z2ASPSEST;
201800150120       C2CCOURT  = Z2CCOURT ;
201900150120       C2CDISABL = Z2CDISABL;
202000150120       C2CEMPSTS = Z2CEMPSTS;
202100150120       C2CMEDCAR = Z2CMEDCAR;
202200150120       C2CDIVORC = Z2CDIVORC;
202300150120       C2CDEPLOS = Z2CDEPLOS;
202400150120       C2CSPSEST = Z2CSPSEST;
202500150120       C2CSTUSTS = Z2CSTUSTS;
202600150128       C2RETRODY = Z2RETRODY;
202700180522       C2ASTUSTS = Z2ASTUSTS;
202800150507
202900150507       C2ADIVORC = Z2ADIVORC;
203000150507       C2CBIRTH  = Z2CBIRTH;
203100150507       C2CMARIED = Z2CMARIED;
203200150507
203300150507
203400150120    ***
203500150120       UPDATE CARMST2R;
203600150120       @STEP = 'PREP SCR 4';
203700150120       E4MSG = 'COPY TO ' + S4TOCARR + ' COMPLETED';
203800150120    ***
203900150120     C                   ENDSR
204000150324      *----------------------------------------------------------------
204100150112    *** PROMPTS FOR SCREEN 4
204200150324      *----------------------------------------------------------------
204300150112     C     $S4F4         BEGSR
204400150112    ***
204500150112     C                   IF        WSFL4 = *BLANKS
204600150112     C                   LEAVESR
204700150112     C                   ENDIF
204800150112    ***
204900150112          @P3 = *BLANKS;
205000150121     C                   CALL      'FM002CL32'
205100150112     C                   PARM                    @P3
205200150112       IF @P3 = '*LR';
205300150112          E4MSG = 'NO SELECTION WAS MADE';
205400150112          LEAVESR;
205500150112       ELSE;
205600150112          S4TOCARR = @P3;
205700150112     C     S4TOCARR      CHAIN(N)  CARMSR
205800150112          IF %FOUND(CARUNIQUE);
205900150112             S4CARRDESC = %TRIM(CNAME);
206000150112          ELSE;
206100150112             S4CARRDESC = '*UNKNOWN*';
206200150112          ENDIF;
206300150112       ENDIF;
206400150112    ***
206500150112     C                   ENDSR
206600150324      *----------------------------------------------------------------
206700150112    *** VALIDATION FOR SCREEN 4
206800150324      *----------------------------------------------------------------
206900150112     C     $VALSCR4      BEGSR
207000150112    ***
207100150112       IF S4TOCARR = *BLANKS;
207200150112          E4MSG = 'TO CARRIER REQUIRED';
207300150112          LEAVESR;
207400150112       ENDIF;
207500150112    ***
207600150112     C     S4TOCARR      CHAIN(N)  CARMSR
207700150112       IF NOT %FOUND(CARUNIQUE);
207800150112          E4MSG = 'TO CARRIER IS INVALID';
207900150112          LEAVESR;
208000150112       ENDIF;
208100150113       S4CARRDESC = %TRIM(CNAME);
208200150112    ***
208300150112     C     S4TOCARR      CHAIN(N)  CARMST2R
208400150112       IF NOT %FOUND(CARMST2P);
208500150112          E4MSG = 'TO CARRIER MASTER 2 IS INVALID';
208600150112          LEAVESR;
208700150112       ENDIF;
208800150112    ***
208900150112       IF C2ADEPADD <> *BLANKS;
209000150112          E4MSG = 'QUALIFY EVENTS ALREADY PRESENT';
209100150112          LEAVESR;
209200150112       ENDIF;
209300150112    ***
209400150112     C                   ENDSR
209500150112    ***
209600150324         //------------------------------------------------------
209700150324         Begsr SendMsg;
209800150324
209900150324            messageid = '';
210000150324            qualmsgf   = '';
210100150324
210200150324       //      msgdata     = 'This is an error message';
210300150324
210400150324            msgdtalen  = %len(%trim(msgdata));
210500150324            msgtype    = '*DIAG';
210600150324            callstkent = '*';
210700150324            callstkcnt = 0;
210800150324            messagekey = ' ';
210900150324
211000150324            sndpgmmsg( messageid: qualmsgf:
211100150324                msgdata : msgdtalen: msgtype:
211200150324                callstkent: callstkcnt: messagekey:
211300150324                *null );
211400150324         Endsr;
211500150324
211600150324       //------------------------------------------------------
211700150324         Begsr RemoveMsg;
211800150324
211900150324            messageRmv = '*ALL';
212000150324            callstkent = '*';
212100150324            callstkcnt = 0;
212200150324            messagekey = ' ';
212300150324            clrpgmmsg(
212400150324                callstkent: callstkcnt: messagekey:
212500150324                messageRmv : *null );
212600150324
212700150324         Endsr;
212800161121
212900161121      ****************************************
213000161121      * DISPLAY abr codes in SUBFILE WINDOW  *
213100161121      ****************************************
213200161121       begsr #dspabr;
213300161121
213400161121      * CLEAR SUBFILE
213500161121       *in80 = *off;
213600161121       *in81 = *off;
213700161121       *in82 = *on;
213800161121       write sf02ctl;
213900161121       *in82 = *off;
214000161121
214100161121      * BUILD SUBFILE
214200161121
214300161121       clear RR2;
214400161121       setll *loval abrctl;
214500161121       dou %eof(abrctl);
214600161121       read abrctl;
214700161121       if not %eof(abrctl) and abcstat = 'A';
214800161121        eval sfabr = abccode;
214900161121        eval sfdesc = abcdesc;
215000161121        rr2 += 1;
215100161121        write sf02;
215200161121       endif;
215300161121       enddo;
215400161121        eval *in81 = *on;
215500161121
215600161121      * DISPLAY SUBFILE IN WINDOW
215700161121      * if no rec found, display not found msg
215800161121        if rr2 = 0;
215900161121         clear sf02;
216000161121         eval sfdesc = 'NOT FOUND';
216100161121         rr2 += 1;
216200161121         write sf02;
216300161121        endif;
216400161121
216500161121        eval *in80 = *on;
216600161121
216700161121        write window2;
216800161121        exfmt sf02ctl;
216900161121
217000161121        endsr;
