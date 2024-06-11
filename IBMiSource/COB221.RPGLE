000100140611     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
0002000108140002  *---------------------------------------------------------------**
0003000108140003  * COB221     GROUP BENEFIT SERVICES SOFTWARE                     *
0004000108140005  *            WRITTEN BY - M.L.F.                                 *
0005000108140006  *            DATE - 09/98                                        *
0006000108140008  *  DESCRIPTION - THIS PROGRAMS CALCULATES RATES AND UPDATES      *
0007000108140009  *                HISTORY FILE.                                   *
000800010821      * DLW 12.98 CHANGE HIST TO NEW FORMAT AND USE 8 BYTE DATES.      *
000900010821      *           Y2K COMPLIANT.                                       *
001000010821      * DLK 06/09/00 fix name length                                   *
0011000108140017  * DLK 03/19/01 - convert "UHM" trcode to unique code per letter  *
0012000108210017  * KSJ 08/21/01 - ADDED FOR MENTAL HEALTH PLANS TO BE USED BY     *
0013000108210017  *                MAGELLAN.  ADDED COBRA PLANS CROSS-REF FILE     *
0014000407260017  * DLK 07/26/04 - remove mental health, add rx                    *
0015000409210017  * DLK 09/21/04 - remove sf code, convert to use plan cat type,   *
0016000409210017  *                first mariner special                          *
0017000410280017  * DLK 10/28/04 - add cobra lite letter codes                     *
0018000501060017  * DLK 01/06/05 - GBS will use first mariner special also         *
0019000501110017  * DLK 01/11/05 - Correct rate search to use effdt of cancel      *
0020000501110017  *                instead of udate. Also add 2nd rate search      *
0021000501110017  *                to match tr172.                                 *
0022000505050017  * SZZ 05/02/05 - Get the premiums for the Benegap plans.         *
0023000706130017  * DLK 06/13/07 - EU  special : same as 1st Mariner but for       *
002400070613      *                Dental plan instead                             *
002500070613      *                also remove gbs special for rx plan             *
0026000707230017  * DLK 07/23/07 - remove 1st Mariner special for rx plan          *
0027000710050017  * DLK 10/04/07 - convert rate calc to use external pgm           *
0028000808260017  * DLK 08/26/08 - Benegap special - if carrier = MBF then use net *
002900080826      *                rate instead of the billed rate                 *
003000081107      * DLK 11/07/08 - Goodwill special : get rx plan rate             *
003100081107      *                from sub 999 since it is 0 (member does not pay *
003200081107      *                for rx while they are employed just like 1st    *
003300081107      *                Mariner did)                                    *
003400090402      * DLK 04/01/09 - add subsidy addendum (4 pages) to all letters   *
003500090402      *                and add text to hist rec showing addendum. also *
003600090402      *                add dep seq# to hist rec.                       *
003700090508      * DLK 05/08/09 - The ACI Group special: get dental plan rate     *
003800090508      *                from sub 999                                    *
0039000912140017  * DLK 12/14/09 - BPI special - if carrier = NAB then use net     *
004000091214      *                rate instead of the billed rate                 *
004100091223      * DLK 12/23/09 - GBS special: get medical rate from sub 999      *
004200091223      *                This will be the billed rate less the 5% broker *
004300091223      *                commission since GBS wants to charge cobra      *
004400091223      *                members the rate less the normal commission.    *
004500091223      *                The 2% cobra commission will still be added     *
004600091223      *                by this program.                                *
004700100427      * DLK 02/16/10 - change subsidy addendum text pages 1-3          *
004800100429      * DLK 04/27/10 - change subsidy addendum text pages 1-3 for      *
004900100429      *                latest extension and history note.              *
005000100429      * DLK 04/29/10 - change addendum text in history note for new    *
005100100429      *                letters going forward                           *
005200100713      * DLK 07/13/10 - change subsidy addendum and history note to     *
005300100713      *                only show if term date is <= 6/1/10             *
005400100929      * DLK 09/29/10 - add return by date in hist rec in receive date
005500100929      *                field                                           *
0056001011190017  * DLK 11/19/10 - GBS special - if carrier = GBH then use net     *
005700101119      *                rate instead of the billed rate                 *
0058001012210017  * DLK 12/21/10 - Remove the GBS special that got the medical
005900101221      *                rate from sub 999.                              *
0060001104140011  * DLK 04/14/11 - add letter history file.
0061001206040017  * DLK 06/04/12 - remove EU special for dental plan sub 999 rate search
0062001206130017  * DLK 06/13/12 - remove ACI special for dental plan sub 999 rate search
0063001208010017  * DLK 08/01/12 - add status field to clethst file                     h
0064001210150017  * DLK 10/15/12 - add code for hra bundling plan                       h
006500131011      * dlk 10/11/13 - hist file expansion project
006600140117      * dlk 01/17/14 - move dep# to end of note 1
006700140207      * JVA 02/07/14 - Check ACA Plan, use full rate
0068001703240017  * DLK 03/24/17 - remove GOODWILL special for RX plan sub 999
0069001703240017  *                rate search
0070001809240017  * DLK 08/24/18 - add EAP plan
0071001912170017  * DLK 12/17/19 - use generic "Medical" description for medical plan
007200191217      *                instead of actual plan description to avoid wrong
007300191217      *                description when more than 1 med plan cat type
007400191217      *                is used for the premium such as the BSF plan.
0075002104290017  * DLK 04/29/21 - Remove ARRA subsidy addendum from 2009
007600191217      *                                                                *
0077000108140013  *---------------------------------------------------------------**
007800010815     FCOB220WK  UP   E           K DISK
007900980911     FCONTRL    IF   E           K DISK
008000080826JGE01FPLNMST    IF   e           k DISK
008100110414JGE01Fmember    IF   e           k DISK    prefix(m_)
008200110414     FDEPNDC    IF   E           K DISK    prefix(d_)
008300110414     Fcodesl1   IF   E           K DISK
008400120404JGE01Faacode    IF   e           k DISK
008500120404     FCOBRAAA   IF   E           K DISK
0086001310110028 FHIST      O  A F  216        DISK
008700110414     Fclethst   o  a E           K DISK
0088000501060019 Fcob221p   O    F  132        PRINTER OFLIND(*INOF)
008900010814
0090000501110037 D isodate         S               d   datfmt(*iso)
0091000710040037 D workdt          S               d   datfmt(*iso)
0092001009290037 D dat2wkdt        S               d   datfmt(*iso)
009300040921     D gbspct          S                   like(fedp)
009400070723     D****firstmariner    S             10  0 inz(5901070001)
009500091223     D gbsaccount#     S             10  0 inz(5500010016)
009600120604     D****euaccount#      S             10  0 inz(5900010013)
009700170324     D****gwaccount#      S             10  0 inz(5900070010)
009800120613     D****acaccount#      S             10  0 inz(5910020272)
009900071004     D premwk          S                   like(mpre)
010000041028     D trcodeout       S              3
010100071004     D dcand2          S              8  0
010200210429     D*addentxt        C                   CONST('W/ARRA ADDENDUM 5/31/10 +
010300210429     D*                                          ')
010400090402     D ck#not          S             30
010500120405     D wkbgdesc        S             50    inz
010600120405     D                                     ('HRA FUNDING/CLAIMS PROCESSING FEE')
010700100713      *******
010800100713      * end date for subsidy addendum
010900210429     D*addenenddat     S              8  0 inz(20100601)
011000100713      *******
011100120404     D PO              S             42    DIM(2) CTDATA PERRCD(1)
011200120404     D pdescrhold      S                   like(pdescr)
011300120404     D wkadden         S                   like(cladden1)
011400120404     D wkadden1        S                   like(cladden1)
011500120404     D wkadden2        S                   like(cladden2)
011600120404     D wkadden3        S                   like(cladden3)
0117001310110037 D sysdateymd      S               d   datfmt(*iso)
0118001310110037 D systime         S               t
011900131011     D thispgmname     S             10a   inz('COB221    ')
012000140207
0121001402070125 D YES             S               N   INZ(*ON)
0122001402070125 D NO              S               N   INZ(*OFF)
0123001402070125 D AM_I_ACA        S               N   INZ(*OFF)
012400140207     D @1              S              1A   INZ
012500140207
012600140207   X***X
012700140207      /DEFINE CHK_ACA_PLAN_PR
012800140207      /DEFINE CHK_ACA_PLAN_FIELDS
012900140611      /COPY QCPYSRC,ACASRVPGMP
013000140207      /UNDEFINE CHK_ACA_PLAN_PR
013100140207      /UNDEFINE CHK_ACA_PLAN_FIELDS
013200140207   X***X
013300140207
013400040921     D                 DS
013500040921     D  memtsa                 1     10  0
013600040921     D  trust                  1      3  0
013700040921     D  sub                    4      6  0
013800040921     D  acct                   7     10  0
0139000710040152 D                 DS
0140000710040152 D  tspabct                1     15
0141000710040154 D  ktrust                 1      3  0
0142000710040154 D  ksub                   4      6  0
0143000710040154 D  kplan                  7     10
0144000710040154 D  kageb                 11     12  0
0145000710040154 D  kcovtp                13     15
014600980914     D                UDS
014700131011     D  luser                 25     34
0148000409210054 D  CONAME               201    240
0149000409210055 D  TIME                 242    247  0
015000100929JGE01D  LD8YMD               248    255  0
015100010814
015200040921     C                   IF        Flag   = 'F'
015300040921     c                   eval      gbspct = fedp
015400040921     c                   else
015500040921     c                   eval      gbspct = stap
015600040921     C                   END
015700010814
015800040921     c                   clear                   mpre
015900040921     c                   clear                   dpre
016000040921     c                   clear                   vpre
016100040921     c                   clear                   rpre
016200120405     c                   clear                   bgpre
016300180924     c                   clear                   eappre
016400120404     c                   clear                   mplandsc
016500120404     c                   clear                   dplandsc
016600120404     c                   clear                   vplandsc
016700120404     c                   clear                   rplandsc
016800120405     c                   clear                   bgplandsc
016900180924     c                   clear                   eapplandsc
017000040921     c                   clear                   rx
017100070613     c                   clear                   dn
017200091223     c                   clear                   md
017300120404      * what addendums are printed with this letter? used in letter hist
017400120404      * file
017500120404     c                   clear                   wkadden1
017600120404     c                   clear                   wkadden2
017700120404     c                   clear                   wkadden3
017800120404
017900040921
018000120404      * rx plan
018100120404     c                   if        rplan <> *blanks
018200120404     C                   MOVE      rplan         XPLAN
018300120404     C                   MOVE      'Y'           rx                1
018400120404     C                   exsr      #getprem
018500120404     C                   movel     pdescrhold    rplandsc
018600120404     C                   clear                   rx
018700120404     C                   EVAL      rpre = premwk
018800120404     c                   end
018900120404
019000120404      * medical
019100191217      * 12/17/19 - use generic "Medical" description instead of the actual
019200191217      *            plan desc to avoid the wrong plan desc showing when
019300191217      *            more than 1 med plan cat type is included.
019400040921     c                   if        mplan <> *blanks
019500040921     C                   MOVE      MPLAN         XPLAN             4
019600091223     C                   MOVE      'Y'           md                1
019700040921     C                   exsr      #getprem
019800091223     C                   clear                   md
019900121015     c                   eval(h)   mpre = mpre + premwk
020000191217     C***************    movel     pdescrhold    mplandsc
020100191217     C                   movel     'MEDICAL'     mplandsc
020200120404      * include rx with med
020300120404     C                   if        rpre <> 0
020400120404     c                   eval(h)   mpre = mpre + rpre
020500120404     c                   cat       'w/RX':1      mplandsc
020600120404     c                   end
020700040921     c                   end
020800121015
020900121015      * medical2 - hra bundling plan with P1P as the plan category.
021000121015      *            add to the medical plan premium but do not show the
021100121015      *            plan description.
021200121015     c                   if        mplan2 <> *blanks
021300121015     C                   MOVE      MPLAN2        XPLAN             4
021400121015     C                   exsr      #getprem
021500121015     c                   eval(h)   mpre = mpre + premwk
021600121015     c                   end
021700050502
021800120405    ? * Benegap Funding Fee
021900120405    ? * Benegap Claims Processing Fee                                  *
022000120405    ? * 11/28/11 - stop showing benegap prem for all accts
022100120405      * 11/28/11 - only show plans for federal accts
022200120405     C                   If        BNPLAN <> *Blanks or bgplan <> *blanks
022300120405     C                   Eval      BGPRE = 0
022400120405     c                   if        flag = 'f'
022500120405     C                   movel     wkbgdesc      bgplandsc
022600120405     C                   end
022700120405     C                   End
022800040921
022900120404    ? * dental plan
023000040921     c                   if        dplan <> *blanks
023100010814     C                   MOVE      DPLAN         XPLAN
023200070613     C                   MOVE      'Y'           dn                1
023300040921     C                   exsr      #getprem
023400120404     C                   movel     pdescrhold    dplandsc
023500070613     C                   clear                   dn
023600071004     C                   EVAL      dpre = premwk
023700040921     c                   end
023800010814
023900120404    ? * vision plan
024000040921     c                   if        vplan <> *blanks
024100010814     C                   MOVE      VPLAN         XPLAN
024200040921     C                   exsr      #getprem
024300120404     C                   movel     pdescrhold    vplandsc
024400071004     C                   EVAL      vpre = premwk
024500040921     c                   end
024600120404
024700180924    ? * EAP plan
024800180924     c                   if        eapplan <> *blanks
024900180924     C                   MOVE      eapPLAN       XPLAN
025000180924     C                   exsr      #getprem
025100180924     C                   movel     pdescrhold    eapplandsc
025200180924     C                   EVAL      eappre = premwk
025300180924     c                   end
025400180924
025500120404      * get other fields needed in clethst & cob220wk
025600120404
025700120404     c                   eval      aaname = *blanks
025800120404     c     TRUST         Chain     COBRAAA
025900120404     c                   if        %found(COBRAAA)
026000120404     c     CACODE        chain     AACODE
026100120404     c                   if        %found(AACODE)
026200120405     C                   movel     afnam         aaname           30
026300120405     c                   if        aaname <> *blanks
026400120405     c                   cat       alnam:1       aaname
026500120405     c                   else
026600120405     c                   movel     alnam         aaname
026700120405     c                   end
026800120404     c                   endif
026900120404     c                   endif
027000120404
027100120405     C                   MOVEl     PO(1)         returnadr
027200120404
027300120404      * print subsidy addendum if term date is <= addendum end date
027400210429      * 04/29/21 - remove old subsidy addendum
027500210429     c**                 clear                   ck#not
027600210429     c**                 if        dcand <> 0 and
027700210429     c**                           dcand <= addenenddat
027800210429     c**                 eval      ck#not = addentxt
027900210429     c**                 movel     'SUBSIDY   '  wkadden
028000210429     c**                 exsr      #storadd
028100210429     c**                 end
028200120404
028300120404      * benegap addendum
028400120404      * only for federal accts
028500120404     c                   if        (bgplan <> *blanks or bnplan <> *blanks)
028600120404     c                             and flag = 'F'
028700120404     c                   movel     'BENEGAP   '  wkadden
028800210429     c                   exsr      #storadd
028900120404     c                   end
029000120404
029100120404      * fill addendum fields in work file
029200120404
029300120405     c                   movel     wkadden1      wADDEN1
029400120405     c                   movel     wkadden2      wADDEN2
029500120405     c                   movel     wkadden3      wADDEN3
029600120405
029700120405      * calculate 45 or 60 days for return date
029800120405     c                   clear                   returndt
029900120405     c                   exsr      #adday
030000120405     c                   move      newymd        returndt
030100120404
030200120404      * write work file
030300980911     C                   UPDATE    COBWRK
030400000609     c                   movel     name          nameo            30
030500041028
030600041028      * full serv or letter only
030700041028     c                   if        cserv = 'F'
030800041028     c                   eval      trcodeout = 'U19'
030900041028     c                   else
031000041028     c                   eval      trcodeout = 'U40'
031100041028     c                   end
031200100929
031300140117      * put dep # in right side of ck#not field
031400140117     c                   movel     'D#-'         d#note            5
031500140117     c                   move      depseq        d#note
031600140117     c                   move      d#note        ck#not
031700140117
031800131011     C                   eval      sysdateymd = %date
031900131011     C                   MOVE      sysdateymd    ld8ymd
032000131011     c                   eval      systime = %time
032100980911     C                   EXCEPT    ADDHIS
032200110414     C                   exsr      #clethst
032300090402     c                   clear                   ck#not
032400010814
032500100929      ****************************************************************
032600100929      * THIS ROUTINE ADDS 45 DAYS FOR STATE, AND 60 DAYS FOR FEDERAL *
032700100929      * TO EITHER 'UDATE,' OR TERMINATION DATE WHICHEVER IS LATER.   *
032800100929      ****************************************************************
0329001009290294 C     #ADDAY        BEGSR
033000100929     C                   IF        LD8YMD <= dcand
033100100929     C                   MOVE      dcand         dat2wkdt
033200100929     C                   else
033300100929     C                   MOVE      *DATE         dat2wkdt
033400100929     C                   END
033500100929
033600100929      *   ADD 45 OR 60 DAYS. FED/COB = 60, STATE = 45
033700100929
033800100929     C                   IF        Flag = 'S'
033900100929     c                   adddur    45:*d         dat2wkdt
034000100929     C                   ELSE
034100100929     c                   adddur    60:*d         dat2wkdt
034200100929     C                   END
034300100929
034400100929     C                   MOVE      dat2wkdt      newymd            8 0
0345001009290340 C                   ENDSR
034600010814      *****************************************************************
034700010814      * REARRANGE DATE FROM MMDDCCYY TO CCYYMMDD
034800010814      *****************************************************************
034900981217     C     #MDCY8        BEGSR
035000981217     C                   MOVEL     MDCY#         MMDD#             4
035100981217     C                   MOVE      MDCY#         CCYY#             4
035200981217     C                   MOVE      MMDD#         CYMD#             8
035300981217     C                   MOVEL     CCYY#         CYMD#
035400981217     C                   ENDSR
035500040921
035600040921      *****************************************************************
035700040921      * get premium
035800040921      *****************************************************************
035900040921     C     #getprem      BEGSR
036000040921
036100040921     C                   eval      ktrust = trust
036200040921     C                   eval      ksub   = sub
036300040921     C                   eval      kplan  = xplan
036400040921     C                   eval      kageb  = ab
036500040921     C                   eval      kcovtp = type
036600040921
036700070613      * EU special - get dental rate from sub 999
036800120604      * 6/4/12 - remove this special
036900120604     c*                  if        (memtsa = euaccount# and
037000120604     c*                            dn = 'Y')
037100120604     c*                  eval      ksub   = 999
037200120604     c*                  end
037300081107
037400081107      * Goodwill special - get RX rate from sub 999
037500170324      * removed 03/24/17
037600170324     c**                 if        (memtsa = gwaccount# and
037700170324     c**                           rx = 'Y')
037800170324     c**                 eval      ksub   = 999
037900170324     c**                 end
038000090508
038100090508      * ACI group special - get DENTAL rate from sub 999
038200120613      * added 05/09/09, removed 06/13/12
038300120613     c**                 if        (memtsa = acaccount# and
038400120613     c**                           dn = 'Y')
038500120613     c**                 eval      ksub   = 999
038600120613     c**                 end
038700091223
038800091223      * GBS special - get MEDICAL rate from sub 999
038900101221      * added 12/23/09, removed 12/21/10
039000101221     c**                 if        (memtsa = gbsaccount# and
039100101221     c**                           md = 'Y')
039200101221     c**                 eval      ksub   = 999
039300101221     c**                 end
039400081107
039500080826     c                   clear                   carrier           3
039600120404     c                   clear                   pdescrhold
039700080826     C     PLNKEY        CHAIN     PLNMST
039800080826     c                   if        %found(plnmst)
039900080826     c                   move      pcarr         carrier
040000120404     c                   movel     pdescr        pdescrhold
040100080826     c                   end
040200080826
0403000710040324 C*******************************************
0404000710040325 C* GET RATE
0405000710040324 C*******************************************
0406000710040384 C*
0407000710040385 C* clear fields first
0408000710040387 C                   clear                   PREM
040900071005     C                   clear                   premwk
041000071004
041100071004     c     grplist       plist
041200071004     c                   parm                    parmkey          15
041300140106     C                   PARM                    PARMSSN           9
041400140106     C                   PARM                    PARMSEQ           2
041500071004     c                   parm                    parmeffymd        8
041600071004     c                   parm                    parmbenamt        7
041700071004     c                   parm                    parmgroup        15
041800071004     c                   parm                    parmbilrte       11
041900071004     c                   parm                    parmnetrte       11
042000071004     c                   parm                    parmbilprem       7
042100071004     c                   parm                    parmnetprem       7
042200071004     c                   parm                    parmfound         1
042300140207
042400140207    *C                   Exsr      $ACA_CHK
042500140106    *
042600140207     C                   If        AM_I_ACA = YES
042700140207     C                   EVAL      PARMSSN = %EDITC(MEMSSN:'X')
042800140207     C                   MOVE      DEPSEQ        PARMSEQ
042900140207     C                   Else
043000140106     C                   EVAL      PARMSSN = *BLANKS
043100140106     C                   EVAL      PARMSEQ = *BLANKS
043200140207     C                   End
043300071004
043400071004     c                   move      tspabct       parmkey
043500071004     c                   move      dcand         parmeffymd
043600071004     c                   move      *zeros        parmbenamt
043700071004     c                   clear                   parmgroup
043800071004     c                   clear                   parmbilrte
043900071004     c                   clear                   parmnetrte
044000071004     c                   clear                   parmbilprem
044100071004     c                   clear                   parmnetprem
044200071004     c                   clear                   parmfound
044300071004
044400071004     c                   call      'GETRATE'     grplist
044500071004      * premium returned
0446000710040361 C                   if        parmfound = 'Y'
044700080826      * special for benegap debit card - use NET RATE
044800091214      * special for BPI COBRA          - use NET RATE
044900101122      * special for GBS HRA funding    - use NET RATE
045000101119     c                   if        carrier = 'MBF' or carrier = 'NAB' or
045100101119     c                             carrier = 'GBH'
045200080826     c                   move      parmnetprem   prem
045300080826     c                   else
045400080826     c                   move      parmbilprem   prem              7 2
045500080826     c                   end
045600140207
045700140207      * If ACA Plan, use the full depn rate
045800140207     C                   If        AM_I_ACA = YES
045900140211     c                   movel     parmbilrte    prem
046000140207     c                   end
046100080826
046200071004     c                   else
046300071004
046400071004      * no rate found - do second rate search for 1 month less
0465000710040361 C                   if        dcand = 0
046600071005     C                   leavesr
046700071004     c                   end
046800071004
046900071004     C                   move      dcand         workdt
047000071004     C                   subdur    1:*m          workdt
047100071004     C                   move      workdt        dcand2
047200071004     c                   move      tspabct       parmkey
047300071004     c                   move      dcand2        parmeffymd
047400071004     c                   move      *zeros        parmbenamt
047500071004     c                   clear                   parmgroup
047600071004     c                   clear                   parmbilrte
047700071004     c                   clear                   parmnetrte
047800071004     c                   clear                   parmbilprem
047900071004     c                   clear                   parmnetprem
048000071004     c                   clear                   parmfound
048100071004
048200071004     c                   call      'GETRATE'     grplist
048300071004
048400071004      * premium returned
0485000710040361 C                   if        parmfound = 'Y'
048600080826      * special for benegap debit card - use NET RATE
048700091214      * special for BPI COBRA          - use NET RATE
048800101122      * special for GBS HRA funding    - use NET RATE
048900101119     c                   if        carrier = 'MBF' or carrier = 'NAB' or
049000101119     c                             carrier = 'GBH'
049100080826     c                   move      parmnetprem   prem
049200080826     c                   else
049300080826     c                   move      parmbilprem   prem
049400080826     c                   end
049500140207
049600140207      * If ACA Plan, use the full depn rate
049700140207     C                   If        AM_I_ACA = YES
049800140211     c                   movel     parmbilrte    prem
049900140207     c                   end
050000080826
050100071004     c                   else
050200071004
050300071004      * IF STILL NO RATES, SKIP
050400071004     c                   if        first = ' '
050500071004     c                   move      'N'           first             1
050600071004     c                   except    head
050700071004     C                   END
050800071004     c   of              except    head
050900071004
051000071004     C                   MOVE      dcand         MDCY#
051100071004     C                   EXSR      #MDCY8
051200071004     C                   MOVE      CYMD#         dcandmdy          8 0
051300071004     C                   MOVE      dcand2        MDCY#
051400071004     C                   EXSR      #MDCY8
051500071004     C                   MOVE      CYMD#         dcand2mdy         8 0
051600071004
051700071004     c                   except    raterr
051800071005     C                   leavesr
051900071004
0520000710040363 C                   end
0521000710040363 C                   end
052200071004
0523000710040324 C*******************************************
052400040921
052500071004     C                   EVAL(H)   premwk = (prem + (prem * gbspct)         )
052600040921
052700040921     C                   ENDSR
052800040921
0529001104140103  ***************************************************
0530001104140104  * write letter history recod                      *
0531001104140105  ***************************************************
0532001104140107
0533001104140106 C     #clethst      BEGSR
053400110414     C                   clear                   clethstr
053500120801     C                   MOVE      'A'           CLSTATUS
053600131011     C                   MOVEl     ld8ymd        CLTRDAT
053700110414     C                   move      time          CLTRTIM
053800131011     C                   MOVEl     luser         CLTRUSER
053900110414     C                   MOVEl     trcodeout     CLTRCOD
054000110414     c     trcodeout     chain     codesl1
054100110414     c                   if        %found(codesl1)
054200110414     C                   MOVEl     ldescr        CLTRDES
054300110414     c                   end
054400110414     C                   MOVEl     ck#not        CLNOTE1
054500110414     C                   movel     nameo         CLNOTE2
054600110414     C                   MOVE      memssn        CLMSSN
054700110414     c     memssn        chain     member
054800110414     c                   if        %found(member)
054900110414     C                   MOVEl     m_mlname      CLMLNAME
055000110414     C                   MOVEl     m_mfname      CLMFNAME
055100110414     C                   MOVE      m_mmi         CLMMI
055200110414     C                   MOVEl     m_addr1       CLMADR1
055300110414     C                   MOVEl     m_addr2       CLMADR2
055400110414     C                   MOVEl     m_city        CLMCITY
055500110414     C                   MOVEl     m_state       CLMST
055600110414     C                   MOVE      m_zip         CLMZIP
055700110414     c                   end
055800110414
055900110414     C                   MOVE      TRUST         CLTRUST
056000110414     C                   MOVE      SUB           CLSUB
056100110414     C                   MOVE      ACCT          CLACCT
056200110414     C                   MOVEl     aname         CLACNAM1
056300110415     C                   MOVEl     aname2        CLACNAM2
056400110418     C                   MOVEl     flag          CLFCSTFL
056500110418     C                   MOVEl     cserv         CLCOBSRV
056600110414     C                   MOVE      dcand         CLTRMDT
056700120405     C                   MOVE      returndt      CLEENDT
056800110414     C                   move      depseq        CLDSEQ
056900110414     C     depkey        CHAIN     DEPNDC
057000110414     c                   if        %found(depndc)
057100110414     C                   move      d_depss#      CLDSSN
057200110415      * same last name as member
057300110415     c                   if        %subst(d_dlname:1:5) = 'SAME '
057400110415     C                   movel     CLMLNAME      CLDLNAME
057500110415     c                   else
057600110414     C                   movel     d_DLNAME      CLDLNAME
057700110415     c                   end
057800110414     C                   movel     d_DFNAME      CLDFNAME
057900110414     C                   movel     d_DMI         CLDMI
058000110415
058100110415      * same address as member
058200110415     c                   if        %subst(d_daddr1:1:5) = 'SAME '
058300110415     C                   movel     CLMADR1       CLDADR1
058400110415     C                   movel     CLMADR2       CLDADR2
058500110415     C                   movel     CLMCITY       CLDCITY
058600110415     C                   movel     CLMST         CLDST
058700110415     C                   move      CLMZIP        CLDZIP
058800110415     c                   else
058900110414     C                   movel     d_DADDR1      CLDADR1
059000110414     C                   movel     d_DADDR2      CLDADR2
059100110414     C                   movel     d_DCITY       CLDCITY
059200110414     C                   movel     d_DSTATE      CLDST
059300110414     C                   move      d_DZIP        CLDZIP
059400110414     c                   end
059500110415     c                   end
059600110415
059700110414     C                   clear                   CLINEL1
059800110414     C                   clear                   CLINEL2
059900110414     C                   clear                   CLINEL3
060000110415     C                   clear                   CLINEL4
060100130308
060200130308      * link field not used for dependnet letters
060300130308     C                   clear                   CLLINK
060400130429
060500130429      * plans for rate sheet not used for dependent letters
060600130429     c                   clear                   CLPLNR1
060700130429     c                   clear                   CLPLNR2
060800130429     c                   clear                   CLPLNR3
060900130429     c                   clear                   CLPLNR4
061000130429     c                   clear                   CLPLNR5
061100130429     c                   clear                   CLPLNR6
061200130429     c                   clear                   CLPLNR7
061300130429     c                   clear                   CLPLNR8
061400130429     c                   clear                   CLPLNR9
061500130429     c                   clear                   CLPLNR10
061600130429
061700120405      *
061800120405     c                   movel     aaname        CLAANAME
061900120405     c                   movel     contac        CLACONTAC
062000120405     c                   movel     aaddr1        CLAADR1
062100120405     c                   movel     aaddr2        CLAADR2
062200120405     c                   movel     acity         CLACITY
062300120405     c                   movel     astate        CLASTATE
062400120405     c                   move      azip          CLAZIP
062500120405     C                   MOVEl     aarea         CLAPHONE
062600120405     C                   MOVE      aphone        CLAPHONE
062700120405     C                   MOVEl     returnadr     CLRETADR
062800120405     C                   MOVEl     mplandsc      CLPDES1
062900120405     C                   MOVE      mpre          CLPPRM1
063000120405     C                   MOVEl     dplandsc      CLPDES2
063100120405     C                   MOVE      dpre          CLPPRM2
063200120405     C                   MOVEl     vplandsc      CLPDES3
063300120405     C                   MOVE      vpre          CLPPRM3
063400120405     C                   MOVEl     bgplandsc     CLPDES4
063500120405     C                   move      bgpre         CLPPRM4
063600180924     C                   MOVEl     eapplandsc    CLPDES5
063700180924     C                   move      eappre        CLPPRM5
063800120405
063900120404      * fill addendum fields
064000120404     c                   movel     wkadden1      CLADDEN1
064100120404     c                   movel     wkadden2      CLADDEN2
064200120404     c                   movel     wkadden3      CLADDEN3
064300120404
064400110414     C                   write     clethstr
064500120404
064600120404     c                   clear                   wkadden1
064700120404     c                   clear                   wkadden2
064800120404     c                   clear                   wkadden3
064900120404
0650001104140120 C                   ENDSR
065100110414
065200120404      ********************************************************
065300210429      * store addeddum printed for later use in letter hist file
065400120404      ********************************************************
065500120404
065600210429     C     #storadd      BEGSR
065700120404
065800120404     c                   select
065900120404     c                   when      wkadden1 = *blanks
066000120404     c                   movel     wkadden       wkadden1
066100120404     c                   when      wkadden2 = *blanks
066200120404     c                   movel     wkadden       wkadden2
066300120404     c                   when      wkadden3 = *blanks
066400120404     c                   movel     wkadden       wkadden3
066500120404     c                   endsl
066600120404
066700120404     C                   endsr
066800120404
066900010814      *****************************************************************
067000981217     C     *INZSR        BEGSR
0671000409210123  * GET FED OR STATE PCT.
0672000409210124 C                   MOVEL     'C'           COBK1             1
067300040921     C                   MOVE      *BLANKS       COBK2            14
067400040921
0675000409210125 C     COBKEY        CHAIN     CONTRL                             28
067600040921     C                   IF        *IN28 = '0'
067700040921     C                   MOVEL     CANFLG        FEDPCT            2 2
067800040921     C                   MOVE      AIFLG         FEDPCT
067900040921     C                   MOVEL     CIFLG         STAPCT            2 2
068000040921     C                   MOVE      PRMFLG        STAPCT
0681000409210126 C                   MOVE      FEDPCT        FEDP              2 2
0682000409210127 C                   MOVE      STAPCT        STAP              2 2
068300040921     C                   END
068400040921
068500040921     C                   Z-ADD     0             ZERO9             9 0
068600131011     C                   Z-ADD     0             ZERO8             8 0
068700131011     C                   Z-ADD     0             ZERO7             7 0
068800040921     C                   MOVE      0             AB                2 0
068900040921     C                   MOVE      'TIN'         TYPE              3
069000040921     C                   MOVE      *DATE         MDCY#             8
069100040921     C                   EXSR      #MDCY8
069200040921     C                   MOVE      CYMD#         CVTDAT            8 0
069300040921
069400040921
069500040921     C     COBKEY        KLIST
069600040921     C                   KFLD                    COBK1
069700040921     C                   KFLD                    COBK2
069800110414
069900110414     C     depkey        KLIST
070000110414     C                   KFLD                    memssn
070100110414     C                   KFLD                    depseq
070200040921
070300080826     c     plnkey        klist
070400080826     c                   kfld                    trust
070500080826     c                   kfld                    sub
070600080826     c                   kfld                    xplan
070700080826
070800981217     C                   ENDSR
070900140207      *****************************************************************
071000140207     C     $ACA_CHK      BEGSR
071100140207    ***
071200140207     C                   EVAL      AM_I_ACA = NO
071300140207     C                   EVAL      @1 = #CHK_ACA_PLAN(TRUST:SUB:XPLAN)
071400140207    ***
071500140207     C                   IF        @1 = 'Y'
071600140207     C                   EVAL      AM_I_ACA = YES
071700140207     C                   ENDIF
071800140207    ***
071900140207     C                   ENDSR
072000010814      *****************************************************************
0721000501060237 Ocob221p   e            head           2 03
0722000409210239 O                                           44 '*****'
0723000409210240 O                       CONAME              85
0724000409210241 O                                           91 '*****'
0725000409210242 O          e            head           1
0726000409210244 O                                           78 'COBRA DEPENDENT LETTER RAT'
0727000409210244 O                                           +0 'E ERRORS'
0728000409210242 O          e            head           1
0729000409210248 O                                           25 'PROGRAM NAME: COB221'
0730000409210249 O                                          122 'PAGE :'
0731000409210250 O                       PAGE          Z    131
0732000409210242 O          e            head           1
0733000409210253 O                                           14 'RUN DATE:'
0734000409210254 O                       UDATE         Y     25
0735000409210255 O                                          122 'TIME :'
0736000409210256 O                       TIME               131 '  :  :  '
0737000409210242 O          e            head           1
0738000409210259 O                                           24 '""""""""""""""""""""""""'
0739000409210260 O                                           48 '""""""""""""""""""""""""'
0740000409210261 O                                           72 '""""""""""""""""""""""""'
0741000409210262 O                                           96 '""""""""""""""""""""""""'
0742000409210263 O                                          120 '""""""""""""""""""""""""'
0743000409210264 O                                          132 '""""""""""""'
0744000409210242 O          e            head           1
0745000409210272 O                                            8 'SSN'
0746000409210275 O                                           27 'ACCT #'
0747000409210276 O                                           34 'PLAN'
0748000409210242 O          e            head           2
0749000409210281 O                                           24 '""""""""""""""""""""""""'
0750000409210282 O                                           48 '""""""""""""""""""""""""'
0751000409210283 O                                           72 '""""""""""""""""""""""""'
0752000409210284 O                                           96 '""""""""""""""""""""""""'
0753000409210285 O                                          120 '""""""""""""""""""""""""'
0754000409210286 O                                          132 '""""""""""""'
0755000409210287 O          E            raterr         1
0756000409210288 O                       memssn              12 '0   -  -    '
0757000409210289 O                       memtsa              27 '   -   -    '
0758000409210289 O                       xplan               34
0759000501060289 O                                           +3 '* MISSING RATE *'
0760000501110289 O                       dcandmdy            +3 '  /  /    '
0761000501110289 O                                           +2 'AND'
0762000501110289 O                       dcand2mdy           +2 '  /  /    '
0763009809110278 OHIST      EADD         ADDHIS
076400980911     O                       MEMSSN              10
0765000410280284 O                       trcodeout           19
0766009809110285 O                       ZERO9               24P
076700090402     o                       ck#not              55
076800000609     O                       NAMEO               85
076900090402     O                       depseq              90
077000131011     O                       thispgmname        107
077100131011     O                                          108 ' '
077200980911     O                       TRUST              112
077300980911     O                       SUB                115
077400980911     O                       ACCT               119
077500131011     o                       zero8              127
0776009809110294 O                                          128 'A'
0777001310110283 O                       ld8ymd             136
0778001310110288 O                       ZERO8              144
0779001204050288 O                       returndt           152
0780009901120289 O                       DCAND              160
078100131011     o                       zero9              184
078200131011     o                       zero7              191
078300131011     o                       systime            199
078400131011     o                       zero7              206
078500131011     O                       luser              216
078600120404**
078700120404P.O. Box 64802, Baltimore, MD 21264-4802
078800120404P.O. Box 17309, Baltimore, MD 21297-1288.
