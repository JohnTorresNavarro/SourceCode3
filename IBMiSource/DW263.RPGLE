0001000210290015  ******************************************************************
000200031002      * DW263          Group Benefit Services, Inc.                    *
000300021029      *                                                                *
000400021029      *    WRITTEN BY - DAVID KETTERMAN                                *
000500030807      *    DATE       - 08/07/03                                       *
000600021029      *                                                                *
000700030930      * This program will:
0008000309300015  * 1. Copy all CR130HSD records for this months remittance that   *
0009000309300015  * have a negative FBR to DBCR130NG. 2. Clear the paid, comm,     *
0010000308070015  * admin, bonus and mem cnt in the CR130HSD records just copied.  *
0011000310020015  * If the paid amount is not zero and the billed / adj amts are   *
0012000310020015  * zero then the record will be deleted from cr130hsd             *
0013000308070015  *                                                                *
0013010711300015  * 11/30/07 dlk - change late field to seq                        *
0013021612150015  * 12/15/16 dlk - clear new lives fields added for new GPR        *
0013031911050015  * 11/05/19 dlk - clear life volume                               *
0014000210290015  ******************************************************************
001500030807     Fcr130hsd  UF a E           k DISK
001600030807     Fdbcr130ng iF a E           k DISK    rename(crhstr:dbcr130nr)
001700030807     Fdbfbrnhs  iF   E           k DISK
0018000308070055 D                 DS
0019000308070056 D  cgroup                 1     15
0020000308070056 D   groupid               1      8
0021000308070056 D   subgroupid            9     12
002200960408     D                UDS
0023000308070125 D  Leffmdy               85     92  0
0024000308070125 D  Leffmd                85     88  0
0025000308070125 D  Leffy                 89     92  0
0026000711300126 D  lseq                  21     22  0
0027000308070054 D  CONAME               201    240
002800030807
002900030807      * copy this months CR130HSD records that are part of the negative
003000191105      * FBR file to DBCR130NG. Also zero out the paid, com, cnt & volume
003100030930      * in the CR130HSD rec being copied from. IF the billed and adj amts
003200030930      * are zero then delete the record.
003300030807
003400030807     c     leffymd       setll     cr130hsd
003500030807     C                   dou       %eof(cr130hsd)
003600030807     c     leffymd       reade     cr130hsd
003700030807
003800030930     c                   if        not %eof(cr130hsd) and
003900071130     c                             (cseq = lseq)
004100030930
004200030807     c     dbfbrnkey     chain     dbfbrnhs
004300030807     C                   if        %found(dbfbrnhs)
004400030807
004500030807      * copy this rec to dbcr130ng
004600030807     c                   write     dbcr130nr
004700030807
004800031002      * if the billed or adj amt are not zero then this is a new record
004900191105      * that will have the paid, comm, cnt and volume cleared.
005000030930
005100030930     c                   if        cbamt <> 0 or caamt <> 0
005200031002     c                   clear                   cpamt
005300031002     c                   clear                   ccome
005400031002     c                   clear                   cadme
005500031002     c                   clear                   cbond
005600031002     c                   clear                   ctotc
005700031002     c                   clear                   clives
005701161215     c                   clear                   clivesB
005702161215     c                   clear                   clivesA
005703161215     c                   clear                   cdlives
005704161215     c                   clear                   cdlivesB
005705161215     c                   clear                   cdlivesA
005706191105     c                   clear                   clifev
005800030807     c                   update    crhstr
005900030930     c                   else
006000031002      * billed & adj are zero
006100031002
006200031002      * If the paid amount is not zero then delete it
006300031002      * If the paid amt is zero this record could be a zero rate plan
006400031002      * so do not delete it since we can not tell if it is the first
006500031002      * time through.
006600031002     c                   if        cpamt <> 0
006700030930     c                   delete    crhstr
006800030930     c                   end
006900031002     c                   end
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
009000021106     C                   ENDSR
