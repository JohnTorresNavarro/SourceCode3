0001001311060002  *****************************************************************************
000200130912      * DDPBLDGR   Group Benefit Services                                         *
000300130926      *            WRITTEN BY - R.L.J.                                            *
000400131101      *            DATE - 11/2013                                                 *
000500131101      *  DESCRIPTION - Bld Delta Dental PA - SFL file from GBS wrk file           *
000600130926      *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900141210      *  rlj 12/05/2014 Bypass Goodwill recs per Stacey H.
001000141223      *  rlj 12/23/2014 Allow Goodwill recs
001100141230      *  rlj 12/30/2014 Bypass Oakworks recs per C. Gibbons at Delta
001200020402      *                                                                *
0013009102150018 F******************************************************************
0014001311010020 Fdelwrkp   IF   E           K DISK
0015000205170020 Fmember    IF   E           K DISK
0016000205170020 Fdepndc    IF   E           K DISK
0017001311040020 Fddelgsxl  IF   E           K DISK
0018001311010020  *
0019001311010020 Fddgtrmp   UF A E           K DISK
0020001311010020 Fddghdrp   O    E             DISK
0021001311010020 Fddgeligp  O    E             DISK
0022001311010020 Fddgtrlp   O    E             DISK
0023001504070020 Fddggrpp   UF A E           K DISK
002400130912      *
0025001311010250 D                 DS
0026001311010251 D  dwgrp#                 1     15
0027001311010251 D    grp14                1      4
0028001311010251 D    grp15                1      5
0029001311010251 D    grp18                1      8
0030001311010251 D    grp110               1     10
0031001311010251 D    grp58                5      8
0032001311040251 D    grp610               6     10
0033001311040251 D    grp10               10     10
0034001311010029  *
0035001309120250 D                 DS
0036001311040251 D  dehphon                1     14
0037001311040251 D   dphn10                1     10
0038002003180029  *
0039002003180250 D                 DS
0040002003180251 D  addr1                  1     30
0041002003180251 D   addr17                1      7
0042002003180029  *
0043002003180250 D                 DS
0044002003180251 D  city                   1     15
0045002003180251 D   city4                 1      4
0046002003180029  *
0047002003180250 D                 DS
0048002003180251 D  wkzip                  1      9
0049002003180251 D   wkzip5                1      5
0050002003180251 D   wkzip4                6      9
0051002003180029  *
0052002003180250 D                 DS
0053002003180251 D  dhcrtm                 1      6
0054001311040251 D  xhcrtm                 1      6  0
005500200318      *
0056002003180250 D                 DS
0057002003180251 D  dhcrdt                 1      8
0058002003180251 D  xhcrdt                 1      8  0
005900200318      *
0060002003180250 D                 DS
0061002003180251 D  ISOdate        S               D
0062000205210251 D  ISOnum         S              8  0
0063001504070251 D  ISOtda         S              8  0
0064000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0065000205240251 D  enrdat         S              8  0
0066000205240251 D  trmdat         S              8  0
0067001311010251 D  mindate        S              8  0
0068001311040251 D  reccnt         S              7  0 INZ(2)
0069001311040251 D  gxkey          S             10
0070001311060251 D  svgrp          S                   LIKE(degrp#)
0071001311060251 D  svdiv          S                   LIKE(dediv#)
0072001311060251 D  svtrmdt        S                   LIKE(detrmdt)
007300131101      *
0074000205210250 D                 DS
0075000205310251 D  wrkdat8                1      8  0
0076000205310251 D   wrkda                 7      8  0
007700020517      *
007800131101     C     tmkey         klist
007900131101     C                   kfld                    degrp#
008000131101     C                   kfld                    dediv#
008100131101     C                   kfld                    desubid
008200131101     C                   kfld                    demssn
008300131101     C                   kfld                    demlnam
008400131101     C                   kfld                    demfnam
008500131101     C                   kfld                    detrmdt
008600090917      *
008700020517     C     dpkey         klist
008800131101     C                   kfld                    dwssn
008900131101     C                   kfld                    dwseq#
009000150407      *
009100150407     C     gpkey         klist
009200150407     C                   kfld                    ktrst             3 0
009300150407     C                   kfld                    ksub              3 0
009400150407     C                   kfld                    kacct             4 0
009500150407     C                   kfld                    degrp#
009600150407     C                   kfld                    dediv#
009700020503      ******************************************************************************
009800020517      *      MainLine
0099001311011304  *         Calculate cutoff dates
010000131101     C                   move      UDATE         ISOdate
010100131101     C                   move      ISOdate       ISOnum
010200150407     C                   move      ISOnum        ISOtda
010300131119     C                   subdur    60:*D         ISOdate
010400131101     C                   move      ISOdate       mindate
0105001309121304  *         Build Header Record
010600130912     C                   clear                   ddghdrr
0107001309120297 C                   eval      dhrctp = '10'
0108001309120297 C                   movel     '15591'       dhgrp#
0109001311190297 C                   eval      dhport = 'P'
011000130912     C                   eval      xhcrdt = %int(%char(%date : *iso0))
011100130912     C                   time                    xhcrtm
0112001311010297 C                   write     ddghdrr
0113001311010111  *          Read Work file to create Detail recs
0114001311010107  *
011500131101     C                   dou       *in23 = '1'
011600131101     C                   read      delwrkp                                23
011700131101     C                   if        *in23 = '1'
011800131101     C                   leave
011900131101     C                   endif
0120001412230111  ***        Bypass Goodwill recs - Removed per Delta instructions
012100141230     C********           if        grp110 = '7853900001'
012200141230     C***                iter
012300141230     C********           endif
0124001412300111  *          Bypass Oakworks recs - per Delta instructions
012500141230     C                   if        grp15 = '09449'
012600141230     C                   iter
012700141230     C                   endif
0128001311010111  *       If term date older than 7/1/2013 - bypass rec
012900131119     C                   if        dwterm <> 0 and dwterm < mindate
013000131119     C*******            if        dwterm <> 0 and dwterm < 20131101
013100131101     C                   iter
013200131101     C                   endif
0133001311010111  *         Member Record?
013400131101     C                   if        dwseq# = 0
0135001311010111  *
013600131101     C                   exsr      bldmbr
013700131101     C                   else
0138001311010111  *
013900131101     C                   exsr      blddep
0140001311010111  *
014100131101     C                   endif
014200131101     C                   enddo
014300131101     C                   exsr      bldtrl
014400131101     C                   movel     '1'           *inlr
014500131101     C                   return
0146000204260111  *
0147000204020107  ********************************************************************************
0148000204020107  *
0149001309120107  *     BLDMBR - Build Record - Member data
0150000204020107  *
0151000204020107  ********************************************************************************
015200020517     C     bldmbr        begsr
015300130912     C                   clear                   ddgeligr
015400131101     C     dwssn         chain     member                             31
015500020517     C                   if        *in31 = '0'
0156001309120107  *       Build Member Record
015700130912      *
015800130912     C                   movel     '30'          derctp
015900131104      *       Chk group# for 10 digits
016000131104     C                   if        grp10 = ' '
016100131104     C                   movel(P)  grp18         gxkey
016200131104     C     gxkey         chain     ddelgsxl                           52
016300131104     C                   if        *in52 = '0'
016400131104     C                   movel(P)  dx10gs        dwgrp#
016500131104     C                   else
016600131104     C                   eval      dwgrp# = dwgrp#
016700131104     C                   endif
016800131104     C                   endif
016900130912      *
017000131104     C                   movel(P)  grp15         degrp#
017100131104     C                   movel(P)  grp610        dediv#
017200131106      *
017300131106     C                   eval      svgrp = degrp#
017400131106     C                   eval      svdiv = dediv#
017500130912      *
017600131106     C                   if        degrp# = '15543' and dediv# = '00001' or
017700131106     C                             degrp# = '15543' and dediv# = '90001' or
017800131106     C                             degrp# = '97523' and dediv# = '04092'
017900131106     C                   leavesr
018000131106     C                   endif
018100131106      *
018200131106     C********           movel     empdt         dehrdt
018300131106     C                   movel     *blanks       dehrdt
018400130912     C                   movel(P)  mbssno        desubid
018500130912     C                   movel(P)  mbssno        demssn
018600130912     C                   movel     mlname        demlnam
018700130912     C                   movel     mfname        demfnam
018800130912     C                   movel     mmi           demmnam
018900130912     C                   move      sex           desex
019000130912     C                   movel     birth         demdob
019100130912     C                   movel     '10'          derelc
0192001311060107  *
0193001311060296 C                   If        addr17 <> 'UNKNOWN'
019400130912    *C                   movel(P)  addr1         deaddr1
019500131106     C                   endif                                                  *in62 = '0'
0196001311060107  *
019700130912    *C                   movel(P)  addr2         deaddr2
0198001309120107  *
0199001309120296 C                   If        deaddr1 = *blanks and deaddr2 <> *blanks
020000130912     C                   movel(P)  deaddr2       deaddr1
020100130912     C                   movel     *blanks       deaddr1
020200130912     C                   endif                                                  *in62 = '0'
0203001309120107  *
0204001311060296 C                   If        city4  <> 'XXXX'
020500130912     C                   movel     city          decity
020600131106     C                   endif                                                  *in62 = '0'
0207001311060107  *
0208001311060296 C                   If        state  <> 'XX'
020900130912     C                   move      state         dest
021000131106     C                   endif                                                  *in62 = '0'
0211001311040107  *
021200131104     C                   movel     zip           wkzip
021300131104     C                   if        wkzip4 = '0000'
021400131104     C                   movel     *blanks       wkzip4
021500131104     C                   endif
021600131106     C                   if        wkzip5 = '00000'
021700131106     C                   movel     *blanks       wkzip5
021800131106     C                   endif
021900131104     C                   movel     wkzip         dezip
0220001311040107  *
022100131104     C                   if        area <> 0 and phone <> 0
022200131104     C                   movel     area          dphn10
022300131104     C                   move      phone         dphn10
022400131104     C                   endif
0225001311060107  *
022600131106     C                   if        dweff < 20110101
022700131106     C                   eval      dweff = 20110101
022800131106     C                   endif
022900131106      *
023000131106     C                   if        degrp# = '10893' and dediv# = '09999' and
023100131106     C                             dweff < 20130730
023200131106     C                   eval      dweff = 20130730
023300131106     C                   endif
0234001311060107  *
023500131101     C                   movel     dweff         deeffdt
023600131101     C                   movel     dwterm        detrmdt
0237001311010107  *
023800131104     C                   if        dwterm <> 0
023900131104     C                   move      dwterm        ISOdate
024000131104     C                   subdur    1:*D          ISOdate
024100171130     C                   move      ISOdate       ISOnum
024200171130     C                   move      ISOnum        detrmdt
024300171130     C                   else
024400171130     C                   eval      detrmdt = *blanks
024500171130     C                   endif
0246001711300107  *
024700171130     C                   eval      svtrmdt = detrmdt
0248001711300107  *
024900171130     C                   if        detrmdt <> *blanks
0250001711300107  *
025100171130     C     tmkey         chain     ddgtrmp                            41
025200171130     C                   if        *in41 = '0'
025300171130     C                   leavesr
025400171130     C                   endif
025500131101      *
025600131101     C                   eval      dtgrp# = degrp#
025700131101     C                   eval      dtdiv# = dediv#
025800131101     C                   eval      dtsubid = desubid
025900131101     C                   eval      dtmssn = demssn
026000131101     C                   eval      dtmlnam = demlnam
026100131104     C                   eval      dtmfnam = demfnam
026200131101     C                   eval      dttrmdt = detrmdt
026300131101     C                   eval      dtdate = dhcrdt
026400131101     C                   write     ddgtrmr
0265001311010107  *
026600131101     C                   endif                                                  *in62 = '0'
026700131101      *
026800130912     C                   eval      reccnt = reccnt + 1
026900130912     C                   write     ddgeligr
027000150407     C                   exsr      grpmsr
0271001309120107  *
027200130912     C                   endif                                                  *in62 = '0'
0273000205170111  *
027400020517     C                   endsr
0275000205170107  ********************************************************************************
0276000205170107  *
0277001309120107  *     BLDDEP - Build Record for Dependent data
0278000205170107  *
0279000205170107  ********************************************************************************
028000020517     C     blddep        begsr
028100020517     C     dpkey         chain     depndc                             33
028200020517     C                   if        *in33 = '0'
0283001309120107  *
028400130912     C                   clear                   ddgeligr
028500130912      *
028600130912     C                   movel     '30'          derctp
028700131104      *       Chk group# for 10 digits
028800131104     C                   if        grp10 = ' '
028900131104     C                   movel(P)  grp18         gxkey
029000131104     C     gxkey         chain     ddelgsxl                           52
029100131104     C                   if        *in52 = '0'
029200131104     C                   movel(P)  dx10gs        dwgrp#
029300131104     C                   else
029400131104     C                   eval      dwgrp# = dwgrp#
029500131104     C                   endif
029600131104     C                   endif
029700131104      *
029800131101     C                   movel(P)  grp15         degrp#
029900131101     C                   movel(P)  grp610        dediv#
0300001311060296  *
0301001311060296 C                   If        degrp# <> svgrp
030200131106     C                   eval      degrp# = svgrp
0303001311060296 C                   endif
0304001311060296  *
0305001311060296 C                   If        dediv# <> svdiv
030600131106     C                   eval      dediv# = svdiv
0307001311060296 C                   endif
030800131106      *
030900131106     C                   if        degrp# = '15543' and dediv# = '00001' or
031000131106     C                             degrp# = '15543' and dediv# = '90001' or
031100131106     C                             degrp# = '97523' and dediv# = '04092'
031200131106     C                   leavesr
031300131106     C                   endif
031400131106      *
031500130912     C                   movel(P)  dssno         desubid
0316001311040296  *
0317001311040296 C                   If        depss# <> 0
031800130912     C                   movel(P)  depss#        demssn
0319001311040296 C                   endif
0320001311040296  *
032100130912     C                   movel     dlname        demlnam
032200130912     C                   movel     dfname        demfnam
032300130912     C                   movel     dmi           demmnam
032400130912     C                   move      dsex          desex
032500130912     C                   movel     dbirth        demdob
032600130912     C                   movel     *blanks       dehrdt
0327001309120296  *
032800180130     C                   movel     '30'          derelc
0329001309120296 C                   If        drelcd = 'RHU' or drelcd = 'RWI'
033000130912     C                   movel     '20'          derelc
0331001309120296 C                   else
0332001309120296 C                   If        drelcd = 'RSO' or drelcd = 'RDA'
033300130912     C                   movel     '30'          derelc
0334001309120296 C                   else
0335001309120296 C                   If        drelcd = 'RPA'
033600130912     C                   movel     '21'          derelc
0337001309120296 C                   endif
0338001309120296 C                   endif
0339001309120296 C                   endif
0340001309120296  *
034100131106     C                   if        dweff < 20110101
034200131106     C                   eval      dweff = 20110101
034300131106     C                   endif
0344001311060107  *
034500131106     C                   if        degrp# = '10893' and dediv# = '09999' and
034600131106     C                             dweff < 20130730
034700131106     C                   eval      dweff = 20130730
034800131106     C                   endif
0349001311060107  *
035000131101     C                   movel     dweff         deeffdt
0351001311040107  *
035200131104     C                   if        dwterm <> 0
035300131104     C                   move      dwterm        ISOdate
035400131104     C                   subdur    1:*D          ISOdate
035500131104     C                   move      ISOdate       ISOnum
035600131104     C                   move      ISOnum        detrmdt
035700131104     C                   else
035800131104     C                   eval      detrmdt = *blanks
035900131104     C                   endif
0360001311010107  *
036100131106     C                   if        svtrmdt <> *blanks and detrmdt = *blanks
036200131106     C                   eval      detrmdt = svtrmdt
036300131106     C                   endif
0364001311060107  *
036500131106     C                   if        detrmdt <> *blanks
0366001311010107  *
036700131101     C     tmkey         chain     ddgtrmp                            41
036800131101     C                   if        *in41 = '0'
036900131101     C                   leavesr
037000131101     C                   endif
037100131101      *
037200131101     C                   eval      dtgrp# = degrp#
037300131101     C                   eval      dtdiv# = dediv#
037400131101     C                   eval      dtsubid = desubid
037500131101     C                   eval      dtmssn = demssn
037600131101     C                   eval      dtmlnam = demlnam
037700131104     C                   eval      dtmfnam = demfnam
037800131101     C                   eval      dttrmdt = detrmdt
037900131101     C                   eval      dtdate = dhcrdt
038000131101     C                   write     ddgtrmr
038100131101     C                   endif                                                  *in62 = '0'
038200131101      *
038300131101     C                   eval      reccnt = reccnt + 1
038400131101     C                   write     ddgeligr
038500150407     C                   exsr      grpdsr
0386000205170111  *
038700131101     C                   endif                                                  *in62 = '0'
038800131101      *
038900020517     C                   endsr
0390000205170107  ********************************************************************************
0391000205170107  *
0392001311010107  *     BLDTRL - Build Trailer Record
0393000205170107  *
0394000205170107  ********************************************************************************
039500131101     C     bldtrl        begsr
0396001311011304  *
039700131101     C                   clear                   ddgtrlr
0398001311010297 C                   eval      dtrctp = '90'
0399001311010297 C                   movel     reccnt        dtrecct
0400001311010297 C                   write     ddgtrlr
0401000205170111  *
040200020517     C                   endsr
0403001504070107  ********************************************************************************
0404001504070107  *
0405001504070107  *     GRPMSR - Update Group Record for MBR
0406001504070107  *
0407001504070107  ********************************************************************************
040800150407     C     grpmsr        begsr
0409001504071304  *
0410001504070297 C                   if        dwterm <> 0 and dwterm < ISOtda
0411001504070297 C                   leavesr
0412001504070297 C                   endif
0413001504071304  *
0414001504070297 C                   eval      ktrst =  mbtrst
0415001504070297 C                   eval      ksub =  mbsub#
0416001504070297 C                   eval      kacct =  mbacct
0417001504071304  *
0418001504070297 C     gpkey         chain     ddggrpp                            21
0419001504070297 C                   if        *in21 = '0'
0420001504070297 C                   eval      dgempc = dgempc + 1
0421001504070297 C                   eval      dgtotc = dgtotc + 1
0422001504070297 C                   update    ddggrpr
0423001504071304  *
042400150407     C                   else
042500150407     C                   clear                   ddggrpr
0426001504070297 C                   eval      dggrp# = degrp#
0427001504070297 C                   eval      dgdiv# = dediv#
0428001504070297 C                   eval      dgtrst = ktrst
0429001504070297 C                   eval      dgsub# = ksub
0430001504070297 C                   eval      dgacct = kacct
0431001504080297 C                   eval      dgplan = dwplan
0432001504070297 C                   eval      dgempc = 1
0433001504070297 C                   eval      dgtotc = 1
0434001504070297 C                   write     ddggrpr
0435001504070111  *
043600150407     C                   endif
0437001504070111  *
043800150407     C                   endsr
0439001504070107  ********************************************************************************
0440001504070107  *
0441001504070107  *     GRPDSR - Update Group Record for Dep
0442001504070107  *
0443001504070107  ********************************************************************************
044400150407     C     grpdsr        begsr
0445001504071304  *
0446001504070297 C                   if        dwterm <> 0 and dwterm < ISOtda
0447001504070297 C                   leavesr
0448001504070297 C                   endif
0449001504071304  *
0450001504070297 C                   eval      ktrst =  mbtrst
0451001504070297 C                   eval      ksub =  mbsub#
0452001504070297 C                   eval      kacct =  mbacct
0453001504071304  *
0454001504070297 C     gpkey         chain     ddggrpp                            21
0455001504070297 C                   if        *in21 = '0'
0456001504070297 C                   eval      dgdepc = dgdepc + 1
0457001504070297 C                   eval      dgtotc = dgtotc + 1
0458001504070297 C                   update    ddggrpr
0459001504071304  *
046000150407     C                   else
046100150407     C                   clear                   ddggrpr
0462001504070297 C                   eval      dggrp# = degrp#
0463001504070297 C                   eval      dgdiv# = dediv#
0464001504070297 C                   eval      dgtrst = ktrst
0465001504070297 C                   eval      dgsub# = ksub
0466001504070297 C                   eval      dgacct = kacct
0467001504080297 C                   eval      dgplan = dwplan
0468001504070297 C                   eval      dgdepc = 1
0469001504070297 C                   eval      dgtotc = 1
0470001504070297 C                   write     ddggrpr
0471001504070111  *
047200150407     C                   endif
0473001504070111  *
047400150407     C                   endsr
