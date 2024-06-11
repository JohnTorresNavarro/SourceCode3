0001000204020002  *****************************************************************************
000200080710      * DW471      Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400080710      *            DATE - 07/2008                                                 *
000500020403      *  DESCRIPTION - Compare Hold file with Current file to produce             *
000600080710      *                Change file for HRA Acct info                              *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900020402      *                                                                *
0010009102150018 F******************************************************************
0011000807100020 FBGACCP    IF   E           K DISK
0012000807100020 FBGAHLDP   IF   E           K DISK
0013000807100020 FBGACHGP   O  A E             DISK
0014000204020025  *
0015000510120029  *
0016000510120250 D                 DS
0017000204030251 D  getcur                 1      1    INZ(*blank)
0018000204030251 D  gethld                 2      2    INZ(*blank)
0019000204030029  *
0020000204030250 D                 DS
0021000807100251 D  curkey                 1     15
0022000807100251 D   bagrp#                1     15
0023000505250029  *
0024000505250250 D                 DS
0025000807100251 D  hldkey                 1     15
0026000807100251 D   blgrp#                1     15
0027000510120029  *
0028000510120250 D                 DS
0029000808140251 D  chgkey                 1     15
0030000808140251 D   bzgrp#                1     15
0031000808140029  *
0032000808140250 D                 DS
0033000808140251 D  curdem                 1    156
0034000808140251 D   baacnm                1     40
0035000808140251 D   baadr1               41     70
0036000807100251 D   baadr2               71    100
0037000808140251 D   bacity              101    115
0038000808140251 D   bast                116    117
0039000808140251 D   bazip               118    126  0
0040000808140251 D   bacntc              127    156
0041000808140029  *
0042000808140250 D                 DS
0043000808140251 D  hlddem                 1    156
0044000808140251 D   blacnm                1     40
0045000808140251 D   bladr1               41     70
0046000808140251 D   bladr2               71    100
0047000808140251 D   blcity              101    115
0048000808140251 D   blst                116    117
0049000808140251 D   blzip               118    126  0
0050000808140251 D   blcntc              127    156
0051000808140029  *
0052000808140250 D                 DS
0053000808140251 D  chghdem                1    156
0054000808140251 D   bzhacnm               1     40
0055000808140251 D   bzhadr1              41     70
0056000808140251 D   bzhadr2              71    100
0057000808140251 D   bzhcity             101    115
0058000807100251 D   bzhst               116    117
0059000807100251 D   bzhzip              118    126  0
0060000808140251 D   bzhcntc             127    156
0061000808140029  *
0062000808140250 D                 DS
0063000808140251 D  chgcdem                1    156
0064000808140251 D   bzaacnm               1     40
0065000808140251 D   bzaadr1              41     70
0066000808140251 D   bzaadr2              71    100
0067000808140251 D   bzacity             101    115
0068000808140251 D   bzast               116    117
0069000808140251 D   bzazip              118    126  0
0070000808140251 D   bzacntc             127    156
0071000807160029  *
0072000807160250 D                 DS
0073000807100251 D  curact                 1     10
0074000807100251 D   batrst                1      3  0
0075000807100251 D   basub                 4      6  0
0076000807100251 D   baacct                7     10  0
0077000807210029  *
0078000807210250 D                 DS
0079000807210251 D  chgact                 1     10
0080000807210251 D   bztrst                1      3  0
0081000807210251 D   bzsub                 4      6  0
0082000807100251 D   bzacct                7     10  0
0083000807210029  *
0084000807210250 D                 DS
008500080721     D  ISOToday       S               d     inz
008600080721     D  Today          S              8p 0   inz
0087000807210251 D  cutoff         S               D   DATFMT(*ISO)
0088000807210251 D  cutofn         S              8S 0
0089000807210029  *
0090000707180250 D                 DS
009100070718     D  gbdate                 1      8  0
009200070718     D   gbyr                  1      4  0
009300070718     D   gbmo                  5      6  0
009400080814     D   gbdy                  7      8  0
0095000808140029  *
0096000808140250 D                 DS
009700080711     D  wkday          S               D     inz
0098000808140111  *
009900080814      *
010000080814     C                   move      udate         ISOtoday
010100080814     C                   move      ISOtoday      today
0102000804300291  * Determine Term date cutoff - 1 year ago
0103000807110297 C     ISOtoday      subdur    360:*D        cutoff
0104000808140297 C                   movel     cutoff        cutofn
010500080814      *
010600080711      *
0107000807110291  * Main Line - Loop thru current and hold file - comparing the 2
0108000807110297 C     *LOVAL        setll     bgaccp
0109000807100297 C     *LOVAL        setll     bgahldp
0110000807110296 C                   dou       *in21 = '1'
011100080716      *
0112000807160296 C                   if        getcur = *blank
0113000808140297 C                   read      bgaccp                                 21
0114000808140296 C                   If        *in21 = '1'
0115000808140296 C                   movel     'E'           getcur
0116000807160296 C                   If        gethld = 'E' or
0117000807110296 C                             hldkey = '999999999999999'
0118000807110296 C                   leave
0119000807220296 C                   endif
0120000807220296 C                   endif
0121000807220296 C                   else
0122000807220296 C                   If        getcur <> 'E'
0123000807220296 C                   movel     *blank        getcur
0124000807220296 C                   endif
0125000807220296 C                   endif
0126000807220291  *
0127000807220291  *      DEBUG
0128000807220296 C                   If        bagrp# = '111111111111111'
0129000807110296 C                   movel     bagrp#        bagrp#
0130000807220296 C                   endif
013100080722      *
0132000807220296 C                   if        gethld = *blank
0133000807220297 C                   read      bgahldp                                22
0134000204050296 C                   If        *in22 = '1'
0135000204050296 C                   movel     'E'           gethld
0136000807100296 C                   eval      hldkey = '999999999999999'
0137000807220296 C                   If        getcur = 'E'
0138000807220296 C                   leave
0139000807220296 C                   else
0140000807220296 C                   exsr      putnew
0141000807220296 C                   iter
0142000807220296 C                   endif
0143000807220296 C                   endif
0144000807220296 C                   else
0145000808140296 C                   If        gethld <> 'E'
0146000808140296 C                   movel     *blank        gethld
0147000808140296 C                   endif
0148000808140296 C                   endif
014900080814      *
0150000808140296 C                   if        curkey < hldkey
0151000505250297 C                   exsr      putnew
0152000808140296 C                   movel     'N'           gethld
0153000808140296 C                   iter
0154000808140296 C                   endif
015500080814      *
0156000408020296 C                   if        curkey > hldkey and
0157000408020296 C                             gethld <> 'E'
0158000803040297 C                   exsr      putx
0159000204050296 C                   movel     'N'           getcur
0160000204050296 C                   iter
0161000204050296 C                   endif
016200020405      *
0163000204100296 C                   if        curdem <> hlddem
0164000807110297 C                   exsr      putchg
0165000807110296 C                   iter
0166000807110296 C                   endif
016700080711      *
0168000807110296 C                   enddo
016900080711      *
0170000204050296 C                   movel     '1'           *inlr
0171000204050296 C                   return
0172000204020107  ********************************************************************************
0173000204020107  *
0174000505250107  *     PUTNEW - Write the New record to the change file
0175000204020107  *
0176000204020107  ********************************************************************************
017700050525     C     putnew        begsr
0178000807110107  *                                                                     **********
017900080711     C                   clear                   bgachgr
018000080710     C                   eval      bzsts = 'N'
018100050525     C                   eval      chgkey = curkey
018200080304     C                   eval      chgcdem = curdem
018300070718      *
018400050622     C                   eval      chgact = curact
018500080710     C                   eval      bzdate = today
018600080722     C                   eval      bzsent = 0
018700080710     C                   write     bgachgr
018800020405     C                   endsr
0189000505250107  ********************************************************************************
0190000505250107  *
0191000505250107  *     PUTCHG - Write the Chg record to the change file
0192000505250107  *
0193000505250107  ********************************************************************************
019400050525     C     putchg        begsr
0195000806160107  *                                                                     **********
019600080710     C                   clear                   bgachgr
019700080710     C                   eval      bzsts = 'C'
019800050525     C                   eval      chgkey = curkey
019900050622     C                   eval      chgact = curact
020000080304      *
020100080710     C                   if        baacnm <> blacnm
020200080710     C                   eval      bzaacnm = baacnm
020300080710     C                   eval      bzhacnm = blacnm
020400050525     C                   endif
020500080710      *
020600080710     C                   if        baadr1 <> bladr1
020700080710     C                   eval      bzaadr1 = baadr1
020800080711     C                   eval      bzhadr1 = bladr1
020900080711     C                   endif
021000080711      *
021100080711     C                   if        baadr2 <> bladr2
021200080711     C                   eval      bzaadr2 = baadr2
021300080711     C                   eval      bzhadr2 = bladr2
021400080711     C                   endif
021500080710      *
021600080710     C                   if        bacity <> blcity
021700080710     C                   eval      bzacity = bacity
021800080710     C                   eval      bzhcity = blcity
021900080710     C                   endif
022000080710      *
022100080710     C                   if        bast <> blst
022200080710     C                   eval      bzast = bast
022300080710     C                   eval      bzhst = blst
022400080710     C                   endif
022500080710      *
022600080710     C                   if        bazip <> blzip
022700080710     C                   eval      bzazip = bazip
022800080710     C                   eval      bzhzip = blzip
022900080711     C                   endif
023000080710      *
023100080710     C                   if        bacntc <> blcntc
023200080710     C                   eval      bzacntc = bacntc
023300080710     C                   eval      bzhcntc = blcntc
023400080710     C                   endif
023500070718      *
023600080710     C                   eval      bzdate = today
023700080722     C                   eval      bzsent = 0
023800080710     C                   write     bgachgr
023900050525     C                   endsr
0240000803040107  ********************************************************************************
0241000803040107  *
0242000803040107  *     PUTX - Write the X rec change file
0243000803040107  *
0244000803040107  ********************************************************************************
024500080304     C     putx          begsr
024600080710     C                   clear                   bgachgr
024700080710     C                   eval      bzsts = 'X'
024800080304     C                   eval      chgkey = hldkey
024900080304     C                   eval      chghdem = hlddem
025000080710     C                   eval      bzdate = today
025100080722     C                   eval      bzsent = 0
025200080711     C                   write     bgachgr
025300080711     C                   endsr
