000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Broker Carrier Grouper Summery load
000400000000      *
000500000000      *  (c)Copyright 2005 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 18, 2005
000800000000      *_________________________________________________________________________
000900050302     FACCPRDP   IF   E           K DISK
001000050302     FBRKPRDL6  IF   E           K DISK
001100050302     FCARXRFP   IF   E           K DISK
001200050218     FCARMST    IF   E           K DISK
001300050218     FBRKSUMP   UF A E           K DISK
001400050302
001500050302     D WDATE           S              8S 0 INZ
001600050302
001700050302     D DTA           E DS                  EXTNAME(ACCMSTP)
001800000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001900050218
002000050218      *
002100050302      * Find Account Products
002200050302     C     ADACCT        setll     ACCPRDP
002300050302     C     ADACCT        reade     ACCPRDP
002400050302     C                   dow       not %eof(ACCPRDP)
002500050302     C                   if        APTRDT = *HIVAL
002600050218     C                   exsr      ActiveMemCov
002700050218     C                   end
002800050302     C     ADACCT        reade     ACCPRDP
002900050218     C                   enddo
003000050218     C                   return
003100050218      *___________________________________________________________________
003200050302      * Active Broker Product
003300050218      *___________________________________________________________________
003400050218     C     ActiveMemCov  BEGSR
003500050302     C     KBRKP         chain     BRKPRDL6
003600050218     C                   if        %found
003700050302     C     BPCAID        chain     CARXRFP
003800050218     C                   if        %found
003900050302     C     CXGBSC        chain     CARMST
004000050302     C                   if        %found
004100050218     C                   exsr      UpdateTotals
004200050302     C                   end
004300050218     C                   end
004400050218     C                   end
004500050218     C                   ENDSR
004600050218      *___________________________________________________________________
004700050218      * Update Totals
004800050218      *___________________________________________________________________
004900050218     C     UpdateTotals  BEGSR
005000050302     C                   Extrct    ADGEFD:*Y     bcyear
005100050218     C     KBROK         chain     BRKSUMP
005200050218     C                   if        not %found
005300050302     C                   eval      BCBRK     = BPSMAN
005400050218     C                   eval      BCGRP     = CGRPCD
005500050218     C                   eval      BCACC     = 1
005600050302     C                   eval      BCEMP     = ADBENR
005700050302     C                   eval      BCPRM     = ADPAMT
005800050302     C                   eval      BCGAAC    = ADACCT
005900050302     C                   Extrct    ADGEFD:*Y     bcyear
006000050302     C                   Write     BRKSUMR
006100050218     C                   else
006200050218      * not same act
006300050302     C                   if        BCGAAC   <> ADACCT
006400050218     C                   eval      BCACC     = BCACC + 1
006500050302     C                   eval      BCGAAC    = ADACCT
006600050302     C                   eval      BCEMP     = BCEMP + ADBENR
006700050218     C                   end
006800050218      * premium
006900050302     C                   eval      BCPRM     = BCPRM + ADPAMT
007000050218     C                   Update    BRKSUMR
007100050218     C                   end
007200050218     C                   ENDSR
007300000000      *___________________________________________________________________
007400000000      * Key Lists
007500000000      *___________________________________________________________________
007600050218     C     KLIST         BEGSR
007700050302     C     KBRKP         KLIST
007800050302     C                   KFLD                    APACCT
007900050302     C                   KFLD                    APCGRP
008000050302     C                   KFLD                    APCAID
008100050302     C                   KFLD                    APPRID
008200050218     C     KBROK         KLIST
008300050302     C                   KFLD                    BPSMAN
008400050218     C                   KFLD                    CGRPCD
008500050218     C                   KFLD                    BCYEAR
008600000000     C                   ENDSR
008700000000      *___________________________________________________________________
008800000000      * Program open
008900000000      *___________________________________________________________________
009000000000     C     *INZSR        BEGSR
009100050218     C     *ENTRY        PLIST
009200050218     C                   PARM                    DTA
009300000000     C                   ENDSR
