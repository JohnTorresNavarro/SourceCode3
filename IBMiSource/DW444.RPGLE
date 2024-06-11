0001000204020002  *****************************************************************************
000200091001      * DW444      Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400091001      *            DATE - 10/2009                                                 *
000500091001      *  DESCRIPTION - Create MBI update files using GBS MBI Chg file             *
000600091230      * NOTE!! When you make a chg to MBxxP files - change D-specs here           *
0007000204020002  *****************************************************************************
0008001202280015  *  Change Log: rlj 02/28/2012 Create MBI update record even if term         *
0009001202280015  *                             date is not 0.                                *
0010001209180015  *              RLJ 09/18/12 Don't set emp term date per JB                  *
001100020402      *                                                                *
0012009102150018 F******************************************************************
0013001004220020 FMBCHG2P   IF   E           K DISK
0014001004220020 FMBCUR2P   IF   E           K DISK
0015000910010020 FMBIAP     UF   E             DISK
0016000910010020 FMBIBP     O    E             DISK
0017000910010020 FMBICP     O    E             DISK
0018000910010020 FMBIFP     O    E             DISK
0019000910010020 FMBIZP     O    E             DISK
0020000910080020 FMBCMBP    O    E             DISK
0021000707230025  *
0022000204030250 D                 DS
0023000910020251 D  mcarea                 1      3  0
0024000910020251 D   areac                 1      3
0025000910020025  *
0026000910020250 D                 DS
0027000910020251 D  mxcgrp#                1     15
0028000910020251 D   cgrp4                 1      4
0029000910020025  *
0030000910020250 D                 DS
0031000910020251 D  mcgrp#                 1     15
0032000910020251 D   grp4                  1      4
0033001004210251 D   grp1                  1      1
0034001004210251 D   grp24                 2      4
0035000912030251 D   grp12                 1     12
0036001005240251 D   grp212                2     12
0037000912030251 D   grp13                13     15
0038001003260025  *
0039001003260250 D                 DS
0040001003260251 D  mbgrp#                 1      9
0041001003260251 D   bgrp1                 1      3    INZ('GBS')
0042001003260251 D   bgrp2                 4      7
0043000805150029  *
0044000805150250 D                 DS
0045000910010251 D  mcphn#                 1      7  0
0046000910010251 D   p3                    1      3
0047000910010251 D   p4                    4      7
0048000910010029  *
0049000910010250 D                 DS
0050000910010251 D  curkey                 1     11  0
0051000910010251 D   mcmid#                1      9  0
0052000910010251 D   mcmida                1      9
0053000809180251 D   mcseq#               10     11  0
0054000505250029  *
0055000510120250 D                 DS
0056000505250251 D  chgkey                 1     11  0
0057000809190251 D   mxmid#                1      9  0
0058000809190251 D   mxseq#               10     11  0
0059000807310029  *
0060000807310250 D                 DS
0061000807310251 D  hldkey                 1     11  0 INZ(0)
0062000807310251 D  astrsk                12     22    INZ('***********')
0063000807310029  *
0064000809150250 D                 DS
0065000809150251 D  curact                 1    214
0066000811130251 D   mctrust               1      3  0
0067000809190251 D   mcsub                 4      6  0
0068000809190251 D   mcacct                7     10  0
0069000809190251 D   mcacnm               11     50
0070000711080029  *
0071000711080250 D                 DS
007200091002     D  recct                  1      6S 0
007300091002     D  reccta                 1      6
007400090108    * *
0075000901080053 D                 DS
0076000910020054 D  wkamt          S              9
0077000910130251 D  cntf           S              2  0 INZ(0)
0078000910130251 D  cntt           S              2  0 INZ(0)
0079000910130251 D  cntl           S              2  0 INZ(0)
0080000910130251 D  fnm1           S              1
0081000711080111  *
0082000910080029  *   Format Output Records
0083000910080250 D                 DS
0084000910160251 D  ibrec                  1    215
0085000910080251 D   ibrcid                1      2
0086000910080251 D   ibtpa                 3      8
0087000910080251 D   ibemlr                9     17
0088000910080251 D   ibemly               18     26
0089000910080251 D   iblnme               27     52
0090000910080251 D   ibfnme               53     71
0091000910080251 D   ibmi                 72     72
0092000910080251 D   ibphn#               73     91
0093000910080251 D   ibadr1               92    127
0094000910080251 D   ibadr2              128    163
0095000910080251 D   ibcity              164    183
0096000910080251 D   ibst                184    193
0097000910080251 D   ibzip               194    202
0098000910080251 D   ibcnty              203    205
0099000910080251 D   ibgndr              206    206
0100000910080251 D   ibbrdt              207    214
0101000910160251 D   ibrmth              215    215
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
0147000911040291  *          Group shit
0148001009090296 C                   if        *in21 = '0' and cgrp4 = '9523' or
0149001009090296 C                             *in21 = '0' and cgrp4 = '9523'
0150001003120291  *
0151000912300296 C                   If        (mxsts = 'N' and mxseq# = 0) or
0152000912300296 C                             (mxsts = 'G' and mxseq# = 0)
0153000809260291  *
0154001202280296 C*****              If        mxhtfdt = 0 and mxctfdt = 0
0155000809260291  *      DEBUG
0156000910020296 C                   If        mxmid# = 212061187
0157000809260296 C                   movel     mxmid#        mxmid#
0158000910020291  *      Skip this SSN
0159000910020296 C                   iter
0160000910020296 C                   endif
016100080926      *
0162000807250296 C                   if        hldkey <> chgkey
0163000807250297 C                   eval      hldkey = chgkey
016400091001     C                   exsr      putnew
016500070605     C                   endif
016600120228     C******             else
016700091001      *
016800120228     C******             endif
016900080725     C                   endif
017000091002      *
017100091002     C                   endif
017200091002     C                   enddo
017300091002      *
017400091002     C                   eval      recct = recct + 1
017500091002     C                   movel     reccta        iarcnt
017600091002     C                   update    mbiar
017700091002      *
0178000910020297 C                   movel     '1'           *inlr
0179000910020297 C                   return
0180000705300107  ********************************************************************************
0181000705300107  *
0182000910010107  *     PUTNEW - Write the New record to MBI Import files
0183000705300107  *
0184000705300107  ********************************************************************************
018500091001     C     putnew        begsr
0186001004220297 C     mbckey        setll     mbcur2p                            21
0187000807250296 C                   dou       *in21 = '1'
0188001004220297 C                   read      mbcur2p                                21
0189000809190296 C                   If        *in21 = '0' and mcmid# = mxmid# and
0190000809190296 C                             mcseq# = mxseq#
0191000807250297 C                   leave
0192000807250297 C                   else
0193000706050297 C                   leavesr
0194000706050297 C                   endif
0195000706050297 C                   enddo
0196000910010291  *    IB rec
019700100421     C                   If        grp1 = '*'
019800100421     C                   movel(P)  grp24         bgrp2
019900100421     C                   else
020000100421     C                   movel     grp4          bgrp2
020100100421     C                   endif
020200091001     C                   movel(P)  mbgrp#        ibemlr
020300091001     C                   movel     mcmid#        ibemly
020400091001     C                   movel(P)  mclnme        iblnme
020500091001     C                   movel(P)  mcfnme        ibfnme
020600091001     C                   movel     mcmi          ibmi
020700091013     C                   exsr      namrtn
020800091002     C                   eval      ibphn# = '(' + areac + ')' + p3 + '-' + p4
020900091001     C                   movel(P)  mcadr1        ibadr1
021000091001     C                   movel(P)  mcadr2        ibadr2
021100091001     C                   movel(P)  mccity        ibcity
021200091001     C                   movel(P)  mcst          ibst
021300091001     C                   movel(P)  mczip         ibzip
021400091002     C                   eval      ibcnty = 'US '
021500091001     C                   If        mcgndr = 'M'
021600091001     C                   eval      ibgndr = '1'
021700091001     C                   else
021800091001     C                   eval      ibgndr = '2'
021900091001     C                   endif
022000091001     C                   movel     mcbrdt        ibbrdt
022100091016     C                   eval      ibrmth = '1'
022200091001    * *     Write IB rec
022300091001     C                   write     mbibr
022400091008     C                   clear                   mbcmbr
022500091008     C                   movel     ibrec         mcdata
022600091008     C                   write     mbcmbr
022700091001     C                   eval      recct = recct + 1
022800070530    * *
0229000910010291  *     IC Rec
023000091001     C                   movel(P)  mbgrp#        icemlr
023100091001     C                   movel     mcmid#        icemly
023200091001     C                   movel(P)  'HRA'         icactp
023300091203     C                   if        grp13 <> '   '
023400091204     C******?            movel(P)  grp13         pln3
023500100315     C                   movel(P)  grp13         icactp
023600091014     C                   endif
023700100315      *
023800100524     C                   if        grp1 = '*'
023900100524     C                   movel(P)  grp212        pln12
024000100524     C                   else
024100100524     C                   movel(P)  grp12         pln12
024200100524     C                   endif
024300100315     C                   if        pln3 = *blanks
024400100315     C                   movel(P)  'HRA'         pln3
024500100315     C                   endif
024600100315      *
024700100315     C                   movel     mcpefd        icpeff
024800100315     C                   movel     mcptrd        icptrm
024900091001     C                   eval      icsts = '1'
025000091001     C                   move      '0.00'        iceypp
025100091001     C                   move      '0.00'        icerpp
025200091002     C                   eval      wkamt = %EDITW(mcrate:'      .  ')
025300091002     C                   move      wkamt         icefrf
025400091002     C                   if        mctfdt = 0
025500091002     C                   eval      icetrm = *blanks
025600091002     C                   else
025700120918     C******             movel     mctfdt        icetrm
025800091002     C                   endif
025900091001     C                   movel     mcefdt        iceeff
026000091001    * *     Write IC rec
026100091001     C                   write     mbicr
026200091008     C                   clear                   mbcmbr
026300091008     C                   movel     icrec         mcdata
026400091008     C                   write     mbcmbr
026500091001     C                   eval      recct = recct + 1
026600091001    * *
0267000910010291  *     IF Rec
026800091001     C                   movel(P)  mbgrp#        ifemlr
026900091001     C                   movel     mcmid#        ifemly
027000091001     C                   movel(P)  *blanks       ifdep
027100091104    * *     Card shit
027200091216    * *          Issue card - Bulk overnite to employer
027300100524     C******             movel(P)  '3'           ifsmcd
027400100524     C**                 movel(P)  '2'           ifadcd
027500100524     C******             movel(P)  '2'           ifissu
027600091217    * *          Issue card - Standard US Mail to card holder
027700100609     C                   movel(P)  '1'           ifsmcd
027800100609     C                   movel(P)  '1'           ifadcd
027900100609     C                   movel(P)  '2'           ifissu
028000091029    * *          No card
028100100609     C*****              movel(P)  '1'           ifsmcd
028200100609     C**                 movel(P)  '0'           ifadcd
028300100609     C*****              movel(P)  '1'           ifissu
028400091001    * *     Write IF rec
028500091001     C                   write     mbifr
028600091008     C                   clear                   mbcmbr
028700091008     C                   movel     ifrec         mcdata
028800091008     C                   write     mbcmbr
028900091001     C                   eval      recct = recct + 1
029000091001    * *
0291000910010291  *     IZ Rec
029200091001     C                   movel(P)  mbgrp#        izemlr
029300091001     C                   movel     mcmid#        izemly
029400091002     C                   if        mctfdt = 0
029500091002     C                   eval      iztrm = *blanks
029600091002     C                   else
029700091002     C                   movel     mctfdt        iztrm
029800091002     C                   endif
029900091001     C                   movel     mcefdt        izelig
030000091001    * *     Write IZ rec
030100091001     C                   write     mbizr
030200091008     C                   clear                   mbcmbr
030300091008     C                   movel     izrec         mcdata
030400091008     C                   write     mbcmbr
030500091001     C                   eval      recct = recct + 1
030600070530      *
030700070530     C                   endsr
0308000711080107  ********************************************************************************
0309000711080107  *
0310000910130107  *     NAMRTN - Reduce total Name length to 20 chars
0311000711080107  *
0312000711080107  ********************************************************************************
0313000910130296 C     namrtn        begsr
0314000910130296 C                   eval      cntl = %scan('  ':iblnme:2)
0315000910130296 C                   if        cntl = 0
0316000910130296 C                   eval      cntl = 25
0317000910130296 C                   else
0318000910130296 C                   eval      cntl = cntl - 1
0319000910130296 C                   endif
0320000910130291  *      If LNAM is GT 18 - Just use last name
0321000910130296 C                   if        cntl > 18
0322000910130296 C                   movel     *blanks       ibfnme
0323000910130296 C                   movel     *blanks       ibmi
0324000910130296 C                   leavesr
0325000910130296 C                   endif
0326000910130291  *
0327000910130296 C                   eval      cntf = %scan('  ':ibfnme:2)
0328000910130296 C                   if        cntf = 0
0329000910130296 C                   eval      cntf = 18
0330000910130296 C                   else
0331000910130296 C                   eval      cntf = cntf - 1
0332000910130296 C                   endif
0333000910130291  *   If LNAM + FNAM + 1 > 18 - remove MI
0334000910130296 C                   eval      cntt = cntl + cntf + 1
0335000910130296 C                   if        cntt > 18
0336000910130296 C                   eval      ibmi = ' '
0337000910130296 C                   endif
0338000910130291  *   If LNAM + FNAM + 1 > 20 - remove MI and use 1 char FNAM
0339000910130291  *
0340000910130296 C                   if        cntt > 20
0341000910130296 C                   movel     ibfnme        fnm1
0342000910130296 C                   movel(P)  fnm1          ibfnme
0343000910130296 C                   endif
0344000910130296 C                   endsr
0345000910130107  ********************************************************************************
0346000910130107  *
0347000910130107  *     INZSR - Preprocessing
0348000910130107  *
0349000910130107  ********************************************************************************
035000071108     C     *Inzsr        Begsr
035100091001    * *   SET DEFAULT FIELDS
0352000910010297 C                   clear                   mbibr
0353000910010297 C                   clear                   mbicr
0354001001150297 C                   clear                   mbifr
0355001001150297 C                   clear                   mbizr
0356001001150297 C                   eval      ibrcid = 'IB'
0357001001150297 C                   eval      icrcid = 'IC'
0358001001150297 C                   eval      ifrcid = 'IF'
0359001001150297 C                   eval      izrcid = 'IZ'
0360001001150297 C                   eval      ibtpa = 'T00025'
0361001001150297 C                   eval      ictpa = 'T00025'
0362001001150297 C                   eval      iftpa = 'T00025'
0363000910010297 C                   eval      iztpa = 'T00025'
036400091001    * *   Get IA rec
036500091001     C                   read      mbiap
0366000910010297 C                   eval      recct = 0
036700091001    * *
036800091001     C                   endsr
