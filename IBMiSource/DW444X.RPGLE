0001000204020002  *****************************************************************************
000200101011      * DW444X     Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400101011      *            DATE - 10/2010                                                 *
000500091001      *  DESCRIPTION - Create MBI update files using GBS MBI Chg file             *
000600091230      * NOTE!! When you make a chg to MBxxP files - change D-specs here           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900020402      *                                                                *
0010009102150018 F******************************************************************
0011001004220020 FMBCHG2P   IF   E           K DISK
0012001004220020 FMBCUR2P   IF   E           K DISK
0013000910010020 FMBIAP     UF   E             DISK
0014000910010020 FMBIBP     O    E             DISK
0015000910010020 FMBICP     O    E             DISK
0016000910010020 FMBIFP     O    E             DISK
0017000910010020 FMBIZP     O    E             DISK
0018000910080020 FMBCMBP    O    E             DISK
0019000707230025  *
0020000204030250 D                 DS
0021000910020251 D  mcarea                 1      3  0
0022000910020251 D   areac                 1      3
0023000910020025  *
0024000910020250 D                 DS
0025000910020251 D  mxcgrp#                1     15
0026000910020251 D   cgrp4                 1      4
0027000910020025  *
0028000910020250 D                 DS
0029000910020251 D  mcgrp#                 1     15
0030000910020251 D   grp4                  1      4
0031001004210251 D   grp1                  1      1
0032001004210251 D   grp24                 2      4
0033000912030251 D   grp12                 1     12
0034001005240251 D   grp212                2     12
0035000912030251 D   grp13                13     15
0036001003260025  *
0037001003260250 D                 DS
0038001003260251 D  mbgrp#                 1      9
0039001003260251 D   bgrp1                 1      3    INZ('GBS')
0040001003260251 D   bgrp2                 4      7
0041000805150029  *
0042000805150250 D                 DS
0043000910010251 D  mcphn#                 1      7  0
0044000910010251 D   p3                    1      3
0045000910010251 D   p4                    4      7
0046000910010029  *
0047000910010250 D                 DS
0048000910010251 D  curkey                 1     11  0
0049000910010251 D   mcmid#                1      9  0
0050000910010251 D   mcmida                1      9
0051000809180251 D   mcseq#               10     11  0
0052000505250029  *
0053000510120250 D                 DS
0054000505250251 D  chgkey                 1     11  0
0055000809190251 D   mxmid#                1      9  0
0056000809190251 D   mxseq#               10     11  0
0057000807310029  *
0058000807310250 D                 DS
0059000807310251 D  hldkey                 1     11  0 INZ(0)
0060000807310251 D  astrsk                12     22    INZ('***********')
0061000807310029  *
0062000809150250 D                 DS
0063000809150251 D  curact                 1    214
0064000811130251 D   mctrust               1      3  0
0065000809190251 D   mcsub                 4      6  0
0066000809190251 D   mcacct                7     10  0
0067000809190251 D   mcacnm               11     50
0068000711080029  *
0069000711080250 D                 DS
007000091002     D  recct                  1      6S 0
007100091002     D  reccta                 1      6
007200090108    * *
0073000901080053 D                 DS
0074000910020054 D  wkamt          S              9
0075000910130251 D  cntf           S              2  0 INZ(0)
0076000910130251 D  cntt           S              2  0 INZ(0)
0077000910130251 D  cntl           S              2  0 INZ(0)
0078000910130251 D  fnm1           S              1
0079000711080111  *
0080000910080029  *   Format Output Records
0081000910080250 D                 DS
0082001911210251 D  ibrec                  1    316
0083000910080251 D   ibrcid                1      2
0084000910080251 D   ibtpa                 3      8
0085000910080251 D   ibemlr                9     17
0086000910080251 D   ibemly               18     26
0087000910080251 D   iblnme               27     52
0088000910080251 D   ibfnme               53     71
0089000910080251 D   ibmi                 72     72
0090000910080251 D   ibphn#               73     91
0091000910080251 D   ibadr1               92    127
0092000910080251 D   ibadr2              128    163
0093000910080251 D   ibcity              164    183
0094000910080251 D   ibst                184    193
0095000910080251 D   ibzip               194    202
0096000910080251 D   ibcnty              203    205
0097000910080251 D   ibgndr              206    206
0098000910080251 D   ibbrdt              207    214
0099000910160251 D   ibrmth              215    215
0100001911210251 D   ibemal              216    315
0101001911210251 D   ibfill              316    316
0102000910080250 D                 DS
0103000910150251 D  icrec                  1    138
0104000910080251 D   icrcid                1      2
0105000910080251 D   ictpa                 3      8
0106000910080251 D   icemlr                9     17
0107000910150251 D   icplan               18     35
0108000912030251 D     pln12              18     29
0109000912030251 D     pln4               18     21
0110000912030251 D     pln3               22     24
0111000910150251 D   icemly               36     44
0112000910150251 D   icactp               45     48
0113000910150251 D   icpeff               49     56
0114000910150251 D   icptrm               57     64
0115000910150251 D   icsts                65     65
0116000910150251 D   iceypp               66     84
0117000910150251 D   icerpp               85    103
0118000910150251 D   icefrf              104    122
0119000910150251 D   icetrm              123    130
0120000910150251 D   iceeff              131    138
0121000910080250 D                 DS
0122001004150251 D  ifrec                  1     40
0123000910080251 D   ifrcid                1      2
0124000910080251 D   iftpa                 3      8
0125000910080251 D   ifemlr                9     17
0126000910080251 D   ifemly               18     26
0127001004150251 D   ifdep                27     37
0128001004150251 D   ifsmcd               38     38
0129001004150251 D   ifadcd               39     39
0130001004150251 D   ifissu               40     40
0131000910080250 D                 DS
0132000910080251 D  izrec                  1     42
0133000910080251 D   izrcid                1      2
0134000910080251 D   iztpa                 3      8
0135000910080251 D   izemlr                9     17
0136000910080251 D   izemly               18     26
0137000910080251 D   iztrm                27     34
0138000910080251 D   izelig               35     42
0139000910080291  *
014000080919     C     mbckey        klist
014100080919     C                   kfld                    mxmid#
014200080919     C                   kfld                    mxseq#
0143000508240291  *
0144000803270291  *
0145000910020296 C                   dou       *in21 = '1'
0146001004220297 C                   read      mbchg2p                                21
0147001010110291  *
0148001010110296 C                   if        *in21 = '0'
0149001003120291  *
0150000912300296 C                   If        (mxsts = 'N' and mxseq# = 0) or
0151000912300296 C                             (mxsts = 'G' and mxseq# = 0)
0152000809260291  *
0153000809260296 C                   If        mxhtfdt = 0 and mxctfdt = 0
0154001010270291  *      Skip AAAA and AAAQ grps - GBS
0155001010270296 C                   If        cgrp4 = 'AAAA' or cgrp4 = 'AAAQ'
0156001010270296 C                   iter
0157001010270296 C                   endif
0158001610130291  *      DEBUG SHIT
0159001610130296 C                   If        mxmid# = 155429564
0160000809260296 C                   movel     mxmid#        mxmid#
0161000910020296 C                   endif
016200080926      *
0163000807250296 C                   if        hldkey <> chgkey
0164000807250297 C                   eval      hldkey = chgkey
016500091001     C                   exsr      putnew
016600070605     C                   endif
016700080725     C                   else
016800091001      *
016900080725     C                   endif
017000080725     C                   endif
017100091002      *
017200101011     C                   endif
017300091002     C                   enddo
017400091002      *
017500091002     C                   eval      recct = recct + 1
017600091002     C                   movel     reccta        iarcnt
017700091002     C                   update    mbiar
017800091002      *
0179000910020297 C                   movel     '1'           *inlr
0180000910020297 C                   return
0181000705300107  ********************************************************************************
0182000705300107  *
0183000910010107  *     PUTNEW - Write the New record to MBI Import files
0184000705300107  *
0185000705300107  ********************************************************************************
018600091001     C     putnew        begsr
0187001004220297 C     mbckey        setll     mbcur2p                            21
0188000807250296 C                   dou       *in21 = '1'
0189001004220297 C                   read      mbcur2p                                21
0190000809190296 C                   If        *in21 = '0' and mcmid# = mxmid# and
0191000809190296 C                             mcseq# = mxseq#
0192000807250297 C                   leave
0193000807250297 C                   else
0194000706050297 C                   leavesr
0195000706050297 C                   endif
0196000706050297 C                   enddo
0197000910010291  *    IB rec
019800100421     C                   If        grp1 = '*'
019900100421     C                   movel(P)  grp24         bgrp2
020000100421     C                   else
020100100421     C                   movel     grp4          bgrp2
020200100421     C                   endif
020300091001     C                   movel(P)  mbgrp#        ibemlr
020400091001     C                   movel     mcmid#        ibemly
020500091001     C                   movel(P)  mclnme        iblnme
020600091001     C                   movel(P)  mcfnme        ibfnme
020700091001     C                   movel     mcmi          ibmi
020800091013     C                   exsr      namrtn
020900091002     C                   eval      ibphn# = '(' + areac + ')' + p3 + '-' + p4
021000091001     C                   movel(P)  mcadr1        ibadr1
021100091001     C                   movel(P)  mcadr2        ibadr2
021200191121     C                   movel(P)  mcemal        ibemal
021300091001     C                   movel(P)  mccity        ibcity
021400091001     C                   movel(P)  mcst          ibst
021500091001     C                   movel(P)  mczip         ibzip
021600091002     C                   eval      ibcnty = 'US '
021700091001     C                   If        mcgndr = 'M'
021800091001     C                   eval      ibgndr = '1'
021900091001     C                   else
022000091001     C                   eval      ibgndr = '2'
022100091001     C                   endif
022200091001     C                   movel     mcbrdt        ibbrdt
022300091016     C                   eval      ibrmth = '1'
022400191121    * *
022500191121     C                   eval      ibfill = 'X'
022600191121    * *     Write IB rec
022700091001     C                   write     mbibr
022800091008     C                   clear                   mbcmbr
022900091008     C                   movel     ibrec         mcdata
023000091008     C                   write     mbcmbr
023100091001     C                   eval      recct = recct + 1
023200070530    * *
0233000910010291  *     IC Rec
023400091001     C                   movel(P)  mbgrp#        icemlr
023500091001     C                   movel     mcmid#        icemly
023600091001     C                   movel(P)  'HRA'         icactp
023700091203     C                   if        grp13 <> '   '
023800091204     C******?            movel(P)  grp13         pln3
023900100315     C                   movel(P)  grp13         icactp
024000091014     C                   endif
024100100315      *
024200100524     C                   if        grp1 = '*'
024300100524     C                   movel(P)  grp212        pln12
024400100524     C                   else
024500100524     C                   movel(P)  grp12         pln12
024600100524     C                   endif
024700100315     C                   if        pln3 = *blanks
024800100315     C                   movel(P)  'HRA'         pln3
024900100315     C                   endif
025000100315      *
025100100315     C                   movel     mcpefd        icpeff
025200100315     C                   movel     mcptrd        icptrm
025300091001     C                   eval      icsts = '1'
025400091001     C                   move      '0.00'        iceypp
025500091001     C                   move      '0.00'        icerpp
025600091002     C                   eval      wkamt = %EDITW(mcrate:'      .  ')
025700091002     C                   move      wkamt         icefrf
025800091002     C                   if        mctfdt = 0
025900091002     C                   eval      icetrm = *blanks
026000091002     C                   else
026100120918     C******             movel     mctfdt        icetrm
026200091002     C                   endif
026300091001     C                   movel     mcefdt        iceeff
026400091001    * *     Write IC rec
026500091001     C                   write     mbicr
026600091008     C                   clear                   mbcmbr
026700091008     C                   movel     icrec         mcdata
026800091008     C                   write     mbcmbr
026900091001     C                   eval      recct = recct + 1
027000091001    * *
0271000910010291  *     IF Rec
027200091001     C                   movel(P)  mbgrp#        ifemlr
027300091001     C                   movel     mcmid#        ifemly
027400091001     C                   movel(P)  *blanks       ifdep
027500091104    * *     Card shit
027600101011    * *          No card
027700101011     C                   if        mcdbtc = ' ' or mcdbtc = 'N'
027800101011     C                   movel(P)  '1'           ifsmcd
027900101011     C                   movel(P)  '0'           ifadcd
028000101011     C                   movel(P)  '1'           ifissu
028100101011     C                   endif
028200101011    * *          Issue card - Standard US Mail to card holder
028300101011     C                   if        mcdbtc = '1'
028400101011     C                   movel(P)  '1'           ifsmcd
028500101011     C                   movel(P)  '1'           ifadcd
028600101011     C                   movel(P)  '2'           ifissu
028700101011     C                   endif
028800101011    * *          Issue card - Standard US Mail to Employer
028900101011     C                   if        mcdbtc = '2'
029000101011     C                   movel(P)  '1'           ifsmcd
029100101011     C                   movel(P)  '2'           ifadcd
029200101011     C                   movel(P)  '2'           ifissu
029300101011     C                   endif
029400101011    * *          Issue card - Bulk overnite to employer
029500101011     C                   if        mcdbtc = '4'
029600101011     C                   movel(P)  '3'           ifsmcd
029700101011     C                   movel(P)  '2'           ifadcd
029800101011     C                   movel(P)  '2'           ifissu
029900101011     C                   endif
030000091001    * *     Write IF rec
030100091001     C                   write     mbifr
030200091008     C                   clear                   mbcmbr
030300091008     C                   movel     ifrec         mcdata
030400091008     C                   write     mbcmbr
030500091001     C                   eval      recct = recct + 1
030600091001    * *
0307000910010291  *     IZ Rec
030800091001     C                   movel(P)  mbgrp#        izemlr
030900091001     C                   movel     mcmid#        izemly
031000091002     C                   if        mctfdt = 0
031100091002     C                   eval      iztrm = *blanks
031200091002     C                   else
031300091002     C                   movel     mctfdt        iztrm
031400091002     C                   endif
031500091001     C                   movel     mcefdt        izelig
031600091001    * *     Write IZ rec
031700091001     C                   write     mbizr
031800091008     C                   clear                   mbcmbr
031900091008     C                   movel     izrec         mcdata
032000091008     C                   write     mbcmbr
032100091001     C                   eval      recct = recct + 1
032200070530      *
032300070530     C                   endsr
0324000711080107  ********************************************************************************
0325000711080107  *
0326000910130107  *     NAMRTN - Reduce total Name length to 20 chars
0327000711080107  *
0328000711080107  ********************************************************************************
0329000910130296 C     namrtn        begsr
0330000910130296 C                   eval      cntl = %scan('  ':iblnme:2)
0331000910130296 C                   if        cntl = 0
0332000910130296 C                   eval      cntl = 25
0333000910130296 C                   else
0334000910130296 C                   eval      cntl = cntl - 1
0335000910130296 C                   endif
0336000910130291  *      If LNAM is GT 18 - Just use last name
0337000910130296 C                   if        cntl > 18
0338000910130296 C                   movel     *blanks       ibfnme
0339000910130296 C                   movel     *blanks       ibmi
0340000910130296 C                   leavesr
0341000910130296 C                   endif
0342000910130291  *
0343000910130296 C                   eval      cntf = %scan('  ':ibfnme:2)
0344000910130296 C                   if        cntf = 0
0345000910130296 C                   eval      cntf = 18
0346000910130296 C                   else
0347000910130296 C                   eval      cntf = cntf - 1
0348000910130296 C                   endif
0349000910130291  *   If LNAM + FNAM + 1 > 18 - remove MI
0350000910130296 C                   eval      cntt = cntl + cntf + 1
0351000910130296 C                   if        cntt > 18
0352000910130296 C                   eval      ibmi = ' '
0353000910130296 C                   endif
0354000910130291  *   If LNAM + FNAM + 1 > 20 - remove MI and use 1 char FNAM
0355000910130291  *
0356000910130296 C                   if        cntt > 20
0357000910130296 C                   movel     ibfnme        fnm1
0358000910130296 C                   movel(P)  fnm1          ibfnme
0359000910130296 C                   endif
0360000910130296 C                   endsr
0361000910130107  ********************************************************************************
0362000910130107  *
0363000910130107  *     INZSR - Preprocessing
0364000910130107  *
0365000910130107  ********************************************************************************
036600071108     C     *Inzsr        Begsr
036700091001    * *   SET DEFAULT FIELDS
0368000910010297 C                   clear                   mbibr
0369000910010297 C                   clear                   mbicr
0370001001150297 C                   clear                   mbifr
0371001001150297 C                   clear                   mbizr
0372001001150297 C                   eval      ibrcid = 'IB'
0373001001150297 C                   eval      icrcid = 'IC'
0374001001150297 C                   eval      ifrcid = 'IF'
0375001001150297 C                   eval      izrcid = 'IZ'
0376001001150297 C                   eval      ibtpa = 'T00025'
0377001001150297 C                   eval      ictpa = 'T00025'
0378001001150297 C                   eval      iftpa = 'T00025'
0379000910010297 C                   eval      iztpa = 'T00025'
038000091001    * *   Get IA rec
038100091001     C                   read      mbiap
0382000910010297 C                   eval      recct = 0
038300091001    * *
038400091001     C                   endsr
