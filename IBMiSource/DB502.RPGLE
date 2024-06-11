000100060203     FDB500WF   UPE  E           K DISK
000200060203     FMEMALTL1  IF   E           K DISK
000300060203     C     *LIKE         DEFINE    MAALTID       @A
000400060203     C                   IF        DDMRE = *BLANKS
000500060203     C                   EVAL      @A = DDSUB
000600060203     C     @A            CHAIN     MEMALTR
000700060203     C                   IF        %FOUND(MEMALTL1)
000800060203     C                   MOVE      MAMEMID       DDMRE
000900060203     C                   UPDATE    RDBEDOC
001000060203     C                   ENDIF
001100060203     C                   ENDIF
