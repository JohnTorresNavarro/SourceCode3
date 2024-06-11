000100061114     FIOFTPSC0  UP   E             DISK
000200061114      *
000300061114     D                 DS
000400061114     D f80                     1     80
000500131120     D  f8023                  1     23
000600131120     D  f80dat                24     29
000700131120     D  f80txt                30     34
000800061114      *
0009000611140053 D                 DS
0010001311200054 D  putstmt        C                   'put qs36f/ddgcmbp delfi'
001100061114      *
001200131120     C                   if        f8023 = putstmt
001300020328     C                   MOVE      UDATE         #TDAY             6 0
001400020328     C                   MOVE      #TDAY         @TDAY             6
001500061114     C                   eval      f80dat = @TDAY
001600061114     C                   eval      f80txt = '.txt'
001700061114     C                   update    RIOFTPSC
001800061114     C                   ENDif
