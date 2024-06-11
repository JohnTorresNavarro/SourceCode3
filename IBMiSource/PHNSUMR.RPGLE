000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Broker Carrier Grouper Summery load
000400000000      *
000500000000      *  (c)Copyright 2005 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 18, 2005
000800000000      *_________________________________________________________________________
000900050218     FMCOVC15   IF   E           K DISK
001000050218     FPLNMST    IF   E           K DISK
001100050316     FMEMBER    IF   E           K DISK
001200050316     FPHNSUMP   UF A E           K DISK
001300050218
001400050218     D DTA           E DS                  EXTNAME(ACCMST)
001500000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001600050218
001700050218      *
001800050218      * Find Active Member Coverage
001900050218     C     KMCOV         setll     MCOVC15
002000050218     C     KMCOV         reade     MCOVC15
002100050218     C                   dow       not %eof(MCOVC15)
002200050218     C                   if        CANDT = 0
002300050218     C                   exsr      ActiveMemCov
002400050218     C                   end
002500050218     C     KMCOV         reade     MCOVC15
002600050218     C                   enddo
002700050316      *
002800050218     C                   return
002900050218      *___________________________________________________________________
003000050218      * Active Member Coverage
003100050218      *___________________________________________________________________
003200050218     C     ActiveMemCov  BEGSR
003300050218     C     KPLAN         chain     PLNMST
003400050218     C                   if        %found
003500050316     C                   if        PCARR = 'PHN'
003600050218     C                   exsr      UpdateTotals
003700050218     C                   end
003800050218     C                   end
003900050218     C                   ENDSR
004000050218      *___________________________________________________________________
004100050218      * Update Totals
004200050218      *___________________________________________________________________
004300050218     C     UpdateTotals  BEGSR
004400050316     C     MCSSNO        Chain     MEMBER
004500050316     C                   Eval      BCDEPQ    = 0
004600050316     C     PHNK          Chain     PHNSUMP
004700050316     C                   If        not %Found
004800050218     C                   eval      BCTRST    = MCTRST
004900050218     C                   eval      BCSUB#    = MCSUB#
005000050218     C                   eval      BCACCT    = ACC#
005100050316     C                   eval      BCSSNO    = MCSSNO
005200050316     C                   eval      BCNAME    = %trim(MLNAME) + ', ' +
005300050316     C                                         %trim(MFNAME)
005400050316     C                   Eval      BCDEPQ    = 0
005500050316     C                   Write     PHNSUMR
005600050316     C                   End
005700050218     C                   ENDSR
005800000000      *___________________________________________________________________
005900000000      * Key Lists
006000000000      *___________________________________________________________________
006100050218     C     KLIST         BEGSR
006200050218     C     KMCOV         KLIST
006300050218     C                   KFLD                    ACTRST
006400050218     C                   KFLD                    ACSUB#
006500050218     C                   KFLD                    ACACCT
006600050316     C     PHNK          KLIST
006700050316     C                   KFLD                    MCSSNO
006800050316     C                   KFLD                    BCDEPQ
006900050218     C     KPLAN         KLIST
007000050218     C                   KFLD                    MCTRST
007100050218     C                   KFLD                    MCSUB#
007200050218     C                   KFLD                    MCPLAN
007300050218     C     KMCAR         KLIST
007400050218     C                   KFLD                    PCARR
007500000000     C                   ENDSR
007600000000      *___________________________________________________________________
007700000000      * Program open
007800000000      *___________________________________________________________________
007900000000     C     *INZSR        BEGSR
008000050218     C     *ENTRY        PLIST
008100050218     C                   PARM                    DTA
008200000000     C                   ENDSR
