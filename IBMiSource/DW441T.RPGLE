0001000204020002  **************************************************************************
000200080905      * DW441      Group Benefit Services
000300020402      *            WRITTEN BY - R.L.J.
000400080905      *            DATE - 09/2008
000500020403      *  DESCRIPTION - Compare Hold file with Current file to produce
000600050525      *                Change file
0007000204020002  **************************************************************************
0008001103150015  *  Change Log: 03/15/2011 RLJ When card date changes - update DEBCARD
000900110315      *                             file, write a HIST rec.          *
0010001310070015  *              10/07/2013 HIST file expansion
0011001911110015  *              11/11/2019 rlj Add logic for email address fields
0012009102150018 F******************************************************************
0013001004220020 FMBCUR2P   IF   E           K DISK
0014001004220020 FMBHLD2P   IF   E           K DISK
0015001004220020 FMBHLD2L   IF   E           K DISK    PREFIX(G)
0016001004220020 F                                     RENAME(MBHLD2R:MBHLD2RL)
0017001004220020 FMBCHG2P   O  A E             DISK
0018001103210029  *
0019001103210250 D                 DS
0020000204030251 D  getcur                 1      1    INZ(*blank)
0021000204030251 D  gethld                 2      2    INZ(*blank)
0022000204030029  *
0023000204030250 D                 DS
0024000505250251 D  curkey                 1     11  0
0025000809050251 D   mcmid#                1      9  0
0026000809050251 D   mcseq#               10     11  0
0027000505250029  *
0028000505250250 D                 DS
0029000505250251 D  hldkey                 1     11  0
0030000809050251 D   mhmid#                1      9  0
0031000809050251 D   mhseq#               10     11  0
0032000510120029  *
0033000510120250 D                 DS
0034000505250251 D  chgkey                 1     11  0
0035000809050251 D   mxmid#                1      9  0
0036000809050251 D   mxseq#               10     11  0
0037000204030029  *
0038000204030250 D                 DS
0039001911210251 D  curdem                 1    289
0040000809050251 D   mcdssn                1      9  0
0041000809050251 D   mclnme               10     27
0042000809050251 D   mcfnme               28     39
0043000809050251 D   mcmi                 40     40
0044000809050251 D   mcadr1               41     70
0045000809050251 D   mcadr2               71    100
0046000809050251 D   mccity              101    115
0047000809050251 D   mcst                116    117
0048000809050251 D   mczip               118    126  0
0049000809050251 D   mcarea              127    129  0
0050000809050251 D   mcphn#              130    136  0
0051000809050251 D   mcbrdt              137    144  0
0052000809050251 D   mcgndr              145    145
0053000809050251 D   mcempdt             154    161  0
0054000809050251 D   mcrelcd             179    181
0055000809050251 D   mcefdt              182    189  0
0056000809050251 D   mctfdt              190    197  0
0057000809050251 D   mcgrp#              198    212
0058000809050251 D   mccovt              213    214
0059000811140251 D   mcrate              215    222  2
0060001006100251 D   mcdbtc              223    223
0061001911210251 D   mcemal              224    289
0062001103140251 D   mccdat                        D
0063000505250029  *
0064000505250250 D                 DS
0065001911210251 D  hlddem                 1    289
0066000809050251 D   mhdssn                1      9  0
0067000809050251 D   mhlnme               10     27
0068000809050251 D   mhfnme               28     39
0069000809050251 D   mhmi                 40     40
0070000809050251 D   mhadr1               41     70
0071000809050251 D   mhadr2               71    100
0072000809050251 D   mhcity              101    115
0073000809050251 D   mhst                116    117
0074000809050251 D   mhzip               118    126  0
0075000809050251 D   mharea              127    129  0
0076000809050251 D   mhphn#              130    136  0
0077000809050251 D   mhbrdt              137    144  0
0078000809050251 D   mhgndr              145    145
0079000809050251 D   mhempdt             154    161  0
0080000809050251 D   mhrelcd             179    181
0081000809050251 D   mhefdt              182    189  0
0082000809050251 D   mhtfdt              190    197  0
0083000809050251 D   mhgrp#              198    212
0084000809050251 D   mhcovt              213    214
0085000811140251 D   mhrate              215    222  2
0086001006100251 D   mhdbtc              223    223
0087001911210251 D   mhemal              224    289
0088001103140251 D   mhcdat                        D
0089000809040029  *
0090000809040250 D                 DS
0091001911210251 D  chghdem                1    289
0092000809050251 D   mxhdssn               1      9  0
0093000809050251 D   mxhlnme              10     27
0094000809050251 D   mxhfnme              28     39
0095000809050251 D   mxhmi                40     40
0096000809050251 D   mxhadr1              41     70
0097000809050251 D   mxhadr2              71    100
0098000809050251 D   mxhcity             101    115
0099000809050251 D   mxhst               116    117
0100000809050251 D   mxhzip              118    126  0
0101000809050251 D   mxharea             127    129  0
0102000809050251 D   mxhphn#             130    136  0
0103000809050251 D   mxhbrdt             137    144  0
0104000809050251 D   mxhgndr             145    145
0105000809050251 D   mxhempdt            154    161  0
0106000809050251 D   mxhrelcd            179    181
0107000809050251 D   mxhefdt             182    189  0
0108000809050251 D   mxhtfdt             190    197  0
0109000809050251 D   mxhgrp#             198    212
0110000809050251 D   mxhcovt             213    214
0111000811140251 D   mxhrate             215    222  2
0112001006100251 D   mxhdbtc             223    223
0113001911210251 D   mxhemal             224    289
0114001103140251 D   mxhcdat                       D
0115000809040029  *
0116000809040250 D                 DS
0117001911210251 D  chgcdem                1    289
0118000809050251 D   mxcdssn               1      9  0
0119000809050251 D   mxclnme              10     27
0120000809050251 D   mxcfnme              28     39
0121000809050251 D   mxcmi                40     40
0122000809050251 D   mxcadr1              41     70
0123000809050251 D   mxcadr2              71    100
0124000809050251 D   mxccity             101    115
0125000809050251 D   mxcst               116    117
0126000809050251 D   mxczip              118    126  0
0127000809050251 D   mxcarea             127    129  0
0128000809050251 D   mxcphn#             130    136  0
0129000809050251 D   mxcbrdt             137    144  0
0130000809050251 D   mxcgndr             145    145
0131000809050251 D   mxcempdt            154    161  0
0132000809050251 D   mxcrelcd            179    181
0133000809050251 D   mxcefdt             182    189  0
0134000809050251 D   mxctfdt             190    197  0
0135000809050251 D   mxcgrp#             198    212
0136000809050251 D   mxccovt             213    214
0137000811140251 D   mxcrate             215    222  2
0138001006100251 D   mxcdbtc             223    223
0139001911210251 D   mxcemal             224    289
0140001103140251 D   mxccdat                       D
0141000807210029  *
0142000807210250 D                 DS
0143000807210251 D  curact                 1    214
0144000811130251 D   mctrust               1      3  0
0145000809050251 D   mcsub                 4      6  0
0146000809050251 D   mcacct                7     10  0
0147000809050251 D   mcacnm               11     50
0148000506220029  *
0149000506220250 D                 DS
0150000506220251 D  chgact                 1    214
0151000809050251 D   mxtrst                1      3  0
0152000809050251 D   mxsub                 4      6  0
0153000809050251 D   mxacct                7     10  0
0154000809050251 D   mxacnm               11     50
0155000910140029  *          Plan Renewal Info
0156000910140250 D                 DS
0157000910140251 D  curprn                 1     16
0158000910140251 D   mcpefd                1      8  0
0159000910140251 D   mcptrd                9     16  0
0160000910140250 D                 DS
0161000910140251 D  hldprn                 1     16
0162000910140251 D   mhpefd                1      8  0
0163000910140251 D   mhptrd                9     16  0
0164000910140029  *
0165000809040250 D                 DS
016600110315     D  ISOToday       S               d   DATFMT(*ISO)
016700080904     D  Today          S              8p 0   inz
0168000809040251 D  cutoff         S               D   DATFMT(*ISO)
0169000809040251 D  cutofn         S              8S 0
0170001310070037 D sysdateymd      S               d   datfmt(*iso)
0171000809040029  *
0172000809040250 D                 DS
017300080904     D  gbdate                 1      8  0
017400080904     D   gbyr                  1      4  0
017500080904     D   gbmo                  5      6  0
017600080904     D   gbdy                  7      8  0
0177000809040029  *
0178000809040250 D                 DS
017900070718     D  wkday          S               D     inz
0180001103170029  *
0181001103170250 D                 DS
0182001103170251 D  dnote2                 1     11
0183001103170251 D   note2a                1     11      INZ('DEP SEQ# - ')
0184001103170251 D   ntseq#               10     11
018500110316      *
0186001103160053 D                 DS
0187001103160054 D  dbc1           C                   'Std Card Std Mail to Cardhlder'
0188000809040111  *
018900091014      *
019000110315     C     cardky        klist
019100110315     C                   kfld                    mcmid#
019200110315     C                   kfld                    mcseq#
019300110315      *
019400110315     C     gkey          klist
019500110315     C                   kfld                    mctrust
019600091014     C                   kfld                    mcsub
019700091014     C                   kfld                    mcacct
019800091223      *
019900091223     C     prnkey        klist
020000091223     C                   kfld                    mctrust
020100091223     C                   kfld                    mcsub
020200091223     C                   kfld                    mcacct
020300091014     C                   kfld                    mcpln
020400091014     C                   kfld                    mcpefd
020500091014      *
020600080904      *
020700080904     C                   move      udate         ISOtoday
020800080904     C                   move      ISOtoday      today
0209000809040291  * Determine Term date cutoff - 1 year ago
0210000809040297 C     ISOtoday      subdur    365:*D        cutoff
0211000809040297 C                   movel     cutoff        cutofn
021200080904      *
021300080904      *
0214000809040291  * Main Line - Loop thru current and hold file - comparing the 2
0215001004220297 C     *LOVAL        setll     mbcur2p
0216001004220297 C     *LOVAL        setll     mbhld2p
0217000303310296 C                   dou       *in21 = '1'
021800020403      *
0219000807210296 C                   if        getcur = *blank
0220001004220297 C                   read      mbcur2p                                21
0221000807210296 C                   If        *in21 = '1'
0222000807210296 C                   movel     'E'           getcur
0223000807210296 C                   If        gethld = 'E' or
0224000807210296 C                             hldkey = 99999999999
0225000807210296 C                   leave
0226000807210296 C                   endif
0227000807210296 C                   endif
0228000807210296 C                   else
0229000807210296 C                   If        getcur <> 'E'
0230000204050296 C                   movel     *blank        getcur
0231000204050296 C                   endif
0232000303310296 C                   endif
0233000508240291  *
0234000508240291  *      DEBUG
0235001103160296 C                   If        mcmid# = 590434134
0236000809050296 C                   movel     mcmid#        mcmid#
0237000508240296 C                   endif
023800020403      *
0239000204050296 C                   if        gethld = *blank
0240000807310296  *
0241000807310296 C                   dou       *in22 = '1'
0242001004220297 C                   read      mbhld2p                                22
0243000909180291  *      DEBUG
0244000909180296 C                   If        mhmid# = 213594714
0245000909180296 C                   movel     mhmid#        mhmid#
0246000909180296 C                   endif
0247000909180296  *
0248000809050296 C                   If        *in22 = '0' and mhtfdt = 0 or
0249000809050296 C                             *in22 = '0' and mhtfdt > cutofn
0250000807310296 C                   leave
0251000807310296 C                   endif
0252000807310296 C                   enddo
0253000807310296  *
0254000204050296 C                   If        *in22 = '1'
0255000204050296 C                   movel     'E'           gethld
0256000506210296 C                   eval      hldkey = 99999999999
0257000408020296 C                   If        getcur = 'E'
0258000408020296 C                   leave
0259000505250296 C                   else
0260000505250296 C                   exsr      putnew
0261000809020296 C                   iter
0262000809020296 C                   endif
0263000809020296 C                   endif
0264000204050296 C                   else
0265000303310296 C                   If        gethld <> 'E'
0266000204050296 C                   movel     *blank        gethld
0267000204050296 C                   endif
0268000807210296 C                   endif
026900080721      *
0270000910140296 C                   if        curprn <> hldprn and mcpln = mhplan
0271000204050296 C                   endif
027200091014      *
0273000910140296 C                   if        curkey < hldkey
0274000910140297 C                   exsr      putnew
0275000910140296 C                   movel     'N'           gethld
0276000910140296 C                   iter
0277000910140296 C                   endif
027800020405      *
0279000408020296 C                   if        curkey > hldkey and
0280000408020296 C                             gethld <> 'E'
0281000803040297 C                   exsr      putx
0282000204050296 C                   movel     'N'           getcur
0283000204050296 C                   iter
0284000204050296 C                   endif
028500091014      *
0286000910140296 C                   if        curprn <> hldprn
0287000910140296 C                   endif
028800020405      *
0289001103160296 C                   if        curdem <> hlddem or mccdat <> mhcdat
0290000505250297 C                   exsr      putchg
0291000204050296 C                   iter
0292000204050296 C                   endif
029300020405      *
0294000204050296 C                   enddo
029500020405      *
0296000204050296 C                   movel     '1'           *inlr
0297000204050296 C                   return
0298000204020107  **************************************************************************
0299000204020107  *
0300000505250107  *     PUTNEW - Write the New record to the change file
0301000204020107  *
0302000204020107  **************************************************************************
030300050525     C     putnew        begsr
0304000806160107  *          Per angie - do not report on grp 9127                      ****
030500080905     C***********        if        bcgrp# = '9127           '
030600080905     C***                leavesr
030700080905     C***********        endif
0308000806160107  *                                                                     ****
030900100422     C                   clear                   mbchg2r
031000091223     C                   eval      mxsts = 'N'
0311000912230107  *                                                                     ****
031200100422     C     gkey          chain     mbhld2l                            41
031300091223     C                   if        *IN41 = '1'
031400091223     C                   eval      mxsts = 'G'
031500091223     C                   endif
0316000912230107  *                                                                     ****
031700050525     C                   eval      chgkey = curkey
031800080304     C                   eval      chgcdem = curdem
031900110316     C                   eval      mxccdat = mccdat
032000070718      *    BeneGap - LUM Logic
032100080905     C                   eval      mxctfldt = mxctfdt
032200080905     C                   eval      gbdate = mxctfdt
032300070718     C                   if        gbdy = 01
032400070718     C                   move      gbdate        wkday
032500070718     C                   subdur    1:*D          wkday
032600080905     C                   move      wkday         mxctfldt
032700070718     C                   endif
032800070718      *
032900080905     C                   eval      mxlsts = mxsts
033000070718      *
033100050622     C                   eval      chgact = curact
033200080905     C                   eval      mxdate = today
033300100422     C                   write     mbchg2r
033400110316      *
033500110316     C                   if        mccdat <> *LOVAL
033600110316     C                   endif
033700110316      *
033800020405     C                   endsr
0339000505250107  **************************************************************************
0340000505250107  *
0341000505250107  *     PUTCHG - Write the Chg record to the change file
0342000505250107  *
0343000505250107  **************************************************************************
034400050525     C     putchg        begsr
0345000806160107  *          Per angie - do not report on grp 9127                      ****
034600080905     C*********          if        bcgrp# = '9127           '
034700110325     C****               leavesr
034800080905     C*********          endif
0349000806160107  *                                                                     ****
035000100422     C                   clear                   mbchg2r
035100080905     C                   eval      mxsts = 'C'
035200050525     C                   eval      chgkey = curkey
035300050622     C                   eval      chgact = curact
035400080905     C                   eval      mxclnme = mclnme
035500080905     C                   eval      mxcfnme = mcfnme
035600080905     C                   eval      mxcgrp# = mcgrp#
035700080304      *
035800080905     C                   if        mclnme <> mhlnme
035900080905     C                   eval      mxhlnme = mhlnme
036000050525     C                   endif
036100080304      *
036200080905     C                   if        mcfnme <> mhfnme
036300080905     C                   eval      mxhfnme = mhfnme
036400080304     C                   endif
036500080304      *
036600080905     C                   if        mcmi <> mhmi
036700080905     C                   eval      mxcmi = mcmi
036800080905     C                   eval      mxhmi = mhmi
036900080304     C                   endif
037000080903      *
037100080905     C                   if        mcdssn <> mhdssn
037200080905     C                   eval      mxcdssn = mcdssn
037300080905     C                   eval      mxhdssn = mhdssn
037400080903     C                   endif
037500050525      *
037600080905     C                   if        mcadr1 <> mhadr1
037700080905     C                   eval      mxcadr1 = mcadr1
037800080905     C                   eval      mxhadr1 = mhadr1
037900050525     C                   endif
038000050525      *
038100080905     C                   if        mcadr2 <> mhadr2
038200080905     C                   eval      mxcadr2 = mcadr2
038300080905     C                   eval      mxhadr2 = mhadr2
038400050525     C                   endif
038500191111      *
038600191121     C                   if        mcemal <> mhemal
038700191121     C                   eval      mxcemal = mcemal
038800191121     C                   eval      mxhemal = mhemal
038900191121     C                   endif
039000050525      *
039100080905     C                   if        mccity <> mhcity
039200080905     C                   eval      mxccity = mccity
039300080905     C                   eval      mxhcity = mhcity
039400050525     C                   endif
039500050525      *
039600080905     C                   if        mcst <> mhst
039700080905     C                   eval      mxcst   = mcst
039800080905     C                   eval      mxhst   = mhst
039900050525     C                   endif
040000050525      *
040100080905     C                   if        mczip  <> mhzip
040200080905     C                   eval      mxczip  = mczip
040300080905     C                   eval      mxhzip  = mhzip
040400050525     C                   endif
040500050525      *
040600080905     C                   if        mcarea <> mharea
040700080905     C                   eval      mxcarea = mcarea
040800080905     C                   eval      mxharea = mharea
040900050525     C                   endif
041000080905      *
041100080905     C                   if        mcphn# <> mhphn#
041200080905     C                   eval      mxcphn# = mcphn#
041300080905     C                   eval      mxhphn# = mhphn#
041400050525     C                   endif
041500050525      *
041600080905     C                   if        mcbrdt <> mhbrdt
041700080905     C                   eval      mxcbrdt = mcbrdt
041800080905     C                   eval      mxhbrdt = mhbrdt
041900050525     C                   endif
042000050525      *
042100080905     C                   if        mcgndr <> mhgndr
042200080905     C                   eval      mxcgndr = mcgndr
042300080905     C                   eval      mxhgndr = mhgndr
042400050525     C                   endif
042500050525      *
042600080905     C                   if        mcempdt <> mhempdt
042700080905     C                   eval      mxcempdt = mcempdt
042800080905     C                   eval      mxhempdt = mhempdt
042900050525     C                   endif
043000050525      *
043100080905     C                   if        mcrelcd <> mhrelcd
043200080905     C                   eval      mxcrelcd = mcrelcd
043300080905     C                   eval      mxhrelcd = mhrelcd
043400050525     C                   endif
043500050525      *
043600080905     C                   if        mcefdt <> mhefdt
043700080905     C                   eval      mxcefdt = mcefdt
043800080905     C                   eval      mxhefdt = mhefdt
043900050525     C                   endif
044000050525      *
044100080905     C                   if        mctfdt <> mhtfdt
044200080304      *
044300131204     C                   if        mctfdt <> 0
044400131204     C                   eval      mxsts = 'T'
044500131204     C                   endif
044600131204      *
044700080905     C                   eval      mxctfdt = mctfdt
044800080905     C                   eval      mxctfldt = mxctfdt
044900080905     C                   eval      gbdate = mxctfdt
045000080304     C                   if        gbdy = 01
045100080304     C                   move      gbdate        wkday
045200080304     C                   subdur    1:*D          wkday
045300080905     C                   move      wkday         mxctfldt
045400080304     C                   endif
045500080304      *
045600080905     C                   eval      mxhtfdt = mhtfdt
045700080905     C                   eval      mxhtfldt = mhtfdt
045800080905     C                   eval      gbdate = mxhtfdt
045900080304     C                   if        gbdy = 01
046000080304     C                   move      gbdate        wkday
046100080304     C                   subdur    1:*D          wkday
046200080905     C                   move      wkday         mxhtfldt
046300080304     C                   endif
046400080304      *
046500050525     C                   endif
046600050525      *
046700080905     C***                if        mcgrp# <> mhgrp#
046800080905     C***                eval      mggrp# = mcgrp#
046900070207     C***                endif
047000120202      *
047100120202     C                   if        mcgrp# <> mhgrp#
047200120202     C                   eval      mxcgrp# = mcgrp#
047300120202     C                   eval      mxhgrp# = mhgrp#
047400120202     C                   endif
047500080904      *
047600080905     C                   if        mccovt <> mhcovt
047700080905     C                   eval      mxccovt = mccovt
047800080905     C                   eval      mxhcovt = mhcovt
047900080904     C                   endif
048000100610      *
048100100610     C                   if        mcdbtc <> mhdbtc
048200100610     C                   eval      mxcdbtc = mcdbtc
048300100610     C                   eval      mxhdbtc = mhdbtc
048400100610     C                   endif
048500110314      *
048600110314     C                   if        mccdat <> mhcdat
048700110314     C                   eval      mxccdat = mccdat
048800110324     C                   eval      mxhcdat = mhcdat
048900110324     C                   endif
049000110324      *
049100110324     C                   if        mcrate <> mhrate
049200110324     C                   eval      mxhrate = mhrate
049300081114     C                   endif
049400110324      *
049500110324     C                   eval      mxcrate = mcrate
049600070718      *
049700110324     C                   eval      mxlsts = mxsts
049800110324      *
049900080905     C                   eval      mxdate = today
050000100422     C                   write     mbchg2r
050100050525     C                   endsr
0502000803040107  **************************************************************************
0503000803040107  *
0504000803040107  *     PUTX - Write the X rec change file
0505000803040107  *
0506000803040107  **************************************************************************
050700080304     C     putx          begsr
050800090918     C                   if        mhtfdt > cutofn or
050900090918     C                             mhtfdt = 0
051000100422     C                   clear                   mbchg2r
051100080905     C                   eval      mxsts = 'X'
051200080304     C                   eval      chgkey = hldkey
051300080304     C                   eval      chghdem = hlddem
051400080905     C                   eval      mxdate = today
051500100422     C                   write     mbchg2r
051600080430     C                   endif
051700080430     C                   endsr
