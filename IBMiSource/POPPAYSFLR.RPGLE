000001110418     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000002110418     H option(*SRCSTMT: *NODEBUGIO)
000200000000      *_________________________________________________________________________
000300000000      *
000301110725      *
000302110725      *  NOTE::::  GET START DATE FROM SHELLY!!!
000303110725      *
000305110725      *
000306110725      *
000400000000      *  Description:  Populate Payroll Deductions from MCOV
000500000000      *
000600110725      *  (c)Copyright 2011 by GBS, Inc.
000700000000      *
000800110725      *    Created by:  JALLEN - May 3, 2011
000900000000      *_________________________________________________________________________
000901110418     FMCOV22    if   e           k disk
000902110418     FMEMAC#    if   e           k disk
000903101223     FPLNMST    if   e           k disk
000904101223     FACCMST    if   e           k disk
000905101223     FWEBPAYROLLif   e           k disk
000906101223     FPRTPOPP   o    e             printer     oflind(*IN91)
000907110418
000908110421      /COPY *LIBL/QMODSRC,#SFLACOVPR
000909110421      /COPY *LIBL/QMODSRC,#GET80IPR
000910101203
000911110421     D w80date         s              8S 0 inz
000912101203     D Today           s              8S 0 inz
000913110418     D  p#             s              3s 0 inz
000914101203
000915101203     D WWTRS           s              3A
000916101203     D WWSUB           s              3A
000917101203     D WWACC           s              4A
000918110214     D WWSSN           s              9A
000919110214     D WWSAL           s              1A
000920101223     D PRTFLG          s              1A
000921101203
000922110108     D WITRS           s              3S 0   inz
000923110108     D WISUB           s              3S 0   inz
000924110108     D WIACC           s              4S 0   inz
000925110108     D WISSN           s              9S 0   inz
000926101223
000927101223     D                 ds
000928101223     D WTSA                          10s 0
000929101223     D WT                      1      3s 0
000930101223     D WS                      4      6s 0
000931101223     D WA                      7     10s 0
000932110418
000933110418     d  MemCov       e ds          2000    extname(webmcov)
000934110418     d  plan                   1    100a   dim(25) inz
000935110418     d  pcat                 101    175a   dim(25) inz
000936110418     d  desc                 176   1175a   dim(25) inz
000937110418     d  effd                1176   1425d   dim(25) inz datfmt(*usa)
000938110418     d  ctyp                1426   1500a   dim(25) inz
000939110418     d  covt                1501   2000a   dim(25) inz
000940101203
000941101203     D WEBDED        e ds                  extname(WEBPAYDED)
000942101203     D WDTA          e ds                  extname(WEBPAYGBS)
000943101203
001000000000      * Program status data structure
001100101203     D PGMD          esds                  EXTNAME(IOPGMD)
001200000000      *
001201101203     C     *ENTRY        PLIST
001202101203     C                   PARM                    WWTRS
001203101203     C                   PARM                    WWSUB
001204101203     C                   PARM                    WWACC
001205110214     C                   PARM                    WWSSN
001206110214     C                   PARM                    WWSAL
001207101203
001208101203     C     ' ':'0'       XLATE     WWTRS         WWTRS
001209101203     C     ' ':'0'       XLATE     WWSUB         WWSUB
001210101203     C     ' ':'0'       XLATE     WWACC         WWACC
001211101203     C     ' ':'0'       XLATE     WWSSN         WWSSN
001212101203
001213101203     C                   MOVE      WWTRS         WITRS
001214101203     C                   MOVE      WWSUB         WISUB
001215101203     C                   MOVE      WWACC         WIACC
001216101203     C                   MOVE      WWSSN         WISSN
001217101203
001218101203     C                   Select
001219101203     C                   When      WISSN = 0
001220101203     C                   Exsr      BY_ACC
001221101203     C                   When      WISSN <> 0
001222101203     C                   Exsr      BY_SSN
001223101203     C                   Endsl
001224101203
001225101203     C                   EVAL      *INLR = *ON
001226101203     C                   RETURN
001300000000      *___________________________________________________________________
001400101203      * Run By Account
001500000000      *___________________________________________________________________
001600101203     C     BY_ACC        BEGSR
001601101203     C     KEYACC        KLIST
001602101203     C                   KFLD                    WITRS
001603101203     C                   KFLD                    WISUB
001604101203     C                   KFLD                    WIACC
001606101203
001607110418     C     KEYACC        SETLL     MEMAC#
001608110418     C     KEYACC        READE     MEMAC#
001609110418     C                   DOW       NOT %EOF(MEMAC#)
001610110418     C                   IF        TERMDT = *zeros
001615101223
001616110418     C                   Eval      p# = 1
001617110418     C                   Eval      MemCov = #sflacov(mbtrst:mbsub#:mbacct:
001618110418     C                                      mbssno:0:'N':'N')
001619110418
001620110418     C                   If        plan(p#) <> *blanks
001621110418     C                   Dow       plan(p#) <> *blanks
001622110418     C                   If        plan(p#) <> 'XXXX'
001624101223
001636101203      * Load Keys
001637110418     C                   Eval      PGTRS = MBTRST
001638110418     C                   Eval      PGSUB = MBSUB#
001639110418     C                   Eval      PGACT = MBACCT
001640110418     C                   Eval      PGSSN = MBSSNO
001641110418     C                   Eval      PGSEQ = 0
001642110418     C                   Eval      PGPLN = plan(p#)
001643110418     C                   Eval      PGCTP = CTYP(p#)
001658101203
001659101203      * Get Plan Category
001660101203     C                   Exsr      GET_PCAT
001661101203     C                   Eval      PGCAT = PLNCAT
001678110223
001679110421     C                   Eval      w80date = #get80i(effd(p#))
001681110421     C                   Select
001682110421     C                   When      w80date = *zeros
001683110914     C                   Eval      PGSTART = 20110901
001684110914     C                   When      w80date < 20110901
001685110914     C                   Eval      PGSTART = 20110901
001686110421     C                   Other
001687110421     C                   Eval      PGSTART = w80date
001688110421     C                   Endsl
001689110421
001690110223     C                   Eval      PGSTOP  = 0
001691110223     C                   Eval      PGBENAM = BENAMT
001692101203
001693110223      * Exclude RX
001694110223     C                   If        %trim(PGCAT) <> 'PRX'  and
001695110223     C                             %trim(PRTFLG) <> 'Y'
001696110223
001697110223     C                   Call      'BLDPAYDEDR'
001698110727     C                   Parm                    WDTA
001699110727     C                   Parm                    WWSAL
001700110223
001701110418     C                   End
001702110223     C                   End
001703110418     C                   Eval      p# = p# + 1
001704110418     C                   Enddo
001705110418     C                   End
001706101203
001707101203     C                   END
001708110418     C     KEYACC        READE     MEMAC#
001709101203     C                   ENDDO
001710101203
001711000000     C                   ENDSR
001712101203      *___________________________________________________________________
001713101203      * Run By SSN
001714101203      *___________________________________________________________________
001715101203     C     BY_SSN        BEGSR
001716110418
001717110418     C     KEYSSN        KLIST
001718110418     C                   KFLD                    WITRS
001719110418     C                   KFLD                    WISUB
001720110418     C                   KFLD                    WIACC
001721110418     C                   KFLD                    WISSN
001722110418
001723110418     C     KEYSSN        SETLL     MCOV22
001803101203
001804101203     C                   ENDSR
001805101203      *___________________________________________________________________
001806101203      * Get Plan Category
001807101203      *___________________________________________________________________
001808101203     C     GET_PCAT      BEGSR
001809101203     C     KEYPLN        KLIST
001810101203     C                   KFLD                    PGTRS
001811101203     C                   KFLD                    PGSUB
001812101203     C                   KFLD                    PGPLN
001813101203
001814101203     C     KEYPLN        CHAIN     PLNMST
001815101203     C                   If        not %found(PLNMST)
001816101203     C                   Clear                   PLNCAT
001817101203     C                   End
001818101203
001819101203     C                   ENDSR
001820101223      *___________________________________________________________________
001821101223      * Print
001822101223      *___________________________________________________________________
001823101223     C     PRTRPT        BEGSR
001824101223     C                   Eval      PRTFLG = 'N'
001825101223
001826101223      * Missing Screen 2 Report
001827110214     C                   Clear                   WEBPAYR
001828101223     C     PAYKEY        Chain     WEBPAYROLL
001829101223     C                   If        not %found(WEBPAYROLL)
001830101223     C                   If        *in91 = *on
001831101223     C                   Write     PRTHDR
001832101223     C                   Eval      *in91 = *off
001833101223     C                   End
001834101223     C                   Eval      WT = MCTRST
001835101223     C                   Eval      WS = MCSUB#
001836101223     C                   Eval      WA = ACC#
001839101223     C                   Eval      WMNAME = %trim(MLNAME) +
001840101223     C                                      ' ' + %trim(MFNAME)
001844101223     C     ACCKEY        Chain     ACCMST
001845101223     C                   If        %found(ACCMST)
001846101223     C                   Eval      WANAME = %trim(ACNAM1)
001847101223     C                   Else
001848101223     C                   Eval      WANAME = *blanks
001849101223     C                   End
001850101223     C                   Write     PRTDTL
001851101223     C                   Eval      PRTFLG = 'Y'
001852101223     C                   End
001853101223
001854101223     C                   ENDSR
001855000000      *___________________________________________________________________
001900000000      * Program open
002000000000      *___________________________________________________________________
002100000000     C     *INZSR        BEGSR
002101101203     C     *DATE         MULT      10000.0001    TODAY
002102101223     C                   Eval      *in91 = *on
002103101223     C     PAYKEY        Klist
002104110418     C                   Kfld                    MBTRST
002105110418     C                   Kfld                    MBSUB#
002106110418     C                   Kfld                    MBACCT
002107110418     C                   Kfld                    MBSSNO
002108101223     C     ACCKEY        Klist
002109110418     C                   Kfld                    MBTRST
002110110418     C                   Kfld                    MBSUB#
002111110418     C                   Kfld                    MBACCT
002200000000     C                   ENDSR
002300000000      *___________________________________________________________________
002400000000      * Program error handler
002500000000      *___________________________________________________________________
002600000000     C     *PSSR         BEGSR
002700000000     C                   CALL      'SNDRPGM'                            50
002800000000     C                   PARM                    WQPGMN
002900000000     C                   PARM                    WQSTSC
003000000000     C                   PARM                    WQRPGS
003100000000     C                   PARM                    WQMSG
003200000000     C                   ENDSR     '*CANCL'
