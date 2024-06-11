000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300200714    ? *  Description:  Password Update from repository
000400000000    ? *
000500061129    ? *  (c)Copyright 2006 by GBS, Inc.
000600200422    ? *
000700200714    ? * 07.14.2020 J.Allen
000800200422    ? *
000900000000    ? *___________________________________________________________________
001000200714     FOEREPOSLF IF   E           K Disk
001100200714     FOEUSERL2  UF   E           K Disk
001200080618
001300070719     D Today           s              8S 0 inz
001400070720
001500200714     C     *loval        Setll     OEUSERL2
001600200714     C                   Read      OEUSERL2
001700200714    ?C                   Dow       Not %Eof(OEUSERL2)
001800200714     C     OUUSER        chain     OEREPOSLF
001900200714    ?C                   if        %found(OEREPOSLF)
002000200714     C                   if        %trim(OUUSPW) <> %trim(RPASS)
002100200714     C                   eval      OUUSPW = %trim(RPASS)
002200200714     C                   eval      OUCHGU = 'PWUPDATE'
002300200714     C                   eval      OUCHDT = Today
002400111017     C                   Update    OEUSERR
002500200714     C                   End
002600111017     C                   End
002700200714     C                   Read      OEUSERL2
002800111017     C                   Enddo
002900200714
003000200714     C                   return
003100070718      *---------------------------------------------------------------*
003200070718     C     *inzsr        Begsr
003300200714     C     *date         mult      10000.0001    Today
003400070718     C                   Endsr
