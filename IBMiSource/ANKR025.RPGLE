000100130327   X***X
000200130327    ***
000300130517     FMEMAC#    IF   E           K DISK
000400130514     FHISTL9    IF   E           K DISK
000500130517     FANKW020   IF A E           K DISK
000600130327    ***
000700130327   X***X
000800130514    ***
000900130523     D #DATE           S               D   DATFMT(*ISO) INZ(D'2013-05-01')
001000130514     D DAYNO           S              1P 0
001100130514     D #ISO            S               D   DATFMT(*ISO)
001200130517     D #BEGIN          S              8S 0
001300130517     D #END            S              8S 0
001400130517    ***
001500130327   X***X
001600130517    ***
001700130517     C     KL#M          KLIST
001800130517     C                   KFLD                    HSTRST
001900130517     C                   KFLD                    HSSUB#
002000130517     C                   KFLD                    HSACCT
002100130517    ***
002200130517     C                   EVAL      #ISO = %DATE
002300130523    ***
002400130517     C                   MOVE      #ISO          #END
002500130517    ***
002600130523     C                   MOVE      #DATE         #BEGIN
002700130523    ***
002800130517     C                   EXSR      $PROC
002900130517    ***
003000130517     C                   EVAL      *INLR = *ON
003100130517    ***
003200130517   S***S
003300130517     C     $PROC         BEGSR
003400130517    ***
003500130517     C     #BEGIN        SETLL     HISTR
003600130517     C                   DOU       %EOF(HISTL9) OR TRDATE >= #END
003700130517     C                   READ      HISTR
003800130517     C                   IF        NOT %EOF(HISTL9) AND
003900130517     C                             TRDATE >= #BEGIN AND
004000130517     C                             TRDATE < #END AND
004100130517     C                             HSTRST > 24 AND HSTRST < 76
004200130517    ***
004300130517     C                   IF        TRCODE = 'L01' OR TRCODE = 'L02' OR
004400130517     C                             TRCODE = 'L03' OR TRCODE = 'L04' OR
004500130517     C                             TRCODE = 'L05' OR TRCODE = 'L06' OR
004600130517     C                             TRCODE = 'L07' OR TRCODE = 'L08' OR
004700130517     C                             TRCODE = 'MMA' OR TRCODE = 'MCE' OR
004800130517     C                             TRCODE = 'MCX' OR TRCODE = 'MDC' OR
004900130517     C                             TRCODE = 'MRC' OR TRCODE = 'MMX' OR
005000130517     C                             TRCODE = 'M01' OR TRCODE = 'M05' OR
005100130517     C                             TRCODE = 'M02' OR TRCODE = 'M06' OR
005200130517     C                             TRCODE = 'M03' OR TRCODE = 'M07' OR
005300130517     C                             TRCODE = 'M11' OR TRCODE = 'M14' OR
005400130517     C                             TRCODE = 'M12' OR TRCODE = 'M15' OR
005500130517     C                             TRCODE = 'M13' OR
005600130517     C                             TRCODE = 'M04' OR TRCODE = 'M08'
005700130517    ***
005800130517     C     KL#M          CHAIN     MEMBR
005900130517     C                   IF        NOT %FOUND(MEMAC#)
006000130517     C                   ITER
006100130517     C                   ENDIF
006200130517    ***
006300130517     C     MBSSNO        CHAIN     ANKF020
006400130517     C                   IF        %FOUND(ANKW020)
006500130517     C                   ITER
006600130517     C                   ENDIF
006700130517    ***
006800130517     C                   CLEAR                   ANKF020
006900130517     C                   EVAL      A20SSN = MBSSNO
007000130517     C                   EVAL      A20TRS = MBTRST
007100130517     C                   EVAL      A20SUB = MBSUB#
007200130517     C                   EVAL      A20ACC = MBACCT
007300130517     C                   WRITE     ANKF020
007400130517    ***
007500130517     C                   ENDIF
007600130517    ***
007700130517     C                   ENDIF
007800130517     C                   ENDDO
007900130517    ***
008000130517     C                   ENDSR
008100130517   S***S
