000100161025      *
000200161025      * 10.25.2016  JALLEN   Removed ROO as spouse as it is reserved for
000300161025      *                      grandchildren.
000400161025      *
000500111010     FACMUNIQUE IPE  E           K DISK    PREFIX(I)
000600021204     F*
000700111010     FMEMAC#3   IF   E           K DISK
000800031203     F*
000900111010     FDEPNDC    IF   E           K DISK
001000031203     F*
001100111010     FGRAT24    IF   E           K DISK
001200111010     F*
001300111010     FDCOV22    IF   E           K DISK
001400031203     F*
001500111010     FMCOVC15   IF   E           K DISK
001600111010     F*
001700111010     FPLNUNIQUE IF   E           K DISK
001800111010     F*
001900111010     FAACODE    IF   E           K DISK
002000111010     F*
002100111010     FCODESL1   IF   E           K DISK
002200031203     F*
002300111010     FT200      O  A F  200        DISK
002400031203   X***X
002500021203     D #CNTSP          S              3S 0                                      SPOUSE COUNT
002600021203     D #CNTCH          S              3S 0                                      CHILD COUNT
002700111010     D MSG             S             60A                                        GENERIC MSG FIELD
002800111010     D X               S            200A
002900021203    ***
003000021203    ***
003100021203    ***
003200031203   X***X
003300111114     C                   IF        IACTRST <> 888
003400111114     C                   EXSR      $MAIN
003500111114     C                   ENDIF
003600111114    ***
003700111114   X***X
003800111114     C     $MAIN         BEGSR
003900111010    ***
004000111010     C     KL#TSA        SETLL     MEMBR
004100111010     C                   DOU       %EOF(MEMAC#3)                                1
004200111010     C     KL#TSA        READE     MEMBR
004300111010     C                   IF        NOT %EOF(MEMAC#3)                            2
004400111010      *
004500111010     C     KL#TSAS       SETLL     MCOVR
004600111010     C                   DOU       %EOF(MCOVC15)                                3
004700111010     C     KL#TSAS       READE     MCOVR
004800111010     C                   IF        NOT %EOF(MCOVC15)                            4
004900111010      *
005000111010     C     KL#TSP        CHAIN     PLNMSR
005100111010     C     PLNCAT        CHAIN     CODESR
005200111010     C                   EXSR      $RATRIX
005300111010      *
005400111010     C                   IF        ACTION <> 'M' AND ACTION <> 'D' AND          5
005500111010     C                             ACTION <> 'V' AND ACTION <> 'R'
005600111010     C                   ITER
005700111010     C                   ENDIF                                                  5
005800111010      *
005900111010     C                   MOVE      *ZEROS        #MAXDEP           3 0
006000111010     C                   MOVE      *ZEROS        #MAXSP            3 0
006100111010     C                   MOVE      *ZEROS        #MAXCH            3 0
006200111010     C                   MOVE      *ZEROS        #CNTSP
006300111010     C                   MOVE      *ZEROS        #CNTCH
006400111114      *
006500111114     C                   EXSR      $ENROLL
006600111010      *
006700111010     C     KL#TSPS       SETLL     DCOVR
006800111010     C                   DOU       %EOF(DCOV22)                                 5
006900111010     C     KL#TSPS       READE     DCOVR
007000111010     C                   IF        NOT %EOF(DCOV22) AND                         6
007100111010     C                             CCANDT = 0
007200111010     C     KL#DEP        CHAIN     DEPENR
007300111018     C                   IF        NOT %FOUND(DEPNDC)
007400111018     C                   GOTO      TAG1
007500111018     C                   ENDIF
007600111010      *                                                                             #CNTSP
007700161025     C****               IF        DRELCD = 'RHU' OR DRELCD = 'ROO' OR          7   #CNTCH
007800161025     C                   IF        DRELCD = 'RHU' OR                            7   #CNTCH
007900111010     C                             DRELCD = 'RPA' OR DRELCD = 'RWI'
008000111010     C                   ADD       1             #CNTSP
008100111010     C                   ELSE                                                   7
008200111010     C                   ADD       1             #CNTCH
008300111010     C                   ENDIF                                                  7
008400111010      *
008500111010     C                   ENDIF                                                  6
008600111010     C                   ENDDO                                                  5
008700111010      *
008800111010     C                   EVAL      MSG = *BLANKS
008900111010      *
009000111114     C                   EXSR      $CHECK
009100111010      *
009200111010     C                   MOVE      *BLANKS       X
009300111010     C                   IF        MSG <> *BLANKS                               5
009400111010     C     IAACODE       CHAIN     AACODR
009500111010     C                   EVAL      X = '"' + %TRIM(MLNAME) + ', ' +
009600111010     C                             %TRIM(MFNAME) + '","' +
009700111010     C                             %EDITC(MBSSNO:'X') + '","' +
009800111010     C                             %CHAR(IACTRST) + '","' +
009900111010     C                             %CHAR(IACSUB#) + '","' +
010000111010     C                             %CHAR(IACACCT) + '","' +
010100111010     C                             %TRIM(MCPLAN) + '","' +
010200111010     C                             %TRIM(MCOVTP) + '","' +
010300111010     C                             %CHAR(#CNTSP) + '","' +
010400111010     C                             %CHAR(#CNTCH) + '","' +
010500111010     C                             %TRIM(MSG) + '","' +
010600111010     C                             %TRIM(ALNAM) + ', ' + %SUBST(AFNAM:1:1) +
010700111010     C                             '"'
010800111010     C                   EXCEPT    OUTF
010900111010     C                   ENDIF                                                  5
011000111018     C     TAG1          TAG
011100111010      *
011200111010     C                   ENDIF                                                  4
011300111010     C                   ENDDO                                                  3
011400111010      *
011500111010     C                   ENDIF                                                  2
011600111010     C                   ENDDO                                                  1
011700111114      *
011800111114     C                   ENDSR
011900111010   X***X
012000111010     C     $RATRIX       BEGSR
012100111010      * RATE MATRIX
012200111010      *          SPS   CHD  <-- ALLOWED(MAX)  0 OR 1 OR UNLIMITED
012300111010      *  POS 1    0     0      INDIVIDUAL
012400111010      *      2    1     0      HUSBAND/WIFE
012500111010      *      3    0     1      CHILD
012600111010      *      4    0     *      CHILDREN
012700111010      *      5    1     *      FAMILY
012800111010      *
012900111010     C                   MOVE      '00000'       @RR               5
013000111010      *
013100111010     C     KL#TSP        CHAIN     GRATER
013200111010     C                   IF        NOT %FOUND(GRAT24)
013300111010     C                   LEAVESR
013400111010     C                   ENDIF
013500111010      *
013600111010     C     KL#TSP        SETGT     GRATER
013700111010     C     KL#TSP        READPE    GRATER
013800111010     C                   Z-ADD     TODAT         #8E               8 0
013900111010      *
014000111114     C                   DOW       NOT %EOF(GRAT24) AND
014100111114     C                             TODAT = #8E
014200111010      *
014300111114     C                   SELECT
014400111114      *
014500111114     C                   WHEN       TYPECD = 'TIN' OR TYPECD = 'TMI'
014600111114     C                   EVAL       %SUBST(@RR:1:1) = '1'
014700111114      *
014800111114     C                   WHEN      MCOVTP = 'TED'
014900111114     C                   EVAL       %SUBST(@RR:2:2) = '11'
015000111114      *
015100111114     C                   WHEN      MCOVTP = 'TFA' OR MCOVTP = 'TMM' OR
015200111114     C                             MCOVTP = 'TFM' OR MCOVTP = 'TMF'
015300111114     C                   EVAL       %SUBST(@RR:5:1) = '1'
015400111114      *
015500111114     C                   WHEN      MCOVTP = 'THM' OR MCOVTP = 'TMH' OR
015600111114     C                             MCOVTP = 'THW'
015700111114     C                   EVAL       %SUBST(@RR:2:1) = '1'
015800111114      *
015900111114     C                   WHEN      MCOVTP = 'TM2' OR MCOVTP = 'TP2' OR
016000111114     C                             MCOVTP = 'TU3' OR MCOVTP = 'TU2'
016100111114     C                   EVAL       %SUBST(@RR:4:1) = '1'
016200111114      *
016300111114     C                   WHEN      MCOVTP = 'TMP' OR MCOVTP = 'TPC' OR
016400111114     C                             MCOVTP = 'TU1'
016500111114     C                   EVAL       %SUBST(@RR:3:1) = '1'
016600111114      *
016700111114     C                   ENDSL
016800111010      *
016900111010     C     KL#TSP        READPE    GRATER
017000111010      *
017100111010     C                   ENDDO
017200111114      *
017300111114     C                   ENDSR
017400111114   X***X
017500111114     C     $ENROLL       BEGSR
017600111114      *
017700111114     **
017800111114     ***TIN, TMI DEFAULT TO ZEROS
017900111114     **
018000111114     C                   SELECT                                                 5
018100111114      *
018200111114     C                   WHEN      MCOVTP = 'TED' OR MCOVTP = 'T01' OR          5
018300111114     C                             MCOVTP = 'T02' OR MCOVTP = 'T03' OR
018400111114     C                             MCOVTP = 'T04' OR MCOVTP = 'T05' OR
018500111114     C                             MCOVTP = 'T06' OR MCOVTP = 'T07' OR
018600111114     C                             MCOVTP = 'T08' OR MCOVTP = 'T09' OR
018700111114     C                             MCOVTP = 'T10'
018800111114     C                   EVAL      #MAXDEP = 1
018900111114      *
019000111114     C                   WHEN      MCOVTP = 'TFA' OR MCOVTP = 'TMM' OR          5
019100111114     C                             MCOVTP = 'TFM' OR MCOVTP = 'TMF'
019200111114     C                   EVAL      #MAXSP = 1
019300111114     C                   EVAL      #MAXCH = 999
019400111114      *
019500111114     C                   WHEN      MCOVTP = 'THM' OR MCOVTP = 'TMH' OR          5
019600111114     C                             MCOVTP = 'THW'
019700111114     C                   EVAL      #MAXSP = 1
019800111114      *
019900111114     C                   WHEN      MCOVTP = 'TM2' OR MCOVTP = 'TP2' OR          5
020000111114     C                             MCOVTP = 'TU3'
020100111114     C                   EVAL      #MAXCH = 999
020200111114      *
020300111114     C                   WHEN      MCOVTP = 'TMP' OR MCOVTP = 'TPC' OR          5
020400111114     C                             MCOVTP = 'TU1'
020500111114     C                   EVAL      #MAXCH = 1
020600111114      *
020700111114     C                   WHEN      MCOVTP = 'TU2'                               5
020800111114     C                   EVAL      #MAXCH = 2
020900111114      *
021000111114     C                   ENDSL                                                  5
021100111114      *
021200111114     C                   ENDSR
021300111114   X***X
021400111114     C     $CHECK        BEGSR
021500111114      *
021600111114     C                   SELECT
021700111114      *
021800111114     C                   WHEN      #MAXDEP  > 0 AND
021900111114     C                             (#CNTSP + #CNTCH) = 0
022000111114     C                   EVAL      MSG = 'DEPS NOT FOUND ON PLAN'
022100111114      *
022200111114     C                   WHEN      #MAXDEP  > 0 AND
022300111114     C                             (#CNTSP + #CNTCH) > #MAXDEP
022400111114     C                   EVAL      MSG = 'TOO MANY DEPS FOR PLAN'
022500111114      *
022600111114     C                   WHEN      #MAXDEP  > 0 AND
022700111114     C                             (#CNTSP + #CNTCH) = #MAXDEP
022800111114     C                   LEAVESR
022900111114      *
023000111114     C                   WHEN      #MAXSP =  0 AND #MAXCH = 0 AND
023100111114     C                             (#CNTSP > 0 OR #CNTCH > 0)
023200111114     C                   EVAL      MSG = 'DEPS FND ON IND PLAN'
023300111114      *
023400111114     C                   WHEN      #MAXSP =  1 AND @RR <> '10001' AND
023500111114     C                             #MAXCH =  999 AND #CNTCH = 0
023600111114     C                   EVAL      MSG = 'NO CHILDREN ON FAMILY PLAN'
023700111114      *
023800111114     C                   WHEN      (#MAXSP =  1 AND #CNTSP > 1) AND
023900111114     C                             (#MAXCH =  999 AND #CNTCH > 0)
024000111114     C                   EVAL      MSG = 'SPOUSE ERR ON FAMILY PLAN'
024100111114      *
024200111114     C                   WHEN      #MAXSP =  1 AND #CNTSP = 0 AND
024300111114     C                             #MAXCH =  999 AND @RR <> '10001'
024400111114     C                   EVAL      MSG = 'NO SPOUSE ON FAMILY PLAN'
024500111114      *
024600111114     C                   WHEN      (#MAXSP =  1 AND #CNTSP = 1) AND
024700111114     C                             (#MAXCH =  0 AND #CNTCH > 0)
024800111114     C                   EVAL      MSG = 'DEPS FND ON H/W PLAN'
024900111114      *
025000111114     C                   WHEN      #MAXSP =  1 AND #CNTSP = 0 AND #MAXCH = 0
025100111114     C                   EVAL      MSG = 'MISSING SPOUSE ON H/W PLAN'
025200111114      *
025300111114     C                   WHEN      #MAXSP =  1 AND #CNTSP > 1 AND #MAXCH = 0
025400111114     C                   EVAL      MSG = 'TO MANY SPOUSES ON H/W PLAN'
025500111114      *
025600111114     C                   WHEN      #MAXSP =  0 AND #CNTSP > 0 AND
025700111114     C                             #MAXCH > 0
025800111114     C                   EVAL      MSG = 'SPOUSE SHOULD NOT BE ENROLLED'
025900111114      *
026000111114     C                   WHEN      ((#MAXCH =  1 AND #CNTCH = 0) OR
026100111114     C                             (#MAXCH =  1 AND #CNTCH > 1))
026200111114     C                             AND %SUBST(@RR:3:2) <> '10'
026300111114     C                   EVAL      MSG = 'DEP COUNT ERROR ON DEP PLAN'
026400111114      *
026500111114     C                   WHEN      (#MAXCH =  2 AND #CNTCH < 2) OR
026600111114     C                             (#MAXCH =  2 AND #CNTCH > 2)
026700111114     C                   EVAL      MSG = 'DEP COUNT ERROR ON 2 DEP PLAN'
026800111114      *
026900111114     C                   WHEN      (#MAXSP =  0 AND #CNTSP = 0) AND
027000111114     C                             (#MAXCH =  999 AND #CNTCH = 0)
027100111114     C                   EVAL      MSG = 'NO DEP FOUND FOR PLAN'
027200111114      *
027300111114     C                   ENDSL
027400111010      *
027500111010     C                   ENDSR
027600031203   X***X
027700111010     C     *INZSR        BEGSR
027800111114      *
027900111114     C     KL#TSA        KLIST
028000111114     C                   KFLD                    IACTRST
028100111114     C                   KFLD                    IACSUB#
028200111114     C                   KFLD                    IACACCT
028300111114    ***
028400111114     C     KL#DEP        KLIST
028500111114     C                   KFLD                    SSNO
028600111114     C                   KFLD                    DSEQ#
028700111114    ***
028800111114     C     KL#TSAS       KLIST
028900111114     C                   KFLD                    IACTRST
029000111114     C                   KFLD                    IACSUB#
029100111114     C                   KFLD                    IACACCT
029200111114     C                   KFLD                    MBSSNO
029300111114    ***
029400111114     C     KL#TSP        KLIST
029500111114     C                   KFLD                    IACTRST
029600111114     C                   KFLD                    IACSUB#
029700111114     C                   KFLD                    MCPLAN
029800111114    ***
029900111114     C     KL#TSPS       KLIST
030000111114     C                   KFLD                    IACTRST
030100111114     C                   KFLD                    IACSUB#
030200111114     C                   KFLD                    MCPLAN
030300111114     C                   KFLD                    MBSSNO
030400111202      *
030500111202     C                   EVAL      X = '"MEMBER & DEPENDENT COVERAGE LEVEL AU' +
030600111202     C                             'DIT"'
030700111202     C                   EXCEPT    OUTF
030800111114      *
030900111202     C                   EVAL      X = ','
031000111202     C                   EXCEPT    OUTF
031100111202     C                   EVAL      X = ','
031200111202     C                   EXCEPT    OUTF
031300111202      *
031400111010     C                   EVAL      X = '"MEMBER NAME","SSN","TRS","SUB","ACC"' +
031500111010     C                             ',"PLAN","COV TYPE","SPS CNT","CHD CNT","P' +
031600111010     C                             'OSSIBLE ERROR","AA"'
031700111010     C                   EXCEPT    OUTF
031800111114      *
031900111010     C                   ENDSR
032000111010    ***
032100111010   X***X
032200031219     OT200      EADD         OUTF
032300111010     O                       X                  200
