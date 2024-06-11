000100180129     H Option(*nodebugio)
000200180129
000300001201     F*---------------------------------------------------------------**
000400001201     F* FM120      GROUP BENEFIT SERVICES SOFTWARE                     *
000500001201     F*            WRITTEN BY - M.L.F.                                 *
000600001201     F*            DATE - 08/97                                        *
000700001201     F*  DESCRIPTION - AGENCY MASTER FILE MAINTENANCE                  *
000800001201     F*---------------------------------------------------------------**
000900001201    *** DEC 1, 2000 REWRITE THIS PROGRAM AND ADD AGENCY/CARRIER COMMISSION OVERRIDE APP
001000001201    ***             AND REMOVE ALL THESE HORRIBLE GOTO TAGS.
001100001201    *** SSK  I/O INC.
001200001201    ***
001300010823    *** 08.23.2001 SSK FUNCTION KEYS AVAILABLE ON CHANGE MODE ONLY
001400020130    *** 01.22.2002 SSK CORRECT DATE USAGE IN $SPINNER ROUTINE
001500030109    *** 01.09.2003 SSK ADD SUPER AGENCY INTERFACE
001600040430    *** 04.29.2004 SSK DEACTIVATED $SPINNER ROUTINE AND PURGE AGCAROV0.
001700050524    *** 05.24.2005 SSK RE-CODE AGACH.
001800060316    *** 03.16.2006 SSK ADD RELATIONSHIP MANAGEMENT.
001900060316    ***                DE-ACTIVATE SUPER AGENCY DISPLAY
002000080318    *** 03.18.2008 SSK ADD POSITION CURSOR LOGIC
002100080915    *** 09/15/2008 dlk allow "I" in AGACH field
002200090108    *** 01.08.2009 SSK MARKETING STATUS MODS
002300090514    *** 05.14.2009 SSK LICENSING STATUS MODS
002400090514    ***                REMOVE OLD CODE NO LONGER USED FOR READABILITY
002500091103    *** 11.03.2009 SSK AGENCY RELATIONSHIP HISTORICAL CAPTURE
002600100512    *** 05.12.2010 SSK HOLD FOR ACH
002700101025    *** 10.25.2010 SSK ADD CONTRACTING REPORT MENU
002800110418    *** 04/18/2011 SSK ADDED MARKETING DIARY NOTES.
002900161010    *** 04/18/2011 DLK PRINT PAPER COMMISSION STATEMENT
003000161011    *** 10/10/2016 DLK add producer (Amwins EDT use)
003100170215    *** 12/15/2017 JT  Recompiled for changes on DSPF
003200110418    ***
003300110418    ***
003400110418    ***
003500090514     FFM120D    CF   E             WORKSTN INFDS(WSDS) SFILE(S03SFL:RR3)
003600090514     FAGENCY2   UF A E           K DISK
003700090514     FAGENCY    UF A E           K DISK
003800090514     FAGENL1    IF   E           K DISK    PREFIX(I:1) RENAME(AGENR:AGL1)
003900090514     FCARMKSZ4  IF   E           K DISK
004000090514     FAGCAROV0  O  A E             DISK
004100090514     Fagchist0  O  A E             DISK
004200091103     FAGRHIST0  O  A E             DISK    PREFIX(K:1)
004300090514     FAGCYRMG0  UF A E           K DISK
004400090514     FRMGRMST0  IF   E           K DISK
004500090514     FMKTSTSP   UF A E           K DISK
004600090514     FIRMMSTP   IF   E           K DISK
004700090515     FBLITRKP   IF   E           K DISK
004800090519     FBLIEEOP   IF   E           K DISK
004900090514   X***X
005000090519     D                 DS
005100090519     D @@AS                    1     30A
005200090519     D ASR                     1     30A   DIM(15)
005300090519     D   AS01                  1      2A
005400090519     D   AS02                  3      4A
005500090519     D   AS03                  5      6A
005600090519     D   AS04                  7      8A
005700090519     D   AS05                  9     10A
005800090519     D   AS06                 11     12A
005900090519     D   AS07                 13     14A
006000090519     D   AS08                 15     16A
006100090519     D   AS09                 17     18A
006200090519     D   AS10                 19     20A
006300090519     D   AS11                 21     22A
006400090519     D   AS12                 23     24A
006500090519     D   AS13                 25     26A
006600090519     D   AS14                 27     28A
006700090519     D   AS15                 29     30A
006800090519     ***
006900090519     D                 DS
007000090519     D @@AL                    1    300A
007100090519     D ALR                     1    300A   DIM(15)
007200090519     D   AL01                  1     20A
007300090519     D   AL02                 21     40A
007400090519     D   AL03                 41     60A
007500090519     D   AL04                 61     80A
007600090519     D   AL05                 81    100A
007700090519     D   AL06                101    120A
007800090519     D   AL07                121    140A
007900090519     D   AL08                141    160A
008000090519     D   AL09                161    180A
008100090519     D   AL10                181    200A
008200090519     D   AL11                201    220A
008300090519     D   AL12                221    240A
008400090519     D   AL13                241    260A
008500090519     D   AL14                261    280A
008600090519     D   AL15                281    300A
008700090519     ***
008800090519     D                 DS
008900090519     D @@AD                    1    150A
009000090519     D ADR                     1    150A   DIM(15)
009100090519     D   AD01                001    010A
009200090519     D   AD02                011    020A
009300090519     D   AD03                021    030A
009400090519     D   AD04                031    040A
009500090519     D   AD05                041    050A
009600090519     D   AD06                051    060A
009700090519     D   AD07                061    070A
009800090519     D   AD08                071    080A
009900090519     D   AD09                081    090A
010000090519     D   AD10                091    100A
010100090519     D   AD11                101    110A
010200090519     D   AD12                111    120A
010300090519     D   AD13                121    130A
010400090519     D   AD14                131    140A
010500090519     D   AD15                141    150A
010600090519     ***
010700090519     D                 DS
010800090519     D @@ES                    1    165A
010900090519     D ESR                     1    165A   DIM(15)
011000090519     D   ES01                001    011A
011100090519     D   ES02                012    022A
011200090519     D   ES03                023    033A
011300090519     D   ES04                034    044A
011400090519     D   ES05                045    055A
011500090519     D   ES06                056    066A
011600090519     D   ES07                067    077A
011700090519     D   ES08                078    088A
011800090519     D   ES09                089    099A
011900090519     D   ES10                100    110A
012000090519     D   ES11                111    121A
012100090519     D   ES12                122    132A
012200090519     D   ES13                133    143A
012300090519     D   ES14                144    154A
012400090519     D   ES15                155    165A
012500090519     ***
012600090519     D                 DS
012700090519     D @@ER                    1    120A
012800090519     D ERR                     1    120A   DIM(15)
012900090519     D   ER01                001    008A
013000090519     D   ER02                009    016A
013100090519     D   ER03                017    024A
013200090519     D   ER04                025    032A
013300090519     D   ER05                033    040A
013400090519     D   ER06                041    048A
013500090519     D   ER07                049    056A
013600090519     D   ER08                057    064A
013700090519     D   ER09                065    072A
013800090519     D   ER10                073    080A
013900090519     D   ER11                081    088A
014000090519     D   ER12                089    096A
014100090519     D   ER13                097    104A
014200090519     D   ER14                105    112A
014300090519     D   ER15                113    120A
014400090519     ***
014500090519     D                 DS
014600090519     D @@ED                    1    150A
014700090519     D EDR                     1    150A   DIM(15)
014800090519     D   ED01                001    010A
014900090519     D   ED02                011    020A
015000090519     D   ED03                021    030A
015100090519     D   ED04                031    040A
015200090519     D   ED05                041    050A
015300090519     D   ED06                051    060A
015400090519     D   ED07                061    070A
015500090519     D   ED08                071    080A
015600090519     D   ED09                081    090A
015700090519     D   ED10                091    100A
015800090519     D   ED11                101    110A
015900090519     D   ED12                111    120A
016000090519     D   ED13                121    130A
016100090519     D   ED14                131    140A
016200090519     D   ED15                141    150A
016300090519     ***
016400090514     D                UDS
016500090514     D  CONAME               201    240
016600090514     ***
016700090514     D DS@IRM        E DS                  EXTNAME(IRMMSTP)
016800090514     D  IMTXT1                 4     43A
016900090514     D  IMTXT2                44     83A
017000090514    ***
017100090514     D WSDS            DS
017200090514     D  FKEY                 369    369A
017300090514     ***
017400090514     D  F1             C                   CONST(X'31')
017500090514     D  F2             C                   CONST(X'32')
017600090514     D  F3             C                   CONST(X'33')
017700090514     D  F4             C                   CONST(X'34')
017800090514     D  F5             C                   CONST(X'35')
017900090514     D  F6             C                   CONST(X'36')
018000090514     D  F7             C                   CONST(X'37')
018100090514     D  F8             C                   CONST(X'38')
018200090514     D  F9             C                   CONST(X'39')
018300090514     D  F10            C                   CONST(X'3A')
018400090514     D  F11            C                   CONST(X'3B')
018500090514     D  F12            C                   CONST(X'3C')
018600090514     D  F13            C                   CONST(X'B1')
018700090514     D  F14            C                   CONST(X'B2')
018800090514     D  F15            C                   CONST(X'B3')
018900090514     D  F16            C                   CONST(X'B4')
019000090514     D  F17            C                   CONST(X'B5')
019100090514     D  F18            C                   CONST(X'B6')
019200090514     D  F19            C                   CONST(X'B7')
019300090514     D  F20            C                   CONST(X'B8')
019400090514     D  F21            C                   CONST(X'B9')
019500090514     D  F22            C                   CONST(X'BA')
019600090514     D  F23            C                   CONST(X'BB')
019700090514     D  F24            C                   CONST(X'BC')
019800090514     ***
019900090514     D @VP             S              1A
020000090519     D #XSX            S              8S 0
020100090514     D #ISO            S               D   DATFMT(*ISO)
020200090514     D #USA            S               D   DATFMT(*USA)
020300090514    ***
020400090514      *
020500090514    *** TIMESTAMP FIELDS DATA STRUCTURE
020600090514      *
020700090514     D @TIMESTAMP      DS
020800090514     D  #TSCYMD                1      8S 0
020900090514     D  #TSTIME                9     14S 0
021000090514     D  @TSJOB                15     24
021100090514     D  @TSUSER               25     34
021200090514     D  #TSNBR                35     40S 0
021300090514    * *
021400090514     D @TS40           S             40A
021500090514    ***
021600090514     D ORIG#END        S              8S 0
021700090515     d ds@ag2        e ds                  extname(agency2)
021800090514     d ds@ag         e ds                  extname(agency)
021900090514     D WDRMM         E DS                  EXTNAME(RMGRMST0)
022000091103     D DS@AGR        E DS                  EXTNAME(AGCYRMG0)
022100090514   X***X
022200090514     C                   DOU       @STEP = 'EXIT'
022300090514     C     @STEP         CASEQ     'STEP1'       $STEP1
022400090514     C     @STEP         CASEQ     'STEP2'       $STEP2
022500090514     C     @STEP         CASEQ     'STEP3'       $STEP3
022600090514     C     @STEP         CASEQ     'STEP4'       $STEP4
022700090514     C     @STEP         CASEQ     'STEP5'       $STEP5
022800090514     C                   ENDCS
022900090514     C                   ENDDO
023000090514     C*
023100090514     C                   MOVE      *ON           *INLR
023200090514     C*
023300090514   S***S
023400090514     C     *INZSR        BEGSR
023500090514     C                   MOVE      'STEP1'       @STEP             5
023600090514     C                   MOVE      *ZEROS        RR3               3 0
023700090514     C                   EVAL      @CTYPE = 'A'
023800090514     C                   ENDSR
023900090514   S***S
024000090514     C     $STEP1        BEGSR
024100090514    ***
024200090514     C                   EXFMT     S01
024300090514    ***
024400090514     C                   IF        FKEY = F7
024500090514     C                   MOVEL(P)  'EXIT'        @STEP
024600090514     C                   LEAVESR
024700090514     C                   ENDIF
024800101025    ***
024900101025     C                   IF        CODE = '***'
025000101025     C                   CALL      'KTHMNUC'
025100101025     C                   LEAVESR
025200101025     C                   ENDIF
025300090514    ***
025400090514     C                   IF        FKEY = F9
025500090514     c                   exsr      $f9
025600090514     C                   LEAVESR
025700090514     C                   ENDIF
025800090514    ***
025900090519     C                   IF        FKEY = F10
026000090519    *C                   CALL      'WRKLKICL'
026100090519     C                   LEAVESR
026200090519     C                   ENDIF
026300090519    ***
026400090514     C                   IF        FKEY = F11
026500090514     c                   exsr      $f11
026600090514     C                   LEAVESR
026700090514     C                   ENDIF
026800090514    ***
026900090514     C                   IF        FKEY = F13
027000090514     c                   exsr      $f13
027100090514     C                   LEAVESR
027200090514     C                   ENDIF
027300090514    ***
027400090514     C                   IF        FKEY = F15
027500090514     c                   CALL      'WRKIRMCL'
027600090514     C                   LEAVESR
027700090514     C                   ENDIF
027800090514    ***
027900090514     C                   IF        FKEY = F5 and code <> *blanks
028000090514     c                   exsr      $f5
028100090514     C                   LEAVESR
028200090514     C                   ENDIF
028300090514    ***
028400091104     C                   IF        FKEY = F8 and code <> *blanks
028500091104     c                   exsr      $f8
028600091104     C                   LEAVESR
028700091104     C                   ENDIF
028800091104    ***
028900090514     C                   IF        FKEY = F3
029000090514     C                   MOVEL(P)  'STEP4'       @STEP
029100090514     C                   LEAVESR
029200090514     C                   ENDIF
029300090514    ***
029400090514     C                   IF        CODE <> *BLANKS
029500090514     C                   MOVEL(P)  'STEP2'       @STEP
029600090514     C                   ENDIF
029700090514    ***
029800090514     C                   ENDSR
029900090514   S***S
030000090514     C     $f9           BEGSR
030100090514    ***
030200090514     c                   CALL      'FM121CL'
030300090514     c                   parm                    code
030400090514    ***
030500090514     C                   ENDSR
030600090514   S***S
030700090514     C     $f11          BEGSR
030800090514    ***
030900090514     c                   CALL      'WRKARMCL'
031000090514    ***
031100090514     C                   ENDSR
031200090514   S***S
031300090514     C     $f13          BEGSR
031400090514    ***
031500090514     c                   CALL      'WRKRMMCL'
031600090514    ***
031700090514     C                   ENDSR
031800090514   S***S
031900090514     C     $f5           BEGSR
032000090514    ***
032100090514     c                   CALL      'FM122CL'
032200090514     c                   parm                    code
032300090514    ***
032400090514     C                   ENDSR
032500090514   S***S
032600091104     C     $f8           BEGSR
032700091104    ***
032800091104     c                   CALL      'FM126CL'
032900091104     c                   parm                    code
033000091104    ***
033100091104     C                   ENDSR
033200091104   S***S
033300090514     C     $STEP2        BEGSR
033400090514    ***
033500090514     C                   CLEAR                   DS@IRM
033600090514     c                   clear                   RAGCHIST
033700091103     C                   CLEAR                   DS@AGR
033800091103     c                   clear                   RAGRHIST
033900090515     c                   clear                   ds@ag2
034000090514     c                   clear                   ds@ag
034100090515     C                   SETOFF                                       455051
034200090515     C                   SETOFF                                       5253
034300090514     C                   EVAL      INAC = *BLANKS
034400090514     C                   MOVEL(P)  CODE          ACODE
034500090515     C                   MOVEL(P)  CODE          A2CODE
034600090514    ***
034700090514     C     CODE          CHAIN     AGENR
034800090514    1C                   IF        NOT %FOUND(AGENCY)
034900090514     C                   CLEAR                   AGENR
035000090514     C                   EVAL      AGACH = 'N'
035100091105     C                   MOVE      *OFF          *IN36
035200091105     C                   EVAL      A2LREQ = 'N'
035300091105     C                   EVAL      S2LREQ = 'N'
035400110418     C                   EVAL      A2PAPER = 'N'
035500110418     C                   EVAL      S2PAPER = 'N'
035600090514     C                   MOVE      *OFF          *IN36
035700090514     C                   CLEAR                   D_SGR
035800090514     C                   CLEAR                   D_LGR
035900090514     C                   CLEAR                   D_RMGR
036000090514     C                   CLEAR                   AGCYRMGR
036100090514     C                   EVAL      ARAGCY = CODE
036200091105     C                   EVAL      A2CODE = CODE
036300090514     C                   EVAL      ARSGR = '*UA*'
036400090514     C                   EVAL      ARLGR = '*UA*'
036500090514     C                   EVAL      ARRMGR = '*UA*'
036600090514     c                   eval      hbefore = ds@ag
036700091103     c                   Eval      Kbefore = ds@AGR
036800090514     C                   EVAL      ORIG#END = 0
036900090514     C                   EVAL      S2EFDT = 0
037000090514     C                   EVAL      S2TMDT = 0
037100090514     C                   EVAL      INAC = *BLANKS
037200090514     C                   MOVEL     'STEP3'       @STEP
037300090514    1C                   LEAVESR
037400090514     C                   ENDIF
037500090514    ***
037600090515     C     CODE          CHAIN     AGEN2R
037700090515     C                   EVAL      S2LREQ = A2LREQ
037800110418     C                   EVAL      S2PAPER = A2PAPER
037900161010     C                   EVAL      S2prod  = A2prod
038000090515    ***
038100090514     C                   MOVE      AGEFDT        #ISA
038200090514     C                   EXSR      $ISOUSA
038300090514     C                   MOVE      #ISA          S2EFDT
038400090514     C                   EVAL      ORIG#END = AGTMDT
038500090514     C                   MOVE      AGTMDT        #ISA
038600090514     C                   EXSR      $ISOUSA
038700090514     C                   MOVE      #ISA          S2TMDT
038800090514     C                   MOVE      *ON           *IN36
038900090514     C                   EXSR      $RMG
039000090514    ***
039100090514     C                   EXSR      $LICENSE
039200090514    ***
039300090514     C                   IF        AGTMDT = 0
039400090514     C                   EVAL      *IN50 = *ON
039500090514     C                   EVAL      *IN51 = *ON
039600090514     C                   MOVEL     'STEP3'       @STEP
039700091103     c                   eval      Kbefore =ds@AGR
039800090514     c                   eval      hbefore =ds@ag
039900090514    1C                   LEAVESR
040000090514     C                   ENDIF
040100090514    ***
040200090514    * * TERMED/INACTIVE
040300090514     C                   EVAL      *IN52 = *ON
040400090514    * *
040500090514     C     KL#MS         CHAIN     MKTSTSR
040600090514     C                   IF        %FOUND(MKTSTSP)
040700090514    * *
040800090514     C                   EVAL      INAC = MSREASN
040900090514     C                   IF        %SUBST(MSREASN:1:1) = 'I'
041000090514     C                   EVAL      *IN50 = *OFF
041100090514     C                   EVAL      *IN51 = *ON
041200090514     C                   ELSE
041300090514     C                   EVAL      *IN50 = *ON
041400090514     C                   EVAL      *IN51 = *OFF
041500090514     C                   ENDIF
041600090514    * *
041700090514     C     MSREASN       CHAIN     IRMMSTR
041800090514     C                   IF        NOT %FOUND(IRMMSTP)
041900090514     C                   EVAL      IMTEXT = '* UNSELECTED REASON *'
042000090514     C                   ENDIF
042100090514    * *
042200090514     C                   ELSE
042300090514    * *
042400090514     C                   EVAL      IMTEXT = '* UNSELECTED REASON *'
042500090514     C                   EVAL      *IN50 = *ON
042600090514     C                   EVAL      *IN51 = *OFF
042700090514    * *
042800090514     C                   ENDIF
042900090514    ***
043000091103     c                   eval      Kbefore =ds@agR
043100090514     c                   eval      hbefore =ds@ag
043200090514     C                   MOVEL     'STEP3'       @STEP
043300090514    ***
043400090514     C                   ENDSR
043500090514   S***S
043600090514    *C     $LICENSE      BEGSR
043700090514    ***
043800090515     C                   IF        AGTMDT <> 0
043900090515     C                   LEAVESR
044000090515     C                   ENDIF
044100090515    ***
044200090515    *** SMAN CHECK
044300090515     C                   IF        A2CODE = 'N'
044400090515     C                   MOVEL(P)  CODE          P_AGCY            3
044500090515     C                   CALL      'FM125CL'
044600090515     C                   PARM                    P_AGCY
044700090515     C                   IF        P_AGCY = 'EXP'
044800090515     C                   EVAL      *IN53 = *ON
044900090514     C                   ENDIF
045000090515     C                   LEAVESR
045100090515     C                   ENDIF
045200090515    ***
045300090515    *** AGENCY CHECK
045400090515     C                   MOVE      'A'           KF@TYPE           1
045500090515     C     KL#BLT        KLIST
045600090515     C                   KFLD                    KF@TYPE
045700090515     C                   KFLD                    CODE
045800090515    ***
045900090515     C     KL#BLT        CHAIN     BLITRKR
046000090515     C                   IF        %FOUND(BLITRKP)
046100090515     C                   EVAL      *IN53 = *ON
046200090515    0C                   ENDIF
046300090519    ***
046400090519     C     KL#BLT        CHAIN     BLIEEOR
046500090519     C                   IF        %FOUND(BLIEEOP)
046600090519     C                   EVAL      *IN53 = *ON
046700090519    0C                   ENDIF
046800090514    ***
046900090514     C                   ENDSR
047000090514   S***S
047100090514    *C     $RMG          BEGSR
047200090514    ***
047300090514     C                   MOVEL(P)  'N/A'         D_SGR
047400090514     C                   MOVEL(P)  'N/A'         D_LGR
047500090514     C                   MOVEL(P)  'N/A'         D_RMGR
047600090514    ***
047700090514     C     CODE          CHAIN     AGCYRMGR
047800090514     C                   IF        NOT %FOUND(AGCYRMG0)
047900090514     C                   CLEAR                   AGCYRMGR
048000090514     C                   EVAL      ARAGCY = CODE
048100090514     C                   EVAL      ARSGR = '*UA*'
048200090514     C                   EVAL      ARLGR = '*UA*'
048300090514     C                   EVAL      ARRMGR = '*UA*'
048400090514     C                   WRITE     AGCYRMGR
048500090514     C     CODE          CHAIN     AGCYRMGR
048600091103     c                   eval      Kbefore =ds@agR
048700090514     C                   ENDIF
048800090514    ***
048900090514     C     ARSGR         CHAIN     RMGRMSTR
049000090514     C                   IF        %FOUND(RMGRMST0)
049100090514     C                   MOVEL(P)  RMNAME        D_SGR
049200090514     C                   ENDIF
049300090514    ***
049400090514     C     ARLGR         CHAIN     RMGRMSTR
049500090514     C                   IF        %FOUND(RMGRMST0)
049600090514     C                   MOVEL(P)  RMNAME        D_LGR
049700090514     C                   ENDIF
049800090514    ***
049900090514     C     ARRMGR        CHAIN     RMGRMSTR
050000090514     C                   IF        %FOUND(RMGRMST0)
050100090514     C                   MOVEL(P)  RMNAME        D_RMGR
050200090514     C                   ENDIF
050300090514    ***
050400090514     C                   ENDSR
050500090514   S***S
050600090514     C     $ISOUSA       BEGSR
050700090514    ***
050800090514     C                   MOVE      'Y'           @@GD              1
050900090514     C                   IF        #ISA = 0
051000090514     C                   MOVE      'N'           @@GD
051100090514     C                   ELSE
051200090514     C     *ISO          TEST (DE)               #ISA
051300090514     C                   IF        %ERROR
051400090514     C                   MOVE      'N'           @@GD
051500090514     C                   ELSE
051600090514     C                   MOVE      #ISA          #ISO
051700090514     C                   MOVE      #ISO          #USA
051800090514     C                   MOVE      #USA          #ISA              8 0
051900090514     C                   ENDIF
052000090514     C                   ENDIF
052100090514     C                   ENDSR
052200090514   S***S
052300090514     C     $STEP3        BEGSR
052400090514    ***
052500090514     C                   EXFMT     S02
052600090514     C                   MOVE      *BLANKS       S2MSG
052700090514     C                   MOVEA     '000'         *IN(41)
052800090514    ***
052900090514     C                   IF        FKEY = F1
053000090514     C                   IF        *IN45 = *ON
053100090514     C                   EVAL      *IN45 = *OFF
053200090514     C                   ELSE
053300090514     C                   MOVEL(P)  'STEP1'       @STEP
053400090514     C                   ENDIF
053500090514     C                   LEAVESR
053600090514     C                   ENDIF
053700110418    ***
053800110418     C                   IF        FKEY = F2
053900110418     C                   EVAL      @NTEPARM = '001' + ACODE
054000110418     C                   CALL      'MDC010  '
054100110418     C                   PARM                    @NTEPARM         11
054200110418     C                   LEAVESR
054300110418     C                   ENDIF
054400090514    ***
054500090514     C                   IF        FKEY = F4
054600090514     C                   EXSR      $F4S02
054700090514     C                   LEAVESR
054800090514     C                   ENDIF
054900090514    ***
055000090514     C                   IF        FKEY = F7
055100090514     C                   MOVEL(P)  'EXIT'        @STEP
055200090514     C                   LEAVESR
055300090514     C                   ENDIF
055400090514    ***
055500091105     C                   IF        FKEY = F9
055600091105     C                   CALL      'FM123CL'
055700091105     C                   PARM                    ACODE
055800091105     C                   LEAVESR
055900091105     C                   ENDIF
056000091105    ***
056100090514     C                   IF        FKEY = F8
056200090519     C                   EXSR      $F08S02
056300090514     C                   LEAVESR
056400090514     C                   ENDIF
056500091105    ***
056600091105    1C                   IF        FKEY = F10
056700091105    *C                   CALL      'WRKLKICL'
056800091105     C                   LEAVESR
056900091105    1C                   ENDIF
057000090514    ***
057100090514    1C                   IF        FKEY = F11
057200090514     C                   EXSR      $F11S02
057300090514     C                   LEAVESR
057400090514    1C                   ENDIF
057500090514    ***
057600090514     C                   EXSR      $S02VAL
057700090514    * *
057800090514     C                   IF        @VP = 'N'
057900090514     C                   EVAL      *IN45 = *OFF
058000090514     C                   LEAVESR
058100090514    1C                   ENDIF
058200090514    * *
058300090514     C                   IF        (*IN52 = *ON AND S2TMDT <> 0) OR
058400090514     C                             S2TMDT  = 0
058500090514     C                   EVAL      *IN45 = *ON
058600090514     C                   ENDIF
058700090514    * *
058800090514     C                   IF        ORIG#END = 0 AND S2TMDT  <> 0
058900090514     C                   EVAL      *IN52 = *ON
059000090514     C                   ENDIF
059100090514    * *
059200090514     C                   IF        ORIG#END <> 0 AND S2TMDT  = 0
059300090514     C                   EVAL      *IN52 = *OFF
059400090514     C                   ENDIF
059500090514    * *
059600090514     C                   IF        S2TMDT  = 0
059700090514     C                   EVAL      *IN50 = *ON
059800090514     C                   EVAL      *IN51 = *ON
059900090514     C                   LEAVESR
060000090514     C                   ENDIF
060100090514    * *
060200090514     C                   IF        INAC = *BLANKS
060300090514     C                   EVAL      *IN50 = *ON
060400090514     C                   EVAL      *IN51 = *OFF
060500090514     C                   ELSE
060600090514     C                   IF        %SUBST(MSREASN:1:1) = 'I'
060700090514     C                   EVAL      *IN50 = *OFF
060800090514     C                   EVAL      *IN51 = *ON
060900090514     C                   ELSE
061000090514     C                   EVAL      *IN50 = *ON
061100090514     C                   EVAL      *IN51 = *OFF
061200090514     C                   ENDIF
061300090514     C                   ENDIF
061400090519    ***
061500090519     C                   ENDSR
061600090519   S***S
061700090519     C     $F08S02       BEGSR
061800090519    ***
061900090519     C                   MOVE      *BLANKS       @@AS
062000090519     C                   MOVE      *BLANKS       @@AL
062100090519     C                   MOVE      *BLANKS       @@AD
062200090519     C                   MOVE      *BLANKS       @@ER
062300090519     C                   MOVE      *BLANKS       @@ES
062400090519     C                   MOVE      *BLANKS       @@ED
062500090519     C                   MOVE      *ZEROS        Z                 3 0
062600090519     C                   MOVE      *BLANKS       H@STATE           2
062700090519     C                   MOVE      *BLANKS       H@RELID           8
062800090519    ***
062900090519     C     KL#BLT        SETLL     BLITRKR
063000090519     C                   DOU       %EOF(BLITRKP)
063100090519     C     KL#BLT        READE     BLITRKR
063200090519     C                   IF        NOT %EOF(BLITRKP)
063300090519    ***
063400090519     C                   IF        LTSTAT <> H@STATE
063500090519     C                   EVAL      H@STATE = LTSTAT
063600090519     C                   ADD       1             Z
063700090519     C                   EVAL      ASR(Z) = LTSTAT
063800090519     C                   EVAL      ALR(Z) = LTLICN
063900090519     C     LTEXPD        MULT      10000.0001    #XSX
064000090519     C                   EVAL      ADR(Z) = %EDITC(#XSX:'Y')
064100090519     C                   ENDIF
064200090519    ***
064300090519     C                   ENDIF
064400090519     C                   ENDDO
064500090514    ***
064600090519     C                   MOVE      *ZEROS        Z
064700090519     C     KL#BLT        SETLL     BLIEEOR
064800090519     C                   DOU       %EOF(BLIEEOP)
064900090519     C     KL#BLT        READE     BLIEEOR
065000090519     C                   IF        NOT %EOF(BLIEEOP)
065100090519    ***
065200090519     C                   IF        ETRELID <> H@RELID
065300090519     C                   EVAL      H@RELID = ETRELID
065400090519     C                   ADD       1             Z
065500090519     C                   EVAL      ERR(Z) = ETRELID
065600090519     C                   EVAL      ESR(Z) = ETSAS
065700090519     C     ETEXPD        MULT      10000.0001    #XSX
065800090519     C                   EVAL      EDR(Z) = %EDITC(#XSX:'Y')
065900090519     C                   ENDIF
066000090519    ***
066100090519     C                   ENDIF
066200090519     C                   ENDDO
066300090519    ***
066400090519     C                   DOW       FKEY <> F1
066500090519    ***
066600090519     C                   EXFMT     S04
066700090519    ***
066800090519     C                   ENDDO
066900090519    ***
067000090514     C                   ENDSR
067100090514   S***S
067200090514     C     $F11S02       BEGSR
067300090514    ***
067400090514     C                   EXSR      $S02VAL
067500090514    ***
067600090514    2C                   IF        @VP = 'N'
067700090514     C                   EVAL      *IN45 = *OFF
067800090514     C                   LEAVESR
067900090514     C                   ENDIF
068000090514    ***
068100090514     C                   EVAL      ORIG#END = AGTMDT
068200090514    ***
068300090514     C                   IF        AGCODE = *BLANKS
068400090514     C                   MOVEL     ACODE         AGCODE
068500090514     C                   WRITE     AGENR
068600090515     C                   WRITE     AGEN2R
068700090514     C                   WRITE     AGCYRMGR
068800090514    ***
068900090514     C                   IF        S2TMDT  <> 0 AND INAC <> *BLANKS
069000090514     C                   CLEAR                   MKTSTSR
069100090514     C                   EVAL      MSCTYPE = 'A'
069200090514     C                   EVAL      MSCODE = ACODE
069300090514     C                   EVAL      MSREASN = INAC
069400090514     C                   CALL      'TIMESTMP'
069500090514     C                   PARM                    @TS40
069600090514     C                   MOVEL     @TS40         @TIMESTAMP
069700090514     C                   EVAL      MSCDATE = #TSCYMD
069800090514     C                   EVAL      MSCUSER = @TSUSER
069900090514     C                   WRITE(E)  MKTSTSR
070000090514    2C                   ENDIF
070100090514    ***
070200090514     c                   exsr      $history
070300090514     C                   ELSE
070400090515     C                   UPDATE    AGEN2R
070500090514     C                   UPDATE    AGENR
070600090514     C                   UPDATE    AGCYRMGR
070700090514     c                   exsr      $history
070800090514     **
070900090514    1C                   IF        S2TMDT = 0 OR
071000090514     C                             (S2TMDT <> 0 AND INAC = *BLANKS)
071100090514     C                   EXSR      $INACTDLT
071200090514     C                   ENDIF
071300090514     **
071400090514     C                   IF        INAC <> *BLANKS AND S2TMDT <> 0
071500090514     C                   EXSR      $INACTWRT
071600090514     C                   ENDIF
071700090514    ***
071800090514     C                   ENDIF
071900090514    ***
072000090514     C                   EVAL      *IN45 = *OFF
072100090514     C                   MOVEL(P)  'STEP2'       @STEP
072200090514    ***
072300090514     C                   ENDSR
072400090514   S***S
072500090514     C     $INACTDLT     BEGSR
072600090514    ***
072700090514     C     KL#MS         KLIST
072800090514     C                   KFLD                    @CTYPE            1
072900090514     C                   KFLD                    ACODE
073000090514     C     KL#MS         CHAIN     MKTSTSR
073100090514     C                   IF        %FOUND(MKTSTSP)
073200090514     C     KL#MS         DELETE    MKTSTSR
073300090514     C                   ENDIF
073400090514    ***
073500090514     C                   ENDSR
073600090514   S***S
073700090514     C     $INACTWRT     BEGSR
073800090514    ***
073900090514     C                   CALL      'TIMESTMP'
074000090514     C                   PARM                    @TS40
074100090514     C                   MOVEL     @TS40         @TIMESTAMP
074200090514    ***
074300090514     C     KL#MS         CHAIN     MKTSTSR
074400090514    ***
074500090514     C                   IF        %FOUND(MKTSTSP)
074600090514    * *
074700090514     C                   IF        MSREASN <> INAC
074800090514     C                   EVAL      MSREASN = INAC
074900090514     C                   MOVEL     @TSUSER       MSCUSER
075000090514     C                   MOVE      #TSCYMD       MSCDATE
075100090514     C                   UPDATE    MKTSTSR
075200090514     C                   ENDIF
075300090514    * *
075400090514     C                   LEAVESR
075500090514     C                   ENDIF
075600090514    ***
075700090514     C                   CLEAR                   MKTSTSR
075800090514     C                   EVAL      MSCTYPE = 'A'
075900090514     C                   EVAL      MSCODE = ACODE
076000090514     C                   EVAL      MSREASN = INAC
076100090514     C                   MOVEL     @TSUSER       MSCUSER
076200090514     C                   MOVE      #TSCYMD       MSCDATE
076300090514     C                   WRITE     MKTSTSR
076400090514    ***
076500090514     C                   ENDSR
076600090514   S***S
076700090514     C     $S02VAL       BEGSR
076800090514    ***
076900090514     C                   EVAL      @VP = 'N'
077000090515    ***
077100090515      * LICENSING REQUIRED
077200090515     C                   IF        S2LREQ = *BLANKS OR
077300090515     C                             (S2LREQ <> 'Y' AND S2LREQ <> 'N')
077400090515     C                   EVAL      S2MSG = 'LIC REQ MUST BE Y OR N'
077500090515     C                   LEAVESR
077600090515     C                   ENDIF
077700090515     C                   EVAL      A2LREQ = S2LREQ
077800090514    ***
077900110418      * PRINT A PAPER COPY COMMISSION STATEMENT
078000110418     C                   IF        S2PAPER = *BLANKS OR
078100110418     C                             (S2PAPER <> 'Y' AND S2PAPER <> 'N')
078200110418     C                   EVAL      S2MSG = 'PRT COMM STMT MUST BE Y OR N'
078300110418     C                   LEAVESR
078400110418     C                   ENDIF
078500110418     C                   EVAL      A2PAPER = S2PAPER
078600161010
078700161010      * producer code - no editing at this time
078800161010     C                   EVAL      A2prod = S2prod
078900161010
079000110418    ***
079100100512      * ach: y=yes, n=no, i=internal commission, H=HOLD
079200090514     C                   IF        AGACH = *BLANKS OR (AGACH <> 'Y' AND
079300100512     C                             AGACH <> 'H' AND
079400090514     C                             AGACH <> 'N' and agach <> 'I')
079500100512     C                   EVAL      S2MSG = 'ACH MUST BE Y, N, H, OR I'
079600090514     C                   LEAVESR
079700090514     C                   ENDIF
079800090514    ***
079900090514     C                   MOVE      S2EFDT        #ISA
080000090514     C                   EXSR      $USAISO
080100090514     C                   IF        @@GD = 'N'
080200090514     C                   EVAL      S2MSG = 'INVALID EFFECTIVE DTE'
080300090514     C                   LEAVESR
080400090514     C                   ELSE
080500090514     C                   MOVE      #ISA          AGEFDT
080600090514     C                   ENDIF
080700090514    ***
080800090514     c                   if        agtxid = 0
080900090514     c                   eval      S2MSG = 'TAX ID IS REQUIRED.'
081000090514     c                   leavesr
081100090514     c                   endif
081200090514    ***
081300090514     C                   MOVE      S2TMDT        #ISA
081400090514     C                   EXSR      $USAISO
081500090514    1C                   IF        S2TMDT = 0 AND AGTMDT <> 0
081600090514     C                   MOVE      *ZEROS        AGTMDT
081700090514    1C                   ELSE
081800090514    2C                   IF        S2TMDT <> 0
081900090514    3C                   IF        @@GD = 'N'
082000090514     C                   EVAL      S2MSG = 'INVALID TERMINATE DTE'
082100090514     C                   LEAVESR
082200090514    3C                   ELSE
082300090514     C                   MOVE      #ISA          AGTMDT
082400090514    3C                   ENDIF
082500090514    2C                   ENDIF
082600090514    1C                   ENDIF
082700090514    ***
082800090514     c                   if        agtmdt > 0 and agefdt > agtmdt
082900090514     C                   EVAL      S2MSG = 'INVALID TERMINATE DTE'
083000090514     C                   LEAVESR
083100090514    1C                   ENDIF
083200090514    ***
083300090514     C                   CLEAR                   DS@IRM
083400090514     C                   IF        *IN52 = *ON AND INAC <> *BLANKS
083500090514     C     INAC          CHAIN     IRMMSTR
083600090514     C                   IF        NOT %FOUND(IRMMSTP)
083700090514     C                   EVAL      S2MSG = 'INVALID INACTIVE REASON CODE'
083800090514     C                   LEAVESR
083900090514     C                   ENDIF
084000090514     C                   ENDIF
084100090514    ***
084200090514     C                   EVAL      @VP = 'Y'
084300090514    ***
084400090514     C                   ENDSR
084500090514   S***S
084600090514     C     $F4S02        BEGSR
084700090514    ***
084800090514     C                   SELECT
084900090514 001  *
085000090514 001 C                   When      WSFLD = 'D_SGR'
085100090514     C                   Call      'SLCRMM1'                                    *ENTRY LIST
085200090514     C                   Parm                    WWRQS             8            PROGRAM REQUEST
085300090514     C                   Parm                    WWRTN             8            RETURN CODE
085400090514     C                   Parm                    WUPGM            10            LAST PGM NAME
085500090514     C                   Parm                    WDRMM                          RECORD DS
085600090514     C                   IF        WWRTN = *BLANKS
085700090514     C                   Eval      ARSGR = RMCODE
085800090514     C                   MOVEL(P)  RMNAME        D_SGR
085900090514     C                   EVAL      *IN41 = *ON
086000090514E001 C                   Endif
086100090514 001  *
086200090514 001 C                   When      WSFLD = 'D_LGR'
086300090514     C                   Call      'SLCRMM2'                                    *ENTRY LIST
086400090514     C                   Parm                    WWRQS                          PROGRAM REQUEST
086500090514     C                   Parm                    WWRTN                          RETURN CODE
086600090514     C                   Parm                    WUPGM                          LAST PGM NAME
086700090514     C                   Parm                    WDRMM                          RECORD DS
086800090514     C                   IF        WWRTN = *BLANKS
086900090514     C                   Eval      ARLGR = RMCODE
087000090514     C                   MOVEL(P)  RMNAME        D_LGR
087100090514     C                   EVAL      *IN42 = *ON
087200090514E001 C                   Endif
087300090514 001  *
087400090514 001 C                   When      WSFLD = 'D_RMGR'
087500090514     C                   Call      'SLCRMM3'                                    *ENTRY LIST
087600090514     C                   Parm                    WWRQS                          PROGRAM REQUEST
087700090514     C                   Parm                    WWRTN                          RETURN CODE
087800090514     C                   Parm                    WUPGM                          LAST PGM NAME
087900090514     C                   Parm                    WDRMM                          RECORD DS
088000090514     C                   IF        WWRTN = *BLANKS
088100090514     C                   Eval      ARRMGR = RMCODE
088200090514     C                   MOVEL(P)  RMNAME        D_RMGR
088300090514     C                   EVAL      *IN43 = *ON
088400090514E001 C                   Endif
088500090514 001  *
088600090514 001 C                   When      WSFLD = 'INAC'
088700090514     C                   CALL      'SLCIRMCL'
088800090514     C                   PARM      'LOAD'        WRQS              8
088900090514     C                   PARM                    WRTN              8
089000090514     C                   PARM      'SLCIRM'      WPGM             10
089100090514     C                   PARM                    @83              83
089200091105     C                   EVAL      INAC = %SUBST(@83:1:3)
089300090514     C                   EVAL      IMTXT1 = %SUBST(@83:4:40)
089400090514     C                   EVAL      IMTXT2 = %SUBST(@83:44:40)
089500090514     C                   EVAL      DS@IRM = @83
089600090514 001  *
089700090514     C                   ENDSL
089800090514    ***
089900090514     C                   ENDSR
090000090514   S***S
090100090514     C     $history      BEGSR
090200090514    ***
090300091103     c                   eval      Kafter = ds@agR
090400090514     c                   eval      hafter = ds@ag
090500090514     c                   clear                   @timestamp
090600090514     C                   MOVE      *BLANKS       @TS40
090700090514    ***
090800090514     C                   CALL      'TIMESTMP'
090900090514     C                   PARM                    @TS40
091000090514    ***
091100090514     C                   MOVEL     @TS40         @TIMESTAMP
091200090514     C                   MOVEL     @TSUSER       HUSERID
091300090514     C                   MOVE      #TSCYMD       HDATE
091400090514     C                   MOVE      #TSTIME       HTIME
091500090514     C                   MOVEL     @TSJOB        HJOB
091600090514     C                   MOVE      #TSNBR        HNUMBER
091700091103     C                   MOVEL     @TSUSER       KUSERID
091800091103     C                   MOVE      #TSCYMD       KDATE
091900091103     C                   MOVE      #TSTIME       KTIME
092000091103     C                   MOVEL     @TSJOB        KJOB
092100091103     C                   MOVE      #TSNBR        KNUMBER
092200090514    ***
092300091103     C                   eval      Kagcy = agcode
092400090514     C                   eval      hfagcy = agcode
092500090514     C                   IF        HBEFORE <> HAFTER
092600090514     c                   write     RAGCHIST
092700090514     C                   ENDIF
092800091103     C                   IF        KBEFORE <> KAFTER
092900091103     c                   write     RAGRHIST
093000091103     C                   ENDIF
093100090514    ***
093200090514     C                   ENDSR
093300090514   S***S
093400090514     C     $USAISO       BEGSR
093500090514    ***
093600090514     C                   MOVE      'Y'           @@GD              1
093700090514     C                   IF        #ISA = 0
093800090514     C                   MOVE      'N'           @@GD
093900090514     C                   ELSE
094000090514     C     *USA          TEST (DE)               #ISA
094100090514     C                   IF        %ERROR
094200090514     C                   MOVE      'N'           @@GD
094300090514     C                   ELSE
094400090514     C                   MOVE      #ISA          #USA
094500090514     C                   MOVE      #USA          #ISO
094600090514     C                   MOVE      #ISO          #ISA              8 0
094700090514     C                   ENDIF
094800090514     C                   ENDIF
094900090514     C                   ENDSR
095000090514   S***S
095100090514     C     $STEP4        BEGSR
095200090514    ***
095300090514     C                   MOVE      *ZEROS        RR3
095400090514     C                   MOVE      *ZEROS        #CNTREC           3 0
095500090514    ***
095600090514     C                   EXSR      $CLEAR
095700090514     C                   MOVEL(P)  'A'           C3NAME
095800090514     C                   MOVEL(P)  C3NAME        @HLNAME          40
095900090514    ***
096000090514     C                   EXSR      $BUILD
096100090514     C                   MOVEL(P)  'STEP5'       @STEP
096200090514    ***
096300090514     C                   ENDSR
096400090514   S***S
096500090514     C     $STEP5        BEGSR
096600090514    ***
096700090514     C                   EXSR      $DISPLAY
096800090514    ***
096900090514    1C                   IF        FKEY = F1
097000090514     C                   MOVEL(P)  'STEP1'       @STEP
097100090514     C                   LEAVESR
097200090514    1C                   ENDIF
097300090514    ***
097400090514    1C                   IF        @HLNAME <> C3NAME AND C3NAME <> *BLANKS
097500090514     C                   EXSR      $CLEAR
097600090514     C                   EXSR      $BUILD
097700090514     C                   MOVEL(P)  C3NAME        @HLNAME
097800090514     C                   LEAVESR
097900090514    1C                   ENDIF
098000090514    ***
098100090514    1C                   IF        *IN30 = *ON
098200090514     C                   MOVE      '0'           @SFLOOP
098300090514    2C                   DOU       %EOF(AGENL1) OR @SFLOOP = '1'
098400090514     C                   READ      AGL1
098500090514    3C                   IF        NOT %EOF(AGENL1)
098600090514     C                   EXSR      $LOADSFL
098700090514    3C                   ENDIF
098800090514    2C                   ENDDO
098900090514    2C                   IF        %EOF(AGENL1)
099000090514     C                   MOVE      *OFF          *IN29
099100090514    2C                   ELSE
099200090514     C                   MOVE      *ON           *IN29
099300090514    2C                   ENDIF
099400090514     C                   LEAVESR
099500090514    1C                   ENDIF
099600090514    ***
099700090514     C                   EXSR      $CHKSELC
099800090514    ***
099900090514     C                   ENDSR
100000090514   S***S
100100090514     C* INITIALIZE THE SUBFILE
100200090514    ***
100300090514     C     $CLEAR        BEGSR
100400090514    ***
100500090514     C                   MOVEA     '011'         *IN(25)
100600090514     C                   WRITE     S03CTL
100700090514     C                   MOVEA     '010'         *IN(25)
100800090514     C                   Z-ADD     *ZERO         RR3
100900090514    ***
101000090514     C                   ENDSR
101100090514   S***S
101200090514     C* DISPLAY THE SCREEN
101300090514    ***
101400090514     C     $DISPLAY      BEGSR
101500090514    ***
101600090514     C                   WRITE     S03REC
101700090514     C                   EXFMT     S03CTL
101800090514    ***
101900090514     C                   ENDSR
102000090514    ***
102100090514   S***S
102200090514     C* BUILD SUBFILE CONTROL ROUTINE
102300090514    ***
102400090514     C     $BUILD        BEGSR
102500090514    ***
102600090514     C                   MOVE      *ZEROS        #CNTREC
102700090514     C                   MOVE      '0'           @1STLOOP          1
102800090514     C                   MOVEA     '00'          *IN(33)
102900090514     C                   MOVE      '0'           @SFLOOP           1
103000090514    ***
103100090514     C     C3NAME        SETLL     AGL1
103200090514     C                   DOU       %EOF(AGENL1) OR @SFLOOP = '1'
103300090514     C                   READ      AGL1
103400090514     C                   IF        NOT %EOF(AGENL1)
103500090514     C                   EXSR      $LOADSFL
103600090514     C                   ENDIF
103700090514     C                   ENDDO
103800090514    ***
103900090514     C                   IF        %EOF(AGENL1)
104000090514     C                   MOVE      *OFF          *IN29
104100090514     C                   MOVE      *BLANKS       @LRNAME          40
104200090514     C                   ELSE
104300090514     C                   MOVE      *ON           *IN29
104400090514     C                   ENDIF
104500090514    ***
104600090514     C                   ENDSR
104700090514   S***S
104800090514     C* LOAD SUBFILE RECORDS
104900090514    ***
105000090514     C     $LOADSFL      BEGSR
105100090514    ***
105200090514     C                   MOVE      *ON           *IN25
105300090514     C                   MOVE      *BLANKS       SEL03
105400090514     C                   MOVEL(P)  IGCODE        S3CODE
105500090514     C                   MOVEL(P)  IGNAM1        S3NAM1
105600090514     C                   IF        IGTMDT = 0
105700090514     C                   MOVE      *ZEROS        S3TERM
105800090514     C                   ELSE
105900090514     C                   MOVE      IGTMDT        #ISO
106000090514     C                   MOVE      #ISO          #USA
106100090514     C                   MOVE      #USA          S3TERM
106200090514     C                   ENDIF
106300090514     C*
106400090514     C                   ADD       1             RR3
106500090514     C*
106600090514     C                   IF        @1STLOOP = '0'
106700090514     C                   Z-ADD     RR3           SFLPOS
106800090514     C                   MOVE      '1'           @1STLOOP
106900090514     C                   ENDIF
107000090514     C*
107100090514     C                   WRITE     S03SFL
107200090514     C*
107300090514     C                   ADD       1             #CNTREC
107400090514     C                   IF        #CNTREC = 14
107500090514     C                   MOVE      '1'           @SFLOOP
107600090514     C                   ENDIF
107700090514    ***
107800090514     C                   ENDSR
107900090514   S***S
108000090514     C* CHECK SUBFILE SELECTION
108100090514    ***
108200090514     C     $CHKSELC      BEGSR
108300090514    ***
108400090514     C                   MOVE      *OFF          *IN36
108500090514     C*
108600090514     C                   DOU       %EOF(FM120D)
108700090514     C                   READC     S03SFL
108800090514     C                   IF        NOT %EOF(FM120D) AND SEL03 <> *BLANKS
108900090514     C                   MOVEL(P)  S3CODE        CODE
109000090514     C                   MOVEL(P)  'STEP2'       @STEP
109100090514     C                   LEAVESR
109200090514     C                   ENDIF
109300090514     C                   ENDDO
109400090514    ***
109500090514     C                   ENDSR
109600090514   S***S
109700090514     C* ROLL CONTROL
109800090514    ***
109900090514     C     $RELOAD       BEGSR
110000090514     C*
110100090514     C                   MOVEL(P)  C3NAME        @40              40
110200090514     C                   MOVEL(P)  @LRNAME       C3NAME
110300090514     C*
110400090514     C                   EXSR      $BUILD
110500090514     C*
110600090514     C                   MOVEL(P)  @40           C3NAME
110700090514    ***
110800090514     C                   ENDSR
110900090514   S***S
