000100010111      ******************************************************************
000200010111      * RPA060N    GROUP BENEFIT SERVICES SOFTWARE           2001
000300010111      *
000400010111      *            WRITTEN BY - R JONES
000500010125      *            DATE - 01/23/2001
000600010111      *
000700050826      *  DESCRIPTION - This program calculates salesman commission
000701050826      *                using the new method.
001000010111      *
001001050826      *  CHANGE LOG
001002050826      * 04/18/2001     - fix bug with admin fee: only cacl if mcnt <> 0     BCRE
001003050826      * 01/08/2002 rlj - change method of calculating Bonus Draw Charge for BCRE
001004050826      * 06/05/2002 DLK - add "and w9mcnt <> 0" to commission calc for
001005050826      *                  w9mthd = C
001006050826      * 04/11/2003 DLK - add % of prem and % of com calcs to admin fee
001007050826      *                  also add error report
001008050826      * 06/03/2003 DLK - add relid to sort / break
001009050826      * 05/18/2005 szz - Recompile due to RPA060WK file change:RPCPDDT
001802050823      * 08/16/2005 DLK - Add global % of prem commission. Remove bcrec
001803050823      *                  update, it has been moved to a seperate pgm
001804050823      *                  (RPA060N2) that will follow this one. Also move
001805050824      *                  code to not process for late pay to the cl,
001806050824      *                  rework logic and use new fields added to RPA069WK
001807050824      *                  for plan desc & sman name.
001808061013      * 10/12/2006 DLK - Increase field size of W9CMAM & W9GLOB to 17.8
001809061013      *                  (and all fields defined LIKE)
001811061016      * 10/16/2006 DLK - round final result of total comm amt before writing
001812061016      *                  to rpa060wk
001813071207      * 12/07/2007 DLK - change runtyp to use lda position 22 for run seq
001814071207      *                  to store in rpa060wk in the field rplflg.
001815071207      *                  RPA060WK records are only written at full run
001816071207      *                  time anyway (seq 01) so this should not be a
001817071207      *                  problem.
001818080206      * 02/06/2008 DLK - change seq to 2.0 in rpa060wk. Now commissions
001819080206      *                  are written at every run for new transactions.
001820080206      *                  Only records that should be paid are fed to this
001821080206      *                  RPG from the QRY (W9PDFL = Y)
001822080910      * 09/10/2008 DLK - update new field in F.INVDET, "IDCOMDT" =
001823080910      *                  commission paid date.
001824081007      * 10/07/2008 DLK - All records are now fed to this pgm and we will
001825081007      *                  only pay commission on the records with w9pdfl = Y.
001826081007      *                  The other records will be written to rpa060wk
001827081007      *                  with the comm, prem and mcnt all equal to zero
001828081007      *                  to make rpa060wk appear like cr130hst with the
001829081007      *                  billed / paid structure.
001830110307      * 03/07/2011 DLK - Because the new commission method for Coventry
001831110307      *                  that uses a flat fee and premium split will not
001832110307      *                  show the correct comm rate, this program will need
001833110307      *                  to recalculate the actual rate instead of using
001834110307      *                  the value from the work file. Actual rate =
001835110307      *                  commission / mem cnt.
001836110607      * 06/07/2011 DLK - calc agency override for rpa060wk by calling GETAO
001837110607      *                  pgm. Remember the files in GETAO need to be
001838110607      *                  overridden in the CL for this program
001839110607      *                  (AGCAROV1, SPRAGXR2, SMANRLT).
001840111216      * 12/16/2011 DLK - fix coventry special rate recalc to use a larger
001841111216      *                  member count field with more decimal places so
001842111216      *                  the result is correct.
001843191127      * 11/27/2019 DLK - Remove Coventry special rate recalc due to errors
001844191127      *                  that resulted from incorrect setup. Coventry is
001845191127      *                  gone anyway.
001846191127      *
001847200519      *
0018482005190015  *  ************************************************************   *
0018492005190015  *  * * NOTE - Logic in this program was copied to RPA421.     *   *
0018502005190015  *  *          Any changes here should be considered there also*
0018522005190015  *  *                                                          *   *
0018532005190015  *  ************************************************************   *
001854200519      *
001900010111      ******************************************************************
002000010111
002100050824     FRPA069WK  ip   E             DISK
002700010108     FACCMST    IF   E           K DISK
002701080910     Finvdetl2  uf   e           k DISK
002900010111     FRPA060WK  O    E             DISK
0029010809110050 Fqsysprt   O    F  132        PRINTER OFLIND(*INOF)
003400050825     D  tmcnt          s                   like(rpmcnt)
003500050825     D  tprem          s                   like(rppprm)
003600050901     D  tcomm          s                   like(w9cmam)
0039000508250133 D  wkpct          s              7  6
003901191127     D**rpmcnt_big     s             11  6
003902110607     D parmrel         s                   like(rprelid)
003903110607     D parmcar         s                   like(rppcar)
003904110607     D parmmksz        s                   like(rpmaszcd)
003905110607     D parmeffymd      s                   like(rpefdt)
003906110607     D parmcomamt      s                   like(rppcom)
003907110607     D parmprem        s                   like(rppprm)
003908110607     D parmmcnt        s                   like(rpmcnt)
003909110607     D parmmethod      s                   like(rpaomthd)
003910110607     D parmrate        s                   like(rpaorate)
003911110607     D parmovramt      s                   like(rpaoamt)
003912110607     D parmfound       s              1
009400970918     D                UDS
009500980929     D  RUNDAT                 1      8  0
009600980929     D  RUNMM                  1      2  0
009700980929     D  RUNDD                  3      4  0
009800980929     D  RUNYY                  5      8  0
009902080206     D  lrunseq               21     22  0
010000970917     D  CONAME               201    240
0100010809100056 D  lrunymd              400    407  0                                      MDY
010002050824     Irpa069r
010003050824     I                                          w9cocd        L1
010004050824     I                                          w9sman        L1
010005050824     I                                          w9relid       L1
010006050824     I                                          w9trst        L1
010007050824     I                                          w9subd        L1
010008050824     I                                          w9acct        L1
010009050824     I                                          w9grp#        L1
010010050824     I                                          w9plan        L1
010011050824     I                                          w9efdt        L1
010401050824
010402050824     c                   if        *inl1
010403050824     c                   clear                   tmcnt
010404050824     c                   clear                   tprem
010405050824     c                   clear                   tcomm
010406050824     c                   end
010407050824
010408081007     c                   move      'Y'           onerec            1
010409081007
010410100817      *  If salesman commission is paid this run (w9pdfl = Y)
010411081007      *  accumulate member count, premium and commission then update the
010412081007      *  comm paid date.
010413081007     c                   if        w9pdfl = 'Y'
010415050824     c                   add       w9mcnt        tmcnt
010416050824     c                   add       w9prem        tprem
010417050824     c                   add       w9cmam        tcomm
010420100816      * update commission paid date in F.INVDET
010421080911     c     w9dtsq        chain     invdetl2
010422080911     c                   if        %found(invdetl2)
010424081020     c                   exsr      #upinvd
010473080911      * date/seq not found - error
010474080911     c                   else
010475080911     c                   if        firste = ' '
010476080911     c                   except    head
010477080911     c                   move      'N'           firste
010478080911     c                   end
010479080911     c   of              except    head
010480080911     c                   except    error2
010482080910     c                   end
010491081007     c                   end
010502080227
010503080910      * write RPA060WK rec if at least one record was in the input file
010504080227     cl1                 if        onerec = 'Y'
010505050824     Cl1                 exsr      #l1
010506080227     Cl1                 end
032201050819
032441050819
032442010125      **************************************************************************
032443081020      * update invoice detail with comm paid date
032500010125      **************************************************************************
032600081020     c     #upinvd       begsr
032602081020
032603100817      * if salesman commission paid date is 0
032608081020     c                   if        idcomdt = 0
032609081020
032610081020      * and remittance paid date = run date then
032611081020      * update comm paid date, else error
032612081020     c                   if        idpaid  = lrunymd
032613081020     c                   eval      idcomdt = lrunymd
032614081020     c                   update    invdr
032615081020     c                   else
032616081020     c                   if        firste = ' '
032617081020     c                   except    head
032618081020     c                   move      'N'           firste            1
032619081020     c                   end
032620081020     c   of              except    head
032621081020     c                   except    error
032622081020     c                   end
032623081020
032626081020      * if the comm paid date was not 0 and the rec is not a split comm
032627090624      * and the date is not today, then print error
032628081020     c                   else
032629090624     c                   if        w9pspl = 0 and idcomdt <> lrunymd
032630081020     c                   if        firste = ' '
032631081020     c                   except    head
032632081020     c                   move      'N'           firste            1
032633081020     c                   end
032634081020     c   of              except    head
032635081020     c                   except    error3
032636081020     c                   end
032637081020
032638081020     c                   end
032640081020
032641081020     c                   endsr
032642081020
032643081020      **************************************************************************
032644081020      * Write RPA060WK record - commission history
032645081020      **************************************************************************
032646081020     c     #l1           begsr
032700050824
032800010125     c                   clear                   rpa60r
032801050824
032900050824      * move fields to rpa060wk record
032901050824
033000050824     c                   move      runymd        rpcdat
033001050824     c                   movel     w9cocd        rpccde
033002050824     c                   movel     w9sman        rpsmcd
033200050824     c                   movel     w9relid       rprelid
033202050824     c                   movel     w9trst        rptrst
033203050824     c                   movel     w9subd        rpsub
033204050824     c                   movel     w9acct        rpacc
033205050824     c                   movel     w9grp#        rpgrp
033206050824     c                   movel     w9plan        rpplan
033207050824     c                   move      w9efdt        rpefdt
033900050824     c                   movel     w9smlast      rpslnm
034000050824     c                   movel     w9smfirst     rpsfnm
034100050824     c                   movel     w9smmi        rpsmi
035500050824     c                   movel     w9carr        rppcar
035600050824     c                   movel     w9cnam        rpcnam
035800050824     c                   movel     w9mthd        rpmthd
035900050824     c                   move      w9pspl        rppspl
036000080206     c                   move      lrunseq       rpseq#
036001050824     c                   movel     w9pdescr      rppdsc
036002050824     C                   move      *zeros        rpcpddt
037000030603
037100050825      * Set commission rate, mem cnt, prem and comm
037200050818
037300050824     c                   if        w9cmrt <> 0
037400050824     c                   z-add     w9cmrt        rpcmrt
037401050818     c                   else
038200050824     c                   z-add     w9glob        rpcmrt
038401050818     c                   endif
038504110307
038505050825     c                   z-add     tmcnt         rpmcnt
038506191127     c**                 z-add     tmcnt         rpmcnt_big
038507050825     c                   z-add     tprem         rppprm
038508061016      * 10/16/06 round total commision
038509061016     c     tcomm         mult(H)   1             rppcom
038601050824
038602050825      * apply prem split % to premium and member count
038700050824     c                   if        w9pspl <> 0
038800050824     c     w9pspl        div       100           wkpct
038900050825     c                   mult      wkpct         rppprm
039000050825     c                   mult      wkpct         rpmcnt
039001191127     c**                 mult      wkpct         rpmcnt_big
040100050824     c                   endif
040205110307
040206110307      * override / recalculate the rate when the Coventry Special split
040207110307      * comm with a non-global rate is used. These are set up with a flat
040208110307      * fee override and a premium split value.
040209111216      * 12/16/11 - use larger member count field with more decimal places
040210191127      * 11/27/19 - stop this recalculation since a large flat fee
040211191127      *            creates a large commission amount that along with
040212191127      *            a small member count (becuase of a split commission)
040213191127      *            could create a calculated rate that is too large to fit
040214191127      *            in the rpcmrt field that is only 5.2 and this results
040215191127      *            in a halt / error the way it was coded with an eval
040216191127      *            using rpcmrt. This happened when a 36.00 flat fee
040217191127      *            was set up in error and a 2.5% split with 42 members so
040218191127      *            we decided to eliminate this recalculation originally
040219191127      *            put in for Coventry that has since ended. An edit should
040220191127      *            also be put in the comctx maintenance program to prevent
040221191127      *            seting up a flat fee and split %.
040222191127      *
040223110307
040224191127     c**                 if        w9mthd = 'F' and w9pspl <> 0
040225191127     c**                 clear                   rpcmrt
040226191127     c**                 if        rpmcnt_big <> 0
040228191127     c**                 eval(h)   rpcmrt = %abs(rppcom /rpmcnt_big)
040229191127     c**                 end
040230191127     c**                 end
040231110307
040232050825      * get acct name
040233050825     c     ackey         chain     accmst
040234050825     c                   if        %found(accmst)
040235050825     c                   movel     acnam1        rpanm
040236050825     c                   end
040237050825
040238110616     C                   move      w9mksz        RPMASZCD
040239110616
040240110616      * is the sman commission paid?
040241081007     c                   if        w9pdfl = 'Y'
040242081007     c                   move      'Y'           rppaid
040243110616      * agency override
040244110616     c                   exsr      #getao
040245081007     c                   else
040246081007     c                   move      'N'           rppaid
040247081007     c                   end
040248110607
040249050825      * write commission history rec
040300010125     c                   write     rpa60r
040301050818
040500010125     c                   endsr
040600030411
040601110607      *************************************************
040602110607      * get agency override
040603110607      *************************************************
0406041106070120 C     #getao        begsr
0406051106070456
040606110607     c     grplist       plist
040607110607     c                   parm                    parmrel
040608110607     c                   parm                    parmcar
040609110607     c                   parm                    parmmksz
040610110607     c                   parm                    parmeffymd
040611110607     c                   parm                    parmcomamt
040612110607     c                   parm                    parmprem
040613110607     c                   parm                    parmmcnt
040614110607     c                   parm                    parmmethod
040615110607     c                   parm                    parmrate
040616110607     c                   parm                    parmovramt
040617110607     c                   parm                    parmfound
040618110607
040619110607      * set parameter values using RPA060WK fields. This is what the
040620110607      * agency override is calculated from
040621110607     c                   move      rprelid       parmrel
040622110607     c                   move      rppcar        parmcar
040623110607     c                   move      rpmaszcd      parmmksz
040624110607     c                   move      rpefdt        parmeffymd
040625110607     c                   move      rppcom        parmcomamt
040626110607     c                   move      rppprm        parmprem
040627110607     c                   move      rpmcnt        parmmcnt
040628110607     c                   clear                   parmmethod
040629110607     c                   clear                   parmrate
040630110607     c                   clear                   parmovramt
040631110607     c                   clear                   parmfound
040632110607
040633110607     c                   call      'GETAO'       grplist
040634110607
040635110607      * if a valid agency override was found then move the calculated
040636110607      * retun values to the rpa060wk fields
040637110607     c                   if        parmfound = 'Y'
040638110607     c                   move      parmmethod    RPAOMTHD
040639110607     c                   move      parmrate      RPAORATE
040640110607     c                   move      parmovramt    RPAOAMT
040641110607     c                   end
040642110607
0406431106070120 C                   ENDSR
040644110607
040645050824      *********************
040646050824      * first cycle
040647050824      *********************
040700030411     C     *INZSR        BEGSR
040701050824
041400030411     C     ACKEY         KLIST
041500050824     C                   KFLD                    w9trst
041600050824     C                   KFLD                    w9subd
041700050824     C                   KFLD                    w9acct
042201050824
042202050825      * Set run date to be YYYYMMDD
042203050824     C                   MOVEL     RUNDAT        RUNMD             4 0
042204050824     C                   MOVE      RUNDAT        RUNCY             4 0
042205050824     C                   MOVEL     RUNCY         runymd            8 0
042206050824     C                   MOVE      RUNMD         runymd
042300030411      *
042400030411     c                   endsr
0425000809110477 Oqsysprt   e            head           2  3
0427000809110478 O                                           45 '*****'
0428000809110479 O                       CONAME              85
0429000809110480 O                                           91 '*****'
0430000809110477 O          e            head           1
0431000809110482 O                                           66 'INVOICE DETAIL UPDATE ER'
0432000809110483 O                                           90 'RORS                    '
0433000809110477 O          e            head           1
0434000809110485 O                                           25 'PROGRAM NAME: RPA060N'
0435000809110486 O                                          125 'PAGE:'
0436000809110487 O                       PAGE          Z    131
0437000809110477 O          e            head           1
0438000809110489 O                                           13 'RUN DATE:'
0439000809110490 O                       UDATE         Y     24
0440000809110491 O                                           67 'FOR PERIOD:'
044100080911     O                       rundat              78 '  /  /    '
0441010809110477 O          e            head        1  1
0444000809110494 O                                           24 '""""""""""""""""""""""""'
0445000809110495 O                                           48 '""""""""""""""""""""""""'
0446000809110496 O                                           72 '""""""""""""""""""""""""'
0447000809110497 O                                           96 '""""""""""""""""""""""""'
0448000809110498 O                                          120 '""""""""""""""""""""""""'
0449000809110499 O                                          132 '""""""""""""'
0449010809110477 O          e            head           1
0452000809110502 O                                           10 'DATE/SEQ  '
0452010809110502 O                                           45 'IDCOMDT ALREADY IN FILE '
0452030809110502 O                                           82 'IDPAID ALREADY IN FILE  '
0452040809110477 O          e            head           2
0467000809110509 O                                           24 '""""""""""""""""""""""""'
0468000809110510 O                                           48 '""""""""""""""""""""""""'
0469000809110511 O                                           72 '""""""""""""""""""""""""'
0470000809110512 O                                           96 '""""""""""""""""""""""""'
0471000809110513 O                                          120 '""""""""""""""""""""""""'
0472000809110514 O                                          132 '""""""""""""'
0473000809110515 O*
0474000809110516 O          E            error          1
0475000906170518 O                       w9dtsq              19
0476000809110518 O                       idcomdt             44 '    /  /  '
0477000809110518 O                       idpaid              80 '    /  /  '
0477010810200518 O                                           +4 'IDPAID <> RUN DATE'
0478000809110516 O          E            error2         1
0479000906170518 O                       w9dtsq              19
0480000809110518 O                                           44 '* DATE/SEQ NOT FOUND *'
0481000810200516 O          E            error3         1
0482000906170518 O                       w9dtsq              19
0483000810200518 O                       idcomdt             44 '    /  /  '
0484000810200518 O                       idpaid              80 '    /  /  '
0485000810200518 O                                           +4 'COMDT<>0, NOT A SPLIT COMM'
