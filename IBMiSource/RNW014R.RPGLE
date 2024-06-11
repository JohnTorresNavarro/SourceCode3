000100101101     FCARMSTP   IPE  E             DISK
000200101101     FRNW01GRW  IF A E           K DISK
000300101101     C     CMCAID        CHAIN     RNW01GR
000400101101     C                   IF        NOT %FOUND(RNW01GRW)
000500101101     C                   EVAL      RGCAID = CMCAID
000600101101     C                   EVAL      RGRENEW = 'N'
000700101101     C                   WRITE     RNW01GR
000800101101     C                   ENDIF
