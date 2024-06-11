000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Remove Target Members - ADD All Accounts
000500000000      *
000600000000      *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - April 21, 2004
000900000000      *_________________________________________________________________________
001000040421     FACCMST    IF   E           K DISK
001002040421     FACCMSTP   IF   E           K DISK
001003040421     FBRKPRDL2  IF   E           K DISK
001004040421     FACCTAR    O  A E           K DISK
001005040421      *
001006040421     D NUMTRM          S              8S 0
001007040421     D NUMZIP          S              9S 0
001008040421
001009040421     D ADACCT          DS
001010040421     D ACTRST                  1      3S 0 inz
001011040421     D ACSUB#                  4      6S 0 inz
001012040421     D ACACCT                  7     10S 0 inz
001013040421
001014040421      *
001015040421      * Fully Ins.
001016040421      *
001100040421     C     *loval        Setll     ACCMST
001200040421     C                   Read      ACCMST
001300040421     C                   Dow       (not %eof(ACCMST))
001400040421     C                   Eval      TARFLAG = 'F'
001500040421     C                   z-add     azip          numzip
001600040421     C     atrmdt        Mult      10000.0001    numtrm
001700040421     C                   move      numzip        tarzip
001800040421     C                   move      numtrm        tarterm
001900040421     C                   Write     TARR
002000040421     C                   Read      ACCMST
002100040421     C                   Enddo
002201040421      *
002202040421      * General Agency System
002203040421      *
002204040421     C                   Clear                   TARR
002205040421     C     *loval        Setll     ACCMSTP
002206040421     C                   Read      ACCMSTP
002207040421     C                   Dow       (not %eof(ACCMSTP))
002208040421     C                   Eval      TARFLAG = 'G'
002209040421     C                   z-add     azip          numzip
002210040421     C                   move      numzip        tarzip
002211040421     C                   move      adtrdt        numtrm
002212040421     C                   z-add     numtrm        atrmdt
002213040421     C     numtrm        Mult      10000.0001    numtrm
002214040421     C                   move      numtrm        tarterm
002215040421     C                   move      adaddt        numtrm
002216040421     C                   z-add     numtrm        gbsbdt
002217040421      *
002218040421     C                   if        gbsbdt = 99991231
002219040421     C                   Eval      gbsbdt = 0
002220040421     C                   End
002221040421     C                   if        atrmdt = 99991231
002222040421     C                   Eval      atrmdt = 0
002223040421     C                   Eval      TarTerm = *blanks
002224040421     C                   End
002225040421      *
002226040421     C                   Eval      ACNAM1 = %TRIM(ADNAME)
002227040421     C                   Eval      AADDR1 = %TRIM(ADADD1)
002228040421     C                   Eval      AADDR2 = %TRIM(ADADD2)
002229040421     C                   Eval      ACITY  = %TRIM(ADCITY)
002230040421     C                   Eval      ASTATE = %TRIM(ADSTAT)
002231040421     C     ' ':'0'       xlate     ADZIP         ADZIP
002232040421     C                   Move      ADZIP         AZIP
002233040421     C                   Eval      CONTAC = %TRIM(ADCNTC)
002234040421     C                   z-add     adbenr        totemp
002235040421      *
002236040421     C                   Write(e)  TARR
002237040421     C                   Read      ACCMSTP
002238040421     C                   Enddo
002239040421      *
002300040421     C                   Eval      *INLR = *ON
002400040421     C                   Return
