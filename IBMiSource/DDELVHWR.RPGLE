0001000204020002  *****************************************************************************
000200120906      * DDELVAGR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400130730      *            DATE - 07/2013                                                 *
000500130730      *  DESCRIPTION - Build Delta Dental VA for Henry's Wecker                   *
000600020426      *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900121106      *  rlj 11/06/2012 Don't send deps w/ a term date, remove from file
001000130327      *  rlj 03/27/2013 Only send 1 rec for each mbr - most recent
001100130508      *  rlj 05/08/2013 Use MCOV39 to get ENR(D) to see cov lvl chgs
001200130906      *  rlj 08/29/2013 Subtract 1 day from term dates per CF
001300130906      *  rlj 09/06/2013 Do not send recs w/ term dates prior to 6/6/13
001400020402      *                                                                *
0015009102150018 F******************************************************************
0016000610240020 Fplnmstn1  IF   E           K DISK
0017000610240020 Fgrat25    IF   E           K DISK
0018000610240020 Fmcovl1    IF   E           K DISK
0019001305080020 Fmcov39    IF   E           K DISK    RENAME(MCOVR:MC39R)
0020000205240020 F                                     PREFIX(X)
0021000205170020 Fmember    IF   E           K DISK
0022000205170020 Fdepndc    IF   E           K DISK
0023000205170020 Fdcov      IF   E           K DISK
0024001307300020 Fddvelhwl  UF   E           K DISK    RENAME(DDVELHWR:DDVELR)
0025001303270020 F                                     PREFIX(L)
0026001307300020 Fddvelhwp  O    E             DISK
0027000810300029  *
0028000204260250 D                 DS
0029000610240251 D  group#                 1     15
0030000610240251 D    grp14                1      4
0031000610240251 D    grp58                5      8
0032001209060029  *
0033001209060250 D                 DS
0034001209060251 D  zip                    1      9  0
0035001209060251 D    zip5                 1      5
0036001209060251 D    zip4                 6      9
0037000810300029  *
0038001209060250 D                 DS
0039001209060251 D dzip                    1      9  0
0040001209060251 D   dzip5                 1      5
0041001209060251 D   dzip4                 6      9
0042001211060029  *
0043001211060250 D                 DS
0044001211060251 D dvcity                  1     30
0045001211060251 D   city6                 1      6
0046001209060029  *
0047000810300250 D                 DS
0048000810300251 D  kyid           S              1
0049000810300251 D  kydata         S             74    INZ(*BLANKS)
0050001203120251 D  dupmem         S              1
0051001203120251 D  dupem          S              1
0052000810300251 D  updtd          S              1
0053001211060251 D  todayx         S               D   DATFMT(*ISO)
0054001211060251 D  today8         S              8S 0
0055000610240029  *
0056000610240250 D                 DS
0057000610240251 D  datymd                 1      8  0
0058000610240251 D    ymdcc                1      2  0
0059000610240251 D    ymdyy                3      4  0
0060000205070251 D    ymdmd                5      8  0
0061000205170250 D                 DS
0062000205170251 D  mktrst                        3  0 INZ(419)
0063000205170251 D  mksub                         3  0 INZ(1)
0064000205170251 D  mkplan                        4    INZ('7000')
0065000205210251 D  cntspc                        2  0 INZ(0)
0066000205210251 D  cntkid                        2  0 INZ(0)
0067000205210251 D  savrat                        1    INZ(' ')
0068000205210251 D  todaa                         2  0
0069000610240251 D  kcarr                              LIKE(PCARR)
0070001209060251 D  svtyp                              LIKE(mcovtp)
0071001209140251 D  svpln                              LIKE(mcplan)
0072001209060251 D  svratc                             LIKE(dvratc)
0073001209140251 D  svsubl                             LIKE(dvsubl)
0074001303270251 D  ksubid                             LIKE(dvsubid)
0075001303270251 D  kmfnam                             LIKE(dvmfnam)
0076001303270251 D  kdob                               LIKE(dvdob)
0077001305080251 D  mbreff                             LIKE(dveffdt)
0078001303270251  *
0079000205210250 D                 DS
0080000205210251 D  ISOdate        S               D
0081000205210251 D  ISOnum         S              8  0
0082000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0083000205240251 D  enrdat         S              8  0
0084000205240251 D  trmdat         S              8  0
0085001305080251 D  date9          S              8  0 INZ(99999999)
0086001305080251  *
0087000205210250 D                 DS
0088000205310251 D  wrkdat8                1      8  0
0089000205310251 D   wrkda                 7      8  0
0090000205310250 D                 DS
0091000205310251 D  dftstrt                1      8  0
0092000205210251 D    strtda               7      8  0
0093000205210251 D  dftend                 9     16  0
0094000205210251 D    endda               15     16  0
0095000205210251 D  mdystrt               17     22  0
0096000205210251 D   strta                17     22
0097000205210251 D  mdyend                23     28  0
0098000205210251 D   enda                 23     28
009900020517      *
010000061024     C     grkey         klist
010100061024     C                   kfld                    pltrst
010200061024     C                   kfld                    plsub#
010300061024     C                   kfld                    plplan
010400061024      *
010500061024     C     mckey         klist
010600061024     C                   kfld                    mktrst
010700061024     C                   kfld                    mksub
010800061024     C                   kfld                    mkplan
010900020517      *
011000090917     C     xrkey         klist
011100090917     C                   kfld                    mctrst
011200090917     C                   kfld                    mcsub#
011300090917     C                   kfld                    acc#
011400090917      *
011500020517     C     dpkey         klist
011600090917     C                   kfld                    ssno
011700090917     C                   kfld                    dseq#
011800090917      *
011900130508     C     m39ky         klist
012000090917     C                   kfld                    mctrst
012100020524     C                   kfld                    mcsub#
012200020524     C                   kfld                    mcplan
012300130508     C                   kfld                    mcssno
012400130508     C                   kfld                    date9
012500130327      *
012600130327     C     dekey         klist
012700130327     C                   kfld                    ksubid
012800130327     C                   kfld                    kmfnam
012900130327     C                   kfld                    kdob
013000020517      *
013100020503      ******************************************************************************
0132001211060291  *   Preprocessing
0133001307300297 C                   movel     UDATE         todayx
0134001211060297 C                   movel     todayx        today8
0135001211060297  *
013600020517      *      MainLine
0137000204260111  *
0138001307300107  *      Loop thru PLNMST looking for Carrier = 'DVL'
013900130730     C                   eval      kcarr = 'DVL'
014000061024     C     kcarr         setll     plnmstn1
014100061024     C                   dou       *in23 = '1'
014200101228     C                   read      plnmstn1                               23
014300130730     C                   if        *in23 = '1' or PCARR > 'DVL'
014400101228     C                   leave
014500101228     C                   endif
014600130730     C                   if        PCARR = 'DVL'
0147000612120111  *
014800061024     C     grkey         chain     grat25                             24
014900061024     C                   if        *in24 = '0'
015000120906     C****               eval      rgrp# = grp14
015100120906     C*****              eval      rsubl = grp58
015200061024     C                   endif
0153001203060107  *      Debug shit
015400120306     C                   if        plplan = 'BADW' or plplan = 'BADZ'
015500120306     C                   eval      mcssno = mcssno
015600120306     C                   endif
0157000610240107  *      Loop thru MCOVL1 to locate all mbrs
015800061024     C     grkey         setll     mcovl1
015900061024     C                   dou       *in21 = '1'
016000061024     C     grkey         reade     mcovl1                                 21
016100061024     C                   if        *in21 = '0'
0162000205240107  *      If enroll date and term date are equal => bypass record
016300020524     C                   if        enrldt = candt
016400020524     C                   iter
016500020524     C                   endif
0166000810310107  *      Debug shit
016700130521     C                   if        mcssno = 456786500
016800081031     C                   eval      mcssno = mcssno
016900081031     C                   endif
0170000205240107  *
017100120906     C                   z-add     enrldt        enrdat
017200120906     C                   z-add     candt         trmdat
017300120906     C                   eval      svtyp = mcovtp
017400120914     C                   eval      svpln = mcplan
0175001209060111  *
017600020524     C                   exsr      bldmbr
0177001203120107  *     If member was duplicate - skip
017800120312     C                   if        dupmem = 'Y'
017900120312     C                   iter
018000120312     C                   endif
0181000610250107  *      Loop thru DCOV to locate all Delta dependents
018200020517     C     mcssno        setll     dcov
018300020517     C                   dou       *in22 = '1'
018400020517     C     mcssno        reade     dcov                                   22
018500020517     C                   if        *in22 = '0'
0186000206260107  *      If enroll date and term date are equal => bypass record
018700020524     C                   if        denrdt = ccandt
018800020524     C                   iter
018900020524     C                   endif
019000130521     C                   if        mcssno = ssno and dvplan = plplan
019100020517     C                   exsr      blddep
019200020517     C                   endif
019300020517     C                   else
019400020517     C                   leave
019500020517     C                   endif
019600020517     C                   enddo
019700020517     C                   endif
019800020517     C                   enddo
019900061024     C                   endif
020000061024     C                   enddo
020100120906      *
020200020517     C                   movel     '1'           *inlr
020300020517     C                   return
0204000204020107  ********************************************************************************
0205000204020107  *
0206001209060107  *     BLDMBR - Build Member record
0207000204020107  *
0208000204020107  ********************************************************************************
020900020517     C     bldmbr        begsr
021000120906      *
021100020521     C                   eval      cntspc = 0
021200020521     C                   eval      cntkid = 0
021300130327     C                   eval      dupmem = 'N'
021400020517     C     mcssno        chain     member                             31
021500020517     C                   if        *in31 = '0'
0216001209060107  *       Build Member rec
021700130730     C                   clear                   ddvelhwr
021800120906     C                   movel     mcssno        dvsubid
021900130730     C                   eval      dvgrp# = '000100449'
022000120914      *
022100130730     C********           select
022200130730     C********           when      svpln = 'EALJ'
022300120914     C                   eval      dvsubl = '00001111'
022400130730     C********           when      svpln = 'EALK'
022500130730     C********           eval      dvsubl = '00001099'
022600130730     C********           endsl
022700120914     C                   eval      svsubl = dvsubl
022800120914      *
022900120913     C                   eval      dvdiv# = '0000'
0230001209060107  *     debug shit
023100120906     C                   if        mcssno = 218867574
023200120906     C                   eval      mcssno = mcssno
023300120906     C                   endif
0234001209060107  *
0235001305080107  *      Loop thru MCOV39 to locate all coverages for Mbr for TK - Delta
023600130508     C                   eval      svtyp = *blanks
023700130508     C     m39ky         setll     mcov39
023800120906     C                   dou       *in28 = '1'
023900130508     C                   read      mcov39                                 28
024000120906     C                   if        *in28 = '0'
024100130508     C****               if        xenrldt = enrdat and xcandt = trmdat
024200130508     C****               iter
024300130508     C****               endif
0244001305080107  *      If enroll date and term date are equal => bypass record
024500130508     C                   if        xenrldt = xcandt
024600130508     C                   iter
024700130508     C                   endif
0248001305080107  *      Get initial cov type
024900130508     C                   if        svtyp = *blanks
025000130508     C                   eval      svtyp = xmcovtp
025100120914     C                   endif
0252001305080107  *      Check cov type
025300130508     C                   if        svtyp <> xmcovtp or mcssno <> xmcssno
025400130508     C                   leave
025500130508     C                   endif
0256001209140107  *
025700120906     C                   if        xenrldt < enrdat
025800120906     C                   z-add     xenrldt       enrdat
025900120906     C                   endif
026000120906     C                   if        trmdat <> 0
0261001209060296 C                   If        xcandt > trmdat or
0262001209060296 C                             xcandt = 0
026300120906     C                   z-add     xcandt        trmdat
026400120906     C                   endif
026500120906     C                   endif
026600120906     C                   endif
026700120906     C                   enddo
026800120906      *        Set cov type
026900120906     C                   eval      dvratc = '0004'
027000120906     C                   select
027100120906      *
027200120906     C                   when      svtyp = 'TIN'
027300120906     C                   eval      dvratc = '0001'
027400120906     C                   when      svtyp = 'THW'
027500120906     C                   eval      dvratc = '0002'
027600120906     C                   when      svtyp = 'TFA'
027700120906     C                   eval      dvratc = '0003'
027800120906     C                   when      svtyp = 'TPC'
027900120906     C                   eval      dvratc = '0005'
028000120906     C                   when      svtyp = 'TP2'
028100120906     C                   eval      dvratc = '0006'
028200120906      *
028300120906     C                   endsl
028400120906      *
028500120906     C                   eval      svratc = dvratc
028600120906      *
028700120906     C                   movel     enrdat        dveffdt
028800130508     C                   eval      mbreff = dveffdt
028900120906     C                   movel     trmdat        dvtrmdt
0290001308290111  *
029100130906     C                   if        trmdat <> 0 and trmdat < 20130606
029200130906     C                   leavesr
029300130906     C                   endif
0294001309060111  *
029500130829     C                   movel     trmdat        dvtrmdt
029600130829     C                   if        trmdat <> 0
029700130829     C                   movel     trmdat        todayx
029800130829     C                   subdur    1:*D          todayx
029900130829     C                   movel     todayx        today8
030000130829     C                   movel     today8        dvtrmdt
030100130829     C                   endif
0302001308290111  *
030300120906     C                   movel     empdt         dvhirdt
030400120906     C                   eval      dvrelcd = '01'
030500120906     C                   movel(P)  mlname        dvmlnam
030600120906     C                   movel(P)  mfname        dvmfnam
030700120906     C                   movel(P)  mmi           dvmmnam
030800120906     C                   movel     birth         dvdob
030900120906     C                   if        sex = 'M'
031000120906     C                   movel     '01'          dvsex
031100120906     C                   else
031200120906     C                   movel     '02'          dvsex
031300120906     C                   endif
031400120906     C                   movel(P)  addr1         dvaddr1
031500120906     C                   movel(P)  addr2         dvaddr2
031600120906     C                   movel(P)  city          dvcity
0317001211060111  *
031800121106     C                   if        city6 = 'APO   '
031900121106     C                   movel(P)  'AA'          dvst
032000121106     C                   movel(P)  '34001'       dvzip
032100121106     C                   movel(P)  *blanks       dvzip4
032200121106     C                   else
032300121106     C                   movel(P)  state         dvst
032400121106     C                   movel(P)  zip5          dvzip
032500121106     C                   movel(P)  zip4          dvzip4
032600121106     C                   endif
0327001211060111  *
032800120906     C                   movel     '0001'        dvcntr
0329001209060111  *
033000120906     C                   endif
0331001303270111  *   Check to see if mbr rec already exists
033200130327     C                   eval      ksubid = dvsubid
033300130327     C                   eval      kmfnam = dvmfnam
033400130327     C                   eval      kdob = dvdob
033500130730     C     dekey         chain     ddvelhwl                           43
033600130327     C                   if        *in43 = '0'
0337001303270107  *
033800130327     C                   if        dveffdt > ldveffdt
033900130327     C                   delete    ddvelr
034000130730     C                   write     ddvelhwr
034100130327     C                   endif
0342001303270107  *
034300130327     C                   else
034400130730     C                   write     ddvelhwr
034500130327     C                   endif
0346000205170111  *
034700020517     C                   endsr
0348000205170107  ********************************************************************************
0349000205170107  *
0350001209060107  *     BLDDEP - Build Record for Dependent data
0351000205170107  *
0352000205170107  ********************************************************************************
035300020517     C     blddep        begsr
035400020517     C     dpkey         chain     depndc                             33
035500020517     C                   if        *in33 = '0'
0356001209060107  *       Build Dep Rec
035700130730     C                   clear                   ddvelhwr
035800120906     C                   movel     mcssno        dvsubid
035900130730     C                   eval      dvgrp# = '000100449'
036000120914     C                   eval      dvsubl = svsubl
036100120914     C                   eval      dvdiv# = '0000'
036200120906     C                   eval      dvratc = svratc
036300120906     C                   movel     denrdt        dveffdt
036400130508      *
036500130508     C                   if        mbreff > dveffdt
036600130508     C                   eval      dveffdt = mbreff
036700130508     C                   endif
0368001309060111  *
036900130906     C                   if        ccandt <> 0 and ccandt < 20130606
037000130906     C                   leavesr
037100130906     C                   endif
037200130508      *
037300120906     C                   movel     ccandt        dvtrmdt
037400130829     C                   if        ccandt <> 0
037500130829     C                   movel     ccandt        todayx
037600130829     C                   subdur    1:*D          todayx
037700130829     C                   movel     todayx        today8
037800130829     C                   movel     today8        dvtrmdt
037900130829     C                   endif
038000120906      *
038100120906     C                   if        drelcd = 'RHU' or drelcd = 'RWI'
038200120906     C                   eval      dvrelcd = '02'
038300120906     C                   else
038400120906     C                   if        drelcd = 'RSO' or drelcd = 'RDA'
038500120906     C                   eval      dvrelcd = '03'
038600120906     C                   else
038700120906     C                   eval      dvrelcd = '04'
038800120906     C                   endif
038900120906     C                   endif
039000120906      *
039100120906     C                   movel(P)  dlname        dvmlnam
039200120906     C                   movel(P)  dfname        dvmfnam
039300120906     C                   movel(P)  dmi           dvmmnam
039400120906     C                   movel     dbirth        dvdob
039500120906     C                   if        dsex = 'M'
039600120906     C                   movel     '01'          dvsex
039700120906     C                   else
039800120906     C                   movel     '02'          dvsex
039900120906     C                   endif
040000120906     C                   movel(P)  daddr1        dvaddr1
040100120906     C                   movel(P)  daddr2        dvaddr2
040200120906     C                   movel(P)  dcity         dvcity
0403001211060111  *
040400121106     C                   if        city6 = 'APO   '
040500121106     C                   movel(P)  'AA'          dvst
040600121106     C                   movel(P)  '34001'       dvzip
040700121106     C                   movel(P)  *blanks       dvzip4
040800121106     C                   else
040900120906     C                   movel(P)  dstate        dvst
041000120906     C                   movel(P)  dzip5         dvzip
041100120906     C                   movel(P)  dzip4         dvzip4
041200121106     C                   endif
0413001211060111  *
041400120906     C                   movel     '0001'        dvcntr
0415001209060111  *
0416001303270111  *   Check to see if dep rec already exists
041700130327     C                   eval      ksubid = dvsubid
041800130327     C                   eval      kmfnam = dvmfnam
041900130327     C                   eval      kdob = dvdob
042000130730     C     dekey         chain     ddvelhwl                           43
042100130327     C                   if        *in43 = '0'
0422001303270107  *
042300130327     C                   if        dveffdt > ldveffdt
042400130327     C                   delete    ddvelr
042500130730     C                   write     ddvelhwr
042600130327     C                   endif
0427001303270107  *
042800130327     C                   else
042900130730     C                   write     ddvelhwr
0430000205170111  *
043100020517     C                   endif
0432001303270111  *
043300130327     C                   endif
0434000205170111  *
043500020517     C                   endsr
