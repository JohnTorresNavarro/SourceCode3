000100060203     FDB500WF   UPE  E           K DISK
000200051221     C     *LIKE         DEFINE    DDMRE         H@
000300051221     C     *LIKE         DEFINE    DDSUB         X@
000400051221     C                   IF        DDDPSQ = 0
000500051221     C                   EVAL      X@ = DDSUB
000600051221     C                   EVAL      H@ = DDMRE
000700051221     C                   ELSE
000800051221     C                   IF        DDSUB = X@
000900051221     C                   EVAL      DDMRE = H@
001000051221     C                   UPDATE    RDBEDOC
001100051221     C                   ENDIF
001200051221     C                   ENDIF
