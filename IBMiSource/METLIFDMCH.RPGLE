000100130626     **** MET LIFE DEATH MATCH FOR KT
000200130626     ****
000300130626     **** JULY 2012
000400130626     ****
000500130626     ****
000600130626     ****
000700130626     ****
000800120710     FMETLIF0005IF   F   65        DISK
000900120710     FMETLIF0102IF   F   63        DISK
001000140630     FT151      O  A F  151        DISK
001100140630    ***
001200140630     D HDR             C                   CONST('HGBSAUDITCCYYMMDDKTHOMPSON@GB-
001300140630     D                                     SIO.NET')
001400140630    ***
001500120710     D TRL             C                   CONST('TGBSAUDIT')
001600140630    ***
001700140630     D @X              S            151A   INZ
001800120710     D #C              S              8S 0
001900120710     D #ISO            S               D   DATFMT(*ISO)
002000120710     D #XSX            S              8S 0
002100120710     D @12             S             12A
002200120710     D @20             S             20A
002300120710     IMETLIF0005AA
002400120710     I                                  3   11  M5SS
002500120710     I                                 12   29  M5LN
002600120710     I                                 30   41  M5FN
002700120710     I                                 42   49  M5BD
002800120710     I                                 50   57  M5ED
002900120710     I                                 58   65  M5TR
003000120710     IMETLIF0102BB
003100120710     I                                  1    9  M2SS
003200120710     I                                 10   24  M2LN
003300120710     I                                 25   39  M2FN
003400120710     I                                 40   47  M2BD
003500120710     I                                 48   55  M2ED
003600120710     I                                 56   63  M2TR
003700120710     C                   EVAL      #ISO = %DATE
003800120710     C                   MOVE      #ISO          #XSX
003900120710     C                   EVAL      @X = HDR
004000120710     C                   EVAL      %SUBST(@X:10:8) = %EDITC(#XSX:'X')
004100120710     C                   EXCEPT    OUTF
004200120710     C                   EXSR      $FILE005
004300120710     C                   EXSR      $FILE102
004400120710     C                   EVAL      @X = TRL
004500120710     C                   EVAL      %SUBST(@X:10:8) = %EDITC(#C:'X')
004600120710     C                   EXCEPT    OUTF
004700120710     C                   EVAL      *INLR = *ON
004800120710     C     $FILE005      BEGSR
004900120710     C                   DOU       %EOF(METLIF0005)
005000120710     C                   READ      METLIF0005
005100120710     C                   IF        NOT %EOF(METLIF0005)
005200120710     C                   MOVEL(P)  M5LN          @20
005300120710     C                   MOVEL(P)  M5FN          @12
005400120710     C                   MOVE      M5TR          @8                8
005500120710     C                   IF        @8 = '00000000'
005600120710     C                   EVAL      @8 = *BLANKS
005700120710     C                   ENDIF
005800120710     C                   EVAL      @X = 'IT' + M5SS +
005900120710     C                             @20 + @12 +
006000120710     C                             M5BD + M5ED + ' ' + @8
006100120710     C                   EXCEPT    OUTF
006200120710     C                   ADD       1             #C
006300120710     C                   ENDIF
006400120710     C                   ENDDO
006500120710     C                   ENDSR
006600120710     C     $FILE102      BEGSR
006700120710     C                   DOU       %EOF(METLIF0102)
006800120710     C                   READ      METLIF0102
006900120710     C                   IF        NOT %EOF(METLIF0102)
007000120710     C                   MOVEL(P)  M2LN          @20
007100120710     C                   MOVEL(P)  M2FN          @12
007200120710     C                   MOVE      M2TR          @8
007300120710     C                   IF        @8 = '00000000'
007400120710     C                   EVAL      @8 = *BLANKS
007500120710     C                   ENDIF
007600120710     C                   EVAL      @X = 'IT' + M2SS +
007700120710     C                             @20 + @12 +
007800120710     C                             M2BD + M2ED + ' ' + @8
007900120710     C                   EXCEPT    OUTF
008000120710     C                   ADD       1             #C
008100120710     C                   ENDIF
008200120710     C                   ENDDO
008300120710     C                   ENDSR
008400140630     OT151      EADD         OUTF
008500140630     O                       @X             B   151
