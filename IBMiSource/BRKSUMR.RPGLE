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
001100050218     FCARMST    IF   E           K DISK
001200050218     FBRKSUMP   UF A E           K DISK
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
002700050218     C                   return
002800050218      *___________________________________________________________________
002900050218      * Active Member Coverage
003000050218      *___________________________________________________________________
003100050218     C     ActiveMemCov  BEGSR
003200050218     C     KPLAN         chain     PLNMST
003300050218     C                   if        %found
003400050218     C     KMCAR         chain     CARMST
003500050218     C                   if        %found
003600050218     C                   exsr      UpdateTotals
003700050218     C                   end
003800050218     C                   end
003900050218     C                   ENDSR
004000050218      *___________________________________________________________________
004100050218      * Update Totals
004200050218      *___________________________________________________________________
004300050218     C     UpdateTotals  BEGSR
004400050218     C                   movel     GBSBDT        BCYEAR
004500110524     C     KBROK         chain     BRKSUMP                            9999
004600050218     C                   if        not %found
004700050218     C                   eval      BCBRK     = SMANCD
004800050218     C                   eval      BCGRP     = CGRPCD
004900050218     C                   eval      BCACC     = 1
005000050218     C                   eval      BCEMP     = 1
005100050218     C                   eval      BCPRM     = LPREM
005200050218     C                   eval      BCTRST    = MCTRST
005300050218     C                   eval      BCSUB#    = MCSUB#
005400050218     C                   eval      BCACCT    = ACC#
005500050218     C                   eval      BCSSNO    = MCSSNO
005600050218     C                   movel     GBSBDT        BCYEAR
005700110524     C                   Write(e)  BRKSUMR
005800050218     C                   else
005900050218      * not same ssn
006000050218     C                   if        BCSSNO   <> MCSSNO
006100050218     C                   eval      BCEMP     = BCEMP + 1
006200050218     C                   eval      BCSSNO    = MCSSNO
006300050218     C                   end
006400050218      * not same act
006500050222     C                   if        BCTRST   <> MCTRST or
006600050222     C                             BCSUB#   <> MCSUB# or
006700050218     C                             BCACCT   <> ACC#
006800050218     C                   eval      BCACC     = BCACC + 1
006900050218     C                   eval      BCTRST    = MCTRST
007000050218     C                   eval      BCSUB#    = MCSUB#
007100050218     C                   eval      BCACCT    = ACC#
007200050218     C                   end
007300050218      * premium
007400050218     C                   eval      BCPRM     = BCPRM + LPREM
007500050218     C                   Update    BRKSUMR
007600050218     C                   end
007700050218     C                   ENDSR
007800000000      *___________________________________________________________________
007900000000      * Key Lists
008000000000      *___________________________________________________________________
008100050218     C     KLIST         BEGSR
008200050218     C     KMCOV         KLIST
008300050218     C                   KFLD                    ACTRST
008400050218     C                   KFLD                    ACSUB#
008500050218     C                   KFLD                    ACACCT
008600050218     C     KPLAN         KLIST
008700050218     C                   KFLD                    MCTRST
008800050218     C                   KFLD                    MCSUB#
008900050218     C                   KFLD                    MCPLAN
009000050218     C     KMCAR         KLIST
009100050218     C                   KFLD                    PCARR
009200050218     C     KBROK         KLIST
009300050218     C                   KFLD                    SMANCD
009400050218     C                   KFLD                    CGRPCD
009500050218     C                   KFLD                    BCYEAR
009600000000     C                   ENDSR
009700000000      *___________________________________________________________________
009800000000      * Program open
009900000000      *___________________________________________________________________
010000000000     C     *INZSR        BEGSR
010100050218     C     *ENTRY        PLIST
010200050218     C                   PARM                    DTA
010300000000     C                   ENDSR
