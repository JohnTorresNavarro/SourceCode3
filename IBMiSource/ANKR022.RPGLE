000100130327   X***X
000200130327    ***
000300130517     FMEMAC#    IF   E           K DISK
000400130514     FHISTL9    IF   E           K DISK
000500130517     FANKW020   IF A E           K DISK
000600130327    ***
000700130327   X***X
000800130514    ***
000900130514     D DAYNO           S              1P 0
001000130514     D #ISO            S               D   DATFMT(*ISO)
001100130517     D #BEGIN          S              8S 0
001200130517     D #END            S              8S 0
001300130517    ***
001400130327   X***X
001500130517    ***
001600130517     C     KL#M          KLIST
001700130517     C                   KFLD                    HSTRST
001800130517     C                   KFLD                    HSSUB#
001900130517     C                   KFLD                    HSACCT
002000130517    ***
002100130514     C                   EVAL      DAYNO =
002200130514     C                             %REM(%DIFF(%DATE():D'0001-01-01':*DAYS):7)
002300130517    ***
002400130517     C                   EVAL      #ISO = %DATE
002500130517    ***
002600130517     C                   MOVE      #ISO          #END
002700130517    ***
002800130517     C                   IF        DAYNO < 5
002900130517     C                   IF        DAYNO = 0
003000130517     C                   SUBDUR    3:*D          #ISO
003100130517     C                   ELSE
003200130517     C                   SUBDUR    1:*D          #ISO
003300130517     C                   ENDIF
003400130517     C                   MOVE      #ISO          #BEGIN
003500130517     C                   EXSR      $PROC
003600130517     C                   ENDIF
003700130517    ***
003800130517     C                   EVAL      *INLR = *ON
003900130517    ***
004000130517   S***S
004100130517     C     $PROC         BEGSR
004200130517    ***
004300130517     C     #BEGIN        SETLL     HISTR
004400130517     C                   DOU       %EOF(HISTL9) OR TRDATE >= #END
004500130517     C                   READ      HISTR
004600130517     C                   IF        NOT %EOF(HISTL9) AND
004700130517     C                             TRDATE >= #BEGIN AND
004800130517     C                             TRDATE < #END AND
004900130517     C                             HSTRST > 24 AND HSTRST < 76
005000130517    ***
005100130517     C                   IF        TRCODE = 'L01' OR TRCODE = 'L02' OR
005200130517     C                             TRCODE = 'L03' OR TRCODE = 'L04' OR
005300130517     C                             TRCODE = 'L05' OR TRCODE = 'L06' OR
005400130517     C                             TRCODE = 'L07' OR TRCODE = 'L08' OR
005500141014     C                             TRCODE = 'L09' OR TRCODE = 'L10' OR
005600141014     C                             TRCODE = 'L11' OR TRCODE = 'L95' OR
005700141014     C                             TRCODE = 'L29' OR TRCODE = 'L52' OR
005800141014     C                             TRCODE = 'L95' OR TRCODE = 'M01' OR
005900141014     C                             TRCODE = 'M02' OR TRCODE = 'M03' OR
006000141014     C                             TRCODE = 'M04' OR TRCODE = 'M05' OR
006100141014     C                             TRCODE = 'M06' OR TRCODE = 'M07' OR
006200141014     C                             TRCODE = 'M08' OR TRCODE = 'M09' OR
006300141014     C                             TRCODE = 'M10' OR TRCODE = 'M11' OR
006400141014     C                             TRCODE = 'M12' OR TRCODE = 'M13' OR
006500141014     C                             TRCODE = 'M14' OR TRCODE = 'M15' OR
006600141014     C                             TRCODE = 'M16' OR TRCODE = 'MAC' OR
006700141014     C                             TRCODE = 'MCE' OR TRCODE = 'MCX' OR
006800141014     C                             TRCODE = 'MDC' OR TRCODE = 'MMA' OR
006900141014     C                             TRCODE = 'MMX' OR TRCODE = 'MRC'
007000130517    ***
007100130517     C     KL#M          CHAIN     MEMBR
007200130517     C                   IF        NOT %FOUND(MEMAC#)
007300130517     C                   ITER
007400130517     C                   ENDIF
007500130517    ***
007600130517     C     MBSSNO        CHAIN     ANKF020
007700130517     C                   IF        %FOUND(ANKW020)
007800130517     C                   ITER
007900130517     C                   ENDIF
008000130517    ***
008100130517     C                   CLEAR                   ANKF020
008200130517     C                   EVAL      A20SSN = MBSSNO
008300130517     C                   EVAL      A20TRS = MBTRST
008400130517     C                   EVAL      A20SUB = MBSUB#
008500130517     C                   EVAL      A20ACC = MBACCT
008600130517     C                   WRITE     ANKF020
008700130517    ***
008800130517     C                   ENDIF
008900130517    ***
009000130517     C                   ENDIF
009100130517     C                   ENDDO
009200130517    ***
009300130517     C                   ENDSR
009400130517   S***S
