0001000204020002  *****************************************************************************
000200150915      * IRS95CBLR  Group Benefit Services                                         *
000300150924      *            WRITTEN BY - R.L.J.                                            *
000400170224      *            AATE - 12/2016                                                 *
000500161220      *  DESCRIPTION - Build file IRS 1095C for a TSA for 2016                    *
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
001800190618     FCODES     IF   E           K DISK
0019001906180020 FIRS95CP   UF A E           K DISK
0020001906180025  *
002100190618      *
002200190618     D                 DS
002300190618     D  contar         S              1A   DIM(30)
002400190618     D  contarx        S              1A   DIM(30)
002500190618     D  conlarx        S              1A   DIM(30)
002600190618     D  addrar         S              1A   DIM(30)
002700190618     D  addrarx        S              1A   DIM(30)
002800190618    * *
002900190618    * *
003000190618     D                 DS
003100190618     D @KEYPRM                 1     10A
003200190618     D #KTRST                  1      3S 0
003300190618     D #KSUB#                  4      6S 0
003400190618     D #KACCT                  7     10S 0
0035001906180025  *
0036001906180250 D                 DS
0037001906180251 D azip                    1      9  0
0038001906180251 D  azip9                  1      9
0039001906180025  *
0040001906180250 D                 DS
0041001906180251 D zip                     1      9  0
0042001906180251 D  mzip9                  1      9
0043001906180025  *
0044001906180250 D                 DS
0045001906180251 D rnewpd                  1      2  0
0046001906180251 D  svplst                 1      2
0047001906180025  *
0048001906180250 D                 DS
0049001906180251 D mbenrl                  1      8  0
0050001906180251 D  enrmm                  5      6
0051001906180025  *
0052001906180250 D                 DS
0053001906180251 D   emprinfo              1    241
0054001906180251 D    i5enm1               1     40
0055001906180251 D    i5enm2              41     80
0056001509280251 D    i5ead1              81    110
0057001906180251 D    i5ead2             111    140
0058001906180251 D    i5ecty             141    160
0059001906180251 D    i5est              161    162
0060001612200251 D    i5ezip             163    171
0061001509280251 D    i5ephn             172    181
0062001509280251 D    i5epex             182    189
0063001509280251 D    i5eid              190    201
0064001612300251 D    i5ecfn             202    221
0065001612300251 D    i5ecln             222    241
0066001509280025  *
0067001509280250 D                 DS
0068001509280251 D   covall                1     12
0069001509280251 D    cov01                1      1
0070001509280251 D    cov02                2      2
0071001509280251 D    cov03                3      3
0072001509280251 D    cov04                4      4
0073001509280251 D    cov05                5      5
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
0095001701260251 D  datee                          D   DATFMT(*ISO)
0096001701260251 D  days                          5S 0
0097001701260251 D  enrdat                        8S 0
0098001701260251 D  sal92                         9S 2
0099001701260251 D  mseq#                         2  0 INZ(0)
0100001701260251 D  sps                           1
0101001701260251 D  deplif                        1
0102001701260251 D  trst600                       3  0 INZ(600)
0103001701260251 D  sub#3                         3  0 INZ(3)
0104001701260251 D  addr30                       30
0105001701260251 D  addr30x                      30
0106001701260251 D  cont30                       30
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
0160001601050291  *        debug Shit
0161001601050296 C                   if        mbssno = 216084030
0162001601050296 C                   eval      mbssno = mbssno
0163001509280296 C                   endif
0164001601050291  *
0165001601050296 C                   if        mbenrl = termdt
0166001601050296 C                   iter
0167001601050296 C                   endif
0168001509280291  *
0169001612300296 C                   If        mbenrl < 20170101 and
0170001612200296 C                             (termdt = 0 or termdt > 20151231)
0171001509280291 C                   exsr      bldmbr
0172000605040291  *
0173001509280297 C                   endif                                                  *in21 = '1'
0174001509280297 C                   endif                                                  *in21 = '1'
0175001509280291  *
0176001509280297 C                   enddo                                                  *in21 = '1'
0177001509280291  *
0178001509280297 C                   endif                                                  *in21 = '1'
0179000605040291  *
0180000204020297 C                   movel     '1'           *inlr
0181000204020297 C                   return
0182000605040291  *
0183000605040107  ********************************************************************************
0184000204020107  *
0185001509150107  *     BLDACC - Build Account portion of record
0186000204020107  *
0187000204020107  ********************************************************************************
018800150915     C     bldacc        begsr
0189000604270107  *
019000150915     C                   movel(P)  acnam1        i5enm1
019100150915     C                   movel(P)  acnam2        i5enm2
019200150915     C                   movel(P)  aaddr1        i5ead1
0193001701030107  *
019400170103     C                   movel(P)  aaddr1        addr30
019500170103     C                   exsr      getaddr
019600170103     C                   movel(P)  addr30x       i5ead1
0197001701030107  *
019800170103     C                   movel(P)  aaddr2        addr30
019900170103     C                   exsr      getaddr
020000170103     C                   movel(P)  addr30x       i5ead2
0201001701030107  *
020200150915     C                   movel(P)  acity         i5ecty
020300150915     C                   movel(P)  astate        i5est
020400161220     C                   movel     azip9         i5ezip
0205001612200296 C**                 If        i5ezp4 = '0000'
020600161220     C**                 movel(P)  *blanks       i5ezp4
020700161220     C**                 endif
020800150915     C                   movel     aarea         i5ephn
020900150915     C                   move      aphone        i5ephn
0210001612300107  *
021100161230     C                   movel     contac        cont30
021200161230     C                   exsr      getcont
021300161230     C                   movel     conf12        i5ecfn
021400161230     C                   movel     conl20        i5ecln
0215001612300107  *
0216001509300291  *        Get Acc 2 Record
0217001509300297 C     ac2key        chain     ac2mst                             31
0218001509300296 C                   If        *in31 = '0' and a2tax_id# <> 0
021900150930     C                   movel(P)  a2tax_id#     i5eid
022000150930     C                   else
022100150928     C                   movel(P)  @keyprm       i5eid
022200150930     C                   endif
0223001509150107  *                                                                     **********
022400150915     C                   endsr
0225001509150107  ********************************************************************************
0226001509150107  *
0227001509150107  *     BLDMBR - Build Member record
0228001509150107  *
0229001509150107  ********************************************************************************
023000150915     C     bldmbr        begsr
0231001509150107  *
0232001509280296 C                   clear                   irs95cr
0233001509280107  *
0234001509280296 C                   eval      emprinfo = svempr
0235001509150107  *
023600150928     C                   movel     mbssno        i5mssn
023700150928     C                   movel     mfname        i5mfnm
023800150928     C                   move      mmi           i5mmi
023900150928     C                   movel     mlname        i5mlnm
0240001701030107  *
024100170103     C                   movel(P)  addr1         addr30
024200170103     C                   exsr      getaddr
024300170103     C                   movel(P)  addr30x       i5mad1
0244001701030107  *
024500170103     C                   movel(P)  addr2         addr30
024600170103     C                   exsr      getaddr
024700170103     C                   movel(P)  addr30x       i5mad2
0248001701030107  *
024900150928     C                   movel     city          i5mcty
025000150928     C                   movel     state         i5mst
025100150928     C                   movel     mlname        i5mlnm
025200150928     C                   movel     mlname        i5mlnm
025300150928     C                   movel     mlname        i5mlnm
025400161220     C                   movel     mzip9         i5mzip
0255001612200296 C***                If        i5mzp4 = '0000'
025600161220     C***                movel(P)  *blanks       i5mzp4
025700161220     C***                endif
025800151014     C                   movel(P)  fill66        i5meml
0259001509280107  *        Person 1 info (same as mbr)
0260001509290107  *          Leave blank for FI - Per KT
026100150929     C*******            movel     mbssno        i51ssn
026200150929     C**                 movel     mfname        i51fnm
026300150929     C**                 move      mmi           i51mi
026400150929     C********           movel     mlname        i51lnm
0265001509280107  *        Plan Offer Info
026600160105      *           Calc Enroll Dt if Enroll Dt is prior to Employ Dt
0267001601050296 C                   If        mbenrl < empdt and
0268001612200296 C                             (mbenrl > 20150601 or empdt > 20150601)
026900161027     C                   move      mbenrl        datea
027000161027     C                   move      empdt         dateb
027100161027     C     dateb         subdur    datea         days:*D
0272001610270296 C                   If        days > 31
027300161027     C                   exsr      calcenr
027400161027     C                   eval      mbenrl = enrdat
027500161027     C                   endif
027600161027     C                   endif
0277001610270107  *
027800161027      *
0279001701030296 C******             If        mbenrl < 20160201
028000170103     C***                eval      i5mpls = '01'
028100170103     C**                 else
028200170103     C************       eval      i5mpls = svplst
028300170103     C******             endif
028400180129      *           All 2016 Months?
0285001801290296 C                   If        mbenrl < 20160201 and
0286001801290296 C                             (termdt = 0 or termdt > 20161231)
028700180129     C                   eval      i5mcall = '1A'
028800180129     C                   else
028900180129      *               Jan?
0290001801290296 C                   If        mbenrl < 20160201 and
0291001801290296 C                             (termdt = 0 or termdt > 20160101)
029200180129     C                   eval      i5mcm1 = '1A'
029300180129     C                   else
029400180129     C                   eval      i5mcm1 = '1H'
029500161027     C                   endif
029600180129      *               Feb?
0297001801290296 C                   If        mbenrl < 20160301 and
0298001801290296 C                             (termdt = 0 or termdt > 20160201)
029900180129     C                   eval      i5mcm2 = '1A'
030000161027     C                   else
030100161027     C                   eval      i5mcm2 = '1H'
030200161027     C                   endif
030300150928      *               Mar?
0304001612200296 C                   If        mbenrl < 20160401 and
0305001612200296 C                             (termdt = 0 or termdt > 20160301)
030600150928     C                   eval      i5mcm3 = '1A'
030700160106     C                   else
030800160106     C                   eval      i5mcm3 = '1H'
030900150928     C                   endif
031000150928      *               Apr?
0311001612200296 C                   If        mbenrl < 20160501 and
0312001612200296 C                             (termdt = 0 or termdt > 20160401)
031300150928     C                   eval      i5mcm4 = '1A'
031400160106     C                   else
031500160106     C                   eval      i5mcm4 = '1H'
031600150928     C                   endif
031700150928      *               May?
0318001612200296 C                   If        mbenrl < 20160601 and
0319001612200296 C                             (termdt = 0 or termdt > 20160501)
032000150928     C                   eval      i5mcm5 = '1A'
032100160106     C                   else
032200160106     C                   eval      i5mcm5 = '1H'
032300150928     C                   endif
032400150928      *               Jun?
0325001612200296 C                   If        mbenrl < 20160701 and
0326001612200296 C                             (termdt = 0 or termdt > 20160601)
032700150928     C                   eval      i5mcm6 = '1A'
032800160106     C                   else
032900160106     C                   eval      i5mcm6 = '1H'
033000150928     C                   endif
033100150928      *               Jul?
0332001612200296 C                   If        mbenrl < 20160801 and
0333001612200296 C                             (termdt = 0 or termdt > 20160701)
033400150928     C                   eval      i5mcm7 = '1A'
033500160106     C                   else
033600160106     C                   eval      i5mcm7 = '1H'
033700150928     C                   endif
033800150928      *               Aug?
0339001612200296 C                   If        mbenrl < 20160901 and
0340001612200296 C                             (termdt = 0 or termdt > 20160801)
034100150928     C                   eval      i5mcm8 = '1A'
034200160106     C                   else
034300160106     C                   eval      i5mcm8 = '1H'
034400150928     C                   endif
034500150928      *               Sep?
0346001612200296 C                   If        mbenrl < 20161001 and
0347001612200296 C                             (termdt = 0 or termdt > 20160901)
034800150928     C                   eval      i5mcm9 = '1A'
034900160106     C                   else
035000160106     C                   eval      i5mcm9 = '1H'
035100150928     C                   endif
035200150928      *               Oct?
0353001612200296 C                   If        mbenrl < 20161101 and
0354001612200296 C                             (termdt = 0 or termdt > 20161001)
035500150928     C                   eval      i5mcm10 = '1A'
035600160106     C                   else
035700160106     C                   eval      i5mcm10 = '1H'
035800150928     C                   endif
035900150928      *               Nov?
0360001612200296 C                   If        mbenrl < 20161201 and
0361001612200296 C                             (termdt = 0 or termdt > 20161101)
036200150928     C                   eval      i5mcm11 = '1A'
036300160106     C                   else
036400160106     C                   eval      i5mcm11 = '1H'
036500150928     C                   endif
036600150928      *               Dec?
0367001612200296 C                   If        mbenrl < 20170101 and
0368001612200296 C                             (termdt = 0 or termdt > 20161201)
036900150928     C                   eval      i5mcm12 = '1A'
037000160106     C                   else
037100160106     C                   eval      i5mcm12 = '1H'
037200150928     C                   endif
0373001509280107  *
037400150928     C                   endif
0375001509280107  *
0376001509280107  *        Determine Coverage Time Frame for Member
037700150928     C                   eval      covall = '000000000000'
0378000604270107  *
037900150928      *           Find Medical Plan Coverage
0380001509280297 C     covkey        setll     mcovmpln                           23
0381001509280296 C                   dou       *in23 = '1'
0382001509280297 C     covkey        reade     mcovmpln                               23
0383001509280296 C                   if        *in23 = '0'
0384001509280107  *
0385001612200296 C                   If        candt <> 0 and candt < 20160101
038600150928     C                   iter
038700150928     C                   endif
0388001509280107  *
0389001612200296 C                   If        enrldt > 20161231
039000150928     C                   iter
039100150928     C                   endif
039200150928      *           Get Plan rec to chk for MED
0393001509280297 C     plnkey        chain     plnmst                             24
0394001509280296 C                   if        *in24 = '0'
0395001509280107  *
0396001509280297 C     codkey        chain     codes                              25
0397001509280296 C                   if        *in25 = '0'
0398001509280107  *
039900150928     C                   if        action <> 'M'
040000150928     C                   iter
040100150928     C                   endif
0402001509280107  *
040300161220      *           All 2016 Months?
0404001612200296 C                   If        enrldt < 20160201 and
0405001612200296 C                             (candt = 0 or candt > 20161231)
040600160105     C                   eval      i5mhall = '2C'
040700160105     C                   eval      covall = '111111111111'
040800160105     C                   leave
040900160105     C                   endif
041000150928      *               Jan?
0411001612200296 C                   If        enrldt < 20160201 and
0412001612200296 C                             (candt = 0 or candt > 20160101)
041300150928     C                   eval      cov01 = '1'
041400150928     C                   endif
041500150928      *               Feb?
0416001612200296 C                   If        enrldt < 20160301 and
0417001612200296 C                             (candt = 0 or candt > 20160201)
041800150928     C                   eval      cov02 = '1'
041900150928     C                   endif
042000150928      *               Mar?
0421001612200296 C                   If        enrldt < 20160401 and
0422001612200296 C                             (candt = 0 or candt > 20160301)
042300150928     C                   eval      cov03 = '1'
042400150928     C                   endif
042500150928      *               Apr?
0426001612200296 C                   If        enrldt < 20160501 and
0427001612200296 C                             (candt = 0 or candt > 20160401)
042800150928     C                   eval      cov04 = '1'
042900150928     C                   endif
043000150928      *               May?
0431001612200296 C                   If        enrldt < 20160601 and
0432001612200296 C                             (candt = 0 or candt > 20160501)
043300150928     C                   eval      cov05 = '1'
043400150928     C                   endif
043500150928      *               Jun?
0436001612200296 C                   If        enrldt < 20160701 and
0437001612200296 C                             (candt = 0 or candt > 20160601)
043800150928     C                   eval      cov06 = '1'
043900150928     C                   endif
044000151002      *               Jul?
0441001612200296 C                   If        enrldt < 20160801 and
0442001612200296 C                             (candt = 0 or candt > 20160701)
044300151002     C                   eval      cov07 = '1'
044400151002     C                   endif
044500151002      *               Aug?
0446001612200296 C                   If        enrldt < 20160901 and
0447001612200296 C                             (candt = 0 or candt > 20160801)
044800151002     C                   eval      cov08 = '1'
044900151002     C                   endif
045000151002      *               Sep?
0451001612200296 C                   If        enrldt < 20161001 and
0452001612200296 C                             (candt = 0 or candt > 20160901)
045300151002     C                   eval      cov09 = '1'
045400150928     C                   endif
045500150928      *               Oct?
0456001612200296 C                   If        enrldt < 20161101 and
0457001612200296 C                             (candt = 0 or candt > 20161001)
045800150928     C                   eval      cov10 = '1'
045900150928     C                   endif
046000150928      *               Nov?
0461001612200296 C                   If        enrldt < 20161201 and
0462001612200296 C                             (candt = 0 or candt > 20161101)
046300150928     C                   eval      cov11 = '1'
046400150928     C                   endif
046500150928      *               Dec?
0466001612200296 C                   If        enrldt < 20170101 and
0467001612200296 C                             (candt = 0 or candt > 20161201)
046800150928     C                   eval      cov12 = '1'
046900150928     C                   endif
047000150928      *
047100060427     C                   endif
047200150928      *
047300150928     C                   endif
0474001509280107  *
047500060427     C                   endif
0476000303270107  *
047700150928     C                   enddo
0478001509280107  *
047900150928     C                   If        covall = '111111111111'
048000150928     C                   eval      i5mhall = '2C'
048100150929     C*****              eval      i51call = '1'
048200150928     C                   else
0483001509280107  *
048400150928     C                   If        cov01 = '1'
048500150928     C                   eval      i5mhm1 = '2C'
048600150929     C******             eval      i51cm1 = '1'
048700150928     C                   endif
0488001509280107  *
048900150928     C                   If        cov02 = '1'
049000150928     C                   eval      i5mhm2 = '2C'
049100150929     C******             eval      i51cm2 = '1'
049200150928     C                   endif
0493001509280107  *
049400150928     C                   If        cov03 = '1'
049500150928     C                   eval      i5mhm3 = '2C'
049600150929     C******             eval      i51cm3 = '1'
049700150928     C                   endif
0498001509280107  *
049900150928     C                   If        cov04 = '1'
050000150928     C                   eval      i5mhm4 = '2C'
050100150929     C******             eval      i51cm4 = '1'
050200150928     C                   endif
0503001509280107  *
050400150928     C                   If        cov05 = '1'
050500150928     C                   eval      i5mhm5 = '2C'
050600150929     C******             eval      i51cm5 = '1'
050700150928     C                   endif
0508001509280107  *
050900150928     C                   If        cov06 = '1'
051000150928     C                   eval      i5mhm6 = '2C'
051100150929     C*****              eval      i51cm6 = '1'
051200150928     C                   endif
0513001509280107  *
051400150928     C                   If        cov07 = '1'
051500150928     C                   eval      i5mhm7 = '2C'
051600150929     C*****              eval      i51cm7 = '1'
051700150928     C                   endif
0518001509280107  *
051900150928     C                   If        cov08 = '1'
052000150928     C                   eval      i5mhm8 = '2C'
052100150929     C******             eval      i51cm8 = '1'
052200150928     C                   endif
0523001509280107  *
052400150928     C                   If        cov09 = '1'
052500150928     C                   eval      i5mhm9 = '2C'
052600150929     C******             eval      i51cm9 = '1'
052700150928     C                   endif
0528001509280107  *
052900150928     C                   If        cov10 = '1'
053000150928     C                   eval      i5mhm10 = '2C'
053100150929     C*******            eval      i51cm10 = '1'
053200150928     C                   endif
0533001509280107  *
053400150928     C                   If        cov11 = '1'
053500150928     C                   eval      i5mhm11 = '2C'
053600150929     C*******            eval      i51cm11 = '1'
053700150928     C                   endif
0538001509280107  *
053900150928     C                   If        cov12 = '1'
054000150928     C                   eval      i5mhm12 = '2C'
054100150929     C******             eval      i51cm12 = '1'
054200150928     C                   endif
0543000604270107  *
054400150928     C                   endif
0545000604270296  *
054600150928     C                   write     IRS95CR
0547000204150107  *
054800020415     C                   endsr
0549001601050107  ********************************************************************************
0550001601050107  *
0551001601050107  *     CALCENR - Calculate enrollment Date
0552001601050107  *
0553001601050107  ********************************************************************************
055400160105     C     calcenr       begsr
0555001601050107  *
0556001601050296 C                   eval      enrdat = empdt
0557001601050296 C                   move      empdt         datee
0558001601050296 C                   move      empdt         datec
055900161111      *           Find Medical Plan Coverage
0560001611110297 C     covkey        setll     mcovmpln                           23
0561001611110296 C                   dou       *in23 = '1'
0562001611110297 C     covkey        reade     mcovmpln                               23
0563001611110296 C                   if        *in23 = '0'
0564001611110107  *
0565001612200296 C                   If        candt <> 0 and candt < 20160101
056600161111     C                   iter
056700161111     C                   endif
0568001611110107  *
0569001612200296 C                   If        enrldt > 20161231
057000160105     C                   iter
057100160105     C                   endif
057200160105      *           Get Plan rec to chk for MED
0573001601050297 C     plnkey        chain     plnmst                             24
0574001601050296 C                   if        *in24 = '0'
0575001601050107  *
0576001601050297 C     codkey        chain     codes                              25
0577001601050296 C                   if        *in25 = '0'
0578001601050107  *
057900160105     C                   if        action <> 'M'
058000160105     C                   iter
058100160105     C                   endif
0582001601050107  *
058300160105      *           Med Plan
0584001601050297 C     plnkey        chain     plnauxp                            29
0585001611100296 C                   If        *in29 = '0'
0586001611100107  *             Date of Hire                                            **********
0587001611100296 C                   If        pxwtpd = 'WDH'
0588001611100296 C     datee         adddur    pxwtdy:*D     dated
0589001611100296 C                   If        dated > datec
0590001611100296 C                   eval      datec = dated
059100161110     C                   endif
059200161110     C                   else
0593001611100107  *             First of Mon after Date of Hire                         **********
0594001611100296 C                   If        pxwtpd = 'WFM'
0595001611100296 C     datee         adddur    pxwtdy:*D     dated
0596001611100296 C                   adddur    1:*M          dated
0597001611100296 C                   If        dated > datec
0598001611100296 C                   eval      datec = dated
059900161110     C                   endif
060000161110     C                   else
0601001611100107  *                                                                     **********
0602001611100107  *             First Day Following Date of Hire                        **********
0603001611090296 C                   If        pxwtpd = 'WFF'
0604001611090296 C     datee         adddur    pxwtdy:*D     dated
0605001611090296 C                   adddur    1:*D          dated
0606001611090296 C                   If        dated > datec
0607001611090296 C                   eval      datec = dated
060800161109     C                   endif
060900161109     C                   endif
061000161109     C                   endif
061100161109     C                   endif
0612001611090107  *                                                                     **********
061300161109     C                   endif
0614001611090107  *                                                                     **********
061500161109     C                   endif
0616001611090107  *                                                                     **********
061700161109     C                   endif
0618001611090107  *                                                                     **********
061900161103     C                   endif
0620001611030107  *                                                                     **********
062100161103     C                   enddo
0622001611030107  *                                                                     **********
0623001611030296 C                   move      datec         enrdat
062400161103     C                   endsr
0625001612300107  ********************************************************************************
0626001612300107  *
0627001612300107  *     GETCONT - Break out contact name
0628001612300107  *
0629001612300107  ********************************************************************************
063000161230     C     getcont       begsr
0631001612300107  *
063200161230     C                   movel     *blanks       conf12
063300161230     C                   movel     *blanks       conl20
063400161230     C                   movel     *blanks       contmi
063500161230     C                   movel     *blanks       contarx
0636001612300107  *
063700161230     C                   movea     cont30        contar
063800161230     C                   eval      z = 1
0639001612300107  *          First Name
064000161230    3C     1             DO        30            X
064100161230    4C                   IF        (contar(X) >= 'A' and
064200161230    4C                             contar(X) <= 'Z') or
064300161230    4C                             (contar(X) >= '0' and
064400161230    4C                             contar(X) <= '9') or
064500161230    4C                             contar(X) = '.'  or
064600161230    4C                             contar(X) = ''''  or
064700161230    4C                             contar(X) = '-'
064800161230     C                   eval      contarx(z) = contar(x)
064900161230     C                   eval      z = z + 1
065000161230    4C                   endif
0651001612300291  *
065200161230    4C                   IF        contar(X) = ' '
065300161230     C                   leave
065400161230    4C                   endif
065500161230    3C                   enddo
0656001612300291  *
065700161230     C                   movea     contarx       conf12
065800161230     C                   movel     *blanks       contarx
065900161230     C                   eval      x = x + 1
0660001612300291  *         MI or last name
066100161230     C                   eval      z = 1
066200161230    3C                   DOU       X = 30
066300161230    4C                   IF        (contar(X) >= 'A' and
066400161230    4C                             contar(X) <= 'Z') or
066500161230    4C                             (contar(X) >= '0' and
066600161230    4C                             contar(X) <= '9') or
066700161230    4C                             contar(X) = '.'  or
066800161230    4C                             contar(X) = ''''  or
066900161230    4C                             contar(X) = '-'
067000161230     C                   eval      contarx(z) = contar(x)
067100161230     C                   eval      z = z + 1
067200161230    4C                   endif
0673001612300291  *
067400161230    4C                   IF        contar(X) = ' '
067500161230     C                   leave
067600161230    4C                   endif
067700161230     C                   eval      x = x + 1
067800161230    3C                   enddo
0679001612300291  *
068000161230    4C                   IF        z = 2 or contarx(2) = '.'
068100161230     C                   movea     contarx(1)    contmi
068200161230     C                   eval      x = x + 1
068300161230     C                   else
068400161230     C                   movea     contarx       conl20
068500161230     C                   leavesr
068600161230     C                   endif
0687001612300111  *
0688001612300291  *         Last name
068900161230     C                   movel     *blanks       contarx
069000161230     C                   eval      z = 1
069100161230    3C                   DOU       X = 30
069200161230    4C                   IF        (contar(X) >= 'A' and
069300161230    4C                             contar(X) <= 'Z') or
069400161230    4C                             (contar(X) >= '0' and
069500161230    4C                             contar(X) <= '9') or
069600161230    4C                             contar(X) = '.'  or
069700161230    4C                             contar(X) = ' '  or
069800161230    4C                             contar(X) = ''''  or
069900161230    4C                             contar(X) = '-'
070000161230     C                   eval      contarx(z) = contar(x)
070100161230     C                   eval      z = z + 1
070200161230    4C                   endif
0703001612300291  *
070400161230     C                   eval      x = x + 1
070500161230    3C                   enddo
0706001612300291  *
070700161230     C                   movea     contarx       conl20
0708001612300111  *
070900161230     C                   endsr
0710001701030107  ********************************************************************************
0711001701030107  *
0712001701030107  *     GETADDR - Strip Addr fields of unwanted chars
0713001701030107  *
0714001701030107  ********************************************************************************
071500170103     C     getaddr       begsr
0716001701030107  *
071700170103     C                   movel     *blanks       addr30x
071800170103     C                   movel     *blanks       addrarx
0719001701030107  *
072000170103     C                   movea     addr30        addrar
072100170103     C                   eval      z = 1
0722001701030107  *
072300170103    3C     1             DO        30            X
072400170103    4C                   IF        (addrar(X) >= 'A' and
072500170103    4C                             addrar(X) <= 'Z') or
072600170103    4C                             (addrar(X) >= '0' and
072700170103    4C                             addrar(X) <= '9') or
072800170103    4C                             addrar(X) = ' '  or
072900170103    4C                             addrar(X) = '/'  or
073000170103    4C                             addrar(X) = '-'
073100170103     C                   eval      addrarx(z) = addrar(x)
073200170103     C                   eval      z = z + 1
073300170103    4C                   endif
073400170103    3C                   enddo
0735001701030291  *
073600170103     C                   movea     addrarx       addr30x
0737001701030111  *
073800170103     C                   endsr
