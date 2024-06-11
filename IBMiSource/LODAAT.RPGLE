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
001300090716     FTRNFXCP   IF   E           K DISK
001400151005     FGRAT24    IF   E           K DISK    Prefix(G_)
001500110318
001600110318     D SHOW            S              1a   inz
001700081120
001800021106      * File DS
001900081120     D WIDTA         E DS                  EXTNAME(TRNUSRP)
002000081120
002100021106      * Program status data structure
002200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002300081120
002400081120     C     *ENTRY        PLIST
002500081120     C                   PARM                    WIDTA
002600081120
002700081120      * Load Summary
002800081203     C                   If        %trim(ASUSER) = *blanks
002900081203     C                   Exsr      LoadSummaryAll
003000081203     C                   Else
003100081120     C                   Exsr      LoadSummary
003200081203     C                   End
003300081120
003400081120     C                   Return
003500000000      *___________________________________________________________________
003600081203      * Load Summary All Users
003700000000      *___________________________________________________________________
003800081203     C     LoadSummaryAllBEGSR
003900081120      *
004000081120     C     ASUSER        Setll     DW310JF1
004100081203     C                   Read      DW310JF1
004200081120     C                   Dow       not %eof(DW310JF1)
004300081120      *
004400081120     C     SOCSOC        Chain     MEMBER
004500081120     C                   If        %found(MEMBER)
004600081120     C                   Eval      SMNAME = %trim(MFNAME) + ' ' +
004700081120     C                                      %trim(MLNAME)
004800081121     C                   Eval      SMLNAM = %trim(MLNAME)
004900081120     C                   Else
005000081121     C                   Eval      SMNAME = *blanks
005100081121     C                   Eval      SMLNAM = *blanks
005200081120     C                   End
005300081120      *
005400081120     C                   Eval      SMSSNO = SOCSOC
005500081120     C                   Eval      SMACTC = ACTCOD
005600100419     C                   Eval      SMFLAG = QQFLAG
005700100419     C                   Eval      SMGRP# = %trim(GROUP#)
005800090716     C     QQFIXF        Chain     TRNFXCP
005900090716     C                   If        %found(TRNFXCP)
006000090716     C                   Eval      SMFIXF = 'Y'
006100090716     C                   Eval      SMFIXR = %trim(FCREAS)
006200090716     C                   Else
006300081120     C                   Eval      SMFIXF = QQFIXF
006400090716     C                   Eval      SMFIXR = *Blanks
006500090716     C                   End
006600081203     C                   Eval      SMUSER = %trim(QQUSER)
006700081120     C                   Eval      SMTEXT = %trim(ASTEXT)
006800081203     C                   Eval      SMDATE = QQDATE
006900081203     C                   Eval      SMRVWR = QQRVWR
007000110318      *
007100151005     C                   Exsr      GETGROUP
007200110318     C                   If        %trim(Show) = *Blanks
007300081120     C     SMSSNO        Setll     TRNSUMP
007400081120     C                   If        not %equal(TRNSUMP)
007500081120     C                   Write     TRNSUMR
007600081120     C                   End
007700110318     C                   End
007800081120      *
007900081203     C                   Read      DW310JF1
008000081120     C                   Enddo
008100021024      *
008200000000     C                   ENDSR
008300081203      *___________________________________________________________________
008400081203      * Load Summary
008500081203      *___________________________________________________________________
008600081203     C     LoadSummary   BEGSR
008700081203      *
008800090518     C     ASUSER        Setgt     DW310JF1
008900090518     C     ASUSER        Readpe    DW310JF1
009000081203     C                   Dow       not %eof(DW310JF1)
009100081203      *
009200081203     C     SOCSOC        Chain     MEMBER
009300081203     C                   If        %found(MEMBER)
009400081203     C                   Eval      SMNAME = %trim(MFNAME) + ' ' +
009500081203     C                                      %trim(MLNAME)
009600081203     C                   Eval      SMLNAM = %trim(MLNAME)
009700081203     C                   Else
009800081203     C                   Eval      SMNAME = *blanks
009900081203     C                   Eval      SMLNAM = *blanks
010000081203     C                   End
010100081203      *
010200081203     C                   Eval      SMSSNO = SOCSOC
010300081203     C                   Eval      SMACTC = ACTCOD
010400081203     C                   Eval      SMFLAG = QQFLAG
010500100419     C                   Eval      SMGRP# = %trim(GROUP#)
010600090716     C     QQFIXF        Chain     TRNFXCP
010700090716     C                   If        %found(TRNFXCP)
010800090716     C                   Eval      SMFIXF = 'Y'
010900090716     C                   Eval      SMFIXR = %trim(FCREAS)
011000090716     C                   Else
011100090716     C                   Eval      SMFIXF = QQFIXF
011200090716     C                   Eval      SMFIXR = *Blanks
011300090716     C                   End
011400081203     C                   Eval      SMUSER = %trim(ASUSER)
011500081203     C                   Eval      SMTEXT = %trim(ASTEXT)
011600081203     C                   Eval      SMDATE = QQDATE
011700081203     C                   Eval      SMRVWR = QQRVWR
011800090115      *
011900090115     C     SMKEY         KLIST
012000090115     C                   KFLD                    SMSSNO
012100090115     C                   KFLD                    SMFLAG
012200110318      *
012300151005     C                   Exsr      GETGROUP
012400110318     C                   If        %trim(Show) = *Blanks
012500090518     C     SMSSNO        Setll     TRNSUMP
012600081203     C                   If        not %equal(TRNSUMP)
012700081203     C                   Write     TRNSUMR
012800110318     C                   End
012900081203     C                   End
013000081203      *
013100090518     C     ASUSER        Readpe    DW310JF1
013200081203     C                   Enddo
013300081203      *
013400081203     C                   ENDSR
013500151005      *___________________________________________________________________
013600151005      * Get Group
013700151005      *___________________________________________________________________
013800151005     C     GetGroup      BEGSR
013900151005      *
014000151005     C     GrtKey        Klist
014100151005     C                   Kfld                    TRUST
014200151005     C                   Kfld                    SUBNO
014300151005     C                   Kfld                    PLAN#
014400151005      *
014500151005     C                   Eval      show = *blanks
014600151005      *
014700151005      * Get Plan Group
014800151005     C     GrtKey        Setll     GRAT24
014900151005     C     GrtKey        Reade     GRAT24
015000151005     C                   Dow       not %eof(GRAT24)
015100151005      * GBS Date Logic
015200151005     C                   If        G_frmdat <> G_todat
015300151005      *
015400151005     C                   if        ENRLDT >= G_frmdat and
015500151005     C                             ENRLDT <= G_todat
015600151005      *
015700151005     C                   If        %trim(G_group#) = 'PENDING'
015800151005     C                   Eval      show = 'N'
015900151005     C                   Leave
016000151005     C                   end
016100151005      *
016200151005     C                   end
016300151005     C                   end
016400151005     C     GrtKey        Reade     GRAT24
016500151005     C                   Enddo
016600151005      *
016700151005     C                   ENDSR
