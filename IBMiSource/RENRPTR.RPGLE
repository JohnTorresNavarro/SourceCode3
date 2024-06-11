000100220711     FREN834P   IPE  E           K DISK
000200220711     FRENCSVP   O  A F 2500        DISK
000300050823   X***X
000400220711     D @OUTPUT         S           1000A   INZ
000500051108     D @C              C                   CONST('","')
000600051108    ***
0007000704030025  *
0008002108050025  *
0009000811140250 D                 DS
0010002207110251 Dsaldatx          S             10
0011002207110251 Dsaldatn          S              8  0
0012000704030025  *
001300220711             saldatx = *blanks;
001400220711             if saldate <> *blanks;
001500220711     C                   move      saldate       saldatn
001600220711               saldatx = %Char(%date(saldatn) :*usa);
001700220705             endif;
0018002207050025  *
001900081114      *
002000220711     C                   if        relcd = 'EE'
002100220711     C                   CLEAR                   @OUTPUT
002200220711     C                   EVAL      @OUTPUT = '"' + %TRIM(groupnam) + '",' +
002300220711     C                             %TRIM(memid) + ',' +
002400220711     C                             %TRIM(lastname) + ',' +
002500220711     C                             %TRIM(firstname) + ',' +
002600220711     C                             %TRIM(cursalary) + ',' +
002700220711     C                             %TRIM(saldatx)
002800201006    * *
002900060315     C                   EXCEPT    OUTFA
003000220711     C                   Endif
003100201006   S* *
003200201006     C     *INZSR        BEGSR
003300201006    * *
003400220711     C                   EVAL      @OUTPUT = 'Group Name,' +
003500220705     C                             'Employee SSN,' +
003600220711     C                             'Member Last Name,' +
003700220711     C                             'Member First Name,' +
003800220711     C                             'Salary,' +
003900220711     C                             'Sal Eff DT'
004000201006    * *
004100201006     C                   EXCEPT    OUTFA
004200201006    * *
004300201006     C                   ENDSR
004400201006    * *
004500201006     C
004600060315    ***
004700220711     ORENCSVP   EADD         OUTFA
004800220711     O                       @OUTPUT           1000
