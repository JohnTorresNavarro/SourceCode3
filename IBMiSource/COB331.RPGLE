000100120607     *** DATE RANGE TEST
000200120607     *** SSK
000300120607     ***
000400120607     *** TEST FOR VALID FROM DATE
000500120607     *** TEST FOR VALID TO DATE
000600120607     *** TEST FOR TO DATE LESS THAN OR EQUAL TO FROM DATE
000700120607     ***
000800120607     *** RESULT FLAG IS EITHER 'F' FOR FAIL OR 'P' FOR PASS
000900120607     ***
001000120607     ***
001100120607     ***
001200120607     ***
001300120607     D P@FRDATE        S              8S 0
001400120607     D P@TODATE        S              8S 0
001500120607     D P@RESULT        S              1A
001600130319     D FR#USA          S               D   DATFMT(*USA)
001700130319     D TO#USA          S               D   DATFMT(*USA)
001800120607     C     *ENTRY        PLIST
001900120607     C                   PARM                    P@FRDATE
002000120607     C                   PARM                    P@TODATE
002100120607     C                   PARM                    P@RESULT
002200120607      *
002300120607     C                   EVAL      P@RESULT = 'F'
002400120607      *
002500120607     C     *USA          TEST(DE)                P@FRDATE
002600120607     C                   IF        %ERROR
002700120607     C                   GOTO      $DONE
002800120607     C                   ENDIF
002900130319     C                   MOVE      P@FRDATE      FR#USA
003000120607      *
003100120607     C     *USA          TEST(DE)                P@TODATE
003200120607     C                   IF        %ERROR
003300120607     C                   GOTO      $DONE
003400120607     C                   ENDIF
003500130319     C                   MOVE      P@TODATE      TO#USA
003600120607      *
003700130319     C                   IF        TO#USA <= FR#USA
003800120607     C                   GOTO      $DONE
003900120607     C                   ENDIF
004000120607      *
004100120607     C                   EVAL      P@RESULT = 'P'
004200120607      *
004300120607     C     $DONE         TAG
004400120607     C                   RETURN
