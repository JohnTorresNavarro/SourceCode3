000100090819     FRP560WF   IF   E             DISK
000200090817     FMCOV14    IF   E           K DISK
000300090818     FMCOV      IF   E           K DISK    RENAME(MCOVR:MCVF)
000400090817     FMEMAC#1   IF   E           K DISK
000500090817     FDCOV22    IF   E           K DISK
000600090817     FDEPNDC    IF   E           K DISK
000700090814     FOEPLAN    IF   E           K DISK    PREFIX(Z:1)
000800090817     FCODES     IF   E           K DISK
000900090814     FPLNMST    IF   E           K DISK
001000090819     FRP561WF   O  A F 2000        DISK
001100090819     FRP562WF   O  A F 2000        DISK
001200090814   X***X
001300090814     D @XA             S           2000A
001400090814     D @XB             S           2000A
001500090827     D @DOB            S             15A
001600090814     D #ISO            S               D   DATFMT(*ISO)
001700090814     D #XSX            S              8S 0
001800090814     D #TDAY           S              8S 0
001900090817     D @ANAME          S             60A
002000090814     D @@MTH           S             20A   DIM(12) CTDATA PERRCD(1)
002100090814     D @MTHNAME        S             20A
002200090814     D @DTXT           S             25A
002300090814     D #MTH            S              2S 0
002400090814     D #YR             S              4S 0
002500090814     D DS@OEP        E DS                  EXTNAME(OEPLAN) OCCURS(80)
002600090814     D PL#CNT          S              5S 0 DIM(80)
002700090817     D PL#TOT          S              5S 0 DIM(80)
002800090817     D CNT#SUM         S              9S 0
002900090817     D TOT#SUM         S              9S 0
003000090814     D #N              S              3S 0
003100090814     D #C              S              3S 0
003200090817     D @15             S             15A
003300090817     D QQ              C                   CONST('","')
003400090814     D KF@TYPE         S              1A   INZ('P')
003500090814     D CAT@            S              3A   DIM(20)
003600090814     D CAT#N           S              3S 0
003700090814     D CAT#C           S              3S 0
003800090814     D @STEP           S              6A
003900090817     D KF@TY           S              1A
004000090817     D KF@CO           S              2A
004100090814     D KF@T            S              3S 0
004200090814     D KF@S            S              3S 0
004300090814     D KF@A            S              4S 0
004400090814     D KF@P            S              4A
004500090817     D KF@SS           S                   LIKE(MBSSNO)
004600090814   X***X
004700090817     C                   EVAL      @STEP = 'PREP01'
004800090814     C                   DOU       @STEP = 'LEAVE '
004900090817     C     @STEP         CASEQ     'PREP01'      $PREP01
005000090817     C     @STEP         CASEQ     'STEP01'      $STEP01
005100090817     C     @STEP         CASEQ     'STEP02'      $STEP02
005200090817     C     @STEP         CASEQ     'STEP03'      $STEP03
005300090817     C     @STEP         CASEQ     'STEP04'      $STEP04
005400090817     C     @STEP         CASEQ     'STEP05'      $STEP05
005500090817     C     @STEP         CASEQ     'STEP06'      $STEP06
005600090817     C     @STEP         CASEQ     'STEP07'      $STEP07
005700090817     C     @STEP         CASEQ     'STEP08'      $STEP08
005800090817     C     @STEP         CASEQ     'STEP09'      $STEP09
005900090817     C     @STEP         CASEQ     'STEP10'      $STEP10
006000090817     C     @STEP         CASEQ     'STEP11'      $STEP11
006100090817     C     @STEP         CASEQ     'STEP12'      $STEP12
006200090814     C                   ENDCS
006300090818     C                   ENDDO
006400090814    ***
006500090814     C                   EVAL      *INLR = *ON
006600090814    ***
006700090814   S***S
006800090814     C     *INZSR        BEGSR
006900090814    ***
007000090814     C     KL#MBR        KLIST
007100090814     C                   KFLD                    KF@T
007200090814     C                   KFLD                    KF@S
007300090814     C                   KFLD                    KF@A
007400090814    ***
007500090814     C     KL#PLN        KLIST
007600090814     C                   KFLD                    KF@T
007700090814     C                   KFLD                    KF@S
007800090814     C                   KFLD                    KF@P
007900090814    ***
008000090817     C     KL#DCV        KLIST
008100090817     C                   KFLD                    KF@T
008200090817     C                   KFLD                    KF@S
008300090817     C                   KFLD                    KF@P
008400090817     C                   KFLD                    KF@SS
008500090817    ***
008600090817     C     KL#CDE        KLIST
008700090817     C                   KFLD                    KF@TY
008800090817     C                   KFLD                    KF@CO
008900090817    ***
009000090817     C     KL#DEP        KLIST
009100090817     C                   KFLD                    KF@SS
009200090817     C                   KFLD                    DSEQ#
009300090817    ***
009400090817     C                   EVAL      #ISO = %DATE
009500090817     C                   MOVE      #ISO          #TDAY
009600090817    ***
009700090814     C                   ENDSR
009800090817   S***S
009900090817     C     $STEP01       BEGSR
010000090817    ***
010100090817     C                   EVAL      CAT#C = 0
010200090817     C     KF@TYPE       SETLL     CODESR
010300090817     C                   DOU       %EOF(CODES)
010400090817     C     KF@TYPE       READE     CODESR
010500090817     C                   IF        NOT %EOF(CODES) AND
010600090819     C                             ACTION = 'M' AND
010700090819     C                             CODE <> 'XM'
010800090817     C                   ADD       1             CAT#C
010900090817     C                   EVAL      CAT@(CAT#C) = TYPE + CODE
011000090817     C                   ENDIF
011100090817     C                   ENDDO
011200090817    ***
011300090817     C                   EVAL      @STEP = 'STEP02'
011400090817    ***
011500090817     C                   ENDSR
011600090814   S***S
011700090817     C     $STEP02       BEGSR
011800090814    ***
011900090814     C                   READ      RPDF
012000090814    ***
012100090819     C                   IF        %EOF(RP560WF)
012200090817     C                   EVAL      @STEP = 'STEP06'
012300090814     C                   LEAVESR
012400090814     C                   ENDIF
012500090814    ***
012600090814     C                   EVAL      KF@T = RDTRST
012700090814     C                   EVAL      KF@S = RDSUB#
012800090814     C                   EVAL      KF@A = RDACCT
012900090814    ***
013000090817     C                   EVAL      @STEP = 'STEP03'
013100090817    ***
013200090817     C     KL#MBR        SETLL     MCOVR
013300090817    ***
013400090817     C                   ENDSR
013500090817   S***S
013600090817     C     $STEP03       BEGSR
013700090817    ***
013800090817     C     KL#MBR        READE     MCOVR
013900090817    ***
014000090818     C                   IF        %EOF(MCOV14)
014100090817     C                   EVAL      @STEP = 'STEP02'
014200090817     C                   LEAVESR
014300090817     C                   ENDIF
014400090817    ***
014500090817     C                   IF        ENRLDT = CANDT
014600090817     C                   LEAVESR
014700090817     C                   ENDIF
014800090817    ***
014900090817     C                   IF        MCPLAN <> KF@P
015000090817     C                   EVAL      KF@P = MCPLAN
015100090817     C                   EVAL      @STEP = 'STEP04'
015200090817     C                   ENDIF
015300090817    ***
015400090817     C                   ENDSR
015500090817   S***S
015600090817     C     $STEP04       BEGSR
015700090817    ***
015800090817     C     KL#PLN        CHAIN     PLNMSR
015900090817     C                   IF        NOT %FOUND(PLNMST)
016000090817     C                   EVAL      @STEP = 'STEP03'
016100090817     C                   LEAVESR
016200090817     C                   ENDIF
016300090817    ***
016400090817     C                   EVAL      CAT#N = 0
016500090817     C                   DO        CAT#C
016600090817     C                   ADD       1             CAT#N
016700090817     C                   IF        CAT@(CAT#N) = PLNCAT
016800090817     C                   EVAL      @STEP = 'STEP05'
016900090817     C                   LEAVESR
017000090817     C                   ENDIF
017100090818     C                   ENDDO
017200090817    ***
017300090817     C                   EVAL      @STEP = 'STEP03'
017400090817    ***
017500090817     C                   ENDSR
017600090817   S***S
017700090817     C     $STEP05       BEGSR
017800090817    ***
017900090817     C                   IF        #C = 0
018000090818     C                   EXSR      $ADDENT
018100090818     C                   EVAL      @STEP = 'STEP03'
018200090817     C                   LEAVESR
018300090817     C                   ENDIF
018400090817    ***
018500090817     C                   EVAL      #N = 0
018600090817    ***
018700090817     C                   DO        #C
018800090817     C                   ADD       1             #N
018900090817     C     #N            OCCUR     DS@OEP
019000090817     C                   IF        OTRST = KF@T AND
019100090817     C                             OSUB# = KF@S AND
019200090817     C                             OPLAN = KF@P
019300090817     C                   EVAL      @STEP = 'STEP03'
019400090817     C                   LEAVESR
019500090817     C                   ENDIF
019600090817     C                   ENDDO
019700090817    ***
019800090817     C                   EVAL      @STEP = 'STEP03'
019900090817    ***
020000090818     C                   EXSR      $ADDENT
020100090818    ***
020200090818     C                   ENDSR
020300090818   S***S
020400090818     C     $ADDENT       BEGSR
020500090818    ***
020600090818     C                   ADD       1             #C
020700090818     C     #C            OCCUR     DS@OEP
020800090818    ***
020900090818     C                   EVAL      OTRST = KF@T
021000090818     C                   EVAL      OSUB# = KF@S
021100090818     C                   EVAL      OPLAN = KF@P
021200090818     C
021300090818     C     KL#PLN        CHAIN     OEPLANR
021400090818     C                   IF        %FOUND(OEPLAN) AND ZDESC <> *BLANKS
021500090818     C                   EVAL      ODESC = ZDESC
021600090818     C                   LEAVESR
021700090818     C                   ENDIF
021800090818    ***
021900090818     C                   IF        %FOUND(PLNMST) AND PDESCR <> *BLANKS
022000090818     C                   MOVEL(P)  PDESCR        ODESC
022100090818     C                   LEAVESR
022200090818     C                   ENDIF
022300090818    ***
022400090818     C                   MOVEL(P)  '**UNKNOWN'   ODESC
022500090817    ***
022600090817     C                   ENDSR
022700090817   S***S
022800090818     C     $STEP06       BEGSR
022900090817    ***
023000090817     C                   EXSR      $HEAD
023100090817    ***
023200090817     C     1             SETLL     RPDF
023300090817     C                   EVAL      @STEP = 'STEP07'
023400090817     C                   EVAL      KF@T = 0
023500090817    ***
023600090817     C                   ENDSR
023700090817   S***S
023800090817     C     $STEP07       BEGSR
023900090817    ***
024000090817     C                   IF        KF@T <> 0
024100090817     C                   EVAL      @STEP = 'STEP12'
024200090817     C                   LEAVESR
024300090817     C                   ENDIF
024400090817    ***
024500090817     C                   READ      RPDF
024600090817    ***
024700090819     C                   IF        %EOF(RP560WF)
024800090818     C                   EXSR      $TOTAL
024900090817     C                   EVAL      @STEP = 'LEAVE '
025000090817     C                   LEAVESR
025100090817     C                   ENDIF
025200090817    ***
025300090817     C                   EVAL      KF@T = RDTRST
025400090817     C                   EVAL      KF@S = RDSUB#
025500090817     C                   EVAL      KF@A = RDACCT
025600090817    ***
025700090817     C                   EVAL      @STEP = 'STEP08'
025800090817     C     KL#MBR        SETLL     MEMBR
025900090817    ***
026000090817     C                   ENDSR
026100090817   S***S
026200090817     C     $STEP08       BEGSR
026300090814    ***
026400090817     C     KL#MBR        READE     MEMBR
026500090817    ***
026600090818     C                   IF        %EOF(MEMAC#1)
026700090817     C                   EVAL      @STEP = 'STEP07'
026800090817     C                   LEAVESR
026900090817     C                   ENDIF
027000090817    ***
027100090817     C                   IF        TERMDT < #TDAY AND
027200090817     C                             TERMDT > 0
027300090817     C                   LEAVESR
027400090817     C                   ENDIF
027500090817    ***
027600090817     C                   EVAL      KF@SS = MBSSNO
027700090817    ***
027800090818     C                   EVAL      @STEP = 'STEP09'
027900090818     C     KF@SS         SETLL     MCVF
028000090817    ***
028100090817     C                   ENDSR
028200090817   S***S
028300090817     C     $STEP09       BEGSR
028400090817    ***
028500090818     C     KF@SS         READE     MCVF
028600090817    ***
028700090817     C                   IF        %EOF(MCOV)
028800090817     C                   EVAL      @STEP = 'STEP08'
028900090817     C                   LEAVESR
029000090817     C                   ENDIF
029100090817    ***
029200090817     C                   IF        ENRLDT = CANDT OR
029300090817     C                             (CANDT < #TDAY AND
029400090817     C                             CANDT > 0)
029500090817     C                   LEAVESR
029600090817     C                   ENDIF
029700090814    ***
029800090817     C                   EVAL      KF@P = MCPLAN
029900090817    ***
030000090817     C                   EVAL      @STEP = 'STEP10'
030100090814    ***
030200090814     C                   ENDSR
030300090814   S***S
030400090817     C     $STEP10       BEGSR
030500090814    ***
030600090814     C                   EVAL      #N = 0
030700090817     C                   DO        #C
030800090817     C                   ADD       1             #N
030900090817     C     #N            OCCUR     DS@OEP
031000090817     C                   IF        OTRST = KF@T AND
031100090817     C                             OSUB# = KF@S AND
031200090817     C                             OPLAN = KF@P
031300090817     C                   EVAL      @STEP = 'STEP11'
031400090818     C                   LEAVESR
031500090818     C                   ENDIF
031600090817     C                   ENDDO
031700090814    ***
031800090817     C                   EVAL      @STEP = 'STEP09'
031900090817    ***
032000090817     C                   ENDSR
032100090817   S***S
032200090817     C     $STEP11       BEGSR
032300090817    ***
032400090817     C                   ADD       1             PL#CNT(#N)
032500090817     C                   ADD       1             PL#TOT(#N)
032600090817    ***
032700090817     C                   EXSR      $DUMP
032800090817    ***
032900090817     C                   EVAL      @STEP = 'STEP08'
033000090817    ***
033100090817     C                   ENDSR
033200090817   S***S
033300090817     C     $STEP12       BEGSR
033400090817    ***
033500090817     C                   EVAL      @STEP = 'STEP07'
033600090817    ***
033700090818     C                   EVAL      @ANAME = RDNAME
033800090817    ***
033900090817     C                   XFOOT     PL#CNT        #SUM              9 0
034000090817     C                   EVAL      @15 = %EDITC(#SUM:'J')
034100090817    * *
034200090817     C                   EVAL      @XA = '"' + %TRIM(@ANAME) + '",' +
034300090817     C                             '"' + %TRIM(@15) + '",'
034400090817    * *
034500090817     C                   EVAL      #N = 0
034600090817    * *
034700090817     C                   DO        #C
034800090817
034900090817     C                   ADD       1             #N
035000090817
035100090817     C                   EVAL      #SUM = PL#CNT(#N)
035200090817     C                   EVAL      @15 = %EDITC(#SUM:'J')
035300090817
035400090817     C                   EVAL      @XA = %TRIM(@XA) +
035500090817     C                             '"' + %TRIM(@15) + '",'
035600090817
035700090817     C                   ENDDO
035800090817    * *
035900090817     C                   EXCEPT    OUTFA
036000090817    ***
036100090817     C                   EVAL      KF@T = 0
036200090817     C                   CLEAR                   PL#CNT
036300090817    ***
036400090817     C                   ENDSR
036500090817   S***S
036600090817     C     $TOTAL        BEGSR
036700090817    ***
036800090817     C                   XFOOT     PL#TOT        #SUM              9 0
036900090817     C                   EVAL      @15 = %EDITC(#SUM:'J')
037000090817    * *
037100090817     C                   EVAL      @XA = '"TOTAL..............",' +
037200090817     C                             '"' + %TRIM(@15) + '",'
037300090817    * *
037400090817     C                   EVAL      #N = 0
037500090817    * *
037600090817     C                   DO        #C
037700090817     C                   ADD       1             #N
037800090817     C                   EVAL      #SUM = PL#TOT(#N)
037900090817     C                   EVAL      @15 = %EDITC(#SUM:'J')
038000090817     C                   EVAL      @XA = %TRIM(@XA) +
038100090817     C                             '"' + %TRIM(@15) + '",'
038200090817     C                   ENDDO
038300090817    * *
038400090817     C                   EXCEPT    OUTFA
038500090814    ***
038600090814     C                   ENDSR
038700090814   S***S
038800090817     C     $HEAD         BEGSR
038900090814    ***
039000090814     C                   EVAL      #MTH = %SUBDT(#ISO:*M)
039100090814     C                   EVAL      #YR = %SUBDT(#ISO:*Y)
039200090814     C                   EVAL      @MTHNAME = @@MTH(#MTH)
039300090814     C                   EVAL      @DTXT = %TRIM(@MTHNAME) + ' ' + %CHAR(#YR)
039400090814    ***
039500090818     C                   EVAL      @XA = '"SUMMARY FOR : ' +
039600090818     C                             %TRIM(@DTXT) + '"'
039700090814     C                   EXCEPT    OUTFA
039800090814    ***
039900090814     C                   EVAL      @XA = ','
040000090814     C                   EXCEPT    OUTFA
040100090814    ***
040200090814     C                   EVAL      @XA = ','
040300090814     C                   EXCEPT    OUTFA
040400090814    ***
040500090817     C                   EVAL      @XA = '"ACCOUNT NAME","TOTAL",'
040600090817     C                   EVAL      #N = 0
040700090817     C                   DO        #C
040800090817     C                   ADD       1             #N
040900090817     C     #N            OCCUR     DS@OEP
041000090817     C                   EVAL      @XA = %TRIM(@XA) + '"' +
041100090817     C                             %TRIM(ODESC) + '",'
041200090817     C                   ENDDO
041300090814     C                   EXCEPT    OUTFA
041400090814    ***
041500090814     C                   ENDSR
041600090814   S***S
041700090817     C     $PREP01       BEGSR
041800090814    ***
041900090818     C                   EVAL      #MTH = %SUBDT(#ISO:*M)
042000090818     C                   EVAL      #YR = %SUBDT(#ISO:*Y)
042100090818     C                   EVAL      @MTHNAME = @@MTH(#MTH)
042200090818     C                   EVAL      @DTXT = %TRIM(@MTHNAME) + ' ' + %CHAR(#YR)
042300090818    ***
042400090817     C                   EVAL      @XB = '"MEMBERSHIP BY ACCOUNT FOR : ' +
042500090818     C                             %TRIM(@DTXT) + '"'
042600090817     C                   EXCEPT    OUTFB
042700090817    ***
042800090817     C                   EVAL      @XB = ','
042900090817     C                   EXCEPT    OUTFB
043000090817    ***
043100090817     C                   EVAL      @XB = ','
043200090817     C                   EXCEPT    OUTFB
043300090817    ***
043400090818     C                   EVAL      @XB = '"ACCOUNT NAME","PLAN","MBR LAST NA' +
043500090827     C                             'ME","MBR FIRST NAME","MBR MID INIT",' +
043600090827     C                             '"MBR DOB","EFF ' +
043700090817     C                             'MTH","EFF YR","ENROLL LEVEL","SPOUSE LAST' +
043800090827     C                             ' NAME","SPOUSE FIRST NAME","SPOUSE MI"'
043900090827     C                             + ',"SPOUSE DOB",' +
044000090817     C                             '"DEP LAST NAME","DEP FIRST NAME","DEP MI"'
044100090827     C                             + ',"DEP DOB",' +
044200090817     C                             '"DEP LAST NAME","DEP FIRST NAME","DEP MI"'
044300090827     C                             + ',"DEP DOB",' +
044400090817     C                             '"DEP LAST NAME","DEP FIRST NAME","DEP MI"'
044500090827     C                             + ',"DEP DOB",' +
044600090817     C                             '"DEP LAST NAME","DEP FIRST NAME","DEP MI"'
044700090827     C                             + ',"DEP DOB",' +
044800090817     C                             '"DEP LAST NAME","DEP FIRST NAME","DEP MI"'
044900090827     C                             + ',"DEP DOB",' +
045000090817     C                             '"DEP LAST NAME","DEP FIRST NAME","DEP MI"'
045100090827     C                             + ',"DEP DOB"'
045200090817     C                   EXCEPT    OUTFB
045300090817    ***
045400090817     C                   EVAL      @STEP = 'STEP01'
045500090814    ***
045600090814     C                   ENDSR
045700090814   S***S
045800090817     C     $DUMP         BEGSR
045900090814    ***
046000090818     C                   EVAL      @ANAME = RDNAME
046100090817    ***
046200090827     C                   IF        BIRTH = 0
046300090827     C                   EVAL      @DOB = '"**N/A**"'
046400090827     C                   ELSE
046500090827     C     BIRTH         MULT      10000.0001    #XSX
046600090827     C                   EVAL      @DOB = %EDITC(#XSX:'Y')
046700090827     C                   ENDIF
046800090817    ***
046900090827     C                   EVAL      @XB = '"' + %TRIM(@ANAME) + QQ +
047000090827     C                             %TRIM(ODESC) + QQ + %TRIM(MLNAME) + QQ +
047100090827     C                             %TRIM(MFNAME) + QQ + %TRIM(MMI) + '",'
047200090827     C                             + %TRIM(@DOB) + ',"'
047300090827    ***
047400090817     C                   MOVE      ENRLDT        #ISO
047500090817     C                   EXTRCT    #ISO:*M       #MTH              2 0
047600090817     C                   EXTRCT    #ISO:*Y       #YEAR             4 0
047700090817     C                   EVAL      @XB = %TRIM(@XB) +
047800090817     C                             %EDITC(#MTH:'X') + QQ +
047900090817     C                             %EDITC(#YEAR:'X') + '",'
048000090817    ***
048100090817     C                   EVAL      KF@TY = %SUBST(MCOVTP:1:1)
048200090817     C                   EVAL      KF@CO = %SUBST(MCOVTP:2:2)
048300090817     C     KL#CDE        CHAIN     CODESR
048400090817     C                   EVAL      @XB = %TRIM(@XB) + '"' +
048500090817     C                             %TRIM(SDESCR) + '",'
048600090817    ***
048700090817     C                   EXSR      $DEPS
048800090817     C                   IF        @SF = 'N'
048900090827     C                   EVAL      @XB = %TRIM(@XB) + ',,,,'
049000090817     C                   ENDIF
049100090817    ***
049200090817     C                   EXSR      $DEPC
049300090818    ***
049400090818     C                   EXCEPT    OUTFB
049500090814    ***
049600090814     C                   ENDSR
049700090814   S***S
049800090817     C     $DEPS         BEGSR
049900090817    ***
050000090817     C                   MOVE      'N'           @SF               1
050100090817    ***
050200090817     C     KL#DCV        CHAIN     DCOVR
050300090817     C                   IF        NOT %FOUND(DCOV22)
050400090817     C                   LEAVESR
050500090817     C                   ENDIF
050600090814    ***
050700090817     C     KL#DCV        SETLL     DCOVR
050800090817     C                   DOU       %EOF(DCOV22)
050900090817     C     KL#DCV        READE     DCOVR
051000090817     C                   IF        NOT %EOF(DCOV22) AND
051100090817     C                             DENRDT <> CCANDT AND
051200090817     C                             (CCANDT = 0 OR
051300090817     C                             CCANDT > #TDAY)
051400090817      *
051500090817     C     KL#DEP        CHAIN     DEPENR
051600090817     C                   IF        %FOUND(DEPNDC) AND (DRELCD = 'RHU'
051700090817     C                             OR DRELCD = 'RWI')
051800090817     C                   MOVE      'Y'           @SF
051900090827     C                   IF        DBIRTH = 0
052000090827     C                   EVAL      @DOB = '"**N/A**"'
052100090827     C                   ELSE
052200090827     C     DBIRTH        MULT      10000.0001    #XSX
052300090827     C                   EVAL      @DOB = %EDITC(#XSX:'Y')
052400090827     C                   ENDIF
052500090817     C                   EVAL      @XB = %TRIM(@XB) + '"' +
052600090817     C                             %TRIM(DLNAME) + QQ +
052700090817     C                             %TRIM(DFNAME) + QQ + %TRIM(DMI) + '",'
052800090827     C                             + %TRIM(@DOB) + ','
052900090817     C                   LEAVESR
053000090817     C                   ENDIF
053100090817      *
053200090817     C                   ENDIF
053300090817     C                   ENDDO
053400090814    ***
053500090814     C                   ENDSR
053600090814   S***S
053700090817     C     $DEPC         BEGSR
053800090817    ***
053900090817     C     KL#DCV        CHAIN     DCOVR
054000090817     C                   IF        NOT %FOUND(DCOV22)
054100090817     C                   LEAVESR
054200090817     C                   ENDIF
054300090817    ***
054400090817     C     KL#DCV        SETLL     DCOVR
054500090817     C                   DOU       %EOF(DCOV22)
054600090817     C     KL#DCV        READE     DCOVR
054700090817     C                   IF        NOT %EOF(DCOV22) AND
054800090817     C                             DENRDT <> CCANDT AND
054900090817     C                             (CCANDT = 0 OR
055000090817     C                             CCANDT > #TDAY)
055100090817      *
055200090817     C     KL#DEP        CHAIN     DEPENR
055300090817     C                   IF        %FOUND(DEPNDC) AND DRELCD <> 'RHU'
055400090817     C                             AND DRELCD <> 'RWI'
055500090827     C                   IF        DBIRTH = 0
055600090827     C                   EVAL      @DOB = '"**N/A**"'
055700090827     C                   ELSE
055800090827     C     DBIRTH        MULT      10000.0001    #XSX
055900090827     C                   EVAL      @DOB = %EDITC(#XSX:'Y')
056000090827     C                   ENDIF
056100090817     C                   EVAL      @XB = %TRIM(@XB) + '"' +
056200090817     C                             %TRIM(DLNAME) + QQ +
056300090817     C                             %TRIM(DFNAME) + QQ + %TRIM(DMI) + '",'
056400090827     C                             + %TRIM(@DOB) + ','
056500090817     C                   ENDIF
056600090817      *
056700090817     C                   ENDIF
056800090817     C                   ENDDO
056900090817    ***
057000090817     C                   ENDSR
057100090817   S***S
057200090819     ORP561WF   EADD         OUTFA
057300090814     O                       @XA            B  2000
057400090819     ORP562WF   EADD         OUTFB
057500090814     O                       @XB            B  2000
057600090814   X***X
057700090814** @@MTH
057800090814JANUARY
057900090814FEBRUARY
058000090814MARCH
058100090814APRIL
058200090814MAY
058300090814JUNE
058400090814JULY
058500090814AUGUST
058600090814SEPTEMBER
058700090814OCTOBER
058800090814NOVEMBER
058900090814DECEMBER
