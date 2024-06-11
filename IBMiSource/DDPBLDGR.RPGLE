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
001200200319      *  rlj 03/19/2020 Adjust process for Delta Group File reporting
001300200319      *  rlj 03/19/2020 Use new work file DDGRPWP for report
001400210203      *  rlj 02/03/2021 Add Hire Date data for member records
001500020402      *                                                                *
0016009102150018 F******************************************************************
0017001311010020 Fdelwrkp   IF   E           K DISK
0018000205170020 Fmember    IF   E           K DISK
0019000205170020 Fdepndc    IF   E           K DISK
0020001311040020 Fddelgsxl  IF   E           K DISK
0021002003190020 Fgrat26    IF   E           K DISK
0022002003310020  *
0023002003310020 Fddgtrmp   UF A E           K DISK
0024002003310020 Fddghdrp   O    E             DISK
0025002003310020 Fddgeligp  O    E             DISK
0026001311010020 Fddgtrlp   O    E             DISK
0027002003310020 Fddgrpwp   UF A E           K DISK
002800200331      *
0029002003310250 D                 DS
0030002003310251 D  dwgrp#                 1     15
0031002003310251 D    grp14                1      4
0032002003310251 D    grp15                1      5
0033002003310251 D    grp18                1      8
0034002003310251 D    grp110               1     10
0035001311010251 D    grp58                5      8
0036001311040251 D    grp610               6     10
0037001311040251 D    grp10               10     10
0038001311010029  *
0039001309120250 D                 DS
0040001311040251 D  dehphon                1     14
0041001311040251 D   dphn10                1     10
0042002003180029  *
0043002003180250 D                 DS
0044002003180251 D  addr1                  1     30
0045002003180251 D   addr17                1      7
0046002003180029  *
0047002003180250 D                 DS
0048002003180251 D  city                   1     15
0049002003180251 D   city4                 1      4
0050002003180029  *
0051002003180250 D                 DS
0052002003180251 D  wkzip                  1      9
0053002003180251 D   wkzip5                1      5
0054002003180251 D   wkzip4                6      9
0055002003180029  *
0056002003180250 D                 DS
0057002003180251 D  dhcrtm                 1      6
0058001311040251 D  xhcrtm                 1      6  0
005900200318      *
0060002003180250 D                 DS
0061002003180251 D  dhcrdt                 1      8
0062002003180251 D  xhcrdt                 1      8  0
006300200318      *
0064002003180250 D                 DS
0065002003180251 D  ISOdate        S               D
0066000205210251 D  ISOnum         S              8  0
0067001504070251 D  ISOtda         S              8  0
0068000205210251 D  MDYdate        S               D   DATFMT(*MDY)
0069000205240251 D  enrdat         S              8  0
0070000205240251 D  trmdat         S              8  0
0071001311010251 D  mindate        S              8  0
0072001311040251 D  reccnt         S              7  0 INZ(2)
0073001311040251 D  gxkey          S             10
0074001311060251 D  svgrp          S                   LIKE(degrp#)
0075001311060251 D  svdiv          S                   LIKE(dediv#)
0076001311060251 D  svtrmdt        S                   LIKE(detrmdt)
007700131101      *
0078000205210250 D                 DS
0079000205310251 D  wrkdat8                1      8  0
0080000205310251 D   wrkda                 7      8  0
008100020517      *
008200131101     C     tmkey         klist
008300131101     C                   kfld                    degrp#
008400131101     C                   kfld                    dediv#
008500131101     C                   kfld                    desubid
008600131101     C                   kfld                    demssn
008700131101     C                   kfld                    demlnam
008800131101     C                   kfld                    demfnam
008900131101     C                   kfld                    detrmdt
009000090917      *
009100020517     C     dpkey         klist
009200131101     C                   kfld                    dwssn
009300131101     C                   kfld                    dwseq#
009400150407      *
009500150407     C     gpkey         klist
009600150407     C                   kfld                    ktrst             3 0
009700150407     C                   kfld                    ksub              3 0
009800150407     C                   kfld                    kacct             4 0
009900150407     C                   kfld                    degrp#
010000150407     C                   kfld                    dediv#
010100200319      *
010200200319     C     grkey         klist
010300200319     C                   kfld                    dwtrst
010400200319     C                   kfld                    dwsub#
010500200319     C                   kfld                    dwplan
010600200319     C                   kfld                    dwcovt
010700200320     C                   kfld                    grdat             8 0
010800020503      ******************************************************************************
010900020517      *      MainLine
0110001311011304  *         Calculate cutoff dates
011100131101     C                   move      UDATE         ISOdate
011200131101     C                   move      ISOdate       ISOnum
011300150407     C                   move      ISOnum        ISOtda
011400131119     C                   subdur    60:*D         ISOdate
011500131101     C                   move      ISOdate       mindate
0116001309121304  *         Build Header Record
011700130912     C                   clear                   ddghdrr
0118002003310297 C                   eval      dhrctp = '10'
0119002003310297 C                   movel     '15591'       dhgrp#
0120002003310297 C                   eval      dhport = 'P'
012100200331     C                   eval      xhcrdt = %int(%char(%date : *iso0))
012200200331     C                   time                    xhcrtm
0123002003310297 C                   write     ddghdrr
0124002003310111  *          Read Work file to create Detail recs
0125002003310107  *
012600200331     C                   dou       *in23 = '1'
012700200331     C                   read      delwrkp                                23
012800200331     C                   if        *in23 = '1'
012900200331     C                   leave
013000200331     C                   endif
0131002003310111  ***        Bypass Goodwill recs - Removed per Delta instructions
013200200331     C********           if        grp110 = '7853900001'
013300200331     C***                iter
013400200331     C********           endif
0135001412300111  *          Bypass Oakworks recs - per Delta instructions
013600200325     C                   if        grp15 = '09449'
013700200325     C                   iter
013800200325     C                   endif
0139002003250111  *       If term date older than 7/1/2013 - bypass rec
014000200325     C                   if        dwterm <> 0 and dwterm < mindate
014100131119     C*******            if        dwterm <> 0 and dwterm < 20131101
014200200325     C                   iter
014300200325     C                   endif
0144002003250111  *         Member Record?
014500200325     C                   if        dwseq# = 0
0146002003250111  *
014700200325     C                   exsr      bldmbr
014800200325     C                   else
0149002003250111  *
015000200325     C                   exsr      blddep
0151002003250111  *
015200131101     C                   endif
015300131101     C                   enddo
015400131101     C                   exsr      bldtrl
015500131101     C                   movel     '1'           *inlr
015600131101     C                   return
0157000204260111  *
0158000204020107  ********************************************************************************
0159000204020107  *
0160001309120107  *     BLDMBR - Build Record - Member data
0161000204020107  *
0162000204020107  ********************************************************************************
016300020517     C     bldmbr        begsr
016400130912     C                   clear                   ddgeligr
016500131101     C     dwssn         chain     member                             31
016600020517     C                   if        *in31 = '0'
0167001309120107  *       Build Member Record
016800130912      *
016900130912     C                   movel     '30'          derctp
017000131104      *       Chk group# for 10 digits
017100131104     C                   if        grp10 = ' '
017200131104     C                   movel(P)  grp18         gxkey
017300131104     C     gxkey         chain     ddelgsxl                           52
017400131104     C                   if        *in52 = '0'
017500131104     C                   movel(P)  dx10gs        dwgrp#
017600131104     C                   else
017700131104     C                   eval      dwgrp# = dwgrp#
017800131104     C                   endif
017900131104     C                   endif
018000130912      *
018100131104     C                   movel(P)  grp15         degrp#
018200131104     C                   movel(P)  grp610        dediv#
018300131106      *
018400131106     C                   eval      svgrp = degrp#
018500131106     C                   eval      svdiv = dediv#
018600130912      *
018700131106     C                   if        degrp# = '15543' and dediv# = '00001' or
018800131106     C                             degrp# = '15543' and dediv# = '90001' or
018900131106     C                             degrp# = '97523' and dediv# = '04092'
019000131106     C                   leavesr
019100131106     C                   endif
019200131106      *
019300210203     C                   movel     empdt         dehrdt
019400130912     C                   movel(P)  mbssno        desubid
019500130912     C                   movel(P)  mbssno        demssn
019600130912     C                   movel     mlname        demlnam
019700130912     C                   movel     mfname        demfnam
019800130912     C                   movel     mmi           demmnam
019900130912     C                   move      sex           desex
020000130912     C                   movel     birth         demdob
020100130912     C                   movel     '10'          derelc
0202001311060107  *
0203001311060296 C                   If        addr17 <> 'UNKNOWN'
020400130912    *C                   movel(P)  addr1         deaddr1
020500131106     C                   endif                                                  *in62 = '0'
0206001311060107  *
020700130912    *C                   movel(P)  addr2         deaddr2
0208001309120107  *
0209001309120296 C                   If        deaddr1 = *blanks and deaddr2 <> *blanks
021000130912     C                   movel(P)  deaddr2       deaddr1
021100130912     C                   movel     *blanks       deaddr1
021200130912     C                   endif                                                  *in62 = '0'
0213001309120107  *
0214001311060296 C                   If        city4  <> 'XXXX'
021500130912     C                   movel     city          decity
021600131106     C                   endif                                                  *in62 = '0'
0217001311060107  *
0218001311060296 C                   If        state  <> 'XX'
021900130912     C                   move      state         dest
022000131106     C                   endif                                                  *in62 = '0'
0221001311040107  *
022200131104     C                   movel     zip           wkzip
022300131104     C                   if        wkzip4 = '0000'
022400131104     C                   movel     *blanks       wkzip4
022500131104     C                   endif
022600131106     C                   if        wkzip5 = '00000'
022700131106     C                   movel     *blanks       wkzip5
022800131106     C                   endif
022900131104     C                   movel     wkzip         dezip
0230001311040107  *
023100131104     C                   if        area <> 0 and phone <> 0
023200131104     C                   movel     area          dphn10
023300131104     C                   move      phone         dphn10
023400131104     C                   endif
0235001311060107  *
023600131106     C                   if        dweff < 20110101
023700131106     C                   eval      dweff = 20110101
023800131106     C                   endif
023900131106      *
024000131106     C                   if        degrp# = '10893' and dediv# = '09999' and
024100131106     C                             dweff < 20130730
024200131106     C                   eval      dweff = 20130730
024300131106     C                   endif
0244001311060107  *
024500131101     C                   movel     dweff         deeffdt
024600131101     C                   movel     dwterm        detrmdt
0247001311010107  *
024800131104     C                   if        dwterm <> 0
024900131104     C                   move      dwterm        ISOdate
025000131104     C                   subdur    1:*D          ISOdate
025100171130     C                   move      ISOdate       ISOnum
025200171130     C                   move      ISOnum        detrmdt
025300171130     C                   else
025400171130     C                   eval      detrmdt = *blanks
025500171130     C                   endif
0256001711300107  *
025700171130     C                   eval      svtrmdt = detrmdt
0258001711300107  *
025900171130     C                   if        detrmdt <> *blanks
0260001711300107  *
026100171130     C     tmkey         chain     ddgtrmp                            41
026200171130     C                   if        *in41 = '0'
026300171130     C                   leavesr
026400171130     C                   endif
026500131101      *
026600131101     C                   eval      dtgrp# = degrp#
026700131101     C                   eval      dtdiv# = dediv#
026800131101     C                   eval      dtsubid = desubid
026900131101     C                   eval      dtmssn = demssn
027000131101     C                   eval      dtmlnam = demlnam
027100131104     C                   eval      dtmfnam = demfnam
027200131101     C                   eval      dttrmdt = detrmdt
027300131101     C                   eval      dtdate = dhcrdt
027400200601     C                   write     ddgtrmr
0275002003240107  *
027600200324     C                   endif                                                  *in62 = '0'
027700200324      *
027800200324     C                   eval      reccnt = reccnt + 1
027900200324     C                   write     ddgeligr
028000200324     C                   exsr      grpmsr
0281002003240107  *
028200200324     C                   endif                                                  *in62 = '0'
0283002003240111  *
028400020517     C                   endsr
0285000205170107  ********************************************************************************
0286000205170107  *
0287001309120107  *     BLDDEP - Build Record for Dependent data
0288000205170107  *
0289000205170107  ********************************************************************************
029000020517     C     blddep        begsr
029100020517     C     dpkey         chain     depndc                             33
029200020517     C                   if        *in33 = '0'
0293001309120107  *
029400130912     C                   clear                   ddgeligr
029500130912      *
029600130912     C                   movel     '30'          derctp
029700131104      *       Chk group# for 10 digits
029800131104     C                   if        grp10 = ' '
029900131104     C                   movel(P)  grp18         gxkey
030000131104     C     gxkey         chain     ddelgsxl                           52
030100131104     C                   if        *in52 = '0'
030200131104     C                   movel(P)  dx10gs        dwgrp#
030300131104     C                   else
030400131104     C                   eval      dwgrp# = dwgrp#
030500131104     C                   endif
030600131104     C                   endif
030700131104      *
030800131101     C                   movel(P)  grp15         degrp#
030900131101     C                   movel(P)  grp610        dediv#
0310001311060296  *
0311001311060296 C                   If        degrp# <> svgrp
031200131106     C                   eval      degrp# = svgrp
0313001311060296 C                   endif
0314001311060296  *
0315001311060296 C                   If        dediv# <> svdiv
031600131106     C                   eval      dediv# = svdiv
0317001311060296 C                   endif
031800131106      *
031900131106     C                   if        degrp# = '15543' and dediv# = '00001' or
032000131106     C                             degrp# = '15543' and dediv# = '90001' or
032100131106     C                             degrp# = '97523' and dediv# = '04092'
032200131106     C                   leavesr
032300131106     C                   endif
032400131106      *
032500130912     C                   movel(P)  dssno         desubid
0326001311040296  *
0327001311040296 C                   If        depss# <> 0
032800130912     C                   movel(P)  depss#        demssn
0329001311040296 C                   endif
0330001311040296  *
033100130912     C                   movel     dlname        demlnam
033200130912     C                   movel     dfname        demfnam
033300130912     C                   movel     dmi           demmnam
033400130912     C                   move      dsex          desex
033500130912     C                   movel     dbirth        demdob
033600130912     C                   movel     *blanks       dehrdt
0337001309120296  *
033800180130     C                   movel     '30'          derelc
0339001309120296 C                   If        drelcd = 'RHU' or drelcd = 'RWI'
034000130912     C                   movel     '20'          derelc
0341001309120296 C                   else
0342001309120296 C                   If        drelcd = 'RSO' or drelcd = 'RDA'
034201230208     C                   movel     '30'          derelc
0342022302080296 C                   If        dhndcp <> ' '
034300230208     C                   movel     '32'          derelc
0343012302080296 C                   endif
0344001309120296 C                   else
0345001309120296 C                   If        drelcd = 'RPA'
034600130912     C                   movel     '21'          derelc
0347001309120296 C                   endif
0348001309120296 C                   endif
0349001309120296 C                   endif
0350001309120296  *
035100131106     C                   if        dweff < 20110101
035200131106     C                   eval      dweff = 20110101
035300131106     C                   endif
0354001311060107  *
035500131106     C                   if        degrp# = '10893' and dediv# = '09999' and
035600131106     C                             dweff < 20130730
035700131106     C                   eval      dweff = 20130730
035800131106     C                   endif
0359001311060107  *
036000131101     C                   movel     dweff         deeffdt
0361001311040107  *
036200131104     C                   if        dwterm <> 0
036300131104     C                   move      dwterm        ISOdate
036400131104     C                   subdur    1:*D          ISOdate
036500131104     C                   move      ISOdate       ISOnum
036600131104     C                   move      ISOnum        detrmdt
036700131104     C                   else
036800131104     C                   eval      detrmdt = *blanks
036900131104     C                   endif
0370001311010107  *
037100131106     C                   if        svtrmdt <> *blanks and detrmdt = *blanks
037200131106     C                   eval      detrmdt = svtrmdt
037300131106     C                   endif
0374001311060107  *
037500131106     C                   if        detrmdt <> *blanks
0376001311010107  *
037700131101     C     tmkey         chain     ddgtrmp                            41
037800131101     C                   if        *in41 = '0'
037900131101     C                   leavesr
038000131101     C                   endif
038100131101      *
038200131101     C                   eval      dtgrp# = degrp#
038300131101     C                   eval      dtdiv# = dediv#
038400131101     C                   eval      dtsubid = desubid
038500131101     C                   eval      dtmssn = demssn
038600131101     C                   eval      dtmlnam = demlnam
038700131104     C                   eval      dtmfnam = demfnam
038800131101     C                   eval      dttrmdt = detrmdt
038900131101     C                   eval      dtdate = dhcrdt
039000200601     C                   write     ddgtrmr
039100131101     C                   endif                                                  *in62 = '0'
039200131101      *
039300131101     C                   eval      reccnt = reccnt + 1
039400131101     C                   write     ddgeligr
039500150407     C                   exsr      grpdsr
0396000205170111  *
039700131101     C                   endif                                                  *in62 = '0'
039800131101      *
039900020517     C                   endsr
0400000205170107  ********************************************************************************
0401000205170107  *
0402001311010107  *     BLDTRL - Build Trailer Record
0403000205170107  *
0404000205170107  ********************************************************************************
040500131101     C     bldtrl        begsr
0406001311011304  *
040700131101     C                   clear                   ddgtrlr
0408001311010297 C                   eval      dtrctp = '90'
0409001311010297 C                   movel     reccnt        dtrecct
0410001311010297 C                   write     ddgtrlr
0411000205170111  *
041200020517     C                   endsr
0413001504070107  ********************************************************************************
0414001504070107  *
0415001504070107  *     GRPMSR - Update Group Record for MBR
0416001504070107  *
0417001504070107  ********************************************************************************
041800150407     C     grpmsr        begsr
0419001504071304  *
0420001504070297 C                   if        dwterm <> 0 and dwterm < ISOtda
0421001504070297 C                   leavesr
0422001504070297 C                   endif
0423001504071304  *
0424001504070297 C                   eval      ktrst =  mbtrst
0425001504070297 C                   eval      ksub =  mbsub#
0426001504070297 C                   eval      kacct =  mbacct
0427002003201304  *       If grp rec already there - Update existing rec
0428002003190297 C     gpkey         chain     ddgrpwp                            21
0429001504070297 C                   if        *in21 = '0'
043000200319      *
043100200319     C                   select
043200200319     C                   when      dwcovt = 'TIN'
0433002003190297 C                   eval      dgempc1 = dgempc1 + 1
043400200319     C                   when      dwcovt = 'THW'
0435002003190297 C                   eval      dgempc2 = dgempc2 + 1
043600200319     C                   when      dwcovt = 'TPC'
0437002003190297 C                   eval      dgempc3 = dgempc3 + 1
043800200319     C                   when      dwcovt = 'TP2'
0439002003190297 C                   eval      dgempc3 = dgempc3 + 1
044000200319     C                   when      dwcovt = 'TFA'
0441002003190297 C                   eval      dgempc4 = dgempc4 + 1
044200200319     C                   endsl
044300200319      *
044400200319      *
0445002003200297 C                   eval      grdat = ISOtda
044600200319     C     grkey         setll     grat26                             21
044700200319     C                   read      grat26                               2121
044800200319      *
044900200320     C                   if        *in21 = '1' or dwcovt <> typecd
0450002003200297 C                   eval      grdat = 99999999
045100200320     C     grkey         setll     grat26                             21
045200200320     C                   read      grat26                               2121
045300200320     C                   if        *in21 = '1' or dwcovt <> typecd
045400200320     C                   leavesr
045500200320     C                   endif
045600200320     C                   endif
045700200320      *
0458002003190297 C                   eval      dgtotp = dgtotp + netrte
045900200320      *
046000200320     C                   if        *in21 = '0' and dwcovt = typecd
0461002003200297 C                   eval      dgtotp = dgtotp + netrte
0462002003190297 C                   update    ddgrpwr
046300200319     C                   endif
0464001504071304  *
046500150407     C                   else
0466002003201304  *       If grp rec not there - Create new rec
046700200319     C                   clear                   ddgrpwr
0468001504070297 C                   eval      dggrp# = degrp#
0469001504070297 C                   eval      dgdiv# = dediv#
0470001504070297 C                   eval      dgtrst = ktrst
0471001504070297 C                   eval      dgsub# = ksub
0472001504070297 C                   eval      dgacct = kacct
0473001504080297 C                   eval      dgplan = dwplan
047400200319      *
047500200319     C                   select
047600200319     C                   when      dwcovt = 'TIN'
0477002003190297 C                   eval      dgempc1 = 1
047800200319     C                   when      dwcovt = 'THW'
0479002003190297 C                   eval      dgempc2 = 1
048000200319     C                   when      dwcovt = 'TPC'
0481002003190297 C                   eval      dgempc3 = 1
048200200319     C                   when      dwcovt = 'TP2'
0483002003190297 C                   eval      dgempc3 =  1
048400200319     C                   when      dwcovt = 'TFA'
0485002003190297 C                   eval      dgempc4 =  1
048600200319     C                   endsl
048700200319      *
0488002003200297 C                   eval      grdat = ISOtda
048900200320     C     grkey         setll     grat26                             21
049000200320     C                   read      grat26                               2121
049100200320      *
049200200320     C                   if        *in21 = '1' or dwcovt <> typecd
0493002003200297 C                   eval      grdat = 99999999
049400200320     C     grkey         setll     grat26                             21
049500200320     C                   read      grat26                               2121
049600200320     C                   if        *in21 = '1' or dwcovt <> typecd
049700200320     C                   leavesr
049800200320     C                   endif
049900200320     C                   endif
050000200319      *
050100200319     C                   if        *in21 = '0' and dwcovt = typecd
0502002003190297 C                   z-add     netrte        dgtotp
0503002003190297 C                   z-add     frmdat        dgeffdt
050400200320      *
050500200320     C                   move      todat         ISOdate
050600200320     C                   adddur    1:*D          ISOdate
050700200320     C                   move      ISOdate       ISOnum
050800200320     C                   move      ISOnum        dgtrmdt
050900200319     C                   endif
0510002003191304  *
0511002003190297 C                   write     ddgrpwr
0512001504070111  *
051300150407     C                   endif
0514001504070111  *
051500150407     C                   endsr
0516001504070107  ********************************************************************************
0517001504070107  *
0518001504070107  *     GRPDSR - Update Group Record for Dep
0519001504070107  *
0520001504070107  ********************************************************************************
052100150407     C     grpdsr        begsr
0522001504071304  *
0523001504070297 C                   if        dwterm <> 0 and dwterm < ISOtda
0524001504070297 C                   leavesr
0525001504070297 C                   endif
0526001504071304  *
0527001504070297 C                   eval      ktrst =  mbtrst
0528001504070297 C                   eval      ksub =  mbsub#
0529001504070297 C                   eval      kacct =  mbacct
0530001504071304  *
0531002003190297 C     gpkey         chain     ddgrpwp                            21
0532002003190297 C                   if        *in21 = '1'
0533002003190297 C                   eval      dgdepct = dgdepct
053400200319     C                   else
0535002003190297 C                   eval      dgdepct = dgdepct + 1
0536002003190297 C                   update    ddgrpwr
0537001504071304  *
053800150407     C                   endif
0539001504070111  *
054000150407     C                   endsr
