000200000000      *_________________________________________________________________________
000300060104      *
000500111021      *  Description:  Print Benefit Summary Listing
000600000000      *
000700110208      *  (c)Copyright 2011 by GBS, Inc.
000800000000      *
000900111021      *    Created by:  JALLEN - Oct 21, 2011
001000000000      *_________________________________________________________________________
001001111021     FBENSUM10F IF   E             DISK
001002111021     FMEMBER    IF   E           K DISK
001003110420     FACCMST    IF   E           K DISK
001500111021     FPRTBSMP   O    E             PRINTER oflind(*in91)
001600031107      *
001700050330     D Period          s              2    inz(*HIVAL)
001800031107     D Count           S              5S 0
001801110420     D TRS             S              3S 0
001802110420     D SUB             S              3S 0
001803111021     D ACT             S              4S 0
001804111021     D SSN             S              9S 0
002201110411
002202110420     C     *Entry        Plist
002203110420     C                   Parm                    WITRS             3
002204110420     C                   Parm                    WISUB             3
002205111021     C                   Parm                    WIACT             4
002206111021     C                   Parm                    WISSN             9
002207111021     C                   Parm                    WIHEAD           10
002208110420
002209110420     C                   Move      WITRS         TRS
002210110420     C                   Move      WISUB         SUB
002211111021     C                   Move      WIACT         ACT
002212111021     C                   Move      WISSN         SSN
002213110420
002214110420     C     TRSKEY        Klist
002215110420     C                   Kfld                    TRS
002216110420     C                   Kfld                    SUB
002217110420     C                   Kfld                    ACT
002223110420
002224111021     C     TRSKEY        Chain     ACCMST
002225111021     C                   Eval      WPACCN = %trim(ACNAM1)
002226111021
002227111021     C     SSN           Chain     MEMBER
002228111021     C                   If        %trim(MMI) = *blanks
002229111021     C                   Eval      WPNAME = %trim(MFNAME) + ' ' +
002230111021     C                                      %trim(MLNAME)
002231111021     C                   Else
002232111021     C                   Eval      WPNAME = %trim(MFNAME) + ' ' +
002233111021     C                                      %trim(MMI) + ' ' +
002234111021     C                                      %trim(MLNAME)
002235111021     C                   End
002236111021     C                   Eval      WPSSN = MBSSNO
002237111021
002238111021     C     1             Setll     BENSUM10F
002239111021     C                   Read      BENSUM10F
002240111021     C                   Dow       not %eof(BENSUM10F)
003300030422    ?C                   Exsr      ChkOvf
003301111021     C                   Movel     BQFLAT        WPFLAT
005700111021    ?C                   Write     PRTSUM
005701111021    ?C                   Move      *on           *inu1
005901111021     C                   Read      BENSUM10F
005902110420     C                   Enddo
006101110209
006301110420     C                   Eval      *INLR = *ON
006302110420     C                   Return
007900030422    ? *___________________________________________________________________
008000030422    ? * Check Overflow
008100030422    ? *___________________________________________________________________
008200030422    ?C     ChkOvf        Begsr
008300030422B001?C     *in91         Ifeq      *On
008400030422 001?C                   Time                    WPTIM
008401111021 001?C                   Write     PRTHDR
008500111021 001?C                   Write     PRTBSM
008600030422 001?C                   Move      *Off          *In91
008700030422E001?C                   Endif
008800030422    ?C                   Endsr
008900030422      *___________________________________________________________________
009000030422      * Program initialization
009100030422      *___________________________________________________________________
009200030422     C     *INZSR        BEGSR
009300030422      *
009500030422    ?C                   Move      *on           *in91
009600111021     C                   Eval      WQPGMN =      'PRTBSM'
009800030422    ?C                   Endsr
