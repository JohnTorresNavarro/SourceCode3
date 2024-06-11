0001000306110015  *******************************************************************
000200200505      * rpa421         Group Benefit Services, Inc.                     *
000300030611      *                                                                 *
000400030611      *    WRITTEN BY - DAVID KETTERMAN                                 *
000500200505      *    DATE       - 05/05/20                                        *
000600030611      *                                                                 *
000700200505      * This program will produce a workfile for the CF PAYDFR          *
000701200505      * remittance similar to the unpaid remittance. It was cloned      *
0008002005180015  * from RPA401. It should only be needed a couple of months        *
0008012005180015  * (probably not after 7/1/20) since it only shows the initial     *
0008022005180015  * invoice deferral transactions for 3/20, 4/20 and 5/20.          *
0008032005180015  *                                                                 *
0008042005110015  * 05/11/20 dlk - add commission workfiles rpa069wk & rpa068wk     *
0008052005110015  *                so the salesman commissions can be reproduced    *
0008062005110015  *                also.                                            *
0008072005110015  *                                                                 *
0008082005180015  *  ************************************************************   *
0008092005190015  *  * * NOTE - logic in this program was taken from DW040,     *   *
0008102005190015  *  *          RPA060N and RPA068. Any changes there should be *   *
0008112005190015  *  *          made here also.                                 *   *
0008122005180015  *  *                                                          *   *
0008132005180015  *  ************************************************************   *
0008142005180015  *                                                                 *
0013000306110015  *******************************************************************
0014000908140017 FINVDET    IP   E             DISK
0015002005050019 Fpaydfrcpl2IF   E           K DISK
0015012005050019 FACCMST    IF   E           K DISK
0016009606250019 FCARMST    IF   E           K DISK
0017000304090019 FCMCT14    IF   e           k DISK
0018000102120014 Fmktcara1  IF   e           k DISK
0019000905140014 Fplnmst    if   e           k DISK
0020000908190039 FCRAT13    IF   e           k DISK
0021000908190014 Fbrkrcom1  IF   e           k DISK
002200090819     fsmanrlt   if   e           k disk
002300090819     FADMNFEE1  IF   E           K DISK
002400090819     faboverl1  if   e           k disk
002500090819     FBONUSDR1  IF   E           K DISK
0026000908190047 FSUBMST    IF   e           k DISK
0027000908190014 FSMAN      IF   e           k DISK
002701200511     fspragxr2  if   e           k disk
0028000908140030 Fbcrec     O  A E             DISK
002801200511     FRPA069WK  O  A E             DISK
002802200511     FRPA068WK  O  A F  193        DISK
0029000908200030 Fqsysprt   O    F  132        PRINTER OFLIND(*INOf)
003000030926
0034000908190056 D  wkcomtot       s                   like(bccchg)
0035000908190056 D  wkbdtot        s                   like(bcdchg)
0036000908190056 D  wkbdchg        s                   like(bcdchg)
0036011612150133 D  wkbdmth        s                   like(bcdmth)
0037000908190056 D  wkaftot        s                   like(bcfchg)
0038000908200056 D* w9glob         s                   like(bccchg)
0039000908190056 D  wkfee          s                   like(bcfchg)
0039011612150133 D  wkfeemth       s                   like(bcfmth)
0040002005110056 D  globalcomamt   s                   like(w9cmam)
0041000908190133 Dworkafff         s                   like(affee)
0042000908190133 Dworkafpp         s                   like(affeepp)
0043000908190133 Dworkafpc         s                   like(affeepc)
0044000908190133 Dworkbdff         s                   like(bdovra)
0045000908190133 Dworkbdpp         s                   like(bdovpp)
0046000908190133 Dworkbdpc         s                   like(bdovpc)
0047002005110133 Dwkprem           s                   like(w9prem)
0048000908200133 D w9afovff        s                   like(abovra)
0049000908200133 D w9afovpc        s                   like(abovpc)
0050000908200133 D w9afovpp        s                   like(abovpp)
0051000908200133 D w9bdovff        s                   like(abovra)
0052000908200133 D w9bdovpc        s                   like(abovpc)
0053000908200133 D w9bdovpp        s                   like(abovpp)
0054000908190133 D wksplitpct      s              7  6
0055000908190133 D wkpct           s              7  6
005600090825     Dbonp             S              5P 2
005700090825     Dafp              S              5P 2
005800090825     Dcomp             S              5P 2
005801161215     d  wkcnt          s                   like(bcmcnt)
0058022005110133 D rppdfl          s              1
005803200511     d pdescrwk        s                   like(pdescr)
005900090825    ***
0060000908190132 D                 DS
0061000908190133 D  DTETMP                 1      8  0
0062000908190134 D  CENRMM                 5      6  0
0063000908190135 D  CENRDD                 7      8  0
0064000908190136 D  CENRYY                 3      4  0
0065009606050055 D                 DS
0066009606050056 D  TSA                    1     10
0067009606050056 D  IDTRST                 1      3  0
0068009606030056 D  IDSUBD                 4      6  0
0069009606030056 D  IDACCT                 7     10  0
0070000908280055 D*                DS
0071000908280056 D* covtdt                 1      8  0
0072000908280056 D* covcym                 1      6  0
0073000908280056 D* covd                   7      8  0
0074009910230055 D                 DS
0075001409110056 D  idtrmd                 1      8  0
0077001409110056 D  idtrmdday              7      8  0
0078000104170055 D                 DS
0079000104170056 D  IDRC                   1      3
0080000104170056 D  IDRC2                  2      3
0081000101310055 D                 DS
0082000101310056 D  bcefdt                 1      8  0
0083000101310056 D   bcefyy                1      4  0
0084000101310056 D   bcefmm                5      6  0
0085000101310056 D   bcefdd                7      8  0
0086000908280055 D*                DS
0087000908280056 D* idgrp#                 1     15
0088000908280056 D*  groupid               1      8
0089000908280056 D*  subgroupid            9     12
009000081215
009100081215      * primary broker field from CMCT14
009200081215     D                 DS
009300081215     D  free5                  1      5
009400081215     D  cmprib                 1      1
009500081215
0096009606030055 D                UDS
0097000908260056 D  LEFFDT                 1      8  0
009800090825
009801200505     iinvdr
009802200505     i                                          idtrst        l1
009803200505     i                                          IDSUBD        l1
009804200505     i                                          IDACCT        l1
009805200505     i                                          IDINV#        l1
009806200505     i                                          IDgrp#        l1
009900090825     ICARMSR
010000090825     I              CBONP                       CBONPX
010100090825     I              CAFP                        CAFPX
010200090825     I              CCOMP                       CCOMPX
010201200505
010202200505     C* if this is not a CF deferred invoice then skip it
010203200505     c                   if        *inl1
010204200505     c                   clear                   dfrinv            1
010205200505     C     dfrl2key      CHAIN     paydfrcpl2
010206200505     C                   if        %found(paydfrcpl2)
010207200505     c                   eval      dfrinv = 'Y'
010208200505     c                   end
010209200505     c                   end
010210200505
010211200505     c                   if        dfrinv <> 'Y'
010212200505     c                   goto      #end
010213200505     c                   end
010214200505
010300000807     C*
010400140911     C* idtrmd (effective date) as day 01
010500000807     C*
010600140911     c                   move      idtrmd        idtrmd01          8 0
010700140911     c                   move      01            idtrmd01
010800030806
010900090814     C* get acct rec
011000030806     C     ACKEY         CHAIN     ACCMST
011100030806     C                   if        not %found(accmst)
011101200507     c                   if        firste <> 'Y'
011102200507     c                   except    head2
011103200507     c                   move      'Y'           firste            1
011104200507     c                   end
011200090820     C   of              EXCEPT    HEAD2
011300970625     C                   EXCEPT    ERROR2
011400090819     C                   GOTO      #end
011500970625     C                   END
011600030806
011700090901     C     IDCAR         CHAIN     CARMST
011800090901     C                   if        not %found(carmst)
011801200507     c                   if        firste <> 'Y'
011802200507     c                   except    head2
011803200507     c                   move      'Y'           firste            1
011804200507     c                   end
011900090901     C   of              EXCEPT    HEAD2
012000090901     C                   EXCEPT    ERROR3
012100090901     C                   GOTO      #end
012200090901     C                   END
012300090901
012400081215      *
012500081216      * read all comctx that are active for this plan / date and find the
012600081216      * 1st active relation
012700081216     C                   clear                   SLSOUT            3
012800081216     C                   clear                   relout            8
0129000812160197  *
013000081216  93 C     cmkey         setll     cmct14
013100081216     c                   dou       %eof(cmct14)
0132000812160195 C     cmkey         reade     cmct14
013300140911     c                   if        (not %eof(cmct14)) and (idtrmd >= effdat)
013400140911     c                             and (cmcan = 0 or cmcan >= idtrmd)
013500081216     c                             and (cmcan <> effdat)
013600081216      * hold 1st active
013700081216     c                   if        relout  = *blanks
013800081216     C                   MOVE      SLSMAN        SLSOUT
013900081216     C                   MOVE      cmrelid       relout
014000081216     c                   end
014100081216      * if this rec is the primary broker, use it
014200081216     c                   if        cmprib = 'Y'
014300081216     C                   MOVE      SLSMAN        SLSOUT
014400081216     C                   MOVE      cmrelid       relout
014500081216     c                   leave
0146000812160201 C                   end
014700081216
014800081216     c                   end
014900081216     c                   enddo
015000010131     C*
015100090819     C* fill BCREC fields
015200090901     c                   clear                   bcrecr
015300090901
015400010204     c                   movel     idgrp#        bcgn
015500010131     C                   z-add     idtrst        bctrst
015600010131     C                   z-add     idsubd        bcsub
015700010131     C                   z-add     idacct        bcacct
015800010131     C                   movel     idcar         bccar
015900010131     C                   movel     idplan        bcplan
016000010131     C                   movel     acnam1        bcanam
016100010131     C                   movel     cgrpcd        bcgrpc
016200090817     C                   z-add     idtram        bcpada
016300140911     C                   z-add     idtrmd01      bcefdt
016400030409     C                   movel     relout        bcrelid
016500060302     C                   z-add     idbamt        bclifev
016501200505
016502200505      * Put invoice # in left side of misc 3 field
016503200505     C                   movel     idinv#        bcmisc3
016600010203
016700090914      *******************************
016800200505      * calc commission
017000090914
017100090818     c* get member count and market size
017200010203     c                   exsr      #mcnt
017201161215     c                   exsr      #mksz
017300010131
017400090819     c* accumulate all commission amounts for this invdet rec
017500090814     c                   exsr      #getcom
017600090814
017700090901      * calc admin fee and bonus draw
017800090901
017900090901     c                   clear                   wkaftot
018000090901     c                   clear                   wkbdtot
018100090901     c                   if        comsch = '2'
018200090901     c                   exsr      #newafbd
018300090901     c                   else
018400090901     c                   exsr      #oldafbd
018500090901     c                   end
018600090901
018700090901     c* move totals to bcrec fields
018800090819     c                   z-add     wkcomtot      bccchg
018900090901     c                   z-add     wkaftot       bcfchg
019000090819     c                   z-add     wkbdtot       bcdchg
019100090914
019300090914      *******************************
019400090819
019500090901      * write 1 bcrec record with all amounts calculated
019600090819     C                   WRITE     bcrecr
019700090819     c                   clear                   bcrecr
019800090819
019900010131     c                   clear                   slsout
020000030409     c                   clear                   relout
020100960625     C*
020200960513     C     #END          TAG
020300010203
0204000102030069 C**************************************************************
0205000908140069 C* get commission info
0206000102030069 C**************************************************************
020700090814     c     #getcom       begsr
020800090814
020900090814      * find all commision control records that apply to this plan
021000090819      * and accumulate amounts
021100090814
021200090819     c                   clear                   wkcomtot
021300090819
021400090814  93 C     cmkey         setll     cmct14
021500090814     c                   dou       %eof(cmct14)
0216000908140195 C     cmkey         reade     cmct14
021700140911     c                   if        (not %eof(cmct14)) and (idtrmd >= effdat)
021800140911     c                             and (cmcan = 0 or cmcan >= idtrmd)
021900090814     c                             and (cmcan <> effdat)
021901200511     c                   exsr      #getrel
0220000908180272  * calc commission based on old or new schedule
022100090818     c                   if        ccpnc <> 'N'
022200090818     c                   if        comsch = '2'
022300090818     c                   exsr      #newcom
022400090818     c                   else
022500090818     c                   exsr      #oldcom
022600090818     c                   end
022700090818     c                   end
022800090818
022900090817     c                   end
023000090814     c                   enddo
023100090814
023200090814     c                   endsr
023300090814
0234000908170103  ************************************************************
0235002005110104  * get relation info
0236000908170105  ************************************************************
0237000908170107  *
0238002005110106 C     #getrel       BEGSR
023801200511
023807200511     c     cmrelid       chain     smanrlt
023808200511     c                   if        not  %found(smanrlt)
023809200511     c                   leavesr
023815200511     c                   end
023816200511
0238172005110266 C     srsman        CHAIN     SMAN
023818200511     c                   if        not  %found(sman)
023819200511     c                   leavesr
023820200511     c                   end
023822200511
023823200511     c     srasid        chain     spragxr2
023824200511     c                   if        not  %found(spragxr2)
023825200511     c                   leavesr
023826200511     c                   end
0238272005110188 C*
023828200511     c                   endsr
023829200511
0238302005110103  ************************************************************
0238312005110104  * #NEWCOM SR - BUILD RPA069WK USING NEW COMMISSION METHOD   *
0238322005110105  ************************************************************
0238332005110107  *
0238342005110106 C     #NEWCOM       BEGSR
023835200511
023836200511     c                   clear                   pdescrwk
0238372005110266 C     plnkey        CHAIN     PLNMST
023838200511     c                   if        %found(plnmst)
023839200511     c                   movel     pdescr        pdescrwk
023840200511     c                   end
023841200511
023842200511
023843200511     c                   clear                   rpa069r
023844200511     C                   z-add     idtrst        w9trst
023845200511     C                   z-add     idsubd        w9subd
023846200511     C                   z-add     idacct        w9acct
023847200511     C                   movel     idplan        w9plan
023848200511     C                   movel     idgrp#        w9grp#
023849200511     C                   z-add     idss#         w9ss#
023850200511     C                   z-add     idseq         w9seq
023851200511     C                   z-add     idtrmd        w9efdt
023852200511     C                   z-add     idtram        w9prem
023853200511     C                   z-add     idedt         w9edt
023854200511     C                   movel     cmrelid       w9relid
023855200511     C                   movel     pdescrwk      w9pdescr
023856200511     C                   movel     slname        w9smlast
023857200511     C                   movel     sfname        w9smfirst
023858200511     C                   movel     smi           w9smmi
023859200511     C                   move      idcomdt       w9comdt
023860200511     C                   move      ccpnc         w9ccpnc
023861200511     C                   move      idpaid        w9idpaid
023862200511     C                   movel     idcar         w9carr
023863200511     C                   movel     cname         w9cnam
023864200511     C                   movel     slsman        w9sman
023865200511     c                   movel     sxagcy        w9cocd
023866200511     C                   movel     iddtsq        w9dtsq
023867200511     C                   z-add     cccmsp        w9pspl
0238682005110408
023869200511     C                   z-add     bcmcnt        w9mcnt
023870200511
0238712005110456  * Get Acct Mkt size - default to 50 if not found
023872200511     c                   clear                   w9mksz
023873200511     c                   eval      *in21 = *off
023874200511     c     mkcaky        setll     mktcara1
023875200511     C                   dow       *in21 = *off
023876200511     c     mkcaky        reade     mktcara1                               21
0238772005110133 C   21              leave
023878200511     c                   if        mafrdt <> matodt
023879200511     c                   if        (mafrdt <= idtrmd and matodt >= idtrmd) or
023880200511     c                             (mafrdt <= idtrmd and matodt = 0 )
023881200511     c                   movel     maszcd        w9mksz
023882200511     c                   leave
023883200511     c                   endif
023884200511     c                   endif
023885200511     c                   enddo
0238862005110456  *
023887200511     c                   if        w9mksz = *blanks
023888200511     c                   movel     '50'          w9mksz
023889200511     c                   endif
023890200511
023900090817
0241000908170429  *
0242002005110429  * COBRA invoices:  *Note - this is code from rpa068, there should NOT
0242012005050429  *                   be any cobra transactions on a cf pay dfr acct
0242022005110429  *                   invoice so it should not be needed.
0242032005110429  *
0242042005110429  * COBRA invoices: The billed amount (IDTRAMB) holds the rate plus
0242052005110429  * the 2% surcharge. The net (IDTRAM) holds the original rate without
0242062005110429  * the 2% added.
0242072005110429  * COBRA adjustments: billed should hold the rate + 2% and net will
0242082005110429  * hold either the same amount or rate less 2% and PSF.
0242092005110429  *
0242102005110429  * 12/3/18 If the billed = net then still get the billed less 2%,
0242112005110429  * otherwise still use the net rate (these should be PSF plans) which
0242122005110429  * is already in w9prem.
024213200511     C                   if        idcob = 'C' and w9prem <> 0
0242152005110429  * cobra manual adj (CMA)
024216200511     c                   if        idrc  = 'CMA'
024217200511     c                   if        idtramb = idtram
024218200511     c     idtramb       div(h)    1.02          w9prem
024219200511     c                   end
0242202005110429  * cobra invoices
024221200511     c                   else
024222200511     c                   move      idtram        w9prem
024223200511     c                   end
024225200511     c                   end
0242262005110361
025800090817
0259000908170456  *******************
0260000908170456  * Calculate commission
0261000908170456  *******************
0262000908170456
0263000908170456  * if pay no comm field was set to "P" then skip all comm calcs
0264000908170456  * this allows prem and member count to pass through but no comm
0265000908170456  * will be paid
026600090817     c                   if        ccpnc = 'P'
026601200511     c                   clear                   w9cmam
026602200511     c                   clear                   w9mthd
026603200511     c                   clear                   w9glob
026700200511     c                   goto      #writ69
026800090817     c                   endif
026900090817
027000090817      *******************
0271000908170456  * global Commission = mbr count x flat fee
0272000908170456  * 8/15/05 add % of prem calc
027300090817      *******************
027400090817
027500090817     c                   clear                   globalcomamt
027600090817     c                   clear                   rbrkrcom
027700090817     c                   clear                   foundbrkrc        1
027800090817
027900090817     c* 01/02/09 - use effdt of trans to find broker com
028000090817     c     brcmky        setll     brkrcom1
028100090817     c                   dou       %eof(brkrcom1)
028200090817     c     brcmky        reade     brkrcom1
028300090817     C                   if        (not %eof(brkrcom1)) and
028400090817     C                             (bcfromdt <> bctodate) and
028500140911     c                             ((bcfromdt <= idtrmd and bctodate >= idtrmd)
028600140911     c                               or (bcfromdt <= idtrmd and bctodate = 0))
028700090817     c                   eval      foundbrkrc = 'Y'
028800090817     c                   leave
028900090817     c                   end
029000090817     c                   enddo
029100090817
029200090817     c                   if        foundbrkrc = 'Y'
029300090817
029400090817      * global fee per member - default method
029500200511     c                   clear                   w9cmrt
029600200511     c                   z-add     bcamnt        w9glob
029700200511     c     bcmcnt        mult      bcamnt        w9cmam
029800200511     c                   z-add     w9cmam        globalcomamt
029900200511     c                   movel     'G'           w9mthd
030000090817
030100090817      * global % of prem
030200090817     c                   if        bcpop <> 0
030300200511     c                   z-add     bcpop         w9cmrt
030400200511     c                   clear                   w9cmam
030500090817     c                   clear                   wkpct
030600090817     c     bcpop         div       100           wkpct
030700200511     c     wkpct         mult      w9prem        w9cmam
030800200511     c                   z-add     w9cmam        globalcomamt
030900090817      * w9glob will hold the orig calculated % of prem amt
031000200511     c                   z-add     w9cmam        w9glob
031100200511     c                   movel     'O'           w9mthd
031200090817     c                   end
031300090817
031400090817     c                   endif
0315000908170456
031600090817      ********
0317000908170456  * process overrides to global commission
031800090817      ********
0319000908170456
0320000908170456  * flat fee per member override
0321000908170456
032200090817     c                   if        ccovra <> *zero
032300200511     c                   movel     'F'           w9mthd
032400200511     c                   clear                   w9cmam
032500200511     c                   clear                   w9cmrt
032600200511     c     bcmcnt        mult      ccovra        w9cmam
032700090820     c*                  z-add     ccovra        w9glob
032800090817
032900090817     c                   else
0330000908170456
0331000908170456  * % of commission override
033200090817
033300090817     c                   if        ccovpc <> *zero
033400200511     c                   movel     'C'           w9mthd
033500200511     c                   z-add     ccovpc        w9cmov
033600200511     c                   clear                   w9cmam
033700090817     c     ccovpc        div       100           wkpct
033800200511     c     wkpct         mult      globalcomamt  w9cmam
033900090817
034000090817     c                   else
034100090817
0342000908170456  * % of premium override
034300090817
034400090817     c                   if        ccovpp <> *zero
034500200511     c                   movel     'P'           w9mthd
034600200511     c                   z-add     ccovpp        w9cmrt
034700200511     c                   clear                   w9cmam
034800090817     c     ccovpp        div       100           wkpct
034900090817
0350000908170456  * if premium split is entered (split commisison) the premium must
0351000908170456  * first be reduced by the split % before the % of prem can be calc
035200200511     c                   if        w9pspl <> 0
035300200511     c     w9pspl        div       100           wksplitpct
035400200511     c     wksplitpct    mult      w9prem        wkprem
035500090817     c                   else
035600200511     c                   z-add     w9prem        wkprem
035700090817     c                   end
035800090817
035900200511     c     wkpct         mult      wkprem        w9cmam
036000090817     c                   end
036100090817
036200090817     c                   endif
036300090817     c                   endif
036400090817
036401200511     c     #writ69       tag
036402200511
0365000908170456  * Ensure commission amt is same sign as premium
036600090817
036700200511     c                   if        w9prem   < 0 and w9cmam > 0
036800200511     c     w9cmam        mult      -1            w9cmam
036900090817     c                   endif
0370000908170456
037100090819      * accumulate commission amounts
037200200511     c                   add       w9cmam        wkcomtot
037300200511     c                   move      w9mthd        bccmth
037301200511
037302200511      * every record slected has already been paid
037303200511     c                   move      'Y'           w9pdfl
037304200511     c                   write     rpa069r
0374000908190456
0375000908170120 C                   ENDSR
037600090817
037700090817      ******************************************
037800090901      * logic from rpa060n2 to admin fee and bonus draw for new commission
037900090901      * carriers
038000090817      ******************************************
038100090901     c     #newafbd      begsr
038200090819
038300090819      * logic from ra068 to get admin fee and bonus draw override
038400090819
038500090819     c                   clear                   w9afovpp
038600090819     c                   clear                   w9afovff
038700090819     c                   clear                   w9afovpc
038800090819     c                   clear                   w9bdovpp
038900090819     c                   clear                   w9bdovff
039000090819     c                   clear                   w9bdovpc
039100090819
039200090819      * 1/2/09 change to use trans effdt for the search instead of remit dt
039300090819     c     abkey         setll     aboverl1
039400090819     C                   dou       %eof(aboverl1)
039500090819     c     abkey         reade     aboverl1
039600090819     C                   if        (not %eof(aboverl1)) and
039700090819     C                             (abfrdt <> abtodt) and
039800140911     c                             ((abfrdt <= idtrmd and abtodt >= idtrmd) or
039900140911     c                              (abfrdt <= idtrmd and abtodt = 0))
040000090819      * admin fee
040100090819     c                   if        abab = 'A'
040200090819     c                   move      abovpp        w9afovpp
040300090819     c                   move      abovra        w9afovff
040400090819     c                   move      abovpc        w9afovpc
040500090819      * bonus draw
040600090819     c                   else
040700090819     c                   move      abovpp        w9bdovpp
040800090819     c                   move      abovra        w9bdovff
040900090819     c                   move      abovpc        w9bdovpc
041000090819     c                   end
041100090819
041200090819     c                   endif
041300090819     c                   enddo
0414000908190456
041500090819
041600090819      * *** Logic from rpa060N2 starts here ****
041700090817
041800090817      * fill comm pct (for methods using a %)
041900200511     c                   z-add     w9cmrt        bccpct
042000090817
042100090817      ****
042200090817      * Calc Admin Fee
042300090817      ****
042400090817     c                   clear                   workafff
042500090817     c                   clear                   workafpp
042600090817     c                   clear                   workafpc
042700090817      * override
042800090817     c                   if        w9afovff <> 0 or w9afovpp <> 0 or
042900090817     c                             w9afovpc <> 0
043000090817     c                   z-add     w9afovff      workafff
043100090817     c                   z-add     w9afovpp      workafpp
043200090817     c                   z-add     w9afovpc      workafpc
043300090817
043400090817      * 999.99 = override to 0
043500090817     c                   if        workafff = 999.99
043600090817     c                   eval      workafff = *zeros
043700090817     c                   end
043800090817     c                   if        workafpp = 999.9999
043900090817     c                   eval      workafpp = *zeros
044000090817     c                   end
044100090817     c                   if        workafpc = 999.9999
044200090817     c                   eval      workafpc = *zeros
044300090817     c                   end
044400090817
044500090817
044600090817     c                   exsr      #calcaf
044700090817
044800090817     c                   else
044900090817
045000090817     c* 01/02/09 - use effdt of trans to find admin fee
045100090817     c                   clear                   foundadmf         1
045200090817     c     afkey         setll     admnfee1
045300090817     c                   dou       %eof(admnfee1)
045400090817     c     afkey         reade     admnfee1
045500090817     C                   if        (not %eof(admnfee1)) and
045600090817     C                             (affromdt <> aftodate) and
045700140911     c                             ((affromdt <= idtrmd and aftodate >= idtrmd)
045800140911     c                               or (affromdt <= idtrmd and aftodate = 0))
045900090817     c                   eval      foundadmf = 'Y'
046000090817     c                   leave
046100090817     c                   end
046200090817     c                   enddo
046300090817
046400090817     c                   if        foundadmf  = 'Y'
046500090817     c                   z-add     affee         workafff
046600090817     c                   z-add     affeepp       workafpp
046700090817     c                   z-add     affeepc       workafpc
046800090817     c                   exsr      #calcaf
046900090817     c                   else
047000090817      * error - missing admin fee
047100090817     c                   if        firste <> 'Y'
047200090819     c                   except    head2
047300090817     c                   move      'Y'           firste            1
047400090817     c                   end
047500090819     c   of              except    head2
047600090817     c                   except    error1
047700090817     c                   end
047800090817
047900090817     c                   end
048000090817
048100090817      ****
048200090817      * Calc Bonus Draw Charge on remittance
048300090817      ****
048400090817     c                   clear                   workbdff
048500090817     c                   clear                   workbdpp
048600090817     c                   clear                   workbdpc
048700090817      * override
048800090817     c                   if        w9bdovpp <> 0 or w9bdovpc <> 0
048900090817     c                             or w9bdovff <> 0
049000090817     c                   z-add     w9bdovff      workbdff
049100090817     c                   z-add     w9bdovpp      workbdpp
049200090817     c                   z-add     w9bdovpc      workbdpc
049300090817
049400090817      * 999.99 = override to 0
049500090817      * flat fee
049600090817     c                   if        workbdff = 999.99
049700090817     c                   eval      workbdff = *zeros
049800090817     c                   end
049900090817     c                   if        workbdpp = 999.9999
050000090817     c                   eval      workbdpp = *zeros
050100090817     c                   end
050200090817     c                   if        workbdpc = 999.9999
050300090817     c                   eval      workbdpc = *zeros
050400090817     c                   end
050500090817
050600090817     c                   exsr      #calcbd
050700090817     c                   else
050800090817
050900090817      * get bonus draw
051000090817     c* 01/02/09 - use effdt of trans to find admin fee
051100090817     c                   clear                   foundbd           1
051200090817     c     afkey         setll     bonusdr1
051300090817     C                   dou       %eof(bonusdr1)
051400090817     c     afkey         reade     bonusdr1
051500090817     C                   if        (not %eof(bonusdr1)) and
051600140911     c                             ((bdfrdt <= idtrmd and bdtodt >= idtrmd) or
051700140911     c                             (bdfrdt <= idtrmd and bdtodt = 0))
051800090817     c                   eval      foundbd = 'Y'
051900090817     c                   leave
052000090817     c                   endif
052100090817     c                   enddo
052200090817
052300090817      *********
052400090817      * error - missing bonus draw
052500090817     c                   if        foundbd <> 'Y'
052600090817     c                   if        firste <> 'Y'
052700090819     c                   except    head2
052800090817     c                   move      'Y'           firste            1
052900090817     c                   end
053000090819     c   of              except    head2
053100090819     c                   except    error5
053200090817     c                   goto      #skpremcalc
053300090817     c                   end
053400090817
053500090817     c                   z-add     bdovra        workbdff
053600090817     c                   z-add     bdovpp        workbdpp
053700090817     c                   z-add     bdovpc        workbdpc
053800090817     c                   exsr      #calcbd
053900090817
054000090817     c                   end
054100090817
054200090817
054300090817     c     #skpremcalc   tag
054400090817
054500090817     c                   endsr
054600090817
054700090817      **********************************************
054800090817      * Calc Admin Fee
054900090817      **********************************************
055000090817     c     #calcaf       begsr
055100090817
055200090817     c                   clear                   wkpct
055300090817     c                   clear                   wkfee
055301161215     c                   clear                   wkfeemth
055400090817
055500090817     c                   select
055600090817      * flat fee per member
055700161215     c                   when      workafff <> 0 and bcmcnt <> 0
055800090817     c                   z-add     workafff      wkfee
055801161215     c                   eval      wkfeemth = '$'
055900090817     c                   clear                   bcfpct
056000090817      * % of prem
056100090817     c                   when      workafpp <> 0
056101161215     c                   eval      wkfeemth = '%'
056200090817     c     workafpp      div       100           wkpct
056300200511     c     wkpct         mult(h)   w9prem        wkfee
056400090817     c                   z-add     workafpp      bcfpct
056500090817      * % of com
056600090817     c                   when      workafpc <> 0
056601161215     c                   eval      wkfeemth = '%'
056700090817     c     workafpc      div       100           wkpct
056800090901     c     wkpct         mult(h)   wkcomtot      wkfee
056900090817     c                   z-add     workafpc      bcfpct
057000090817     c                   endsl
057100090817
057200161215      * set sign of fee to match mem cnt (bcmcnt will be +1,-1)
057300161215     c                   if        (bcmcnt < 0 and wkfee > 0) or
057400161215     c                             (bcmcnt > 0 and wkfee < 0)
057500090817     c                   mult      -1            wkfee
057600090817     c                   end
057700090817
057800090901     c                   z-add     wkfee         wkaftot
057801161215     c                   movel     wkfeemth      bcfmth
057900090817
058000090817     c                   endsr
058100090817
058200090817      **********************************************
058300090817      * Calc bonus draw
058400090817      **********************************************
058500090817     c     #calcbd       begsr
058600090817
058700090817     c                   clear                   wkbdchg
058800090817     c                   clear                   wkpct
058801161215     c                   clear                   wkbdmth
058900090817
059000090817      * flat fee
059100161215     c                   if        workbdff <> 0 and bcmcnt <> 0
059101161215     c                   eval      wkbdmth = '$'
059200090817     c                   z-add     workbdff      wkbdchg
059300090817     c                   z-add     0             bcdpct
059400090817     c                   else
059500090817      * % of prem
059600090817     c                   if        workbdpp <> 0
059601161215     c                   eval      wkbdmth = '%'
059700090817     c     workbdpp      div       100           wkpct
059800200511     c     wkpct         mult      w9prem        wkbdchg
059900090817     c                   z-add     workbdpp      bcdpct
060000090817     c                   else
060100090817
060200090817      * % of com = bonus draw % x admin fee
060300090817     c                   if        workbdpc <> 0
060301161215     c                   eval      wkbdmth = '%'
060400090817     c     workbdpc      div       100           wkpct
060500090817     c     wkpct         mult(H)   bcfchg        wkbdchg
060600090817     c                   z-add     workbdpc      bcdpct
060700090817     c                   endif
060800090817
060900090817     c                   endif
061000090817     c                   endif
061100090817
061200161215      * set sign of fee to match mem cnt (bcmcnt will be +1,-1)
061300161215     c                   if        (bcmcnt < 0 and wkbdchg > 0) or
061400161215     c                             (bcmcnt > 0 and wkbdchg < 0)
061500090817     c                   mult      -1            wkbdchg
061600090817     c                   end
061700090817
061800090819     c                   add       wkbdchg       wkbdtot
061801161215     c                   movel     wkbdmth       bcdmth
061900090817
062000090817     c                   endsr
062100090817
062200090817      *****************************************************
062300090817      * old commission schedule
062400090817      *****************************************************
062500090817     c     #oldcom       begsr
062600090817
0627000908180237 C* old comm method
062800090818     C                   move      'P'           bccmth
062801200511     c                   move      'Y'           rppdfl
062900090827
063000090827      * GET SALESMAN MASTER FILE FOR STYPE IN CRATE SEARCH
0631000908270266 C     SLSMAN        CHAIN     SMAN
063200090827     c                   if        not %found(sman)
063300090827     c                   clear                   stype
063400090827     c                   end
063500090818
0636000908170237 C* get crate
0637000908170239 C*
0638000908170246 C                   SETOFF                                       51
063900090817     c                   move      ' '           crrec             1
0640000908170245 C     CRATKY        SETLL     CRAT13
0641000908170247 C                   dow       *in51 = *off
0642000908170248 C     CRATKY        READE     CRAT13                                 51
064300090817     C*
064400090818     C                   if        *in51 = *off and crdltd <> 'D' and effdat
064500090818     C                             >= frdate and effdat <= todate
0646000908170252 C                   move      'Y'           crrec
0647000908170252 C                   leave
0648000908170253 C                   END
064900090817     c                   enddo
065000090817
0651000908170256 C*
0652000908190256 C* if no crate print error and leave this subroutine
0653000908170256 C*
0654000908170257 C                   if        crrec = ' '
0655000908170261 C                   Z-ADD     1             X                 2 0
065600090817     C                   MOVE      effdat        @DATIN
065700090819     C                   EXSR      #DATYM
065800090817     C                   MOVE      @DATOU        effmdy            8 0
065801200507     c                   if        firste <> 'Y'
065802200507     c                   except    head2
065803200507     c                   move      'Y'           firste
065804200507     c                   end
065805200507     C   of              EXCEPT    HEAD2
0659000908190267 C                   EXCEPT    ERROR4
066000090817     c                   move      0             effmdy
0661000908170268 C                   leavesr
066200090817     c                   end
066300090817
0664000908170273 C                   Z-ADD     effdat        DTETMP
0665000908170274  *
0666000908170275  *  CHECK DONE TO SEE IF WHEN THE PROCEDURE IS RUN THE COMMISSION
0667000908170276  *  PERIOD IS EXPIRED.
0668000908170277  *  IF THE COMMISSION PERIOD IN MONTHS IS GREATER THEN 0 ADD IT TO
0669000908170278  *  THE ENROLLMENT MONTH.  KEEP SUBTRACTING 12 AND ADDING ONE TO THE
0670000908170279  *  YEAR UNTIL THE MONTH IS LE 12 (TO MAKE A NORMAL DATE).
0671001409110280  *  THEN COMPARE THE NEW ENROLLMENT DATE AND idtrmd . IF ENROLLMENT DATE
0672001409110281  *  IS LATER THEN idtrmd  THE COMMISSION HAS EXPIRED.  ADD THE COMMISSION
0673000908170282  *  PERCENT TO GBS'S COMMISSION PERCENT AND ZERO OUT THE SALESMAN'S
0674000908170283  *  COMMISSION PERCENT TO BE UPDATED IN THE WORK FILE.
0675000908170284  *
0676000908170285 C     COMPRD        IFGT      0
0677000908170286 C                   ADD       COMPRD        CENRMM
0678000908170287 C     CENRMM        DOWGT     12
0679000908170288 C     CENRMM        SUB       12            CENRMM
0680000908170289 C                   ADD       1             CENRYY
0681000908170290 C                   END
0682000908170291 C                   Z-ADD     DTETMP        CYYMMD            8 0
0683001409110293 C     CYYMMD        IFLE      idtrmd
0684000908170294 C     COMTYP        IFEQ      'HPP'
0685000908170295 C                   ADD       COMRTE        CRPRTE
0686000908170296 C                   END
0687000908170297 C                   Z-ADD     0             COMRTE
0688000908170298 C                   END
0689000908170299 C                   END
0690000908170417  *
0691000908170429  * billed amount comes from field "IDTRAMB" in invdwk file,
0692000908170429  * "IDTRAM" is net
0693000908170417  *
069400090817     c                   move      idtramb       prem              7 2
069500090817     c                   move      idtram        netrte            7 2
0696000908170429  *
0697012005110429  * COBRA invoices: The billed amount (IDTRAMB) holds the rate plus
0697022005110429  * the 2% surcharge. The net (IDTRAM) holds the original rate without
0697032005110429  * the 2% added.
0697042005110429  * COBRA adjustments: billed should hold the rate + 2% and net will
0697052005110429  * hold either the same amount or rate less 2% and PSF.
0697062005110429  *
0697072005110429  * 12/3/18 If the billed = net then still get the billed less 2%,
0697082005110429  * otherwise still use the net rate (these should be PSF plans) which
0697092005110429  * is already in prem.
069710200511     C                   if        idcob = 'C' and prem <> 0
069711200511
0697122005110429  * cobra manual adj (CMA)
069713200511     c                   if        idrc  = 'CMA'
069714200511     c                   if        idtramb = idtram
069715200511     c     idtramb       div(h)    1.02          prem
069716200511     c                   move      prem          netrte
069717200511     c                   end
0697182005110429  * cobra invoices
069719200511     c                   else
069720200511     c                   move      idtram        prem
069721200511     c                   end
069722200511
069723200511     c                   end
0713000908170361
0714000908170364 C                   Z-ADD     *ZEROS        HOLD1
0715000908170365  *
0716000908170366  *    CALCULATE SALESMAN COMMISSION AOMUNT...........
0717000908170367  *
0718000908170368 C                   move      *ZEROS        SLSCOM            9 2
0719000908170369 C                   move      *ZEROS        CRPCOM            9 2
0720000908170370  *
0721000908170370  * flat fee only paid for current enrollment and retro activity
0722000908170370  * for add,term,rein.
0723000908170370  *
0724000908170371 C     COMTYP        IFEQ      'HFF'
072500090817
072600090817     c                   if        idtrcd = 'MCC' or idtrcd = 'MCA' or
072700140228     c                             idtrcd = 'MCB' or idtrcd = 'M10'
072800090817     c                   leavesr
072900090817     c                   end
073000090817
073100090817     c* positive prem = positive flat fee
073200090817     c* negative prem = negative flat fee
073300090817     c* zero prem     = zero     flat fee
073400090817
073500090817     c                   if        prem > 0
0736000908170372 C                   add       COMRTE        SLSCOM
0737000908170373 C                   else
073800090817     c                   if        prem < 0
0739000908170372 C                   sub       COMRTE        SLSCOM
0740000908170373 C                   end
0741000908170373 C                   end
074200090817
0743000908170373 C                   END
0744000908170374 C*
0745000908170375 C     COMTYP        IFEQ      'HPP'
0746000908170376 C     PREM          MULT(H)   COMRTE        HOLD1             9 2
0747000908170377 C     HOLD1         DIV(H)    100           HOLD1
0748000908170378 C                   Z-ADD     HOLD1         SLSCOM
0749000908170379 C                   END
0750000908170380 C*
0751000908170381 C     COMTYP        IFEQ      'HPL'
0752000908170382 C     PREM          SUB       NETRTE        LOAD              9 2
0753000908170383 C     LOAD          MULT(H)   COMRTE        HOLD1
0754000908170384 C     HOLD1         DIV(H)    100           HOLD1
0755000908170385 C                   Z-ADD     HOLD1         SLSCOM
0756000908170386 C                   END
0757000908170387 C*
0758000908170388 C*   CALCULATE CORPORATE COMMISSION AMOUNT.........
0759000908170389 C*    ** LOAD BALANCE **
0760000908170389 C*
0761000908170389 C*
0762000908170390 C     CRPTYP        IFEQ      'ILB'
0763000908170391 C     subkey        CHAIN     SUBMST                             55
0764000908170392 C     PREM          SUB       NETRTE        HOLD1
0765000908170393 C     PLNCAT        IFEQ      'PMM'
0766000908170394 C     HOLD1         SUB       COMFEE        HOLD1
0767000908170395 C                   END
0768000908170396 C     PLNCAT        IFEQ      'PMS'
0769000908170397 C     HOLD1         SUB       COMFEE        HOLD1
0770000908170398 C                   END
0771000908170399 C     HOLD1         SUB       SLSCOM        CRPCOM
0772000908170400 C                   END
0773000908170401 C*
0774000908170389 C*    ** % OF LOAD - CORPORATE **
0775000908170401 C*         "ILC" NOT PROCESSED IN PGM SO THE COMMISSION WILL BE 0
0776000908170401 C*
0777000908170389 C*   THIS TYPE WILL BE USED FOR SPLIT COMMISSIONS ONLY...SMAN TYPE
0778000908170389 C*   OF "CC" WILL HAVE "PL" IN CORP TYPE AND RATE IN CORP RATE
0779000908170389 C*   BUT WILL NOT HAVE ANYTHING IN SMAN RATE. THE SMAN WILL
0780000908170389 C*   HAVE IT'S OWN SEPERATE COMM RATE RECORD WITH SMAN RATE
0781000908170389 C*   FILLED IN AND CORP TYPE "LC" AND 0 RATE
078200090817     C*
078300090817     C*  8/20/97 : CHANGE TO ALLOW SMAN TYPE OF "PP" AND CORP TYPE
078400090817     C*            OF "LC" (ONLY CHANGE WAS TO FM160 TO ALLOW INPUT)
078500090817     C*
078600090817     C*    * IMPORTANT FOR THE USERS TO REMEMBER : ALL % MUST ADD UP
078700090817     C*      TO 100
078800090817     C*
0789000908170389 C*      EXAMPLE:
0790000908170389 C*   SMAN  COMM   COMM    CORP   CORP
0791000908170389 C*   TYPE  RATE   TYPE    RATE   TYPE
0792000908170389 C*   ----  -----  ----    -----  -----
0793000908170389 C*   AC    39.66    PL     0.00    LC
0794000908170389 C*   CC     0.00          33.34    PL
0795000908170389 C*   OB    27.00    PL     0.00    LC
0796000908170389 C*
0797000908170389 C*
0798000908170389 C*
0799000908170390 C     CRPTYP        IFEQ      'IPL'
0800000908170382 C     PREM          SUB       NETRTE        LOAD              9 2
0801000908170401 C*
0802000908170401 C* "LOAD" IS THE LOAD...CORP COMM IS % OF LOAD
0803000908170401 C*
0804000908170383 C     LOAD          MULT(H)   CRPRTE        HOLD1
0805000908170384 C     HOLD1         DIV(H)    100           HOLD1
0806000908170385 C                   Z-ADD     HOLD1         CRPCOM
0807000908170400 C                   END
0808000908170401 C*
0809000908170401 C*
0810000908170402 C     CRPTYP        IFEQ      'IPP'
0811000908170403 C     PREM          MULT(H)   CRPRTE        HOLD1
0812000908170404 C     HOLD1         DIV(H)    100           HOLD1
0813000908170405 C                   Z-ADD     HOLD1         CRPCOM
0814000908170406 C                   END
0815000908170407 C*
0816000908170370 C*
0817000908170370 C*
0818000908170370 C* flat fee only paid for current enrollment and retro activity
0819000908170370 C* for add,term,rein.
0820000908170370 C*
0821000908170402 C                   IF        crptyp = 'IFF'
082200090817     c                   clear                   crpcom
082300090817     c                   if        idtrcd <> 'MCC' and idtrcd <> 'MCA'
082400090817     c                             and idtrcd <> 'MCB'
082500140228     c                             and idtrcd <> 'M10'
082600090817     c                   if        prem > 0
0827000908170372 C                   z-add     CRPRTE        CRPCOM
082800090817     c                   else
082900090817     c                   if        prem < 0
0830000908170372 C                   z-sub     CRPRTE        CRPCOM
0831000908170373 C                   end
0832000908170373 C                   end
083300090817     c                   end
083400090817     c                   end
0834012005110408  *
0834022005110408  * calculate member count for this record (0,1,-1)
0834032005110408  * change transactions are 0, all others add 1 for positive amount
0834042005110408  * and sub 1 for negative amount. this should handle voids since
0834052005110408  * voids reverse the transaction
0834062005110408  * 5/14/09 - employer billed subsidy plans have a 0 member count
0834072005110408  *           (SFADM = Y)
0834082005110408  * 1/03/14 - dependent records have a 0 member count
0834092005110408  * 4/09/14 - Tobacco records have a 0 member count
0834102005110408  *
083411200511     c                   move      0             memcnt            1 0
083412200511
083413200511     c                   if        idtrcd <> 'MCC' and idtrcd <> 'MCA'
083414200511     c                             and idtrcd <> 'MCB' and sfadm <> 'Y'
083415200511     c                             and idtrcd <> 'M10' and idtrcd <> 'MSM' and
083416200511     c                             idtrcd <> 'MSK' and
083417200511     c                             idseq = 00
083418200511     c                   if        idtram > 0
083419200511     c                   eval      memcnt = 1
083420200511     c                   end
083421200511     c                   if        idtram < 0
083422200511     c                   eval      memcnt = -1
083423200511     c                   end
083424200511     c                   end
083425200511
085700090817
085701200511      * add rpa068wk record
085702200511     C                   EXCEPT    RPADD1
085703200511
085800090817     c                   endsr
085900090901
0860000909010069 C**************************************************************
0861000909010069 C* calc admin fee and bonus draw for old comm carriers
0862000909010069 C**************************************************************
086300090901     c     #oldafbd      begsr
086400090901
086500090901      ********
086600090901      * code from cr130
086700090901      ********
086800090901
086900090901      * values from carrier master
087000090901     C                   z-add     cbonpX        bonp
087100090901     C                   z-add     cafpX         afp
087200090901     C                   z-add     ccompX        comp
087300090901
087400090901      * plan level overrides
087500090901     c* 999.99 = override to 0 %
087600090901    2c                   if        pbonp <> 0 and pbonp <> 999.99
087700090901     c                   eval      bonp  = pbonp
087800090901    2c                   end
087900090901    2c                   if        pbonp = 999.99
088000090901     c                   eval      bonp  = *zeros
088100090901    2c                   end
088200090901
088300090901    2c                   if        pafp <> 0 and pafp <> 999.99
088400090901     c                   eval      afp  = pafp
088500090901    2c                   end
088600090901    2c                   if        pafp = 999.99
088700090901     c                   eval      afp  = *zeros
088800090901    2c                   end
088900090901
089000090901    2c                   if        pcomp <> 0 and pcomp <> 999.99
089100090901     c                   eval      comp  = pcomp
089200090901    2c                   end
089300090901    2c                   if        pcomp = 999.99
089400090901     c                   eval      comp  = *zeros
089500090901    2c                   end
089600090901    ***
089700090901     C     COMP          DIV       100           CPCT              5 4
089800090901     C     AFP           DIV       100           APCT              5 4
089900090901     C     BONP          DIV       100           BPCT              5 4
090000090901     C     idtram        MULT      CPCT          COMEX             9 2
090100090901     C     idtram        MULT      APCT          ADMEX             9 2
090200090901     C     idtram        MULT      BPCT          BONDR             9 2
090300090901
090400090901      * accumulate commission
090500090901      * comm override was used
090600090901     c                   if        cpct <> 0
090700090901     c                   add       comex         wkcomtot
090800090901     c                   z-add     cpct          bccpct
090900090901     c                   else
091000090901      * comm override was not used
091100090901     c                   add       slscom        wkcomtot
091200090901     c                   z-add     comrte        bccpct
091300090901     c                   end
091400090901
091500090901     c                   z-add     admex         wkaftot
091600090901     c                   z-add     apct          bcfpct
091700090901
091800090901     c                   z-add     bondr         wkbdtot
091900090901     c                   z-add     bpct          bcdpct
092000090901
092100090901     c                   endsr
092200090901
0923000908140069 C**************************************************************
0924000908140069 C* get member count
0924011612150069 C*   **********************************************************
0926011612150069 C*   **** ANY changes to this member count logic must also be *
0926021612150069 C*   *    made in DW040. ***                                  *
0926031612150069 C*   **********************************************************
0926051612150069 C**************************************************************
092606161215       begsr #mcnt;
0926071612150408  *
0926081612150408  * calculate member count for this record (0,1,-1)
0926091612150408  * -change transactions are 0 (MCC,MCA,MCB,M10,M51,M41)
0926101612150408  * -midmonth records are 0 except invoices and adds
0926111612150408  * -smoke rate transactions are 0 (MSM,MSK)
0926121612150408  *
0926131612150408  * all others: +1 for positive amount paid and -1 for negative amt paid
0926171612150408  *
096802161215       clear bcmcnt;   // net member cnt
096803161215       clear bcBmcnt;  // billed member cnt
096804161215       clear bcAmcnt;  // adjustment member cnt
096805161215       clear bcdcnt;   // net depend cnt
096806161215       clear bcBdcnt;  // billed depend cnt
096807161215       clear bcAdcnt;  // adjustment depend cnt
096808161215       clear wkcnt;    // work count
096809161215
0968101612150408  * skip all transactions that do not affect the count
096811161215
096812161215       if idtram = 0 or
096813161215          (idtrmdday <> 01 and idrc2 <> 'CE' and
096814161215           idtrcd <> 'MAC' and idtrcd <> 'MDA') or
096815161215          idtrcd = 'MCC' or idtrcd = 'MCA' or idtrcd = 'MCB' or
096816161215          idtrcd = 'M10' or idtrcd = 'MSM' or idtrcd = 'MSK' or
096817161215          idtrcd = 'M41' or idtrcd = 'M51';
096818161215        leavesr;
096819161215       endif;
096820161215
0968211612150408  * set +1 or -1 count for this transaction (zero paid transactions
0968221612150408  * have already been skipped above)
096823161215
096824161215       if idtram > 0;
096825161215        wkcnt = 1;
096826161215       else;
096827161215        wkcnt = -1;
096828161215       endif;
096829161215
0968301612150408  * member transaction
096831161215       if idseq = 0;
096832161215        bcmcnt = wkcnt;
0968331612150408  * count this as an invoice or adj ?
096834161215        if idrc2 = 'CE';
096835161215          bcBmcnt = wkcnt;  // billed / invoice rec
096836161215        else;
096837161215          bcAmcnt = wkcnt;  // adjustment rec
096838161215        endif;
096839161215
0968401612150408  * dependent transaction
096841161215       else;
096842161215        bcdcnt = wkcnt;
0968431612150408  * count this as an invoice or adj ?
096844161215        if idrc2 = 'CE';
096845161215          bcBdcnt = wkcnt;  // billed / invoice rec
096846161215        else;
096847161215          bcAdcnt = wkcnt;  // adjustment rec
096848161215        endif;
096849161215       endif;
096850161215
096851161215       endsr;
096852161215
0968531612150069 C**************************************************************
0968541612150069 C* get market size
0968551612150069 C**************************************************************
096856161215     c     #mksz         begsr
096900010212     c* get market size - defalut to 50 for comm sched 2 and default to
097000010212     c* 1 for comm sched 1, also fill method with "P" for sched 1
097100010212
097101161215     c                   clear                   bcmksz
097102161215     c                   clear                   bccmth
097103161215
097200010212     c                   if        comsch = '2'
097300010212     c                   movel     '50   '       bcmksz
097400010212     c                   else
097500010212     c                   movel     '1    '       bcmksz
097600010212     c                   move      'P'           bccmth
097700010212     c                   end
097800010212
097900010212     c                   eval      *in67 = *off
098000010212     c     mkcaky        setll     mktcara1
098100010212     C                   dow       *in67 = *off
098200010212     c     mkcaky        reade     mktcara1                               67
0983000102120133 C   67              leave
098400140911     c                   if        idtrmd < mafrdt or (matodt <> 0 and
098500140911     c                             idtrmd > matodt) or (mafrdt = matodt)
098600010212     c                   iter
098700010212     c                   endif
098800010212     c                   movel     maszcd        bcmksz
098900010212     c                   enddo
099000010212
099100010203     c                   endsr
099200021016
0993000210160069 C**************************************************************
0994000210160069 C* first time                                                 *
0995000210160069 C**************************************************************
099600021016     c     *inzsr        begsr
099700021016     C                   TIME                    HTIME             6 0
099800021016     C*
099900090828     C*                  MOVE      *DATE         @DATIN
100000090828     C*                  EXSR      #DATMY
100100090828     C*                  MOVE      @DATOU        UYMD              8 0
1002000210160111 C*
100300021016     C                   MOVE      LEFFDT        @DATIN
100400021016     C                   EXSR      #DATMY
100500090827     C                   MOVE      @DATOU        LEFMDY            8 0
100600030805
100700200507     C***                EXCEPT    HEAD2
100800021017
100900021016     C     ACKEY         KLIST
101000021016     C                   KFLD                    IDTRST
101100021016     C                   KFLD                    IDSUBD
101200021016     C                   KFLD                    IDACCT
101300021016
101400090819     c     subkey        klist
101500090819     c                   kfld                    idtrst
101600090819     c                   kfld                    idsubd
101700090819
101800090819     c     cratky        klist
101900090819     c                   kfld                    cmtrst
102000090819     c                   kfld                    csubdv
102100090819     c                   kfld                    cmplan
102200090819     c                   kfld                    stype
102300090819
102400021016     c     mkcaky        klist
102500021016     c                   kfld                    idtrst
102600021016     c                   kfld                    idsubd
102700021016     c                   kfld                    idacct
102800021016     c                   kfld                    idcar
102900021017
103000030409     c     cmkey         klist
103100030409     c                   kfld                    idtrst
103200030409     c                   kfld                    idsubd
103300030409     c                   kfld                    idacct
103400030409     c                   kfld                    idplan
103500090514
103600090514     c     plnkey        klist
103700090514     c                   kfld                    idtrst
103800090514     c                   kfld                    idsubd
103900090514     c                   kfld                    idplan
104000090817
104100090817     c     brcmky        klist
104200090817     c                   kfld                    idcar
104300090817     c                   kfld                    bcmksz
104400090817
104500090819     C     AFKEY         KLIST
104600090819     C                   KFLD                    idcar
104700090819     C                   KFLD                    bcmksz
104800090819
104900090819     c     abkey         klist
105000090819     c                   kfld                    idtrst
105100090819     c                   kfld                    idsubd
105200090819     c                   kfld                    idacct
105300090819     c                   kfld                    idcar
105400090819     c                   kfld                    plncat
105500030409
105501200505     c     dfrl2key      klist
105502200505     c                   kfld                    idtrst
105503200505     c                   kfld                    idsubd
105504200505     c                   kfld                    idacct
105505200505     c                   kfld                    idinv#
105506200505     c                   kfld                    idgrp#
105507200505
105600021016     c                   endsr
105700980817     C*
1058009808170103 C***************************************************
1059009808170104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
1060009808170105 C***************************************************
1061009808170107 C*
1062009808170107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
1063009808170107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
1064009808170107 C*
1065009808170106 C     #DATMY        BEGSR
106600980817     C                   MOVEL     @DATIN        @MD               4 0
106700980817     C                   MOVE      @DATIN        @Y                4 0
106800980817     C                   MOVE      @MD           @DATOU            8 0
106900980817     C                   MOVEL     @Y            @DATOU
107000980817     C                   MOVE      *ZEROS        @DATIN            8 0
1071009808170120 C                   ENDSR
1072000908190103  ***************************************************
1073000908190104  * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
1074000908190105  ***************************************************
1075000908190107  *
1076000908190107  * DATE IN  = @DATIN (8.0) YYYYMMDD
1077000908190107  * DATE OUT = @DATOU (8.0) MMDDYYYY
1078000908190107  *
1079000908190106 C     #DATYM        BEGSR
108000090819     C                   MOVE      @DATIN        @MD               4 0
108100090819     C                   MOVEL     @DATIN        @Y                4 0
108200090819     C                   MOVEL     @MD           @DATOU            8 0
108300090819     C                   MOVE      @Y            @DATOU
108400090819     C                   MOVE      *ZEROS        @DATIN            8 0
1085000908190120 C                   ENDSR
1086000908190107 C*
108700020322
1087012005110458 ORPA068WK  EADD         RPADD1
1087022005110459 O                       cmtrst               3
1087032005110459 O                       csubdv               6
1087042005110459 O                       cmacct              10
1087052005110459 O                       cmplan              14
1087062005110460 O                       idss#               23
1087072005110461 O                       idseq               25
1087082005110462 O                                           27 '  '
1087092005110462 O                       rppdfl              28
1087102005110463 O                       SLSMAN              31
1087112005110464 O                       COMRTE              36
1087122005110465 O                       COMTYP              39
1087132005110466 O                       PREM                43P
1087142005110467 O                       idcar               46
1087152005110468 O                       idgrp#              61
1087162005110469 O                       CNAME              101
1087172005110470 O                       CRPRTE             106
1087182005110471 O                       CRPTYP             109
1087192005110471 O                       idtrmd             117
1087202005110471 O                       memcnt             118
1087212005110475 O                       SLSCOM             126P
1087222005110476 O                       CRPCOM             131P
1087232005110476 O                       sxagcy             134
108724200511     O                       cmrelid            158
108725200511     O                       iddtsq             177
108726200511     O                       idcomdt            185
108727200511     O                       idpaid             193
1088000210170237 Oqsysprt   E            head2          2 03
1089000210170239 O                                           73 '** GROUP BENEFIT SERVICE'
1090000210170241 O                                           77 'S **'
1091000210170242 O          E            head2          1
1092002005050244 O                                           80 'CF PAY DFR REMIT ERROR '
1092012005050244 O                                           86 'REPORT'
1093000210170242 O          E            head2          1
109400021017 244 O                                           65 'FOR :'
109500090827 244 O                       LEFMDY              76 '  /  /    '
1096000210170242 O          E            head2          1
1097002005050248 O                                           25 'PROGRAM NAME: RPA421'
1098000210170249 O                                          122 'PAGE :'
1099000210170250 O                       PAGE2         Z    131
1100000210170242 O          E            head2          1
1101000210170253 O                                           14 'RUN DATE:'
1102000210170254 O                       UDATE         Y     25
1103000210170255 O                                          122 'TIME :'
1104000210170256 O                       HTIME              131 '  :  :  '
1105000210170242 O          E            head2          1
1106000210170259 O                                           24 '------------------------'
1107000210170260 O                                           48 '------------------------'
1108000210170261 O                                           72 '------------------------'
1109000210170262 O                                           96 '------------------------'
1110000210170263 O                                          120 '------------------------'
1111000210170286 O                                          132 '------------'
1112000210170242 O          E            head2          1
1113000210170267 O                                            9 'ACCOUNT #'
1114000210170268 O                                          104 'ERROR'
1115000210170242 O          E            head2          2
1116000210170259 O                                           24 '------------------------'
1117000210170260 O                                           48 '------------------------'
1118000210170261 O                                           72 '------------------------'
1119000210170262 O                                           96 '------------------------'
1120000210170263 O                                          120 '------------------------'
1121000210170286 O                                          132 '------------'
1122000908190287 O          E            ERROR1         1
1123000210170288 O                       IDTRST               3
1124000210170288 O                                            4 '-'
1125000210170288 O                       IDSUBD               7
1126000210170288 O                                            8 '-'
1127000210170288 O                       IDACCT              12
1128000210170288 O                       IDPLAN              19
1129000908190125 O                       idcar               31
1130000908190138 O                       bcmksz              43
1131001409110288 O                       idtrmd              69 '    /  /  '
1132000210170288 O                       IDSS#               83
1133000908190288 O                                          125 'NO ADMIN FEE SET UP       '
1134000210170287 O          E            ERROR2         1
1135000210170288 O                       IDTRST               3
1136000210170288 O                                            4 '-'
1137000210170288 O                       IDSUBD               7
1138000210170288 O                                            8 '-'
1139000210170288 O                       IDACCT              12
1140000210170288 O                                          125 'NO ACCOUNT MASTER         '
1141000909010287 O          E            ERROR3         1
1142000909010288 O                       IDTRST               3
1143000909010288 O                                            4 '-'
1144000909010288 O                       IDSUBD               7
1145000909010288 O                                            8 '-'
1146000909010288 O                       IDACCT              12
1147000909010288 O                       IDcar               18
1148000909010288 O                                          125 'NO CARRIER MASTER         '
1149000908190287 O          E            ERROR4         1
1150000908190288 O                       IDTRST               3
1151000908190288 O                                            4 '-'
1152000908190288 O                       IDSUBD               7
1153000908190288 O                                            8 '-'
1154000908190288 O                       IDACCT              12
1155000908190288 O                       IDPLAN              19
1156001409110288 O                       idtrmd              69 '    /  /  '
1157000908190523 O                       Stype               82
1158000908190523 O                       effmdy        y     95
1159000908190288 O                                          125 'NO COMMISSION RATE(CRATE) '
1160000908190287 O          E            ERROR5         1
1161000908190288 O                       IDTRST               3
1162000908190288 O                                            4 '-'
1163000908190288 O                       IDSUBD               7
1164000908190288 O                                            8 '-'
1165000908190288 O                       IDACCT              12
1166000908190288 O                       IDPLAN              19
1167001409110288 O                       idtrmd              33 '    /  /  '
1168000908190523 O                       idcar               39
1169000908190523 O                       bcmksz              47
1170000908190523 O                       effmdy        y     95
1171000908190288 O                                          125 'NO BONUS DRAW SET UP      '
