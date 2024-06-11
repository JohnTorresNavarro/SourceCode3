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
0018000910140020 FMBPRNP    UF A E           K DISK
0019001103150020 FDEBCARD   UF A E           K DISK
0020001103160020 FHIST      O  A E             DISK
0021001103210029  *
0022001103210250 D                 DS
0023000204030251 D  getcur                 1      1    INZ(*blank)
0024000204030251 D  gethld                 2      2    INZ(*blank)
0025000204030029  *
0026000204030250 D                 DS
0027000505250251 D  curkey                 1     11  0
0028000809050251 D   mcmid#                1      9  0
0029000809050251 D   mcseq#               10     11  0
0030000505250029  *
0031000505250250 D                 DS
0032000505250251 D  hldkey                 1     11  0
0033000809050251 D   mhmid#                1      9  0
0034000809050251 D   mhseq#               10     11  0
0035000510120029  *
0036000510120250 D                 DS
0037000505250251 D  chgkey                 1     11  0
0038000809050251 D   mxmid#                1      9  0
0039000809050251 D   mxseq#               10     11  0
0040000204030029  *
0041000204030250 D                 DS
0042001911210251 D  curdem                 1    289
0043000809050251 D   mcdssn                1      9  0
0044000809050251 D   mclnme               10     27
0045000809050251 D   mcfnme               28     39
0046000809050251 D   mcmi                 40     40
0047000809050251 D   mcadr1               41     70
0048000809050251 D   mcadr2               71    100
0049000809050251 D   mccity              101    115
0050000809050251 D   mcst                116    117
0051000809050251 D   mczip               118    126  0
0052000809050251 D   mcarea              127    129  0
0053000809050251 D   mcphn#              130    136  0
0054000809050251 D   mcbrdt              137    144  0
0055000809050251 D   mcgndr              145    145
0056000809050251 D   mcempdt             154    161  0
0057000809050251 D   mcrelcd             179    181
0058000809050251 D   mcefdt              182    189  0
0059000809050251 D   mctfdt              190    197  0
0060000809050251 D   mcgrp#              198    212
0061000809050251 D   mccovt              213    214
0062000811140251 D   mcrate              215    222  2
0063001006100251 D   mcdbtc              223    223
0064001911210251 D   mcemal              224    289
0065001103140251 D   mccdat                        D
0066000505250029  *
0067000505250250 D                 DS
0068001911210251 D  hlddem                 1    289
0069000809050251 D   mhdssn                1      9  0
0070000809050251 D   mhlnme               10     27
0071000809050251 D   mhfnme               28     39
0072000809050251 D   mhmi                 40     40
0073000809050251 D   mhadr1               41     70
0074000809050251 D   mhadr2               71    100
0075000809050251 D   mhcity              101    115
0076000809050251 D   mhst                116    117
0077000809050251 D   mhzip               118    126  0
0078000809050251 D   mharea              127    129  0
0079000809050251 D   mhphn#              130    136  0
0080000809050251 D   mhbrdt              137    144  0
0081000809050251 D   mhgndr              145    145
0082000809050251 D   mhempdt             154    161  0
0083000809050251 D   mhrelcd             179    181
0084000809050251 D   mhefdt              182    189  0
0085000809050251 D   mhtfdt              190    197  0
0086000809050251 D   mhgrp#              198    212
0087000809050251 D   mhcovt              213    214
0088000811140251 D   mhrate              215    222  2
0089001006100251 D   mhdbtc              223    223
0090001911210251 D   mhemal              224    289
0091001103140251 D   mhcdat                        D
0092000809040029  *
0093000809040250 D                 DS
0094001911210251 D  chghdem                1    289
0095000809050251 D   mxhdssn               1      9  0
0096000809050251 D   mxhlnme              10     27
0097000809050251 D   mxhfnme              28     39
0098000809050251 D   mxhmi                40     40
0099000809050251 D   mxhadr1              41     70
0100000809050251 D   mxhadr2              71    100
0101000809050251 D   mxhcity             101    115
0102000809050251 D   mxhst               116    117
0103000809050251 D   mxhzip              118    126  0
0104000809050251 D   mxharea             127    129  0
0105000809050251 D   mxhphn#             130    136  0
0106000809050251 D   mxhbrdt             137    144  0
0107000809050251 D   mxhgndr             145    145
0108000809050251 D   mxhempdt            154    161  0
0109000809050251 D   mxhrelcd            179    181
0110000809050251 D   mxhefdt             182    189  0
0111000809050251 D   mxhtfdt             190    197  0
0112000809050251 D   mxhgrp#             198    212
0113000809050251 D   mxhcovt             213    214
0114000811140251 D   mxhrate             215    222  2
0115001006100251 D   mxhdbtc             223    223
0116001911210251 D   mxhemal             224    289
0117001103140251 D   mxhcdat                       D
0118000809040029  *
0119000809040250 D                 DS
0120001911210251 D  chgcdem                1    289
0121000809050251 D   mxcdssn               1      9  0
0122000809050251 D   mxclnme              10     27
0123000809050251 D   mxcfnme              28     39
0124000809050251 D   mxcmi                40     40
0125000809050251 D   mxcadr1              41     70
0126000809050251 D   mxcadr2              71    100
0127000809050251 D   mxccity             101    115
0128000809050251 D   mxcst               116    117
0129000809050251 D   mxczip              118    126  0
0130000809050251 D   mxcarea             127    129  0
0131000809050251 D   mxcphn#             130    136  0
0132000809050251 D   mxcbrdt             137    144  0
0133000809050251 D   mxcgndr             145    145
0134000809050251 D   mxcempdt            154    161  0
0135000809050251 D   mxcrelcd            179    181
0136000809050251 D   mxcefdt             182    189  0
0137000809050251 D   mxctfdt             190    197  0
0138000809050251 D   mxcgrp#             198    212
0139000809050251 D   mxccovt             213    214
0140000811140251 D   mxcrate             215    222  2
0141001006100251 D   mxcdbtc             223    223
0142001911210251 D   mxcemal             224    289
0143001103140251 D   mxccdat                       D
0144000807210029  *
0145000807210250 D                 DS
0146000807210251 D  curact                 1    214
0147000811130251 D   mctrust               1      3  0
0148000809050251 D   mcsub                 4      6  0
0149000809050251 D   mcacct                7     10  0
0150000809050251 D   mcacnm               11     50
0151000506220029  *
0152000506220250 D                 DS
0153000506220251 D  chgact                 1    214
0154000809050251 D   mxtrst                1      3  0
0155000809050251 D   mxsub                 4      6  0
0156000809050251 D   mxacct                7     10  0
0157000809050251 D   mxacnm               11     50
0158000910140029  *          Plan Renewal Info
0159000910140250 D                 DS
0160000910140251 D  curprn                 1     16
0161000910140251 D   mcpefd                1      8  0
0162000910140251 D   mcptrd                9     16  0
0163000910140250 D                 DS
0164000910140251 D  hldprn                 1     16
0165000910140251 D   mhpefd                1      8  0
0166000910140251 D   mhptrd                9     16  0
0167000910140029  *
0168000809040250 D                 DS
016900110315     D  ISOToday       S               d   DATFMT(*ISO)
017000080904     D  Today          S              8p 0   inz
0171000809040251 D  cutoff         S               D   DATFMT(*ISO)
0172000809040251 D  cutofn         S              8S 0
0173001310070037 D sysdateymd      S               d   datfmt(*iso)
0174000809040029  *
0175000809040250 D                 DS
017600080904     D  gbdate                 1      8  0
017700080904     D   gbyr                  1      4  0
017800080904     D   gbmo                  5      6  0
017900080904     D   gbdy                  7      8  0
0180000809040029  *
0181000809040250 D                 DS
018200070718     D  wkday          S               D     inz
0183001103170029  *
0184001103170250 D                 DS
0185001103170251 D  dnote2                 1     11
0186001103170251 D   note2a                1     11      INZ('DEP SEQ# - ')
0187001103170251 D   ntseq#               10     11
018800110316      *
0189001103160053 D                 DS
0190001103160054 D  dbc1           C                   'Std Card Std Mail to Cardhlder'
0191000809040111  *
019200091014      *
019300110315     C     cardky        klist
019400110315     C                   kfld                    mcmid#
019500110315     C                   kfld                    mcseq#
019600110315      *
019700110315     C     gkey          klist
019800110315     C                   kfld                    mctrust
019900091014     C                   kfld                    mcsub
020000091014     C                   kfld                    mcacct
020100091223      *
020200091223     C     prnkey        klist
020300091223     C                   kfld                    mctrust
020400091223     C                   kfld                    mcsub
020500091223     C                   kfld                    mcacct
020600091014     C                   kfld                    mcpln
020700091014     C                   kfld                    mcpefd
020800091014      *
020900080904      *
021000080904     C                   move      udate         ISOtoday
021100080904     C                   move      ISOtoday      today
0212000809040291  * Determine Term date cutoff - 1 year ago
0213000809040297 C     ISOtoday      subdur    365:*D        cutoff
0214000809040297 C                   movel     cutoff        cutofn
021500080904      *
021600080904      *
0217000809040291  * Main Line - Loop thru current and hold file - comparing the 2
0218001004220297 C     *LOVAL        setll     mbcur2p
0219001004220297 C     *LOVAL        setll     mbhld2p
0220000303310296 C                   dou       *in21 = '1'
022100020403      *
0222000807210296 C                   if        getcur = *blank
0223001004220297 C                   read      mbcur2p                                21
0224000807210296 C                   If        *in21 = '1'
0225000807210296 C                   movel     'E'           getcur
0226000807210296 C                   If        gethld = 'E' or
0227000807210296 C                             hldkey = 99999999999
0228000807210296 C                   leave
0229000807210296 C                   endif
0230000807210296 C                   endif
0231000807210296 C                   else
0232000807210296 C                   If        getcur <> 'E'
0233000204050296 C                   movel     *blank        getcur
0234000204050296 C                   endif
0235000303310296 C                   endif
0236000508240291  *
0237000508240291  *      DEBUG
0238001103160296 C                   If        mcmid# = 590434134
0239000809050296 C                   movel     mcmid#        mcmid#
0240000508240296 C                   endif
024100020403      *
0242000204050296 C                   if        gethld = *blank
0243000807310296  *
0244000807310296 C                   dou       *in22 = '1'
0245001004220297 C                   read      mbhld2p                                22
0246000909180291  *      DEBUG
0247000909180296 C                   If        mhmid# = 213594714
0248000909180296 C                   movel     mhmid#        mhmid#
0249000909180296 C                   endif
0250000909180296  *
0251000809050296 C                   If        *in22 = '0' and mhtfdt = 0 or
0252000809050296 C                             *in22 = '0' and mhtfdt > cutofn
0253000807310296 C                   leave
0254000807310296 C                   endif
0255000807310296 C                   enddo
0256000807310296  *
0257000204050296 C                   If        *in22 = '1'
0258000204050296 C                   movel     'E'           gethld
0259000506210296 C                   eval      hldkey = 99999999999
0260000408020296 C                   If        getcur = 'E'
0261000408020296 C                   leave
0262000505250296 C                   else
0263000505250296 C                   exsr      putnew
0264000809020296 C                   iter
0265000809020296 C                   endif
0266000809020296 C                   endif
0267000204050296 C                   else
0268000303310296 C                   If        gethld <> 'E'
0269000204050296 C                   movel     *blank        gethld
0270000204050296 C                   endif
0271000807210296 C                   endif
027200080721      *
0273000910140296 C                   if        curprn <> hldprn and mcpln = mhplan
0274000910140297 C                   exsr      putprn
0275000204050296 C                   endif
027600091014      *
0277000910140296 C                   if        curkey < hldkey
0278000910140297 C                   exsr      putnew
0279000910140296 C                   movel     'N'           gethld
0280000910140296 C                   iter
0281000910140296 C                   endif
028200020405      *
0283000408020296 C                   if        curkey > hldkey and
0284000408020296 C                             gethld <> 'E'
0285000803040297 C                   exsr      putx
0286000204050296 C                   movel     'N'           getcur
0287000204050296 C                   iter
0288000204050296 C                   endif
028900091014      *
0290000910140296 C                   if        curprn <> hldprn
0291000910140297 C                   exsr      putprn
0292000910140296 C                   endif
029300020405      *
0294001103160296 C                   if        curdem <> hlddem or mccdat <> mhcdat
0295000505250297 C                   exsr      putchg
0296000204050296 C                   iter
0297000204050296 C                   endif
029800020405      *
0299000204050296 C                   enddo
030000020405      *
0301000204050296 C                   movel     '1'           *inlr
0302000204050296 C                   return
0303000204020107  **************************************************************************
0304000204020107  *
0305000505250107  *     PUTNEW - Write the New record to the change file
0306000204020107  *
0307000204020107  **************************************************************************
030800050525     C     putnew        begsr
0309000806160107  *          Per angie - do not report on grp 9127                      ****
031000080905     C***********        if        bcgrp# = '9127           '
031100080905     C***                leavesr
031200080905     C***********        endif
0313000806160107  *                                                                     ****
031400100422     C                   clear                   mbchg2r
031500091223     C                   eval      mxsts = 'N'
0316000912230107  *                                                                     ****
031700100422     C     gkey          chain     mbhld2l                            41
031800091223     C                   if        *IN41 = '1'
031900091223     C                   eval      mxsts = 'G'
032000091223     C                   endif
0321000912230107  *                                                                     ****
032200050525     C                   eval      chgkey = curkey
032300080304     C                   eval      chgcdem = curdem
032400110316     C                   eval      mxccdat = mccdat
032500070718      *    BeneGap - LUM Logic
032600080905     C                   eval      mxctfldt = mxctfdt
032700080905     C                   eval      gbdate = mxctfdt
032800070718     C                   if        gbdy = 01
032900070718     C                   move      gbdate        wkday
033000070718     C                   subdur    1:*D          wkday
033100080905     C                   move      wkday         mxctfldt
033200070718     C                   endif
033300070718      *
033400080905     C                   eval      mxlsts = mxsts
033500070718      *
033600050622     C                   eval      chgact = curact
033700080905     C                   eval      mxdate = today
033800100422     C                   write     mbchg2r
033900110316      *
034000110316     C                   if        mccdat <> *LOVAL
034100110316     C                   exsr      cardsr
034200110316     C                   endif
034300110316      *
034400020405     C                   endsr
0345000505250107  **************************************************************************
0346000505250107  *
0347000505250107  *     PUTCHG - Write the Chg record to the change file
0348000505250107  *
0349000505250107  **************************************************************************
035000050525     C     putchg        begsr
0351000806160107  *          Per angie - do not report on grp 9127                      ****
035200080905     C*********          if        bcgrp# = '9127           '
035300110325     C****               leavesr
035400080905     C*********          endif
0355000806160107  *                                                                     ****
035600100422     C                   clear                   mbchg2r
035700080905     C                   eval      mxsts = 'C'
035800050525     C                   eval      chgkey = curkey
035900050622     C                   eval      chgact = curact
036000080905     C                   eval      mxclnme = mclnme
036100080905     C                   eval      mxcfnme = mcfnme
036200080905     C                   eval      mxcgrp# = mcgrp#
036300080304      *
036400080905     C                   if        mclnme <> mhlnme
036500080905     C                   eval      mxhlnme = mhlnme
036600050525     C                   endif
036700080304      *
036800080905     C                   if        mcfnme <> mhfnme
036900080905     C                   eval      mxhfnme = mhfnme
037000080304     C                   endif
037100080304      *
037200080905     C                   if        mcmi <> mhmi
037300080905     C                   eval      mxcmi = mcmi
037400080905     C                   eval      mxhmi = mhmi
037500080304     C                   endif
037600080903      *
037700080905     C                   if        mcdssn <> mhdssn
037800080905     C                   eval      mxcdssn = mcdssn
037900080905     C                   eval      mxhdssn = mhdssn
038000080903     C                   endif
038100050525      *
038200080905     C                   if        mcadr1 <> mhadr1
038300080905     C                   eval      mxcadr1 = mcadr1
038400080905     C                   eval      mxhadr1 = mhadr1
038500050525     C                   endif
038600050525      *
038700080905     C                   if        mcadr2 <> mhadr2
038800080905     C                   eval      mxcadr2 = mcadr2
038900080905     C                   eval      mxhadr2 = mhadr2
039000050525     C                   endif
039100191111      *
039200191121     C                   if        mcemal <> mhemal
039300191121     C                   eval      mxcemal = mcemal
039400191121     C                   eval      mxhemal = mhemal
039500191121     C                   endif
039600050525      *
039700080905     C                   if        mccity <> mhcity
039800080905     C                   eval      mxccity = mccity
039900080905     C                   eval      mxhcity = mhcity
040000050525     C                   endif
040100050525      *
040200080905     C                   if        mcst <> mhst
040300080905     C                   eval      mxcst   = mcst
040400080905     C                   eval      mxhst   = mhst
040500050525     C                   endif
040600050525      *
040700080905     C                   if        mczip  <> mhzip
040800080905     C                   eval      mxczip  = mczip
040900080905     C                   eval      mxhzip  = mhzip
041000050525     C                   endif
041100050525      *
041200080905     C                   if        mcarea <> mharea
041300080905     C                   eval      mxcarea = mcarea
041400080905     C                   eval      mxharea = mharea
041500050525     C                   endif
041600080905      *
041700080905     C                   if        mcphn# <> mhphn#
041800080905     C                   eval      mxcphn# = mcphn#
041900080905     C                   eval      mxhphn# = mhphn#
042000050525     C                   endif
042100050525      *
042200080905     C                   if        mcbrdt <> mhbrdt
042300080905     C                   eval      mxcbrdt = mcbrdt
042400080905     C                   eval      mxhbrdt = mhbrdt
042500050525     C                   endif
042600050525      *
042700080905     C                   if        mcgndr <> mhgndr
042800080905     C                   eval      mxcgndr = mcgndr
042900080905     C                   eval      mxhgndr = mhgndr
043000050525     C                   endif
043100050525      *
043200080905     C                   if        mcempdt <> mhempdt
043300080905     C                   eval      mxcempdt = mcempdt
043400080905     C                   eval      mxhempdt = mhempdt
043500050525     C                   endif
043600050525      *
043700080905     C                   if        mcrelcd <> mhrelcd
043800080905     C                   eval      mxcrelcd = mcrelcd
043900080905     C                   eval      mxhrelcd = mhrelcd
044000050525     C                   endif
044100050525      *
044200080905     C                   if        mcefdt <> mhefdt
044300080905     C                   eval      mxcefdt = mcefdt
044400080905     C                   eval      mxhefdt = mhefdt
044500050525     C                   endif
044600050525      *
044700080905     C                   if        mctfdt <> mhtfdt
044800080304      *
044900131204     C                   if        mctfdt <> 0
045000131204     C                   eval      mxsts = 'T'
045100131204     C                   endif
045200131204      *
045300080905     C                   eval      mxctfdt = mctfdt
045400080905     C                   eval      mxctfldt = mxctfdt
045500080905     C                   eval      gbdate = mxctfdt
045600080304     C                   if        gbdy = 01
045700080304     C                   move      gbdate        wkday
045800080304     C                   subdur    1:*D          wkday
045900080905     C                   move      wkday         mxctfldt
046000080304     C                   endif
046100080304      *
046200080905     C                   eval      mxhtfdt = mhtfdt
046300080905     C                   eval      mxhtfldt = mhtfdt
046400080905     C                   eval      gbdate = mxhtfdt
046500080304     C                   if        gbdy = 01
046600080304     C                   move      gbdate        wkday
046700080304     C                   subdur    1:*D          wkday
046800080905     C                   move      wkday         mxhtfldt
046900080304     C                   endif
047000080304      *
047100050525     C                   endif
047200050525      *
047300080905     C***                if        mcgrp# <> mhgrp#
047400080905     C***                eval      mggrp# = mcgrp#
047500070207     C***                endif
047600120202      *
047700120202     C                   if        mcgrp# <> mhgrp#
047800120202     C                   eval      mxcgrp# = mcgrp#
047900120202     C                   eval      mxhgrp# = mhgrp#
048000120202     C                   endif
048100080904      *
048200080905     C                   if        mccovt <> mhcovt
048300080905     C                   eval      mxccovt = mccovt
048400080905     C                   eval      mxhcovt = mhcovt
048500080904     C                   endif
048600100610      *
048700100610     C                   if        mcdbtc <> mhdbtc
048800100610     C                   eval      mxcdbtc = mcdbtc
048900100610     C                   eval      mxhdbtc = mhdbtc
049000100610     C                   endif
049100110314      *
049200110314     C                   if        mccdat <> mhcdat
049300110314     C                   eval      mxccdat = mccdat
049400110324     C                   eval      mxhcdat = mhcdat
049500110324     C                   exsr      cardsr
049600110324     C                   endif
049700110324      *
049800110324     C                   if        mcrate <> mhrate
049900110324     C                   eval      mxhrate = mhrate
050000081114     C                   endif
050100110324      *
050200110324     C                   eval      mxcrate = mcrate
050300070718      *
050400110324     C                   eval      mxlsts = mxsts
050500110324      *
050600080905     C                   eval      mxdate = today
050700100422     C                   write     mbchg2r
050800050525     C                   endsr
0509000803040107  **************************************************************************
0510000803040107  *
0511000803040107  *     PUTX - Write the X rec change file
0512000803040107  *
0513000803040107  **************************************************************************
051400080304     C     putx          begsr
051500090918     C                   if        mhtfdt > cutofn or
051600090918     C                             mhtfdt = 0
051700100422     C                   clear                   mbchg2r
051800080905     C                   eval      mxsts = 'X'
051900080304     C                   eval      chgkey = hldkey
052000080304     C                   eval      chghdem = hlddem
052100080905     C                   eval      mxdate = today
052200100422     C                   write     mbchg2r
052300080430     C                   endif
052400080430     C                   endsr
0525000910140107  **************************************************************************
0526000910140107  *
0527000910140107  *     PUTPRN - Write the Plan Renewal file
0528000910140107  *
0529000910140107  **************************************************************************
053000091014     C     putprn        begsr
0531000910140107  *
053200091014     C     prnkey        chain     mbprnp                             51
053300091103     C                   if        *in51 = '1' and mctfdt = 0
053400091014     C                   clear                   mbprnr
053500091014     C                   eval      mrsts = 'N'
053600091014     C                   eval      mrgrp# = mcgrp#
053700091014     C                   eval      mrtrst = mctrust
053800091014     C                   eval      mrsub = mcsub
053900091014     C                   eval      mracct = mcacct
054000091014     C                   eval      mracnm = mcacnm
054100091014     C                   eval      mrplan = mcpln
054200091014     C                   eval      mrhpefd = mhpefd
054300091014     C                   eval      mrcpefd = mcpefd
054400091014     C                   eval      mrhptrd = mhptrd
054500091014     C                   eval      mrcptrd = mcptrd
054600091014     C                   eval      mrdate = today
0547000910140107  *
054800091014     C     *DTAARA       define    mruniq        ##SQ             15 0
054900091014     C     *LOCK         in        ##sq
055000091014     C                   add       1             ##SQ
055100091014     C                   move      ##sq          mruniq
055200091014     C                   out       ##sq
0553000910140107  *
055400091014     C                   write     mbprnr
055500091014     C                   endif
055600091014     C                   endsr
0557001103150107  **************************************************************************
0558001103150107  *
0559001103160107  *     CARDSR - Update debit card info and write HIST rec
0560001103150107  *
0561001103150107  **************************************************************************
056200110315     C     cardsr        begsr
0563001103150107  *
056400110315     C     cardky        chain     debcard                            51
056500110316     C                   if        *in51 = '0' and dbprsta = ' ' and
056600110316     C                             dbdeliv <> 'N'
056700110315     C                   eval      dbprsta = 'P'
056800110315     C                   eval      dbprdat = isotoday
056900110315     C                   update    debcardr
057000110316      *
057100110316      *         Write HIST rec
057200110316     C                   clear                   histr
057300110316     C                   move      mcmid#        hkey
057400110316     C                   movel     today         trdate
057500110316     C                   move      'U52'         trcode
057600110316     C                   Z-ADD     0             TRAMT
057700110316     C                   MOVE      *BLANKS       CM$FLG
057800110316     C                   MOVEL     dbc1          CK#NOT
057900110317      *
058000110316     C                   MOVE      *BLANKS       NOTE2
058100110317     C                   if        mcseq# <> 0
058200110317     C                   move      mcseq#        hdseq#
058300110317     C                   move      mcseq#        ntseq#
058400110317     C                   movel     dnote2        note2
058500110317     C                   endif
058600110317      *
058700110316     C                   MOVE      '  '          HDSEQ#
058800131007     C                   MOVEL(P)  'DW441'       HPRGNM
058900110316     C                   Z-ADD     0             RECVDT
059000110316     C                   MOVE      mctrust       HSTRST
059100110316     C                   MOVE      mcsub         HSSUB#
059200110316     C                   MOVE      mcacct        HSACCT
059300110316     C                   MOVEL     dbuser        HOPER
059400110316     C                   MOVEL     'A'           HSDLTD
059500131007     C                   eval      sysdateymd = %date
059600131007     C                   MOVE      sysdateymd    trdate
059700131007     c                   eval      hstrtime = %time
059800110316     C                   WRITE     HISTR
059900110316      *
060000110315     C                   endif
060100110315     C                   endsr
