0001000710010152 D                 DS
0002001401090153 D  parmkey                1     15
0003000710010154 D  Ptrust                 1      3  0
0004000710010154 D  Psub                   4      6  0
0005000710010154 D  Pplan                  7     10
0006000710010155 D  pab                   11     12  0
0007000710010156 D  pct                   13     15
000800140103
000900140103     D prem_aca        s              7  2
001000140103     D prem_count      s              3  0
001100140103     D idx             s              2  0
001200140103     D pssn            s              9  0
001300140109
001400140109     C                   EVAL      PTRUST = 591
001500140109     C                   EVAL      PSUB   = 001
001600140109     C                   EVAL      PPLAN  = 'FAL9'
001700140109     C                   EVAL      PAB    = 0
001800140109     C                   EVAL      parmssn = '217388945'
001900140109     C                   EVAL      parmseq = '00'
002000140109     C                   EVAL      parmeffymd = '20140201'
002100140109
002200140109     c                   CALL      'GETRATE'
002300071001     c                   parm                    parmkey          15
002400140106     c                   parm                    parmssn           9
002500140106     c                   parm                    parmseq           2
002600071001     c                   parm                    parmeffymd        8
002700071001     c                   parm                    parmbenamt        7
002800071001     c                   parm                    parmgroup        15
002900071001     c                   parm                    parmbilrte       11
003000071001     c                   parm                    parmnetrte       11
003100071001     c                   parm                    parmbilprem       7
003200071001     c                   parm                    parmnetprem       7
003300071001     c                   parm                    parmfound         1
003400001107
003500071001   9 C                   return
003600071001
