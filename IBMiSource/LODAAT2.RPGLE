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
002800240201       //asuser = ' ';
002900240201     C****               If        %trim(ASUSER) = *blanks
003000240201     C****               Exsr      LoadSummaryAll
003100240201     C****               Else
003200240201     C                   Exsr      LoadSummary
003300240201     C****               End
003400081120
003500081120     C                   Return
003600000000      *___________________________________________________________________
003700081203      * Load Summary All Users
003800000000      *___________________________________________________________________
003900081203     C     LoadSummaryAllBEGSR
004000081120      *
004100081120     C     ASUSER        Setll     DW310JF1
004200081203     C                   Read      DW310JF1
004300081120     C                   Dow       not %eof(DW310JF1)
004400081120      *
004500081120     C     SOCSOC        Chain     MEMBER
004600081120     C                   If        %found(MEMBER)
004700081120     C                   Eval      SMNAME = %trim(MFNAME) + ' ' +
004800081120     C                                      %trim(MLNAME)
004900081121     C                   Eval      SMLNAM = %trim(MLNAME)
005000081120     C                   Else
005100081121     C                   Eval      SMNAME = *blanks
005200081121     C                   Eval      SMLNAM = *blanks
005300081120     C                   End
005400081120      *
005500081120     C                   Eval      SMSSNO = SOCSOC
005600081120     C                   Eval      SMACTC = ACTCOD
005700100419     C                   Eval      SMFLAG = QQFLAG
005800100419     C                   Eval      SMGRP# = %trim(GROUP#)
005900090716     C     QQFIXF        Chain     TRNFXCP
006000090716     C                   If        %found(TRNFXCP)
006100090716     C                   Eval      SMFIXF = 'Y'
006200090716     C                   Eval      SMFIXR = %trim(FCREAS)
006300090716     C                   Else
006400081120     C                   Eval      SMFIXF = QQFIXF
006500090716     C                   Eval      SMFIXR = *Blanks
006600090716     C                   End
006700240201       smuser = asuser;
006800240201     C****               Eval      SMUSER = %trim(QQUSER)
006900081120     C                   Eval      SMTEXT = %trim(ASTEXT)
007000081203     C                   Eval      SMDATE = QQDATE
007100081203     C                   Eval      SMRVWR = QQRVWR
007200110318      *
007300151005     C                   Exsr      GETGROUP
007400110318     C                   If        %trim(Show) = *Blanks
007500081120     C     SMSSNO        Setll     TRNSUMP
007600081120     C                   If        not %equal(TRNSUMP)
007700081120     C                   Write     TRNSUMR
007800081120     C                   End
007900110318     C                   End
008000081120      *
008100081203     C                   Read      DW310JF1
008200081120     C                   Enddo
008300021024      *
008400000000     C                   ENDSR
008500081203      *___________________________________________________________________
008600081203      * Load Summary
008700081203      *___________________________________________________________________
008800081203     C     LoadSummary   BEGSR
008900081203      *
009000090518     C     ASUSER        Setgt     DW310JF1
009100090518     C     ASUSER        Readpe    DW310JF1
009200081203     C                   Dow       not %eof(DW310JF1)
009300081203      *
009400081203     C     SOCSOC        Chain     MEMBER
009500081203     C                   If        %found(MEMBER)
009600081203     C                   Eval      SMNAME = %trim(MFNAME) + ' ' +
009700081203     C                                      %trim(MLNAME)
009800081203     C                   Eval      SMLNAM = %trim(MLNAME)
009900081203     C                   Else
010000081203     C                   Eval      SMNAME = *blanks
010100081203     C                   Eval      SMLNAM = *blanks
010200081203     C                   End
010300081203      *
010400081203     C                   Eval      SMSSNO = SOCSOC
010500081203     C                   Eval      SMACTC = ACTCOD
010600081203     C                   Eval      SMFLAG = QQFLAG
010700100419     C                   Eval      SMGRP# = %trim(GROUP#)
010800090716     C     QQFIXF        Chain     TRNFXCP
010900090716     C                   If        %found(TRNFXCP)
011000090716     C                   Eval      SMFIXF = 'Y'
011100090716     C                   Eval      SMFIXR = %trim(FCREAS)
011200090716     C                   Else
011300090716     C                   Eval      SMFIXF = QQFIXF
011400090716     C                   Eval      SMFIXR = *Blanks
011500090716     C                   End
011600081203     C                   Eval      SMUSER = %trim(ASUSER)
011700081203     C                   Eval      SMTEXT = %trim(ASTEXT)
011800081203     C                   Eval      SMDATE = QQDATE
011900081203     C                   Eval      SMRVWR = QQRVWR
012000090115      *
012100090115     C     SMKEY         KLIST
012200090115     C                   KFLD                    SMSSNO
012300090115     C                   KFLD                    SMFLAG
012400110318      *
012500151005     C                   Exsr      GETGROUP
012600110318     C                   If        %trim(Show) = *Blanks
012700090518     C     SMSSNO        Setll     TRNSUMP
012800081203     C                   If        not %equal(TRNSUMP)
012900081203     C                   Write     TRNSUMR
013000110318     C                   End
013100081203     C                   End
013200081203      *
013300090518     C     ASUSER        Readpe    DW310JF1
013400081203     C                   Enddo
013500081203      *
013600081203     C                   ENDSR
013700151005      *___________________________________________________________________
013800151005      * Get Group
013900151005      *___________________________________________________________________
014000151005     C     GetGroup      BEGSR
014100151005      *
014200151005     C     GrtKey        Klist
014300151005     C                   Kfld                    TRUST
014400151005     C                   Kfld                    SUBNO
014500151005     C                   Kfld                    PLAN#
014600151005      *
014700151005     C                   Eval      show = *blanks
014800151005      *
014900151005      * Get Plan Group
015000151005     C     GrtKey        Setll     GRAT24
015100151005     C     GrtKey        Reade     GRAT24
015200151005     C                   Dow       not %eof(GRAT24)
015300151005      * GBS Date Logic
015400151005     C                   If        G_frmdat <> G_todat
015500151005      *
015600151005     C                   if        ENRLDT >= G_frmdat and
015700151005     C                             ENRLDT <= G_todat
015800151005      *
015900151005     C                   If        %trim(G_group#) = 'PENDING'
016000151005     C                   Eval      show = 'N'
016100151005     C                   Leave
016200151005     C                   end
016300151005      *
016400151005     C                   end
016500151005     C                   end
016600151005     C     GrtKey        Reade     GRAT24
016700151005     C                   Enddo
016800151005      *
016900151005     C                   ENDSR
