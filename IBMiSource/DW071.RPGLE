000001071127     hoption(*nodebugio)
0001009408170002 F******************************************************************
0002000712050003 F* dw071      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009408170004 F*                                                                *
0004009408170005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000712050006 F*            DATE - 12/05/07                                     *
0006009408170007 F*                                                                *
0007000712050008 F*  DESCRIPTION - copied from dw041 to POST cr130hs* for all      *
0009000712050010 F*                carriers.                                       *
0009020906120010 F* 06/12/09 dlk - add "S" abr code                                *
0009031611140010 F* 11/14/16 dlk - add ABRCTL file and convert to use it instead   *
0009041611140010 F*                of hard coded list of abr codes.                *
0009051612120010 F* 12/12/16 dlk - remove blue cross run                           *
0009060906120010 F*                                                                *
0010009408170011 F******************************************************************
0011009408170012 F*                                                                *
0012000712050013 Fdw071d    CF   E             WORKSTN
001201071127     F                                     SFILE(SF01:RRN)
001202161114     F                                     SFILE(SF02:RR2)
0012031611140015 Fabrctl    iF   E           K DISK
0015000712050015 Fabrhist   uF   E           K DISK
001501051028     d workdtymd       s               d   datfmt(*iso)
0015020510260056 D  parmcancel     s              1
0015030711270056 D  parmabr        s              1
0015040711270056 D  prevseq        s              2  0
0015050510260056 D  error          s              1
0015060711270056 D  err1           c                   const('** ERROR - THIS DATE/ABR/ +
0015070712050056 D                                     SEQ HAS NOT BEEN RUN YET **         +
0015080510270056 D                                             ')
0015090712050056 D  err2           c                   const('** THIS RUN HAS ALREADY BEEN +
0015100712050056 D                                     POSTED **                           +
0015110510270056 D                                          ')
0015240510260055 D                 DS
0015250510260056 D  effdt                  1      8s 0
0015260510260056 D  effm                   1      2s 0
0015270510260056 D  effd                   3      4s 0
0015280510260056 D  effy                   5      8s 0
0015290510260055 D                uDS
0015300712050056 D  leffmdy                1      8
0015310712050056 D  lseq                   9     10
0015330712050056 D  labrcode              11     11
0015340510260601 D  CONAME               201    240
0015350510260601 D  luser               1000   1009
004300020702
008501051026     c                   clear                   effdt
008503051026
008504051026     c                   dou       *inlr = *on
008900051026     C                   exfmt     scrn01
008901051026
008902051026      * f7 - cancel
008903051026     c                   if        *in07 = *on
008904051026     c                   move      'Y'           parmcancel
008905051026     c                   goto      #end
008906051026     c                   end
008907051026
008908051026      * clear errors
008909051026     c                   clear                   error
008910051026     c                   clear                   errortxt
008911051026     c                   eval      *in21 = *off
008913071127     c                   eval      *in22 = *off
008914071127     c                   eval      *in23 = *off
008916051026     c                   eval      *in92 = *off
009101161114
0091021611140077  *  F4 DISPLAY ABR codes
0091031611140079 C                   if        *inkd = *on
0091041611140080 C                   EXSR      #DSPabr
0091051611140080 C                   iter
009106161114     C                   END
009107161114
009108051026      * edits
009109051026     c                   if        effm < 1 or effm > 12 or effd <> 1 or
009110161114     c                             effy < 2015 or effy > 2030
009111051026     c                   eval      *in21 = *on
009112051026     c                   eval      error = 'Y'
009113051026     c                   iter
009114051026     c                   end
009115161114
009116161114      * edit ABR CODE
009117161114
009118161114       chain abrcode abrctl;
009119161114       if not %found(abrctl) or abcstat <> 'A';
009120161114        *in23 = *on;
009121161114        error = 'Y';
009122161114        iter;
009123161114       endif;
009124161114
009125071127
009126161114      * only allow DBE code when dbe run and non dbe code when non dbe run
009127161114     c                   if        (parmabr = 'D' and abrcode <> 'D') or
009128161114     c                             (parmabr <> 'D' and abrcode = 'D')
009129161114     c                   eval      *in23 = *on
009130161114     c                   eval      error = 'Y'
009131161114     c                   iter
009132161114     c                   end
009153071127
009154161114
009155071127     c                   move      effdt         @datin
009156071127     c                   exsr      #datym
009157071127     c                   move      @datou        effymd            8 0
0095020711270076 C*
0095030711270077 C*  ON CMD 5 DISPLAY SUBFILE OF abr history for this effdt
0095040711270078 C*
0095050711270079 C                   if        *inke = *on
0095060711270080 C                   EXSR      #DSPhist
0095070711270080 C                   iter
009508071127     C                   END
009510071127
009511071205      * Edit the seq.
009513071205     c                   if        runseq < 01 or runseq > 99
009514071127     c                   eval      *in22 = *on
009515071127     c                   eval      error = 'Y'
009516071127     c                   iter
009517071127     c                   end
009518071127
009552071205      * verify this month/seq has already been run and has not been posted
009900071127     C     abrkey2       CHAIN     abrhist
009904071205     c                   if        not %found(abrhist)
009905051027     c                   eval      errortxt = err1
009906051027     c                   eval      error    = 'Y'
009907071127     c                   iter
009908071205     c                   else
009909071205     c                   if        abposdate <> 0 or abrundate = 0
009910071205     c                   unlock    abrhist
009911071205     c                   eval      errortxt = err2
009912071205     c                   eval      error    = 'Y'
009913071205     c                   iter
009914071127     c                   end
009915071205     c                   end
010504071128
010520051027      * if no errors display F2 - submit (92 = unhide text)
010521051027     c                   if        error = *blank
010522051026     c                   eval      *in92 = *on
010523051026     c                   end
010524051026
010525071205      * if no errors and user pressed F2- fill lda, update and continue
010526051027     c                   if        error = *blank and *in02
010527051026     c                   move      effdt         leffmdy
010528071127     c                   move      runseq        lseq
010529051026     c                   move      abrcode       labrcode
010531051026
010532051026     c                   move      *date         @datin
010533051026     c                   exsr      #datym
010534051026     c                   move      @datou        udymd             8 0
010535051026
010540071205     c                   move      udymd         abposdate
010541071205     c                   time                    abpostime
010542071205     c                   movel     luser         abposuser
010546051027
010547071205     c                   update    abrr
010548051026
010549051026     c                   leave
010550051026     c                   end
010551051026
010552020702     c                   enddo
010553051026
010554051026     c     #end          tag
010555051026
011960020703     c                   eval      *inlr = *on
011961051028
0119790510280103 C***************
0119800510280104 C* flip dates
0119810510280103 C***************
0119820510280106 C     #flipdates    BEGSR
011983051028
011984071127     c                   move      abrundate     @datin
011985051028     c                   exsr      #datym
011986071127     c                   move      @datou        abrunmdy
011987051028
011988071127     c                   move      abposdate     @datin
011989051028     c                   exsr      #datym
011990071127     c                   move      @datou        abposmdy
011991051028
011992051028
0119930510280120 C                   ENDSR
011994071127     C************************************
011995071127     C* DISPLAY abr hist in SUBFILE WINDOW  *
011996071127     C************************************
011997071127     C     #DSPhist      BEGSR
011998071127     C*
011999071127     C* CLEAR SUBFILE
012000071127     C*
012001071127     C                   MOVEA     '001'         *IN(90)
012002071127     C                   WRITE     SF01CTL
012003071127     C                   MOVE      '0'           *IN92
012004071127     C*
012005071127     C* BUILD SUBFILE
012006071127     C*
012007071127     C                   clear                   RRN               5 0
012008071127     C     abrkey        SETLL     abrhist
012009071127     C                   dou       %eof(abrhist)
012010071127     C     abrkey        READE     abrhist                                91
012011071127     C                   if        *in91 = *off
012012071127     c                   exsr      #flipdates
012013071127     C                   ADD       1             RRN
012014071127     C                   WRITE     SF01
012015071127     C                   END
012016071127     C                   enddo
012017071127     C*
012018071127     C* DISPLAY SUBFILE IN WINDOW
012019071127     C* if no rec found, display not found msg
012020071127     C                   if        rrn = 0
012021071127     c                   clear                   sf01
012023071127     c                   eval      abrunuser = 'NOT FOUND'
012024071127     c                   add       1             rrn
012025071127     c                   write     sf01
012026071127     C                   end
012027071127
012028071127     C                   eval      *in90 = *on
012031071127     C*
012032071127     C                   WRITE     WINDOW
012033071127     C                   EXFMT     SF01CTL
012034071127     C*
012035071127     C                   ENDSR
012037161114
012038161114     C****************************************
012039161114     C* DISPLAY abr codes in SUBFILE WINDOW  *
012040161114     C****************************************
012041161114     C     #DSPabr       BEGSR
012042161114     C*
012043161114     C* CLEAR SUBFILE
012044161114     C*
012045161114     C                   MOVEA     '001'         *IN(80)
012046161114     C                   WRITE     SF02CTL
012047161114     C                   MOVE      '0'           *IN82
012048161114     C*
012049161114     C* BUILD SUBFILE
012050161114     C*
012051161114     C                   clear                   RR2               5 0
012052161114     C     *loval        SETLL     abrctl
012053161114     C                   dou       %eof(abrctl)
012054161114     C                   READ      abrctl                                 81
012055161114     C                   if        *in81 = *off and abcstat = 'A'
012056161114     c                   movel     abccode       sfabr
012057161114     c                   movel     abcdesc       sfdesc
012058161114     C                   ADD       1             RR2
012059161114     C                   WRITE     SF02
012060161114     C                   END
012061161114     C                   enddo
012062161114     C*
012063161114     C* DISPLAY SUBFILE IN WINDOW
012064161114     C* if no rec found, display not found msg
012065161114     C                   if        rr2 = 0
012066161114     c                   clear                   sf02
012067161114     c                   eval      sfdesc = 'NOT FOUND'
012068161114     c                   add       1             rr2
012069161114     c                   write     sf02
012070161114     C                   end
012071161114
012072161114     C                   eval      *in80 = *on
012073161114     C*
012074161114     C                   WRITE     WINDOW2
012075161114     C                   EXFMT     SF02CTL
012076161114     C*
012077161114     C                   ENDSR
012078161114
0120790510260103 C***************************************************
0120800510260104 C* CONVERT FIELD FROM YMD TO MDY or MDY TO YMD
0120810510260105 C***************************************************
0120820510260106 C     #DATYM        BEGSR
012083051026     C                   MOVE      @DATIN        @MD               4 0
012084051026     C                   MOVEL     @DATIN        @Y                4 0
012085051026     C                   MOVEL     @MD           @DATOU            8 0
012086051026     C                   MOVE      @Y            @DATOU
012087051026     C                   MOVE      *ZEROS        @DATIN            8 0
0120880510260120 C                   ENDSR
012089051026
012090020703
012091020701     C     *inzsr        BEGSR
012092051026     c     *ENTRY        plist
012093051026     C                   parm                    parmcancel
012094071127     C                   parm                    parmabr
012095051026
012096071129      * fill heading and ABR CODE. *in37 prevents input
012097071127     c                   select
012098090612     c                   when      parmabr = 'O' or parmabr = 'N' or
012099090612     c                             parmabr = 'S'
012100071127     c                   eval      abrcode = 'O'
012101071127     c                   eval      cardes = '* ALTERNATE CARRIER RUN *'
012107071127
012108071127     c                   when      parmabr = 'D'
012109071127     c                   eval      abrcode = 'D'
012110071129     c                   eval      *in37 = *on
012111071127     c                   eval      cardes = '     ** DBE RUN **       '
012112071127     c                   endsl
012113071127
012114051026     C     abrkey        KLIST
012115051026     C                   KFLD                    effymd
012116051026     C                   KFLD                    abrcode
012117071127     C     abrkey2       KLIST
012118071127     C                   KFLD                    effymd
012119071127     C                   KFLD                    abrcode
012120071127     C                   KFLD                    runseq
012121020701     C                   ENDSR
