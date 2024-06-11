0001000204020002  *****************************************************************************
000200150915      * IRS95CBLR  Group Benefit Services                                         *
000300150924      *            WRITTEN BY - R.L.J.                                            *
000400191203      *            DATE - 12/2019                                                 *
000500191203      *  DESCRIPTION - Build file IRS 1095C for a TSA for 2019                    *
000600150924      *                                                                           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900201028      *  rlj 12/06/2019 Add new fields now mandated bu the IRS to the             *
001000201028      *                 output file IRS96CP.                           *
001100201028      *  rlj 12/10/2019 Change the date selection criteria to locate data         *
001200201028      *                 for the 2019 calendar year.                    *
001300201028      *  rlj 01/08/2020 Use new Waiting Period codes to determine plan            *
001400201028      *                 coverage start dates.                          *
0015001509170018 F******************************************************************
0016001612120019 FACCMST    IF   E           K DISK
0017001612120019 FAC2MST    IF   E           K DISK
001800161212     FMCOVMPLN  IF   E           K DISK
001900161212     FMEMAC#1   IF   E           K DISK
002000161212     FPLNMST    IF   E           K DISK
002100161212     FPLNAUXP   IF   E           K DISK
002200161212     FCODES     IF   E           K DISK
0023001612120020 FIRS95CP   UF A E           K DISK
0024001509240025  *
002500161230      *
002600161230     D                 DS
002700161230     D  contar         S              1A   DIM(30)
002800161230     D  contarx        S              1A   DIM(30)
002900161230     D  conlarx        S              1A   DIM(30)
003000170103     D  addrar         S              1A   DIM(30)
003100170103     D  addrarx        S              1A   DIM(30)
003200221031    * *
003300221031    * *
003400221031     D                 DS
003500221031     D @KEYPRM                 1     10A
003600221031     D #KTRST                  1      3S 0
003700221031     D #KSUB#                  4      6S 0
003800221031     D #KACCT                  7     10S 0
0039002210310025  *
0040002210310250 D                 DS
0041002210310251 D azip                    1      9  0
0042001712120251 D  azip9                  1      9
0043001712120025  *
0044001712120250 D                 DS
0045001712120251 D zip                     1      9  0
0046001712120251 D  mzip9                  1      9
0047001712120025  *
0048001509280250 D                 DS
0049001701030251 D rnewpd                  1      2  0
0050001701030251 D  svplst                 1      2
0051001701030025  *
0052001701030250 D                 DS
0053001701030251 D mbenrl                  1      8  0
0054001701030251 D  enrmm                  5      6
0055000604270025  *
0056001509280250 D                 DS
0057001612300251 D   emprinfo              1    241
0058001509280251 D    i5enm1               1     40
0059001509280251 D    i5enm2              41     80
0060001509280251 D    i5ead1              81    110
0061001509280251 D    i5ead2             111    140
0062001509280251 D    i5ecty             141    160
0063001509280251 D    i5est              161    162
0064001612200251 D    i5ezip             163    171
0065001509280251 D    i5ephn             172    181
0066001509280251 D    i5epex             182    189
0067001509280251 D    i5eid              190    201
0068001612300251 D    i5ecfn             202    221
0069001612300251 D    i5ecln             222    241
0070001509280025  *
0071001509280250 D                 DS
0072001509280251 D   covall                1     12
0073001509280251 D    cov01                1      1
0074001509280251 D    cov02                2      2
0075001509280251 D    cov03                3      3
0076001509280251 D    cov04                4      4
0077001509280251 D    cov05                5      5
0078001509280251 D    cov06                6      6
0079001509280251 D    cov07                7      7
0080001509280251 D    cov08                8      8
0081001509280251 D    cov09                9      9
0082001509280251 D    cov10               10     10
0083001509280251 D    cov11               11     11
0084001509280251 D    cov12               12     12
008500150928      *
008600150928     D                 DS
008700150928     D plncat                  1      3
008800150928     D   cdkey1                1      1
008900150928     D   cdkey2                2      3
009000150928      *
0091000604270025  *
0092000604270250 D                 DS
0093001612300251 D  svempr                      241
0094001701260251 D  a2typ                         1    INZ('F')
0095001701260251 D  datea                          D   DATFMT(*ISO)
0096001701260251 D  dateb                          D   DATFMT(*ISO)
0097001701260251 D  datec                          D   DATFMT(*ISO)
0098001701260251 D  dated                          D   DATFMT(*ISO)
0099001902040251 D  datee                          D   DATFMT(*ISO)
0100001902040251 D  days                          5S 0
0101001902040251 D  enrdat                        8S 0
0102001902040251 D  sal92                         9S 2
0103001902040251 D  mseq#                         2  0 INZ(0)
0104001902040251 D  sps                           1
0105001902040251 D  deplif                        1
0106001902040251 D  trst600                       3  0 INZ(600)
0107001902040251 D  sub#3                         3  0 INZ(3)
0108001902040251 D  addr30                       30
0109001902040251 D  addr30x                      30
0110001902040251 D  cont30                       30
0111001701260251 D  conf12                       12
0112001701260251 D  conl20                       20
0113001701260251 D  contmi                        1
0114001701260251 D  x                             2  0
0115001701260251 D  y                             2  0
0116001701260251 D  z                             2  0
011700170126      *
011800170126    * *
011900170126     C     acckey        KLIST
012000170126     C                   KFLD                    #ktrst
012100170126     C                   KFLD                    #ksub#
012200170126     C                   KFLD                    #kacct
012300170126    * *
012400170126     C     ac2key        KLIST
012500170126     C                   KFLD                    a2typ
012600170126     C                   KFLD                    #ktrst
012700170126     C                   KFLD                    #ksub#
012800170126     C                   KFLD                    #kacct
012900161028    * *
013000170126     C     covkey        KLIST
013100170126     C                   KFLD                    mbssno
013200170126     C                   KFLD                    mseq#
013300170126     C                   KFLD                    #ktrst
013400170126     C                   KFLD                    #ksub#
013500170126    * *
013600170126     C     plnkey        KLIST
013700170126     C                   KFLD                    mctrst
013800170126     C                   KFLD                    mcsub#
013900170126     C                   KFLD                    mcplan
014000170126    * *
014100170126     C     codkey        KLIST
014200170126     C                   KFLD                    cdkey1
014300170126     C                   KFLD                    cdkey2
014400170126    * *
014500170126    * *
014600170126    * *
014700161028     C     *ENTRY        PLIST
014800161028     C                   PARM                    @PARM            10
014900161028     C                   MOVEL(P)  @PARM         @KEYPRM
015000161028    * *
0151001610260291  *        Get Account Record
0152001610260297 C     acckey        chain     accmst                             21
0153001610260296 C                   If        *in21 = '0'
0154001610260291  *
0155001610260291 C                   clear                   irs95cr
0156001509220291 C                   exsr      bldacc
0157001509280291 C                   eval      svempr = emprinfo
0158001509220291  *
015900150922      *        Locate members in TSA
0160001509160297 C     acckey        setll     memac#1                            22
0161001509220296 C                   dou       *in22 = '1'
0162001509160297 C     acckey        reade     memac#1                                22
0163001509280296 C                   if        *in22 = '0'
0164001801180291  *       Check for Non-empoyee
0165001801180296 C                   if        nonemp = 'Y'
0166001801180296 C                   iter
0167001801180296 C                   endif
0168001601050291  *        debug Shit
0169001601050296 C                   if        mbssno = 216084030
0170001601050296 C                   eval      mbssno = mbssno
0171001509280296 C                   endif
0172002209120291  *
0173002209120296 C                   if        mbenrl = termdt
0174002209120296 C                   iter
0175002209120296 C                   endif
0176002209120291  *
0177002209120296 C                   If        mbenrl < 20200101 and
0178002209120296 C                             (termdt = 0 or termdt > 20181231)
0179002209120291 C                   exsr      bldmbr
0180000605040291  *
0181002209120297 C                   endif                                                  *in21 = '1'
0182002209120297 C                   endif                                                  *in21 = '1'
0183002209120291  *
0184002209120297 C                   enddo                                                  *in21 = '1'
0185001802120291  *
0186002209120297 C                   endif                                                  *in21 = '1'
0187001802120291  *
0188001802120297 C                   movel     '1'           *inlr
0189001802120297 C                   return
0190001802120291  *
0191000605040107  ********************************************************************************
0192000204020107  *
0193001509150107  *     BLDACC - Build Account portion of record
0194000204020107  *
0195000204020107  ********************************************************************************
019600150915     C     bldacc        begsr
0197000604270107  *
019800150915     C                   movel(P)  acnam1        i5enm1
019900150915     C                   movel(P)  acnam2        i5enm2
020000150915     C                   movel(P)  aaddr1        i5ead1
0201001701030107  *
020200170103     C                   movel(P)  aaddr1        addr30
020300170103     C                   exsr      getaddr
020400170103     C                   movel(P)  addr30x       i5ead1
0205001701030107  *
020600170103     C                   movel(P)  aaddr2        addr30
020700170103     C                   exsr      getaddr
020800220909     C                   movel(P)  addr30x       i5ead2
0209002209090107  *
021000220909     C                   movel(P)  acity         i5ecty
021100220909     C                   movel(P)  astate        i5est
021200220909     C                   movel     azip9         i5ezip
0213002209090296 C**                 If        i5ezp4 = '0000'
021400220909     C**                 movel(P)  *blanks       i5ezp4
021500161220     C**                 endif
021600150915     C                   movel     aarea         i5ephn
021700220909     C                   move      aphone        i5ephn
0218002209090107  *
021900220909     C                   movel     contac        cont30
022000220909     C                   exsr      getcont
022100220909     C                   movel     conf12        i5ecfn
022200220909     C                   movel     conl20        i5ecln
0223001612300107  *
0224001509300291  *        Get Acc 2 Record
0225001509300297 C     ac2key        chain     ac2mst                             31
0226001509300296 C                   If        *in31 = '0' and a2tax_id# <> 0
022700150930     C                   movel(P)  a2tax_id#     i5eid
022800150930     C                   else
022900150928     C                   movel(P)  @keyprm       i5eid
023000150930     C                   endif
0231001509150107  *                                                                     **********
023200150915     C                   endsr
0233001509150107  ********************************************************************************
0234001509150107  *
0235001509150107  *     BLDMBR - Build Member record
0236001509150107  *
0237001509150107  ********************************************************************************
023800150915     C     bldmbr        begsr
0239001509150107  *
0240001509280296 C                   clear                   irs95cr
0241001509280107  *
0242001509280296 C                   eval      emprinfo = svempr
0243001509150107  *
024400150928     C                   movel     mbssno        i5mssn
024500150928     C                   movel     mfname        i5mfnm
024600150928     C                   move      mmi           i5mmi
024700150928     C                   movel     mlname        i5mlnm
0248001701030107  *
024900170103     C                   movel(P)  addr1         addr30
025000170103     C                   exsr      getaddr
025100170103     C                   movel(P)  addr30x       i5mad1
0252001701030107  *
025300170103     C                   movel(P)  addr2         addr30
025400170103     C                   exsr      getaddr
025500170103     C                   movel(P)  addr30x       i5mad2
0256001701030107  *
025700150928     C                   movel     city          i5mcty
025800150928     C                   movel     state         i5mst
025900150928     C                   movel     mlname        i5mlnm
026000150928     C                   movel     mlname        i5mlnm
026100150928     C                   movel     mlname        i5mlnm
026200161220     C                   movel     mzip9         i5mzip
0263001612200296 C***                If        i5mzp4 = '0000'
026400161220     C***                movel(P)  *blanks       i5mzp4
026500161220     C***                endif
026600151014     C                   movel(P)  fill66        i5meml
0267001509280107  *        Person 1 info (same as mbr)
0268001509290107  *          Leave blank for FI - Per KT
026900150929     C*******            movel     mbssno        i51ssn
027000150929     C**                 movel     mfname        i51fnm
027100150929     C**                 move      mmi           i51mi
027200150929     C********           movel     mlname        i51lnm
0273001509280107  *        Plan Offer Info
027400160105      *           Calc Enroll Dt if Enroll Dt is prior to Employ Dt
0275001601050296 C                   If        mbenrl < empdt and
0276001912030296 C                             (mbenrl > 20180601 or empdt > 20180601)
027700180104     C                   move      mbenrl        datea
027800180104     C                   move      empdt         dateb
027900180104     C     dateb         subdur    datea         days:*D
0280001801040296 C                   If        days > 31
028100180104     C                   exsr      calcenr
028200180104     C                   eval      mbenrl = enrdat
028300180104     C                   endif
028400180104     C                   endif
0285001801040107  *
028600180104      *
0287001912030296 C******             If        mbenrl < 20190201
028800180104     C***                eval      i5mpls = '01'
028900180104     C**                 else
029000180104     C************       eval      i5mpls = svplst
029100180104     C******             endif
029200191203      *           All  2019 Months?
0293001912030296 C                   If        mbenrl < 20190201 and
0294001912030296 C                             (termdt = 0 or termdt > 20191231)
029500171220     C                   eval      i5mcall = '1A'
029600171220     C                   else
029700171220      *               Jan?
0298001912030296 C                   If        mbenrl < 20190201 and
0299001912030296 C                             (termdt = 0 or termdt > 20190101)
030000171220     C                   eval      i5mcm1 = '1A'
030100171220     C                   else
030200160106     C                   eval      i5mcm1 = '1H'
030300161027     C                   endif
030400161027      *               Feb?
0305001912030296 C                   If        mbenrl < 20190301 and
0306001912030296 C                             (termdt = 0 or termdt > 20190201)
030700161027     C                   eval      i5mcm2 = '1A'
030800161027     C                   else
030900161027     C                   eval      i5mcm2 = '1H'
031000161027     C                   endif
031100150928      *               Mar?
0312001912030296 C                   If        mbenrl < 20190401 and
0313001912030296 C                             (termdt = 0 or termdt > 20190301)
031400150928     C                   eval      i5mcm3 = '1A'
031500160106     C                   else
031600160106     C                   eval      i5mcm3 = '1H'
031700150928     C                   endif
031800150928      *               Apr?
0319001912030296 C                   If        mbenrl < 20190501 and
0320001912030296 C                             (termdt = 0 or termdt > 20190401)
032100150928     C                   eval      i5mcm4 = '1A'
032200160106     C                   else
032300160106     C                   eval      i5mcm4 = '1H'
032400150928     C                   endif
032500150928      *               May?
0326001912030296 C                   If        mbenrl < 20190601 and
0327001912030296 C                             (termdt = 0 or termdt > 20190501)
032800150928     C                   eval      i5mcm5 = '1A'
032900160106     C                   else
033000160106     C                   eval      i5mcm5 = '1H'
033100150928     C                   endif
033200180206      *               Jun?
0333001912030296 C                   If        mbenrl < 20190701 and
0334001912030296 C                             (termdt = 0 or termdt > 20190601)
033500180206     C                   eval      i5mcm6 = '1A'
033600180206     C                   else
033700180206     C                   eval      i5mcm6 = '1H'
033800180206     C                   endif
033900180206      *               Jul?
0340001912030296 C                   If        mbenrl < 20190801 and
0341001912030296 C                             (termdt = 0 or termdt > 20190701)
034200180206     C                   eval      i5mcm7 = '1A'
034300180206     C                   else
034400180206     C                   eval      i5mcm7 = '1H'
034500180206     C                   endif
034600180206      *               Aug?
0347001912030296 C                   If        mbenrl < 20190901 and
0348001912030296 C                             (termdt = 0 or termdt > 20190801)
034900150928     C                   eval      i5mcm8 = '1A'
035000160106     C                   else
035100160106     C                   eval      i5mcm8 = '1H'
035200150928     C                   endif
035300180216      *               Sep?
0354001912030296 C                   If        mbenrl < 20191001 and
0355001912030296 C                             (termdt = 0 or termdt > 20190901)
035600180216     C                   eval      i5mcm9 = '1A'
035700180216     C                   else
035800180216     C                   eval      i5mcm9 = '1H'
035900180216     C                   endif
036000180216      *               Oct?
0361001912030296 C                   If        mbenrl < 20191101 and
0362001912030296 C                             (termdt = 0 or termdt > 20191001)
036300180216     C                   eval      i5mcm10 = '1A'
036400180216     C                   else
036500180216     C                   eval      i5mcm10 = '1H'
036600180216     C                   endif
036700180216      *               Nov?
0368001912030296 C                   If        mbenrl < 20191201 and
0369001912030296 C                             (termdt = 0 or termdt > 20191101)
037000150928     C                   eval      i5mcm11 = '1A'
037100160106     C                   else
037200160106     C                   eval      i5mcm11 = '1H'
037300150928     C                   endif
037400150928      *               Dec?
0375001912030296 C                   If        mbenrl < 20200101 and
0376001912030296 C                             (termdt = 0 or termdt > 20191201)
037700150928     C                   eval      i5mcm12 = '1A'
037800220912     C                   else
037900220912     C                   eval      i5mcm12 = '1H'
038000220912     C                   endif
0381002209120107  *
038200220912     C                   endif
0383002209120107  *
0384002209120107  *        Determine Coverage Time Frame for Member
038500220912     C                   eval      covall = '000000000000'
0386000604270107  *
038700150928      *           Find Medical Plan Coverage
0388002209120297 C     covkey        setll     mcovmpln                           23
0389002209120296 C                   dou       *in23 = '1'
0390002209120297 C     covkey        reade     mcovmpln                               23
0391002209120296 C                   if        *in23 = '0'
0392002209120107  *
0393002209120296 C                   If        candt <> 0 and candt < 20190101
039400150928     C                   iter
039500150928     C                   endif
0396001509280107  *
0397001912030296 C                   If        enrldt > 20191231
039800150928     C                   iter
039900150928     C                   endif
040000150928      *           Get Plan rec to chk for MED
0401001509280297 C     plnkey        chain     plnmst                             24
0402001509280296 C                   if        *in24 = '0'
0403001509280107  *
0404001509280297 C     codkey        chain     codes                              25
0405001509280296 C                   if        *in25 = '0'
0406001509280107  *
040700150928     C                   if        action <> 'M'
040800150928     C                   iter
040900150928     C                   endif
0410002209080107  *
041100220908      *           All 2019 Months?
0412002209080296 C                   If        enrldt < 20190201 and
0413002209080296 C                             (candt = 0 or candt > 20191231)
041400220908     C                   eval      i5mhall = '2C'
041500220908     C                   eval      covall = '111111111111'
041600220908     C                   leave
041700220908     C                   endif
041800220908      *               Jan?
0419002209080296 C                   If        enrldt < 20190201 and
0420002209080296 C                             (candt = 0 or candt > 20190101)
042100220908     C                   eval      cov01 = '1'
042200220908     C                   endif
042300220908      *               Feb?
0424002209080296 C                   If        enrldt < 20190301 and
0425002209080296 C                             (candt = 0 or candt > 20190201)
042600220908     C                   eval      cov02 = '1'
042700150928     C                   endif
042800150928      *               Mar?
0429001912030296 C                   If        enrldt < 20190401 and
0430001912030296 C                             (candt = 0 or candt > 20190301)
043100150928     C                   eval      cov03 = '1'
043200150928     C                   endif
043300150928      *               Apr?
0434001912030296 C                   If        enrldt < 20190501 and
0435001912030296 C                             (candt = 0 or candt > 20190401)
043600150928     C                   eval      cov04 = '1'
043700150928     C                   endif
043800150928      *               May?
0439001912030296 C                   If        enrldt < 20190601 and
0440001912030296 C                             (candt = 0 or candt > 20190501)
044100150928     C                   eval      cov05 = '1'
044200150928     C                   endif
044300150928      *               Jun?
0444001912030296 C                   If        enrldt < 20190701 and
0445001912030296 C                             (candt = 0 or candt > 20190601)
044600150928     C                   eval      cov06 = '1'
044700150928     C                   endif
044800151002      *               Jul?
0449001912030296 C                   If        enrldt < 20190801 and
0450001912030296 C                             (candt = 0 or candt > 20190701)
045100151002     C                   eval      cov07 = '1'
045200151002     C                   endif
045300151002      *               Aug?
0454001912030296 C                   If        enrldt < 20190901 and
0455001912030296 C                             (candt = 0 or candt > 20190801)
045600151002     C                   eval      cov08 = '1'
045700151002     C                   endif
045800151002      *               Sep?
0459001912030296 C                   If        enrldt < 20191001 and
0460001912030296 C                             (candt = 0 or candt > 20190901)
046100151002     C                   eval      cov09 = '1'
046200150928     C                   endif
046300150928      *               Oct?
0464001912030296 C                   If        enrldt < 20191101 and
0465001912030296 C                             (candt = 0 or candt > 20191001)
046600150928     C                   eval      cov10 = '1'
046700150928     C                   endif
046800150928      *               Nov?
0469001912030296 C                   If        enrldt < 20191201 and
0470001912030296 C                             (candt = 0 or candt > 20191101)
047100150928     C                   eval      cov11 = '1'
047200150928     C                   endif
047300150928      *               Dec?
0474001912030296 C                   If        enrldt < 20200101 and
0475001912030296 C                             (candt = 0 or candt > 20191201)
047600150928     C                   eval      cov12 = '1'
047700150928     C                   endif
047800150928      *
047900060427     C                   endif
048000150928      *
048100150928     C                   endif
0482001509280107  *
048300060427     C                   endif
0484000303270107  *
048500150928     C                   enddo
0486001509280107  *
048700150928     C                   If        covall = '111111111111'
048800150928     C                   eval      i5mhall = '2C'
048900150929     C*****              eval      i51call = '1'
049000150928     C                   else
0491001509280107  *
049200150928     C                   If        cov01 = '1'
049300150928     C                   eval      i5mhm1 = '2C'
049400150929     C******             eval      i51cm1 = '1'
049500150928     C                   endif
0496001509280107  *
049700150928     C                   If        cov02 = '1'
049800150928     C                   eval      i5mhm2 = '2C'
049900150929     C******             eval      i51cm2 = '1'
050000150928     C                   endif
0501001509280107  *
050200150928     C                   If        cov03 = '1'
050300150928     C                   eval      i5mhm3 = '2C'
050400150929     C******             eval      i51cm3 = '1'
050500150928     C                   endif
0506001509280107  *
050700150928     C                   If        cov04 = '1'
050800150928     C                   eval      i5mhm4 = '2C'
050900150929     C******             eval      i51cm4 = '1'
051000150928     C                   endif
0511001509280107  *
051200150928     C                   If        cov05 = '1'
051300150928     C                   eval      i5mhm5 = '2C'
051400150929     C******             eval      i51cm5 = '1'
051500150928     C                   endif
0516001509280107  *
051700150928     C                   If        cov06 = '1'
051800150928     C                   eval      i5mhm6 = '2C'
051900150929     C*****              eval      i51cm6 = '1'
052000150928     C                   endif
0521001509280107  *
052200150928     C                   If        cov07 = '1'
052300150928     C                   eval      i5mhm7 = '2C'
052400150929     C*****              eval      i51cm7 = '1'
052500150928     C                   endif
0526001509280107  *
052700150928     C                   If        cov08 = '1'
052800150928     C                   eval      i5mhm8 = '2C'
052900150929     C******             eval      i51cm8 = '1'
053000150928     C                   endif
0531001509280107  *
053200150928     C                   If        cov09 = '1'
053300150928     C                   eval      i5mhm9 = '2C'
053400150929     C******             eval      i51cm9 = '1'
053500150928     C                   endif
0536001509280107  *
053700150928     C                   If        cov10 = '1'
053800150928     C                   eval      i5mhm10 = '2C'
053900150929     C*******            eval      i51cm10 = '1'
054000150928     C                   endif
0541001509280107  *
054200150928     C                   If        cov11 = '1'
054300150928     C                   eval      i5mhm11 = '2C'
054400150929     C*******            eval      i51cm11 = '1'
054500150928     C                   endif
0546001509280107  *
054700150928     C                   If        cov12 = '1'
054800150928     C                   eval      i5mhm12 = '2C'
054900150929     C******             eval      i51cm12 = '1'
055000150928     C                   endif
0551000604270107  *
055200150928     C                   endif
0553000604270296  *
055400150928     C                   write     IRS95CR
0555000204150107  *
055600020415     C                   endsr
0557001601050107  ********************************************************************************
0558001601050107  *
0559001601050107  *     CALCENR - Calculate enrollment Date
0560001601050107  *
0561001601050107  ********************************************************************************
056200171215     C     calcenr       begsr
0563001712150107  *
0564001712150296 C                   eval      enrdat = empdt
0565001712150296 C                   move      empdt         datee
0566001712150296 C                   move      empdt         datec
056700171215      *           Find Medical Plan Coverage
0568001712150297 C     covkey        setll     mcovmpln                           23
0569001712150296 C                   dou       *in23 = '1'
0570001712150297 C     covkey        reade     mcovmpln                               23
0571001712150296 C                   if        *in23 = '0'
0572001712150107  *
0573001912030296 C                   If        candt <> 0 and candt < 20190101
057400171215     C                   iter
057500161111     C                   endif
0576001712150107  *
0577001912030296 C                   If        enrldt > 20191231
057800171215     C                   iter
057900171215     C                   endif
058000171215      *           Get Plan rec to chk for MED
0581001712150297 C     plnkey        chain     plnmst                             24
0582001712150296 C                   if        *in24 = '0'
0583001601050107  *
0584001601050297 C     codkey        chain     codes                              25
0585001601050296 C                   if        *in25 = '0'
0586001601050107  *
058700160105     C                   if        action <> 'M'
058800160105     C                   iter
058900160105     C                   endif
0590001601050107  *
059100160105      *           Med Plan
0592001601050297 C     plnkey        chain     plnauxp                            29
0593001712280296 C                   If        *in29 = '0'
0594001712280107  *             Date of Hire                                            **********
0595001712280296 C                   If        pxwtpd = 'WDH'
0596001712280296 C     datee         adddur    pxwtdy:*D     dated
0597001902040296 C                   If        dated > datec
0598001902040296 C                   eval      datec = dated
059900190204     C                   endif
060000190204     C                   else
0601001902040107  *             First of Mon after Date of Hire                         **********
0602001912130296 C                   If        pxwtpd = 'WFM'
0603001912130296 C     datee         adddur    pxwtdy:*D     dated
0604001912130296 C                   adddur    1:*M          dated
0605001912130296 C                   If        dated > datec
0606001912130296 C                   eval      datec = dated
060700191213     C                   endif
060800191213     C                   else
0609001912130107  *                                                                     **********
0610001611100107  *             First Day Following Date of Hire                        **********
0611001611090296 C                   If        pxwtpd = 'WFF'
0612001611090296 C     datee         adddur    pxwtdy:*D     dated
0613001611090296 C                   adddur    1:*D          dated
0614001611090296 C                   If        dated > datec
0615001611090296 C                   eval      datec = dated
061600161109     C                   endif
061700161109     C                   endif
061800161109     C                   endif
061900161109     C                   endif
0620001611090107  *                                                                     **********
062100161109     C                   endif
0622001611090107  *                                                                     **********
062300161109     C                   endif
0624001611090107  *                                                                     **********
062500161109     C                   endif
0626001611090107  *                                                                     **********
062700161103     C                   endif
0628001611030107  *                                                                     **********
062900161103     C                   enddo
0630001611030107  *                                                                     **********
0631001611030296 C                   move      datec         enrdat
063200161103     C                   endsr
0633001612300107  ********************************************************************************
0634001612300107  *
0635001612300107  *     GETCONT - Break out contact name
0636001612300107  *
0637001612300107  ********************************************************************************
063800161230     C     getcont       begsr
0639001612300107  *
064000161230     C                   movel     *blanks       conf12
064100161230     C                   movel     *blanks       conl20
064200161230     C                   movel     *blanks       contmi
064300161230     C                   movel     *blanks       contarx
0644001612300107  *
064500161230     C                   movea     cont30        contar
064600161230     C                   eval      z = 1
0647001612300107  *          First Name
064800161230    3C     1             DO        30            X
064900161230    4C                   IF        (contar(X) >= 'A' and
065000161230    4C                             contar(X) <= 'Z') or
065100161230    4C                             (contar(X) >= '0' and
065200161230    4C                             contar(X) <= '9') or
065300161230    4C                             contar(X) = '.'  or
065400161230    4C                             contar(X) = ''''  or
065500161230    4C                             contar(X) = '-'
065600161230     C                   eval      contarx(z) = contar(x)
065700161230     C                   eval      z = z + 1
065800161230    4C                   endif
0659001612300291  *
066000161230    4C                   IF        contar(X) = ' '
066100161230     C                   leave
066200161230    4C                   endif
066300161230    3C                   enddo
0664001612300291  *
066500161230     C                   movea     contarx       conf12
066600161230     C                   movel     *blanks       contarx
066700161230     C                   eval      x = x + 1
0668001612300291  *         MI or last name
066900161230     C                   eval      z = 1
067000161230    3C                   DOU       X = 30
067100161230    4C                   IF        (contar(X) >= 'A' and
067200161230    4C                             contar(X) <= 'Z') or
067300161230    4C                             (contar(X) >= '0' and
067400161230    4C                             contar(X) <= '9') or
067500161230    4C                             contar(X) = '.'  or
067600161230    4C                             contar(X) = ''''  or
067700161230    4C                             contar(X) = '-'
067800161230     C                   eval      contarx(z) = contar(x)
067900161230     C                   eval      z = z + 1
068000161230    4C                   endif
0681001612300291  *
068200161230    4C                   IF        contar(X) = ' '
068300161230     C                   leave
068400161230    4C                   endif
068500161230     C                   eval      x = x + 1
068600161230    3C                   enddo
0687001612300291  *
068800161230    4C                   IF        z = 2 or contarx(2) = '.'
068900161230     C                   movea     contarx(1)    contmi
069000161230     C                   eval      x = x + 1
069100161230     C                   else
069200161230     C                   movea     contarx       conl20
069300161230     C                   leavesr
069400161230     C                   endif
0695001612300111  *
0696001612300291  *         Last name
069700161230     C                   movel     *blanks       contarx
069800161230     C                   eval      z = 1
069900161230    3C                   DOU       X = 30
070000161230    4C                   IF        (contar(X) >= 'A' and
070100161230    4C                             contar(X) <= 'Z') or
070200161230    4C                             (contar(X) >= '0' and
070300161230    4C                             contar(X) <= '9') or
070400161230    4C                             contar(X) = '.'  or
070500161230    4C                             contar(X) = ' '  or
070600161230    4C                             contar(X) = ''''  or
070700161230    4C                             contar(X) = '-'
070800161230     C                   eval      contarx(z) = contar(x)
070900161230     C                   eval      z = z + 1
071000161230    4C                   endif
0711001612300291  *
071200161230     C                   eval      x = x + 1
071300161230    3C                   enddo
0714001612300291  *
071500161230     C                   movea     contarx       conl20
0716001612300111  *
071700161230     C                   endsr
0718001701030107  ********************************************************************************
0719001701030107  *
0720001701030107  *     GETADDR - Strip Addr fields of unwanted chars
0721001701030107  *
0722001701030107  ********************************************************************************
072300170103     C     getaddr       begsr
0724001701030107  *
072500170103     C                   movel     *blanks       addr30x
072600170103     C                   movel     *blanks       addrarx
0727001701030107  *
072800170103     C                   movea     addr30        addrar
072900170103     C                   eval      z = 1
0730001701030107  *
073100180103    3C     1             DO        30            X
073200180103    4C                   IF        (addrar(X) >= 'A' and
073300180103    4C                             addrar(X) <= 'Z') or
073400180103    4C                             (addrar(X) >= '0' and
073500180103    4C                             addrar(X) <= '9') or
073600180103    4C                             addrar(X) = ' '  or
073700180103    4C                             addrar(X) = '/'  or
073800170103    4C                             addrar(X) = '-'
073900180103     C                   eval      addrarx(z) = addrar(x)
074000180103     C                   eval      z = z + 1
074100180103    4C                   endif
074200180103    3C                   enddo
0743001801030291  *
074400180103     C                   movea     addrarx       addr30x
0745001801030111  *
074600180103     C                   endsr
