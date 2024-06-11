0001000204020002  *****************************************************************************
000200080911      * DW445      Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400080911      *            DATE - 09/2008                                                 *
000500080911      *  DESCRIPTION - Create LUM update files using GBS MBI Chg file             *
000600080911      *                                                                           *
0007000204020002  *****************************************************************************
0008001202280015  *  Change Log: rlj 02/28/2012 Write LUM update record even if               *
000900120228      *                             term date <> 0.                    *
0010009102150018 F******************************************************************
0011001004220020 FMBCHG2P   UP   E           K DISK
0012001004220020 FMBCUR2P   IF   E           K DISK
0013000805150020 FPARTICIPL4IF   E           K DISK
0014000809180020 FMB0012WA  O    E             DISK
0015000809180020 FMB0012WB  O    E             DISK
0016000707230025  *
001700070529     ** coverage type xref
001800070529     D TABA            S              3A   DIM(12) CTDATA PERRCD(1)
001900070529     D TABB            S              3A   DIM(12) ALT(TABA)
002000070529     **
0021000204030029  *
0022000204030250 D                 DS
0023000809180251 D  mcgrp#                 1     15
0024001004210251 D   grp1                  1      1
0025001004210251 D   grp24                 2      4
0026001004210251 D   grp4                  1      4
0027000903300251 D   grp20                 1     20
0028000805150029  *
0029000805150250 D                 DS
0030000805150251 D  curkey                 1     11  0
0031000809180251 D   mcmid#                1      9  0
0032000809180251 D   mcmida                1      9
0033000809180251 D   mcseq#               10     11  0
0034000505250029  *
0035000510120250 D                 DS
0036000505250251 D  chgkey                 1     11  0
0037000809190251 D   mxmid#                1      9  0
0038000809190251 D   mxseq#               10     11  0
0039000807310029  *
0040000807310250 D                 DS
0041000807310251 D  hldkey                 1     11  0 INZ(0)
0042000807310251 D  astrsk                12     22    INZ('***********')
0043000807310029  *
0044000809150250 D                 DS
0045000809150251 D  curact                 1    214
0046000811130251 D   mctrust               1      3  0
0047000809190251 D   mcsub                 4      6  0
0048000809190251 D   mcacct                7     10  0
0049000809190251 D   mcacnm               11     50
0050001008180029  *
0051001008180250 D                 DS
0052001008180251 D  chghdem                1    214
0053001008180251 D   mxhf1                 1     40    INZ(*blanks)
0054001008180251 D   mxhlnme              10     27
0055001008180251 D   mxhfnme              28     39
0056001008180251 D   mxhmi                40     40
0057001008180251 D   mxhadr1              41     70
0058001008180251 D   mxhadr2              71    100
0059001008180251 D   mxhcity             101    115
0060001008180251 D   mxhst               116    117
0061001008180251 D   mxhzip              118    126  0
0062001008180251 D   mxharea             127    129  0
0063001008180251 D   mxhphn#             130    136  0
0064001008180251 D   mxhbrdt             137    144  0
0065001008180251 D   mxhgndr             145    145
0066001008180251 D   mxhempdt            154    161  0
0067001008180251 D   mxhrelcd            179    181
0068001008180251 D   mxhefdt             182    189  0
0069001008180251 D   mxhtfdt             190    197  0
0070001008180251 D   mxhf2               198    212    INZ(*blanks)
0071001008180251 D   mxhcovt             213    214
0072001008180029  *
0073001008180250 D                 DS
0074001008180251 D  chgcdem                1    214
0075001008180251 D   mxcf1                 1     40    INZ(*blanks)
0076001008180251 D   mxcadr1              41     70
0077001008180251 D   mxcadr2              71    100
0078001008180251 D   mxccity             101    115
0079001008180251 D   mxcst               116    117
0080001008180251 D   mxczip              118    126  0
0081001008180251 D   mxcarea             127    129  0
0082001008180251 D   mxcphn#             130    136  0
0083001008180251 D   mxcbrdt             137    144  0
0084001008180251 D   mxcgndr             145    145
0085001008180251 D   mxcempdt            154    161  0
0086001008180251 D   mxcrelcd            179    181
0087001008180251 D   mxcefdt             182    189  0
0088001008180251 D   mxctfdt             190    197  0
0089001008180251 D   mxcf2               198    212    INZ(*blanks)
0090001008180251 D   mxccovt             213    214
0091001008180029  *
0092000809150029  *
0093000505250250 D                 DS
009400050525     D  ISOToday       S               d     inz
009500050525     D  Today          S              8p 0   inz
009600070605     D  hidate         S              8S 0 INZ(99999999)
009700100421     D  grpky          S             20
009800100818     D  chg            S              1
0099000505250111  *
0100000711080250 D                 DS
010100071108     D  gbdate                 1      8  0
010200071108     D   gbyr                  1      4  0
010300071108     D   gbmo                  5      6  0
010400071108     D   gbdy                  7      8  0
0105000711080029  *
0106000711080250 D                 DS
010700071108     D  wkday          S               D     inz
010800090108    * *
0109000901080053 D                 DS
0110000901080054 D  mbplan         C                   'MBI PARTICIPANT     '
0111000711080111  *
011200080919     C     mbckey        klist
011300080919     C                   kfld                    mxmid#
011400080919     C                   kfld                    mxseq#
0115000805150111  *
011600080515     C     partky        klist
011700100421     C                   kfld                    grpky
011800080919     C                   kfld                    mcmida
011900050525      *
0120000508240291  *
0121000803270291  *
0122000809260296 C                   If        mxsts <> 'X'
0123000809260291  *
0124001202280296 C******             If        mxhtfdt = 0 and mxctfdt = 0
0125000809260291  *      DEBUG
0126000809260296 C                   If        mxmid# = 212158675
0127000809260296 C                   movel     mxmid#        mxmid#
0128000809260296 C                   endif
012900080926      *
0130001008180296 C                   eval      chg = 'Y'
0131001312040296 C                   If        mxsts = 'C' or mxsts = 'T'
0132001008180296 C                   eval      chg = 'N'
0133001008180296 C                   if        mxhlnme <> *blanks or
0134001008180296 C                             mxhfnme <> *blanks or
0135001008180296 C                             chghdem <> chgcdem
0136001008180296 C                   eval      chg = 'Y'
013700100818     C                   endif
013800100818     C                   endif
0139001008180291  *
0140000807250296 C                   if        hldkey <> chgkey
0141000807250297 C                   eval      hldkey = chgkey
0142001008180296 C                   if        chg = 'Y'
014300080725     C                   exsr      putchg
014400070605     C                   endif
014500100818     C                   endif
014600120228     C******             else
014700080725      *        Put Term logic here
014800120228     C******             endif
014900080725     C                   endif
0150000705300107  ********************************************************************************
0151000705300107  *
0152000803270107  *     PUTCHG - Write the New record to Lum Import file
0153000705300107  *
0154000705300107  ********************************************************************************
015500080725     C     putchg        begsr
0156001004220297 C     mbckey        setll     mbcur2p                            21
0157000807250296 C                   dou       *in21 = '1'
0158001004220297 C                   read      mbcur2p                                21
0159000809190296 C                   If        *in21 = '0' and mcmid# = mxmid# and
0160000809190296 C                             mcseq# = mxseq#
0161000807250297 C                   leave
0162000807250297 C                   else
0163000706050297 C                   leavesr
0164000706050297 C                   endif
0165000706050297 C                   enddo
0166000706050291  *
016700080919     C                   if        mxseq# = 0
016800080919    * *     Get LUM record if Rec is a change rec
016900131204     C                   if        mxsts = 'C' or mxsts = 'T'
017000100421     C                   if        grp1 = '*'
017100100421     c                   movel(P)  grp24         grpky
017200100421     c                   else
017300100421     c                   movel(P)  grp4          grpky
017400100421     c                   endif
0175000805150297 C     partky        chain     participl4                         29
017600080515     C                   if        *in29 = '0'
017700080515     c                   movel     gpinitdt      e3initdt
017800080515     c                   movel     gpbeneff      e3beneff
017900080515     c                   endif
018000080515     c                   endif
018100080515    * *     Write Mbr rec
018200070530     C                   CLEAR                   LUMENRC1R
018300070530    * *
018400100421     C                   if        grp1 = '*'
018500100421     c                   EVAL      E3GROUP = %TRIM(grp24)
018600100421     c                   else
018700100421     c                   EVAL      E3GROUP = %TRIM(grp4)
018800100421     c                   endif
018900070530     c                   move      '1'           e3rectyp
019000080919     c                   movel     mcmid#        e3partic
019100070530     c                   move      '00'          e3depno
019200080919     c                   move      mcempdt       e3hiredt
019300070530     C                   EVAL      E3DIV = 'A001'
019400070530    ***
019500080919     c*******            move      mcefdt        e3initdt
019600080919     c                   movel     mclnme        e3last
019700080919     c                   movel     mcfnme        e3first
019800080919     c                   move      mcmi          e3mi
019900070530    * *
020000080919     c                   movel     mcadr1        e3addr
020100080919     c                   movel     mcadr2        e3addr2
020200080919     c                   movel     mccity        e3city
020300080919     c                   movel     mcst          e3stat
020400070530    * *
020500080919     c                   movel     mczip         e3zip
020600080919     c                   movel     mcarea        phonewk          10
020700080919     c                   move      mcphn#        phonewk
020800070530     c                   movel     phonewk       e3phone
020900070530    ***
021000080919     c                   move      mcgndr        e3sex
021100080919     c                   move      mcbrdt        e3dob
021200080919     c                   move      mcmid#        e3ssn
021300080725    * *
021400080919    1c                   if        mcmardt <> 0
021500080725     c                   move      'M'           e3marsta
021600080725    1c                   else
021700080725     c                   move      'S'           e3marsta
021800080725    1c                   end
021900080725      *
022000080919    1C                   if        mcsal = 0
022100071108    1c                   movel     astrsk        e3sal
022200071108    1c                   else
022300080919     c                   z-add     mcsal         salarywk         10 2
022400070530     c                   eval      e3sal = %editc(salarywk : '3')
022500071108    1c                   endif
022600070530      *
022700080919     c***                movel     'T'           covtp             3
022800080919     c***                move      mccovt        covtp
022900080919     c*    covtp         lookup    taba          tabb                     66
023000080919    1C*                  if        *in66
023100080919     C****               MOVEL     TABB          e3enr1
023200080919    1c****               endif
0233000707240291  *
023400071108     c                   movel     astrsk        e3vol1
023500071108     c                   movel     astrsk        e3vol2
023600071108     c                   movel     astrsk        e3vol3
023700071108     c                   movel     astrsk        e3vol4
023800071108     c                   movel     astrsk        e3vol5
023900071108     c                   movel     astrsk        e3vol6
024000071108     c                   movel     astrsk        e3vol7
024100071108     c                   movel     astrsk        e3vol8
024200071108     c                   movel     astrsk        e3vol9
024300071108     c                   movel     astrsk        e3vol10
024400071108     c                   movel     astrsk        e3vol11
024500071108     c                   movel     astrsk        e3vol12
024600071108     c                   movel     astrsk        e3vol13
024700071108     c                   movel     astrsk        e3vol14
024800071108     c                   movel     astrsk        e3vol15
024900071108     c                   movel     astrsk        e3vol16
025000080926      *
025100100603    1c                   if        mxsts = 'N' or mxsts = 'G'
025200090108     C                   MOVEL     mbplan        e3plan1
025300090108     c                   EVAL      e3cov1 = 'ADM'
025400090108     c                   EVAL      e3enr1 = 'F99'
025500080926     c                   movel     mcefdt        e3effdt
025600080926     c                   else
025700080926      *        If coverage change use eff date o/w use today's date
025800080926    1c                   if        mxccovt <> ' ' or
025900080926    1c                             mxctfldt <> 0
026000080926     c                   movel     mcefdt        e3effdt
026100080926     c                   else
026200080926     c                   movel     today         e3effdt
026300080926     c                   endif
026400080926     c                   endif
026500071113      *
026600070530      * write subscriber record to subscriber file
026700070530     C                   EVAL      E3X = '*'
026800070530     c                   write     lumenrc1r
026900080430      *
027000070530     C                   else
027100070530    * *     Write Dep rec
027200070530     C                   CLEAR                   LUMENRC2R
027300070530    * *
027400100421     C                   if        grp1 = '*'
027500100421     c                   EVAL      E4GROUP = %TRIM(grp24)
027600100421     c                   else
027700100421     c                   EVAL      E4GROUP = %TRIM(grp4)
027800100421     c                   endif
027900070530     c                   move      '2'           e4rectyp
028000080919     c                   movel     mcmid#        e4partic
028100080919     c                   move      mcseq#        e4dep
028200080919     c*****              move      mcempdt       e3hiredt
028300070530     C                   EVAL      E4DIV = 'A001'
028400070530    ***
028500080919     c*******            move      mcefdt        e4initdt
028600080919     c                   movel     mclnme        e4last
028700080919     c                   movel     mcfnme        e4first
028800080919     c                   move      mcmi          e4mi
028900070530    * *
029000070530    ***
029100080919     c                   move      mcgndr        e4sex
029200080919     c                   move      mcbrdt        e4dob
029300080919     c                   move      mcdssn        e4ssn
029400070530    * *
029500100610    1c                   if        mctrmdt <> 0
029600100610     c                   move      mctrmdt       e3emptrm
029700100610    1c                   end
029800070530      *
029900080919     c****               z-add     mcsal         salarywk         10 2
030000070530     c****               eval      e3sal = %editc(salarywk : '3')
030100070530    * *
030200080919    1c                   if        mcrelcd = 'RSO' or
030300080919    1c                             mcrelcd = 'RDA'
030400070530     c                   eval      e4relat = 'C'
030500070530    1c                   else
030600070530     c                   eval      e4relat = 'S'
030700070530    1c                   end
030800070530      *
030900070921     C                   MOVEL     *blanks       e4plan1
031000070921      *
031100080919     c****               If        e4cov1 = '   '
031200080919     c*                  eval      mxlsts = 'E'
031300080919     c*                  write     bgerrxr
0314000809190297 C****               else
031500080430      *
031600100603    1c                   if        mxsts = 'N' or mxsts = 'G'
031700080926     c                   movel     mcefdt        e4effdt
031800090108     C                   MOVEL     mbplan        e4plan1
031900090108     c                   EVAL      e4cov1 = 'ADM'
032000080926     c                   else
032100080926     c                   movel     mcefdt        e4effdt
032200080926     c                   endif
032300071113      *
032400080926    1c***                if        mxctfldt <> 0
032500080926     C*                  move      mxctfldt      e4end
032600080926    1c***                endif
032700071113      *
032800070530      * write subscriber record to subscriber file
032900070530     C                   EVAL      E4X = '*'
033000070530     c                   write     lumenrc2r
033100070530      *
033200080430     C                   endif
033300070530      *
033400070530     C                   endsr
0335000711080107  ********************************************************************************
0336000711080107  *
0337000711080107  *     INZSR - Preprocessing
0338000711080107  *
0339000711080107  ********************************************************************************
034000071108     C     *Inzsr        Begsr
034100071108    ***   Pre-processing
0342000711080297 C                   movel     UDATE         isotoday
0343000711080297 C                   movel     isotoday      today
034400071108     C                   Endsr
034500070529** coverage types (3-3): GBS - LUM
034600070529TINP00
034700070529TPCP01
034800070529T2PP99
034900070529TP2P99
035000070529THWF00
035100070529TFAF99
035200070529TDEF00
035300070529TDFF99
035400070529TTCP19
035500070529TFCF19
035600070529TE1F00
035700070529TDPF00
