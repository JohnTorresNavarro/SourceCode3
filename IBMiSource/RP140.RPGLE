000300000000      ****************************************************************
000500000414      *  RP140     GROUP BENEFIT SERVICES SOFTWARE           1988    *
000600000000      *                                                              *
000700000000      *            WRITTEN BY - MICHAEL C. DUNPHY                    *
000800000000      *            DATE - 01/20/89                                   *
000900000000      *                                                              *
001000060725      *  DESCRIPTION - Salary census                                 *
001700000000      *                                                              *
001701001019      *    KSJ 10/2000 - Modified to add Birthdate                   *
001702001019      *                  Converted from QS36SRC                      *
001703060725      * 09/28/05 DLK - add mask ssn option
001704060809      * 07/25/06 DLK - add coverage info and letter using RPG-WORD
001705060809      *                technique                                     *
001706060809      *                                                              *
001800000000      ****************************************************************
002001060725     Fmember    ip   e           k DISK
002301060725     Faccmst    if   e           K DISK
002302060725     Fmcov      if   e           K DISK
002303060726     Fplnmst    if   e           k disk
002304060725     Fgrate     if   e           K DISK
002305060725     Fcodesl1   if   e           K DISK
002306060803     Fsman      if   e           K DISK
002307060807     Fnumtrkp   uf   e             DISK
002308060807     Frp140in   if   e             DISK
002309060807     Frp140out  o  a e             DISK
002310001019     FRP140P    O    E             PRINTER OFLIND(*IN80)
002700001019
0027010608030037 D YR              S              9    DIM(12) CTDATA PERRCD(1)
002702001019     D                 DS
002703001019     D  BIRTH                  1      8  0
002704001019     D  BYR                    1      4  0
002705001019     D  BMO                    5      6  0
002706060803     D                 DS
002707060803     D  memtsa                 1     10  0
002708060803     D  mbtrst                 1      3  0
002709060803     D  mbsub#                 4      6  0
002710060803     D  mbacct                 7     10  0
002711060803
002712001019
0027130607260037 D workdt          S               d   datfmt(*iso)
003001060726     D firstcov        S              1
003002060726     D lifeplan        S              1
003003060726     D leffymd         S              8  0
003004060726     D ratedate        S              8  0
003005060725     D @DATIN          S              8  0
003006001019     D @DATOU          S              8  0
003007001019     D @MD             S              4  0
003008001019     D @Y              S              4  0
003011001019     D ZIP4            S              4
003012001019     D ZIP5            S              5
0030130509280037 D ssnoout         S             12
0030140608030037 D linecnt         S              3  0
003015060807     D Line            S            500A   inz
003016060807     D var             S              2A
003017060807     D POS             S              3S 0 INZ
003018060807     D VARFLD          S            500    VARYING
003019001019
0030200509280156 D                UDS
003021050928     D  lmask                 11     11
003022060726     D  leffdt                12     19  0
003023060803     D  leffm                 12     13  0
003024060803     D  leffy                 16     19
003025060726     D  lheaddt               20     27  0
003026060803     D  lheadmm               20     21  0
003027060803     D  lheaddd               22     23
003028060803     D  lheadyy               24     27
003029060726     D  lretdt                28     35  0
003030060726     D  coname               201    240
004900001019
004901060725      * get acct info once
004902060725     c                   if        firstrec <> 'N'
004903060725     C     ACKEY         CHAIN     ACCMST
004904060725     C                   EXSR      #ADDR
004905060725     c                   move      'N'           firstrec          1
004906060725     c                   end
004907060725
004908060725     c                   eval      firstcov = 'Y'
004909060803     c                   eval      linecnt  = 0
004910060725
004911060725     c     mbssno        setll     mcov
004912060725     c                   dou       %eof(mcov)
004913060725     c     mbssno        reade     mcov
004914060725     c                   if        not %eof(mcov) and (candt = 0
004915060725     c                             or (candt <> 0 and candt > leffymd))
004916060726     c                             and (enrldt <= leffymd)
004917060725     c                   exsr      #getlife
004918060725
004919060725     c                   if        lifeplan = 'Y'
0049200607260086 C                   move      leffymd       ratedate
004921060726     c                   exsr      #getrat
004922060726
004923060726      * if no rate found, try again for the previous month
004924060726     c                   if        group#out = *blanks
004925060726     C                   move      leffymd       workdt
004926060726     C                   subdur    1:*m          workdt
004927060726     C                   move      workdt        ratedate
004928060726     c                   exsr      #getrat
004929060726     c                   end
004930060726
004931060726     c                   exsr      #prtline
004932060725     c                   end
004933060725
004934060725     c                   end
004935060725     c                   enddo
004936060803
004937060803      * if only 1 line of coverage was printed, print another line now
004938060803      * with only the line for the effective date
004939060803     c                   if        linecnt = 1
004940060803     C                   CLEAR                   DTL
004941060803     c                   move      *all'_'       upsal
004942060803     C                   WRITE     DTL
004943060803     C                   CLEAR                   DTL
004944060803     c                   end
004945060725
006641060726     Clr                 WRITE     TOT
006642060803     Clr                 exsr      #letter
006648060725
006649060725      ****************************************
006650060726      * get life, LTD, STD plan info
006651060725      ****************************************
006652060725     c     #getlife      begsr
006653060725
006654060725     c                   clear                   lifeplan
006655060725     c     plnkey        chain     plnmst
006656060725     c                   if        %found(plnmst)
006657060725     c     plncat        chain     codesl1
006658060726     c                   if        %found(codesl1) and (action = 'L' or
006659060726     c                             action = 'T' or action = 'S')
006660060725     c                   eval      lifeplan = 'Y'
006661060725     c                   end
006662060725     c                   end
006663060725
006664060725     c                   endsr
006666060725
006667060725      ****************************************
006668060725      * print detail line
006669060725      ****************************************
006670060725     c     #prtline      begsr
006671060725
006672060725     c                   if        firstcov = 'Y'
006673060726     C                   EVAL      CNT = CNT + 1
006674060726     c                   move      *all'_'       upsal
006675060726     c                   move      *all'_'       jobtitle
006676060725     C                   EXSR      #NAME
006677060726
006679060725     C                   EVAL      @DATIN = BIRTH
006680060725     C                   EXSR      #DATYM
006681060725     C                   EVAL      BMDY = @DATOU
006682060726
006687060725     C                   EVAL      SLRY = SALARY
006688060725     c                   eval      ssnoout = (%editw(mbssno:'0   -  -    '))
0066890607250261 C                   if        lmask = 'Y'
0066900607250261 C                   movel     ' XXX-XX'     ssnoout
0066910607250261 C                   end
006692060725     c                   clear                   firstcov
006693060725     c                   end
006694060725
006695060726     C                   EVAL      @DATIN = enrldt
006696060726     C                   EXSR      #DATYM
006697060726     C                   EVAL      enrmdy = @DATOU
006698060726
006699060725     c                   if        *in80
006700060725     C                   WRITE     HDR
006701060725     C                   EVAL      *IN80 = *OFF
006702060725     C                   ENDIF
006703060803
006704060803      * count # of lines printed
006705060803     C                   add       1             linecnt
006706060803
006707060803      * print underline for handwritten effdt
006708060803     c                   if        linecnt = 2
006709060803     c                   move      *all'_'       upsal
006712060803     c                   end
006713060803
006715060725     C                   WRITE     DTL
006716060726     C                   CLEAR                   DTL
006717060725
006718060725     c                   endsr
006719060725
009514001019
009700001019      ****************************************************************
009800001019      *    AL = CITY, ST  ZIP
009900001019      *----------------- COMPRESS CITY/STATE/ZIP ------------------*
010000001019
010100000000     C     #ADDR         BEGSR
010200001019
010500060725     C                   clear                   AL               31
010700060725     C                   MOVEl     ACITY         AL
010701060725     c                   cat       ',':1         al
010702060725     c                   cat       astate:1      al
012100001019
012101060726     C                   MOVEL     azip          ZIP5
012102060726     C                   MOVE      azip          ZIP4
012103060725     C                   CAT       ZIP5:1        AL
012104060725     C     ZIP4          IFNE      '0000'
012105060725     C                   CAT       '-':0         AL
012106060725     C                   CAT       ZIP4:0        AL
012107060725     C                   END
013202001019
013300000000     C                   ENDSR
013301060725
014600001019      ****************************************************************
014700060725      *   FIELD= LAST, FI.
014800001019      *------------------- COMPRESS NAME FIELDS ---------------------*
014900001019
015000000000     C     #NAME         BEGSR
015100001019
015101060725     c                   movel     mfname        mfini             1
015102060725     C     MLNAME        CAT(P)    ',':0         name
015103060725     C                   CAT(P)    MFini:1       NAME
015106060725     C                   CAT(P)    '.':0         NAME
015705001019
019200000000     C                   ENDSR
019201060725
019900001019
019901060725      **********************************
019902060725      * mdy - ymd or ymd - mdy
019904060725      **********************************
020000001019     C     #DATYM        BEGSR
020100001019     C                   MOVE      @DATIN        @MD
020200001019     C                   MOVEL     @DATIN        @Y
020300001019     C                   MOVEL     @MD           @DATOU
020400001019     C                   MOVE      @Y            @DATOU
020500060725     C                   clear                   @DATIN
020600001019     C                   ENDSR
020601060725
020602060726      **********************************
020603060726      * get grate for group #
020604060726      **********************************
020605060726     C     #getrat       BEGSR
0206070607260086 C                   clear                   group#out
020609060726
0206100607260076 C     RATKEY        SETLL     GRATE
020611060726     c                   dou       %eof(grate)
0206120607260080 C     ratkey        reade     GRATE
020613060726     C                   if        (not %eof(grate)) and (ratedate >= frmdat)
020614060726     C                             and (ratedate <= todat)
020615060726     c                   movel     group#        group#out
0206160607260087 C                   leave
0206170607260089 C                   END
0206180607260091 C                   ENDDO
020619060803
0206200608030091 C                   endsr
020621060726
020622060803      **********************************
020623060803      * print letter
020624060803      **********************************
020625060803     C     #letter       BEGSR
0206260608030323 C* FIRST DATE LINE - heading date from screen
0206270608030329 C                   clear                   DL               19
0206300608030332 C                   MOVEL     YR(lheadmm)   DL
020632060803     C                   CAT       lheaddd:1     DL
020633060803     C                   CAT       ',':0         DL
020634060803     C                   CAT       lheadyy:1     DL
020635060803     C*
020636060803     c                   clear                   snameout         32
020638060803     c                   clear                   saddr1out        30
020639060803     c                   clear                   saddr2out        31
020640060803     c     smancd        chain     sman
020641060803     c                   if        %found(sman)
020642060803     c     sfname        cat       slname:1      snameout
020645060803     c                   movel     saddr         saddr1out
020646060803     c                   movel     scity         saddr2out
020647060803     C                   CAT       ',':0         saddr2out
020648060803     C                   CAT       sstate:1      saddr2out
020649060803     C                   MOVEL     szipcd        ZIP5              5
020650060803     C                   MOVE      szipcd        ZIP4              4
020651060803     C                   CAT       ZIP5:1        saddr2out
020652060803     C     ZIP4          IFNE      '0000'
020653060803     C                   CAT       '-':0         saddr2out
020654060803     C                   CAT       ZIP4:0        saddr2out
020655060803     C                   END
020656060803     c                   end
020657060726
020658060803      * build acc name output field with acc#
020661060803     c                   clear                   acnamout         55
020662060803     C                   clear                   acnumtxt         12
020663060803     c                   movel     acnam1        acnamout
020664060803     c                   eval      acnumtxt = %editw(memtsa: '   -   -    ')
020665060803     c                   cat       acnumtxt:1    acnamout
020666060803
020667060803      * build month/year output
020668060803
020669060803     c                   clear                   renmyout         16
020670060803     c                   movel     yr(leffm)     renmyout
020671060803     c                   cat       ',':0         renmyout
020672060803     c                   cat       leffy:1       renmyout
020673060803
020674060809      * create html letter
020675060807     c                   exsr      #dohtml
020678060803
020679060726     C                   ENDSR
020680060725
020681060807      *****************************************************************
020682060807      * Read html input file, replace variables with text and write
020683060807      * html output file
020684060807      *****************************************************************
020700060807     C     #dohtml       BEGSR
020701060807
020703060807      * Read in Template, write out new file with text instead of variables
020705060807
020706060808     C     0             chain     rp140in
020707060807     C                   Dou       %eof(rp140in)
020708060807     C                   Read      rp140in
020709060807     C                   if        not %eof(rp140in)
020711060807     C                   Eval      Line = rp140ifld
020713060807      * Print Date (@A)
020714060807     C                   Eval      var  = '@A'
020715060807     C                   Eval      pos = %scan(var:Line)
020716060807     C                   If        pos > 0
020717060807     C*                  Exsr      CheckLen
020718060807     C                   Eval      %len(VARFLD) = %len(%trim(dl))
020719060807     C                   Eval      VARFLD = %trim(dl)
020720060807     C                   Eval      Line = %replace(VARFLD:Line:pos:2)
020721060807     C                   End
020722060807
020723060808      * sman name (@B & @H)
020724060807     C                   Eval      var  = '@B'
020725060807     C                   Eval      pos = %scan(var:Line)
020726060807     C                   If        pos > 0
020727060807     C*                  Exsr      CheckLen
020728060807     C                   Eval      %len(VARFLD) = %len(%trim(snameout))
020729060807     C                   Eval      VARFLD = %trim(snameout)
020730060807     C                   Eval      Line = %replace(VARFLD:Line:pos:2)
020731060807     C                   End
020732060808
020733060808     C                   Eval      var  = '@H'
020734060808     C                   Eval      pos = %scan(var:Line)
020735060808     C                   If        pos > 0
020736060808     C*                  Exsr      CheckLen
020737060808     C                   Eval      %len(VARFLD) = %len(%trim(snameout))
020738060808     C                   Eval      VARFLD = %trim(snameout)
020739060808     C                   Eval      Line = %replace(VARFLD:Line:pos:2)
020740060808     C                   End
020741060807
020742060807      * sman addr (@C)
020743060807     C                   Eval      var  = '@C'
020744060807     C                   Eval      pos = %scan(var:Line)
020745060807     C                   If        pos > 0
020746060807     C*                  Exsr      CheckLen
020747060807     C                   Eval      %len(VARFLD) = %len(%trim(saddr1out))
020748060807     C                   Eval      VARFLD = %trim(saddr1out)
020749060807     C                   Eval      Line = %replace(VARFLD:Line:pos:2)
020750060807     C                   End
020751060807
020752060807      * sman csz  (@D)
020753060807     C                   Eval      var  = '@D'
020754060807     C                   Eval      pos = %scan(var:Line)
020755060807     C                   If        pos > 0
020756060807     C*                  Exsr      CheckLen
020757060807     C                   Eval      %len(VARFLD) = %len(%trim(saddr2out))
020758060807     C                   Eval      VARFLD = %trim(saddr2out)
020759060807     C                   Eval      Line = %replace(VARFLD:Line:pos:2)
020760060807     C                   End
020761060807
020762060807      * acct name (@E)
020763060807     C                   Eval      var  = '@E'
020764060807     C                   Eval      pos = %scan(var:Line)
020765060807     C                   If        pos > 0
020766060807     C*                  Exsr      CheckLen
020767060807     C                   Eval      %len(VARFLD) = %len(%trim(acnamout))
020768060807     C                   Eval      VARFLD = %trim(acnamout)
020769060807     C                   Eval      Line = %replace(VARFLD:Line:pos:2)
020770060807     C                   End
020771060807
020772060809      * renew m,y (@F)
020773060807     C                   Eval      var  = '@F'
020774060807     C                   Eval      pos = %scan(var:Line)
020775060807     C                   If        pos > 0
020776060807     C*                  Exsr      CheckLen
020777060807     C                   Eval      %len(VARFLD) = %len(%trim(renmyout))
020778060807     C                   Eval      VARFLD = %trim(renmyout)
020779060807     C                   Eval      Line = %replace(VARFLD:Line:pos:2)
020780060807     C                   End
020782060808
020783060808      * return date (@I)
020784060808     C                   Eval      var  = '@I'
020785060808     C                   Eval      pos = %scan(var:Line)
020786060808     C                   If        pos > 0
020787060808     C*                  Exsr      CheckLen
020788060808     C                   Eval      %len(VARFLD) = %len(
020790060808     C                             %editw(lretdt:'0  /  /    '))
020791060808     C                   Eval      VARFLD =
020792060808     C                             (%editw(lretdt:'0  /  /    '))
020793060808     C                   Eval      Line = %replace(VARFLD:Line:pos:2)
020794060808     C                   End
020795060808
020796060807     C                   Clear                   rp140ofld
020797060807     C                   Eval      rp140ofld = Line
020798060807     C                   Write     rp140orec
020799060807
020800060807     c                   end
020801060807     c                   enddo
020802060807
020803060807     c
020804060807      * get unique spool number
020805060807     c     1             chain     NUMTRKP
020806060807     c                   If        %Found(numtrkp)
020807060807     c                   eval      docnbr = docnbr + 1
020808060807     c                   Update    NUMTRKR
020809060807     c                   movel     docnbr        splnbr
020810060807     c                   end
020811060807
020812060807     C                   ENDSR
020813060807
020814060807      *------------------------------------------------------------------*
020815060807      * Check Length of Line
020816060807      *------------------------------------------------------------------*
020817060807      * (207) if any data element is larger than 50 you must change this #.
020818060809      * since the html in & out files are 257
020819060809      *  ** I am not using this routine beacuse I created the html files
020820060809      *     as 500 bytes **
020821060807     C*    CheckLen      Begsr
020822060807     C*                  If        Line <> *Blanks
020823060807     C*                  Eval      %len(VARFLD) = %len(%trim(Line))
020824060807     C*                  If        %len(VARFLD) > 207
020825060807     C*                  Clear                   rp140ofld
020826060807     C*                  Eval      rp140ofld = %subst(Line:1:pos-1)
020827060807     C*                  Write     rp140orec
020828060807     C*                  Eval      Line = %subst(Line:pos-1)
020829060807     C*                  Eval      pos = %scan(var:Line)
020830060807     C*                  End
020831060807     C*                  End
020832060807     C*                  Endsr
020833060807
020834060807
020835060807     C     *INZSR        BEGSR
020836060807     C     *Entry        Plist
020837060807     C                   Parm                    splnbr            5
020838060725
020900060725     C                   EVAL      *IN80 = *ON
021000060725     C     ACKEY         KLIST
021100060725     C                   KFLD                    MBTRST
021200060725     C                   KFLD                    MBSUB#
021300060725     C                   KFLD                    MBACCT
021301060726     c     ratkey        klist
021302060726     c                   kfld                    mctrst
021303060726     c                   kfld                    mcsub#
021304060726     c                   kfld                    mcplan
021305060726     c                   kfld                    mcageb
021306060726     c                   kfld                    mcovtp
021307060726     c     plnkey        klist
021308060726     c                   kfld                    mctrst
021309060726     c                   kfld                    mcsub#
021310060726     c                   kfld                    mcplan
021311060725
021312060725     C                   EVAL      @DATIN = leffdt
021313060725     C                   EXSR      #DATYM
021314060725     C                   EVAL      leffymd = @DATOU
021400060725
021500060725     C                   ENDSR
021600060803**
021700060803January
021800060803February
021900060803March
022000060803April
022100060803May
022200060803June
022300060803July
022400060803August
022500060803September
022600060803October
022700060803November
022800060803December
