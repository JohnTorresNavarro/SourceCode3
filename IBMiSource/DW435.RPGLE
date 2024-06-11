0001000204020002  *****************************************************************************
000200100915      * DW435      Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400100915      *            DATE - 09/2010                                                 *
000500100915      *  DESCRIPTION - Create LUM update files using GBS FSA Chg file             *
000600080911      *                                                                           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900020402      *                                                                *
0010009102150018 F******************************************************************
0011001009150020 FFSCHGP    UP   E           K DISK
0012001009150020 FFSCURP    IF   E           K DISK
0013000805150020 FPARTICIPL4IF   E           K DISK
0014001009150020 FFS0012WA  O    E             DISK
0015001009150020 FFS0012WB  O    E             DISK
0016000707230025  *
001700070529     ** coverage type xref
001800070529     D TABA            S              3A   DIM(12) CTDATA PERRCD(1)
001900070529     D TABB            S              3A   DIM(12) ALT(TABA)
002000070529     **
0021000204030029  *
0022000204030250 D                 DS
0023001009150251 D  fcgrp#                 1     15
0024001004210251 D   grp1                  1      1
0025001004210251 D   grp24                 2      4
0026001004210251 D   grp4                  1      4
0027000903300251 D   grp20                 1     20
0028000805150029  *
0029000805150250 D                 DS
0030000805150251 D  curkey                 1     11  0
0031001009150251 D   fcmid#                1      9  0
0032001009150251 D   fcmida                1      9
0033001009150251 D   fcseq#               10     11  0
0034000505250029  *
0035000510120250 D                 DS
0036000505250251 D  chgkey                 1     11  0
0037001009150251 D   fxmid#                1      9  0
0038001009150251 D   fxseq#               10     11  0
0039000807310029  *
0040000807310250 D                 DS
0041000807310251 D  hldkey                 1     11  0 INZ(0)
0042000807310251 D  astrsk                12     22    INZ('***********')
0043000807310029  *
0044000809150250 D                 DS
0045000809150251 D  curact                 1    214
0046001009150251 D   fctrust               1      3  0
0047001009150251 D   fcsub                 4      6  0
0048001009150251 D   fcacct                7     10  0
0049001009150251 D   fcacnm               11     50
0050001008180029  *
0051001008180250 D                 DS
0052001008180251 D  chghdem                1    214
0053001009150251 D   fxhf1                 1     40    INZ(*blanks)
0054001009150251 D   fxhlnme              10     27
0055001009150251 D   fxhfnme              28     39
0056001009150251 D   fxhmi                40     40
0057001009150251 D   fxhadr1              41     70
0058001009150251 D   fxhadr2              71    100
0059001009150251 D   fxhcity             101    115
0060001009150251 D   fxhst               116    117
0061001009150251 D   fxhzip              118    126  0
0062001009150251 D   fxharea             127    129  0
0063001009150251 D   fxhphn#             130    136  0
0064001009150251 D   fxhbrdt             137    144  0
0065001009150251 D   fxhgndr             145    145
0066001009150251 D   fxhempdt            154    161  0
0067001009150251 D   fxhrelcd            179    181
0068001009150251 D   fxhefdt             182    189  0
0069001009150251 D   fxhtfdt             190    197  0
0070001009150251 D   fxhf2               198    212    INZ(*blanks)
0071001009150251 D   fxhcovt             213    214
0072001008180029  *
0073001008180250 D                 DS
0074001008180251 D  chgcdem                1    214
0075001009150251 D   fxcf1                 1     40    INZ(*blanks)
0076001009150251 D   fxcadr1              41     70
0077001009150251 D   fxcadr2              71    100
0078001009150251 D   fxccity             101    115
0079001009150251 D   fxcst               116    117
0080001009150251 D   fxczip              118    126  0
0081001009150251 D   fxcarea             127    129  0
0082001009150251 D   fxcphn#             130    136  0
0083001009150251 D   fxcbrdt             137    144  0
0084001009150251 D   fxcgndr             145    145
0085001009150251 D   fxcempdt            154    161  0
0086001009150251 D   fxcrelcd            179    181
0087001009150251 D   fxcefdt             182    189  0
0088001009150251 D   fxctfdt             190    197  0
0089001009150251 D   fxcf2               198    212    INZ(*blanks)
0090001009150251 D   fxccovt             213    214
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
010900100915    * *    Per Jessica - leave this blank for FSA
0110000901080053 D                 DS
0111001101200054 D  fsplan         C                   'FSA PARTICIPANT     '
0112000711080111  *
011300080919     C     mbckey        klist
011400100915     C                   kfld                    fxmid#
011500100915     C                   kfld                    fxseq#
0116000805150111  *
011700080515     C     partky        klist
011800100421     C                   kfld                    grpky
011900100915     C                   kfld                    fcmida
012000050525      *
0121000508240291  *
0122000803270291  *
0123001009150296 C                   If        fxsts <> 'X'
0124000809260291  *
0125001202280296 C*******            If        fxhtfdt = 0 and fxctfdt = 0
0126000809260291  *      DEBUG
0127001009150296 C                   If        fxmid# = 212158675
0128001009150296 C                   movel     fxmid#        fxmid#
0129000809260296 C                   endif
013000080926      *
0131001008180296 C                   eval      chg = 'Y'
0132001009150296 C                   If        fxsts = 'C'
0133001008180296 C                   eval      chg = 'N'
0134001009150296 C                   if        fxhlnme <> *blanks or
0135001009150296 C                             fxhfnme <> *blanks or
0136001008180296 C                             chghdem <> chgcdem
0137001008180296 C                   eval      chg = 'Y'
013800100818     C                   endif
013900100818     C                   endif
0140001008180291  *
0141000807250296 C                   if        hldkey <> chgkey
0142000807250297 C                   eval      hldkey = chgkey
0143001008180296 C                   if        chg = 'Y'
014400080725     C                   exsr      putchg
014500070605     C                   endif
014600100818     C                   endif
014700120228     C********           else
014800080725      *        Put Term logic here
014900120228     C********           endif
015000080725     C                   endif
0151000705300107  ********************************************************************************
0152000705300107  *
0153000803270107  *     PUTCHG - Write the New record to Lum Import file
0154000705300107  *
0155000705300107  ********************************************************************************
015600080725     C     putchg        begsr
0157001009150297 C     mbckey        setll     fscurp                             21
0158000807250296 C                   dou       *in21 = '1'
0159001009150297 C                   read      fscurp                                 21
0160001009150296 C                   If        *in21 = '0' and fcmid# = fxmid# and
0161001009150296 C                             fcseq# = fxseq#
0162000807250297 C                   leave
0163000807250297 C                   else
0164000706050297 C                   leavesr
0165000706050297 C                   endif
0166000706050297 C                   enddo
0167000706050291  *
016800100915     C                   if        fxseq# = 0
016900080919    * *     Get LUM record if Rec is a change rec
017000100915     C                   if        fxsts = 'C'
017100100915     C                   if        grp1 = '*' or grp1 = '0'
017200100421     c                   movel(P)  grp24         grpky
017300100421     c                   else
017400100421     c                   movel(P)  grp4          grpky
017500100421     c                   endif
0176000805150297 C     partky        chain     participl4                         29
017700080515     C                   if        *in29 = '0'
017800080515     c                   movel     gpinitdt      e3initdt
017900080515     c                   movel     gpbeneff      e3beneff
018000080515     c                   endif
018100080515     c                   endif
018200080515    * *     Write Mbr rec
018300070530     C                   CLEAR                   LUMENRC1R
018400070530    * *
018500100915     C                   if        grp1 = '*' or grp1 = '0'
018600100421     c                   EVAL      E3GROUP = %TRIM(grp24)
018700100421     c                   else
018800100421     c                   EVAL      E3GROUP = %TRIM(grp4)
018900100421     c                   endif
019000070530     c                   move      '1'           e3rectyp
019100100915     c                   movel     fcmid#        e3partic
019200070530     c                   move      '00'          e3depno
019300100915     c                   move      fcempdt       e3hiredt
019400070530     C                   EVAL      E3DIV = 'A001'
019500070530    ***
019600100915     c*******            move      fcefdt        e3initdt
019700100915     c                   movel     fclnme        e3last
019800100915     c                   movel     fcfnme        e3first
019900100915     c                   move      fcmi          e3mi
020000070530    * *
020100100915     c                   movel     fcadr1        e3addr
020200100915     c                   movel     fcadr2        e3addr2
020300100915     c                   movel     fccity        e3city
020400100915     c                   movel     fcst          e3stat
020500070530    * *
020600100915     c                   movel     fczip         e3zip
020700100915     c                   movel     fcarea        phonewk          10
020800100915     c                   move      fcphn#        phonewk
020900070530     c                   movel     phonewk       e3phone
021000070530    ***
021100100915     c                   move      fcgndr        e3sex
021200100915     c                   move      fcbrdt        e3dob
021300100915     c                   move      fcmid#        e3ssn
021400080725    * *
021500100915    1c                   if        fcmardt <> 0
021600080725     c                   move      'M'           e3marsta
021700080725    1c                   else
021800080725     c                   move      'S'           e3marsta
021900080725    1c                   end
022000080725      *
022100100915    1C                   if        fcsal = 0
022200071108    1c                   movel     astrsk        e3sal
022300071108    1c                   else
022400100915     c                   z-add     fcsal         salarywk         10 2
022500070530     c                   eval      e3sal = %editc(salarywk : '3')
022600071108    1c                   endif
022700070530      *
022800080919     c***                movel     'T'           covtp             3
022900100915     c***                move      fccovt        covtp
023000080919     c*    covtp         lookup    taba          tabb                     66
023100080919    1C*                  if        *in66
023200080919     C****               MOVEL     TABB          e3enr1
023300080919    1c****               endif
0234000707240291  *
023500071108     c                   movel     astrsk        e3vol1
023600071108     c                   movel     astrsk        e3vol2
023700071108     c                   movel     astrsk        e3vol3
023800071108     c                   movel     astrsk        e3vol4
023900071108     c                   movel     astrsk        e3vol5
024000071108     c                   movel     astrsk        e3vol6
024100071108     c                   movel     astrsk        e3vol7
024200071108     c                   movel     astrsk        e3vol8
024300071108     c                   movel     astrsk        e3vol9
024400071108     c                   movel     astrsk        e3vol10
024500071108     c                   movel     astrsk        e3vol11
024600071108     c                   movel     astrsk        e3vol12
024700071108     c                   movel     astrsk        e3vol13
024800071108     c                   movel     astrsk        e3vol14
024900071108     c                   movel     astrsk        e3vol15
025000071108     c                   movel     astrsk        e3vol16
025100080926      *
025200100915    1c                   if        fxsts = 'N' or fxsts = 'G'
025300100915    * *    Per Jessica - leave this blank for FSA
025400110120    * *    Per Jessica - 01/2011 - we are now using plan name
025500110120     C                   MOVEL     fsplan        e3plan1
025600110120     c                   EVAL      e3cov1 = 'ADN'
025700090108     c                   EVAL      e3enr1 = 'F99'
025800100915     c                   movel     fcefdt        e3effdt
025900080926     c                   else
026000080926      *        If coverage change use eff date o/w use today's date
026100100915    1c                   if        fxccovt <> ' ' or
026200100915    1c                             fxctfldt <> 0
026300100915     c                   movel     fcefdt        e3effdt
026400080926     c                   else
026500080926     c                   movel     today         e3effdt
026600080926     c                   endif
026700080926     c                   endif
026800071113      *
026900070530      * write subscriber record to subscriber file
027000070530     C                   EVAL      E3X = '*'
027100070530     c                   write     lumenrc1r
027200080430      *
027300070530     C                   else
027400070530    * *     Write Dep rec
027500070530     C                   CLEAR                   LUMENRC2R
027600070530    * *
027700100915     C                   if        grp1 = '*' or grp1 = '0'
027800100421     c                   EVAL      E4GROUP = %TRIM(grp24)
027900100421     c                   else
028000100421     c                   EVAL      E4GROUP = %TRIM(grp4)
028100100421     c                   endif
028200070530     c                   move      '2'           e4rectyp
028300100915     c                   movel     fcmid#        e4partic
028400100915     c                   move      fcseq#        e4dep
028500100915     c*****              move      fcempdt       e3hiredt
028600070530     C                   EVAL      E4DIV = 'A001'
028700070530    ***
028800100915     c*******            move      fcefdt        e4initdt
028900100915     c                   movel     fclnme        e4last
029000100915     c                   movel     fcfnme        e4first
029100100915     c                   move      fcmi          e4mi
029200070530    * *
029300070530    ***
029400100915     c                   move      fcgndr        e4sex
029500100915     c                   move      fcbrdt        e4dob
029600100915     c                   move      fcdssn        e4ssn
029700070530    * *
029800100915    1c                   if        fctrmdt <> 0
029900100915     c                   move      fctrmdt       e3emptrm
030000100610    1c                   end
030100070530      *
030200100915     c****               z-add     fcsal         salarywk         10 2
030300070530     c****               eval      e3sal = %editc(salarywk : '3')
030400070530    * *
030500100915    1c                   if        fcrelcd = 'RSO' or
030600100915    1c                             fcrelcd = 'RDA'
030700070530     c                   eval      e4relat = 'C'
030800070530    1c                   else
030900070530     c                   eval      e4relat = 'S'
031000070530    1c                   end
031100070530      *
031200070921     C                   MOVEL     *blanks       e4plan1
031300070921      *
031400080919     c****               If        e4cov1 = '   '
031500100915     c*                  eval      fxlsts = 'E'
031600080919     c*                  write     bgerrxr
0317000809190297 C****               else
031800080430      *
031900100915    1c                   if        fxsts = 'N' or fxsts = 'G'
032000100915     c                   movel     fcefdt        e4effdt
032100100915    * *    Per Jessica - leave this blank for FSA
032200110120    * *    Per Jessica - 01/2011 - we are now using plan name
032300110120     C                   MOVEL     fsplan        e4plan1
032400110120     c                   EVAL      e4cov1 = 'ADN'
032500080926     c                   else
032600100915     c                   movel     fcefdt        e4effdt
032700080926     c                   endif
032800071113      *
032900100915    1c***                if        fxctfldt <> 0
033000100915     C*                  move      fxctfldt      e4end
033100080926    1c***                endif
033200071113      *
033300070530      * write subscriber record to subscriber file
033400070530     C                   EVAL      E4X = '*'
033500070530     c                   write     lumenrc2r
033600070530      *
033700080430     C                   endif
033800070530      *
033900070530     C                   endsr
0340000711080107  ********************************************************************************
0341000711080107  *
0342000711080107  *     INZSR - Preprocessing
0343000711080107  *
0344000711080107  ********************************************************************************
034500071108     C     *Inzsr        Begsr
034600071108    ***   Pre-processing
0347000711080297 C                   movel     UDATE         isotoday
0348000711080297 C                   movel     isotoday      today
034900071108     C                   Endsr
035000070529** coverage types (3-3): GBS - LUM
035100070529TINP00
035200070529TPCP01
035300070529T2PP99
035400070529TP2P99
035500070529THWF00
035600070529TFAF99
035700070529TDEF00
035800070529TDFF99
035900070529TTCP19
036000070529TFCF19
036100070529TE1F00
036200070529TDPF00
