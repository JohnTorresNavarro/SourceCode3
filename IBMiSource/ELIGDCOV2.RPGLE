000100110902     FMEMAC#    IF   E           K DISK
000200110902     FMCOV      IF   E           K DISK
000300110902     FDCOV22    IF   E           K DISK    RENAME(DCOVR:DCVIN) PREFIX(Z)
000400130212     FELIGDCOV  IF A E           K DISK
000500110902     D                 DS
000600110902     D @TSA                    1     10A
000700110902     D #T                      1      3S 0
000800110902     D #S                      4      6S 0
000900110902     D #A                      7     10S 0
001000130212     D #ACEN           S              8S 0
001100130212     D #ACTR           S              8S 0
001200130212     D #STR            S              8S 0
001300130212     D #TRM            S              8S 0
001400130212     D DS1           E DS                  EXTNAME(MCOV)
001500130212     D DS2           E DS                  EXTNAME(DCOV) PREFIX(Z)
001600110902     ***
001700110902     C     KL#MBR        SETLL     MEMBR
001800110902     C                   DOU       %EOF(MEMAC#)
001900110902     C     KL#MBR        READE     MEMBR
002000110902     C                   IF        NOT %EOF(MEMAC#)
002100110902     ***
002200110902     C     MBSSNO        CHAIN     MCOVR
002300110902     C                   IF        NOT %FOUND(MCOV)
002400110902     C                   ITER
002500110902     C                   ENDIF
002600130212     ***
002700130212     C                   EXSR      $ACTIVE
002800130212     ***
002900130212     C                   EXSR      $TERMS
003000110902     ***
003100130212     C                   ENDIF
003200130212     C                   ENDDO
003300130212     ***
003400130212     C                   EVAL      *INLR = *ON
003500130212     ***
003600130212     ***
003700130212     *** FIRST WE DO ONLY ACTIVE PLANS
003800130212     ***
003900130212     C     $ACTIVE       BEGSR
004000130212     ***
004100110902     C     MBSSNO        SETLL     MCOVR
004200110902     C                   DOU       %EOF(MCOV)
004300110902     C     MBSSNO        READE     MCOVR
004400130212     C                   IF        NOT %EOF(MCOV) AND CANDT = 0
004500130212     C                             AND MCOVTP <> 'TIN'
004600130212     ***
004700130212     C                   EVAL      #ACEN = ENRLDT
004800130212     C                   EVAL      #ACTR = 99999999
004900110902     ***
005000110902     C     KL#DCV        CHAIN     DCVIN
005100110902     C                   IF        NOT %FOUND(DCOV22)
005200110902     C                   ITER
005300110902     C                   ENDIF
005400110902     ***
005500110902     C     KL#DCV        SETLL     DCVIN
005600110902     C                   DOU       %EOF(DCOV22)
005700110902     C     KL#DCV        READE     DCVIN
005800130212     C                   IF        NOT %EOF(DCOV22)
005900130212     ***
006000130212     C                   IF        ZCCANDT <= ENRLDT AND ZCCANDT > 0
006100130212     C                   ITER
006200130212     C                   ENDIF
006300130212     ***
006400130212     C                   IF        ZDENRDT <= ENRLDT AND
006500130212     C                             ZCCANDT <> 0
006600130212     C                   EVAL      #STR = ENRLDT
006700130212     C                   EVAL      #TRM = ZCCANDT
006800130212     C                   EXSR      $WRITE
006900130212     C                   ITER
007000130212     C                   ENDIF
007100130212     ***
007200130212     C                   IF        ZDENRDT <= ENRLDT AND
007300130212     C                             ZCCANDT = 0
007400130212     C                   EVAL      #STR = ENRLDT
007500130212     C                   EVAL      #TRM = ZCCANDT
007600130212     C                   EXSR      $WRITE
007700130212     C                   ITER
007800130212     C                   ENDIF
007900130212     ***
008000130212     C                   IF        ZDENRDT > ENRLDT
008100130212     C                   EVAL      #STR = ZDENRDT
008200130212     C                   EVAL      #TRM = ZCCANDT
008300130212     C                   EXSR      $WRITE
008400130212     C                   ENDIF
008500110902     ***
008600130212     C                   ENDIF
008700130212     C                   ENDDO
008800130212     ***
008900110902     C                   ENDIF
009000110902     C                   ENDDO
009100110902     ***
009200130212     C                   ENDSR
009300130212     ***
009400130212     ***
009500130212     C     $WRITE        BEGSR
009600130212     ***
009700130212     C     KL#UNQ        CHAIN     DCOVR
009800130212     C                   IF        %FOUND(ELIGDCOV)
009900130212     C                   LEAVESR
010000130212     C                   ENDIF
010100130212     ***
010200130212     C                   CLEAR                   DCOVR
010300130212     C                   EVAL      SSNO       = ZSSNO
010400130212     C                   EVAL      DSEQ#      = ZDSEQ#
010500130212     C                   EVAL      DVTRST     = ZDVTRST
010600130212     C                   EVAL      DVSUB#     = ZDVSUB#
010700130212     C                   EVAL      DVPLAN     = ZDVPLAN
010800130212     C                   EVAL      DVHLDT     = ZDVHLDT
010900130212     C                   EVAL      DVDLTD     = ZDVDLTD
011000130212     C                   EVAL      DENRDT     = #STR
011100130212     C                   EVAL      CCANDT     = #TRM
011200130212     C                   EVAL      DVACCT     = #A
011300130212     C                   EVAL      DVENRL     = MCOVTP
011400130212     C                   WRITE     DCOVR
011500130212     ***
011600130212     C                   ENDSR
011700130212     ***
011800130212     ***
011900130212     C     $TERMS        BEGSR
012000130212     ***
012100130212     C                   EVAL      #ACEN = 99999999
012200130212     C                   EVAL      #ACTR = 0
012300130212     ***
012400130212     C     MBSSNO        SETLL     MCOVR
012500130212     C                   DOU       %EOF(MCOV)
012600130212     C     MBSSNO        READE     MCOVR
012700130212     C                   IF        NOT %EOF(MCOV)
012800130212     C                             AND MCOVTP <> 'TIN'
012900130212     ***
013000130212     C                   IF        CANDT = 0
013100130212     C                   ITER
013200130212     C                   ENDIF
013300130212     ***
013400130212     C     KL#DCV        CHAIN     DCVIN
013500130212     C                   IF        NOT %FOUND(DCOV22)
013600130212     C                   ITER
013700130212     C                   ENDIF
013800130212     ***
013900130212     C     KL#DCV        SETLL     DCVIN
014000130212     C                   DOU       %EOF(DCOV22)
014100130212     C     KL#DCV        READE     DCVIN
014200130212     C                   IF        NOT %EOF(DCOV22)
014300130212     ***
014400130212     C                   IF        ZCCANDT = 0
014500130212     C                   EVAL      ZCCANDT = 99999999
014600130212     C                   ENDIF
014700130212     ***
014800130212     C                   IF        ZDENRDT = ZCCANDT AND
014900130212     C                             ZDENRDT = ENRLDT AND
015000130212     C                             CANDT = ZCCANDT
015100130212     C                   EVAL      #STR = ZDENRDT
015200130212     C                   EVAL      #TRM = ZCCANDT
015300130212     C                   EXSR      $WRITE
015400130212     C                   ITER
015500130212     C                   ENDIF
015600130212     ***
015700130212     C                   IF        ZCCANDT <= ENRLDT
015800130212     C                   ITER
015900130212     C                   ENDIF
016000130212     ***
016100130212     C                   IF        ZDENRDT >= CANDT
016200130212     C                   ITER
016300130212     C                   ENDIF
016400130212     ***
016500130212     C                   IF        ZDENRDT <= ENRLDT
016600130212     C                   IF        ZCCANDT < CANDT
016700130212     C                   EVAL      #STR = ENRLDT
016800130212     C                   EVAL      #TRM = ZCCANDT
016900130212     C                   ELSE
017000130212     C                   EVAL      #STR = ENRLDT
017100130212     C                   EVAL      #TRM = CANDT
017200130212     C                   ENDIF
017300130212     C                   EXSR      $WRITE
017400130212     C                   ITER
017500130212     C                   ENDIF
017600130212     ***
017700130212     C                   IF        ZDENRDT > ENRLDT
017800130212     C                   IF        ZCCANDT < CANDT
017900130212     C                   EVAL      #STR = ZDENRDT
018000130212     C                   EVAL      #TRM = ZCCANDT
018100130212     C                   ELSE
018200130212     C                   EVAL      #STR = ZDENRDT
018300130212     C                   EVAL      #TRM = CANDT
018400130212     C                   ENDIF
018500130212     C                   EXSR      $WRITE
018600130212     C                   ITER
018700130212     C                   ENDIF
018800130212     ***
018900130212     C                   ENDIF
019000130212     C                   ENDDO
019100130212     ***
019200130212     C                   ENDIF
019300130212     C                   ENDDO
019400130212     ***
019500130212     C                   ENDSR
019600110902     ***
019700110902     ***
019800110902     C     *INZSR        BEGSR
019900110902     ***
020000110902     C     *ENTRY        PLIST
020100110902     C                   PARM                    @TSAX            10
020200110902     C                   EVAL      @TSA = @TSAX
020300110902     ***
020400110902     C     KL#MBR        KLIST
020500110902     C                   KFLD                    #T
020600110902     C                   KFLD                    #S
020700110902     C                   KFLD                    #A
020800110902     ***
020900110902     C     KL#DCV        KLIST
021000110902     C                   KFLD                    MCTRST
021100110902     C                   KFLD                    MCSUB#
021200110902     C                   KFLD                    MCPLAN
021300110902     C                   KFLD                    MCSSNO
021400110902     ***
021500130212     C     KL#UNQ        KLIST
021600130212     C                   KFLD                    MCSSNO
021700130212     C                   KFLD                    ZDSEQ#
021800130212     C                   KFLD                    MCTRST
021900130212     C                   KFLD                    MCSUB#
022000130212     C                   KFLD                    ACC#
022100130212     C                   KFLD                    MCPLAN
022200130212     C                   KFLD                    #STR
022300130212     C                   KFLD                    #TRM
022400130212     ***
022500110902     C                   ENDSR
