000100000000      *_________________________________________________________________________
000200000000      *
000300091006      *  Description:  Process SYNC TRNMIT Flags 'R'
000400000000      *
000500090518      *  (c)Copyright 2009 by GBS, Inc.
000600000000      *
000700090518      *    Created by:  JALLEN - May 18, 2009
000800000000      *_________________________________________________________________________
000900021024      *
001000090518     FDW310JF2  IP   E           K DISK
001100090518     FTRNMIT1   UF   E           K DISK    rename(TRNMIR:TRNUPD)
001200170203
001300170203      * Program status data structure
001400170203     D PGMD          ESDS                  EXTNAME(IOPGMD)
001500090518
001600090518      *
001700090518     IJOINR         01
001800090518     I                                          SOCSOC        L2
001900090518
002000090518      * Process flags
002100091006     CL2                 Exsr      SyncFlags
002200090518      *___________________________________________________________________
002300090518      * Sync flags to latest status
002400090518      *___________________________________________________________________
002500090518     C     SyncFlags     BEGSR
002600090518      *
002700090518     C     SOCSOC        Setll     TRNMIT1
002800090518     C     SOCSOC        Reade     TRNMIT1
002900090518     C                   Dow       not %eof(TRNMIT1)
003000090518      *
003100090518     C                   If        TRNBID = *BLANKS  AND
003200091006     C                             DLTCOD = 'A'      AND
003300091006     C                             QQFLAG = 'H'
003400170203     C                   Eval      QQFLAG = 'R'
003500170203     C                   Eval      QQRVWR = WQUSRN
003600090518     C                   Update    TRNUPD
003700090518     C                   End
003800081121      *
003900090518     C     SOCSOC        Reade     TRNMIT1
004000090518     C                   Enddo
004100081121      *
004200081121     C                   ENDSR
