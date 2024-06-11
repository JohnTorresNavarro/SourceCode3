0001009102150002 F******************************************************************
0002001205150003 F* rpa252     GROUP BENEFIT SERVICES SOFTWARE                     *
0003009102150004 F*                                                                *
0004000201100004 F*          David Ketterman                                       *
0005001205160004 F*          05/16/12                                              *
0006009510040004 F*                                                                *
0007001205160004 F*          read my rpa251wk work file and write to Stephens      *
0008001205150013 F*          streport file for state reporting.                    *
0010009808120015 F*                                                                *
0014000304300015 F*                                                                *
0015000304300016 F******************************************************************
0016001205160018 Frpa251wk  Ip   E           k DISK
0018001205150027 Fstreport  uf a e           k disk
001806120516     D totprem         S                   LIKE(staprem)
001807120516     D totcom          S                   LIKE(stacom)
001808120516     D totaf           S                   LIKE(staaf)
001809120516     D totbd           S                   LIKE(stabd)
001810120516     D totlives        S                   LIKE(stalives)
001811120516     Irpa251wkr
001812120516     I                                          r2STCODE      L3
001813120516     I                                          r2AGCODE      L2
001814120516     I                                          r2CARGRP      L1
001815120516
001816120515     c                   if        *inl1
001817120516     c                   clear                   totprem
001818120516     c                   clear                   totcom
001819120516     c                   clear                   totaf
001820120516     c                   clear                   totbd
001821120516     c                   clear                   totlives
001822120515     c                   end
001823120516
001824120516      * accumulate totals
001825120516     c                   add       r2aprem       totprem
001826120516     c                   add       r2acom        totcom
001827120516     c                   add       r2aaf         totaf
001828120516     c                   add       r2abd         totbd
001829120516     c                   add       r2alives      totlives
001830120516
004100120515     cl1                 exsr      #l1tot
004101120516
004102120516      *****************************************************
004103120516      * at end of l1, update or write new record
004104120516      *****************************************************
004105120515     c     #l1tot        begsr
004106120516
004107120516     c     stkey         klist
004108120516     c                   kfld                    r2STCODE
004109120516     c                   kfld                    r2AGCODE
004110120516     c                   kfld                    r2CARGRP
004111120516
004112120516     c     stkey         chain     streport
004113120516     c                   if        %found(streport)
004114120516     c                   z-add     totprem       staprem
004115120516     c                   z-add     totcom        stacom
004116120516     c                   z-add     totaf         staaf
004117120516     c                   z-add     totbd         stabd
004118120516     c                   z-add     totlives      stalives
004119120515     c                   update    strf
004120120516
004121120515     c                   else
004122120516     c                   clear                   strf
004123120516     c                   movel     r2STCODE      STSTCODE
004124120516     c                   movel     r2AGCODE      STAGCODE
004125120516     c                   movel     r2CARGRP      STCARGRP
004126120516     c                   movel     r2stname      STSTNAME
004127120516     c                   movel     r2AGNAME      STAGNAME
004128120516     c                   movel     r2GRPNAM      STGRPNAM
004129120516     c                   z-add     totprem       staprem
004130120516     c                   z-add     totcom        stacom
004131120516     c                   z-add     totaf         staaf
004132120516     c                   z-add     totbd         stabd
004133120516     c                   z-add     totlives      stalives
006400120515     c                   write     strf
006401120515     c                   end
006402120515
006500120515     c                   endsr
