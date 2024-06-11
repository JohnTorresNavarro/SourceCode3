000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Write flags to DBEDTL834 at end of process
000400000000      *
000500000000      *  (c)Copyright 2010 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - April 21, 2010
000800000000      *_________________________________________________________________________
000900100421     FDBEDTL834 UP   E             DISK
000901110407
000902110407     D Q_SSN           S              9A
000903110407     D Q_FLG           S              1A
000904110408     D ISO_DATE        S               D   DATFMT(*ISO)
001200100421
001201110407     D                 DS
001202110407     D WCDATE                         8
001203110407     D WNDATE                         8S 0 OVERLAY(WCDATE:1) inz
001204110407
001300000000      * Program status data structure
001400000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
003501110407
003502110407      * If end result is "R" check employment date change
003503110407     C                   Eval      D3FIL66  = ' '
003504110407     C                   If        D3SFX = '00' and
003505110407     C                             D3MNTYP = 'R'
003506110407     C                   Exsr      EMPDATCHG
003507110407     C                   End
003508110407      *___________________________________________________________________
003509110407      * Check employment date change
003510110407      *___________________________________________________________________
003511110407     C     EMPDATCHG     BEGSR
003512110407
003513110407      * Format Date
003514110407     C     *Date         Mult      10000.0001    WNDATE
003515110408     C     *YMD          MOVE      WNDATE        ISO_DATE
003516110408     C     ISO_DATE      SUBDUR    7:*DAYS       ISO_DATE
003517110408     C     *ISO          MOVE      ISO_DATE      WNDATE
003518110407      *
003519110407      * Check Member emp date changed
003520110407     C                   Eval      Q_FLG = ' '
003521110407     C                   Eval      D3FIL66  = ' '
003522110407     C                   Move      D3SUB         Q_SSN
003523110407     C                   Call      'DW311M16C'
003524110407     C                   Parm                    Q_SSN
003525110407     C                   Parm                    WCDATE
003526110407     C                   Parm                    Q_FLG             1
003527110407      *
003528110407     C                   If        Q_FLG = 'Y'
003529110407     C                   Eval      D3FIL66  = 'Y'
003530110407     C                   Update    DBEDTLR
003531110407     C                   End
003532110407      *
003533110407     C                   ENDSR
