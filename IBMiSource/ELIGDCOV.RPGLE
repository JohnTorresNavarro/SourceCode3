000100130625     **** SSK DO NOT DELETE
000200130625     ****
000300110902     FMEMAC#    IF   E           K DISK
000400110902     FMCOV      IF   E           K DISK
000500110902     FDCOV22    IF   E           K DISK    RENAME(DCOVR:DCVIN) PREFIX(Z)
000600110902     FELIGDCOV  O  A E             DISK
000700110902     D                 DS
000800110902     D @TSA                    1     10A
000900110902     D #T                      1      3S 0
001000110902     D #S                      4      6S 0
001100110902     D #A                      7     10S 0
001200110902     D
001300110902     D
001400110902     ***
001500110902     C     KL#MBR        SETLL     MEMBR
001600110902     C                   DOU       %EOF(MEMAC#)
001700110902     C     KL#MBR        READE     MEMBR
001800110902     C                   IF        NOT %EOF(MEMAC#)
001900110902     ***
002000110902     C     MBSSNO        CHAIN     MCOVR
002100110902     C                   IF        NOT %FOUND(MCOV)
002200110902     C                   ITER
002300110902     C                   ENDIF
002400110902     ***
002500110902     C     MBSSNO        SETLL     MCOVR
002600110902     C                   DOU       %EOF(MCOV)
002700110902     C     MBSSNO        READE     MCOVR
002800110902     C                   IF        NOT %EOF(MCOV)
002900110902     C                             AND ENRLDT <> CANDT
003000110902     ***
003100110902     C     KL#DCV        CHAIN     DCVIN
003200110902     C                   IF        NOT %FOUND(DCOV22)
003300110902     C                   ITER
003400110902     C                   ENDIF
003500110902     ***
003600110902     C     KL#DCV        SETLL     DCVIN
003700110902     C                   DOU       %EOF(DCOV22)
003800110902     C     KL#DCV        READE     DCVIN
003900110902     C                   IF        NOT %EOF(DCOV22) AND
004000110902     C                             ZDENRDT <> ZCCANDT AND
004100110902     C                             (ZCCANDT = CANDT OR
004200110902     C                             (ZCCANDT <= CANDT AND ZCCANDT >= ZDENRDT))
004300110902     ***
004400110902     C                   CLEAR                   DCOVR
004500110902     C                   EVAL      SSNO       = ZSSNO
004600110902     C                   EVAL      DSEQ#      = ZDSEQ#
004700110902     C                   EVAL      DVTRST     = ZDVTRST
004800110902     C                   EVAL      DVSUB#     = ZDVSUB#
004900110902     C                   EVAL      DVPLAN     = ZDVPLAN
005000110902     C                   EVAL      DVHLDT     = ZDVHLDT
005100110902     C                   EVAL      DVDLTD     = ZDVDLTD
005200110902     C                   EVAL      DENRDT     = ZDENRDT
005300110902     C                   EVAL      CCANDT     = ZCCANDT
005400110902     C                   EVAL      DVACCT     = #A
005500110902     C                   EVAL      DVENRL     = MCOVTP
005600110902     C                   WRITE     DCOVR
005700110902     ***
005800110902     C                   ENDIF
005900110902     C                   ENDDO
006000110902     ***
006100110902     C                   ENDIF
006200110902     C                   ENDDO
006300110902     ***
006400110902     C                   ENDIF
006500110902     C                   ENDDO
006600110902     ***
006700110902     C                   EVAL      *INLR = *ON
006800110902     ***
006900110902     ***
007000110902     C     *INZSR        BEGSR
007100110902     ***
007200110902     C     *ENTRY        PLIST
007300110902     C                   PARM                    @TSAX            10
007400110902     C                   EVAL      @TSA = @TSAX
007500110902     ***
007600110902     C     KL#MBR        KLIST
007700110902     C                   KFLD                    #T
007800110902     C                   KFLD                    #S
007900110902     C                   KFLD                    #A
008000110902     ***
008100110902     C     KL#DCV        KLIST
008200110902     C                   KFLD                    MCTRST
008300110902     C                   KFLD                    MCSUB#
008400110902     C                   KFLD                    MCPLAN
008500110902     C                   KFLD                    MCSSNO
008600110902     ***
008700110902     C                   ENDSR
