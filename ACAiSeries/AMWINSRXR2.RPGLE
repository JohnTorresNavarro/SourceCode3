000100161227     h option(*nodebugio)
0002001611300002  *============================================================================
000300161201      * AMWINSRXR - AmWINS Rx
0004001612010002  *============================================================================
000500161130      *  DESCRIPTION - Build file of current EHP
000600161130      *                Eligibility from LuminX files.
0007001611300002  *============================================================================
000800161201      * Date        Int   Description
000900161201      * ----------  ---   -------------------------------------------------------------
001000161201      * 07/01/2015  JT    Original creation (Cloned from EHPELIGR by R. Jones)
0011001611300002  *============================================================================
001200161130
0013001612290019 FPARTCOVGL4IP   E           K DISK
001400161130
001500021009     FPARTICIPL1IF   E           K DISK
001600161130
001700021011     FDEPENDNTL1IF   E           K DISK
001800161130
001900021030     FDEPNCOVGL2IF   E           K DISK
002000161130
002100060201     FGROUPDIVL1IF   E           K DISK
002200161130
002300031114     FGRBILCLCL3IF   E           K Disk
002400161130
002500060131     FGROUPMSTL2IF   E           K Disk
002600161130
002700161223     FPLANMASTL1IF   E           K Disk
002800161223
0029001612010020 famwinsrx  uf a e             disk    rename(amwrxr:winsFile)
003000161130
0031001612050020 famwinstermuf a e           k disk    rename(amtermr:termFile)
003200161202
0033001611300002  *============================================================================
0034001611300025
003500021016     D PCARRAY       E DS                  EXTNAME(PARTCOVG)
003600031114     D  P@COV                 57    104A   Dim(16)
003700021016     D  P@PLAN               105    424A   DIM(16)
003800021016     D  P@ENR                425    472A   DIM(16)
003900161130   X*
004000060131     D                 DS
004100060131     D  datelm                 1      8  0
004200060131     D   dtlmyy                1      4
004300060131     D   dtlmmm                5      6
004400060131     D   dtlmdd                7      8
004500161130   X*
004600060131     D                 DS
004700060201     D  dateeh                 1     10
004800060131     D   dtehmm                1      2
004900060131     D   dtehs1                3      3    INZ('/')
005000060201     D   dtehdd                4      5
005100060131     D   dtehs2                6      6    INZ('/')
005200060201     D   dtehyy                7     10
005300161130
0054000311140250 D                 DS
0055000311140251 D  gbbilfor               1     50
0056000311140251 D   bilfor9               1      9
005700161130
0058000602010250 D                 DS
0059000602010251 D  curgrdv                1     24
0060000602010251 D   curgrp#               1     20
0061000602010251 D   curdiv               21     24
006200161130
0063000602010250 D                 DS
0064000602010251 D  savgrdv                1     24
0065000602010251 D   savgrp#               1     20
0066000602010251 D   savdiv               21     24
006700161130
0068000602010250 D                 DS
0069000602010251 D  ehmbr#                 1     12
0070000602010251 D   ehmbr9                1      9
0071000602010251 D   ehmbr1               10     10    INZ('0')
0072000602010251 D   ehmbr2               11     12
007300161130
0074009102150250 D                 DS
0075000301150251 D  dseq                          2S 0 INZ(0)
0076000204030251 D  cutoff                         D   DATFMT(*ISO)
0077000204030251 D  cutofn                        8S 0
0078000211040251 D  day30d                         D   DATFMT(*ISO)
0079000301150251 D  day30n                        8S 0
0080000210100251 D  sveff                         8S 0
0081000210100251 D  svterm                        8S 0
0082000603080251 D  sveffg                        8S 0
0083000603080251 D  svtrmg                        8S 0
0084000210100251 D  todaa                         8S 0
0085000210100251 D  date9                         8S 0
0086000204150251 D  updt                          1A
0087000601310251 D  ehpy                          1A   INZ('N')
0088000210160251 D  X                             2S 0
0089000602230251 D  Y                             2S 0
0090000401060251 D  fstcov                        1A   INZ('N')
0091000211010251 D  dchg                          1A   INZ('N')
0092000601310251 D  ehpvend                       1A   INZ('N')
0093000311140251 D  plnk99                        2A   INZ('99')
009400161130
0095000210090251 D  svpartic                           LIKE(pepartic)
0096000210110251 D  svdep                              LIKE(dqdep)
0097000210160251 D  svenr                              LIKE(peenr01)
0098000509070251 D  svssn                              LIKE(gpssn)
0099000511230251 D  curplan                            LIKE(pepln01)
0100000401060251 D  svplan                             LIKE(pepln01)
0101000311140251 D  svcov                              LIKE(pecov01)
0102000511230251 D  curcov                             LIKE(pecov01)
0103000511230251 D  curenr                             LIKE(peenr01)
010400161130
010500161205     d percd_d         s              3  0
010600161205     d @phone          s             10
010700161205     d t               s              3  0
010800161205     d r               s              3  0
010900161205     d e               s              1
011000161205     d termed          s              1
011100161205     d chpartcp        s             20
011200161205     d chgroup         s             20
011300161205     d chdate          s              8  0
011400161223     d grp             s             20
011500161227     D $pos            S              2  0
011600161227     D $pos2           S              2  0
011700161227     D $pos3           S              2  0
011800161227     D $pos4           S              2  0
011900161229     D svplan2         S             20
012000161205
0121001612010002  //===========================================================================
012200161201      // Mainline
0123001612010002  //===========================================================================
012400161130
012500161229       //exsr init;
012600161229       //exsr main;
012700161229       //exsr exit;
012800161130
0129001611300002  *============================================================================
013000161130      * Main
0131001611300002  *============================================================================
013200161130
013300161229     C**** main          begsr
013400161130
013500161229     C**** *loval        setll     partcovgr
013600161229     C****               read      partcovgr
013700161130
013800161229     C****               dow       not %eof
0139001611300291
0140001611300291  * Check each participant coverage record for EHP Med
014100060131     C                   eval      ehpy = 'N'
014200051123    3C     1             DO        16            X
014300161223    4C                   IF        P@PLAN(X) <> *blanks and P@COV(X) = 'RXD'
014400051123     C                   eval      svplan = P@PLAN(X)
014500161229
014600161229     c                   eval      $pos2= %scan('AMWINS RX':svplan:1)
014700161229     c                   if        $pos2 > 0
014800161229     c****               eval      svplan2 = svplan
014900161229     c                   endif
015000161229
015100051123     C                   exsr      chkvend
015200060131     C                   if        ehpvend = 'Y'
015300060131     C                   eval      ehpy = 'Y'
015400060201     C                   movel(P)  pegroup       curgrp#
015500060201     C                   movel(P)  pediv         curdiv
015600051123     C                   MOVEA     P@COV(X)      curcov
015700051123     C                   MOVEA     P@PLAN(X)     curplan
015800051123     C                   MOVEA     P@ENR(X)      curenr
015900051123     C                   leave
016000051123     C                   endif
016100051123     C                   endif
016200051123     C                   enddo
016300051123      *
016400060131     C                   if        ehpy = 'Y'
016500161130      * EHP Med Rec
0166001611300291  * Check for change in Paticipant
0167000511230296 C                   If        pepartic <> svpartic
0168001611300291  * If Participant# Changes
0169000602010296 C                   if        svpartic <> *blanks
0170000511230291  *            Build member record
0171000511230296 C                   If        svterm = 0 or svterm = 99999999 or
0172000511230296 C                             svterm > cutofn
0173000511230291 C                   exsr      bldmbr
0174000511230291 C                   exsr      chkdep
0175000511230296 C                   endif
0176000602010296 C                   endif
017700161130
0178001611300291  * reset save fields
017900161229     C                   MOVEl     curplan       svplan2
0180000511230297 C                   movel     pepartic      svpartic
0181000511230297 C                   movel     curenr        svenr
0182000511230297 C                   eval      sveff = 99999999
0183000511230297 C                   eval      svterm = 00000000
0184000511230296 C                   endif
0185001611300296
0186000511230296 C                   If        pefromdt < sveff
0187000511230297 C                   eval      sveff = pefromdt
0188000511230296 C                   endif
0189001611300291
0190000511230296 C                   If        petodate > svterm
0191000511230297 C                   eval      svterm = petodate
0192000511230296 C                   endif
019300161130
0194001611300291  * Check for change in EHP Grp#
0195000602010296 C                   If        curgrdv <> savgrdv
0196000602010296 C                   If        curgrp# <> savgrp#
0197000603080297 C                   eval      sveffg = 99999999
0198000603080297 C                   eval      svtrmg = 00000000
0199000603080297 C     curgrp#       setll     groupmstl2                         64
0200000603080296 C                   dou       *in64 = '1'
0201000603080297 C     curgrp#       reade     groupmstl2                             64
0202000603080296 C                   If        *in64 = '0' and grgroup = curgrp#
0203000603080291  *
0204000603080296 C                   If        grfrdate < sveffg
0205000603080297 C                   eval      sveffg = grfrdate
0206000603080296 C                   endif
0207000603080291  *
0208000603080296 C                   If        grtodate > svtrmg
0209000603080297 C                   eval      svtrmg = grtodate
0210000603080296 C                   endif
0211000603080291  *
0212000603080296 C                   endif
0213000603080291  *
0214000603080296 C                   enddo
0215000603080291  *
021600060308     C                   eval      datelm = sveffg
021700060201     C                   exsr      datesr
0218000602010291  *
021900060308     C                   eval      datelm = svtrmg
022000060201     C                   exsr      datesr
0221000602010291  *
022200060201    4C                   endif
0223000602010291  *
0224001611300297 C     grdvky        chain     GROUPDIVL1
0225001611300296 C                   If        %found
022600161130
022700060201     C                   endif
0228000602010291  *
0229000602010296 C                   eval      savgrdv = curgrdv
0230000602010291  *
023100060201    4C                   endif
023200051123      *
0233000511230296 C                   endif
023400021016
023500161229     C****               read      partcovgr
023600161229     C****               enddo
023700161130
023800161229     Clr                 Exsr      Process_LR
023900161227
024000161229     C****               endsr
024100161130
0242001611300002  *============================================================================
024300021016      * Process LR
0244001611300002  *============================================================================
024500161130
024600021016     C     Process_LR    BEGSR
024700161130
0248000511230296 C                   If        svpartic <> *blanks
0249000210160296 C                   If        svterm = 0 or svterm = 99999999 or
0250000210160296 C                             svterm > cutofn
0251000210160291 C                   exsr      bldmbr
0252000211200291 C                   exsr      chkdep
0253000210160296 C                   endif
0254000210160296 C                   endif
025500161130
025600021016     C                   ENDSR
025700161130
0258001611300002  *============================================================================
0259001611300107  * BLDMBR - Build Member record
0260001611300002  *============================================================================
026100161130
026200020402     C     bldmbr        begsr
026300161130
0264001611300297 C     partky        chain     PARTICIPL1
0265001611300296 C                   If        %found
026600161130
026700161201       clear winsFile;
026800161201
026900161229       //if X < 17;
027000161229       //chain (P@PLAN(X)) PLANMASTL1;
027100161229       // if %found;
027200161229       //  group# = plremk;
027300161229       // endif;
027400161227
027500161229       // else;
027600161229         chain (svplan2) PLANMASTL1;
027700161229        if %found;
027800161227          group# = plremk;
027900161227        endif;
028000161227
028100161227       carrier = 'COMMSIHP';
028200161201       memid = gppartic;
028300161227       percd = '001';
028400161201       relcd = '1';
028500161201       lastname = gplast;
028600161201       firstname = gpfirst;
028700161201       mi = gpmi;
028800161201       gender = gpsex;
028900161201       dateofbth = %char(gpdob);
029000161227       effdate = %char(pefromdt);
029100161227
029200161227       termdate = %char(petodate);
029300161227       if petodate = 99999999;
029400161227        termdate = ' ';
029500161227       endif;
029600161227
029700161201    *  address1 = gpaddr1;
029800161201    *  address2 = gpaddr2;
029900161201       city = gpcity;
030000161201       state = gpstate;
030100161201       zip = gpzip;
030200161201
030300161205       exsr $phone;
030400161205       phone = @phone;
030500161205
030600161201       mbrssn = gpssn;
030700161130
0308001612010296   if curenr = 'P00';
030900161201        covcode = 'I';
031000161201       endif;
031100161130
0312000511230296 C                   If        svenr = 'P01'
031300161201     C                   eval      covcode = 'C'
0314001611300296 C                   endif
031500161130
0316000511230296 C                   If        svenr = 'F00'
031700161201     C                   eval      covcode = 'S'
0318001611300296 C                   endif
031900161130
0320000511230296 C                   If        svenr = 'F99'
032100161201     C                   eval      covcode = 'F'
0322000210160296 C                   endif
032300161205
032400161205       chgroup = gpgroup;
032500161205       chdate = grtodate;
032600161205       chpartcp = gppartic;
032700161205       exsr checkTermed;
0328001612010291
032900161205       if termed = 'N';
033000161205        write winsFile;
033100161205       endif;
033200161205
033300161201     C                   endif
0334001612010107
033500020415     C                   endsr
033600161130
0337001611300002  *============================================================================
0338001611300107  * CHKDEP - Check for Dependent Records
0339001611300002  *============================================================================
034000161130
034100021011     C     chkdep        begsr
034200161130
0343001611300291  * Get Dependent coverage record
0344000210110297 C                   eval      svdep = '00'
0345000210300297 C     partky        setll     depncovgl2                         42
0346000210110296 C                   dou       *in42 = '1'
0347000210300297 C                   read      depncovgl2                             42
034800161130
0349000210310296 C                   If        *in42 = '0' and dqpartic = svpartic
035000161130
0351001611300291  * DOES DIV HAVE TO MATCH ??????????
0352000601310291  * Check each dependent coverage record for EHP RX
0353001612230296 C                   If        dqcov01 = 'RXD' or
0354001612230296 C                             dqcov02 = 'RXD' or
0355001612230296 C                             dqcov03 = 'RXD' or
0356001612230296 C                             dqcov04 = 'RXD' or
0357001612230296 C                             dqcov05 = 'RXD' or
0358001612230296 C                             dqcov06 = 'RXD' or
0359001612230296 C                             dqcov07 = 'RXD' or
0360001612230296 C                             dqcov08 = 'RXD' or
0361001612230296 C                             dqcov09 = 'RXD' or
0362001612230296 C                             dqcov10 = 'RXD' or
0363001612230296 C                             dqcov11 = 'RXD' or
0364001612230296 C                             dqcov12 = 'RXD' or
0365001612230296 C                             dqcov13 = 'RXD' or
0366001612230296 C                             dqcov14 = 'RXD' or
0367001612230296 C                             dqcov15 = 'RXD' or
0368001612230296 C                             dqcov16 = 'RXD'
0369000210110291  *
0370000210110296 C                   If        svdep <> dqdep
0371001611300291  * Dep # Change => build dep record
0372000210110296 C                   If        svdep <> '00'
0373000210110296 C                   If        svterm = 0 or svterm = 99999999 or
0374000210110296 C                             svterm > cutofn
0375000210110291 C                   exsr      blddep
0376000210110296 C                   endif
0377000210110296 C                   endif
0378000210110291  *
0379000210110297 C                   eval      svdep = dqdep
0380000210110297 C                   eval      sveff = 99999999
0381000210110297 C                   eval      svterm = 00000000
0382000210110291  *
0383000210110296 C                   endif
0384000210110291  *
0385000210110296 C                   If        dqfromdt < sveff
0386000210110297 C                   eval      sveff = dqfromdt
0387000210110296 C                   endif
0388000210110291  *
0389000210110296 C                   If        dqtodate > svterm
0390000210110297 C                   eval      svterm = dqtodate
0391000210110296 C                   endif
0392000210110297 C                   endif                                                  *in42 = '0'
0393000210110291  *
0394000210310297 C                   else                                                   *in42 = '0'
0395001611300291  * Participant Change => build dep record
0396000210110296 C                   If        svdep <> '00'
0397000210110296 C                   If        svterm = 0 or svterm = 99999999 or
0398000210110296 C                             svterm > cutofn
0399000210110291 C                   exsr      blddep
0400000210110296 C                   endif
0401000210110296 C                   endif
0402000210110291 C                   leave
0403000210110291  *
0404000210110297 C                   endif                                                  *in42 = '0'
0405000210110291  *
0406000210110297 C                   enddo                                                  *in42 = '0'
0407000210110291  *
040800021011     C                   endsr
040900161130
0410001611300002  *============================================================================
0411001611300107  * BLDDEP - Build Dependent Record
0412001611300002  *============================================================================
041300161130
041400021011     C     blddep        begsr
041500161130
0416001611300291  * Get Dependent record
0417001611300297 C     depky         chain     dependntl1
0418001611300296 C                   If        %found
0419001612010291
042000161201       clear winsFile;
0421001612010291
042200161229       //if X < 17;
042300161229       //chain (P@PLAN(X)) PLANMASTL1;
042400161229       // if %found;
042500161229       //  group# = plremk;
042600161229       // endif;
042700161227
042800161229       //else;
042900161229        chain (svplan2) PLANMASTL1;
043000161229        if %found;
043100161227        group# = plremk;
043200161227       endif;
043300161227
043400161227       carrier = 'COMMSIHP';
043500161227
043600161201       memid = dppartic;
043700161205
043800161205       percd_d = %dec(dpdep:2:0) + 1;
043900161205       percd = %editc(percd_d:'X');
044000161205
044100161205       if dprelat = 'S' or dprelat = 'D';
044200161205        relcd = '02';
044300161205       else;
044400161205        relcd = '03';
044500161205       endif;
044600161205
044700161201       lastname = dplast;
044800161201       firstname = dpfirst;
044900161201       mi = dpmi;
045000161201       gender = dpsex;
045100161201       dateofbth = %char(dpdob);
045200161227       effdate = %char(dqfromdt);
045300161227
045400161227       termdate = %char(dqtodate);
045500161227       if dqtodate = 99999999;
045600161227        termdate = ' ';
045700161227       endif;
045800161227
045900161201    *  address1 = gpaddr1;
046000161201    *  address2 = gpaddr2;
046100161201       city = gpcity;
046200161201       state = gpstate;
046300161201       zip = gpzip;
046400161201
046500161205       exsr $phone;
046600161205       phone = @phone;
046700161205
046800161201       mbrssn = dpssn;
046900161201
047000161205       chgroup = dpgroup;
047100161205       chdate = grtodate;
047200161205       chpartcp = dppartic;
047300161205       exsr checkTermed;
047400161205
047500161205       if termed = 'N';
047600161205        write winsFile;
047700161205       endif;
047800161205
047900161201     C                   endif
048000161201
048100161201     C                   endsr
048200161130
0483001611300002  *============================================================================
048400161130     * CHKVEND - Determine vendor by checking the Group Cov Bill File
0485001611300002  *============================================================================
048600161130
048700031114    C     chkvend       Begsr
048800161130
048900060131     C                   Eval      ehpvend = 'N'
049000161130
049100031114      * Build the Key
049200031114     C                   Eval      GBGROUP   =   pegroup
049300031114     C                   Eval      GBDIV     =   pediv
049400031114     C                   Eval      GBCOVCAT  =   P@COV(X)
049500031114     C                   Eval      GBPLAN    =   P@PLAN(X)
049600031114     C                   Eval      GBENROLL  =   P@ENR(X)
049700161227     C                   Movel(P)  '000450003'   gbbilfor
049800161130
049900031114     C     GrpKey        Setll     GRBILCLCL3
050000031114     C                   Dou       %Eof(GRBILCLCL3)
050100031114     C     GrpKey        Reade     GRBILCLCL3
050200031114     C                   If        Not %Eof(GRBILCLCL3)
050300161227     C                   If        bilfor9 = '000450003'
050400051130     C                   If        (todaa >= gbfrdate and
050500060201     C                             todaa <= gbtodate)
050600161229     c                   eval      svplan2 = gbplan
050700060131     C                   Eval      ehpvend = 'Y'
050800100325     C                   Leavesr
050900031114     C                   End
051000031114     C                   End
051100031114     C                   End
051200161130
051300031114     C                   Enddo
051400161205
051500031114    C                   Endsr
051600161130
0517001611300002  *============================================================================
0518001611300107  * DATESR - Reformat date
0519001611300002  *============================================================================
052000161130
052100060131     C     DATESR        Begsr
052200161130
0523000601310297 C                   movel     dtlmyy        dtehyy
0524000601310297 C                   movel     dtlmmm        dtehmm
0525000601310297 C                   movel     dtlmdd        dtehdd
052600161130
052700060131     C                   Endsr
052800161130
052900161205      //=================================================================
053000161205      // phone
053100161205      //=================================================================
053200161205
053300161205       begsr $phone;
053400161205
053500161227        @phone = ' ';
053600161227        t = 0;
053700161227        r = 0;
053800161227        e = ' ';
053900161227
054000161227       $pos4 = %scan(' ' : gpphone);
054100161227
054200161227       if $pos4 >= 12;
054300161227        leavesr;
054400161227       endif;
054500161227
054600161227     C                   DO        20
054700161227     C                   ADD       1             T
054800161227     C                   EVAL      E = %SUBST(GPPHONE:T:1)
054900161227     C                   IF        E = '1' OR E = '2' OR E = '3' OR E = '4'
055000161227     C                             OR E = '5' OR E = '6' OR E = '7'
055100161227     C                             OR E = '8' OR E = '9' OR E = '0'
055200161227     C                   ADD       1             R
055300161227       monitor;
055400161227     C                   EVAL      %SUBST(@PHONE:R:1) = E
055500161227       on-error;
055600161227       @phone = gpphone;
055700161227       endmon;
055800161227     C                   ENDIF
055900161227     C                   ENDDO
056000161227
056100161227       endsr;
056200161227
056300161205      //=================================================================
056400161205      // phone
056500161205      //=================================================================
056600161205
056700161205       begsr checkTermed;
056800161205
056900161227       termed = 'N';
057000161227
057100161205       chain (chgroup : chpartcp : chdate) termFile;
057200161205       if %found;
057300161205        termed = 'Y';
057400161205       endif;
057500161205
057600161205       if not %found;
057700161205        if chdate > 0;
057800161205         if chdate <> 99999999;
057900161205          termed = 'N';
058000161205           tdate = chdate;
058100161205            partic = chpartcp;
058200161205           group = chgroup;
058300161205          write termFile;
058400161205         endif;
058500161205        endif;
058600161205       endif;
058700161205
058800161205       endsr;
058900161205
0590001611300002  *============================================================================
059100161130      * exit
0592001611300002  *============================================================================
059300161130
059400161130     C     exit          Begsr
059500161130
059600161130     C                   eval      *inlr = '1'
059700161130     C                   return
059800161130
0599001611300297 C                   endsr
0600001611300107
0601001611300002  *============================================================================
060200161130      * Init
0603001611300002  *============================================================================
060400161130
060500161229     C     *inzsr        Begsr
060600161130
060700161130     C     partky        klist
060800161130     C                   kfld                    savgrp#
060900161130     C                   kfld                    svpartic
061000161130      *
061100161130     C     planky        klist
061200161130     C                   kfld                    svplan
061300161130     C                   kfld                    plnk99
061400161130      *
061500161130     C     grdvky        klist
061600161130     C                   kfld                    curgrp#
061700161130     C                   kfld                    curdiv
061800161130      *
061900161130     C     depky         klist
062000161130     C                   kfld                    savgrp#
062100161130     C                   kfld                    svpartic
062200161130     C                   kfld                    svdep
062300161130     *
062400161130     C     GRPKey        Klist
062500161130     C                   Kfld                    GBGROUP
062600161130     C                   Kfld                    GBDIV
062700161130     C                   Kfld                    GBCOVCAT
062800161130     C                   Kfld                    GBPLAN
062900161130     C                   Kfld                    GBENROLL
063000161130     C                   Kfld                    GBBILFOR
063100161130
063200161205
0633000210110297 C                   movel     UDATE         cutoff
0634000210110297 C                   movel     cutoff        todaa
0635000210110297 C                   z-add     99999999      date9
063600161130
0637000509290291  * Determine Term date cutoff - 90 days ago
0638000509290297 C     cutoff        subdur    90:*D         cutoff
0639000210110297 C                   movel     cutoff        cutofn
0640000211040297 C                   movel     UDATE         day30d
0641000211040297 C     day30d        adddur    30:*D         day30d
0642000211040297 C                   movel     day30d        day30n
0643000210110297 C                   movel     *blanks       svpartic
0644001612290297 C                   movel     *blanks       svplan2
0645000210110297 C                   eval      sveff = 99999999
0646000210110297 C                   eval      svterm = 00000000
064700161130
064800021011     C                   Endsr
064900161130
0650001611300002  *============================================================================
