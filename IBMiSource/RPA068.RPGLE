0001000101200002  ******************************************************************
0002000101200003  * RPA068     GROUP BENEFIT SERVICES SOFTWARE           1988      *
0003000101200004  *                                                                *
0004000101200005  *            WRITTEN BY - MICHAEL C. DUNPHY                      *
0005000101200006  *            DATE - 01/26/89                                     *
0006000101200012  *                                                                *
0007000101200013  *  DESCRIPTION - THIS PROGRAM WILL ATTACH EACH MCOV RECORD       *
0008000101200014  *            WITH IT'S MEMBER RECORD AND TO THE COMMISSION       *
0009000101200015  *            CONTROL TO CREATE A WORK FILE TO BE USED FOR        *
0010000101200016  *            COMMISSION REPORTS.                                 *
0011000101200017  *                                                                *
0012000101200018  *  COMMISSION TYPES SUPPORTED:                                   *
0013000101200019  *  __________________________                                    *
0014000101200020  *                                                                *
0015000101200021  *     SALESMAN: (CODE TYPE 'H')                                  *
0016000101200022  *                                                                *
0017000101200023  *     -  FIXED FEE            FF    COMM AMOUNT                  *
0018000101200024  *     -  PERCENT OF PREMIUM   PP    PREMIUM * COMM%              *
0019000101200025  *     -  PERCENT OF LOAD      PL    (BILL - NET) * COMM%         *
0020000101200026  *                                                                *
0021000101200027  *                                                                *
0022000101200028  *     CORPORATE: (CODE TYPE 'I')                                 *
0023000101200029  *                                                                *
0024000101200030  *     -  PERCENT OF PREMIUM   PP    PREMIUM * COMM%              *
0025000101200031  *     -  LOAD BALANCE         LB    (BILL - NET - SMAN.COMM -    *
0026000101200032  *                                       ASS.FEE               )  *
0027000101200023  *     -  FIXED FEE            FF    COMM AMOUNT                  *
0028000101200033  *                                                                *
0029000101200034  *                                                                *
003000990113      *         1/13/99  REMOVE BENEGAP CODE                           *
003100010120      * 06/19/00 DLK - CONVERT TO RPGLE, external definitions and      *
0032000101200035  *                use invdet file instead of mcov to base         *
0033000101200035  *                commissions on.                                 *
0034000101200035  *                "IDEDT" will be used for selection and          *
0035000101200035  *                "IDCVDT" will be used for the effdt of          *
0036000101200035  *                commission.                                     *
0037000101200079  * 06/22/00 dlk - comctx is now considered valid up to and        *
0038000101200035  *                including the cancel date                       *
003900010120      * DLK 10/12/00 - change group # to 15 in invdet                  *
0040000101200035  * RLJ 01/20/01 - NEW CODE FOR NEW COMMISSION METHOD              *
004100010709      * 07/09/01 dlk - fix market size search - was not skipping       *
0042000107090035  *                records with enroll date = cancel date          *
0043000107090035  *                (never effective).                              *
0044000201250035  * RLJ 01/25/02 - For New Commission Method, Method "G" -         *
0045000201250035  *                Determine commission amt by mutplying  broker   *
0046000201250035  *                comm amt by member count.                       *
004700020221      * 02/21/02 dlk - fix override calc - was using billed rate       *
0048000202210035  *                instead of net rate to multiply % of prem.      *
0049000304290035  * 03.29.2003 ssk - salesman relationship project                 *
005000030530      * 05/30/03 dlk - add "P" to CCPNC field. This will indicate      *
0051000305300035  *                pay no comm but still show prem, mem cnt etc.   *
005200030908      * 09/08/03 dlk - supress printing relation id errors for comctx  *
0053000309080035  *                cancelled prior to 1/1/01.                      *
005400050824      * 08/16/05 dlk - add % of prem to global fee calc, rework logic, *
0055000508240035  *                add new fields to RPA069WK                      *
005600060518      * 05/17/06 dlk - add new com admin fee & bonus draw override     *
005700061013      * 10/12/06 DLK - Increase field size of W9CMAM & W9GLOB to 17.8
005800061013      *                (and all fields defined LIKE)
0059000708280015  * 08/28/07 dlk - change to find market size by transaction       *
0060000708280015  *                effdt instead of run effdt.                     *
0061000802050015  * 02/05/08 dlk - add field to output(work)files to indicate      *
0062000802050035  *                when a transaction should have commissions      *
0063000802050035  *                paid (all new transactions).                    *
0064000810070015  * 09/09/08 dlk - change when commission is paid. Now, we process *
0065000810070035  *                all records and only pay comm when we pay the
0066000810070035  *                carrier
0067000810100015  * 10/10/08 dlk - update invdet comm paid date for "pay no comm"  *
0068000810100015  *                records here since they will not be included    *
0069000810100035  *                rpa069wk for update in rpa060n.                 *
0070000810150015  * 10/15/08 dlk - change rpa068 file length, add comm paid dt from*
0071000810150035  *                invdet to rpa069WK and rpa068                   *
0072000901020015  * 01/02/09 dlk - broker com is now stored by date range, find    *
0073000901020035  *                by effdt of trans. Also find admin fee / bonus  *
0074000901020035  *                draw override by effdt of trans instead of      *
0075000901020035  *                remit effdt.                                    *
0076000905140015  * 05/14/09 dlk - do not include employer billed subsidy plans in *
0077000905140035  *                the contract count.                             *
0078001008090015  * 08/09/10 dlk - add w9ccpnc field                               *
0079001008170015  * 08/17/10 dlk - change rpa068 file length, add remit paid dt from *
0080001008170035  *                invdet to rpa069WK and rpa068                   *
0081001106150015  * 06/15/11 dlk - change rpa068 file to rpa068wk                  *
0082001401040015  * 01/03/14 dlk - add dep seq#, depend record will not alter      *
0083001401030035  *                member count.                                   *
0084001402280015  * 02/28/14 dlk - bday change will not alter member count         *
008500140506      * 04/09/14 dlk - tobacco adjustments will not affect member cnt
008600140815      * 08/15/14 dlk - stop printing manual adj report (Carol S request)
008700140910      * 09/10/14 dlk - change to use IDTRMD (record type effective date)
0088001409100035  *                instead of IDCVDT (invoice effective date)
0089001409100035  *                for all compensation calculations.
009000170130      * 01/30/17 dlk - change to use IDCAR (carrier code from invdet)
0091001701300035  *                instead of carrcd or pcarr (carrier codes from
0092001701300035  *                carrier master or plan master) in case admin
0093001701300035  *                changed a carrier code in the plan set up leaving
0094001701300035  *                a different carrier code in some invdet records.
0095001701300035  *                This happened once and caused a market size error.
009600181203      * 12/03/18 dlk - Cobra manual adjustments will now only back out the
0097001812030035  *                2% admin fee if net = billed. If net <> billed then
0098001812030035  *                use the net rate (these should be PSF plans).
0099002105130015  * 05/13/21 dlk - remove skip of employer billed subsidy plans (SFADM=Y)
0100002105130035  *                in the contract count since they need to be counted
0101002105130035  *                with this subsidy.
0102002105130035  *
0103000909020035  *  ** any changes the the calculations must also be made in      *
010400200519      *     RPA401 & RPA421 **
010500090902      *
0106000101200036  ******************************************************************
0107000101200037  *
0108000006230038 FCmct14    IP   e           k DISK
0109000006190039 FCRAT13    IF   e           k DISK
0110000102010040 Finvdwkl2  IF   e           k DISK
0111000006190043 FPLNMST    IF   e           k DISK
0112000006190044 FTRSMST    IF   e           k DISK
0113000006190046 FCARMST    IF   e           k DISK
0114000508220047 FSUBMST    IF   e           k DISK
0115000006190014 FSMAN      IF   e           k DISK
0116000011060014 Fcodes     IF   e           k DISK
0117000101200014 Fmktcara1  IF   e           k DISK
0118000101200014 Fbrkrcom1  IF   e           k DISK
011900030429     fsmanrlt   if   e           k disk
012000030429     fspragxr2  if   e           k disk
012100060517     faboverl1  if   e           k disk
012200081010     Finvdetl2  uf   e           k DISK    rename(invdr:invdrl2) prefix(I_)
0123000101200049 FRPA069WK  O  A E             DISK
0124001106150049 FRPA068WK  O  A F  193        DISK
0125000006190050 FREPORT    O    F  132        PRINTER OFLIND(*INOF)
0126001408150050 F*sysprt   O    F  132        PRINTER OFLIND(*INOg)
0127000101200051  *
0128000304290051 D MSG             S             40    DIM(7) CTDATA PERRCD(1)
0129000508160051 D globalcomamt    S                   like(w9cmam)
0130000607190051 D wkprem          S                   like(w9prem)
0131000607190133 D wkpct           s              7  6
0132000607190133 D wksplitpct      s              7  6
0133000810070133 D rppdfl          s              1
0134000101200132 D                 DS
0135001409100133 D  idtrmd                 1      8  0
0136000104050134 D   efday                 7      8  0
0137000104180132 D                 DS
0138000104180133 D  idrc                   1      3
0139000104180134 D   idrc2                 2      3
0140000104050132 D                 DS
0141000104050133 D  DTETMP                 1      8  0
0142000104050134 D  CENRMM                 5      6  0
0143009809280135 D  CENRDD                 7      8  0
0144009809280136 D  CENRYY                 3      4  0
0145009102150171 D                UDS
0146000802050172 D  leffdt                 1      8  0
0147009102150177 D  CONAME               201    240
0148000802050056 D  lrunymd              400    407  0
0149000006230032 Icomcxr
0150000006230033 I                                          cmtrst        l2
0151000006230033 I                                          csubdv        l1
0152000006230033 I                                          cmplan        l1
015300170130      * get trust master on trust change
015400000623     c                   if        *inl2
0155000006230259 C     cmtrst        CHAIN     TRSMST                             69
015600000623     c                   if        *in69
0157000006230305 C                   Z-ADD     5             X
0158000006230306 C                   EXCEPT    ERROR
015900000623     c                   end
016000000623     c                   end
016100000623
016200170130      * get plan master on plan change
016300000623     c                   if        *inl1
0164000006230266 C     KEYPLN        CHAIN     PLNMST                             68
016500000623     c                   if        *in68
0166000006230305 C                   Z-ADD     2             X
0167000006230306 C                   EXCEPT    ERROR
016800000623     c                   end
016900000623     c                   end
017000000623
017100010130      *
017200010130      *  SELECT COMCTX RECORDS
017300010130      *  6/20/00 all comctx will be processed and the date compare
017400010130      *  will be done when the transactions are read from INVDWK
017500010130      *
017600170130     c                   if        *in69 or *in68 or
017700000623     c                             cmdltd = 'D' or effdat = cmcan
017800000620     C                   GOTO      #end
017900000619     C                   END
018000000623
018100010130      * GLC - 1/5/95
018200030529      * GET SALESMAN MASTER FILE FOR STYPE IN CRATE SEARCH
018300050824      * and name is used in rpa069wk
0184000006230266 C     SLSMAN        CHAIN     SMAN                               43
018500000623     c                   if        *in43
0186000006230261 C                   Z-ADD     4             X                 2 0
018700000623     c                   move      slsman        smanout           3
018800000623     C                   except    error
018900000623     c                   move      *blanks       smanout           3
019000000623     C                   goto      #end
019100000623     c                   end
0192000304290188 C*
019300030429     c     cmrelid       chain     srf
019400030429     c                   if        not  %found(smanrlt)
019500030908
019600030908      * do not print error if cancelled prior to 1/1/01
019700030908
019800030908     c                   if        cmcan = 0 or cmcan > 20010101
019900030429     c                   Z-ADD     6             X
020000030429     c                   move      slsman        smanout
020100030429     c                   except    error
020200030429     c                   move      *blanks       smanout
020300030908     c                   end
020400030908
020500030429     c                   goto      #end
020600030429     c                   end
020700030908
020800030429     c     srasid        chain     sxf
020900030429     c                   if        not  %found(spragxr2)
021000030429     c                   Z-ADD     7             X
021100030429     c                   move      slsman        smanout
021200030429     c                   except    error
021300030429     c                   move      *blanks       smanout
021400030429     c                   goto      #end
021500030429     c                   end
0216009609180188 C*
0217000101300079 C* 6/20/00 - invoices and adjustments from invdwk now drive commissions
0218000006200079 C*
0219000006190212 C                   SETOFF                                           66
0220000102010213 C     invkey        SETLL     invdwkl2
022100000619     c                   dow       *in66 = *off
0222000102010216 C     invkey        READe     invdwkl2                               66
0223000006200218 C   66              GOTO      #end
022400000620
0225000101200272  * if transaction is not within date range of COMCTX, skip it
022600140910     c                   if        idtrmd < effdat or (cmcan <> 0 and
022700140910     c                             idtrmd > cmcan)
022800000620     c                   iter
022900000620     c                   end
0230000508190272
0231001701300272  * 01/30/17 change -
0232001701300272  * get carrier master using carrier code from invoice detail record
0233001701300272  * in case it was changed in the plan master
0234001701300311 C     idcar         CHAIN     CARMST
023500170130     c                   if        not %found(carmst)
0236001701300313 C                   Z-ADD     3             X
0237001701300314 C                   EXCEPT    ERROR
0238001701300314 C                   iter
023900170130     c                   end
024000170130
0241000508190272  * calc commission based on old or new schedule
024200010120     c                   if        comsch = '2'
024300010120     c                   exsr      #newcom
024400010206     c                   else
024500050819     c                   exsr      #oldcom
024600050819     c                   end
024700050819
0248000006190415 C                   enddo
024900000619
0250000006200416 C     #end          TAG
0251000101200456  *
0252000101200103  ************************************************************
0253000101230104  * #NEWCOM SR - BUILD RPA069WK USING NEW COMMISSION METHOD   *
0254000101200105  ************************************************************
0255000101200107  *
0256000101200106 C     #NEWCOM       BEGSR
025700010123
025800010123      * list manual adjustments for finance
025900140815     c*                  movel     idtrcd        type              1
026000140815     c*                  if        type = 'A'
026100140815     c*                  exsr      #prtadj
026200140815     c*                  end
026300050819
026400010120     c                   clear                   rpa069r
026500010120     C                   z-add     idtrst        w9trst
026600010120     C                   z-add     idsubd        w9subd
026700010120     C                   z-add     idacct        w9acct
026800010120     C                   movel     idplan        w9plan
026900010120     C                   movel     idgrp#        w9grp#
027000010120     C                   z-add     idss#         w9ss#
027100140103     C                   z-add     idseq         w9seq
027200140910     C                   z-add     idtrmd        w9efdt
027300020221     C                   z-add     idtram        w9prem
027400010202     C                   z-add     idedt         w9edt
027500030603     C                   movel     cmrelid       w9relid
027600050824     C                   movel     pdescr        w9pdescr
027700050824     C                   movel     slname        w9smlast
027800050824     C                   movel     sfname        w9smfirst
027900050824     C                   movel     smi           w9smmi
028000081015     C                   move      idcomdt       w9comdt
028100100809     C                   move      ccpnc         w9ccpnc
028200100817     C                   move      idpaid        w9idpaid
028300100813
0284001008130429  * if ccpnc = N then no commission, AF or BD will be paid so this
0285001008130429  * record will NOT be added to RPA069WK. If this record was eligible
0286001008130429  * for commission payment then update the commission paid date in
0287001008130429  * invdet since it will not make the update in RPA060N.
028800100813      * 5/29/03 new definition of ccpnc : N = no com, no prem, no mem cnt
028900100813      *                                   P = no com, yes prem, yes mem cnt
029000100813      *                                      (this allows the AF & BD to calc)
029100100813     c                   if        ccpnc = 'N'
029200100813     c                   if        idcomdt = 0 and idpaid = lrunymd
029300100813     c                   exsr      #upinvd
029400100813     c                   end
029500100813     c                   leavesr
029600100813     c                   end
029700100813
029800080205
0299000101230429  *
0300001812030429  * COBRA invoices: The billed amount (IDTRAMB) holds the rate plus
0301001812030429  * the 2% surcharge. The net (IDTRAM) holds the original rate without
0302001812030429  * the 2% added.
0303001812030429  * COBRA adjustments: billed should hold the rate + 2% and net will
0304001812030429  * hold either the same amount or rate less 2% and PSF.
0305001812030429  *
0306001812030429  * 12/3/18 If the billed = net then still get the billed less 2%,
0307001812030429  * otherwise still use the net rate (these should be PSF plans) which
0308001812030429  * is already in w9prem.
030900010405     C                   if        idcob = 'C' and w9prem <> 0
031000010123
0311001812030429  * cobra manual adj (CMA)
031200010123     c                   if        idrc  = 'CMA'
031300181203     c                   if        idtramb = idtram
031400010123     c     idtramb       div(h)    1.02          w9prem
031500181203     c                   end
0316001812030429  * cobra invoices
031700010123     c                   else
031800010123     c                   move      idtram        w9prem
031900010123     c                   end
032000010123
032100010123     c                   end
0322000101230361
032300010120     C                   movel     idcar         w9carr
032400010120     C                   movel     cname         w9cnam
032500010120     C                   movel     slsman        w9sman
032600030429     c                   movel     sxagcy        w9cocd
032700010120     C                   movel     iddtsq        w9dtsq
032800010125     C                   z-add     cccmsp        w9pspl
0329000305300408
0330000305300408  * set Member count based on tran code
0331001401030408  * change records have 0 member count
0332000508250408  * If first of month or curent enrollment (invoice) or tran code is
0333000508250408  * Add Coverage => base Mbr Cnt on sign of Tran Net Amt
0334000905140408  * 5/14/09 - employer billed subsidy plans have a 0 member count
0335000905140408  *           (SFADM = Y)
0336001401030408  * 1/03/14 - dependent records have a 0 member count
0337001405060408  * 4/08/14 - tobacco records have a 0 member count
0338002105130408  * 5/13/21 - employer billed subsidy plans (SFADM=Y) are counted now
0339002105130408  *           but the member subsidy plans are not ($0 prem)
034000030530
034100050825     c                   clear                   w9mcnt
034200050825     c                   if        (idtrcd <> 'MCC' and idtrcd <> 'MCA'
034300210513     c                              and idtrcd <> 'MCB'
034400140409     c                              and idtrcd <> 'M10' and idtrcd <> 'MSM'
034500140506     c                              and idtrcd <> 'MSK'
034600140409     c                              and idseq = 00) and
034700050825     c                             (efday = 01 or idrc2 = 'CE' or
034800050825     c                              idtrcd = 'MAC')
034900030530
035000010120     c                   if        idtram > 0
035100010120     c                   eval      w9mcnt = 1
035200010418     c                   else
035300010418     c                   if        idtram < 0
035400010120     c                   eval      w9mcnt = -1
035500050825     c                   end
035600050825     c                   end
035700030530
035800050825     c                   end
035900010120
0360000305300456  * Get Acct Mkt size - default to 50 if not found
036100030530     c                   clear                   w9mksz
036200010120     c                   eval      *in21 = *off
036300010120     c     mkcaky        setll     mktcara1
036400010120     C                   dow       *in21 = *off
036500010120     c     mkcaky        reade     mktcara1                               21
0366000101200133 C   21              leave
036700010709     c                   if        mafrdt <> matodt
036800140910     c                   if        (mafrdt <= idtrmd and matodt >= idtrmd) or
036900140910     c                             (mafrdt <= idtrmd and matodt = 0 )
037000010120     c                   movel     maszcd        w9mksz
037100010120     c                   leave
037200010120     c                   endif
037300010709     c                   endif
037400010120     c                   enddo
0375000101200456  *
037600010120     c                   if        w9mksz = *blanks
037700010120     c                   movel     '50'          w9mksz
037800030530     c                   endif
037900030530
0380000508190456  *******************
0381000508190456  * Calculate commission
0382000508190456  *******************
0383000305300456
0384000305300456  * if pay no comm field was set to "P" then skip all comm calcs
0385001008170456  * this allows prem and member count to pass through to the commission
0386001008170456  * and remittance so admin fee and bonus draw can be calculated but
0387001008170456  * no commission will be paid
038800030530     c                   if        ccpnc = 'P'
038900030530     c                   clear                   w9cmam
039000030530     c                   clear                   w9mthd
039100030530     c                   clear                   w9glob
039200030530     c                   goto      #writ69
039300030530     c                   endif
039400030530
039500050819      *******************
0396000508160456  * global Commission = mbr count x flat fee
0397000508160456  * 8/15/05 add % of prem calc
039800050819      *******************
039900030530
040000050816     c                   clear                   globalcomamt
040100050817     c                   clear                   rbrkrcom
040200090102     c                   clear                   foundbrkrc        1
040300050816
040400090102     c* 01/02/09 - use effdt of trans to find broker com
040500090102     c     brcmky        setll     brkrcom1
040600090102     c                   dou       %eof(brkrcom1)
040700090102     c     brcmky        reade     brkrcom1
040800090102     C                   if        (not %eof(brkrcom1)) and
040900090102     C                             (bcfromdt <> bctodate) and
041000140910     c                             ((bcfromdt <= idtrmd and bctodate >= idtrmd)
041100140910     c                               or (bcfromdt <= idtrmd and bctodate = 0))
041200090102     c                   eval      foundbrkrc = 'Y'
041300090102     c                   leave
041400090102     c                   end
041500090102     c                   enddo
041600090102
041700090102     c                   if        foundbrkrc = 'Y'
041800050816
041900050816      * global fee per member - default method
042000050818     c                   clear                   w9cmrt
042100010125     c                   z-add     bcamnt        w9glob
042200020125     c     w9mcnt        mult      bcamnt        w9cmam
042300050816     c                   z-add     w9cmam        globalcomamt
042400010125     c                   movel     'G'           w9mthd
042500050816
042600050816      * global % of prem
042700050816     c                   if        bcpop <> 0
042800050816     c                   z-add     bcpop         w9cmrt
042900050816     c                   clear                   w9cmam
043000050816     c                   clear                   wkpct
043100050816     c     bcpop         div       100           wkpct
043200050816     c     wkpct         mult      w9prem        w9cmam
043300050816     c                   z-add     w9cmam        globalcomamt
043400050818      * w9glob will hold the orig calculated % of prem amt
043500050818     c                   z-add     w9cmam        w9glob
043600050816     c                   movel     'O'           w9mthd
043700050816     c                   end
043800050816
043900030530     c                   endif
0440000305300456
044100050819      *******************
044200050816
0443000508190456  * flat fee commissions do not pay on change transactions
0444000508190456  * create an adj rec only (skip all calcs) when % comm methods
0445000508250456  *
0446000508250456  * 8/25/05 - this block of codes should not be necessary since the
0447000508250456  *           member count of ZERO should take care of the calculations
0448000508250456  *           and not pay when the method is a flat fee.
044900050816
045000050825     c**                 if        (idtrcd = 'MCC' or idtrcd = 'MCA' or
045100050825     c**                           idtrcd = 'MCB') and ccovpp = 0
045200050825     c**                           and w9mthd <> 'O'
045300050825     c**                 movel     'A'           w9mthd
045400050825     c**                 z-add     0             w9mcnt
045500050825     c**                 z-add     0             w9cmam
045600050825     c**                 clear                   w9glob
045700050825     c**                 clear                   w9cmrt
045800050825     c**                 goto      #writ69
045900050825     c**                 endif
046000050816
046100050819      ********
0462000508160456  * process overrides to global commission
046300050819      ********
0464000305300456
0465000508160456  * flat fee per member override
0466000305300456
046700010120     c                   if        ccovra <> *zero
046800030530     c                   movel     'F'           w9mthd
046900030530     c                   clear                   w9cmam
047000050816     c                   clear                   w9cmrt
047100030530     c     w9mcnt        mult      ccovra        w9cmam
047200020125     c                   z-add     ccovra        w9glob
047300030530
047400010120     c                   else
0475000305300456
0476000305300456  * % of commission override
047700030530
047800010120     c                   if        ccovpc <> *zero
047900010120     c                   movel     'C'           w9mthd
048000010120     c                   z-add     ccovpc        w9cmov
048100030530     c                   clear                   w9cmam
048200010120     c     ccovpc        div       100           wkpct
048300050816     c     wkpct         mult      globalcomamt  w9cmam
048400030530
048500030530     c                   else
048600030530
0487000305300456  * % of premium override
048800030530
048900030530     c                   if        ccovpp <> *zero
049000030530     c                   movel     'P'           w9mthd
049100030530     c                   z-add     ccovpp        w9cmrt
049200030530     c                   clear                   w9cmam
049300030530     c     ccovpp        div       100           wkpct
049400060719
0495000607190456  * if premium split is entered (split commisison) the premium must
0496000607190456  * first be reduced by the split % before the % of prem can be calc
049700060719     c                   if        w9pspl <> 0
049800060719     c     w9pspl        div       100           wksplitpct
049900060719     c     wksplitpct    mult      w9prem        wkprem
050000060719     c                   else
050100060719     c                   z-add     w9prem        wkprem
050200060719     c                   end
050300060719
050400060719     c     wkpct         mult      wkprem        w9cmam
050500030530     c                   end
050600030530
050700030530     c                   endif
050800030530     c                   endif
0509000305300456
051000030530     c     #writ69       tag
051100030530
0512000305300456  * Ensure commission amt is same sign as premium
051300030530
051400010201     c                   if        w9prem < 0 and w9cmam > 0
051500010201     c     w9cmam        mult      -1            w9cmam
051600030530     c                   endif
0517000305300456
051800060517      * check for admin fee / bonus draw override
051900060517     c                   exsr      #getabover
052000060517
0521001008170429  * pay sman commission for records we have not previously paid
0522001008170429  * commission and we paid the carrier in this run today.
052300100816     c                   if        idcomdt = 0 and idpaid = lrunymd
052400100813     c                   move      'Y'           w9pdfl
052500100813     c                   end
052600100813
052700010204     c                   write     rpa069r
0528000305300456
0529000101200456  *
0530000305300120 C                   ENDSR
053100050819
053200081010      *****************************************************
053300081010      * update invoice detail rec for ccpnc = n records that we have
053400081021      * a payment for. report as an error any record that already has
053500081021      * the comm paid date filled in with a date other than the run date
053600081021      * (since there are a few records set up with multiple salesman
053700081021      * and the ccpnc fields = N)
053800081010      *****************************************************
053900081010     c     #upinvd       begsr
054000081010     c     iddtsq        chain     invdetl2
054100081010     c                   if        %found(invdetl2)
054200081021
054300081021     c                   if        i_idcomdt = 0
054400081021     c                   eval      i_idcomdt = lrunymd
054500110616     c                   update    invdrl2
054600081021      * not 0
054700081010     c                   else
054800081021     c                   if        i_idcomdt <> lrunymd
054900081021     c                   except    error2
055000081010     c                   end
055100081021     c                   end
055200081021
055300081010      * date/seq not found - error
055400081010     c                   else
055500081010     c                   except    error3
055600081010     c                   end
055700081010
0558000810100120 C                   ENDSR
055900081010
056000050819      *****************************************************
056100050819      * old commission schedule
056200050819      *****************************************************
056300050819     c     #oldcom       begsr
056400050819
0565001008170429  * pay sman comm for records we have not previously paid commission
0566000810070429  * and we paid the carrier in this run today
056700081007
056800081007     c                   clear                   rppdfl
056900081007     c                   if        idcomdt = 0 and idpaid = lrunymd
057000081007     c                   move      'Y'           rppdfl
057100081007     c                   end
0572000810070429  *
0573000508190237 C* get crate
0574000508190239 C*
0575000508190246 C                   SETOFF                                       51
057600050819     c                   move      ' '           crrec             1
0577000508190245 C     CRATKY        SETLL     CRAT13
0578000508190247 C                   dow       *in51 = *off
0579000508190248 C     CRATKY        READE     CRAT13                                 51
058000050819     C*
058100050819     C                   if        *in51 = *off and crdltd <> 'D' and effdat
058200050819     C                             >= frdate and effdat <= todate
0583000508190252 C                   move      'Y'           crrec
0584000508190252 C                   leave
0585000508190253 C                   END
058600050819     c                   enddo
058700050819
0588000508190256 C*
0589000508190256 C* if no crate print error and continue reading invdwk
0590000508190256 C*
0591000508190257 C                   if        crrec = ' '
0592000508190261 C                   Z-ADD     1             X                 2 0
059300050819     C                   MOVE      effdat        @DATIN
059400050819     C                   EXSR      #DATYM
059500050819     C                   MOVE      @DATOU        effmdy            8 0
0596000508190267 C                   EXCEPT    ERROR
059700050819     c                   move      0             effmdy
0598000508190268 C                   leavesr
059900050819     c                   end
060000050819
0601000508190273 C                   Z-ADD     effdat        DTETMP
0602000508190274  *
0603000508190275  *  CHECK DONE TO SEE IF WHEN THE PROCEDURE IS RUN THE COMMISSION
0604000508190276  *  PERIOD IS EXPIRED.
0605000508190277  *  IF THE COMMISSION PERIOD IN MONTHS IS GREATER THEN 0 ADD IT TO
0606000508190278  *  THE ENROLLMENT MONTH.  KEEP SUBTRACTING 12 AND ADDING ONE TO THE
0607000508190279  *  YEAR UNTIL THE MONTH IS LE 12 (TO MAKE A NORMAL DATE).
0608001409100280  *  THEN COMPARE THE NEW ENROLLMENT DATE AND idtrmd . IF ENROLLMENT DATE
0609001409100281  *  IS LATER THEN idtrmd  THE COMMISSION HAS EXPIRED.  ADD THE COMMISSION
0610000508190282  *  PERCENT TO GBS'S COMMISSION PERCENT AND ZERO OUT THE SALESMAN'S
0611000508190283  *  COMMISSION PERCENT TO BE UPDATED IN THE WORK FILE.
0612000508190284  *
0613000508190285 C     COMPRD        IFGT      0
0614000508190286 C                   ADD       COMPRD        CENRMM
0615000508190287 C     CENRMM        DOWGT     12
0616000508190288 C     CENRMM        SUB       12            CENRMM
0617000508190289 C                   ADD       1             CENRYY
0618000508190290 C                   END
0619000508190291 C                   Z-ADD     DTETMP        CYYMMD            8 0
0620001409100293 C     CYYMMD        IFLE      idtrmd
0621000508190294 C     COMTYP        IFEQ      'HPP'
0622000508190295 C                   ADD       COMRTE        CRPRTE
0623000508190296 C                   END
0624000508190297 C                   Z-ADD     0             COMRTE
0625000508190298 C                   END
0626000508190299 C                   END
0627000508190417  *
0628000508190429  * billed amount comes from field "IDTRAMB" in invdwk file,
0629000508190429  * "IDTRAM" is net
0630000508190417  *
063100050819     c                   move      idtramb       prem              7 2
063200050819     c                   move      idtram        netrte            7 2
0633000508190429  *
0634001812030429  * COBRA invoices: The billed amount (IDTRAMB) holds the rate plus
0635001812030429  * the 2% surcharge. The net (IDTRAM) holds the original rate without
0636001812030429  * the 2% added.
0637001812030429  * COBRA adjustments: billed should hold the rate + 2% and net will
0638001812030429  * hold either the same amount or rate less 2% and PSF.
0639001812030429  *
0640001812030429  * 12/3/18 If the billed = net then still get the billed less 2%,
0641001812030429  * otherwise still use the net rate (these should be PSF plans) which
0642001812030429  * is already in prem.
064300181203     C                   if        idcob = 'C' and prem <> 0
064400050819
0645001812030429  * cobra manual adj (CMA)
064600050819     c                   if        idrc  = 'CMA'
064700181203     c                   if        idtramb = idtram
064800181203     c     idtramb       div(h)    1.02          prem
064900181203     c                   move      prem          netrte
065000181203     c                   end
0651001812030429  * cobra invoices
065200050819     c                   else
065300050819     c                   move      idtram        prem
065400050819     c                   end
065500050819
065600050819     c                   end
0657000508190361
0658000508190364 C                   Z-ADD     *ZEROS        HOLD1
0659000508190365  *
0660000508190366  *    CALCULATE SALESMAN COMMISSION AOMUNT...........
0661000508190367  *
0662000508190368 C                   move      *ZEROS        SLSCOM            9 2
0663000508190369 C                   move      *ZEROS        CRPCOM            9 2
0664000508190370  *
0665000508190370  * flat fee only paid for current enrollment and retro activity
0666000508190370  * for add,term,rein.
0667000508190370  *
0668000508190371 C     COMTYP        IFEQ      'HFF'
066900050819
067000050819     c                   if        idtrcd = 'MCC' or idtrcd = 'MCA' or
067100050819     c                             idtrcd = 'MCB'
067200050819     c                   leavesr
067300050819     c                   end
067400050819
067500050819     c* positive prem = positive flat fee
067600050819     c* negative prem = negative flat fee
067700050819     c* zero prem     = zero     flat fee
067800050819
067900050819     c                   if        prem > 0
0680000508190372 C                   add       COMRTE        SLSCOM
0681000508190373 C                   else
068200050819     c                   if        prem < 0
0683000508190372 C                   sub       COMRTE        SLSCOM
0684000508190373 C                   end
0685000508190373 C                   end
068600050819
0687000508190373 C                   END
0688000508190374 C*
0689000508190375 C     COMTYP        IFEQ      'HPP'
0690000508190376 C     PREM          MULT(H)   COMRTE        HOLD1             9 2
0691000508190377 C     HOLD1         DIV(H)    100           HOLD1
0692000508190378 C                   Z-ADD     HOLD1         SLSCOM
0693000508190379 C                   END
0694000508190380 C*
0695000508190381 C     COMTYP        IFEQ      'HPL'
0696000508190382 C     PREM          SUB       NETRTE        LOAD              9 2
0697000508190383 C     LOAD          MULT(H)   COMRTE        HOLD1
0698000508190384 C     HOLD1         DIV(H)    100           HOLD1
0699000508190385 C                   Z-ADD     HOLD1         SLSCOM
0700000508190386 C                   END
0701000508190387 C*
0702000508190388 C*   CALCULATE CORPORATE COMMISSION AMOUNT.........
0703000508190389 C*    ** LOAD BALANCE **
0704000508190389 C*
0705000508190389 C*
0706000508190390 C     CRPTYP        IFEQ      'ILB'
0707000508220391 C     subkey        CHAIN     SUBMST                             55
0708000508190392 C     PREM          SUB       NETRTE        HOLD1
0709000508190393 C     PLNCAT        IFEQ      'PMM'
0710000508190394 C     HOLD1         SUB       COMFEE        HOLD1
0711000508190395 C                   END
0712000508190396 C     PLNCAT        IFEQ      'PMS'
0713000508190397 C     HOLD1         SUB       COMFEE        HOLD1
0714000508190398 C                   END
0715000508190399 C     HOLD1         SUB       SLSCOM        CRPCOM
0716000508190400 C                   END
0717000508190401 C*
0718000508190389 C*    ** % OF LOAD - CORPORATE **
0719000508190401 C*         "ILC" NOT PROCESSED IN PGM SO THE COMMISSION WILL BE 0
0720000508190401 C*
0721000508190389 C*   THIS TYPE WILL BE USED FOR SPLIT COMMISSIONS ONLY...SMAN TYPE
0722000508190389 C*   OF "CC" WILL HAVE "PL" IN CORP TYPE AND RATE IN CORP RATE
0723000508190389 C*   BUT WILL NOT HAVE ANYTHING IN SMAN RATE. THE SMAN WILL
0724000508190389 C*   HAVE IT'S OWN SEPERATE COMM RATE RECORD WITH SMAN RATE
0725000508190389 C*   FILLED IN AND CORP TYPE "LC" AND 0 RATE
072600050819     C*
072700050819     C*  8/20/97 : CHANGE TO ALLOW SMAN TYPE OF "PP" AND CORP TYPE
072800050819     C*            OF "LC" (ONLY CHANGE WAS TO FM160 TO ALLOW INPUT)
072900050819     C*
073000050819     C*    * IMPORTANT FOR THE USERS TO REMEMBER : ALL % MUST ADD UP
073100050819     C*      TO 100
073200050819     C*
0733000508190389 C*      EXAMPLE:
0734000508190389 C*   SMAN  COMM   COMM    CORP   CORP
0735000508190389 C*   TYPE  RATE   TYPE    RATE   TYPE
0736000508190389 C*   ----  -----  ----    -----  -----
0737000508190389 C*   AC    39.66    PL     0.00    LC
0738000508190389 C*   CC     0.00          33.34    PL
0739000508190389 C*   OB    27.00    PL     0.00    LC
0740000508190389 C*
0741000508190389 C*
0742000508190389 C*
0743000508190390 C     CRPTYP        IFEQ      'IPL'
0744000508190382 C     PREM          SUB       NETRTE        LOAD              9 2
0745000508190401 C*
0746000508190401 C* "LOAD" IS THE LOAD...CORP COMM IS % OF LOAD
0747000508190401 C*
0748000508190383 C     LOAD          MULT(H)   CRPRTE        HOLD1
0749000508190384 C     HOLD1         DIV(H)    100           HOLD1
0750000508190385 C                   Z-ADD     HOLD1         CRPCOM
0751000508190400 C                   END
0752000508190401 C*
0753000508190401 C*
0754000508190402 C     CRPTYP        IFEQ      'IPP'
0755000508190403 C     PREM          MULT(H)   CRPRTE        HOLD1
0756000508190404 C     HOLD1         DIV(H)    100           HOLD1
0757000508190405 C                   Z-ADD     HOLD1         CRPCOM
0758000508190406 C                   END
0759000508190407 C*
0760000508190370 C*
0761000508190370 C*
0762000508190370 C* flat fee only paid for current enrollment and retro activity
0763000508190370 C* for add,term,rein.
0764000508190370 C*
0765000608240402 C                   IF        crptyp = 'IFF'
076600060824     c                   clear                   crpcom
076700060824     c                   if        idtrcd <> 'MCC' and idtrcd <> 'MCA'
076800050819     c                             and idtrcd <> 'MCB'
076900050819     c                   if        prem > 0
0770000508190372 C                   z-add     CRPRTE        CRPCOM
077100050819     c                   else
077200050819     c                   if        prem < 0
0773000508190372 C                   z-sub     CRPRTE        CRPCOM
0774000508190373 C                   end
0775000508190373 C                   end
077600050819     c                   end
077700060824     c                   end
0778000508190408  *
0779000508190408  * calculate member count for this record (0,1,-1)
0780000508190408  * change transactions are 0, all others add 1 for positive amount
0781000508190408  * and sub 1 for negative amount. this should handle voids since
0782000508190408  * voids reverse the transaction
0783000905140408  * 5/14/09 - employer billed subsidy plans have a 0 member count
0784000905140408  *           (SFADM = Y)
0785001401030408  * 1/03/14 - dependent records have a 0 member count
0786001405060408  * 4/09/14 - Tobacco records have a 0 member count
0787002105130408  * 5/13/21 - employer billed subsidy plans (SFADM=Y) are counted now
0788002105130408  *           but the member subsidy plans are not ($0 prem)
078900210513
079000050819     c                   move      0             memcnt            1 0
079100050819
079200050819     c                   if        idtrcd <> 'MCC' and idtrcd <> 'MCA'
079300210513     c                             and idtrcd <> 'MCB'
079400140409     c                             and idtrcd <> 'M10' and idtrcd <> 'MSM' and
079500140506     c                             idtrcd <> 'MSK' and
079600140228     c                             idseq = 00
079700050819     c                   if        idtram > 0
079800050819     c                   eval      memcnt = 1
079900050819     c                   end
080000050819     c                   if        idtram < 0
080100050819     c                   eval      memcnt = -1
080200050819     c                   end
080300050819     c                   end
080400050819
0805000508190409 C                   EXCEPT    RPADD1
080600050819
080700050819     c* list manual adjustments for finance
080800140815     c*                  movel     idtrcd        type              1
080900140815     c*                  if        type = 'A'
081000140815     c*                  exsr      #prtadj
081100140815     c*                  end
081200050819
081300050819     c                   endsr
081400050819
081500050819      ******************************************
081600050819      * list manual adjustments for finance
081700050819      ******************************************
081800140815     c*    #prtadj       begsr
081900140815     c*                  move      idtrcd        t2                2
082000140815     c*    codkey        chain     codes
082100140815     c*                  if        %found(codes)
082200140815     c*                  move      ldescr        desout           30
082300140815     c*                  else
082400140815     c*                  move      *blanks       desout
082500140815     c*                  end
082600140815     c*                  except    manadj
082700140815     c*                  endsr
082800140815
082900060517      ******************************************
083000060517      * get admin fee / bonus draw override
083100060517      ******************************************
083200060517     c     #getabover    begsr
083300060517
083400060517     c                   clear                   w9afovpp
083500060517     c                   clear                   w9afovff
083600060517     c                   clear                   w9afovpc
083700060517     c                   clear                   w9bdovpp
083800060517     c                   clear                   w9bdovff
083900060517     c                   clear                   w9bdovpc
084000060517
084100090102      * 1/2/09 change to use trans effdt for the search instead of remit dt
084200060517     c     abkey         setll     aboverl1
084300060517     C                   dou       %eof(aboverl1)
084400060517     c     abkey         reade     aboverl1
084500060517     C                   if        (not %eof(aboverl1)) and
084600060517     C                             (abfrdt <> abtodt) and
084700140910     c                             ((abfrdt <= idtrmd and abtodt >= idtrmd) or
084800140910     c                              (abfrdt <= idtrmd and abtodt = 0))
084900060517      * admin fee
085000060517     c                   if        abab = 'A'
085100060517     c                   move      abovpp        w9afovpp
085200060517     c                   move      abovra        w9afovff
085300060517     c                   move      abovpc        w9afovpc
085400060517      * bonus draw
085500060517     c                   else
085600060517     c                   move      abovpp        w9bdovpp
085700060517     c                   move      abovra        w9bdovff
085800060517     c                   move      abovpc        w9bdovpc
085900060517     c                   end
086000060517
086100060517     c                   endif
086200060517     c                   enddo
0863000605170456
086400060517     c                   endsr
086500050819
0866000101200103  ***************************************************
0867000101200104  * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0868000101200105  ***************************************************
0869000101200107  *
0870000101200107  * DATE IN  = @DATIN (8.0) YYYYMMDD
0871000101200107  * DATE OUT = @DATOU (8.0) MMDDYYYY
0872000101200107  *
0873000101200106 C     #DATYM        BEGSR
087400010120     C                   MOVE      @DATIN        @MD               4 0
087500010120     C                   MOVEL     @DATIN        @Y                4 0
087600010120     C                   MOVEL     @MD           @DATOU            8 0
087700010120     C                   MOVE      @Y            @DATOU
087800010120     C                   MOVE      *ZEROS        @DATIN            8 0
0879000101200120 C                   ENDSR
0880000101200107 C*
0881000006190456 C*
0882000006190455 C     *inzsr        begsr
088300000619
0884000006190183 C                   TIME                    HTIME             6 0
088500080205     C                   MOVEL     leffdt        leffmd            4 0
088600080205     C                   MOVE      leffdt        leffcy            4 0
088700080205     C                   MOVEL     leffcy        leffymd           8 0
088800080205     C                   MOVE      leffmd        leffymd
088900000619     C                   MOVE      *zeros        bilrte            7 2
089000000619
089100000619     c     subkey        klist
089200000619     c                   kfld                    idtrst
089300000619     c                   kfld                    idsubd
089400000619
089500140815     c*    codkey        klist
089600140815     c*                  kfld                    type
089700140815     c*                  kfld                    t2
089800001106
089900000619     c     cratky        klist
090000000619     c                   kfld                    cmtrst
090100000619     c                   kfld                    csubdv
090200000619     c                   kfld                    cmplan
090300000619     c                   kfld                    stype
090400000619
090500000619     c     invkey        klist
090600000619     c                   kfld                    cmtrst
090700000619     c                   kfld                    csubdv
090800000619     c                   kfld                    cmacct
090900000619     c                   kfld                    cmplan
091000000619
091100000619     c     keypln        klist
091200000619     c                   kfld                    cmtrst
091300000619     c                   kfld                    csubdv
091400000619     c                   kfld                    cmplan
091500010120
091600010120     c     mkcaky        klist
091700010120     c                   kfld                    cmtrst
091800010120     c                   kfld                    csubdv
091900010120     c                   kfld                    cmacct
092000170130     c                   kfld                    idcar
092100010120
092200010120     c     brcmky        klist
092300010120     c                   kfld                    idcar
092400010120     c                   kfld                    w9mksz
092500060517
092600060517     c     abkey         klist
092700060517     c                   kfld                    idtrst
092800060517     c                   kfld                    idsubd
092900060517     c                   kfld                    idacct
093000060517     c                   kfld                    idcar
093100060517     c                   kfld                    plncat
093200060517
093300000619
0934000006190455 C                   ENDSR
093500000619
0936001106150458 ORPA068WK  EADD         RPADD1
0937000006190459 O                       cmtrst               3
0938000006190459 O                       csubdv               6
0939000006190459 O                       cmacct              10
0940000006190459 O                       cmplan              14
0941000006190460 O                       idss#               23
0942001401030461 O                       idseq               25
0943000810070462 O                                           27 '  '
0944000810070462 O                       rppdfl              28
0945009102150463 O                       SLSMAN              31
0946009102150464 O                       COMRTE              36
0947009102150465 O                       COMTYP              39
0948009102150466 O                       PREM                43P
0949001701300467 O                       idcar               46
0950000010120468 O                       idgrp#              61
0951009102150469 O                       CNAME              101
0952009102150470 O                       CRPRTE             106
0953009102150471 O                       CRPTYP             109
0954001409100471 O                       idtrmd             117
0955000007060471 O                       memcnt             118
0956009102150475 O                       SLSCOM             126P
0957009102150476 O                       CRPCOM             131P
0958000304290476 O                       sxagcy             134
095900030429     O                       cmrelid            158
096000090617     O                       iddtsq             177
096100090617     O                       idcomdt            185
096200100817     O                       idpaid             193
0963000006230477 OREPORT    h    1p                     2 03
096400000623     o         or    of
0965009102150478 O                                           45 '*****'
0966009102150479 O                       CONAME              85
0967009102150480 O                                           91 '*****'
0968000006230481 O          h    1p                     2
096900000623     o         or    of
0970009102150482 O                                           66 'COMMISSION CALCULATIONS '
0971000006230483 O                                           87 '** ERROR   **  REPORT'
0972000006230481 O          h    1p                     1
097300000623     o         or    of
0974009102150485 O                                           24 'PROGRAM NAME: RPA068'
0975009102150486 O                                          125 'PAGE:'
0976009102150487 O                       PAGE          Z    131
0977000006230481 O          h    1p                     1
097800000623     o         or    of
0979009102150489 O                                           13 'RUN DATE:'
0980009102150490 O                       UDATE         Y     24
0981009102150491 O                                           67 'FOR PERIOD:'
098200080205     O                       leffdt              78 '  /  /    '
0983000006230481 O          h    1p                  1  1
098400000623     o         or    of
0985009102150494 O                                           24 '""""""""""""""""""""""""'
0986009102150495 O                                           48 '""""""""""""""""""""""""'
0987009102150496 O                                           72 '""""""""""""""""""""""""'
0988009102150497 O                                           96 '""""""""""""""""""""""""'
0989009102150498 O                                          120 '""""""""""""""""""""""""'
0990009102150499 O                                          132 '""""""""""""'
0991000006230481 O          h    1p                     1
099200000623     o         or    of
0993009102150502 O                                           24 'ACCOUNT  #'
0994009102150503 O                                           33 'PLAN'
0995000006210507 O                                          106 'ERROR CONDITION'
0996000006230481 O          h    1p                     2
099700000623     o         or    of
0998009102150509 O                                           24 '""""""""""""""""""""""""'
0999009102150510 O                                           48 '""""""""""""""""""""""""'
1000009102150511 O                                           72 '""""""""""""""""""""""""'
1001009102150512 O                                           96 '""""""""""""""""""""""""'
1002009102150513 O                                          120 '""""""""""""""""""""""""'
1003009102150514 O                                          132 '""""""""""""'
1004009102150515 O*
1005009102150516 O          E            ERROR          1
1006000006190518 O                       cmtrst              17
1007009102150519 O                                           18 '-'
1008009606140520 O                       CSUBDV              21
1009009102150521 O                                           22 '-'
1010000006190522 O                       cmacct              26
1011000006190523 O                       cmplan              33
1012000006230523 O                       SMANOUT             82
1013000006230523 O                       effmdy        y     92
1014009102150528 O                       MSG(X)             132
1015000810100516 O          E            error2         1
1016000906170518 O                       iddtsq              19
1017000810100518 O                                           +2 '<--DATE/SEQ'
1018000810100518 O                       i_idcomdt           +5 '    /  /  '
1019000810100518 O                                           +2 '<--DATE IN FILE'
1020000810100518 O                                          123 '* idcomdt not 0 *     '
1021000810100516 O          E            error3         1
1022000906170518 O                       iddtsq              19
1023000810100518 O                                           +2 '<--DATE/SEQ'
1024000810100518 O                                          123 '* DATE/SEQ NOT FOUND *'
1025009102150529 O*
1026001408150477 O*sysprt   h    1p                     2 03
102700140815     o*        or    og
1028001408150478 O*                                          45 '*****'
1029001408150479 O*                      CONAME              85
1030001408150480 O*                                          91 '*****'
1031001408150481 O*         h    1p                     2
103200140815     o*        or    og
1033001408150482 O*                                          66 'MANUAL ADJUSTMENTS IN CO'
1034001408150483 O*                                          90 'MMISSION REPORT         '
1035001408150481 O*         h    1p                     1
103600140815     o*        or    og
1037001408150485 O*                                          24 'PROGRAM NAME: RPA068'
1038001408150486 O*                                         125 'PAGE:'
1039001408150487 O*                      PAGE2         Z    131
1040001408150481 O*         h    1p                     1
104100140815     o*        or    og
1042001408150489 O*                                          13 'RUN DATE:'
1043001408150490 O*                      UDATE         Y     24
1044001408150491 O*                                          67 'FOR PERIOD:'
104500140815     O*                      leffdt              78 '  /  /    '
1046001408150481 O*         h    1p                  1  1
104700140815     o*        or    og
1048001408150494 O*                                          24 '""""""""""""""""""""""""'
1049001408150495 O*                                          48 '""""""""""""""""""""""""'
1050001408150496 O*                                          72 '""""""""""""""""""""""""'
1051001408150497 O*                                          96 '""""""""""""""""""""""""'
1052001408150498 O*                                         120 '""""""""""""""""""""""""'
1053001408150499 O*                                         132 '""""""""""""'
1054001408150481 O*         h    1p                     1
105500140815     o*        or    og
1056001408150502 O*                                          12 'ACCOUNT  #'
1057001408150503 O*                                          19 'TRANS'
1058001408150503 O*                                          31 'DESCRIPTION'
1059001408150507 O*                                          57 'PLAN'
1060001408150507 O*                                          66 'GROUP #'
1061001408150507 O*                                          86 'TRANS'
1062001408150507 O*                                          91 'SSN'
1063001408150507 O*                                         104 'DEP'
1064001408150507 O*                                         120 'COBRA'
1065001408150507 O*                                         126 'CARR'
1066001408150507 O*                                         132 'SMAN'
1067001408150481 O*         h    1p                     1
106800140815     o*        or    og
1069001408150502 O*                                          18 'CODE'
1070001408150502 O*                                          86 'AMT'
1071001408150507 O*                                         104 'SEQ'
1072001408150481 O*         h    1p                     2
107300140815     o*        or    og
1074001408150509 O*                                          24 '""""""""""""""""""""""""'
1075001408150510 O*                                          48 '""""""""""""""""""""""""'
1076001408150511 O*                                          72 '""""""""""""""""""""""""'
1077001408150512 O*                                          96 '""""""""""""""""""""""""'
1078001408150513 O*                                         120 '""""""""""""""""""""""""'
1079001408150514 O*                                         132 '""""""""""""'
1080001408150515 O*
1081001408150516 O*         E            manadj         1
1082001408150518 O*                      idtrst               3
1083001408150519 O*                                           4 '-'
1084001408150520 O*                      idsubd               7
1085001408150521 O*                                           8 '-'
1086001408150522 O*                      idacct              12
1087001408150522 O*                      idtrcd              17
1088001408150522 O*                      desout              50
1089001408150523 O*                      idplan              57
1090001408150523 O*                      idgrp#              75
1091001408150523 O*                      idtram        l     86
1092001408150528 O*                      idss#               99 '   -  -    '
1093001408150528 O*                      idseq         z    104
1094001408150463 O*                      idcob              120
1095001408150463 O*                      idcar              126
1096001408150463 O*                      SLSMAN             132
1097000007180529 O*
109800960614**
109900000621 NO COMMISION RATES
110000000621 INVALID PLAN IN COMMISSION CONTROL
110100000621 INVALID CARRIER IN COMMISSION CONTROL
110200000623 INVALID SMAN IN COMMISSION CONTROL
110300000621 INVALID TRUST IN COMMISSION CONTROL
110400030429 INVALID RELID IN COMMISSION CONTROL
110500030429 INVALID ASID ON RELATIOSHIP RECORD
