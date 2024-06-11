000100060713     FRNWP017A  IF   E           K DISK
000200060713     FRNWP018A  IF   E           K DISK
000300060713     FRNWP019A  IF   E           K DISK
000400060706    ***
000500060713     FRNWP017   O  A F  150        DISK
000600060713     FRNWP018   O  A F  150        DISK
000700060713     FRNWP019   O  A F  150        DISK
000800060706   X***X
000900060706     D @S              S              1A   INZ('A')
001000060713     D O@              S            150A   INZ
001100060713     D O17             S            150A   INZ
001200060713     D O18             S            150A   INZ
001300060713     D O19             S            150A   INZ
001400060705     D S@              C                   CONST('","')
001500060707    ***
001600060706   X***X
001700060713     C                   EVAL      O@ = '"LINE 1","LINE 2","LINE 3","LINE 4"'
001800060713     C                   EVAL      O17 = O@
001900060713     C                   EXCEPT    O17F
002000060713     C                   EVAL      O18 = O@
002100060713     C                   EXCEPT    O18F
002200060713     C                   EVAL      O19 = O@
002300060713     C                   EXCEPT    O19F
002400060713    ***
002500060707     C                   DOU       @S = '7'
002600060713*************ANC LABELS
002700060713     C     @S            CASEQ     'A'           $ANC
002800060713*************BLUES LABELS
002900060713     C     @S            CASEQ     'B'           $BLUES
003000060713*************PPN LABELS
003100060713     C     @S            CASEQ     'C'           $PPN
003200060706     C                   ENDCS
003300060707    ***
003400060706     C                   ENDDO
003500060706    ***
003600060710     C                   EVAL      *INLR = *ON
003700060707   S***S
003800060713     C     $ANC          BEGSR                                                   SR=A
003900060707    ***
004000060713     C                   READ      F017A
004100060707    ***
004200060713     C                   IF        %EOF(RNWP017A)
004300060713     C                   EVAL      @S = 'B'
004400060707     C                   LEAVESR
004500060707     C                   ENDIF
004600060706    ***
004700060713     C                   EVAL      O@ = '"' + %TRIM(R7ACC) + S@ + %TRIM(R7ANM) +
004800060713     C                             S@ + %TRIM(R7BKR) + S@ + %TRIM(R7SMN) + '"'
004900060713    ***
005000060713     C                   EVAL      O17 = O@
005100060713     C                   EXCEPT    O17F
005200060706    ***
005300060706     C                   ENDSR
005400060707   S***S
005500060713     C     $BLUES        BEGSR                                                   SR=B
005600060713    ***
005700060713     C                   READ      F018A
005800060713    ***
005900060713     C                   IF        %EOF(RNWP018A)
006000060713     C                   EVAL      @S = 'C'
006100060713     C                   LEAVESR
006200060713     C                   ENDIF
006300060713    ***
006400060713     C                   EVAL      O@ = '"' + %TRIM(R8ACC) + S@ + %TRIM(R8ANM) +
006500060713     C                             S@ + %TRIM(R8BKR) + S@ + %TRIM(R8SMN) + '"'
006600060713    ***
006700060713     C                   EVAL      O18 = O@
006800060713     C                   EXCEPT    O18F
006900060713    ***
007000060713     C                   ENDSR
007100060713   S***S
007200060713     C     $PPN          BEGSR                                                   SR=C
007300060713    ***
007400060713     C                   READ      F019A
007500060713    ***
007600060713     C                   IF        %EOF(RNWP019A)
007700060713     C                   EVAL      @S = '7'
007800060713     C                   LEAVESR
007900060713     C                   ENDIF
008000060713    ***
008100060713     C                   EVAL      O@ = '"' + %TRIM(R9ACC) + S@ + %TRIM(R9ANM) +
008200060713     C                             S@ + %TRIM(R9BKR) + S@ + %TRIM(R9SMN) + '"'
008300060713    ***
008400060713     C                   EVAL      O19 = O@
008500060713     C                   EXCEPT    O19F
008600060713    ***
008700060713     C                   ENDSR
008800060713   S***S
008900060713     ORNWP017   EADD         O17F
009000060713     O                       O17                150
009100060713     ORNWP018   EADD         O18F
009200060713     O                       O18                150
009300060713     ORNWP019   EADD         O19F
009400060713     O                       O19                150
