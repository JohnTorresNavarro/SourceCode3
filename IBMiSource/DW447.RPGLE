0001000204020002  *****************************************************************************
000200100429      * DW447      Group Benefit Services                                         *
000300020402      *            WRITTEN BY - R.L.J.                                            *
000400100429      *            DATE - 04/2010                                                 *
000500100429      *  DESCRIPTION - Create MBI update files for Group Renewals                 *
000600100430      * NOTE!! When you make a chg to MBICP files - change D-specs here           *
0007000204020002  *****************************************************************************
0008000204020015  *  Change Log:                                                              *
000900020402      *                                                                *
0010009102150018 F******************************************************************
0011001004290020 FMBCUR2L   IF   E           K DISK
0012000910010020 FMBIAP     UF   E             DISK
0013000910010020 FMBICP     O    E             DISK
0014000910080020 FMBCMBP    O    E             DISK
0015000707230025  *
0016000204030250 D                 DS
0017000910020251 D  mcarea                 1      3  0
0018000910020251 D   areac                 1      3
0019000910020025  *
0020000910020250 D                 DS
0021001005140251 D  kgrp                   1     15
0022001005140251 D   kgrp4                 1      4
0023001005140025  *
0024001005140250 D                 DS
0025001005140251 D  mcgrp#                 1     15
0026001005140251 D   grp4                  1      4
0027001004210251 D   grp1                  1      1
0028001004210251 D   grp24                 2      4
0029000912030251 D   grp12                 1     12
0030000912030251 D   grp13                13     15
0031001003260025  *
0032001003260250 D                 DS
0033001003260251 D  mbgrp#                 1      9
0034001003260251 D   bgrp1                 1      3    INZ('GBS')
0035001003260251 D   bgrp2                 4      7
0036000711080029  *
0037000711080250 D                 DS
003800091002     D  recct                  1      6S 0
003900091002     D  reccta                 1      6
004000090108    * *
0041000901080053 D                 DS
0042000910020054 D  wkamt          S              9
0043000910130251 D  cntf           S              2  0 INZ(0)
0044000910130251 D  cntt           S              2  0 INZ(0)
0045000910130251 D  cntl           S              2  0 INZ(0)
0046000910130251 D  fnm1           S              1
0047000711080111  *
0048000910080029  *   Format Output Records
0049000910080250 D                 DS
0050000910150251 D  icrec                  1    138
0051000910080251 D   icrcid                1      2
0052000910080251 D   ictpa                 3      8
0053000910080251 D   icemlr                9     17
0054000910150251 D   icplan               18     35
0055000912030251 D     pln12              18     29
0056000912030251 D     pln4               18     21
0057000912030251 D     pln3               22     24
0058000910150251 D   icemly               36     44
0059000910150251 D   icactp               45     48
0060000910150251 D   icpeff               49     56
0061000910150251 D   icptrm               57     64
0062000910150251 D   icsts                65     65
0063000910150251 D   iceypp               66     84
0064000910150251 D   icerpp               85    103
0065000910150251 D   icefrf              104    122
0066000910150251 D   icetrm              123    130
0067000910150251 D   iceeff              131    138
0068000508240291  *
0069001004300291  *         Group shit
0070001101110296 C                   movel(P)  '9329'        kgrp
0071001004290297 C     kgrp          setll     mbcur2l                                21
0072000910020296 C                   dou       *in21 = '1'
0073001005140297 C                   read      mbcur2l                                21
0074001005210291  *
0075001005140296 C                   if        *in21 = '0'
0076000809260291  *
0077001005140296 C                   if        grp4 <> kgrp4
0078001005140296 C                   eval      *in21 = '1'
0079001005140296 C                   else
0080001005140291  *
0081001004290296 C                   If        mctfdt = 0 and mcseq# = 0
0082000809260291  *      DEBUG
0083001006100296 C                   If        mcmid# = 230643464
0084001004290296 C                   movel     mcmid#        mcmid#
0085000910020296 C                   endif
008600080926      *
008700100429     C                   exsr      putc
008800091001      *
008900080725     C                   endif
009000100514     C                   endif
009100080725     C                   endif
009200091002      *
009300091002     C                   enddo
009400100429      *
009500100429     C                   eval      recct = recct + 1
009600100429     C                   movel     reccta        iarcnt
009700100429     C                   update    mbiar
009800091002      *
0099000910020297 C                   movel     '1'           *inlr
0100000910020297 C                   return
0101000705300107  ********************************************************************************
0102000705300107  *
0103001004290107  *     PUTC - Write the New record to MBI Import files
0104000705300107  *
0105000705300107  ********************************************************************************
010600100429     C     putc          begsr
010700070530    * *
0108000910010291  *     IC Rec
010900100429     C                   movel     grp4          bgrp2
011000100429     C                   movel(P)  mbgrp#        icemlr
011100091001     C                   movel     mcmid#        icemly
011200091001     C                   movel(P)  'HRA'         icactp
011300091203     C                   if        grp13 <> '   '
011400091204     C******?            movel(P)  grp13         pln3
011500100315     C                   movel(P)  grp13         icactp
011600091014     C                   endif
011700100315      *
011800100315     C                   movel(P)  grp12         pln12
011900100315     C                   if        pln3 = *blanks
012000100315     C                   movel(P)  'HRA'         pln3
012100100315     C                   endif
012200100315      *
012300100315     C                   movel     mcpefd        icpeff
012400100315     C                   movel     mcptrd        icptrm
012500091001     C                   eval      icsts = '1'
012600091001     C                   move      '0.00'        iceypp
012700091001     C                   move      '0.00'        icerpp
012800091002     C                   eval      wkamt = %EDITW(mcrate:'      .  ')
012900091002     C                   move      wkamt         icefrf
013000091002     C                   if        mctfdt = 0
013100091002     C                   eval      icetrm = *blanks
013200091002     C                   else
013300120918     C*****              movel     mctfdt        icetrm
013400091002     C                   endif
013500100429     C*******            movel     mcefdt        iceeff
013600100429     C                   movel     icpeff        iceeff
013700091001    * *     Write IC rec
013800091001     C                   write     mbicr
013900091008     C                   clear                   mbcmbr
014000091008     C                   movel     icrec         mcdata
014100091008     C                   write     mbcmbr
014200091001     C                   eval      recct = recct + 1
014300091001    * *
014400100429     C                   endsr
0145000910130107  ********************************************************************************
0146000910130107  *
0147000910130107  *     INZSR - Preprocessing
0148000910130107  *
0149000910130107  ********************************************************************************
015000071108     C     *Inzsr        Begsr
015100091001    * *   SET DEFAULT FIELDS
0152000910010297 C                   clear                   mbicr
0153001001150297 C                   eval      icrcid = 'IC'
0154001001150297 C                   eval      ictpa = 'T00025'
015500091001    * *   Get IA rec
015600091001     C                   read      mbiap
0157000910010297 C                   eval      recct = 0
015800091001    * *
015900091001     C                   endsr
