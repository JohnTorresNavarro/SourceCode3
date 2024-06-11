0001000204020002  *****************************************************************************
000200130122      * DELGRPGR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400130122      *            DATE - 01/2013                                                 *
000500130122      *  DESCRIPTION - Build Delta Dental group file from GBS files               *
000600020426      *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900130122      *  xxx mm/dd/yyyy x
001000020402      *                                                                *
0011009102150018 F******************************************************************
0012000610240020 Fplnmstn1  IF   E           K DISK
0013000610240020 Fgrat25    IF   E           K DISK
0014000610240020 Fmcovl1    IF   E           K DISK
0015001301220020 Faccmst    IF   E           K DISK
0016000205170020 Fdcov      IF   E           K DISK
0017001301220020 Fddgrpp    O    E             DISK
0018000810300029  *
0019000204260250 D                 DS
0020000610240251 D  group#                 1     15
0021001312190251 D    grp14                1      4
0022001312190251 D    grp58                5      8
0023000810300029  *
0024000810300250 D                 DS
0025000810300251 D  kyid           S              1
0026000810300251 D  kydata         S             74    INZ(*BLANKS)
0027001203120251 D  dupmem         S              1
0028001203120251 D  dupem          S              1
0029000810300251 D  updtd          S              1
0030000610240029  *
0031000610240250 D                 DS
0032000610240251 D  datymd                 1      8  0
0033000610240251 D    ymdcc                1      2  0
0034000610240251 D    ymdyy                3      4  0
0035000205070251 D    ymdmd                5      8  0
0036000205170250 D                 DS
0037000205170251 D  mktrst                        3  0 INZ(419)
0038000205170251 D  mksub                         3  0 INZ(1)
0039000205170251 D  mkplan                        4    INZ('7000')
0040000205210251 D  cntspc                        2  0 INZ(0)
0041000205210251 D  cntkid                        2  0 INZ(0)
0042000205210251 D  savrat                        1    INZ(' ')
0043001301220251 D  todaa                         8  0
0044000610240251 D  kcarr                              LIKE(PCARR)
0045000205210250 D                 DS
0046000205210251 D  ISOdate        S               D
0047000205210251 D  ISOnum         S              8  0
0048000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0049000205240251 D  enrdat         S              8  0
0050000205240251 D  trmdat         S              8  0
0051000205210250 D                 DS
0052000205310251 D  wrkdat8                1      8  0
0053000205310251 D   wrkda                 7      8  0
0054000205310250 D                 DS
0055000205310251 D  dftstrt                1      8  0
0056000205210251 D    strtda               7      8  0
0057000205210251 D  dftend                 9     16  0
0058000205210251 D    endda               15     16  0
0059000205210251 D  mdystrt               17     22  0
0060000205210251 D   strta                17     22
0061000205210251 D  mdyend                23     28  0
0062000205210251 D   enda                 23     28
006300020517      *
006400061024     C     grkey         klist
006500061024     C                   kfld                    pltrst
006600061024     C                   kfld                    plsub#
006700061024     C                   kfld                    plplan
006800061024      *
006900061024     C     mckey         klist
007000061024     C                   kfld                    mktrst
007100061024     C                   kfld                    mksub
007200061024     C                   kfld                    mkplan
007300130122      *
007400130122     C     ackey         klist
007500130122     C                   kfld                    mctrst
007600130122     C                   kfld                    mcsub#
007700130122     C                   kfld                    acc#
007800020517      *
007900090917     C     xrkey         klist
008000090917     C                   kfld                    mctrst
008100090917     C                   kfld                    mcsub#
008200090917     C                   kfld                    acc#
008300090917      *
008400020517     C     dpkey         klist
008500090917     C                   kfld                    ssno
008600090917     C                   kfld                    dseq#
008700081030      *
008800081030     C     dekey         klist
008900081030     C                   kfld                    kyid
009000081030     C                   kfld                    kydata
009100020517      *
009200020503      ******************************************************************************
0093001301221304  *         Calculate default action dates
009400130122     C                   move      UDATE         ISOdate
009500130122     C                   move      ISOdate       todaa
009600020517      *      MainLine
0097000204260111  *
0098001012280107  *      Loop thru PLNMST looking for Carrier = 'DEA', 'DEM' or 'DE1'
009900101228     C                   eval      kcarr = 'DEA'
010000061024     C     kcarr         setll     plnmstn1
010100061024     C                   dou       *in23 = '1'
010200101228     C                   read      plnmstn1                               23
010300101228     C                   if        *in23 = '1' or PCARR > 'DE1'
010400101228     C                   leave
010500101228     C                   endif
010600101228     C                   if        PCARR = 'DEA' or pcarr = 'DEM' or
010700101228     C                             PCARR = 'DE1'
0108000612120111  *
010900130122     C                   clear                   ddgrpr
011000130122     C                   movel     pdescr        dgpnam
0111001301230111  *
011200130123     C     'PPO'         scan      dgpnam                                 52
011300130123     C                   if        *in52 = '1'
011400130123     C                   movel     'PPO'         dgptyp
011500130123     C                   else
011600130123     C                   movel     'DHMO'        dgptyp
011700130123     C                   endif
0118001301220111  *
011900130122     C     grkey         chain     grat25                             24
012000061024     C                   if        *in24 = '0'
012100131219     C                   movel     grp14         dggrp#
012200131219     C                   movel     grp58         dgsubl
012300061024     C                   endif
0124000902100107  *   **** Bypass termed grp# 9690 prt Delta 02/2009
012500130122     C                   if        dggrp# = '9690' or
012600130122     C                             dggrp# = '0997' or
012700130122     C                             dggrp# = '6408' or
012800130122     C                             dggrp# = '7129'
012900090210     C                   iter
013000090210     C                   endif
0131001203060107  *      Debug shit
013200120306     C                   if        plplan = 'BADW' or plplan = 'BADZ'
013300120306     C                   eval      mcssno = mcssno
013400120306     C                   endif
0135000610240111  *
013600130122     C                   eval      dgcnt = 0
0137001301220111  *
0138000610240107  *      Loop thru MCOVL1 to locate all mbrs
013900061024     C     grkey         setll     mcovl1
014000061024     C                   dou       *in21 = '1'
014100061024     C     grkey         reade     mcovl1                                 21
014200061024     C                   if        *in21 = '0'
0143000205240107  *      If enroll date and term date are equal => bypass record
014400130122     C                   if        enrldt = candt
014500020524     C                   iter
014600020524     C                   endif
0147001302270107  *      If Not yet active => bypass record
014800130228     C                   if        enrldt > 20130228
014900130122     C                   iter
015000130122     C                   endif
0151001302270107  *      If termed => bypass record
015200130228     C                   if        candt <> 0 and candt < 20130228
015300130227     C                   iter
015400130227     C                   endif
0155000810310107  *      Debug shit
015600130117     C                   if        mcssno = 203526129
015700081031     C                   eval      mcssno = mcssno
015800081031     C                   endif
0159001301220111  *
016000130122     C                   eval      dgcnt = dgcnt + 1
0161001301220107  *      Fill in Account info in not there yet
016200130122     C                   if        dggnam = *blanks
0163001301220111  *
016400130122     C     ackey         chain     accmst                             27
016500130122     C                   if        *in27 = '0'
016600130122     C                   movel     acnam1        dggnam
016700130227     C                   movel     astate        dgst
016800130227     C                   movel     azip          dggzip
016900130122     C                   endif
017000130122      *
017100130122     C                   endif
0172001301220111  *
017300020517     C                   endif
017400020517     C                   enddo
0175001301220107  *
017600130122     C                   if        dgcnt > 4 and dgcnt < 100
017700130122     C                   write     ddgrpr
017800130122     C                   endif
0179001301230107  *
018000130123     C                   endif
0181001301230107  *
018200061024     C                   enddo
018300130122      *
018400020517     C                   movel     '1'           *inlr
018500020517     C                   return
