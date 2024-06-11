0001000204020002  **************************************************************************
000200080905      * DW441      Group Benefit Services
000300020402      *            WRITTEN BY - R.L.J.
000400080905      *            DATE - 09/2008
000500020403      *  DESCRIPTION - Compare Hold file with Current file to produce
000600050525      *                Change file
0007000204020002  **************************************************************************
0008001911120015  *  Change Log: 10/07/2013 rlj HIST file expansion
0009001911120015  *              11/12/2019 rlj Add logic for email address fields
001000020402      *                                                                *
0011009102150018 F******************************************************************
0012001008050020 FFSCURP    IF   E           K DISK
0013001008050020 FFSHLDP    IF   E           K DISK
0014001008050020 FFSHLDL    IF   E           K DISK    PREFIX(G)
0015001008050020 F                                     RENAME(FSHLDR:FSHLDRL)
0016001008050020 FFSCHGP    O  A E             DISK
0017001104190020 FDEBCARD   UF A E           K DISK
0018001104190020 FHIST      O  A E             DISK
0019000907210029  *
0020000907210250 D                 DS
0021000204030251 D  getcur                 1      1    INZ(*blank)
0022000204030251 D  gethld                 2      2    INZ(*blank)
0023000204030029  *
0024000204030250 D                 DS
0025000505250251 D  curkey                 1     11  0
0026001008050251 D   fcmid#                1      9  0
0027001008050251 D   fcseq#               10     11  0
0028000505250029  *
0029000505250250 D                 DS
0030000505250251 D  hldkey                 1     11  0
0031001008050251 D   fhmid#                1      9  0
0032001008050251 D   fhseq#               10     11  0
0033000510120029  *
0034000510120250 D                 DS
0035000505250251 D  chgkey                 1     11  0
0036001008050251 D   fxmid#                1      9  0
0037001008050251 D   fxseq#               10     11  0
0038000204030029  *
0039000204030250 D                 DS
0040001911210251 D  curdem                 1    289
0041001008050251 D   fcdssn                1      9  0
0042001008050251 D   fclnme               10     27
0043001008050251 D   fcfnme               28     39
0044001008050251 D   fcmi                 40     40
0045001008050251 D   fcadr1               41     70
0046001008050251 D   fcadr2               71    100
0047001008050251 D   fccity              101    115
0048001008050251 D   fcst                116    117
0049001008050251 D   fczip               118    126  0
0050001008050251 D   fcarea              127    129  0
0051001008050251 D   fcphn#              130    136  0
0052001008050251 D   fcbrdt              137    144  0
0053001008050251 D   fcgndr              145    145
0054001008050251 D   fcempdt             154    161  0
0055001008050251 D   fcrelcd             179    181
0056001008050251 D   fcefdt              182    189  0
0057001008050251 D   fctfdt              190    197  0
0058001008050251 D   fcgrp#              198    212
0059001008050251 D   fccovt              213    214
0060001008050251 D   fcrate              215    222  2
0061001008050251 D   fcdbtc              223    223
0062001911210251 D   fcemal              224    289
0063001104190251 D   fccdat                        D
0064000505250029  *
0065000505250250 D                 DS
0066001911210251 D  hlddem                 1    289
0067001008050251 D   fhdssn                1      9  0
0068001008050251 D   fhlnme               10     27
0069001008050251 D   fhfnme               28     39
0070001008050251 D   fhmi                 40     40
0071001008050251 D   fhadr1               41     70
0072001008050251 D   fhadr2               71    100
0073001008050251 D   fhcity              101    115
0074001008050251 D   fhst                116    117
0075001008050251 D   fhzip               118    126  0
0076001008050251 D   fharea              127    129  0
0077001008050251 D   fhphn#              130    136  0
0078001008050251 D   fhbrdt              137    144  0
0079001008050251 D   fhgndr              145    145
0080001008050251 D   fhempdt             154    161  0
0081001008050251 D   fhrelcd             179    181
0082001008050251 D   fhefdt              182    189  0
0083001008050251 D   fhtfdt              190    197  0
0084001008050251 D   fhgrp#              198    212
0085001008050251 D   fhcovt              213    214
0086001008050251 D   fhrate              215    222  2
0087001008050251 D   fhdbtc              223    223
0088001911210251 D   fhemal              224    289
0089001104190251 D   fhcdat                        D
0090000809040029  *
0091000809040250 D                 DS
0092001911210251 D  chghdem                1    289
0093001008050251 D   fxhdssn               1      9  0
0094001008050251 D   fxhlnme              10     27
0095001008050251 D   fxhfnme              28     39
0096001008050251 D   fxhmi                40     40
0097001008050251 D   fxhadr1              41     70
0098001008050251 D   fxhadr2              71    100
0099001008050251 D   fxhcity             101    115
0100001008050251 D   fxhst               116    117
0101001008050251 D   fxhzip              118    126  0
0102001008050251 D   fxharea             127    129  0
0103001008050251 D   fxhphn#             130    136  0
0104001008050251 D   fxhbrdt             137    144  0
0105001008050251 D   fxhgndr             145    145
0106001008050251 D   fxhempdt            154    161  0
0107001008050251 D   fxhrelcd            179    181
0108001008050251 D   fxhefdt             182    189  0
0109001008050251 D   fxhtfdt             190    197  0
0110001008050251 D   fxhgrp#             198    212
0111001008050251 D   fxhcovt             213    214
0112001008050251 D   fxhrate             215    222  2
0113001008050251 D   fxhdbtc             223    223
0114001911210251 D   fxhemal             224    289
0115001104190251 D   fxhcdat                       D
0116000809040029  *
0117000809040250 D                 DS
0118001911210251 D  chgcdem                1    289
0119001008050251 D   fxcdssn               1      9  0
0120001008050251 D   fxclnme              10     27
0121001008050251 D   fxcfnme              28     39
0122001008050251 D   fxcmi                40     40
0123001008050251 D   fxcadr1              41     70
0124001008050251 D   fxcadr2              71    100
0125001008050251 D   fxccity             101    115
0126001008050251 D   fxcst               116    117
0127001008050251 D   fxczip              118    126  0
0128001008050251 D   fxcarea             127    129  0
0129001008050251 D   fxcphn#             130    136  0
0130001008050251 D   fxcbrdt             137    144  0
0131001008050251 D   fxcgndr             145    145
0132001008050251 D   fxcempdt            154    161  0
0133001008050251 D   fxcrelcd            179    181
0134001008050251 D   fxcefdt             182    189  0
0135001008050251 D   fxctfdt             190    197  0
0136001008050251 D   fxcgrp#             198    212
0137001008050251 D   fxccovt             213    214
0138001008050251 D   fxcrate             215    222  2
0139001008050251 D   fxcdbtc             223    223
0140001911210251 D   fxcemal             224    289
0141001104190251 D   fxccdat                       D
0142000807210029  *
0143000807210250 D                 DS
0144000807210251 D  curact                 1    214
0145001008050251 D   fctrust               1      3  0
0146001008050251 D   fcsub                 4      6  0
0147001008050251 D   fcacct                7     10  0
0148001008050251 D   fcacnm               11     50
0149000506220029  *
0150000506220250 D                 DS
0151000506220251 D  chgact                 1    214
0152001008050251 D   fxtrst                1      3  0
0153001008050251 D   fxsub                 4      6  0
0154001008050251 D   fxacct                7     10  0
0155001008050251 D   fxacnm               11     50
0156000910140029  *          Plan Renewal Info
0157000910140250 D                 DS
0158000910140251 D  curprn                 1     16
0159001008050251 D   fcpefd                1      8  0
0160001008050251 D   fcptrd                9     16  0
0161000910140250 D                 DS
0162000910140251 D  hldprn                 1     16
0163001008050251 D   fhpefd                1      8  0
0164001008050251 D   fhptrd                9     16  0
0165000910140029  *
0166000809040250 D                 DS
016700080904     D  ISOToday       S               d     inz
016800080904     D  Today          S              8p 0   inz
0169000809040251 D  cutoff         S               D   DATFMT(*ISO)
0170000809040251 D  cutofn         S              8S 0
0171001310070037 D sysdateymd      S               d   datfmt(*iso)
0172000809040029  *
0173000809040250 D                 DS
017400080904     D  gbdate                 1      8  0
017500080904     D   gbyr                  1      4  0
017600080904     D   gbmo                  5      6  0
017700080904     D   gbdy                  7      8  0
0178000809040029  *
0179000809040250 D                 DS
018000070718     D  wkday          S               D     inz
0181000809040111  *
0182001104190250 D                 DS
0183001104190251 D  dnote2                 1     11
0184001104190251 D   note2a                1     11      INZ('DEP SEQ# - ')
0185001104190251 D   ntseq#               10     11
018600110419      *
0187001104190053 D                 DS
0188001104190054 D  dbc1           C                   'Std Card Std Mail to Cardhlder'
0189001104190111  *
019000110419      *
019100110419     C     cardky        klist
019200110419     C                   kfld                    fcmid#
019300110419     C                   kfld                    fcseq#
019400110419      *
019500091223     C     gkey          klist
019600100805     C                   kfld                    fctrust
019700100805     C                   kfld                    fcsub
019800100805     C                   kfld                    fcacct
019900091223      *
020000091223     C     prnkey        klist
020100100805     C                   kfld                    fctrust
020200100805     C                   kfld                    fcsub
020300100805     C                   kfld                    fcacct
020400100805     C                   kfld                    fcpln
020500100805     C                   kfld                    fcpefd
020600091014      *
020700080904      *
020800080904     C                   move      udate         ISOtoday
020900080904     C                   move      ISOtoday      today
0210000809040291  * Determine Term date cutoff - 1 year ago
0211000809040297 C     ISOtoday      subdur    365:*D        cutoff
0212000809040297 C                   movel     cutoff        cutofn
021300080904      *
021400080904      *
0215000809040291  * Main Line - Loop thru current and hold file - comparing the 2
0216001008050297 C     *LOVAL        setll     fscurp
0217001008050297 C     *LOVAL        setll     fshldp
0218000303310296 C                   dou       *in21 = '1'
021900020403      *
0220000807210296 C                   if        getcur = *blank
0221001008050297 C                   read      fscurp                                 21
0222000807210296 C                   If        *in21 = '1'
0223000807210296 C                   movel     'E'           getcur
0224000807210296 C                   If        gethld = 'E' or
0225000807210296 C                             hldkey = 99999999999
0226000807210296 C                   leave
0227000807210296 C                   endif
0228000807210296 C                   endif
0229000807210296 C                   else
0230000807210296 C                   If        getcur <> 'E'
0231000204050296 C                   movel     *blank        getcur
0232000204050296 C                   endif
0233000303310296 C                   endif
0234000508240291  *
0235000508240291  *      DEBUG
0236001008050296 C                   If        fcmid# = 217559130
0237001008050296 C                   movel     fcmid#        fcmid#
0238000508240296 C                   endif
023900020403      *
0240000204050296 C                   if        gethld = *blank
0241000807310296  *
0242000807310296 C                   dou       *in22 = '1'
0243001008050297 C                   read      fshldp                                 22
0244001205010291  *      DEBUG SHIT
0245001205010296 C                   If        fhmid# = 184521277
0246001008050296 C                   movel     fhmid#        fhmid#
0247000909180296 C                   endif
0248000909180296  *
0249001008050296 C                   If        *in22 = '0' and fhtfdt = 0 or
0250001008050296 C                             *in22 = '0' and fhtfdt > cutofn
0251000807310296 C                   leave
0252000807310296 C                   endif
0253000807310296 C                   enddo
0254000807310296  *
0255000204050296 C                   If        *in22 = '1'
0256000204050296 C                   movel     'E'           gethld
0257000506210296 C                   eval      hldkey = 99999999999
0258000408020296 C                   If        getcur = 'E'
0259000408020296 C                   leave
0260000505250296 C                   else
0261000505250296 C                   exsr      putnew
0262000809020296 C                   iter
0263000809020296 C                   endif
0264000809020296 C                   endif
0265000204050296 C                   else
0266000303310296 C                   If        gethld <> 'E'
0267000204050296 C                   movel     *blank        gethld
0268000204050296 C                   endif
0269000807210296 C                   endif
027000091014      *
0271000910140296 C                   if        curkey < hldkey
0272000910140297 C                   exsr      putnew
0273000910140296 C                   movel     'N'           gethld
0274000910140296 C                   iter
0275000910140296 C                   endif
027600020405      *
0277000408020296 C                   if        curkey > hldkey and
0278000408020296 C                             gethld <> 'E'
0279000803040297 C                   exsr      putx
0280000204050296 C                   movel     'N'           getcur
0281000204050296 C                   iter
0282000204050296 C                   endif
028300020405      *
0284001104190296 C                   if        curdem <> hlddem or fccdat <> fhcdat
0285000505250297 C                   exsr      putchg
0286000204050296 C                   iter
0287000204050296 C                   endif
028800020405      *
0289000204050296 C                   enddo
029000020405      *
0291000204050296 C                   movel     '1'           *inlr
0292000204050296 C                   return
0293000204020107  **************************************************************************
0294000204020107  *
0295000505250107  *     PUTNEW - Write the New record to the change file
0296000204020107  *
0297000204020107  **************************************************************************
029800050525     C     putnew        begsr
0299000806160107  *          Per angie - do not report on grp 9127                      ****
030000080905     C***********        if        bcgrp# = '9127           '
030100080905     C***                leavesr
030200080905     C***********        endif
0303000806160107  *                                                                     ****
030400100805     C                   clear                   fschgr
030500100805     C                   eval      fxsts = 'N'
0306000912230107  *                                                                     ****
030700100805     C     gkey          chain     fshldl                             41
030800091223     C                   if        *IN41 = '1'
030900100805     C                   eval      fxsts = 'G'
031000091223     C                   endif
0311000912230107  *                                                                     ****
031200050525     C                   eval      chgkey = curkey
031300080304     C                   eval      chgcdem = curdem
031400110419     C                   eval      fxccdat = fccdat
031500070718      *    BeneGap - LUM Logic
031600100805     C                   eval      fxctfldt = fxctfdt
031700100805     C                   eval      gbdate = fxctfdt
031800070718     C                   if        gbdy = 01
031900070718     C                   move      gbdate        wkday
032000070718     C                   subdur    1:*D          wkday
032100100805     C                   move      wkday         fxctfldt
032200070718     C                   endif
032300070718      *
032400100805     C                   eval      fxlsts = fxsts
032500070718      *
032600050622     C                   eval      chgact = curact
032700100805     C                   eval      fxdate = today
032800100805     C                   write     fschgr
032900110419      *
033000110419     C                   if        fccdat <> *LOVAL
033100110419     C                   exsr      cardsr
033200110419     C                   endif
033300110419      *
033400020405     C                   endsr
0335000505250107  **************************************************************************
0336000505250107  *
0337000505250107  *     PUTCHG - Write the Chg record to the change file
0338000505250107  *
0339000505250107  **************************************************************************
034000050525     C     putchg        begsr
0341000806160107  *          Per angie - do not report on grp 9127                      ****
034200080905     C*********          if        bcgrp# = '9127           '
034300080905     C*&**               leavesr
034400080905     C*********          endif
0345000806160107  *                                                                     ****
034600100805     C                   clear                   fschgr
034700100805     C                   eval      fxsts = 'C'
034800050525     C                   eval      chgkey = curkey
034900050622     C                   eval      chgact = curact
035000100805     C                   eval      fxclnme = fclnme
035100100805     C                   eval      fxcfnme = fcfnme
035200100805     C                   eval      fxcgrp# = fcgrp#
035300080304      *
035400100805     C                   if        fclnme <> fhlnme
035500100805     C                   eval      fxhlnme = fhlnme
035600050525     C                   endif
035700080304      *
035800100805     C                   if        fcfnme <> fhfnme
035900100805     C                   eval      fxhfnme = fhfnme
036000080304     C                   endif
036100080304      *
036200100805     C                   if        fcmi <> fhmi
036300100805     C                   eval      fxcmi = fcmi
036400100805     C                   eval      fxhmi = fhmi
036500080304     C                   endif
036600080903      *
036700100805     C                   if        fcdssn <> fhdssn
036800100805     C                   eval      fxcdssn = fcdssn
036900100805     C                   eval      fxhdssn = fhdssn
037000080903     C                   endif
037100050525      *
037200100805     C                   if        fcadr1 <> fhadr1
037300100805     C                   eval      fxcadr1 = fcadr1
037400100805     C                   eval      fxhadr1 = fhadr1
037500050525     C                   endif
037600050525      *
037700100805     C                   if        fcadr2 <> fhadr2
037800100805     C                   eval      fxcadr2 = fcadr2
037900100805     C                   eval      fxhadr2 = fhadr2
038000050525     C                   endif
038100191112      *
038200191121     C                   if        fcemal <> fhemal
038300191121     C                   eval      fxcemal = fcemal
038400191121     C                   eval      fxhemal = fhemal
038500191121     C                   endif
038600050525      *
038700100805     C                   if        fccity <> fhcity
038800100805     C                   eval      fxccity = fccity
038900100805     C                   eval      fxhcity = fhcity
039000050525     C                   endif
039100050525      *
039200100805     C                   if        fcst <> fhst
039300100805     C                   eval      fxcst   = fcst
039400100805     C                   eval      fxhst   = fhst
039500050525     C                   endif
039600050525      *
039700100805     C                   if        fczip  <> fhzip
039800100805     C                   eval      fxczip  = fczip
039900100805     C                   eval      fxhzip  = fhzip
040000050525     C                   endif
040100050525      *
040200100805     C                   if        fcarea <> fharea
040300100805     C                   eval      fxcarea = fcarea
040400100805     C                   eval      fxharea = fharea
040500050525     C                   endif
040600080905      *
040700100805     C                   if        fcphn# <> fhphn#
040800100805     C                   eval      fxcphn# = fcphn#
040900100805     C                   eval      fxhphn# = fhphn#
041000050525     C                   endif
041100050525      *
041200100805     C                   if        fcbrdt <> fhbrdt
041300100805     C                   eval      fxcbrdt = fcbrdt
041400100805     C                   eval      fxhbrdt = Fhbrdt
041500050525     C                   endif
041600050525      *
041700100805     C                   if        fcgndr <> Fhgndr
041800100805     C                   eval      fxcgndr = fcgndr
041900100805     C                   eval      fxhgndr = Fhgndr
042000050525     C                   endif
042100050525      *
042200100805     C                   if        fcempdt <> fhempdt
042300100805     C                   eval      fxcempdt = fcempdt
042400100805     C                   eval      fxhempdt = fhempdt
042500050525     C                   endif
042600050525      *
042700100805     C                   if        fcrelcd <> fhrelcd
042800100805     C                   eval      fxcrelcd = fcrelcd
042900100805     C                   eval      fxhrelcd = fhrelcd
043000050525     C                   endif
043100050525      *
043200100805     C                   if        fcefdt <> fhefdt
043300100805     C                   eval      fxcefdt = fcefdt
043400100805     C                   eval      fxhefdt = fhefdt
043500050525     C                   endif
043600050525      *
043700100805     C                   if        fctfdt <> fhtfdt
043800080304      *
043900100805     C                   eval      fxctfdt = fctfdt
044000100805     C                   eval      fxctfldt = fxctfdt
044100100805     C                   eval      gbdate = fxctfdt
044200080304     C                   if        gbdy = 01
044300080304     C                   move      gbdate        wkday
044400080304     C                   subdur    1:*D          wkday
044500100805     C                   move      wkday         fxctfldt
044600080304     C                   endif
044700080304      *
044800100805     C                   eval      fxhtfdt = fhtfdt
044900100805     C                   eval      fxhtfldt = fhtfdt
045000100805     C                   eval      gbdate = fxhtfdt
045100080304     C                   if        gbdy = 01
045200080304     C                   move      gbdate        wkday
045300080304     C                   subdur    1:*D          wkday
045400100805     C                   move      wkday         fxhtfldt
045500080304     C                   endif
045600080304      *
045700050525     C                   endif
045800050525      *
045900100805     C***                if        fcgrp# <> fhgrp#
046000120202     C***                eval      fggrp# = fcgrp#
046100070207     C***                endif
046200120202      *
046300120202     C                   if        fcgrp# <> fhgrp#
046400120202     C                   eval      fxcgrp# = fcgrp#
046500120202     C                   eval      fxhgrp# = fhgrp#
046600120202     C                   endif
046700080904      *
046800100805     C                   if        fccovt <> fhcovt
046900100805     C                   eval      fxccovt = fccovt
047000100805     C                   eval      fxhcovt = fhcovt
047100080904     C                   endif
047200100610      *
047300100805     C                   if        fcdbtc <> fhdbtc
047400100805     C                   eval      fxcdbtc = fcdbtc
047500100805     C                   eval      fxhdbtc = fhdbtc
047600100610     C                   endif
047700110419      *
047800110419     C                   if        fccdat <> fhcdat
047900110419     C                   eval      fxccdat = fccdat
048000110419     C                   eval      fxhcdat = fhcdat
048100110419     C                   exsr      cardsr
048200110419     C                   endif
048300081114      *
048400100805     C                   if        fcrate <> fhrate
048500100805     C                   eval      fxhrate = fhrate
048600081114     C                   endif
048700081114      *
048800100805     C                   eval      fxcrate = fcrate
048900070718      *
049000100805     C                   eval      fxlsts = fxsts
049100070718      *
049200100805     C                   eval      fxdate = today
049300100805     C                   write     fschgr
049400050525     C                   endsr
0495000803040107  **************************************************************************
0496000803040107  *
0497000803040107  *     PUTX - Write the X rec change file
0498000803040107  *
0499000803040107  **************************************************************************
050000080304     C     putx          begsr
050100100805     C                   if        fhtfdt > cutofn or
050200100805     C                             fhtfdt = 0
050300120920     C                   if        fhseq# = 0
050400100805     C                   clear                   fschgr
050500100805     C                   eval      fxsts = 'X'
050600080304     C                   eval      chgkey = hldkey
050700080304     C                   eval      chghdem = hlddem
050800100805     C                   eval      fxdate = today
050900100805     C                   write     fschgr
051000080430     C                   endif
051100120920     C                   endif
051200080430     C                   endsr
0513001104190107  **************************************************************************
0514001104190107  *
0515001104190107  *     CARDSR - Update debit card info and write HIST rec
0516001104190107  *
0517001104190107  **************************************************************************
051800110419     C     cardsr        begsr
0519001104190107  *
052000110419     C     cardky        chain     debcard                            51
052100110419     C                   if        *in51 = '0' and dbprsta = ' ' and
052200110419     C                             dbdeliv <> 'N'
052300110419     C                   eval      dbprsta = 'P'
052400110419     C                   eval      dbprdat = isotoday
052500110419     C                   update    debcardr
052600110419      *
052700110419      *         Write HIST rec
052800110419     C                   clear                   histr
052900110419     C                   move      fcmid#        hkey
053000110419     C                   movel     today         trdate
053100110419     C                   move      'U52'         trcode
053200110419     C                   Z-ADD     0             TRAMT
053300110419     C                   MOVE      *BLANKS       CM$FLG
053400110419     C                   MOVEL     dbc1          CK#NOT
053500110419      *
053600110419     C                   MOVE      *BLANKS       NOTE2
053700110419     C                   if        fcseq# <> 0
053800110419     C                   move      fcseq#        hdseq#
053900110419     C                   move      fcseq#        ntseq#
054000110419     C                   movel     dnote2        note2
054100110419     C                   endif
054200110419      *
054300110419     C                   MOVE      '  '          HDSEQ#
054400131007     C                   MOVEL(P)  'DW431'       HPRGNM
054500110419     C                   Z-ADD     0             RECVDT
054600110419     C                   MOVE      fctrust       HSTRST
054700110419     C                   MOVE      fcsub         HSSUB#
054800110419     C                   MOVE      fcacct        HSACCT
054900110419     C                   MOVEL     dbuser        HOPER
055000110419     C                   MOVEL     'A'           HSDLTD
055100131007     C                   eval      sysdateymd = %date
055200131007     C                   MOVE      sysdateymd    trdate
055300131007     c                   eval      hstrtime = %time
055400110419     C                   WRITE     HISTR
055500110419      *
055600110419     C                   endif
055700110419     C                   endsr
