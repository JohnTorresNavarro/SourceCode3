000100980902      *------------------------------------------------------------------------*
000200050114     FEGITRXD   IP   F  400        DISK
000300050114     FEGITRXT   O  A F  400        DISK
000400990617     D                UDS
000500990617     D  LDADAT               248    255  0
000600050114     IEGITRXD   NS  01
000700981020     I                                  1  200  CR200
000800981020     I                                201  400  CR400
000900980710      *
001000990617     C                   ADD       1             RECCNT            7 0
001100990617      *
001200990617     C     *INZSR        BEGSR
001300990617     C                   EXCEPT    HEADER
001400990617     C                   ENDSR
001500980713      *
001600050114     OEGITRXT   EADD         HEADER
001700980713     O                                            1 'H'
001800990617     O                       LDADAT               9
001900990617     O                       LDADAT              17
002000980713     O                                           25 '00000001'
002100980713     O                                           26 'P'
002200050114     O                                           30 'A4  '
002300050114     O                                           34 'SE  '
002400980713     O                                          399 'HEADER '
002500980713     O                                          400 'X'
002600990617     O          DADD 01
0027009810201    O                       CR200              200
0028009810201    O                       CR400              400
002900990617     O          TADD    LR
003000990617     O                                            1 'T'
003100990617     O                       RECCNT               8
003200990617     O                                          399 'TRAILER'
003300990617     O                                          400 'X'
