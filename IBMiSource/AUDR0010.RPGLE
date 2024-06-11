000100070724     FACCMST    IPE  E           K DISK
000200070724     FMEMAC#    IF   E           K DISK
000300070724     FT200      O  A F  200        DISK
000400070724   X***X
000500070724     D OUT@            S            200A
000600070724   X***X
000700070724     C                   IF        ATRMDT = 0
000800070724     C     KL#           CHAIN     MEMBR
000900070724     C                   IF        NOT %FOUND(MEMAC#)
001000070724     C                   EVAL      OUT@ = '"' + %CHAR(ACTRST) + '","' +
001100070724     C                             %CHAR(ACSUB#) + '","' + %CHAR(ACACCT) + '","'
001200070724     C                             + %TRIM(ACNAM1) + '"'
001300070724     C                   EXCEPT    OUTF
001400070724     C                   ENDIF
001500070724     C                   ENDIF
001600070724   S***S
001700070724     C     *INZSR        BEGSR
001800070724    ***
001900070724     C     KL#           KLIST
002000070724     C                   KFLD                    ACTRST
002100070724     C                   KFLD                    ACSUB#
002200070724     C                   KFLD                    ACACCT
002300070724    ***
002400070724     C                   EVAL      OUT@ = '"AUDIT OF ACTIVE ACCOUNT VERSUS ME' +
002500070724     C                             'MBERSHIP"'
002600070724     C                   EXCEPT    OUTF
002700070724    ***
002800070724     C                   EVAL      OUT@ = ','
002900070724     C                   EXCEPT    OUTF
003000070724    ***
003100070724     C                   EVAL      OUT@ = '"ACTIVE ACCOUNTS WITHOUT MEMBER RE' +
003200070724     C                             'CORDS IN THE SYSTEM"'
003300070724     C                   EXCEPT    OUTF
003400070724    ***
003500070724     C                   EVAL      OUT@ = ','
003600070724     C                   EXCEPT    OUTF
003700070724    ***
003800070724     C                   EVAL      OUT@ = '"TRUST","SUBDIVISION","ACCOUNT NUM' +
003900070724     C                             'BER","ACCOUNT NAME"'
004000070724     C                   EXCEPT    OUTF
004100070724    ***
004200070724     C                   ENDSR
004300070724   S***S
004400070724     OT200      EADD         OUTF
004500070724     O                       OUT@               200
