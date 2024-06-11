0001009102150002 F******************************************************************
0002000201140003 F* cr210edit  GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102150004 F*                                                                *
0004000201100004 F*          David Ketterman                                       *
0005000201140004 F*          01/14/02                                              *
0006009510040004 F*                                                                *
0007000201140004 F*          Create CFS compensation and persistency bonus         *
0008000201140013 F*          draw file prompt screen.                              *
0009009808120015 F*                                                                *
0010000602200015 F* 02/20/06 dlk - update for 2006 persistency bonus next year     *
0011000801100015 F* 01/10/08 dlk - update for 2007 persistency bonus               *
0012000812030015 F* 12/03/08 dlk - update for 2008 persistency bonus               *
0013000911240015 F* 11/24/09 dlk - update for 2009 persistency bonus               *
0014001012290015 F* 12/29/10 dlk - update for 2010 persistency bonus               *
0015001112130015 F* 12/13/11 dlk - update for 2011 persistency bonus               *
0016001212180015 F* 12/18/12 dlk - update for 2012 persistency bonus               *
0017001306130015 F* 06/13/13 dlk - update for 2013 persistency bonus               *
0018001412020015 F* 12/02/14 dlk - update for 2014 persistency bonus               *
0019001511180015 F* 11/18/15 dlk - update for 2015 persistency bonus               *
0020001611300015 F* 11/30/16 dlk - update for 2016 persistency bonus               *
0021001712070015 F* 12/07/17 dlk - update for 2017 persistency bonus               *
0022001712290015 F* 12/29/17 dlk - remove coventry                                 *
0023001801240015 F* 01/24/18 dlk - update for special last run (13 months)         *
0024001801240015 F*                1/2017 - 01/2018                                *
0025001901230015 F* 01/23/19 dlk - update for 2019 persistency bonus               *
0026001912130015 F* 12/13/19 dlk - update for 2020 persistency bonus               *
0027002012150015 F* 12/15/20 dlk - update for 2021 persistency bonus               *
0028002112080015 F* 12/08/21 dlk - update for 2022 persistency bonus               *
0029002212290015 F* 12/29/22 dlk - update for 2023 persistency bonus               *
0030001801240015 F*                                                                *
0031009102150016 F******************************************************************
0032000201140018 FCR210d    cf   E             workstn
0033000107240018 Fagency    If   E           K DISK
0034000201140055 D                 DS
0035000201140034 D ag                    102    131                                         CURR AND PREV BALANC
003600020114     D                                     DIM(10)                              CURR AND PREV BALANC
0037000201140125 D  ag1                  102    104
0038000201140125 D  ag2                  105    107
0039000201140125 D  ag3                  108    110
0040000201140125 D  ag4                  111    113
0041000201140125 D  ag5                  114    116
0042000201140125 D  ag6                  117    119
0043000201140125 D  ag7                  120    122
0044000201140125 D  ag8                  123    125
0045000201140125 D  ag9                  126    128
0046000201140125 D  ag10                 129    131
0047000201140124 D                 DS
0048000201140125 D  fmmyy                  1      6  0
0049000201140125 D  fm                     1      2  0
0050000201140125 D  fy                     3      6  0
0051000201140124 D                 DS
0052000201140125 D  tmmyy                  1      6  0
0053000201140125 D  tm                     1      2  0
0054000201140125 D  ty                     3      6  0
0055000201140124 D                UDS
0056000201140125 D  LFYMD                 85     92  0
0057000201140125 D  LTYMD                 93    100  0
0058000201140125 D  bdyorn               101    101
0059000201140125 D  agout                102    131
0060000301080125 D  apbyorn              132    132
006100020114
006200020114     c     *ENTRY        plist
006300020114     c                   parm                    cmd7              1
006400020114
006500020114     c                   clear                   fmmyy
006600020114     c                   clear                   tmmyy
006700020114     c                   clear                   lfymd
006800020114     c                   clear                   ltymd
006900020114     c                   dow       *in07 = *off and *inlr = *off
007000020114     c                   exfmt     scrn01
007100020114
007200020114     c                   clear                   error
007300030108     c                   movea     '000'         *in(2)
007400020114     c                   movea     '0000000000'  *in(20)
007500020114
007600020114     c                   if        *in07 = *on
007700020114     c                   eval      cmd7  = 'Y'
007800020114     c                   eval      *inlr = *on
007900020114     c                   leave
008000020114     c                   end
008100020114
008200020114     c                   move      fy            lfy               4 0
008300020114     c                   movel     fm            lfmd              4 0
008400020114     c                   move      01            lfmd
008500020114     c                   movel     lfy           lfymd
008600020114     c                   move      lfmd          lfymd
008700020114
008800020114     c                   move      ty            lty               4 0
008900020114     c                   movel     tm            ltmd              4 0
009000020114     c                   move      01            ltmd
009100020114     c                   movel     lty           ltymd
009200020114     c                   move      ltmd          ltymd
009300020114
009400020114     c* date edit
009500050128     c                   eval      *in02 = *off
009600050128     c                   eval      *in03 = *off
009700020114     c                   if        lfymd < 20010101
009800020114     c                   eval      *in02 = *on
009900020114     c                   move      'Y'           error
010000020114     c                   end
010100020114     c                   if        ltymd < 20010101
010200020114     c                   eval      *in03 = *on
010300020114     c                   move      'Y'           error
010400020114     c                   end
010500020114
010600020114     c* in = indicator 20-29; a = agency entered on screen
010700020114
010800020114     c                   if        bdyorn = 'Y'
010900020114
011000020114     c                   z-add     20            in                2 0
011100020114
011200020114     c                   do        10            a                 2 0
011300020114     c                   if        ag(a) <> *blanks
011400020114     C     ag(a)         CHAIN     agency
011500020114     c                   if        not %found(agency)
011600020114     c                   eval      *in(in) = *on
011700020114     c                   move      'Y'           error             1
011800020114     c                   end
011900020114     c                   end
012000020114     c                   add       1             in
012100020114     c                   enddo
012200020114
012300020114     c                   end
012400020114
012500061212      * Date edit for Care Fisrt or Coventry
012600061212      * persistency bonus selection
012700030108
012800050128     c                   eval      *in04 = *off
012900171229     c                   if        (apbyorn = 'Y')
013000221229     c                             and (lfymd <> 20220201 or ltymd <> 20230101)
013100030108     c                   move      'Y'           error             1
013200030108     c                   eval      *in04 = *on
013300030108     c                   end
013400050128
013500020114     c* any errors redisplay screen
013600020114
013700020114     c                   if        error = 'Y'
013800020114     c                   iter
013900020114     c                   end
014000020114
014100020114     c                   movea     ag            agout
014200020114     c                   eval      *inlr = *on
014300020114
014400020114     c                   enddo
