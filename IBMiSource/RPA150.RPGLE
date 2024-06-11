000100030821     h option(*nodebugio)
000200000000  02  ******************************************************************
000300081205  03  *  rpa150    GROUP BENEFIT SERVICES SOFTWARE                     *
000400000000  04  *                                                                *
000500000000  05  *            WRITTEN BY - DAVID KETTERMAN                        *
000600081205  06  *            DATE - 12/05/08                                     *
000700000000  07  *                                                                *
000800081205  08  *  DESCRIPTION - comhst file maintenance -  allow finance to     *
000900081205  09  *                enter a status code and resolution code.        *
001100000000  07  *                                                                *
001101091012  07  * 10/12/09 dlk - add resolve user                                *
001102091103  07  * 11/03/09 dlk - add program id                                  *
001400030909  07  *                                                                *
001500000000  13  ******************************************************************
001600000000  13 F***
001700081205     Frpa150d   CF   E             WORKSTN
001800030814     F                                     SFILE(S02SFL:rr2)
001801081209     F                                     SFILE(SF04:RR4)
001900081208     Fcomhst    if   e           k disk    infds(comhinfds)
001901081208     Fcomhstl1  uf   e             disk    rename(comhstr:comhstrl1)
001902081210     Fcomhstl2  uf   e           k disk    rename(comhstr:comhstrl2)
001903081205     Faccmst    if   e           k disk
001904081209     Fcodesl1   if   e           k disk    rename(codesr:codesrl1)
001905081209     Fcodes     if   e           k disk
0019060812110015 Fgbsecure  IF   E           K DISK
001907081205     d workdtmdy       s               d   datfmt(*usa)
001908081205     d workdtymd       s               d   datfmt(*iso)
001909081211     d s1trdtfrymd     s               d   datfmt(*iso)
001910081211     d s1trdttoymd     s               d   datfmt(*iso)
001911081210     d s5frdtymd       s               d   datfmt(*iso)
001912081210     d s5todtymd       s               d   datfmt(*iso)
001913081205     D comhinfds     E DS                  EXTNAME(IODBFD)
001914081208     d comkeyt         s                   like(chtrust)
001915081208     d comkeys         s                   like(chsub)
001916081208     d comkeya         s                   like(chacc)
001917081209     dx                s              1    inz('X')
002000030818  00 D                 DS
002100030818  01 D  search                 1     10  0
002200081208  01 D  searcht                1      3  0
002300081208  01 D  searchs                4      6  0
002400081208  01 D  searcha                7     10  0
002416081208  00 D                 DS
002417081208  01 D  s1tsa                  1     10  0 inz
002418081208  01 D  s1t                    1      3  0
002419081208  01 D  s1s                    4      6  0
002420081208  01 D  s1a                    7     10  0
002421081208  00 D                 DS
002422081208  01 D  s2tsa                  1     10  0
002423081208  01 D  s2t                    1      3  0
002424081208  01 D  s2s                    4      6  0
002425081208  01 D  s2a                    7     10  0
002426081208  00 D                 DS
002427081209  01 D  s3tsa                  1     10  0
002428081209  01 D  s3t                    1      3  0
002429081209  01 D  s3s                    4      6  0
002430081209  01 D  s3a                    7     10  0
004500030814  00 D                UDS
004600091012  01 D  luser                  1     10
004601091012  01 D  CONAME               201    240
004700030814
004800081205      ****************************
004900081205     C* screen 1                 *
005000081205     C* date and status select   *
005100081205      ****************************
005101081208     c                   eval      statnew = 'Y'
005102081208     c                   eval      statopen = 'Y'
005103081208
005200030821     c                   dou       *in07
005303081208
005400030814     C                   exfmt     S01
005500030820     c                   clear                   *in20
005600030930     c                   clear                   *in21
005601081205     c                   clear                   *in22
005700030814     C* F7
005800030821     c                   if        *in07
005900030820     c                   leave
006000030814     c                   end
006100030814
006101081211
006102081211      * F23 - update all selection
006103081211     c                   if        *in23
006104081211     c                   exsr      #f23
006105081211     C                   iter
006106081211     c                   end
006107081208      * acct or trdate must be selected
006108081211     c                   if        s1tsa = 0 and s1trdtfr = 0 and
006109081211     c                             s1trdtto = 0
006110081208     c                   eval      *in20 = *on
006111081208     c                   eval      *in21 = *on
006112081208     c                   iter
006113081208     c                   end
006114081208
006115081211      * edit transaction dates
006116081211     c                   if        (s1trdtfr <> 0 and s1trdtto = 0) or
006117081211     c                             (s1trdtfr =  0 and s1trdtto <> 0)
006118081211     c                   eval      *in20 = *on
006119081211     c                   iter
006120081211     C                   end
006121081211
006122081211     c                   if        s1trdtfr <> 0
006123081211     C     *USA          test (de)               s1trdtfr
006124081205     C                   if        %ERROR
006125081205     c                   eval      *in20 = *on
006126081205     c                   iter
006127081205     C                   end
006128081208     C                   end
006129081211
006130081211     c                   if        s1trdtto <> 0
006131081211     C     *USA          test (de)               s1trdtto
006132081211     C                   if        %ERROR
006133081211     c                   eval      *in20 = *on
006134081211     c                   iter
006135081211     C                   end
006136081211     C                   end
006700030814
006701081205      * edit account
006702081208     c                   if        s1tsa <> 0
006703081205     C     acckey        CHAIN     accmst
006704081205     c                   if        not %found(accmst)
006705081205     c                   eval      *in21 = *on
006706081205     c                   iter
006707081205     C                   end
006708081208     C                   end
006709081205
006710081205      * edit status
006800081205     c                   if        statnew = ' ' and statclosed = ' ' and
006801081205     c                             statopen = ' '
006900081205     c                   eval      *in22 = *on
007000030930     c                   iter
007100030930     c                   end
007200030930
007301081208     C                   move      s1t           searcht
007302081208     C                   move      s1s           searchs
007303081208     C                   move      s1a           searcha
007400030930
007500030820     c                   exsr      #screen2
007600030820
007700030820     c                   enddo
007800030820
007900030820     c                   eval      *inlr = *on
008000030820
008100030820      ***********************
008200030820      * screen 2            *
008300030820      ***********************
008400030820     c     #screen2      begsr
008604081205
009100030820     C* clear and build subfile
009200030820     c                   exsr      #clrsfl
009202081205
009203081211     c                   clear                   s1trdtfrymd
009204081211     c                   if        s1trdtfr <> 0
009205081211     c                   move      s1trdtfr      workdtmdy
009206081211     c                   move      workdtmdy     s1trdtfrymd
009207081208     c                   end
009208081208
009209081211     c                   clear                   s1trdttoymd
009210081211     c                   if        s1trdtto <> 0
009211081211     c                   move      s1trdtto      workdtmdy
009212081211     c                   move      workdtmdy     s1trdttoymd
009213081211     c                   end
009214081211
009215081208     c                   move      s1t           comkeyt
009216081208     c                   move      s1s           comkeys
009217081208     c                   move      s1a           comkeya
009218081208
009219081208     C     comkey        SETLL     comhst
009220081205
009400030820     c                   exsr      #bldsfl
009500030820
009600030821     c                   dou       *in01 or *in07
009700030814
009800000000     C* DISPLAY SUBFILE
009900000000     C*
010000000000     C* *IN63 IS ON WHEN LAST PAGE IS DISPLAYED AND ROLLUP
010100000000     C* KEY IS PRESSED AGAIN... IF ANY MORE RECORDS WERE ADDED
010200000000     C* TO SUBFILE THEN DISPLAY NEXT PAGE,  ELSE IF THE LAST RECORD
010300000000     C* TO DISPLAY WAS EXACTLY THE LAST ONE ON THE LAST PAGE, THEN
010400000000     C* DISPLAY THE LAST PAGE
010500000000     C*
010600030821     C                   if        *in63
010700030821     C                   if        count > 0
010800081208     C                   ADD       85            SFREC#
010900000000     C                   ELSE
011000081208     C                   ADD       84            SFREC#
011100000000     C                   END
011200030821     C                   eval      *in63 = *off
011300000000     C                   END
011404081209
011500030821     C                   eval      *IN61 = *on
011600030821     C                   if        rr2 > 0
011700030821     C                   eval      *IN60 = *on
011800000000     C                   END
011801081209
011900030821
012000030814     C                   WRITE     S02CMDKY
012100030814     C                   EXFMT     S02CTL
012200030820      * f1 or f7
012300030821     c                   if        *in01 or *in07
012400030820     c                   leavesr
012500030820     c                   end
012600000000     C*
012700081209     C* IF ENTER PRESSED BUT NO RECORDS IN SUBFILE (beacuse the position
012701081209     C* to value put it beyond the end of the subfile) RE-load SCREEN with
012800081209     C* original search values from first screen
012900081209     C                   if        *in60 = *off and search = 0
012901081209     c                   move      s1t           comkeyt
012902081209     c                   move      s1s           comkeys
012903081209     c                   move      s1a           comkeya
012904081209     C     comkey        SETLL     comhst
012905081209     c                   exsr      #clrsfl
012906081209     c                   exsr      #bldsfl
013000030821     C                   iter
013100030821     C                   END
013200000000     C*
013300000000     C* *IN63 IS ON WHEN LAST PAGE IS DISPLAYED AND ROLLUP
013400081209     C* KEY IS PRESSED AGAIN... LOAD NEXT 85 RECORDS IN SUBFILE
013500000000     C*
013600030821     C                   if        *in63
013700030821     C                   clear                   COUNT
013800030821     c                   exsr      #bldsfl
013900030821     C                   iter
014000000000     C                   END
014100030821
014200030819      * READ SUBFILE FOR Acct SELECTED
014300030819
014400081205     c                   dou       %eof(rpa150d)
014500030819     C                   readc     s02sfl
014600081211     c                   if        not %eof(rpa150d) and s2select <> *blank
014601081211     C* display selected rec
014604081211     C                   exsr      #screen3
014605081211     c                   eval      *in01 = *off
014800030821     C                   end
014900030819     C                   enddo
015000030819
015700030820
015800030821      * position to
015900030821     c*                  if        search <> *zeros
016000030821     c                   exsr      #clrsfl
016001081208     c                   move      searcht       comkeyt
016002081208     c                   move      searchs       comkeys
016003081208     c                   move      searcha       comkeya
016100081205     C     comkey        SETLL     comhst
016200030821     C                   clear                   COUNT
016300030821     c                   exsr      #bldsfl
016400030821     C*                  clear                   search
016500030821     C*                  END
016600030821
016700030820     C* ENTER PRESSED with no selection... REDISPLAY AND TRY AGAIN
016800030820     c                   enddo
016900030820
017000030820     c                   endsr
017100030820
017200030820      *****************************
017300030820     C* screen 3 -                *
017400081205     C* DISPLAY comhst    INFO    *
017500030820      *****************************
017600030820     c     #screen3      begsr
017700030818
017701081208     c                   setoff                                       3031
017702081208
017800081208     C     s2rec#        CHAIN     comhstl1
017900030818
018000081208     C                   if        %found(comhstl1)
018100030818     C* move fields to output for screen 3
018200030818
018502081209     C                   MOVE      chtrust       s3t
018503081209     C                   MOVE      chsub         s3s
018504081209     C                   MOVE      chacc         s3a
018505081208     C                   MOVEL     chplan        planout
018506081208
018507081208     c                   clear                   acnamout
018508081208     C     s3tsakey      CHAIN     accmst
018509081208     c                   if        %found(accmst)
018510081208     c                   movel     acnam1        acnamout
018512081208     C                   end
018513081208
018514081208     c                   clear                   trdesout
018515081208     c                   if        chtrcod <> *blanks
018516081208     c     chtrcod       chain     codesl1
018517081208     c                   if        %found(codesl1)
018518081208     c                   movel     ldescr        trdesout
018519081208     c                   end
018520081208     c                   end
018521081208
018523081211     c                   move      chtrdat       workdtmdy
018524081211     c                   move      workdtmdy     trdatout
018525081208     C                   MOVE      chtrtim       trtimout
018526091103     C                   MOVE      chpgm         pgmout
018527091012
018528091012      * user
018529081211     c                   clear                   userout
018530081211     c     chuser        chain     gbsecure
018531081211     c                   if        %found(gbsecure)
018532081211     c                   movel     scname        userout
018533081211     c                   end
018534081208
018535081208      * effdt
018536081208     C                   MOVE      chbeff        @DATIN
018537081208     c                   EXSR      #DATYM
018538081208     C                   MOVE      @DATOU        chbeffmdy
018539081208     C                   MOVE      chaeff        @DATIN
018540081208     c                   EXSR      #DATYM
018541081208     C                   MOVE      @DATOU        chaeffmdy
018542081208
018543081208      * cancel date
018544081208     C                   MOVE      chbcan        @DATIN
018545081208     c                   EXSR      #DATYM
018546081208     C                   MOVE      @DATOU        chbcanmdy
018547081208     C                   MOVE      chacan        @DATIN
018548081208     c                   EXSR      #DATYM
018549081208     C                   MOVE      @DATOU        chacanmdy
018550081208     c
018551081208     C                   MOVE      chstat        stat
018552081208     C                   MOVE      chrscod       rescod2
018553081208     c                   clear                   resdes
018554081208     c                   if        chrscod <> *blanks
018555081208     c     chrscod       chain     codesl1
018556081208     c                   if        %found(codesl1)
018557081208     c                   movel     ldescr        resdes
018558081208     c                   end
018559081208     c                   end
018560081208
018561091012      * resolve user
018562091012     c                   clear                   resusr
018563091012     c     chrsusr       chain     gbsecure
018564091012     c                   if        %found(gbsecure)
018565091012     c                   movel     scname        resusr
018566091012     c                   end
018567091012
018568081208     C                   clear                   noteout
018569081208     C                   MOVEl     chrsnot       noteout
018700030818
018701081208      * process screen 3
018800030821     c                   dou       *in01
019000030814     C                   EXFMT     S03
019100030818     c                   eval      *in30 = *off
019200030821      * F1
019300030821     c                   if        *in01
019301081210     c                   unlock    comhstl1
019400030821     c                   leavesr
019500030821     c                   end
019600030818
0196020812090077 C* f8 DISPLAY SUBFILE OF resolve codes
0196030812090078
0196040812090079 C                   if        *in08
0196050812090080 C                   EXSR      #DSPcd
019606081209     c                   eval      *in08 = *off
019607081209     c                   iter
019608081209     C                   END
0196090812090076
019610081208      * validate status
019700081208     c                   if        stat <> ' ' and stat <> 'C' and
019701081208     c                             stat <> 'O'
020100030818     c                   eval      *in30 = *on
020200030821     C                   iter
020300030818     c                   end
020301081208
020302081208      * validate resolve code
020303081208     c                   if        rescod2 <> *blanks
020304081208     c                   movel     'X'           rescod3           3
020305081208     c                   move      rescod2       rescod3
020306081208     c     rescod3       chain     codesl1
020307081208     c                   if        not %found(codesl1)
020308081208     c                   eval      *in31 = *on
020309081208     C                   iter
020310081208     c                   end
020311081208     c                   end
023901050307
023902081208      * update record
023904081208     c                   move      stat          chstat
023905081208     c                   if        rescod2 <> *blanks
023906081208     c                   movel     'X'           chrscod
023907081208     c                   move      rescod2       chrscod
023908091012      * fill resolve user first time only
023909091012     c                   if        chrsusr = *blanks
023910091012     c                   move      luser         chrsusr
023911091012     c                   end
023912091012
023913081208     c                   else
023914081208     c                   clear                   chrscod
023915081208     c                   end
023916081208
023917081208     c                   eval      chrsnot = %trimr(noteout)
023918081208     c                   update    comhstrl1
023919081208     c                   leavesr
024001081208
024100030821     C                   enddo
024200030821
024300030821     C* NO HIT ON FILE...error
024400000000     C                   ELSE
024500030820     C                   leavesr
024600000000     C                   END
024700030814
024800030820     C                   endsr
025326050308
025327081210     C************************************
025328081210     C* update all prompt                *
025329081210     C************************************
025330081210     C     #f23          BEGSR
025331081210
025332081210      * release locked record
025334081210     c                   unlock    comhstl1
025335081210     c                   clear                   s5frdt
025336081210     c                   clear                   s5todt
025337081210     c                   clear                   *in10
025338081210     c                   clear                   *in50
025339081210     c                   clear                   *in51
025340081210
025341081210     c                   dou       *in10
025342081210     C                   exfmt     S05
025343081210     c                   clear                   *in50
025344081210     c                   clear                   *in51
025345081210     C* F1 return
025346081210     c                   if        *in01
025347081210     c                   leavesr
025348081210     c                   end
025349081210
025350081210      * validate from date
025351081210     C     *USA          test (de)               s5frdt
025352081210     C                   if        %ERROR
025353081210     c                   eval      *in50 = *on
025354081210     c                   eval      *in10 = *off
025355081210     c                   iter
025356081210     C                   end
025357081210
025358081210      * validate to date
025359081210     C     *USA          test (de)               s5todt
025360081210     C                   if        %ERROR
025361081210     c                   eval      *in51 = *on
025362081210     c                   eval      *in10 = *off
025363081210     c                   iter
025364081210     C                   end
025385081210
025386081210     c                   enddo
025387081210
025388081210      * F10 was pressed so begin the update
025389081210
025390081210     c                   move      s5frdt        workdtmdy
025391081210     c                   move      workdtmdy     s5frdtymd
025392081210     c                   move      s5todt        workdtmdy
025393081210     c                   move      workdtmdy     s5todtymd
025394081210     C     s5frdtymd     SETLL     comhstl2
025395081210     c                   dou       %eof(comhstl2)
025396081210     C                   read      comhstl2
025397081210     C                   if        not %eof(comhstl2) and chtrdat >=
025398081210     c                             s5frdtymd and chtrdat <= s5todtymd and
025399081210     c                             chstat = *blank
025400081210     c                   eval      chstat = 'C'
025401081210     c                   update    comhstrl2
025402081210     c                   end
025403081210     c                   enddo
025404081210
025405081210     C                   endsr
025406081210     C*
025407030820
025408081209     C************************************
025409081209     C* DISPLAY codes in SUBFILE WINDOW  *
025410081209     C************************************
025411081209     C     #DSPcd        BEGSR
025412081209     C*
025413081209     C* CLEAR SUBFILE
025414081209     C*
025415081209     C                   MOVEA     '001'         *IN(80)
025416081209     C                   WRITE     SF04CTL
025417081209     C                   MOVE      '0'           *IN82
025418081209     C*
025419081209     C* BUILD SUBFILE
025420081209     C*
025421081209     C                   MOVE      *ZEROS        RR4               5 0
025422081209     C     x             SETLL     codes
025423081209     C                   dou       %eof(codes)
025424081209     C     x             READe     codes                                  81
025425081209
025426081209     c                   if        *in81 = *off
025427081209     c                   move      code          rc
025428081209     c                   movel     ldescr        desc
025429081209
025430081209     C                   ADD       1             RR4
025431081209     C                   WRITE     SF04
025432081209     C                   END
025433081209     C                   enddo
025434081209     C*
025435081209     C* DISPLAY SUBFILE IN WINDOW
025436081209     C*
025437081209     C                   if        RR4 > 0
025438081209     C                   MOVE      '1'           *IN80
025439081209     C                   END
025440081209     C*
025441081209     C                   WRITE     WINDOW4
025442081209     C                   EXFMT     SF04CTL
025443081209     C*
025444081209     C                   ENDSR
025445081209
025446050308      ***********************
025447050308      * clear subfile       *
025448050308      ***********************
025449050308     c     #clrsfl       begsr
025450050308
025500030820     C                   MOVEA     '0010'        *IN(60)
025600081208     C                   clear                   s2select
025700030820     C                   Z-ADD     1             SFREC#
025800030820     C                   clear                   rr2               5 0
025900030820     C                   clear                   COUNT             5 0
026000030820     C                   WRITE     S02CTL
026100030820     C                   eval      *in62 = *off
026200030820     C                   endsr
026300030820
026400030820      ***********************
026500030820      * build subfile       *
026600030820      ***********************
026700030820     c     #bldsfl       begsr
026800030821
026900081205     c                   dou       count = 85 or %eof(comhst)
026901081208     c                   if        s1tsa <> 0
027000081208     c     comkey        reade     comhst                                 64
027001081208     c                   else
027002081208     c                   read      comhst                                 64
027003081208     c                   end
027100030930
027300081208     C                   if        *in64 = *off
027302081208      * select trdate
027303081211     c                   if        s1trdtfr <> 0 and
027304081211     c                             (chtrdat < s1trdtfrymd or
027305081211     c                              chtrdat > s1trdttoymd)
027306081208     c                   iter
027307081208     c                   end
027308081208
027309081208      * select status
027310081208     c                   clear                   include           1
027311081208     c                   if        statnew <> *blank and chstat = ' '
027312081208     c                   move      'Y'           include
027313081208     c                   end
027314081208     c                   if        statclosed <> *blank and chstat = 'C'
027315081208     c                   move      'Y'           include
027316081208     c                   end
027317081208     c                   if        statopen <> *blank and chstat = 'O'
027318081208     c                   move      'Y'           include
027319081208     c                   end
027321081208     c                   if        include <> 'Y'
027322081208     c                   iter
027323081208     c                   end
027324081208
027325081208
027800030820     C                   ADD       1             rr2
027900030820     C                   ADD       1             COUNT
028000081208     c                   move      CHTRUST       s2t
028100081208     c                   move      CHSUB         s2s
028200081208     c                   move      CHACC         s2a
028300081208     c                   move      CHPLAN        s2plan
028400081208     c                   move      CHAREL        s2rel
028401081208     c                   if        chtrcod <> *blanks
028402081208     c     chtrcod       chain     codesl1
028403081208     c                   if        %found(codesl1)
028404081208     c                   movel     ldescr        s2trdsc
028405081208     c                   end
028406081208     c                   end
028407081209
028408081209      * change chtrdat to mdy
028409081209     c                   move      chtrdat       workdtmdy
028410081209     c                   move      workdtmdy     s2trdat
028500081209
028600081208     c                   move      CHTRTIM       s2trtim
028601081211
028602081211      * set status display
028603081211     c                   clear                   s2stat
028604081211     c                   select
028605081211     c                   when      chstat = *blank
028606081211     c                   eval      s2stat = 'NEW '
028607081211     c                   when      chstat = 'C'
028608081211     c                   eval      s2stat = 'CLOS'
028609081211     c                   when      chstat = 'O'
028610081211     c                   eval      s2stat = 'OPEN'
028611081211     c                   endsl
028701081211
028702081211      * set resolution description
028703081211     c                   clear                   s2res
028704081211     c                   if        chrscod <> *blanks
028705081211     c     chrscod       chain     codesl1
028706081211     c                   if        %found(codesl1)
028707081211     c                   movel     sdescr        s2res
028708081211     c                   end
028709081211     c                   end
028710081211
028711081208     c                   move      wqrelr        s2rec#
029700030820
029800030820     C                   WRITE     S02SFL
029900030820
030000031013     c*                  else
030100030821      * eof
030200031013     c*                  leave
030300030820     c                   end
030400030820
030500030820     c                   enddo
030600030820
030700030820     C                   endsr
0308009903230107 C*
0309009903230103 C***************************************************
0310009903230104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0311009903230105 C***************************************************
0312009903230107 C*
0313009903230107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0314009903230107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0315009903230107 C*
0316009903230106 C     #DATYM        BEGSR
031700990323     C                   MOVE      @DATIN        @MD               4 0
031800990323     C                   MOVEL     @DATIN        @Y                4 0
031900990323     C                   MOVEL     @MD           @DATOU            8 0
032000990323     C                   MOVE      @Y            @DATOU
032100990323     C                   MOVE      *ZEROS        @DATIN            8 0
0322009903230120 C                   ENDSR
032300990323     C*
0324000308200106 C     *inzsr        BEGSR
032500030820
032600081208     c     comkey        klist
032800081208     c                   kfld                    comkeyt
032900081208     c                   kfld                    comkeys
033000081208     c                   kfld                    comkeya
033001081205     c     acckey        klist
033002081208     c                   kfld                    s1t
033003081208     c                   kfld                    s1s
033004081208     c                   kfld                    s1a
033005081208     c     s3tsakey      klist
033006081209     c                   kfld                    s3t
033007081209     c                   kfld                    s3s
033008081209     c                   kfld                    s3a
035300030820
0354000308200120 C                   ENDSR
