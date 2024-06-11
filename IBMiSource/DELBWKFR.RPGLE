0001000204020002  *****************************************************************************
000200131025      * DELBWKFR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400131101      *            DATE - 10/2013                                                 *
000500131025      *  DESCRIPTION - Build Delta Dental PA work File                            *
000600020426      *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900140820      *  rlj 08/20/2014 Bypass 591-007-0514 per Brandon Scarfield
001000140826      *  rlj 08/26/2014 Bypass 591-007-0471 per Deb Clark
001100170208      *  rlj 02/08/2017 Bypass 905-001-0306 per Deb Clark
001200170424      *  rlj 04/24/2017 Bypass 590-007-0010 per Deb Clark
001300170424      *  rlj 04/24/2017 Bypass 590-008-0002 per Deb Clark
001400171204      *  rlj 12/04/2017 Bypass 900-001-0083 per Deb Clark
001500180207      *  rlj 02/07/2018 Bypass 590-007-0019 per Deb Clark
001600180709      *  rlj 07/09/2018 Bypass 905-001-0646 per Deb Clark
001700191121      *TEMP*****%%%%!!!!!!!                                            *
001800191121      *  rlj 07/09/2018 Bypass 003-001-2182 per Ron Maas
001900191121      *   jt 11/21/2019 Eliminated hardcoded bypass values and using file
002000191121      *                 to check.
002100191121      *                                                                *
0022001311010018  ******************************************************************
0023000610240020 Fplnmstn1  IF   E           K DISK
0024000610240020 Fgrat25    IF   E           K DISK
0025002204060020 Fmember    IF   E           K DISK
0026002204060020 Fmcovl1    IF   E           K DISK
0027000205170020 Fdcov      IF   E           K DISK
0028001310250020 Fdelwrkp   UF A E           K DISK
002900191121
003000191121     ftransoff1 if   e           k disk    rename(transr:transFile)
0031000810300029  *
003200191121     d iterYN          s              1
003300191121     d carrier         s              2  0
003400191121
0035000810300250 D                 DS
0036001309260251 D  raty           S              1
0037001309260251 D  kyid           S              1
0038001203120251 D  dupmem         S              1
0039001203120251 D  dupem          S              1
0040000810300251 D  updtd          S              1
0041000205170250 D                 DS
0042000205170251 D  mktrst                        3  0 INZ(419)
0043000205170251 D  mksub                         3  0 INZ(1)
0044000205170251 D  mkplan                        4    INZ('7000')
0045000205210251 D  cntspc                        2  0 INZ(0)
0046000205210251 D  cntkid                        2  0 INZ(0)
0047000205210251 D  savrat                        1    INZ(' ')
0048000205210251 D  todaa                         2  0
0049000610240251 D  kcarr                              LIKE(PCARR)
0050002204060251 D  svacc                              LIKE(acc#)
0051000205210250 D                 DS
0052000205210251 D  ISOdate        S               D
0053000205210251 D  ISOnum         S              8  0
0054000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0055001310290251 D  date30         S              8  0
0056000205210250 D                 DS
0057000205310251 D  wrkdat8                1      8  0
0058000205310251 D   wrkda                 7      8  0
0059000205310250 D                 DS
0060000205310251 D  dftstrt                1      8  0
0061000205210251 D    strtda               7      8  0
0062000205210251 D  dftend                 9     16  0
0063000205210251 D    endda               15     16  0
0064000205210251 D  mdystrt               17     22  0
0065000205210251 D   strta                17     22
0066000205210251 D  mdyend                23     28  0
0067000205210251 D   enda                 23     28
006800020517      *
006900061024     C     grkey         klist
007000061024     C                   kfld                    pltrst
007100061024     C                   kfld                    plsub#
007200061024     C                   kfld                    plplan
007300061024      *
007400061024     C     mckey         klist
007500061024     C                   kfld                    mktrst
007600061024     C                   kfld                    mksub
007700061024     C                   kfld                    mkplan
007800020517      *
007900090917     C     xrkey         klist
008000090917     C                   kfld                    mctrst
008100090917     C                   kfld                    mcsub#
008200090917     C                   kfld                    acc#
008300090917      *
008400020517     C     dpkey         klist
008500090917     C                   kfld                    ssno
008600090917     C                   kfld                    dseq#
008700090917      *
008800020524     C     m38ky         klist
008900090917     C                   kfld                    mcssno
009000090917     C                   kfld                    mdseq#
009100090917     C                   kfld                    mctrst
009200020524     C                   kfld                    mcsub#
009300020524     C                   kfld                    mcplan
009400081030      *
009500131025     C     dwkey         klist
009600131025     C                   kfld                    dkssn             9 0
009700131025     C                   kfld                    dkseq             2 0
009800020517      *
009900020503      ******************************************************************************
010000020517      *      MainLine
010100191121        carrier = 18;
010200191121
0103001310291304  *         Get date 30 days out
010400131029     C                   move      UDATE         ISOdate
010500131029     C                   adddur    30:*D         ISOdate
010600131029     C                   move      ISOdate       date30
0107000204260111  *
0108001012280107  *      Loop thru PLNMST looking for Carrier = 'DEA', 'DEM' or 'DE1'
010900101228     C                   eval      kcarr = 'DEA'
011000061024     C     kcarr         setll     plnmstn1
011100061024     C                   dou       *in23 = '1'
011200101228     C                   read      plnmstn1                               23
011300101228     C                   if        *in23 = '1' or PCARR > 'DE1'
011400101228     C                   leave
011500101228     C                   endif
0116002105050111  *
011700210505     C                   if        sfadm = 'Y'
011800210505     C                   iter
011900210505     C                   endif
0120002105050111  *
012100101228     C                   if        PCARR = 'DEA' or pcarr = 'DEM' or
012200101228     C                             PCARR = 'DE1'
0123000612120111  *
0124001310010107  *        Debug shit
012500131001     C                   if        pltrst = 597 and
012600131001     C                             plsub# = 1
012700131001     C                   eval      plplan = plplan
012800131001     C                   endif
0129001310250107  *
013000130926     C                   eval      raty = 'N'
0131001309260107  *      Loop thru MCOVL1 to locate all mbrs
013200130918     C     grkey         setll     grat25
013300130918     C                   dou       *in24 = '1'
013400130918     C     grkey         reade     grat25                                 24
013500131024     C                   if        *in24 = '0'
0136001310240107  *
013700130926     C                   eval      raty = 'Y'
013800130918     C                   leave
013900061024     C                   endif
014000130918     C                   enddo
0141001203060107  *      Debug shit
014200120306     C                   if        plplan = 'BADW' or plplan = 'BADZ'
014300120306     C                   eval      mcssno = mcssno
014400120306     C                   endif
0145000610240111  *
0146000610240107  *      Loop thru MCOVL1 to locate all mbrs
014700061024     C     grkey         setll     mcovl1
014800061024     C                   dou       *in21 = '1'
014900061024     C     grkey         reade     mcovl1                                 21
015000061024     C                   if        *in21 = '0'
015100191121
015200191121       exsr checkTransmission;
015300191121       if iterYN = 'Y';
015400191121        iter;
015500191121       endif;
0156001408200107  *      Bypass 591-007-0514 per Brandon 8/20/14
015700191121     C****               if        mctrst = 591 and mcsub# = 7 and
015800191121     C****                         acc# = 514
015900191121     C****               iter
016000191121     C****               endif
0161001408260107  *      Bypass 591-007-0471 per D Clark 8/26/14
016200191121     C****               if        mctrst = 591 and mcsub# = 7 and
016300191121     C****                         acc# = 471
016400191121     C****               iter
016500191121     C****               endif
0166001702080107  *      Bypass 905-001-0306 per D Clark 2/08/17
016700191121     C****               if        mctrst = 905 and mcsub# = 1 and
016800191121     C****                         acc# = 306
016900191121     C****               iter
017000191121     C****               endif
0171001704240107  *      Bypass 590-007-0010 per D Clark 4/24/17
017200191121     C****               if        mctrst = 590 and mcsub# = 7 and
017300191121     C****                         acc# = 10
017400191121     C****               iter
017500191121     C****               endif
0176001704240107  *      Bypass 590-008-0002 per D Clark 4/24/17
017700191121     C****               if        mctrst = 590 and mcsub# = 8 and
017800191121     C****                         acc# = 2
017900191121     C****               iter
018000191121     C****               endif
0181001712040107  *      Bypass 900-001-0083 per D Clark 12/4/17
018200191121     C****               if        mctrst = 900 and mcsub# = 1 and
018300191121     C****                         acc# = 83
018400191121     C****               iter
018500191121     C****               endif
0186001802070107  *      Bypass 590-007-0019 per D Clark 02/7/18
018700191121     C****               if        mctrst = 590 and mcsub# = 7 and
018800191121     C****                         acc# = 19
018900191121     C****               iter
019000191121     C****               endif
0191001807090107  *      Bypass 905-001-0646 per D Clark 07/9/18
019200191121     C****               if        mctrst = 905 and mcsub# = 1 and
019300191121     C****                         acc# = 646
019400191121     C****               iter
019500191121     C****               endif
0196001911210107  *  TEMP !!!!
0197001911210107  *      Bypass 003-001-2182 per D Clark 07/9/18
019800191121     C****               if        mctrst = 003 and mcsub# = 1 and
019900191121     C****                         acc# = 2182
020000191121     C****               iter
020100191121     C****               endif
0202001408200107  *      Debug shit
020300150925     C                   if        mcssno = 218841866
020400140820     C                   eval      mcssno = mcssno
020500140820     C                   endif
020600141006     C                   if        mcssno = 168545044 or
020700141006     C                             mcssno = 176541879
020800131029     C                   eval      mcssno = mcssno
020900131029     C                   endif
0210000205240107  *      If enroll date and term date are equal => bypass record
021100020524     C                   if        enrldt = candt
021200020524     C                   iter
021300020524     C                   endif
0214001310290107  *      If enroll date is over 30 days out => bypass record
021500131029     C                   if        enrldt > date30
021600131029     C                   iter
021700131029     C                   endif
0218000205240107  *
021900020524     C                   exsr      bldmbr
0220000610250107  *      Loop thru DCOV to locate all Delta dependents
022100020517     C     mcssno        setll     dcov
022200020517     C                   dou       *in22 = '1'
022300020517     C     mcssno        reade     dcov                                   22
022400020517     C                   if        *in22 = '0'
0225000206260107  *      If enroll date and term date are equal => bypass record
022600020524     C                   if        denrdt = ccandt
022700020524     C                   iter
022800020524     C                   endif
0229001310290107  *      If enroll date is over 30 days out => bypass record
023000131029     C                   if        denrdt > date30
023100131029     C                   iter
023200131029     C                   endif
0233001310290107  *
0234001310240107  *      If term date is prior to 7/1/2013 => bypass record
023500131025     C*******            if        ccandt <> 0 and ccandt < 20130701
023600131025     C***                iter
023700131025     C********           endif
0238001310240107  *
023900061025     C                   if        mcssno = ssno and dvplan = plplan
024000020517     C                   exsr      blddep
024100020517     C                   endif
024200020517     C                   else
024300020517     C                   leave
024400020517     C                   endif
024500020517     C                   enddo
024600020517     C                   endif
024700020517     C                   enddo
024800061024     C                   endif
024900061024     C                   enddo
025000131025      *
025100020517     C                   movel     '1'           *inlr
025200020517     C                   return
0253000204020107  ********************************************************************************
0254000204020107  *
0255001310250107  *     BLDMBR - Build Record
0256000204020107  *
0257000204020107  ********************************************************************************
025800020517     C     bldmbr        begsr
0259001310250107  *     debug shit
026000131025     C                   if        mcssno = 203368142
026100131025     C                   eval      mcssno = mcssno
026200131025     C                   endif
0263001310250107  *
0264001310250111  *        See if rec already exists - if so,update
026500131025     C                   eval      dkssn = mcssno
026600131025     C                   eval      dkseq = 0
026700131025     C     dwkey         chain     delwrkp                            33
026800131025     C                   if        *in33 = '0'
0269001310250111  *          See if updates are needed
027000131029     C                   if        candt = 0 or
027100131029     C                             (dwterm <> 0 and candt > dwterm and
027200131029     C                             enrldt > dweff)
027300131025     C                   eval      dwplan = mcplan
027400131025     C                   eval      dwgrp# = group#
027500131025     C                   eval      dwterm = candt
027600131025     C                   eval      dwcovt = mcovtp
027700131025     C                   update    delwrkr
027800131025     C                   leavesr
027900131025     C                   endif
0280001310250107  *
028100131025     C                   if        enrldt < dweff
028200131025     C                   eval      dweff = enrldt
028300131025     C                   update    delwrkr
028400131025     C                   leavesr
028500131025     C                   endif
0286001310250107  *
028700131025     C                   else
0288001310250107  *          No existing record - create new
028900131025     C                   clear                   delwrkr
029000131025     C                   eval      dwssn = mcssno
029100131025     C                   eval      dwseq# = 0
029200131025     C                   eval      dwtrst = mctrst
029300131025     C                   eval      dwsub# = mcsub#
029400131025     C                   eval      dwacct = acc#
029500220406     C                   eval      svacc = acc#
029600131025     C                   eval      dwplan = mcplan
029700131025     C                   eval      dwgrp# = group#
029800131025     C                   eval      dweff = enrldt
029900131025     C                   eval      dwterm = candt
030000131025     C                   eval      dwcovt = mcovtp
030100131025     C                   write     delwrkr
0302001310250107  *
030300131025     C                   endif
0304000205170111  *
030500020517     C                   endsr
0306000205170107  ********************************************************************************
0307000205170107  *
0308000205170107  *     BLDDEP - Build Record ID = '2' - Dependent data
0309000205170107  *
0310000205170107  ********************************************************************************
031100020517     C     blddep        begsr
0312001310250107  *
0313001310250111  *        See if rec already exists - if so,update
031400131025     C                   eval      dkssn = ssno
031500131025     C                   eval      dkseq = dseq#
031600131025     C     dwkey         chain     delwrkp                            33
031700131025     C                   if        *in33 = '0'
0318001310250111  *          See if updates are needed
031900131029     C                   if        ccandt = 0 or
032000131029     C                             (dwterm <> 0 and ccandt > dwterm and
032100131029     C                             denrdt > dweff)
032200131025     C                   eval      dwplan = dvplan
032300131025     C                   eval      dwgrp# = group#
032400131025     C                   eval      dwterm = ccandt
032500131025     C                   eval      dwcovt = mcovtp
032600131025     C                   update    delwrkr
032700131025     C                   leavesr
032800131025     C                   endif
0329001310250107  *
033000131025     C                   if        denrdt < dweff
033100131025     C                   eval      dweff = denrdt
033200131025     C                   update    delwrkr
033300131025     C                   leavesr
033400131025     C                   endif
0335001310250107  *
033600131025     C                   else
0337001310250107  *          No existing record - create new
033800131025     C                   clear                   delwrkr
033900131025     C                   eval      dwssn = ssno
034000131025     C                   eval      dwseq# = dseq#
034100131025     C                   eval      dwtrst = dvtrst
034200131025     C                   eval      dwsub# = dvsub#
034300220406     C                   eval      dwacct = svacc
034400131025     C                   eval      dwplan = dvplan
034500131025     C                   eval      dwgrp# = group#
034600131025     C                   eval      dweff = denrdt
034700131025     C                   eval      dwterm = ccandt
034800131025     C                   write     delwrkr
0349001310250107  *
035000131025     C                   endif
0351001310250111  *
035200131025     C                   endsr
035300191121
035400191121       //===================================================================
035500191121       // check for transmission
035600191121       //===================================================================
035700191121
035800191121       begsr checkTransmission;
035900191121
036000191121        iterYN = 'N';
036100191121
036200191121        chain (carrier : mctrst : mcsub# : acc#) transFile;
036300191121        if %found;
036400191121         iterYN = 'Y';
036500191121        endif;
036600191121
036700191121       endsr;
036800191121
036900191121       //===================================================================
