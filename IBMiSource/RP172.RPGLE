000100011026     FTRSMST    IF   E           K DISK    USROPN
000200011026     D #TRST           S              3S 0
000300011012     C     *ENTRY        PLIST
000400011026     C                   PARM                    @TRUST            3
000500011012     C                   PARM                    @VALID            1
000600011012     C                   MOVE      'N'           @VALID
000700011026     C                   IF        @TRUST <> *BLANKS AND @TRUST <> '000'
000800011026     C                   MOVE      @TRUST        #TRST
000900011026     C                   OPEN      TRSMST
001000011026     C     #TRST         CHAIN(N)  TRSMSR
001100011026     C                   IF        %FOUND(TRSMST)
001200011012     C                   MOVE      'Y'           @VALID
001300011012     C                   ENDIF
001400011026     C                   CLOSE     TRSMST
001500011012     C                   ENDIF
001600011012     C                   RETURN
