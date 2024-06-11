000001110912     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000002110912     H option(*SRCSTMT: *NODEBUGIO)
000200000000      *_________________________________________________________________________
000300000000      *
000400000000      *  Description:  Populate Payroll Deductions from MCOV
000500000000      *
000600000000      *  (c)Copyright 2010 by Innovative Outsourcing, Inc.
000700000000      *
000800000000      *    Created by:  JALLEN - December 03, 2010
000900000000      *_________________________________________________________________________
000901101203     FMCOV22    if   e           k disk
000902101223     FPLNMST    if   e           k disk
000903101223     FMEMBER    if   e           k disk
000904101223     FACCMST    if   e           k disk
000905101223     FWEBPAYROLLif   e           k disk
000906101223     FPRTPOPP   o    e             printer     oflind(*IN91)
000907101203
000908110912      /copy *libl/qmodsrc,#sflacovpr
000909110912      /copy *libl/qmodsrc,#get80ipr
000910110912
000911110803     D Days            s              3S 0 inz
000912110803     D Today           s              8S 0 inz
000913110803     D Todaa           s              8S 0 inz
000914110803     d IsoStart        S               d   datfmt(*iso)
000915110803     d IsoToday        S               d   datfmt(*iso)
000916110912
000917110912     D w80date         s              8S 0 inz
000919110912     D  p#             s              3s 0 inz
000920101203
000921101203     D WWTRS           s              3A
000922101203     D WWSUB           s              3A
000923101203     D WWACC           s              4A
000924110214     D WWSSN           s              9A
000925110214     D WWSAL           s              1A
000926110912     D PRTFLG          s              1A
000927110912     D MCOVFLG         s              1A
000928101203
000929110108     D WITRS           s              3S 0   inz
000930110108     D WISUB           s              3S 0   inz
000931110108     D WIACC           s              4S 0   inz
000932110108     D WISSN           s              9S 0   inz
000933110912
000934110912     d  MemCov       e ds          2000    extname(webmcov)
000935110912     d  plan                   1    100a   dim(25) inz
000936110912     d  pcat                 101    175a   dim(25) inz
000937110912     d  desc                 176   1175a   dim(25) inz
000938110912     d  effd                1176   1425d   dim(25) inz datfmt(*usa)
000939110912     d  ctyp                1426   1500a   dim(25) inz
000940110912     d  covt                1501   2000a   dim(25) inz
000941101223
000942101223     D                 ds
000943101223     D WTSA                          10s 0
000944101223     D WT                      1      3s 0
000945101223     D WS                      4      6s 0
000946101223     D WA                      7     10s 0
000947101203
000948101203     D WEBDED        e ds                  extname(WEBPAYDED)
000949101203     D WDTA          e ds                  extname(WEBPAYGBS)
000950101203
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
001605101203
001606101203     C     KEYACC        SETLL     MCOV22
001607101203     C     KEYACC        READE     MCOV22
001608101203     C                   DOW       NOT %EOF(MCOV22)
001609101203     C                   IF        TODAY >= ENRLDT and
001610101203     C                             TODAY <= CANDT  or
001611101203     C                             TODAY >= ENRLDT and
001612101222     C                             CANDT  = 0      or
001613101222     C                             ENRLDT >= TODAY and
001614101222     C                             CANDT  = 0
001615110902      * Skip Same Day Terms
001616110902     C                   IF        ENRLDT <> CANDT
001617101223
001618101223      * Missing Screen 2
001619101223     C                   Exsr      PRTRPT
001620101223
001636101203      * Load Keys
001637101203     C                   Eval      PGTRS = MCTRST
001638101203     C                   Eval      PGSUB = MCSUB#
001639101203     C                   Eval      PGACT = ACC#
001640101203     C                   Eval      PGSSN = MCSSNO
001641101203     C                   Eval      PGSEQ = MDSEQ#
001642101203     C                   Eval      PGPLN = MCPLAN
001643101203     C                   Eval      PGCTP = MCOVTP
001658101203
001659101203      * Get Plan Category
001660101203     C                   Exsr      GET_PCAT
001661101203     C                   Eval      PGCAT = PLNCAT
001662110223
001663110223      * Change in Salary, use sal change date. (Salary Based Plans Only)
001664110908     C                   Select
001665110908     C                   When      WWSAL = 'Y'
001666110223     C                   If        MULT  > *Zeros or
001667110223     C                             PGCAT = 'PP1'  or
001668110223     C                             PGCAT = 'PPR'
001669110223     C                   If        PYSALDT <> *Zeros
001671110223     C                   Eval      PGSTART = PYSALDT
001672110223     C                   Else
001673110223     C                   Eval      PGSTART = ENRLDT
001674110223     C                   End
001675110801     C                   Else
001676110801     C                   Eval      PGSTART = ENRLDT
001677110223     C                   End
001678110908      * Change in Rule, use Rule Change date.
001679110908     C                   When      WWSAL = 'R'
001680110908     C                   Eval      PGSTART = PYBPCEF
001681110908     C                   Other
001682110223     C                   Eval      PGSTART = ENRLDT
001683110908     C                   Endsl
001684110223
001685110223     C                   Eval      PGSTOP  = 0
001686110223     C                   Eval      PGBENAM = BENAMT
001687101203
001688110223      * Exclude RX
001689110223     C                   If        %trim(PGCAT) <> 'PRX'  and
001690110223     C                             %trim(PRTFLG) <> 'Y'
001691110223
001693110908     C                   Select
001694110908     C                   When      WWSAL = 'Y'
001695110223     C                   If        MULT  > *Zeros or
001696110223     C                             PGCAT = 'PP1'  or
001697110223     C                             PGCAT = 'PPR'
001698110223     C                   Call      'BLDPAYDEDR'
001699110727     C                   Parm                    WDTA
001700110727     C                   Parm                    WWSAL
001701110223     C                   End
001702110908     C                   When      WWSAL = 'R'
001703110908     C                   Call      'BLDPAYDEDR'
001704110908     C                   Parm                    WDTA
001705110908     C                   Parm                    WWSAL
001706110908     C                   Other
001707110223     C                   Call      'BLDPAYDEDR'
001708110223     C                   Parm                    WDTA
001709110727     C                   Parm                    WWSAL
001710110908     C                   Endsl
001711110902
001712110223     C                   End
001713110223
001714110223     C                   End
001715101203
001716101203     C                   END
001717101203     C     KEYACC        READE     MCOV22
001718101203     C                   ENDDO
001719101203
001720000000     C                   ENDSR
001721101203      *___________________________________________________________________
001722101203      * Run By SSN
001723101203      *___________________________________________________________________
001724101203     C     BY_SSN        BEGSR
001725101203     C     KEYSSN        KLIST
001726101203     C                   KFLD                    WITRS
001727101203     C                   KFLD                    WISUB
001728101203     C                   KFLD                    WIACC
001729101203     C                   KFLD                    WISSN
001730110912
001731110912     C                   Eval      MCOVFLG = 'N'
001732101203
001733101203     C     KEYSSN        SETLL     MCOV22
001734101203     C     KEYSSN        READE     MCOV22
001735101203     C                   DOW       NOT %EOF(MCOV22)
001736101203     C                   IF        TODAY >= ENRLDT and
001737101203     C                             TODAY <= CANDT  or
001738101203     C                             TODAY >= ENRLDT and
001739101222     C                             CANDT  = 0      or
001740101222     C                             ENRLDT >= TODAY and
001741101222     C                             CANDT  = 0
001742110902
001743110902      * Skip Same Day Terms
001744110902     C                   IF        ENRLDT <> CANDT
001745101223
001746101223      * Missing Screen 2
001747101223     C                   Exsr      PRTRPT
001748101203
001749101203      * Load Keys
001750101203     C                   Eval      PGTRS = MCTRST
001751101203     C                   Eval      PGSUB = MCSUB#
001752101203     C                   Eval      PGACT = ACC#
001753101203     C                   Eval      PGSSN = MCSSNO
001754101203     C                   Eval      PGSEQ = MDSEQ#
001755101203     C                   Eval      PGPLN = MCPLAN
001756101203     C                   Eval      PGCTP = MCOVTP
001757101203
001758101203      * Get Plan Category
001759101203     C                   Exsr      GET_PCAT
001760101203     C                   Eval      PGCAT = PLNCAT
001761110223
001762110908      * Change in Salary, use sal change date. (Salary Based Plans Only)
001763110908     C                   Select
001764110908     C                   When      WWSAL = 'Y'
001765110908     C                   If        MULT  > *Zeros or
001766110908     C                             PGCAT = 'PP1'  or
001767110908     C                             PGCAT = 'PPR'
001768110908     C                   If        PYSALDT <> *Zeros
001769110908     C                   Eval      PGSTART = PYSALDT
001770110908     C                   Else
001771110908     C                   Eval      PGSTART = ENRLDT
001772110908     C                   End
001773110908     C                   Else
001774110908     C                   Eval      PGSTART = ENRLDT
001775110908     C                   End
001776110908      * Change in Rule, use Rule Change date.
001777110908     C                   When      WWSAL = 'R'
001778110908     C                   Eval      PGSTART = PYBPCEF
001779110908     C                   Other
001780110908     C                   Eval      PGSTART = ENRLDT
001781110908     C                   Endsl
001794110803
001795110803      * Pay-choice cannot start a ded more than a year after
001796110803     C                   eval      Todaa = %int(%char(%date : *iso0))
001797120111     C                   If        PGSTART = 0  and
001798120111     C                             PGSTOP  = 0
001799120111     C                   eval      PGSTART = %int(%char(%date : *iso0))
001800120111     C                   End
001801110803     C                   If        PGSTART < Todaa
001802110803     C     *ISO          Move      PGSTART       isoStart
001803110803     C     *ISO          Move      Todaa         isoToday
001804110803     C     isoToday      Subdur    isoStart      Days:*d
001805110803     C                   If        Days > 180
001806110803     C                   Eval      PGSTART = Todaa
001807110803     C                   End
001808110803     C                   End
001809110223
001810110223     C                   Eval      PGSTOP  = 0
001811110223     C                   Eval      PGBENAM = BENAMT
001812101203
001813110223      * Exclude RX
001814101222     C                   If        %trim(PGCAT) <> 'PRX'  and
001815101223     C                             %trim(PRTFLG) <> 'Y'
001816110223
001817110912     C                   Eval      MCOVFLG = 'Y'
001818110908     C                   Select
001819110908     C                   When      WWSAL = 'Y'
001820110908     C                   If        MULT  > *Zeros or
001821110908     C                             PGCAT = 'PP1'  or
001822110908     C                             PGCAT = 'PPR'
001823110908     C                   Call      'BLDPAYDEDR'
001824110908     C                   Parm                    WDTA
001825110908     C                   Parm                    WWSAL
001826110908     C                   End
001827110908     C                   When      WWSAL = 'R'
001828110908     C                   Call      'BLDPAYDEDR'
001829110908     C                   Parm                    WDTA
001830110908     C                   Parm                    WWSAL
001831110908     C                   Other
001832110908     C                   Call      'BLDPAYDEDR'
001833110908     C                   Parm                    WDTA
001834110908     C                   Parm                    WWSAL
001835110908     C                   Endsl
001844110223
001845101222     C                   End
001846101203
001847110902     C                   End
001848110902
001849101203     C                   END
001850101203     C     KEYSSN        READE     MCOV22
001851101203     C                   ENDDO
001852110912
001853110912     C                   Exsr      NEWLY_ADDED
001854110912
001855110912     C                   ENDSR
001856110912      *___________________________________________________________________
001857110912      * Check Newly Added Employee
001858110912      *___________________________________________________________________
001859110912     C     NEWLY_ADDED   BEGSR
001860110912
001861110912      * If no MCOV yet, maybe is a new hire
001862110912     C                   If        MCOVFLG = 'N'
001863110912     C                   Clear                   WEBPAYR
001864110912     C     NEWKEY        Chain     WEBPAYROLL
001865110912     C                   Eval      p# = 1
001866110912     C                   Eval      MemCov = #sflacov(witrs:wisub:wiacc:
001867110912     C                                      wissn:0:'N':'N')
001868110912
001869110912     C                   If        plan(p#) <> *blanks
001870110912     C                   Dow       plan(p#) <> *blanks
001871110912     C                   If        plan(p#) <> 'XXXX'
001872110912
001873110912      * Load Keys
001874110912     C                   Eval      PGTRS = WITRS
001875110912     C                   Eval      PGSUB = WISUB
001876110912     C                   Eval      PGACT = WIACC
001877110912     C                   Eval      PGSSN = WISSN
001878110912     C                   Eval      PGSEQ = 0
001879110912     C                   Eval      PGPLN = plan(p#)
001880110912     C                   Eval      PGCTP = CTYP(p#)
001881110912
001882110912      * Get Plan Category
001883110912     C                   Exsr      GET_PCAT
001884110912     C                   Eval      PGCAT = PLNCAT
001885110912
001886110912      * Change in Salary, use sal change date. (Salary Based Plans Only)
001887110912     C                   Select
001888110912     C                   When      WWSAL = 'Y'
001889110912     C                   If        MULT  > *Zeros or
001890110912     C                             PGCAT = 'PP1'  or
001891110912     C                             PGCAT = 'PPR'
001892110912     C                   If        PYSALDT <> *Zeros
001893110912     C                   Eval      PGSTART = PYSALDT
001894110912     C                   Else
001895110912     C                   Eval      w80date = #get80i(effd(p#))
001896110912     C                   Eval      PGSTART = w80date
001897110912     C                   End
001898110912     C                   Else
001899110912     C                   Eval      w80date = #get80i(effd(p#))
001900110912     C                   Eval      PGSTART = w80date
001901110912     C                   End
001902110912      * Change in Rule, use Rule Change date.
001903110912     C                   When      WWSAL = 'R'
001904110912     C                   Eval      PGSTART = PYBPCEF
001905110912     C                   Other
001906110912     C                   Eval      w80date = #get80i(effd(p#))
001907110912     C                   Eval      PGSTART = w80date
001908110912     C                   Endsl
001909110912
001910110912     C                   Eval      PGSTOP  = 0
001911110912     C                   Eval      PGBENAM = BENAMT
001912110912
001913110912      * Exclude RX
001914110912     C                   If        %trim(PGCAT) <> 'PRX'  and
001915110912     C                             %trim(PRTFLG) <> 'Y'
001916110912
001917110912     C                   Call      'BLDPAYDEDR'
001918110912     C                   Parm                    WDTA
001919110912     C                   Parm                    WWSAL
001920110912
001921110912     C                   End
001922110912     C                   End
001923110912     C                   Eval      p# = p# + 1
001924110912     C                   Enddo
001925110912     C                   End
001926110912     C                   End
001927101203
001928101203     C                   ENDSR
001929101203      *___________________________________________________________________
001930101203      * Get Plan Category
001931101203      *___________________________________________________________________
001932101203     C     GET_PCAT      BEGSR
001933101203     C     KEYPLN        KLIST
001934101203     C                   KFLD                    PGTRS
001935101203     C                   KFLD                    PGSUB
001936101203     C                   KFLD                    PGPLN
001937101203
001938101203     C     KEYPLN        CHAIN     PLNMST
001939101203     C                   If        not %found(PLNMST)
001940101203     C                   Clear                   PLNCAT
001941101203     C                   End
001942101203
001943101203     C                   ENDSR
001944101223      *___________________________________________________________________
001945101223      * Print
001946101223      *___________________________________________________________________
001947101223     C     PRTRPT        BEGSR
001948101223     C                   Eval      PRTFLG = 'N'
001949101223
001950101223      * Missing Screen 2 Report
001951110214     C                   Clear                   WEBPAYR
001952101223     C     PAYKEY        Chain     WEBPAYROLL
001953101223     C                   If        not %found(WEBPAYROLL)
001954101223     C                   If        *in91 = *on
001955101223     C                   Write     PRTHDR
001956101223     C                   Eval      *in91 = *off
001957101223     C                   End
001958101223     C                   Eval      WT = MCTRST
001959101223     C                   Eval      WS = MCSUB#
001960101223     C                   Eval      WA = ACC#
001961101223     C     MCSSNO        Chain     MEMBER
001962101223     C                   If        %found(MEMBER)
001963101223     C                   Eval      WMNAME = %trim(MLNAME) +
001964101223     C                                      ' ' + %trim(MFNAME)
001965101223     C                   Else
001966101223     C                   Eval      WMNAME = *blanks
001967101223     C                   End
001968101223     C     ACCKEY        Chain     ACCMST
001969101223     C                   If        %found(ACCMST)
001970101223     C                   Eval      WANAME = %trim(ACNAM1)
001971101223     C                   Else
001972101223     C                   Eval      WANAME = *blanks
001973101223     C                   End
001974101223     C                   Write     PRTDTL
001975101223     C                   Eval      PRTFLG = 'Y'
001976101223     C                   End
001977101223
001978101223     C                   ENDSR
001979000000      *___________________________________________________________________
001980000000      * Program open
002000000000      *___________________________________________________________________
002100000000     C     *INZSR        BEGSR
002101101203     C     *DATE         MULT      10000.0001    TODAY
002102101223     C                   Eval      *in91 = *on
002103101223     C     PAYKEY        Klist
002104101223     C                   Kfld                    MCTRST
002105101223     C                   Kfld                    MCSUB#
002106101223     C                   Kfld                    ACC#
002107101223     C                   Kfld                    MCSSNO
002108110912     C     NEWKEY        Klist
002109110912     C                   Kfld                    WITRS
002110110912     C                   Kfld                    WISUB
002111110912     C                   Kfld                    WIACC
002112110912     C                   Kfld                    WISSN
002113101223     C     ACCKEY        Klist
002114101223     C                   Kfld                    MCTRST
002115101223     C                   Kfld                    MCSUB#
002116101223     C                   Kfld                    ACC#
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
