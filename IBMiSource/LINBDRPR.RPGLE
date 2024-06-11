0001000204020002  *****************************************************************************
000200210422      * LINBDRPR   Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400210421      *            DATE - 04/2021                                                 *
000500210422      *  DESCRIPTION - Build Report file for Lincoln Dental                       *
000600210421      *                Eligibility - Lincoln Fmt V2                               *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900210421      *  xxx mm/dd/yyyy                                                           *
001000200828      *
0011009102150018 F******************************************************************
0012002104220020 FLINDTLP   IF   E           K DISK
0013002104220020 FLINRPTP   O    E           K DISK
0014000204020025  *
0015002104220025  *
0016002104220250 D                 DS
0017002104220037 D lidzip                  1      9
001800210422     D  zip5                   1      5
0019002104220025  *
0020002104220250 D                 DS
0021002104220037 D wkdate          S               D   datfmt(*iso)
002200210422     D usadt           S               D   DATFMT(*USA/)
0023000204040291  *
0024002104220291  * Main Line
0025002104220297 C     *LOVAL        setll     lindtlp                            22
0026002104220296 C                   dou       *in22 = '1'
0027002104220297 C                   read      lindtlp                                22
0028002104220296 C                   if        *in22 = '0'
0029002104220291  *       Check for Non-empoyee
0030002104220291  *        Chk for Mbr or Dep
0031002104220296 C                   If        LIDPER# = 0
0032002104220291  *          Write previous record
0033002104220296 C                   If        LIRSSN <> *blanks
003400210422     C                   write     linrptr
003500210422     C                   endif
0036002104220291  *          Build Mbr part of record
003700210422     C                   clear                   linrptr
003800210422     C                   eval      lirssn = lidssn
003900210422   X* *
004000210422     C                   if        lidtmdt <> 0
004100210422     C                   movel     lidtmdt       wkdate
004200210422     C                   move      wkdate        usadt
004300210422     C                   move      usadt         lirtmdt
004400210422     C                   endif
004500210422   X* *
004600210519     C                   eval      lirlnam = lidlnam
004700210519     C                   eval      lirfnam = lidfnam
004800210519     C                   eval      lirmi = lidmi
004900210519     C                   eval      lirsex = lidsex
005000210519   X* *
005100210519     C                   movel     liddob        wkdate
005200210519     C                   move      wkdate        usadt
005300210519     C                   move      usadt         lirdob
005400210519   X* *
005500210519     C                   movel     lidefdt       wkdate
005600210519     C                   move      wkdate        usadt
005700210519     C                   move      usadt         lirefdt
005800210519   X* *
005900210519     C                   eval      liradd1 = lidadd1
006000210519     C                   eval      liradd2 = lidadd2
006100210422     C                   eval      lircity = lidcity
006200210422     C                   eval      liradd1 = lidadd1
006300210422     C                   eval      lirst = lidst
006400210422     C                   eval      lirzip = zip5
006500210422   X* *
006600210422     C                   movel     liddoh        wkdate
006700210422     C                   move      wkdate        usadt
006800210422     C                   move      usadt         lirdoh
006900210422   X* *
007000210422     C                   eval      lirpln# = lidpln#
007100210426     C                   eval      lirtier = lidtier
007200210422   X* *
007300210422     C                   else
0074002104220291  *        Chk for Dep#
0075002104220296 C                   If        LIDPER# = 01
0076002104220107  *
007700210422   X* *
007800210422     C                   eval      lirlnamd = lidlnam
007900210422     C                   eval      lirfnamd = lidfnam
008000210422     C                   eval      lirmid = lidmi
008100210422     C                   eval      lirsexd = lidsex
008200210422   X* *
008300210422     C                   movel     liddob        wkdate
008400210422     C                   move      wkdate        usadt
008500210422     C                   move      usadt         lirdobd
008600210422   X* *
008700210422     C                   eval      lirreld = lidrel
008800210512     C                   eval      lircovd = 'D'
008900210514     C                   eval      lirstd = lidstd
009000210422   X* *
009100210422     C                   else
0092002104220291  *        Chk for Dep#
0093002104220296 C                   If        LIDPER# = 02
0094002104220107  *
009500210422   X* *
009600210422     C                   eval      lirlnam2 = lidlnam
009700210422     C                   eval      lirfnam2 = lidfnam
009800210422     C                   eval      lirmi2 = lidmi
009900210422     C                   eval      lirsex2 = lidsex
010000210422   X* *
010100210422     C                   movel     liddob        wkdate
010200210422     C                   move      wkdate        usadt
010300210422     C                   move      usadt         lirdob2
010400210422   X* *
010500210422     C                   eval      lirrel2 = lidrel
010600210512     C                   eval      lircov2 = 'D'
010700210514     C                   eval      lirstd2 = lidstd
010800200528      *
010900210422     C                   else
0110002104220291  *        Chk for Dep#
0111002104220296 C                   If        LIDPER# = 03
0112002104220107  *
011300210422   X* *
011400210422     C                   eval      lirlnam3 = lidlnam
011500210422     C                   eval      lirfnam3 = lidfnam
011600210422     C                   eval      lirmi3 = lidmi
011700210422     C                   eval      lirsex3 = lidsex
011800210422   X* *
011900210422     C                   movel     liddob        wkdate
012000210422     C                   move      wkdate        usadt
012100210422     C                   move      usadt         lirdob3
012200210422   X* *
012300210422     C                   eval      lirrel3 = lidrel
012400210512     C                   eval      lircov3 = 'D'
012500210514     C                   eval      lirstd3 = lidstd
012600210422   X* *
012700210422      *
012800210422     C                   else
0129002104220291  *        Chk for Dep#
0130002104220296 C                   If        LIDPER# = 04
0131002104220107  *
013200210422   X* *
013300210422     C                   eval      lirlnam4 = lidlnam
013400210422     C                   eval      lirfnam4 = lidfnam
013500210422     C                   eval      lirmi4 = lidmi
013600210422     C                   eval      lirsex4 = lidsex
013700210422   X* *
013800210422     C                   movel     liddob        wkdate
013900210422     C                   move      wkdate        usadt
014000210422     C                   move      usadt         lirdob4
014100210422   X* *
014200210422     C                   eval      lirrel4 = lidrel
014300210512     C                   eval      lircov4 = 'D'
014400210514     C                   eval      lirstd4 = lidstd
014500210422   X* *
014600210422     C                   else
0147002104220291  *        Chk for Dep#
0148002104220296 C                   If        LIDPER# = 05
0149002104220107  *
015000210422   X* *
015100210422     C                   eval      lirlnam5 = lidlnam
015200210422     C                   eval      lirfnam5 = lidfnam
015300210422     C                   eval      lirmi5 = lidmi
015400210422     C                   eval      lirsex5 = lidsex
015500210422   X* *
015600210422     C                   movel     liddob        wkdate
015700210422     C                   move      wkdate        usadt
015800210422     C                   move      usadt         lirdob5
015900210422   X* *
016000210422     C                   eval      lirrel5 = lidrel
016100210512     C                   eval      lircov5 = 'D'
016200210514     C                   eval      lirstd5 = lidstd
016300210422   X* *
016400200528     C                   endif                                                  *in62 = '0'
016500210422     C                   endif                                                  *in62 = '0'
016600210422     C                   endif                                                  *in62 = '0'
016700210422     C                   endif                                                  *in62 = '0'
016800210422     C                   endif                                                  *in62 = '0'
0169002104220291  *
0170002104220297 C                   endif                                                  *in21 = '1'
0171002104220291  *
0172002104220297 C                   endif                                                  *in21 = '1'
0173002104220291  *
0174002104220297 C                   enddo                                                  *in21 = '1'
0175002104220291  *          Write Last record
0176002104220296 C                   If        LIRSSN <> *blanks
017700210422     C                   write     linrptr
017800210422     C                   endif
0179002104220291  *
0180002104220297 C                   movel     '1'           *inlr
0181002104220297 C                   return
0182002104220291  *
