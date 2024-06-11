0002009102150002 F******************************************************************
0003000504190003 F* DW221      GROUP BENEFIT SERVICES, INC.                        *
0004009102150004 F*                                                                *
0005000504190005 F*            WRITTEN BY - David Ketterman                        *
0006000504190006 F*            DATE - 04/19/05.                                    *
0007009509120007 F*                                                                *
000800950907     F*
0009000504190008 F*  DESCRIPTION - THIS PROGRAM WILL PROCESS COBRA PAYMENTS        *
0010000504190009 F*                FROM M&T BANK                                   *
0010010507210015 F* 07/21/05 dlk - add edit for acc #                              *
0010020710250015 F* 10/25/07 dlk - add remote deposit                              *
0010030804070015 F* 04/07/08 dlk - add cobra Alt Id logic                          *
0010040901140015 F* 01/14/09 dlk - change bksource check                           *
0010050907090015 F* 07/09/09 dlk - fix dup check search                            *
0010061007200015 F* 07/20/10 dlk - add payment type "D" and "T" to dup check       *
001007131003      * 10/03/13 dlk - hist file expansion project
0014012304200015 F* 04/20/23 jt  - Added optional parm
0014022306260015 F* 06/30/23 jt  - Changed reversal code from BPR to BMP
0015009102150013 F******************************************************************
0016000504190014
0017000504200015 Fbankmt    UP   e             DISK
0019000505060017 FHISTaa    IF   e           k DISK    prefix(h_) rename(histr:histraa)
0019010504200017 FMEMBER    uF   e           k DISK
0019020804070017 Fmemaltl1  iF   e           k DISK
0020000505050017 FHIST      O  a e             DISK
0020010504190017 FDW221xl   o  a e             DISK
002002230420
002003230420      *========================================================================
002004230420
002005230420     d psds           sds
002006230420     d  proc_name        *proc
002007230420     d  jobName              244    253
002008230420     d  userName             254    263
002009230420     d  jobNumber            264    269
002010230420
0027000505110020 D MSG             S             30    DIM(7) CTDATA PERRCD(1)
0027020504220037 D isodate         S               d   datfmt(*iso)
0027040504220020 D wkssn           S              9  0
0027050505060020 D payeffdt        S              8  0
0027060505110020 D chkamtchar      S             14
0027070505110020 D blank15         S             15
0027080804070020 D atype           S                   like(MAALTTP)
0027090804070020 D aid             S                   like(MAALTID)
002710050721     D DIGITS          C                   CONST('0123456789')
0027111310030037 D sysdateymd      S               d   datfmt(*iso)
0027121310030037 D systime         S               t
002713131003     D thispgmname     S             10a   inz('DW221     ')
0028000504220064
0028060504220065 D                 DS
0028070505130066 D  dsnote2               56     85
0028090505130066 D  dsbkinv               69     78
0028100505260066 D  dsbkbatch             83     85
002811230420
0028120505130065 D                 DS
0028130505130066 D  bkacct                 1     10
0028140505130066 D  bkc                    1      1
0028150804070066 D  bkb                    2      2
0028160804070066 D  bkssn                  2     10
002817230420
003901050429     D                 DS
003902050429     D ud8ymd                  1      8  0
003903050429     D  DYY                    1      4  0
003904050429     D  DMM                    5      6  0
003905050429     D  DDD                    7      8  0
007802050225
007803230420     d dw221           pi
007804230518     d  reverse                       1
007805230420
007806230420      *========================================================================
007807230420
007808050721      * is 1st position numeric (account payment)?
007809050721     C                   move      'Y'           bkcnum            1
007810050721     C     DIGITS        CHECK     bkc                                    99
007811050721     C   99              MOVE      'N'           bkcnum
007812050721
009300050426     C* if rec has already been processed or if is not a cobra payment
009400050426     C* skip it.
009500050721     C                   if        bkstat = 'X' or bkcnum = 'Y'
009600050422     C                   GOTO      #END
009700950906     C                   END
009708050426
009709050505     c                   clear                   histr
009710050505
009902050422     c                   clear                   msgout           30
009903050422     c                   clear                   error             1
010003050422     C                   MOVE      bkamt         PAY82             8 2
010004050422     C                   MOVE      bkamt         paymnt            8 2
010007050422
010008050422      * edit all input fields
010009050422     c                   exsr      #edit
010010050422
010011050422     c                   if        error = 'Y'
010012050511     c                   goto      #update
010013050422     c                   end
010014050505
010015050505      * prep hist rec
010016050505
010017080407     c                   move      wkssn         hkey
010019050505     C                   MOVEL     bkchk#        CK#NOT
010020050511     c                   clear                   chkamtchar
010021050511     c                   evalr     chkamtchar =
010022050513     c                             (%editc(pay82:'M':*cursym))
010023050513     c***                          %trim(%editc(pay82:'M':*cursym))
010024050511     C                   MOVE      chkamtchar    CK#NOT
010025050511
010026050526     C                   MOVE      bkbatch       dsbkbatch
010027050526     C                   MOVE      bkinv         dsbkinv
010028050513     C                   MOVE      dsnote2       note2
010029230420     C
010031230420
010032131003     C                   movel     thispgmname   hprgnm
010033050505     C                   move      mbtrst        hstrst
010034050505     C                   move      mbsub#        hssub#
010035050505     C                   move      mbacct        hsacct
010036050512
010037050512      * where did this payment come from ? M&T bank or princeton e-com
010038090114      * or remote deposit? 'PRINCEECOM', 'M&T BANK  ' or 'REMOTE DEP'
010039090114
010040090114      * 1/14/09 - only check first 8 bytes of bksource. This was added
010041090114      *           because one time the princeton data was ftp'd over the
010042090114      *           m&t file causing a 2 byte truncation of bksource
010043090114
010044071025     c                   clear                   hoper
010045071025     c                   clear                   cm$flg
010046050512
010047090114     c                   movel     bksource      bksource8         8
010048090114
010049071025     c                   select
010050090114     c                   when      bksource8 = 'PRINCEEC'
010052131003     C                   movel     'PECOM     '  hoper
010053050523     C                   MOVE      'E'           CM$FLG
010054090114     c                   when      bksource8 = 'M&T BANK'
010056131003     C                   movel     'M&TBANK   '  hoper
010057050523     C                   MOVE      'C'           CM$FLG
010058090114     c                   when      bksource8 = 'REMOTE D'
010060131003     C                   movel     'REMDEP    '  hoper
010061071025     C                   MOVE      'C'           CM$FLG
010062090114      * source not found
010063090114     c                   other
010064090114     C                   MOVE      'C'           CM$FLG
010065071025     c                   endsl
010066050512
010067230420       exsr reversePayment;
010068050505     C                   move      'A'           hsdltd
010069050505     C                   move      ud8ymd        trdate
010070050505     C                   move      bkrcvdt       recvdt
010071050422
023200050505     C* Post payment
023202050505     c                   exsr      #post
023300050426
023600950810     C                   ADD       PAY82         AMT              11 2
023700950810     C                   ADD       1             CNT               9 0
023801050214     c                   exsr      writexldet
0267000505110098
0267010505110098 C* update status so this rec is not processed again by accident
026702050511     c     #update       tag
026800050422     C                   MOVE      'X'           bkstat            1
026900050422     C                   update    bankmtr
027000950906     C*
027001050422     c     #end          tag
027002050511
027100950810     CLR   ERRAMT        ADD       AMT           LRAMT            11 2
027200950810     CLR   ERRCNT        ADD       CNT           LRCNT             9 0
027300050221     CLR                 exsr      writexllr
027301050422
027802050422      ************************************************
027803050422      * edit input fields
027804050422      ************************************************
027805050422     c     #edit         begsr
027806050422
027807050422     C                   clear                   error
027808050506     C                   clear                   statout
027809050506     C                   clear                   cexmdy
027810080407     C                   clear                   wkssn
027811050512
027812050512      * receive date
027813050512     C                   MOVE      bkrcvdt       @DATIN
027814050512     C                   EXSR      #DATym
027815050512     C                   MOVE      @DATOU        rcvmdy            8 0
027816050422
027818080407      * validate cobra
027819080407     c                   if        bkc <> 'C'
027820080407     c                   move      msg(1)        msgout
027821080407     c                   exsr      writexldet
027822080407     C                   ADD       PAY82         ERRAMT
027823080407     C                   ADD       1             ERRCNT
027824080407     C                   eval      error = 'Y'
027825080407     C                   leavesr
027826080407     c                   end
027827080407
027828080407      * if SSN used, validate it (C999999999)
027829080407     c                   if        bkb <> 'B'
027830050721     C     DIGITS        CHECK     bkssn                                  99
027831080407     c                   if        *in99 = *on
027832050721     c                   move      msg(1)        msgout
027833050721     C                   exsr      writexldet2
027834050721     C                   ADD       PAY82         ERRAMT
027835050721     C                   ADD       1             ERRCNT
027836050721     C                   eval      error = 'Y'
027837050721     C                   leavesr
027838050721     c                   end
027843050422     c                   move      bkssn         wkssn
027844080407
027845080407      * else - if Alt Id used, validate it (CB99999999)
027846080407     c                   else
027847080407     c                   movel     bkacct        aid
027848080407     c                   move      'GBS '        atype
027849080407     c     altkey        chain     memaltl1
027850080407     c                   if        not %found(memaltl1)
027851080407     c                   move      msg(1)        msgout
027852080407     c                   exsr      writexldet
027853080407     C                   ADD       PAY82         ERRAMT
027854080407     C                   ADD       1             ERRCNT
027855080407     C                   eval      error = 'Y'
027856080407     C                   leavesr
027857080407     c                   end
027859080407     c                   move      mamemid       wkssn
027860080407
027861080407     c                   end
027862080407
027863080407      * get member
027880080407     c     wkssn         chain     member
027881080407     c                   if        not %found(member)
027882080407     c                   move      msg(1)        msgout
027883080407     c                   exsr      writexldet
027884080407     C                   ADD       PAY82         ERRAMT
027885080407     C                   ADD       1             ERRCNT
027886080407     C                   eval      error = 'Y'
027887080407     C                   leavesr
027888080407     c                   end
027891080407
027892050512      * show member status
027893050422     C                   if        termdt <> 0
027894050422     C                   MOVEL     'CANCELLED '  statout          10
027895050422     C                   ELSE
027896050422     C                   MOVEL     'ACTIVE    '  statout
027897050422     C                   END
027898050511
027899050511      * only post to cobra memebrs
027900050506     C                   MOVE      cexpdt        @DATIN
027901050506     C                   EXSR      #DATym
027902050506     C                   MOVE      @DATOU        cexmdy            8 0
027903050511
027904050511     C                   if        cexpdt = 0
027905050511     c                   move      msg(4)        msgout
027906050511     c                   exsr      writexldet
027907050511     C                   ADD       PAY82         ERRAMT
027908050511     C                   ADD       1             ERRCNT
027909050511     C                   eval      error = 'Y'
027910050511     C                   leavesr
027911050511     C                   END
0279120504220079
027913050422      * validate check #
027914050422     C                   if        bkchk# = 0
027915050422     c                   move      msg(2)        msgout
027916050422     c                   exsr      writexldet
027917050422     C                   ADD       PAY82         ERRAMT           11 2
027918050422     C                   ADD       1             ERRCNT            9 0
027919050422     C                   eval      error = 'Y'
027920050422     C                   leavesr
027921050422     C                   END
027922050422
027923050422      * validate payment
027924050422     C                   if        paymnt <= 0 or paymnt > 5000000
027925050422     c                   move      msg(3)        msgout
027926050422     c                   exsr      writexldet
027927050422     C                   ADD       PAY82         ERRAMT
027928050422     C                   ADD       1             ERRCNT
027929050422     C                   eval      error = 'Y'
027930050422     C                   leavesr
027931050422     C                   END
027932050422
027933050422      * validate receive date
027934050422     C                   if        bkrcvdt <> 0
027935050511     C     *iso          TEST (ED)               bkrcvdt
027936050422     C                   if        %error
027937050422     c                   move      msg(5)        msgout
027938050422     c                   exsr      writexldet
027939050422     C                   ADD       PAY82         ERRAMT
027940050422     C                   ADD       1             ERRCNT
027941050422     C                   eval      error = 'Y'
027942050422     C                   leavesr
027943050422     C                   end
027944050422     C                   end
027945050506
027946050506     C                   if        bkrcvdt = 0
027947050506     c                   move      msg(5)        msgout
027948050506     c                   exsr      writexldet
027949050506     C                   ADD       PAY82         ERRAMT
027950050506     C                   ADD       1             ERRCNT
027951050506     C                   eval      error = 'Y'
027952050506     C                   leavesr
027953050506     C                   end
027954050422
027955050426      * look for dup check #
027956090709     c                   move      wkssn         ssnchar          10
027957050426     C     ssnchar       SETLL     HISTaa
027958050422     C                   dou       %eof(histaa)
027959050426     C     ssnchar       READE     HISTaa
027960050426     c                   if        %eof(histaa) or (h_trcode <> 'BMP' and
027961050505     c                             h_trcode <> 'BPP') or
027962100720     c                             (h_cm$flg <> 'C' and  h_cm$flg <> 'E' and
027963100720     c                              h_cm$flg <> 'D' and  h_cm$flg <> 'T')
027964050426     c                   iter
027965050422     c                   end
027966050426
027967050426     c                   clear                   pos               2 0
027968050506     c                   eval      pos = %scan(%char(bkchk#):h_ck#not)
027969050426      * dup found
027970050426     c                   if        pos <> 0
027971050422     c                   move      msg(7)        msgout
027972050422     c                   exsr      writexldet
027973050426     C                   ADD       PAY82         ERRAMT
027974050426     C                   ADD       1             ERRCNT
027975050426     C                   eval      error = 'Y'
027976050426     c                   leave
027977050426     c                   end
027978050422
027979050422     c                   enddo
027980050422
027981050422     c                   endsr
027982050422
0279830504290192  ********************************************
0279840504290193  * post payment
0279850504290192  ********************************************
0279860504290194
0279870504290195 C     #post         BEGSR
027988050429
0279890504290236  * MOVE ANY CURRENT CREDIT BALANCE TO PREVIOUS
0279900504290237
0279910504220238 C     CURBAL        IFLT      0
0279920504220239 C                   ADD       CURBAL        PRVBAL
0279930504220240 C                   MOVE      *ZEROS        CURBAL
0279940504220241 C                   END
027995050505     C* use member cover through date for payment effdt
027996050422     C* IF PAYMENT IS POSTED BEFORE FIRST INVOICE IS RUN, COVTDT
027997050422     C* WILL BE 0 AND CAUSE EFFDT TO BE 0 SO USE UYEAR/UMONTH/01
027998050422     C*
027999050429     C                   if        cvthdt = 0
028000050429     C                   MOVE      UD8YMD        payeffdt
028001050429     C                   MOVE      01            payeffdt
028002050429     c                   else
028003050429     c                   move      cvthdt        payeffdt
028004050422     C                   END
028005050505
028006050505      * create patyeffdt - 1 month
028007050505     c                   move      payeffdt      isodate
028008050505     c                   subdur    1:*m          isodate
028009050505     c                   move      isodate       payeffminus1      8 0
028010050505
0280110504220245 C* SATISFY PREVIOUS BALANCE
0280120505050246
0280130504220247 C     PRVBAL        IFNE      0
0280140504220248 C*--------------------------------------------------------------------
0280150504220249 C* PROCESS AGAINST DEBIT PREVIOUS BALANCE
0280160504220250 C*--------------------------------------------------------------------
0280170504220251 C     PRVBAL        IFGT      0
0280180506140252 C     paymnt        SUB       PRVBAL        PAYLFT            8 2
028019050505
0280200504220254 C* * * * * * * * * * FULL PAYMENT OF PREVIOUS  BALANCE  * * * * * * * *
0280210504220255 C*
0280220504220256 C     PAYLFT        IFEQ      0
0280230505050258 C                   Z-SUB     paymnt        TRAMT
0280240504220259 C                   MOVE      *ZEROS        paymnt
0280250504220260 C                   MOVE      *ZEROS        PARPAY
0280260504220261 C                   MOVE      *ZEROS        PRVBAL
028027050505     C                   MOVE      payeffminus1  COVTDT
028028050505     C                   MOVE      'BPP'         trcode
028030131003     c                   exsr      #gettime
028031131029     C                   MOVE      systime       hstrtime
028032230425       exsr reversePayment;
028033050505     c                   write     histr
028034050511     C                   move      blank15       CK#NOT
0280350504220265 C                   END
0280360504220266 C*
0280370504220267 C* * * * * * * * * PARTIAL PAYMENT OF PREVIOUS  BALANCE  * * * * * * * *
0280380504220268 C*
0280390504220269 C     PAYLFT        IFLT      0
0280400504220270 C                   Z-SUB     paymnt        TRAMT
0280410504220271 C                   SUB       paymnt        PRVBAL
0280420504220272 C                   ADD       paymnt        PARPAY
0280430504220273 C                   MOVE      *ZEROS        paymnt
028044050505     C                   MOVE      payeffminus1  COVTDT
028045050505     C                   MOVE      'BPP'         trcode
028046131003     c                   exsr      #gettime
028047131029     C                   MOVE      systime       hstrtime
028048230425       exsr reversePayment;
028049050505     c                   write     histr
028050050511     C                   move      blank15       CK#NOT
0280510504220277 C                   END
0280520504220278 C*
0280530504220279 C* * * * * *  FULL PREVIOUS PAYMENT PLUS CURRENT PAYMENT  * * * * * * *
0280540504220280 C*
0280550504220281 C     PAYLFT        IFGT      0
0280560504220282 C                   Z-SUB     PRVBAL        TRAMT
0280570504220283 C                   Z-ADD     PAYLFT        paymnt
0280580504220284 C                   MOVE      *ZEROS        PARPAY
0280590504220285 C                   MOVE      *ZEROS        PRVBAL
028060050505     C                   MOVE      payeffminus1  COVTDT
028061050505     C                   MOVE      'BPP'         trcode
028062131003     c                   exsr      #gettime
028063131029     C                   MOVE      systime       hstrtime
028064230425       exsr reversePayment;
028065050505     c                   write     histr
028066050511     C                   move      blank15       CK#NOT
0280670504220289 C                   END
0280680504220290 C*
0280690504220291 C*--------------------------------------------------------------------
0280700504220292 C* PROCESS AGAINST CREDIT PREVIOUS BALANCE
0280710504220293 C*--------------------------------------------------------------------
0280720504220294 C*
0280730504220295 C                   ELSE
0280740504220296 C     PARPAY        ADD       paymnt        PARPAY
0280750504220297 C     PRVBAL        SUB       paymnt        PRVBAL
0280760504220298 C                   Z-SUB     paymnt        TRAMT
0280770504220299 C                   MOVE      *ZEROS        paymnt
028078050505     C                   MOVE      payeffdt      COVTDT
028079050505     C                   MOVE      'BPP'         trcode
028080131003     c                   exsr      #gettime
028081131029     C                   MOVE      systime       hstrtime
028082230425       exsr reversePayment;
028083050505     c                   write     histr
028084050511     C                   move      blank15       CK#NOT
0280850504220303 C                   END
0280860504220304 C*
0280870504220305 C                   END
0280880504220306 C*--------------------------------------------------------------------
0280890504220307 C*--------------------------------------------------------------------
0280900504220308 C* IF MONEY IS LEFT PAY CURRENT BALANCE
0280910504220309 C*
0280920504220310 C     paymnt        IFNE      0
0280930504220311 C                   Z-SUB     paymnt        TRAMT
0280940504220312 C*--------------------------------------------------------------------
0280950504220313 C* PROCESS AGAINST CURRENT BALANCE
0280960504220314 C*--------------------------------------------------------------------
0280970504220315 C     paymnt        SUB       CURBAL        PAYLFT
0280980504220316 C*
0280990504220317 C* * * * * * * * * *     PAYMENT IN FULL      * * * * * * * * * * * * *
0281000504220318 C*
0281010504220319 C     PAYLFT        IFEQ      0
0281020504220321 C                   Z-ADD     PAYLFT        PARPAY
0281030504220322 C                   MOVE      *ZEROS        CURBAL
028104050429     C                   MOVE      payeffdt      COVTDT
028105050505     C                   MOVE      'BMP'         trcode
028106131003     c                   exsr      #gettime
028107131029     C                   MOVE      systime       hstrtime
028108230425       exsr reversePayment;
028109050505     c                   write     histr
028110050511     C                   move      blank15       CK#NOT
0281110504220326 C                   END
0281120504220327 C*
0281130504220328 C* * * * * * * * * *     PARTIAL PAYMENT      * * * * * * * * * * * * *
0281140504220329 C*
0281150504220330 C     PAYLFT        IFLT      0
0281160504220332 C                   ADD       paymnt        PARPAY
0281170504220333 C                   Z-SUB     PAYLFT        CURBAL
028118050429     C                   MOVE      payeffdt      COVTDT
028119050505     C                   MOVE      'BMP'         trcode
028120131003     c                   exsr      #gettime
028121131029     C                   MOVE      systime       hstrtime
028122230425       exsr reversePayment;
028123050505     c                   write     histr
028124050511     C                   move      blank15       CK#NOT
0281250504220337 C                   END
0281260504220338 C*
0281270504220339 C* * * * * * * * * *     OVER PAYMENT         * * * * * * * * * * * * *
0281280504220340 C*
0281290504220341 C     PAYLFT        IFGT      0
0281300504220343 C                   Z-SUB     PAYLFT        CURBAL
0281310504220344 C                   Z-ADD     PAYLFT        PARPAY
028132050429     C                   MOVE      payeffdt      COVTDT
028133050505     C                   MOVE      'BMP'         trcode
028134131003     c                   exsr      #gettime
028135131029     C                   MOVE      systime       hstrtime
028136230425       exsr reversePayment;
028137050505     c                   write     histr
028138050511     C                   move      blank15       CK#NOT
0281390504220348 C                   END
028140050505
0281410504220349 C                   END
028142050506     C* update member
028143050506     c                   update    membr
0281440505060350
0281450505060355 C                   ENDSR
028146131003
0281471310030103 C***************************************************
0281481310030104 C* get current date and time for output in hist rec
0281491310030105 C***************************************************
0281501310030106 C     #gettime      BEGSR
028151131003     C                   eval      sysdateymd = %date
028152131003     C                   MOVE      sysdateymd    ud8ymd
028153131003     c                   eval      systime = %time
028154230420
0281551310030320 C                   ENDSR
028156230420
0281570505060103 C***************************************************
0281580505060104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0281590505060105 C***************************************************
0281600505060107 C*
0281610505060107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0281620505060107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0281630505060107 C*
0281640505060106 C     #DATYM        BEGSR
028165050506     C                   MOVE      @DATIN        @MD               4 0
028166050506     C                   MOVEL     @DATIN        @Y                4 0
028167050506     C                   MOVEL     @MD           @DATOU            8 0
028168050506     C                   MOVE      @Y            @DATOU
028169050506     C                   MOVE      *ZEROS        @DATIN            8 0
0281700505060120 C                   ENDSR
0281710505060107 C*
028172050512
028173050512      *************************************************************
028174050512      *                                                           *
028175050512      * Write Spreadsheet heading                                 *
028176050512      *                                                           *
028177050512      *************************************************************
028178050512     C     Writexlhead   BEGSR
028179050512
028180050512     c                   clear                   DW221fld
028181050614     C                   Eval      DW221fld  =   '"' + 'STATUS'        + '","' +
028182080407     C                                                 'ID '           + '","' +
028183080407     C                                                 'ACCT/MEMBER #' + '","' +
028184050616     C                                               'CHECK/PAYMENT #' + '","' +
028185050512     C                                                 'CHECK AMOUNT'  + '","' +
028186050512     C                                                 'RECEIVE DATE'  + '","' +
028187050512     C                                                 'INVOICE #'     + '","' +
028188050512     C                                                 'BATCH #'       + '","' +
028189050614     C                                                 'SOURCE'        + '","' +
028190050614     C                                                 '** ERROR **'   + '","' +
028191050614     C                                                'COBRA END DATE' + '",'
028192050512     C                   Write     DW221xr
028193050512
0281940505120320 C                   ENDSR
0583000505060313
0583010505060164  *************************************************************
0583020505060164  *                                                           *
0583030505060164  * Write Spreadsheet Detail                                  *
0583040505060164  *                                                           *
0583050505060164  *************************************************************
058306050214     C     Writexldet    BEGSR
058307050214
058308050419     c                   clear                   DW221fld
058354050419     C                   Eval      DW221fld  =   '"' +
058355050506     C                             statout                             + '","' +
058359080407     C                             bkacct                              + '","' +
058360080407     C                             %trim(%editw(wkssn:'0   -  -    ')) + '","' +
058361050506     C                             %trim(%editc(bkchk#:'3'))           + '","' +
058362050506     C                             %Trim(%Editc(pay82:'K'))            + '","' +
058363050506     C                             %trim(%editw(rcvmdy:'  /  /    '))  + '","' +
058364050506     C                             %Trim(%Editc(bkinv:'Z'))            + '","' +
058365050506     C                             %char(bkbatch)                      + '","' +
058366050512     C                             bksource                            + '","' +
058367050614     C                             %Trim(msgout)                       + '","' +
058368050614     C                             %trim(%editw(cexmdy:'0  /  /    ')) + '",'
058375050506
058376050419     C                   Write     DW221xr
0583770502140320 C                   ENDSR
0583780507210164  *************************************************************
0583800507210164  * Write Spreadsheet Detail 2 - error for invalid acc#       *
0583820507210164  *************************************************************
058383050721     C     Writexldet2   BEGSR
058384050721
058385050721     c                   clear                   DW221fld
058386050721     C                   Eval      DW221fld  =   '"' +
058387050721     C                             statout                             + '","' +
058388050721     C                             bkacct                              + '","' +
058389080407     C                             ' '                                 + '","' +
058390050721     C                             %trim(%editc(bkchk#:'3'))           + '","' +
058391050721     C                             %Trim(%Editc(pay82:'K'))            + '","' +
058392050721     C                             %trim(%editw(rcvmdy:'  /  /    '))  + '","' +
058393050721     C                             %Trim(%Editc(bkinv:'Z'))            + '","' +
058394050721     C                             %char(bkbatch)                      + '","' +
058395050721     C                             bksource                            + '","' +
058396050721     C                             %Trim(msgout)                       + '","' +
058397050721     C                             %trim(%editw(cexmdy:'0  /  /    ')) + '",'
058398050721
058399050721     C                   Write     DW221xr
0584000507210320 C                   ENDSR
058409050506      *************************************************************
058410050506      *                                                           *
058411050506      * Write Spreadsheet Totals                                  *
058412050506      *                                                           *
058413050506      *************************************************************
058414050214     C     Writexllr     BEGSR
058415050214
058416050419     c                   clear                   DW221fld
058417050419     C                   Eval      DW221fld  =   '"' +
058418050221     C                             'TOTAL $$ AMT POSTED: '             + '","' +
058419050221     C                              %Trim(%Editc(amt:'J'))             + '","' +
058420050221     C                             'TOTAL # OF CHECKS: '               + '","' +
058421050221     C                              %Trim(%Editc(cnt:'3'))             + '",'
058429050419     C                   Write     DW221xr
058430050218
058431050419     c                   clear                   DW221fld
058432050419     C                   Eval      DW221fld  =   '"' +
058433050221     C                             'TOTAL $$ AMT ERROR: '              + '","' +
058434050221     C                             %Trim(%Editc(erramt:'J'))           + '","' +
058435050221     C                             'TOTAL # OF ERROR: '                + '","' +
058436050221     C                             %Trim(%Editc(errcnt:'3'))           + '",'
058437050419     C                   Write     DW221xr
058439050218
058440050419     c                   clear                   DW221fld
058441050419     C                   Eval      DW221fld  =   '"' +
058442050221     C                             'FINAL $$ AMT: '                    + '","' +
058443050221     C                             %Trim(%Editc(lramt:'J'))            + '","' +
058444050221     C                             'FINAL # OF CHECKS: '               + '","' +
058445050221     C                             %Trim(%Editc(lrcnt:'3'))            + '",'
058446050419     C                   Write     DW221xr
058455050218
0584560502140320 C                   ENDSR
0584570502140103 C***************************************************
0584580502140104 C* FIRST CYCLE                                     *
0584590502140105 C***************************************************
0584600502140106 C     *INZSR        BEGSR
058461230425
058463050214     C                   Exsr      Writexlhead
058464050420     C                   TIME                    HTIME             6 0
058465050505     C                   MOVE      *MONTH        DMM
058466050505     C                   MOVE      *day          DDD
058467050505     C                   MOVE      *YEAR         DYY
058468080407
058469080407     c     altkey        klist
058470080407     c                   kfld                    aid
058471080407     c                   kfld                    atype
058472230420
058474230518       //if %parms = 1;
058475230518       // reverse = 'Y';
058476230518       //endif;
058478230420
058479050214     C                   endsr
058480230420
058481230420      //=======================================================================
058482230420      // is this a reverse payment?
058483230420      //=======================================================================
058484230420
058485230420       begsr reversePayment;
058486230420
058487230420        if reverse = 'Y';
058488230626         trcode = 'BMP';
058489230425          hoper = userName;
058490230420          note2 = ' ';
058491230420         note2 = 'Reversed Payment';
058492230420        endif;
058493230420
058494230420       endsr;
058495230420
058496230420      //=======================================================================
058497230420
058498230420
058499230420
069600050506** error msg table
069700050722  ** INVALID ACCT/MEMBER #  **
069800950810  ** CHECK # IS INVALID     **
069900950810  ** CHECK AMOUNT INVALID   **
070000050511  ** MEMBER IS NOT COBRA    **
070100950810  ** RECEIVED DATE INVALID  **
070200950810  ** INVOICE # IS INVALID   **
070300950906  ** POSSIBLE DUP CHECK #   **
