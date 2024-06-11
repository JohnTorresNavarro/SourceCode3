000100171130     H option(*noDebugIo)
0002000204020002  *****************************************************************************
000300120131      * DW434X     Group Benefit Services                                         *
000400020402      *            WRITTEN BY - R.L.J.                                            *
000500120131      *            DATE - 01/2012                                                 *
000600120131      *  DESCRIPTION - Create FSA-MBI update files using GBS MBI Chg file         *
000700120131      * NOTE!! When you make a chg to FSxxP files - change D-specs here           *
0008000204020002  *****************************************************************************
0009001209180015  *  Change Log: RLJ 09/18/12 Don't set emp term date per JB                  *
0010001911210015  *  Change Log: RLJ 11/20/19 Add email and fill to end of rec                *
001100020402      *                                                                *
001200171130      * 11/30/2017   B.Rees        br01
001300171130      *  Debbie Graziano Request: Currently, when we load the file into
001400171130      *   the WCA System ( WealthCare Administration System )
001500171130      *   We are clearing out the current data. ( We are passing in a Zero Amount )
001600171130      *
001700171130      *  Solution?  Remove the Group# ( WCA calls this the Plan ID ) from the
001800171130      *    text file.
001900171130      *
0020009102150018 F******************************************************************
0021001201310020 FFSCHGP    IF   E           K DISK
0022001201310020 FFSCURP    IF   E           K DISK
0023001201310020 FFSIAP     UF   E             DISK
0024001201310020 FFSIBP     O    E             DISK
0025001201310020 FFSICP     O    E             DISK
0026001201310020 FFSIFP     O    E             DISK
0027001201310020 FFSIZP     O    E             DISK
0028001201310020 FFSCMBP    O    E             DISK
0029000707230025  *
0030000204030250 D                 DS
0031001201310251 D  FCarea                 1      3  0
0032000910020251 D   areac                 1      3
0033000910020025  *
0034000910020250 D                 DS
0035001201310251 D  fxcgrp#                1     15
0036000910020251 D   cgrp4                 1      4
0037000910020025  *
0038000910020250 D                 DS
0039001201310251 D  FCgrp#                 1     15
0040000910020251 D   grp4                  1      4
0041001004210251 D   grp1                  1      1
0042001004210251 D   grp24                 2      4
0043000912030251 D   grp12                 1     12
0044001005240251 D   grp212                2     12
0045000912030251 D   grp13                13     15
0046001003260025  *
0047001003260250 D                 DS
0048001003260251 D  mbgrp#                 1      9
0049001003260251 D   bgrp1                 1      3    INZ('GBS')
0050001003260251 D   bgrp2                 4      7
0051000805150029  *
0052000805150250 D                 DS
0053001201310251 D  FCphn#                 1      7  0
0054000910010251 D   p3                    1      3
0055000910010251 D   p4                    4      7
0056000910010029  *
0057000910010250 D                 DS
0058000910010251 D  curkey                 1     11  0
0059001201310251 D   fcmid#                1      9  0
0060001201310251 D   fcmida                1      9
0061001201310251 D   fcseq#               10     11  0
0062000505250029  *
0063000510120250 D                 DS
0064000505250251 D  chgkey                 1     11  0
0065001201310251 D   fxmid#                1      9  0
0066001201310251 D   fxseq#               10     11  0
0067000807310029  *
0068000807310250 D                 DS
0069000807310251 D  hldkey                 1     11  0 INZ(0)
0070000807310251 D  astrsk                12     22    INZ('***********')
0071000807310029  *
0072000809150250 D                 DS
0073000809150251 D  curact                 1    214
0074001201310251 D   fctrust               1      3  0
0075001201310251 D   fcsub                 4      6  0
0076001201310251 D   fcacct                7     10  0
0077001201310251 D   fcacnm               11     50
0078000711080029  *
0079000711080250 D                 DS
008000091002     D  recct                  1      6S 0
008100091002     D  reccta                 1      6
008200090108    * *
0083000901080053 D                 DS
0084000910020054 D  wkamt          S              9
0085000910130251 D  cntf           S              2  0 INZ(0)
0086000910130251 D  cntt           S              2  0 INZ(0)
0087000910130251 D  cntl           S              2  0 INZ(0)
0088000910130251 D  fnm1           S              1
0089000711080111  *
0090000910080029  *   Format Output Records
0091000910080250 D                 DS
0092001911210251 D  ibrec                  1    316
0093000910080251 D   ibrcid                1      2
0094000910080251 D   ibtpa                 3      8
0095000910080251 D   ibemlr                9     17
0096000910080251 D   ibemly               18     26
0097000910080251 D   iblnme               27     52
0098000910080251 D   ibfnme               53     71
0099000910080251 D   ibmi                 72     72
0100000910080251 D   ibphn#               73     91
0101000910080251 D   ibadr1               92    127
0102000910080251 D   ibadr2              128    163
0103000910080251 D   ibcity              164    183
0104000910080251 D   ibst                184    193
0105000910080251 D   ibzip               194    202
0106000910080251 D   ibcnty              203    205
0107000910080251 D   ibgndr              206    206
0108000910080251 D   ibbrdt              207    214
0109000910160251 D   ibrmth              215    215
0110001911210251 D   ibemal              216    315
0111001911210251 D   ibfill              316    316
0112000910080250 D                 DS
0113000910150251 D  icrec                  1    138
0114000910080251 D   icrcid                1      2
0115000910080251 D   ictpa                 3      8
0116000910080251 D   icemlr                9     17
0117000910150251 D   icplan               18     35
0118000912030251 D     pln12              18     29
0119000912030251 D     pln4               18     21
0120000912030251 D     pln3               22     24
0121000910150251 D   icemly               36     44
0122000910150251 D   icactp               45     48
0123000910150251 D   icpeff               49     56
0124000910150251 D   icptrm               57     64
0125000910150251 D   icsts                65     65
0126000910150251 D   iceypp               66     84
0127000910150251 D   icerpp               85    103
0128000910150251 D   icefrf              104    122
0129000910150251 D   icetrm              123    130
0130000910150251 D   iceeff              131    138
0131000910080250 D                 DS
0132001004150251 D  ifrec                  1     40
0133000910080251 D   ifrcid                1      2
0134000910080251 D   iftpa                 3      8
0135000910080251 D   ifemlr                9     17
0136000910080251 D   ifemly               18     26
0137001004150251 D   ifdep                27     37
0138001004150251 D   ifsmcd               38     38
0139001004150251 D   ifadcd               39     39
0140001004150251 D   ifissu               40     40
0141000910080250 D                 DS
0142000910080251 D  izrec                  1     42
0143000910080251 D   izrcid                1      2
0144000910080251 D   iztpa                 3      8
0145000910080251 D   izemlr                9     17
0146000910080251 D   izemly               18     26
0147000910080251 D   iztrm                27     34
0148000910080251 D   izelig               35     42
0149000910080291  *
015000080919     C     mbckey        klist
015100120131     C                   kfld                    fxmid#
015200120131     C                   kfld                    fxseq#
0153000508240291  *
0154000803270291  *
0155000910020296 C                   dou       *in21 = '1'
0156001201310297 C                   read      fschgp                                 21
0157001010110291  *
0158001010110296 C                   if        *in21 = '0'
0159001003120291  *
0160001201310296 C                   If        (fxsts = 'N' and fxseq# = 0) or
0161001201310296 C                             (fxsts = 'G' and fxseq# = 0)
0162000809260291  *
0163001202280296 C********           If        fxhtfdt = 0 and fxctfdt = 0
0164001010270291  *      Skip AAAA and AAAQ grps - GBS
0165001010270296 C                   If        cgrp4 = 'AAAA' or cgrp4 = 'AAAQ'
0166001010270296 C                   iter
0167001010270296 C                   endif
0168000809260291  *      DEBUG
0169001201310296 C                   If        fxmid# = 212061187
0170001201310296 C                   movel     fxmid#        fxmid#
0171000910020291  *      Skip this SSN
0172000910020296 C                   iter
0173000910020296 C                   endif
017400080926      *
0175000807250296 C                   if        hldkey <> chgkey
0176000807250297 C                   eval      hldkey = chgkey
017700091001     C                   exsr      putnew
017800070605     C                   endif
017900120228     C*******            else
018000091001      *
018100120228     C********           endif
018200080725     C                   endif
018300091002      *
018400101011     C                   endif
018500091002     C                   enddo
018600091002      *
018700091002     C                   eval      recct = recct + 1
018800091002     C                   movel     reccta        iarcnt
018900120131     C                   update    fsiar
019000091002      *
0191000910020297 C                   movel     '1'           *inlr
0192000910020297 C                   return
0193000705300107  ********************************************************************************
0194000705300107  *
0195000910010107  *     PUTNEW - Write the New record to MBI Import files
0196000705300107  *
0197000705300107  ********************************************************************************
019800091001     C     putnew        begsr
0199001201310297 C     mbckey        setll     fscurp                             21
0200000807250296 C                   dou       *in21 = '1'
0201001201310297 C                   read      fscurp                                 21
0202001201310296 C                   If        *in21 = '0' and fcmid# = fxmid# and
0203001201310296 C                             fcseq# = fxseq#
0204000807250297 C                   leave
0205000807250297 C                   else
0206000706050297 C                   leavesr
0207000706050297 C                   endif
0208000706050297 C                   enddo
0209000910010291  *    IB rec
021000100421     C                   If        grp1 = '*'
021100100421     C                   movel(P)  grp24         bgrp2
021200100421     C                   else
021300100421     C                   movel     grp4          bgrp2
021400100421     C                   endif
021500091001     C                   movel(P)  mbgrp#        ibemlr
021600120131     C                   movel     fcmid#        ibemly
021700120131     C                   movel(P)  fclnme        iblnme
021800120131     C                   movel(P)  fcfnme        ibfnme
021900120131     C                   movel     fcmi          ibmi
022000091013     C                   exsr      namrtn
022100091002     C                   eval      ibphn# = '(' + areac + ')' + p3 + '-' + p4
022200120131     C                   movel(P)  fcadr1        ibadr1
022300120131     C                   movel(P)  fcadr2        ibadr2
022400191119     C*******            movel(P)  fcemal        ibemal
022500120131     C                   movel(P)  fccity        ibcity
022600120131     C                   movel(P)  fcst          ibst
022700120131     C                   movel(P)  fczip         ibzip
022800091002     C                   eval      ibcnty = 'US '
022900120131     C                   If        fcgndr = 'M'
023000091001     C                   eval      ibgndr = '1'
023100091001     C                   else
023200091001     C                   eval      ibgndr = '2'
023300091001     C                   endif
023400120131     C                   movel     fcbrdt        ibbrdt
023500091016     C                   eval      ibrmth = '1'
023600191121    * *
023700191121     C                   eval      ibfill = 'X'
023800191121    * *     Write IB rec
023900120131     C                   write     fsibr
024000120131     C                   clear                   fscmbr
024100120131     C                   movel     ibrec         fcdata
024200120131     C                   write     fscmbr
024300091001     C                   eval      recct = recct + 1
024400070530    * *
0245000910010291  *     IC Rec
024600091001     C                   movel(P)  mbgrp#        icemlr
024700120131     C                   movel     fcmid#        icemly
024800121004     C                   movel(P)  'FSA'         icactp
024900091203     C                   if        grp13 <> '   '
025000091204     C******?            movel(P)  grp13         pln3
025100100315     C                   movel(P)  grp13         icactp
025200091014     C                   endif
025300100315      *
025400100524     C                   if        grp1 = '*'
025500100524     C                   movel(P)  grp212        pln12
025600100524     C                   else
025700100524     C                   movel(P)  grp12         pln12
025800100524     C                   endif
025900100315     C                   if        pln3 = *blanks
026000121004     C                   movel(P)  'FSA'         pln3
026100100315     C                   endif
026200100315      *
026300120131     C                   movel     fcpefd        icpeff
026400120131     C                   movel     fcptrd        icptrm
026500091001     C                   eval      icsts = '1'
026600091001     C                   move      '0.00'        iceypp
026700091001     C                   move      '0.00'        icerpp
026800120131     C*****              eval      wkamt = %EDITW(fcrate:'      .  ')
026900120131     C****               move      wkamt         icefrf
027000120131      *   Per WA - default employer fund amt to 0
027100120131     C                   move      '0.00'        icefrf
027200120131     C                   if        fctfdt = 0
027300091002     C                   eval      icetrm = *blanks
027400091002     C                   else
027500120918     C********           movel     fctfdt        icetrm
027600091002     C                   endif
027700120131     C                   movel     fcefdt        iceeff
027800091001    * *     Write IC rec
027900120131     C                   write     fsicr
028000120131     C                   clear                   fscmbr
028100171130br01 C                   eval      icPlan = *Blanks
028200120131     C                   movel     icrec         fcdata
028300120131     C                   write     fscmbr
028400091001     C                   eval      recct = recct + 1
028500091001    * *
0286000910010291  *     IF Rec
028700091001     C                   movel(P)  mbgrp#        ifemlr
028800120131     C                   movel     fcmid#        ifemly
028900091001     C                   movel(P)  *blanks       ifdep
029000091104    * *     Card shit
029100101011    * *          No card
029200120131     C                   if        fcdbtc = ' ' or fcdbtc = 'N'
029300101011     C                   movel(P)  '1'           ifsmcd
029400101011     C                   movel(P)  '0'           ifadcd
029500101011     C                   movel(P)  '1'           ifissu
029600101011     C                   endif
029700101011    * *          Issue card - Standard US Mail to card holder
029800120131     C                   if        fcdbtc = '1'
029900101011     C                   movel(P)  '1'           ifsmcd
030000101011     C                   movel(P)  '1'           ifadcd
030100101011     C                   movel(P)  '2'           ifissu
030200101011     C                   endif
030300101011    * *          Issue card - Standard US Mail to Employer
030400120131     C                   if        fcdbtc = '2'
030500101011     C                   movel(P)  '1'           ifsmcd
030600101011     C                   movel(P)  '2'           ifadcd
030700101011     C                   movel(P)  '2'           ifissu
030800101011     C                   endif
030900101011    * *          Issue card - Bulk overnite to employer
031000120131     C                   if        fcdbtc = '4'
031100101011     C                   movel(P)  '3'           ifsmcd
031200101011     C                   movel(P)  '2'           ifadcd
031300101011     C                   movel(P)  '2'           ifissu
031400101011     C                   endif
031500091001    * *     Write IF rec
031600120131     C                   write     fsifr
031700120131     C                   clear                   fscmbr
031800120131     C                   movel     ifrec         fcdata
031900120131     C                   write     fscmbr
032000091001     C                   eval      recct = recct + 1
032100091001    * *
0322000910010291  *     IZ Rec
032300091001     C                   movel(P)  mbgrp#        izemlr
032400120131     C                   movel     fcmid#        izemly
032500120131     C                   if        fctfdt = 0
032600091002     C                   eval      iztrm = *blanks
032700091002     C                   else
032800120131     C                   movel     fctfdt        iztrm
032900091002     C                   endif
033000120131     C                   movel     fcefdt        izelig
033100091001    * *     Write IZ rec
033200120131     C                   write     fsizr
033300120131     C                   clear                   fscmbr
033400120131     C                   movel     izrec         fcdata
033500120131     C                   write     fscmbr
033600091001     C                   eval      recct = recct + 1
033700070530      *
033800070530     C                   endsr
0339000711080107  ********************************************************************************
0340000711080107  *
0341000910130107  *     NAMRTN - Reduce total Name length to 20 chars
0342000711080107  *
0343000711080107  ********************************************************************************
0344000910130296 C     namrtn        begsr
0345000910130296 C                   eval      cntl = %scan('  ':iblnme:2)
0346000910130296 C                   if        cntl = 0
0347000910130296 C                   eval      cntl = 25
0348000910130296 C                   else
0349000910130296 C                   eval      cntl = cntl - 1
0350000910130296 C                   endif
0351000910130291  *      If LNAM is GT 18 - Just use last name
0352000910130296 C                   if        cntl > 18
0353000910130296 C                   movel     *blanks       ibfnme
0354000910130296 C                   movel     *blanks       ibmi
0355000910130296 C                   leavesr
0356000910130296 C                   endif
0357000910130291  *
0358000910130296 C                   eval      cntf = %scan('  ':ibfnme:2)
0359000910130296 C                   if        cntf = 0
0360000910130296 C                   eval      cntf = 18
0361000910130296 C                   else
0362000910130296 C                   eval      cntf = cntf - 1
0363000910130296 C                   endif
0364000910130291  *   If LNAM + FNAM + 1 > 18 - remove MI
0365000910130296 C                   eval      cntt = cntl + cntf + 1
0366000910130296 C                   if        cntt > 18
0367000910130296 C                   eval      ibmi = ' '
0368000910130296 C                   endif
0369000910130291  *   If LNAM + FNAM + 1 > 20 - remove MI and use 1 char FNAM
0370000910130291  *
0371000910130296 C                   if        cntt > 20
0372000910130296 C                   movel     ibfnme        fnm1
0373000910130296 C                   movel(P)  fnm1          ibfnme
0374000910130296 C                   endif
0375000910130296 C                   endsr
0376000910130107  ********************************************************************************
0377000910130107  *
0378000910130107  *     INZSR - Preprocessing
0379000910130107  *
0380000910130107  ********************************************************************************
038100071108     C     *Inzsr        Begsr
038200091001    * *   SET DEFAULT FIELDS
0383001201310297 C                   clear                   fsibr
0384001201310297 C                   clear                   fsicr
0385001201310297 C                   clear                   fsifr
0386001201310297 C                   clear                   fsizr
0387001001150297 C                   eval      ibrcid = 'IB'
0388001001150297 C                   eval      icrcid = 'IC'
0389001001150297 C                   eval      ifrcid = 'IF'
0390001001150297 C                   eval      izrcid = 'IZ'
0391001001150297 C                   eval      ibtpa = 'T00025'
0392001001150297 C                   eval      ictpa = 'T00025'
0393001001150297 C                   eval      iftpa = 'T00025'
0394000910010297 C                   eval      iztpa = 'T00025'
039500091001    * *   Get IA rec
039600120131     C                   read      fsiap
0397000910010297 C                   eval      recct = 0
039800091001    * *
039900091001     C                   endsr
