000100000000      *_________________________________________________________________________
000200000000      *
000300081120      *  Description:  Load WRKAAT TRNSUMP Temp file
000400000000      *
000500081120      *  (c)Copyright 2008 by GBS, Inc.
000600000000      *
000700081120      *    Created by:  JALLEN - Nov 20, 2008
000800000000      *_________________________________________________________________________
000900021024      *
001000081120     FDW310JF1  IF   E           K DISK
001100081120     FMEMBER    IF   E           K DISK
001200090716     FTRNSUMP   IF A E           K DISK
001201100621     FTRNFXCP   IF   E           K DISK
001202100621     FTRNMITL5  IF   E           K DISK    RENAME(TRNMIR:TRNL5R)
001300100621     F                                     PREFIX(L5_)
001301110321     FTEMPG#    If   e           k disk
001302110321
001303110321     D SHOW            S              1a   inz
001400081120
001500021106      * File DS
001600081120     D WIDTA         E DS                  EXTNAME(TRNUSRP)
001700081120
001800021106      * Program status data structure
001900000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002000081120
002100081120     C     *ENTRY        PLIST
002200081120     C                   PARM                    WIDTA
002300081120
002400081120      * Load Summary
002500081203     C                   If        %trim(ASUSER) = *blanks
002600081203     C                   Exsr      LoadSummaryAll
002700081203     C                   Else
002800081120     C                   Exsr      LoadSummary
002900081203     C                   End
003000081120
003100081120     C                   Return
003200000000      *___________________________________________________________________
003300081203      * Load Summary All Users
003400000000      *___________________________________________________________________
003500081203     C     LoadSummaryAllBEGSR
003600081120      *
003700081120     C     ASUSER        Setll     DW310JF1
003800081203     C                   Read      DW310JF1
003900081120     C                   Dow       not %eof(DW310JF1)
004000081120      *
004100081120     C     SOCSOC        Chain     MEMBER
004200081120     C                   If        %found(MEMBER)
004300081120     C                   Eval      SMNAME = %trim(MFNAME) + ' ' +
004400081120     C                                      %trim(MLNAME)
004500081121     C                   Eval      SMLNAM = %trim(MLNAME)
004600081120     C                   Else
004700081121     C                   Eval      SMNAME = *blanks
004800081121     C                   Eval      SMLNAM = *blanks
004900081120     C                   End
005000081120      *
005100081120     C                   Eval      SMSSNO = SOCSOC
005200081120     C                   Eval      SMACTC = ACTCOD
005300100419     C                   Eval      SMFLAG = QQFLAG
005400100419     C                   Eval      SMGRP# = %trim(GROUP#)
005500090716     C     QQFIXF        Chain     TRNFXCP
005600090716     C                   If        %found(TRNFXCP)
005700090716     C                   Eval      SMFIXF = 'Y'
005800090716     C                   Eval      SMFIXR = %trim(FCREAS)
005900090716     C                   Else
006000081120     C                   Eval      SMFIXF = QQFIXF
006100090716     C                   Eval      SMFIXR = *Blanks
006200090716     C                   End
006300081203     C                   Eval      SMUSER = %trim(QQUSER)
006400081120     C                   Eval      SMTEXT = %trim(ASTEXT)
006500081203     C                   Eval      SMDATE = QQDATE
006600081203     C                   Eval      SMRVWR = QQRVWR
006700081120      *
006702110321     C                   Eval      Show = *blanks
006703110321     C                   If        %subst(GROUP#:1:4) = 'TEMP'
006704110321     C                   Eval      Show = 'N'
006705110321     C     GROUP#        Chain     TEMPG#
006706110321     C                   If        %found(TEMPG#)      and
006707110321     C                             %trim(TEREALG#) <> *Blanks
006708110321     C                   Eval      SMGRP# = %trim(TEREALG#)
006709110321     C                   Eval      Show = *blanks
006710110321     C                   End
006711110321     C                   End
006712110321      *
006713110321     C                   If        %trim(Show) = *Blanks
006800081120     C     SMSSNO        Setll     TRNSUMP
006900081120     C                   If        not %equal(TRNSUMP)
006901100621     C                   Exsr      GETUSER
007000081120     C                   Write     TRNSUMR
007001110321     C                   End
007100081120     C                   End
007200081120      *
007300081203     C                   Read      DW310JF1
007400081120     C                   Enddo
007500021024      *
007600000000     C                   ENDSR
007700081203      *___________________________________________________________________
007800081203      * Load Summary
007900081203      *___________________________________________________________________
008000081203     C     LoadSummary   BEGSR
008100081203      *
008200090518     C     ASUSER        Setgt     DW310JF1
008300090518     C     ASUSER        Readpe    DW310JF1
008400081203     C                   Dow       not %eof(DW310JF1)
008500081203      *
008600081203     C     SOCSOC        Chain     MEMBER
008700081203     C                   If        %found(MEMBER)
008800081203     C                   Eval      SMNAME = %trim(MFNAME) + ' ' +
008900081203     C                                      %trim(MLNAME)
009000081203     C                   Eval      SMLNAM = %trim(MLNAME)
009100081203     C                   Else
009200081203     C                   Eval      SMNAME = *blanks
009300081203     C                   Eval      SMLNAM = *blanks
009400081203     C                   End
009500081203      *
009600081203     C                   Eval      SMSSNO = SOCSOC
009700081203     C                   Eval      SMACTC = ACTCOD
009800081203     C                   Eval      SMFLAG = QQFLAG
009900100419     C                   Eval      SMGRP# = %trim(GROUP#)
010000090716     C     QQFIXF        Chain     TRNFXCP
010100090716     C                   If        %found(TRNFXCP)
010200090716     C                   Eval      SMFIXF = 'Y'
010300090716     C                   Eval      SMFIXR = %trim(FCREAS)
010400090716     C                   Else
010500090716     C                   Eval      SMFIXF = QQFIXF
010600090716     C                   Eval      SMFIXR = *Blanks
010700090716     C                   End
010800081203     C                   Eval      SMUSER = %trim(ASUSER)
010900081203     C                   Eval      SMTEXT = %trim(ASTEXT)
011000081203     C                   Eval      SMDATE = QQDATE
011100081203     C                   Eval      SMRVWR = QQRVWR
011200090115      *
011300090115     C     SMKEY         KLIST
011400090115     C                   KFLD                    SMSSNO
011500090115     C                   KFLD                    SMFLAG
011600081203      *
011602110321     C                   Eval      Show = *blanks
011603110321     C                   If        %subst(GROUP#:1:4) = 'TEMP'
011604110321     C                   Eval      Show = 'N'
011605110321     C     GROUP#        Chain     TEMPG#
011606110321     C                   If        %found(TEMPG#)      and
011607110321     C                             %trim(TEREALG#) <> *Blanks
011608110321     C                   Eval      SMGRP# = %trim(TEREALG#)
011609110321     C                   Eval      Show = *blanks
011610110321     C                   End
011611110321     C                   End
011612110321      *
011613110321     C                   If        %trim(Show) = *Blanks
011700090518     C***  SMKEY         Setll     TRNSUMP
011800090518     C     SMSSNO        Setll     TRNSUMP
011900081203     C                   If        not %equal(TRNSUMP)
012000081203     C                   Write     TRNSUMR
012001110321     C                   End
012100081203     C                   End
012200081203      *
012300090518     C     ASUSER        Readpe    DW310JF1
012400081203     C                   Enddo
012500081203      *
012501100621     C                   ENDSR
012502100621      *___________________________________________________________________
012503100621      * Get USER
012504100621      *___________________________________________________________________
012505100621     C     GetUser       BEGSR
012506100621      *
012507100621     C     SOCSOC        Setll     TRNMITL5
012508100621     C     SOCSOC        Reade     TRNMITL5
012509100621     C                   Dow       not %eof(TRNMITL5)
012510100621     C                   If        %trim(TRNBID) = %trim(L5_TRNBID)
012511100621     C                   Eval      SMUSER = %trim(L5_QQUSER)
012512100621     C                   LeaveSR
012513100621     C                   End
012514100621     C     SOCSOC        Reade     TRNMITL5
012515100621     C                   Enddo
012600081203     C                   ENDSR
