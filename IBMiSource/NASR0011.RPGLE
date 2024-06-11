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
033300170613     C                   IF        MCPLAN <> 'DAD4' AND MCPLAN <> 'DAD2'
033400170613     C****                         MCPLAN <> 'BADJ' AND MCPLAN <> 'BADK' and
033500170613     C****                         MCPLAN <> 'KAAW' AND MCPLAN <> 'KAAV'
033600160628     C****                         and MCPLAN <> 'S000' AND MCPLAN <> 'S001'
033700130531     C                   LEAVESR
033800130531     C                   ENDIF
033900130531    ***
034000170613     C                   IF        MCPLAN = 'DAD4' or MCPLAN = 'DAD2'
034100170613     C****               IF        MCPLAN = 'BADJ' or MCPLAN = 'BADK'
034200160322
034300130531     C                   EVAL      @PLANIN = MCPLAN
034400150617     C                   EVAL      #EFFDTE = ENRLDT
034500170613JOHN C                   if        #EFFDTE < 20170701
034600170613 ¦   C                   EVAL      #EFFDTE = 20170701
034700150617JOHN C                   endif
034800160322
034900160322JOHN C                   endif
035000160322
035100170613     C****               IF        MCPLAN = 'KAAW' or MCPLAN = 'KAAV'
035200160322
035300170613     C****               EVAL      @PLANIN = MCPLAN
035400170613     C****               EVAL      #EFFDTE = ENRLDT
035500170613JOHN C****               if        #EFFDTE < 20160301
035600170613 ¦   C****               EVAL      #EFFDTE = 20160301
035700170613JOHN C****               endif
035800160322
035900170613JOHN C****               endif
036000160322
036100130531     C                   EVAL      #CANCEL = CANDT
036200130531     C                   EVAL      @ENRIN = MCOVTP
036300130531     **
036400130531     C                   IF        #CANCEL = 0
036500130531     C                   EVAL      #CANCEL = 99999999
036600130531     C                   ENDIF
036700130531    ***
036800130531    ***
036900130531    *** 2014 ENROLLMENT CODE - COMMENT OUT WHEN OPEN ENROLLMENT IS DONE
037000130603    *C*                  IF        #CANCEL >= 20130731 AND #CANCEL < 99999999
037100130531     C*                  EVAL      #CANCEL = 99999999
037200130531    *C*                  ENDIF
037300130531    *X*
037400130603    *C*                  IF        ENRLDT > 20140800
037500130531    *C*                  LEAVESR
037600130531    2C*                  ENDIF
037700130531    *** 2014 ENROLLMENT CODE
037800130531    ***
037900130531    ***
038000130531     C                   EXSR      $QUIK
038100130531     **
038200130531     C                   IF        PLN@CAT = *BLANKS
038300130531     C                   LEAVESR
038400130531     C                   ENDIF
038500130531    ***
038600130531     C                   EXSR      $AD2MARY
038700130531    ***
038800130531     C                   ENDSR
038900130531   S***S
039000130531     C     $QUIK         BEGSR
039100130531    ***
039200130531     C                   EVAL      @ENROU = @ENRIN
039300130531     C                   EVAL      @CCTRIN = *BLANKS
039400130603     C                   EVAL      PLN@CAT = *BLANKS
039500130603    ***
039600130603     C                   SELECT
039700160323
039800170613     C****               WHEN      @PLANIN = 'BADB' OR @PLANIN = 'BADC' OR
039900150616     C****                         @PLANIN = 'BADG' OR @PLANIN = 'BADH' OR
040000170613JOHN C****                         @PLANIN = 'DABN' OR @PLANIN = 'DABP'
040100170613    *C****               EVAL      PLN@CAT = 'MED'
040200160323
040300170613     C                   WHEN      @PLANIN = 'DAD4' OR @PLANIN = 'DAD2'
040400170613     C****                         @PLANIN = 'BADJ' OR @PLANIN = 'BADK' or
040500170613     C****                         @PLANIN = 'KAAW' or @PLANIN = 'KAAV'
040600160628     C****                         or @PLANIN = 'S000' or @PLANIN = 'S001'
040700130603    *C                   EVAL      PLN@CAT = 'DEN'
040800160323
040900130603     C                   ENDSL
041000130531    ***
041100130531     C                   ENDSR
041200130531   S***S
041300130531     C     $AD2MARY      BEGSR
041400130531    ***
041500130531    *C                   IF        PLN@CAT = 'MED'
041600130531     C                   EXSR      $LOADMED
041700130531     C                   IF        MED#CNE > 0
041800130531     C                   IF        MED@TRM(MED#CNE) = 99999999
041900130531     C                   LEAVESR
042000130531     C                   ENDIF
042100130531     C                   ENDIF
042200130531    *C                   ADD       1             MED#CNE
042300130531    *C                   EVAL      MED@PLN(MED#CNE) = @PLANIN
042400130531    *C                   EVAL      MED@ENR(MED#CNE) = @ENROU
042500170613JOHN C                   if        #EFFDTE < 20170701
042600170613 ¦   C                   eval      #EFFDTE = 20170701
042700150617JOHN C                   endif
042800130531    *C                   EVAL      MED@FRM(MED#CNE) = #EFFDTE
042900130531    *C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
043000130531     C                   LEAVESR
043100130531    *C                   ENDIF
043200130531    ***
043300130531    *C                   IF        PLN@CAT = 'DEN'
043400130531     C                   IF        DEN#CNE > 0
043500130531     C                   IF        DEN@TRM(DEN#CNE) = 99999999
043600130531     C                   LEAVESR
043700130531     C                   ENDIF
043800130531     C                   ENDIF
043900130531    *C                   ADD       1             DEN#CNE
044000130531    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
044100130531    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
044200160323
044300170613     C                   IF        @planin = 'DAD2' or @planin = 'DAD4'
044400170613     C****               IF        @planin = 'BADJ' or @planin = 'BADK'
044500170613JOHN C                   if        #EFFDTE < 20170701
044600170613 ¦   C                   eval      #EFFDTE = 20170701
044700160323JOHN C                   endif
044800160323JOHN C                   endif
044900160323
045000170613     C****               IF        @planin = 'KAAW' or @planin = 'KAAV'
045100170613JOHN C****               if        #EFFDTE < 20160301
045200170613 ¦   C****               eval      #EFFDTE = 20160301
045300170613JOHN C****               endif
045400170613JOHN C****               endif
045500160323
045600130531    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
045700130531    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
045800130531     C                   LEAVESR
045900130531    *C                   ENDIF
046000130531    ***
046100130531     C                   ENDSR
046200130531   S***S
046300130531     C     $LOADMED      BEGSR
046400130531    ***
046500130531     C                   IF        MED#CNE = 0
046600130531     C                   EXSR      $AE_MED
046700130531     C                   LEAVESR
046800130531     C                   ENDIF
046900130531    ***
047000130531     C                   IF        MED@TRM(MED#CNE) = 99999999
047100130531     C                   LEAVESR
047200130531     C                   ENDIF
047300130531    ***
047400130607     C                   EVAL      MED#NDX = 0
047500130531    ***
047600130607     C                   DOU       MED#NDX = MED#CNE
047700130607     C                   IF        @PLANIN = MED@PLN(MED#NDX) AND
047800130607     C                             MED@ENR(MED#NDX) = @ENROU
047900130531      *
048000130607     C                   EVAL      #8D0 = MED@TRM(MED#NDX)
048100130531     C                   MOVE      #8D0          #ISO
048200130531     C                   ADDDUR    1:*D          #ISO
048300130531     C                   MOVE      #ISO          #8D1
048400130531      *
048500130531     C                   IF        #EFFDTE = #8D0 OR #EFFDTE = #8D1
048600130607     C                   IF        #CANCEL > MED@TRM(MED#NDX)
048700130607    *C                   EVAL      MED@TRM(MED#NDX) = #CANCEL
048800130603     C                   ENDIF
048900130531     C                   LEAVESR
049000130531     C                   ENDIF
049100130531      *
049200130531     C                   ENDIF
049300130531     C                   ENDDO
049400130531    ***
049500130531     C                   EXSR      $AE_MED
049600130531    ***
049700130531     C                   ENDSR
049800130531   S***S
049900130604    *** ADD ENTRY FOR MEDICAL
050000130604    ***
050100130531     C     $AE_MED       BEGSR
050200130531    ***
050300130531    *C                   ADD       1             MED#CNE
050400130531    *C                   EVAL      MED@PLN(MED#CNE) = @PLANIN
050500130531    *C                   EVAL      MED@ENR(MED#CNE) = @ENROU
050600170613JOHN C                   if        #EFFDTE < 20170701
050700170613 ¦   C                   eval      #EFFDTE = 20170701
050800150617JOHN C                   endif
050900130531    *C                   EVAL      MED@FRM(MED#CNE) = #EFFDTE
051000130531    *C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
051100130531    ***
051200130531     C                   ENDSR
051300130531   S***S
051400130603     C     $LOADDEN      BEGSR
051500130603    ***
051600130603     C                   IF        DEN#CNE = 0
051700130603     C                   EXSR      $AE_DEN
051800130603     C                   LEAVESR
051900130603     C                   ENDIF
052000130603    ***
052100130603     C                   IF        DEN@TRM(DEN#CNE) = 99999999
052200130603     C                   LEAVESR
052300130603     C                   ENDIF
052400130603    ***
052500130607     C                   EVAL      DEN#NDX = 0
052600130603    ***
052700130607     C                   DOU       DEN#NDX = DEN#CNE
052800130607     C                   IF        @PLANIN = DEN@PLN(DEN#NDX) AND
052900130607     C                             DEN@ENR(DEN#NDX) = @ENROU
053000130603      *
053100130607     C                   EVAL      #8D0 = DEN@TRM(DEN#NDX)
053200130603     C                   MOVE      #8D0          #ISO
053300130603     C                   ADDDUR    1:*D          #ISO
053400130603     C                   MOVE      #ISO          #8D1
053500130603      *
053600130603     C                   IF        #EFFDTE = #8D0 OR #EFFDTE = #8D1
053700130607     C                   IF        #CANCEL > DEN@TRM(DEN#NDX)
053800130607    *C                   EVAL      DEN@TRM(DEN#NDX) = #CANCEL
053900130603     C                   ENDIF
054000130603     C                   LEAVESR
054100130603     C                   ENDIF
054200130603      *
054300130603     C                   ENDIF
054400130603     C                   ENDDO
054500130603    ***
054600130603     C                   EXSR      $AE_DEN
054700130603    ***
054800130603     C                   ENDSR
054900130603   S***S
055000130604    *** ADD ENTRY FOR DENTAL
055100130604    ***
055200130603     C     $AE_DEN       BEGSR
055300130603    ***
055400130603    *C                   ADD       1             DEN#CNE
055500130603    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
055600130603    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
055700160323
055800170613     C                   IF        @planin = 'DAD4' or @planin = 'DAD2'
055900170613     C****               IF        @planin = 'BADJ' or @planin = 'BADK'
056000170613JOHN C                   if        #EFFDTE < 20170701
056100170613 ¦   C                   eval      #EFFDTE = 20170701
056200150617JOHN C                   endif
056300160323JOHN C                   endif
056400160323
056500170613     C****               IF        @planin = 'KAAW' or @planin = 'KAAV'
056600170613JOHN C****               if        #EFFDTE < 20160301
056700170613 ¦   C****               eval      #EFFDTE = 20160301
056800170613JOHN C****               endif
056900170613JOHN C****               endif
057000160323
057100130603    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
057200130603    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
057300130603    ***
057400130603     C                   ENDSR
057500130603   S***S
057600130531     C     $PREP4        BEGSR
057700130531    ***
057800130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
057900130531     C                   EVAL      @STEP = 'STEP2'
058000130531     C                   LEAVESR
058100130531     C                   ENDIF
058200130531    ***
058300130531     C                   EVAL      TERM_MED = NO
058400130531     C                   EVAL      TERM_DEN = NO
058500130531    ***
058600130531     C                   EXSR      $CHKHEM
058700130531    ***
058800130531     C                   EVAL      @STEP = 'STEP4'
058900130531    ***
059000130531     C                   ENDSR
059100130531   S***S
059200130531    *** GENERATE MEMBER RECORD
059300130531    ***
059400130531     C     $STEP4        BEGSR
059500130531    ***
059600130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
059700130531     C                   EVAL      @STEP = 'STEP2'
059800130531     C                   LEAVESR
059900130531     C                   ENDIF
060000130531    ***
060100130531     C                   EVAL      WRT@TYPE = 'MEMBER'
060200130531    ***
060300130531     C                   EVAL      MED@MEFF = 0
060400130531     C                   EVAL      DEN@MEFF = 0
060500130531    ***
060600130531     C                   EXSR      $FILLMBR
060700130531    ***
060800130531     C                   EXSR      $FILLCOVG
060900130531    ***
061000130603     C                   WRITE     NASF0001
061100130531     C                   ADD       1             #RECCNT
061200130531    ***
061300130531     C                   EVAL      @STEP = 'PREP5'
061400130531    ***
061500130531     C                   ENDSR
061600130531   S***S
061700130531     C     $MEDICARE     BEGSR
061800130531    ***
061900130531     C                   SELECT
062000130531     C                   WHEN      ADT > 0 AND BDT > 0
062100130531     C                   EVAL      N1MEI = '3'
062200130531     C                   WHEN      ADT > 0 AND BDT = 0
062300130531     C                   EVAL      N1MEI = '1'
062400130531     C                   WHEN      ADT = 0 AND BDT > 0
062500130531     C                   EVAL      N1MEI = '2'
062600130531     C                   OTHER
062700130531     C                   EVAL      N1MEI = '9'
062800130531     C                   ENDSL
062900130531    ***
063000130531     C                   EVAL      N1MAED = ADT
063100130531     C                   EVAL      N1MBED = BDT
063200130531    ***
063300130531     C                   ENDSR
063400130531   S***S
063500130531     C     $FILLMBR      BEGSR
063600130531    ***
063700130531     C                   CLEAR                   NASF0001
063800130531    ***
063900130531     C                   EVAL      N1TC = 'PF'
064000130531    ***
064100130812     C                   MOVE      @@SUB         N1SSN
064200130531     C                   MOVEL     MLNAME        N1LN
064300130531     C                   MOVEL     MFNAME        N1FN
064400130531     C                   MOVE      MMI           N1MI
064500130531    ***
064600130531     C                   MOVE      BIRTH         #XSX
064700130531     C                   EXSR      $ISOUSA
064800130531     C                   MOVE      #XSX          N1DOB
064900130531    ***
065000130531     C                   MOVE      SEX           N1GEN
065100130531     C                   EVAL      N1RC = '1'
065200130531    ***
065300130603     C                   MOVE      EMPDT         #XSX
065400130603     C                   EXSR      $ISOUSA
065500130603     C                   MOVE      #XSX          N1HIRE
065600130603    ***
065700130603     C                   IF        EMPST = 'C'
065800130603     C                   EVAL      N1SI = 'C'
065900130603     C                   ELSE
066000130603     C                   EVAL      N1SI = 'A'
066100130603     C                   ENDIF
066200130603    ***
066300130531     C                   MOVEL     ADDR1         N1A1
066400130531     C                   MOVEL     ADDR2         N1A2
066500130531     C                   MOVEL     CITY          N1CTY
066600130531     C                   MOVEL     STATE         N1ST
066700130531     C                   EVAL      @9 = %EDITC(ZIP:'X')
066800130531     C                   EVAL      N1ZP = %SUBST(@9:1:5)
066900130531    ***
067000130531     C                   EVAL      N1AREA = %EDITC(AREA:'X')
067100130531     C                   EVAL      N1PHON = %EDITC(PHONE:'X')
067200130812     C                   MOVE      @@MBR         N1SS2
067300130531    ***
067400130531     C                   IF        MED# <> *BLANKS AND (MEDADT > 0 OR
067500130531     C                             MEDBDT > 0)
067600130531     C                   MOVEL     MED#          N1HIC#
067700130531     C                   EVAL      ADT = MEDADT
067800130531     C                   EVAL      BDT = MEDBDT
067900130531     C                   EXSR      $MEDICARE
068000130531     C                   ELSE
068100130531     C                   EVAL      N1MEI = '9'
068200130531     C                   ENDIF
068300130531    ***
068400130531     C                   IF        COB <> 'Y'
068500130531     C                   EVAL      N1COBI = 'N'
068600130531     C                   ELSE
068700130531     C                   EVAL      N1COBI = 'Y'
068800130531     C                   ENDIF
068900130531    ***
069000140812     C                   IF        HNDICP = '3'
069100130531     C                   EVAL      N1DI = 'Y'
069200130531     C                   ELSE
069300130531     C                   EVAL      N1DI = 'N'
069400130531     C                   ENDIF
069500130531    ***
069600130531     C                   EVAL      N1STDI = *BLANKS
069700130531    ***
069800130531     C                   ENDSR
069900130531   S***S
070000130603     C     $FILLCOVG     BEGSR
070100130603    ***
070200130603     C                   IF        MED#CNE > 0
070300130604     C                   EXSR      $FILLMED
070400130603     C                   ENDIF
070500130603    ***
070600130603     C                   IF        DEN#CNE > 0
070700130604     C                   EXSR      $FILLDEN
070800130603     C                   ENDIF
070900130603    ***
071000130604     C                   ENDSR
071100130604   S***S
071200130604     C     $FILLMED      BEGSR
071300130604    ***
071400130604      * MEDICAL
071500130604    ***
071600130604     C                   EVAL      @PLANIN = MED@PLN(MED#CNE)
071700130604     C                   EVAL      @ENROU = MED@ENR(MED#CNE)
071800130604      *
071900130604     C                   SELECT
072000150616JOHN C                   WHEN      @PLANIN = 'DABP'
072100150616 ¦   C                   EVAL      N1MGN = '5801056DC40'
072200150617 ¦   C                   EVAL      N1MSN = '006'
072300150617 ¦   C****               EVAL      N1MSN = '026'
072400150616 ¦   C                   EVAL      N1MBC = '00002K3UZ'
072500150616 ¦   C                   WHEN      @PLANIN = 'DABN'
072600150616 ¦   C                   EVAL      N1MGN = '5801055DC10'
072700150616 ¦   C                   EVAL      N1MSN = '006'
072800150616JOHN C                   EVAL      N1MBC = '00001K3UY'
072900130604     C                   WHEN      @PLANIN = 'BADB'
073000130604     C                   EVAL      N1MGN = '5801053DC10'
073100130604     C                   EVAL      N1MSN = '240'
073200130604     C                   EVAL      N1MBC = '00001K3UW'
073300130604     C                   WHEN      @PLANIN = 'BADC'
073400130604     C                   EVAL      N1MGN = '5801054DC40'
073500150618     C                   EVAL      N1MSN = '240'
073600130604     C                   EVAL      N1MBC = '00002K3UX'
073700150616     C****               WHEN      @PLANIN = 'BADG'
073800150616     C****               EVAL      N1MGN = '5801055DC10'
073900150616     C****               EVAL      N1MSN = '006'
074000150616     C****               EVAL      N1MBC = '00001K3UY'
074100150616     C****               WHEN      @PLANIN = 'BADH'
074200150616     C****               EVAL      N1MGN = '5801056DC40'
074300150616     C****               EVAL      N1MSN = '026'
074400150616     C****               EVAL      N1MBC = '00002K3UZ'
074500130604     C                   ENDSL
074600130604      *
074700130604     C                   SELECT
074800130604     C*
074900130607     C                   WHEN      @ENROU = 'TIN'
075000130604     C                   EVAL      N1MCL = '01'
075100130604     C*
075200130607     C                   WHEN      @ENROU = 'THW'
075300130604     C                   EVAL      N1MCL = '02'
075400130604     C*
075500130607     C                   WHEN      @ENROU = 'TPC'
075600130604     C                   EVAL      N1MCL = '03'
075700130604     C*
075800130607     C                   WHEN      @ENROU = 'TP2'
075900130604     C                   EVAL      N1MCL = '04'
076000130604     C*
076100130607     C                   WHEN      @ENROU = 'TFA'
076200130604     C                   EVAL      N1MCL = '04'
076300130604     C*
076400130604     C                   ENDSL
076500130604      *
076600130604     C                   EVAL      #XSX = MED@FRM(MED#CNE)
076700130604     C                   EXSR      $ISOUSA
076800130612     C                   EVAL      N1MCD = %EDITC(#XSX:'X')
076900130604      *
077000130604     C                   EVAL      #XSX = MED@TRM(MED#CNE)
077100130607     C                   IF        #XSX = 99999999
077200130607     C                   EVAL      #XSX = 0
077300130607     C                   ENDIF
077400130607      *
077500130604     C                   IF        #XSX > 0
077600130604     C                   EVAL      N1MTC = '04'
077700130604     C                   EXSR      $ISOUSA
077800130612     C                   EVAL      N1MTD = %EDITC(#XSX:'X')
077900130604     C                   ENDIF
078000130604      *
078100150617      * Control Plan Code...
078200150617     C                   EVAL      N1CPC = '580'
078300150617
078400130607     C                   EVAL      N1MPID = '00'
078500130604      *
078600150617      * Home Plan Code...
078700150617     C                   EVAL      N1HPC = '580'
078800130604     C                   EVAL      @9 = %EDITC(ZIP:'X')
078900130604      *
079000150617     C                   IF        (%SUBST(@9:1:3) >= '210' AND
079100150617     C                             %SUBST(@9:1:3) <= '219')
079200150617     C                   EVAL      N1HPC = '690'
079300150617     C                   ENDIF
079400150617
079500130604     C                   EXSR      $PCP
079600130604     C                   EVAL      N1PCP = @PCP
079700130604     C                   EVAL      N1PED = @PED
079800130604     C                   EVAL      N1XPI = @XPI
079900130603    ***
080000130603     C                   ENDSR
080100130603   S***S
080200130603     C     $PCP          BEGSR
080300130603    ***
080400130603     C                   EVAL      @PCP = *BLANKS
080500130607     C                   EVAL      #PED = *ZEROS
080600130603     C                   EVAL      @PED = *BLANKS
080700130603     C                   EVAL      @XPI = *BLANKS
080800130603     C                   EVAL      KF@SPCD = 'MED'
080900130603    ***
081000130603     C     KL#PCP        CHAIN     PCPR
081100130603     C                   IF        NOT %FOUND(PCPL1)
081200130603     C                   LEAVESR
081300130603     C                   ENDIF
081400130603    ***
081500130603     C     KL#PCP        SETLL     PCPR
081600130603     C                   DOU       %EOF(PCPL1)
081700130603     C     KL#PCP        READE     PCPR
081800130603     C                   IF        NOT %EOF(PCPL1) AND
081900130603     C                             PCCAN = 0
082000130603      *
082100130603     C                   EVAL      @PCP = PCID#
082200130604     C                   EVAL      #XSX = PCEFF
082300130604     C                   EXSR      $ISOUSA
082400130607     C                   EVAL      #PED = #XSX
082500130607     C                   MOVE      #PED          @PED
082600130603     C                   IF        PCCUR = 'Y'
082700130603     C                   EVAL      @XPI = 'Y'
082800130603     C                   ELSE
082900130603     C                   EVAL      @XPI = 'N'
083000130603     C                   ENDIF
083100130603      *
083200130603     C                   ENDIF
083300130603     C                   ENDDO
083400130603    ***
083500130603     C                   ENDSR
083600130603   S***S
083700130604     C     $FILLDEN      BEGSR
083800130604    ***
083900130604      * DENTAL
084000130604    ***
084100130604     C                   EVAL      N1DPID = '08'
084200130604      *
084300130604     C                   EVAL      @PLANIN = DEN@PLN(DEN#CNE)
084400130604     C                   EVAL      @ENROU = DEN@ENR(DEN#CNE)
084500130604      *
084600130604     C                   SELECT
084700160323
084800170613     C                   WHEN      @PLANIN = 'DAD4'
084900130604     C                   EVAL      N1DGN = '1R8X'
085000170621     C                   EVAL      N1DSGN = '0001'
085100160323     C****               EVAL      N1DPCC = '0001'
085200160322
085300170613     C                   WHEN      @PLANIN = 'DAD2'
085400130604     C                   EVAL      N1DGN = '1R8X'
085500170613     C                   EVAL      N1DSGN = '0001'
085600160323     C****               EVAL      N1DPCC = '0002'
085700160322
085800170613     C****               WHEN      @PLANIN = 'KAAV'
085900170613     C****               EVAL      N1DGN = '1R8X'
086000170613     C****               EVAL      N1DSGN = '0001'
086100160323     C****               EVAL      N1DPCC = '0003'
086200160322
086300170613     C****               WHEN      @PLANIN = 'KAAW'
086400170613     C****               EVAL      N1DGN = '1R8X'
086500170613     C****               EVAL      N1DSGN = '0001'
086600160323     C****               EVAL      N1DPCC = '0004'
086700160322
086800160628     C****               WHEN      @PLANIN = 'S000'
086900160628     C****               EVAL      N1DGN = '1R8X'
087000160628     C****               EVAL      N1DSGN = '0001'
087100160419
087200160628     C****               WHEN      @PLANIN = 'S001'
087300160628     C****               EVAL      N1DGN = '1R8X'
087400160628     C****               EVAL      N1DSGN = '0001'
087500160419
087600130604     C                   ENDSL
087700130604      *
087800160323     C     kl#tsp        chain     fclass
087900160323     C                   if        %found
088000160323     C                   eval      n1dpcc = clclass
088100160323     c                   endif
088200160323
088300130604     C                   SELECT
088400130604     C*
088500130607     C                   WHEN      @ENROU = 'TIN'
088600130604     C                   EVAL      N1DCL = '01'
088700130604     C*
088800130607     C                   WHEN      @ENROU = 'THW'
088900130604     C                   EVAL      N1DCL = '02'
089000130604     C*
089100130607     C                   WHEN      @ENROU = 'TPC'
089200130604     C                   EVAL      N1DCL = '03'
089300130604     C*
089400130607     C                   WHEN      @ENROU = 'TP2'
089500130604     C                   EVAL      N1DCL = '04'
089600130604     C*
089700130607     C                   WHEN      @ENROU = 'TFA'
089800130604     C                   EVAL      N1DCL = '04'
089900130604     C*
090000130604     C                   ENDSL
090100130604      *
090200150618JOHN C****               if        DEN@FRM(DEN#CNE) < 20150701
090300150618 ¦   C****               eval      den@frm(den#cne) = 20150701
090400150618JOHN C****               endif
090500130604     C                   EVAL      #XSX = DEN@FRM(DEN#CNE)
090600130604     C                   EXSR      $ISOUSA
090700130607     C                   MOVE      #XSX          N1DCD
090800130604      *
090900130604     C                   EVAL      #XSX = DEN@TRM(DEN#CNE)
091000130607     C                   IF        #XSX = 99999999
091100130607     C                   EVAL      #XSX = 0
091200130607     C                   ENDIF
091300130607      *
091400130604     C                   IF        #XSX > 0
091500130604     C                   EVAL      N1DTC = '04'
091600160720     C****               EXSR      $ISOUSA
091700160720     C****               EVAL      N1DTD = %EDITC(#XSX:'X')
091800160720
091900160720       work_date = %date(%dec(#xsx : 8 : 0) : *iso);
092000160720       if %subdt(work_date:*d) = 01 ;
092100160720        work_date -= %days(1) ;
092200160720        num_date = %dec(work_date:*usa);
092300160720        n1dtd = %EDITC(num_date:'X');
092400160720       endif;
092500160720
092600130604     C                   ENDIF
092700130604    ***
092800130604     C                   ENDSR
092900130604   S***S
093000130604     C     $PREP5        BEGSR
093100130604    ***
093200130604     C     KF@SSN        CHAIN     DEPENR
093300130604     C                   IF        NOT %FOUND(DEPNDC)
093400130604     C                   EVAL      @STEP = 'STEP2'
093500130604     C                   LEAVESR
093600130604     C                   ENDIF
093700130604    ***
093800130604     C     KF@SSN        SETLL     DEPENR
093900130604    ***
094000130604     C                   EVAL      @STEP = 'STEP5'
094100130604    ***
094200130604     C                   ENDSR
094300130604   S***S
094400130604     C     $STEP5        BEGSR
094500130604    ***
094600130604     C     KF@SSN        READE     DEPENR
094700130604    ***
094800130604     C                   IF        %EOF(DEPNDC)
094900130604     C                   EVAL      @STEP = 'STEP2'
095000130604     C                   LEAVESR
095100130604     C                   ENDIF
095200130604    ***
095300130604     C                   EVAL      KF@SEQ = DPSEQ#
095400130604    ***
095500130604     C     KL#DCV        CHAIN     DCOVR
095600130604     C                   IF        NOT %FOUND(ELIGDCOVL1)
095700130604     C                   LEAVESR
095800130604     C                   ENDIF
095900130604    ***
096000130604     C                   EXSR      $CLRSTG
096100130604    ***
096200130604     C     KL#DCV        SETLL     DCOVR
096300130604    ***
096400130604     C                   EVAL      @STEP = 'STEP6'
096500130604    ***
096600130604     C                   ENDSR
096700130604   S***S
096800130604     C     $STEP6        BEGSR
096900130604    ***
097000130604     C     KL#DCV        READE     DCOVR
097100130604    ***
097200130604     C                   IF        %EOF(ELIGDCOVL1)
097300130604     C                   EVAL      @STEP = 'PREP7'
097400130604     C                   LEAVESR
097500130604     C                   ENDIF
097600130604    ***
097700130604    *** PUT PLANS HERE ***
097800130604    ***
097900170613     C                   IF        DVPLAN <> 'DAD4' AND DVPLAN <> 'DAD2'
098000170613     C****               IF        DVPLAN <> 'BADJ' AND DVPLAN <> 'BADK' and
098100170613     C****                         DVPLAN <> 'KAAW' AND DVPLAN <> 'KAAV'
098200160628     C****                         and DVPLAN <> 'S000' AND DVPLAN <> 'S001'
098300130604     C                   LEAVESR
098400130604     C                   ENDIF
098500130604    ***
098600130604     C                   EVAL      @PLANIN = DVPLAN
098700130604     C                   EVAL      @ENRIN = DVENRL
098800130604     C                   EVAL      #EFFDTE = DENRDT
098900130604     C                   EVAL      #CANCEL = CCANDT
099000130604    ***
099100130604     C                   IF        #CANCEL = 0
099200130604     C                   EVAL      #CANCEL = 99999999
099300130604     C                   ENDIF
099400130604    ***
099500130604    *** 2014 ENROLLMENT CODE - COMMENT OUT WHEN OPEN ENROLLMENT IS DONE
099600130604    *C*                  IF        #CANCEL >= 20130731 AND #CANCEL < 99999999
099700130604     C*                  EVAL      #CANCEL = 99999999
099800130604    *C*                  ENDIF
099900130604    *X*
100000130604    *C*                  IF        DENRDT > 20140800
100100130604    *C*                  LEAVESR
100200130604    2C*                  ENDIF
100300130604    *** 2014 ENROLLMENT CODE
100400130604    ***
100500130604    ***
100600130604    ***
100700130604     C                   EXSR      $QUIK
100800130604    ***
100900130604     C                   IF        PLN@CAT = *BLANKS
101000130604     C                   LEAVESR
101100130604     C                   ENDIF
101200130604    ***
101300130604     C                   EXSR      $AD2MARY
101400130604    ***
101500130604     C                   ENDSR
101600130604   S***S
101700130604     C     $PREP7        BEGSR
101800130604    ***
101900130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
102000130604     C                   EVAL      @STEP = 'STEP5'
102100130604     C                   LEAVESR
102200130604     C                   ENDIF
102300130604    ***
102400130604     C                   EVAL      TERM_MED = NO
102500130604     C                   EVAL      TERM_DEN = NO
102600130604    ***
102700130604     C                   EXSR      $CHKHEM
102800130604    ***
102900130604     C                   EVAL      @STEP = 'STEP7'
103000130604    ***
103100130604     C                   ENDSR
103200130604   S***S
103300130604     C     $STEP7        BEGSR
103400130604    ***
103500130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
103600130604     C                   EVAL      @STEP = 'STEP5'
103700130604     C                   LEAVESR
103800130604     C                   ENDIF
103900130604    ***
104000130604     C                   EVAL      WRT@TYPE = 'DEPEND'
104100130604    ***
104200130604     C                   EVAL      MED@MEFF = 0
104300130604     C                   EVAL      DEN@MEFF = 0
104400130604    ***
104500130604     C                   EXSR      $FILLDEP
104600130604    ***
104700130604     C                   EXSR      $FILLCOVG
104800130604    ***
104900160628     C     kl#tsp        chain     fclass
105000160628     C                   if        %found
105100160628     C                   eval      n1dpcc = clclass
105200160628     c                   endif
105300160628
105400130604     C                   WRITE     NASF0001
105500130604     C                   ADD       1             #RECCNT
105600130604    ***
105700130604     C                   EVAL      @STEP = 'STEP5'
105800130604    ***
105900130604     C                   ENDSR
106000130604   S***S
106100130604     C     $FILLDEP      BEGSR
106200130604    ***
106300130604     C                   CLEAR                   NASF0001
106400130604    ***
106500130604     C                   EVAL      N1TC = 'PF'
106600130604    ***
106700130812     C                   MOVE      @@SUB         N1SSN
106800130604     C                   MOVEL     DLNAME        N1LN
106900130604     C                   MOVEL     DFNAME        N1FN
107000130604     C                   MOVE      DMI           N1MI
107100130604    ***
107200130604     C                   MOVE      DBIRTH        #XSX
107300130604     C                   EXSR      $ISOUSA
107400130604     C                   MOVE      #XSX          N1DOB
107500130604    ***
107600130604     C                   MOVE      DSEX          N1GEN
107700130604    ***
107800130604    2C                   SELECT
107900130604    2C                   WHEN      DRELCD = 'RWI' OR DRELCD = 'RHU'
108000130604     C                   MOVE      '2'           N1RC
108100130604    2C                   WHEN      DRELCD = 'RDA' OR DRELCD = 'RSO'
108200130604     C                   MOVE      '3'           N1RC
108300130604    2C                   WHEN      DRELCD = 'RPA' OR DRELCD = 'RDP'
108400130604     C                   MOVE      '4'           N1RC
108500130604    2C                   OTHER
108600130604     C                   MOVE      '9'           N1RC
108700130604    2C                   ENDSL
108800130604    ***
108900130604    2C                   IF        DADDR1 = 'SAME'
109000130604     C                   MOVEL     ADDR1         N1A1
109100130604     C                   MOVEL     ADDR2         N1A2
109200130604     C                   MOVEL     CITY          N1CTY
109300130604     C                   MOVEL     STATE         N1ST
109400130604     C                   EVAL      @9 = %EDITC(ZIP:'X')
109500130604     C                   EVAL      N1ZP = %SUBST(@9:1:5)
109600130604     C                   EVAL      N1AREA = %EDITC(AREA:'X')
109700130604     C                   EVAL      N1PHON = %EDITC(PHONE:'X')
109800130604    2C                   ELSE
109900130604     C                   MOVEL     DADDR1        N1A1
110000130604     C                   MOVEL     DADDR2        N1A2
110100130604     C                   MOVEL     DCITY         N1CTY
110200130604     C                   MOVEL     DSTATE        N1ST
110300130604     C                   EVAL      @9 = %EDITC(DZIP:'X')
110400130604     C                   EVAL      N1ZP = %SUBST(@9:1:5)
110500130604     C                   EVAL      N1AREA = %EDITC(DAREA:'X')
110600130604     C                   EVAL      N1PHON = %EDITC(DPHONE:'X')
110700130604    2C                   ENDIF
110800130604    ***
110900140815     C                   IF        DEPSS# = 0
111000140815     C                   EVAL      N1SS2 = *BLANKS
111100140815     C                   ELSE
111200140815     C                   EVAL      N1SS2 = %EDITC(DEPSS#:'X')
111300140815     C                   ENDIF
111400140815    ***
111500130604     C                   IF        DMED# <> *BLANKS AND (DMEDAD > 0 OR
111600130604     C                             DMEDBD > 0)
111700130604     C                   MOVEL     DMED#         N1HIC#
111800130604     C                   EVAL      ADT = DMEDAD
111900130604     C                   EVAL      BDT = DMEDBD
112000130604     C                   EXSR      $MEDICARE
112100130604     C                   ELSE
112200130604     C                   EVAL      N1MEI = '9'
112300130604     C                   ENDIF
112400130604    ***
112500130604     C                   IF        DCOB = 'Y'
112600130604     C                   EVAL      N1COBI = 'Y'
112700130604     C                   ELSE
112800130604     C                   EVAL      N1COBI = 'N'
112900130604     C                   ENDIF
113000130604    ***
113100140812     C                   IF        DHNDCP = '3'
113200130604     C                   EVAL      N1DI = 'Y'
113300130604     C                   ELSE
113400130604     C                   EVAL      N1DI = 'N'
113500130604     C                   ENDIF
113600130604    ***
113700130604     C                   IF        DSTUDN = 'Y'
113800130604     C                   EVAL      N1STDI = 'Y'
113900130604     C                   ENDIF
114000130604    ***
114100130604     C                   MOVE      EMPDT         #XSX
114200130604     C                   EXSR      $ISOUSA
114300130604     C                   MOVE      #XSX          N1HIRE
114400130604    ***
114500130604     C                   IF        EMPST = 'C'
114600130604     C                   EVAL      N1SI = 'C'
114700130604     C                   ELSE
114800130604     C                   EVAL      N1SI = 'A'
114900130604     C                   ENDIF
115000130604    ***
115100130604     C                   ENDSR
115200130604   S***S
115300130604     C     $CHKHEM       BEGSR
115400130604    ***
115500130604     C                   IF        MED#CNE > 0 AND MED@TRM(MED#CNE) <> 99999999
115600130604     C                   EXSR      $CHKMED
115700130604     C                   ENDIF
115800130604    ***
115900130604     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
116000130604     C                   EXSR      $CHKDEN
116100130604     C                   ENDIF
116200130604    ***
116300130604     C                   ENDSR
116400130604   S***S
116500130604      * CHECK FOR MEDICAL TERMINATION
116600130604    *C     $CHKMED       BEGSR
116700130604    ***
116800130604    *C                   EVAL      TERM_MED = YES
116900130604    *C                   EVAL      KF@TRM = MED@TRM(MED#CNE)
117000130604    *C                   EVAL      KF@PLN = MED@PLN(MED#CNE)
117100130604    *C                   EVAL      KF@ENR = MED@ENR(MED#CNE)
117200130604    ***
117300130604    *C     KL#MTR        CHAIN     NASTERMR
117400130604    *C                   IF        %FOUND(NASTERMP)
117500130604    *C                   EVAL      MED#CNE = 0
117600130604    *C                   EVAL      TERM_MED = NO
117700130604     C                   LEAVESR
117800130604     C                   ENDIF
117900130604    ***
118000130604     C                   EXSR      $WRTERM
118100130604    ***
118200130604    *C                   ENDSR
118300130604   S***S
118400130604    *C     $WRTERM       BEGSR
118500130604    ***
118600130604    *C                   CLEAR                   NASTERMR
118700130604     C                   EVAL      NTSSNO         = KF@SSN
118800130604     C                   EVAL      NTDEPNO        = KF@SEQ
118900130604     C                   EVAL      NTTERMDT       = KF@TRM
119000130604     C                   EVAL      NTPLAN         = KF@PLN
119100130604     C                   EVAL      NTCOVTP        = KF@ENR
119200130604     C                   EVAL      NTTRST         = KF@TRS
119300130604     C                   EVAL      NTSUB#         = KF@SUB
119400130604     C                   EVAL      NTACCT         = KF@ACC
119500130604     C                   EVAL      NTTRANSDT      = #TODAY
119600130604     C                   WRITE     NASTERMR
119700130604    ***
119800130604    *C                   ENDSR
119900130604   S***S
120000130604      * CHECK FOR DENTAL TERMINATION
120100130604    *C     $CHKDEN       BEGSR
120200130604    ***
120300130604    *C                   EVAL      TERM_DEN = YES
120400130604    *C                   EVAL      KF@TRM = DEN@TRM(DEN#CNE)
120500130604    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
120600130604    *C                   EVAL      KF@ENR = DEN@ENR(DEN#CNE)
120700130604    ***
120800130604    *C     KL#MTR        CHAIN     NASTERMR
120900130604    *C                   IF        %FOUND(NASTERMP)
121000130604    *C                   EVAL      DEN#CNE = 0
121100130604    *C                   EVAL      TERM_DEN = NO
121200130604     C                   LEAVESR
121300130604     C                   ENDIF
121400130604    ***
121500130604     C                   EXSR      $WRTERM
121600130604    ***
121700130604    *C                   ENDSR
121800130531   S***S
121900130531     C     *INZSR        BEGSR
122000130531    ***
122100130531     C                   EVAL      #RECCNT = 0
122200130531    ***
122300130531     C     KL#ACCTL      KLIST
122400130531     C                   KFLD                    CARR#CTL
122500130531     C                   KFLD                    KF@TRS
122600130531     C                   KFLD                    KF@SUB
122700130531     C                   KFLD                    KF@ACC
122800130603    ***
122900130603     C     KL#PCP        KLIST
123000130603     C                   KFLD                    KF@SSN
123100130603     C                   KFLD                    KF@SEQ
123200130603     C                   KFLD                    KF@SPCD
123300130531    ***
123400130531     C     KL#AUX        KLIST
123500130531     C                   KFLD                    KF@TRS
123600130531     C                   KFLD                    KF@SUB
123700130531     C                   KFLD                    KF@ACC
123800130531     C                   KFLD                    KF@SSN
123900130531     C                   KFLD                    KF@SEQ
124000130531    ***
124100130531     C     KL#TSA        KLIST
124200130531     C                   KFLD                    KF@TRS
124300130531     C                   KFLD                    KF@SUB
124400130531     C                   KFLD                    KF@ACC
124500130531    ***
124600130812     C     KL#SSA        KLIST
124700130812     C                   KFLD                    KF@ATYP
124800130812     C                   KFLD                    KF@MEM
124900130812    ***
125000130812     C     KL#NAS        KLIST
125100130812     C                   KFLD                    KF@ATYP
125200130812     C                   KFLD                    KF@ALID
125300130812    ***
125400130531     C     KL#MPLN       KLIST
125500130531     C                   KFLD                    KF@SSN
125600130531     C                   KFLD                    KF@SEQ
125700130531     C                   KFLD                    KF@TRS
125800130531     C                   KFLD                    KF@SUB
125900130531     C                   KFLD                    KF@ACC
126000130531    ***
126100130531     C     KL#CPLN       KLIST
126200130531     C                   KFLD                    CARR#CTL
126300130531     C                   KFLD                    KF@TRS
126400130531     C                   KFLD                    KF@SUB
126500130531     C                   KFLD                    KF@ACC
126600130531     C                   KFLD                    KF@CCTR
126700130531     C                   KFLD                    KF@PLN
126800130531    ***
126900130531     C     KL#DCV        KLIST
127000130531     C                   KFLD                    KF@SSN
127100130531     C                   KFLD                    KF@SEQ
127200130604     C                   KFLD                    KF@TRS
127300130604     C                   KFLD                    KF@SUB
127400130604     C                   KFLD                    KF@ACC
127500130531    ***
127600130531     C     KL#MTR        KLIST
127700130531     C                   KFLD                    KF@SSN
127800130531     C                   KFLD                    KF@SEQ
127900130531     C                   KFLD                    KF@TRM
128000130531     C                   KFLD                    KF@PLN
128100130531     C                   KFLD                    KF@ENR
128200130531     C                   KFLD                    KF@TRS
128300130531     C                   KFLD                    KF@SUB
128400130531     C                   KFLD                    KF@ACC
128500130604    ***
128600160323     C     kl#tsp        klist
128700160323     C                   kfld                    kf@trs
128800160323     C                   kfld                    kf@sub
128900160323     C                   kfld                    @planin
129000160323
129100130604     C                   ENDSR
129200130604   S***S
129300130604     C     $ISOUSA       BEGSR
129400130604    ***
129500130604     C                   MOVE      #XSX          @XSX              8
129600130604     C                   EVAL      @XSX = %SUBST(@XSX:5:4) + %SUBST(@XSX:1:4)
129700130604     C                   MOVE      @XSX          #XSX
129800130531    ***
129900130531     C                   ENDSR
130000130531   S***S
130100130531     C     $CLRSTG       BEGSR
130200130531    ***
130300130531     C                   EVAL      #CANCEL = 0
130400130531    ***
130500130531     C                   EVAL                    MED#CNE = 0
130600130531     C                   EVAL                    MED#NDX = 0
130700130531     C                   CLEAR                   MED@PLN
130800130531     C                   CLEAR                   MED@ENR
130900130531     C                   CLEAR                   MED@FRM
131000130531     C                   CLEAR                   MED@TRM
131100130531    ***
131200130531     C                   EVAL                    DEN#CNE = 0
131300130531     C                   EVAL                    DEN#NDX = 0
131400130531     C                   CLEAR                   DEN@PLN
131500130531     C                   CLEAR                   DEN@ENR
131600130531     C                   CLEAR                   DEN@FRM
131700130531     C                   CLEAR                   DEN@TRM
131800130531    ***
131900130531     C                   ENDSR
132000130531   S***S
