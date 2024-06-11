000101191204      *================================================================
000102191204     H option(*noDebugIo)
000200120229     *** AUDIT OF MEMBERSHIP BY ACCOUNT SET UP WITH AETNA
000300120229     *** SSK 2/29/2012
000400130123     ***
000500130123     *** 01/23/2013 SSK ADD STIERSTS TO AUDIT REPORT
000600130123     ***
000700130403     *** 04/03/2013 SSK ADD SEPARATE COLUMN FOR AA TO AUDIT REPORT
000701191204     *** 12/04/2019 jt  Added plan description
000702191204      *================================================================
000800191204
000900121129     FAET001WF  IPE  E           K DISK
001000121130     FCARPLNQ   IF   E           K DISK
001100120229     FMCOVAPSE  IF   E           K DISK
001200120229     FMEMBER    IF   E           K DISK
001300121016     FACMUNIQUE IF   E           K DISK
001400121016     FCARRSCANAAIF   E           K DISK
001500121130     FPLNUNIQUE IF   E           K DISK
001600120229     FT2000     O  A F 2000        DISK
001700121130     FT500      O  A F  500        DISK
001701191204      *================================================================
001900120229     D KF@T            S                   LIKE(MBTRST)
002000120229     D KF@S            S                   LIKE(MBSUB#)
002100120229     D KF@A            S                   LIKE(MBACCT)
002200120229     D KF@P            S                   LIKE(MCPLAN)
002201191204     d K@desc          S                   LIKE(MCPLAN)
002300120229     D @NAME           S             60A
002400121016     D HDG@            S             90A
002500120229     D S50@            S            100A
002600121129     D S50H            S            100A
002700120229     D X               S              3S 0
002800121130     D @T5             S            500A
002900120229     D @T              S           2000A
003000121129     D CARR#CTL        S             10A   INZ('0000000011')
003100120229   X***X
003200121129     C     KL#UTSPA      KLIST
003300121129     C                   KFLD                    CARR#CTL
003400121129     C                   KFLD                    KF@T
003500121129     C                   KFLD                    KF@S
003600121129     C                   KFLD                    KF@P
003700121129     C                   KFLD                    KF@A
003800121130    ***
003900121130     C     KL#TSP        KLIST
004000121130     C                   KFLD                    KF@T
004100121130     C                   KFLD                    KF@S
004200121130     C                   KFLD                    KF@P
004300121129    ***
004400120229     C     KL#TSAP       KLIST
004500120229     C                   KFLD                    KF@T
004600120229     C                   KFLD                    KF@S
004700120229     C                   KFLD                    KF@A
004800120229     C                   KFLD                    KF@P
004900121016    ***
005000121016     C     KL#TSA        KLIST
005100121016     C                   KFLD                    KF@T
005200121016     C                   KFLD                    KF@S
005300121016     C                   KFLD                    KF@A
005400120229   X***X
005500121129     C                   IF        AE1MAP = 'STATETIER' OR AE1MAP = 'STSTATE' OR
005600130123     C                             AE1MAP = 'JUSTSTATE' OR AE1MAP = 'STIERSTS'
005700121129     C                   EVAL      KF@T = AE1TRS
005800121129     C                   EVAL      KF@S = AE1SUB
005900121129     C                   EVAL      KF@A = AE1ACC
006000121129     C                   EVAL      KF@P = AE1PLN
006100121129     C                   EXSR      $A
006200121129     C                   ENDIF
006300120229    ***
006400121130     CLR                 EXSR      $LRTN
006500121129   S***S
006600121129     C     $A            BEGSR
006700121129    ***
006800121129     C                   MOVE      *ZEROS        CNT               3 0
006900121129     C                   MOVE      *ZEROS        NDX               3 0
007000121130     C                   EVAL      S50H = *BLANKS
007100121129    ***
007200121129     C     KL#UTSPA      SETLL     CARPLNR
007300121129     C                   DOU       %EOF(CARPLNQ)
007400121129     C     KL#UTSPA      READE     CARPLNR
007500121129     C                   IF        NOT %EOF(CARPLNQ)
007600121129    ***
007700130123     C                   IF        AE1MAP = 'STATETIER' OR AE1MAP = 'STSTATE' OR
007800130123     C                             AE1MAP = 'JUSTSTATE'
007900121129     C                   MOVEL     CPCCTR        @ST               2
008000130123     C                   ELSE
008100130123     C                   EVAL      @ST = %SUBST(CPCCTR:2:2)
008200130123     C                   ENDIF
008300121129     C                   MOVE      *ZEROS        NDX
008400121129    ***
008500121129     C                   IF        CNT = 0
008600121129     C                   EVAL      CNT = 1
008700121129     C                   EVAL      S50H = @ST
008800121129     C                   ITER
008900121129     C                   ENDIF
009000121129    ***
009100121129     C                   DO        CNT
009200121129     C                   ADD       2             NDX
009300121129     C     NDX           SUB       1             PTR               3 0
009400121129     C                   IF        %SUBST(S50H:PTR:2) = @ST
009500121129     C                   EVAL      NDX = 999
009600121129     C                   LEAVE
009700121129     C                   ENDIF
009800121129     C                   ENDDO
009900121129    ***
010000121129     C                   IF        NDX <> 999
010100121129     C                   ADD       1             CNT
010200121129     C                   EVAL      PTR = (CNT * 2) - 1
010300121129     C                   EVAL      %SUBST(S50H:PTR:2) = @ST
010400121129     C                   ENDIF
010500121129    ***
010600121129     C                   ENDIF
010700121129     C                   ENDDO
010800121129    ***
010900121129     C                   EVAL      S50@ = S50H
011000121130    ***
011100121130     C                   EXSR      $WHOSEIT
011200121130    ***
011300121130     C                   EXSR      $COMP
011400121130    ***
011500121130     C                   ENDSR
011600121130   S***S
011700121130     C     $LRTN         BEGSR
011800140501    ***
011900140501    ***
012000140501     C                   EVAL      KF@T = 590                                   DAN RYAN
012100140506     C                   EVAL      KF@S = 008                                   BUILDERS
012200140506     C                   EVAL      KF@A = 0002
012300140501     C*
012400140814     C                   EVAL      KF@P = 'LAAL'
012500140814     C                   EVAL      S50@ = 'MDDCMNNCOHPASCVAWVIL'
012600140501     C                   EXSR      $COMP
012700140814     C                   EVAL      KF@P = 'LAAM'
012800140501     C                   EXSR      $COMP
012900140501     C*
013000140814     C                   EVAL      KF@P = 'LAAN'
013100141112     C                   EVAL      S50@ = 'MDDCNCOHPAVASCWV'
013200140501     C                   EXSR      $COMP
013300140814     C                   EVAL      KF@P = 'LAAP'
013400140501     C                   EXSR      $COMP
013500140501     C*
013600140814     C                   EVAL      KF@P = 'LAAK'
013700141028     C                   EVAL      S50@ = 'MDNCOHPADCVAWV'
013800140501     C                   EXSR      $COMP
013900140814     C                   EVAL      KF@P = 'LAAJ'
014000140501     C                   EXSR      $COMP
014100121016    ***
014200121016     C                   EVAL      KF@T = 590                                   ECOLOGY
014300121016     C                   EVAL      KF@S = 002                                   SERVICES
014400120229     C*
014500140304     C                   EVAL      KF@P = 'DAB0'
014600140408     C                   EVAL      S50@ = 'MDDCNJPAVATNMA'
014700120229     C                   EVAL      KF@A = 0006
014800120229     C                   EXSR      $COMP
014900140304     C                   EVAL      S50@ = 'MDDCNJPAVA'
015000120229     C                   EVAL      KF@A = 0007
015100120229     C                   EXSR      $COMP
015200120229     C                   EVAL      KF@A = 0008
015300120229     C                   EXSR      $COMP
015400120229     C                   EVAL      KF@A = 0009
015500120229     C                   EXSR      $COMP
015600120229     C                   EVAL      KF@A = 0010
015700120229     C                   EXSR      $COMP
015800120229     C                   EVAL      KF@A = 0011
015900120229     C                   EXSR      $COMP
016000120229     C*
016100140304     C                   EVAL      KF@P = 'DABZ'
016200140304     C                   EVAL      S50@ = 'MDDCNJPAVAMATNILWV'
016300120229     C                   EVAL      KF@A = 0006
016400120229     C                   EXSR      $COMP
016500140304     C                   EVAL      S50@ = 'MDDCNJPAVA'
016600120229     C                   EVAL      KF@A = 0007
016700120229     C                   EXSR      $COMP
016800130625     C                   EVAL      KF@A = 0008
016900130625     C                   EXSR      $COMP
017000130625     C                   EVAL      KF@A = 0009
017100130625     C                   EXSR      $COMP
017200130625     C                   EVAL      KF@A = 0010
017300130625     C                   EXSR      $COMP
017400120229     C                   EVAL      KF@A = 0011
017500120229     C                   EXSR      $COMP
017600120229    ***
017700120625    ***
017800120919    ***
017900120625     C                   ENDSR
018000120625   S***S
018100120229     C     $COMP         BEGSR
018200121130    ***
018300120229     C     KL#TSAP       SETLL     MCOVR
018400120229     C                   DOU       %EOF(MCOVAPSE)
018500120229     C     KL#TSAP       READE     MCOVR
018600120229     C                   IF        NOT %EOF(MCOVAPSE) AND CANDT = 0
018700120229    *C*
018800120229     C     MCSSNO        CHAIN     MEMBR
018900120229     C                   IF        NOT %FOUND(MEMBER)
019000120229     C                   ITER
019100120229     C                   ENDIF
019200120229    *C*
019300120229     C                   EXSR      $VERFIY
019400120229    *C*
019500120229     C                   ENDIF
019600120229     C                   ENDDO
019700120229    ***
019800120229     C                   ENDSR
019900120229   S***S
020000120229     C     $VERFIY       BEGSR
020100120229    ***
020200120229     C                   EVAL      X = -1
020300120229     C*
020400120229     C                   DO        50
020500120229     C*
020600120229     C                   ADD       2             X
020700120229     C*
020800120229     C                   IF        %SUBST(S50@:X:2) = *BLANKS
020900120229     C                   LEAVE
021000120229     C                   ENDIF
021100120229     C*
021200120229     C                   IF        %SUBST(S50@:X:2) = STATE
021300120229     C                   LEAVESR
021400120229     C                   ENDIF
021500120229     C*
021600120229     C                   ENDDO
021700120229     C*
021800120229     C                   EXSR      $OUTPUT
021900121130    ***
022000121130     C                   ENDSR
022100121130   S***S
022200121130     C     *INZSR        BEGSR
022300121130    ***
022400121130     C                   EVAL      @T5 = '"MAPPED STATES BY ACCOUNT & PLAN"'
022500121130     C                   EXCEPT    OUTF5
022600121130    ***
022700121130     C                   EVAL      @T5 = ','
022800121130     C                   EXCEPT    OUTF5
022900121130    ***
023000121130     C                   EVAL      @T5 = ','
023100121130     C                   EXCEPT    OUTF5
023200121130    ***
023300121130     C                   ENDSR
023400121130   S***S
023500121130     C     $WHOSEIT      BEGSR
023600121130    ***
023700121130     C     KL#TSA        CHAIN     ACCMSR
023800121130     C                   IF        ATRMDT <> 0
023900121130     C                   LEAVESR
024000121130     C                   ENDIF
024100121130    ***
024200121130     C     AACODE        CHAIN     AACODR
024300121130     C     KL#TSP        CHAIN     PLNMSR
024400121130    ***
024500121130     C                   Z-ADD     -1            QZ                3 0
024600121130     C                   MOVE      *BLANKS       @@STATES        300
024700121130    ***
024800121130     C                   DO        50
024900121130     C                   ADD       2             QZ
025000121130     C                   IF        %SUBST(S50@:QZ:2) <> ' '
025100121130     C                   EVAL      @@STATES = %TRIM(@@STATES) +
025200121130     C                             '"' + %SUBST(S50@:QZ:2) + '",'
025300121130     C                   ENDIF
025400121130     C                   ENDDO
025500121130    ***
025600121130     C                   IF        @@STATES <> *BLANKS
025700130403     C                   EVAL      @T5 = '"ACCOUNT: ' + %TRIM(ACNAM1) + '","' +
025800130403     C                             'AA:' + %TRIM(AFNAM) + ' ' +
025900130403     C                             %TRIM(ALNAM) + '","TSAP:' +
026000121130     C                             %EDITC(KF@T:'X') + '-' +
026100121130     C                             %EDITC(KF@S:'X') + '-' +
026200121130     C                             %EDITC(KF@A:'X') + '-' + KF@P +
026300121130     C                             '","DESC: ' + %TRIM(PDESCR) +
026400121130     C                             '","STATES:",' + %TRIM(@@STATES)
026500121130     C                   EXCEPT    OUTF5
026600121130     C                   ENDIF
026700120229    ***
026800120229     C                   ENDSR
026900120229   S***S
027000120229     C     $OUTPUT       BEGSR
027100120229    ***
027200121016     C     KL#TSA        CHAIN     ACCMSR
027300121016    ***
027400121016     C     AACODE        CHAIN     AACODR
027500121016    ***
027600130403     C                   EVAL      HDG@ = %TRIM(ACNAM1) + '","AA:' +
027700130403     C                             %TRIM(AFNAM) + ' ' + %TRIM(ALNAM)
027800121016    ***
027900120229     C                   EVAL      @NAME =
028000120229     C                             %TRIM(MLNAME) + ', ' +
028100120229     C                             %TRIM(MFNAME) + ' ' +
028200120229     C                             %TRIM(MMI)
028300120229     C                   EVAL      @T = '"ACCOUNT: ' + %TRIM(HDG@) +
028400121130     C                             '","TSAP:' + %EDITC(KF@T:'X') + '-' +
028500120229     C                             %EDITC(KF@S:'X') + '-' +
028600191204     C                             %EDITC(KF@A:'X') + '-' + KF@P + '-' +
028700191204     C                             %TRIM(PDESCR) +           '","MEMBER: ' +
028800120229     C                             %TRIM(@NAME) + ' (' +
028900120229     C                             %EDITW(MBSSNO:'   -  -    ') +
029000120229     C                             ')","STATE: ' + STATE + ' IS NOT SETUP"'
029100120229     C                   EXCEPT    OUTF
029200120229    ***
029300120229     C                   ENDSR
029400120229   S***S
029500120229     OT2000     EADD         OUTF
029600120229     O                       @T             B  2000
029700121130     OT500      EADD         OUTF5
029800121130     O                       @T5            B   500
