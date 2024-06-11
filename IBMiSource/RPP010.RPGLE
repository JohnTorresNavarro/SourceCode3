000100111011     FINVELE    IF   E           K DISK
000200111011     FCARUNIQUE IF   E           K DISK
000300111011     FPLNUNIQUE IF   E           K DISK
000400111011     FACMUNIQUE IF   E           K DISK
000500111012     FRPP010WF  UF A E           K DISK
000600111011     FT500      O  A F  500        DISK
000700111011      *
000800111011     D #ISO            S               D   DATFMT(*ISO)
000900111011     D                 DS
001000111011     D PARM@DS                 1     27A
001100111011     D  PTRS                   1      3S 0
001200111011     D  PSUB                   4      6S 0
001300111011     D  PACC                   7     10S 0
001400111011     D  @TRS                   1      3A
001500111011     D  @SUB                   4      6A
001600111011     D  @ACC                   7     10A
001700111011     D  PFRDT                 11     18S 0
001800111011     D  PTODT                 19     26S 0
001900111011     D  @FRDT                 11     18A
002000111011     D  @TODT                 19     26A
002100111011      *
002200111011     C     *ENTRY        PLIST
002300111011     C                   PARM                    PARM@IN          27
002400111011     C                   EVAL      PARM@DS = PARM@IN
002500111011     C     KL#TSA        KLIST
002600111011     C                   KFLD                    PTRS
002700111011     C                   KFLD                    PSUB
002800111011     C                   KFLD                    PACC
002900111011      *
003000111011     C     KL#TSA        SETLL     INVELR
003100111011     C                   DOU       %EOF(INVELE)
003200111011     C     KL#TSA        READE     INVELR
003300111011     C                   IF        NOT %EOF(INVELE) AND IERC = '20' AND
003400111011     C                             IEVCDT >= PFRDT AND
003500111011     C                             IEVCDT <= PTODT
003600111011      *
003700111011     C     KL#TSAPYM     KLIST
003800111011     C                   KFLD                    IETRST
003900111011     C                   KFLD                    IESUBD
004000111011     C                   KFLD                    IEACCT
004100111011     C                   KFLD                    IEPLAN
004200111011     C                   KFLD                    ##YR
004300111011     C                   KFLD                    ##MO
004400111011      *
004500111011     C                   MOVE      IEVCDT        #ISO
004600111011     C                   EXTRCT    #ISO:*Y       ##YR              4 0
004700111011     C                   EXTRCT    #ISO:*M       ##MO              2 0
004800111011     C     KL#TSAPYM     CHAIN     F200
004900111011      *
005000111012     C                   IF        %FOUND(RPP010WF)
005100111011     C                   EXSR      $ADD2BKT
005200111011     C                   UPDATE    F200
005300111011     C                   ELSE
005400111011     C                   EXSR      $FMT200
005500111011     C                   EXSR      $ADD2BKT
005600111011     C                   WRITE     F200
005700111011     C                   ENDIF
005800111011      *
005900111011     C                   ENDIF
006000111011     C                   ENDDO
006100111011      *
006200111011     C     KL#TSA        CHAIN     ACCMSR
006300111011     C                   EVAL      X = '"ACCOUNT: ' + @TRS + '-' + @SUB + '-' +
006400111011     C                             @ACC + ' ' + %TRIM(ACNAM1) + '"'
006500111011     C                   EXCEPT    OUTF
006600111011      *
006700111011     C                   EVAL      X = '"FROM: ' + @FRDT + ' TO: ' + @TODT + '"'
006800111011     C                   EXCEPT    OUTF
006900111011      *
007000111011     C                   EVAL      X = ','
007100111011     C                   EXCEPT    OUTF
007200111011     C                   EXCEPT    OUTF
007300111011      *
007400111011     C                   EVAL      X = '"PLAN DESCRIPTION","YEAR","MONTH","IN' +
007500111011     C                             'D","HUS/WIFE","PARNT+CHD","PARNT+CHDRN","' +
007600111011     C                             'FAM","CLS 1","CLS 2","CLS 3","CLS 4","DOU' +
007700111011     C                             'LE","EMP+1","FAM MEDCR","HUS/WIFE MEDCR",' +
007800111011     C                             '"MEDCR FAM","MEDCR HUS/WIFE","IND MEDCR",' +
007900111011     C                             '"MED FAM2","MED P+C","MED CHDRN","UHC 1 C' +
008000111011     C                             'HD","UHC 2 CHDRN","UHC 3 CHDRN","UHC AB 0' +
008100111011     C                             '1","UHC AB 02","UHC AB 03","UHC AB 04","U' +
008200111011     C                             'HC AB 05","UHC AB 06","UHC AB 07","UHC AB' +
008300111011     C                             ' 08","UHC AB 09","UHC AB 10","2 PERSN"'
008400111011     C                   EXCEPT    OUTF
008500111011      *
008600111011     C     KL#TSP2       KLIST
008700111011     C                   KFLD                    R2TRS
008800111011     C                   KFLD                    R2SUB
008900111011     C                   KFLD                    R2PLN
009000111011      *
009100111011     C     KL#TSA        SETLL     F200
009200111012     C                   DOU       %EOF(RPP010WF)
009300111011     C     KL#TSA        READE     F200
009400111012     C                   IF        NOT %EOF(RPP010WF)
009500111011      *
009600111011     C     KL#TSP2       CHAIN     PLNMSR
009700111011     C     R2CAR         CHAIN     CARMSR
009800111011      *
009900111011     C                   MOVE      *BLANKS       X               500
010000111011     C                   EVAL      X = '"' + %TRIM(PDESCR) + '","' +
010100111011     C                             %CHAR(R2YR) + '","' + %CHAR(R2MO) + '","' +
010200111011     C                             %CHAR(R2IN) + '","' +
010300111011     C                             %CHAR(R2HW) + '","' +
010400111011     C                             %CHAR(R2PC) + '","' +
010500111011     C                             %CHAR(R2P2) + '","' +
010600111011     C                             %CHAR(R2FA) + '","' +
010700111011     C                             %CHAR(R2C1) + '","' +
010800111011     C                             %CHAR(R2C2) + '","' +
010900111011     C                             %CHAR(R2C3) + '","' +
011000111011     C                             %CHAR(R2C4) + '","' +
011100111011     C                             %CHAR(R2DB) + '","' +
011200111011     C                             %CHAR(R2ED) + '","' +
011300111011     C                             %CHAR(R2FM) + '","' +
011400111011     C                             %CHAR(R2HM) + '","' +
011500111011     C                             %CHAR(R2MF) + '","' +
011600111011     C                             %CHAR(R2MH) + '","' +
011700111011     C                             %CHAR(R2MI) + '","' +
011800111011     C                             %CHAR(R2MM) + '","' +
011900111011     C                             %CHAR(R2MP) + '","' +
012000111011     C                             %CHAR(R2M2) + '","' +
012100111011     C                             %CHAR(R2U1) + '","' +
012200111011     C                             %CHAR(R2U2) + '","' +
012300111011     C                             %CHAR(R2U3) + '","' +
012400111011     C                             %CHAR(R201) + '","' +
012500111011     C                             %CHAR(R202) + '","' +
012600111011     C                             %CHAR(R203) + '","' +
012700111011     C                             %CHAR(R204) + '","' +
012800111011     C                             %CHAR(R205) + '","' +
012900111011     C                             %CHAR(R206) + '","' +
013000111011     C                             %CHAR(R207) + '","' +
013100111011     C                             %CHAR(R208) + '","' +
013200111011     C                             %CHAR(R209) + '","' +
013300111011     C                             %CHAR(R210) + '","' +
013400111011     C                             %CHAR(R22P) + '"'
013500111011     C                   EXCEPT    OUTF
013600111011     C                   ENDIF
013700111011     C                   ENDDO
013800111011      *
013900111011     C                   EVAL      *INLR = *ON
014000111011      *
014100111011      *
014200111011     C     $FMT200       BEGSR
014300111011     C                   CLEAR                   F200
014400111011     C                   EVAL      R2TRS = IETRST
014500111011     C                   EVAL      R2SUB = IESUBD
014600111011     C                   EVAL      R2ACC = IEACCT
014700111011     C                   EVAL      R2PLN = IEPLAN
014800111011     C                   EVAL      R2CAR = IECAR
014900111011     C                   MOVE      IEVCDT        #ISO
015000111011     C                   EXTRCT    #ISO:*Y       R2YR
015100111011     C                   EXTRCT    #ISO:*M       R2MO
015200111011     C                   ENDSR
015300111011     C     $ADD2BKT      BEGSR
015400111011     C                   SELECT
015500111011     C                   WHEN      IECT   = 'TIN'
015600111011     C                   ADD       1             R2IN
015700111011     C                   WHEN      IECT   = 'THW'
015800111011     C                   ADD       1             R2HW
015900111011     C                   WHEN      IECT   = 'TPC'
016000111011     C                   ADD       1             R2PC
016100111011     C                   WHEN      IECT   = 'TP2'
016200111011     C                   ADD       1             R2P2
016300111011     C                   WHEN      IECT   = 'TFA'
016400111011     C                   ADD       1             R2FA
016500111011     C                   WHEN      IECT   = 'TC1'
016600111011     C                   ADD       1             R2C1
016700111011     C                   WHEN      IECT   = 'TC2'
016800111011     C                   ADD       1             R2C2
016900111011     C                   WHEN      IECT   = 'TC3'
017000111011     C                   ADD       1             R2C3
017100111011     C                   WHEN      IECT   = 'TC4'
017200111011     C                   ADD       1             R2C4
017300111011     C                   WHEN      IECT   = 'TDB'
017400111011     C                   ADD       1             R2DB
017500111011     C                   WHEN      IECT   = 'TED'
017600111011     C                   ADD       1             R2ED
017700111011     C                   WHEN      IECT   = 'TFM'
017800111011     C                   ADD       1             R2FM
017900111011     C                   WHEN      IECT   = 'THM'
018000111011     C                   ADD       1             R2HM
018100111011     C                   WHEN      IECT   = 'TMF'
018200111011     C                   ADD       1             R2MF
018300111011     C                   WHEN      IECT   = 'TMH'
018400111011     C                   ADD       1             R2MH
018500111011     C                   WHEN      IECT   = 'TMI'
018600111011     C                   ADD       1             R2MI
018700111011     C                   WHEN      IECT   = 'TMM'
018800111011     C                   ADD       1             R2MM
018900111011     C                   WHEN      IECT   = 'TMP'
019000111011     C                   ADD       1             R2MP
019100111011     C                   WHEN      IECT   = 'TM2'
019200111011     C                   ADD       1             R2M2
019300111011     C                   WHEN      IECT   = 'TU1'
019400111011     C                   ADD       1             R2U1
019500111011     C                   WHEN      IECT   = 'TU2'
019600111011     C                   ADD       1             R2U2
019700111011     C                   WHEN      IECT   = 'TU3'
019800111011     C                   ADD       1             R2U3
019900111011     C                   WHEN      IECT   = 'T01'
020000111011     C                   ADD       1             R201
020100111011     C                   WHEN      IECT   = 'T02'
020200111011     C                   ADD       1             R202
020300111011     C                   WHEN      IECT   = 'T03'
020400111011     C                   ADD       1             R203
020500111011     C                   WHEN      IECT   = 'T04'
020600111011     C                   ADD       1             R204
020700111011     C                   WHEN      IECT   = 'T05'
020800111011     C                   ADD       1             R205
020900111011     C                   WHEN      IECT   = 'T06'
021000111011     C                   ADD       1             R206
021100111011     C                   WHEN      IECT   = 'T07'
021200111011     C                   ADD       1             R207
021300111011     C                   WHEN      IECT   = 'T08'
021400111011     C                   ADD       1             R208
021500111011     C                   WHEN      IECT   = 'T09'
021600111011     C                   ADD       1             R209
021700111011     C                   WHEN      IECT   = 'T10'
021800111011     C                   ADD       1             R210
021900111011     C                   WHEN      IECT   = 'T2P'
022000111011     C                   ADD       1             R22P
022100111011     C                   ENDSL
022200111011     C                   ENDSR
022300111011     OT500      EADD         OUTF
022400111011     O                       X                  500
