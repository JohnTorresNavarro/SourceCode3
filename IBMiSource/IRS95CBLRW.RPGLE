0001000204020002  *****************************************************************************
000200150915      * IRS95CBLR  Group Benefit Services                                         *
000300150924      *            WRITTEN BY - R.L.J.                                            *
000400181205      *            DATE - 12/2018                                                 *
000500181205      *  DESCRIPTION - Build file IRS 1095C for a TSA for 2018                    *
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
002100161230      *
002200161230     D                 DS
002300161230     D  contar         S              1A   DIM(30)
002400161230     D  contarx        S              1A   DIM(30)
002500161230     D  conlarx        S              1A   DIM(30)
002600170103     D  addrar         S              1A   DIM(30)
002700170103     D  addrarx        S              1A   DIM(30)
002800171212    * *
002900171212    * *
003000171212     D                 DS
003100171212     D @KEYPRM                 1     10A
003200171212     D #KTRST                  1      3S 0
003300171212     D #KSUB#                  4      6S 0
003400171212     D #KACCT                  7     10S 0
0035001712120025  *
0036001712120250 D                 DS
0037001712120251 D azip                    1      9  0
0038001712120251 D  azip9                  1      9
0039001712120025  *
0040001712120250 D                 DS
0041001712120251 D zip                     1      9  0
0042001712120251 D  mzip9                  1      9
0043001712120025  *
0044001509280250 D                 DS
0045001701030251 D rnewpd                  1      2  0
0046001701030251 D  svplst                 1      2
0047001701030025  *
0048001701030250 D                 DS
0049001701030251 D mbenrl                  1      8  0
0050001701030251 D  enrmm                  5      6
0051000604270025  *
0052001509280250 D                 DS
0053001612300251 D   emprinfo              1    241
0054001509280251 D    i5enm1               1     40
0055001509280251 D    i5enm2              41     80
0056001509280251 D    i5ead1              81    110
0057001509280251 D    i5ead2             111    140
0058001509280251 D    i5ecty             141    160
0059001509280251 D    i5est              161    162
0060001612200251 D    i5ezip             163    171
0061001509280251 D    i5ephn             172    181
0062001509280251 D    i5epex             182    189
0063001509280251 D    i5eid              190    201
0064001612300251 D    i5ecfn             202    221
0065001612300251 D    i5ecln             222    241
0066002210310025  *
0067002210310250 D                 DS
0068002210310251 D   covall                1     12
0069002210310251 D    cov01                1      1
0070002210310251 D    cov02                2      2
0071002210310251 D    cov03                3      3
0072002210310251 D    cov04                4      4
0073002210310251 D    cov05                5      5
0074001509280251 D    cov06                6      6
0075001509280251 D    cov07                7      7
0076001509280251 D    cov08                8      8
0077001509280251 D    cov09                9      9
0078001509280251 D    cov10               10     10
0079001509280251 D    cov11               11     11
0080001509280251 D    cov12               12     12
008100150928      *
008200150928     D                 DS
008300150928     D plncat                  1      3
008400150928     D   cdkey1                1      1
008500150928     D   cdkey2                2      3
008600150928      *
0087000604270025  *
0088000604270250 D                 DS
0089001612300251 D  svempr                      241
0090001701260251 D  a2typ                         1    INZ('F')
0091001701260251 D  datea                          D   DATFMT(*ISO)
0092001701260251 D  dateb                          D   DATFMT(*ISO)
0093001701260251 D  datec                          D   DATFMT(*ISO)
0094001701260251 D  dated                          D   DATFMT(*ISO)
0095001902040251 D  datee                          D   DATFMT(*ISO)
0096001902040251 D  days                          5S 0
0097001902040251 D  enrdat                        8S 0
0098001902040251 D  sal92                         9S 2
0099001902040251 D  mseq#                         2  0 INZ(0)
0100001902040251 D  sps                           1
0101001902040251 D  deplif                        1
0102001902040251 D  trst600                       3  0 INZ(600)
0103001902040251 D  sub#3                         3  0 INZ(3)
0104001902040251 D  addr30                       30
0105001902040251 D  addr30x                      30
0106001902040251 D  cont30                       30
0107001701260251 D  conf12                       12
0108001701260251 D  conl20                       20
0109001701260251 D  contmi                        1
0110001701260251 D  x                             2  0
0111001701260251 D  y                             2  0
0112001701260251 D  z                             2  0
011300170126      *
011400170126    * *
011500170126     C     acckey        KLIST
011600170126     C                   KFLD                    #ktrst
011700170126     C                   KFLD                    #ksub#
011800170126     C                   KFLD                    #kacct
011900170126    * *
012000170126     C     ac2key        KLIST
012100170126     C                   KFLD                    a2typ
012200170126     C                   KFLD                    #ktrst
012300170126     C                   KFLD                    #ksub#
012400170126     C                   KFLD                    #kacct
012500161028    * *
012600170126     C     covkey        KLIST
012700170126     C                   KFLD                    mbssno
012800170126     C                   KFLD                    mseq#
012900170126     C                   KFLD                    #ktrst
013000170126     C                   KFLD                    #ksub#
013100170126    * *
013200170126     C     plnkey        KLIST
013300170126     C                   KFLD                    mctrst
013400170126     C                   KFLD                    mcsub#
013500170126     C                   KFLD                    mcplan
013600170126    * *
013700170126     C     codkey        KLIST
013800170126     C                   KFLD                    cdkey1
013900170126     C                   KFLD                    cdkey2
014000170126    * *
014100170126    * *
014200170126    * *
014300161028     C     *ENTRY        PLIST
014400161028     C                   PARM                    @PARM            10
014500161028     C                   MOVEL(P)  @PARM         @KEYPRM
014600161028    * *
0147001610260291  *        Get Account Record
0148001610260297 C     acckey        chain     accmst                             21
0149001610260296 C                   If        *in21 = '0'
0150001610260291  *
0151001610260291 C                   clear                   irs95cr
0152001509220291 C                   exsr      bldacc
0153001509280291 C                   eval      svempr = emprinfo
0154001509220291  *
015500150922      *        Locate members in TSA
0156001509160297 C     acckey        setll     memac#1                            22
0157001509220296 C                   dou       *in22 = '1'
0158001509160297 C     acckey        reade     memac#1                                22
0159001509280296 C                   if        *in22 = '0'
0160001801180291  *       Check for Non-empoyee
0161001801180296 C                   if        nonemp = 'Y'
0162001801180296 C                   iter
0163001801180296 C                   endif
0164001601050291  *        debug Shit
0165001601050296 C                   if        mbssno = 216084030
0166001601050296 C                   eval      mbssno = mbssno
0167001509280296 C                   endif
0168001601050291  *
0169001601050296 C                   if        mbenrl = termdt
0170001601050296 C                   iter
0171001601050296 C                   endif
0172001802120291  *
0173001812050296 C                   If        mbenrl < 20190101 and
0174001812050296 C                             (termdt = 0 or termdt > 20171231)
0175002202230291 C                   exsr      bldmbr
0176002202230291  *
0177002202230297 C                   endif                                                  *in21 = '1'
0178002202230297 C                   endif                                                  *in21 = '1'
0179002202230291  *
0180002202230297 C                   enddo                                                  *in21 = '1'
0181002202230291  *
0182002202230297 C                   endif                                                  *in21 = '1'
0183002202230291  *
0184002202230297 C                   movel     '1'           *inlr
0185001802120297 C                   return
0186001802120291  *
0187000605040107  ********************************************************************************
0188000204020107  *
0189001509150107  *     BLDACC - Build Account portion of record
0190000204020107  *
0191000204020107  ********************************************************************************
019200150915     C     bldacc        begsr
0193000604270107  *
019400150915     C                   movel(P)  acnam1        i5enm1
019500150915     C                   movel(P)  acnam2        i5enm2
019600150915     C                   movel(P)  aaddr1        i5ead1
0197001701030107  *
019800170103     C                   movel(P)  aaddr1        addr30
019900170103     C                   exsr      getaddr
020000170103     C                   movel(P)  addr30x       i5ead1
0201001701030107  *
020200170103     C                   movel(P)  aaddr2        addr30
020300170103     C                   exsr      getaddr
020400170103     C                   movel(P)  addr30x       i5ead2
0205001701030107  *
020600150915     C                   movel(P)  acity         i5ecty
020700150915     C                   movel(P)  astate        i5est
020800161220     C                   movel     azip9         i5ezip
0209001612200296 C**                 If        i5ezp4 = '0000'
021000161220     C**                 movel(P)  *blanks       i5ezp4
021100161220     C**                 endif
021200150915     C                   movel     aarea         i5ephn
021300150915     C                   move      aphone        i5ephn
0214001612300107  *
021500161230     C                   movel     contac        cont30
021600161230     C                   exsr      getcont
021700161230     C                   movel     conf12        i5ecfn
021800161230     C                   movel     conl20        i5ecln
0219001612300107  *
0220001509300291  *        Get Acc 2 Record
0221001509300297 C     ac2key        chain     ac2mst                             31
0222001509300296 C                   If        *in31 = '0' and a2tax_id# <> 0
022300150930     C                   movel(P)  a2tax_id#     i5eid
022400150930     C                   else
022500150928     C                   movel(P)  @keyprm       i5eid
022600150930     C                   endif
0227001509150107  *                                                                     **********
022800150915     C                   endsr
0229001509150107  ********************************************************************************
0230001509150107  *
0231001509150107  *     BLDMBR - Build Member record
0232001509150107  *
0233001509150107  ********************************************************************************
023400150915     C     bldmbr        begsr
0235001509150107  *
0236001509280296 C                   clear                   irs95cr
0237001509280107  *
0238001509280296 C                   eval      emprinfo = svempr
0239001509150107  *
024000150928     C                   movel     mbssno        i5mssn
024100150928     C                   movel     mfname        i5mfnm
024200150928     C                   move      mmi           i5mmi
024300150928     C                   movel     mlname        i5mlnm
0244001701030107  *
024500170103     C                   movel(P)  addr1         addr30
024600170103     C                   exsr      getaddr
024700170103     C                   movel(P)  addr30x       i5mad1
0248001701030107  *
024900170103     C                   movel(P)  addr2         addr30
025000170103     C                   exsr      getaddr
025100170103     C                   movel(P)  addr30x       i5mad2
0252001701030107  *
025300150928     C                   movel     city          i5mcty
025400150928     C                   movel     state         i5mst
025500150928     C                   movel     mlname        i5mlnm
025600150928     C                   movel     mlname        i5mlnm
025700150928     C                   movel     mlname        i5mlnm
025800161220     C                   movel     mzip9         i5mzip
0259001612200296 C***                If        i5mzp4 = '0000'
026000161220     C***                movel(P)  *blanks       i5mzp4
026100161220     C***                endif
026200151014     C                   movel(P)  fill66        i5meml
0263001509280107  *        Person 1 info (same as mbr)
0264001509290107  *          Leave blank for FI - Per KT
026500150929     C*******            movel     mbssno        i51ssn
026600150929     C**                 movel     mfname        i51fnm
026700150929     C**                 move      mmi           i51mi
026800150929     C********           movel     mlname        i51lnm
0269001509280107  *        Plan Offer Info
027000160105      *           Calc Enroll Dt if Enroll Dt is prior to Employ Dt
0271001601050296 C                   If        mbenrl < empdt and
0272001812050296 C                             (mbenrl > 20170601 or empdt > 20170601)
027300180104     C                   move      mbenrl        datea
027400180104     C                   move      empdt         dateb
027500180104     C     dateb         subdur    datea         days:*D
0276001801040296 C                   If        days > 31
027700180104     C                   exsr      calcenr
027800180104     C                   eval      mbenrl = enrdat
027900180104     C                   endif
028000180104     C                   endif
0281001801040107  *
028200180104      *
0283001812050296 C******             If        mbenrl < 20180201
028400180104     C***                eval      i5mpls = '01'
028500180104     C**                 else
028600180104     C************       eval      i5mpls = svplst
028700180104     C******             endif
028800181205      *           All  2018 Months?
0289001812050296 C                   If        mbenrl < 20180201 and
0290001812050296 C                             (termdt = 0 or termdt > 20181231)
029100171220     C                   eval      i5mcall = '1A'
029200171220     C                   else
029300171220      *               Jan?
0294001812050296 C                   If        mbenrl < 20180201 and
0295001812050296 C                             (termdt = 0 or termdt > 20180101)
029600171220     C                   eval      i5mcm1 = '1A'
029700171220     C                   else
029800160106     C                   eval      i5mcm1 = '1H'
029900161027     C                   endif
030000161027      *               Feb?
0301001812050296 C                   If        mbenrl < 20180301 and
0302001812050296 C                             (termdt = 0 or termdt > 20180201)
030300161027     C                   eval      i5mcm2 = '1A'
030400161027     C                   else
030500161027     C                   eval      i5mcm2 = '1H'
030600161027     C                   endif
030700150928      *               Mar?
0308001812050296 C                   If        mbenrl < 20180401 and
0309001812050296 C                             (termdt = 0 or termdt > 20180301)
031000150928     C                   eval      i5mcm3 = '1A'
031100160106     C                   else
031200160106     C                   eval      i5mcm3 = '1H'
031300150928     C                   endif
031400150928      *               Apr?
0315001812050296 C                   If        mbenrl < 20180501 and
0316001812050296 C                             (termdt = 0 or termdt > 20180401)
031700150928     C                   eval      i5mcm4 = '1A'
031800160106     C                   else
031900160106     C                   eval      i5mcm4 = '1H'
032000150928     C                   endif
032100150928      *               May?
0322001812050296 C                   If        mbenrl < 20180601 and
0323001812050296 C                             (termdt = 0 or termdt > 20180501)
032400150928     C                   eval      i5mcm5 = '1A'
032500160106     C                   else
032600160106     C                   eval      i5mcm5 = '1H'
032700150928     C                   endif
032800180206      *               Jun?
0329001812050296 C                   If        mbenrl < 20180701 and
0330001812050296 C                             (termdt = 0 or termdt > 20180601)
033100180206     C                   eval      i5mcm6 = '1A'
033200180206     C                   else
033300180206     C                   eval      i5mcm6 = '1H'
033400180206     C                   endif
033500180206      *               Jul?
0336001812050296 C                   If        mbenrl < 20180801 and
0337001812050296 C                             (termdt = 0 or termdt > 20180701)
033800180206     C                   eval      i5mcm7 = '1A'
033900180206     C                   else
034000180206     C                   eval      i5mcm7 = '1H'
034100180206     C                   endif
034200180206      *               Aug?
0343001812050296 C                   If        mbenrl < 20180901 and
0344001812050296 C                             (termdt = 0 or termdt > 20180801)
034500150928     C                   eval      i5mcm8 = '1A'
034600160106     C                   else
034700160106     C                   eval      i5mcm8 = '1H'
034800150928     C                   endif
034900180216      *               Sep?
0350001812050296 C                   If        mbenrl < 20181001 and
0351001812050296 C                             (termdt = 0 or termdt > 20180901)
035200180216     C                   eval      i5mcm9 = '1A'
035300180216     C                   else
035400180216     C                   eval      i5mcm9 = '1H'
035500180216     C                   endif
035600180216      *               Oct?
0357001812050296 C                   If        mbenrl < 20181101 and
0358001812050296 C                             (termdt = 0 or termdt > 20181001)
035900180216     C                   eval      i5mcm10 = '1A'
036000180216     C                   else
036100180216     C                   eval      i5mcm10 = '1H'
036200180216     C                   endif
036300180216      *               Nov?
0364001812050296 C                   If        mbenrl < 20181201 and
0365001812050296 C                             (termdt = 0 or termdt > 20181101)
036600150928     C                   eval      i5mcm11 = '1A'
036700160106     C                   else
036800160106     C                   eval      i5mcm11 = '1H'
036900150928     C                   endif
037000150928      *               Dec?
0371001812050296 C                   If        mbenrl < 20190101 and
0372001812050296 C                             (termdt = 0 or termdt > 20181201)
037300150928     C                   eval      i5mcm12 = '1A'
037400160106     C                   else
037500160106     C                   eval      i5mcm12 = '1H'
037600150928     C                   endif
0377001509280107  *
037800150928     C                   endif
0379001509280107  *
0380001509280107  *        Determine Coverage Time Frame for Member
038100150928     C                   eval      covall = '000000000000'
0382000604270107  *
038300150928      *           Find Medical Plan Coverage
0384001509280297 C     covkey        setll     mcovmpln                           23
0385001509280296 C                   dou       *in23 = '1'
0386001509280297 C     covkey        reade     mcovmpln                               23
0387001509280296 C                   if        *in23 = '0'
0388001509280107  *
0389001812050296 C                   If        candt <> 0 and candt < 20180101
039000150928     C                   iter
039100150928     C                   endif
0392001509280107  *
0393001812050296 C                   If        enrldt > 20181231
039400150928     C                   iter
039500150928     C                   endif
039600150928      *           Get Plan rec to chk for MED
0397001509280297 C     plnkey        chain     plnmst                             24
0398001509280296 C                   if        *in24 = '0'
0399001509280107  *
0400001509280297 C     codkey        chain     codes                              25
0401001509280296 C                   if        *in25 = '0'
0402001509280107  *
040300150928     C                   if        action <> 'M'
040400150928     C                   iter
040500150928     C                   endif
0406001802010107  *
040700181205      *           All 2018 Months?
0408001812050296 C                   If        enrldt < 20180201 and
0409001812050296 C                             (candt = 0 or candt > 20181231)
041000180201     C                   eval      i5mhall = '2C'
041100180201     C                   eval      covall = '111111111111'
041200180201     C                   leave
041300180201     C                   endif
041400180201      *               Jan?
0415001812050296 C                   If        enrldt < 20180201 and
0416001812050296 C                             (candt = 0 or candt > 20180101)
041700180201     C                   eval      cov01 = '1'
041800180201     C                   endif
041900180201      *               Feb?
0420001812050296 C                   If        enrldt < 20180301 and
0421001812050296 C                             (candt = 0 or candt > 20180201)
042200180201     C                   eval      cov02 = '1'
042300150928     C                   endif
042400150928      *               Mar?
0425001812050296 C                   If        enrldt < 20180401 and
0426001812050296 C                             (candt = 0 or candt > 20180301)
042700150928     C                   eval      cov03 = '1'
042800150928     C                   endif
042900150928      *               Apr?
0430001812050296 C                   If        enrldt < 20180501 and
0431001812050296 C                             (candt = 0 or candt > 20180401)
043200150928     C                   eval      cov04 = '1'
043300150928     C                   endif
043400150928      *               May?
0435001812050296 C                   If        enrldt < 20180601 and
0436001812050296 C                             (candt = 0 or candt > 20180501)
043700150928     C                   eval      cov05 = '1'
043800150928     C                   endif
043900150928      *               Jun?
0440001812050296 C                   If        enrldt < 20180701 and
0441001812050296 C                             (candt = 0 or candt > 20180601)
044200150928     C                   eval      cov06 = '1'
044300150928     C                   endif
044400151002      *               Jul?
0445001812050296 C                   If        enrldt < 20180801 and
0446001812050296 C                             (candt = 0 or candt > 20180701)
044700151002     C                   eval      cov07 = '1'
044800151002     C                   endif
044900151002      *               Aug?
0450001812050296 C                   If        enrldt < 20180901 and
0451001812050296 C                             (candt = 0 or candt > 20180801)
045200151002     C                   eval      cov08 = '1'
045300151002     C                   endif
045400151002      *               Sep?
0455001812050296 C                   If        enrldt < 20181001 and
0456001812050296 C                             (candt = 0 or candt > 20180901)
045700151002     C                   eval      cov09 = '1'
045800150928     C                   endif
045900150928      *               Oct?
0460001812050296 C                   If        enrldt < 20181101 and
0461001812050296 C                             (candt = 0 or candt > 20181001)
046200150928     C                   eval      cov10 = '1'
046300150928     C                   endif
046400150928      *               Nov?
0465001812050296 C                   If        enrldt < 20181201 and
0466001812050296 C                             (candt = 0 or candt > 20181101)
046700150928     C                   eval      cov11 = '1'
046800150928     C                   endif
046900150928      *               Dec?
0470001812050296 C                   If        enrldt < 20190101 and
0471001812050296 C                             (candt = 0 or candt > 20181201)
047200150928     C                   eval      cov12 = '1'
047300150928     C                   endif
047400150928      *
047500060427     C                   endif
047600150928      *
047700150928     C                   endif
0478001509280107  *
047900060427     C                   endif
0480000303270107  *
048100150928     C                   enddo
0482001509280107  *
048300150928     C                   If        covall = '111111111111'
048400150928     C                   eval      i5mhall = '2C'
048500150929     C*****              eval      i51call = '1'
048600150928     C                   else
0487001509280107  *
048800150928     C                   If        cov01 = '1'
048900150928     C                   eval      i5mhm1 = '2C'
049000150929     C******             eval      i51cm1 = '1'
049100150928     C                   endif
0492001509280107  *
049300150928     C                   If        cov02 = '1'
049400150928     C                   eval      i5mhm2 = '2C'
049500150929     C******             eval      i51cm2 = '1'
049600150928     C                   endif
0497001509280107  *
049800150928     C                   If        cov03 = '1'
049900150928     C                   eval      i5mhm3 = '2C'
050000150929     C******             eval      i51cm3 = '1'
050100150928     C                   endif
0502001509280107  *
050300150928     C                   If        cov04 = '1'
050400150928     C                   eval      i5mhm4 = '2C'
050500150929     C******             eval      i51cm4 = '1'
050600150928     C                   endif
0507001509280107  *
050800150928     C                   If        cov05 = '1'
050900150928     C                   eval      i5mhm5 = '2C'
051000150929     C******             eval      i51cm5 = '1'
051100150928     C                   endif
0512001509280107  *
051300150928     C                   If        cov06 = '1'
051400150928     C                   eval      i5mhm6 = '2C'
051500150929     C*****              eval      i51cm6 = '1'
051600150928     C                   endif
0517001509280107  *
051800150928     C                   If        cov07 = '1'
051900150928     C                   eval      i5mhm7 = '2C'
052000150929     C*****              eval      i51cm7 = '1'
052100150928     C                   endif
0522001509280107  *
052300150928     C                   If        cov08 = '1'
052400150928     C                   eval      i5mhm8 = '2C'
052500150929     C******             eval      i51cm8 = '1'
052600150928     C                   endif
0527001509280107  *
052800150928     C                   If        cov09 = '1'
052900150928     C                   eval      i5mhm9 = '2C'
053000150929     C******             eval      i51cm9 = '1'
053100150928     C                   endif
0532001509280107  *
053300150928     C                   If        cov10 = '1'
053400150928     C                   eval      i5mhm10 = '2C'
053500150929     C*******            eval      i51cm10 = '1'
053600150928     C                   endif
0537001509280107  *
053800150928     C                   If        cov11 = '1'
053900150928     C                   eval      i5mhm11 = '2C'
054000150929     C*******            eval      i51cm11 = '1'
054100150928     C                   endif
0542001509280107  *
054300150928     C                   If        cov12 = '1'
054400150928     C                   eval      i5mhm12 = '2C'
054500150929     C******             eval      i51cm12 = '1'
054600150928     C                   endif
0547000604270107  *
054800150928     C                   endif
0549000604270296  *
055000150928     C                   write     IRS95CR
0551000204150107  *
055200020415     C                   endsr
0553001601050107  ********************************************************************************
0554001601050107  *
0555001601050107  *     CALCENR - Calculate enrollment Date
0556001601050107  *
0557001601050107  ********************************************************************************
055800171215     C     calcenr       begsr
0559001712150107  *
0560001712150296 C                   eval      enrdat = empdt
0561001712150296 C                   move      empdt         datee
0562001712150296 C                   move      empdt         datec
056300171215      *           Find Medical Plan Coverage
0564001712150297 C     covkey        setll     mcovmpln                           23
0565001712150296 C                   dou       *in23 = '1'
0566001712150297 C     covkey        reade     mcovmpln                               23
0567001712150296 C                   if        *in23 = '0'
0568001712150107  *
0569001812050296 C                   If        candt <> 0 and candt < 20180101
057000171215     C                   iter
057100161111     C                   endif
0572001712150107  *
0573001812050296 C                   If        enrldt > 20181231
057400171215     C                   iter
057500171215     C                   endif
057600171215      *           Get Plan rec to chk for MED
0577001712150297 C     plnkey        chain     plnmst                             24
0578001712150296 C                   if        *in24 = '0'
0579001601050107  *
0580001601050297 C     codkey        chain     codes                              25
0581001601050296 C                   if        *in25 = '0'
0582001601050107  *
058300160105     C                   if        action <> 'M'
058400160105     C                   iter
058500160105     C                   endif
0586001601050107  *
058700160105      *           Med Plan
0588001601050297 C     plnkey        chain     plnauxp                            29
0589001712280296 C                   If        *in29 = '0'
0590001712280107  *             Date of Hire                                            **********
0591001712280296 C                   If        pxwtpd = 'WDH'
0592001712280296 C     datee         adddur    pxwtdy:*D     dated
0593001902040296 C                   If        dated > datec
0594001902040296 C                   eval      datec = dated
059500190204     C                   endif
059600190204     C                   else
0597001902040107  *             First of Mon after Date of Hire                         **********
0598001902040296 C                   If        pxwtpd = 'WFM'
0599001902040296 C     datee         adddur    pxwtdy:*D     dated
0600001902040296 C                   adddur    1:*M          dated
0601001902040296 C                   If        dated > datec
0602001902040296 C                   eval      datec = dated
060300190204     C                   endif
060400190204     C                   else
0605001902040107  *                                                                     **********
0606001611100107  *             First Day Following Date of Hire                        **********
0607001611090296 C                   If        pxwtpd = 'WFF'
0608001611090296 C     datee         adddur    pxwtdy:*D     dated
0609001611090296 C                   adddur    1:*D          dated
0610001611090296 C                   If        dated > datec
0611001611090296 C                   eval      datec = dated
061200161109     C                   endif
061300161109     C                   endif
061400161109     C                   endif
061500161109     C                   endif
0616001611090107  *                                                                     **********
061700161109     C                   endif
0618001611090107  *                                                                     **********
061900161109     C                   endif
0620001611090107  *                                                                     **********
062100161109     C                   endif
0622001611090107  *                                                                     **********
062300161103     C                   endif
0624001611030107  *                                                                     **********
062500161103     C                   enddo
0626001611030107  *                                                                     **********
0627001611030296 C                   move      datec         enrdat
062800161103     C                   endsr
0629001612300107  ********************************************************************************
0630001612300107  *
0631001612300107  *     GETCONT - Break out contact name
0632001612300107  *
0633001612300107  ********************************************************************************
063400161230     C     getcont       begsr
0635001612300107  *
063600161230     C                   movel     *blanks       conf12
063700161230     C                   movel     *blanks       conl20
063800161230     C                   movel     *blanks       contmi
063900161230     C                   movel     *blanks       contarx
0640001612300107  *
064100161230     C                   movea     cont30        contar
064200161230     C                   eval      z = 1
0643001612300107  *          First Name
064400161230    3C     1             DO        30            X
064500161230    4C                   IF        (contar(X) >= 'A' and
064600161230    4C                             contar(X) <= 'Z') or
064700161230    4C                             (contar(X) >= '0' and
064800161230    4C                             contar(X) <= '9') or
064900161230    4C                             contar(X) = '.'  or
065000161230    4C                             contar(X) = ''''  or
065100161230    4C                             contar(X) = '-'
065200161230     C                   eval      contarx(z) = contar(x)
065300161230     C                   eval      z = z + 1
065400161230    4C                   endif
0655001612300291  *
065600161230    4C                   IF        contar(X) = ' '
065700161230     C                   leave
065800161230    4C                   endif
065900161230    3C                   enddo
0660001612300291  *
066100161230     C                   movea     contarx       conf12
066200161230     C                   movel     *blanks       contarx
066300161230     C                   eval      x = x + 1
0664001612300291  *         MI or last name
066500161230     C                   eval      z = 1
066600161230    3C                   DOU       X = 30
066700161230    4C                   IF        (contar(X) >= 'A' and
066800161230    4C                             contar(X) <= 'Z') or
066900161230    4C                             (contar(X) >= '0' and
067000161230    4C                             contar(X) <= '9') or
067100161230    4C                             contar(X) = '.'  or
067200161230    4C                             contar(X) = ''''  or
067300161230    4C                             contar(X) = '-'
067400161230     C                   eval      contarx(z) = contar(x)
067500161230     C                   eval      z = z + 1
067600161230    4C                   endif
0677001612300291  *
067800161230    4C                   IF        contar(X) = ' '
067900161230     C                   leave
068000161230    4C                   endif
068100161230     C                   eval      x = x + 1
068200161230    3C                   enddo
0683001612300291  *
068400161230    4C                   IF        z = 2 or contarx(2) = '.'
068500161230     C                   movea     contarx(1)    contmi
068600161230     C                   eval      x = x + 1
068700161230     C                   else
068800161230     C                   movea     contarx       conl20
068900161230     C                   leavesr
069000161230     C                   endif
0691001612300111  *
0692001612300291  *         Last name
069300161230     C                   movel     *blanks       contarx
069400161230     C                   eval      z = 1
069500161230    3C                   DOU       X = 30
069600161230    4C                   IF        (contar(X) >= 'A' and
069700161230    4C                             contar(X) <= 'Z') or
069800161230    4C                             (contar(X) >= '0' and
069900161230    4C                             contar(X) <= '9') or
070000161230    4C                             contar(X) = '.'  or
070100161230    4C                             contar(X) = ' '  or
070200161230    4C                             contar(X) = ''''  or
070300161230    4C                             contar(X) = '-'
070400161230     C                   eval      contarx(z) = contar(x)
070500161230     C                   eval      z = z + 1
070600161230    4C                   endif
0707001612300291  *
070800161230     C                   eval      x = x + 1
070900161230    3C                   enddo
0710001612300291  *
071100161230     C                   movea     contarx       conl20
0712001612300111  *
071300161230     C                   endsr
0714001701030107  ********************************************************************************
0715001701030107  *
0716001701030107  *     GETADDR - Strip Addr fields of unwanted chars
0717001701030107  *
0718001701030107  ********************************************************************************
071900170103     C     getaddr       begsr
0720001701030107  *
072100170103     C                   movel     *blanks       addr30x
072200170103     C                   movel     *blanks       addrarx
0723001701030107  *
072400170103     C                   movea     addr30        addrar
072500170103     C                   eval      z = 1
0726001701030107  *
072700180103    3C     1             DO        30            X
072800180103    4C                   IF        (addrar(X) >= 'A' and
072900180103    4C                             addrar(X) <= 'Z') or
073000180103    4C                             (addrar(X) >= '0' and
073100180103    4C                             addrar(X) <= '9') or
073200180103    4C                             addrar(X) = ' '  or
073300180103    4C                             addrar(X) = '/'  or
073400170103    4C                             addrar(X) = '-'
073500180103     C                   eval      addrarx(z) = addrar(x)
073600180103     C                   eval      z = z + 1
073700180103    4C                   endif
073800180103    3C                   enddo
0739001801030291  *
074000180103     C                   movea     addrarx       addr30x
0741001801030111  *
074200180103     C                   endsr
