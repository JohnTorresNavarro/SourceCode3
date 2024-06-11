000100040924      *  ***************************************************************
000200040224      * FM104_2R - SALESMAN MASTER MAINTENANCE - ADDITIONAL INFO
000300040224      *   WRITTEN by Kimberly Johnson 4/2004
000400010412      *
000500040924      *  Description: display additional maintanence screen
000600010417
000700040924      *  FIELDS BEGINNING WITH W_ ARE DISPLAY FIELDS
000800040924      *  FIELDS beginning with S2 are SMAN2 fields
000900040924   X***X
001000040924   X***X 09/24/04 SSK Cleaned up code and made Grouper primary key.
001100110418   X***X 04/18/2011 SSK ADDED MARKETING DIARY NOTES
001200110801   X***X 08/01/2011 SSK REMOVE BROKER REP [OLD WAY] PER KT
001300040924   X***X
001400040924      *  ***************************************************************
001500040928     FFM104_2D  CF   E             WORKSTN PREFIX(W_) INFDS(WSDS)
001600040924     FSMAN2L    UF A E           K DISK
001700040224     FAACODE    IF   E           K DISK
001800040224     FBRKREP    IF   E           K DISK
001900010416     FSTATECD   IF   E           K DISK
002000040308     FVENDACCTL1IF   E           K DISK
002100041004     fsm2hist0  o  a e             disk
002200040927   X***X
002300040928     d @step           s              5a
002400040928     d valid_s1        s               n
002500040928     d valid_s2        s               n
002600040928     d valid_s3        s               n
002700040928     d no              s               n   INZ(*OFF)
002800040928     d yes             s               n   INZ(*ON)
002900040928    ***
003000040928     D WSDS            DS
003100040928     D  FKEY                 369    369A
003200040928    ***
003300040928     D  F1             C                   CONST(X'31')
003400040928     D  F2             C                   CONST(X'32')
003500040928     D  F3             C                   CONST(X'33')
003600040928     D  F4             C                   CONST(X'34')
003700040928     D  F5             C                   CONST(X'35')
003800040928     D  F6             C                   CONST(X'36')
003900040928     D  F7             C                   CONST(X'37')
004000040928     D  F8             C                   CONST(X'38')
004100040928     D  F9             C                   CONST(X'39')
004200040928     D  F10            C                   CONST(X'3A')
004300040928     D  F11            C                   CONST(X'3B')
004400040928     D  F12            C                   CONST(X'3C')
004500040928     D  F13            C                   CONST(X'B1')
004600040928     D  F14            C                   CONST(X'B2')
004700040928     D  F15            C                   CONST(X'B3')
004800040928     D  F16            C                   CONST(X'B4')
004900040928     D  F17            C                   CONST(X'B5')
005000040928     D  F18            C                   CONST(X'B6')
005100040928     D  F19            C                   CONST(X'B7')
005200040928     D  F20            C                   CONST(X'B8')
005300040928     D  F21            C                   CONST(X'B9')
005400040928     D  F22            C                   CONST(X'BA')
005500040928     D  F23            C                   CONST(X'BB')
005600040928     D  F24            C                   CONST(X'BC')
005700040928    ***
005800010412     D ISO_DATE        S               D   DATFMT(*ISO)                         DATE VARIABLE *ISO
005900010412     D USA_DATE        S               D   DATFMT(*USA)                         DATE VARIABLE *USA
006000040928     d                 ds
006100040928     d parms@in                1     51a
006200040928     d  @grpr                  1      5a
006300040928     d  SCODE                  6      8a
006400040928     d  SNAME                  9     43a
006500040928     d  STERM                 44     51a
006600040928    ***
006700040928    *D                 DS
006800040928    *D TIMEDATE_DS                   12  0 INZ(*ZEROS)
006900040928    *D  TIME_DS                       6  0 OVERLAY(TIMEDATE_DS)
007000040928    *D  DATE_DS                       6  0 OVERLAY(TIMEDATE_DS:7)
007100041004    ***
007200041004     D @TIMESTAMP      DS
007300041004     D  #TSCYMD                1      8S 0
007400041004     D  #TSTIME                9     14S 0
007500041004     D  @TSJOB                15     24
007600041004     D  @TSUSER               25     34
007700041004     D  #TSNBR                35     40S 0
007800041004     D @TS40           S             40A
007900041004     D DS@SM         E DS                  EXTNAME(SMAN2)
008000040928    ***
008100010417     D                 DS
008200040928     D COMPANY                       50a
008300040928     D W_CONAME                1     40a
008400040924   X***X
008500040928    ***
008600040928     c                   dou       @step = 'LEAVE'
008700040928     c     @step         caseq     'PREP1'       $prep1
008800040928     c     @step         caseq     'STEP1'       $step1
008900040928     c     @step         caseq     'STEP2'       $step2
009000040928     c     @step         caseq     'STEP3'       $step3
009100040928     c                   endcs
009200040928     c                   enddo
009300040924    ***
009400040924     C                   EVAL      *INLR = *ON
009500040924   S***S
009600040924     C     *INZSR        BEGSR                                                  INITIAL SETUP
009700040928    ***
009800040928     c                   clear                   scrn1
009900040928     c                   clear                   scrn2
010000040928     c                   clear                   scrn3
010100040928    ***
010200040924     C     *ENTRY        PLIST
010300040928     C                   PARM                    parmz            51
010400040928     C                   movel     parmz         parms@in
010500040924    ***
010600040927    *C     SMAN2KEY      KLIST
010700040927    *C                   KFLD                    @grpr
010800040924    ***
010900040924     C     LUMKEY        KLIST
011000040924     C                   KFLD                    W_LUMID5
011100040924     C                   KFLD                    W_LUMID4
011200040924    ***
011300040924     C     *DTAARA       DEFINE                  COMPANY
011400040924     C                   IN        COMPANY
011500040928    ***
011600040928     C                   EVAL      @step = 'PREP1'
011700040927    ***
011800040924     C                   TIME                    TIMEDATE_DS
011900040924     C     *MDY          MOVE      DATE_DS       USA_DATE
012000040924     C     *MDY          MOVE      DATE_DS       ISO_DATE
012100040927    ***
012200040924     C                   ENDSR
012300040924   S***S
012400040928     C     $prep1        BEGSR
012500040924    ***
012600040928     C                   MOVE      @grpr         W_grpcd
012700040928     C                   EVAL      W_ISCODE = SCODE
012800040928     C                   EVAL      W_ISNAME = SNAME
012900040928    ***
013000040928     c     @grpr         chain     sman2r
013100040928     c                   if        not %found(SMAN2L)
013200040928     c                   exfmt     NO_SMAN2
013300040928     C                   EVAL      @step = 'LEAVE'
013400040928     C                   LEAVESR
013500040928     c                   endif
013600040928    ***
013700040928     c                   exsr      $fmt_scn1
013800040928    ***
013900040928     C                   EVAL      @step = 'STEP1'
014000040928    ***
014100040928     C                   ENDSR
014200040928   S***S
014300040928     c     $fmt_scn1     begsr
014400040928    ***
014500040928     C                   EVAL      W_BRPHXT  = SBRPHXT
014600040928     C                   EVAL      W_BRADPH = SBRADPH
014700040928     C                   EVAL      W_BRFAX = SBRFAX
014800040928     C                   EVAL      W_ASNAM = SASNAM
014900040928     C                   EVAL      W_ASPHN = SASPHN
015000040928     C                   EVAL      W_ASFAX = SASFAX
015100040928     C                   EVAL      W_ASEML = SASEML
015200040928    ***
015300040928     C                   EVAL      W_BRBADD1 = SBRBADD1
015400040928     C                   EVAL      W_BRBADD2 = SBRBADD2
015500040928     C                   EVAL      W_BRBCTY = SBRBCTY
015600040928     C                   EVAL      W_BRBST = SBRBST
015700040928     C                   EVAL      W_BRBZIP5 = SBRBZIP5
015800040928     C                   EVAL      W_BRBZIP4 = SBRBZIP4
015900040928    ***
016000040928     C                   EVAL      W_BRHADD1 = SBRHADD1
016100040928     C                   EVAL      W_BRHADD2 = SBRHADD2
016200040928     C                   EVAL      W_BRHCTY = SBRHCTY
016300040928     C                   EVAL      W_BRHST = SBRHST
016400040928     C                   EVAL      W_BRHZIP5 = SBRHZIP5
016500040928     C                   EVAL      W_BRHZIP4 = SBRHZIP4
016600040928    ***
016700040928     C                   EVAL      W_BREML = SBREML
016800040928     C                   EVAL      W_BRNOTE  = SBRNOTE
016900040928     C                   EVAL      W_BRWEB  = SBRWEB
017000040928    ***
017100040928    3C                   IF        SDOB <> *ZEROS
017200040928     C                   MOVE      SDOB          ISO_DATE
017300040928     C                   MOVE      ISO_DATE      USA_DATE
017400040928     C                   MOVE      USA_DATE      W_DOB
017500040928    3C                   ENDIF
017600040928    ***
017700040928     C                   EVAL      W_LUMID5 = SLUMID5
017800040928     C                   EVAL      W_LUMID4 = SLUMID4
017900040928     C                   EVAL      W_GBSAG = SGBSAG
018000040928     C                   EVAL      W_GBSAC = SGBSAC
018100040928     C                   EVAL      W_AAID = SAAID
018200040928     C                   EVAL      W_BRREP = SBRREP
018300040928     C                   EVAL      W_NOEML = SNOEML
018400040928     C                   EVAL      W_NOFAX = SNOFAX
018500040928    ***
018600040928     C                   EVAL      W_WEBID = SWEBID
018700040928     C                   EVAL      W_ASNAM = SASNAM
018800040928     C                   EVAL      W_ASPHN = SASPHN
018900040928     C                   EVAL      W_ASFAX = SASFAX
019000040928     C                   EVAL      W_ASEML = SASEML
019100040928     C                   EVAL      W_PRTCT = SPRTCT
019200040928     C                   EVAL      W_GRPCD = SGRPCD
019300040928    ***
019400040928     c                   eval      w_safax = safax
019500040928     c                   eval      w_saemail = saemail
019600041004    ***
019700041004     c                   move      @grpr         hfgrp
019800041004     C                   MOVEL     DS@SM         HBEFORE
019900040928    ***
020000040928     c                   endsr
020100040928   S***S
020200040928     C     $step1        BEGSR
020300040928    ***
020400010412     C                   EXFMT     SCRN1
020500040928     c                   move      *blanks       w_error_msg
020600040924    ***
020700040928     C                   IF        fkey = F3
020800040928     C                   EVAL      @step = 'LEAVE'
020900010103     C                   LEAVESR
021000010412     C                   END
021100110418    ***
021200110418     C                   IF        fkey = F2
021300110418     C                   EVAL      @NTEPARM = '101' + SGRPCD
021400110418    ?C                   Call      'MDC010  '
021500110418     C                   PARM                    @NTEPARM         11
021600110418     C                   EVAL      @step = 'LEAVE'
021700110418     C                   LEAVESR
021800110418     C                   END
021900040928    ***
022000040927      *  ALTERNATE CONTACT SCREEN                                           *****
022100040928     C                   IF        fkey = F8
022200040928     C                   CALL      'WRKBAC2CL'
022300040928     C                   PARM                    @grpr
022400040312     C                   LEAVESR
022500040928     C                   endif
022600040928    ***
022700040928     c                   exsr      $validate1
022800040928    ***
022900040928     c                   if        valid_s1 = yes
023000040929     c                   exsr      $fmt_rec
023100040928     c                   update    sman2r
023200040928     c                   exsr      $prep1
023300040928     C                   EVAL      @step = 'STEP2'
023400040928     c                   endif
023500040928    ***
023600040928     C                   ENDSR
023700040928   S***S
023800040928     C     $validate1    BEGSR
023900040928    ***
024000040928     c                   eval      valid_s1 = no
024100040928     c                   exsr      $rst_ndc
024200040928    ***
024300040928      * DOB
024400040928     C                   IF        W_DOB <> *ZEROS
024500040928     C     *USA          TEST(DE)                W_DOB
024600040928    1C                   IF        %ERROR
024700040928     C                   EVAL      W_ERROR_MSG = 'INVALID DATE'
024800040928     C                   EVAL      *in63 = *ON
024900040928     C                   LEAVESR
025000040928     C                   endif
025100040928     C                   ENDIF
025200040928    ***
025300040928      * LOCATION ADDRESS (BROKER)
025400040928     C                   IF        W_BRBADD1 <> *BLANKS or W_BRBCTY <> *BLANKS
025500040928    1C                             or W_BRBST <> *BLANKS or W_BRBZIP5 <> 0
025600040928    * *
025700040928    1C                   IF        W_BRBADD1 = *BLANKS
025800040928     C                   EVAL      W_ERROR_MSG = 'MUST ENTER ADDRESS'
025900040928     C                   EVAL      *in69 = *on
026000040928     C                   LEAVESR
026100040928     C                   ENDIF
026200040928    * *
026300040928    1C                   IF        W_BRBCTY = *BLANKS
026400040928     C                   EVAL      W_ERROR_MSG = 'MUST ENTER CITY   '
026500040928     C                   EVAL      *in65 = *on
026600040928     C                   LEAVESR
026700040928     C                   ENDIF
026800040928    * *
026900040928    1C                   IF        W_BRBST = *BLANKS
027000040928     C                   EVAL      W_ERROR_MSG = 'MUST ENTER STATE  '
027100040928     C                   EVAL      *in50 = *on
027200040928     C                   LEAVESR
027300040928     C                   ENDIF
027400040928    * *
027500040928    1C                   IF        W_BRBZIP5  = *ZEROS
027600040928     C                   EVAL      W_ERROR_MSG = 'MUST ENTER ZIP CODE'
027700040928     C                   EVAL      *in67 = *on
027800040928     C                   LEAVESR
027900040928     C                   ENDIF
028000040928    * *
028100040928     C                   ENDIF
028200040928    ***
028300040928      * HOME ADDRESS (BROKER)
028400040928     C                   IF        W_BRHADD1 <> *BLANKS or W_BRHCTY <> *BLANKS
028500040928    1C                             or W_BRHST <> *BLANKS or W_BRHZIP5 <> *ZEROS
028600040928    * *
028700040928    1C                   IF        W_BRHADD1 = *BLANKS
028800040928     C                   EVAL      W_ERROR_MSG = 'MUST ENTER ADDRESS'
028900040928     C                   EVAL      *in79 = *ON
029000040928     C                   LEAVESR
029100040928     C                   END
029200040928    * *
029300040928    1C                   IF        W_BRHCTY = *BLANKS
029400040928     C                   EVAL      W_ERROR_MSG = 'MUST ENTER CITY'
029500040928     C                   EVAL      *in75 = *on
029600040928     C                   LEAVESR
029700040928     C                   END
029800040928    * *
029900040928    1C                   IF        W_BRHST = *BLANKS
030000040928     C                   EVAL      W_ERROR_MSG = 'MUST ENTER STATE'
030100040928     C                   EVAL      *in40 = *on
030200040928     C                   LEAVESR
030300040928     C                   END
030400040928    * *
030500040928    1C                   IF        W_BRHZIP5  = *ZEROS
030600040928     C                   EVAL      W_ERROR_MSG = 'MUST ENTER ZIP    '
030700040928     C                   EVAL      *in77 = *ON
030800040928     C                   LEAVESR
030900040928     C                   END
031000040928    * *
031100040928     C                   endif
031200040928    ***
031300040928     C                   IF        W_BRBST <> *BLANKS
031400040928    * *
031500040928     C     W_BRBST       chain     STATEF
031600040928     C                   IF        NOT %found(STATECD)
031700040928     C                   EVAL      W_ERROR_MSG = 'INVALID STATE'
031800040928     C                   EVAL      *in66 = *on
031900040928     C                   LEAVESR
032000040928     C                   END
032100040928    * *
032200040928     C                   ENDIF
032300040928    ***
032400040928     C                   IF        W_BRHST <> *BLANKS
032500040928    * *
032600040928     C     W_BRHST       chain     STATEF
032700040928     C                   IF        NOT %found(STATECD)
032800040928     C                   EVAL      W_ERROR_MSG = 'INVALID STATE'
032900040928     C                   EVAL      *in76 = *on
033000040928     C                   LEAVESR
033100040928     C                   END
033200040928    * *
033300040928     C                   ENDIF
033400040928    ***
033500040928     c                   eval      valid_s1 = yes
033600040928    ***
033700040305     C                   ENDSR
033800040924   S***S
033900040928     C     $rst_ndc      BEGSR
034000040924    ***
034100040928     c     1             do        45            n                 3 0
034200040928     c     n             add       39            i                 2 0
034300040928     c                   eval      *in(i) = *OFF
034400040928     c                   enddo
034500040928    ***
034600040928     C                   ENDSR
034700040928   S***S
034800040928     c     $fmt_rec      begsr
034900040928    ***
035000040928     C                   EVAL      SBRPHXT   = W_BRPHXT
035100040928     C                   EVAL      SBRADPH   = W_BRADPH
035200040928     C                   EVAL      SBRFAX    = W_BRFAX
035300040928     C                   EVAL      SASNAM    = W_ASNAM
035400040928     C                   EVAL      SASPHN    = W_ASPHN
035500040928     C                   EVAL      SASFAX    = W_ASFAX
035600040928     C                   EVAL      SASEML    = W_ASEML
035700040928    ***
035800040928     C                   EVAL      SBRBADD1  = W_BRBADD1
035900040928     C                   EVAL      SBRBADD2  = W_BRBADD2
036000040928     C                   EVAL      SBRBCTY   = W_BRBCTY
036100040928     C                   EVAL      SBRBST    = W_BRBST
036200040928     C                   EVAL      SBRBZIP5  = W_BRBZIP5
036300040928     C                   EVAL      SBRBZIP4  = W_BRBZIP4
036400040928    ***
036500040928     C                   EVAL      SBRHADD1  = W_BRHADD1
036600040928     C                   EVAL      SBRHADD2  = W_BRHADD2
036700040928     C                   EVAL      SBRHCTY   = W_BRHCTY
036800040928     C                   EVAL      SBRHST    = W_BRHST
036900040928     C                   EVAL      SBRHZIP5  = W_BRHZIP5
037000040928     C                   EVAL      SBRHZIP4  = W_BRHZIP4
037100040928    ***
037200040928     C                   EVAL      SBREML    = W_BREML
037300040928     C                   EVAL      SBRNOTE   = W_BRNOTE
037400040928     C                   EVAL      SBRWEB    = W_BRWEB
037500040928    ***
037600040928    3C                   IF        w_DOB <> *ZEROS
037700040928     c                   move      w_dob         usa_date
037800040928     C                   MOVE      usa_DATE      iso_DATE
037900040928     C                   MOVE      iso_DATE      sDOB
038000040928    3C                   ENDIF
038100040928    ***
038200040928     C                   EVAL      SLUMID5   = W_LUMID5
038300040928     C                   EVAL      SLUMID4   = W_LUMID4
038400040928     C                   EVAL      SGBSAG    = W_GBSAG
038500040928     C                   EVAL      SGBSAC    = W_GBSAC
038600040928     C                   EVAL      SAAID     = W_AAID
038700040928     C                   EVAL      SBRREP    = W_BRREP
038800040928     C                   EVAL      SNOEML    = W_NOEML
038900040928     C                   EVAL      SNOFAX    = W_NOFAX
039000040928    ***
039100040928     C                   EVAL      SWEBID    = W_WEBID
039200040928     C                   EVAL      SASNAM    = W_ASNAM
039300040928     C                   EVAL      SASPHN    = W_ASPHN
039400040928     C                   EVAL      SASFAX    = W_ASFAX
039500040928     C                   EVAL      SASEML    = W_ASEML
039600040928     C                   EVAL      SPRTCT    = W_PRTCT
039700040928    ***
039800040928     C                   EVAL      safax     = w_safax
039900040928     C                   EVAL      saemail   = w_saemail
040000040928    ***
040100041004     C                   MOVEL     DS@SM         Hafter
040200041004    ***
040300041004     C                   CLEAR                   @TIMESTAMP
040400041004     C                   MOVE      *BLANKS       @TS40
040500041004    ***
040600041004     C                   CALL      'TIMESTMP'
040700041004     C                   PARM                    @TS40
040800041004    ***
040900041004     C                   MOVEL     @TS40         @TIMESTAMP
041000041004     C                   MOVEL     @TSUSER       HUSERID
041100041004     C                   MOVE      #TSCYMD       HDATE
041200041004     C                   MOVE      #TSTIME       HTIME
041300041004     C                   MOVEL     @TSJOB        HJOB
041400041004     C                   MOVE      #TSNBR        HNUMBER
041500041004    ***
041600041004     c                   if        hbefore <> hafter
041700041004     c                   write     rsm2hist
041800041004     c                   endif
041900041004    ***
042000040928     c                   endsr
042100040928   S***S
042200040928     C     $step2        BEGSR
042300040928    ***
042400040928     C                   EXFMT     SCRN3
042500040928     c                   move      *blanks       w_error_msg
042600040928    ***
042700040928     C                   IF        fkey = F1
042800040928     C                   EVAL      @step = 'STEP1'
042900040928     C                   LEAVESR
043000040928     C                   END
043100040928    ***
043200040928     C                   IF        fkey = F3
043300040928     C                   EVAL      @step = 'LEAVE'
043400040928     C                   LEAVESR
043500040928     C                   END
043600040928    ***
043700040928     C                   IF        fkey = F4
043800040928     C                   exsr      $f4
043900040928     C                   LEAVESR
044000040928     C                   END
044100040928    ***
044200040928      *  ALTERNATE CONTACT SCREEN                                           *****
044300040928     C                   IF        fkey = F8
044400040928     C                   CALL      'WRKBAC2CL'
044500040928     C                   PARM                    @grpr
044600040928     C                   LEAVESR
044700040928     C                   endif
044800040928    ***
044900040928     c                   exsr      $validate3
045000040928    ***
045100040928     c                   if        valid_s3 = yes
045200040929     c                   exsr      $fmt_rec
045300040928     c                   update    sman2r
045400040928     c                   exsr      $prep1
045500040928     C                   EVAL      @step = 'STEP3'
045600040928     c                   endif
045700040924    ***
045800010606     C                   ENDSR
045900040924   S***S
046000040928     C     $f4           BEGSR
046100040924    ***
046200040928     C                   select
046300040928     C*
046400040928     C                   when      w_Wsfld = 'AAID' or w_wsfld = 'W_AAID'
046500040928     c                   eval      @3 = *blanks
046600040928    ?C                   CALL      'SLCAAD'                                     CALL SELECT PROGRAM
046700040928    ?C                   PARM                    @3                3            REQUEST
046800040928    ?C                   if        @3 <> *blanks                                RETURN CODE
046900040928    ?C                   eval      w_aaid = @3                                  PROGRAM
047000040928    ?C                   endif                                                  RECORD DS
047100040928     C*
047200040928     C                   when      W_wsfld = 'BRREP' or w_wsfld = 'W_BRREP'
047300040928    ?C                   CALL      'SLCBRL'                                     CALL SELECT PROGRAM
047400040928    ?C                   PARM                    WWRQS                          REQUEST
047500040928    ?C                   PARM                    WWRTN                          RETURN CODE
047600040928    ?C                   PARM                    WUPGM                          PROGRAM
047700040928    ?C                   PARM                    @43              43            RECORD DS
047800040928     C                   IF        WWRTN = *BLANKS
047900040928     C                   movel     @43           @5                5
048000040928     C                   move      @5            w_brrep
048100040928    ?C                   endif                                                  RECORD DS
048200040928     C*
048300040928     C                   when      w_wsfld = 'SAEMAIL' or w_wsfld = 'W_SAEMAIL'
048400040928     c                   movel(p)  @grpr         wwrtn
048500040928    ?C                   CALL      'SLCBAC'                                     CALL SELECT PROGRAM
048600040928    ?C                   PARM                    WWRQS             8            REQUEST
048700040928    ?C                   PARM                    WWRTN             8            RETURN CODE
048800040928    ?C                   PARM                    WUPGM            10            PROGRAM
048900040928    ?C                   PARM                    @118            118            RECORD DS
049000040928     C                   IF        WWRTN = *BLANKS
049100040928     C                   EVAL      @5 = %subst(@118:6:5)
049200040928     C                   move      @5            w_saemail
049300040928     C                   ENDIF
049400040928     C*
049500040928     C                   when      w_wsfld = 'SAFAX' or w_wsfld = 'W_SAFAX'
049600040928     c                   movel(p)  @grpr         wwrtn
049700040928    ?C                   CALL      'SLCBAC'                                     CALL SELECT PROGRAM
049800040928    ?C                   PARM                    WWRQS             8            REQUEST
049900040928    ?C                   PARM                    WWRTN             8            RETURN CODE
050000040928    ?C                   PARM                    WUPGM            10            PROGRAM
050100040928    ?C                   PARM                    @118            118            RECORD DS
050200040928     C                   IF        WWRTN = *BLANKS
050300040928     C                   EVAL      @5 = %subst(@118:6:5)
050400040928     C                   move      @5            w_safax
050500040928     C                   ENDIF
050600040928     C*
050700040928     c                   endsl
050800040928    ***
050900040928     C                   ENDSR
051000040928   S***S
051100040928     C     $validate3    BEGSR
051200040928    ***
051300040928     c                   eval      valid_s3 = no
051400040928     c                   exsr      $rst_ndc
051500040924    ***
051600040924    1C                   IF        W_GBSAG <> 'Y' AND W_GBSAG <> 'N'
051700040305     C                   EVAL      W_ERROR_MSG = 'MUST ENTER Y OR N'
051800040928     C                   EVAL      *in59 = *ON
051900040305     C                   LEAVESR
052000040305     C                   END
052100040924    ***
052200040924    1C                   IF        W_GBSAC <> 'Y' AND W_GBSAC <> 'N'
052300040305     C                   EVAL      W_ERROR_MSG = 'MUST ENTER Y OR N'
052400040928     C                   EVAL      *in60 = *ON
052500040305     C                   LEAVESR
052600040305     C                   END
052700040924    ***
052800040924    1C                   IF        W_NOEML <> 'Y' AND W_NOEML <> 'N'
052900040305     C                   EVAL      W_ERROR_MSG = 'MUST ENTER Y OR N'
053000040928     C                   EVAL      *in61 = *ON
053100040305     C                   LEAVESR
053200040305     C                   END
053300040924    ***
053400040924    1C                   IF        W_NOFAX <> 'Y' AND W_NOFAX <> 'N'
053500040305     C                   EVAL      W_ERROR_MSG = 'MUST ENTER Y OR N'
053600040928     C                   EVAL      *in62 = *ON
053700040305     C                   LEAVESR
053800040305     C                   END
053900040924    ***
054000040924      *  VALIDATE DATA IN LUMID
054100040402     C                   IF        W_LUMID5 <> *BLANKS AND
054200040402     C                             W_LUMID4 <> *BLANKS
054300040928    * *
054400040308     C     LUMKEY        CHAIN     VENDACCTR
054500040308     C                   IF        NOT %FOUND(VENDACCTL1)
054600040308     C                   EVAL      W_ERROR_MSG = 'INVALID VENDOR ID'
054700040928     C                   EVAL      *in51 = *on
054800040308     C                   LEAVESR
054900040308     C                   ENDIF
055000040924    * *
055100040402     C                   ENDIF
055200040924    ***
055300040924      *  VALIDATE DATA IN AAID
055400040402     C                   IF        W_AAID <> *BLANKS
055500040928    * *
055600040308     C     W_AAID        CHAIN     AACODR
055700040308     C                   IF        NOT %FOUND(AACODE)
055800040308     C                   EVAL      W_ERROR_MSG = 'INVALID AA CODE'
055900040928     C                   EVAL      *in53 = *ON
056000040308     C                   LEAVESR
056100040308     C                   ENDIF
056200040928    * *
056300040402     C                   ENDIF
056400040924    ***
056500080604     c                   If        w_brrep <> 0
056600040503     C     W_BRREP       CHAIN     BRKREPR
056700040503     C                   IF        NOT %FOUND(BRKREP)
056800040503     C                   EVAL      W_ERROR_MSG = 'INVALID BROKER REP CODE'
056900040928     C                   EVAL      *in54 = *ON
057000040503     C                   LEAVESR
057100040503     C                   ENDIF
057200080604     c                   EndIf
057300040924    ***
057400040928     c                   eval      valid_s3 = yes
057500040928    ***
057600010606     C                   ENDSR
057700040924   S***S
057800040928     C     $step3        BEGSR
057900040928    ***
058000040928     C                   EXFMT     SCRN2
058100040928     c                   move      *blanks       w_error_msg
058200040928    ***
058300040928     C                   IF        fkey = F1
058400040928     C                   EVAL      @step = 'STEP2'
058500040928     C                   LEAVESR
058600040928     C                   END
058700040928    ***
058800040928     C                   IF        fkey = F3
058900040928     C                   EVAL      @step = 'LEAVE'
059000040928     C                   LEAVESR
059100040928     C                   END
059200040928    ***
059300040928     c                   exsr      $validate2
059400040928    ***
059500040928     c                   if        valid_s2 = yes
059600040929     c                   exsr      $fmt_rec
059700040928     c                   update    sman2r
059800040929     C                   EVAL      @step = 'PREP1'
059900040928     c                   endif
060000040928    ***
060100040928     C                   ENDSR
060200040928   S***S
060300040928     C     $validate2    BEGSR
060400040924    ***
060500040928     c                   eval      valid_s2 = no
060600040928     c                   exsr      $rst_ndc
060700040928    ***
060800040308     C                   IF        W_ASNAM = *BLANKS AND
060900040310     C                             (W_ASPHN <> *ZEROS OR
061000040310     C                             W_ASFAX <> *ZEROS OR
061100040310     C                             W_ASEML <> *BLANKS)
061200040308     C                   EVAL      W_ERROR_MSG = 'MUST ENTER NAME'
061300040928     C                   EVAL      *in55 = *ON
061400010607     C                   LEAVESR
061500010607     C                   END
061600040924    ***
061700040928     c                   eval      valid_s2 = yes
061800040928    ***
061900010606     C                   ENDSR
062000040924   S***S
