000001060531      * list active split comm where gbs is part of the split but gbs
000002060531      * (SA) is not first so it will not be used in cr130hst
000003090116      * 1/16/09 - shelly request - stop running this in robot
000004051004
0001010510040005 Fcmct14    ip   e           k disk
0001060510040014 FSMAN      IF   e           k DISK
0001070606010014 Faccmst    IF   e           k DISK
000108060531     fsmanrlt   if   e           k disk
000109060531     fspragxr2  if   e           k disk
0001100606010005 Fmcov14    if   e           k disk
000111060531     fqsysprt   o    f  132        printer oflind(*inof)
0001170605310037 D wkag            S                   like(sxagcy)                         last day of month
0001180605310037 D wksa            S                   like(sxsuper)                        last day of month
0001190605310037 D wksman          S                   like(srsman)                         last day of month
0001200605310037 D firstag         S                   like(sxagcy)                         last day of month
0001210605310037 D firstsa         S                   like(sxsuper)                        last day of month
0001220605310037 D firstsman       S                   like(slsman)                         last day of month
0001230605310037 D firstrel        S                   like(cmrelid)                        last day of month
0001240605310037 D gbs             S              1                                         last day of month
0001250605310169 D                 DS
000126060531     D  L1CTL                  1     14
000127060531     D  cmtrst                 1      3  0
000128060531     D  csubdv                 4      6  0
000129060531     D  cmacct                 7     10  0
000130060531     D  cmplan                11     14
0001310605310169 D                 DS
000132060531     D  L1CTLh                 1     14
0001330606050044 D                UDS
0001380606050050 D  CONAME               201    240
000139060531     icomcxr
000140060531     i                                          cmtrst        l1
000141060531     i                                          csubdv        l1
000142060531     i                                          cmacct        l1
000143060531     i                                          cmplan        l1
000151060531     c                   if        *inl1
000152060531     c                   clear                   gbs
000153060531     c                   clear                   firstag
000154060531     c                   clear                   firstsa
000155060531     c                   clear                   firstsman
000156060531     c                   clear                   firstrel
000157060531     c                   exsr      #getrel
000158060531     c                   move      wkag          firstag
000159060531     c                   move      wksa          firstsa
000160060531     c                   move      wksman        firstsman
000161060531     c                   move      cmrelid       firstrel
000162060531     c                   else
000163060531     c                   exsr      #getrel
000164060531     c                   end
000165060531
000166060531     c                   if        wksa = '959'
000167060531     c                   eval      gbs = 'Y'
000168060531     c                   end
000169051004
000170060531     cl1                 exsr      #l1tot
000171060531
000172060531     c     #end          tag
000173060605     clr                 except    tot
000421051004
000422051004      ********************
000424051004      ********************
000425060531     c     #getrel       begsr
000426060531
000427060531     c                   clear                   wkag
000428060531     c                   clear                   wksa
000429060531     c                   clear                   wksman
000430060531
000434060531
000437060531     c     cmrelid       chain     smanrlt
000438060531     c                   if        %found(smanrlt)
000439060531     C                   EVAL      wksman = srsman
000445060531     c     srasid        chain     spragxr2
000446060531     c                   if        %found(spragxr2)
000453060531     C                   EVAL      wkag = SXAGCY
000454060531     C                   EVAL      wksa = SXsuper
000455060531     c                   end
000456060531     c                   end
000458060531
000459060531     c                   endsr
0004600605310188 C*
000461060531     c     #l1tot        begsr
000465060531
000471060531     c                   if        gbs = 'Y' and firstsa <> '959'
000472060601     c     acckey        chain     accmst
000473060601     c                   clear                   wkterm            8 0
000474060601     c                   if        %found(accmst)
000475060601     c                   move      atrmdt        wkterm
000476060601     c                   end
000477060601
000478060601     c                   clear                   hit
000479060601     c                   if        wkterm = 0
000480060601     c                   exsr      #getmcov
000481060601     c                   end
000482060601
000483060601     C   of              except    head
000484060601     C                   except    err
000485060605     C                   add       1             toterr            6 0
000486060605     c                   end
000487060531
000488060531     c                   endsr
000489060601
000490060601      *********************************
000491060601      * any active mcov?
000492060601      *********************************
000493060601
000494060601     c     #getmcov      begsr
000495060601     c                   clear                   hit               1
000496060601     c     mckey         setll     mcov14
0004970606010131 C                   dou       %eof(mcov14)
0004980606010132 C     mckey         READE     mcov14
000499060601     c                   if        not %eof(mcov14) and
000500060601     c                             candt = 0
000501060601     c                   move      'Y'           hit
000502060605     C                   add       1             tothit            6 0
000503060601     c                   leave
000504060601     c                   end
000505060601
000506060601     c                   enddo
000507060601     c                   endsr
000508060601
000509060601     c     *inzsr        begsr
000510060601
0005110606050053 C                   TIME                    HTIME             6 0
000512060605
000513060601     c     acckey        klist
000514060601     c                   kfld                    cmtrst
000515060601     c                   kfld                    csubdv
000516060601     c                   kfld                    cmacct
000517060601
000518060601     c     mckey         klist
000519060601     c                   kfld                    cmtrst
000520060601     c                   kfld                    csubdv
000521060601     c                   kfld                    cmacct
000522060601     c                   kfld                    cmplan
000523060601
000524060601     c                   except    head
000525060601     c                   endsr
000526060601
000527060605     oqsysprt   e            head           2 02
0005280606050092 O                       CONAME              87
000529060605     o          e            head           1
0005300606050096 O                                            5 'DATE:'
0005310606050094 O                       UDATE         Y     14
000532060605     O                                           61 'SPLIT COMMISSIONS WHERE '
000533060605     O                                           87 'GBS IS NOT FIRST (BY SUPER'
000534060605     O                                           95 ' AGENCY)'
0005350606050096 O                                          120 'PAGE :'
0005360606050097 O                       PAGE          Z    126
000537060605     o          e            head           1
000538060605     O                                           10 'PGM: QDC16'
0005390606050100 O                                          120 'TIME :'
0005400606050101 O                       HTIME              130 '  :  :  '
0005410606050102 O          E            HEAD           1
0005420606050103 O                                           24 '------------------------'
0005430606050104 O                                           48 '------------------------'
0005440606050105 O                                           72 '------------------------'
0005450606050106 O                                           96 '------------------------'
0005460606050107 O                                          120 '------------------------'
0005470606050108 O                                          132 '------------'
000548060605     o          e            head           1
000549060605     O                                           13 'ACCOUNT #'
000550060605     O                                           19 'PLAN'
000551060605     O                                           25 'SMAN'
000552060605     O                                           35 'RELID'
000553060605     O                                           43 'SUPER'
000554060605     O                                           55 'ACCOUNT'
000555060605     O                                           65 'ACTIVE'
000556060605     o          e            head           1
000558060605     O                                           43 'AGENCY'
000559060605     O                                           55 'TERM DATE'
000560060605     O                                           65 'MEMBERS'
0005610606050102 O          E            HEAD           2
0005620606050103 O                                           24 '------------------------'
0005630606050104 O                                           48 '------------------------'
0005640606050105 O                                           72 '------------------------'
0005650606050106 O                                           96 '------------------------'
0005660606050107 O                                          120 '------------------------'
0005670606050108 O                                          132 '------------'
000568060601     o          e            err            1
000600060531     O                       cmtrst               4
000601060605     O                                            5 '-'
000700060605     O                       csubdv               8
000701060605     O                                            9 '-'
000800060605     O                       cmacct              13
000900060605     O                       cmplan              19
001000060605     O                       firstsman           25
001001060605     O                       firstrel            35
001100060605     O                       firstsa             43
001200060605     O                       wkterm              55 '    /  /  '
001300060605     O                       hit                 63
001400060605     o          e            tot         1  1
001600060605     O                                              'Total Errors:'
001601060605     O                       toterr        3     +1
001602060605     O                                           +2 'Total w/Active Members:'
001603060605     O                       tothit        3     +1
