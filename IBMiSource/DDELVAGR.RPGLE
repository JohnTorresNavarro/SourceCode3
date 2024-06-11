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
001100130808      *  rlj 05/08/2013 Use MCOV39 to get ENR(D) to see cov lvl chgs
001200130829      *  rlj 08/29/2013 Subtract 1 from term dates per CF
001300130906      *  rlj 09/06/2013 Remove recs w/ term dt prior to 6/6/13 per CF
001400140421      *  rlj 04/21/2014 Use first MCOV39 record for eff, trm dates
001500140501      *  rlj 05/01/2014 Remove recs w/ term dt prior to 12/1/13.
001600161011      *  rlj 10/11/2016 Remove recs w/ term dt prior to 12/1/14.
001700170207      *  rlj 02/07/2017 Chg sel criteria to Car Code = DVL.
001800170214      *  rlj 02/14/2017 Chg grp# and subloc for new account.
001900020402      *                                                                *
0020009102150018 F******************************************************************
0021000610240020 Fplnmstn1  IF   E           K DISK
0022000610240020 Fgrat25    IF   E           K DISK
0023000610240020 Fmcovl1    IF   E           K DISK
0024001308080020 Fmcov39    IF   E           K DISK    RENAME(MCOVR:MC39R)
0025000205240020 F                                     PREFIX(X)
0026000205170020 Fmember    IF   E           K DISK
0027000205170020 Fdepndc    IF   E           K DISK
0028000205170020 Fdcov      IF   E           K DISK
0029001303270020 Fddveligl  UF   E           K DISK    RENAME(DDVELIGR:DDVELR)
0030001303270020 F                                     PREFIX(L)
0031001303270020 Fddveligp  O    E             DISK
0032000810300029  *
0033000204260250 D                 DS
0034000610240251 D  group#                 1     15
0035000610240251 D    grp14                1      4
0036000610240251 D    grp58                5      8
0037001209060029  *
0038001209060250 D                 DS
0039001209060251 D  zip                    1      9  0
0040001209060251 D    zip5                 1      5
0041001209060251 D    zip4                 6      9
0042000810300029  *
0043001209060250 D                 DS
0044001209060251 D dzip                    1      9  0
0045001209060251 D   dzip5                 1      5
0046001209060251 D   dzip4                 6      9
0047001211060029  *
0048001211060250 D                 DS
0049001211060251 D dvcity                  1     30
0050001211060251 D   city6                 1      6
0051001209060029  *
0052000810300250 D                 DS
0053000810300251 D  kyid           S              1
0054000810300251 D  kydata         S             74    INZ(*BLANKS)
0055001412030251 D  dupmem         S              1
0056001203120251 D  dupem          S              1
0057000810300251 D  updtd          S              1
0058001211060251 D  todayx         S               D   DATFMT(*ISO)
0059001211060251 D  today8         S              8S 0
0060000610240029  *
0061000610240250 D                 DS
0062000610240251 D  datymd                 1      8  0
0063000610240251 D    ymdcc                1      2  0
0064000610240251 D    ymdyy                3      4  0
0065000205070251 D    ymdmd                5      8  0
0066000205170250 D                 DS
0067000205170251 D  mktrst                        3  0 INZ(419)
0068000205170251 D  mksub                         3  0 INZ(1)
0069000205170251 D  mkplan                        4    INZ('7000')
0070000205210251 D  cntspc                        2  0 INZ(0)
0071000205210251 D  cntkid                        2  0 INZ(0)
0072000205210251 D  savrat                        1    INZ(' ')
0073000205210251 D  todaa                         2  0
0074000610240251 D  kcarr                              LIKE(PCARR)
0075001209060251 D  svtyp                              LIKE(mcovtp)
0076001209140251 D  svpln                              LIKE(mcplan)
0077001209060251 D  svratc                             LIKE(dvratc)
0078001209140251 D  svsubl                             LIKE(dvsubl)
0079001303270251 D  ksubid                             LIKE(dvsubid)
0080001303270251 D  kmfnam                             LIKE(dvmfnam)
0081001303270251 D  kdob                               LIKE(dvdob)
0082001308080251 D  mbreff                             LIKE(dveffdt)
0083001303270251  *
0084000205210250 D                 DS
0085000205210251 D  ISOdate        S               D
0086000205210251 D  ISOnum         S              8  0
0087000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0088000205240251 D  enrdat         S              8  0
0089000205240251 D  trmdat         S              8  0
0090001308080251 D  date9          S              8  0 INZ(99999999)
0091001308080251  *
0092000205210250 D                 DS
0093000205310251 D  wrkdat8                1      8  0
0094000205310251 D   wrkda                 7      8  0
0095000205310250 D                 DS
0096000205310251 D  dftstrt                1      8  0
0097000205210251 D    strtda               7      8  0
0098000205210251 D  dftend                 9     16  0
0099000205210251 D    endda               15     16  0
0100000205210251 D  mdystrt               17     22  0
0101000205210251 D   strta                17     22
0102000205210251 D  mdyend                23     28  0
0103000205210251 D   enda                 23     28
010400020517      *
010500061024     C     grkey         klist
010600061024     C                   kfld                    pltrst
010700061024     C                   kfld                    plsub#
010800061024     C                   kfld                    plplan
010900061024      *
011000061024     C     mckey         klist
011100061024     C                   kfld                    mktrst
011200061024     C                   kfld                    mksub
011300061024     C                   kfld                    mkplan
011400020517      *
011500090917     C     xrkey         klist
011600090917     C                   kfld                    mctrst
011700090917     C                   kfld                    mcsub#
011800090917     C                   kfld                    acc#
011900090917      *
012000020517     C     dpkey         klist
012100090917     C                   kfld                    ssno
012200090917     C                   kfld                    dseq#
012300090917      *
012400130808     C     m39ky         klist
012500130808     C                   kfld                    mctrst
012600130808     C                   kfld                    mcsub#
012700130808     C                   kfld                    mcplan
012800130808     C                   kfld                    mcssno
012900130808     C                   kfld                    date9
013000130327      *
013100130327     C     dekey         klist
013200130327     C                   kfld                    ksubid
013300130327     C                   kfld                    kmfnam
013400130327     C                   kfld                    kdob
013500020517      *
013600020503      ******************************************************************************
0137001211060291  *   Preprocessing
0138001211060297 C                   movel     UDATE         todayx
0139001211060297 C                   movel     todayx        today8
0140001211060297  *
014100020517      *      MainLine
0142000204260111  *
0143001702140107  *      Loop thru PLNMST looking for Carrier = 'DVA'
014400170214     C                   eval      kcarr = 'DVA'
014500061024     C     kcarr         setll     plnmstn1
014600061024     C                   dou       *in23 = '1'
014700101228     C                   read      plnmstn1                               23
014800170214     C                   if        *in23 = '1' or PCARR > 'DVA'
014900101228     C                   leave
015000101228     C                   endif
015100210505     C                   if        PCARR = 'DVA' and sfadm <> 'Y'
0152000612120111  *
015300061024     C     grkey         chain     grat25                             24
015400061024     C                   if        *in24 = '0'
015500120906     C****               eval      rgrp# = grp14
015600120906     C*****              eval      rsubl = grp58
015700061024     C                   endif
0158001203060107  *      Debug shit
015900120306     C                   if        plplan = 'BADW' or plplan = 'BADZ'
016000120306     C                   eval      mcssno = mcssno
016100120306     C                   endif
0162000610240107  *      Loop thru MCOVL1 to locate all mbrs
016300061024     C     grkey         setll     mcovl1
016400061024     C                   dou       *in21 = '1'
016500061024     C     grkey         reade     mcovl1                                 21
016600061024     C                   if        *in21 = '0'
0167000205240107  *      If enroll date and term date are equal => bypass record
016800020524     C                   if        enrldt = candt
016900020524     C                   iter
017000020524     C                   endif
0171000810310107  *      Debug shit
017200140421     C                   if        mcssno = 228455219
017300081031     C                   eval      mcssno = mcssno
017400081031     C                   endif
0175000205240107  *
017600120906     C                   z-add     enrldt        enrdat
017700120906     C                   z-add     candt         trmdat
017800120906     C                   eval      svtyp = mcovtp
017900120914     C                   eval      svpln = mcplan
0180001209060111  *
018100020524     C                   exsr      bldmbr
0182001203120107  *     If member was duplicate - skip
018300141210     C                   if        dupmem = 'Y'
018400120312     C                   iter
018500120312     C                   endif
0186000610250107  *      Loop thru DCOV to locate all Delta dependents
018700020517     C     mcssno        setll     dcov
018800020517     C                   dou       *in22 = '1'
018900020517     C     mcssno        reade     dcov                                   22
019000020517     C                   if        *in22 = '0'
0191000206260107  *      If enroll date and term date are equal => bypass record
019200020524     C                   if        denrdt = ccandt
019300020524     C                   iter
019400020524     C                   endif
019500130808     C                   if        mcssno = ssno and dvplan = plplan
019600020517     C                   exsr      blddep
019700020517     C                   endif
019800020517     C                   else
019900020517     C                   leave
020000020517     C                   endif
020100020517     C                   enddo
020200020517     C                   endif
020300020517     C                   enddo
020400061024     C                   endif
020500061024     C                   enddo
020600120906      *
020700020517     C                   movel     '1'           *inlr
020800020517     C                   return
0209000204020107  ********************************************************************************
0210000204020107  *
0211001209060107  *     BLDMBR - Build Member record
0212000204020107  *
0213000204020107  ********************************************************************************
021400020517     C     bldmbr        begsr
021500120906      *
021600020521     C                   eval      cntspc = 0
021700020521     C                   eval      cntkid = 0
021800130327     C                   eval      dupmem = 'N'
021900020517     C     mcssno        chain     member                             31
022000020517     C                   if        *in31 = '0'
0221001412030107  *       Build Member rec
022200120906     C                   clear                   ddveligr
022300120906     C                   movel     mcssno        dvsubid
022400170214     C                   eval      dvgrp# = '000500353'
022500120914      *
022600170214     C                   eval      dvsubl = '00001111'
022700170214     C                   eval      svsubl = dvsubl
022800170214      *
022900170214     C********           select
023000170214     C**                 when      svpln = 'EALJ'
023100170214     C**                 eval      dvsubl = '00001111'
023200170214     C**                 when      svpln = 'EALK'
023300170214     C**                 eval      dvsubl = '00001099'
023400170214     C**                 when      svpln = 'EALL'
023500170214     C**                 eval      dvsubl = '00002111'
023600170214     C**                 when      svpln = 'EALM'
023700170214     C**                 eval      dvsubl = '00002099'
023800170214     C**                 endsl
023900170214     C********           eval      svsubl = dvsubl
024000120914      *
024100120913     C                   eval      dvdiv# = '0000'
0242001209060107  *     debug shit
024300120906     C                   if        mcssno = 218867574
024400120906     C                   eval      mcssno = mcssno
024500120906     C                   endif
0246001209060107  *
0247001308080107  *      Loop thru MCOV39 to locate all coverages for Mbr for TK - Delta
024800130808     C                   eval      svtyp = *blanks
024900130808     C     m39ky         setll     mcov39
025000130808     C                   dou       *in28 = '1'
025100130808     C                   read      mcov39                                 28
025200120906     C                   if        *in28 = '0'
025300130808     C****               if        xenrldt = enrdat and xcandt = trmdat
025400130808     C****               iter
025500130808     C****               endif
0256001404210107  *      Check mbr SSN
025700140421     C                   if        mcssno <> xmcssno
025800140421     C                   leave
025900140421     C                   endif
0260001209140107  *      If enroll date and term date are equal => bypass record
026100120914     C                   if        xenrldt = xcandt
026200120914     C                   iter
026300120914     C                   endif
0264001404210107  *      Set values from most recent MCOV record
026500130808     C                   eval      svtyp = xmcovtp
026600120906     C                   z-add     xenrldt       enrdat
026700120906     C                   z-add     xcandt        trmdat
026800140421     C                   leave
026900140421      *
027000120906     C                   endif
027100120906     C                   enddo
027200120906      *        Set cov type
027300120906     C                   eval      dvratc = '0004'
027400120906     C                   select
027500120906      *
027600120906     C                   when      svtyp = 'TIN'
027700120906     C                   eval      dvratc = '0001'
027800120906     C                   when      svtyp = 'THW'
027900120906     C                   eval      dvratc = '0002'
028000120906     C                   when      svtyp = 'TFA'
028100120906     C                   eval      dvratc = '0003'
028200120906     C                   when      svtyp = 'TPC'
028300120906     C                   eval      dvratc = '0005'
028400120906     C                   when      svtyp = 'TP2'
028500120906     C                   eval      dvratc = '0006'
028600120906      *
028700120906     C                   endsl
028800120906      *
028900120906     C                   eval      svratc = dvratc
029000120906      *
029100120906     C                   movel     enrdat        dveffdt
029200130808     C                   eval      mbreff = dveffdt
0293001308290111  *
029400170119     C                   if        trmdat < 20161201 and trmdat <> 0
029500130906     C                   leavesr
029600130906     C                   endif
0297001309060111  *
029800120906     C                   movel     trmdat        dvtrmdt
029900130829     C                   if        trmdat <> 0
030000130829     C                   movel     trmdat        todayx
030100130829     C                   subdur    1:*D          todayx
030200130829     C                   movel     todayx        today8
030300130829     C                   movel     today8        dvtrmdt
030400130829     C                   endif
0305001308290111  *
030600120906     C                   movel     empdt         dvhirdt
030700120906     C                   eval      dvrelcd = '01'
030800120906     C                   movel(P)  mlname        dvmlnam
030900120906     C                   movel(P)  mfname        dvmfnam
031000120906     C                   movel(P)  mmi           dvmmnam
031100120906     C                   movel     birth         dvdob
031200120906     C                   if        sex = 'M'
031300120906     C                   movel     '01'          dvsex
031400120906     C                   else
031500120906     C                   movel     '02'          dvsex
031600120906     C                   endif
031700120906     C                   movel(P)  addr1         dvaddr1
031800120906     C                   movel(P)  addr2         dvaddr2
031900120906     C                   movel(P)  city          dvcity
0320001211060111  *
032100121106     C                   if        city6 = 'APO   '
032200121106     C                   movel(P)  'AA'          dvst
032300121106     C                   movel(P)  '34001'       dvzip
032400121106     C                   movel(P)  *blanks       dvzip4
032500121106     C                   else
032600121106     C                   movel(P)  state         dvst
032700121106     C                   movel(P)  zip5          dvzip
032800121106     C                   movel(P)  zip4          dvzip4
032900121106     C                   endif
0330001211060111  *
033100120906     C                   movel     '0001'        dvcntr
0332001209060111  *
033300120906     C                   endif
0334001303270111  *   Check to see if mbr rec already exists
033500130327     C                   eval      ksubid = dvsubid
033600130327     C                   eval      kmfnam = dvmfnam
033700130327     C                   eval      kdob = dvdob
033800130327     C     dekey         chain     ddveligl                           43
033900130327     C                   if        *in43 = '0'
0340001303270107  *
034100130327     C                   if        dveffdt > ldveffdt
034200130327     C                   delete    ddvelr
034300130327     C                   write     ddveligr
034400130327     C                   endif
0345001303270107  *
034600130327     C                   else
034700120906     C                   write     ddveligr
034800130327     C                   endif
0349000205170111  *
035000020517     C                   endsr
0351000205170107  ********************************************************************************
0352000205170107  *
0353001209060107  *     BLDDEP - Build Record for Dependent data
0354000205170107  *
0355000205170107  ********************************************************************************
035600020517     C     blddep        begsr
035700020517     C     dpkey         chain     depndc                             33
035800020517     C                   if        *in33 = '0'
0359001209060107  *       Build Dep Rec
036000120906     C                   clear                   ddveligr
036100120906     C                   movel     mcssno        dvsubid
036200170214     C                   eval      dvgrp# = '000500353'
036300120914     C                   eval      dvsubl = svsubl
036400120914     C                   eval      dvdiv# = '0000'
036500120906     C                   eval      dvratc = svratc
036600120906     C                   movel     denrdt        dveffdt
036700130808      *
036800130808     C                   if        mbreff > dveffdt
036900130808     C                   eval      dveffdt = mbreff
037000130808     C                   endif
037100130808      *
037200170119     C                   if        ccandt < 20161201 and ccandt <> 0
037300130906     C                   leavesr
037400130906     C                   endif
0375001309060111  *
037600120906     C                   movel     ccandt        dvtrmdt
037700130829     C                   if        ccandt <> 0
037800130829     C                   movel     ccandt        todayx
037900130829     C                   subdur    1:*D          todayx
038000130829     C                   movel     todayx        today8
038100130829     C                   movel     today8        dvtrmdt
038200130829     C                   endif
038300140604      *
038400140604     C                   if        dveffdt > dvtrmdt and ccandt <> 0
038500140604     C                   leavesr
038600140604     C                   endif
038700120906      *
038800120906     C                   if        drelcd = 'RHU' or drelcd = 'RWI'
038900120906     C                   eval      dvrelcd = '02'
039000120906     C                   else
039100120906     C                   if        drelcd = 'RSO' or drelcd = 'RDA'
039200120906     C                   eval      dvrelcd = '03'
039300120906     C                   else
039400120906     C                   eval      dvrelcd = '04'
039500120906     C                   endif
039600120906     C                   endif
039700120906      *
039800120906     C                   movel(P)  dlname        dvmlnam
039900120906     C                   movel(P)  dfname        dvmfnam
040000120906     C                   movel(P)  dmi           dvmmnam
040100120906     C                   movel     dbirth        dvdob
040200120906     C                   if        dsex = 'M'
040300120906     C                   movel     '01'          dvsex
040400120906     C                   else
040500120906     C                   movel     '02'          dvsex
040600120906     C                   endif
040700120906     C                   movel(P)  daddr1        dvaddr1
040800120906     C                   movel(P)  daddr2        dvaddr2
040900120906     C                   movel(P)  dcity         dvcity
0410001211060111  *
041100121106     C                   if        city6 = 'APO   '
041200121106     C                   movel(P)  'AA'          dvst
041300121106     C                   movel(P)  '34001'       dvzip
041400121106     C                   movel(P)  *blanks       dvzip4
041500121106     C                   else
041600120906     C                   movel(P)  dstate        dvst
041700120906     C                   movel(P)  dzip5         dvzip
041800120906     C                   movel(P)  dzip4         dvzip4
041900121106     C                   endif
0420001211060111  *
042100120906     C                   movel     '0001'        dvcntr
0422001209060111  *
0423001303270111  *   Check to see if dep rec already exists
042400130327     C                   eval      ksubid = dvsubid
042500130327     C                   eval      kmfnam = dvmfnam
042600130327     C                   eval      kdob = dvdob
042700130327     C     dekey         chain     ddveligl                           43
042800130327     C                   if        *in43 = '0'
0429001303270107  *
043000130327     C                   if        dveffdt > ldveffdt
043100130327     C                   delete    ddvelr
043200130327     C                   write     ddveligr
043300130327     C                   endif
0434001303270107  *
043500130327     C                   else
043600120906     C                   write     ddveligr
0437000205170111  *
043800020517     C                   endif
0439001303270111  *
044000130327     C                   endif
0441000205170111  *
044200020517     C                   endsr
