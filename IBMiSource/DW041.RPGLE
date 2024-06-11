000100071127     hoption(*nodebugio)
0002009408170002 F******************************************************************
0003000510260003 F* dw041      GROUP BENEFIT SERVICES SOFTWARE                     *
0004009408170004 F*                                                                *
0005009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0006000510260006 F*            DATE - 10/26/05                                     *
0007009408170007 F*                                                                *
0008000510260008 F*  DESCRIPTION - prompt for ABR run and update abrhist file      *
0009000510260010 F*                for alternate carriers.                         *
0010000711270010 F* 11/27/07 dlk - This program will now include all abr runs.     *
0011000906160010 F* 06/16/09 dlk - add "S" abr code                                *
0012001510190010 F* 10/19/15 dlk - remove care first and phn abr codes             *
0013001611110010 F* 11/11/16 dlk - add ABRCTL file and convert to use it instead   *
0014001611110010 F*                of hard coded list of abr codes.                *
0015002301130010 F* 09/19/17 dlk - Prevent running special "X" ABR code, this is   *
0016001709190010 F*                being used as "Excluded from remittance" for    *
0017001709190010 F*                Evergreen just for a week.                      *
0018002301130010 F* 01/13/23 dlk - add edit to prevent running > 1 bill file for   *
0019002301130010 F*                same carrier and seq on the same day. This is   *
0020002301130010 F*                due to a limitation to the unique key field     *
0021002301130010 F*                in invdet (IDDTSQ) that is not unique when > 1  *
0022002301130010 F*                run for same abr code is done on the same day   *
0023002301130010 F*                as happend when SD ran for 12/22 #1 and 1/23    *
0024002301130010 F*                #1 to close out dental business.                *
0025002303210010 F* 03/21/23 dlk - remove default abrcode on screen for alt carrier*
0026002303210010 F*                run to force choice. This was a suggestion by   *
0027002303210010 F*                Anthony.                                        *
0028002303210010 F*                                                                *
0029009408170011 F******************************************************************
0030009408170012 F*                                                                *
0031000510260013 Fdw041d    CF   E             WORKSTN
003200071127     F                                     SFILE(SF01:RRN)
003300161111     F                                     SFILE(SF02:RR2)
0034001611110015 Fabrctl    iF   E           K DISK
0035001611110015 Fabrhist   iF a E           K DISK
0036002301130015 Fabrhistl1 if a e           K DISK    rename(abrr:abrl1) prefix(AA)
003700051028     d workdtymd       s               d   datfmt(*iso)
0038000510260056 D  parmcancel     s              1
0039000711270056 D  parmabr        s              1
0040000711270056 D  prevseq        s              2  0
0041000510260056 D  error          s              1
0042002301130056 D  err1           c                   const('** ERROR - THIS DATE/ABR/SEQ +
0043002301130056 D                                     HAS ALREADY BEEN RUN **             +
0044002301130056 D                                          ')
0045000510270056 D  err2           c                   const('** THE ORIGINAL RUN FOR THIS +
0046000510270056 D                                     DATE HAS ALREADY BEEN PROCESSED **  +
0047000510270056 D                                          ')
0048000711270056 D  err3           c                   const('** INVALID RUN SEQUENCE. +
0049000711270056 D                                     PLEASE ENTER THE NEXT AVAILABLE #  +
0050000510270056 D                                              ')
0051000711280056 D  err4           c                   const('** PREVIOUS MONTH LAST SEQ +
0052000711280056 D                                     HAS NOT BEEN POSTED. **             +
0053000711280056 D                                             ')
0054000711270056 D  err5           c                   const('** PREVIOUS RUN HAS NOT BEEN +
0055000711270056 D                                     POSTED. PLEASE POST PREVIOUS SEQ +
0056000711270056 D                                     FIRST **')
0057000711280056 D  err6           c                   const('** ERROR - THE NEXT MONTH +
0058000711280056 D                                     ABR HAS ALREADY BEEN RUN **         +
0059000711280056 D                                             ')
0060002301130056 D  err7           c                   const('** ERROR - THIS ABR/SEQ +
0061002301130056 D                                     ALREADY RAN TODAY. CANNOT RUN AGAIN +
0062002301130056 D                                     TODAY     ')
0063000510260055 D                 DS
0064000510260056 D  effdt                  1      8s 0
0065000510260056 D  effm                   1      2s 0
0066000510260056 D  effd                   3      4s 0
0067000510260056 D  effy                   5      8s 0
0068000510260055 D                uDS
0069000510260056 D  leffmdy               85     92
0070000711270056 D  lseq                  21     22
0071000711280056 D  lwiredt               30     37
0072000510260056 D  labrcode             200    200
0073000510260601 D  CONAME               201    240
0074000510260601 D  luser               1000   1009
007500020702
007600051026     c                   clear                   effdt
007700071128     c                   clear                   wiredt
007800051026
007900051026     c                   dou       *inlr = *on
008000051026     C                   exfmt     scrn01
008100051026
008200051026      * f7 - cancel
008300051026     c                   if        *in07 = *on
008400051026     c                   move      'Y'           parmcancel
008500051026     c                   goto      #end
008600051026     c                   end
008700051026
008800051026      * clear errors
008900051026     c                   clear                   error
009000051026     c                   clear                   errortxt
009100051026     c                   eval      *in21 = *off
009200071127     c                   eval      *in22 = *off
009300071127     c                   eval      *in23 = *off
009400071128     c                   eval      *in26 = *off
009500051026     c                   eval      *in92 = *off
009600051026
0097001611110077  *  F4 DISPLAY ABR codes
0098001611110079 C                   if        *inkd = *on
0099001611110080 C                   EXSR      #DSPabr
0100001611110080 C                   iter
010100161111     C                   END
010200161111
010300051026      * edits
010400051026     c                   if        effm < 1 or effm > 12 or effd <> 1 or
010500230113     c                             effy < 2015 or effy > 2035
010600051026     c                   eval      *in21 = *on
010700051026     c                   eval      error = 'Y'
010800051026     c                   iter
010900051026     c                   end
011000071127
011100071127      * edit ABR CODE
011200170919      * Do not allow code "X" - Exclude from remittance
011300161111
011400161111       chain abrcode abrctl;
011500170919       if not %found(abrctl) or abcstat <> 'A' or abrcode = 'X';
011600161111        *in23 = *on;
011700161111        error = 'Y';
011800161111        iter;
011900161111       endif;
012000161114
012100161114      * only allow DBE code when dbe run and non dbe code when non dbe run
012200161114     c                   if        (parmabr = 'D' and abrcode <> 'D') or
012300161114     c                             (parmabr <> 'D' and abrcode = 'D')
012400161114     c                   eval      *in23 = *on
012500161114     c                   eval      error = 'Y'
012600161114     c                   iter
012700161114     c                   end
012800161114
012900071127
013000071127     c                   move      effdt         @datin
013100071127     c                   exsr      #datym
013200071127     c                   move      @datou        effymd            8 0
0133000711270076 C*
0134000711270077 C*  ON CMD 5 DISPLAY SUBFILE OF abr history for this effdt
0135000711270078 C*
0136000711270079 C                   if        *inke = *on
0137000711270080 C                   EXSR      #DSPhist
0138000711270080 C                   iter
013900071127     C                   END
014000071127
014100071205      * Edit the seq.
014200071205     c                   if        runseq < 01 or runseq > 99
014300071127     c                   eval      *in22 = *on
014400071127     c                   eval      error = 'Y'
014500071127     c                   iter
014600071127     c                   end
014700071127
014800071128      * has this month/seq already been run?
014900071127     C     abrkey2       CHAIN     abrhist
015000071127     c                   if        %found(abrhist)
015100051027     c                   eval      errortxt = err1
015200051027     c                   eval      error    = 'Y'
015300071127     c                   iter
015400071127     c                   end
015500071128
015600071128      * has next month/seq already been run?
015700071128     c                   move      effymd        workdtymd
015800071128     c                   adddur    1:*m          workdtymd
015900071128     c                   move      workdtymd     effymdplus1       8 0
016000071128
016100071128     C     nextabrkey    CHAIN     abrhist
016200071128     c                   if        %found(abrhist)
016300071128     c                   eval      errortxt = err6
016400071128     c                   eval      error    = 'Y'
016500071128     c                   iter
016600071128     c                   end
016700051027
016800071127      * make sure the next avail seq # is being run
016900071127     c                   exsr      #fndnxtseq
017000071127     c                   if        runseq <> nxtavlseq
017100071127     c                   eval      errortxt = err3
017200051027     c                   eval      error    = 'Y'
017300071127     c                   iter
017400071127     c                   end
017500071128
017600071128      * if seq 01, prior month last run must be complete / posted
017700071128     c                   if        runseq = 01
017800071128     c                   move      effymd        workdtymd
017900071128     c                   subdur    1:*m          workdtymd
018000071128     c                   move      workdtymd     effymdminus1      8 0
018100071128
018200071128     c                   clear                   lastpostdt        8 0
018300071128     C     prevabrkey    setll     abrhist
018400071128     C                   dou       %eof(abrhist)
018500071128     C     prevabrkey    READE     abrhist
018600071128     C                   if        not %eof(abrhist)
018700071128     c                   move      abposdate     lastpostdt
018800071128     C                   END
018900071128     C                   enddo
019000071128
019100071128     c                   if        lastpostdt = 0
019200071128     c                   eval      errortxt = err4
019300071128     c                   eval      error    = 'Y'
0194000711280080 C                   iter
019500071128     c                   end
019600071128     c                   end
019700071128
019800071127      * if seq # > 01 make sure the prev seq # was posted
019900071127     c                   if        runseq > 01
020000071127     c                   eval      prevseq = runseq - 1
020100071127     C     abrkey3       CHAIN     abrhist
020200071128     c                   if        not %found(abrhist) or abposdate = 0
020300071127     c                   eval      errortxt = err5
020400071127     c                   eval      error    = 'Y'
020500071127     c                   iter
020600071127     c                   end
020700071128     c                   end
020800071128      * edit wire date
020900151019     c                   if        abrcode = 'D'
021000071128     C     *usa          test (de)               wiredt
021100071128    2C                   if        %error
021200071128     c                   eval      *in26 = *on
021300071128     c                   eval      error    = 'Y'
021400071128     c                   iter
021500071128    2C                   end
021600071128     c                   end
021700071128
021800230113      * make sure another run has not occured for same carrier and seq #
021900230113      * today (due to IDDTSQ field in invdet not being able to handle this
022000230113      * as a unique key).
022100230113     c                   move      *date         @datin
022200230113     c                   exsr      #datym
022300230113     c                   move      @datou        udymd
022400230113     C     abrkey4       CHAIN     abrhistl1
022500230113     c                   if        %found(abrhistl1)
022600230113     c                   eval      errortxt = err7
022700230113     c                   eval      error    = 'Y'
022800230113     c                   iter
022900230113     c                   end
023000230113
023100230113
023200051027      * if no errors display F2 - submit (92 = unhide text)
023300051027     c                   if        error = *blank
023400051026     c                   eval      *in92 = *on
023500051026     c                   end
023600051026
023700071127      * if no errors and user pressed F2- fill lda, write and continue
023800051027     c                   if        error = *blank and *in02
023900051026     c                   move      effdt         leffmdy
024000071127     c                   move      runseq        lseq
024100051026     c                   move      abrcode       labrcode
024200071128     c                   move      wiredt        lwiredt
024300051026
024400051026     c                   move      *date         @datin
024500051026     c                   exsr      #datym
024600051026     c                   move      @datou        udymd             8 0
024700051026
024800071128     c                   clear                   abrr
024900071127     c                   move      effymd        abeffdat
025000071127     c                   move      abrcode       abcar
025100071127     c                   move      runseq        abseq
025200071127     c                   move      udymd         abrundate
025300071127     c                   time                    abruntime
025400071127     c                   movel     luser         abrunuser
025500051027
025600071127     c                   write     abrr
025700051026
025800051026     c                   leave
025900051026     c                   end
026000051026
026100020702     c                   enddo
026200051026
026300051026     c     #end          tag
026400051026
026500020703     c                   eval      *inlr = *on
026600051028
0267000711270103 C***************
0268000711270104 C* find next avail seq #
0269000711270103 C***************
0270000711270106 C     #fndnxtseq    BEGSR
027100071127
027200071127     c                   clear                   nxtavlseq
027300071127     C     abrkey        setll     abrhist
027400071127     C                   dou       %eof(abrhist)
027500071127     C     abrkey        READE     abrhist
027600071127     C                   if        not %eof(abrhist)
027700071127     c                   move      abseq         nxtavlseq         2 0
027800071127     C                   END
027900071127     C                   enddo
028000071127
028100071127     c                   add       1             nxtavlseq
028200071127
0283000711270106 C                   endsr
0284000510280103 C***************
0285000510280104 C* flip dates
0286000510280103 C***************
0287000510280106 C     #flipdates    BEGSR
028800051028
028900071127     c                   move      abrundate     @datin
029000051028     c                   exsr      #datym
029100071127     c                   move      @datou        abrunmdy
029200051028
029300071127     c                   move      abposdate     @datin
029400051028     c                   exsr      #datym
029500071127     c                   move      @datou        abposmdy
029600051028
029700051028
0298000510280120 C                   ENDSR
029900071127     C************************************
030000071127     C* DISPLAY abr hist in SUBFILE WINDOW  *
030100071127     C************************************
030200071127     C     #DSPhist      BEGSR
030300071127     C*
030400071127     C* CLEAR SUBFILE
030500071127     C*
030600071127     C                   MOVEA     '001'         *IN(90)
030700071127     C                   WRITE     SF01CTL
030800071127     C                   MOVE      '0'           *IN92
030900071127     C*
031000071127     C* BUILD SUBFILE
031100071127     C*
031200071127     C                   clear                   RRN               5 0
031300071127     C     abrkey        SETLL     abrhist
031400071127     C                   dou       %eof(abrhist)
031500071127     C     abrkey        READE     abrhist                                91
031600071127     C                   if        *in91 = *off
031700071127     c                   exsr      #flipdates
031800071127     C                   ADD       1             RRN
031900071127     C                   WRITE     SF01
032000071127     C                   END
032100071127     C                   enddo
032200071127     C*
032300071127     C* DISPLAY SUBFILE IN WINDOW
032400071127     C* if no rec found, display not found msg
032500071127     C                   if        rrn = 0
032600071127     c                   clear                   sf01
032700071127     c                   eval      abrunuser = 'NOT FOUND'
032800071127     c                   add       1             rrn
032900071127     c                   write     sf01
033000071127     C                   end
033100071127
033200071127     C                   eval      *in90 = *on
033300071127     C*
033400071127     C                   WRITE     WINDOW
033500071127     C                   EXFMT     SF01CTL
033600071127     C*
033700071127     C                   ENDSR
033800051026
033900161111     C****************************************
034000161111     C* DISPLAY abr codes in SUBFILE WINDOW  *
034100161111     C****************************************
034200161111     C     #DSPabr       BEGSR
034300161111     C*
034400161111     C* CLEAR SUBFILE
034500161111     C*
034600161111     C                   MOVEA     '001'         *IN(80)
034700161111     C                   WRITE     SF02CTL
034800161111     C                   MOVE      '0'           *IN82
034900161111     C*
035000161111     C* BUILD SUBFILE
035100161111     C*
035200161111     C                   clear                   RR2               5 0
035300161111     C     *loval        SETLL     abrctl
035400161111     C                   dou       %eof(abrctl)
035500161111     C                   READ      abrctl                                 81
035600161111     C                   if        *in81 = *off and abcstat = 'A'
035700161111     c                   movel     abccode       sfabr
035800161111     c                   movel     abcdesc       sfdesc
035900161111     C                   ADD       1             RR2
036000161111     C                   WRITE     SF02
036100161111     C                   END
036200161111     C                   enddo
036300161111     C*
036400161111     C* DISPLAY SUBFILE IN WINDOW
036500161111     C* if no rec found, display not found msg
036600161111     C                   if        rr2 = 0
036700161111     c                   clear                   sf02
036800161111     c                   eval      sfdesc = 'NOT FOUND'
036900161111     c                   add       1             rr2
037000161111     c                   write     sf02
037100161111     C                   end
037200161111
037300161111     C                   eval      *in80 = *on
037400161111     C*
037500161111     C                   WRITE     WINDOW2
037600161111     C                   EXFMT     SF02CTL
037700161111     C*
037800161111     C                   ENDSR
037900161111
0380000510260103 C***************************************************
0381000510260104 C* CONVERT FIELD FROM YMD TO MDY or MDY TO YMD
0382000510260105 C***************************************************
0383000510260106 C     #DATYM        BEGSR
038400051026     C                   MOVE      @DATIN        @MD               4 0
038500051026     C                   MOVEL     @DATIN        @Y                4 0
038600051026     C                   MOVEL     @MD           @DATOU            8 0
038700051026     C                   MOVE      @Y            @DATOU
038800051026     C                   MOVE      *ZEROS        @DATIN            8 0
0389000510260120 C                   ENDSR
039000051026
039100020703
039200020701     C     *inzsr        BEGSR
039300051026     c     *ENTRY        plist
039400051026     C                   parm                    parmcancel
039500071127     C                   parm                    parmabr
039600051026
039700071129      * fill heading and ABR CODE. *in37 prevents input
039800230321      * 03/21/23 - remove default "O" abrcode when alt carrier run to
039900230321      *            force a choice.
040000071127     c                   select
040100071127     c                   when      parmabr = 'O' or parmabr = 'N'
040200230321     c                   eval      abrcode = ' '
040300071127     c                   eval      cardes = '* ALTERNATE CARRIER RUN *'
040400071127
040500071127     c                   when      parmabr = 'D'
040600071127     c                   eval      abrcode = 'D'
040700071129     c                   eval      *in37 = *on
040800071127     c                   eval      cardes = '     ** DBE RUN **       '
040900071127     c                   endsl
041000071127
041100051026     C     abrkey        KLIST
041200051026     C                   KFLD                    effymd
041300051026     C                   KFLD                    abrcode
041400071127     C     abrkey2       KLIST
041500071127     C                   KFLD                    effymd
041600071127     C                   KFLD                    abrcode
041700071127     C                   KFLD                    runseq
041800071127     C     abrkey3       KLIST
041900071127     C                   KFLD                    effymd
042000071127     C                   KFLD                    abrcode
042100071127     C                   KFLD                    prevseq
042200230113
042300230113     C     abrkey4       KLIST
042400230113     C                   KFLD                    udymd
042500230113     C                   KFLD                    abrcode
042600230113     C                   KFLD                    runseq
042700230113
042800051028     C     prevabrkey    KLIST
042900051028     C                   KFLD                    effymdminus1
043000051028     C                   KFLD                    abrcode
043100071128     C     nextabrkey    KLIST
043200071128     C                   KFLD                    effymdplus1
043300071128     C                   KFLD                    abrcode
043400020701     C                   ENDSR
