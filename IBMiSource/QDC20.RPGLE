000001070919      * find comctx where commission override is used with a care first /
000003070919      * dbe carrier and the market size is 50.
000004070921      * This will be run in robot on the 15th of the month with an effdt
000005070921      * of next month
000006070921      * 09/19/07 DLK - Create this list for Shelly
000007070921      * 09/21/07 DLK - Put in robot
000008121120      * 11/20/12 DLK - convert to email the report per request from Brandon
000009170216      * 02/16/17 DLK - remove carbc codes 1 - 4
000010051004
0001010709190005 Fcmct14    ip   e           k disk
0001020708230016 Fplnmst    IF   e           k DISK
0001030708230016 Fcarmst    IF   e           k DISK
0001040708230014 Fmktcara1  IF   e           k DISK
000107121120     fqdc20p    o    f  132        printer oflind(*inof)
0001080709210037 D workdt          S               d   datfmt(*iso)                         last day of month
0001100708230055 D                 DS
0001110708240056 D  tsa                    1     10
000112070824     D  cmtrst                 1      3  0
000113070824     D  csubdv                 4      6  0
000114070824     D  cmacct                 7     10  0
0001150709210053 D                UDS
0001160709210054 D  CONAME               201    240
0001170709210055 D  TIME                 242    247  0
000130070823
000403070919     c                   if        (cmcan = 0 and cccmsp = 0) and
000404070919     c                             (ccovpp <> 0 or ccovra <> 0 or ccovpc <> 0)
0004060708230063 C     plnkey        CHAIN     plnmst
000407070823     c                   if        %found(plnmst)
0004080708230063 C     pcarr         CHAIN     carmst
000409170216     c                   if        %found(carmst) and carbc = 'D'
000418070919     c                   exsr      #chkmkt
000419070823     c                   end
000420070823     c                   end
000421070823     c                   end
000427070611
0004280708230069 C**************************************************************
0004290709190069 C*   check market size                                        *
0004300708230069 C**************************************************************
0004310708230069 C*
000432070919     c     #chkmkt       begsr
000433070823
000434070823     c* get market size - defalut to 50
000435070823
000436070823     c                   movel     '50   '       mksz              5
000437070823     c                   eval      *in67 = *off
000438070823     c     mkcaky        setll     mktcara1
000439070823     C                   dow       *in67 = *off
000440070823     c     mkcaky        reade     mktcara1                               67
0004410708230133 C   67              leave
000442070823     c                   if        runymd < mafrdt or (matodt <> 0 and
000443070823     c                             runymd > matodt) or (mafrdt = matodt)
000444070823     c                   iter
000445070823     c                   endif
000446070823     c                   movel     maszcd        mksz
000447070823     c                   enddo
000448070823
000449070919     c*
000455070919     c                   if        mksz = '50   '
000468070823     c                   add       1             count             5 0
000469070823     C                   MOVE      effdat        @DATIN
000470070823     C                   EXSR      #DATYM
000471070823     C                   MOVE      @DATOU        effdatmdy         8 0
000472070823     C                   MOVE      cmcan         @DATIN
000473070823     C                   EXSR      #DATYM
000474070823     C                   MOVE      @DATOU        cmcanmdy          8 0
000475070823     c   of              except    head
000476070823     c                   except    prt
000492070823     c                   end
000493070823
000494070823     c                   endsr
000495070823
0005500708230103 C***************************************************
0005510708230104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0005520708230105 C***************************************************
0005530708230107 C*
0005540708230107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0005550708230107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0005560708230107 C*
0005570708230106 C     #DATYM        BEGSR
000558070823     C                   MOVEL     @DATIN        @Y                4 0
000559070823     C                   MOVE      @DATIN        @MD               4 0
000560070823     C                   MOVE      @Y            @DATOU            8 0
000561070823     C                   MOVEL     @MD           @DATOU
000562070823     C                   MOVE      *ZEROS        @DATIN            8 0
0005630708230120 C                   ENDSR
000564070611     c     *inzsr        begsr
000566070823     c     mkcaky        klist
000567070823     c                   kfld                    cmtrst
000568070823     c                   kfld                    csubdv
000569070823     c                   kfld                    cmacct
000570070823     c                   kfld                    pcarr
000571070823     c     plnkey        klist
000572070611     c                   kfld                    cmtrst
000573070611     c                   kfld                    csubdv
000574070823     c                   kfld                    cmplan
000575070823     c     brcmky        klist
000576070823     c                   kfld                    pcarr
000577070823     c                   kfld                    mksz
000578070824
000579070921      * run effective date will be next month sice this will be run
000580070921      * in robot on the 15th
000581070921
000582070824     C                   MOVE      *DATE         @DATIN
000583070824     C                   EXSR      #DATym
000584070824     C                   MOVE      @DATOU        UD8YMD            8 0
000585070921     c                   move      ud8ymd        workdt
000586070921     c                   adddur    1:*m          workdt
000587070921     c                   move      workdt        runymd            8 0
000588070824
000589070611     c                   except    head
000590070611     c                   endsr
000591121120     oqdc20p    e            head           2  2
0005920709210239 O                                           44 '*****'
0005930709210240 O                       CONAME              85
0005940709210241 O                                           91 '*****'
000595070921     o          e            head           1
0005960709210244 O                                           51 'COMMISSION CONTROL WITH '
0005970709210245 O                                           75 'OVERRIDES TO CARE FIRST '
0005980709210245 O                                           99 'PLANS IN MARKET SIZE 50 '
0005990709210245 O                                          123 'ACCOUNTS                '
000600070921     o          e            head           1
0006010709210248 O                                           19 'PROGRAM NAME: QDC20'
0006020709210249 O                                          122 'PAGE :'
0006030709210250 O                       PAGE          Z    131
000604070921     o          e            head           1
0006050709210253 O                                            9 'RUN DATE:'
0006060709210254 O                       UDATE         Y     22
0006070709210255 O                                          122 'TIME :'
0006080709210256 O                       TIME               131 '  :  :  '
000609070921     o          e            head           1
000610070921     o                                           24 '------------------------'
000611070921     o                                           48 '------------------------'
000612070921     o                                           72 '------------------------'
000613070921     o                                           96 '------------------------'
000614070921     o                                          120 '------------------------'
000615070921     o                                          132 '------------'
000616070921     o          e            head           1
000617000925     o                                           15 'TRUST-SUB-ACCT'
000618051013     o                                           21 'PLAN'
000619070823     o                                           26 'CARR'
000620070823     o                                           31 'SMAN'
000621070919     o                                           44 'COMMISSION'
000622070919     o                                           56 'COMMISSION'
000623070823     o                                           91 '  OVERRIDE'
000624070823     o                                          103 '  OVERRIDE'
000625070919     o                                          115 '  OVERRIDE'
000626070919     o                                          127 'COMMISSION'
000627070921     o          e            head           1
000628070919     o                                           44 'EFFECTIVE'
000629070919     o                                           56 '   CANCEL'
000630070823     o                                           91 '       FEE'
000631070823     o                                          103 ' % OF PREM'
000632070919     o                                          115 ' % OF COMM'
000633070919     o                                          127 '     SPLIT'
000634070921     o          e            head           2
000635070921     o                                           24 '------------------------'
000636070921     o                                           48 '------------------------'
000637070921     o                                           72 '------------------------'
000638070921     o                                           96 '------------------------'
000639070921     o                                          120 '------------------------'
000640070921     o                                          132 '------------'
000641000925     o          e            prt            1
000642000925     O                       cmtrst               4
000700051013     O                       csubdv               9
000800051013     O                       cmacct              15
000900051013     O                       cmplan              21
000901070823     O                       pcarr               26
001000070823     O                       slsman              31
001200070823     O                       effdatmdy           44 '  /  /    '
001300070823     O                       cmcanmdy            56 '  /  /    '
001305070823     O                       ccovra        4     91
001306070823     O                       ccovpp        4    103
001308070919     O                       ccovpc        4    115
001309070919     O                       cccmsp        4    127
001310070823     o          t    lr                  1  1
001311051004     O                                              'Total:'
001312051004     O                       count         1     +2
