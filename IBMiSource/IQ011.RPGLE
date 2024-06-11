0001009602140002 F******************************************************************
0002000104030003 F* IQ011      GROUP BENEFIT SERVICES SOFTWARE                     *
0003009602140004 F*                                                                *
0004009602140005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005000103300006 F*            DATE - 03/30/01                                     *
0006009602140007 F*                                                                *
0007000104020007 F* commision control display in IQ010                             *
0008000202260007 F* 02/26/02 dlk - display "NO COMMISSION..." when no comctx.      *
0009000512130007 F* 12/13/05 dlk - add class and input parms to hide plans         *
0010000512160007 F*    *Note: By manually removing *ALL observable info, the obj   *
0011000512160007 F*           size of iq011 is 50% smaller allowing a much faster  *
0012000512160007 F*           first time open. Remember to do this when program    *
0013000512160007 F*           changes are complete.                                *
0014000808130007 F* 08/13/08 rlj - use a work file to sort dtl lines by class      *
0015000904240007 F* 04/24/09 szz - Add Rate file to show rate expire date.         *
0016000908200007 F* 08/20/09 dlk - do cancel date compare against todays date,     *
0017000908200007 F*                not just 0.                                     *
0018001009160007 F* 09/16/10 dlk - add relation ID per request from Finance.       *
0019001308270007 F* 08/28/13 rlj - add call to FI035 w/ Plan#.                     *
0020001311190007 F* 11/08/13 dpb - add F8 & F9 inquiries (FI036R)                  *
0021001311210007 F* 11/21/13 rlj - add call to FI030                               *
0022001403280007 F* 03/28/14 jva - add parm to call of FI030                       *
0023001505040007 F* 05/04/15 rlj - Blink plan# if it is the reference plan         *
0024000512160007 F*                                                                *
0025001611210007 F* 11/21/2016  B.Rees  Mod: br01
0026001611210007 F*  Displaying the Commission percentage at the end of the
0027001611210007 F*  salesmen name field.
002800170221     F*
0029001702210007 F* 02/21/2017  B.Rees  Mod: br02
0030001702210007 F*  New Call for Composite Rates
003100170802     F*
003200170802     F* 07/05/2017  B.Rees  Mod: br03
003300170802     F*  New sort for the plan IDs.  Sort by Carrier Code.
003400170802     F*   The display will be by CareFirst Items first; followed by
003500170802     F*   Plans with a class, then plans without a class.
0036001708090007 F* 08/09/17 dlk - fix SFLDSPCTL indicator 91 - was not set when no
0037001708090007 F*                records read from iq11sfp
0038001905020007 F* 05/02/19 dlk - add primary broker - Mick request
0039002108170007 F* 08/17/21 dlk - recomplie only to pick up new SFPNC field added to
0040002108170007 F*                iq11sfp work file.
0041009602140013 F******************************************************************
004200010330     Fiq011d    CF   E             WORKSTN
004300961031     F                                     SFILE(SF01:RRN)
004400171109     Fcmct14    IF   E           K DISK    ExtDesc('F.CMCT14')
004500171109     F                                     ExtFile(*extdesc)
004600171109     Fsman      IF   E           K DISK    ExtDesc('F.SMAN')
004700171109     F                                     ExtFile(*extdesc)
004800171109     Fplnmst    IF   E           K DISK    ExtDesc('F.PLNMST')
004900171109     F                                     ExtFile(*extdesc)
005000170221br02 FplnAuxp   IF   E           K DISK
005100170725br03 FCarMst    IF   E           K DISK    ExtDesc('F.CARMST')
005200170725     F                                     ExtFile(*extdesc)
005300171109     Fmcov14    IF   E           K DISK    ExtDesc('F.MCOV14')
005400171109     F                                     ExtFile(*extdesc)
005500171109     Fclass     IF   E           K DISK    ExtDesc('F.CLASS')
005600171109     F                                     ExtFile(*extdesc)
005700150504     Fpdrefplp  IF   E           K DISK
005800171109     FGRAT25    IF   E           K Disk    ExtDesc('F.GRAT25')
005900171109     F                                     ExtFile(*extdesc)
006000080812     Fiq11sfp   UF A E           K DISK    USROPN
006100161121
006200161121      *---------------------------------------------------------------
006300051214     d nocommsg        C                   CONST('* NO COMMISSION CONTROL TO +
006400080811     d                                     DISPLAY *')
006500130827      *
0066000808110484 D                 DS
0067001505040485 D  rfplan                 1      4
006800150504      *
0069001505040484 D                 DS
0070001505040485 D  tsaout                 1     10  0
0071000808110486 D  t                      1      3  0
0072000808110487 D  S                      4      6  0
0073000808110488 D  A                      7     10  0
007400130827      *
0075001308270484 D                 DS
0076001308270485 D  plnxv                  1     10
0077001308270486 D   axtr                  1      3
0078001308270487 D   axsb                  4      6
0079001308280488 D   axpl                  7     10
008000140325    ? * Data structure
008100140325    ?D WDDTA         E DS                  EXTNAME(PLNMST)
008200130827      *
0083000908200600 D                UDS
0084000908200601 D  ud8ymd               248    255  0
008500090424     DExpDate          S                   LIKE(TODAT) Inz(99999999)
008600161121
008700161128br01 D CommPct         s              6s 3 inz
008800161121
008900161121      *---------------------------------------------------------------
009000010330     c     *ENTRY        plist
009100080811     C                   parm                    p1                3
009200080811     C                   parm                    p2                3
009300080811     C                   parm                    p3                4
009400010330     c                   move      p1            t                 3 0
009500010330     c                   move      p2            s                 3 0
009600010330     c                   move      p3            a                 4 0
009700130827     c                   move      p1            axtr
009800130827     c                   move      p2            axsb
009900140326
010000140326     C                   write     DUMMY
010100051213
010200051213      * set defaults for hiding plans
010300051214     c                   move      'Y'           hidecanp
010400051213     c                   move      ' '           hidenomem
010500080812     C                   OPEN      IQ11SFP
010600010403
010700010330     C     tsa           KLIST
010800080811     C                   KFLD                    t
010900080811     C                   KFLD                    s
011000080811     C                   KFLD                    a
011100080811
011200080811     C     mkey          KLIST
011300080811     C                   KFLD                    t
011400010330     C                   KFLD                    s
011500010330     C                   KFLD                    a
011600010330     C                   KFLD                    cmplan
011700010402
011800010402     C     plnkey        KLIST
011900010402     C                   KFLD                    t
012000010402     C                   KFLD                    s
012100010402     C                   KFLD                    cmplan
012200090424
012300090424     C     RatKey        Klist
012400090424     C                   Kfld                    t
012500090424     C                   Kfld                    s
012600090424     C                   Kfld                    cmplan
012700090424     C                   Kfld                    ExpDate
012800010330
012900010330     C***************************************************
013000080807     C* Build file IQ11SFP                              *
013100010330     C***************************************************
013200150504      *        See if Reference Plan exixsts for this TSA
013300150504     c                   eval      rfplan = *blanks
013400150504     C     tsa           chain     pdrefplp                           22
013500150504     C                   if        *in22 = '0'
013600150504     c                   eval      rfplan = prplan
013700150504     C                   endif
013800150504      *
013900131113
014000131113     C                   clear                   uxplan
014100080807     C                   dou       *in01 = *on
014200080807      *
014300080807     c                   eval      *in21 = *off
014400010330     C     tsa           SETLL     cmct14
014500010330
014600080807     C                   dow       *in21 = *off
014700080807     C     tsa           READE     cmct14                                 21
014800010330
014900080807     C                   if        *in21 = *off
015000051213
015100051213      * hide cancelled plans
015200051213     c                   if        hidecanp = 'Y' and cmcan <> 0
015300090820     c                             and cmcan <= ud8ymd
015400051213     c                   iter
015500051213     c                   end
015600051213
0157000808070200 C                   clear                   sname            31                           SR#NA
0158000808070200 C                   clear                   effmdy                                        SR#NA
0159000808070200 C                   clear                   cmcmdy                                        SR#NA
0160000904240200 C                   Clear                   REXMDY                                        SR#NA
0161000104020200 C                   clear                   savplan                                       SR#NA
0162001905020200 C                   clear                   pribrk                                        SR#NA
016300051213
016400190502      * primary broker
016500190502       pribrk = %subst(free5:1:1);
016600190502
016700190502
016800010402     C     slsman        CHAIN     sman
016900010330     c                   if        %found(sman)
0170001611210202 C**  br01           MOVEl     sfname        sname                                         SR#NA
017100161121     C**  br01           CAT       slname:1      sname
017200161121     C
017300161121br01 C                   eval      sname = %Trim(sfName) + ' ' + slName
017400161128 |   C                   if        cccmsp > 0
017500161121 |
017600161121 |    *?Round up...
017700161128 |   C                   eval      CommPct = %dech(cccmsp:6:3)
017800161128 |   C
017900161128 |   C                   if        cccmsp < 10
018000161128 |   C
018100161128 |   C                   eval      %Subst(sname : 26 : 6) =
018200161121 |   C                               %Char(CommPct) + '%'
018300161128 |   C                   else
018400161128 |   C                   eval      %Subst(sname : 25 : 7) =
018500161128 |   C                               %Char(CommPct) + '%'
018600161128 |   C
018700161128 |   C                   endif
018800161121 |   C                   endif
018900161121br01 C
019000161121     C
019100010402     C                   end
019200010402
019300010403     c* to reduce io - only do plan specifc logic when plan changes since
019400010403     c* cmct14 is in t/s/a/plan order
019500010402
019600010402     c                   if        cmplan <> savplan
019700010402     C     plnkey        CHAIN     plnmst
019800010402     c                   if        not %found(plnmst)
0199000104020202 C                   clear                   pdescr                                        SR#NA
020000090424      *
020100090424      * Get Rates Expire Date
020200090424     C                   Else
020300090424     C                   Exsr      #GetRate
020400090424      *
020500010402     C                   end
020600051213     c* get class
020700051213     c                   exsr      #getclass
020800010402     c* set on 32 for active members in this plan
020900010402     c                   exsr      #rmcov
021000010402     C                   end
021100051213
021200051214      * hide plans with no active members
021300051213     c                   if        hidenomem = 'Y' and *in32 = *off
021400051213     c                   iter
021500051213     c                   end
021600010330
021700010402     c                   move      cmplan        savplan           4
021800010402
021900010330     C                   MOVE      effdat        @DATIN
022000010330     C                   EXSR      #DATYM
022100010330     C                   MOVE      @DATOU        effmdy            8 0
022200010330
022300010330     C                   MOVE      cmcan         @DATIN
022400010330     C                   EXSR      #DATYM
022500010330     C                   MOVE      @DATOU        cmcmdy            8 0
022600010330
022700170725br03 C     pCarr         chain     CarMst
022800170725
022900170725     C
023000080811     C                   eval      sfpln = cmplan
023100100916     C                   eval      sfrelid = cmrelid
023200080811     C                   eval      sfdesc = pdescr
023300080807     C                   eval      sfcls = classout
023400080807     C                   eval      sfslsm = slsman
023500080807     C                   eval      sfsnam = sname
023600080807     C                   eval      sfeff = effmdy
023700080807     C                   eval      sftrm = cmcmdy
023800090424     C                   Eval      SFREX = REXMDY
023900170705br03 C                   eval      spCarr = pCarr
024000170725br03 C                   eval      sGrpCd = cGrpCd
024100190502br03 C                   eval      sfpribrk = pribrk
024200080807     C                   WRITE     iq11sfr
024300010330     C                   end
024400010330     c                   enddo
024500080812      *
024600080812     C                   CLOSE     IQ11SFP
024700080812      *
024800080807     C**&*&*&*&*&*&*&***&***&*&**&**&
0249000103300103 C***************************************************
0250000808070103 C***************************************************
025100080807     C***************************************************
025200080807     C* DISPLAY IQ11SFP in class/plan order             *
025300080807     C***************************************************
025400080807     C*
025500080812     C                   OPEN      IQ11SFP
025600080812     C*
025700080807     C* CLEAR SUBFILE
025800080807     C*
025900080807     C                   MOVEA     '001'         *IN(90)
026000080807     C                   WRITE     SF01CTL
026100080807     C                   MOVE      '0'           *IN92
026200080807     C*
026300080807     C* BUILD SUBFILE
026400080807     C*
026500080807     C                   MOVE      *ZEROS        RRN               5 0
026600170802     C
026700170802br03 C                   Exsr      Read1
026800170802br03 C                   Exsr      Read2
026900170802br03 C                   Exsr      Read3
027000170802br03 C                   Exsr      Read4
027100170802     C
027200080807     C*
027300080807     C* DISPLAY SUBFILE
027400080807     C*
027500080807     c* if no commissions exist, display * no commission..*
027600080807
027700080807     C                   if        rrn = 0
027800080807     c                   clear                   sf01
027900080807     c                   eval      pdescr = nocommsg
028000080807     c                   add       1             rrn
028100080807     c                   write     sf01
028200080807     C                   end
028300080807
028400080807     C                   eval      *in90 = *on
028500170809     C                   eval      *in91 = *on
028600080807
028700080807     C* display subfile with text at bottom
028800080807
028900130828     C                   write     Sf01CMDKY
029000080807     C                   EXFMT     SF01CTL
029100131113
029200131113     C                   if        *in01 = *on
029300131113     C                   leave
029400131113     C                   endif
029500080807
029600140326     C                   if        *in08 = *on or *in06 = *on or
029700140326     C                             *in07 = *on or
029800140326     C                             *in09 = *on or *in07 = *on
029900131119
030000131119     C                   if        uxplan = *blanks
030100131113     C                   eval      errormsg = 'No plan selected'
030200131113     C                   exfmt     wdwerror
030300131113     C                   clear                   errormsg
030400131113
030500131113     C                   else
030600131113
030700131113     C                   eval      cmplan = uxplan
030800131113     C     mkey          setll     cmct14
030900131113     C                   if         not %equal(cmct14)
031000131113     C                   eval      errormsg = 'Invalid plan for t/s/a'
031100131113     C                   exfmt     wdwerror
031200131113     C                   clear                   errormsg
031300131113
031400140326     C                   elseif    *in08 = *on
031500130828     C                   eval      axpl = uxplan
031600130827CLS  C                   call      'FI035CL'
031700130827CLS  C                   PARM                    plnxv
031800131108
031900140326     C                   elseif    *in09 = *on
032000140325     C                   eval      axpl = uxplan
032100140325     C                   eval      PLTRST = T
032200140325     C                   eval      PLSUB# = S
032300140325     C                   eval      PLPLAN = uxplan
032400140325     C                   CALL      'FI030'
032500140325    ?C                   PARM                    WIRQS             8            EXT MODE
032600140325    ?C                   PARM                    WORTN             8            INTERNAL MODE
032700140325    ?C                   PARM                    WUPGM            10            LAST PGM NAME
032800140328    ?C                   PARM                    WDDTA                          RECORD DS
032900140328    ?C                   PARM                    CMACCT                         RECORD DS
033000140325    ?C                   PARM                    WIFKY            60            FUNCTIONS VALID
033100131121
033200140326     C                   elseif    *in06 = *on
033300170221br02                     chain (cmTrst: cSubdv: uxPlan) PlnAuxp;
033400170221
033500170223br02 C                   if        pxAcar = 'C'or pxAcar = 'N'
033600170221     C                   call      'FI037R'
033700170221     C                   parm                    cmtrst
033800170221     C                   parm                    csubdv
033900170221     C                   parm                    uxplan
034000170221     C
034100170221     C
034200170221     C
034300170221     C                   else
034400131113     C                   call      'FI036R'
034500131108     C                   parm                    cmtrst
034600131108     C                   parm                    csubdv
034700131108     C                   parm                    uxplan
034800131108     C                   parm                    cmacct
034900131111     C                   parm      'RATES'       inqtype           8
035000170221br02 C                   endif
035100131108
035200140326     C                   elseif    *in07 = *on
035300131113     C                   call      'FI036R'
035400131108     C                   parm                    cmtrst
035500131108     C                   parm                    csubdv
035600131108     C                   parm                    uxplan
035700131111     C                   parm                    cmacct
035800131111     C                   parm      'BENEFITS'    inqtype
035900131113
036000131126     C                   endif
036100131126     C***                endif
036200131113     C                   endif
036300131119     C                   endif
036400131121     C****               endif
036500130827CLS * *
036600080807     C* leave when f1 pressed
036700080807     c                   enddo
036800080807
036900080812      *
037000080812     C                   CLOSE     IQ11SFP
037100080812      *
037200080807     C* return to calling program
037300080807     c                   return
0374000808070107 C*
0375000808070103 C***************************************************
0376000808070103 C***************************************************
0377000103300104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0378000103300105 C***************************************************
0379000103300107 C*
0380000103300107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0381000103300107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0382000103300107 C*
0383000103300106 C     #DATYM        BEGSR
038400010330     C                   MOVE      @DATIN        @MD               4 0
038500010330     C                   MOVEL     @DATIN        @Y                4 0
038600010330     C                   MOVEL     @MD           @DATOU            8 0
038700010330     C                   MOVE      @Y            @DATOU
038800010330     C                   MOVE      *ZEROS        @DATIN            8 0
0389000103300120 C                   ENDSR
039000010330
039100010402     C* FIND WHICH PLANS ARE ACTIVE....
039200010330
039300010330     C     #RMCOV        BEGSR
039400010330     C*
039500010330     C                   SETOFF                                       65  32
039600010402     C     mkey          SETLL     MCOV14
039700010330
039800010330     C                   dow       *in65 = *off
039900010402     C     mkey          READe     MCOV14                                 65
040000010330     C                   if        *in65 = *off and candt = 0
040100010330     C                   eval      *in32 = *on
040200010330     C                   leave
040300010330     C                   END
040400010330     C                   enddo
040500010330
040600010330     C                   ENDSR
040700051213
040800051213      ***********************
040900051213      * get class
041000051213      ***********************
041100051213     C     #getclass     BEGSR
041200051213
041300051213     C                   clear                   classout
041400051213
041500051214     C*    plnkey        setgt     class
041600051214     C*    plnkey        readpe    class
041700051214     C     plnkey        setll     class
041800051214     C     plnkey        reade     class
041900051213     C                   if        not %eof(class)
042000051213     C                   move      clclass       classout
042100051213     C                   end
042200051213
042300051213     C                   ENDSR
042400090424      ***********************
042500090424      * Get Rate Expire Date
042600090424      ***********************
042700090424     C     #GetRate      BEGSR
042800090424
042900090424     C                   Clear                   REXMDY
043000090424
043100090424     C     RatKey        Setll     GRAT25
043200090424     c     plnkey        Reade     GRAT25
043300090424     C                   If        Not %Eof(GRAT25)
043400090424     C                   Move      TODAT         @DATIN
043500090424     C                   Exsr      #DATYM
043600090424     C                   Move      @DATOU        REXMDY            8 0
043700090424     C                   End
043800090424
043900090424     C                   ENDSR
044000170802
044100170802br03  *-----------------------------------------------------------------
044200170802       Begsr Read1;
044300170802
044400170802          // Read1 is only selecting CareFirst Plans for the Subfile.
044500170802
044600170802          Setll *loval iq11sfp;
044700170802
044800170802          dou %eof(iq11sfp);
044900170802             read iq11sfp;
045000170802
045100170802             if %eof( iq11sfp );
045200170802                leave;
045300170802             endif;
045400170802
045500170802             //?Skip Cobra Plans
045600170802             if %Subst(sfPln : 1 : 1) = '9';
045700170802                iter;
045800170802             endif;
045900170802
046000170802             if sGrpcd = 'CF';
046100170802                *in91 = *on;
046200170802
046300170802                cmplan = sfpln;
046400170802                cmrelid = sfrelid;
046500170802                pdescr = sfdesc ;
046600170802                classout = sfcls;
046700170802                slsman = sfslsm;
046800170802                sname = sfsnam ;
046900170802                effmdy = sfeff ;
047000170802                cmcmdy = sftrm ;
047100190502                pribrk = sfpribrk ;
047200170802                REXMDY = SFREX ;
047300170802
047400170802                //?set on 33 for Reference Plan
047500170802                *in33 = *off;
047600170802                if cmPlan = rfPlan;
047700170802                   *in33 = *on;
047800170802                endif;
047900170802
048000170802
048100170802                //?set on 33 for Active Member
048200170802                exsr #rmcov;
048300170802
048400170802                delete iq11sfr;
048500170802
048600170802                rrn = rrn + 1;
048700170802                write sf01;
048800170802
048900170802             Endif;
049000170802          enddo;
049100170802
049200170802       Endsr;
049300170802
049400170802
049500170802br03  *-----------------------------------------------------------------
049600170802       Begsr Read2;
049700170802
049800170802          // Read2 is selecting any plan that is not CareFirst
049900170802          //       Plans must have a class..
050000170802
050100170802          Setll *loval iq11sfp;
050200170802
050300170802          dou %eof(iq11sfp);
050400170802             read iq11sfp;
050500170802
050600170802             if %eof( iq11sfp );
050700170802                leave;
050800170802             endif;
050900170802
051000170802             //?Skip Cobra Plans
051100170802             if %Subst(sfPln : 1 : 1) = '9';
051200170802                iter;
051300170802             endif;
051400170802
051500170802
051600170802             if sGrpcd <> 'CF' and sfcls > *Blanks;
051700170802                *in91 = *on;
051800170802
051900170802                cmplan = sfpln;
052000170802                cmrelid = sfrelid;
052100170802                pdescr = sfdesc ;
052200170802                classout = sfcls;
052300170802                slsman = sfslsm;
052400170802                sname = sfsnam ;
052500170802                effmdy = sfeff ;
052600170802                cmcmdy = sftrm ;
052700190502                pribrk = sfpribrk;
052800170802                REXMDY = SFREX ;
052900170802
053000170802                //?set on 33 for Reference Plan
053100170802                *in33 = *off;
053200170802                if cmPlan = rfPlan;
053300170802                   *in33 = *on;
053400170802                endif;
053500170802
053600170802
053700170802                //?set on 33 for Active Member
053800170802                exsr #rmcov;
053900170802
054000170802                delete iq11sfr;
054100170802
054200170802                rrn = rrn + 1;
054300170802                write sf01;
054400170802
054500170802             Endif;
054600170802          enddo;
054700170802
054800170802       Endsr;
054900170802
055000170802
055100170802br03  *-----------------------------------------------------------------
055200170802       Begsr Read3;
055300170802
055400170802          // Read3 is selecting any plan that is not CareFirst
055500170802          //       Plans must have not have a class.
055600170802
055700170802          Setll *loval iq11sfp;
055800170802
055900170802          dou %eof(iq11sfp);
056000170802             read iq11sfp;
056100170802
056200170802             if %eof( iq11sfp );
056300170802                leave;
056400170802             endif;
056500170802
056600170802             //?Skip Cobra Plans
056700170802             if %Subst(sfPln : 1 : 1) = '9';
056800170802                iter;
056900170802             endif;
057000170802
057100170802
057200170802             if sGrpcd <> 'CF' and sfcls = *Blanks;
057300170802                *in91 = *on;
057400170802
057500170802                cmplan = sfpln;
057600170802                cmrelid = sfrelid;
057700170802                pdescr = sfdesc ;
057800170802                classout = sfcls;
057900170802                slsman = sfslsm;
058000170802                sname = sfsnam ;
058100170802                effmdy = sfeff ;
058200170802                cmcmdy = sftrm ;
058300190502                pribrk = sfpribrk;
058400170802                REXMDY = SFREX ;
058500170802
058600170802                //?set on 33 for Reference Plan
058700170802                *in33 = *off;
058800170802                if cmPlan = rfPlan;
058900170802                   *in33 = *on;
059000170802                endif;
059100170802
059200170802
059300170802                //?set on 33 for Active Member
059400170802                exsr #rmcov;
059500170802
059600170802                delete iq11sfr;
059700170802
059800170802                rrn = rrn + 1;
059900170802                write sf01;
060000170802
060100170802             Endif;
060200170802          enddo;
060300170802
060400170802       Endsr;
060500170802
060600170802
060700170802br03  *-----------------------------------------------------------------
060800170802       Begsr Read4;
060900170802
061000170802          // Read4 Anything Left Over.  ie= Cobra
061100170802
061200170802          Setll *loval iq11sfp;
061300170802
061400170802          dou %eof(iq11sfp);
061500170802             read iq11sfp;
061600170802
061700170802             if %eof( iq11sfp );
061800170802                leave;
061900170802             endif;
062000170802
062100170802                *in91 = *on;
062200170802
062300170802                cmplan = sfpln;
062400170802                cmrelid = sfrelid;
062500170802                pdescr = sfdesc ;
062600170802                classout = sfcls;
062700170802                slsman = sfslsm;
062800170802                sname = sfsnam ;
062900170802                effmdy = sfeff ;
063000170802                cmcmdy = sftrm ;
063100190502                pribrk = sfpribrk;
063200170802                REXMDY = SFREX ;
063300170802
063400170802                //?set on 33 for Reference Plan
063500170802                *in33 = *off;
063600170802                if cmPlan = rfPlan;
063700170802                   *in33 = *on;
063800170802                endif;
063900170802
064000170802
064100170802                //?set on 33 for Active Member
064200170802                exsr #rmcov;
064300170802
064400170802                delete iq11sfr;
064500170802
064600170802                rrn = rrn + 1;
064700170802                write sf01;
064800170802
064900170802          enddo;
065000170802
065100170802       Endsr;
065200170802
065300170802
065400170802
