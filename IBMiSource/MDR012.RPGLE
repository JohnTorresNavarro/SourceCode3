000100110401    *** MARKETING DIARY NOTE GENERIC
000200020308    ***
000300110401    *** 04.01.2011.SSK.ORIGINAL SOURCE
000400020308    ***
000500110401    *** REPORTING PROGRAM
000600020308    ***
000700020308    ***
000800020308    ***
000900020308    ***
001000020308    ***
001100020308    ***
001200110401     FMKTDIARYD0IF   E           K DISK
001300020108     ** HISTORY DIARY FILE - DETAIL
001400110401     FMKTDIARYH0IF   E           K DISK
001500020108     ** HISTORY DIARY FILE - HEADER
001600110401     FT200      O  A F  200        DISK
001700010508   X***X
001800020103    ***
001900110401     D @X              S            200A
002000010509    ***
002100010508   X***X
002200010508    ***
002300011228     C     *ENTRY        PLIST
002400110401     C                   PARM                    @15              15
002500110401     C                   MOVEL     @15           KF@UNQ           15
002600040106    ***
002700110401     C     KF@UNQ        CHAIN     MKTHR
002800110401     C                   IF        %FOUND(MKTDIARYH0)
002900110401     C                   EXSR      $HEADER
003000110401     C     KF@UNQ        CHAIN     MKTDR
003100110401     C                   IF        %FOUND(MKTDIARYD0)
003200110401     C                   EXSR      $DETAIL
003300110401     C                   ELSE
003400110401     C                   EVAL      @X = '"ERROR-NO DETAIL NOTES"'
003500110401     C                   EXCEPT    OUTF
003600110401     C                   ENDIF
003700110401     C                   ELSE
003800110401     C                   EVAL      @X = '"ERROR-CANNOT FIND HEADER NOTE"'
003900110401     C                   EXCEPT    OUTF
004000110401     C                   ENDIF
004100110401    ***
004200110401     C                   EVAL      *INLR = *ON
004300110401    ***
004400110401    ***
004500110401     C     $HEADER       BEGSR
004600110401    ***
004700110401     C                   EVAL      @X = '"NOTE PRINT OUT FOR #' +
004800110401     C                             MHUNIQUE + '"'
004900110401     C                   EXCEPT    OUTF
005000110413      *
005100110401     C                   EVAL      @X = ','
005200110401     C                   EXCEPT    OUTF
005300110413      *
005400110413     C                   IF        MHSMAN <> *BLANKS
005500110413     C                   EVAL      @X = %TRIM(@X) + ' SMAN:' + MHSMAN + ';'
005600110413     C                   ENDIF
005700110413      *
005800110413     C                   IF        MHAGENCY  <> *BLANKS
005900110413     C                   EVAL      @X = %TRIM(@X) + ' AGCY:' + MHAGENCY + ';'
006000110413     C                   ENDIF
006100110413      *
006200110413     C                   IF        MHSUPER   <> *BLANKS
006300110413     C                   EVAL      @X = %TRIM(@X) + ' SUPR:' + MHSUPER + ';'
006400110413     C                   ENDIF
006500110413      *
006600110413     C                   IF        MHRELID   <> *BLANKS
006700110413     C                   EVAL      @X = %TRIM(@X) + ' REL:' + MHRELID + ';'
006800110413     C                   ENDIF
006900110413      *
007000110413     C                   IF        MHLINKID  <> *BLANKS
007100110413     C                   EVAL      @X = %TRIM(@X) + ' LINK:' + MHLINKID + ';'
007200110413     C                   ENDIF
007300110413      *
007400110413     C                   IF        MHGROUPER <> *BLANKS
007500110413     C                   EVAL      @X = %TRIM(@X) + ' GRPR:' + MHGROUPER + ';'
007600110413     C                   ENDIF
007700110415      *
007800110415     C                   EXCEPT    OUTF
007900110413      *
008000110413     C                   EVAL      @X = ','
008100110413     C                   EXCEPT    OUTF
008200110413      *
008300110401     C                   MOVE      *BLANKS       @T                8
008400110401     C                   MOVE      *BLANKS       @D               10
008500110401     C                   EVALR     @T = %EDITW(MHADTI:'  :  :  ')
008600110401     C     MHADDT        MULT      10000.0001    #8                8 0
008700110401     C                   EVALR     @D = %EDITW(#8:'  /  /    ')
008800110401     C                   EVAL      @X = '"' + %TRIM(MHCODE) + ' NOTE ADDED ON:'
008900110401     C                             + @D + ' AT:' + @T + '"'
009000110401     C                   EXCEPT    OUTF
009100110413      *
009200110401     C                   EVAL      @X = ','
009300110401     C                   EXCEPT    OUTF
009400110413      *
009500110412     C                   EVAL      @X = '"NOTE WAS CREATED BY: ' +
009600110401     C                             %TRIM(MHADJOB) + '/' +
009700110401     C                             %TRIM(MHADUSER) + '/' +
009800110401     C                             %TRIM(MHADNBR) + '"'
009900110401     C                   EXCEPT    OUTF
010000110401     C                   EVAL      @X = ','
010100110415     C                   EVAL      @X = '"SUBJECT: ' + %TRIM(MHSUBJ) + '"'
010200110401     C                   EXCEPT    OUTF
010300110401     C                   EVAL      @X = ','
010400110401     C                   EXCEPT    OUTF
010500110415     C                   EVAL      @X = '"MESSAGE TEXT BELOW"'
010600110415     C                   EXCEPT    OUTF
010700110401    ***
010800110401     C                   ENDSR
010900110401    ***
011000110401    ***
011100110401     C     $DETAIL       BEGSR
011200110401    ***
011300110401     C     KF@UNQ        SETLL     MKTDR
011400110401     C                   DOU       %EOF(MKTDIARYD0)
011500110401     C     KF@UNQ        READE     MKTDR
011600110401     C                   IF        NOT %EOF(MKTDIARYD0)
011700110401    ***
011800110401     C                   IF        MDTEXT <> *BLANKS
011900110401     C                   EVAL      @X = '"' + %TRIM(MDTEXT) + '"'
012000110401     C                   EXCEPT    OUTF
012100110401     C                   ENDIF
012200110401    ***
012300110401     C                   ENDIF
012400110401     C                   ENDDO
012500110401    ***
012600110401     C                   ENDSR
012700110401   X***X
012800110401     OT200      EADD         OUTF
012900110401     O                       @X             B   200
