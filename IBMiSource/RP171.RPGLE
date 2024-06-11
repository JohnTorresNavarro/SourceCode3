000100011012     C     *ENTRY        PLIST
000200011012     C                   PARM                    @DATE             8
000300011012     C                   PARM                    @VALID            1
000400011012     C                   MOVE      'N'           @VALID
000500011012     C                   IF        @DATE <> *BLANKS AND @DATE <> '00000000'
000600011012     C                   MOVE      @DATE         #DATE             8 0
000700011012     C     *USA          TEST(DE)                #DATE
000800011012     C                   IF        NOT %ERROR
000900011012     C                   MOVE      'Y'           @VALID
001000011012     C                   ENDIF
001100011012     C                   ENDIF
001200011012     C                   RETURN
