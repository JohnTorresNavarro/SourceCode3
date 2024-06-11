001510060308      * 03/08/06 dlk - create workfile to print broker labels for renewals
001511060220      *
001512051222
0017000603080005 Ftrkrnwlp  ip   e             disk
0017010603080005 Fmcov14    if   e           k disk
0018000312190005 Faccmst    if   e           k disk
0021000312190005 Fcmct14    if   e           k disk
002300031219     fspragxr2  if   e           k disk
002400031219     fsmanrlt   if   e           k disk
002500031219     fagency    if   e           k disk
002600060308     **fsupragcy  if   e           k disk
002700031222     fsman      if   e           k disk
002800060308     frpp120wk  o  a e             disk
002900060309     frpp120p   o    f  132        printer oflind(*inof)
002901060308     D UP              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
002902060308     D LO              C                   'abcdefghijklmnopqrstuvwxyz'
002903060308     D firste          s              1
004201060308     D                udS
0042020603080125 D  lruneff                1      8  0
0042030603080125 D  lrunmd                 1      4  0
0042040603080125 D  lrunyy                 5      8  0
004300031219
004301060308     itrkrnwlr
004302060308     i                                          trtrst        l2
004303060308     i                                          trsub#        l2
004304060308     i                                          tracct        l2
004305060308     i                                          trplan        l1
004400060308     c* verify active acct
004500031219     c                   if        *inl2
004600031219     c                   clear                   okacc             1
004700031219     c     acckey        chain     accmst
004800060308     c                   if        %found(accmst) and atrmdt = 0
005000031219     c                   eval      okacc = 'Y'
005100031219     c                   end
005200031219     c                   end
005300060308
005301060308     c* verify active mcov and comctx
005400011228     c                   if        *inl1
005401060308     c                   exsr      #l1sr
005402060308     c                   end
008100020123
008900031219
009000011228     c     #end          tag
009300031219
0094000312190069 C**************************************************************
009500060308JGE01C* process each change in plans
0096000312190069 C**************************************************************
009700060308JGE01C     #l1sr         BEGSR
009801060308
009802060308     c                   clear                   okmcov            1
009803060308     c                   clear                   okcom             1
009805060308
009806060308      * find first active mcov
009807060308     c     tsapkey       setll     mcov14
009808060308     c                   dou       %eof(mcov14)
009809060308     c     tsapkey       reade     mcov14
009810060308     c                   if        not %eof(mcov14) and candt = 0
009811060308     c                   eval      okmcov = 'Y'
009812060308     c                   leave
009813060308     c                   end
009814060308     c                   enddo
009815060308
009816060308      * find active commissions
009817060308     c                   if        okmcov = 'Y'
009818060309
009819060308     c     tsapkey       setll     cmct14
009820060308     c                   dou       %eof(cmct14)
009821060308     c     tsapkey       reade     cmct14
009822060308     c                   if        not %eof(cmct14) and cmcan = 0
009823060308     c                   eval      okcom = 'Y'
009824060308     c                   exsr      #writesr
009825060308     c                   end
009826060308     c                   enddo
009828060308
009829060308     c                   if        okcom <> 'Y'
009830060308     c                   if        firste <> ' '
009831060308     c                   except    head
009832060308     c                   eval      firste = 'N'
009833060308     c                   end
009834060308     c   of              except    head
009835060308     c                   except    errcom
009836060308     c                   end
009837060309
009838060309     c                   end
011705060220
012300031219JGE01C                   endsr
012301060308
012303060308      ************************************************************
012304060308      * get relation for this comctx and write to workfile
012305060308      ************************************************************
012306060308      *
012307060308     c     #writesr      begsr
012308060308
012309060308     c                   clear                   rpp120r
016607051222
0167000603080063 C     cmrelid       CHAIN     smanrlt
016800051222     c                   if        not %found(smanrlt)
016801060308     c                   if        firste <> ' '
016802060308     c                   except    head
016803060308     c                   eval      firste = 'N'
016804060308     c                   end
016805060308     c   of              except    head
016806051222     c                   except    errrel
016807051222     c                   leavesr
016808051222     c                   else
016809060308    * * the relation is not active for the run date
016810051222     c                   if        (sreffdte = srtrmdte) or
016811060308     c                             (sreffdte > runymd)  or (srtrmdte <> 0
016812060308     c                             and srtrmdte <= runymd)
016813060308     c                   if        firste <> ' '
016814060308     c                   except    head
016815060308     c                   eval      firste = 'N'
016816060308     c                   end
016817060308     c   of              except    head
016818051222     c                   except    errrel
016819060308     c                   leavesr
016820051222     c                   end
016821051222     c                   end
016900031222
017000060308    * * use sman info from relation to get sman name & address
017200031222     c     srsman        chain     sman
017300031222     c                   if        %found(sman)
017400060308     c                   eval      rppsmnam  = %trim(sfname)
017500031222     c                   if        smi <> ' '
017600060308     c                   cat       smi:1         rppsmnam
017700031222     c                   end
017800060308     c                   cat       slname:1      rppsmnam
017801060308
017802060308     c                   movel     saddr         rppsmadr
017803060308     c                   movel     scity         rppsmcsz
017804060308     c                   cat       sstate:1      rppsmcsz
017805060308     c                   movel     szipcd        wkzip5            5
017806060308     c                   move      szipcd        wkzip4            4
017807060308     c                   cat       wkzip5:1      rppsmcsz
017808060308     c                   if        wkzip4 <> *blanks and wkzip4 <> '0000'
017809060308     c                   cat       '-':0         rppsmcsz
017810060308     c                   cat       wkzip4:0      rppsmcsz
017811060308     c                   end
017812060308
017813060308      * missing sman
017814060308     c                   else
017815060308     c                   if        firste <> ' '
017816060308     c                   except    head
017817060308     c                   eval      firste = 'N'
017818060308     c                   end
017819060308     c   of              except    head
017820060308     c                   except    errsman
017821060309     c                   leavesr
017900031222     c                   endif
018000031222    *
018100031219      * get SA xref
018200031219     c     srasid        chain     spragxr2
018300031219     c                   if        %found(spragxr2)
018600031219      * get super agency name
018700060308     c**   sxsuper       chain     supragcy
018800060308     c**                 if        %found(supragcy)
018900060308     c**                 eval      holdsaname = %trim(saname1)
019000060308     c**                 end
019100031219      * get agency name
019200031219     c     sxagcy        chain     agency
019300031219     c                   if        %found(agency)
019301060308     C     LO:UP         XLATE     AGNAM1        rppagnam
019500031219     c                   end
019700031219     c                   end
019900031219
019901060308     c                   write     rpp120r
019902060308
019903060308JGE01C                   endsr
020300011228
020305060308
020400011228     c     *inzsr        begsr
021400020123     c     acckey        klist
021500060308     c                   kfld                    trtrst
021600060308     c                   kfld                    trsub#
021700060308     c                   kfld                    tracct
021701060308     c     tsapkey       klist
021702060308     c                   kfld                    trtrst
021703060308     c                   kfld                    trsub#
021704060308     c                   kfld                    tracct
021705060308     c                   kfld                    trplan
021706060309
021707060308     c                   movel     lrunyy        runymd            8 0
021708060308     c                   move      lrunmd        runymd
0225000112280382 C                   ENDSR
022600060309     orpp120p   e            head           2  2
022800060309     O                                           72 'MISSING INFO - RPP120'
022801060309     O                                           87 ' RENEWAL LABELS'
022802060308     o          e            head           2
022803060308     O                                           12 'SSN'
022804060308     O                                           20 'TRUST'
022805060308     O                                           24 'SUB'
022806060308     O                                           29 'ACC'
022807060308     O                                           34 'PLAN'
022808060308     O                                           44 'REL.ID'
023401050201     o          e            errcom         1
023402050201     O                       mcssno              12 '0   -  -    '
023403060308     O                       mctrst              20
023404060308     O                       mcsub#              24
023405060308     O                       acc#                29
023406060308     O                       mcplan              34
023407060309     O                                          100 'MISSION COMMISSION        '
023408051222     o          e            errrel         1
023409051222     O                       mcssno              12 '0   -  -    '
023410051222     O                       mctrst              20
023411051222     O                       mcsub#              24
023412051222     O                       acc#                29
023413051222     O                       mcplan              34
023414060308     O                       cmrelid             44
023415051222     O                       sreffdte            +2
023416051222     O                       srtrmdte            +2
023417060309     O                                          100 'NON-ACTIVE RELATION       '
023418060308     o          e            errsman        1
023419060308     O                       mcssno              12 '0   -  -    '
023420060308     O                       mctrst              20
023421060308     O                       mcsub#              24
023422060308     O                       acc#                29
023423060308     O                       mcplan              34
023424060308     O                       cmrelid             44
023425060308     O                       srsman              +2
023427060309     O                                          100 'SMAN NOT FOUND            '
024800020123     o          e            erracc         1
024900020123     O                       mcssno              12 '0   -  -    '
025000020123     O                       mctrst              20
025100020123     O                       mcsub#              24
025101060308     O                       acc#                29
025200060308     O                       mcplan              34
025400060309     O                                          100 'MISSION ACCOUNT           '
