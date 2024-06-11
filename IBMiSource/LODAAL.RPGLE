000100000000      *_________________________________________________________________________
000200000000      *
000300081120      *  Description:  Load WRKAAL TRNUSRP Temp file
000400000000      *
000500081120      *  (c)Copyright 2008 by GBS, Inc.
000600000000      *
000700081120      *    Created by:  JALLEN - Nov 20, 2008
000800000000      *_________________________________________________________________________
000900021024      *
001000090602     FTRNMITLF  IP   E           K DISK    Infds(DBFD)
001100090602     FCARMST    IF   E           K DISK
001200081120     FTRNUSRP   O  A E             DISK
001300090602      *
001400090602     D XXFLAG          S              1    inz(' ')
001500090602      *
001600021106      * File DS
001700021106     D DBFD          E DS                  EXTNAME(IODBFD)
001800021106      * Program status data structure
001900000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002000000000      *
002100090602     ITRNMIR        01
002200081120     I                                          QQUSER        L2
002300090602
002400090602      * Check DBE
002500090602     C   01              IF        DLTCOD =  'A' and
002600090828     C                             QQFLAG <> ' ' and
002700090828     C                             QQUSER <> ' '
002800090602     C     CARCOD        Chain     CARMST
002900090602     C                   If        %found(CARMST)
003000090602     C                   If        CARBC = 'D'
003100090602     C                   Eval      XXFLAG =  'Y'
003200090602     C                   End
003300090602     C                   End
003400090602     C                   End
003500090602
003600081120      * Load User
003700081120     CL2                 Exsr      LoadUser
003800000000      *___________________________________________________________________
003900081120      * Load User
004000000000      *___________________________________________________________________
004100081120     C     LoadUser      BEGSR
004200090602      *
004300090602     C                   IF        XXFLAG = 'Y'
004400081120     C                   CALL      'RTVAALCL'
004500081120     C                   PARM                    QQUSER
004600081120     C                   PARM                    WWTEXT           50
004700021024      *
004800081120     C                   Eval      ASTEXT = %trim(WWTEXT)
004900081120     C                   Eval      ASUSER = %trim(QQUSER)
005000081120     C                   Write     TRNUSRR
005100090602     C                   END
005200090602      *
005300090602      * Reset Next User
005400090602     C                   Eval      XXFLAG =  ' '
005500090602      *
005600000000     C                   ENDSR
