000100981030     F*------------------------------------------------------------------------------------------*
000200081216      * FM022R     GROUP BENIFIT SERVICES SOFTWARE           2008                                *
000300981030      *            WRITTEN BY - R.L.J.                                                           *
000400081205      *            DATE - 12/2008                                                                *
000500081216      *  DESCRIPTION - Maintain Sub Onsite Dental Aux file                                       *
000600981030      *  Technical Specs- This program uses a Load All Subfile technique - this should only be   *
000700981030      *            used when the subfile to be loaded is known to be small ( 100 or less ).      *
000800981105      *  Indicator Usage:                                                                        *
000900981030      *            31     Display Subfile                                                        *
001000981030      *            32     Display Subfile Control                                                *
001100981030      *            33     Clear Subfile                                                          *
001200981030      *            34     Subfile End                                                            *
001300981030      *------------------------------------------------------------------------------------------*
001400081205      * Change Log
001500081205      * xxx mm/dd/yyyy
001600000306      *------------------------------------------------------------------------------------------*
001700081217     FTRSMST    IF   E           K DISK
001800081217     FSUBMST    IF   E           K DISK
001900100722     FODRGNP    IF   E           K DISK
002000090219     FODFACP    UF A E           K DISK
002100090209     FODHYGP    UF A E           K DISK
002200090123     FODDENTP   UF A E           K DISK
002300081216     FFM022D    CF   E             WORKSTN
002400090220     F                                     SFILE(DETOFC:ORRN)
002500090220     F                                     SFILE(DETHYG:HRRN)
002600090123     F                                     SFILE(DETDNT:DRRN)
002700981030      *
002800090327    ?D WCDTA         E DS                  EXTNAME(ODCNTCP) inz
002900090310      *
003000081205     D @PARM           DS
003100081205     D  TRUST#                 1      3S 0
003200090119     D  SUB#                   4      6S 0
003300090119    * *
003400090119     D                 DS
003500090123     D wdnt#           S              5  0
003600090122     D whyg#           S              5  0
003700090220     D wofc#           S              3  0
003800090220     D selof           S              1
003900090220     D selhy           S              1
004000090123     D seldn           S              1
004100090302     D clrfld          S              1
004200090317     D clearadd        S              1
004300090310     D wortn           S              8
004400090223    * *
004500090223     D                 DS
004600090223     D s2zip                   1      9
004700090223     D  szip5                  1      5
004800090223     D  szip4                  6      9
004900090223    * *
005000090223     D                 DS
005100090223     D sdzip                   1     10
005200090119     D  dzip5                  1      5
005300090220     D  dzip                   6      6    INZ('-')
005400090223     D  dzip4                  7     10
005500090220    * *
005600090220     D                 DS
005700090220     D mhzip                   1      9
005800090220     D  mhzip5                 1      5
005900090220     D  mhzip4                 6      9
006000090220    * *
006100090220     D                 DS
006200090123     D odzip                   1      9
006300090220     D  odzip5                 1      5
006400090123     D  odzip4                 6      9
006500090123    * *
006600090123     D                 DS
006700090123     D hdzip                   1     10
006800090123     D  hdzip5                 1      5
006900090123     D  hdzp                   6      6    INZ('-')
007000090123     D  hdzip4                 7     10
007100090123    * *
007200090123     D                 DS
007300090123     D ddzip                   1     10
007400090123     D  ddzip5                 1      5
007500090220     D  ddzp                   6      6    INZ('-')
007600090220     D  ddzip4                 7     10
007700090302    * *
007800090302     D                 DS
007900090302     D s2phon                  1     10
008000090302     D  sph13                  1      3
008100090302     D  sph46                  4      6
008200090302     D  sph710                 7     10
008300090318    * *
008400090318     D                 DS
008500090318     D sdphon                  1     12
008600090318     D  dph13                  1      3
008700090318     D  dph1                   4      4    INZ('-')
008800090217     D  dph46                  5      7
008900090318     D  dph2                   8      8    INZ('-')
009000090319     D  dph710                 9     12
009100090514    * *
009200090514     D                 DS
009300090514     D s2fax                   1     10
009400090514     D  sfx13                  1      3
009500090514     D  sfx46                  4      6
009600090514     D  sfx710                 7     10
009700090514    * *
009800090514     D                 DS
009900090514     D sdfax                   1     12
010000090514     D  dfx13                  1      3
010100090514     D  dfx1                   4      4    INZ('-')
010200090514     D  dfx46                  5      7
010300090514     D  dfx2                   8      8    INZ('-')
010400090514     D  dfx710                 9     12
010500090319    * *
010600090319     D                 DS
010700090319     D mhphon                  1     10
010800090319     D  mhph13                 1      3
010900090319     D  mhph46                 4      6
011000090319     D  mhph710                7     10
011100090319    * *
011200090319     D                 DS
011300090319     D odphon                  1     10
011400090319     D  odph13                 1      3
011500090319     D  odph46                 4      6
011600090213     D  odph710                7     10
011700090213    * *
011800090213     D                 DS
011900090227     D wkdphn                  1     12
012000090227     D  wdph13                 1      3
012100090227     D  wdph1                  4      4    INZ('-')
012200090227     D  wdph46                 5      7
012300090227     D  wdph2                  8      8    INZ('-')
012400090227     D  wdph710                9     12
012500090227    * *
012600090227     D                 DS
012700090227     D hdphon                  1     12
012800090227     D  hdph13                 1      3
012900090227     D  hdph1                  4      4    INZ('-')
013000090227     D  hdph46                 5      7
013100090227     D  hdph2                  8      8    INZ('-')
013200090227     D  hdph710                9     12
013300090121    * *
013400090123     D                 DS
013500090123     D ddphon                  1     12
013600090123     D  ddph13                 1      3
013700090123     D  ddph1                  4      4    INZ('-')
013800090128     D  ddph46                 5      7
013900090128     D  ddph2                  8      8    INZ('-')
014000090128     D  ddph710                9     12
014100090128    * *
014200090128     D                 DS
014300090306     D mhssn#                  1      9
014400090306     D  hssn1                  1      3
014500090306     D  hssn2                  4      5
014600090306     D  hssn3                  6      9
014700081215    * *
014800090128     D                 DS
014900090306     D hdssn                   1     11
015000090306     D  dhsn1                  1      3
015100090306     D  dsn1                   4      4    INZ('-')
015200090306     D  dhsn2                  5      6
015300090306     D  dsn2                   7      7    INZ('-')
015400090306     D  dhsn3                  8     11
015500081215    * *
015600090306     D                 DS
015700090306     D mhdob                   1      8  0
015800090414     D  hdbyy                  1      4
015900090414     D  hdbmm                  5      6
016000090306     D  hdbdd                  7      8
016100090414    * *
016200090414     D                 DS
016300090414     D hddob                   1     10
016400090414     D  dhdbm                  1      2
016500090414     D  dhd1                   3      3    INZ('/')
016600090414     D  dhdbd                  4      5
016700090414     D  dhd2                   6      6    INZ('/')
016800090414     D  dhdby                  7     10
016900090414    * *
017000090414     D                 DS
017100090414     D mheff                   1      8  0
017200090414     D  hefyy                  1      4
017300090414     D  hefmm                  5      6
017400090306     D  hefdd                  7      8
017500090306    * *
017600090306     D                 DS
017700090306     D hdeff                   1     10
017800090306     D  dhefm                  1      2
017900090306     D  dhf1                   3      3    INZ('/')
018000090306     D  dhefd                  4      5
018100090306     D  dhf2                   6      6    INZ('/')
018200090325     D  dhefy                  7     10
018300090325    * *
018400090325     D                 DS
018500090325     D mhtrm                   1      8  0
018600090325     D  htryy                  1      4
018700090325     D  htrmm                  5      6
018800090325     D  htrdd                  7      8
018900090325    * *
019000090319     D                 DS
019100090325     D hdtrm                   1     10
019200090319     D  dhtrm                  1      2
019300090306     D  dht1                   3      3    INZ('/')
019400090306     D  dhtrd                  4      5
019500090306     D  dht2                   6      6    INZ('/')
019600090306     D  dhtry                  7     10
019700090309    * *
019800090309    * *  Dentist fields
019900090309    * *
020000090309     D                 DS
020100090309     D odssn#                  1      9
020200090309     D  dssn1                  1      3
020300090309     D  dssn2                  4      5
020400090309     D  dssn3                  6      9
020500090309    * *
020600090309     D                 DS
020700090309     D ddssn                   1     11
020800090309     D  ddsn1                  1      3
020900090309     D  ddn1                   4      4    INZ('-')
021000090309     D  ddsn2                  5      6
021100090309     D  ddn2                   7      7    INZ('-')
021200090309     D  ddsn3                  8     11
021300090309    * *
021400090309     D                 DS
021500090309     D oddob                   1      8  0
021600090309     D  ddbyy                  1      4
021700090309     D  ddbmm                  5      6
021800090309     D  ddbdd                  7      8
021900090309    * *
022000090309     D                 DS
022100090309     D dddob                   1     10
022200090309     D  dddbm                  1      2
022300090309     D  ddd1                   3      3    INZ('/')
022400090309     D  dddbd                  4      5
022500090319     D  ddd2                   6      6    INZ('/')
022600090319     D  dddby                  7     10
022700090319    * *
022800090406     D                 DS
022900090406     D odeff                   1      8  0
023000090406     D  defyy                  1      4
023100090406     D  defmm                  5      6
023200090406     D  defdd                  7      8
023300090406    * *
023400090406     D                 DS
023500090406     D ddeff                   1     10
023600090406     D  ddefm                  1      2
023700090406     D  ddf1                   3      3    INZ('/')
023800090309     D  ddefd                  4      5
023900090309     D  ddf2                   6      6    INZ('/')
024000090309     D  ddefy                  7     10
024100090309    * *
024200090309     D                 DS
024300090309     D odtrm                   1      8  0
024400090309     D  dtryy                  1      4
024500090309     D  dtrmm                  5      6
024600090309     D  dtrdd                  7      8
024700090309    * *
024800090309     D                 DS
024900090309     D ddterm                  1     10
025000090309     D  ddtrm                  1      2
025100090309     D  ddt1                   3      3    INZ('/')
025200090309     D  ddtrd                  4      5
025300090309     D  ddt2                   6      6    INZ('/')
025400090309     D  ddtry                  7     10
025500090309    * *
025600090309    * *   Facility Fields
025700090309    * *
025800090306     D                 DS
025900090306     D s2eff                   1      8  0
026000090306     D  sefyy                  1      4
026100090306     D  sefmm                  5      6
026200090306     D  sefdd                  7      8
026300090306    * *
026400090306     D                 DS
026500090306     D sdeff                   1     10
026600090309     D  sdefmm                 1      2
026700090306     D  def1                   3      3    INZ('/')
026800090309     D  sdefdd                 4      5
026900090306     D  def2                   6      6    INZ('/')
027000090309     D  sdefyy                 7     10
027100090306    * *
027200081215     D                 DS
027300081217     D sdtrm                   1     10
027400090309     D  odtrmm                 1      2
027500090309     D  odtr1                  3      3    INZ('/')
027600090309     D  odtrdd                 4      5
027700090319     D  odtr2                  6      6    INZ('/')
027800090319     D  odtryy                 7     10
027900090319    * *
028000090319     D                 DS
028100090319     D sceff                   1     10
028200090319     D  cefmm                  1      2
028300090319     D  cef1                   3      3    INZ('/')
028400090319     D  cefdd                  4      5
028500090319     D  cef2                   6      6    INZ('/')
028600090319     D  cefyy                  7     10
028700090319    * *
028800090319     D                 DS
028900090319     D sctrm                   1     10
029000090319     D  ctrmm                  1      2
029100090319     D  ctr1                   3      3    INZ('/')
029200090223     D  ctrdd                  4      5
029300090223     D  ctr2                   6      6    INZ('/')
029400090206     D  ctryy                  7     10
029500090122    * *
029600090206     D                 DS
029700090206     D s2trm                   1      8  0
029800090122     D  stryy                  1      4
029900090122     D  strmm                  5      6
030000090316     D  strdd                  7      8
030100090316    * *
0302000903160053 D                 DS
0303000903160054 D  invdob         C                   'Invalid DOB                        '
0304000903160054 D  inveffd        C                   'Invalid Effective Date             '
0305000903160054 D  invtrmd        C                   'Invalid Term Date                  '
0306000903160054 D  invzip5        C                   'Invalid Zip5 - must be 5 numerics  '
0307000903160054 D  invzip4        C                   'Inv Zip4 - must be 4 num or blank'
0308000903160054 D  invphn         C                   'Invalid Phone# - 10 num or blank'
0309001002190054 D  noemal         C                   'Email address is mandatory      '
0310000905140054 D  invfax         C                   'Invalid Fax# - 10 num or blank'
0311000903160054 D  invhyg         C                   'Invalid Hygienist Number           '
0312000903160054 D  invdnt         C                   'Invalid Dentist Number             '
0313000911060054 D  dupfac         C                   'Facility rec already exists        '
0314000911060054 D  duphyg         C                   'Hygienist# already exists          '
0315000901230054 D  dupdnt         C                   'Dentist# already exists            '
0316000903170054 D  recadd         C                   'Record has been added              '
0317000903170054 D  recchg         C                   'Record has been changed            '
031800090116    * *
031900090206     D USCLAS          S             10
032000090206    * *
032100090206     C     *ENTRY        PLIST
032200090206     C                   PARM                    @PARM
032300090206    * *
032400090206      *
032500081217     C     subkey        klist
032600090206     C                   kfld                    trust#
032700090206     C                   kfld                    sub#
032800090206      *
032900090204     C     fackey        klist
033000090206     C                   kfld                    d2trst
033100090206     C                   kfld                    d2sub#
033200090219      *
033300090219     C     ofckey        klist
033400090219     C                   kfld                    s2trst
033500090219     C                   kfld                    s2ofc#
033600090224      *
033700090224     C     ofckeya       klist
033800090224     C                   kfld                    trust#
033900090224     C                   kfld                    saofc#
034000090224      *
034100090224     C     ofckeyc       klist
034200090224     C                   kfld                    trust#
034300090224     C                   kfld                    scofc#
034400090206      *
034500081217     C     fadkey        klist
034600081217     C                   kfld                    trust#
034700081217     C                   kfld                    sbsub#
034800991116      *
034900090120      *    MAINLINE
035000090120     C     *IN01         DOWEQ     *OFF
035100090120      *
035200090219     C     subkey        chain     ODFACP                             52
035300090219     C                   if        *IN52 = '1'
035400090219     C                   exsr      adddtl
035500090219     C                   else
035600090219     C                   exsr      disdtl
035700090219     C                   endif
035800090219      *
035900090219     C                   if        *IN01 = '1'
036000090219     C                   leave
036100090219     C                   ENDIF
036200090219      *
036300090217     C                   ENDDO
036400090217     C                   MOVE      *ON           *INLR
036500090217     C                   RETURN
036600981030      ******************************************************************
036700090209      *       SUBROUTINE - *INZSR                                      *
036800090209      *                    FIRST PASS LOGIC                            *
036900981030      ******************************************************************
037000081208     C***  *INZSR        BEGSR
037100090115     C*****              ENDSR
037200081208      ******************************************************************
037300090319      *       SUBROUTINE - DISDTL                                      *
037400090319      *                    Dispaly Office Detail                       *
037500081208      ******************************************************************
037600090319     C     disdtl        BEGSR
037700090319     C     *IN01         DOWEQ     *OFF
037800090319     C**** *IN07         ANDEQ     *OFF
037900090319     C     trust#        chain     trsmst
038000090319     C     subkey        chain     submst
038100090319     C     subkey        chain     ODFACP
038200090319      *
038300090319     C                   eval      sdofc# = s2ofc#
038400090319     C                   eval      sdoloc = *blanks
038500100722     C     ofckey        chain     ODRGNP                             53
038600090219     C                   IF        *in53 = *OFF
038700090219     C                   eval      sdoloc = mooloc
038800090219     C                   endif
038900090219      *
039000140321     C                   eval      sdpchn = s2pchn
039100140321      *
039200140321     C                   eval      sdadd1 = s2add1
039300090212     C                   eval      sdadd2 = s2add2
039400090212     C                   eval      sdcity = s2city
039500090204     C                   eval      sdst = s2st
039600090205      *
039700090212     C                   movel     szip5         dzip5
039800090212     C                   movel     szip4         dzip4
039900090212      *
040000090206     C                   movel     sph13         dph13
040100090206     C                   movel     sph46         dph46
040200090206     C                   movel     sph710        dph710
040300090206      *
040400090514     C                   movel     sfx13         dfx13
040500090514     C                   movel     sfx46         dfx46
040600090514     C                   movel     sfx710        dfx710
040700090514      *
040800090309     C                   movel     sefmm         sdefmm
040900090309     C                   movel     sefdd         sdefdd
041000090309     C                   movel     sefyy         sdefyy
041100090206      *
041200090406     C                   movel     strmm         odtrmm
041300090406     C                   movel     strdd         odtrdd
041400090406     C                   movel     stryy         odtryy
041500090406      *
041600090406     C                   eval      sdhyg# = s2hyg#
041700090218     C     s2hyg#        chain     odhygp
041800090406     C                   eval      sdhnam = *blanks
041900090406     C                   eval      sdhnam = %TRIM(mhfnam) + ' ' +
042000090406     C                                      %TRIM(mhlnam)
042100090406      *
042200090406     C                   eval      sddent = s2dent
042300090406     C     s2dent        chain     oddentp
042400090406     C                   eval      sddnam = *blanks
042500090406     C                   eval      sddnam = %TRIM(odfnam) + ' ' +
042600090218     C                                      %TRIM(odlnam)
042700091214      *
042800091214     C                   eval      sdbeds = s2beds
042900090129      *
043000090206     C                   exfmt     disp01
043100090128      *
043200090219     C                   IF        *IN05 = *ON
043300090219     C                   exsr      chgdtl
043400090219     C                   iter
043500090219     C                   endif
043600090227      *
043700090227     C                   IF        *IN08 = *ON
043800090227     C                   exsr      wrkcon
043900090227     C                   iter
044000090227     C                   endif
044100081215      *
044200090219     C*****              IF        *IN01 = *ON
044300090219     C*****              MOVE      *Off          *IN01
044400090219     C*****              leavesr
044500090219     C*****              endif
044600081208      *
044700090406     C                   ENDDO
044800090406      *
044900090406     C                   ENDSR
045000081208      ******************************************************************
045100090406      *       SUBROUTINE - ADDDTL                                      *
045200090406      *                    Add a new Dental Facility Rec               *
045300081208      ******************************************************************
045400090406     C     adddtl        BEGSR
045500090406     C                   eval      selof = 'N'
045600090220     C                   eval      selhy = 'N'
045700090209     C                   eval      seldn = 'N'
045800090306      *
045900090306     C                   eval      smsg = *blanks
046000090306     C                   eval      *in68 = *off
046100090306      *
046200090312     C                   eval      saofc# = 0
046300140321     C                   eval      sapchn = *blanks
046400140321     C                   eval      saadd1 = *blanks
046500090312     C                   eval      saadd2 = *blanks
046600090312     C                   eval      sacity = *blanks
046700090312     C                   eval      sast = *blanks
046800090312     C                   eval      azip5 = *blanks
046900090312     C                   eval      azip4 = *blanks
047000090312     C                   eval      aph13 = *blanks
047100090312     C                   eval      aph46 = *blanks
047200090312     C                   eval      aph710 = *blanks
047300090514     C                   eval      afx13 = *blanks
047400090514     C                   eval      afx46 = *blanks
047500090514     C                   eval      afx710 = *blanks
047600090312     C                   eval      aefmm = *blanks
047700090312     C                   eval      aefdd = *blanks
047800090312     C                   eval      aefyy = *blanks
047900090312     C                   eval      atrmm = *blanks
048000090312     C                   eval      atrdd = *blanks
048100090312     C                   eval      atryy = *blanks
048200090312     C                   eval      sahyg# = 0
048300090312     C                   eval      sadent = 0
048400091214     C                   eval      sabeds = 0
048500090312      *
048600090306     C     trust#        chain     trsmst
048700090306     C     subkey        chain     submst
048800090306      *
048900090209     C     *IN01         DOWEQ     *OFF
049000090209      *
049100090312     C******             if        selof <> 'Y' and
049200090312     C*                            selhy <> 'Y' and
049300090312     C*                            seldn <> 'Y' and
049400090312     C*******                      smsg = *blanks
049500090312      *
049600090312     C*******            endif
049700090114      *
049800090113     C                   exfmt     add01
049900081208      *
050000090128     C                   IF        *IN01 = *ON
050100090309     C                   eval      smsg = *blanks
050200090306     C**                 MOVE      *Off          *IN01
050300090128     C                   leavesr
050400081208     C                   endif
050500090220      *           If F8 => Select Office
050600081208      *
050700090220     C                   eval      selof = 'N'
050800090220     C                   IF        *IN08 = *ON
050900090220     C                   exsr      selofc
051000090224     C                   if        wofc# <> 0
051100090224     C                   eval      selof = 'Y'
051200090224     C                   eval      saofc# = wofc#
051300090224     C                   eval      saoloc = *blanks
051400100722     C     ofckeya       chain     ODRGNP                             53
051500090224     C                   IF        *in53 = *OFF
051600090224     C                   eval      saoloc = mooloc
051700090224     C                   endif
051800090224      *
051900081208     C                   endif
052000090224     C                   endif
052100090220      *           If F9 => Select Hygienist
052200090220      *
052300090220     C                   eval      selhy = 'N'
052400090220     C                   IF        *IN09 = *ON
052500090220     C                   exsr      selhyg
052600090224     C                   if        whyg# <> 0
052700090224     C                   eval      selhy = 'Y'
052800090224     C                   eval      sahyg# = whyg#
052900090224     C     sahyg#        chain     odhygp
053000090224     C                   eval      sahnam = *blanks
053100090224     C                   eval      sahnam = %TRIM(mhfnam) + ' ' +
053200090224     C                                      %TRIM(mhlnam)
053300090224      *
053400090220     C                   endif
053500090224     C                   endif
053600090123      *           If F11 => Select Dentist
053700090123      *
053800090123     C                   eval      seldn = 'N'
053900090123     C                   IF        *IN11 = *ON
054000090123     C                   exsr      seldnt
054100090224     C                   if        wdnt# <> 0
054200090224     C                   eval      seldn = 'Y'
054300090224     C                   eval      sadent = wdnt#
054400090224     C     sadent        chain     oddentp
054500090224     C                   eval      sadnam = *blanks
054600090224     C                   eval      sadnam = %TRIM(odfnam) + ' ' +
054700090224     C                                      %TRIM(odlnam)
054800090224      *
054900090123     C                   endif
055000090224     C                   endif
055100090105      *           If F5 => Add new rec - edit Fields
055200090105      *
055300090105     C                   IF        *IN05 = *ON
055400091106      *
055500091106     C     fadkey        chain     ODFACP                             21
055600091106     C                   IF        *IN21 = *Off
055700091106     C                   eval      smsg = *blanks
055800091106     C                   eval      smsg = dupfac
055900091106     C                   iter
056000091106     C                   endif
056100091106      *
056200090306     C                   testn                   azip5                21
056300090306     C                   if        *in21 = *OFF
056400090306     C                   eval      smsg = invzip5
056500090306     C                   eval      *in68 = *on
056600090306     C                   iter
056700090306     C                   endif
056800090306      *
056900090306     C                   testn                   azip4                21
057000090306     C                   if        *in21 = *OFF and azip4 <> *blanks
057100090306     C                   eval      smsg = invzip4
057200090306     C                   eval      *in68 = *on
057300090306     C                   iter
057400090306     C                   endif
057500090306      *
057600090306     C                   if        aph13 <> *blanks or
057700090306     C                             aph46 <> *blanks or
057800090306     C                             aph710 <> *blanks
057900090306     C                   testn                   aph13                21
058000090306     C                   testn                   aph46                22
058100090306     C                   testn                   aph710               23
058200090306     C                   if        *IN21 = *OFF or *in22 = *OFF or
058300090306     C                             *IN23 = *OFF
058400090306     C                   eval      smsg = invphn
058500090306     C                   eval      *in68 = *on
058600090306     C                   iter
058700090306     C                   endif
058800090306     C                   endif
058900090514      *
059000090514     C                   if        afx13 <> *blanks or
059100090514     C                             afx46 <> *blanks or
059200090514     C                             afx710 <> *blanks
059300090514     C                   testn                   afx13                21
059400090514     C                   testn                   afx46                22
059500090514     C                   testn                   afx710               23
059600090514     C                   if        *IN21 = *OFF or *in22 = *OFF or
059700090514     C                             *IN23 = *OFF
059800090514     C                   eval      smsg = invfax
059900090514     C                   eval      *in68 = *on
060000090514     C                   iter
060100090514     C                   endif
060200090514     C                   endif
060300090306      *
060400090306     C                   If        aefyy = '    '
060500090306     C                   movel     0000          sefyy
060600090306     C                   else
060700090306     C                   movel     aefyy         sefyy
060800090306     C                   endif
060900090306     C                   If        aefmm = '  '
061000090306     C                   movel     00            sefmm
061100090306     C                   else
061200090306     C                   movel     aefmm         sefmm
061300090306     C                   endif
061400090306     C                   If        aefdd = '  '
061500090306     C                   movel     00            sefdd
061600090306     C                   else
061700090306     C                   movel     aefdd         sefdd
061800090306     C                   endif
061900090306      *
062000090306     C                   test(D)                 s2eff                  21
062100090306     C                   if        *in21 = *ON
062200090306     C                   eval      smsg = inveffd
062300090306     C                   eval      *in68 = *on
062400090306     C                   iter
062500090306     C                   endif
062600090306      *
062700090306     C                   If        atryy = '    '
062800090306     C                   movel     0000          stryy
062900090306     C                   else
063000090306     C                   movel     atryy         stryy
063100090306     C                   endif
063200090306     C                   If        atrmm = '  '
063300090306     C                   movel     00            strmm
063400090306     C                   else
063500090306     C                   movel     atrmm         strmm
063600090306     C                   endif
063700090306     C                   If        atrdd = '  '
063800090306     C                   movel     00            strdd
063900090306     C                   else
064000090306     C                   movel     atrdd         strdd
064100090306     C                   endif
064200090306      *
064300090306     C                   If        motrm <> 0
064400090306     C                   test(D)                 s2trm                  21
064500090306     C                   if        *in21 = *ON
064600090306     C                   eval      smsg = invtrmd
064700090306     C                   eval      *in68 = *on
064800090306     C                   iter
064900090306     C                   endif
065000090306     C                   endif
065100090306      *
065200081208      *  Add record
065300090223     C                   eval      s2trst = trust#
065400090223     C                   eval      s2sub# = sbsub#
065500090223     C                   eval      s2ofc# = saofc#
065600140321     C                   eval      s2pchn = sapchn
065700140321     C                   eval      s2add1 = saadd1
065800090223     C                   eval      s2add2 = saadd2
065900090120     C                   eval      s2city = sacity
066000090120     C                   eval      s2st = sast
066100090120     C                   movel     azip5         s2zip
066200090212     C                   move      azip4         s2zip
066300090212     C                   eval      sph13 = aph13
066400090212     C                   eval      sph46 = aph46
066500090212     C                   eval      sph710 = aph710
066600090514     C                   eval      sfx13 = afx13
066700090514     C                   eval      sfx46 = afx46
066800090514     C                   eval      sfx710 = afx710
066900081224      *
067000081224     C                   eval      s2hyg# = sahyg#
067100090122     C                   eval      s2dent = sadent
067200081218      *
067300091214     C                   eval      s2beds = sabeds
067400091214      *
067500090209     C                   write     ODFACR
067600081208      *
067700081218     C                   MOVE      *OFF          *IN05
067800081218     C                   endif
067900081208      *
068000081208     C                   ENDDO
068100081208      *
068200081208     C                   ENDSR
068300081208      ******************************************************************
068400081208      *       SUBROUTINE - CHGDTL                                      *
068500081217      *                    Change facility Detail                       *
068600081208      ******************************************************************
068700081208     C     chgdtl        BEGSR
068800090306      *
068900090306     C                   eval      smsg = *blanks
069000090306     C                   eval      *in68 = *off
069100090306      *
069200090224     C                   eval      selof = 'N'
069300090224     C                   eval      selhy = 'N'
069400090224     C                   eval      seldn = 'N'
069500090306      *
069600090306     C     trust#        chain     trsmst
069700090306     C     subkey        chain     submst
069800090306      *
069900081208     C     *IN01         DOWEQ     *OFF
070000090224      *
070100090224     C                   if        selof <> 'Y' and
070200090224     C                             selhy <> 'Y' and
070300090306     C                             seldn <> 'Y' and
070400090306     C                             smsg = *blanks
070500090306      *
070600090219     C     subkey        chain     ODFACP
070700090219      *
070800090219     C                   eval      scofc# = s2ofc#
070900090219     C                   eval      scoloc = *blanks
071000100722     C     ofckey        chain     ODRGNP                             53
071100090219     C                   IF        *in53 = *OFF
071200090219     C                   eval      scoloc = mooloc
071300090219     C                   endif
071400090219      *
071500140321     C                   eval      scpchn = s2pchn
071600140321      *
071700140321     C                   eval      scadd1 = s2add1
071800081217     C                   eval      scadd2 = s2add2
071900081217     C                   eval      sccity = s2city
072000081217     C                   eval      scst = s2st
072100081208      *
072200081217     C                   movel     szip5         czip5
072300081217     C                   movel     szip4         czip4
072400081208      *
072500081217     C                   movel     sph13         cph13
072600081217     C                   movel     sph46         cph46
072700081217     C                   movel     sph710        cph710
072800081208      *
072900090514     C                   movel     sfx13         cfx13
073000090514     C                   movel     sfx46         cfx46
073100090514     C                   movel     sfx710        cfx710
073200090514      *
073300081217     C                   movel     sefmm         cefmm
073400081217     C                   movel     sefdd         cefdd
073500081217     C                   movel     sefyy         cefyy
073600081215      *
073700081217     C                   movel     strmm         ctrmm
073800081217     C                   movel     strdd         ctrdd
073900081217     C                   movel     stryy         ctryy
074000081208      *
074100081224     C                   eval      schyg# = s2hyg#
074200090218     C     s2hyg#        chain     odhygp
074300090218     C                   eval      schnam = *blanks
074400090218     C                   eval      schnam = %TRIM(mhfnam) + ' ' +
074500090218     C                                      %TRIM(mhlnam)
074600090218      *
074700090218     C                   eval      scdent = s2dent
074800090218     C     s2dent        chain     oddentp
074900090218     C                   eval      scdnam = *blanks
075000090218     C                   eval      scdnam = %TRIM(odfnam) + ' ' +
075100090218     C                                      %TRIM(odlnam)
075200091214      *
075300091214     C                   eval      scbeds = s2beds
075400081224      *
075500090224     C                   endif
075600090224      *
075700090224     C                   exfmt     chg01
075800081208      *
075900081215     C*****              IF        *IN07 = *ON or *IN01 = *ON
076000081215     C**                 MOVE      *ON           *INLR
076100081215     C**                 return
076200081215     C****               endif
076300081215      *
076400081215     C                   IF        *IN01 = *ON
076500090309     C                   eval      smsg = *blanks
076600081215     C                   MOVE      *Off          *IN01
076700081215     C                   leavesr
076800081215     C                   endif
076900090224      *           If F8 => Select Office
077000090224      *
077100090224     C                   eval      selof = 'N'
077200090224     C                   IF        *IN08 = *ON
077300090224     C                   exsr      selofc
077400090224     C                   if        wofc# <> 0
077500090224     C                   eval      selof = 'Y'
077600090224     C                   eval      scofc# = wofc#
077700090224     C                   eval      scoloc = *blanks
077800100722     C     ofckeyc       chain     ODRGNP                             53
077900090224     C                   IF        *in53 = *OFF
078000090224     C                   eval      scoloc = mooloc
078100090224     C                   endif
078200090224      *
078300110303     C                   iter
078400110303     C                   endif
078500090224     C                   endif
078600090224      *           If F9 => Select Hygienist
078700090224      *
078800090224     C                   eval      selhy = 'N'
078900090224     C                   IF        *IN09 = *ON
079000090224     C                   exsr      selhyg
079100090224     C                   if        whyg# <> 0
079200090224     C                   eval      selhy = 'Y'
079300090224     C                   eval      schyg# = whyg#
079400090316     C     schyg#        chain     odhygp
079500090316     C                   eval      schnam = *blanks
079600090316     C                   eval      schnam = %TRIM(mhfnam) + ' ' +
079700090316     C                                      %TRIM(mhlnam)
079800090224      *
079900110303     C                   iter
080000110303     C                   endif
080100090316     C                   endif
080200090316      *           If F11 => Select Dentist
080300090316      *
080400090316     C                   eval      seldn = 'N'
080500090316     C                   IF        *IN11 = *ON
080600090224     C                   exsr      seldnt
080700090224     C                   if        wdnt# <> 0
080800090224     C                   eval      seldn = 'Y'
080900090224     C                   eval      scdent = wdnt#
081000090224     C     scdent        chain     oddentp
081100090224     C                   eval      scdnam = *blanks
081200090224     C                   eval      scdnam = %TRIM(odfnam) + ' ' +
081300090224     C                                      %TRIM(odlnam)
081400090224      *
081500110303     C                   iter
081600110303     C                   endif
081700090224     C                   endif
081800110303      *           ENTER => Change rec - edit Fields
081900081208      *
082000110303     C**********         IF        *IN05 = *ON
082100090306      *
082200090306     C                   eval      smsg = *blanks
082300090306     C                   eval      *in68 = *off
082400090306      *
082500090306     C                   testn                   czip5                21
082600090306     C                   if        *in21 = *OFF
082700090306     C                   eval      smsg = invzip5
082800090306     C                   eval      *in68 = *on
082900090306     C                   iter
083000090306     C                   endif
083100090306      *
083200090306     C                   testn                   czip4                21
083300090306     C                   if        *in21 = *OFF and czip4 <> *blanks
083400090306     C                   eval      smsg = invzip4
083500090306     C                   eval      *in68 = *on
083600090306     C                   iter
083700090306     C                   endif
083800090306      *
083900090306     C                   if        cph13 <> *blanks or
084000090306     C                             cph46 <> *blanks or
084100090306     C                             cph710 <> *blanks
084200090306     C                   testn                   cph13                21
084300090306     C                   testn                   cph46                22
084400090306     C                   testn                   cph710               23
084500090306     C                   if        *IN21 = *OFF or *in22 = *OFF or
084600090306     C                             *IN23 = *OFF
084700090306     C                   eval      smsg = invphn
084800090306     C                   eval      *in68 = *on
084900090306     C                   iter
085000090306     C                   endif
085100090306     C                   endif
085200090514      *
085300090514     C                   if        cfx13 <> *blanks or
085400090514     C                             cfx46 <> *blanks or
085500090514     C                             cfx710 <> *blanks
085600090514     C                   testn                   cfx13                21
085700090514     C                   testn                   cfx46                22
085800090514     C                   testn                   cfx710               23
085900090514     C                   if        *IN21 = *OFF or *in22 = *OFF or
086000090514     C                             *IN23 = *OFF
086100090514     C                   eval      smsg = invfax
086200090514     C                   eval      *in68 = *on
086300090514     C                   iter
086400090514     C                   endif
086500090514     C                   endif
086600090306      *
086700090306     C                   If        cefyy = '    '
086800090306     C                   movel     0000          sefyy
086900090306     C                   else
087000090306     C                   movel     cefyy         sefyy
087100090306     C                   endif
087200090306     C                   If        cefmm = '  '
087300090306     C                   movel     00            sefmm
087400090306     C                   else
087500090306     C                   movel     cefmm         sefmm
087600090306     C                   endif
087700090306     C                   If        cefdd = '  '
087800090306     C                   movel     00            sefdd
087900090306     C                   else
088000090306     C                   movel     cefdd         sefdd
088100090306     C                   endif
088200090306      *
088300090306     C                   test(D)                 s2eff                  21
088400090306     C                   if        *in21 = *ON
088500090306     C                   eval      smsg = inveffd
088600090306     C                   eval      *in68 = *on
088700090306     C                   iter
088800090306     C                   endif
088900090306      *
089000090306     C                   If        ctryy = '    '
089100090306     C                   movel     0000          stryy
089200090306     C                   else
089300090306     C                   movel     ctryy         stryy
089400090306     C                   endif
089500090306     C                   If        ctrmm = '  '
089600090306     C                   movel     00            strmm
089700090306     C                   else
089800090306     C                   movel     ctrmm         strmm
089900090306     C                   endif
090000090306     C                   If        ctrdd = '  '
090100090306     C                   movel     00            strdd
090200090306     C                   else
090300090306     C                   movel     ctrdd         strdd
090400090306     C                   endif
090500090306      *
090600090306     C                   If        s2trm <> 0
090700090306     C                   test(D)                 s2trm                  21
090800090306     C                   if        *in21 = *ON
090900090306     C                   eval      smsg = invtrmd
091000090306     C                   eval      *in68 = *on
091100090306     C                   iter
091200090306     C                   endif
091300090306     C                   endif
091400090306      *    Update Changed Record
091500090129      *
091600090219     C                   eval      s2ofc# = scofc#
091700140321     C                   eval      s2pchn = scpchn
091800140321     C                   eval      s2add1 = scadd1
091900090129     C                   eval      s2add2 = scadd2
092000090129     C                   eval      s2city = sccity
092100090129     C                   eval      s2st = scst
092200081217     C                   eval      szip5 = czip5
092300090129     C                   eval      szip4 = czip4
092400081217     C                   eval      sph13 = cph13
092500090129     C                   eval      sph46 = cph46
092600081217     C                   eval      sph710 = cph710
092700090514     C                   eval      sfx13 = cfx13
092800090514     C                   eval      sfx46 = cfx46
092900090514     C                   eval      sfx710 = cfx710
093000081224      *
093100081224     C                   eval      s2hyg# = schyg#
093200090128     C                   eval      s2dent = scdent
093300091214     C                   eval      s2beds = scbeds
093400090128      *
093500090209     C                   update    ODFACR
093600090128      *
093700110303     C******             endif
093800090128      *
093900090128     C                   ENDDO
094000090128      *
094100090128     C                   ENDSR
094200090105      ******************************************************************
094300090220      *       SUBROUTINE - SELOFC                                      *
094400090220      *                    Select the Office                           *
094500090105      ******************************************************************
094600090220     C     selofc        BEGSR
094700090105     C     *IN01         DOWEQ     *OFF
094800090105     C***  *IN07         ANDEQ     *OFF
094900090128      *
095000090220     C                   EXSR      $OCLEAR
095100090220     C                   EXSR      $OLOAD
095200090220     C                   EXSR      $ODISPLAY
095300090128      *    PROCESS SELECTION
095400090128     C     *IN01         IFEQ      *OFF
095500090128     C***  *IN07         ANDEQ     *OFF
095600090105     C***  RRN           ANDNE     *ZERO
095700090220     C                   eval      wofc# = 0
095800090220     C                   EXSR      $OPROCES
095900090220     C                   If        wofc# <> 0
096000090113     C                   leavesr
096100090113     C                   ENDIF
096200090113     C                   ENDIF
096300090105     C                   ENDDO
096400090105      *
096500090105     C                   movel     '0'           *in01
096600090105     C                   ENDSR
096700090105      ******************************************************************
096800090220      *       SUBROUTINE - $OCLEAR                                      *
096900090105      *                    CLEAR SUBF AND RRN                          *
097000090105      ******************************************************************
097100090220     C     $OCLEAR       BEGSR
097200090220     C                   MOVEA     '001'         *IN(61)
097300090220     C                   WRITE     HDOFC
097400090220     C                   Z-ADD     *ZERO         ORRN              3 0
097500090220     C                   WRITE     HDOFC
097600090220     C                   MOVEA     '010'         *IN(61)
097700090105     C                   ENDSR
097800090105      ******************************************************************
097900090220      *       SUBROUTINE - $OLOAD                                       *
098000090220      *                    LOAD SUBFILE W/ Office Info                  *
098100090105      ******************************************************************
098200090220     C     $OLOAD        BEGSR
098300100722     C     trust#        SETLL     ODRGNP
098400090220     C                   SETOFF                                       6496
098500090220     C     *IN64         DOUEQ     *ON
098600090105     C     *IN96         OREQ      *ON
098700100722     C                   READ      ODRGNP                                 64
098800090220     C                   IF        (*In64 <> *ON)
098900090105      *
099000090220     C                   IF        motrst <> trust#
099100090220     C                   leave
099200090220     C                   endif
099300090105      *
099400090220     C                   ADD       1             ORRN
099500090220     C                   MOVEL     motrst        dotrst
099600090220     C                   MOVEL     moofc#        doofc#
099700090220     C                   MOVEL     mooloc        dooloc
099800090220     C                   WRITE     DETOFC
099900090105     C                   ENDIF
100000090105      *
100100090105     C                   ENDDO
100200090105     C                   ENDSR
100300090105      ******************************************************************
100400090220      *       SUBROUTINE - $ODISPLAY                                    *
100500090105      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
100600090105      ******************************************************************
100700090220     C     $ODISPLAY     BEGSR
100800090220     C                   If        ORRN <> *Zero
100900090220     C                   MOVE      *ON           *IN61
101000090105     C                   ENDIF
101100090220     C                   WRITE     TRAILOF
101200090220     C                   EXFMT     HDOFC
101300090105     C                   ENDSR
101400090105      ******************************************************************
101500090220      *       SUBROUTINE - $OPROCES                                     *
101600090105      *                    PROCESS THE SELECTION                       *
101700090105      ******************************************************************
101800090220     C     $OPROCES      BEGSR
101900090105     C     *IN96         DOUEQ     *ON
102000090105      *
102100090220     C                   READC     DETOFC                                 96
102200090105     C                   IF        *IN96 = *OFF
102300090113      *      Select Hyg
102400090220     C                   IF        SEL3 = '1'
102500090220     C                   eval      wofc# = doofc#
102600090113     C                   leavesr
102700090113     C                   endif
102800090105      *
102900090105     C                   CLEAR                   SEL2
103000090105     C                   UPDATE    DETHYG
103100090105     C                   ENDIF
103200090105     C                   ENDDO
103300090105     C                   ENDSR
103400090220      ******************************************************************
103500090220      *       SUBROUTINE - SELHYG                                      *
103600090220      *                    Select the hygienist                        *
103700090220      ******************************************************************
103800090220     C     selhyg        BEGSR
103900090220     C     *IN01         DOWEQ     *OFF
104000090220     C***  *IN07         ANDEQ     *OFF
104100090220      *
104200090220     C                   EXSR      $HCLEAR
104300090220     C                   EXSR      $HLOAD
104400090220     C                   EXSR      $HDISPLAY
104500090220      *    PROCESS SELECTION
104600090220     C     *IN01         IFEQ      *OFF
104700090220     C***  *IN07         ANDEQ     *OFF
104800090220     C***  RRN           ANDNE     *ZERO
104900090220     C                   eval      whyg# = 0
105000090220     C                   EXSR      $HPROCES
105100090220     C                   If        whyg# <> 0
105200090220     C                   eval      sahyg# = whyg#
105300090220     C                   leavesr
105400090220     C                   ENDIF
105500090220     C                   ENDIF
105600090220     C                   ENDDO
105700090220      *
105800090220     C                   movel     '0'           *in01
105900090220     C                   ENDSR
106000090220      ******************************************************************
106100090220      *       SUBROUTINE - $HCLEAR                                      *
106200090220      *                    CLEAR SUBF AND RRN                          *
106300090220      ******************************************************************
106400090220     C     $HCLEAR       BEGSR
106500090220     C                   MOVEA     '001'         *IN(41)
106600090220     C                   WRITE     HDHYG
106700090220     C                   Z-ADD     *ZERO         HRRN              3 0
106800090220     C                   WRITE     HDHYG
106900090220     C                   MOVEA     '010'         *IN(41)
107000090220     C                   ENDSR
107100090220      ******************************************************************
107200090220      *       SUBROUTINE - $HLOAD                                       *
107300090220      *                    LOAD SUBFILE W/ Hygienist Info              *
107400090220      ******************************************************************
107500090220     C     $HLOAD        BEGSR
107600090220     C     *LOVAL        SETLL     ODHYGP
107700090220     C                   SETOFF                                       4496
107800090220     C     *IN44         DOUEQ     *ON
107900090220     C     *IN96         OREQ      *ON
108000090220     C                   READ      ODHYGP                                 44
108100090220     C                   IF        (*In44 <> *ON)
108200090220      *
108300090220     C***                IF        mhtrst <> trust# or mhsub# <> sub#
108400090220     C***                leave
108500090220     C***                endif
108600090220      *
108700090220     C                   ADD       1             HRRN
108800090220     C                   MOVEL     mhhyg#        dhhyg#
108900090220     C                   MOVEL     mhlnam        dhlnam
109000090220     C                   MOVEL     mhfnam        dhfnam
109100090220     C                   WRITE     DETHYG
109200090220     C                   ENDIF
109300090220      *
109400090220     C                   ENDDO
109500090220     C                   ENDSR
109600090220      ******************************************************************
109700090220      *       SUBROUTINE - $HDISPLAY                                    *
109800090220      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
109900090220      ******************************************************************
110000090220     C     $HDISPLAY     BEGSR
110100090220     C                   If        HRRN <> *Zero
110200090220     C                   MOVE      *ON           *IN41
110300090220     C                   ENDIF
110400090220     C                   WRITE     TRAILHY
110500090220     C                   EXFMT     HDHYG
110600090220     C                   ENDSR
110700090220      ******************************************************************
110800090220      *       SUBROUTINE - $HPROCES                                     *
110900090220      *                    PROCESS THE SELECTION                       *
111000090220      ******************************************************************
111100090220     C     $HPROCES      BEGSR
111200090220     C     *IN96         DOUEQ     *ON
111300090220      *      Add new record
111400090220     C                   IF        *in10 = *ON
111500090220     C                   exsr      addhyg
111600090220     C                   eval      *in10 = *OFF
111700090220     C                   iter
111800090220     C                   endif
111900090220      *
112000090220     C                   READC     DETHYG                                 96
112100090220     C                   IF        *IN96 = *OFF
112200090220      *      Select Hyg
112300090220     C                   IF        SEL2 = '1'
112400090220     C                   eval      whyg# = dhhyg#
112500090220     C                   leavesr
112600090220     C                   endif
112700090220      *      Display detail
112800090220     C                   IF        SEL2 = '5'
112900090220     C                   exsr      dishyg
113000090220     C                   else
113100090220      *      Display detail
113200090220     C                   IF        SEL2 = '2'
113300090220     C                   exsr      chghyg
113400090220     C                   endif
113500090220     C                   endif
113600090220      *
113700090220     C                   CLEAR                   SEL2
113800090220     C                   UPDATE    DETHYG
113900090220     C                   ENDIF
114000090220     C                   ENDDO
114100090220     C                   ENDSR
114200090113      ******************************************************************
114300090113      *       SUBROUTINE - ADDHYG                                      *
114400090113      *                    Add a new Dental Hygienist Rec              *
114500090113      ******************************************************************
114600090113     C     addhyg        BEGSR
114700090309      *
114800090309     C                   eval      smsg = *blanks
114900090309     C                   eval      *in68 = *off
115000090317     C                   eval      clearadd = 'Y'
115100090317      *
115200090317     C     *IN01         DOWEQ     *OFF
115300090317      *
115400090317     C                   if        clearadd = 'Y'
115500090312      *
115600090312     C     99999         setgt     ODHYGP
115700090312     C                   readp     ODHYGP                                 23
115800090312     C                   if        *IN23 = *ON
115900090312     C                   eval      ahhyg# = 1
116000090312     C                   else
116100090312     C                   eval      ahhyg# = mhhyg# + 1
116200090312     C                   endif
116300090312      *
116400090312     C                   eval      ahlnam = *blanks
116500090312     C                   eval      ahfnam = *blanks
116600090312     C                   eval      ahadd1 = *blanks
116700090312     C                   eval      ahadd2 = *blanks
116800090312     C                   eval      ahcity = *blanks
116900090312     C                   eval      ahst = *blanks
117000090312     C                   eval      hzip5 = *blanks
117100090312     C                   eval      hzip4 = *blanks
117200090312     C                   eval      hph13 = *blanks
117300090312     C                   eval      hph46 = *blanks
117400090312     C                   eval      hph710 = *blanks
117500090312     C                   eval      ahemal = *blanks
117600090312     C                   eval      hasn1 = *blanks
117700090312     C                   eval      hasn2 = *blanks
117800090312     C                   eval      hasn3 = *blanks
117900090312     C                   eval      hadbm = *blanks
118000090312     C                   eval      hadbd = *blanks
118100090312     C                   eval      hadby = *blanks
118200090312     C                   eval      haefm = *blanks
118300090312     C                   eval      haefd = *blanks
118400090312     C                   eval      haefy = *blanks
118500090312     C                   eval      hatrm = *blanks
118600090312     C                   eval      hatrd = *blanks
118700090312     C                   eval      hatry = *blanks
118800090312      *
118900090317     C                   eval      clearadd = 'N'
119000090317      *
119100090317     C                   endif
119200090309      *
119300090309     C                   exfmt     add02
119400090113      *
119500090113     C                   IF        *IN01 = *ON
119600090309     C                   eval      smsg = *blanks
119700090113     C                   MOVE      *Off          *IN01
119800090113     C                   leavesr
119900090113     C                   endif
120000090113      *           If F5 => Add new rec - edit Fields
120100090113      *
120200090320     C******             IF        *IN05 = *ON
120300090113      *
120400090309     C                   eval      smsg = *blanks
120500090309     C                   eval      *in68 = *off
120600090309      *
120700090113     C                   if        ahhyg# = 0
120800090113     C                   eval      smsg = *blanks
120900090113     C                   eval      smsg = invhyg
121000090113     C                   iter
121100090113     C                   endif
121200090113      *
121300090209     C     ahhyg#        chain     ODHYGP                             21
121400090113     C                   IF        *IN21 = *Off
121500090113     C                   eval      smsg = *blanks
121600090113     C                   eval      smsg = duphyg
121700090113     C                   iter
121800090113     C                   endif
121900090309      *
122000090309     C                   testn                   hzip5                21
122100090309     C                   if        *in21 = *OFF
122200090309     C                   eval      smsg = invzip5
122300090309     C                   eval      *in68 = *on
122400090309     C                   iter
122500090309     C                   endif
122600090309      *
122700090309     C                   testn                   hzip4                21
122800090309     C                   if        *in21 = *OFF and hzip4 <> *blanks
122900090309     C                   eval      smsg = invzip4
123000090309     C                   eval      *in68 = *on
123100090309     C                   iter
123200090309     C                   endif
123300100219      *
123400100316      *        Removed per CW 3/14/10
123500100316     C*******            if        ahemal = *blanks
123600100316     C***                eval      smsg = noemal
123700100316     C***                eval      *in68 = *on
123800100316     C***                iter
123900100316     C*******            endif
124000090309      *
124100090309     C                   if        hph13 <> *blanks or
124200090309     C                             hph46 <> *blanks or
124300090309     C                             hph710 <> *blanks
124400090309     C                   testn                   hph13                21
124500090309     C                   testn                   hph46                22
124600090309     C                   testn                   hph710               23
124700090309     C                   if        *IN21 = *OFF or *in22 = *OFF or
124800090309     C                             *IN23 = *OFF
124900090309     C                   eval      smsg = invphn
125000090309     C                   eval      *in68 = *on
125100090309     C                   iter
125200090309     C                   endif
125300090309     C                   endif
125400090309      *
125500090309     C                   If        hadby = '    '
125600090309     C                   movel     0000          hdbyy
125700090309     C                   else
125800090309     C                   movel     hadby         hdbyy
125900090309     C                   endif
126000090309     C                   If        hadbm = '  '
126100090309     C                   movel     00            hdbmm
126200090309     C                   else
126300090309     C                   movel     hadbm         hdbmm
126400090309     C                   endif
126500090309     C                   If        hadbd = '  '
126600090309     C                   movel     00            hdbdd
126700090309     C                   else
126800090309     C                   movel     hadbd         hdbdd
126900090309     C                   endif
127000090309      *
127100090309     C                   test(D)                 mhdob                  21
127200090309     C                   if        *in21 = *ON
127300090309     C                   eval      smsg = invdob
127400090309     C                   eval      *in68 = *on
127500090309     C                   iter
127600090309     C                   endif
127700090309      *
127800090309     C                   If        haefy = '    '
127900090309     C                   movel     0000          hefyy
128000090309     C                   else
128100090309     C                   movel     haefy         hefyy
128200090309     C                   endif
128300090309     C                   If        haefm = '  '
128400090309     C                   movel     00            hefmm
128500090309     C                   else
128600090309     C                   movel     haefm         hefmm
128700090309     C                   endif
128800090309     C                   If        haefd = '  '
128900090309     C                   movel     00            hefdd
129000090309     C                   else
129100090309     C                   movel     haefd         hefdd
129200090309     C                   endif
129300090309      *
129400090309     C                   test(D)                 mheff                  21
129500090309     C                   if        *in21 = *ON
129600090309     C                   eval      smsg = inveffd
129700090309     C                   eval      *in68 = *on
129800090309     C                   iter
129900090309     C                   endif
130000090309      *
130100090309     C                   If        hatry = '    '
130200090309     C                   movel     0000          htryy
130300090309     C                   else
130400090309     C                   movel     hatry         htryy
130500090309     C                   endif
130600090309     C                   If        hatrm = '  '
130700090309     C                   movel     00            htrmm
130800090309     C                   else
130900090309     C                   movel     hatrm         htrmm
131000090309     C                   endif
131100090309     C                   If        hatrd = '  '
131200090309     C                   movel     00            htrdd
131300090309     C                   else
131400090309     C                   movel     hatrd         htrdd
131500090309     C                   endif
131600090309      *
131700090309     C                   If        mhtrm <> 0
131800090309     C                   test(D)                 mhtrm                  21
131900090309     C                   if        *in21 = *ON
132000090309     C                   eval      smsg = invtrmd
132100090309     C                   eval      *in68 = *on
132200090309     C                   iter
132300090309     C                   endif
132400090309     C                   endif
132500090309      *
132600090113      *  Add record
132700090113     C                   eval      mhhyg# = ahhyg#
132800090113     C                   eval      mhlnam = ahlnam
132900090113     C                   eval      mhfnam = ahfnam
133000090113     C                   eval      mhadd1 = ahadd1
133100090113     C                   eval      mhadd2 = ahadd2
133200090113     C                   eval      mhcity = ahcity
133300090113     C                   eval      mhst = ahst
133400090113     C                   movel     hzip5         mhzip
133500090113     C                   move      hzip4         mhzip
133600090113     C                   eval      mhph13 = hph13
133700090113     C                   eval      mhph46 = hph46
133800090113     C                   eval      mhph710 = hph710
133900090309      *
134000090512     C                   movel     hasn1         hssn1
134100090512     C                   movel     hasn2         hssn2
134200090512     C                   movel     hasn3         hssn3
134300090309      *
134400090113     C                   eval      mhemal = ahemal
134500090113      *
134600090209     C                   write     ODHYGR
134700090317     C                   eval      smsg = recadd
134800090317     C                   eval      *in68 = *on
134900090317      *
135000090317     C                   eval      clearadd = 'Y'
135100090113      *
135200090113     C                   MOVE      *OFF          *IN05
135300090320     C****               endif
135400090113      *
135500090113     C                   ENDDO
135600090113      *
135700090113     C                   ENDSR
135800090113      ******************************************************************
135900090113      *       SUBROUTINE - DISHYG                                      *
136000090113      *                    Dispaly Hygienist                           *
136100090113      ******************************************************************
136200090113     C     dishyg        BEGSR
136300090113     C     *IN01         DOWEQ     *OFF
136400090209     C     dhhyg#        chain     ODHYGP
136500090113      *
136600090113     C                   movel     mhzip5        hdzip5
136700090113     C                   movel     mhzip4        hdzip4
136800090113      *
136900090114     C                   movel     mhph13        hdph13
137000090114     C                   movel     mhph46        hdph46
137100090114     C                   movel     mhph710       hdph710
137200090306      *
137300090306     C                   movel     hssn1         dhsn1
137400090306     C                   movel     hssn2         dhsn2
137500090306     C                   movel     hssn3         dhsn3
137600090306      *
137700090306     C                   movel     hdbyy         dhdby
137800090306     C                   movel     hdbmm         dhdbm
137900090306     C                   movel     hdbdd         dhdbd
138000090306      *
138100090306     C                   movel     hefyy         dhefy
138200090306     C                   movel     hefmm         dhefm
138300090306     C                   movel     hefdd         dhefd
138400090306      *
138500090306     C                   movel     htryy         dhtry
138600090306     C                   movel     htrmm         dhtrm
138700090306     C                   movel     htrdd         dhtrd
138800090113      *
138900090113     C                   exfmt     disp02
139000090113      *
139100090113     C****               IF        *IN07 = *ON or *IN01 = *ON
139200090113     C**                 MOVE      *ON           *INLR
139300090113     C**                 return
139400090113     C****               endif
139500090113      *
139600090113     C                   IF        *IN01 = *ON
139700090309     C                   eval      smsg = *blanks
139800090113     C                   MOVE      *Off          *IN01
139900090113     C                   leavesr
140000090113     C                   endif
140100090113      *
140200090113     C                   ENDDO
140300090113      *
140400090113     C                   ENDSR
140500090114      ******************************************************************
140600090114      *       SUBROUTINE - CHGHYG                                      *
140700090114      *                    Change Hygienist                           *
140800090114      ******************************************************************
140900090114     C     chghyg        BEGSR
141000090309      *
141100090309     C                   eval      smsg = *blanks
141200090309     C                   eval      *in68 = *off
141300090309      *
141400090114     C     *IN01         DOWEQ     *OFF
141500090309      *
141600090309     C                   if        smsg = *blanks
141700090309      *
141800090209     C     dhhyg#        chain     ODHYGP
141900090114      *
142000090114     C                   eval      chlnam = mhlnam
142100090114     C                   eval      chfnam = mhfnam
142200090114     C                   eval      chadd1 = mhadd1
142300090114     C                   eval      chadd2 = mhadd2
142400090114     C                   eval      chcity = mhcity
142500090114     C                   eval      chst = mhst
142600090114      *
142700090114     C                   movel     mhzip5        chzip5
142800090114     C                   movel     mhzip4        chzip4
142900090114      *
143000090114     C                   movel     mhph13        chph13
143100090114     C                   movel     mhph46        chph46
143200090114     C                   movel     mhph710       chph710
143300090309      *
143400090309     C                   movel     hssn1         hcsn1
143500090309     C                   movel     hssn2         hcsn2
143600090309     C                   movel     hssn3         hcsn3
143700090309      *
143800090309     C                   movel     hdbyy         hcdby
143900090309     C                   movel     hdbmm         hcdbm
144000090309     C                   movel     hdbdd         hcdbd
144100090309      *
144200090309     C                   movel     hefyy         hcefy
144300090309     C                   movel     hefmm         hcefm
144400090309     C                   movel     hefdd         hcefd
144500090309      *
144600090309     C                   movel     htryy         hctry
144700090309     C                   movel     htrmm         hctrm
144800090309     C                   movel     htrdd         hctrd
144900090114      *
145000090114     C                   eval      chemal = mhemal
145100090114      *
145200090309     C                   endif
145300090309      *
145400090114     C                   exfmt     chg02
145500090114      *
145600090114     C****               IF        *IN07 = *ON or *IN01 = *ON
145700090114     C**                 MOVE      *ON           *INLR
145800090114     C**                 return
145900090114     C****               endif
146000090114      *
146100090114     C                   IF        *IN01 = *ON
146200090309     C                   eval      smsg = *blanks
146300090114     C                   MOVE      *Off          *IN01
146400090114     C                   leavesr
146500090114     C                   endif
146600090114      *           If F5 => Change rec - edit Fields
146700090114      *
146800090114     C                   IF        *IN05 = *ON
146900090114      *
147000090309     C                   eval      smsg = *blanks
147100090309     C                   eval      *in68 = *off
147200090309      *
147300090309     C                   testn                   chzip5               21
147400090309     C                   if        *in21 = *OFF
147500090309     C                   eval      smsg = invzip5
147600090309     C                   eval      *in68 = *on
147700090309     C                   iter
147800090309     C                   endif
147900090309      *
148000090309     C                   testn                   chzip4               21
148100090309     C                   if        *in21 = *OFF and chzip4 <> *blanks
148200090309     C                   eval      smsg = invzip4
148300090309     C                   eval      *in68 = *on
148400090309     C                   iter
148500090309     C                   endif
148600100219      *
148700100316      *        Removed per CW 3/14/10
148800100316     C******             if        chemal = *blanks
148900100316     C***                eval      smsg = noemal
149000100316     C***                eval      *in68 = *on
149100100316     C***                iter
149200100316     C******             endif
149300090309      *
149400090309     C                   if        chph13 <> *blanks or
149500090309     C                             chph46 <> *blanks or
149600090309     C                             chph710 <> *blanks
149700090309     C                   testn                   chph13               21
149800090309     C                   testn                   chph46               22
149900090309     C                   testn                   chph710              23
150000090309     C                   if        *IN21 = *OFF or *in22 = *OFF or
150100090309     C                             *IN23 = *OFF
150200090309     C                   eval      smsg = invphn
150300090309     C                   eval      *in68 = *on
150400090309     C                   iter
150500090309     C                   endif
150600090309     C                   endif
150700090309      *
150800090309     C                   If        hcdby = '    '
150900090309     C                   movel     0000          hdbyy
151000090309     C                   else
151100090309     C                   movel     hcdby         hdbyy
151200090309     C                   endif
151300090309     C                   If        hcdbm = '  '
151400090309     C                   movel     00            hdbmm
151500090309     C                   else
151600090309     C                   movel     hcdbm         hdbmm
151700090309     C                   endif
151800090309     C                   If        hcdbd = '  '
151900090309     C                   movel     00            hdbdd
152000090309     C                   else
152100090309     C                   movel     hcdbd         hdbdd
152200090309     C                   endif
152300090309      *
152400090309     C                   test(D)                 mhdob                  21
152500090309     C                   if        *in21 = *ON
152600090309     C                   eval      smsg = invdob
152700090309     C                   eval      *in68 = *on
152800090309     C                   iter
152900090309     C                   endif
153000090309      *
153100090309     C                   If        hcefy = '    '
153200090309     C                   movel     0000          hefyy
153300090309     C                   else
153400090309     C                   movel     hcefy         hefyy
153500090309     C                   endif
153600090309     C                   If        hcefm = '  '
153700090309     C                   movel     00            hefmm
153800090309     C                   else
153900090309     C                   movel     hcefm         hefmm
154000090309     C                   endif
154100090309     C                   If        hcefd = '  '
154200090309     C                   movel     00            hefdd
154300090309     C                   else
154400090309     C                   movel     hcefd         hefdd
154500090309     C                   endif
154600090309      *
154700090309     C                   test(D)                 mheff                  21
154800090309     C                   if        *in21 = *ON
154900090309     C                   eval      smsg = inveffd
155000090309     C                   eval      *in68 = *on
155100090309     C                   iter
155200090309     C                   endif
155300090309      *
155400090309     C                   If        hctry = '    '
155500090309     C                   movel     0000          htryy
155600090309     C                   else
155700090309     C                   movel     hctry         htryy
155800090309     C                   endif
155900090309     C                   If        hctrm = '  '
156000090309     C                   movel     00            htrmm
156100090309     C                   else
156200090309     C                   movel     hctrm         htrmm
156300090309     C                   endif
156400090309     C                   If        hctrd = '  '
156500090309     C                   movel     00            htrdd
156600090309     C                   else
156700090309     C                   movel     hctrd         htrdd
156800090309     C                   endif
156900090309      *
157000090309     C                   If        mhtrm <> 0
157100090309     C                   test(D)                 mhtrm                  21
157200090309     C                   if        *in21 = *ON
157300090309     C                   eval      smsg = invtrmd
157400090309     C                   eval      *in68 = *on
157500090309     C                   iter
157600090309     C                   endif
157700090309     C                   endif
157800090309      *
157900090114     C                   eval      mhlnam = chlnam
158000090114     C                   eval      mhfnam = chfnam
158100090114     C                   eval      mhadd1 = chadd1
158200090114     C                   eval      mhadd2 = chadd2
158300090114     C                   eval      mhcity = chcity
158400090114     C                   eval      mhst = chst
158500090114      *
158600090114     C                   movel     chzip5        mhzip5
158700090114     C                   movel     chzip4        mhzip4
158800090114      *
158900090114     C                   movel     chph13        mhph13
159000090114     C                   movel     chph46        mhph46
159100090114     C                   movel     chph710       mhph710
159200090114      *
159300090309     C                   movel     hcsn1         hssn1
159400090309     C                   movel     hcsn2         hssn2
159500090309     C                   movel     hcsn3         hssn3
159600090309      *
159700090114     C                   eval      mhemal = chemal
159800090114      *
159900090209     C                   update    ODHYGR
160000090114      *
160100090114     C                   MOVE      *OFF          *IN05
160200090114     C                   endif
160300090114      *
160400090114     C                   ENDDO
160500090114      *
160600090114     C                   ENDSR
160700090123      ******************************************************************
160800090123      *       SUBROUTINE - SELDNT                                      *
160900090123      *                    Select the Dentist                          *
161000090123      ******************************************************************
161100090123     C     seldnt        BEGSR
161200090123     C     *IN01         DOWEQ     *OFF
161300090123     C***  *IN07         ANDEQ     *OFF
161400090123      *
161500090123     C                   EXSR      $DCLEAR
161600090123     C                   EXSR      $DLOAD
161700090123     C                   EXSR      $DDISPLAY
161800090123      *    PROCESS SELECTION
161900090123     C     *IN01         IFEQ      *OFF
162000090123     C***  *IN07         ANDEQ     *OFF
162100090123     C***  RRN           ANDNE     *ZERO
162200090123     C                   eval      wdnt# = 0
162300090123     C                   EXSR      $DPROCES
162400090123     C                   If        wdnt# <> 0
162500090123     C                   leavesr
162600090123     C                   ENDIF
162700090123     C                   ENDIF
162800090123     C                   ENDDO
162900090123      *
163000090123     C                   movel     '0'           *in01
163100090123     C                   ENDSR
163200090123      ******************************************************************
163300090123      *       SUBROUTINE - $DCLEAR                                      *
163400090123      *                    CLEAR SUBF AND RRN                          *
163500090123      ******************************************************************
163600090123     C     $DCLEAR       BEGSR
163700090123     C                   MOVEA     '001'         *IN(51)
163800090123     C                   WRITE     HDDNT
163900090123     C                   Z-ADD     *ZERO         DRRN              3 0
164000090123     C                   WRITE     HDDNT
164100090123     C                   MOVEA     '010'         *IN(51)
164200090123     C                   ENDSR
164300090123      ******************************************************************
164400090123      *       SUBROUTINE - $DLOAD                                      *
164500090123      *                    LOAD SUBFILE W/ Dentist Info                *
164600090123      ******************************************************************
164700090123     C     $DLOAD        BEGSR
164800090123     C     *LOVAL        SETLL     oddentp
164900090123     C                   SETOFF                                       5496
165000090123     C     *IN54         DOUEQ     *ON
165100090123     C     *IN96         OREQ      *ON
165200090123     C                   READ      oddentp                                54
165300090123     C                   IF        (*In54 <> *ON)
165400090123      *
165500090123     C                   ADD       1             DRRN
165600090123     C                   MOVEL     oddnt#        dddnt#
165700090123     C                   MOVEL     odlnam        ddlnam
165800090123     C                   MOVEL     odfnam        ddfnam
165900090123     C                   WRITE     DETDNT
166000090123     C                   ENDIF
166100090123      *
166200090123     C                   ENDDO
166300090123     C                   ENDSR
166400090123      ******************************************************************
166500090123      *       SUBROUTINE - $DDISPLAY                                    *
166600090123      *                    DISPLAY HEADER AND SUBFILE DETAIL           *
166700090123      ******************************************************************
166800090123     C     $DDISPLAY     BEGSR
166900090123     C                   If        DRRN <> *Zero
167000090123     C                   MOVE      *ON           *IN51
167100090123     C                   ENDIF
167200090123     C                   WRITE     TRAILDT
167300090123     C                   EXFMT     HDDNT
167400090123     C                   ENDSR
167500090123      ******************************************************************
167600090123      *       SUBROUTINE - $DPROCES                                     *
167700090123      *                    PROCESS THE SELECTION                       *
167800090123      ******************************************************************
167900090123     C     $DPROCES      BEGSR
168000090123     C     *IN96         DOUEQ     *ON
168100090123      *      Add new record
168200090123     C                   IF        *in10 = *ON
168300090123     C                   exsr      adddnt
168400090123     C                   eval      *in10 = *OFF
168500090123     C                   iter
168600090123     C                   endif
168700090123      *
168800090123     C                   READC     DETDNT                                 96
168900090123     C                   IF        *IN96 = *OFF
169000090123      *      Select Dnt
169100090123     C                   IF        SEL3 = '1'
169200090123     C                   eval      wdnt# = dddnt#
169300090123     C                   leavesr
169400090123     C                   endif
169500090123      *      Display detail
169600090123     C                   IF        SEL3 = '5'
169700090123     C                   exsr      disdnt
169800090123     C                   else
169900090123      *      Display detail
170000090123     C                   IF        SEL3 = '2'
170100090123     C                   exsr      chgdnt
170200090123     C                   endif
170300090123     C                   endif
170400090123      *
170500090123     C                   CLEAR                   SEL3
170600090123     C                   UPDATE    DETDNT
170700090123     C                   ENDIF
170800090123     C                   ENDDO
170900090123     C                   ENDSR
171000090123      ******************************************************************
171100090123      *       SUBROUTINE - ADDDNT                                      *
171200090123      *                    Add a new Dentist Rec                       *
171300090123      ******************************************************************
171400090123     C     adddnt        BEGSR
171500090309      *
171600090309     C                   eval      smsg = *blanks
171700090309     C                   eval      *in68 = *off
171800090317     C                   eval      clearadd = 'Y'
171900090309      *
172000090312     C                   eval      dadnt# = 0
172100090317      *
172200090317     C     *IN01         DOWEQ     *OFF
172300090317      *
172400090317     C                   if        clearadd = 'Y'
172500090312      *
172600090312     C     99999         setgt     oddentp
172700090312     C                   readp     oddentp                                23
172800090312     C                   if        *IN23 = *ON
172900090312     C                   eval      dadnt# = 1
173000090312     C                   else
173100090312     C                   eval      dadnt# = oddnt# + 1
173200090312     C                   endif
173300090312      *
173400090312     C                   eval      dalnam = *blanks
173500090312     C                   eval      dafnam = *blanks
173600090312     C                   eval      daadd1 = *blanks
173700090312     C                   eval      daadd2 = *blanks
173800090312     C                   eval      dacity = *blanks
173900090312     C                   eval      dast = *blanks
174000090312     C                   eval      dazp5 = *blanks
174100090312     C                   eval      dazp4 = *blanks
174200090312     C                   eval      dap13 = *blanks
174300090312     C                   eval      dap46 = *blanks
174400090312     C                   eval      dap710 = *blanks
174500090312     C                   eval      daemal = *blanks
174600090312     C                   eval      dasn1 = *blanks
174700090312     C                   eval      dasn2 = *blanks
174800090312     C                   eval      dasn3 = *blanks
174900090514     C                   eval      dadn# = *blanks
175000090514     C                   eval      dadea# = *blanks
175100090312     C                   eval      dadbm = *blanks
175200090312     C                   eval      dadbd = *blanks
175300090312     C                   eval      dadby = *blanks
175400090312     C                   eval      daefm = *blanks
175500090312     C                   eval      daefd = *blanks
175600090312     C                   eval      daefy = *blanks
175700090312     C                   eval      datrm = *blanks
175800090312     C                   eval      datrd = *blanks
175900090312     C                   eval      datry = *blanks
176000090312      *
176100090317     C                   eval      clearadd = 'N'
176200090317      *
176300090317     C                   endif
176400090309      *
176500090123     C                   exfmt     add03
176600090309      *
176700090309     C                   eval      smsg = *blanks
176800090309     C                   eval      *in68 = *off
176900090123      *
177000090123     C                   IF        *IN01 = *ON
177100090309     C                   eval      smsg = *blanks
177200090123     C                   MOVE      *Off          *IN01
177300090123     C                   leavesr
177400090123     C                   endif
177500090123      *           If F5 => Add new rec - edit Fields
177600090123      *
177700090320     C******             IF        *IN05 = *ON
177800090123      *
177900090123     C                   if        dadnt# = 0
178000090123     C                   eval      smsg = *blanks
178100090123     C                   eval      smsg = invdnt
178200090123     C                   iter
178300090123     C                   endif
178400090123      *
178500090123     C     dadnt#        chain     oddentp                            21
178600090123     C                   IF        *IN21 = *Off
178700090123     C                   eval      smsg = *blanks
178800090123     C                   eval      smsg = dupdnt
178900090123     C                   iter
179000090123     C                   endif
179100090309      *
179200090309     C                   testn                   dazp5                21
179300090309     C                   if        *in21 = *OFF
179400090309     C                   eval      smsg = invzip5
179500090309     C                   eval      *in68 = *on
179600090309     C                   iter
179700090309     C                   endif
179800090309      *
179900090309     C                   testn                   dazp4                21
180000090309     C                   if        *in21 = *OFF and dazp4 <> *blanks
180100090309     C                   eval      smsg = invzip4
180200090309     C                   eval      *in68 = *on
180300090309     C                   iter
180400090309     C                   endif
180500090309      *
180600090309     C                   if        dap13 <> *blanks or
180700090309     C                             dap46 <> *blanks or
180800090309     C                             dap710 <> *blanks
180900090309     C                   testn                   dap13                21
181000090309     C                   testn                   dap46                22
181100090309     C                   testn                   dap710               23
181200090309     C                   if        *IN21 = *OFF or *in22 = *OFF or
181300090309     C                             *IN23 = *OFF
181400090309     C                   eval      smsg = invphn
181500090309     C                   eval      *in68 = *on
181600090309     C                   iter
181700090309     C                   endif
181800090309     C                   endif
181900090309      *
182000090309     C                   If        dadby = '    '
182100090309     C                   movel     0000          ddbyy
182200090309     C                   else
182300090309     C                   movel     dadby         ddbyy
182400090309     C                   endif
182500090309     C                   If        dadbm = '  '
182600090309     C                   movel     00            ddbmm
182700090309     C                   else
182800090309     C                   movel     dadbm         ddbmm
182900090309     C                   endif
183000090309     C                   If        dadbd = '  '
183100090309     C                   movel     00            ddbdd
183200090309     C                   else
183300090309     C                   movel     dadbd         ddbdd
183400090309     C                   endif
183500090309      *
183600090309     C                   test(D)                 oddob                  21
183700090309     C                   if        *in21 = *ON
183800090309     C                   eval      smsg = invdob
183900090309     C                   eval      *in68 = *on
184000090309     C                   iter
184100090309     C                   endif
184200090309      *
184300090309     C                   If        daefy = '    '
184400090309     C                   movel     0000          defyy
184500090309     C                   else
184600090309     C                   movel     daefy         defyy
184700090309     C                   endif
184800090309     C                   If        daefm = '  '
184900090309     C                   movel     00            defmm
185000090309     C                   else
185100090309     C                   movel     daefm         defmm
185200090309     C                   endif
185300090309     C                   If        daefd = '  '
185400090309     C                   movel     00            defdd
185500090309     C                   else
185600090309     C                   movel     daefd         defdd
185700090309     C                   endif
185800090309      *
185900090309     C                   test(D)                 odeff                  21
186000090309     C                   if        *in21 = *ON
186100090309     C                   eval      smsg = inveffd
186200090309     C                   eval      *in68 = *on
186300090309     C                   iter
186400090309     C                   endif
186500090309      *
186600090309     C                   If        datry = '    '
186700090309     C                   movel     0000          dtryy
186800090309     C                   else
186900090309     C                   movel     datry         dtryy
187000090309     C                   endif
187100090309     C                   If        datrm = '  '
187200090309     C                   movel     00            dtrmm
187300090309     C                   else
187400090309     C                   movel     datrm         dtrmm
187500090309     C                   endif
187600090309     C                   If        datrd = '  '
187700090309     C                   movel     00            dtrdd
187800090309     C                   else
187900090309     C                   movel     datrd         dtrdd
188000090309     C                   endif
188100090309      *
188200090309     C                   If        odtrm <> 0
188300090309     C                   test(D)                 odtrm                  21
188400090309     C                   if        *in21 = *ON
188500090309     C                   eval      smsg = invtrmd
188600090309     C                   eval      *in68 = *on
188700090309     C                   iter
188800090309     C                   endif
188900090309     C                   endif
189000090309      *
189100090123      *  Add record
189200090123     C                   eval      oddnt# = dadnt#
189300090123     C                   eval      odlnam = dalnam
189400090123     C                   eval      odfnam = dafnam
189500090123     C                   eval      odadd1 = daadd1
189600090123     C                   eval      odadd2 = daadd2
189700090123     C                   eval      odcity = dacity
189800090123     C                   eval      odst = dast
189900090123     C                   movel     dazp5         odzip
190000090123     C                   move      dazp4         odzip
190100090123     C                   eval      odph13 = dap13
190200090123     C                   eval      odph46 = dap46
190300090123     C                   eval      odph710 = dap710
190400090123      *
190500090123     C                   eval      odemal = daemal
190600090309      *
190700090309     C                   movel     dasn1         dssn1
190800090309     C                   movel     dasn2         dssn2
190900090309     C                   movel     dasn3         dssn3
191000090123      *
191100090514     C                   eval      oddn# = dadn#
191200090514     C                   eval      oddea# = dadea#
191300090514      *
191400090123     C                   write     oddentr
191500090317     C                   eval      smsg = recadd
191600090317     C                   eval      *in68 = *on
191700090317      *
191800090317     C                   eval      clearadd = 'Y'
191900090123      *
192000090123     C                   MOVE      *OFF          *IN05
192100090320     C*****              endif
192200090123      *
192300090123     C                   ENDDO
192400090123      *
192500090123     C                   ENDSR
192600090123      ******************************************************************
192700090123      *       SUBROUTINE - DISDNT                                      *
192800090123      *                    Dispaly Dentist                             *
192900090123      ******************************************************************
193000090123     C     disdnt        BEGSR
193100090123     C     *IN01         DOWEQ     *OFF
193200090123     C     dddnt#        chain     oddentp
193300090123      *
193400090123     C                   movel     odzip5        ddzip5
193500090123     C                   movel     odzip4        ddzip4
193600090123      *
193700090123     C                   movel     odph13        ddph13
193800090123     C                   movel     odph46        ddph46
193900090123     C                   movel     odph710       ddph710
194000090123      *
194100090309     C                   movel     dssn1         ddsn1
194200090309     C                   movel     dssn2         ddsn2
194300090309     C                   movel     dssn3         ddsn3
194400090309      *
194500090309     C                   movel     ddbyy         dddby
194600090309     C                   movel     ddbmm         dddbm
194700090309     C                   movel     ddbdd         dddbd
194800090309      *
194900090309     C                   movel     defyy         ddefy
195000090309     C                   movel     defmm         ddefm
195100090309     C                   movel     defdd         ddefd
195200090309      *
195300090309     C                   movel     dtryy         ddtry
195400090309     C                   movel     dtrmm         ddtrm
195500090309     C                   movel     dtrdd         ddtrd
195600090309      *
195700090123     C                   exfmt     disp03
195800090123      *
195900090123     C****               IF        *IN07 = *ON or *IN01 = *ON
196000090123     C**                 MOVE      *ON           *INLR
196100090123     C**                 return
196200090123     C****               endif
196300090123      *
196400090123     C                   IF        *IN01 = *ON
196500090309     C                   eval      smsg = *blanks
196600090123     C                   MOVE      *Off          *IN01
196700090123     C                   leavesr
196800090123     C                   endif
196900090123      *
197000090123     C                   ENDDO
197100090123      *
197200090123     C                   ENDSR
197300090123      ******************************************************************
197400090123      *       SUBROUTINE - CHGDNT                                      *
197500090123      *                    Change Dentist                              *
197600090123      ******************************************************************
197700090123     C     chgdnt        BEGSR
197800090309      *
197900090309     C                   eval      smsg = *blanks
198000090309     C                   eval      *in68 = *off
198100090309      *
198200090123     C     *IN01         DOWEQ     *OFF
198300090309      *
198400090309     C                   if        smsg = *blanks
198500090309      *
198600090123     C     dddnt#        chain     oddentp
198700090123      *
198800090123     C                   eval      dclnam = odlnam
198900090123     C                   eval      dcfnam = odfnam
199000090123     C                   eval      dcadd1 = odadd1
199100090123     C                   eval      dcadd2 = odadd2
199200090123     C                   eval      dccity = odcity
199300090123     C                   eval      dcst = odst
199400090123      *
199500090123     C                   movel     odzip5        dczip5
199600090123     C                   movel     odzip4        dczip4
199700091007      *
199800091007     C                   movel     odph13        dcph13
199900091007     C                   movel     odph46        dcph46
200000091007     C                   movel     odph710       dcph710
200100090123      *
200200090123     C                   eval      dcemal = odemal
200300091007      *
200400091007     C                   movel     dssn1         dcsn1
200500091007     C                   movel     dssn2         dcsn2
200600090414     C                   movel     dssn3         dcsn3
200700090414      *
200800090514     C                   movel     oddn#         dcdn#
200900090514     C                   movel     oddea#        dcdea#
201000090514      *
201100090414     C                   movel     ddbyy         dcdby
201200090414     C                   movel     ddbmm         dcdbm
201300090414     C                   movel     ddbdd         dcdbd
201400090414      *
201500090414     C                   movel     defyy         dcefy
201600090414     C                   movel     defmm         dcefm
201700090309     C                   movel     defdd         dcefd
201800090414      *
201900090309     C                   movel     dtryy         dctry
202000090414     C                   movel     dtrmm         dctrm
202100090414     C                   movel     dtrdd         dctrd
202200090309      *
202300090309     C                   endif
202400090123      *
202500090123     C                   exfmt     chg03
202600090123      *
202700090123     C                   IF        *IN01 = *ON
202800090309     C                   eval      smsg = *blanks
202900090123     C                   MOVE      *Off          *IN01
203000090123     C                   leavesr
203100090123     C                   endif
203200090123      *           If F5 => Change rec - edit Fields
203300090123      *
203400090123     C                   IF        *IN05 = *ON
203500090309      *
203600090309     C                   eval      smsg = *blanks
203700090309     C                   eval      *in68 = *off
203800090309      *
203900090309     C                   testn                   dczip5               21
204000090309     C                   if        *in21 = *OFF
204100090309     C                   eval      smsg = invzip5
204200090309     C                   eval      *in68 = *on
204300090309     C                   iter
204400090309     C                   endif
204500090309      *
204600090309     C                   testn                   dczip4               21
204700090309     C                   if        *in21 = *OFF and dczip4 <> *blanks
204800090309     C                   eval      smsg = invzip4
204900090309     C                   eval      *in68 = *on
205000090309     C                   iter
205100090311     C                   endif
205200090311      *
205300090311     C                   if        dcph13 <> *blanks or
205400090311     C                             dcph46 <> *blanks or
205500090311     C                             dcph710 <> *blanks
205600090311     C                   testn                   dcph13               21
205700090311     C                   testn                   dcph46               22
205800090309     C                   testn                   dcph710              23
205900090311     C                   if        *IN21 = *OFF or *in22 = *OFF or
206000090309     C                             *IN23 = *OFF
206100090309     C                   eval      smsg = invphn
206200090309     C                   eval      *in68 = *on
206300090309     C                   iter
206400090309     C                   endif
206500090309     C                   endif
206600090309      *
206700090309     C                   If        dcdby = '    '
206800090309     C                   movel     0000          ddbyy
206900090309     C                   else
207000090309     C                   movel     dcdby         ddbyy
207100090309     C                   endif
207200090309     C                   If        dcdbm = '  '
207300090309     C                   movel     00            ddbmm
207400090309     C                   else
207500090309     C                   movel     dcdbm         ddbmm
207600090309     C                   endif
207700090309     C                   If        dcdbd = '  '
207800090309     C                   movel     00            ddbdd
207900090309     C                   else
208000090309     C                   movel     dcdbd         ddbdd
208100090309     C                   endif
208200090309      *
208300090309     C                   test(D)                 oddob                  21
208400090309     C                   if        *in21 = *ON
208500090309     C                   eval      smsg = invdob
208600090309     C                   eval      *in68 = *on
208700090309     C                   iter
208800090309     C                   endif
208900090309      *
209000090309     C                   If        dcefy = '    '
209100090309     C                   movel     0000          defyy
209200090309     C                   else
209300090309     C                   movel     dcefy         defyy
209400090309     C                   endif
209500090309     C                   If        dcefm = '  '
209600090309     C                   movel     00            defmm
209700090309     C                   else
209800090309     C                   movel     dcefm         defmm
209900090309     C                   endif
210000090309     C                   If        dcefd = '  '
210100090309     C                   movel     00            defdd
210200090309     C                   else
210300090309     C                   movel     dcefd         defdd
210400090309     C                   endif
210500090309      *
210600090309     C                   test(D)                 odeff                  21
210700090309     C                   if        *in21 = *ON
210800090309     C                   eval      smsg = inveffd
210900090309     C                   eval      *in68 = *on
211000090309     C                   iter
211100090309     C                   endif
211200090309      *
211300090309     C                   If        dctry = '    '
211400090309     C                   movel     0000          dtryy
211500090309     C                   else
211600090309     C                   movel     dctry         dtryy
211700090309     C                   endif
211800090309     C                   If        dctrm = '  '
211900090309     C                   movel     00            dtrmm
212000090309     C                   else
212100090309     C                   movel     dctrm         dtrmm
212200090309     C                   endif
212300090309     C                   If        dctrd = '  '
212400090309     C                   movel     00            dtrdd
212500090309     C                   else
212600090309     C                   movel     dctrd         dtrdd
212700090309     C                   endif
212800090309      *
212900090309     C                   If        odtrm <> 0
213000090309     C                   test(D)                 odtrm                  21
213100090309     C                   if        *in21 = *ON
213200090309     C                   eval      smsg = invtrmd
213300090309     C                   eval      *in68 = *on
213400090309     C                   iter
213500090309     C                   endif
213600090309     C                   endif
213700090309      *
213800090123      *
213900090123     C                   eval      odlnam = dclnam
214000090123     C                   eval      odfnam = dcfnam
214100090123     C                   eval      odadd1 = dcadd1
214200090123     C                   eval      odadd2 = dcadd2
214300090123     C                   eval      odcity = dccity
214400090123     C                   eval      odst = dcst
214500090123      *
214600090123     C                   movel     dczip5        odzip5
214700090123     C                   movel     dczip4        odzip4
214800090123      *
214900090123     C                   movel     dcph13        odph13
215000090123     C                   movel     dcph46        odph46
215100090123     C                   movel     dcph710       odph710
215200090123      *
215300090123     C                   eval      odemal = dcemal
215400090309      *
215500090309     C                   movel     dcsn1         dssn1
215600090309     C                   movel     dcsn2         dssn2
215700090309     C                   movel     dcsn3         dssn3
215800090514      *
215900090514     C                   eval      oddn# = dcdn#
216000090514     C                   eval      oddea# = dcdea#
216100090123      *
216200090123     C                   update    oddentr
216300090123      *
216400090123     C                   MOVE      *OFF          *IN05
216500090123     C                   endif
216600090123      *
216700090123     C                   ENDDO
216800090123      *
216900090123     C                   ENDSR
217000090227      ******************************************************************
217100090227      *       SUBROUTINE - WRKCON                                      *
217200090227      *                    Work with Contacts                          *
217300090227      ******************************************************************
217400090227     C     wrkcon        BEGSR
217500090227      *
217600090310     C                   Eval      OCTRST = trust#
217700090310     C                   Eval      OCSUB# = sub#
217800090310     C                   Eval      OCACCT = 0
217900090310     C                   Call      'WRKOCNCL'
218000090310     C                   Parm                    WCDTA
218100090310    ?C***                Move      'END'         WWENDO                         END OPT LOOP
218200090310    ?C***                Move      'END'         WWENDF                         END PGM LOOP
218300090310    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
218400090310      *
218500090227     C                   ENDSR
218600081208      ******************************************************************
