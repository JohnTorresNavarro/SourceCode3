0001000204020002  *****************************************************************************
000200150915      * IRS95CBLR  Group Benefit Services                                         *
000300150924      *            WRITTEN BY - R.L.J.                                            *
000400211206      *            DATE - 12/2021                                                 *
000500211201      *  DESCRIPTION - Build file IRS 1095C for a TSA for 2021                    *
000600150924      *                                                                           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900060427      *  xxx mm/dd/yyyy                                                           *
001000150924      *                                                                *
0011001509170018 F******************************************************************
0012001612120019 FACCMST    IF   E           K DISK
0013001612120019 FAC2MST    IF   E           K DISK
001400161212     FMCOVMPLN  IF   E           K DISK
001500161212     FMEMAC#1   IF   E           K DISK
001600161212     FPLNMST    IF   E           K DISK
001700161212     FPLNAUXP   IF   E           K DISK
001800161212     FCODES     IF   E           K DISK
0019001612120020 FIRS95CP   UF A E           K DISK
0020001509240025  *
002100201209      *
002200201209     D                 DS
002300201209     D  contar         S              1A   DIM(30)
002400201209     D  contarx        S              1A   DIM(30)
002500201209     D  conlarx        S              1A   DIM(30)
002600201209     D  addrar         S              1A   DIM(30)
002700201209     D  addrarx        S              1A   DIM(30)
002800220119     D  namear         S              1A   DIM(40)
002900220119     D  namearx        S              1A   DIM(40)
003000201209    * *
003100201209    * *
003200171212     D                 DS
003300201209     D @KEYPRM                 1     10A
003400201209     D #KTRST                  1      3S 0
003500201209     D #KSUB#                  4      6S 0
003600201209     D #KACCT                  7     10S 0
003700220111    * *
003800220111     D                 DS
003900220111     D parmtsp                 1     10A
004000220111     D parmtr                  1      3
004100220111     D parmsu                  4      6
004200220111     D parmpln                 7     10A
004300220111    * *
004400220111     D                 DS
004500220111     D empdt                   1      8S 0
004600220111     D parmedt                 1      8A
0047001712120025  *
0048001712120250 D                 DS
0049002101070251 D gbsbdt                  1      8  0
0050002101070251 D  mpst                   5      6
0051002101070025  *
0052002101070250 D                 DS
0053002101070251 D azip                    1      9  0
0054002101070251 D  azip9                  1      9
0055001712120025  *
0056001712120250 D                 DS
0057001712120251 D zip                     1      9  0
0058001712120251 D  mzip9                  1      9
0059001712120025  *
0060001509280250 D                 DS
0061001701030251 D rnewpd                  1      2  0
0062001701030251 D  svplst                 1      2
0063001701030025  *
0064001701030250 D                 DS
0065001701030251 D mbenrl                  1      8  0
0066001701030251 D  enrmm                  5      6
0067002201190025  *
0068002201190250 D                 DS
0069002201190251 D a2tax_id#               1     10  0
0070002201190251 D  taxid9                 2     10
0071000604270025  *
0072001509280250 D                 DS
0073001612300251 D   emprinfo              1    241
0074001509280251 D    i5enm1               1     40
0075001509280251 D    i5enm2              41     80
0076001509280251 D    i5ead1              81    110
0077001509280251 D    i5ead2             111    140
0078001509280251 D    i5ecty             141    160
0079001509280251 D    i5est              161    162
0080001612200251 D    i5ezip             163    171
0081001509280251 D    i5ephn             172    181
0082001509280251 D    i5epex             182    189
0083001509280251 D    i5eid              190    201
0084001612300251 D    i5ecfn             202    221
0085001612300251 D    i5ecln             222    241
0086001509280025  *
0087001509280250 D                 DS
0088001509280251 D   covall                1     12
0089001509280251 D    cov01                1      1
0090001509280251 D    cov02                2      2
0091001509280251 D    cov03                3      3
0092002011030251 D    cov04                4      4
0093002011030251 D    cov05                5      5
0094002011030251 D    cov06                6      6
0095001509280251 D    cov07                7      7
0096001509280251 D    cov08                8      8
0097001509280251 D    cov09                9      9
0098001509280251 D    cov10               10     10
0099001509280251 D    cov11               11     11
0100002112070251 D    cov12               12     12
010100211207      *
010200211207     D                 DS
010300211207     D plncat                  1      3
010400211207     D   cdkey1                1      1
010500211207     D   cdkey2                2      3
010600211207      *
0107002112070025  *
0108002112070250 D                 DS
0109002112070251 D  svempr                      241
0110002112070251 D  a2typ                         1    INZ('F')
0111002112070251 D  datea                          D   DATFMT(*ISO)
0112002112070251 D  dateb                          D   DATFMT(*ISO)
0113002112070251 D  datec                          D   DATFMT(*ISO)
0114002011030251 D  dated                          D   DATFMT(*ISO)
0115002011030251 D  datee                          D   DATFMT(*ISO)
0116002011030251 D  days                          5S 0
0117002011030251 D  enrdat                        8S 0
0118001902040251 D  sal92                         9S 2
0119001902040251 D  mseq#                         2  0 INZ(0)
0120001902040251 D  sps                           1
0121001902040251 D  deplif                        1
0122002201110251 D  parmerr                       1
0123002201110251 D  parmenr                       8
0124001902040251 D  trst600                       3  0 INZ(600)
0125001902040251 D  sub#3                         3  0 INZ(3)
0126001902040251 D  addr30                       30
0127001902040251 D  addr30x                      30
0128002201190251 D  name40                       40
0129002201190251 D  name40x                      40
0130001902040251 D  cont30                       30
0131001701260251 D  conf12                       12
0132001701260251 D  conl20                       20
0133001701260251 D  contmi                        1
0134001701260251 D  x                             2  0
0135001701260251 D  y                             2  0
0136001701260251 D  z                             2  0
013700170126      *
013800170126    * *
013900170126     C     acckey        KLIST
014000201103     C                   KFLD                    #ktrst
014100201103     C                   KFLD                    #ksub#
014200201103     C                   KFLD                    #kacct
014300201103    * *
014400201103     C     ac2key        KLIST
014500201103     C                   KFLD                    a2typ
014600201103     C                   KFLD                    #ktrst
014700201103     C                   KFLD                    #ksub#
014800201103     C                   KFLD                    #kacct
014900201103    * *
015000201103     C     covkey        KLIST
015100201103     C                   KFLD                    mbssno
015200201103     C                   KFLD                    mseq#
015300201103     C                   KFLD                    #ktrst
015400201103     C                   KFLD                    #ksub#
015500201103    * *
015600201103     C     plnkey        KLIST
015700201103     C                   KFLD                    mctrst
015800170126     C                   KFLD                    mcsub#
015900170126     C                   KFLD                    mcplan
016000170126    * *
016100170126     C     codkey        KLIST
016200170126     C                   KFLD                    cdkey1
016300170126     C                   KFLD                    cdkey2
016400170126    * *
016500170126    * *
016600170126    * *
016700161028     C     *ENTRY        PLIST
016800161028     C                   PARM                    @PARM            10
016900161028     C                   MOVEL(P)  @PARM         @KEYPRM
017000161028    * *
0171001610260291  *        Get Account Record
0172002012080297 C     acckey        chain     accmst                             21
0173002012080296 C                   If        *in21 = '0'
0174002012080291  *
0175002012080291 C                   clear                   irs95cr
0176002012080291 C                   exsr      bldacc
0177002012080291 C                   eval      svempr = emprinfo
0178002012080291  *
017900201208      *        Locate members in TSA
0180002012080297 C     acckey        setll     memac#1                            22
0181002012080296 C                   dou       *in22 = '1'
0182002112020297 C     acckey        reade     memac#1                                22
0183002112020296 C                   if        *in22 = '0'
0184002112020291  *       Check for Non-empoyee
0185002112020296 C                   if        nonemp = 'Y'
0186002112100296 C                   iter
0187002112100296 C                   endif
0188002112100291  *
0189002112100291  *        debug Shit
0190002201110296 C                   if        mbssno = 047500364
0191002112020296 C                   eval      mbssno = mbssno
0192001509280296 C                   endif
0193001601050291  *
0194001601050296 C                   if        mbenrl = termdt
0195001601050296 C                   iter
0196002011300296 C                   endif
0197002011300291  *
0198002112060296 C                   If        mbenrl < 20220101 and
0199002112060296 C                             (termdt = 0 or termdt > 20201231)
0200002011300291 C                   exsr      bldmbr
0201002011300291  *
0202002011300297 C                   endif                                                  *in21 = '1'
0203002011300297 C                   endif                                                  *in21 = '1'
0204002011300291  *
0205002011300297 C                   enddo                                                  *in21 = '1'
0206002011300291  *
0207002011300297 C                   endif                                                  *in21 = '1'
0208002011300291  *
0209001802120297 C                   movel     '1'           *inlr
0210001802120297 C                   return
0211001802120291  *
0212000605040107  ********************************************************************************
0213000204020107  *
0214001509150107  *     BLDACC - Build Account portion of record
0215000204020107  *
0216000204020107  ********************************************************************************
021700150915     C     bldacc        begsr
0218000604270107  *
021900220119     C                   movel(P)  acnam1        name40
022000220119     C                   exsr      getname
022100220119     C                   movel(P)  name40x       i5enm1
0222002201190107  *
022300220119     C                   movel(P)  acnam2        name40
022400220119     C                   exsr      getname
022500220119     C                   movel(P)  name40x       i5enm2
0226002201190107  *
022700201202     C                   movel(P)  aaddr1        i5ead1
0228002012020107  *
022900201202     C                   movel(P)  aaddr1        addr30
023000201202     C                   exsr      getaddr
023100201202     C                   movel(P)  addr30x       i5ead1
0232002012020107  *
023300201202     C                   movel(P)  aaddr2        addr30
023400201202     C                   exsr      getaddr
023500201202     C                   movel(P)  addr30x       i5ead2
0236002012020107  *
023700201202     C                   movel(P)  acity         i5ecty
023800150915     C                   movel(P)  astate        i5est
023900161220     C                   movel     azip9         i5ezip
0240002011300296 C**                 If        i5ezp4 = '0000'
024100201130     C**                 movel(P)  *blanks       i5ezp4
024200201130     C**                 endif
024300201130     C                   movel     aarea         i5ephn
024400201130     C                   move      aphone        i5ephn
0245002011300107  *
024600161230     C                   movel     contac        cont30
024700201202     C                   exsr      getcont
024800201202     C                   movel     conf12        i5ecfn
024900201202     C                   movel     conl20        i5ecln
0250002012020107  *
0251002112170291  *        Get Acc 2 Record
0252002112170297 C     ac2key        chain     ac2mst                             31
0253002112200296 C                   If        *in31 = '0' and a2tax_id# <> 0
025400220119     C                   movel(P)  taxid9        i5eid
025500211220     C                   else
025600211220     C                   movel(P)  @keyprm       i5eid
025700211220     C                   endif
0258002112200107  *                                                                     **********
025900211217     C                   endsr
0260001509150107  ********************************************************************************
0261001509150107  *
0262001509150107  *     BLDMBR - Build Member record
0263001509150107  *
0264001509150107  ********************************************************************************
026500201104     C     bldmbr        begsr
0266002011040107  *
0267002011040296 C                   clear                   irs95cr
0268002011040107  *
0269002011040296 C                   eval      emprinfo = svempr
0270002011040107  *
027100201104     C                   movel     mbssno        i5mssn
027200201104     C                   movel     mfname        i5mfnm
027300150928     C                   move      mmi           i5mmi
027400150928     C                   movel     mlname        i5mlnm
0275001701030107  *
027600170103     C                   movel(P)  addr1         addr30
027700170103     C                   exsr      getaddr
027800220104     C                   movel(P)  addr30x       i5mad1
0279002201040107  *
028000220104     C                   movel(P)  addr2         addr30
028100220104     C                   exsr      getaddr
028200220104     C                   movel(P)  addr30x       i5mad2
0283002201040107  *
028400220104     C                   movel     city          i5mcty
028500220104     C                   movel     state         i5mst
028600220104     C                   movel     mlname        i5mlnm
028700220104     C                   movel     mlname        i5mlnm
028800220104     C                   movel     mlname        i5mlnm
028900161220     C                   movel     mzip9         i5mzip
0290001612200296 C***                If        i5mzp4 = '0000'
029100161220     C***                movel(P)  *blanks       i5mzp4
029200161220     C***                endif
029300151014     C                   movel(P)  fill66        i5meml
0294001509280107  *        Person 1 info (same as mbr)
0295001509290107  *          Leave blank for FI - Per KT
029600150929     C*******            movel     mbssno        i51ssn
029700150929     C**                 movel     mfname        i51fnm
029800150929     C**                 move      mmi           i51mi
029900150929     C********           movel     mlname        i51lnm
0300001509280107  *        Plan Offer Info
030100160105      *           Calc Enroll Dt if Enroll Dt is prior to Employ Dt
0302002201050296 C**********         If        mbenrl < empdt and
0303002201050296 C**                           (mbenrl > 20200601 or empdt > 20200601)
030400220105     C**                 move      mbenrl        datea
030500220105     C**                 move      empdt         dateb
030600220105     C**   dateb         subdur    datea         days:*D
0307002201050296 C*********          If        days > 31
0308002201050296 C                   If        empdt > 20201003
030900180104     C                   exsr      calcenr
031000180104     C                   eval      mbenrl = enrdat
031100180104     C                   endif
031200220105     C****               endif
0313001801040107  *
031400180104      *
0315002201050296 C                   If        gbsbdt < 20210201
031600220105     C                   eval      i5mpls = '01'
031700220105     C                   else
031800220105     C                   eval      i5mpls = mpst
031900220105     C                   endif
032000220105      *           All  2021 Months?
0321002201050296 C                   If        mbenrl < 20210201 and
0322002201050296 C                             (termdt = 0 or termdt > 20211231)
032300220105     C                   eval      i5mcall = '1A'
032400220105     C                   else
032500171220      *               Jan?
0326002112060296 C                   If        mbenrl < 20210201 and
0327002112060296 C                             (termdt = 0 or termdt > 20210101)
032800171220     C                   eval      i5mcm1 = '1A'
032900171220     C                   else
033000160106     C                   eval      i5mcm1 = '1H'
033100161027     C                   endif
033200161027      *               Feb?
0333002112150296 C                   If        mbenrl < 20210301 and
0334002112150296 C                             (termdt = 0 or termdt > 20210201)
033500161027     C                   eval      i5mcm2 = '1A'
033600211215     C                   else
033700211215     C                   eval      i5mcm2 = '1H'
033800211215     C                   endif
033900150928      *               Mar?
0340002112150296 C                   If        mbenrl < 20210401 and
0341002112150296 C                             (termdt = 0 or termdt > 20210301)
034200211215     C                   eval      i5mcm3 = '1A'
034300160106     C                   else
034400160106     C                   eval      i5mcm3 = '1H'
034500150928     C                   endif
034600150928      *               Apr?
0347002112060296 C                   If        mbenrl < 20210501 and
0348002112060296 C                             (termdt = 0 or termdt > 20210401)
034900150928     C                   eval      i5mcm4 = '1A'
035000160106     C                   else
035100160106     C                   eval      i5mcm4 = '1H'
035200150928     C                   endif
035300150928      *               May?
0354002112060296 C                   If        mbenrl < 20210601 and
0355002112060296 C                             (termdt = 0 or termdt > 20210501)
035600150928     C                   eval      i5mcm5 = '1A'
035700160106     C                   else
035800160106     C                   eval      i5mcm5 = '1H'
035900150928     C                   endif
036000180206      *               Jun?
0361002112060296 C                   If        mbenrl < 20210701 and
0362002112060296 C                             (termdt = 0 or termdt > 20210601)
036300180206     C                   eval      i5mcm6 = '1A'
036400180206     C                   else
036500180206     C                   eval      i5mcm6 = '1H'
036600180206     C                   endif
036700180206      *               Jul?
0368002112060296 C                   If        mbenrl < 20210801 and
0369002201040296 C                             (termdt = 0 or termdt > 20210701)
037000220104     C                   eval      i5mcm7 = '1A'
037100220104     C                   else
037200220104     C                   eval      i5mcm7 = '1H'
037300220104     C                   endif
037400180206      *               Aug?
0375002112060296 C                   If        mbenrl < 20210901 and
0376002112060296 C                             (termdt = 0 or termdt > 20210801)
037700150928     C                   eval      i5mcm8 = '1A'
037800160106     C                   else
037900160106     C                   eval      i5mcm8 = '1H'
038000150928     C                   endif
038100180216      *               Sep?
0382002112060296 C                   If        mbenrl < 20211001 and
0383002112060296 C                             (termdt = 0 or termdt > 20210901)
038400180216     C                   eval      i5mcm9 = '1A'
038500180216     C                   else
038600180216     C                   eval      i5mcm9 = '1H'
038700180216     C                   endif
038800180216      *               Oct?
0389002112060296 C                   If        mbenrl < 20211101 and
0390002112060296 C                             (termdt = 0 or termdt > 20211001)
039100180216     C                   eval      i5mcm10 = '1A'
039200180216     C                   else
039300180216     C                   eval      i5mcm10 = '1H'
039400180216     C                   endif
039500180216      *               Nov?
0396002112060296 C                   If        mbenrl < 20211201 and
0397002112060296 C                             (termdt = 0 or termdt > 20211101)
039800150928     C                   eval      i5mcm11 = '1A'
039900160106     C                   else
040000160106     C                   eval      i5mcm11 = '1H'
040100150928     C                   endif
040200150928      *               Dec?
0403002112060296 C                   If        mbenrl < 20220101 and
0404002112060296 C                             (termdt = 0 or termdt > 20211201)
040500150928     C                   eval      i5mcm12 = '1A'
040600160106     C                   else
040700160106     C                   eval      i5mcm12 = '1H'
040800150928     C                   endif
0409001509280107  *
041000150928     C                   endif
0411001509280107  *
0412001509280107  *        Determine Coverage Time Frame for Member
041300150928     C                   eval      covall = '000000000000'
0414000604270107  *
041500150928      *           Find Medical Plan Coverage
0416001509280297 C     covkey        setll     mcovmpln                           23
0417001509280296 C                   dou       *in23 = '1'
0418001509280297 C     covkey        reade     mcovmpln                               23
0419001509280296 C                   if        *in23 = '0'
0420001509280107  *
0421002112060296 C                   If        candt <> 0 and candt < 20210101
042200150928     C                   iter
042300150928     C                   endif
0424001509280107  *
0425002112060296 C                   If        enrldt > 20211231
042600150928     C                   iter
042700150928     C                   endif
042800150928      *           Get Plan rec to chk for MED
0429001509280297 C     plnkey        chain     plnmst                             24
0430001509280296 C                   if        *in24 = '0'
0431001509280107  *
0432001509280297 C     codkey        chain     codes                              25
0433001509280296 C                   if        *in25 = '0'
0434001509280107  *
043500210505     C                   if        action <> 'M' or sfadm = 'Y'
043600150928     C                   iter
043700150928     C                   endif
0438001802010107  *
043900211206      *           All 2021 Months?
0440002112060296 C                   If        enrldt < 20210201 and
0441002112060296 C                             (candt = 0 or candt > 20211231)
044200180201     C                   eval      i5mhall = '2C'
044300180201     C                   eval      covall = '111111111111'
044400180201     C                   leave
044500180201     C                   endif
044600180201      *               Jan?
0447002112060296 C                   If        enrldt < 20210201 and
0448002112060296 C                             (candt = 0 or candt > 20210101)
044900180201     C                   eval      cov01 = '1'
045000180201     C                   endif
045100180201      *               Feb?
0452002112060296 C                   If        enrldt < 20210301 and
0453002112060296 C                             (candt = 0 or candt > 20210201)
045400180201     C                   eval      cov02 = '1'
045500150928     C                   endif
045600150928      *               Mar?
0457002112060296 C                   If        enrldt < 20210401 and
0458002112060296 C                             (candt = 0 or candt > 20210301)
045900150928     C                   eval      cov03 = '1'
046000150928     C                   endif
046100150928      *               Apr?
0462002112060296 C                   If        enrldt < 20210501 and
0463002112060296 C                             (candt = 0 or candt > 20210401)
046400150928     C                   eval      cov04 = '1'
046500150928     C                   endif
046600150928      *               May?
0467002112060296 C                   If        enrldt < 20210601 and
0468002112060296 C                             (candt = 0 or candt > 20210501)
046900150928     C                   eval      cov05 = '1'
047000150928     C                   endif
047100150928      *               Jun?
0472002112060296 C                   If        enrldt < 20210701 and
0473002112060296 C                             (candt = 0 or candt > 20210601)
047400150928     C                   eval      cov06 = '1'
047500150928     C                   endif
047600151002      *               Jul?
0477002112060296 C                   If        enrldt < 20210801 and
0478002112060296 C                             (candt = 0 or candt > 20210701)
047900151002     C                   eval      cov07 = '1'
048000151002     C                   endif
048100151002      *               Aug?
0482002112060296 C                   If        enrldt < 20210901 and
0483002112060296 C                             (candt = 0 or candt > 20210801)
048400151002     C                   eval      cov08 = '1'
048500151002     C                   endif
048600151002      *               Sep?
0487002112060296 C                   If        enrldt < 20211001 and
0488002112060296 C                             (candt = 0 or candt > 20210901)
048900151002     C                   eval      cov09 = '1'
049000150928     C                   endif
049100150928      *               Oct?
0492002112060296 C                   If        enrldt < 20211101 and
0493002112060296 C                             (candt = 0 or candt > 20211001)
049400150928     C                   eval      cov10 = '1'
049500150928     C                   endif
049600150928      *               Nov?
0497002112060296 C                   If        enrldt < 20211201 and
0498002112060296 C                             (candt = 0 or candt > 20211101)
049900150928     C                   eval      cov11 = '1'
050000150928     C                   endif
050100150928      *               Dec?
0502002112060296 C                   If        enrldt < 20220101 and
0503002112060296 C                             (candt = 0 or candt > 20211201)
050400150928     C                   eval      cov12 = '1'
050500150928     C                   endif
050600150928      *
050700060427     C                   endif
050800150928      *
050900150928     C                   endif
0510001509280107  *
051100060427     C                   endif
0512000303270107  *
051300150928     C                   enddo
0514001509280107  *
051500150928     C                   If        covall = '111111111111'
051600150928     C                   eval      i5mhall = '2C'
051700150929     C*****              eval      i51call = '1'
051800150928     C                   else
0519001509280107  *
052000150928     C                   If        cov01 = '1'
052100150928     C                   eval      i5mhm1 = '2C'
052200150929     C******             eval      i51cm1 = '1'
052300150928     C                   endif
0524001509280107  *
052500150928     C                   If        cov02 = '1'
052600150928     C                   eval      i5mhm2 = '2C'
052700150929     C******             eval      i51cm2 = '1'
052800150928     C                   endif
0529001509280107  *
053000150928     C                   If        cov03 = '1'
053100150928     C                   eval      i5mhm3 = '2C'
053200150929     C******             eval      i51cm3 = '1'
053300150928     C                   endif
0534001509280107  *
053500150928     C                   If        cov04 = '1'
053600150928     C                   eval      i5mhm4 = '2C'
053700150929     C******             eval      i51cm4 = '1'
053800201113     C                   endif
0539002011130107  *
054000201113     C                   If        cov05 = '1'
054100201113     C                   eval      i5mhm5 = '2C'
054200201113     C******             eval      i51cm5 = '1'
054300201113     C                   endif
0544002011130107  *
054500201113     C                   If        cov06 = '1'
054600201113     C                   eval      i5mhm6 = '2C'
054700201113     C*****              eval      i51cm6 = '1'
054800201113     C                   endif
0549002011130107  *
055000201113     C                   If        cov07 = '1'
055100150928     C                   eval      i5mhm7 = '2C'
055200150929     C*****              eval      i51cm7 = '1'
055300150928     C                   endif
0554001509280107  *
055500150928     C                   If        cov08 = '1'
055600150928     C                   eval      i5mhm8 = '2C'
055700150929     C******             eval      i51cm8 = '1'
055800150928     C                   endif
0559001509280107  *
056000150928     C                   If        cov09 = '1'
056100150928     C                   eval      i5mhm9 = '2C'
056200150929     C******             eval      i51cm9 = '1'
056300150928     C                   endif
0564001509280107  *
056500150928     C                   If        cov10 = '1'
056600150928     C                   eval      i5mhm10 = '2C'
056700150929     C*******            eval      i51cm10 = '1'
056800150928     C                   endif
0569001509280107  *
057000150928     C                   If        cov11 = '1'
057100150928     C                   eval      i5mhm11 = '2C'
057200150929     C*******            eval      i51cm11 = '1'
057300150928     C                   endif
0574001509280107  *
057500150928     C                   If        cov12 = '1'
057600150928     C                   eval      i5mhm12 = '2C'
057700150929     C******             eval      i51cm12 = '1'
057800150928     C                   endif
0579000604270107  *
058000150928     C                   endif
0581000604270296  *
058200150928     C                   write     IRS95CR
0583000204150107  *
058400020415     C                   endsr
0585001601050107  ********************************************************************************
0586001601050107  *
0587001601050107  *     CALCENR - Calculate enrollment Date
0588001601050107  *
0589001601050107  ********************************************************************************
059000171215     C     calcenr       begsr
0591001712150107  *
0592001712150296 C                   eval      enrdat = empdt
0593001712150296 C                   move      empdt         datee
0594001712150296 C                   move      empdt         datec
059500171215      *           Find Medical Plan Coverage
0596001712150297 C     covkey        setll     mcovmpln                           23
0597001712150296 C                   dou       *in23 = '1'
0598001712150297 C     covkey        reade     mcovmpln                               23
0599001712150296 C                   if        *in23 = '0'
0600001712150107  *
0601002112060296 C                   If        candt <> 0 and candt < 20210101
060200171215     C                   iter
060300161111     C                   endif
0604001712150107  *
0605002112060296 C                   If        enrldt > 20211231
060600171215     C                   iter
060700171215     C                   endif
060800171215      *           Get Plan rec to chk for MED
0609001712150297 C     plnkey        chain     plnmst                             24
0610001712150296 C                   if        *in24 = '0'
0611001601050107  *
0612001601050297 C     codkey        chain     codes                              25
0613001601050296 C                   if        *in25 = '0'
0614001601050107  *
061500160105     C                   if        action <> 'M'
061600160105     C                   iter
061700160105     C                   endif
0618001601050107  *
061900220111      * get the Initial Eligibility Date
062000220111     c                   move      #ktrst        parmtr
062100220111     c                   move      #ksub#        parmsu
062200220111     c                   move      plplan        parmpln
062300220111     c                   move      empdt         geteldt_empdt     8
062400220111     c                   clear                   parmenr
062500220111     c                   clear                   parmerr
062600220111     c                   call      'GETELDT'
062700220111     c                   parm                    parmtsp
062800220111     c                   parm                    parmedt
062900220111     c                   parm                    parmenr
063000220111     c                   parm                    parmerr
063100220111      *
063200220111      * if no error returned from geteldt then check for override needed
063300220111     c                   if        parmerr = *blank
063400220111     c                   move      parmenr       enrdat            8 0
063500220111     C                   endif
0636002201110107  *
063700220111     C                   leavesr
0638002201110107  *
063900161109     C                   endif
0640001611090107  *                                                                     **********
064100161109     C                   endif
0642001611090107  *                                                                     **********
064300161103     C                   endif
0644001611030107  *                                                                     **********
064500161103     C                   enddo
0646001611030107  *                                                                     **********
064700161103     C                   endsr
0648001612300107  ********************************************************************************
0649001612300107  *
0650001612300107  *     GETCONT - Break out contact name
0651001612300107  *
0652001612300107  ********************************************************************************
065300161230     C     getcont       begsr
0654002201100107  *
065500220110     C                   movel     *blanks       conf12
065600220110     C                   movel     *blanks       conl20
065700220110     C                   movel     *blanks       contmi
065800220110     C                   movel     *blanks       contarx
0659002201100107  *
066000220110     C                   movea     cont30        contar
066100220110     C                   eval      z = 1
0662002201100107  *          First Name
066300220110    3C     1             DO        30            X
066400220110    4C                   IF        (contar(X) >= 'A' and
066500220110    4C                             contar(X) <= 'Z') or
066600220110    4C                             (contar(X) >= '0' and
066700220110    4C                             contar(X) <= '9') or
066800220110    4C                             contar(X) = '.'  or
066900220104    4C                             contar(X) = ''''  or
067000220104    4C                             contar(X) = '-'
067100161230     C                   eval      contarx(z) = contar(x)
067200161230     C                   eval      z = z + 1
067300161230    4C                   endif
0674001612300291  *
067500161230    4C                   IF        contar(X) = ' '
067600161230     C                   leave
067700161230    4C                   endif
067800161230    3C                   enddo
0679001612300291  *
068000161230     C                   movea     contarx       conf12
068100161230     C                   movel     *blanks       contarx
068200161230     C                   eval      x = x + 1
0683001612300291  *         MI or last name
068400161230     C                   eval      z = 1
068500161230    3C                   DOU       X = 30
068600161230    4C                   IF        (contar(X) >= 'A' and
068700161230    4C                             contar(X) <= 'Z') or
068800161230    4C                             (contar(X) >= '0' and
068900161230    4C                             contar(X) <= '9') or
069000161230    4C                             contar(X) = '.'  or
069100161230    4C                             contar(X) = ''''  or
069200161230    4C                             contar(X) = '-'
069300161230     C                   eval      contarx(z) = contar(x)
069400161230     C                   eval      z = z + 1
069500161230    4C                   endif
0696001612300291  *
069700161230    4C                   IF        contar(X) = ' '
069800161230     C                   leave
069900161230    4C                   endif
070000161230     C                   eval      x = x + 1
070100161230    3C                   enddo
0702001612300291  *
070300161230    4C                   IF        z = 2 or contarx(2) = '.'
070400161230     C                   movea     contarx(1)    contmi
070500161230     C                   eval      x = x + 1
070600161230     C                   else
070700161230     C                   movea     contarx       conl20
070800161230     C                   leavesr
070900161230     C                   endif
0710001612300111  *
0711001612300291  *         Last name
071200161230     C                   movel     *blanks       contarx
071300161230     C                   eval      z = 1
071400161230    3C                   DOU       X = 30
071500161230    4C                   IF        (contar(X) >= 'A' and
071600161230    4C                             contar(X) <= 'Z') or
071700161230    4C                             (contar(X) >= '0' and
071800161230    4C                             contar(X) <= '9') or
071900161230    4C                             contar(X) = '.'  or
072000161230    4C                             contar(X) = ' '  or
072100161230    4C                             contar(X) = ''''  or
072200161230    4C                             contar(X) = '-'
072300161230     C                   eval      contarx(z) = contar(x)
072400161230     C                   eval      z = z + 1
072500161230    4C                   endif
0726001612300291  *
072700201201     C                   eval      x = x + 1
072800201201    3C                   enddo
0729002012010291  *
073000201201     C                   movea     contarx       conl20
0731002012010111  *
073200201201     C                   endsr
0733001701030107  ********************************************************************************
0734002012010107  *
0735001701030107  *     GETADDR - Strip Addr fields of unwanted chars
0736002012010107  *
0737001701030107  ********************************************************************************
073800170103     C     getaddr       begsr
0739002012010107  *
074000201201     C                   movel     *blanks       addr30x
074100201201     C                   movel     *blanks       addrarx
0742002012010107  *
074300201201     C                   movea     addr30        addrar
074400170103     C                   eval      z = 1
0745002012010107  *
074600201201    3C     1             DO        30            X
074700180103    4C                   IF        (addrar(X) >= 'A' and
074800180103    4C                             addrar(X) <= 'Z') or
074900180103    4C                             (addrar(X) >= '0' and
075000180103    4C                             addrar(X) <= '9') or
075100180103    4C                             addrar(X) = ' '  or
075200180103    4C                             addrar(X) = '/'  or
075300170103    4C                             addrar(X) = '-'
075400180103     C                   eval      addrarx(z) = addrar(x)
075500180103     C                   eval      z = z + 1
075600180103    4C                   endif
075700180103    3C                   enddo
0758001801030291  *
075900180103     C                   movea     addrarx       addr30x
0760001801030111  *
076100180103     C                   endsr
0762002201190107  ********************************************************************************
0763002201190107  *
0764002201190107  *     GETNAME - Strip Name fields of unwanted chars
0765002201190107  *
0766002201190107  ********************************************************************************
076700220119     C     getname       begsr
0768002201190107  *
076900220119     C                   movel     *blanks       name40x
077000220119     C                   movel     *blanks       namearx
0771002201190107  *
077200220119     C                   movea     name40        namear
077300220119     C                   eval      z = 1
0774002201190107  *
077500220119    3C     1             DO        40            X
077600220119    4C                   IF        (namear(X) >= 'A' and
077700220119    4C                             namear(X) <= 'Z') or
077800220119    4C                             (namear(X) >= '0' and
077900220119    4C                             namear(X) <= '9') or
078000220119    4C                             namear(X) = ' '  or
078100220119    4C                             namear(X) = '&'  or
078200220119    4C                             namear(X) = ''''  or
078300220119    4C                             namear(X) = '"'  or
078400220119    4C                             namear(X) = '('  or
078500220119    4C                             namear(X) = ')'  or
078600220119    4C                             namear(X) = '-'
078700220119     C                   eval      namearx(z) = namear(x)
078800220119     C                   eval      z = z + 1
078900220119    4C                   else
079000220119     C                   eval      namearx(z) = ' '
079100220119     C                   eval      z = z + 1
079200220119    4C                   endif
079300220119    3C                   enddo
0794002201190291  *
079500220119     C                   movea     namearx       name40x
0796002201190111  *
079700220119     C                   endsr
