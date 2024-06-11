000100981030     F*------------------------------------------------------------------------------------------*
000200100114      * FI022R     GROUP BENIFIT SERVICES SOFTWARE           2010                                *
000300981030      *            WRITTEN BY - R.L.J.                                                           *
000400100114      *            DATE - 01/2010                                                                *
000500100114      *  DESCRIPTION - Onsite Dental Facility Inquiry                                            *
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
002000100114     FODFACP    IF   E           K DISK
002100100114     FODHYGP    IF   E           K DISK
002200100114     FODDENTP   IF   E           K DISK
002300100114     FFI022D    CF   E             WORKSTN
002400981030      *
002500090327    ?D WCDTA         E DS                  EXTNAME(ODCNTCP) inz
002600090310      *
002700081205     D @PARM           DS
002800081205     D  TRUST#                 1      3S 0
002900090119     D  SUB#                   4      6S 0
003000090119    * *
003100090119     D                 DS
003200090123     D wdnt#           S              5  0
003300090122     D whyg#           S              5  0
003400090220     D wofc#           S              3  0
003500090220     D selof           S              1
003600090220     D selhy           S              1
003700090123     D seldn           S              1
003800090302     D clrfld          S              1
003900090317     D clearadd        S              1
004000090310     D wortn           S              8
004100090223    * *
004200090223     D                 DS
004300090223     D s2zip                   1      9
004400090223     D  szip5                  1      5
004500090223     D  szip4                  6      9
004600090223    * *
004700090223     D                 DS
004800090223     D sdzip                   1     10
004900090119     D  dzip5                  1      5
005000090220     D  dzip                   6      6    INZ('-')
005100090223     D  dzip4                  7     10
005200090220    * *
005300090220     D                 DS
005400090220     D mhzip                   1      9
005500090220     D  mhzip5                 1      5
005600090220     D  mhzip4                 6      9
005700090220    * *
005800090220     D                 DS
005900090123     D odzip                   1      9
006000090220     D  odzip5                 1      5
006100090123     D  odzip4                 6      9
006200090123    * *
006300090123     D                 DS
006400090123     D hdzip                   1     10
006500090123     D  hdzip5                 1      5
006600090123     D  hdzp                   6      6    INZ('-')
006700090123     D  hdzip4                 7     10
006800090123    * *
006900090123     D                 DS
007000090123     D ddzip                   1     10
007100090123     D  ddzip5                 1      5
007200090220     D  ddzp                   6      6    INZ('-')
007300090220     D  ddzip4                 7     10
007400090302    * *
007500090302     D                 DS
007600090302     D s2phon                  1     10
007700090302     D  sph13                  1      3
007800090302     D  sph46                  4      6
007900090302     D  sph710                 7     10
008000090318    * *
008100090318     D                 DS
008200090318     D sdphon                  1     12
008300090318     D  dph13                  1      3
008400090318     D  dph1                   4      4    INZ('-')
008500090217     D  dph46                  5      7
008600090318     D  dph2                   8      8    INZ('-')
008700090319     D  dph710                 9     12
008800090514    * *
008900090514     D                 DS
009000090514     D s2fax                   1     10
009100090514     D  sfx13                  1      3
009200090514     D  sfx46                  4      6
009300090514     D  sfx710                 7     10
009400090514    * *
009500090514     D                 DS
009600090514     D sdfax                   1     12
009700090514     D  dfx13                  1      3
009800090514     D  dfx1                   4      4    INZ('-')
009900090514     D  dfx46                  5      7
010000090514     D  dfx2                   8      8    INZ('-')
010100090514     D  dfx710                 9     12
010200090319    * *
010300090319     D                 DS
010400090319     D mhphon                  1     10
010500090319     D  mhph13                 1      3
010600090319     D  mhph46                 4      6
010700090319     D  mhph710                7     10
010800090319    * *
010900090319     D                 DS
011000090319     D odphon                  1     10
011100090319     D  odph13                 1      3
011200090319     D  odph46                 4      6
011300090213     D  odph710                7     10
011400090213    * *
011500090213     D                 DS
011600090227     D wkdphn                  1     12
011700090227     D  wdph13                 1      3
011800090227     D  wdph1                  4      4    INZ('-')
011900090227     D  wdph46                 5      7
012000090227     D  wdph2                  8      8    INZ('-')
012100090227     D  wdph710                9     12
012200090227    * *
012300090227     D                 DS
012400090227     D hdphon                  1     12
012500090227     D  hdph13                 1      3
012600090227     D  hdph1                  4      4    INZ('-')
012700090227     D  hdph46                 5      7
012800090227     D  hdph2                  8      8    INZ('-')
012900090227     D  hdph710                9     12
013000090121    * *
013100090123     D                 DS
013200090123     D ddphon                  1     12
013300090123     D  ddph13                 1      3
013400090123     D  ddph1                  4      4    INZ('-')
013500090128     D  ddph46                 5      7
013600090128     D  ddph2                  8      8    INZ('-')
013700090128     D  ddph710                9     12
013800090128    * *
013900090128     D                 DS
014000090306     D mhssn#                  1      9
014100090306     D  hssn1                  1      3
014200090306     D  hssn2                  4      5
014300090306     D  hssn3                  6      9
014400081215    * *
014500090128     D                 DS
014600090306     D hdssn                   1     11
014700090306     D  dhsn1                  1      3
014800090306     D  dsn1                   4      4    INZ('-')
014900090306     D  dhsn2                  5      6
015000090306     D  dsn2                   7      7    INZ('-')
015100090306     D  dhsn3                  8     11
015200081215    * *
015300090306     D                 DS
015400090306     D mhdob                   1      8  0
015500090414     D  hdbyy                  1      4
015600090414     D  hdbmm                  5      6
015700090306     D  hdbdd                  7      8
015800090414    * *
015900090414     D                 DS
016000090414     D hddob                   1     10
016100090414     D  dhdbm                  1      2
016200090414     D  dhd1                   3      3    INZ('/')
016300090414     D  dhdbd                  4      5
016400090414     D  dhd2                   6      6    INZ('/')
016500090414     D  dhdby                  7     10
016600090414    * *
016700090414     D                 DS
016800090414     D mheff                   1      8  0
016900090414     D  hefyy                  1      4
017000090414     D  hefmm                  5      6
017100090306     D  hefdd                  7      8
017200090306    * *
017300090306     D                 DS
017400090306     D hdeff                   1     10
017500090306     D  dhefm                  1      2
017600090306     D  dhf1                   3      3    INZ('/')
017700090306     D  dhefd                  4      5
017800090306     D  dhf2                   6      6    INZ('/')
017900090325     D  dhefy                  7     10
018000090325    * *
018100090325     D                 DS
018200090325     D mhtrm                   1      8  0
018300090325     D  htryy                  1      4
018400090325     D  htrmm                  5      6
018500090325     D  htrdd                  7      8
018600090325    * *
018700090319     D                 DS
018800090325     D hdtrm                   1     10
018900090319     D  dhtrm                  1      2
019000090306     D  dht1                   3      3    INZ('/')
019100090306     D  dhtrd                  4      5
019200090306     D  dht2                   6      6    INZ('/')
019300090306     D  dhtry                  7     10
019400090309    * *
019500090309    * *  Dentist fields
019600090309    * *
019700090309     D                 DS
019800090309     D odssn#                  1      9
019900090309     D  dssn1                  1      3
020000090309     D  dssn2                  4      5
020100090309     D  dssn3                  6      9
020200090309    * *
020300090309     D                 DS
020400090309     D ddssn                   1     11
020500090309     D  ddsn1                  1      3
020600090309     D  ddn1                   4      4    INZ('-')
020700090309     D  ddsn2                  5      6
020800090309     D  ddn2                   7      7    INZ('-')
020900090309     D  ddsn3                  8     11
021000090309    * *
021100090309     D                 DS
021200090309     D oddob                   1      8  0
021300090309     D  ddbyy                  1      4
021400090309     D  ddbmm                  5      6
021500090309     D  ddbdd                  7      8
021600090309    * *
021700090309     D                 DS
021800090309     D dddob                   1     10
021900090309     D  dddbm                  1      2
022000090309     D  ddd1                   3      3    INZ('/')
022100090309     D  dddbd                  4      5
022200090319     D  ddd2                   6      6    INZ('/')
022300090319     D  dddby                  7     10
022400090319    * *
022500090406     D                 DS
022600090406     D odeff                   1      8  0
022700090406     D  defyy                  1      4
022800090406     D  defmm                  5      6
022900090406     D  defdd                  7      8
023000090406    * *
023100090406     D                 DS
023200090406     D ddeff                   1     10
023300090406     D  ddefm                  1      2
023400090406     D  ddf1                   3      3    INZ('/')
023500090309     D  ddefd                  4      5
023600090309     D  ddf2                   6      6    INZ('/')
023700090309     D  ddefy                  7     10
023800090309    * *
023900090309     D                 DS
024000090309     D odtrm                   1      8  0
024100090309     D  dtryy                  1      4
024200090309     D  dtrmm                  5      6
024300090309     D  dtrdd                  7      8
024400090309    * *
024500090309     D                 DS
024600090309     D ddterm                  1     10
024700090309     D  ddtrm                  1      2
024800090309     D  ddt1                   3      3    INZ('/')
024900090309     D  ddtrd                  4      5
025000090309     D  ddt2                   6      6    INZ('/')
025100090309     D  ddtry                  7     10
025200090309    * *
025300090309    * *   Facility Fields
025400090309    * *
025500090306     D                 DS
025600090306     D s2eff                   1      8  0
025700090306     D  sefyy                  1      4
025800090306     D  sefmm                  5      6
025900090306     D  sefdd                  7      8
026000090306    * *
026100090306     D                 DS
026200090306     D sdeff                   1     10
026300090309     D  sdefmm                 1      2
026400090306     D  def1                   3      3    INZ('/')
026500090309     D  sdefdd                 4      5
026600090306     D  def2                   6      6    INZ('/')
026700090309     D  sdefyy                 7     10
026800090306    * *
026900081215     D                 DS
027000081217     D sdtrm                   1     10
027100090309     D  odtrmm                 1      2
027200090309     D  odtr1                  3      3    INZ('/')
027300090309     D  odtrdd                 4      5
027400090319     D  odtr2                  6      6    INZ('/')
027500090319     D  odtryy                 7     10
027600090319    * *
027700090319     D                 DS
027800090319     D sceff                   1     10
027900090319     D  cefmm                  1      2
028000090319     D  cef1                   3      3    INZ('/')
028100090319     D  cefdd                  4      5
028200090319     D  cef2                   6      6    INZ('/')
028300090319     D  cefyy                  7     10
028400090319    * *
028500090319     D                 DS
028600090319     D sctrm                   1     10
028700090319     D  ctrmm                  1      2
028800090319     D  ctr1                   3      3    INZ('/')
028900090223     D  ctrdd                  4      5
029000090223     D  ctr2                   6      6    INZ('/')
029100090206     D  ctryy                  7     10
029200090122    * *
029300090206     D                 DS
029400090206     D s2trm                   1      8  0
029500090122     D  stryy                  1      4
029600090122     D  strmm                  5      6
029700090316     D  strdd                  7      8
029800090316    * *
0299000903160053 D                 DS
0300001001140054 D  blnkfac        C                   'Facility has not been set up       '
0301001001140054 D  invdob         C                   'Invalid DOB                        '
0302000903160054 D  inveffd        C                   'Invalid Effective Date             '
0303000903160054 D  invtrmd        C                   'Invalid Term Date                  '
0304000903160054 D  invzip5        C                   'Invalid Zip5 - must be 5 numerics  '
0305000903160054 D  invzip4        C                   'Inv Zip4 - must be 4 num or blank'
0306000903160054 D  invphn         C                   'Invalid Phone# - 10 num or blank'
0307000905140054 D  invfax         C                   'Invalid Fax# - 10 num or blank'
0308000903160054 D  invhyg         C                   'Invalid Hygienist Number           '
0309000903160054 D  invdnt         C                   'Invalid Dentist Number             '
0310000911060054 D  dupfac         C                   'Facility rec already exists        '
0311000911060054 D  duphyg         C                   'Hygienist# already exists          '
0312000901230054 D  dupdnt         C                   'Dentist# already exists            '
0313000903170054 D  recadd         C                   'Record has been added              '
0314000903170054 D  recchg         C                   'Record has been changed            '
031500090116    * *
031600090206     D USCLAS          S             10
031700090206    * *
031800090206     C     *ENTRY        PLIST
031900090206     C                   PARM                    @PARM
032000090206    * *
032100090206      *
032200081217     C     subkey        klist
032300090206     C                   kfld                    trust#
032400090206     C                   kfld                    sub#
032500090219      *
032600090219     C     ofckey        klist
032700090219     C                   kfld                    s2trst
032800090219     C                   kfld                    s2ofc#
032900090206      *
033000081217     C     fadkey        klist
033100081217     C                   kfld                    trust#
033200081217     C                   kfld                    sbsub#
033300991116      *
033400090120      *    MAINLINE
033500090120     C     *IN01         DOWEQ     *OFF
033600090120      *
033700090219     C     subkey        chain     ODFACP                             52
033800090219     C                   if        *IN52 = '1'
033900100114     C                   exsr      disblnk
034000090219     C                   else
034100090219     C                   exsr      disdtl
034200090219     C                   endif
034300090219      *
034400090219     C                   if        *IN01 = '1'
034500090219     C                   leave
034600090219     C                   ENDIF
034700090219      *
034800090217     C                   ENDDO
034900090217     C                   MOVE      *ON           *INLR
035000090217     C                   RETURN
035100981030      ******************************************************************
035200090209      *       SUBROUTINE - *INZSR                                      *
035300090209      *                    FIRST PASS LOGIC                            *
035400981030      ******************************************************************
035500081208     C***  *INZSR        BEGSR
035600090115     C*****              ENDSR
035700081208      ******************************************************************
035800090319      *       SUBROUTINE - DISDTL                                      *
035900090319      *                    Dispaly Office Detail                       *
036000081208      ******************************************************************
036100090319     C     disdtl        BEGSR
036200090319     C     *IN01         DOWEQ     *OFF
036300090319     C**** *IN07         ANDEQ     *OFF
036400090319     C     trust#        chain     trsmst
036500090319     C     subkey        chain     submst
036600090319     C     subkey        chain     ODFACP
036700090319      *
036800090319     C                   eval      sdofc# = s2ofc#
036900090319     C                   eval      sdoloc = *blanks
037000100722     C     ofckey        chain     ODRGNP                             53
037100090219     C                   IF        *in53 = *OFF
037200090219     C                   eval      sdoloc = mooloc
037300090219     C                   endif
037400090219      *
037500140321     C                   eval      sdpchn = s2pchn
037600140321      *
037700140321     C                   eval      sdadd1 = s2add1
037800090212     C                   eval      sdadd2 = s2add2
037900090212     C                   eval      sdcity = s2city
038000090204     C                   eval      sdst = s2st
038100090205      *
038200090212     C                   movel     szip5         dzip5
038300090212     C                   movel     szip4         dzip4
038400090212      *
038500090206     C                   movel     sph13         dph13
038600090206     C                   movel     sph46         dph46
038700090206     C                   movel     sph710        dph710
038800090206      *
038900090514     C                   movel     sfx13         dfx13
039000090514     C                   movel     sfx46         dfx46
039100090514     C                   movel     sfx710        dfx710
039200090514      *
039300090309     C                   movel     sefmm         sdefmm
039400090309     C                   movel     sefdd         sdefdd
039500090309     C                   movel     sefyy         sdefyy
039600090206      *
039700090406     C                   movel     strmm         odtrmm
039800090406     C                   movel     strdd         odtrdd
039900090406     C                   movel     stryy         odtryy
040000090406      *
040100090406     C                   eval      sdhyg# = s2hyg#
040200090218     C     s2hyg#        chain     odhygp
040300090406     C                   eval      sdhnam = *blanks
040400090406     C                   eval      sdhnam = %TRIM(mhfnam) + ' ' +
040500090406     C                                      %TRIM(mhlnam)
040600090406      *
040700090406     C                   eval      sddent = s2dent
040800090406     C     s2dent        chain     oddentp
040900090406     C                   eval      sddnam = *blanks
041000090406     C                   eval      sddnam = %TRIM(odfnam) + ' ' +
041100090218     C                                      %TRIM(odlnam)
041200091214      *
041300091214     C                   eval      sdbeds = s2beds
041400090129      *
041500090206     C                   exfmt     disp01
041600090227      *
041700090227     C                   IF        *IN08 = *ON
041800090227     C                   exsr      wrkcon
041900090227     C                   iter
042000090227     C                   endif
042100100114      *
042200100114     C                   IF        *IN09 = *ON
042300100114     C                   exsr      dishyg
042400100114     C                   iter
042500100114     C                   endif
042600100114      *
042700100114     C                   IF        *IN10 = *ON
042800100114     C                   exsr      disdnt
042900100114     C                   iter
043000100114     C                   endif
043100081215      *
043200090219     C*****              IF        *IN01 = *ON
043300090219     C*****              MOVE      *Off          *IN01
043400090219     C*****              leavesr
043500090219     C*****              endif
043600081208      *
043700090406     C                   ENDDO
043800090406      *
043900090406     C                   ENDSR
044000100114      ******************************************************************
044100100114      *       SUBROUTINE - DISBLNK                                     *
044200100114      *                    Dispaly Blank Detail                       *
044300100114      ******************************************************************
044400100114     C     disblnk       BEGSR
044500100114     C     *IN01         DOWEQ     *OFF
044600100114     C**** *IN07         ANDEQ     *OFF
044700100114     C     trust#        chain     trsmst
044800100114     C     subkey        chain     submst
044900100114      *
045000100114     C                   eval      sdofc# = 0
045100100114     C                   eval      sdoloc = *blanks
045200100114     C                   eval      sdadd1 = *blanks
045300100114     C                   eval      sdadd2 = *blanks
045400100114     C                   eval      sdcity = *blanks
045500100114     C                   eval      sdst = *blanks
045600100114     C                   eval      sdzip = *blanks
045700100114     C                   eval      sdphon = *blanks
045800100114     C                   eval      sdfax = *blanks
045900100114     C                   eval      sdeff = *blanks
046000100114     C                   eval      sdtrm = *blanks
046100100114      *
046200100114     C                   eval      sdhyg# = 0
046300100114     C                   eval      sdhnam = *blanks
046400100114     C                   eval      sddent = 0
046500100114     C                   eval      sddnam = *blanks
046600100114     C                   eval      sdbeds = 0
046700100114      *
046800100114     C                   eval      smsg = blnkfac
046900100114     C                   eval      *in68 = *on
047000100114      *
047100100114     C                   exfmt     disp01
047200100114      *
047300100114     C                   ENDDO
047400100114      *
047500100114     C                   ENDSR
047600090113      ******************************************************************
047700090113      *       SUBROUTINE - DISHYG                                      *
047800090113      *                    Dispaly Hygienist                           *
047900090113      ******************************************************************
048000090113     C     dishyg        BEGSR
048100090113     C     *IN01         DOWEQ     *OFF
048200100114     C     sdhyg#        chain     ODHYGP
048300090113      *
048400090113     C                   movel     mhzip5        hdzip5
048500090113     C                   movel     mhzip4        hdzip4
048600090113      *
048700090114     C                   movel     mhph13        hdph13
048800090114     C                   movel     mhph46        hdph46
048900090114     C                   movel     mhph710       hdph710
049000090306      *
049100090306     C                   movel     hssn1         dhsn1
049200090306     C                   movel     hssn2         dhsn2
049300090306     C                   movel     hssn3         dhsn3
049400090306      *
049500090306     C                   movel     hdbyy         dhdby
049600090306     C                   movel     hdbmm         dhdbm
049700090306     C                   movel     hdbdd         dhdbd
049800090306      *
049900090306     C                   movel     hefyy         dhefy
050000090306     C                   movel     hefmm         dhefm
050100090306     C                   movel     hefdd         dhefd
050200090306      *
050300090306     C                   movel     htryy         dhtry
050400090306     C                   movel     htrmm         dhtrm
050500090306     C                   movel     htrdd         dhtrd
050600090113      *
050700090113     C                   exfmt     disp02
050800090113      *
050900090113     C****               IF        *IN07 = *ON or *IN01 = *ON
051000090113     C**                 MOVE      *ON           *INLR
051100090113     C**                 return
051200090113     C****               endif
051300090113      *
051400090113     C                   IF        *IN01 = *ON
051500090309     C                   eval      smsg = *blanks
051600090113     C                   MOVE      *Off          *IN01
051700090113     C                   leavesr
051800090113     C                   endif
051900090113      *
052000090113     C                   ENDDO
052100090113      *
052200090113     C                   ENDSR
052300090123      ******************************************************************
052400090123      *       SUBROUTINE - DISDNT                                      *
052500090123      *                    Dispaly Dentist                             *
052600090123      ******************************************************************
052700090123     C     disdnt        BEGSR
052800090123     C     *IN01         DOWEQ     *OFF
052900100114     C     sddent        chain     oddentp
053000090123      *
053100090123     C                   movel     odzip5        ddzip5
053200090123     C                   movel     odzip4        ddzip4
053300090123      *
053400090123     C                   movel     odph13        ddph13
053500090123     C                   movel     odph46        ddph46
053600090123     C                   movel     odph710       ddph710
053700090123      *
053800090309     C                   movel     dssn1         ddsn1
053900090309     C                   movel     dssn2         ddsn2
054000090309     C                   movel     dssn3         ddsn3
054100090309      *
054200090309     C                   movel     ddbyy         dddby
054300090309     C                   movel     ddbmm         dddbm
054400090309     C                   movel     ddbdd         dddbd
054500090309      *
054600090309     C                   movel     defyy         ddefy
054700090309     C                   movel     defmm         ddefm
054800090309     C                   movel     defdd         ddefd
054900090309      *
055000090309     C                   movel     dtryy         ddtry
055100090309     C                   movel     dtrmm         ddtrm
055200090309     C                   movel     dtrdd         ddtrd
055300090309      *
055400090123     C                   exfmt     disp03
055500090123      *
055600090123     C****               IF        *IN07 = *ON or *IN01 = *ON
055700090123     C**                 MOVE      *ON           *INLR
055800090123     C**                 return
055900090123     C****               endif
056000090123      *
056100090123     C                   IF        *IN01 = *ON
056200090309     C                   eval      smsg = *blanks
056300090123     C                   MOVE      *Off          *IN01
056400090123     C                   leavesr
056500090123     C                   endif
056600090123      *
056700090123     C                   ENDDO
056800090123      *
056900090123     C                   ENDSR
057000090227      ******************************************************************
057100090227      *       SUBROUTINE - WRKCON                                      *
057200090227      *                    Work with Contacts                          *
057300090227      ******************************************************************
057400090227     C     wrkcon        BEGSR
057500090227      *
057600090310     C                   Eval      OCTRST = trust#
057700090310     C                   Eval      OCSUB# = sub#
057800090310     C                   Eval      OCACCT = 0
057900100114     C                   Call      'DSPOCNCL'
058000090310     C                   Parm                    WCDTA
058100090310    ?C***                Move      'END'         WWENDO                         END OPT LOOP
058200090310    ?C***                Move      'END'         WWENDF                         END PGM LOOP
058300090310    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
058400090310      *
058500090227     C                   ENDSR
058600081208      ******************************************************************
