0001000210290015  ******************************************************************
000200100224      * DW263B         Group Benefit Services, Inc.                    *
000300021029      *                                                                *
000400021029      *    WRITTEN BY - DAVID KETTERMAN                                *
000500100224      *    DATE       - 02/24/10                                       *
000600021029      *                                                                *
000700030930      * This program will:
0008001002240015  * 1. Copy all RPA060WK records for this months remittance that   *
0009001002240015  * have a negative FBR to DBRPA06NG. 2. Clear the prem, comm,     *
0010001002240015  * mcnt and set paid to "N" in the RPA060WK records just copied.  *
0010011106070015  *                                                                *
0010021106070015  * 06/07/11 dlk - add new agency override and market size fields  *
0013001106070015  *                to rpa060wk / dbrpa06ng                         *
0013011106070015  *                                                                *
0014000210290015  ******************************************************************
001500100224     Frpa060l2  UF   E           k DISK
001501100224     Fcarmst    iF   E           k DISK
001600100224     FDBRPA06NG iF a E           k DISK    rename(rpa60r:dbrpa06nr)
001700030807     Fdbfbrnhs  iF   E           k DISK
0017011002240056 D  zero8          s              8  0 inz(0)
0018000308070055 D                 DS
0019001008110056 D  rpgrp                  1     15
0020000308070056 D   groupid               1      8
0021000308070056 D   subgroupid            9     12
002200960408     D                UDS
0023000308070125 D  Leffmdy               85     92  0
0024000308070125 D  Leffmd                85     88  0
0025000308070125 D  Leffy                 89     92  0
0026000711300126 D  lseq                  21     22  0
0027000308070054 D  CONAME               201    240
002800030807
002900100224      * copy this months RPA060WK records that are part of the negative
003000100224      * FBR file to DBRPA06NG. Also clear some fields
003100100224      * in the RPA060WK rec being copied from.
003300030807
003400100224     c     rpakey        setll     rpa060l2
003500100224     C                   dou       %eof(rpa060l2)
003600100224     c     rpakey        reade     rpa060l2
003700030807
003800100224     c                   if        not %eof(rpa060l2)
003801100224
003802100224      * only select DBE carriers
003803100224     c     rppcar        chain     carmst
003804100224     C                   if        not %found(carmst) or carbc <> 'D'
003805100224     c                   iter
003806100224     c                   end
004100030930
004200030807     c     dbfbrnkey     chain     dbfbrnhs
004300030807     C                   if        %found(dbfbrnhs)
004400030807
004500100224      * copy this rec to DBRPA06NG
004600100224     c                   write     DBRPA06NR
004700030807
004900110607      * clear prem,commision, mcnt, agency override fields and
004901110607      * change paid flag to "N"
005600100224     c                   clear                   rppprm
005700100224     c                   clear                   rppcom
005701100224     c                   clear                   rpmcnt
005702110607     c                   clear                   rpaomthd
005703110607     c                   clear                   rpaorate
005704110607     c                   clear                   rpaoamt
005705100224     c                   move      'N'           rppaid
005706110607
005800100224     c                   update    rpa60r
007000030807
007100030807     c                   end
007200030807     c                   endif
007300030807
007400030807     c                   enddo
007500030807
007600030807     c     #end          tag
007700030811     c                   eval      *inlr = *on
007800030807
007900021106     C     *inzsr        begsr
008000021118
008100030807     c                   movel     leffy         leffymd           8 0
008200030807     c                   move      leffmd        leffymd
008300030807
008400030807     c     dbfbrnkey     klist
008500030807     c                   kfld                    leffymd
008600071130     c                   kfld                    lseq
008700030807     c                   kfld                    groupid
008800030807     c                   kfld                    subgroupid
008900021118
008901100224     c     rpakey        klist
008902100224     c                   kfld                    zero8
008903100224     c                   kfld                    leffymd
008904100224     c                   kfld                    lseq
009000021106     C                   ENDSR
