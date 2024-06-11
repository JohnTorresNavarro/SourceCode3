000100070724     FACCMST    IPE  E           K DISK
000200070724     FMEMAC#    IF   E           K DISK
000300070724     FT200      O  A F  200        DISK
000400070724   X***X
000500070724     D OUT@            S            200A
000600070724   X***X
000700070724     C                   IF        ATRMDT = 0
000800070724    ***
000900070724     C     KL#           CHAIN     MEMBR
001000070724     C                   IF        %FOUND(MEMAC#)
001100070724    ***
001200070724     C                   MOVE      *ZEROS        #C                7 0
001300070724     C     KL#           SETLL     MEMBR
001400070724     C                   DOU       %EOF(MEMAC#)
001500070724     C     KL#           READE     MEMBR
001600070724     C                   IF        NOT %EOF(MEMAC#) AND TERMDT = 0
001700070724    ***
001800070724     C                   ADD       1             #C
001900070724    ***
002000070724     C                   ENDIF
002100070724     C                   ENDDO
002200070724    ***
002300070724     C                   IF        #C = 0
002400070724     C                   EVAL      OUT@ = '"' + %CHAR(ACTRST) + '","' +
002500070724     C                             %CHAR(ACSUB#) + '","' + %CHAR(ACACCT) + '","'
002600070724     C                             + %TRIM(ACNAM1) + '"'
002700070724     C                   EXCEPT    OUTF
002800070724     C                   ENDIF
002900070724    ***
003000070724     C                   ENDIF
003100070724     C                   ENDIF
003200070724   S***S
003300070724     C     *INZSR        BEGSR
003400070724    ***
003500070724     C     KL#           KLIST
003600070724     C                   KFLD                    ACTRST
003700070724     C                   KFLD                    ACSUB#
003800070724     C                   KFLD                    ACACCT
003900070724    ***
004000070724     C                   EVAL      OUT@ = '"AUDIT OF ACTIVE ACCOUNT VERSUS ME' +
004100070724     C                             'MBERSHIP"'
004200070724     C                   EXCEPT    OUTF
004300070724    ***
004400070724     C                   EVAL      OUT@ = ','
004500070724     C                   EXCEPT    OUTF
004600070724    ***
004700070724     C                   EVAL      OUT@ = '"ACTIVE ACCOUNTS WITH MEMBERSHIP, ' +
004800070724     C                             'BUT ALL MEMBERS ARE TERMED"'
004900070724     C                   EXCEPT    OUTF
005000070724    ***
005100070724     C                   EVAL      OUT@ = ','
005200070724     C                   EXCEPT    OUTF
005300070724    ***
005400070724     C                   EVAL      OUT@ = '"TRUST","SUBDIVISION","ACCOUNT NUM' +
005500070724     C                             'BER","ACCOUNT NAME"'
005600070724     C                   EXCEPT    OUTF
005700070724    ***
005800070724     C                   ENDSR
005900070724   S***S
006000070724     OT200      EADD         OUTF
006100070724     O                       OUT@               200
