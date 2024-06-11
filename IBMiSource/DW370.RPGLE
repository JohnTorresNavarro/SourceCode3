0000010506020002 F******************************************************************
0000020506020003 F* DW370      GROUP BENEFIT SERVICES                              *
000003050602     F*
0000040506020005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0000050506020006 F*            DATE - 06/02/05                                     *
0000060506020015 F*                                                                *
0000070506030008 F*         This program will read the daily crosswalk file from
000008050603     F*         Care First and update the MEMALT file.
0000100506020015 F*                                                                *
0000110506020013 F******************************************************************
0000120506020014 F*                                                                *
0001000506020005 Fcfxwalk   ip   e             disk
0001010506020005 Fmemalt    uf a e           k disk
0001030506020231 D                 DS
0001040506020232 D cfxcrtdt                1     10
0001050506020232 D wkmm                    1      2
0001060506020232 D wkdd                    4      5
0001070506020232 D wkyy                    7     10
0001080506020231 D                 DS
0001090506020232 D wkdate2                 1      8  0
0001100506020232 D wkyy2                   1      4  0
0001110506020232 D wkmm2                   5      6  0
0001120506020232 D wkdd2                   7      8  0
000201050610     c                   movel     cfxplatid     kplat             4
000202050602     c                   move      cfxssn        kssn              9 0
000203050603     c                   movel     cfxsid        kalt             20
000206050602
000207050602     c     altkey        chain     memalt
000208050602     c                   if        not %found(memalt)
000209050602     c                   exsr      #add
000210050602     c                   else
000211050602     c                   exsr      #update
000212050602     c                   end
000213050602
000214050602      ************************
000215050602      * add new rec
000216050602      ************************
000217050602     c     #add          begsr
000218050602
000219050602     c                   clear                   memaltr
000220050603     c                   movel     cfxsid        maaltid
000221050602     c                   move      cfxssn        mamemid
000222050610     c                   movel     cfxplatid     maalttp
000223050602     c                   move      cfxlname      malname
000224050602     c                   move      cfxfname      mafname
000225050602
000226050602     c                   clear                   wkdate2
000227050602     c                   move      wkmm          wkmm2
000228050602     c                   move      wkdd          wkdd2
000229050602     c                   move      wkyy          wkyy2
000230050602     c                   move      wkdate2       macrtdt
000400050602     c                   write     memaltr
000500050602     c                   endsr
000600050602      ************************
000700050602      * update rec
000800050602      ************************
000900050602     c     #update       begsr
001000050602
001001050602      * name change ?
001100050602     c                   if        malname <> cfxlname or
001101050602     c                             mafname <> cfxfname
001500050602     c                   move      cfxlname      malname
001600050602     c                   move      cfxfname      mafname
002300050602     c                   update    memaltr
002302050602     c                   end
002400050602     c                   endsr
002401050602
0024030506020106 C     *inzsr        BEGSR
002404050602     c     altkey        klist
002405050602     c                   kfld                    kssn
002406050602     c                   kfld                    kplat
002407050602     c                   kfld                    kalt
002408050602     C                   TIME                    HTIME             6 0
002409050602     c                   endsr
