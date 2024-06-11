0001000204020002  *****************************************************************************
000200080529      * DW461     Group Benefit Services                                          *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400080529      *            DATE - 05/2008                                                 *
000500020403      *  DESCRIPTION - Compare Hold file with Current file to produce             *
000600050525      *                Change file                                                *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900020402      *                                                                *
0010009102150018 F******************************************************************
0011000805290020 FP1CURP    IF   E           K DISK
0012000805290020 FP1HLDP    IF   E           K DISK
0013000805290020 FP1CHGP    O  A E             DISK
0014000204020025  *
0015000510120029  *
0016000510120250 D                 DS
0017000204030251 D  getcur                 1      1    INZ(*blank)
0018000204030251 D  gethld                 2      2    INZ(*blank)
0019000204030029  *
0020000204030250 D                 DS
0021000505250251 D  curkey                 1     11  0
0022000805290251 D   p1mid#                1      9  0
0023000805290251 D   p1seq#               10     11  0
0024000505250029  *
0025000505250250 D                 DS
0026000505250251 D  hldkey                 1     11  0
0027000805290251 D   phmid#                1      9  0
0028000805290251 D   phseq#               10     11  0
0029000510120029  *
0030000510120250 D                 DS
0031000505250251 D  chgkey                 1     11  0
0032000805290251 D   pxmid#                1      9  0
0033000805290251 D   pxseq#               10     11  0
0034000204030029  *
0035000204030250 D                 DS
0036000805290251 D  curdem                 1    203
0037000805290251 D   p1dssn                1      9  0
0038000805290251 D   p1lnme               10     27
0039000805290251 D   p1fnme               28     39
0040000805290251 D   p1mi                 40     40
0041000805290251 D   p1adr1               41     70
0042000805290251 D   p1adr2               71    100
0043000805290251 D   p1city              101    115
0044000805290251 D   p1st                116    117
0045000805290251 D   p1zip               118    126  0
0046000805290251 D   p1area              127    129  0
0047000805290251 D   p1phn#              130    136  0
0048000805290251 D   p1brdt              137    144  0
0049000805290251 D   p1gndr              145    145
0050000805290251 D   p1empdt             154    161  0
0051000805290251 D   p1relcd             179    181
0052000805290251 D   p1efdt              182    189  0
0053000805290251 D   p1tfdt              190    197  0
0054000805290251 D   p1plan              198    201
0055000805290251 D   p1covt              202    203
0056000505250029  *
0057000505250250 D                 DS
0058000805290251 D  hlddem                 1    203
0059000805290251 D   phdssn                1      9  0
0060000805290251 D   phlnme               10     27
0061000805290251 D   phfnme               28     39
0062000805290251 D   phmi                 40     40
0063000805290251 D   phadr1               41     70
0064000805290251 D   phadr2               71    100
0065000805290251 D   phcity              101    115
0066000805290251 D   phst                116    117
0067000805290251 D   phzip               118    126  0
0068000805290251 D   pharea              127    129  0
0069000805290251 D   phphn#              130    136  0
0070000805290251 D   phbrdt              137    144  0
0071000805290251 D   phgndr              145    145
0072000805290251 D   phempdt             154    161  0
0073000805290251 D   phrelcd             179    181
0074000805290251 D   phefdt              182    189  0
0075000805290251 D   phtfdt              190    197  0
0076000805290251 D   phplan              198    201
0077000805290251 D   phcovt              202    203
0078000505250029  *
0079000505250250 D                 DS
0080000805290251 D  chghdem                1    203
0081000805290251 D   pxhdssn               1      9  0
0082000805290251 D   pxhlnme              10     27
0083000805290251 D   pxhfnme              28     39
0084000805290251 D   pxhmi                40     40
0085000805290251 D   pxhadr1              41     70
0086000805290251 D   pxhadr2              71    100
0087000805290251 D   pxhcity             101    115
0088000805290251 D   pxhst               116    117
0089000805290251 D   pxhzip              118    126  0
0090000805290251 D   pxharea             127    129  0
0091000805290251 D   pxhphn#             130    136  0
0092000805290251 D   pxhbrdt             137    144  0
0093000805290251 D   pxhgndr             145    145
0094000805290251 D   pxhempdt            154    161  0
0095000805290251 D   pxhrelcd            179    181
0096000805290251 D   pxhefdt             182    189  0
0097000805290251 D   pxhtfdt             190    197  0
0098000805290251 D   pxhplan             198    201
0099000805290251 D   pxhcovt             202    203
0100000803040029  *
0101000803040250 D                 DS
0102000805290251 D  chgcdem                1    203
0103000805290251 D   pxcdssn               1      9  0
0104000805290251 D   pxclnme              10     27
0105000805290251 D   pxcfnme              28     39
0106000805290251 D   pxcmi                40     40
0107000805290251 D   pxcadr1              41     70
0108000805290251 D   pxcadr2              71    100
0109000805290251 D   pxccity             101    115
0110000805290251 D   pxcst               116    117
0111000805290251 D   pxczip              118    126  0
0112000805290251 D   pxcarea             127    129  0
0113000805290251 D   pxcphn#             130    136  0
0114000805290251 D   pxcbrdt             137    144  0
0115000805290251 D   pxcgndr             145    145
0116000805290251 D   pxcempdt            154    161  0
0117000805290251 D   pxcrelcd            179    181
0118000805290251 D   pxcefdt             182    189  0
0119000805290251 D   pxctfdt             190    197  0
0120000805290251 D   pxcplan             198    201
0121000805290251 D   pxccovt             202    203
0122000506220029  *
0123000204030029  *
0124000505250250 D                 DS
012500050525     D  ISOToday       S               d     inz
012600050525     D  Today          S              8p 0   inz
0127000804300251 D  cutoff         S               D   DATFMT(*ISO)
0128000804300251 D  cutofn         S              8S 0
0129000707180029  *
0130000707180250 D                 DS
013100070718     D  gbdate                 1      8  0
013200070718     D   gbyr                  1      4  0
013300070718     D   gbmo                  5      6  0
013400070718     D   gbdy                  7      8  0
0135000707180029  *
0136000707180250 D                 DS
013700070718     D  wkday          S               D     inz
0138000505250111  *
013900050525      *
014000050525     C                   move      udate         ISOtoday
014100050525     C                   move      ISOtoday      today
0142000804300291  * Determine Term date cutoff - 1 year ago
0143000804300297 C     ISOtoday      subdur    360:*D        cutoff
0144000804300297 C                   movel     cutoff        cutofn
014500080430      *
014600050525      *
0147000204050291  * Main Line - Loop thru current and hold file - comparing the 2
0148000805290297 C     *LOVAL        setll     p1curp
0149000805290297 C     *LOVAL        setll     p1hldp
0150000303310296 C                   dou       *in21 = '1'
015100020403      *
0152000204030296 C                   if        getcur = *blank
0153000805290297 C                   read      p1curp                                 21
0154000204030296 C                   If        *in21 = '1'
0155000204030296 C                   movel     'E'           getcur
0156000506210296 C                   If        gethld = 'E' or
0157000506210296 C                             hldkey = 99999999999
0158000408020296 C                   leave
0159000408020296 C                   endif
0160000204030296 C                   endif
0161000204050296 C                   else
0162000303310296 C                   If        getcur <> 'E'
0163000204050296 C                   movel     *blank        getcur
0164000204050296 C                   endif
0165000303310296 C                   endif
0166000508240291  *
0167000508240291  *      DEBUG
0168000805290296 C                   If        p1mid# = 324649685
0169000805290296 C                   movel     p1mid#        p1mid#
0170000508240296 C                   endif
017100020403      *
0172000204050296 C                   if        gethld = *blank
0173000805290297 C                   read      p1hldp                                 22
0174000204050296 C                   If        *in22 = '1'
0175000204050296 C                   movel     'E'           gethld
0176000506210296 C                   eval      hldkey = 99999999999
0177000408020296 C                   If        getcur = 'E'
0178000408020296 C                   leave
0179000505250296 C                   else
0180000505250296 C                   exsr      putnew
0181000505250296 C                   iter
0182000505250296 C                   endif
0183000408020296 C                   endif
0184000204050296 C                   else
0185000303310296 C                   If        gethld <> 'E'
0186000204050296 C                   movel     *blank        gethld
0187000204050296 C                   endif
0188000303310296 C                   endif
018900020405      *
0190000204050296 C                   if        curkey < hldkey
0191000505250297 C                   exsr      putnew
0192000204050296 C                   movel     'N'           gethld
0193000204050296 C                   iter
0194000204050296 C                   endif
019500020405      *
0196000408020296 C                   if        curkey > hldkey and
0197000408020296 C                             gethld <> 'E'
0198000803040297 C                   exsr      putx
0199000204050296 C                   movel     'N'           getcur
0200000204050296 C                   iter
0201000204050296 C                   endif
020200020405      *
0203000204100296 C                   if        curdem <> hlddem
0204000505250297 C                   exsr      putchg
0205000204050296 C                   iter
0206000204050296 C                   endif
020700020405      *
0208000204050296 C                   enddo
020900020405      *
0210000204050296 C                   movel     '1'           *inlr
0211000204050296 C                   return
0212000204020107  ********************************************************************************
0213000204020107  *
0214000505250107  *     PUTNEW - Write the New record to the change file
0215000204020107  *
0216000204020107  ********************************************************************************
021700050525     C     putnew        begsr
021800080529     C                   clear                   p1chgr
021900080529     C                   eval      pxsts = 'N'
022000050525     C                   eval      chgkey = curkey
022100080304     C                   eval      chgcdem = curdem
022200070718      *
022300080529     C                   eval      pxdate = today
022400080529     C                   write     p1chgr
022500020405     C                   endsr
0226000505250107  ********************************************************************************
0227000505250107  *
0228000505250107  *     PUTCHG - Write the Chg record to the change file
0229000505250107  *
0230000505250107  ********************************************************************************
023100050525     C     putchg        begsr
023200080529     C                   clear                   p1chgr
023300080529     C                   eval      pxsts = 'C'
023400050525     C                   eval      chgkey = curkey
023500080529     C                   eval      pxclnme = p1lnme
023600080529     C                   eval      pxcfnme = p1fnme
023700080304      *
023800080529     C                   if        p1lnme <> phlnme
023900080529     C                   eval      pxhlnme = phlnme
024000050525     C                   endif
024100080304      *
024200080529     C                   if        p1fnme <> phfnme
024300080529     C                   eval      pxhfnme = phfnme
024400080304     C                   endif
024500080304      *
024600080529     C                   if        p1mi <> phmi
024700080529     C                   eval      pxcmi = p1mi
024800080529     C                   eval      pxhmi = phmi
024900080304     C                   endif
025000050525      *
025100080529     C                   if        p1adr1 <> phadr1
025200080529     C                   eval      pxcadr1 = p1adr1
025300080529     C                   eval      pxhadr1 = phadr1
025400050525     C                   endif
025500050525      *
025600080529     C                   if        p1adr2 <> phadr2
025700080529     C                   eval      pxcadr2 = p1adr2
025800080529     C                   eval      pxhadr2 = phadr2
025900050525     C                   endif
026000050525      *
026100080529     C                   if        p1city <> phcity
026200080529     C                   eval      pxccity = p1city
026300080529     C                   eval      pxhcity = phcity
026400050525     C                   endif
026500050525      *
026600080529     C                   if        p1st <> phst
026700080529     C                   eval      pxcst   = p1st
026800080529     C                   eval      pxhst   = phst
026900050525     C                   endif
027000050525      *
027100080529     C                   if        p1zip  <> phzip
027200080529     C                   eval      pxczip  = p1zip
027300080529     C                   eval      pxhzip  = phzip
027400050525     C                   endif
027500050525      *
027600080529     C                   if        p1area <> pharea
027700080529     C                   eval      pxcarea = p1area
027800080529     C                   eval      pxharea = pharea
027900050525     C                   endif
028000050525      *
028100080529     C                   if        p1phn# <> phphn#
028200080529     C                   eval      pxcphn# = p1phn#
028300080529     C                   eval      pxhphn# = phphn#
028400050525     C                   endif
028500050525      *
028600080529     C                   if        p1brdt <> phbrdt
028700080529     C                   eval      pxcbrdt = p1brdt
028800080529     C                   eval      pxhbrdt = phbrdt
028900050525     C                   endif
029000050525      *
029100080529     C                   if        p1gndr <> phgndr
029200080529     C                   eval      pxcgndr = p1gndr
029300080529     C                   eval      pxhgndr = phgndr
029400050525     C                   endif
029500050525      *
029600080529     C                   if        p1empdt <> phempdt
029700080529     C                   eval      pxcempdt = p1empdt
029800080529     C                   eval      pxhempdt = phempdt
029900050525     C                   endif
030000050525      *
030100080529     C                   if        p1relcd <> phrelcd
030200080529     C                   eval      pxcrelcd = p1relcd
030300080529     C                   eval      pxhrelcd = phrelcd
030400050525     C                   endif
030500050525      *
030600080529     C                   if        p1efdt <> phefdt
030700080529     C                   eval      pxcefdt = p1efdt
030800080529     C                   eval      pxhefdt = phefdt
030900050525     C                   endif
031000050525      *
031100080529     C                   if        p1tfdt <> phtfdt
031200080529     C                   eval      pxctfdt = p1tfdt
031300080529     C                   eval      pxhtfdt = phtfdt
031400080529     C                   endif
031500050525      *
031600080529     C                   if        p1covt <> phcovt
031700080529     C                   eval      pxccovt = p1covt
031800080529     C                   eval      pxhcovt = phcovt
031900050525     C                   endif
032000080529      *
032100080529     C                   if        p1plan <> phplan
032200080529     C                   eval      pxcplan = p1plan
032300080529     C                   eval      pxhplan = phplan
032400080529     C                   endif
032500070718      *
032600080529     C                   eval      pxdate = today
032700080529     C                   write     p1chgr
032800050525     C                   endsr
0329000803040107  ********************************************************************************
0330000803040107  *
0331000803040107  *     PUTX - Write the X rec change file
0332000803040107  *
0333000803040107  ********************************************************************************
033400080304     C     putx          begsr
033500080529     C                   if        phtfdt > cutofn
033600080529     C                   clear                   p1chgr
033700080529     C                   eval      pxsts = 'X'
033800080304     C                   eval      chgkey = hldkey
033900080304     C                   eval      chghdem = hlddem
034000080529     C                   eval      pxdate = today
034100080529     C                   write     p1chgr
034200080430     C                   endif
034300080430     C                   endsr
