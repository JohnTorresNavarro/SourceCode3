0001000204020002  *****************************************************************************
000200120906      * DDELVAGR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400120906      *            DATE - 09/2012                                                 *
000500120906      *  DESCRIPTION - Build Delta Dental VA cov file from GBS files              *
000600020426      *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900121106      *  rlj 11/06/2012 Don't send deps w/ a term date, remove from file
001000130327      *  rlj 03/27/2013 Only send 1 rec for each mbr - most recent
001100020402      *                                                                *
0012009102150018 F******************************************************************
0013000610240020 Fplnmstn1  IF   E           K DISK
0014000610240020 Fgrat25    IF   E           K DISK
0015000610240020 Fmcovl1    IF   E           K DISK
0016000205240020 Fmcov38    IF   E           K DISK    RENAME(MCOVR:MC38R)
0017000205240020 F                                     PREFIX(X)
0018000205170020 Fmember    IF   E           K DISK
0019000205170020 Fdepndc    IF   E           K DISK
0020000205170020 Fdcov      IF   E           K DISK
0021001303270020 Fddveligl  UF   E           K DISK    RENAME(DDVELIGR:DDVELR)
0022001303270020 F                                     PREFIX(L)
0023001303270020 Fddveligp  O    E             DISK
0024000810300029  *
0025000204260250 D                 DS
0026000610240251 D  group#                 1     15
0027000610240251 D    grp14                1      4
0028000610240251 D    grp58                5      8
0029001209060029  *
0030001209060250 D                 DS
0031001209060251 D  zip                    1      9  0
0032001209060251 D    zip5                 1      5
0033001209060251 D    zip4                 6      9
0034000810300029  *
0035001209060250 D                 DS
0036001209060251 D dzip                    1      9  0
0037001209060251 D   dzip5                 1      5
0038001209060251 D   dzip4                 6      9
0039001211060029  *
0040001211060250 D                 DS
0041001211060251 D dvcity                  1     30
0042001211060251 D   city6                 1      6
0043001209060029  *
0044000810300250 D                 DS
0045000810300251 D  kyid           S              1
0046000810300251 D  kydata         S             74    INZ(*BLANKS)
0047001203120251 D  dupmem         S              1
0048001203120251 D  dupem          S              1
0049000810300251 D  updtd          S              1
0050001211060251 D  todayx         S               D   DATFMT(*ISO)
0051001211060251 D  today8         S              8S 0
0052000610240029  *
0053000610240250 D                 DS
0054000610240251 D  datymd                 1      8  0
0055000610240251 D    ymdcc                1      2  0
0056000610240251 D    ymdyy                3      4  0
0057000205070251 D    ymdmd                5      8  0
0058000205170250 D                 DS
0059000205170251 D  mktrst                        3  0 INZ(419)
0060000205170251 D  mksub                         3  0 INZ(1)
0061000205170251 D  mkplan                        4    INZ('7000')
0062000205210251 D  cntspc                        2  0 INZ(0)
0063000205210251 D  cntkid                        2  0 INZ(0)
0064000205210251 D  savrat                        1    INZ(' ')
0065000205210251 D  todaa                         2  0
0066000610240251 D  kcarr                              LIKE(PCARR)
0067001209060251 D  svtyp                              LIKE(mcovtp)
0068001209140251 D  svpln                              LIKE(mcplan)
0069001209060251 D  svratc                             LIKE(dvratc)
0070001209140251 D  svsubl                             LIKE(dvsubl)
0071001303270251 D  ksubid                             LIKE(dvsubid)
0072001303270251 D  kmfnam                             LIKE(dvmfnam)
0073001303270251 D  kdob                               LIKE(dvdob)
0074001303270251  *
0075000205210250 D                 DS
0076000205210251 D  ISOdate        S               D
0077000205210251 D  ISOnum         S              8  0
0078000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0079000205240251 D  enrdat         S              8  0
0080000205240251 D  trmdat         S              8  0
0081000205210250 D                 DS
0082000205310251 D  wrkdat8                1      8  0
0083000205310251 D   wrkda                 7      8  0
0084000205310250 D                 DS
0085000205310251 D  dftstrt                1      8  0
0086000205210251 D    strtda               7      8  0
0087000205210251 D  dftend                 9     16  0
0088000205210251 D    endda               15     16  0
0089000205210251 D  mdystrt               17     22  0
0090000205210251 D   strta                17     22
0091000205210251 D  mdyend                23     28  0
0092000205210251 D   enda                 23     28
009300020517      *
009400061024     C     grkey         klist
009500061024     C                   kfld                    pltrst
009600061024     C                   kfld                    plsub#
009700061024     C                   kfld                    plplan
009800061024      *
009900061024     C     mckey         klist
010000061024     C                   kfld                    mktrst
010100061024     C                   kfld                    mksub
010200061024     C                   kfld                    mkplan
010300020517      *
010400090917     C     xrkey         klist
010500090917     C                   kfld                    mctrst
010600090917     C                   kfld                    mcsub#
010700090917     C                   kfld                    acc#
010800090917      *
010900020517     C     dpkey         klist
011000090917     C                   kfld                    ssno
011100090917     C                   kfld                    dseq#
011200090917      *
011300020524     C     m38ky         klist
011400090917     C                   kfld                    mcssno
011500090917     C                   kfld                    mdseq#
011600090917     C                   kfld                    mctrst
011700020524     C                   kfld                    mcsub#
011800020524     C                   kfld                    mcplan
011900130327      *
012000130327     C     dekey         klist
012100130327     C                   kfld                    ksubid
012200130327     C                   kfld                    kmfnam
012300130327     C                   kfld                    kdob
012400020517      *
012500020503      ******************************************************************************
0126001211060291  *   Preprocessing
0127001211060297 C                   movel     UDATE         todayx
0128001211060297 C                   movel     todayx        today8
0129001211060297  *
013000020517      *      MainLine
0131000204260111  *
0132001209130107  *      Loop thru PLNMST looking for Carrier = 'DVA'
013300120913     C                   eval      kcarr = 'DVA'
013400061024     C     kcarr         setll     plnmstn1
013500061024     C                   dou       *in23 = '1'
013600101228     C                   read      plnmstn1                               23
013700120913     C                   if        *in23 = '1' or PCARR > 'DVA'
013800101228     C                   leave
013900101228     C                   endif
014000120913     C                   if        PCARR = 'DVA'
0141000612120111  *
014200061024     C     grkey         chain     grat25                             24
014300061024     C                   if        *in24 = '0'
014400120906     C****               eval      rgrp# = grp14
014500120906     C*****              eval      rsubl = grp58
014600061024     C                   endif
0147001203060107  *      Debug shit
014800120306     C                   if        plplan = 'BADW' or plplan = 'BADZ'
014900120306     C                   eval      mcssno = mcssno
015000120306     C                   endif
0151000610240107  *      Loop thru MCOVL1 to locate all mbrs
015200061024     C     grkey         setll     mcovl1
015300061024     C                   dou       *in21 = '1'
015400061024     C     grkey         reade     mcovl1                                 21
015500061024     C                   if        *in21 = '0'
0156000205240107  *      If enroll date and term date are equal => bypass record
015700020524     C                   if        enrldt = candt
015800020524     C                   iter
015900020524     C                   endif
0160000810310107  *      Debug shit
016100121106     C                   if        mcssno = 230043641
016200081031     C                   eval      mcssno = mcssno
016300081031     C                   endif
0164000205240107  *
016500120906     C                   z-add     enrldt        enrdat
016600120906     C                   z-add     candt         trmdat
016700120906     C                   eval      svtyp = mcovtp
016800120914     C                   eval      svpln = mcplan
0169001209060111  *
017000020524     C                   exsr      bldmbr
0171001203120107  *     If member was duplicate - skip
017200120312     C                   if        dupmem = 'Y'
017300120312     C                   iter
017400120312     C                   endif
0175000610250107  *      Loop thru DCOV to locate all Delta dependents
017600020517     C     mcssno        setll     dcov
017700020517     C                   dou       *in22 = '1'
017800020517     C     mcssno        reade     dcov                                   22
017900020517     C                   if        *in22 = '0'
0180000206260107  *      If enroll date and term date are equal => bypass record
018100020524     C                   if        denrdt = ccandt
018200020524     C                   iter
018300020524     C                   endif
018400121106     C                   if        mcssno = ssno and dvplan = plplan and
018500121106     C                             (ccandt = 0 or ccandt > today8)
018600020517     C                   exsr      blddep
018700020517     C                   endif
018800020517     C                   else
018900020517     C                   leave
019000020517     C                   endif
019100020517     C                   enddo
019200020517     C                   endif
019300020517     C                   enddo
019400061024     C                   endif
019500061024     C                   enddo
019600120906      *
019700020517     C                   movel     '1'           *inlr
019800020517     C                   return
0199000204020107  ********************************************************************************
0200000204020107  *
0201001209060107  *     BLDMBR - Build Member record
0202000204020107  *
0203000204020107  ********************************************************************************
020400020517     C     bldmbr        begsr
020500120906      *
020600020521     C                   eval      cntspc = 0
020700020521     C                   eval      cntkid = 0
020800130327     C                   eval      dupmem = 'N'
020900020517     C     mcssno        chain     member                             31
021000020517     C                   if        *in31 = '0'
0211001209060107  *       Build Member rec
021200120906     C                   clear                   ddveligr
021300120906     C                   movel     mcssno        dvsubid
021400120906     C                   eval      dvgrp# = '000600200'
021500120914      *
021600120914     C                   select
021700120914     C                   when      svpln = 'EALJ'
021800120914     C                   eval      dvsubl = '00001111'
021900120914     C                   when      svpln = 'EALK'
022000120914     C                   eval      dvsubl = '00001099'
022100120914     C                   when      svpln = 'EALL'
022200120914     C                   eval      dvsubl = '00002111'
022300120914     C                   when      svpln = 'EALM'
022400120914     C                   eval      dvsubl = '00002099'
022500120914     C                   endsl
022600120914     C                   eval      svsubl = dvsubl
022700120914      *
022800120913     C                   eval      dvdiv# = '0000'
0229001209060107  *     debug shit
023000120906     C                   if        mcssno = 218867574
023100120906     C                   eval      mcssno = mcssno
023200120906     C                   endif
0233001209060107  *
0234001209060107  *      Loop thru MCOV38 to locate all coverages for Mbr for TK - Delta
023500120906     C     m38ky         setll     mcov38
023600120906     C                   dou       *in28 = '1'
023700120906     C     m38ky         reade     mcov38                                 28
023800120906     C                   if        *in28 = '0'
023900120906     C                   if        xenrldt = enrdat and xcandt = trmdat
024000120906     C                   iter
024100120906     C                   endif
0242001209140107  *      If enroll date and term date are equal => bypass record
024300120914     C                   if        xenrldt = xcandt
024400120914     C                   iter
024500120914     C                   endif
0246001209140107  *
024700120906     C                   if        xenrldt < enrdat
024800120906     C                   z-add     xenrldt       enrdat
024900120906     C                   endif
025000120906     C                   if        trmdat <> 0
0251001209060296 C                   If        xcandt > trmdat or
0252001209060296 C                             xcandt = 0
025300120906     C                   eval      svtyp = xmcovtp
025400120906     C                   z-add     xcandt        trmdat
025500120906     C                   endif
025600120906     C                   endif
025700120906     C                   endif
025800120906     C                   enddo
025900120906      *        Set cov type
026000120906     C                   eval      dvratc = '0004'
026100120906     C                   select
026200120906      *
026300120906     C                   when      svtyp = 'TIN'
026400120906     C                   eval      dvratc = '0001'
026500120906     C                   when      svtyp = 'THW'
026600120906     C                   eval      dvratc = '0002'
026700120906     C                   when      svtyp = 'TFA'
026800120906     C                   eval      dvratc = '0003'
026900120906     C                   when      svtyp = 'TPC'
027000120906     C                   eval      dvratc = '0005'
027100120906     C                   when      svtyp = 'TP2'
027200120906     C                   eval      dvratc = '0006'
027300120906      *
027400120906     C                   endsl
027500120906      *
027600120906     C                   eval      svratc = dvratc
027700120906      *
027800120906     C                   movel     enrdat        dveffdt
027900120906     C                   movel     trmdat        dvtrmdt
028000120906     C                   movel     empdt         dvhirdt
028100120906     C                   eval      dvrelcd = '01'
028200120906     C                   movel(P)  mlname        dvmlnam
028300120906     C                   movel(P)  mfname        dvmfnam
028400120906     C                   movel(P)  mmi           dvmmnam
028500120906     C                   movel     birth         dvdob
028600120906     C                   if        sex = 'M'
028700120906     C                   movel     '01'          dvsex
028800120906     C                   else
028900120906     C                   movel     '02'          dvsex
029000120906     C                   endif
029100120906     C                   movel(P)  addr1         dvaddr1
029200120906     C                   movel(P)  addr2         dvaddr2
029300120906     C                   movel(P)  city          dvcity
0294001211060111  *
029500121106     C                   if        city6 = 'APO   '
029600121106     C                   movel(P)  'AA'          dvst
029700121106     C                   movel(P)  '34001'       dvzip
029800121106     C                   movel(P)  *blanks       dvzip4
029900121106     C                   else
030000121106     C                   movel(P)  state         dvst
030100121106     C                   movel(P)  zip5          dvzip
030200121106     C                   movel(P)  zip4          dvzip4
030300121106     C                   endif
0304001211060111  *
030500120906     C                   movel     '0001'        dvcntr
0306001209060111  *
030700120906     C                   endif
0308001303270111  *   Check to see if mbr rec already exists
030900130327     C                   eval      ksubid = dvsubid
031000130327     C                   eval      kmfnam = dvmfnam
031100130327     C                   eval      kdob = dvdob
031200130327     C     dekey         chain     ddveligl                           43
031300130327     C                   if        *in43 = '0'
0314001303270107  *
031500130327     C                   if        dveffdt > ldveffdt
031600130327     C                   delete    ddvelr
031700130327     C                   write     ddveligr
031800130327     C                   endif
0319001303270107  *
032000130327     C                   else
032100120906     C                   write     ddveligr
032200130327     C                   endif
0323000205170111  *
032400020517     C                   endsr
0325000205170107  ********************************************************************************
0326000205170107  *
0327001209060107  *     BLDDEP - Build Record for Dependent data
0328000205170107  *
0329000205170107  ********************************************************************************
033000020517     C     blddep        begsr
033100020517     C     dpkey         chain     depndc                             33
033200020517     C                   if        *in33 = '0'
0333001209060107  *       Build Dep Rec
033400120906     C                   clear                   ddveligr
033500120906     C                   movel     mcssno        dvsubid
033600120906     C                   eval      dvgrp# = '000600200'
033700120914     C                   eval      dvsubl = svsubl
033800120914     C                   eval      dvdiv# = '0000'
033900120906     C                   eval      dvratc = svratc
034000120906     C                   movel     denrdt        dveffdt
034100120906     C                   movel     ccandt        dvtrmdt
034200120906      *
034300120906     C                   if        drelcd = 'RHU' or drelcd = 'RWI'
034400120906     C                   eval      dvrelcd = '02'
034500120906     C                   else
034600120906     C                   if        drelcd = 'RSO' or drelcd = 'RDA'
034700120906     C                   eval      dvrelcd = '03'
034800120906     C                   else
034900120906     C                   eval      dvrelcd = '04'
035000120906     C                   endif
035100120906     C                   endif
035200120906      *
035300120906     C                   movel(P)  dlname        dvmlnam
035400120906     C                   movel(P)  dfname        dvmfnam
035500120906     C                   movel(P)  dmi           dvmmnam
035600120906     C                   movel     dbirth        dvdob
035700120906     C                   if        dsex = 'M'
035800120906     C                   movel     '01'          dvsex
035900120906     C                   else
036000120906     C                   movel     '02'          dvsex
036100120906     C                   endif
036200120906     C                   movel(P)  daddr1        dvaddr1
036300120906     C                   movel(P)  daddr2        dvaddr2
036400120906     C                   movel(P)  dcity         dvcity
0365001211060111  *
036600121106     C                   if        city6 = 'APO   '
036700121106     C                   movel(P)  'AA'          dvst
036800121106     C                   movel(P)  '34001'       dvzip
036900121106     C                   movel(P)  *blanks       dvzip4
037000121106     C                   else
037100120906     C                   movel(P)  dstate        dvst
037200120906     C                   movel(P)  dzip5         dvzip
037300120906     C                   movel(P)  dzip4         dvzip4
037400121106     C                   endif
0375001211060111  *
037600120906     C                   movel     '0001'        dvcntr
0377001209060111  *
0378001303270111  *   Check to see if dep rec already exists
037900130327     C                   eval      ksubid = dvsubid
038000130327     C                   eval      kmfnam = dvmfnam
038100130327     C                   eval      kdob = dvdob
038200130327     C     dekey         chain     ddveligl                           43
038300130327     C                   if        *in43 = '0'
0384001303270107  *
038500130327     C                   if        dveffdt > ldveffdt
038600130327     C                   delete    ddvelr
038700130327     C                   write     ddveligr
038800130327     C                   endif
0389001303270107  *
039000130327     C                   else
039100120906     C                   write     ddveligr
0392000205170111  *
039300020517     C                   endif
0394001303270111  *
039500130327     C                   endif
0396000205170111  *
039700020517     C                   endsr
