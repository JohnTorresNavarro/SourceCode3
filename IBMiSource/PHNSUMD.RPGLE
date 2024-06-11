000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Broker Carrier Grouper Summery load
000400000000      *
000500000000      *  (c)Copyright 2005 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 18, 2005
000800000000      *_________________________________________________________________________
000900050316     FDCOV22    IF   E           K DISK
001000050218     FPLNMST    IF   E           K DISK
001100050316     FDEPNDC    IF   E           K DISK
001200050316     FPHNSUMP   UF A E           K DISK
001300050218
001400050218     D DTA           E DS                  EXTNAME(ACCMST)
001500000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001600050218
001700050316      *
001800050316      * Find Active Depend Coverage
001900050316     C     DMCOV         setll     DCOV22
002000050316     C     DMCOV         reade     DCOV22
002100050316     C                   dow       not %eof(DCOV22)
002200050316     C                   if        CCANDT = 0
002300050316     C                   exsr      ActiveDepCov
002400050316     C                   end
002500050316     C     DMCOV         reade     DCOV22
002600050316     C                   enddo
002700050218     C                   return
002800050316      *___________________________________________________________________
002900050316      * Active Dep Coverage
003000050316      *___________________________________________________________________
003100050316     C     ActiveDepCov  BEGSR
003200050316     C     DPLAN         chain     PLNMST
003300050316     C                   if        %found
003400050316     C                   if        PCARR = 'PHN'
003500050316     C                   exsr      UpdateDepals
003600050316     C                   end
003700050316     C                   end
003800050316     C                   ENDSR
003900050316      *___________________________________________________________________
004000050316      * Update Totals
004100050316      *___________________________________________________________________
004200050316     C     UpdateDepals  BEGSR
004300050316     C     DKEY          Chain     DEPNDC
004400050316     C     DKEY          Chain     PHNSUMP
004500050316     C                   If        not %Found
004600050316     C                   eval      BCTRST    = ACTRST
004700050316     C                   eval      BCSUB#    = ACSUB#
004800050316     C                   eval      BCACCT    = 0
004900050316     C                   eval      BCSSNO    = SSNO
005000050316     C                   eval      BCNAME    = %trim(DLNAME) + ', ' +
005100050316     C                                         %trim(DFNAME)
005200050316     C                   Eval      BCDEPQ    = DPSEQ#
005300050316     C                   Write     PHNSUMR
005400050316     C                   End
005500050316     C                   ENDSR
005600000000      *___________________________________________________________________
005700000000      * Key Lists
005800000000      *___________________________________________________________________
005900050218     C     KLIST         BEGSR
006000050218     C     KMCOV         KLIST
006100050218     C                   KFLD                    ACTRST
006200050218     C                   KFLD                    ACSUB#
006300050218     C                   KFLD                    ACACCT
006400050316     C     DMCOV         KLIST
006500050316     C                   KFLD                    ACTRST
006600050316     C                   KFLD                    ACSUB#
006700050316     C     DKEY          KLIST
006800050316     C                   KFLD                    SSNO
006900050316     C                   KFLD                    DSEQ#
007000050316     C     DPLAN         KLIST
007100050316     C                   KFLD                    DVTRST
007200050316     C                   KFLD                    DVSUB#
007300050316     C                   KFLD                    DVPLAN
007400050218     C     KMCAR         KLIST
007500050218     C                   KFLD                    PCARR
007600000000     C                   ENDSR
007700000000      *___________________________________________________________________
007800000000      * Program open
007900000000      *___________________________________________________________________
008000000000     C     *INZSR        BEGSR
008100050218     C     *ENTRY        PLIST
008200050218     C                   PARM                    DTA
008300000000     C                   ENDSR
