000100160322      *=========================================================================
000200160322     H option(*noDebugIo)
000300160322      *=========================================================================
000400130603   X***X CARRIER CONTROL ID #0000000084 NASCO SPECIFIC
000500130531   X***X
000600130531   X***X ACCOUNTS SET-UP
000700130603   X***X 590-010-0004  MIDDLE EAST BROADCASTING INC.
000800130531   X***X
000900130531   X***X
001000130531   X***X NOTE: EACH YEAR, REVIEW THIS PROGRAM AND SET DAY1YMD AND DAY1MDY
001100130531   X***X       TO THE FIRST DAY OF THE NEXT ENROLLMENT YEAR.
001200160322
001300160322      *=========================================================================
001400160322      * Modifications
001500160322      *=========================================================================
001600160322      * Date         Programmer    Description
001700160322      *===========   ==========    =============================================
001800160322      * 05/28/2013   SSK           ORIGINAL
001900160322      * 06/03/2013   SSK           COPIED FROM TEMPLATE
002000160322      * 08/09/2013   SSK           ALTERNATE ID LOGIC
002100160323      * 03/22/2016   J. Torres     Added new plans, and Class file.
002200160322      *
002300160322      *=========================================================================
002400160322
002500130531     FCARACCP   IF   E           K DISK
002600160322
002700130531     FMEMAC#1   IF   E           K DISK
002800130531    ***   MEMBER DEMOGRAPHICS BY T/S/A/SOC
002900160322
003000130531     FMCOVMPLN  IF   E           K DISK
003100130531    ***   MEMBER COVERAGE
003200160322
003300130603     FPCPL1     IF   E           K DISK
003400130603    ***   MEMBER/DEPENDENT PCP
003500160322
003600130812     FMEMALTL4  IF   E           K DISK    RENAME(MEMALTR:NASCF) PREFIX(NF:2)
003700130812    ***   ALT ID BY NASCO ID
003800160322
003900130812     FMEMALTL5  IF   E           K DISK    RENAME(MEMALTR:MBRF) PREFIX(SS:2)
004000130812    ***   ALT ID BY MEMBER SSN
004100160322
004200130531     FDEPNDC    IF   E           K DISK
004300130531    ***   DEPENDENT DEMOGRAPHICS BY SOC/SEQ
004400160322
004500130604     FELIGDCOVL1IF   E           K DISK
004600130531    ***   DEPENDENT COVERAGE BY SOC/SEQ/T/S/ENRL/CAN/P
004700160322
004800130531     F***NASCOVERD IF   E           K DISK
004900130531    ***   NASCO OVERRIDE FILE
005000160322
005100130531     FNASTERMP  UF A E           K DISK
005200130531    ***   MEMBER/DEPENDENT TERMINATION
005300160322
005400130603     FNASW0000  O  A E             DISK
005500130531    ***   ELIG EXPORT WORK
005600160323
005700160323     Fclass     if   e           k disk    extfile('F.CLASS')
005800160322
005900160322      *=========================================================================
006000160322
006100130607     D PLN@CAT         S              5A
006200130603     D CARR#CTL        S             10A   INZ('0000000084')
006300130603     D DAY1MDY         S              8S 0 INZ(07012013)
006400130603     D DAY1YMD         S              8S 0 INZ(20130701)
006500130531   X***X
006600130531     D DS@CARACC     E DS                  EXTNAME(CARACCP)
006700130531   X***X
006800130607     D DS@N0         E DS                  EXTNAME(NASW0000)
006900130607   X***X
007000130531     ** WORK ARRAY FOR PLANS
007100130531     **
007200130531     ** PC# - PLAN COUNT
007300130531     ** PP# - PLAN POINTER
007400130531     **
007500130531     D CARPLN@       E DS                  EXTNAME(CARPLNP)
007600130531     D                                     OCCURS(50) PREFIX(X:1)
007700130531     **
007800130531     D ADT             S              8S 0
007900130531     D BDT             S              8S 0
008000130531     D PC#             S              3S 0
008100130531     D PP#             S              3S 0
008200130531     **
008300130603     D @PCP            S                   LIKE(PCID#)
008400130607     D @PED            S              8A
008500130607     D #PED            S                   LIKE(PCEFF)
008600130603     D @XPI            S                   LIKE(PCCUR)
008700130603     D @PLANIN         S              4A
008800130603     D #EFFDTE         S              8S 0
008900130531     D #BENAMT         S                   LIKE(BENAMT)
009000130531     D @CCTRIN         S              3A
009100130531     D @ENRIN          S              3A
009200130531     D @ENROU          S              3A
009300130531   X***X
009400130531     **
009500130531     ** WRITE TYPE = MEMBER OR DEPEND
009600130531     D WRT@TYPE        S              6A
009700130531     **
009800130531   X***X
009900130531     D #CANCEL         S              8S 0
010000130531     D #DATE           S              8S 0
010100130531     D #SIGN           S               D   DATFMT(*ISO)
010200130531     D #ISO            S               D   DATFMT(*ISO)
010300130531     D #RECCNT         S             10S 0 INZ
010400130531     D #TODAY          S              8S 0
010500130604     D @XSX            S              8A
010600130604     D #8D0            S              8S 0
010700130604     D #8D1            S              8S 0
010800130531     D #XSX            S              8S 0
010900130531     D #15S0           S             15S 0
011000130531     D #7S0            S              7S 0
011100130531     **
011200130812     D KF@ATYP         S              4A   INZ('MIS ')
011300130812     D KF@MEM          S              9S 0
011400130812     D KF@ALID         S             20A
011500130812     D @@MBR           S              9A
011600130812     D @@SUB           S              9A
011700130812    ***
011800130531     D MBR_TERM        S               N
011900130531     D TERM_MED        S               N
012000130531     D TERM_DEN        S               N
012100130531     D YES             S               N   INZ(*ON)
012200130531     D NO              S               N   INZ(*OFF)
012300130531     D @9              S              9A
012400130531    ***
012500130531     D KF@ACC          S                   LIKE(ACC#)
012600130531     D KF@CARG         S              2A   INZ
012700130531     D KF@CCTR         S                   LIKE(CCFLG)
012800130531     D KF@CDE          S              2A
012900130531     D KF@ENR          S              3A   INZ
013000130531     D KF@PLN          S                   LIKE(MCPLAN)
013100130531     D KF@SEQ          S                   LIKE(DPSEQ#)
013200130531     D KF@SSN          S                   LIKE(MBSSNO)
013300130603     D KF@SPCD         S                   LIKE(PCSPCD)
013400130531     D KF@SUB          S                   LIKE(MCSUB#)
013500130531     D KF@TRM          S              8S 0
013600130531     D KF@TRS          S                   LIKE(MCTRST)
013700130531     D KF@TYP          S              1A
013800130531     **
013900130531    ***
014000130531    *** MEDICAL ARRAYS
014100130531    *** CAT: PMM, PDM, PSM
014200130531     D MED#CNE         S              3S 0 INZ
014300130531     D MED#NDX         S              3S 0 INZ
014400130531     D MED@PLN         S              4A   DIM(20)
014500130531     D MED@ENR         S              3A   DIM(20)
014600130531     D MED@FRM         S              8S 0 DIM(20)
014700130531     D MED@TRM         S              8S 0 DIM(20)
014800130531     D MED@MEFF        S              8S 0
014900130531     D MED@MTRM        S              8S 0
015000130531    ***
015100130531    *** DENTAL ARRAYS
015200130531    *** CAT: PDN, PDE, PDR
015300130531     D DEN#CNE         S              3S 0 INZ
015400130531     D DEN#NDX         S              3S 0 INZ
015500130531     D DEN@PLN         S              4A   DIM(20)
015600130531     D DEN@ENR         S              3A   DIM(20)
015700130531     D DEN@FRM         S              8S 0 DIM(20)
015800130531     D DEN@TRM         S              8S 0 DIM(20)
015900130531     D DEN@MEFF        S              8S 0
016000130531     D DEN@MTRM        S              8S 0
016100130531    ***
016200130531    ***
016300130531     D @STEP           S              5A
016400160720
016500160720     d num_date        s              8s 0 inz
016600160720     D work_date       s               d
016700160720
016800130531    ***
016900160322      *=========================================================================
017000160322
017100130531     C                   EVAL      @STEP = 'PREP0'
017200160322
017300130531     C                   DOU       @STEP = 'LEAVE'
017400130531     C     @STEP         CASEQ     'PREP0'       $PREP0
017500130531     C     @STEP         CASEQ     'STEP0'       $STEP0
017600130531     C     @STEP         CASEQ     'PREP1'       $PREP1
017700130531     C     @STEP         CASEQ     'STEP1'       $STEP1
017800130531     C     @STEP         CASEQ     'STEP2'       $STEP2
017900130531     C     @STEP         CASEQ     'STEP3'       $STEP3
018000130531     C     @STEP         CASEQ     'PREP4'       $PREP4
018100130531     C     @STEP         CASEQ     'STEP4'       $STEP4
018200130531     C     @STEP         CASEQ     'PREP5'       $PREP5
018300130531     C     @STEP         CASEQ     'STEP5'       $STEP5
018400130531     C     @STEP         CASEQ     'STEP6'       $STEP6
018500130531     C     @STEP         CASEQ     'PREP7'       $PREP7
018600130531     C     @STEP         CASEQ     'STEP7'       $STEP7
018700130531     C                   ENDCS
018800130531     C                   ENDDO
018900130531    ***
019000130531     C                   EVAL      *INLR = *ON
019100130531   S***S
019200130531     C     $PREP0        BEGSR
019300130531    ***
019400130531     C     CARR#CTL      SETLL     CARACCR
019500130531    ***
019600130531     C                   EVAL      #ISO = %DATE
019700130531     C                   MOVE      #ISO          #TODAY
019800130531    ***
019900130531     C                   EVAL      @STEP = 'STEP0'
020000130531    ***
020100130531     C                   ENDSR
020200130531   S***S
020300130531     C     $STEP0        BEGSR
020400130531    ***
020500130531     C     CARR#CTL      READE     CARACCR
020600130531    ***
020700130531     C                   IF        %EOF(CARACCP)
020800130531     C                   EVAL      @STEP = 'LEAVE'
020900130531     C                   LEAVESR
021000130531     C                   ENDIF
021100130531    ***
021200130531    *** CAN THE ACCOUNT BE EXPORTED?
021300130531    ***
021400130531     C                   IF        CASTATUS = 'N'
021500130531     C                   LEAVESR
021600130531     C                   ENDIF
021700130531    ***
021800130531     C                   EVAL      @STEP = 'PREP1'
021900130531    ***
022000130531     C                   ENDSR
022100130531   S***S
022200130531     C     $PREP1        BEGSR
022300130531    ***
022400130531     C                   EVAL      KF@TRS = CATRST
022500130531     C                   EVAL      KF@SUB = CASUB#
022600130531     C                   EVAL      KF@ACC = CAACCT
022700130531    ***
022800130531     C                   EVAL      #RECCNT = 0
022900130531    ***
023000130531     C                   EVAL      @STEP = 'STEP1'
023100130531    ***
023200130531     C                   ENDSR
023300130531   S***S
023400130531     C     $STEP1        BEGSR
023500130531    ***
023600130531     C                   EVAL      KF@PLN = *BLANKS
023700130531     C                   EVAL      KF@TRM = 0
023800130531     C                   EVAL      KF@SSN = 0
023900130531     C                   EVAL      KF@SEQ = 0
024000130531    ***
024100130531     C     KL#TSA        SETLL     MEMBR
024200130531    ***
024300130531     C                   EVAL      @STEP = 'STEP2'
024400130531    ***
024500130531     C                   ENDSR
024600130531   S***S
024700130531     C     $STEP2        BEGSR
024800130531    ***
024900130531     C     KL#TSA        READE     MEMBR
025000130531    ***
025100130531     C                   IF        %EOF(MEMAC#1)
025200130531     C                   EVAL      @STEP = 'STEP0'
025300130531     C                   LEAVESR
025400130531     C                   ENDIF
025500130531    ***
025600130531     C                   EVAL      KF@SSN = MBSSNO
025700130531     C                   MOVE      *ZEROS        KF@SEQ
025800130812     C                   EVAL      KF@MEM = MBSSNO
025900130812     C                   EVAL      KF@ALID = %EDITC(MBSSNO:'X')
026000130812     C                   MOVE      MBSSNO        @@SUB
026100130812     C                   MOVE      MBSSNO        @@MBR
026200130812    ***
026300130812    ***
026400130812    ***  MBSSNO CHAIN ALT ID
026500130812    ***
026600130812    ***1  NOT FOUND                              MEMBER REC SSN NOT ON ALT ID SIDE
026700130812    ***     MBSSNO CHAIN ALT SSN                   MEMBER REC SSN NOT ON ALT SSN SIDE
026800130812    ***2      NOT FOUND THEN GOOD                        SO THIS IS A NORMAL MEMBER
026900130812    ***       IF FOUND                             MEMBER REC SSN IS ON ALT SSN SIDE
027000130812    ***         SET SUBID TO ALT ID VALUE                USE ALT ID FOR SUBSCRIBER INSTEAD
027100130812    ***2      E-I
027200130812    ***1 LSE
027300130812    *** 1(IF FOUND)                     MEMBER REC SSN = ALT ID
027400130812    ***2   IS MBR TERMED?                 IF TERMED, NEW SSN ASSIGNED, SO SKIP
027500130812    ***      YES THEN SKIP IT
027600130812    ***      NO                           STILL ACTIVE
027700130812    ***3       IS ALT ID = ALT SSN          IF ALT ID AND ALT SSN ARE SAME, THEN WE HAVE NOT
027800130812    ***           YES THEN CONTINUE                   RECEIVED SSN UPDATE YET
027900130812    ***           NO  SKIP IT               IF NOT EQUAL, THEN SOMEONE FORGOT TO SHUT IT DOWN
028000130812    ***3       E-I                                    WE MUST SKIP THE RECORD
028100130812    ***2   E-I
028200130812    ***1 E-I
028300130812    ***
028400130812     C     KL#NAS        CHAIN     NASCF
028500130812     C                   IF        NOT %FOUND(MEMALTL4)
028600130812      * NOT FOUND
028700130812      *
028800130812     C     KL#SSA        CHAIN     MBRF
028900130812     C                   IF        %FOUND(MEMALTL5)
029000130812     C                   EVAL      @@SUB = %SUBST(SSALTID:1:9)
029100130812     C                   ENDIF
029200130812      *
029300130812     C                   ELSE
029400130812      *
029500130812      * FOUND
029600130812     C                   IF        CANDT > 0                                     ALT ID MEM REC TRM
029700130812     C                   LEAVESR                                                     SKIP
029800130812     C                   ENDIF
029900130812     C                   MOVE      NFMEMID       @9                9
030000130812     C                   IF        @9 <> NFALTID
030100130812     C                   LEAVESR                                                     SKIP
030200130812     C                   ENDIF
030300130812      *
030400130812     C                   ENDIF
030500130812    ***
030600130812    ***
030700130531    ***
030800130531     C                   IF        TERMDT > 0
030900130531     C                   EVAL      MBR_TERM = YES
031000130531     C                   ELSE
031100130531     C                   EVAL      MBR_TERM = NO
031200130531     C                   ENDIF
031300130531    ***
031400130531     C     KL#MPLN       SETLL     MCOVR
031500130531    ***
031600130531     C                   EXSR      $CLRSTG
031700130531    ***
031800130531     C                   EVAL      @STEP = 'STEP3'
031900130531    ***
032000130531     C                   ENDSR
032100130531   S***S
032200130531     C     $STEP3        BEGSR
032300130531    ***
032400130531     C     KL#MPLN       READE     MCOVR
032500130531    ***
032600130531     C                   IF        %EOF(MCOVMPLN)
032700130531     C                   EVAL      @STEP = 'PREP4'
032800130531     C                   LEAVESR
032900130531     C                   ENDIF
033000130531    ***
033100130531    *** PUT PLANS HERE ***
033200130531    ***
033300170613     C                   IF        MCPLAN <> 'DAD5' AND MCPLAN <> 'DAD3'
033400170613     C****               IF        MCPLAN <> 'S000' AND MCPLAN <> 'S001'
033500130531     C                   LEAVESR
033600130531     C                   ENDIF
033700130531    ***
033800170613     C****               IF        MCPLAN = 'S000' or MCPLAN = 'S001'
033900170613     C                   IF        MCPLAN = 'DAD5' or MCPLAN = 'DAD3'
034000160322
034100130531     C                   EVAL      @PLANIN = MCPLAN
034200150617     C                   EVAL      #EFFDTE = ENRLDT
034300170613JOHN C                   if        #EFFDTE < 20170701
034400170613 ¦   C                   EVAL      #EFFDTE = 20170701
034500150617JOHN C                   endif
034600160322
034700160322JOHN C                   endif
034800160322
034900130531     C                   EVAL      #CANCEL = CANDT
035000130531     C                   EVAL      @ENRIN = MCOVTP
035100130531     **
035200130531     C                   IF        #CANCEL = 0
035300130531     C                   EVAL      #CANCEL = 99999999
035400130531     C                   ENDIF
035500130531    ***
035600130531    ***
035700130531    *** 2014 ENROLLMENT CODE - COMMENT OUT WHEN OPEN ENROLLMENT IS DONE
035800130603    *C*                  IF        #CANCEL >= 20130731 AND #CANCEL < 99999999
035900130531     C*                  EVAL      #CANCEL = 99999999
036000130531    *C*                  ENDIF
036100130531    *X*
036200130603    *C*                  IF        ENRLDT > 20140800
036300130531    *C*                  LEAVESR
036400130531    2C*                  ENDIF
036500130531    *** 2014 ENROLLMENT CODE
036600130531    ***
036700130531    ***
036800130531     C                   EXSR      $QUIK
036900130531     **
037000130531     C                   IF        PLN@CAT = *BLANKS
037100130531     C                   LEAVESR
037200130531     C                   ENDIF
037300130531    ***
037400130531     C                   EXSR      $AD2MARY
037500130531    ***
037600130531     C                   ENDSR
037700130531   S***S
037800130531     C     $QUIK         BEGSR
037900130531    ***
038000130531     C                   EVAL      @ENROU = @ENRIN
038100130531     C                   EVAL      @CCTRIN = *BLANKS
038200130603     C                   EVAL      PLN@CAT = *BLANKS
038300130603    ***
038400130603     C                   SELECT
038500160323
038600160705     C****               WHEN      @PLANIN = 'BADB' OR @PLANIN = 'BADC' OR
038700150616     C****                         @PLANIN = 'BADG' OR @PLANIN = 'BADH' OR
038800160705JOHN C****                         @PLANIN = 'DABN' OR @PLANIN = 'DABP'
038900160705    *C****               EVAL      PLN@CAT = 'MED'
039000160323
039100170613     C                   WHEN      @PLANIN = 'DAD5' OR @PLANIN = 'DAD3'
039200170613     C****               WHEN      @PLANIN = 'S000' OR @PLANIN = 'S001'
039300130603    *C                   EVAL      PLN@CAT = 'DEN'
039400160323
039500130603     C                   ENDSL
039600130531    ***
039700130531     C                   ENDSR
039800130531   S***S
039900130531     C     $AD2MARY      BEGSR
040000130531    ***
040100160705    *C****               IF        PLN@CAT = 'MED'
040200160705     C****               EXSR      $LOADMED
040300160705     C****               IF        MED#CNE > 0
040400160705     C****               IF        MED@TRM(MED#CNE) = 99999999
040500160705     C****               LEAVESR
040600160705     C****               ENDIF
040700160705     C****               ENDIF
040800160705    *C****               ADD       1             MED#CNE
040900160705    *C****               EVAL      MED@PLN(MED#CNE) = @PLANIN
041000160705    *C****               EVAL      MED@ENR(MED#CNE) = @ENROU
041100160705JOHN C****               if        #EFFDTE < 20160701
041200160705 ¦   C****               eval      #EFFDTE = 20160701
041300160705JOHN C****               endif
041400160705    *C****               EVAL      MED@FRM(MED#CNE) = #EFFDTE
041500160705    *C****               EVAL      MED@TRM(MED#CNE) = #CANCEL
041600160705     C****               LEAVESR
041700160705    *C****               ENDIF
041800130531    ***
041900130531    *C                   IF        PLN@CAT = 'DEN'
042000130531     C                   IF        DEN#CNE > 0
042100130531     C                   IF        DEN@TRM(DEN#CNE) = 99999999
042200130531     C                   LEAVESR
042300130531     C                   ENDIF
042400130531     C                   ENDIF
042500130531    *C                   ADD       1             DEN#CNE
042600130531    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
042700130531    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
042800160323
042900170613     C                   IF        @planin = 'DAD5' or @planin = 'DAD3'
043000170613     C****               IF        @planin = 'S000' or @planin = 'S001'
043100170613JOHN C                   if        #EFFDTE < 20170701
043200170613 ¦   C                   eval      #EFFDTE = 20170701
043300160323JOHN C                   endif
043400160323JOHN C                   endif
043500160323
043600130531    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
043700130531    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
043800130531     C                   LEAVESR
043900130531    *C                   ENDIF
044000130531    ***
044100130531     C                   ENDSR
044200130531   S***S
044300130531     C     $LOADMED      BEGSR
044400130531    ***
044500130531     C                   IF        MED#CNE = 0
044600130531     C                   EXSR      $AE_MED
044700130531     C                   LEAVESR
044800130531     C                   ENDIF
044900130531    ***
045000130531     C                   IF        MED@TRM(MED#CNE) = 99999999
045100130531     C                   LEAVESR
045200130531     C                   ENDIF
045300130531    ***
045400130607     C                   EVAL      MED#NDX = 0
045500130531    ***
045600130607     C                   DOU       MED#NDX = MED#CNE
045700130607     C                   IF        @PLANIN = MED@PLN(MED#NDX) AND
045800130607     C                             MED@ENR(MED#NDX) = @ENROU
045900130531      *
046000130607     C                   EVAL      #8D0 = MED@TRM(MED#NDX)
046100130531     C                   MOVE      #8D0          #ISO
046200130531     C                   ADDDUR    1:*D          #ISO
046300130531     C                   MOVE      #ISO          #8D1
046400130531      *
046500130531     C                   IF        #EFFDTE = #8D0 OR #EFFDTE = #8D1
046600130607     C                   IF        #CANCEL > MED@TRM(MED#NDX)
046700130607    *C                   EVAL      MED@TRM(MED#NDX) = #CANCEL
046800130603     C                   ENDIF
046900130531     C                   LEAVESR
047000130531     C                   ENDIF
047100130531      *
047200130531     C                   ENDIF
047300130531     C                   ENDDO
047400130531    ***
047500130531     C                   EXSR      $AE_MED
047600130531    ***
047700130531     C                   ENDSR
047800130531   S***S
047900130604    *** ADD ENTRY FOR MEDICAL
048000130604    ***
048100130531     C     $AE_MED       BEGSR
048200130531    ***
048300130531    *C                   ADD       1             MED#CNE
048400130531    *C                   EVAL      MED@PLN(MED#CNE) = @PLANIN
048500130531    *C                   EVAL      MED@ENR(MED#CNE) = @ENROU
048600170613JOHN C                   if        #EFFDTE < 20170701
048700170613 ¦   C                   eval      #EFFDTE = 20170701
048800150617JOHN C                   endif
048900130531    *C                   EVAL      MED@FRM(MED#CNE) = #EFFDTE
049000130531    *C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
049100130531    ***
049200130531     C                   ENDSR
049300130531   S***S
049400130603     C     $LOADDEN      BEGSR
049500130603    ***
049600130603     C                   IF        DEN#CNE = 0
049700130603     C                   EXSR      $AE_DEN
049800130603     C                   LEAVESR
049900130603     C                   ENDIF
050000130603    ***
050100130603     C                   IF        DEN@TRM(DEN#CNE) = 99999999
050200130603     C                   LEAVESR
050300130603     C                   ENDIF
050400130603    ***
050500130607     C                   EVAL      DEN#NDX = 0
050600130603    ***
050700130607     C                   DOU       DEN#NDX = DEN#CNE
050800130607     C                   IF        @PLANIN = DEN@PLN(DEN#NDX) AND
050900130607     C                             DEN@ENR(DEN#NDX) = @ENROU
051000130603      *
051100130607     C                   EVAL      #8D0 = DEN@TRM(DEN#NDX)
051200130603     C                   MOVE      #8D0          #ISO
051300130603     C                   ADDDUR    1:*D          #ISO
051400130603     C                   MOVE      #ISO          #8D1
051500130603      *
051600130603     C                   IF        #EFFDTE = #8D0 OR #EFFDTE = #8D1
051700130607     C                   IF        #CANCEL > DEN@TRM(DEN#NDX)
051800130607    *C                   EVAL      DEN@TRM(DEN#NDX) = #CANCEL
051900130603     C                   ENDIF
052000130603     C                   LEAVESR
052100130603     C                   ENDIF
052200130603      *
052300130603     C                   ENDIF
052400130603     C                   ENDDO
052500130603    ***
052600130603     C                   EXSR      $AE_DEN
052700130603    ***
052800130603     C                   ENDSR
052900130603   S***S
053000130604    *** ADD ENTRY FOR DENTAL
053100130604    ***
053200130603     C     $AE_DEN       BEGSR
053300130603    ***
053400130603    *C                   ADD       1             DEN#CNE
053500130603    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
053600130603    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
053700160323
053800170613     C                   IF        @planin = 'DAD5' or @planin = 'DAD3'
053900170613     C****               IF        @planin = 'S000' or @planin = 'S001'
054000170613JOHN C                   if        #EFFDTE < 20170701
054100170613 ¦   C                   eval      #EFFDTE = 20170701
054200150617JOHN C                   endif
054300160323JOHN C                   endif
054400160323
054500130603    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
054600130603    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
054700130603    ***
054800130603     C                   ENDSR
054900130603   S***S
055000130531     C     $PREP4        BEGSR
055100130531    ***
055200130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
055300130531     C                   EVAL      @STEP = 'STEP2'
055400130531     C                   LEAVESR
055500130531     C                   ENDIF
055600130531    ***
055700130531     C                   EVAL      TERM_MED = NO
055800130531     C                   EVAL      TERM_DEN = NO
055900130531    ***
056000130531     C                   EXSR      $CHKHEM
056100130531    ***
056200130531     C                   EVAL      @STEP = 'STEP4'
056300130531    ***
056400130531     C                   ENDSR
056500130531   S***S
056600130531    *** GENERATE MEMBER RECORD
056700130531    ***
056800130531     C     $STEP4        BEGSR
056900130531    ***
057000130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
057100130531     C                   EVAL      @STEP = 'STEP2'
057200130531     C                   LEAVESR
057300130531     C                   ENDIF
057400130531    ***
057500130531     C                   EVAL      WRT@TYPE = 'MEMBER'
057600130531    ***
057700130531     C                   EVAL      MED@MEFF = 0
057800130531     C                   EVAL      DEN@MEFF = 0
057900130531    ***
058000130531     C                   EXSR      $FILLMBR
058100130531    ***
058200130531     C                   EXSR      $FILLCOVG
058300130531    ***
058400130603     C                   WRITE     NASF0001
058500130531     C                   ADD       1             #RECCNT
058600130531    ***
058700130531     C                   EVAL      @STEP = 'PREP5'
058800130531    ***
058900130531     C                   ENDSR
059000130531   S***S
059100130531     C     $MEDICARE     BEGSR
059200130531    ***
059300130531     C                   SELECT
059400130531     C                   WHEN      ADT > 0 AND BDT > 0
059500130531     C                   EVAL      N1MEI = '3'
059600130531     C                   WHEN      ADT > 0 AND BDT = 0
059700130531     C                   EVAL      N1MEI = '1'
059800130531     C                   WHEN      ADT = 0 AND BDT > 0
059900130531     C                   EVAL      N1MEI = '2'
060000130531     C                   OTHER
060100130531     C                   EVAL      N1MEI = '9'
060200130531     C                   ENDSL
060300130531    ***
060400130531     C                   EVAL      N1MAED = ADT
060500130531     C                   EVAL      N1MBED = BDT
060600130531    ***
060700130531     C                   ENDSR
060800130531   S***S
060900130531     C     $FILLMBR      BEGSR
061000130531    ***
061100130531     C                   CLEAR                   NASF0001
061200130531    ***
061300130531     C                   EVAL      N1TC = 'PF'
061400130531    ***
061500130812     C                   MOVE      @@SUB         N1SSN
061600130531     C                   MOVEL     MLNAME        N1LN
061700130531     C                   MOVEL     MFNAME        N1FN
061800130531     C                   MOVE      MMI           N1MI
061900130531    ***
062000130531     C                   MOVE      BIRTH         #XSX
062100130531     C                   EXSR      $ISOUSA
062200130531     C                   MOVE      #XSX          N1DOB
062300130531    ***
062400130531     C                   MOVE      SEX           N1GEN
062500130531     C                   EVAL      N1RC = '1'
062600130531    ***
062700130603     C                   MOVE      EMPDT         #XSX
062800130603     C                   EXSR      $ISOUSA
062900130603     C                   MOVE      #XSX          N1HIRE
063000130603    ***
063100130603     C                   IF        EMPST = 'C'
063200130603     C                   EVAL      N1SI = 'C'
063300130603     C                   ELSE
063400130603     C                   EVAL      N1SI = 'A'
063500130603     C                   ENDIF
063600130603    ***
063700130531     C                   MOVEL     ADDR1         N1A1
063800130531     C                   MOVEL     ADDR2         N1A2
063900130531     C                   MOVEL     CITY          N1CTY
064000130531     C                   MOVEL     STATE         N1ST
064100130531     C                   EVAL      @9 = %EDITC(ZIP:'X')
064200130531     C                   EVAL      N1ZP = %SUBST(@9:1:5)
064300130531    ***
064400130531     C                   EVAL      N1AREA = %EDITC(AREA:'X')
064500130531     C                   EVAL      N1PHON = %EDITC(PHONE:'X')
064600130812     C                   MOVE      @@MBR         N1SS2
064700130531    ***
064800130531     C                   IF        MED# <> *BLANKS AND (MEDADT > 0 OR
064900130531     C                             MEDBDT > 0)
065000130531     C                   MOVEL     MED#          N1HIC#
065100130531     C                   EVAL      ADT = MEDADT
065200130531     C                   EVAL      BDT = MEDBDT
065300130531     C                   EXSR      $MEDICARE
065400130531     C                   ELSE
065500130531     C                   EVAL      N1MEI = '9'
065600130531     C                   ENDIF
065700130531    ***
065800130531     C                   IF        COB <> 'Y'
065900130531     C                   EVAL      N1COBI = 'N'
066000130531     C                   ELSE
066100130531     C                   EVAL      N1COBI = 'Y'
066200130531     C                   ENDIF
066300130531    ***
066400140812     C                   IF        HNDICP = '3'
066500130531     C                   EVAL      N1DI = 'Y'
066600130531     C                   ELSE
066700130531     C                   EVAL      N1DI = 'N'
066800130531     C                   ENDIF
066900130531    ***
067000130531     C                   EVAL      N1STDI = *BLANKS
067100130531    ***
067200130531     C                   ENDSR
067300130531   S***S
067400130603     C     $FILLCOVG     BEGSR
067500130603    ***
067600130603     C                   IF        MED#CNE > 0
067700130604     C                   EXSR      $FILLMED
067800130603     C                   ENDIF
067900130603    ***
068000130603     C                   IF        DEN#CNE > 0
068100130604     C                   EXSR      $FILLDEN
068200130603     C                   ENDIF
068300130603    ***
068400130604     C                   ENDSR
068500130604   S***S
068600130604     C     $FILLMED      BEGSR
068700130604    ***
068800130604      * MEDICAL
068900130604    ***
069000130604     C                   EVAL      @PLANIN = MED@PLN(MED#CNE)
069100130604     C                   EVAL      @ENROU = MED@ENR(MED#CNE)
069200130604      *
069300130604     C                   SELECT
069400150616JOHN C                   WHEN      @PLANIN = 'DABP'
069500150616 ¦   C                   EVAL      N1MGN = '5801056DC40'
069600150617 ¦   C                   EVAL      N1MSN = '006'
069700150617 ¦   C****               EVAL      N1MSN = '026'
069800150616 ¦   C                   EVAL      N1MBC = '00002K3UZ'
069900150616 ¦   C                   WHEN      @PLANIN = 'DABN'
070000150616 ¦   C                   EVAL      N1MGN = '5801055DC10'
070100150616 ¦   C                   EVAL      N1MSN = '006'
070200150616JOHN C                   EVAL      N1MBC = '00001K3UY'
070300130604     C                   WHEN      @PLANIN = 'BADB'
070400130604     C                   EVAL      N1MGN = '5801053DC10'
070500130604     C                   EVAL      N1MSN = '240'
070600130604     C                   EVAL      N1MBC = '00001K3UW'
070700130604     C                   WHEN      @PLANIN = 'BADC'
070800130604     C                   EVAL      N1MGN = '5801054DC40'
070900150618     C                   EVAL      N1MSN = '240'
071000130604     C                   EVAL      N1MBC = '00002K3UX'
071100150616     C****               WHEN      @PLANIN = 'BADG'
071200150616     C****               EVAL      N1MGN = '5801055DC10'
071300150616     C****               EVAL      N1MSN = '006'
071400150616     C****               EVAL      N1MBC = '00001K3UY'
071500150616     C****               WHEN      @PLANIN = 'BADH'
071600150616     C****               EVAL      N1MGN = '5801056DC40'
071700150616     C****               EVAL      N1MSN = '026'
071800150616     C****               EVAL      N1MBC = '00002K3UZ'
071900130604     C                   ENDSL
072000130604      *
072100130604     C                   SELECT
072200130604     C*
072300130607     C                   WHEN      @ENROU = 'TIN'
072400130604     C                   EVAL      N1MCL = '01'
072500130604     C*
072600130607     C                   WHEN      @ENROU = 'THW'
072700130604     C                   EVAL      N1MCL = '02'
072800130604     C*
072900130607     C                   WHEN      @ENROU = 'TPC'
073000130604     C                   EVAL      N1MCL = '03'
073100130604     C*
073200130607     C                   WHEN      @ENROU = 'TP2'
073300130604     C                   EVAL      N1MCL = '04'
073400130604     C*
073500130607     C                   WHEN      @ENROU = 'TFA'
073600130604     C                   EVAL      N1MCL = '04'
073700130604     C*
073800130604     C                   ENDSL
073900130604      *
074000130604     C                   EVAL      #XSX = MED@FRM(MED#CNE)
074100130604     C                   EXSR      $ISOUSA
074200130612     C                   EVAL      N1MCD = %EDITC(#XSX:'X')
074300130604      *
074400130604     C                   EVAL      #XSX = MED@TRM(MED#CNE)
074500130607     C                   IF        #XSX = 99999999
074600130607     C                   EVAL      #XSX = 0
074700130607     C                   ENDIF
074800130607      *
074900130604     C                   IF        #XSX > 0
075000130604     C                   EVAL      N1MTC = '04'
075100130604     C                   EXSR      $ISOUSA
075200130612     C                   EVAL      N1MTD = %EDITC(#XSX:'X')
075300130604     C                   ENDIF
075400130604      *
075500150617      * Control Plan Code...
075600150617     C                   EVAL      N1CPC = '580'
075700150617
075800130607     C                   EVAL      N1MPID = '00'
075900130604      *
076000150617      * Home Plan Code...
076100150617     C                   EVAL      N1HPC = '580'
076200130604     C                   EVAL      @9 = %EDITC(ZIP:'X')
076300130604      *
076400150617     C                   IF        (%SUBST(@9:1:3) >= '210' AND
076500150617     C                             %SUBST(@9:1:3) <= '219')
076600150617     C                   EVAL      N1HPC = '690'
076700150617     C                   ENDIF
076800150617
076900130604     C                   EXSR      $PCP
077000130604     C                   EVAL      N1PCP = @PCP
077100130604     C                   EVAL      N1PED = @PED
077200130604     C                   EVAL      N1XPI = @XPI
077300130603    ***
077400130603     C                   ENDSR
077500130603   S***S
077600130603     C     $PCP          BEGSR
077700130603    ***
077800130603     C                   EVAL      @PCP = *BLANKS
077900130607     C                   EVAL      #PED = *ZEROS
078000130603     C                   EVAL      @PED = *BLANKS
078100130603     C                   EVAL      @XPI = *BLANKS
078200130603     C                   EVAL      KF@SPCD = 'MED'
078300130603    ***
078400130603     C     KL#PCP        CHAIN     PCPR
078500130603     C                   IF        NOT %FOUND(PCPL1)
078600130603     C                   LEAVESR
078700130603     C                   ENDIF
078800130603    ***
078900130603     C     KL#PCP        SETLL     PCPR
079000130603     C                   DOU       %EOF(PCPL1)
079100130603     C     KL#PCP        READE     PCPR
079200130603     C                   IF        NOT %EOF(PCPL1) AND
079300130603     C                             PCCAN = 0
079400130603      *
079500130603     C                   EVAL      @PCP = PCID#
079600130604     C                   EVAL      #XSX = PCEFF
079700130604     C                   EXSR      $ISOUSA
079800130607     C                   EVAL      #PED = #XSX
079900130607     C                   MOVE      #PED          @PED
080000130603     C                   IF        PCCUR = 'Y'
080100130603     C                   EVAL      @XPI = 'Y'
080200130603     C                   ELSE
080300130603     C                   EVAL      @XPI = 'N'
080400130603     C                   ENDIF
080500130603      *
080600130603     C                   ENDIF
080700130603     C                   ENDDO
080800130603    ***
080900130603     C                   ENDSR
081000130603   S***S
081100130604     C     $FILLDEN      BEGSR
081200130604    ***
081300130604      * DENTAL
081400130604    ***
081500130604     C                   EVAL      N1DPID = '08'
081600130604      *
081700130604     C                   EVAL      @PLANIN = DEN@PLN(DEN#CNE)
081800130604     C                   EVAL      @ENROU = DEN@ENR(DEN#CNE)
081900130604      *
082000160628     C                   select
082100170613     C                   WHEN      @PLANIN = 'DAD5'
082200170613     C****               WHEN      @PLANIN = 'S000'
082300160628     C                   EVAL      N1DGN = '1R8X'
082400170621     C                   EVAL      N1DSGN = '0001'
082500160628
082600170613     C                   WHEN      @PLANIN = 'DAD3'
082700170613     C****               WHEN      @PLANIN = 'S001'
082800160628     C                   EVAL      N1DGN = '1R8X'
082900170621     C                   EVAL      N1DSGN = '0001'
083000160628     c                   endsl
083100160628
083200160323     C     kl#tsp        chain     fclass
083300160323     C                   if        %found
083400160323     C                   eval      n1dpcc = clclass
083500160323     c                   endif
083600160323
083700130604     C                   SELECT
083800130604     C*
083900130607     C                   WHEN      @ENROU = 'TIN'
084000130604     C                   EVAL      N1DCL = '01'
084100130604     C*
084200130607     C                   WHEN      @ENROU = 'THW'
084300130604     C                   EVAL      N1DCL = '02'
084400130604     C*
084500130607     C                   WHEN      @ENROU = 'TPC'
084600130604     C                   EVAL      N1DCL = '03'
084700130604     C*
084800130607     C                   WHEN      @ENROU = 'TP2'
084900130604     C                   EVAL      N1DCL = '04'
085000130604     C*
085100130607     C                   WHEN      @ENROU = 'TFA'
085200130604     C                   EVAL      N1DCL = '04'
085300130604     C*
085400130604     C                   ENDSL
085500130604      *
085600150618JOHN C****               if        DEN@FRM(DEN#CNE) < 20150701
085700150618 ¦   C****               eval      den@frm(den#cne) = 20150701
085800150618JOHN C****               endif
085900130604     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
086000130604     C                   EXSR      $ISOUSA
086100130607     C                   MOVE      #XSX          N1DCD
086200130604      *
086300130604     C                   EVAL      #XSX = DEN@TRM(DEN#CNE)
086400130607     C                   IF        #XSX = 99999999
086500130607     C                   EVAL      #XSX = 0
086600130607     C                   ENDIF
086700130607      *
086800130604     C                   IF        #XSX > 0
086900130604     C                   EVAL      N1DTC = '04'
087000160720     C****               EXSR      $ISOUSA
087100160720     C****               EVAL      N1DTD = %EDITC(#XSX:'X')
087200160720
087300160720       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
087400160720       if %subdt(work_date:*d) = 01 ;
087500160720        work_date -= %days(1) ;
087600160720        num_date = %dec(work_date:*usa);
087700160720        n1dtd = %EDITC(num_date:'X');
087800160720       endif;
087900160720
088000130604     C                   ENDIF
088100130604    ***
088200130604     C                   ENDSR
088300130604   S***S
088400130604     C     $PREP5        BEGSR
088500130604    ***
088600130604     C     KF@SSN        CHAIN     DEPENR
088700130604     C                   IF        NOT %FOUND(DEPNDC)
088800130604     C                   EVAL      @STEP = 'STEP2'
088900130604     C                   LEAVESR
089000130604     C                   ENDIF
089100130604    ***
089200130604     C     KF@SSN        SETLL     DEPENR
089300130604    ***
089400130604     C                   EVAL      @STEP = 'STEP5'
089500130604    ***
089600130604     C                   ENDSR
089700130604   S***S
089800130604     C     $STEP5        BEGSR
089900130604    ***
090000130604     C     KF@SSN        READE     DEPENR
090100130604    ***
090200130604     C                   IF        %EOF(DEPNDC)
090300130604     C                   EVAL      @STEP = 'STEP2'
090400130604     C                   LEAVESR
090500130604     C                   ENDIF
090600130604    ***
090700130604     C                   EVAL      KF@SEQ = DPSEQ#
090800130604    ***
090900130604     C     KL#DCV        CHAIN     DCOVR
091000130604     C                   IF        NOT %FOUND(ELIGDCOVL1)
091100130604     C                   LEAVESR
091200130604     C                   ENDIF
091300130604    ***
091400130604     C                   EXSR      $CLRSTG
091500130604    ***
091600130604     C     KL#DCV        SETLL     DCOVR
091700130604    ***
091800130604     C                   EVAL      @STEP = 'STEP6'
091900130604    ***
092000130604     C                   ENDSR
092100130604   S***S
092200130604     C     $STEP6        BEGSR
092300130604    ***
092400130604     C     KL#DCV        READE     DCOVR
092500130604    ***
092600130604     C                   IF        %EOF(ELIGDCOVL1)
092700130604     C                   EVAL      @STEP = 'PREP7'
092800130604     C                   LEAVESR
092900130604     C                   ENDIF
093000130604    ***
093100130604    *** PUT PLANS HERE ***
093200130604    ***
093300170613     C                   IF        DVPLAN <> 'DAD5' AND DVPLAN <> 'DAD3'
093400170613     C****               IF        DVPLAN <> 'S000' AND DVPLAN <> 'S001'
093500130604     C                   LEAVESR
093600130604     C                   ENDIF
093700130604    ***
093800130604     C                   EVAL      @PLANIN = DVPLAN
093900130604     C                   EVAL      @ENRIN = DVENRL
094000130604     C                   EVAL      #EFFDTE = DENRDT
094100130604     C                   EVAL      #CANCEL = CCANDT
094200130604    ***
094300130604     C                   IF        #CANCEL = 0
094400130604     C                   EVAL      #CANCEL = 99999999
094500130604     C                   ENDIF
094600130604    ***
094700130604    *** 2014 ENROLLMENT CODE - COMMENT OUT WHEN OPEN ENROLLMENT IS DONE
094800130604    *C*                  IF        #CANCEL >= 20130731 AND #CANCEL < 99999999
094900130604     C*                  EVAL      #CANCEL = 99999999
095000130604    *C*                  ENDIF
095100130604    *X*
095200130604    *C*                  IF        DENRDT > 20140800
095300130604    *C*                  LEAVESR
095400130604    2C*                  ENDIF
095500130604    *** 2014 ENROLLMENT CODE
095600130604    ***
095700130604    ***
095800130604    ***
095900130604     C                   EXSR      $QUIK
096000130604    ***
096100130604     C                   IF        PLN@CAT = *BLANKS
096200130604     C                   LEAVESR
096300130604     C                   ENDIF
096400130604    ***
096500130604     C                   EXSR      $AD2MARY
096600130604    ***
096700130604     C                   ENDSR
096800130604   S***S
096900130604     C     $PREP7        BEGSR
097000130604    ***
097100130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
097200130604     C                   EVAL      @STEP = 'STEP5'
097300130604     C                   LEAVESR
097400130604     C                   ENDIF
097500130604    ***
097600130604     C                   EVAL      TERM_MED = NO
097700130604     C                   EVAL      TERM_DEN = NO
097800130604    ***
097900130604     C                   EXSR      $CHKHEM
098000130604    ***
098100130604     C                   EVAL      @STEP = 'STEP7'
098200130604    ***
098300130604     C                   ENDSR
098400130604   S***S
098500130604     C     $STEP7        BEGSR
098600130604    ***
098700130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
098800130604     C                   EVAL      @STEP = 'STEP5'
098900130604     C                   LEAVESR
099000130604     C                   ENDIF
099100130604    ***
099200130604     C                   EVAL      WRT@TYPE = 'DEPEND'
099300130604    ***
099400130604     C                   EVAL      MED@MEFF = 0
099500130604     C                   EVAL      DEN@MEFF = 0
099600130604    ***
099700130604     C                   EXSR      $FILLDEP
099800130604    ***
099900130604     C                   EXSR      $FILLCOVG
100000130604    ***
100100160628     C     kl#tsp        chain     fclass
100200160628     C                   if        %found
100300160628     C                   eval      n1dpcc = clclass
100400160628     c                   endif
100500160628
100600130604     C                   WRITE     NASF0001
100700130604     C                   ADD       1             #RECCNT
100800130604    ***
100900130604     C                   EVAL      @STEP = 'STEP5'
101000130604    ***
101100130604     C                   ENDSR
101200130604   S***S
101300130604     C     $FILLDEP      BEGSR
101400130604    ***
101500130604     C                   CLEAR                   NASF0001
101600130604    ***
101700130604     C                   EVAL      N1TC = 'PF'
101800130604    ***
101900130812     C                   MOVE      @@SUB         N1SSN
102000130604     C                   MOVEL     DLNAME        N1LN
102100130604     C                   MOVEL     DFNAME        N1FN
102200130604     C                   MOVE      DMI           N1MI
102300130604    ***
102400130604     C                   MOVE      DBIRTH        #XSX
102500130604     C                   EXSR      $ISOUSA
102600130604     C                   MOVE      #XSX          N1DOB
102700130604    ***
102800130604     C                   MOVE      DSEX          N1GEN
102900130604    ***
103000130604    2C                   SELECT
103100130604    2C                   WHEN      DRELCD = 'RWI' OR DRELCD = 'RHU'
103200130604     C                   MOVE      '2'           N1RC
103300130604    2C                   WHEN      DRELCD = 'RDA' OR DRELCD = 'RSO'
103400130604     C                   MOVE      '3'           N1RC
103500130604    2C                   WHEN      DRELCD = 'RPA' OR DRELCD = 'RDP'
103600130604     C                   MOVE      '4'           N1RC
103700130604    2C                   OTHER
103800130604     C                   MOVE      '9'           N1RC
103900130604    2C                   ENDSL
104000130604    ***
104100130604    2C                   IF        DADDR1 = 'SAME'
104200130604     C                   MOVEL     ADDR1         N1A1
104300130604     C                   MOVEL     ADDR2         N1A2
104400130604     C                   MOVEL     CITY          N1CTY
104500130604     C                   MOVEL     STATE         N1ST
104600130604     C                   EVAL      @9 = %EDITC(ZIP:'X')
104700130604     C                   EVAL      N1ZP = %SUBST(@9:1:5)
104800130604     C                   EVAL      N1AREA = %EDITC(AREA:'X')
104900130604     C                   EVAL      N1PHON = %EDITC(PHONE:'X')
105000130604    2C                   ELSE
105100130604     C                   MOVEL     DADDR1        N1A1
105200130604     C                   MOVEL     DADDR2        N1A2
105300130604     C                   MOVEL     DCITY         N1CTY
105400130604     C                   MOVEL     DSTATE        N1ST
105500130604     C                   EVAL      @9 = %EDITC(DZIP:'X')
105600130604     C                   EVAL      N1ZP = %SUBST(@9:1:5)
105700130604     C                   EVAL      N1AREA = %EDITC(DAREA:'X')
105800130604     C                   EVAL      N1PHON = %EDITC(DPHONE:'X')
105900130604    2C                   ENDIF
106000130604    ***
106100140815     C                   IF        DEPSS# = 0
106200140815     C                   EVAL      N1SS2 = *BLANKS
106300140815     C                   ELSE
106400140815     C                   EVAL      N1SS2 = %EDITC(DEPSS#:'X')
106500140815     C                   ENDIF
106600140815    ***
106700130604     C                   IF        DMED# <> *BLANKS AND (DMEDAD > 0 OR
106800130604     C                             DMEDBD > 0)
106900130604     C                   MOVEL     DMED#         N1HIC#
107000130604     C                   EVAL      ADT = DMEDAD
107100130604     C                   EVAL      BDT = DMEDBD
107200130604     C                   EXSR      $MEDICARE
107300130604     C                   ELSE
107400130604     C                   EVAL      N1MEI = '9'
107500130604     C                   ENDIF
107600130604    ***
107700130604     C                   IF        DCOB = 'Y'
107800130604     C                   EVAL      N1COBI = 'Y'
107900130604     C                   ELSE
108000130604     C                   EVAL      N1COBI = 'N'
108100130604     C                   ENDIF
108200130604    ***
108300140812     C                   IF        DHNDCP = '3'
108400130604     C                   EVAL      N1DI = 'Y'
108500130604     C                   ELSE
108600130604     C                   EVAL      N1DI = 'N'
108700130604     C                   ENDIF
108800130604    ***
108900130604     C                   IF        DSTUDN = 'Y'
109000130604     C                   EVAL      N1STDI = 'Y'
109100130604     C                   ENDIF
109200130604    ***
109300130604     C                   MOVE      EMPDT         #XSX
109400130604     C                   EXSR      $ISOUSA
109500130604     C                   MOVE      #XSX          N1HIRE
109600130604    ***
109700130604     C                   IF        EMPST = 'C'
109800130604     C                   EVAL      N1SI = 'C'
109900130604     C                   ELSE
110000130604     C                   EVAL      N1SI = 'A'
110100130604     C                   ENDIF
110200130604    ***
110300130604     C                   ENDSR
110400130604   S***S
110500130604     C     $CHKHEM       BEGSR
110600130604    ***
110700130604     C                   IF        MED#CNE > 0 AND MED@TRM(MED#CNE) <> 99999999
110800130604     C                   EXSR      $CHKMED
110900130604     C                   ENDIF
111000130604    ***
111100130604     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
111200130604     C                   EXSR      $CHKDEN
111300130604     C                   ENDIF
111400130604    ***
111500130604     C                   ENDSR
111600130604   S***S
111700130604      * CHECK FOR MEDICAL TERMINATION
111800130604    *C     $CHKMED       BEGSR
111900130604    ***
112000130604    *C                   EVAL      TERM_MED = YES
112100130604    *C                   EVAL      KF@TRM = MED@TRM(MED#CNE)
112200130604    *C                   EVAL      KF@PLN = MED@PLN(MED#CNE)
112300130604    *C                   EVAL      KF@ENR = MED@ENR(MED#CNE)
112400130604    ***
112500130604    *C     KL#MTR        CHAIN     NASTERMR
112600130604    *C                   IF        %FOUND(NASTERMP)
112700130604    *C                   EVAL      MED#CNE = 0
112800130604    *C                   EVAL      TERM_MED = NO
112900130604     C                   LEAVESR
113000130604     C                   ENDIF
113100130604    ***
113200130604     C                   EXSR      $WRTERM
113300130604    ***
113400130604    *C                   ENDSR
113500130604   S***S
113600130604    *C     $WRTERM       BEGSR
113700130604    ***
113800130604    *C                   CLEAR                   NASTERMR
113900130604     C                   EVAL      NTSSNO         = KF@SSN
114000130604     C                   EVAL      NTDEPNO        = KF@SEQ
114100130604     C                   EVAL      NTTERMDT       = KF@TRM
114200130604     C                   EVAL      NTPLAN         = KF@PLN
114300130604     C                   EVAL      NTCOVTP        = KF@ENR
114400130604     C                   EVAL      NTTRST         = KF@TRS
114500130604     C                   EVAL      NTSUB#         = KF@SUB
114600130604     C                   EVAL      NTACCT         = KF@ACC
114700130604     C                   EVAL      NTTRANSDT      = #TODAY
114800130604     C                   WRITE     NASTERMR
114900130604    ***
115000130604    *C                   ENDSR
115100130604   S***S
115200130604      * CHECK FOR DENTAL TERMINATION
115300130604    *C     $CHKDEN       BEGSR
115400130604    ***
115500130604    *C                   EVAL      TERM_DEN = YES
115600130604    *C                   EVAL      KF@TRM = DEN@TRM(DEN#CNE)
115700130604    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
115800130604    *C                   EVAL      KF@ENR = DEN@ENR(DEN#CNE)
115900130604    ***
116000130604    *C     KL#MTR        CHAIN     NASTERMR
116100130604    *C                   IF        %FOUND(NASTERMP)
116200130604    *C                   EVAL      DEN#CNE = 0
116300130604    *C                   EVAL      TERM_DEN = NO
116400130604     C                   LEAVESR
116500130604     C                   ENDIF
116600130604    ***
116700130604     C                   EXSR      $WRTERM
116800130604    ***
116900130604    *C                   ENDSR
117000130531   S***S
117100130531     C     *INZSR        BEGSR
117200130531    ***
117300130531     C                   EVAL      #RECCNT = 0
117400130531    ***
117500130531     C     KL#ACCTL      KLIST
117600130531     C                   KFLD                    CARR#CTL
117700130531     C                   KFLD                    KF@TRS
117800130531     C                   KFLD                    KF@SUB
117900130531     C                   KFLD                    KF@ACC
118000130603    ***
118100130603     C     KL#PCP        KLIST
118200130603     C                   KFLD                    KF@SSN
118300130603     C                   KFLD                    KF@SEQ
118400130603     C                   KFLD                    KF@SPCD
118500130531    ***
118600130531     C     KL#AUX        KLIST
118700130531     C                   KFLD                    KF@TRS
118800130531     C                   KFLD                    KF@SUB
118900130531     C                   KFLD                    KF@ACC
119000130531     C                   KFLD                    KF@SSN
119100130531     C                   KFLD                    KF@SEQ
119200130531    ***
119300130531     C     KL#TSA        KLIST
119400130531     C                   KFLD                    KF@TRS
119500130531     C                   KFLD                    KF@SUB
119600130531     C                   KFLD                    KF@ACC
119700130531    ***
119800130812     C     KL#SSA        KLIST
119900130812     C                   KFLD                    KF@ATYP
120000130812     C                   KFLD                    KF@MEM
120100130812    ***
120200130812     C     KL#NAS        KLIST
120300130812     C                   KFLD                    KF@ATYP
120400130812     C                   KFLD                    KF@ALID
120500130812    ***
120600130531     C     KL#MPLN       KLIST
120700130531     C                   KFLD                    KF@SSN
120800130531     C                   KFLD                    KF@SEQ
120900130531     C                   KFLD                    KF@TRS
121000130531     C                   KFLD                    KF@SUB
121100130531     C                   KFLD                    KF@ACC
121200130531    ***
121300130531     C     KL#CPLN       KLIST
121400130531     C                   KFLD                    CARR#CTL
121500130531     C                   KFLD                    KF@TRS
121600130531     C                   KFLD                    KF@SUB
121700130531     C                   KFLD                    KF@ACC
121800130531     C                   KFLD                    KF@CCTR
121900130531     C                   KFLD                    KF@PLN
122000130531    ***
122100130531     C     KL#DCV        KLIST
122200130531     C                   KFLD                    KF@SSN
122300130531     C                   KFLD                    KF@SEQ
122400130604     C                   KFLD                    KF@TRS
122500130604     C                   KFLD                    KF@SUB
122600130604     C                   KFLD                    KF@ACC
122700130531    ***
122800130531     C     KL#MTR        KLIST
122900130531     C                   KFLD                    KF@SSN
123000130531     C                   KFLD                    KF@SEQ
123100130531     C                   KFLD                    KF@TRM
123200130531     C                   KFLD                    KF@PLN
123300130531     C                   KFLD                    KF@ENR
123400130531     C                   KFLD                    KF@TRS
123500130531     C                   KFLD                    KF@SUB
123600130531     C                   KFLD                    KF@ACC
123700130604    ***
123800160323     C     kl#tsp        klist
123900160323     C                   kfld                    kf@trs
124000160323     C                   kfld                    kf@sub
124100160323     C                   kfld                    @planin
124200160323
124300130604     C                   ENDSR
124400130604   S***S
124500130604     C     $ISOUSA       BEGSR
124600130604    ***
124700130604     C                   MOVE      #XSX          @XSX              8
124800130604     C                   EVAL      @XSX = %SUBST(@XSX:5:4) + %SUBST(@XSX:1:4)
124900130604     C                   MOVE      @XSX          #XSX
125000130531    ***
125100130531     C                   ENDSR
125200130531   S***S
125300130531     C     $CLRSTG       BEGSR
125400130531    ***
125500130531     C                   EVAL      #CANCEL = 0
125600130531    ***
125700130531     C                   EVAL                    MED#CNE = 0
125800130531     C                   EVAL                    MED#NDX = 0
125900130531     C                   CLEAR                   MED@PLN
126000130531     C                   CLEAR                   MED@ENR
126100130531     C                   CLEAR                   MED@FRM
126200130531     C                   CLEAR                   MED@TRM
126300130531    ***
126400130531     C                   EVAL                    DEN#CNE = 0
126500130531     C                   EVAL                    DEN#NDX = 0
126600130531     C                   CLEAR                   DEN@PLN
126700130531     C                   CLEAR                   DEN@ENR
126800130531     C                   CLEAR                   DEN@FRM
126900130531     C                   CLEAR                   DEN@TRM
127000130531    ***
127100130531     C                   ENDSR
127200130531   S***S
