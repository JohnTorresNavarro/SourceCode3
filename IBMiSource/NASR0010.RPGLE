000100130603   X***X CARRIER CONTROL ID #0000000084 NASCO SPECIFIC
000200130531   X***X
000300130531   X***X ACCOUNTS SET-UP
000400130603   X***X 590-010-0004  MIDDLE EAST BROADCASTING INC.
000500130531   X***X
000600130531   X***X
000700130531   X***X NOTE: EACH YEAR, REVIEW THIS PROGRAM AND SET DAY1YMD AND DAY1MDY
000800130531   X***X       TO THE FIRST DAY OF THE NEXT ENROLLMENT YEAR.
000900130531   X***X
001000130531   X***X   WHEN     WHO  WHAT
001100130809   X***X MM.DD.CCYY.XXX XXXXXXXXXXXXXX
001200130531   X***X 05.28.2013.SSK ORIGINAL
001300130603   X***X 06.03.2013.SSK COPIED FROM TEMPLATE
001400130809   X***X 08.09.2013.SSK ALTERNATE ID LOGIC
001500130531   X***X
001600130531   X***X
001700130531   X***X
001800130531   X***X
001900130531   X***X
002000130531   X***X
002100130531   X***X
002200130531     FCARACCP   IF   E           K DISK
002300130531   X***X
002400130531     FMEMAC#1   IF   E           K DISK
002500130531    ***   MEMBER DEMOGRAPHICS BY T/S/A/SOC
002600130531    ***
002700130531     FMCOVMPLN  IF   E           K DISK
002800130531    ***   MEMBER COVERAGE
002900130531    ***
003000130603     FPCPL1     IF   E           K DISK
003100130603    ***   MEMBER/DEPENDENT PCP
003200130603    ***
003300130809     FMEMALTL4  IF   E           K DISK    RENAME(MEMALTR:NASCF) PREFIX(NF:2)
003400130809    ***   ALT ID BY NASCO ID
003500130809    ***
003600130809     FMEMALTL5  IF   E           K DISK    RENAME(MEMALTR:MBRF) PREFIX(SS:2)
003700130809    ***   ALT ID BY MEMBER SSN
003800130809    ***
003900130531     FDEPNDC    IF   E           K DISK
004000130531    ***   DEPENDENT DEMOGRAPHICS BY SOC/SEQ
004100130531    ***
004200130604     FELIGDCOVL1IF   E           K DISK
004300130531    ***   DEPENDENT COVERAGE BY SOC/SEQ/T/S/ENRL/CAN/P
004400130531    ***
004500130531     F***NASCOVERD IF   E           K DISK
004600130531    ***   NASCO OVERRIDE FILE
004700130531    ***
004800130531     FNASTERMP  UF A E           K DISK
004900130531    ***   MEMBER/DEPENDENT TERMINATION
005000130531    ***
005100130603     FNASW0000  O  A E             DISK
005200130531    ***   ELIG EXPORT WORK
005300130531    ***
005400130531   X***X
005500130607     D PLN@CAT         S              5A
005600130603     D CARR#CTL        S             10A   INZ('0000000084')
005700130603     D DAY1MDY         S              8S 0 INZ(07012013)
005800130603     D DAY1YMD         S              8S 0 INZ(20130701)
005900130531   X***X
006000130531     D DS@CARACC     E DS                  EXTNAME(CARACCP)
006100130531   X***X
006200130607     D DS@N0         E DS                  EXTNAME(NASW0000)
006300130607   X***X
006400130531     ** WORK ARRAY FOR PLANS
006500130531     **
006600130531     ** PC# - PLAN COUNT
006700130531     ** PP# - PLAN POINTER
006800130531     **
006900130531     D CARPLN@       E DS                  EXTNAME(CARPLNP)
007000130531     D                                     OCCURS(50) PREFIX(X:1)
007100130531     **
007200130531     D ADT             S              8S 0
007300130531     D BDT             S              8S 0
007400130531     D PC#             S              3S 0
007500130531     D PP#             S              3S 0
007600130531     **
007700130603     D @PCP            S                   LIKE(PCID#)
007800130607     D @PED            S              8A
007900130607     D #PED            S                   LIKE(PCEFF)
008000130603     D @XPI            S                   LIKE(PCCUR)
008100130603     D @PLANIN         S              4A
008200130603     D #EFFDTE         S              8S 0
008300130531     D #BENAMT         S                   LIKE(BENAMT)
008400130531     D @CCTRIN         S              3A
008500130531     D @ENRIN          S              3A
008600130531     D @ENROU          S              3A
008700130531   X***X
008800130531     **
008900130531     ** WRITE TYPE = MEMBER OR DEPEND
009000130531     D WRT@TYPE        S              6A
009100130531     **
009200130531   X***X
009300130531     D #CANCEL         S              8S 0
009400130531     D #DATE           S              8S 0
009500130531     D #SIGN           S               D   DATFMT(*ISO)
009600130531     D #ISO            S               D   DATFMT(*ISO)
009700130531     D #RECCNT         S             10S 0 INZ
009800130531     D #TODAY          S              8S 0
009900130604     D @XSX            S              8A
010000130604     D #8D0            S              8S 0
010100130604     D #8D1            S              8S 0
010200130531     D #XSX            S              8S 0
010300130531     D #15S0           S             15S 0
010400130531     D #7S0            S              7S 0
010500130531     **
010600130531     D MBR_TERM        S               N
010700130531     D TERM_MED        S               N
010800130531     D TERM_DEN        S               N
010900130531     D YES             S               N   INZ(*ON)
011000130531     D NO              S               N   INZ(*OFF)
011100130531     D @9              S              9A
011200130531    ***
011300130809     D KF@ATYP         S              4A   INZ('MIS ')
011400130809     D KF@MEM          S              9S 0
011500130809     D KF@ALID         S             20A
011600130812     D @@MBR           S              9A
011700130812     D @@SUB           S              9A
011800130809    ***
011900130531     D KF@ACC          S                   LIKE(ACC#)
012000130531     D KF@CARG         S              2A   INZ
012100130531     D KF@CCTR         S                   LIKE(CCFLG)
012200130531     D KF@CDE          S              2A
012300130531     D KF@ENR          S              3A   INZ
012400130531     D KF@PLN          S                   LIKE(MCPLAN)
012500130531     D KF@SEQ          S                   LIKE(DPSEQ#)
012600130531     D KF@SSN          S                   LIKE(MBSSNO)
012700130603     D KF@SPCD         S                   LIKE(PCSPCD)
012800130531     D KF@SUB          S                   LIKE(MCSUB#)
012900130531     D KF@TRM          S              8S 0
013000130531     D KF@TRS          S                   LIKE(MCTRST)
013100130531     D KF@TYP          S              1A
013200130531     **
013300130531    ***
013400130531    *** MEDICAL ARRAYS
013500130531    *** CAT: PMM, PDM, PSM
013600130531     D MED#CNE         S              3S 0 INZ
013700130531     D MED#NDX         S              3S 0 INZ
013800130531     D MED@PLN         S              4A   DIM(20)
013900130531     D MED@ENR         S              3A   DIM(20)
014000130531     D MED@FRM         S              8S 0 DIM(20)
014100130531     D MED@TRM         S              8S 0 DIM(20)
014200130531     D MED@MEFF        S              8S 0
014300130531     D MED@MTRM        S              8S 0
014400130531    ***
014500130531    *** DENTAL ARRAYS
014600130531    *** CAT: PDN, PDE, PDR
014700130531     D DEN#CNE         S              3S 0 INZ
014800130531     D DEN#NDX         S              3S 0 INZ
014900130531     D DEN@PLN         S              4A   DIM(20)
015000130531     D DEN@ENR         S              3A   DIM(20)
015100130531     D DEN@FRM         S              8S 0 DIM(20)
015200130531     D DEN@TRM         S              8S 0 DIM(20)
015300130531     D DEN@MEFF        S              8S 0
015400130531     D DEN@MTRM        S              8S 0
015500130531    ***
015600130531    ***
015700130531     D @STEP           S              5A
015800130531    ***
015900130531   X***X
016000130531     C                   EVAL      @STEP = 'PREP0'
016100130531    ***
016200130531     C                   DOU       @STEP = 'LEAVE'
016300130531     C     @STEP         CASEQ     'PREP0'       $PREP0
016400130531     C     @STEP         CASEQ     'STEP0'       $STEP0
016500130531     C     @STEP         CASEQ     'PREP1'       $PREP1
016600130531     C     @STEP         CASEQ     'STEP1'       $STEP1
016700130531     C     @STEP         CASEQ     'STEP2'       $STEP2
016800130531     C     @STEP         CASEQ     'STEP3'       $STEP3
016900130531     C     @STEP         CASEQ     'PREP4'       $PREP4
017000130531     C     @STEP         CASEQ     'STEP4'       $STEP4
017100130531     C     @STEP         CASEQ     'PREP5'       $PREP5
017200130531     C     @STEP         CASEQ     'STEP5'       $STEP5
017300130531     C     @STEP         CASEQ     'STEP6'       $STEP6
017400130531     C     @STEP         CASEQ     'PREP7'       $PREP7
017500130531     C     @STEP         CASEQ     'STEP7'       $STEP7
017600130531     C                   ENDCS
017700130531     C                   ENDDO
017800130531    ***
017900130531     C                   EVAL      *INLR = *ON
018000130531   S***S
018100130531     C     $PREP0        BEGSR
018200130531    ***
018300130531     C     CARR#CTL      SETLL     CARACCR
018400130531    ***
018500130531     C                   EVAL      #ISO = %DATE
018600130531     C                   MOVE      #ISO          #TODAY
018700130531    ***
018800130531     C                   EVAL      @STEP = 'STEP0'
018900130531    ***
019000130531     C                   ENDSR
019100130531   S***S
019200130531     C     $STEP0        BEGSR
019300130531    ***
019400130531     C     CARR#CTL      READE     CARACCR
019500130531    ***
019600130531     C                   IF        %EOF(CARACCP)
019700130531     C                   EVAL      @STEP = 'LEAVE'
019800130531     C                   LEAVESR
019900130531     C                   ENDIF
020000130531    ***
020100130531    *** CAN THE ACCOUNT BE EXPORTED?
020200130531    ***
020300130531     C                   IF        CASTATUS = 'N'
020400130531     C                   LEAVESR
020500130531     C                   ENDIF
020600130531    ***
020700130531     C                   EVAL      @STEP = 'PREP1'
020800130531    ***
020900130531     C                   ENDSR
021000130531   S***S
021100130531     C     $PREP1        BEGSR
021200130531    ***
021300130531     C                   EVAL      KF@TRS = CATRST
021400130531     C                   EVAL      KF@SUB = CASUB#
021500130531     C                   EVAL      KF@ACC = CAACCT
021600130531    ***
021700130531     C                   EVAL      #RECCNT = 0
021800130531    ***
021900130531     C                   EVAL      @STEP = 'STEP1'
022000130531    ***
022100130531     C                   ENDSR
022200130531   S***S
022300130531     C     $STEP1        BEGSR
022400130531    ***
022500130531     C                   EVAL      KF@PLN = *BLANKS
022600130531     C                   EVAL      KF@TRM = 0
022700130531     C                   EVAL      KF@SSN = 0
022800130531     C                   EVAL      KF@SEQ = 0
022900130531    ***
023000130531     C     KL#TSA        SETLL     MEMBR
023100130531    ***
023200130531     C                   EVAL      @STEP = 'STEP2'
023300130531    ***
023400130531     C                   ENDSR
023500130531   S***S
023600130531     C     $STEP2        BEGSR
023700130531    ***
023800130531     C     KL#TSA        READE     MEMBR
023900130531    ***
024000130531     C                   IF        %EOF(MEMAC#1)
024100130531     C                   EVAL      @STEP = 'STEP0'
024200130531     C                   LEAVESR
024300130531     C                   ENDIF
024400130531    ***
024500130531     C                   EVAL      KF@SSN = MBSSNO
024600130531     C                   MOVE      *ZEROS        KF@SEQ
024700130812     C                   EVAL      KF@MEM = MBSSNO
024800130812     C                   EVAL      KF@ALID = %EDITC(MBSSNO:'X')
024900130812     C                   MOVE      MBSSNO        @@SUB
025000130812     C                   MOVE      MBSSNO        @@MBR
025100130812    ***
025200130812    ***
025300130812    ***  MBSSNO CHAIN ALT ID
025400130812    ***
025500130812    ***1  NOT FOUND                              MEMBER REC SSN NOT ON ALT ID SIDE
025600130812    ***     MBSSNO CHAIN ALT SSN                   MEMBER REC SSN NOT ON ALT SSN SIDE
025700130812    ***2      NOT FOUND THEN GOOD                        SO THIS IS A NORMAL MEMBER
025800130812    ***       IF FOUND                             MEMBER REC SSN IS ON ALT SSN SIDE
025900130812    ***         SET SUBID TO ALT ID VALUE                USE ALT ID FOR SUBSCRIBER INSTEAD
026000130812    ***2      E-I
026100130812    ***1 LSE
026200130812    *** 1(IF FOUND)                     MEMBER REC SSN = ALT ID
026300130812    ***2   IS MBR TERMED?                 IF TERMED, NEW SSN ASSIGNED, SO SKIP
026400130812    ***      YES THEN SKIP IT
026500130812    ***      NO                           STILL ACTIVE
026600130812    ***3       IS ALT ID = ALT SSN          IF ALT ID AND ALT SSN ARE SAME, THEN WE HAVE NOT
026700130812    ***           YES THEN CONTINUE                   RECEIVED SSN UPDATE YET
026800130812    ***           NO  SKIP IT               IF NOT EQUAL, THEN SOMEONE FORGOT TO SHUT IT DOWN
026900130812    ***3       E-I                                    WE MUST SKIP THE RECORD
027000130812    ***2   E-I
027100130812    ***1 E-I
027200130812    ***
027300130812     C     KL#NAS        CHAIN     NASCF
027400130812     C                   IF        NOT %FOUND(MEMALTL4)
027500130812      * NOT FOUND
027600130812      *
027700130812     C     KL#SSA        CHAIN     MBRF
027800130812     C                   IF        %FOUND(MEMALTL5)
027900130812     C                   EVAL      @@SUB = %SUBST(SSALTID:1:9)
028000130812     C                   ENDIF
028100130812      *
028200130812     C                   ELSE
028300130812      *
028400130812      * FOUND
028500130812     C                   IF        CANDT > 0                                     ALT ID MEM REC TRM
028600130812     C                   LEAVESR                                                     SKIP
028700130812     C                   ENDIF
028800130812     C                   MOVE      NFMEMID       @9                9
028900130812     C                   IF        @9 <> NFALTID
029000130812     C                   LEAVESR                                                     SKIP
029100130812     C                   ENDIF
029200130812      *
029300130812     C                   ENDIF
029400130809    ***
029500130812    ***
029600130531     C                   IF        TERMDT > 0
029700130531     C                   EVAL      MBR_TERM = YES
029800130531     C                   ELSE
029900130531     C                   EVAL      MBR_TERM = NO
030000130531     C                   ENDIF
030100130531    ***
030200130531     C     KL#MPLN       SETLL     MCOVR
030300130531    ***
030400130531     C                   EXSR      $CLRSTG
030500130531    ***
030600130531     C                   EVAL      @STEP = 'STEP3'
030700130531    ***
030800130531     C                   ENDSR
030900130531   S***S
031000130531     C     $STEP3        BEGSR
031100130531    ***
031200130531     C     KL#MPLN       READE     MCOVR
031300130531    ***
031400130531     C                   IF        %EOF(MCOVMPLN)
031500130531     C                   EVAL      @STEP = 'PREP4'
031600130531     C                   LEAVESR
031700130531     C                   ENDIF
031800130531    ***
031900130531    *** PUT PLANS HERE ***
032000130531    ***
032100160614JOHN C                   IF        MCPLAN <> 'DABN' AND MCPLAN <> 'DABP' AND
032200160614JOHN C                             MCPLAN <> 'DACR' AND MCPLAN <> 'DACS' AND
032300160614JOHN C                             MCPLAN <> 'DACT' AND MCPLAN <> 'DACU'
032400160614     C
032500130531     C                   LEAVESR
032600130531     C                   ENDIF
032700130531    ***
032800130531     C                   EVAL      @PLANIN = MCPLAN
032900150617     C                   EVAL      #EFFDTE = ENRLDT
033000170620JOHN C                   if        #EFFDTE < 20170701
033100170620 ¦   C                   EVAL      #EFFDTE = 20170701
033200150617JOHN C                   endif
033300130531     C                   EVAL      #CANCEL = CANDT
033400130531     C                   EVAL      @ENRIN = MCOVTP
033500130531     **
033600130531     C                   IF        #CANCEL = 0
033700130531     C                   EVAL      #CANCEL = 99999999
033800130531     C                   ENDIF
033900130531    ***
034000130531    ***
034100130531    *** 2014 ENROLLMENT CODE - COMMENT OUT WHEN OPEN ENROLLMENT IS DONE
034200130603    *C*                  IF        #CANCEL >= 20130731 AND #CANCEL < 99999999
034300130531     C*                  EVAL      #CANCEL = 99999999
034400130531    *C*                  ENDIF
034500130531    *X*
034600130603    *C*                  IF        ENRLDT > 20140800
034700130531    *C*                  LEAVESR
034800130531    2C*                  ENDIF
034900130531    *** 2014 ENROLLMENT CODE
035000130531    ***
035100130531    ***
035200130531     C                   EXSR      $QUIK
035300130531     **
035400130531     C                   IF        PLN@CAT = *BLANKS
035500130531     C                   LEAVESR
035600130531     C                   ENDIF
035700130531    ***
035800130531     C                   EXSR      $AD2MARY
035900130531    ***
036000130531     C                   ENDSR
036100130531   S***S
036200130531     C     $QUIK         BEGSR
036300130531    ***
036400130531     C                   EVAL      @ENROU = @ENRIN
036500130531     C                   EVAL      @CCTRIN = *BLANKS
036600130603     C                   EVAL      PLN@CAT = *BLANKS
036700130603    ***
036800130603     C                   SELECT
036900160614JOHN C                   WHEN      @PLANIN = 'DABN' OR @PLANIN = 'DABP' OR
037000160614JOHN C                             @PLANIN = 'DACR' OR @PLANIN = 'DACS' OR
037100160614JOHN C                             @PLANIN = 'DACT' OR @PLANIN = 'DACU'
037200130603    *C                   EVAL      PLN@CAT = 'MED'
037300160614
037400160705     C****               WHEN      @PLANIN = 'BADJ' OR @PLANIN = 'BADK'
037500160705    *C****               EVAL      PLN@CAT = 'DEN'
037600160705     C                   ENDSL
037700130531    ***
037800130531     C                   ENDSR
037900130531   S***S
038000130805    *** LOAD COVERAGE TO MEMBERSHIP COVERAGE ARRAY
038100130805    ***
038200130531     C     $AD2MARY      BEGSR
038300130531    ***
038400130531    *C                   IF        PLN@CAT = 'MED'
038500130531     C                   EXSR      $LOADMED
038600130531     C                   LEAVESR
038700130531    *C                   ENDIF
038800130531    ***
038900160705    *C****               IF        PLN@CAT = 'DEN'
039000160705     C****               EXSR      $LOADDEN
039100160705     C****               LEAVESR
039200160705    *C****               ENDIF
039300130531    ***
039400130531     C                   ENDSR
039500130531   S***S
039600130531     C     $LOADMED      BEGSR
039700130531    ***
039800130531     C                   IF        MED#CNE = 0
039900130805     C                   EXSR      $AE_MED                                      ADD ENTRY MEDICAL
040000130531     C                   LEAVESR
040100130531     C                   ENDIF
040200130531    ***
040300130531     C                   IF        MED@TRM(MED#CNE) = 99999999
040400130531     C                   LEAVESR
040500130531     C                   ENDIF
040600130531    ***
040700130805     C                   EVAL      MED#NDX = 0
040800130805    ***
040900130607     C                   DOU       MED#NDX = MED#CNE
041000130805      *
041100130805     C                   ADD       1             MED#NDX
041200130805      *
041300130607     C                   IF        @PLANIN = MED@PLN(MED#NDX) AND
041400130607     C                             MED@ENR(MED#NDX) = @ENROU
041500130531      *
041600130607     C                   EVAL      #8D0 = MED@TRM(MED#NDX)
041700130531     C                   MOVE      #8D0          #ISO
041800130531     C                   ADDDUR    1:*D          #ISO
041900130531     C                   MOVE      #ISO          #8D1
042000130531      *
042100130531     C                   IF        #EFFDTE = #8D0 OR #EFFDTE = #8D1
042200130607     C                   IF        #CANCEL > MED@TRM(MED#NDX)
042300130607    *C                   EVAL      MED@TRM(MED#NDX) = #CANCEL
042400130603     C                   ENDIF
042500130531     C                   LEAVESR
042600130531     C                   ENDIF
042700130531      *
042800130531     C                   ENDIF
042900130805      *
043000130531     C                   ENDDO
043100130531    ***
043200130531     C                   EXSR      $AE_MED
043300130531    ***
043400130531     C                   ENDSR
043500130531   S***S
043600130604    *** ADD ENTRY FOR MEDICAL
043700130604    ***
043800130531     C     $AE_MED       BEGSR
043900130531    ***
044000130531    *C                   ADD       1             MED#CNE
044100130531    *C                   EVAL      MED@PLN(MED#CNE) = @PLANIN
044200130531    *C                   EVAL      MED@ENR(MED#CNE) = @ENROU
044300170620JOHN C                   if        #effdte < 20170701
044400170620  ¦  C                   eval      #effdte = 20170701
044500150617JOHN C                   endif
044600130531    *C                   EVAL      MED@FRM(MED#CNE) = #EFFDTE
044700130531    *C                   EVAL      MED@TRM(MED#CNE) = #CANCEL
044800130531    ***
044900130531     C                   ENDSR
045000130531   S***S
045100130603     C     $LOADDEN      BEGSR
045200130603    ***
045300130603     C                   IF        DEN#CNE = 0
045400130603     C                   EXSR      $AE_DEN
045500130603     C                   LEAVESR
045600130603     C                   ENDIF
045700130603    ***
045800130603     C                   IF        DEN@TRM(DEN#CNE) = 99999999
045900130603     C                   LEAVESR
046000130603     C                   ENDIF
046100130603    ***
046200130607     C                   EVAL      DEN#NDX = 0
046300130603    ***
046400130607     C                   DOU       DEN#NDX = DEN#CNE
046500130805      *
046600130805     C                   ADD       1             DEN#NDX
046700130805      *
046800130805     C                   EVAL      #8D0 = DEN@TRM(DEN#NDX)
046900130607     C                   IF        @PLANIN = DEN@PLN(DEN#NDX) AND
047000130607     C                             DEN@ENR(DEN#NDX) = @ENROU
047100130603      *
047200130607     C                   EVAL      #8D0 = DEN@TRM(DEN#NDX)
047300130603     C                   MOVE      #8D0          #ISO
047400130603     C                   ADDDUR    1:*D          #ISO
047500130603     C                   MOVE      #ISO          #8D1
047600130603      *
047700130603     C                   IF        #EFFDTE = #8D0 OR #EFFDTE = #8D1
047800130607     C                   IF        #CANCEL > DEN@TRM(DEN#NDX)
047900130607    *C                   EVAL      DEN@TRM(DEN#NDX) = #CANCEL
048000130603     C                   ENDIF
048100130603     C                   LEAVESR
048200130603     C                   ENDIF
048300130603      *
048400130603     C                   ENDIF
048500130603     C                   ENDDO
048600130603    ***
048700130603     C                   EXSR      $AE_DEN
048800130603    ***
048900130603     C                   ENDSR
049000130603   S***S
049100130604    *** ADD ENTRY FOR DENTAL
049200130604    ***
049300130603     C     $AE_DEN       BEGSR
049400130603    ***
049500130603    *C                   ADD       1             DEN#CNE
049600130603    *C                   EVAL      DEN@PLN(DEN#CNE) = @PLANIN
049700130603    *C                   EVAL      DEN@ENR(DEN#CNE) = @ENROU
049800170620JOHN C                   if        #EFFDTE < 20170701
049900170620 ¦   C                   eval      #EFFDTE = 20170701
050000150617JOHN C                   endif
050100130603    *C                   EVAL      DEN@FRM(DEN#CNE) = #EFFDTE
050200130603    *C                   EVAL      DEN@TRM(DEN#CNE) = #CANCEL
050300130603    ***
050400130603     C                   ENDSR
050500130603   S***S
050600130531     C     $PREP4        BEGSR
050700130531    ***
050800130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
050900130531     C                   EVAL      @STEP = 'STEP2'
051000130531     C                   LEAVESR
051100130531     C                   ENDIF
051200130531    ***
051300130531     C                   EVAL      TERM_MED = NO
051400130531     C                   EVAL      TERM_DEN = NO
051500130531    ***
051600130531     C                   EXSR      $CHKHEM
051700130531    ***
051800130531     C                   EVAL      @STEP = 'STEP4'
051900130531    ***
052000130531     C                   ENDSR
052100130531   S***S
052200130531    *** GENERATE MEMBER RECORD
052300130531    ***
052400130531     C     $STEP4        BEGSR
052500130531    ***
052600130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
052700130531     C                   EVAL      @STEP = 'STEP2'
052800130531     C                   LEAVESR
052900130531     C                   ENDIF
053000130531    ***
053100130531     C                   EVAL      WRT@TYPE = 'MEMBER'
053200130531    ***
053300130531     C                   EVAL      MED@MEFF = 0
053400130531     C                   EVAL      DEN@MEFF = 0
053500130531    ***
053600130531     C                   EXSR      $FILLMBR
053700130531    ***
053800130531     C                   EXSR      $FILLCOVG
053900130531    ***
054000130603     C                   WRITE     NASF0001
054100130531     C                   ADD       1             #RECCNT
054200130531    ***
054300130531     C                   EVAL      @STEP = 'PREP5'
054400130531    ***
054500130531     C                   ENDSR
054600130531   S***S
054700130531     C     $MEDICARE     BEGSR
054800130531    ***
054900130531     C                   SELECT
055000130531     C                   WHEN      ADT > 0 AND BDT > 0
055100130531     C                   EVAL      N1MEI = '3'
055200130531     C                   WHEN      ADT > 0 AND BDT = 0
055300130531     C                   EVAL      N1MEI = '1'
055400130531     C                   WHEN      ADT = 0 AND BDT > 0
055500130531     C                   EVAL      N1MEI = '2'
055600130531     C                   OTHER
055700130531     C                   EVAL      N1MEI = '9'
055800130531     C                   ENDSL
055900130531    ***
056000130531     C                   EVAL      N1MAED = ADT
056100130531     C                   EVAL      N1MBED = BDT
056200130531    ***
056300130531     C                   ENDSR
056400130531   S***S
056500130531     C     $FILLMBR      BEGSR
056600130531    ***
056700130531     C                   CLEAR                   NASF0001
056800130531    ***
056900130531     C                   EVAL      N1TC = 'PF'
057000130531    ***
057100130812     C                   MOVE      @@SUB         N1SSN
057200130531     C                   MOVEL     MLNAME        N1LN
057300130531     C                   MOVEL     MFNAME        N1FN
057400130531     C                   MOVE      MMI           N1MI
057500130531    ***
057600130531     C                   MOVE      BIRTH         #XSX
057700130531     C                   EXSR      $ISOUSA
057800130531     C                   MOVE      #XSX          N1DOB
057900130531    ***
058000130531     C                   MOVE      SEX           N1GEN
058100130531     C                   EVAL      N1RC = '1'
058200130531    ***
058300130603     C                   MOVE      EMPDT         #XSX
058400130603     C                   EXSR      $ISOUSA
058500130603     C                   MOVE      #XSX          N1HIRE
058600130603    ***
058700130603     C                   IF        EMPST = 'C'
058800130603     C                   EVAL      N1SI = 'C'
058900130603     C                   ELSE
059000130603     C                   EVAL      N1SI = 'A'
059100130603     C                   ENDIF
059200130603    ***
059300130531     C                   MOVEL     ADDR1         N1A1
059400130531     C                   MOVEL     ADDR2         N1A2
059500130531     C                   MOVEL     CITY          N1CTY
059600130531     C                   MOVEL     STATE         N1ST
059700130531     C                   EVAL      @9 = %EDITC(ZIP:'X')
059800130531     C                   EVAL      N1ZP = %SUBST(@9:1:5)
059900130531    ***
060000130531     C                   EVAL      N1AREA = %EDITC(AREA:'X')
060100130531     C                   EVAL      N1PHON = %EDITC(PHONE:'X')
060200130812     C                   MOVE      @@MBR         N1SS2
060300130531    ***
060400130531     C                   IF        MED# <> *BLANKS AND (MEDADT > 0 OR
060500130531     C                             MEDBDT > 0)
060600130531     C                   MOVEL     MED#          N1HIC#
060700130531     C                   EVAL      ADT = MEDADT
060800130531     C                   EVAL      BDT = MEDBDT
060900130531     C                   EXSR      $MEDICARE
061000130531     C                   ELSE
061100130531     C                   EVAL      N1MEI = '9'
061200130531     C                   ENDIF
061300130531    ***
061400130531     C                   IF        COB <> 'Y'
061500130531     C                   EVAL      N1COBI = 'N'
061600130531     C                   ELSE
061700130531     C                   EVAL      N1COBI = 'Y'
061800130531     C                   ENDIF
061900130531    ***
062000140812     C                   IF        HNDICP = '3'
062100130531     C                   EVAL      N1DI = 'Y'
062200130531     C                   ELSE
062300130531     C                   EVAL      N1DI = 'N'
062400130531     C                   ENDIF
062500130531    ***
062600130531     C                   EVAL      N1STDI = *BLANKS
062700130531    ***
062800130531     C                   ENDSR
062900130531   S***S
063000130603     C     $FILLCOVG     BEGSR
063100130603    ***
063200130603     C                   IF        MED#CNE > 0
063300130604     C                   EXSR      $FILLMED
063400130603     C                   ENDIF
063500130603    ***
063600160705     C****               IF        DEN#CNE > 0
063700160705     C****               EXSR      $FILLDEN
063800160705     C****               ENDIF
063900130603    ***
064000130604     C                   ENDSR
064100130604   S***S
064200130604     C     $FILLMED      BEGSR
064300130604    ***
064400130604      * MEDICAL
064500130604    ***
064600130604     C                   EVAL      @PLANIN = MED@PLN(MED#CNE)
064700130604     C                   EVAL      @ENROU = MED@ENR(MED#CNE)
064800130604      *
064900130604     C                   SELECT
065000160614 ¦   C                   WHEN      @PLANIN = 'DABN'
065100160614 ¦   C                   EVAL      N1MGN = '5801055DC10'
065200160614 ¦   C                   EVAL      N1MSN = '006'
065300160614     C                   IF        @ENROU = 'TMI'
065400160614 ¦   C                   EVAL      N1MSN = '026'
065500160614     C                   ENDIF
065600160614JOHN C                   EVAL      N1MBC = '00001K3UY'
065700160614
065800150616JOHN C                   WHEN      @PLANIN = 'DABP'
065900150616 ¦   C                   EVAL      N1MGN = '5801056DC40'
066000150617 ¦   C                   EVAL      N1MSN = '006'
066100160614     C                   IF        @ENROU = 'TMI'
066200160614 ¦   C                   EVAL      N1MSN = '026'
066300160614     C                   ENDIF
066400150616 ¦   C                   EVAL      N1MBC = '00002K3UZ'
066500160614
066600160614 ¦   C                   WHEN      @PLANIN = 'DACR'
066700160614 ¦   C                   EVAL      N1MGN = '5801634DC10'
066800160614 ¦   C                   EVAL      N1MSN = '240'
066900160614     c                   IF        @ENROU = 'TMI'
067000160614 ¦   C                   EVAL      N1MSN = '242'
067100160614     C                   ENDIF
067200160614JOHN C                   EVAL      N1MBC = '00001K9JK'
067300160614
067400160614 ¦   C                   WHEN      @PLANIN = 'DACS'
067500160614 ¦   C                   EVAL      N1MGN = '5801635DC40'
067600160614 ¦   C                   EVAL      N1MSN = '240'
067700160614     c                   IF        @ENROU = 'TMI'
067800160614 ¦   C                   EVAL      N1MSN = '242'
067900160614     C                   ENDIF
068000160614JOHN C                   EVAL      N1MBC = '00002K9JL'
068100160614
068200160614 ¦   C                   WHEN      @PLANIN = 'DACT'
068300160614 ¦   C                   EVAL      N1MGN = '5801636DC10'
068400160614 ¦   C                   EVAL      N1MSN = '241'
068500160614     c                   IF        @ENROU = 'TIN'
068600160614 ¦   C                   EVAL      N1MSN = '240'
068700160614     C                   ENDIF
068800160614     c                   IF        @ENROU = 'TMI'
068900160614 ¦   C                   EVAL      N1MSN = '242'
069000160614     C                   ENDIF
069100160614JOHN C                   EVAL      N1MBC = '00001K9JM'
069200160614
069300160614 ¦   C                   WHEN      @PLANIN = 'DACU'
069400160614 ¦   C                   EVAL      N1MGN = '5801637DC40'
069500160614 ¦   C                   EVAL      N1MSN = '241'
069600160614     c                   IF        @ENROU = 'TIN'
069700160614 ¦   C                   EVAL      N1MSN = '240'
069800160614     C                   ENDIF
069900160614     c                   IF        @ENROU = 'TMI'
070000160614 ¦   C                   EVAL      N1MSN = '242'
070100160614     C                   ENDIF
070200160614JOHN C                   EVAL      N1MBC = '00002K9JN'
070300160614
070400160614
070500130604     C                   ENDSL
070600130604      *
070700130604     C                   SELECT
070800130604     C*
070900130607     C                   WHEN      @ENROU = 'TIN'
071000130604     C                   EVAL      N1MCL = '01'
071100130604     C*
071200130607     C                   WHEN      @ENROU = 'THW'
071300130604     C                   EVAL      N1MCL = '02'
071400130604     C*
071500130607     C                   WHEN      @ENROU = 'TPC'
071600130604     C                   EVAL      N1MCL = '03'
071700130604     C*
071800130607     C                   WHEN      @ENROU = 'TP2'
071900130604     C                   EVAL      N1MCL = '04'
072000130604     C*
072100130607     C                   WHEN      @ENROU = 'TFA'
072200130604     C                   EVAL      N1MCL = '04'
072300130604     C*
072400130604     C                   ENDSL
072500130604      *
072600130604     C                   EVAL      #XSX = MED@FRM(MED#CNE)
072700130604     C                   EXSR      $ISOUSA
072800130612     C                   EVAL      N1MCD = %EDITC(#XSX:'X')
072900130604      *
073000130604     C                   EVAL      #XSX = MED@TRM(MED#CNE)
073100130607     C                   IF        #XSX = 99999999
073200130607     C                   EVAL      #XSX = 0
073300130607     C                   ENDIF
073400130607      *
073500130604     C                   IF        #XSX > 0
073600130604     C                   EVAL      N1MTC = '04'
073700130604     C                   EXSR      $ISOUSA
073800130612     C                   EVAL      N1MTD = %EDITC(#XSX:'X')
073900130604     C                   ENDIF
074000130604      *
074100150617      * Control Plan Code...
074200150617     C                   EVAL      N1CPC = '580'
074300150617
074400130607     C                   EVAL      N1MPID = '00'
074500130604      *
074600150617      * Home Plan Code...
074700150617     C                   EVAL      N1HPC = '580'
074800130604     C                   EVAL      @9 = %EDITC(ZIP:'X')
074900150617     C                   IF        (%SUBST(@9:1:3) >= '210' AND
075000150617     C                             %SUBST(@9:1:3) <= '219')
075100150617     C                   EVAL      N1HPC = '690'
075200150617     C                   ENDIF
075300130604      *
075400130604     C                   EXSR      $PCP
075500130604     C                   EVAL      N1PCP = @PCP
075600130604     C                   EVAL      N1PED = @PED
075700130604     C                   EVAL      N1XPI = @XPI
075800130603    ***
075900130603     C                   ENDSR
076000130603   S***S
076100130603     C     $PCP          BEGSR
076200130603    ***
076300130603     C                   EVAL      @PCP = *BLANKS
076400130607     C                   EVAL      #PED = *ZEROS
076500130603     C                   EVAL      @PED = *BLANKS
076600130603     C                   EVAL      @XPI = *BLANKS
076700130603     C                   EVAL      KF@SPCD = 'MED'
076800130603    ***
076900130603     C     KL#PCP        CHAIN     PCPR
077000130603     C                   IF        NOT %FOUND(PCPL1)
077100130603     C                   LEAVESR
077200130603     C                   ENDIF
077300130603    ***
077400130603     C     KL#PCP        SETLL     PCPR
077500130603     C                   DOU       %EOF(PCPL1)
077600130603     C     KL#PCP        READE     PCPR
077700130603     C                   IF        NOT %EOF(PCPL1) AND
077800130603     C                             PCCAN = 0
077900130603      *
078000130603     C                   EVAL      @PCP = PCID#
078100160614JOHN C****               if        PCEFF < 20160701
078200160614 ¦   C****               EVAL      PCEFF = 20160701
078300150618JOHN C****               endif
078400130604     C                   EVAL      #XSX = PCEFF
078500130604     C                   EXSR      $ISOUSA
078600130607     C                   EVAL      #PED = #XSX
078700130607     C                   MOVE      #PED          @PED
078800130603     C                   IF        PCCUR = 'Y'
078900130603     C                   EVAL      @XPI = 'Y'
079000130603     C                   ELSE
079100130603     C                   EVAL      @XPI = 'N'
079200130603     C                   ENDIF
079300130603      *
079400130603     C                   ENDIF
079500130603     C                   ENDDO
079600130603    ***
079700130603     C                   ENDSR
079800130603   S***S
079900160705     C     $FILLDEN      BEGSR
080000130604    ***
080100130604      * DENTAL
080200130604    ***
080300160705     C****               EVAL      N1DPID = '08'
080400130604      *
080500160705     C****               EVAL      @PLANIN = DEN@PLN(DEN#CNE)
080600160705     C****               EVAL      @ENROU = DEN@ENR(DEN#CNE)
080700130604      *
080800160705     C****               SELECT
080900160705     C****               WHEN      @PLANIN = 'BADJ'
081000160705     C****               EVAL      N1DGN = '1R8X'
081100160705     C****               EVAL      N1DSGN = '0001'
081200160705     C****               EVAL      N1DPCC = '0001'
081300160705     C****               WHEN      @PLANIN = 'BADK'
081400160705     C****               EVAL      N1DGN = '1R8X'
081500160705     C****               EVAL      N1DSGN = '0001'
081600160705     C****               EVAL      N1DPCC = '0002'
081700160705     C****               ENDSL
081800160705      ****
081900160705     C****               SELECT
082000130604     C*
082100160705     C****               WHEN      @ENROU = 'TIN'
082200160705     C****               EVAL      N1DCL = '01'
082300160705     C****
082400160705     C****               WHEN      @ENROU = 'THW'
082500160705     C****               EVAL      N1DCL = '02'
082600160705     C****
082700160705     C****               WHEN      @ENROU = 'TPC'
082800160705     C****               EVAL      N1DCL = '03'
082900160705     C****
083000160705     C****               WHEN      @ENROU = 'TP2'
083100160705     C****               EVAL      N1DCL = '04'
083200160705     C****
083300160705     C****               WHEN      @ENROU = 'TFA'
083400160705     C****               EVAL      N1DCL = '04'
083500160705     C****
083600160705     C****               ENDSL
083700160705      ****
083800160705     C****               EVAL      #XSX = DEN@FRM(DEN#CNE)
083900160705     C****               EXSR      $ISOUSA
084000160705     C****               MOVE      #XSX          N1DCD
084100160705      ****
084200160705     C****               EVAL      #XSX = DEN@TRM(DEN#CNE)
084300160705     C****               IF        #XSX = 99999999
084400160705     C****               EVAL      #XSX = 0
084500160705     C****               ENDIF
084600160705      ****
084700160705     C****               IF        #XSX > 0
084800160705     C****               EVAL      N1DTC = '04'
084900160705     C****               EXSR      $ISOUSA
085000160705     C****               EVAL      N1DTD = %EDITC(#XSX:'X')
085100160705     C****               ENDIF
085200130604    ***
085300160705     C                   ENDSR
085400130604   S***S
085500130604     C     $PREP5        BEGSR
085600130604    ***
085700130604     C     KF@SSN        CHAIN     DEPENR
085800130604     C                   IF        NOT %FOUND(DEPNDC)
085900130604     C                   EVAL      @STEP = 'STEP2'
086000130604     C                   LEAVESR
086100130604     C                   ENDIF
086200130604    ***
086300130604     C     KF@SSN        SETLL     DEPENR
086400130604    ***
086500130604     C                   EVAL      @STEP = 'STEP5'
086600130604    ***
086700130604     C                   ENDSR
086800130604   S***S
086900130604     C     $STEP5        BEGSR
087000130604    ***
087100130604     C     KF@SSN        READE     DEPENR
087200130604    ***
087300130604     C                   IF        %EOF(DEPNDC)
087400130604     C                   EVAL      @STEP = 'STEP2'
087500130604     C                   LEAVESR
087600130604     C                   ENDIF
087700130604    ***
087800130604     C                   EVAL      KF@SEQ = DPSEQ#
087900130604    ***
088000130604     C     KL#DCV        CHAIN     DCOVR
088100130604     C                   IF        NOT %FOUND(ELIGDCOVL1)
088200130604     C                   LEAVESR
088300130604     C                   ENDIF
088400130604    ***
088500130604     C                   EXSR      $CLRSTG
088600130604    ***
088700130604     C     KL#DCV        SETLL     DCOVR
088800130604    ***
088900130604     C                   EVAL      @STEP = 'STEP6'
089000130604    ***
089100130604     C                   ENDSR
089200130604   S***S
089300130604     C     $STEP6        BEGSR
089400130604    ***
089500130604     C     KL#DCV        READE     DCOVR
089600130604    ***
089700130604     C                   IF        %EOF(ELIGDCOVL1)
089800130604     C                   EVAL      @STEP = 'PREP7'
089900130604     C                   LEAVESR
090000130604     C                   ENDIF
090100130604    ***
090200130604    *** PUT PLANS HERE ***
090300130604    ***
090400160614JOHN C                   IF        DVPLAN <> 'DABN' AND DVPLAN <> 'DABP' AND
090500160614JOHN C                             DVPLAN <> 'DACR' AND DVPLAN <> 'DACS' AND
090600160614JOHN C                             DVPLAN <> 'DACT' AND DVPLAN <> 'DACU'
090700130604     C                   LEAVESR
090800130604     C                   ENDIF
090900130604    ***
091000130604     C                   EVAL      @PLANIN = DVPLAN
091100130604     C                   EVAL      @ENRIN = DVENRL
091200130604     C                   EVAL      #EFFDTE = DENRDT
091300130604     C                   EVAL      #CANCEL = CCANDT
091400130604    ***
091500130604     C                   IF        #CANCEL = 0
091600130604     C                   EVAL      #CANCEL = 99999999
091700130604     C                   ENDIF
091800130604    ***
091900130604    *** 2014 ENROLLMENT CODE - COMMENT OUT WHEN OPEN ENROLLMENT IS DONE
092000130604    *C*                  IF        #CANCEL >= 20130731 AND #CANCEL < 99999999
092100130604     C*                  EVAL      #CANCEL = 99999999
092200130604    *C*                  ENDIF
092300130604    *X*
092400130604    *C*                  IF        DENRDT > 20140800
092500130604    *C*                  LEAVESR
092600130604    2C*                  ENDIF
092700130604    *** 2014 ENROLLMENT CODE
092800130604    ***
092900130604    ***
093000130604    ***
093100130604     C                   EXSR      $QUIK
093200130604    ***
093300130604     C                   IF        PLN@CAT = *BLANKS
093400130604     C                   LEAVESR
093500130604     C                   ENDIF
093600130604    ***
093700130604     C                   EXSR      $AD2MARY
093800130604    ***
093900130604     C                   ENDSR
094000130604   S***S
094100130604     C     $PREP7        BEGSR
094200130604    ***
094300130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
094400130604     C                   EVAL      @STEP = 'STEP5'
094500130604     C                   LEAVESR
094600130604     C                   ENDIF
094700130604    ***
094800130604     C                   EVAL      TERM_MED = NO
094900130604     C                   EVAL      TERM_DEN = NO
095000130604    ***
095100130604     C                   EXSR      $CHKHEM
095200130604    ***
095300130604     C                   EVAL      @STEP = 'STEP7'
095400130604    ***
095500130604     C                   ENDSR
095600130604   S***S
095700130604     C     $STEP7        BEGSR
095800130604    ***
095900130604     C                   IF        DEN#CNE  = 0 AND MED#CNE  = 0
096000130604     C                   EVAL      @STEP = 'STEP5'
096100130604     C                   LEAVESR
096200130604     C                   ENDIF
096300130604    ***
096400130604     C                   EVAL      WRT@TYPE = 'DEPEND'
096500130604    ***
096600130604     C                   EVAL      MED@MEFF = 0
096700130604     C                   EVAL      DEN@MEFF = 0
096800130604    ***
096900130604     C                   EXSR      $FILLDEP
097000130604    ***
097100130604     C                   EXSR      $FILLCOVG
097200130604    ***
097300130604     C                   WRITE     NASF0001
097400130604     C                   ADD       1             #RECCNT
097500130604    ***
097600130604     C                   EVAL      @STEP = 'STEP5'
097700130604    ***
097800130604     C                   ENDSR
097900130604   S***S
098000130604     C     $FILLDEP      BEGSR
098100130604    ***
098200130604     C                   CLEAR                   NASF0001
098300130604    ***
098400130604     C                   EVAL      N1TC = 'PF'
098500130604    ***
098600130812     C                   MOVE      @@SUB         N1SSN
098700130604     C                   MOVEL     DLNAME        N1LN
098800130604     C                   MOVEL     DFNAME        N1FN
098900130604     C                   MOVE      DMI           N1MI
099000130604    ***
099100130604     C                   MOVE      DBIRTH        #XSX
099200130604     C                   EXSR      $ISOUSA
099300130604     C                   MOVE      #XSX          N1DOB
099400130604    ***
099500130604     C                   MOVE      DSEX          N1GEN
099600130604    ***
099700130604    2C                   SELECT
099800130604    2C                   WHEN      DRELCD = 'RWI' OR DRELCD = 'RHU'
099900130604     C                   MOVE      '2'           N1RC
100000130604    2C                   WHEN      DRELCD = 'RDA' OR DRELCD = 'RSO'
100100130604     C                   MOVE      '3'           N1RC
100200130604    2C                   WHEN      DRELCD = 'RPA' OR DRELCD = 'RDP'
100300130604     C                   MOVE      '4'           N1RC
100400130604    2C                   OTHER
100500130604     C                   MOVE      '9'           N1RC
100600130604    2C                   ENDSL
100700130604    ***
100800130604    2C                   IF        DADDR1 = 'SAME'
100900130604     C                   MOVEL     ADDR1         N1A1
101000130604     C                   MOVEL     ADDR2         N1A2
101100130604     C                   MOVEL     CITY          N1CTY
101200130604     C                   MOVEL     STATE         N1ST
101300130604     C                   EVAL      @9 = %EDITC(ZIP:'X')
101400130604     C                   EVAL      N1ZP = %SUBST(@9:1:5)
101500130604     C                   EVAL      N1AREA = %EDITC(AREA:'X')
101600130604     C                   EVAL      N1PHON = %EDITC(PHONE:'X')
101700130604    2C                   ELSE
101800130604     C                   MOVEL     DADDR1        N1A1
101900130604     C                   MOVEL     DADDR2        N1A2
102000130604     C                   MOVEL     DCITY         N1CTY
102100130604     C                   MOVEL     DSTATE        N1ST
102200130604     C                   EVAL      @9 = %EDITC(DZIP:'X')
102300130604     C                   EVAL      N1ZP = %SUBST(@9:1:5)
102400130604     C                   EVAL      N1AREA = %EDITC(DAREA:'X')
102500130604     C                   EVAL      N1PHON = %EDITC(DPHONE:'X')
102600130604    2C                   ENDIF
102700130604    ***
102800140815     C                   IF        DEPSS# = 0
102900140815     C                   EVAL      N1SS2 = *BLANKS
103000140815     C                   ELSE
103100130604     C                   EVAL      N1SS2 = %EDITC(DEPSS#:'X')
103200140815     C                   ENDIF
103300130604    ***
103400130604     C                   IF        DMED# <> *BLANKS AND (DMEDAD > 0 OR
103500130604     C                             DMEDBD > 0)
103600130604     C                   MOVEL     DMED#         N1HIC#
103700130604     C                   EVAL      ADT = DMEDAD
103800130604     C                   EVAL      BDT = DMEDBD
103900130604     C                   EXSR      $MEDICARE
104000130604     C                   ELSE
104100130604     C                   EVAL      N1MEI = '9'
104200130604     C                   ENDIF
104300130604    ***
104400130604     C                   IF        DCOB = 'Y'
104500130604     C                   EVAL      N1COBI = 'Y'
104600130604     C                   ELSE
104700130604     C                   EVAL      N1COBI = 'N'
104800130604     C                   ENDIF
104900130604    ***
105000140812     C                   IF        DHNDCP = '3'
105100130604     C                   EVAL      N1DI = 'Y'
105200130604     C                   ELSE
105300130604     C                   EVAL      N1DI = 'N'
105400130604     C                   ENDIF
105500130604    ***
105600130604     C                   IF        DSTUDN = 'Y'
105700130604     C                   EVAL      N1STDI = 'Y'
105800130604     C                   ENDIF
105900130604    ***
106000130604     C                   MOVE      EMPDT         #XSX
106100130604     C                   EXSR      $ISOUSA
106200130604     C                   MOVE      #XSX          N1HIRE
106300130604    ***
106400130604     C                   IF        EMPST = 'C'
106500130604     C                   EVAL      N1SI = 'C'
106600130604     C                   ELSE
106700130604     C                   EVAL      N1SI = 'A'
106800130604     C                   ENDIF
106900130604    ***
107000130604     C                   ENDSR
107100130604   S***S
107200130604     C     $CHKHEM       BEGSR
107300130604    ***
107400130604     C                   IF        MED#CNE > 0 AND MED@TRM(MED#CNE) <> 99999999
107500130604     C                   EXSR      $CHKMED
107600130604     C                   ENDIF
107700130604    ***
107800130604     C                   IF        DEN#CNE > 0 AND DEN@TRM(DEN#CNE) <> 99999999
107900130604     C                   EXSR      $CHKDEN
108000130604     C                   ENDIF
108100130604    ***
108200130604     C                   ENDSR
108300130604   S***S
108400130604      * CHECK FOR MEDICAL TERMINATION
108500130604    *C     $CHKMED       BEGSR
108600130604    ***
108700130604    *C                   EVAL      TERM_MED = YES
108800130604    *C                   EVAL      KF@TRM = MED@TRM(MED#CNE)
108900130604    *C                   EVAL      KF@PLN = MED@PLN(MED#CNE)
109000130604    *C                   EVAL      KF@ENR = MED@ENR(MED#CNE)
109100130604    ***
109200130604    *C     KL#MTR        CHAIN     NASTERMR
109300130604    *C                   IF        %FOUND(NASTERMP)
109400130604    *C                   EVAL      MED#CNE = 0
109500130604    *C                   EVAL      TERM_MED = NO
109600130604     C                   LEAVESR
109700130604     C                   ENDIF
109800130604    ***
109900130604     C                   EXSR      $WRTERM
110000130604    ***
110100130604    *C                   ENDSR
110200130604   S***S
110300130604    *C     $WRTERM       BEGSR
110400130604    ***
110500130604    *C                   CLEAR                   NASTERMR
110600130604     C                   EVAL      NTSSNO         = KF@SSN
110700130604     C                   EVAL      NTDEPNO        = KF@SEQ
110800130604     C                   EVAL      NTTERMDT       = KF@TRM
110900130604     C                   EVAL      NTPLAN         = KF@PLN
111000130604     C                   EVAL      NTCOVTP        = KF@ENR
111100130604     C                   EVAL      NTTRST         = KF@TRS
111200130604     C                   EVAL      NTSUB#         = KF@SUB
111300130604     C                   EVAL      NTACCT         = KF@ACC
111400130604     C                   EVAL      NTTRANSDT      = #TODAY
111500130604     C                   WRITE     NASTERMR
111600130604    ***
111700130604    *C                   ENDSR
111800130604   S***S
111900130604      * CHECK FOR DENTAL TERMINATION
112000130604    *C     $CHKDEN       BEGSR
112100130604    ***
112200130604    *C                   EVAL      TERM_DEN = YES
112300130604    *C                   EVAL      KF@TRM = DEN@TRM(DEN#CNE)
112400130604    *C                   EVAL      KF@PLN = DEN@PLN(DEN#CNE)
112500130604    *C                   EVAL      KF@ENR = DEN@ENR(DEN#CNE)
112600130604    ***
112700130604    *C     KL#MTR        CHAIN     NASTERMR
112800130604    *C                   IF        %FOUND(NASTERMP)
112900130604    *C                   EVAL      DEN#CNE = 0
113000130604    *C                   EVAL      TERM_DEN = NO
113100130604     C                   LEAVESR
113200130604     C                   ENDIF
113300130604    ***
113400130604     C                   EXSR      $WRTERM
113500130604    ***
113600130604    *C                   ENDSR
113700130531   S***S
113800130531     C     *INZSR        BEGSR
113900130531    ***
114000130531     C                   EVAL      #RECCNT = 0
114100130531    ***
114200130531     C     KL#ACCTL      KLIST
114300130531     C                   KFLD                    CARR#CTL
114400130531     C                   KFLD                    KF@TRS
114500130531     C                   KFLD                    KF@SUB
114600130531     C                   KFLD                    KF@ACC
114700130603    ***
114800130812     C     KL#SSA        KLIST
114900130812     C                   KFLD                    KF@ATYP
115000130812     C                   KFLD                    KF@MEM
115100130812    ***
115200130812     C     KL#NAS        KLIST
115300130812     C                   KFLD                    KF@ATYP
115400130812     C                   KFLD                    KF@ALID
115500130812    ***
115600130603     C     KL#PCP        KLIST
115700130603     C                   KFLD                    KF@SSN
115800130603     C                   KFLD                    KF@SEQ
115900130603     C                   KFLD                    KF@SPCD
116000130531    ***
116100130531     C     KL#AUX        KLIST
116200130531     C                   KFLD                    KF@TRS
116300130531     C                   KFLD                    KF@SUB
116400130531     C                   KFLD                    KF@ACC
116500130531     C                   KFLD                    KF@SSN
116600130531     C                   KFLD                    KF@SEQ
116700130531    ***
116800130531     C     KL#TSA        KLIST
116900130531     C                   KFLD                    KF@TRS
117000130531     C                   KFLD                    KF@SUB
117100130531     C                   KFLD                    KF@ACC
117200130531    ***
117300130531     C     KL#MPLN       KLIST
117400130531     C                   KFLD                    KF@SSN
117500130531     C                   KFLD                    KF@SEQ
117600130531     C                   KFLD                    KF@TRS
117700130531     C                   KFLD                    KF@SUB
117800130531     C                   KFLD                    KF@ACC
117900130531    ***
118000130531     C     KL#CPLN       KLIST
118100130531     C                   KFLD                    CARR#CTL
118200130531     C                   KFLD                    KF@TRS
118300130531     C                   KFLD                    KF@SUB
118400130531     C                   KFLD                    KF@ACC
118500130531     C                   KFLD                    KF@CCTR
118600130531     C                   KFLD                    KF@PLN
118700130531    ***
118800130531     C     KL#DCV        KLIST
118900130531     C                   KFLD                    KF@SSN
119000130531     C                   KFLD                    KF@SEQ
119100130604     C                   KFLD                    KF@TRS
119200130604     C                   KFLD                    KF@SUB
119300130604     C                   KFLD                    KF@ACC
119400130531    ***
119500130531     C     KL#MTR        KLIST
119600130531     C                   KFLD                    KF@SSN
119700130531     C                   KFLD                    KF@SEQ
119800130531     C                   KFLD                    KF@TRM
119900130531     C                   KFLD                    KF@PLN
120000130531     C                   KFLD                    KF@ENR
120100130531     C                   KFLD                    KF@TRS
120200130531     C                   KFLD                    KF@SUB
120300130531     C                   KFLD                    KF@ACC
120400130604    ***
120500130604     C                   ENDSR
120600130604   S***S
120700130604     C     $ISOUSA       BEGSR
120800130604    ***
120900130604     C                   MOVE      #XSX          @XSX              8
121000130604     C                   EVAL      @XSX = %SUBST(@XSX:5:4) + %SUBST(@XSX:1:4)
121100130604     C                   MOVE      @XSX          #XSX
121200130531    ***
121300130531     C                   ENDSR
121400130531   S***S
121500130531     C     $CLRSTG       BEGSR
121600130531    ***
121700130531     C                   EVAL      #CANCEL = 0
121800130531    ***
121900130531     C                   EVAL                    MED#CNE = 0
122000130531     C                   EVAL                    MED#NDX = 0
122100130531     C                   CLEAR                   MED@PLN
122200130531     C                   CLEAR                   MED@ENR
122300130531     C                   CLEAR                   MED@FRM
122400130531     C                   CLEAR                   MED@TRM
122500130531    ***
122600130531     C                   EVAL                    DEN#CNE = 0
122700130531     C                   EVAL                    DEN#NDX = 0
122800130531     C                   CLEAR                   DEN@PLN
122900130531     C                   CLEAR                   DEN@ENR
123000130531     C                   CLEAR                   DEN@FRM
123100130531     C                   CLEAR                   DEN@TRM
123200130531    ***
123300130531     C                   ENDSR
123400130531   S***S
