0001000306110015  *******************************************************************
000200090814      * rpa401         Group Benefit Services, Inc.                     *
000300030611      *                                                                 *
000400030611      *    WRITTEN BY - DAVID KETTERMAN                                 *
000500090814      *    DATE       - 08/14/09                                        *
000600030611      *                                                                 *
000700090814      * This program will produce a workfile for the unpaid remittance  *
0008000306110015  *                                                                 *
0009001401050015  * 01/05/14 dlk - add dep seq#, depend record will not alter      *
0010001401050035  *                member count.                                   *
0011001402280015  * 02/28/14 dlk - bday change will not alter member count          *
001200140506      * 04/09/14 dlk - tobacco adjustments will not affect member cnt
001300140911      * 09/11/14 dlk - change to use IDTRMD instead of IDCVDT for
0014001409110015  *                compensation calculations.                       *
001500161215      * 12/15/16 dlk - change member count routine to match DW040 with
0016001612150015  *                additional count fields.
001700181203      * 12/03/18 dlk - Cobra manual adjustments will now only back out the
0018001812030035  *                2% admin fee if net = billed. If net <> billed then
0019001812030035  *                use the net rate (these should be PSF plans).
0020001612150015  *
002100181203      *  ** any changes the the calculations must also be made in      *
002200181203      *     RPA068 **
0023000306110015  *******************************************************************
0024000908140017 FINVDET    IP   E             DISK
0025009606050019 FACCMST    IF   E           K DISK
0026009606250019 FCARMST    IF   E           K DISK
0027000304090019 FCMCT14    IF   e           k DISK
0028000102120014 Fmktcara1  IF   e           k DISK
0029000905140014 Fplnmst    if   e           k DISK
0030000908190039 FCRAT13    IF   e           k DISK
0031000908190014 Fbrkrcom1  IF   e           k DISK
003200090819     fsmanrlt   if   e           k disk
003300090819     FADMNFEE1  IF   E           K DISK
003400090819     faboverl1  if   e           k disk
003500090819     FBONUSDR1  IF   E           K DISK
0036000908190047 FSUBMST    IF   e           k DISK
0037000908190014 FSMAN      IF   e           k DISK
0038000908140030 Fbcrec     O  A E             DISK
0039000908200030 Fqsysprt   O    F  132        PRINTER OFLIND(*INOf)
004000030926
0041000908180056 D  wkmthd         s              1
0042000908180056 D  wkcmam         s             17  8
0043000908180056 D  wkcmrt         s              5  2
0044000908190056 D  wkcomtot       s                   like(bccchg)
0045000908190056 D  wkbdtot        s                   like(bcdchg)
0046000908190056 D  wkbdchg        s                   like(bcdchg)
0047001612150133 D  wkbdmth        s                   like(bcdmth)
0048000908190056 D  wkaftot        s                   like(bcfchg)
0049000908200056 D* w9glob         s                   like(bccchg)
0050000908190056 D  wkfee          s                   like(bcfchg)
0051001612150133 D  wkfeemth       s                   like(bcfmth)
0052000908190056 D  globalcomamt   s                   like(wkcmam)
0053000908190133 Dworkafff         s                   like(affee)
0054000908190133 Dworkafpp         s                   like(affeepp)
0055000908190133 Dworkafpc         s                   like(affeepc)
0056000908190133 Dworkbdff         s                   like(bdovra)
0057000908190133 Dworkbdpp         s                   like(bdovpp)
0058000908190133 Dworkbdpc         s                   like(bdovpc)
0059000908200133 Dwkprem           s                   like(holdprem)
0060000908200133 D w9afovff        s                   like(abovra)
0061000908200133 D w9afovpc        s                   like(abovpc)
0062000908200133 D w9afovpp        s                   like(abovpp)
0063000908200133 D w9bdovff        s                   like(abovra)
0064000908200133 D w9bdovpc        s                   like(abovpc)
0065000908200133 D w9bdovpp        s                   like(abovpp)
0066000908190133 D wksplitpct      s              7  6
0067000908190133 D wkpct           s              7  6
006800090825     Dbonp             S              5P 2
006900090825     Dafp              S              5P 2
007000090825     Dcomp             S              5P 2
007100161215     d  wkcnt          s                   like(bcmcnt)
007200090825    ***
0073000908190132 D                 DS
0074000908190133 D  DTETMP                 1      8  0
0075000908190134 D  CENRMM                 5      6  0
0076000908190135 D  CENRDD                 7      8  0
0077000908190136 D  CENRYY                 3      4  0
0078009606050055 D                 DS
0079009606050056 D  TSA                    1     10
0080009606050056 D  IDTRST                 1      3  0
0081009606030056 D  IDSUBD                 4      6  0
0082009606030056 D  IDACCT                 7     10  0
0083000908280055 D*                DS
0084000908280056 D* covtdt                 1      8  0
0085000908280056 D* covcym                 1      6  0
0086000908280056 D* covd                   7      8  0
0087009910230055 D                 DS
0088001409110056 D  idtrmd                 1      8  0
0089001409110056 D  idtrmdday              7      8  0
0090000104170055 D                 DS
0091000104170056 D  IDRC                   1      3
0092000104170056 D  IDRC2                  2      3
0093000101310055 D                 DS
0094000101310056 D  bcefdt                 1      8  0
0095000101310056 D   bcefyy                1      4  0
0096000101310056 D   bcefmm                5      6  0
0097000101310056 D   bcefdd                7      8  0
0098000908280055 D*                DS
0099000908280056 D* idgrp#                 1     15
0100000908280056 D*  groupid               1      8
0101000908280056 D*  subgroupid            9     12
010200081215
010300081215      * primary broker field from CMCT14
010400081215     D                 DS
010500081215     D  free5                  1      5
010600081215     D  cmprib                 1      1
010700081215
0108009606030055 D                UDS
0109000908260056 D  LEFFDT                 1      8  0
011000090825
011100090825     ICARMSR
011200090825     I              CBONP                       CBONPX
011300090825     I              CAFP                        CAFPX
011400090825     I              CCOMP                       CCOMPX
011500000807     C*
011600140911     C* idtrmd (effective date) as day 01
011700000807     C*
011800140911     c                   move      idtrmd        idtrmd01          8 0
011900140911     c                   move      01            idtrmd01
012000030806
012100090814     C* get acct rec
012200030806     C     ACKEY         CHAIN     ACCMST
012300030806     C                   if        not %found(accmst)
012400090820     C   of              EXCEPT    HEAD2
012500970625     C                   EXCEPT    ERROR2
012600090819     C                   GOTO      #end
012700970625     C                   END
012800030806
012900090901     C     IDCAR         CHAIN     CARMST
013000090901     C                   if        not %found(carmst)
013100090901     C   of              EXCEPT    HEAD2
013200090901     C                   EXCEPT    ERROR3
013300090901     C                   GOTO      #end
013400090901     C                   END
013500090901
013600081215      *
013700081216      * read all comctx that are active for this plan / date and find the
013800081216      * 1st active relation
013900081216     C                   clear                   SLSOUT            3
014000081216     C                   clear                   relout            8
0141000812160197  *
014200081216  93 C     cmkey         setll     cmct14
014300081216     c                   dou       %eof(cmct14)
0144000812160195 C     cmkey         reade     cmct14
014500140911     c                   if        (not %eof(cmct14)) and (idtrmd >= effdat)
014600140911     c                             and (cmcan = 0 or cmcan >= idtrmd)
014700081216     c                             and (cmcan <> effdat)
014800081216      * hold 1st active
014900081216     c                   if        relout  = *blanks
015000081216     C                   MOVE      SLSMAN        SLSOUT
015100081216     C                   MOVE      cmrelid       relout
015200081216     c                   end
015300081216      * if this rec is the primary broker, use it
015400081216     c                   if        cmprib = 'Y'
015500081216     C                   MOVE      SLSMAN        SLSOUT
015600081216     C                   MOVE      cmrelid       relout
015700081216     c                   leave
0158000812160201 C                   end
015900081216
016000081216     c                   end
016100081216     c                   enddo
016200010131     C*
016300090819     C* fill BCREC fields
016400090901     c                   clear                   bcrecr
016500090901
016600010204     c                   movel     idgrp#        bcgn
016700010131     C                   z-add     idtrst        bctrst
016800010131     C                   z-add     idsubd        bcsub
016900010131     C                   z-add     idacct        bcacct
017000010131     C                   movel     idcar         bccar
017100010131     C                   movel     idplan        bcplan
017200010131     C                   movel     acnam1        bcanam
017300010131     C                   movel     cgrpcd        bcgrpc
017400090817     C                   z-add     idtram        bcpada
017500140911     C                   z-add     idtrmd01      bcefdt
017600030409     C                   movel     relout        bcrelid
017700060302     C                   z-add     idbamt        bclifev
017800010203
017900090914      *******************************
018000090914      * only calc commission if it has not been paid on this record
018100090914     c                   if        idcomdt = 0
018200090914
018300090818     c* get member count and market size
018400010203     c                   exsr      #mcnt
018500161215     c                   exsr      #mksz
018600010131
018700090819     c* accumulate all commission amounts for this invdet rec
018800090814     c                   exsr      #getcom
018900090814
019000090901      * calc admin fee and bonus draw
019100090901
019200090901     c                   clear                   wkaftot
019300090901     c                   clear                   wkbdtot
019400090901     c                   if        comsch = '2'
019500090901     c                   exsr      #newafbd
019600090901     c                   else
019700090901     c                   exsr      #oldafbd
019800090901     c                   end
019900090901
020000090901     c* move totals to bcrec fields
020100090819     c                   z-add     wkcomtot      bccchg
020200090901     c                   z-add     wkaftot       bcfchg
020300090819     c                   z-add     wkbdtot       bcdchg
020400090914
020500090914     c                   end
020600090914      *******************************
020700090819
020800090901      * write 1 bcrec record with all amounts calculated
020900090819     C                   WRITE     bcrecr
021000090819     c                   clear                   bcrecr
021100090819
021200010131     c                   clear                   slsout
021300030409     c                   clear                   relout
021400960625     C*
021500960513     C     #END          TAG
021600010203
0217000102030069 C**************************************************************
0218000908140069 C* get commission info
0219000102030069 C**************************************************************
022000090814     c     #getcom       begsr
022100090814
022200090814      * find all commision control records that apply to this plan
022300090819      * and accumulate amounts
022400090814
022500090819     c                   clear                   wkcomtot
022600090819
022700090814  93 C     cmkey         setll     cmct14
022800090814     c                   dou       %eof(cmct14)
0229000908140195 C     cmkey         reade     cmct14
023000140911     c                   if        (not %eof(cmct14)) and (idtrmd >= effdat)
023100140911     c                             and (cmcan = 0 or cmcan >= idtrmd)
023200090814     c                             and (cmcan <> effdat)
0233000908180272  * calc commission based on old or new schedule
023400090818     c                   if        ccpnc <> 'N'
023500090818     c                   if        comsch = '2'
023600090818     c                   exsr      #newcom
023700090818     c                   else
023800090818     c                   exsr      #oldcom
023900090818     c                   end
024000090818     c                   end
024100090818
024200090817     c                   end
024300090814     c                   enddo
024400090814
024500090814     c                   endsr
024600090814
0247000908170103  ************************************************************
0248000908170104  * #NEWCOM SR - BUILD RPA069WK USING NEW COMMISSION METHOD   *
0249000908170105  ************************************************************
0250000908170107  *
0251000908170106 C     #NEWCOM       BEGSR
025200090817
025300090826     c                   z-add     idtram        holdprem
0254000908170429  *
0255001812030429  * COBRA invoices: The billed amount (IDTRAMB) holds the rate plus
0256001812030429  * the 2% surcharge. The net (IDTRAM) holds the original rate without
0257001812030429  * the 2% added.
0258001812030429  * COBRA adjustments: billed should hold the rate + 2% and net will
0259001812030429  * hold either the same amount or rate less 2% and PSF.
0260001812030429  *
0261001812030429  * 12/3/18 If the billed = net then still get the billed less 2%,
0262001812030429  * otherwise still use the net rate (these should be PSF plans) which
0263001812030429  * is already in holdprem.
026400090817     C                   if        idcob = 'C' and idtramb <> 0
026500090817
0266001812030429  * cobra manual adj (CMA)
026700090817     c                   if        idrc  = 'CMA'
026800181203     c                   if        idtramb = idtram
026900090820     c     idtramb       div(h)    1.02          holdprem          9 2
027000181203     c                   end
0271001812030429  * cobra invoices
027200090817     c                   else
027300090826     c                   z-add     idtram        holdprem
027400090817     c                   end
027500090817
027600090817     c                   end
0277000908170361
027800090817
0279000908170456  *******************
0280000908170456  * Calculate commission
0281000908170456  *******************
0282000908170456
0283000908170456  * if pay no comm field was set to "P" then skip all comm calcs
0284000908170456  * this allows prem and member count to pass through but no comm
0285000908170456  * will be paid
028600090817     c                   if        ccpnc = 'P'
028700090817     c                   leavesr
028800090817     c                   endif
028900090817
029000090817      *******************
0291000908170456  * global Commission = mbr count x flat fee
0292000908170456  * 8/15/05 add % of prem calc
029300090817      *******************
029400090817
029500090817     c                   clear                   globalcomamt
029600090817     c                   clear                   rbrkrcom
029700090817     c                   clear                   foundbrkrc        1
029800090817
029900090817     c* 01/02/09 - use effdt of trans to find broker com
030000090817     c     brcmky        setll     brkrcom1
030100090817     c                   dou       %eof(brkrcom1)
030200090817     c     brcmky        reade     brkrcom1
030300090817     C                   if        (not %eof(brkrcom1)) and
030400090817     C                             (bcfromdt <> bctodate) and
030500140911     c                             ((bcfromdt <= idtrmd and bctodate >= idtrmd)
030600140911     c                               or (bcfromdt <= idtrmd and bctodate = 0))
030700090817     c                   eval      foundbrkrc = 'Y'
030800090817     c                   leave
030900090817     c                   end
031000090817     c                   enddo
031100090817
031200090817     c                   if        foundbrkrc = 'Y'
031300090817
031400090817      * global fee per member - default method
031500090818     c                   clear                   wkcmrt
031600090820     c*                  z-add     bcamnt        w9glob
031700161215     c     bcmcnt        mult      bcamnt        wkcmam
031800090818     c                   z-add     wkcmam        globalcomamt
031900090818     c                   movel     'G'           wkmthd
032000090817
032100090817      * global % of prem
032200090817     c                   if        bcpop <> 0
032300090818     c                   z-add     bcpop         wkcmrt
032400090818     c                   clear                   wkcmam
032500090817     c                   clear                   wkpct
032600090817     c     bcpop         div       100           wkpct
032700090820     c     wkpct         mult      holdprem      wkcmam
032800090818     c                   z-add     wkcmam        globalcomamt
032900090817      * w9glob will hold the orig calculated % of prem amt
033000090820     c*                  z-add     wkcmam        w9glob
033100090818     c                   movel     'O'           wkmthd
033200090817     c                   end
033300090817
033400090817     c                   endif
0335000908170456
033600090817      ********
0337000908170456  * process overrides to global commission
033800090817      ********
0339000908170456
0340000908170456  * flat fee per member override
0341000908170456
034200090817     c                   if        ccovra <> *zero
034300090818     c                   movel     'F'           wkmthd
034400090818     c                   clear                   wkcmam
034500090818     c                   clear                   wkcmrt
034600161215     c     bcmcnt        mult      ccovra        wkcmam
034700090820     c*                  z-add     ccovra        w9glob
034800090817
034900090817     c                   else
0350000908170456
0351000908170456  * % of commission override
035200090817
035300090817     c                   if        ccovpc <> *zero
035400090818     c                   movel     'C'           wkmthd
035500090820     c*                  z-add     ccovpc        w9cmov
035600090818     c                   clear                   wkcmam
035700090817     c     ccovpc        div       100           wkpct
035800090818     c     wkpct         mult      globalcomamt  wkcmam
035900090817
036000090817     c                   else
036100090817
0362000908170456  * % of premium override
036300090817
036400090817     c                   if        ccovpp <> *zero
036500090818     c                   movel     'P'           wkmthd
036600090818     c                   z-add     ccovpp        wkcmrt
036700090818     c                   clear                   wkcmam
036800090817     c     ccovpp        div       100           wkpct
036900090817
0370000908170456  * if premium split is entered (split commisison) the premium must
0371000908170456  * first be reduced by the split % before the % of prem can be calc
037200090818     c                   if        cccmsp <> 0
037300090818     c     cccmsp        div       100           wksplitpct
037400090820     c     wksplitpct    mult      holdprem      wkprem
037500090817     c                   else
037600090820     c                   z-add     holdprem      wkprem
037700090817     c                   end
037800090817
037900090818     c     wkpct         mult      wkprem        wkcmam
038000090817     c                   end
038100090817
038200090817     c                   endif
038300090817     c                   endif
038400090817
0385000908170456  * Ensure commission amt is same sign as premium
038600090817
038700090820     c                   if        holdprem < 0 and wkcmam > 0
038800090818     c     wkcmam        mult      -1            wkcmam
038900090817     c                   endif
0390000908170456
039100090819      * accumulate commission amounts
039200090819     c                   add       wkcmam        wkcomtot
039300090819     c                   move      wkmthd        bccmth
0394000908190456
0395000908170120 C                   ENDSR
039600090817
039700090817      ******************************************
039800090901      * logic from rpa060n2 to admin fee and bonus draw for new commission
039900090901      * carriers
040000090817      ******************************************
040100090901     c     #newafbd      begsr
040200090819
040300090819      * logic from ra068 to get admin fee and bonus draw override
040400090819
040500090819     c                   clear                   w9afovpp
040600090819     c                   clear                   w9afovff
040700090819     c                   clear                   w9afovpc
040800090819     c                   clear                   w9bdovpp
040900090819     c                   clear                   w9bdovff
041000090819     c                   clear                   w9bdovpc
041100090819
041200090819      * 1/2/09 change to use trans effdt for the search instead of remit dt
041300090819     c     abkey         setll     aboverl1
041400090819     C                   dou       %eof(aboverl1)
041500090819     c     abkey         reade     aboverl1
041600090819     C                   if        (not %eof(aboverl1)) and
041700090819     C                             (abfrdt <> abtodt) and
041800140911     c                             ((abfrdt <= idtrmd and abtodt >= idtrmd) or
041900140911     c                              (abfrdt <= idtrmd and abtodt = 0))
042000090819      * admin fee
042100090819     c                   if        abab = 'A'
042200090819     c                   move      abovpp        w9afovpp
042300090819     c                   move      abovra        w9afovff
042400090819     c                   move      abovpc        w9afovpc
042500090819      * bonus draw
042600090819     c                   else
042700090819     c                   move      abovpp        w9bdovpp
042800090819     c                   move      abovra        w9bdovff
042900090819     c                   move      abovpc        w9bdovpc
043000090819     c                   end
043100090819
043200090819     c                   endif
043300090819     c                   enddo
0434000908190456
043500090819
043600090819      * *** Logic from rpa060N2 starts here ****
043700090817
043800090817      * fill comm pct (for methods using a %)
043900090818     c                   z-add     wkcmrt        bccpct
044000090817
044100090817      ****
044200090817      * Calc Admin Fee
044300090817      ****
044400090817     c                   clear                   workafff
044500090817     c                   clear                   workafpp
044600090817     c                   clear                   workafpc
044700090817      * override
044800090817     c                   if        w9afovff <> 0 or w9afovpp <> 0 or
044900090817     c                             w9afovpc <> 0
045000090817     c                   z-add     w9afovff      workafff
045100090817     c                   z-add     w9afovpp      workafpp
045200090817     c                   z-add     w9afovpc      workafpc
045300090817
045400090817      * 999.99 = override to 0
045500090817     c                   if        workafff = 999.99
045600090817     c                   eval      workafff = *zeros
045700090817     c                   end
045800090817     c                   if        workafpp = 999.9999
045900090817     c                   eval      workafpp = *zeros
046000090817     c                   end
046100090817     c                   if        workafpc = 999.9999
046200090817     c                   eval      workafpc = *zeros
046300090817     c                   end
046400090817
046500090817
046600090817     c                   exsr      #calcaf
046700090817
046800090817     c                   else
046900090817
047000090817     c* 01/02/09 - use effdt of trans to find admin fee
047100090817     c                   clear                   foundadmf         1
047200090817     c     afkey         setll     admnfee1
047300090817     c                   dou       %eof(admnfee1)
047400090817     c     afkey         reade     admnfee1
047500090817     C                   if        (not %eof(admnfee1)) and
047600090817     C                             (affromdt <> aftodate) and
047700140911     c                             ((affromdt <= idtrmd and aftodate >= idtrmd)
047800140911     c                               or (affromdt <= idtrmd and aftodate = 0))
047900090817     c                   eval      foundadmf = 'Y'
048000090817     c                   leave
048100090817     c                   end
048200090817     c                   enddo
048300090817
048400090817     c                   if        foundadmf  = 'Y'
048500090817     c                   z-add     affee         workafff
048600090817     c                   z-add     affeepp       workafpp
048700090817     c                   z-add     affeepc       workafpc
048800090817     c                   exsr      #calcaf
048900090817     c                   else
049000090817      * error - missing admin fee
049100090817     c                   if        firste <> 'Y'
049200090819     c                   except    head2
049300090817     c                   move      'Y'           firste            1
049400090817     c                   end
049500090819     c   of              except    head2
049600090817     c                   except    error1
049700090817     c                   end
049800090817
049900090817     c                   end
050000090817
050100090817      ****
050200090817      * Calc Bonus Draw Charge on remittance
050300090817      ****
050400090817     c                   clear                   workbdff
050500090817     c                   clear                   workbdpp
050600090817     c                   clear                   workbdpc
050700090817      * override
050800090817     c                   if        w9bdovpp <> 0 or w9bdovpc <> 0
050900090817     c                             or w9bdovff <> 0
051000090817     c                   z-add     w9bdovff      workbdff
051100090817     c                   z-add     w9bdovpp      workbdpp
051200090817     c                   z-add     w9bdovpc      workbdpc
051300090817
051400090817      * 999.99 = override to 0
051500090817      * flat fee
051600090817     c                   if        workbdff = 999.99
051700090817     c                   eval      workbdff = *zeros
051800090817     c                   end
051900090817     c                   if        workbdpp = 999.9999
052000090817     c                   eval      workbdpp = *zeros
052100090817     c                   end
052200090817     c                   if        workbdpc = 999.9999
052300090817     c                   eval      workbdpc = *zeros
052400090817     c                   end
052500090817
052600090817     c                   exsr      #calcbd
052700090817     c                   else
052800090817
052900090817      * get bonus draw
053000090817     c* 01/02/09 - use effdt of trans to find admin fee
053100090817     c                   clear                   foundbd           1
053200090817     c     afkey         setll     bonusdr1
053300090817     C                   dou       %eof(bonusdr1)
053400090817     c     afkey         reade     bonusdr1
053500090817     C                   if        (not %eof(bonusdr1)) and
053600140911     c                             ((bdfrdt <= idtrmd and bdtodt >= idtrmd) or
053700140911     c                             (bdfrdt <= idtrmd and bdtodt = 0))
053800090817     c                   eval      foundbd = 'Y'
053900090817     c                   leave
054000090817     c                   endif
054100090817     c                   enddo
054200090817
054300090817      *********
054400090817      * error - missing bonus draw
054500090817     c                   if        foundbd <> 'Y'
054600090817     c                   if        firste <> 'Y'
054700090819     c                   except    head2
054800090817     c                   move      'Y'           firste            1
054900090817     c                   end
055000090819     c   of              except    head2
055100090819     c                   except    error5
055200090817     c                   goto      #skpremcalc
055300090817     c                   end
055400090817
055500090817     c                   z-add     bdovra        workbdff
055600090817     c                   z-add     bdovpp        workbdpp
055700090817     c                   z-add     bdovpc        workbdpc
055800090817     c                   exsr      #calcbd
055900090817
056000090817     c                   end
056100090817
056200090817
056300090817     c     #skpremcalc   tag
056400090817
056500090817     c                   endsr
056600090817
056700090817      **********************************************
056800090817      * Calc Admin Fee
056900090817      **********************************************
057000090817     c     #calcaf       begsr
057100090817
057200090817     c                   clear                   wkpct
057300090817     c                   clear                   wkfee
057400161215     c                   clear                   wkfeemth
057500090817
057600090817     c                   select
057700090817      * flat fee per member
057800161215     c                   when      workafff <> 0 and bcmcnt <> 0
057900090817     c                   z-add     workafff      wkfee
058000161215     c                   eval      wkfeemth = '$'
058100090817     c                   clear                   bcfpct
058200090817      * % of prem
058300090817     c                   when      workafpp <> 0
058400161215     c                   eval      wkfeemth = '%'
058500090817     c     workafpp      div       100           wkpct
058600090820     c     wkpct         mult(h)   holdprem      wkfee
058700090817     c                   z-add     workafpp      bcfpct
058800090817      * % of com
058900090817     c                   when      workafpc <> 0
059000161215     c                   eval      wkfeemth = '%'
059100090817     c     workafpc      div       100           wkpct
059200090901     c     wkpct         mult(h)   wkcomtot      wkfee
059300090817     c                   z-add     workafpc      bcfpct
059400090817     c                   endsl
059500090817
059600161215      * set sign of fee to match mem cnt (bcmcnt will be +1,-1)
059700161215     c                   if        (bcmcnt < 0 and wkfee > 0) or
059800161215     c                             (bcmcnt > 0 and wkfee < 0)
059900090817     c                   mult      -1            wkfee
060000090817     c                   end
060100090817
060200090901     c                   z-add     wkfee         wkaftot
060300161215     c                   movel     wkfeemth      bcfmth
060400090817
060500090817     c                   endsr
060600090817
060700090817      **********************************************
060800090817      * Calc bonus draw
060900090817      **********************************************
061000090817     c     #calcbd       begsr
061100090817
061200090817     c                   clear                   wkbdchg
061300090817     c                   clear                   wkpct
061400161215     c                   clear                   wkbdmth
061500090817
061600090817      * flat fee
061700161215     c                   if        workbdff <> 0 and bcmcnt <> 0
061800161215     c                   eval      wkbdmth = '$'
061900090817     c                   z-add     workbdff      wkbdchg
062000090817     c                   z-add     0             bcdpct
062100090817     c                   else
062200090817      * % of prem
062300090817     c                   if        workbdpp <> 0
062400161215     c                   eval      wkbdmth = '%'
062500090817     c     workbdpp      div       100           wkpct
062600090820     c     wkpct         mult      holdprem      wkbdchg
062700090817     c                   z-add     workbdpp      bcdpct
062800090817     c                   else
062900090817
063000090817      * % of com = bonus draw % x admin fee
063100090817     c                   if        workbdpc <> 0
063200161215     c                   eval      wkbdmth = '%'
063300090817     c     workbdpc      div       100           wkpct
063400090817     c     wkpct         mult(H)   bcfchg        wkbdchg
063500090817     c                   z-add     workbdpc      bcdpct
063600090817     c                   endif
063700090817
063800090817     c                   endif
063900090817     c                   endif
064000090817
064100161215      * set sign of fee to match mem cnt (bcmcnt will be +1,-1)
064200161215     c                   if        (bcmcnt < 0 and wkbdchg > 0) or
064300161215     c                             (bcmcnt > 0 and wkbdchg < 0)
064400090817     c                   mult      -1            wkbdchg
064500090817     c                   end
064600090817
064700090819     c                   add       wkbdchg       wkbdtot
064800161215     c                   movel     wkbdmth       bcdmth
064900090817
065000090817     c                   endsr
065100090817
065200090817      *****************************************************
065300090817      * old commission schedule
065400090817      *****************************************************
065500090817     c     #oldcom       begsr
065600090817
0657000908180237 C* old comm method
065800090818     C                   move      'P'           bccmth
065900090827
066000090827      * GET SALESMAN MASTER FILE FOR STYPE IN CRATE SEARCH
0661000908270266 C     SLSMAN        CHAIN     SMAN
066200090827     c                   if        not %found(sman)
066300090827     c                   clear                   stype
066400090827     c                   end
066500090818
0666000908170237 C* get crate
0667000908170239 C*
0668000908170246 C                   SETOFF                                       51
066900090817     c                   move      ' '           crrec             1
0670000908170245 C     CRATKY        SETLL     CRAT13
0671000908170247 C                   dow       *in51 = *off
0672000908170248 C     CRATKY        READE     CRAT13                                 51
067300090817     C*
067400090818     C                   if        *in51 = *off and crdltd <> 'D' and effdat
067500090818     C                             >= frdate and effdat <= todate
0676000908170252 C                   move      'Y'           crrec
0677000908170252 C                   leave
0678000908170253 C                   END
067900090817     c                   enddo
068000090817
0681000908170256 C*
0682000908190256 C* if no crate print error and leave this subroutine
0683000908170256 C*
0684000908170257 C                   if        crrec = ' '
0685000908170261 C                   Z-ADD     1             X                 2 0
068600090817     C                   MOVE      effdat        @DATIN
068700090819     C                   EXSR      #DATYM
068800090817     C                   MOVE      @DATOU        effmdy            8 0
0689000908190267 C                   EXCEPT    ERROR4
069000090817     c                   move      0             effmdy
0691000908170268 C                   leavesr
069200090817     c                   end
069300090817
0694000908170273 C                   Z-ADD     effdat        DTETMP
0695000908170274  *
0696000908170275  *  CHECK DONE TO SEE IF WHEN THE PROCEDURE IS RUN THE COMMISSION
0697000908170276  *  PERIOD IS EXPIRED.
0698000908170277  *  IF THE COMMISSION PERIOD IN MONTHS IS GREATER THEN 0 ADD IT TO
0699000908170278  *  THE ENROLLMENT MONTH.  KEEP SUBTRACTING 12 AND ADDING ONE TO THE
0700000908170279  *  YEAR UNTIL THE MONTH IS LE 12 (TO MAKE A NORMAL DATE).
0701001409110280  *  THEN COMPARE THE NEW ENROLLMENT DATE AND idtrmd . IF ENROLLMENT DATE
0702001409110281  *  IS LATER THEN idtrmd  THE COMMISSION HAS EXPIRED.  ADD THE COMMISSION
0703000908170282  *  PERCENT TO GBS'S COMMISSION PERCENT AND ZERO OUT THE SALESMAN'S
0704000908170283  *  COMMISSION PERCENT TO BE UPDATED IN THE WORK FILE.
0705000908170284  *
0706000908170285 C     COMPRD        IFGT      0
0707000908170286 C                   ADD       COMPRD        CENRMM
0708000908170287 C     CENRMM        DOWGT     12
0709000908170288 C     CENRMM        SUB       12            CENRMM
0710000908170289 C                   ADD       1             CENRYY
0711000908170290 C                   END
0712000908170291 C                   Z-ADD     DTETMP        CYYMMD            8 0
0713001409110293 C     CYYMMD        IFLE      idtrmd
0714000908170294 C     COMTYP        IFEQ      'HPP'
0715000908170295 C                   ADD       COMRTE        CRPRTE
0716000908170296 C                   END
0717000908170297 C                   Z-ADD     0             COMRTE
0718000908170298 C                   END
0719000908170299 C                   END
0720000908170417  *
0721000908170429  * billed amount comes from field "IDTRAMB" in invdwk file,
0722000908170429  * "IDTRAM" is net
0723000908170417  *
072400090817     c                   move      idtramb       prem              7 2
072500090817     c                   move      idtram        netrte            7 2
0726000908170429  *
0727001812030429  * COBRA invoices: The billed amount (IDTRAMB) holds the rate plus
0728001812030429  * the 2% surcharge. The net (IDTRAM) holds the original rate without
0729001812030429  * the 2% added.
0730001812030429  * COBRA adjustments: billed should hold the rate + 2% and net will
0731001812030429  * hold either the same amount or rate less 2% and PSF.
0732001812030429  *
0733001812030429  * 12/3/18 If the billed = net then still get the billed less 2%,
0734001812030429  * otherwise still use the net rate (these should be PSF plans) which
0735001812030429  * is already in prem.
073600090817     C                   if        idcob = 'C' and prem <> 0
073700090817
0738001812030429  * cobra manual adj (CMA)
073900181203     c                   if        idrc  = 'CMA'
074000181203     c                   if        idtramb = idtram
074100090817     c     idtramb       div(h)    1.02          prem
074200090817     c                   move      prem          netrte
074300181203     c                   end
074400090817     c                   else
0745001812030429  * cobra invoices
074600090817     c                   move      idtram        prem
074700090817     c                   end
074800090817
074900090817     c                   end
0750000908170361
0751000908170364 C                   Z-ADD     *ZEROS        HOLD1
0752000908170365  *
0753000908170366  *    CALCULATE SALESMAN COMMISSION AOMUNT...........
0754000908170367  *
0755000908170368 C                   move      *ZEROS        SLSCOM            9 2
0756000908170369 C                   move      *ZEROS        CRPCOM            9 2
0757000908170370  *
0758000908170370  * flat fee only paid for current enrollment and retro activity
0759000908170370  * for add,term,rein.
0760000908170370  *
0761000908170371 C     COMTYP        IFEQ      'HFF'
076200090817
076300090817     c                   if        idtrcd = 'MCC' or idtrcd = 'MCA' or
076400140228     c                             idtrcd = 'MCB' or idtrcd = 'M10'
076500090817     c                   leavesr
076600090817     c                   end
076700090817
076800090817     c* positive prem = positive flat fee
076900090817     c* negative prem = negative flat fee
077000090817     c* zero prem     = zero     flat fee
077100090817
077200090817     c                   if        prem > 0
0773000908170372 C                   add       COMRTE        SLSCOM
0774000908170373 C                   else
077500090817     c                   if        prem < 0
0776000908170372 C                   sub       COMRTE        SLSCOM
0777000908170373 C                   end
0778000908170373 C                   end
077900090817
0780000908170373 C                   END
0781000908170374 C*
0782000908170375 C     COMTYP        IFEQ      'HPP'
0783000908170376 C     PREM          MULT(H)   COMRTE        HOLD1             9 2
0784000908170377 C     HOLD1         DIV(H)    100           HOLD1
0785000908170378 C                   Z-ADD     HOLD1         SLSCOM
0786000908170379 C                   END
0787000908170380 C*
0788000908170381 C     COMTYP        IFEQ      'HPL'
0789000908170382 C     PREM          SUB       NETRTE        LOAD              9 2
0790000908170383 C     LOAD          MULT(H)   COMRTE        HOLD1
0791000908170384 C     HOLD1         DIV(H)    100           HOLD1
0792000908170385 C                   Z-ADD     HOLD1         SLSCOM
0793000908170386 C                   END
0794000908170387 C*
0795000908170388 C*   CALCULATE CORPORATE COMMISSION AMOUNT.........
0796000908170389 C*    ** LOAD BALANCE **
0797000908170389 C*
0798000908170389 C*
0799000908170390 C     CRPTYP        IFEQ      'ILB'
0800000908170391 C     subkey        CHAIN     SUBMST                             55
0801000908170392 C     PREM          SUB       NETRTE        HOLD1
0802000908170393 C     PLNCAT        IFEQ      'PMM'
0803000908170394 C     HOLD1         SUB       COMFEE        HOLD1
0804000908170395 C                   END
0805000908170396 C     PLNCAT        IFEQ      'PMS'
0806000908170397 C     HOLD1         SUB       COMFEE        HOLD1
0807000908170398 C                   END
0808000908170399 C     HOLD1         SUB       SLSCOM        CRPCOM
0809000908170400 C                   END
0810000908170401 C*
0811000908170389 C*    ** % OF LOAD - CORPORATE **
0812000908170401 C*         "ILC" NOT PROCESSED IN PGM SO THE COMMISSION WILL BE 0
0813000908170401 C*
0814000908170389 C*   THIS TYPE WILL BE USED FOR SPLIT COMMISSIONS ONLY...SMAN TYPE
0815000908170389 C*   OF "CC" WILL HAVE "PL" IN CORP TYPE AND RATE IN CORP RATE
0816000908170389 C*   BUT WILL NOT HAVE ANYTHING IN SMAN RATE. THE SMAN WILL
0817000908170389 C*   HAVE IT'S OWN SEPERATE COMM RATE RECORD WITH SMAN RATE
0818000908170389 C*   FILLED IN AND CORP TYPE "LC" AND 0 RATE
081900090817     C*
082000090817     C*  8/20/97 : CHANGE TO ALLOW SMAN TYPE OF "PP" AND CORP TYPE
082100090817     C*            OF "LC" (ONLY CHANGE WAS TO FM160 TO ALLOW INPUT)
082200090817     C*
082300090817     C*    * IMPORTANT FOR THE USERS TO REMEMBER : ALL % MUST ADD UP
082400090817     C*      TO 100
082500090817     C*
0826000908170389 C*      EXAMPLE:
0827000908170389 C*   SMAN  COMM   COMM    CORP   CORP
0828000908170389 C*   TYPE  RATE   TYPE    RATE   TYPE
0829000908170389 C*   ----  -----  ----    -----  -----
0830000908170389 C*   AC    39.66    PL     0.00    LC
0831000908170389 C*   CC     0.00          33.34    PL
0832000908170389 C*   OB    27.00    PL     0.00    LC
0833000908170389 C*
0834000908170389 C*
0835000908170389 C*
0836000908170390 C     CRPTYP        IFEQ      'IPL'
0837000908170382 C     PREM          SUB       NETRTE        LOAD              9 2
0838000908170401 C*
0839000908170401 C* "LOAD" IS THE LOAD...CORP COMM IS % OF LOAD
0840000908170401 C*
0841000908170383 C     LOAD          MULT(H)   CRPRTE        HOLD1
0842000908170384 C     HOLD1         DIV(H)    100           HOLD1
0843000908170385 C                   Z-ADD     HOLD1         CRPCOM
0844000908170400 C                   END
0845000908170401 C*
0846000908170401 C*
0847000908170402 C     CRPTYP        IFEQ      'IPP'
0848000908170403 C     PREM          MULT(H)   CRPRTE        HOLD1
0849000908170404 C     HOLD1         DIV(H)    100           HOLD1
0850000908170405 C                   Z-ADD     HOLD1         CRPCOM
0851000908170406 C                   END
0852000908170407 C*
0853000908170370 C*
0854000908170370 C*
0855000908170370 C* flat fee only paid for current enrollment and retro activity
0856000908170370 C* for add,term,rein.
0857000908170370 C*
0858000908170402 C                   IF        crptyp = 'IFF'
085900090817     c                   clear                   crpcom
086000090817     c                   if        idtrcd <> 'MCC' and idtrcd <> 'MCA'
086100090817     c                             and idtrcd <> 'MCB'
086200140228     c                             and idtrcd <> 'M10'
086300090817     c                   if        prem > 0
0864000908170372 C                   z-add     CRPRTE        CRPCOM
086500090817     c                   else
086600090817     c                   if        prem < 0
0867000908170372 C                   z-sub     CRPRTE        CRPCOM
0868000908170373 C                   end
0869000908170373 C                   end
087000090817     c                   end
087100090817     c                   end
087200090817
087300090817     c                   endsr
087400090901
0875000909010069 C**************************************************************
0876000909010069 C* calc admin fee and bonus draw for old comm carriers
0877000909010069 C**************************************************************
087800090901     c     #oldafbd      begsr
087900090901
088000090901      ********
088100090901      * code from cr130
088200090901      ********
088300090901
088400090901      * values from carrier master
088500090901     C                   z-add     cbonpX        bonp
088600090901     C                   z-add     cafpX         afp
088700090901     C                   z-add     ccompX        comp
088800090901
088900090901      * plan level overrides
089000090901     c* 999.99 = override to 0 %
089100090901    2c                   if        pbonp <> 0 and pbonp <> 999.99
089200090901     c                   eval      bonp  = pbonp
089300090901    2c                   end
089400090901    2c                   if        pbonp = 999.99
089500090901     c                   eval      bonp  = *zeros
089600090901    2c                   end
089700090901
089800090901    2c                   if        pafp <> 0 and pafp <> 999.99
089900090901     c                   eval      afp  = pafp
090000090901    2c                   end
090100090901    2c                   if        pafp = 999.99
090200090901     c                   eval      afp  = *zeros
090300090901    2c                   end
090400090901
090500090901    2c                   if        pcomp <> 0 and pcomp <> 999.99
090600090901     c                   eval      comp  = pcomp
090700090901    2c                   end
090800090901    2c                   if        pcomp = 999.99
090900090901     c                   eval      comp  = *zeros
091000090901    2c                   end
091100090901    ***
091200090901     C     COMP          DIV       100           CPCT              5 4
091300090901     C     AFP           DIV       100           APCT              5 4
091400090901     C     BONP          DIV       100           BPCT              5 4
091500090901     C     idtram        MULT      CPCT          COMEX             9 2
091600090901     C     idtram        MULT      APCT          ADMEX             9 2
091700090901     C     idtram        MULT      BPCT          BONDR             9 2
091800090901
091900090901      * accumulate commission
092000090901      * comm override was used
092100090901     c                   if        cpct <> 0
092200090901     c                   add       comex         wkcomtot
092300090901     c                   z-add     cpct          bccpct
092400090901     c                   else
092500090901      * comm override was not used
092600090901     c                   add       slscom        wkcomtot
092700090901     c                   z-add     comrte        bccpct
092800090901     c                   end
092900090901
093000090901     c                   z-add     admex         wkaftot
093100090901     c                   z-add     apct          bcfpct
093200090901
093300090901     c                   z-add     bondr         wkbdtot
093400090901     c                   z-add     bpct          bcdpct
093500090901
093600090901     c                   endsr
093700090901
0938000908140069 C**************************************************************
0939000908140069 C* get member count
0940001612150069 C*   **********************************************************
0941001612150069 C*   **** ANY changes to this member count logic must also be *
0942001612150069 C*   *    made in DW040. ***                                  *
0943001612150069 C*   **********************************************************
0944001612150069 C**************************************************************
094500161215       begsr #mcnt;
0946001612150408  *
0947001612150408  * calculate member count for this record (0,1,-1)
0948001612150408  * -change transactions are 0 (MCC,MCA,MCB,M10,M51,M41)
0949001612150408  * -midmonth records are 0 except invoices and adds
0950001612150408  * -smoke rate transactions are 0 (MSM,MSK)
0951001612150408  *
0952001612150408  * all others: +1 for positive amount paid and -1 for negative amt paid
0953001612150408  *
095400161215       clear bcmcnt;   // net member cnt
095500161215       clear bcBmcnt;  // billed member cnt
095600161215       clear bcAmcnt;  // adjustment member cnt
095700161215       clear bcdcnt;   // net depend cnt
095800161215       clear bcBdcnt;  // billed depend cnt
095900161215       clear bcAdcnt;  // adjustment depend cnt
096000161215       clear wkcnt;    // work count
096100161215
0962001612150408  * skip all transactions that do not affect the count
096300161215
096400161215       if idtram = 0 or
096500161215          (idtrmdday <> 01 and idrc2 <> 'CE' and
096600161215           idtrcd <> 'MAC' and idtrcd <> 'MDA') or
096700161215          idtrcd = 'MCC' or idtrcd = 'MCA' or idtrcd = 'MCB' or
096800161215          idtrcd = 'M10' or idtrcd = 'MSM' or idtrcd = 'MSK' or
096900161215          idtrcd = 'M41' or idtrcd = 'M51';
097000161215        leavesr;
097100161215       endif;
097200161215
0973001612150408  * set +1 or -1 count for this transaction (zero paid transactions
0974001612150408  * have already been skipped above)
097500161215
097600161215       if idtram > 0;
097700161215        wkcnt = 1;
097800161215       else;
097900161215        wkcnt = -1;
098000161215       endif;
098100161215
0982001612150408  * member transaction
098300161215       if idseq = 0;
098400161215        bcmcnt = wkcnt;
0985001612150408  * count this as an invoice or adj ?
098600161215        if idrc2 = 'CE';
098700161215          bcBmcnt = wkcnt;  // billed / invoice rec
098800161215        else;
098900161215          bcAmcnt = wkcnt;  // adjustment rec
099000161215        endif;
099100161215
0992001612150408  * dependent transaction
099300161215       else;
099400161215        bcdcnt = wkcnt;
0995001612150408  * count this as an invoice or adj ?
099600161215        if idrc2 = 'CE';
099700161215          bcBdcnt = wkcnt;  // billed / invoice rec
099800161215        else;
099900161215          bcAdcnt = wkcnt;  // adjustment rec
100000161215        endif;
100100161215       endif;
100200161215
100300161215       endsr;
100400161215
1005001612150069 C**************************************************************
1006001612150069 C* get market size
1007001612150069 C**************************************************************
100800161215     c     #mksz         begsr
100900010212     c* get market size - defalut to 50 for comm sched 2 and default to
101000010212     c* 1 for comm sched 1, also fill method with "P" for sched 1
101100010212
101200161215     c                   clear                   bcmksz
101300161215     c                   clear                   bccmth
101400161215
101500010212     c                   if        comsch = '2'
101600010212     c                   movel     '50   '       bcmksz
101700010212     c                   else
101800010212     c                   movel     '1    '       bcmksz
101900010212     c                   move      'P'           bccmth
102000010212     c                   end
102100010212
102200010212     c                   eval      *in67 = *off
102300010212     c     mkcaky        setll     mktcara1
102400010212     C                   dow       *in67 = *off
102500010212     c     mkcaky        reade     mktcara1                               67
1026000102120133 C   67              leave
102700140911     c                   if        idtrmd < mafrdt or (matodt <> 0 and
102800140911     c                             idtrmd > matodt) or (mafrdt = matodt)
102900010212     c                   iter
103000010212     c                   endif
103100010212     c                   movel     maszcd        bcmksz
103200010212     c                   enddo
103300010212
103400010203     c                   endsr
103500021016
1036000210160069 C**************************************************************
1037000210160069 C* first time                                                 *
1038000210160069 C**************************************************************
103900021016     c     *inzsr        begsr
104000021016     C                   TIME                    HTIME             6 0
104100021016     C*
104200090828     C*                  MOVE      *DATE         @DATIN
104300090828     C*                  EXSR      #DATMY
104400090828     C*                  MOVE      @DATOU        UYMD              8 0
1045000210160111 C*
104600021016     C                   MOVE      LEFFDT        @DATIN
104700021016     C                   EXSR      #DATMY
104800090827     C                   MOVE      @DATOU        LEFMDY            8 0
104900030805
105000021017     C                   EXCEPT    HEAD2
105100021017
105200021016     C     ACKEY         KLIST
105300021016     C                   KFLD                    IDTRST
105400021016     C                   KFLD                    IDSUBD
105500021016     C                   KFLD                    IDACCT
105600021016
105700090819     c     subkey        klist
105800090819     c                   kfld                    idtrst
105900090819     c                   kfld                    idsubd
106000090819
106100090819     c     cratky        klist
106200090819     c                   kfld                    cmtrst
106300090819     c                   kfld                    csubdv
106400090819     c                   kfld                    cmplan
106500090819     c                   kfld                    stype
106600090819
106700021016     c     mkcaky        klist
106800021016     c                   kfld                    idtrst
106900021016     c                   kfld                    idsubd
107000021016     c                   kfld                    idacct
107100021016     c                   kfld                    idcar
107200021017
107300030409     c     cmkey         klist
107400030409     c                   kfld                    idtrst
107500030409     c                   kfld                    idsubd
107600030409     c                   kfld                    idacct
107700030409     c                   kfld                    idplan
107800090514
107900090514     c     plnkey        klist
108000090514     c                   kfld                    idtrst
108100090514     c                   kfld                    idsubd
108200090514     c                   kfld                    idplan
108300090817
108400090817     c     brcmky        klist
108500090817     c                   kfld                    idcar
108600090817     c                   kfld                    bcmksz
108700090817
108800090819     C     AFKEY         KLIST
108900090819     C                   KFLD                    idcar
109000090819     C                   KFLD                    bcmksz
109100090819
109200090819     c     abkey         klist
109300090819     c                   kfld                    idtrst
109400090819     c                   kfld                    idsubd
109500090819     c                   kfld                    idacct
109600090819     c                   kfld                    idcar
109700090819     c                   kfld                    plncat
109800030409
109900021016     c                   endsr
110000980817     C*
1101009808170103 C***************************************************
1102009808170104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
1103009808170105 C***************************************************
1104009808170107 C*
1105009808170107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
1106009808170107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
1107009808170107 C*
1108009808170106 C     #DATMY        BEGSR
110900980817     C                   MOVEL     @DATIN        @MD               4 0
111000980817     C                   MOVE      @DATIN        @Y                4 0
111100980817     C                   MOVE      @MD           @DATOU            8 0
111200980817     C                   MOVEL     @Y            @DATOU
111300980817     C                   MOVE      *ZEROS        @DATIN            8 0
1114009808170120 C                   ENDSR
1115000908190103  ***************************************************
1116000908190104  * CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
1117000908190105  ***************************************************
1118000908190107  *
1119000908190107  * DATE IN  = @DATIN (8.0) YYYYMMDD
1120000908190107  * DATE OUT = @DATOU (8.0) MMDDYYYY
1121000908190107  *
1122000908190106 C     #DATYM        BEGSR
112300090819     C                   MOVE      @DATIN        @MD               4 0
112400090819     C                   MOVEL     @DATIN        @Y                4 0
112500090819     C                   MOVEL     @MD           @DATOU            8 0
112600090819     C                   MOVE      @Y            @DATOU
112700090819     C                   MOVE      *ZEROS        @DATIN            8 0
1128000908190120 C                   ENDSR
1129000908190107 C*
113000020322
1131000210170237 Oqsysprt   E            head2          2 03
1132000210170239 O                                           73 '** GROUP BENEFIT SERVICE'
1133000210170241 O                                           77 'S **'
1134000210170242 O          E            head2          1
1135000908190244 O                                           78 'NON-PAY ERROR REPORT'
1136000210170242 O          E            head2          1
113700021017 244 O                                           65 'FOR :'
113800090827 244 O                       LEFMDY              76 '  /  /    '
1139000210170242 O          E            head2          1
1140000908140248 O                                           25 'PROGRAM NAME: RPA401'
1141000210170249 O                                          122 'PAGE :'
1142000210170250 O                       PAGE2         Z    131
1143000210170242 O          E            head2          1
1144000210170253 O                                           14 'RUN DATE:'
1145000210170254 O                       UDATE         Y     25
1146000210170255 O                                          122 'TIME :'
1147000210170256 O                       HTIME              131 '  :  :  '
1148000210170242 O          E            head2          1
1149000210170259 O                                           24 '------------------------'
1150000210170260 O                                           48 '------------------------'
1151000210170261 O                                           72 '------------------------'
1152000210170262 O                                           96 '------------------------'
1153000210170263 O                                          120 '------------------------'
1154000210170286 O                                          132 '------------'
1155000210170242 O          E            head2          1
1156000210170267 O                                            9 'ACCOUNT #'
1157000210170268 O                                          104 'ERROR'
1158000210170242 O          E            head2          2
1159000210170259 O                                           24 '------------------------'
1160000210170260 O                                           48 '------------------------'
1161000210170261 O                                           72 '------------------------'
1162000210170262 O                                           96 '------------------------'
1163000210170263 O                                          120 '------------------------'
1164000210170286 O                                          132 '------------'
1165000908190287 O          E            ERROR1         1
1166000210170288 O                       IDTRST               3
1167000210170288 O                                            4 '-'
1168000210170288 O                       IDSUBD               7
1169000210170288 O                                            8 '-'
1170000210170288 O                       IDACCT              12
1171000210170288 O                       IDPLAN              19
1172000908190125 O                       idcar               31
1173000908190138 O                       bcmksz              43
1174001409110288 O                       idtrmd              69 '    /  /  '
1175000210170288 O                       IDSS#               83
1176000908190288 O                                          125 'NO ADMIN FEE SET UP       '
1177000210170287 O          E            ERROR2         1
1178000210170288 O                       IDTRST               3
1179000210170288 O                                            4 '-'
1180000210170288 O                       IDSUBD               7
1181000210170288 O                                            8 '-'
1182000210170288 O                       IDACCT              12
1183000210170288 O                                          125 'NO ACCOUNT MASTER         '
1184000909010287 O          E            ERROR3         1
1185000909010288 O                       IDTRST               3
1186000909010288 O                                            4 '-'
1187000909010288 O                       IDSUBD               7
1188000909010288 O                                            8 '-'
1189000909010288 O                       IDACCT              12
1190000909010288 O                       IDcar               18
1191000909010288 O                                          125 'NO CARRIER MASTER         '
1192000908190287 O          E            ERROR4         1
1193000908190288 O                       IDTRST               3
1194000908190288 O                                            4 '-'
1195000908190288 O                       IDSUBD               7
1196000908190288 O                                            8 '-'
1197000908190288 O                       IDACCT              12
1198000908190288 O                       IDPLAN              19
1199001409110288 O                       idtrmd              69 '    /  /  '
1200000908190523 O                       Stype               82
1201000908190523 O                       effmdy        y     95
1202000908190288 O                                          125 'NO COMMISSION RATE(CRATE) '
1203000908190287 O          E            ERROR5         1
1204000908190288 O                       IDTRST               3
1205000908190288 O                                            4 '-'
1206000908190288 O                       IDSUBD               7
1207000908190288 O                                            8 '-'
1208000908190288 O                       IDACCT              12
1209000908190288 O                       IDPLAN              19
1210001409110288 O                       idtrmd              33 '    /  /  '
1211000908190523 O                       idcar               39
1212000908190523 O                       bcmksz              47
1213000908190523 O                       effmdy        y     95
1214000908190288 O                                          125 'NO BONUS DRAW SET UP      '
