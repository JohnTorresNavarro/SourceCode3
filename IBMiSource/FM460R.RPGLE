000100030109     F*-------------------------------------------------------------------------
000200030109     F* FM460     GBS/IO SOFTWARE 2003
000300030109     F*           FM46* SUPER AGENCY ENCHANCMENT PROJECT
000400030109     F*           WRITTEN BY - S.S.K.
000500030109     F*           DATE - 01/03
000600030109     F*  DESCRIPTION - PROMPT
000700030109     F*  INDICATOR USAGE:
000800030109     F*    01 = EXIT FROM INITIAL SCREEN
000900030109     F*    25 = SFLDSP
001000030109     F*    26 = SFL DSP CTL
001100030109     F*    27 = SFL CLR
001200030109     F*
001300030109     F*-------------------------------------------------------------------------
001400030109     ** MODIFICATION HISTORY                                              **
001500030109     ** ###  UUU  MMDDCCYY  X---->                                        **
001600030109     ** 000  SSK  01092003  ORIGINAL SOURCE                               **
001700090106     ** 001  SSK  01052003  ADD INACTIVITY PROGRAMMING PIECES             **
001800110418     ** 002  SSK  04182011  ADD MARKETING DIARY NOTES                     **
001900110418     **                                                                   **
002000110418     **                                                                   **
002100110418     **                                                                   **
002200030109     **                                                                   **
002300030109     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002400030109     FFM460D    CF   E             WORKSTN INFDS(WSDS)
002500030109     FSUPRAGCY  UF A E           K DISK
002600030519     FSUPHIST0  O  A E             DISK
002700090106     FIRMMSTP   IF   E           K DISK
002800090109     FMKTSTSP   UF A E           K DISK
002900030109   X***X
003000030109     D WSDS            DS
003100030109     D  FKEY                 369    369A
003200030109    ***
003300030109     D  F1             C                   CONST(X'31')
003400030109     D  F2             C                   CONST(X'32')
003500030109     D  F3             C                   CONST(X'33')
003600030109     D  F4             C                   CONST(X'34')
003700030109     D  F5             C                   CONST(X'35')
003800030109     D  F6             C                   CONST(X'36')
003900030109     D  F7             C                   CONST(X'37')
004000030109     D  F8             C                   CONST(X'38')
004100030109     D  F9             C                   CONST(X'39')
004200030109     D  F10            C                   CONST(X'3A')
004300030109     D  F11            C                   CONST(X'3B')
004400030109     D  F12            C                   CONST(X'3C')
004500030109     D  F13            C                   CONST(X'B1')
004600030109     D  F14            C                   CONST(X'B2')
004700030109     D  F15            C                   CONST(X'B3')
004800030109     D  F16            C                   CONST(X'B4')
004900030109     D  F17            C                   CONST(X'B5')
005000030109     D  F18            C                   CONST(X'B6')
005100030109     D  F19            C                   CONST(X'B7')
005200030109     D  F20            C                   CONST(X'B8')
005300030109     D  F21            C                   CONST(X'B9')
005400030109     D  F22            C                   CONST(X'BA')
005500030109     D  F23            C                   CONST(X'BB')
005600030109     D  F24            C                   CONST(X'BC')
005700030109    ***
005800030519      *
005900030519    *** TIMESTAMP FIELDS DATA STRUCTURE
006000030519      *
006100030519     D @TIMESTAMP      DS
006200030519     D  #TSCYMD                1      8S 0
006300030519     D  #TSTIME                9     14S 0
006400030519     D  @TSJOB                15     24
006500030519     D  @TSUSER               25     34
006600030519     D  #TSNBR                35     40S 0
006700030519    * *
006800030519     D @TS40           S             40A
006900030519    ***
007000030519     D DS@AG         E DS                  EXTNAME(SUPRAGCY)
007100030519    ***
007200090109     D DS@IRM        E DS                  EXTNAME(IRMMSTP)
007300090206     D  IMTXT1                 4     43A
007400090206     D  IMTXT2                44     83A
007500090109    ***
007600030109     D #TDAY           S              8S 0
007700030109     D #ISO            S               D   DATFMT(*ISO)
007800030109     D #USA            S               D   DATFMT(*USA)
007900030109     D @VP             S              1A
008000030109    ***
008100030109     D @IM             S              1A
008200030109     D @STEP           S              5A
008300090109     D P@3             S              5A
008400030109    ***
008500030109     D @EMSG           S             70A
008600030109   X***X
008700030109    1C                   DOU       @STEP = 'LEAVE'
008800030109    2C     @STEP         CASEQ     'PREP1'       $PREP1
008900030109    2C     @STEP         CASEQ     'STEP1'       $STEP1
009000030109    2C                   ENDCS
009100030109    1C                   ENDDO
009200030109    ***
009300030109     C                   MOVE      *ON           *INLR
009400030109   S***S
009500030109     C     *INZSR        BEGSR
009600030109    ***
009700030109     C     *ENTRY        PLIST
009800030429     C                   PARM                    P@3
009900030109     C                   PARM                    P@1               1
010000030109    ***
010100030109     C                   CLEAR                   IO01
010200030109     C                   CLEAR                   SAF
010300030429     C                   MOVEL     P@3           I_CODE
010400030109     C                   MOVE      P@1           @IM
010500030109     C                   EVAL      @STEP = 'PREP1'
010600030109    ***
010700030109     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
010800030109     C                   IN        @DTA50
010900030109    ***
011000030109     C                   EVAL      GBSREALM = %SUBST(@DTA50:1:40)
011100030109     C                   MOVE      *DATE         #ISO
011200030109     C                   MOVE      #ISO          #TDAY
011300090109     C                   EVAL      @CTYPE = 'U'
011400030109    ***
011500030109     C                   ENDSR
011600030109   S***S
011700030109     C     $PREP1        BEGSR
011800030109    ***
011900030109    1C                   IF        @IM = 'I'
012000030109     C                   EVAL      *IN25 = *ON
012100030109    1C                   ELSE
012200030109     C                   EVAL      *IN25 = *OFF
012300030109     C                   ENDIF
012400030519    ***
012500030519     c                   clear                   RSUPHIST
012600030519     c                   clear                   ds@ag
012700090109     C                   EVAL      *IN28 = *OFF
012800090109     C                   EVAL      *IN30 = *OFF
012900090109     C                   EVAL      *IN31 = *OFF
013000030109    ***
013100030109    1C                   SELECT
013200030109    1C                   WHEN      @IM = 'I' OR @IM = 'M'
013300030109     C     I_CODE        CHAIN(N)  SAF
013400030109     C                   EXSR      $FMTREC
013500030109    1C                   WHEN      @IM = 'A'
013600030109     C                   CLEAR                   SAF
013700030429     C                   MOVEL     P@3           I_CODE
013800030109    1C                   ENDSL
013900030109    ***
014000030109     C                   EVAL      @STEP = 'STEP1'
014100030109    ***
014200030109     C                   ENDSR
014300030109   S***S
014400030109     C     $FMTREC       BEGSR
014500030109    ***
014600030109     C                   IF        SAEFFDTE > 0
014700030109     C     SAEFFDTE      MULT      10000.0001    I_BEGDT
014800030109     C                   ELSE
014900030109     C                   Z-ADD     SAEFFDTE      I_BEGDT
015000030109     C                   ENDIF
015100030109    ***
015200030109     C                   IF        SATRMDTE > 0
015300030109     C     SATRMDTE      MULT      10000.0001    I_ENDDT
015400030109     C                   ELSE
015500030109     C                   Z-ADD     SATRMDTE      I_ENDDT
015600030109     C                   ENDIF
015700030109    ***
015800030109     C                   MOVEL(P)  SANAME1       I_NAME1
015900030109     C                   MOVEL(P)  SANAME2       I_NAME2
016000030109     C                   MOVEL(P)  SAADD1        I_ADD1
016100030109     C                   MOVEL(P)  SAADD2        I_ADD2
016200030109     C                   MOVEL(P)  SACITY        I_CITY
016300030109     C                   MOVEL(P)  SASTATE       I_STATE
016400030109     C                   MOVEL(P)  SAZIP         I_ZIP
016500030109     C                   MOVEL(P)  SACNTCT       I_CONTACT
016600030109     C                   MOVEL(P)  SAPHONE       I_PHONE
016700030109     C                   MOVEL(P)  SAFAX         I_FAX
016800030109     C                   MOVEL(P)  SATAXID       I_TAXID
016900030519    ***
017000030519     c                   eval      hbefore =ds@ag
017100030109    ***
017200090109     C                   EVAL      *IN28 = *ON
017300090109     C                   EVAL      *IN30 = *ON
017400090109     C                   EVAL      *IN31 = *OFF
017500090109     C                   EVAL      INAC = *BLANKS
017600030109    ***
017700090109     C                   IF        SATRMDTE > 0
017800090109    * *
017900090206     C                   EVAL      *IN31 = *ON
018000090109    * *
018100090109     C     KL#MS         CHAIN     MKTSTSR
018200090109     C                   IF        %FOUND(MKTSTSP)
018300090109    * *
018400090206     C                   EVAL      INAC = MSREASN
018500090206     C                   IF        %SUBST(MSREASN:1:1) = 'I'
018600090109     C                   EVAL      *IN28 = *OFF
018700090109     C                   EVAL      *IN30 = *ON
018800090206     C                   ELSE
018900090206     C                   EVAL      *IN28 = *ON
019000090206     C                   EVAL      *IN30 = *OFF
019100090206     C                   ENDIF
019200090109    * *
019300090109     C     MSREASN       CHAIN     IRMMSTR
019400090109     C                   IF        NOT %FOUND(IRMMSTP)
019500090109     C                   EVAL      IMTEXT = '* UNSELECTED REASON *'
019600090109     C                   ENDIF
019700090206    * *
019800090206     C                   ELSE
019900090206    * *
020000090206     C                   EVAL      *IN28 = *ON
020100090206     C                   EVAL      *IN30 = *OFF
020200090109    * *
020300090109     C                   ENDIF
020400090109    * *
020500090109     C                   ENDIF
020600090109    ***
020700030109     C                   ENDSR
020800030109   S***S
020900030109     C     $STEP1        BEGSR
021000030109    ***
021100030109     C                   MOVEL     @EMSG         EMSG
021200030109     C                   EXFMT     IO01
021300030109     C                   MOVE      *BLANKS       EMSG
021400030109     C                   MOVE      *BLANKS       @EMSG
021500030109    ***
021600030109    1C                   IF        FKEY = F7
021700030109     C                   EVAL      @STEP = 'LEAVE'
021800030109     C                   MOVE      'X'           P@1
021900030109     C                   LEAVESR
022000030109    1C                   ENDIF
022100110418    ***
022200110418     C                   IF        FKEY = F2
022300110418     C                   EVAL      @NTEPARM = '010' + I_CODE
022400110418     C                   CALL      'MDC010  '
022500110418     C                   PARM                    @NTEPARM         11
022600110418     C                   LEAVESR
022700110418     C                   END
022800030109    ***
022900030109    1C                   IF        FKEY = F1
023000090109     C                   IF        *IN25 = *OFF
023100030109     C                   EVAL      @STEP = 'LEAVE'
023200030109     C                   MOVE      *BLANKS       P@1
023300090109     C                   ELSE
023400090109     C                   EVAL      *IN25 = *OFF
023500090109     C                   ENDIF
023600030109     C                   LEAVESR
023700030109    1C                   ENDIF
023800030109    ***
023900090109    1C                   IF        FKEY = F4
024000090109     C                   CALL      'SLCIRMCL'
024100090109     C                   PARM      'LOAD'        WRQS              8
024200090109     C                   PARM                    WRTN              8
024300090109     C                   PARM      'SLCIRM'      WPGM             10
024400090206     C                   PARM                    @83              83
024500090206     C                   EVAL      INAC = %SUBST(@83:1:1)
024600090206     C                   EVAL      IMTXT1 = %SUBST(@83:4:40)
024700090206     C                   EVAL      IMTXT2 = %SUBST(@83:44:40)
024800090206     C                   EVAL      DS@IRM = @83
024900090109     C                   LEAVESR
025000090109    1C                   ENDIF
025100090109    ***
025200090109    1C                   IF        @IM = 'I'
025300090109     C                   LEAVESR
025400090109    1C                   ENDIF
025500090109    ***
025600090109    1C                   IF        FKEY = F10
025700090109     C                   EXSR      $F10
025800090109     C                   LEAVESR
025900090109    1C                   ENDIF
026000090109    ***
026100030109     C                   EXSR      $VALID
026200030109    ***
026300090109    2C                   IF        @VP = 'N'
026400090109     C                   LEAVESR
026500090109    2C                   ENDIF
026600090109    ***
026700090109     C                   IF        (*IN31 = *ON AND I_ENDDT <> 0) OR
026800090109     C                             I_ENDDT = 0
026900090109     C                   EVAL      *IN25 = *ON
027000090109     C                   ENDIF
027100090109    * *
027200090109     C                   IF        SATRMDTE = 0 AND I_ENDDT <> 0
027300090109     C                   EVAL      *IN31 = *ON
027400090109     C                   ENDIF
027500090109    * *
027600090109     C                   IF        SATRMDTE <> 0 AND I_ENDDT = 0
027700090109     C                   EVAL      *IN31 = *OFF
027800090109     C                   ENDIF
027900090109    * *
028000090109     C                   IF        I_ENDDT = 0
028100090109     C                   EVAL      *IN28 = *ON
028200090109     C                   EVAL      *IN30 = *ON
028300090109     C                   LEAVESR
028400090109     C                   ENDIF
028500090109    * *
028600090206     C                   IF        %SUBST(MSREASN:1:1) = 'I'
028700090109     C                   EVAL      *IN28 = *ON
028800090109     C                   EVAL      *IN30 = *OFF
028900090109     C                   ELSE
029000090109     C                   EVAL      *IN28 = *OFF
029100090109     C                   EVAL      *IN30 = *ON
029200090109     C                   ENDIF
029300090109    ***
029400030109     C                   ENDSR
029500030109   S***S
029600090109     C     $F10          BEGSR
029700090109    ***
029800090109     C                   EXSR      $VALID
029900090109    2C                   IF        @VP = 'Y'
030000090109     C                   EXSR      $I#O
030100090109     C                   EXSR      $HISTORY
030200090109     C                   EVAL      @STEP = 'LEAVE'
030300090109     C                   MOVE      *BLANKS       P@1
030400090109    2C                   ENDIF
030500090109    ***
030600090109     C                   ENDSR
030700090109   S***S
030800030109     C     $I#O          BEGSR
030900030109    ***
031000030109    1C                   IF        @IM = 'A'
031100030109    *** ADD RECORD
031200030109     C                   MOVEL     I_CODE        SACODE
031300030109     C                   EXSR      $COMNFMT
031400030109    ***
031500030109     C                   WRITE     SAF
031600030519     c                   exsr      $history
031700030109    ***
031800030109     C                   LEAVESR
031900030109    1C                   ENDIF
032000030109    *** CHANGE RECORD
032100030404     C     I_CODE        CHAIN     SAF
032200030109     C                   EXSR      $COMNFMT
032300030109    ***
032400030109     C                   UPDATE    SAF
032500030519     c                   exsr      $history
032600030109    ***
032700030109     C                   ENDSR
032800030109   S***S
032900030109     C     $COMNFMT      BEGSR
033000030109    ***
033100030109     C                   EVAL      SANAME1 = I_NAME1
033200030109     C                   EVAL      SANAME2 = I_NAME2
033300030109     C                   EVAL      SAADD1  = I_ADD1
033400030109     C                   EVAL      SAADD2  = I_ADD2
033500030109     C                   EVAL      SACITY  = I_CITY
033600030109     C                   EVAL      SASTATE = I_STATE
033700030109     C                   EVAL      SAZIP   = I_ZIP
033800030109     C                   EVAL      SACNTCT = I_CONTACT
033900030109     C                   EVAL      SAPHONE = I_PHONE
034000030109     C                   EVAL      SAFAX   = I_FAX
034100030109     C                   EVAL      SATAXID = I_TAXID
034200030109    ***
034300030109     C                   IF        I_BEGDT > 0
034400030109     C     I_BEGDT       MULT      10000.0001    SAEFFDTE
034500030109     C                   ELSE
034600030109     C                   Z-ADD     I_BEGDT       SAEFFDTE
034700030109     C                   ENDIF
034800030109    ***
034900030109     C                   IF        I_ENDDT > 0
035000030109     C     I_ENDDT       MULT      10000.0001    SATRMDTE
035100030109     C                   ELSE
035200030109     C                   Z-ADD     I_ENDDT       SATRMDTE
035300030109     C                   ENDIF
035400030109    ***
035500090109    1C                   IF        I_ENDDT = 0 OR
035600090109     C                             (I_ENDDT <> 0 AND INAC = *BLANKS)
035700090109     C                   EXSR      $INACTDLT
035800090109     C                   ENDIF
035900090109     **
036000090109     C                   IF        INAC <> *BLANKS AND I_ENDDT <> 0
036100090109     C                   EXSR      $INACTWRT
036200090109     C                   ENDIF
036300090109    ***
036400030109     C                   ENDSR
036500030109   S***S
036600030109     C     $VALID        BEGSR
036700030109    ***
036800030109     C                   EVAL      @VP = 'N'
036900030109    ***
037000030109    1C                   IF        I_NAME1 = *BLANKS
037100030109     C                   EVAL      @EMSG = 'NAME LINE 1 CANNOT BE BLANK.'
037200030109     C                   LEAVESR
037300030109     C                   ENDIF
037400030109    ***
037500030109     C                   IF        I_BEGDT = 0
037600030109     C                   EVAL      @EMSG = 'EFFECTIVE DATE CANNOT BE ZERO'
037700030109     C                   LEAVESR
037800030109     C                   ENDIF
037900030109    ***
038000030109     C                   IF        I_BEGDT > 0
038100030109     C     *USA          TEST(DE)                I_BEGDT
038200030109     C                   IF        %ERROR
038300030109     C                   EVAL      @EMSG = 'EFFECTIVE DATE IS INVALID'
038400030109     C                   LEAVESR
038500030109     C                   ENDIF
038600030109     C                   ENDIF
038700030513    ***
038800030513     c                   if        I_TAXID = *blanks or
038900030513     c                             %subst(I_TAXID:1:9) = '000000000'
039000030513     c                   eval      @EMSG = 'TAX ID IS REQUIRED.'
039100030513     c                   leavesr
039200030513     c                   endif
039300030109    ***
039400030109     C                   IF        I_ENDDT > 0
039500030109     C     *USA          TEST(DE)                I_ENDDT
039600030109     C                   IF        %ERROR
039700030109     C                   EVAL      @EMSG = 'TERMINATION DATE IS INVALID'
039800030109     C                   LEAVESR
039900030109     C                   ENDIF
040000030109     C                   ENDIF
040100030109    ***
040200090109     C                   IF        INAC <> *BLANKS AND *IN31 = *ON
040300090109     C     INAC          CHAIN     IRMMSTR
040400090109     C                   IF        NOT %FOUND(IRMMSTP)
040500090109     C                   EVAL      IMTEXT = '* UNSELECTED REASON *'
040600090109     C                   ENDIF
040700090109     C                   ENDIF
040800090109    ***
040900030109     C                   EVAL      @VP = 'Y'
041000030109    ***
041100030109     C                   ENDSR
041200030109   S***S
041300030519     C     $history      BEGSR
041400030519    ***
041500030519     c                   eval      hafter = ds@ag
041600030519     c                   clear                   @timestamp
041700030519     C                   MOVE      *BLANKS       @TS40
041800030519    ***
041900030519     C                   CALL      'TIMESTMP'
042000030519     C                   PARM                    @TS40
042100030519    ***
042200030519     C                   MOVEL     @TS40         @TIMESTAMP
042300030519     C                   MOVEL     @TSUSER       HUSERID
042400030519     C                   MOVE      #TSCYMD       HDATE
042500030519     C                   MOVE      #TSTIME       HTIME
042600030519     C                   MOVEL     @TSJOB        HJOB
042700030519     C                   MOVE      #TSNBR        HNUMBER
042800030519    ***
042900030519     C                   eval      HFSUPER = SACODE
043000030519     c                   write     RSUPHIST
043100030519    ***
043200030519     C                   ENDSR
043300030519   S***S
043400090109     C     $INACTDLT     BEGSR
043500090109    ***
043600090109     C     KL#MS         KLIST
043700090109     C                   KFLD                    @CTYPE            1
043800090109     C                   KFLD                    I_CODE
043900090109     C     KL#MS         CHAIN     MKTSTSR
044000090109     C                   IF        %FOUND(MKTSTSP)
044100090109     C     KL#MS         DELETE    MKTSTSR
044200090109     C                   ENDIF
044300090109    ***
044400090109     C                   ENDSR
044500090109   S***S
044600090109     C     $INACTWRT     BEGSR
044700090109    ***
044800090109     C                   CALL      'TIMESTMP'
044900090109     C                   PARM                    @TS40
045000090109     C                   MOVEL     @TS40         @TIMESTAMP
045100090109    ***
045200090109     C     KL#MS         CHAIN     MKTSTSR
045300090109    ***
045400090109     C                   IF        %FOUND(MKTSTSP)
045500090109    * *
045600090109     C                   IF        MSREASN <> INAC
045700090109     C                   EVAL      MSREASN = INAC
045800090109     C                   MOVEL     @TSUSER       MSCUSER
045900090109     C                   MOVE      #TSCYMD       MSCDATE
046000090109     C                   UPDATE    MKTSTSR
046100090109     C                   ENDIF
046200090109    * *
046300090109     C                   LEAVESR
046400090109     C                   ENDIF
046500090109    ***
046600090109     C                   CLEAR                   MKTSTSR
046700090109     C                   EVAL      MSCTYPE = 'U'
046800090109     C                   EVAL      MSCODE = I_CODE
046900090109     C                   EVAL      MSREASN = INAC
047000090109     C                   MOVEL     @TSUSER       MSCUSER
047100090109     C                   MOVE      #TSCYMD       MSCDATE
047200090109     C                   WRITE     MKTSTSR
047300090109    ***
047400090109     C                   ENDSR
047500090109   S***S
