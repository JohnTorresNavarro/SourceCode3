000001070807      *********************************************************************
000002070807      * 08/07/07 - created from QDC13 - David Ketterman
000003070807      *            To be run from ROBOT.
000004070807      *
000005070807      * cancel active comctx w/no active mcov in active accounts using the
000006070611      * latest grate end date. If the end date is AFTER TODAYS DATE DO NOT
000007070611      * cancel the comctx because the plan is still available to memebrs
000009081124      *
000010081124      * 11/24/08 dlk - add new commmission history file
000011131004      * 10/04/13 dlk - hist file expansion project
000012070807      *
000013070807      *********************************************************************
000014051004
0001010510040005 Fcmct14    up   e           k disk
0001020510040005 Faccmst    if   e           k disk
0001030510040005 Fmcov14    if   e           k disk
0001040510130005 Fgrate     if   e           k disk
0001050708060005 Fhist      o  a e             disk
000106081124     Fcomhst    O  A E             DISK
000107000925     fqsysprt   o    f  132        printer oflind(*inof)
0001080009250037 D workdt          S               d   datfmt(*iso)
0001090009260037 D zero2           S              2  0 inz(*zeros)
0001100009260037 D zero8           S              8  0 inz(*zeros)
0001110009260037 D zero9           S              9  0 inz(*zeros)
0001120510040037 D actacct         S              1
0001130510040037 D activemcov      S              1
0001140510040037 D count           S              6  0 inz(*zeros)
0001151310040037 D sysdateymd      S               d   datfmt(*iso)
000116131004     D thispgmname     S             10a   inz('DB920     ')
0001170708060055 D                 DS
0001180708060056 D  tsa                    1     10
0001190708060056 D  cmtrst                 1      3  0
0001200708060056 D  csubdv                 4      6  0
0001210708060056 D  cmacct                 7     10  0
0001220708060055 D                 DS
0001230708060056 D  note1out               1     30
000124070806     D  n1ptxt                 1      8    inz('PLAN# - ')
000125070806     D  n1cmplan               9     12
000126070806     D  n1stxt                15     25    inz('SALESMAN - ')
000127070806     D  n1slsman              26     28
0001280708060055 D                 DS
0001290708060056 D  note2out               1     30
000130070806     D  n2etxt                 1     11    inz('EFF DATE - ')
000131070806     D  n2effdat              12     19
000132070806
0001330706120053 D                UDS
0001340706120054 D  CONAME               201    240
0001350706120055 D  TIME                 242    247  0
0001360706120157 D  UD8YMD               248    255  0
000137051004     icomcxr
000138051004     i                                          cmtrst        l1
000139051004     i                                          csubdv        l1
000140051004     i                                          cmacct        l1
000141051004     i                                          cmplan        l1
000142051004     c                   if        *inl1
000143051004     c                   eval      actacct = 'N'
000144051004     c                   eval      activemcov = 'N'
000145051004     c     acckey        chain     accmst
000146051013     c                   if        %found(accmst) and atrmdt = 0
000147051013     c                   eval      actacct = 'Y'
000148051004     c                   exsr      #getmcov
000149051013     c                   exsr      #getgrate
000150051004     c                   end
000151051004     c                   end
000152051004
000153051013      * fill cancel date with latest grate end date for active plans w/o
000154070611      * active mcov if the end date was before todays date
000155051004
000156051004     c                   if        cmcan = 0 and actacct = 'Y' and
000157051004     c                             activemcov = 'N' and
000158051013     c                             newcomcan <> 0
000159051004
000160051013      * update comctx
000161081124     c                   move      cmcan         cmcanhold         8 0
000162051004     c                   if        effdat <= newcomcan
000201051004     c                   move      newcomcan     cmcan
000202051013     c                   else
000203051013     c                   move      effdat        cmcan
000204051013     c                   end
000205070723     c                   move      'C'           cmdltd
000206051013
000207070612     C                   MOVE      effdat        @DATIN
000208070612     C                   EXSR      #DATYM
000209070612     C                   MOVE      @DATOU        effdatmdy         8 0
000210070612
000211070612     C                   MOVE      cmcan         @DATIN
000212070612     C                   EXSR      #DATYM
000213070612     C                   MOVE      @DATOU        cmcanmdy          8 0
000214070612
000402051004     c                   add       1             count
000403051004     c   of              except    head
000404051004     c                   except    prt
000405051004     c   u1              update    comcxr
000407070806     C   u1              exsr      #writehist
000417051004
000418051004     c                   end
000419051004
000420051004     clr                 except    lrprt
000421051004
000422051004      ********************
000423051013      * any mcov active?
000424051004      ********************
000425051004     c     #getmcov      begsr
000426051004
000429051004     c     mcovkey       setll     mcov14
0004300510040131 C                   dou       %eof(mcov14)
0004310510040132 C     mcovkey       READE     mcov14
0004400510130133 c                   if        not %eof(mcov14) and
0004410510130133 c                             (enrldt <> candt) and candt = 0
000442051004     c                   eval      activemcov = 'Y'
000443051004     c                   leave
000448051004     c                   end
000450051004     c                   enddo
000466051004
000467051004     c                   endsr
000468051004
000469051013      ********************
000470051013      * find the oldest grate end date
000471051013      ********************
000472051013     c     #getgrate     begsr
000473051013
000474051013     c                   clear                   lastenddt         8 0
000475051013     c                   clear                   newcomcan         8 0
000476051013     c     gratkey       setll     grate
0004770510130131 C                   dou       %eof(grate)
0004780510130132 C     gratkey       READE     grate
000479051013     c                   if        not %eof(grate) and
000480051013     C                             (todat > lastenddt)
000481051013     c                   move      todat         lastenddt
000483051013     c                   end
000484051013     c                   enddo
000485051013
000486070808      * if no rates were found for this plan, fill lastenddt with
000487070808      * 0001/01/01 so we cancel the comctx back to the orig effdt
000488070808
000489070808     c                   if        lastenddt = 0
000490070808     c                   move      00010101      lastenddt
000491070808     c                   end
000492070808
000493051013     c                   if        lastenddt < ud8ymd
000494051013     c                   move      lastenddt     newcomcan
000495051013     c                   end
000496051013
000520051013     c                   endsr
000521070806
000522070806     c***************************************************************
000523070806     c* write history record                                        *
000524070806     c***************************************************************
000525070806     c     #writehist    begsr
000526070806
000527070806     c                   clear                   histr
000528070806
000529070806      * set up note fields
000530070806
000531070806     C                   MOVE      cmplan        n1cmplan
000532070806     C                   MOVE      slsman        n1slsman
000533070806     C                   MOVE      effdat        n2effdat
000534070806
000535070806     C                   MOVE      tsa           HKEY
000536070806     C                   MOVE      'LDC'         TRCODE
000537070806     C                   MOVE      note1out      ck#not
000538070806     C                   MOVE      note2out      note2
000539070806     C                   MOVE      'X'           TRMFLG
000540070806     C                   MOVE      'X'           TRLFLG
000541070806     C                   MOVE      'N'           DTRFLG
000542131004     C                   MOVEl     thispgmname   HPRGNM
000543070806     C                   MOVE      cmtrst        HSTRST
000544070806     C                   MOVE      csubdv        HSSUB#
000545070806     C                   MOVE      cmacct        HSACCT
000546131004     C                   MOVEl     'DB920     '  HOPER
000547070806     C                   MOVE      'A'           HSDLTD
000549131004     C                   eval      sysdateymd = %date
000550131004     C                   MOVE      sysdateymd    trdate
000551131004     c                   eval      hstrtime = %time
000552070806     C                   MOVE      cmcan         COVTDT
000553070806     C                   WRITE     HISTR
000554081124
000555081124      * write new commission history rec
000556081124
000557081124      * common fields in commission history file
000558081124     c                   clear                   comhstr
000559081124     C                   move      cmtrst        chtrust
000560081124     C                   move      csubdv        chsub
000561081124     C                   move      cmacct        chacc
000562081124     C                   MOVEL     cmplan        chplan
000563081124     c                   move      ud8ymd        chtrdat
000564081124     c                   time                    chtrtim
000565081124     C                   MOVEL     'ROBOT     '  chuser
000566081124     C                   MOVEL     'DB920     '  chpgm
000567081124
000568081124      * after fields
000569081124     c                   move      effdat        chaeff
000570081124     c                   move      cmcan         chacan
000571081124     c                   move      cmrelid       charel
000572081124     c                   move      ccovpp        chapop
000573081124     c                   move      ccovra        chaff
000574081124     c                   move      ccovpc        chapoc
000575081124     c                   move      ccpnc         chapnc
000576081124     c                   move      cccmsp        chacmsp
000577090416     c                   movel     free5         chapri
000578081124
000579081124      * before fields
000580081124     c                   move      effdat        chbeff
000581081124     c                   move      cmcanhold     chbcan
000582081124     c                   move      cmrelid       chbrel
000583081124     c                   move      ccovpp        chbpop
000584081124     c                   move      ccovra        chbff
000585081124     c                   move      ccovpc        chbpoc
000586081124     c                   move      ccpnc         chbpnc
000587081124     c                   move      cccmsp        chbcmsp
000588090416     c                   movel     free5         chbpri
000589081124
000590081124      * set transaction code
000591081124     C                   eval      chtrcod = 'LDC'
000592081124
000593081124      * add rec with before and after fields
000594081124     c                   write     comhstr
000595070806
000596070806     C                   endsr
000597051013
000598051013     c     *inzsr        begsr
000599051013
000600051013     c     acckey        klist
000601051013     c                   kfld                    cmtrst
000602051013     c                   kfld                    csubdv
000603051013     c                   kfld                    cmacct
000604051013
000605051013     c     mcovkey       klist
000606051013     c                   kfld                    cmtrst
000607051013     c                   kfld                    csubdv
000608051013     c                   kfld                    cmacct
000609051013     c                   kfld                    cmplan
000610051013
000611051013     c     gratkey       klist
000612051013     c                   kfld                    cmtrst
000613051013     c                   kfld                    csubdv
000614051013     c                   kfld                    cmplan
000615051013
000616051013     C                   MOVE      *DATE         @DATIN
000617051013     C                   EXSR      #DATym
000618051013     C                   MOVE      @DATOU        UD8YMD            8 0
000619070612
000620070612     c                   except    head
000621051013     c                   endsr
000622051013
0006230706120103 C***************************************************
0006240706120104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0006250706120105 C***************************************************
0006260706120107 C*
0006270706120107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0006280706120107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0006290706120107 C*
0006300510130106 C     #DATYM        BEGSR
000631051013     C                   MOVEL     @DATIN        @Y                4 0
000632051013     C                   MOVE      @DATIN        @MD               4 0
000633051013     C                   MOVE      @Y            @DATOU            8 0
000634051013     C                   MOVEL     @MD           @DATOU
000635051013     C                   MOVE      *ZEROS        @DATIN            8 0
0006360510130120 C                   ENDSR
000637000925     oqsysprt   e            head           1  2
0006380708070248 O                                           15 'PROGRAM : DB920'
0006390706120239 O                                           44 '*****'
0006400706120240 O                       CONAME              85
0006410706120241 O                                           91 '*****'
000642070612     O                                          123 'PAGE :'
000643070612     O                       page          z    132
000644070612     o          e            head           1
0006450706120253 O                                            9 'RUN DATE:'
0006460706120254 O                       UDATE         Y     18
0006470706120244 O                                           58 'CANCEL COMMISSION RECORDS '
0006480706120244 O                                           84 'W/O ACTIVE MEMBERS IN ACTI'
0006490706120244 O                                          110 'VE ACCOUNTS               '
0006500706120255 O                                          123 'TIME :'
0006510706120256 O                       TIME               132 '  :  :  '
000652070612     o          e            head           1
000653070612     O                                           26 '--------------------------'
000654070612     O                                           52 '--------------------------'
000655070612     O                                           78 '--------------------------'
000656070612     O                                          104 '--------------------------'
000657070612     O                                          130 '--------------------------'
000658070612     O                                          132 '--'
000659070612     o          e            head           1
000660070612     o                                            9 'ACCOUNT #'
000661070612     o                                           19 'PLAN'
000662070612     o                                           26 'SMAN'
000663070612     o                                           39 'EFFECTIVE'
000664070612     o                                           52 'CANCEL'
000665070612     o          e            head           2
000666070612     O                                           26 '--------------------------'
000667070612     O                                           52 '--------------------------'
000668070612     O                                           78 '--------------------------'
000669070612     O                                          104 '--------------------------'
000670070612     O                                          130 '--------------------------'
000671070612     O                                          132 '--'
000672000925     o          e            prt            1
000673070612     O                       cmtrst               3
000674070612     O                                            4 '-'
000700070612     O                       csubdv               7
000701070612     O                                            8 '-'
000800070612     O                       cmacct              12
000900070612     O                       cmplan              19
001000070612     O                       slsman              26
001200070612     O                       effdatmdy           39 '  /  /    '
001300070612     O                       cmcanmdy            52 '  /  /    '
001301051004     o          e            lrprt       1  1
001302051004     O                                              'Total:'
001303051004     O                       count         1     +2
