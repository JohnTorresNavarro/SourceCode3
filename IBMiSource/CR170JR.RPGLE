000100021001     H DFTNAME(CR130JR)
000200991019      **************************************************************************
000300030807      * CR170JR             GROUP BENEFIT SERVICES                       2002
000400010511      *
000500020716      *            WRITTEN BY - S. Zien
000600021001      *            DATE - 10/01/2002
000700010511      *
000800021001      *  DESCRIPTION - Extract Jefferson Pilot records (GUA, GUD) from
000900021024      *                the CR130HSO remittance history file using OPNQRYF.
001000021024      *                Summarize Group# and total plan categories within
001100021024      *                Group#.
001200000801      *
001300031117      * History
001400031117      *
001500031117      * Revised by     S. Zien
001600031117      * Date           11/17/03
001700031117      * Revision       Add parm to show if Original or Late Pay.
001800031117      *
001900040219      * Revised by     S. Zien
002000040219      * Date            2/19/04
002100040219      * Revision       Per Jefferson Pilot & Carol Santucci, zero out
002200040219      *                volume fields if paid field is zero.
002300070412      *
002400070412      * Revised by     S. Zien
002500070412      * Date            4/12/07
002600070412      * Revision       Per Jefferson Pilot (Sabrina Stephens), we should
002700070412      *                use the Invoice Month rather than the Effective Date.
002800070912      *
002900070912      * Revised by     S. Zien
003000070912      * Date            9/12/07
003100070912      * Revision       Remove the 4/12/07 change (per Shelly) so we can
003200070912      *                determine how to accumulate retro adjustments.
003300071204      * 12/04/07 dlk - change orig / late to run sequence
003400091102      *
003500091102      * Revised by     S. Zien
003600091102      * Date           11/02/09
003700091102      * Revision       Per Laurie Snow at Lincoln Financial (her email
003800091102      *                of 11/2/09 9:12 am), plan category PNE should be
003900091102      *                included in code 09 and plan category PNS should
004000091102      *                be included in code 12.
004100071204      *
004200130215      * Revised by     S. Zien
004300130215      * Date            2/15/13
004400130215      * Revision       Per Cindy W. and Dave A. meeting of 2/14/13 only
004500130215      *                count a member once even if he appears in two
004600130215      *                different plans in one of the 17 blocks.  This is
004700130215      *                based on email to Debbie X:
004800130215      *                From: Snow, Laurie A. [mailto:Laurie.Snow@lfg.com]
004900130215      *                Sent: Tuesday, February 12, 2013 9:37 AM
005000130215      *
005100131016      * Revised by     Debbie Bond
005200131016      * Date           10/11/13
005300131016      * Revision       Add additional plans categories.  Also, stop checking
005400131016      *                seq# as we will now only send once a month (per conf
005500131016      *                call meeting with Lincoln on 10/16/2013)
005600131018      *-------------------------------------------------------------------------
005700131018      * Note:  Here are the coverage codes & their corresponding array elements
005800131018      * 01) 02) 03) 04) 05) 06) 07) 08) 09) 10) 11) 12) 13) 14) 15) 16) 17)
005900131018      * PAC PDL PLF PLT PLS PSS POA PVD PSL PVL PVA PSP PVS PVW PTS PDN PSD
006000131018      * PTA PTD PTL PTT         PSA     PNE PVE     PNS         PWD
006100131018      * PAA     PLL
006200131018      * PA1
006300131018      * PS7
006400131018      *-------------------------------------------------------------------------
006500021022     FCR130HSO  IP   E           K DISK
006600021021     FPLNMST    IF   E           K DISK
006700021022     FACCMST    IF   E           K DISK
006800030807     FCR170J    O    E             DISK
006900030807     FCR170JP   O    E             PRINTER OFLIND(*IN91)
0070000210010124 D                UDS
0071000210010125 D  LMDY                  85     92  0
007200021022     D TIME_DATE                     12  0
007300021022     D  TIME                          6  0 OVERLAY(TIME_DATE)
007400021024010   *   Work array - Strip dashes from Group# field.
007500021010010  D DASH            S              1    DIM(11)
007600021024010   *   Work array - Strip dashes from Group# field.
007700021010010  D DAS2            S              1    DIM(11)
007800021023010   *   Work array to keep track of coverage codes.
007900021203010  D Box             S              2    DIM(17)
008000021024     D B               S              2  0 Inz(01)
008100021025     D Sign            S              1    Inz(*Blank)
008200021024    ?D NoErrorMsg      C                   '***   NO BILL LOCATION ERRORS   ***'
0083000210210035 ICRHSTR        01
0084000210240072 I                                          CGROUP        L1
008500021001      *
008600021022     C     *In01         Ifeq      *On
0087000709124/07 C     EFFDT         Ifeq      CEFFDT
008800021209     C                   Exsr      Process
008900020716     C                   End
009000021024     C                   End
009100021024      *
009200021024     CL1                 Exsr      Summarize
009300030807     CL1                 Exsr      WriteCR170J
009400021024      *
009500021024     CLR                 Exsr      EndProgram
009600020716      *___________________________________________________________________
009700020716      * Main Logic
009800020716      *___________________________________________________________________
009900020716     C     Process       BEGSR
010000021022      *---
010100021022      * Do not process if account has been termed.
010200021022      *---
010300021022     C     AccKey        Chain     ACCMST
010400021206     C                   If        Not %Found(ACCMST)
010500021022     C                   LeaveSr
010600021206     C                   End
010700021001      *
010800021022     C                   MoveL     CGROUP        First3            3
010900021022     C     First3        Ifne      'BL-'
011000021022     C                   Add       1             ErrorCtr
011100021024     C     *In91         Ifeq      *On
011200021022     C                   Write     Head
011300021025     C                   Write     Sub
011400021023     C                   Eval      *In91      = *Off
011500021022     C                   End
011600021022     C                   Write     Det
011700021022     C                   End
011800021022      *---
011900021022      * The BL- prefix is cut off since Jefferson shows group as numeric.
012000021022      *---
012100021022     C                   Exsr      StripBL
012200021031     C                   Exsr      ClearAll
012300021023     C                   Movel     'OT'          ADCODE
012400021008      *---
012500021008      * Premium Paid
012600021008      *---
012700030331     C                   Add       CPAMT         CPAMTT
012800021028      *---
012900021028      * Fee Commission (Admin Expense from CR130HSO)
013000021028      *---
013100021025     C                   Add       CADME         FEECT
013200021001      *
013300021009      *---
013400021009      *      B E G I N     C O V E R A G E      B L O C K
013500021009      *---
013600021008      *---
013700021008      *  Coverage Code Translation and Life/Health Designation
013800021008      *---
013900021021     C     PlnKey        Chain     PLNMST
014000021021     C                   If        %Found(PLNMST)
014100021024      *---
014200021021     C                   Select
014300021024      *---
014400131018     C                   When      PLNCAT    =   'PAC' Or plncat = 'PA1' or
014500131018     C                             PLNCAT    =   'PTA' Or plncat = 'PS7' or
014600131018     C                             PLNCAT    =   'PAA'
014700021209     C                   Movel     '01'          LookCC            2
014800021024     C                   Exsr      Look
014900021025     C                   Movel     '01'          CC01              2
015000021023     C                   Eval      Box(B)    =   '01'
015100021024     C                   Add       CCOME         CCOMEHT
015200021114     C                   Add       CBOND         CCOMEHT
015300130215     C                   If        CL01 < CLIVES
015400130215     C                   z-add     CLIVES        CL01
015500130215     C                   End
015600021025     C                   Add       CLIFEV        CLV01
015700021025     C                   Add       CAAMT         CAAMT01
015800021025     C                   Add       CBAMT         CP01
015900021024      *
016000021024     C                   When      PLNCAT    =   'PDL' Or PLNCAT = 'PTD'
016100021024     C                   Movel     '02'          LookCC
016200021024     C                   Exsr      Look
016300021023     C                   Eval      Box(B)    =   '02'
016400021025     C                   Movel     '02'          CC02              2
016500021024     C                   Add       CCOME         CCOMELT
016600021114     C                   Add       CBOND         CCOMELT
016700130215     C                   If        CL02 < CLIVES
016800130215     C                   Z-add     CLIVES        CL02
016900130215     C                   End
017000021025     C                   Add       CLIFEV        CLV02
017100021025     C                   Add       CAAMT         CAAMT02
017200021025     C                   Add       CBAMT         CP02
017300021024      *
017400021113     C                   When      PLNCAT    =   'PDN'
017500021113     C                   Movel     '16'          LookCC
017600021113     C                   Exsr      Look
017700021113     C                   Eval      Box(B)    =   '16'
017800021113     C                   Movel     '16'          CC16              2
017900021113     C                   Add       CCOME         CCOMEHT
018000021114     C                   Add       CBOND         CCOMEHT
018100130215     C                   If        CL16 < CLIVES
018200130215     C                   Z-add     CLIVES        CL16
018300130215     C                   End
018400021113     C                   Add       CLIFEV        CLV16
018500021113     C                   Add       CAAMT         CAAMT16
018600021113     C                   Add       CBAMT         CP16
018700021113      *
018800021209     C                   When      PLNCAT    =   'PLF'  Or
018900021209     C                             PLNCAT    =   'PTL'  Or
019000021209     C                             PLNCAT    =   'PLL'
019100021024     C                   Movel     '03'          LookCC
019200021024     C                   Exsr      Look
019300021023     C                   Eval      Box(B)    =   '03'
019400021025     C                   Movel     '03'          CC03              2
019500021024     C                   Add       CCOME         CCOMELT
019600021114     C                   Add       CBOND         CCOMELT
019700130215     C                   If        CL03 < CLIVES
019800130215     C                   Z-add     CLIVES        CL03
019900130215     C                   End
020000021025     C                   Add       CLIFEV        CLV03
020100021025     C                   Add       CAAMT         CAAMT03
020200021025     C                   Add       CBAMT         CP03
020300021024      *
020400021023     C                   When      PLNCAT    =   'PLS'
020500021024     C                   Movel     '05'          LookCC
020600021024     C                   Exsr      Look
020700021023     C                   Eval      Box(B)    =   '05'
020800021025     C                   Movel     '05'          CC05              2
020900021024     C                   Add       CCOME         CCOMELT
021000021114     C                   Add       CBOND         CCOMELT
021100130215     C                   If        CL05 < CLIVES
021200130215     C                   Z-add     CLIVES        CL05
021300130215     C                   End
021400021025     C                   Add       CLIFEV        CLV05
021500021025     C                   Add       CAAMT         CAAMT05
021600021025     C                   Add       CBAMT         CP05
021700021203      *
021800021203     C                   When      PLNCAT    =   'PSS'
021900021203     C                   Movel     '06'          LookCC
022000021203     C                   Exsr      Look
022100021203     C                   Eval      Box(B)    =   '06'
022200021203     C                   Movel     '06'          CC06              2
022300021203     C                   Add       CCOME         CCOMEHT
022400021203     C                   Add       CBOND         CCOMEHT
022500130215     C                   If        CL06 < CLIVES
022600130215     C                   Z-add     CLIVES        CL06
022700130215     C                   End
022800021203     C                   Add       CLIFEV        CLV06
022900021203     C                   Add       CAAMT         CAAMT06
023000021203     C                   Add       CBAMT         CP06
023100021024      *
023200021024     C                   When      PLNCAT    =   'PLT'  Or PLNCAT = 'PTT'
023300021024     C                   Movel     '04'          LookCC
023400021024     C                   Exsr      Look
023500021023     C                   Eval      Box(B)    =   '04'
023600021025     C                   Movel     '04'          CC04              2
023700021024     C                   Add       CCOME         CCOMEHT
023800021114     C                   Add       CBOND         CCOMEHT
023900130215     C                   If        CL04 < CLIVES
024000130215     C                   Z-add     CLIVES        CL04
024100130215     C                   End
024200021025     C                   Add       CLIFEV        CLV04
024300021025     C                   Add       CAAMT         CAAMT04
024400021025     C                   Add       CBAMT         CP04
024500021024      *
024600021024     C                   When      PLNCAT    =   'POA'  or PLNCAT = 'PSA'
024700131017     C                             or plncat = 'PO1'
024800021024     C                   Movel     '07'          LookCC
024900021024     C                   Exsr      Look
025000021024     C                   Eval      Box(B)    =   '07'
025100021025     C                   Movel     '07'          CC07              2
025200021024     C                   Add       CCOME         CCOMEHT
025300021114     C                   Add       CBOND         CCOMEHT
025400130215     C                   If        CL07 < CLIVES
025500130215     C                   Z-add     CLIVES        CL07
025600130215     C                   End
025700021025     C                   Add       CLIFEV        CLV07
025800021025     C                   Add       CAAMT         CAAMT07
025900021025     C                   Add       CBAMT         CP07
026000021024      *
026100021023     C                   When      PLNCAT    =   'PSD'
026200021203     C                   Movel     '17'          LookCC
026300021024     C                   Exsr      Look
026400021203     C                   Eval      Box(B)    =   '17'
026500021203     C                   Movel     '17'          CC17              2
026600021024     C                   Add       CCOME         CCOMELT
026700021114     C                   Add       CBOND         CCOMELT
026800130215     C                   If        CL17 < CLIVES
026900130215     C                   Z-Add     CLIVES        CL17
027000130215     C                   End
027100021203     C                   Add       CLIFEV        CLV17
027200021203     C                   Add       CAAMT         CAAMT17
027300021203     C                   Add       CBAMT         CP17
027400021024      *
027500091102     C                   When      PLNCAT    =   'PSL'   Or
027600091102     C                             PLNCAT    =   'PNE'
027700021024     C                   Movel     '09'          LookCC
027800021024     C                   Exsr      Look
027900021023     C                   Eval      Box(B)    =   '09'
028000021025     C                   Movel     '09'          CC09              2
028100021024     C                   Add       CCOME         CCOMELT
028200021114     C                   Add       CBOND         CCOMELT
028300130215     C                   If        CL09 < CLIVES
028400130215     C                   Z-add     CLIVES        CL09
028500130215     C                   End
028600021025     C                   Add       CLIFEV        CLV09
028700021025     C                   Add       CAAMT         CAAMT09
028800021025     C                   Add       CBAMT         CP09
028900021024      *
029000131017     C                   When      PLNCAT    =   'PSP' or plncat = 'PS1' or
029100131017     C                             PLNCAT    =   'PNS' or plncat = 'PS4'
029200021025     C                   Movel     '12'          LookCC
029300021025     C                   Exsr      Look
029400021024     C                   Eval      Box(B)    =   '12'
029500021025     C                   Movel     '12'          CC12              2
029600021024     C                   Add       CCOME         CCOMELT
029700021114     C                   Add       CBOND         CCOMELT
029800130215     C                   If        CL12 < CLIVES
029900130215     C                   Z-add     CLIVES        CL12
030000130215     C                   End
030100021025     C                   Add       CLIFEV        CLV12
030200021025     C                   Add       CAAMT         CAAMT12
030300021025     C                   Add       CBAMT         CP12
030400021024      *
030500021023     C                   When      PLNCAT    =   'PTS' OR PLNCAT = 'PWD'
030600021024     C                   Movel     '15'          LookCC
030700021024     C                   Exsr      Look
030800021023     C                   Eval      Box(B)    =   '15'
030900021025     C                   Movel     '15'          CC15              2
031000021024     C                   Add       CCOME         CCOMEHT
031100021114     C                   Add       CBOND         CCOMEHT
031200130215     C                   If        CL15 < CLIVES
031300130215     C                   Z-add     CLIVES        CL15
031400130215     C                   End
031500021025     C                   Add       CLIFEV        CLV15
031600021025     C                   Add       CAAMT         CAAMT15
031700021025     C                   Add       CBAMT         CP15
031800021024      *
031900021023     C                   When      PLNCAT    =   'PVA'
032000021024     C                   Movel     '11'          LookCC
032100021024     C                   Exsr      Look
032200021023     C                   Eval      Box(B)    =   '11'
032300021025     C                   Movel     '11'          CC11              2
032400021024     C                   Add       CCOME         CCOMEHT
032500021114     C                   Add       CBOND         CCOMEHT
032600130215     C                   If        CL11 < CLIVES
032700130215     C                   Z-add     CLIVES        CL11
032800130215     C                   End
032900021025     C                   Add       CLIFEV        CLV11
033000021025     C                   Add       CAAMT         CAAMT11
033100021025     C                   Add       CBAMT         CP11
033200021024      *
033300021023     C                   When      PLNCAT    =   'PVD'
033400021024     C                   Movel     '08'          LookCC
033500021024     C                   Exsr      Look
033600021023     C                   Eval      Box(B)    =   '08'
033700021025     C                   Movel     '08'          CC08              2
033800021024     C                   Add       CCOME         CCOMELT
033900021114     C                   Add       CBOND         CCOMELT
034000130215     C                   If        CL08 < CLIVES
034100130215     C                   Z-add     CLIVES        CL08
034200130215     C                   End
034300021025     C                   Add       CLIFEV        CLV08
034400021025     C                   Add       CAAMT         CAAMT08
034500021025     C                   Add       CBAMT         CP08
034600021024      *
034700021024     C                   When      PLNCAT    =   'PVL' or PLNCAT = 'PVE'
034800021024     C                   Movel     '10'          LookCC
034900021024     C                   Exsr      Look
035000021023     C                   Eval      Box(B)    =   '10'
035100021025     C                   Movel     '10'          CC10              2
035200021024     C                   Add       CCOME         CCOMEHT
035300021114     C                   Add       CBOND         CCOMEHT
035400130215     C                   If        CL10 < CLIVES
035500130215     C                   Z-add     CLIVES        CL10
035600130215     C                   End
035700021025     C                   Add       CLIFEV        CLV10
035800021025     C                   Add       CAAMT         CAAMT10
035900021025     C                   Add       CBAMT         CP10
036000021024      *
036100021023     C                   When      PLNCAT    =   'PVS'
036200021024     C                   Movel     '13'          LookCC
036300021024     C                   Exsr      Look
036400021023     C                   Eval      Box(B)    =   '13'
036500021025     C                   Movel     '13'          CC13              2
036600021024     C                   Add       CCOME         CCOMEHT
036700021114     C                   Add       CBOND         CCOMEHT
036800130215     C                   If        CL13 < CLIVES
036900130215     C                   Z-add     CLIVES        CL13
037000130215     C                   End
037100021025     C                   Add       CLIFEV        CLV13
037200021025     C                   Add       CAAMT         CAAMT13
037300021025     C                   Add       CBAMT         CP13
037400021024      *
037500021023     C                   When      PLNCAT    =   'PVW'
037600021024     C                   Movel     '14'          LookCC
037700021024     C                   Exsr      Look
037800021023     C                   Eval      Box(B)    =   '14'
037900021025     C                   Movel     '14'          CC14              2
038000021024     C                   Add       CCOME         CCOMEHT
038100021114     C                   Add       CBOND         CCOMEHT
038200130215     C                   If        CL14 < CLIVES
038300130215     C                   Z-add     CLIVES        CL14
038400130215     C                   End
038500021025     C                   Add       CLIFEV        CLV14
038600021025     C                   Add       CAAMT         CAAMT14
038700021025     C                   Add       CBAMT         CP14
038800021024      *---
038900021021     C                   Endsl
039000021024      *---
039100021021     C                   End
039200021009      *---
039300021009      *        E N D      C O V E R A G E      B L O C K
039400021009      *---
039500030327      *
039600021001    ?C                   Endsr
039700021024      *____________________________________________________________________
039800021024      * Determine if there's already an accumulation for this coverage code
039900021024      *____________________________________________________________________
040000021024     C     Look          BEGSR
040100021024      *
040200021024     C                   Eval      B = %Lookup(LookCC:Box)
040300021024     C                   If        B = *Zero
040400021024     C                   Eval      B = %Lookup('  ':Box)
040500021024     C                   End
040600021024      *
040700021024    ?C                   Endsr
040800021022      *___________________________________________________________________
040900021025      * Accumulate amounts per coverage code for each group
041000021022      *___________________________________________________________________
041100021022     C     Summarize     BEGSR
041200021022      *
0413000709124/07 C     EFFDT         Ifeq      CEFFDT
0414000709124/07 C************       If        CmpYear  = CEFIYY  And
0415000709124/07 C************                 CmpMonth = CEFIMM
041600030401      *
041700030401     C     CPAMTT        Sub       CCOMELT       CPAMTT
041800030401     C     CPAMTT        Sub       CCOMEHT       CPAMTT
041900030401     C     CPAMTT        Sub       FEECT         CPAMTT
042000021025      *
042100021025     C                   Z-add     CPAMTT        Number            9 2
042200021025     C                   Exsr      PlusMinus
042300021025     C                   Z-add     Number        CPAMTT
042400021025     C                   Eval      PPSIGN = Sign
042500021022      *---
042600021022      * Move coverage data into next available coverage block
042700021022      *---
042800021023      * B points to the current coverage code
042900021023     C                   Z-add     1             B
043000021024      *
043100021203     C     1             Do        17            X                 2 0
043200021024      *
043300021023     C                   Select
043400021024      *
043500021023     C                   When      Box(B)  =     '01'
043600021025     C                   Movel     CC01          Jpcovcd           2
043700021025     C                   Z-add     CL01          GenLives          5 0
043800021025     C                   Z-add     CLV01         GenLifev          9 0
043900021025     C                   Z-add     CP01          GenPremium        9 2
044000021025     C                   Z-add     Caamt01       GenAAmt           9 2
044100021024      *
044200021023     C                   When      Box(B)  =     '02'
044300021025     C                   Movel     CC02          Jpcovcd
044400021025     C                   Z-add     CL02          GenLives
044500021025     C                   Z-add     CLV02         GenLifev
044600021025     C                   Z-add     CP02          GenPremium
044700021025     C                   Z-add     Caamt02       GenAAmt
044800021024      *
044900021023     C                   When      Box(B)  =     '03'
045000021025     C                   Movel     CC03          Jpcovcd
045100021025     C                   Z-add     CL03          GenLives
045200021025     C                   Z-add     CLV03         GenLifev
045300021025     C                   Z-add     CP03          GenPremium
045400021025     C                   Z-add     Caamt03       GenAAmt
045500021024      *
045600021024     C                   When      Box(B)  =     '04'
045700021025     C                   Movel     CC04          Jpcovcd
045800021025     C                   Z-add     CL04          GenLives
045900021025     C                   Z-add     CLV04         GenLifev
046000021025     C                   Z-add     CP04          GenPremium
046100021025     C                   Z-add     Caamt04       GenAAmt
046200021024      *
046300021025     C                   When      Box(B)  =     '05'
046400021025     C                   Movel     CC05          Jpcovcd
046500021025     C                   Z-add     CL05          GenLives
046600021025     C                   Z-add     CLV05         GenLifev
046700021025     C                   Z-add     CP05          GenPremium
046800021025     C                   Z-add     Caamt05       GenAAmt
046900021024      *
047000021025     C                   When      Box(B)  =     '06'
047100021025     C                   Movel     CC06          Jpcovcd
047200021025     C                   Z-add     CL06          GenLives
047300021025     C                   Z-add     CLV06         GenLifev
047400021025     C                   Z-add     CP06          GenPremium
047500021025     C                   Z-add     Caamt06       GenAAmt
047600021024      *
047700021025     C                   When      Box(B)  =     '07'
047800021025     C                   Movel     CC07          Jpcovcd
047900021025     C                   Z-add     CL07          GenLives
048000021025     C                   Z-add     CLV07         GenLifev
048100021025     C                   Z-add     CP07          GenPremium
048200021025     C                   Z-add     Caamt07       GenAAmt
048300021024      *
048400021025     C                   When      Box(B)  =     '08'
048500021025     C                   Movel     CC08          Jpcovcd
048600021025     C                   Z-add     CL08          GenLives
048700021025     C                   Z-add     CLV08         GenLifev
048800021025     C                   Z-add     CP08          GenPremium
048900021025     C                   Z-add     Caamt08       GenAAmt
049000021024      *
049100021025     C                   When      Box(B)  =     '09'
049200021025     C                   Movel     CC09          Jpcovcd
049300021025     C                   Z-add     CL09          GenLives
049400021025     C                   Z-add     CLV09         GenLifev
049500021025     C                   Z-add     CP09          GenPremium
049600021025     C                   Z-add     Caamt09       GenAAmt
049700021024      *
049800021025     C                   When      Box(B)  =     '10'
049900021025     C                   Movel     CC10          Jpcovcd
050000021025     C                   Z-add     CL10          GenLives
050100021025     C                   Z-add     CLV10         GenLifev
050200021025     C                   Z-add     CP10          GenPremium
050300021025     C                   Z-add     Caamt10       GenAAmt
050400021024      *
050500021025     C                   When      Box(B)  =     '11'
050600021025     C                   Movel     CC11          Jpcovcd
050700021025     C                   Z-add     CL11          GenLives
050800021025     C                   Z-add     CLV11         GenLifev
050900021025     C                   Z-add     CP11          GenPremium
051000021025     C                   Z-add     Caamt11       GenAAmt
051100021025      *
051200021025     C                   When      Box(B)  =     '12'
051300021025     C                   Movel     CC12          Jpcovcd
051400021025     C                   Z-add     CL12          GenLives
051500021025     C                   Z-add     CLV12         GenLifev
051600021025     C                   Z-add     CP12          GenPremium
051700021025     C                   Z-add     Caamt12       GenAAmt
051800021025      *
051900021025     C                   When      Box(B)  =     '13'
052000021025     C                   Movel     CC13          Jpcovcd
052100021025     C                   Z-add     CL13          GenLives
052200021025     C                   Z-add     CLV13         GenLifev
052300021025     C                   Z-add     CP13          GenPremium
052400021025     C                   Z-add     Caamt13       GenAAmt
052500021025      *
052600021025     C                   When      Box(B)  =     '14'
052700021025     C                   Movel     CC14          Jpcovcd
052800021025     C                   Z-add     CL14          GenLives
052900021025     C                   Z-add     CLV14         GenLifev
053000021025     C                   Z-add     CP14          GenPremium
053100021025     C                   Z-add     Caamt14       GenAAmt
053200021025      *
053300021025     C                   When      Box(B)  =     '15'
053400021025     C                   Movel     CC15          Jpcovcd
053500021025     C                   Z-add     CL15          GenLives
053600021025     C                   Z-add     CLV15         GenLifev
053700021025     C                   Z-add     CP15          GenPremium
053800021025     C                   Z-add     Caamt15       GenAAmt
053900021025      *
054000021025     C                   When      Box(B)  =     '16'
054100021113     C                   Movel     CC16          Jpcovcd
054200021025     C                   Z-add     CL16          GenLives
054300021025     C                   Z-add     CLV16         GenLifev
054400021025     C                   Z-add     CP16          GenPremium
054500021025     C                   Z-add     Caamt16       GenAAmt
054600021203      *
054700021203     C                   When      Box(B)  =     '17'
054800021203     C                   Movel     CC17          Jpcovcd
054900021203     C                   Z-add     CL17          GenLives
055000021203     C                   Z-add     CLV17         GenLifev
055100021203     C                   Z-add     CP17          GenPremium
055200021203     C                   Z-add     Caamt17       GenAAmt
055300021025      *
055400021023     C                   EndSl
055500021023      *---
055600021023      * X points to the next free coverage block
055700021023      *---
055800021023     C                   Select
055900021024      *
056000021023     C                   When      X        =    1
056100021024     C                   Eval      Covcd1   =    Jpcovcd
056200021220     C                   Z-add     GenLives      CLIVES1           5 0
056300021220     C                   Z-add     GenLifev      CLIFEV1           9 0
056400021220     C                   Z-add     GenPremium    PREMIUM1          9 2
056500021220     C                   Z-add     GenAAmt       ADPREM1           9 2
056600021024      *
056700021023     C                   When      X        =    2
056800021024     C                   Eval      Covcd2   =    Jpcovcd
056900021220     C                   Z-add     GenLives      CLIVES2           5 0
057000021220     C                   Z-add     GenLifev      CLIFEV2           9 0
057100021220     C                   Z-add     GenPremium    PREMIUM2          9 2
057200021220     C                   Z-add     GenAAmt       ADPREM2           9 2
057300021024      *
057400021023     C                   When      X        =    3
057500021024     C                   Eval      Covcd3   =    Jpcovcd
057600021220     C                   Z-add     GenLives      CLIVES3           5 0
057700021220     C                   Z-add     GenLifev      CLIFEV3           9 0
057800021220     C                   Z-add     GenPremium    PREMIUM3          9 2
057900021220     C                   Z-add     GenAAmt       ADPREM3           9 2
058000021024      *
058100021024     C                   When      X        =    4
058200021024     C                   Eval      Covcd4   =    Jpcovcd
058300021220     C                   Z-add     GenLives      CLIVES4           5 0
058400021220     C                   Z-add     GenLifev      CLIFEV4           9 0
058500021220     C                   Z-add     GenPremium    PREMIUM4          9 2
058600021220     C                   Z-add     GenAAmt       ADPREM4           9 2
058700021024      *
058800021024     C                   When      X        =    5
058900021024     C                   Eval      Covcd5   =    Jpcovcd
059000021220     C                   Z-add     GenLives      CLIVES5           5 0
059100021220     C                   Z-add     GenLifev      CLIFEV5           9 0
059200021220     C                   Z-add     GenPremium    PREMIUM5          9 2
059300021220     C                   Z-add     GenAAmt       ADPREM5           9 2
059400021024      *
059500021024     C                   When      X        =    6
059600021024     C                   Eval      Covcd6   =    Jpcovcd
059700021220     C                   Z-add     GenLives      CLIVES6           5 0
059800021220     C                   Z-add     GenLifev      CLIFEV6           9 0
059900021220     C                   Z-add     GenPremium    PREMIUM6          9 2
060000021220     C                   Z-add     GenAAmt       ADPREM6           9 2
060100021024      *
060200021024     C                   When      X        =    7
060300021024     C                   Eval      Covcd7   =    Jpcovcd
060400021220     C                   Z-add     GenLives      CLIVES7           5 0
060500021220     C                   Z-add     GenLifev      CLIFEV7           9 0
060600021220     C                   Z-add     GenPremium    PREMIUM7          9 2
060700021220     C                   Z-add     GenAAmt       ADPREM7           9 2
060800021024      *
060900021024     C                   When      X        =    8
061000021024     C                   Eval      Covcd8   =    Jpcovcd
061100021220     C                   Z-add     GenLives      CLIVES8           5 0
061200021220     C                   Z-add     GenLifev      CLIFEV8           9 0
061300021220     C                   Z-add     GenPremium    PREMIUM8          9 2
061400021220     C                   Z-add     GenAAmt       ADPREM8           9 2
061500021024      *
061600021024     C                   When      X        =    9
061700021220     C                   Eval      Covcd9   =    Jpcovcd
061800021220     C                   Z-add     GenLives      CLIVES9           5 0
061900021220     C                   Z-add     GenLifev      CLIFEV9           9 0
062000021220     C                   Z-add     GenPremium    PREMIUM9          9 2
062100021220     C                   Z-add     GenAAmt       ADPREM9           9 2
062200021024      *
062300021024     C                   When      X        =    10
062400021024     C                   Eval      Covcd10  =    Jpcovcd
062500021220     C                   Z-add     GenLives      CLIVES10          5 0
062600021220     C                   Z-add     GenLifev      CLIFEV10          9 0
062700021220     C                   Z-add     GenPremium    PREMIUM10         9 2
062800021220     C                   Z-add     GenAAmt       ADPREM10          9 2
062900021024      *
063000021024     C                   When      X        =    11
063100021024     C                   Eval      Covcd11  =    Jpcovcd
063200021220     C                   Z-add     GenLives      CLIVES11          5 0
063300021220     C                   Z-add     GenLifev      CLIFEV11          9 0
063400021220     C                   Z-add     GenPremium    PREMIUM11         9 2
063500021220     C                   Z-add     GenAAmt       ADPREM11          9 2
063600021024      *
063700021024     C                   When      X        =    12
063800021024     C                   Eval      Covcd12  =    Jpcovcd
063900021220     C                   Z-add     GenLives      CLIVES12          5 0
064000021220     C                   Z-add     GenLifev      CLIFEV12          9 0
064100021220     C                   Z-add     GenPremium    PREMIUM12         9 2
064200021220     C                   Z-add     GenAAmt       ADPREM12          9 2
064300021024      *
064400021024     C                   When      X        =    13
064500021024     C                   Eval      Covcd13  =    Jpcovcd
064600021220     C                   Z-add     GenLives      CLIVES13          5 0
064700021220     C                   Z-add     GenLifev      CLIFEV13          9 0
064800021220     C                   Z-add     GenPremium    PREMIUM13         9 2
064900021220     C                   Z-add     GenAAmt       ADPREM13          9 2
065000021024      *
065100021024     C                   When      X        =    14
065200021024     C                   Eval      Covcd14  =    Jpcovcd
065300021220     C                   Z-add     GenLives      CLIVES14          5 0
065400021220     C                   Z-add     GenLifev      CLIFEV14          9 0
065500021220     C                   Z-add     GenPremium    PREMIUM14         9 2
065600021220     C                   Z-add     GenAAmt       ADPREM14          9 2
065700021024      *
065800021024     C                   When      X        =    15
065900021024     C                   Eval      Covcd15  =    Jpcovcd
066000021220     C                   Z-add     GenLives      CLIVES15          5 0
066100021220     C                   Z-add     GenLifev      CLIFEV15          9 0
066200021220     C                   Z-add     GenPremium    PREMIUM15         9 2
066300021220     C                   Z-add     GenAAmt       ADPREM15          9 2
066400021024      *
066500021024     C                   When      X        =    16
066600021024     C                   Eval      Covcd16  =    Jpcovcd
066700021220     C                   Z-add     GenLives      CLIVES16          5 0
066800021220     C                   Z-add     GenLifev      CLIFEV16          9 0
066900021220     C                   Z-add     GenPremium    PREMIUM16         9 2
067000021220     C                   Z-add     GenAAmt       ADPREM16          9 2
067100021024      *
067200021203     C                   When      X        =    17
067300021203     C                   Eval      Covcd17  =    Jpcovcd
067400021220     C                   Z-add     GenLives      CLIVES17          5 0
067500021220     C                   Z-add     GenLifev      CLIFEV17          9 0
067600021220     C                   Z-add     GenPremium    PREMIUM17         9 2
067700021220     C                   Z-add     GenAAmt       ADPREM17          9 2
067800021203      *
067900021023     C                   EndSl
068000021024      *
068100021023     C                   Add       1             B
068200021024      *---
068300021024      * If Box(B) is blank, it means there are no more coverage codes.
068400021024      *---
068500021024     C                   If        Box(B)      = '  '
068600021024     C                   Leave
068700021024     C                   End
068800021023     C                   Enddo
068900021025      *
069000021028     C                   If        COVCD1  <> *Blanks
069100021025     C                   Z-add     CLIVES1       Number
069200021025     C                   Exsr      PlusMinus
069300021025     C                   Z-add     Number        CLIVES1
069400021025     C                   Eval      LISIGN1 = Sign
069500021028     C                   Z-add     CLIFEV1       Number
069600021028     C                   Exsr      PlusMinus
069700021028     C                   Z-add     Number        CLIFEV1
069800021028     C                   Eval      VLSIGN1 = Sign
069900021028     C                   Z-add     PREMIUM1      Number
070000021028     C                   Exsr      PlusMinus
070100021028     C                   Z-add     Number        PREMIUM1
070200021028     C                   Eval      PRSIGN1 = Sign
070300021028     C                   Z-add     ADPREM1       Number
070400021028     C                   Exsr      PlusMinus
070500021028     C                   Z-add     Number        ADPREM1
070600021028     C                   Eval      APSIGN1 = Sign
070700021028     C                   End
070800021028     C                   If        COVCD2  <> *Blanks
070900021025     C                   Z-add     CLIVES2       Number
071000021025     C                   Exsr      PlusMinus
071100021025     C                   Z-add     Number        CLIVES2
071200021028     C                   Eval      LISIGN2 = Sign
071300021028     C                   Z-add     CLIFEV2       Number
071400021028     C                   Exsr      PlusMinus
071500021028     C                   Z-add     Number        CLIFEV2
071600021028     C                   Eval      VLSIGN2 = Sign
071700021028     C                   Z-add     PREMIUM2      Number
071800021028     C                   Exsr      PlusMinus
071900021028     C                   Z-add     Number        PREMIUM2
072000021028     C                   Eval      PRSIGN2 = Sign
072100021028     C                   Z-add     ADPREM2       Number
072200021028     C                   Exsr      PlusMinus
072300021028     C                   Z-add     Number        ADPREM2
072400021028     C                   Eval      APSIGN2 = Sign
072500021028     C                   End
072600021028     C                   If        COVCD3  <> *Blanks
072700021028     C                   Z-add     CLIVES3       Number
072800021025     C                   Exsr      PlusMinus
072900021025     C                   Z-add     Number        CLIVES3
073000021025     C                   Eval      LISIGN3 = Sign
073100021028     C                   Z-add     CLIFEV3       Number
073200021028     C                   Exsr      PlusMinus
073300021028     C                   Z-add     Number        CLIFEV3
073400021028     C                   Eval      VLSIGN3 = Sign
073500021028     C                   Z-add     PREMIUM3      Number
073600021028     C                   Exsr      PlusMinus
073700021028     C                   Z-add     Number        PREMIUM3
073800021028     C                   Eval      PRSIGN3 = Sign
073900021028     C                   Z-add     ADPREM3       Number
074000021028     C                   Exsr      PlusMinus
074100021028     C                   Z-add     Number        ADPREM3
074200021028     C                   Eval      APSIGN3 = Sign
074300021028     C                   End
074400021028     C                   If        COVCD4  <> *Blanks
074500021025     C                   Z-add     CLIVES4       Number
074600021025     C                   Exsr      PlusMinus
074700021025     C                   Z-add     Number        CLIVES4
074800021025     C                   Eval      LISIGN4 = Sign
074900021028     C                   Z-add     CLIFEV4       Number
075000021028     C                   Exsr      PlusMinus
075100021028     C                   Z-add     Number        CLIFEV4
075200021028     C                   Eval      VLSIGN4 = Sign
075300021028     C                   Z-add     PREMIUM4      Number
075400021028     C                   Exsr      PlusMinus
075500021028     C                   Z-add     Number        PREMIUM4
075600021028     C                   Eval      PRSIGN4 = Sign
075700021028     C                   Z-add     ADPREM4       Number
075800021028     C                   Exsr      PlusMinus
075900021028     C                   Z-add     Number        ADPREM4
076000021028     C                   Eval      APSIGN4 = Sign
076100021028     C                   End
076200021028     C                   If        COVCD5  <> *Blanks
076300021025     C                   Z-add     CLIVES5       Number
076400021025     C                   Exsr      PlusMinus
076500021025     C                   Z-add     Number        CLIVES5
076600021025     C                   Eval      LISIGN5 = Sign
076700021028     C                   Z-add     CLIFEV5       Number
076800021028     C                   Exsr      PlusMinus
076900021028     C                   Z-add     Number        CLIFEV5
077000021028     C                   Eval      VLSIGN5 = Sign
077100021028     C                   Z-add     PREMIUM5      Number
077200021028     C                   Exsr      PlusMinus
077300021028     C                   Z-add     Number        PREMIUM5
077400021028     C                   Eval      PRSIGN5 = Sign
077500021028     C                   Z-add     ADPREM5       Number
077600021028     C                   Exsr      PlusMinus
077700021028     C                   Z-add     Number        ADPREM5
077800021028     C                   Eval      APSIGN5 = Sign
077900021028     C                   End
078000021028     C                   If        COVCD6  <> *Blanks
078100021028     C                   Z-add     CLIFEV6       Number
078200021028     C                   Exsr      PlusMinus
078300021028     C                   Z-add     Number        CLIFEV6
078400021028     C                   Eval      VLSIGN6 = Sign
078500021025     C                   Z-add     CLIVES6       Number
078600021025     C                   Exsr      PlusMinus
078700021025     C                   Z-add     Number        CLIVES6
078800021025     C                   Eval      LISIGN6 = Sign
078900021028     C                   Z-add     PREMIUM6      Number
079000021028     C                   Exsr      PlusMinus
079100021028     C                   Z-add     Number        PREMIUM6
079200021028     C                   Eval      PRSIGN6 = Sign
079300021028     C                   Z-add     ADPREM6       Number
079400021028     C                   Exsr      PlusMinus
079500021028     C                   Z-add     Number        ADPREM6
079600021028     C                   Eval      APSIGN6 = Sign
079700021028     C                   End
079800021028     C                   If        COVCD7  <> *Blanks
079900021025     C                   Z-add     CLIVES7       Number
080000021025     C                   Exsr      PlusMinus
080100021025     C                   Z-add     Number        CLIVES7
080200021025     C                   Eval      LISIGN7 = Sign
080300021028     C                   Z-add     CLIFEV7       Number
080400021028     C                   Exsr      PlusMinus
080500021028     C                   Z-add     Number        CLIFEV7
080600021028     C                   Eval      VLSIGN7 = Sign
080700021028     C                   Z-add     PREMIUM7      Number
080800021028     C                   Exsr      PlusMinus
080900021028     C                   Z-add     Number        PREMIUM7
081000021028     C                   Eval      PRSIGN7 = Sign
081100021028     C                   Z-add     ADPREM7       Number
081200021028     C                   Exsr      PlusMinus
081300021028     C                   Z-add     Number        ADPREM7
081400021028     C                   Eval      APSIGN7 = Sign
081500021028     C                   End
081600021028     C                   If        COVCD8  <> *Blanks
081700021025     C                   Z-add     CLIVES8       Number
081800021025     C                   Exsr      PlusMinus
081900021025     C                   Z-add     Number        CLIVES8
082000021025     C                   Eval      LISIGN8 = Sign
082100021028     C                   Z-add     CLIFEV8       Number
082200021028     C                   Exsr      PlusMinus
082300021028     C                   Z-add     Number        CLIFEV8
082400021028     C                   Eval      VLSIGN8 = Sign
082500021028     C                   Z-add     PREMIUM8      Number
082600021028     C                   Exsr      PlusMinus
082700021028     C                   Z-add     Number        PREMIUM8
082800021028     C                   Eval      PRSIGN8 = Sign
082900021028     C                   Z-add     ADPREM8       Number
083000021028     C                   Exsr      PlusMinus
083100021028     C                   Z-add     Number        ADPREM8
083200021028     C                   Eval      APSIGN8 = Sign
083300021028     C                   End
083400021028     C                   If        COVCD9  <> *Blanks
083500021025     C                   Z-add     CLIVES9       Number
083600021025     C                   Exsr      PlusMinus
083700021025     C                   Z-add     Number        CLIVES9
083800021025     C                   Eval      LISIGN9 = Sign
083900021028     C                   Z-add     CLIFEV9       Number
084000021028     C                   Exsr      PlusMinus
084100021028     C                   Z-add     Number        CLIFEV9
084200021028     C                   Eval      VLSIGN9 = Sign
084300021028     C                   Z-add     PREMIUM9      Number
084400021028     C                   Exsr      PlusMinus
084500021028     C                   Z-add     Number        PREMIUM9
084600021028     C                   Eval      PRSIGN9 = Sign
084700021028     C                   Z-add     ADPREM9       Number
084800021028     C                   Exsr      PlusMinus
084900021028     C                   Z-add     Number        ADPREM9
085000021028     C                   Eval      APSIGN9 = Sign
085100021028     C                   End
085200021028     C                   If        COVCD10 <> *Blanks
085300021025     C                   Z-add     CLIVES10      Number
085400021025     C                   Exsr      PlusMinus
085500021025     C                   Z-add     Number        CLIVES10
085600021025     C                   Eval      LISIGN10= Sign
085700021028     C                   Z-add     CLIFEV10      Number
085800021028     C                   Exsr      PlusMinus
085900021028     C                   Z-add     Number        CLIFEV10
086000021028     C                   Eval      VLSIGN10 = Sign
086100021028     C                   Z-add     PREMIUM10     Number
086200021028     C                   Exsr      PlusMinus
086300021028     C                   Z-add     Number        PREMIUM10
086400021028     C                   Eval      PRSIGN10 = Sign
086500021028     C                   Z-add     ADPREM10      Number
086600021028     C                   Exsr      PlusMinus
086700021028     C                   Z-add     Number        ADPREM10
086800021028     C                   Eval      APSIGN10 = Sign
086900021028     C                   End
087000021028     C                   If        COVCD11 <> *Blanks
087100021025     C                   Z-add     CLIVES11      Number
087200021025     C                   Exsr      PlusMinus
087300021025     C                   Z-add     Number        CLIVES11
087400021025     C                   Eval      LISIGN11 = Sign
087500021028     C                   Z-add     CLIFEV11      Number
087600021028     C                   Exsr      PlusMinus
087700021028     C                   Z-add     Number        CLIFEV11
087800021028     C                   Eval      VLSIGN11 = Sign
087900021028     C                   Z-add     PREMIUM11     Number
088000021028     C                   Exsr      PlusMinus
088100021028     C                   Z-add     Number        PREMIUM11
088200021028     C                   Eval      PRSIGN11 = Sign
088300021028     C                   Z-add     ADPREM11      Number
088400021028     C                   Exsr      PlusMinus
088500021028     C                   Z-add     Number        ADPREM11
088600021028     C                   Eval      APSIGN11 = Sign
088700021028     C                   End
088800021028     C                   If        COVCD12 <> *Blanks
088900021025     C                   Z-add     CLIVES12      Number
089000021025     C                   Exsr      PlusMinus
089100021025     C                   Z-add     Number        CLIVES12
089200021025     C                   Eval      LISIGN12 = Sign
089300021028     C                   Z-add     CLIFEV12      Number
089400021028     C                   Exsr      PlusMinus
089500021028     C                   Z-add     Number        CLIFEV12
089600021028     C                   Eval      VLSIGN12 = Sign
089700021028     C                   Z-add     PREMIUM12     Number
089800021028     C                   Exsr      PlusMinus
089900021028     C                   Z-add     Number        PREMIUM12
090000021028     C                   Eval      PRSIGN12 = Sign
090100021028     C                   Z-add     ADPREM12      Number
090200021028     C                   Exsr      PlusMinus
090300021028     C                   Z-add     Number        ADPREM12
090400021028     C                   Eval      APSIGN12 = Sign
090500021028     C                   End
090600021028     C                   If        COVCD13 <> *Blanks
090700021025     C                   Z-add     CLIVES13      Number
090800021025     C                   Exsr      PlusMinus
090900021025     C                   Z-add     Number        CLIVES13
091000021025     C                   Eval      LISIGN13 = Sign
091100021028     C                   Z-add     CLIFEV13      Number
091200021028     C                   Exsr      PlusMinus
091300021028     C                   Z-add     Number        CLIFEV13
091400021028     C                   Eval      VLSIGN13 = Sign
091500021028     C                   Z-add     PREMIUM13     Number
091600021028     C                   Exsr      PlusMinus
091700021028     C                   Z-add     Number        PREMIUM13
091800021028     C                   Eval      PRSIGN13 = Sign
091900021028     C                   Z-add     ADPREM13      Number
092000021028     C                   Exsr      PlusMinus
092100021028     C                   Z-add     Number        ADPREM13
092200021028     C                   Eval      APSIGN13 = Sign
092300021028     C                   End
092400021028     C                   If        COVCD14 <> *Blanks
092500021025     C                   Z-add     CLIVES14      Number
092600021025     C                   Exsr      PlusMinus
092700021025     C                   Z-add     Number        CLIVES14
092800021025     C                   Eval      LISIGN14 = Sign
092900021028     C                   Z-add     CLIFEV14      Number
093000021028     C                   Exsr      PlusMinus
093100021028     C                   Z-add     Number        CLIFEV14
093200021028     C                   Eval      VLSIGN14 = Sign
093300021028     C                   Z-add     PREMIUM14     Number
093400021028     C                   Exsr      PlusMinus
093500021028     C                   Z-add     Number        PREMIUM14
093600021028     C                   Eval      PRSIGN14 = Sign
093700021028     C                   Z-add     ADPREM14      Number
093800021028     C                   Exsr      PlusMinus
093900021028     C                   Z-add     Number        ADPREM14
094000021028     C                   Eval      APSIGN14 = Sign
094100021028     C                   End
094200021028     C                   If        COVCD15 <> *Blanks
094300021025     C                   Z-add     CLIVES15      Number
094400021025     C                   Exsr      PlusMinus
094500021025     C                   Z-add     Number        CLIVES15
094600021025     C                   Eval      LISIGN15 = Sign
094700021028     C                   Z-add     CLIFEV15      Number
094800021028     C                   Exsr      PlusMinus
094900021028     C                   Z-add     Number        CLIFEV15
095000021028     C                   Eval      VLSIGN15 = Sign
095100021028     C                   Z-add     PREMIUM15     Number
095200021028     C                   Exsr      PlusMinus
095300021028     C                   Z-add     Number        PREMIUM15
095400021028     C                   Eval      PRSIGN15 = Sign
095500021028     C                   Z-add     ADPREM15      Number
095600021028     C                   Exsr      PlusMinus
095700021028     C                   Z-add     Number        ADPREM15
095800021028     C                   Eval      APSIGN15 = Sign
095900021028     C                   End
096000021028     C                   If        COVCD16 <> *Blanks
096100021025     C                   Z-add     CLIVES16      Number
096200021025     C                   Exsr      PlusMinus
096300021025     C                   Z-add     Number        CLIVES16
096400021025     C                   Eval      LISIGN16 = Sign
096500021028     C                   Z-add     CLIFEV16      Number
096600021028     C                   Exsr      PlusMinus
096700021028     C                   Z-add     Number        CLIFEV16
096800021028     C                   Eval      VLSIGN16 = Sign
096900021028     C                   Z-add     PREMIUM16     Number
097000021028     C                   Exsr      PlusMinus
097100021028     C                   Z-add     Number        PREMIUM16
097200021028     C                   Eval      PRSIGN16 = Sign
097300021028     C                   Z-add     ADPREM16      Number
097400021028     C                   Exsr      PlusMinus
097500021028     C                   Z-add     Number        ADPREM16
097600021028     C                   Eval      APSIGN16 = Sign
097700021028     C                   End
097800021203     C                   If        COVCD17 <> *Blanks
097900021203     C                   Z-add     CLIVES17      Number
098000021203     C                   Exsr      PlusMinus
098100021203     C                   Z-add     Number        CLIVES17
098200021203     C                   Eval      LISIGN17 = Sign
098300021203     C                   Z-add     CLIFEV17      Number
098400021203     C                   Exsr      PlusMinus
098500021203     C                   Z-add     Number        CLIFEV17
098600021203     C                   Eval      VLSIGN17 = Sign
098700021203     C                   Z-add     PREMIUM17     Number
098800021203     C                   Exsr      PlusMinus
098900021203     C                   Z-add     Number        PREMIUM17
099000021203     C                   Eval      PRSIGN17 = Sign
099100021203     C                   Z-add     ADPREM17      Number
099200021203     C                   Exsr      PlusMinus
099300021203     C                   Z-add     Number        ADPREM16
099400021203     C                   Eval      APSIGN17 = Sign
099500021203     C                   End
099600021025      *
099700021023      *---
099800021023      * At the conference call of 10/8/02 w/Shelly, Carol S. and Melissa
099900021023      * and Mandy (from Jefferson), we found out that Life & Health are not
100000021023      * designated by the carrier code as previously thought.  The life/
100100021023      * health designation will be provided by Shelly/Carol S. along with
100200021023      * the Jefferson coverage code/GBS plan category code translation.
100300021023      *
100400021025     C                   Z-add     CCOMELT       Number
100500021025     C                   Exsr      PlusMinus
100600021025     C                   Z-add     Number        CCOMELT
100700021025     C                   Eval      LCSIGN = Sign
100800021025      *
100900021025     C                   Z-add     CCOMEHT       Number
101000021025     C                   Exsr      PlusMinus
101100021025     C                   Z-add     Number        CCOMEHT
101200021025     C                   Eval      HCSIGN = Sign
101300021025      *
101400021025     C                   Z-add     FEECT         Number
101500021025     C                   Exsr      PlusMinus
101600021025     C                   Z-add     Number        FEECT
101700021025     C                   Eval      FESIGN = Sign
101800030331      *
101900021028     C                   End
102000021028      *
102100021022    ?C                   Endsr
102200021022      *___________________________________________________________________
102300021022      * Strip BL- prefix off of group number.
102400021022      *___________________________________________________________________
102500021022     C     StripBL       BEGSR
102600021022      *
102700021022     C                   MOVEA     CGROUP        DASH
102800021022     C                   Z-ADD     1             D                 3 0
102900021022     C     'B'           LOOKUP    DASH(D)                                80
103000021022     C     *IN80         IFEQ      '1'
103100021022     C                   Z-ADD     0             E                 3 0
103200021022     C                   MOVEA     *ALL' '       DAS2
103300021022     C     1             DO        11            D
103400021022     C     DASH(D)       IFNE      'B'
103500021022     C                   ADD       1             E
103600021022     C                   MOVE      DASH(D)       DAS2(E)
103700021022     C                   ENDIF
103800021022     C                   ENDDO
103900021022     C                   MOVEA(P)  DAS2          CGroupAlpha      15
104000021022     C                   ELSE
104100021022     C                   MOVEL     CGROUP        CGroupAlpha
104200021022     C                   ENDIF
104300021022      *** If there are L's in the group#, strip them out.
104400021022      *
104500021022     C                   MOVEA     CGroupAlpha   DASH
104600021022     C                   Z-ADD     1             D                 3 0
104700021022     C     'L'           LOOKUP    DASH(D)                                80
104800021022     C     *IN80         IFEQ      '1'
104900021022     C                   Z-ADD     0             E                 3 0
105000021022     C                   MOVEA     *ALL' '       DAS2
105100021022     C     1             DO        11            D
105200021022     C     DASH(D)       IFNE      'L'
105300021022     C                   ADD       1             E
105400021022     C                   MOVE      DASH(D)       DAS2(E)
105500021022     C                   ENDIF
105600021022     C                   ENDDO
105700021022     C                   MOVEA(P)  DAS2          CGroupAlpha
105800021022     C                   ENDIF
105900021022      *** If there are dashes in the group#, strip them out.
106000021022      *
106100021022     C                   MOVEA     CGroupAlpha   DASH
106200021022     C                   Z-ADD     1             D                 3 0
106300021022     C     '-'           LOOKUP    DASH(D)                                80
106400021022     C     *IN80         IFEQ      '1'
106500021022     C                   Z-ADD     0             E                 3 0
106600021022     C                   MOVEA     *ALL' '       DAS2
106700021022     C     1             DO        11            D
106800021022     C     DASH(D)       IFNE      '-'
106900021022     C                   ADD       1             E
107000021022     C                   MOVE      DASH(D)       DAS2(E)
107100021022     C                   ENDIF
107200021022     C                   ENDDO
107300021022     C                   MOVEA(P)  DAS2          CGroupAlpha
107400021022     C                   ENDIF
107500021203     C                   Movel     CGroupAlpha   CGROUP#
107600021022      *
107700021022    ?C                   Endsr
107800021025      *___________________________________________________________________
107900021025      * Determine if positive or negative
108000021025      *___________________________________________________________________
108100021224     C     PlusMinus     Begsr
108200021025      *
108300021224     C                   Select
108400021224     C                   When      Number < *Zero
108500021025     C                   Eval      Sign = Minus
108600021025     C                   Mult      -1            Number
108700030117     C                   When      Number >= *Zero
108800021025     C                   Eval      Sign = Plus
108900021224     C                   Other
109000021224     C                   Eval      Sign = *Blanks
109100021224     C                   Endsl
109200021224      *
109300021025    ?C                   Endsr
109400021024      *___________________________________________________________________
109500021024      * End of Report Message
109600021024      *___________________________________________________________________
109700021024     C     EndProgram    BEGSR
109800021024      *
109900021024     C     ErrorCtr      Ifeq      *Zero
110000021024     C                   Eval      BLANKTEXT = NoErrorMsg
110100021024     C                   Write     NOERRORS
110200021024     C                   End
110300021024     C                   Write     EOP
110400021024      *
110500021024    ?C                   Endsr
110600021024      *___________________________________________________________________
110700021024      * Write Remittance Record
110800021024      *___________________________________________________________________
110900030807     C     WriteCR170J   BEGSR
111000021024      *
1111000709124/07 C     EFFDT         Ifeq      CEFFDT
1112000709124/07 C************       If        CmpYear  = CEFIYY  And
1113000709124/07 C************                 CmpMonth = CEFIMM
111400021203     C     CGROUP#       Ifne      *Blanks
111500021220     C                   Exsr      BlankZeros
111600030807     C                   Write     CR170JR
111700021203     C                   End
111800021025     C                   Exsr      ClearAfter
111900021025     C                   End
112000021024      *
112100021024    ?C                   Endsr
112200021220      *___________________________________________________________________
112300021220      * Blank out zero coverage block fields
112400021220      *___________________________________________________________________
112500021220     C     BlankZeros    BEGSR
112600021220      *
112700030103     C                   If        CLIVES1  = *Zeros  and
1128000301031/3  C                             COVCD1   = *Blanks
112900021220     C                   Eval      CLIVES1A = *Blanks
113000021220     C                   Else
113100021220     C                   Move      CLIVES1       CLIVES1A
113200021220     C                   End
113300030103      *
113400030103     C                   If        CLIVES2  = *Zeros   and
1135000301031/3  C                             COVCD2   = *Blanks
113600021220     C                   Eval      CLIVES2A = *Blanks
113700021220     C                   Else
113800021220     C                   Move      CLIVES2       CLIVES2A
113900021220     C                   End
114000030103      *
114100030103     C                   If        CLIVES3  = *Zeros   and
1142000301031/3  C                             COVCD3   = *Blanks
114300021220     C                   Eval      CLIVES3A = *Blanks
114400021220     C                   Else
114500021220     C                   Move      CLIVES3       CLIVES3A
114600021220     C                   End
114700030103      *
114800030103     C                   If        CLIVES4  = *Zeros    and
1149000301031/3  C                             COVCD4   = *Blanks
115000021220     C                   Eval      CLIVES4A = *Blanks
115100021220     C                   Else
115200021220     C                   Move      CLIVES4       CLIVES4A
115300021220     C                   End
115400030103      *
115500030103     C                   If        CLIVES5  = *Zeros  and
1156000301031/3  C                             COVCD5   = *Blanks
115700021220     C                   Eval      CLIVES5A = *Blanks
115800021220     C                   Else
115900021220     C                   Move      CLIVES5       CLIVES5A
116000021220     C                   End
116100030103      *
116200030103     C                   If        CLIVES6  = *Zeros     and
1163000301031/3  C                             COVCD6   = *Blanks
116400021220     C                   Eval      CLIVES6A = *Blanks
116500021220     C                   Else
116600021220     C                   Move      CLIVES6       CLIVES6A
116700021220     C                   End
116800030103      *
116900030103     C                   If        CLIVES7  = *Zeros   and
1170000301031/3  C                             COVCD7   = *Blanks
117100021220     C                   Eval      CLIVES7A = *Blanks
117200021220     C                   Else
117300021220     C                   Move      CLIVES7       CLIVES7A
117400021220     C                   End
117500030103      *
117600030103     C                   If        CLIVES8  = *Zeros   and
1177000301031/3  C                             COVCD8   = *Blanks
117800021220     C                   Eval      CLIVES8A = *Blanks
117900021220     C                   Else
118000021220     C                   Move      CLIVES8       CLIVES8A
118100021220     C                   End
118200030103      *
118300030103     C                   If        CLIVES9  = *Zeros  and
1184000301031/3  C                             COVCD9   = *Blanks
118500021220     C                   Eval      CLIVES9A = *Blanks
118600021220     C                   Else
118700021220     C                   Move      CLIVES9       CLIVES9A
118800021220     C                   End
118900030103      *
119000030103     C                   If        CLIVES10  = *Zeros  and
1191000301031/3  C                             COVCD10  = *Blanks
119200021220     C                   Eval      CLIVES10A = *Blanks
119300021220     C                   Else
119400021220     C                   Move      CLIVES10      CLIVES10A
119500021220     C                   End
119600030103      *
119700030103     C                   If        CLIVES11  = *Zeros   and
1198000301031/3  C                             COVCD11  = *Blanks
119900021220     C                   Eval      CLIVES11A = *Blanks
120000021220     C                   Else
120100021220     C                   Move      CLIVES11      CLIVES11A
120200021220     C                   End
120300030103      *
120400030103     C                   If        CLIVES12  = *Zeros and
1205000301031/3  C                             COVCD12  = *Blanks
120600021220     C                   Eval      CLIVES12A = *Blanks
120700021220     C                   Else
120800021220     C                   Move      CLIVES12      CLIVES12A
120900021220     C                   End
121000030103      *
121100030103     C                   If        CLIVES13  = *Zeros   and
1212000301031/3  C                             COVCD13  = *Blanks
121300021220     C                   Eval      CLIVES13A = *Blanks
121400021220     C                   Else
121500021220     C                   Move      CLIVES13      CLIVES13A
121600021220     C                   End
121700030103      *
121800030103     C                   If        CLIVES14  = *Zeros  and
1219000301031/3  C                             COVCD14  = *Blanks
122000021220     C                   Eval      CLIVES14A = *Blanks
122100021220     C                   Else
122200021220     C                   Move      CLIVES14      CLIVES14A
122300021220     C                   End
122400030103      *
122500030103     C                   If        CLIVES15  = *Zeros  and
1226000301031/3  C                             COVCD15  = *Blanks
122700021220     C                   Eval      CLIVES15A = *Blanks
122800021220     C                   Else
122900021220     C                   Move      CLIVES15      CLIVES15A
123000021220     C                   End
123100030103      *
123200030103     C                   If        CLIVES16  = *Zeros   and
1233000301031/3  C                             COVCD16  = *Blanks
123400021220     C                   Eval      CLIVES16A = *Blanks
123500021220     C                   Else
123600021220     C                   Move      CLIVES16      CLIVES16A
123700021220     C                   End
123800030103      *
123900030103     C                   If        CLIVES17  = *Zeros  and
1240000301031/3  C                             COVCD17  = *Blanks
124100021220     C                   Eval      CLIVES17A = *Blanks
124200021220     C                   Else
124300021220     C                   Move      CLIVES17      CLIVES17A
124400021220     C                   End
124500021220      *
124600030103     C                   If        CLIFEV1  = *Zeros    and
1247000301031/3  C                             COVCD1   = *Blanks
124800021220     C                   Eval      CLIFEV1A = *Blanks
124900021220     C                   Else
125000040219     C                   If        CPAMTT   = *Zeros
125100040219     C                   Eval      CLIFEV1A = *Blanks
125200040219     C                   Else
125300021220     C                   Move      CLIFEV1       CLIFEV1A
125400021220     C                   End
125500040219     C                   End
125600030103      *
125700030103     C                   If        CLIFEV2  = *Zeros  and
1258000301031/3  C                             COVCD2   = *Blanks
125900021220     C                   Eval      CLIFEV2A = *Blanks
126000021220     C                   Else
126100040219     C                   If        CPAMTT   = *Zeros
126200040219     C                   Eval      CLIFEV2A = *Blanks
126300040219     C                   Else
126400021220     C                   Move      CLIFEV2       CLIFEV2A
126500021220     C                   End
126600040219     C                   End
126700030103      *
126800030103     C                   If        CLIFEV3  = *Zeros    and
1269000301031/3  C                             COVCD3   = *Blanks
127000021220     C                   Eval      CLIFEV3A = *Blanks
127100021220     C                   Else
127200040219     C                   If        CPAMTT   = *Zeros
127300040219     C                   Eval      CLIFEV3A = *Blanks
127400040219     C                   Else
127500021220     C                   Move      CLIFEV3       CLIFEV3A
127600021220     C                   End
127700040219     C                   End
127800030103      *
127900030103     C                   If        CLIFEV4  = *Zeros and
1280000301031/3  C                             COVCD4   = *Blanks
128100021220     C                   Eval      CLIFEV4A = *Blanks
128200021220     C                   Else
128300040219     C                   If        CPAMTT   = *Zeros
128400040219     C                   Eval      CLIFEV4A = *Blanks
128500040219     C                   Else
128600021220     C                   Move      CLIFEV4       CLIFEV4A
128700021220     C                   End
128800040219     C                   End
128900030103      *
129000030103     C                   If        CLIFEV5  = *Zeros and
1291000301031/3  C                             COVCD5   = *Blanks
129200021220     C                   Eval      CLIFEV5A = *Blanks
129300021220     C                   Else
129400040219     C                   If        CPAMTT   = *Zeros
129500040219     C                   Eval      CLIFEV5A = *Blanks
129600040219     C                   Else
129700021220     C                   Move      CLIFEV5       CLIFEV5A
129800021220     C                   End
129900040219     C                   End
130000030103      *
130100030103     C                   If        CLIFEV6  = *Zeros  and
1302000402191/3  C                             COVCD6   = *Blanks
130300021220     C                   Eval      CLIFEV6A = *Blanks
130400021220     C                   Else
130500040219     C                   If        CPAMTT   = *Zeros
130600040219     C                   Eval      CLIFEV6A = *Blanks
130700040219     C                   Else
130800021220     C                   Move      CLIFEV6       CLIFEV6A
130900021220     C                   End
131000040219     C                   End
131100030103      *
131200030103     C                   If        CLIFEV7  = *Zeros and
1313000301031/3  C                             COVCD7   = *Blanks
131400021220     C                   Eval      CLIFEV7A = *Blanks
131500021220     C                   Else
131600040219     C                   If        CPAMTT   = *Zeros
131700040219     C                   Eval      CLIFEV7A = *Blanks
131800040219     C                   Else
131900021220     C                   Move      CLIFEV7       CLIFEV7A
132000021220     C                   End
132100040219     C                   End
132200030103      *
132300030103     C                   If        CLIFEV8  = *Zeros    and
1324000301031/3  C                             COVCD8   = *Blanks
132500021220     C                   Eval      CLIFEV8A = *Blanks
132600021220     C                   Else
132700040219     C                   If        CPAMTT   = *Zeros
132800040219     C                   Eval      CLIFEV8A = *Blanks
132900040219     C                   Else
133000021220     C                   Move      CLIFEV8       CLIFEV8A
133100040219     C                   End
133200021220     C                   End
133300030103      *
133400030103     C                   If        CLIFEV9  = *Zeros  and
1335000301031/3  C                             COVCD9   = *Blanks
133600021220     C                   Eval      CLIFEV9A = *Blanks
133700021220     C                   Else
133800040219     C                   If        CPAMTT   = *Zeros
133900040219     C                   Eval      CLIFEV9A = *Blanks
134000040219     C                   Else
134100021220     C                   Move      CLIFEV9       CLIFEV9A
134200021220     C                   End
134300040219     C                   End
134400030103      *
134500030103     C                   If        CLIFEV10  = *Zeros and
1346000301031/3  C                             COVCD10  = *Blanks
134700021220     C                   Eval      CLIFEV10A = *Blanks
134800021220     C                   Else
134900040219     C                   If        CPAMTT   = *Zeros
135000040219     C                   Eval      CLIFEV10A = *Blanks
135100040219     C                   Else
135200021220     C                   Move      CLIFEV10      CLIFEV10A
135300021220     C                   End
135400040219     C                   End
135500030103      *
135600030103     C                   If        CLIFEV11  = *Zeros and
1357000301031/3  C                             COVCD11  = *Blanks
135800021220     C                   Eval      CLIFEV11A = *Blanks
135900021220     C                   Else
136000040219     C                   If        CPAMTT   = *Zeros
136100040219     C                   Eval      CLIFEV11A = *Blanks
136200040219     C                   Else
136300021220     C                   Move      CLIFEV11      CLIFEV11A
136400021220     C                   End
136500040219     C                   End
136600030103      *
136700030103     C                   If        CLIFEV12  = *Zeros  and
1368000301031/3  C                             COVCD12  = *Blanks
136900021220     C                   Eval      CLIFEV12A = *Blanks
137000021220     C                   Else
137100040219     C                   If        CPAMTT   = *Zeros
137200040219     C                   Eval      CLIFEV12A = *Blanks
137300040219     C                   Else
137400021220     C                   Move      CLIFEV12      CLIFEV12A
137500021220     C                   End
137600040219     C                   End
137700030103      *
137800030103     C                   If        CLIFEV13  = *Zeros  and
1379000301031/3  C                             COVCD13  = *Blanks
138000021220     C                   Eval      CLIFEV13A = *Blanks
138100021220     C                   Else
138200040219     C                   If        CPAMTT   = *Zeros
138300040219     C                   Eval      CLIFEV13A = *Blanks
138400040219     C                   Else
138500021220     C                   Move      CLIFEV13      CLIFEV13A
138600021220     C                   End
138700040219     C                   End
138800030103      *
138900030103     C                   If        CLIFEV14  = *Zeros    and
1390000301031/3  C                             COVCD14  = *Blanks
139100021220     C                   Eval      CLIFEV14A = *Blanks
139200021220     C                   Else
139300040219     C                   If        CPAMTT   = *Zeros
139400040219     C                   Eval      CLIFEV14A = *Blanks
139500040219     C                   Else
139600021220     C                   Move      CLIFEV14      CLIFEV14A
139700021220     C                   End
139800040219     C                   End
139900030103      *
140000030103     C                   If        CLIFEV15  = *Zeros  and
1401000301031/3  C                             COVCD15  = *Blanks
140200021220     C                   Eval      CLIFEV15A = *Blanks
140300021220     C                   Else
140400040219     C                   If        CPAMTT   = *Zeros
140500040219     C                   Eval      CLIFEV15A = *Blanks
140600040219     C                   Else
140700021220     C                   Move      CLIFEV15      CLIFEV15A
140800021220     C                   End
140900040219     C                   End
141000030103      *
141100030103     C                   If        CLIFEV16  = *Zeros  and
1412000301031/3  C                             COVCD16  = *Blanks
141300021220     C                   Eval      CLIFEV16A = *Blanks
141400021220     C                   Else
141500040219     C                   If        CPAMTT   = *Zeros
141600040219     C                   Eval      CLIFEV16A = *Blanks
141700040219     C                   Else
141800021220     C                   Move      CLIFEV16      CLIFEV16A
141900021220     C                   End
142000040219     C                   End
142100030103      *
142200030103     C                   If        CLIFEV17  = *Zeros and
1423000301031/3  C                             COVCD17  = *Blanks
142400021220     C                   Eval      CLIFEV17A = *Blanks
142500021220     C                   Else
142600040219     C                   If        CPAMTT   = *Zeros
142700040219     C                   Eval      CLIFEV17A = *Blanks
142800040219     C                   Else
142900021220     C                   Move      CLIFEV17      CLIFEV17A
143000021220     C                   End
143100040219     C                   End
143200021220      *
143300030103     C                   If        PREMIUM1  = *Zeros    and
1434000301031/3  C                             COVCD1   = *Blanks
143500021220     C                   Eval      PREMIUM1A = *Blanks
143600021220     C                   Else
143700021220     C                   Move      PREMIUM1      PREMIUM1A
143800021220     C                   End
143900030103      *
144000030103     C                   If        PREMIUM2  = *Zeros  and
1441000301031/3  C                             COVCD2   = *Blanks
144200021220     C                   Eval      PREMIUM2A = *Blanks
144300021220     C                   Else
144400021220     C                   Move      PREMIUM2      PREMIUM2A
144500021220     C                   End
144600030103      *
144700030103     C                   If        PREMIUM3  = *Zeros  and
1448000301031/3  C                             COVCD3   = *Blanks
144900021220     C                   Eval      PREMIUM3A = *Blanks
145000021220     C                   Else
145100021220     C                   Move      PREMIUM3      PREMIUM3A
145200021220     C                   End
145300030103      *
145400030103     C                   If        PREMIUM4  = *Zeros and
1455000301031/3  C                             COVCD4   = *Blanks
145600021220     C                   Eval      PREMIUM4A = *Blanks
145700021220     C                   Else
145800021220     C                   Move      PREMIUM4      PREMIUM4A
145900021220     C                   End
146000030103      *
146100030103     C                   If        PREMIUM5  = *Zeros  and
1462000301031/3  C                             COVCD5   = *Blanks
146300021220     C                   Eval      PREMIUM5A = *Blanks
146400021220     C                   Else
146500021220     C                   Move      PREMIUM5      PREMIUM5A
146600021220     C                   End
146700030103      *
146800030103     C                   If        PREMIUM6  = *Zeros and
1469000301031/3  C                             COVCD6   = *Blanks
147000021220     C                   Eval      PREMIUM6A = *Blanks
147100021220     C                   Else
147200021220     C                   Move      PREMIUM6      PREMIUM6A
147300021220     C                   End
147400030103      *
147500030103     C                   If        PREMIUM7  = *Zeros  and
1476000301031/3  C                             COVCD7   = *Blanks
147700021220     C                   Eval      PREMIUM7A = *Blanks
147800021220     C                   Else
147900021220     C                   Move      PREMIUM7      PREMIUM7A
148000021220     C                   End
148100030103      *
148200030103     C                   If        PREMIUM8  = *Zeros and
1483000301031/3  C                             COVCD8   = *Blanks
148400021220     C                   Eval      PREMIUM8A = *Blanks
148500021220     C                   Else
148600021220     C                   Move      PREMIUM8      PREMIUM8A
148700021220     C                   End
148800030103      *
148900030103     C                   If        PREMIUM9  = *Zeros    and
1490000301031/3  C                             COVCD9   = *Blanks
149100021220     C                   Eval      PREMIUM9A = *Blanks
149200021220     C                   Else
149300021220     C                   Move      PREMIUM9      PREMIUM9A
149400021220     C                   End
149500030103      *
149600030103     C                   If        PREMIUM10 = *Zeros and
1497000301031/3  C                             COVCD10  = *Blanks
149800021220     C                   Eval      PREMIUM10A = *Blanks
149900021220     C                   Else
150000021220     C                   Move      PREMIUM10     PREMIUM10A
150100021220     C                   End
150200030103      *
150300030103     C                   If        PREMIUM11 = *Zeros and
1504000301031/3  C                             COVCD11  = *Blanks
150500021220     C                   Eval      PREMIUM11A = *Blanks
150600021220     C                   Else
150700021220     C                   Move      PREMIUM11     PREMIUM11A
150800021220     C                   End
150900030103      *
151000030103     C                   If        PREMIUM12 = *Zeros and
1511000301031/3  C                             COVCD12  = *Blanks
151200021220     C                   Eval      PREMIUM12A = *Blanks
151300021220     C                   Else
151400021220     C                   Move      PREMIUM12     PREMIUM12A
151500021220     C                   End
151600030103      *
151700030103     C                   If        PREMIUM13  = *Zeros  and
1518000301031/3  C                             COVCD13  = *Blanks
151900021220     C                   Eval      PREMIUM13A = *Blanks
152000021220     C                   Else
152100021220     C                   Move      PREMIUM13     PREMIUM13A
152200021220     C                   End
152300030103      *
152400030103     C                   If        PREMIUM14  = *Zeros  and
1525000301031/3  C                             COVCD14  = *Blanks
152600021220     C                   Eval      PREMIUM14A = *Blanks
152700021220     C                   Else
152800021220     C                   Move      PREMIUM14     PREMIUM14A
152900021220     C                   End
153000030103      *
153100030103     C                   If        PREMIUM15  = *Zeros and
1532000301031/3  C                             COVCD15  = *Blanks
153300021220     C                   Eval      PREMIUM15A = *Blanks
153400021220     C                   Else
153500021220     C                   Move      PREMIUM15     PREMIUM15A
153600021220     C                   End
153700030103      *
153800030103     C                   If        PREMIUM16  = *Zeros   and
1539000301031/3  C                             COVCD16  = *Blanks
154000021220     C                   Eval      PREMIUM16A = *Blanks
154100021220     C                   Else
154200021220     C                   Move      PREMIUM16     PREMIUM16A
154300021220     C                   End
154400030103      *
154500030103     C                   If        PREMIUM17  = *Zeros  and
1546000301031/3  C                             COVCD17  = *Blanks
154700021220     C                   Eval      PREMIUM17A = *Blanks
154800021220     C                   Else
154900021220     C                   Move      PREMIUM17     PREMIUM17A
155000021220     C                   End
155100021220      *
155200030103     C                   If        ADPREM1  = *Zeros  and
1553000301031/3  C                             COVCD1   = *Blanks
155400021220     C                   Eval      ADPREM1A = *Blanks
155500021220     C                   Else
155600021220     C                   Move      ADPREM1       ADPREM1A
155700021220     C                   End
155800030103      *
155900030103     C                   If        ADPREM2  = *Zeros  and
1560000301031/3  C                             COVCD2   = *Blanks
156100021220     C                   Eval      ADPREM2A = *Blanks
156200021220     C                   Else
156300021220     C                   Move      ADPREM2       ADPREM2A
156400021220     C                   End
156500030103      *
156600030103     C                   If        ADPREM3  = *Zeros and
1567000301031/3  C                             COVCD3   = *Blanks
156800021220     C                   Eval      ADPREM3A = *Blanks
156900021220     C                   Else
157000021220     C                   Move      ADPREM3       ADPREM3A
157100021220     C                   End
157200030103      *
157300030103     C                   If        ADPREM4  = *Zeros  and
1574000301031/3  C                             COVCD4   = *Blanks
157500021220     C                   Eval      ADPREM4A = *Blanks
157600021220     C                   Else
157700021220     C                   Move      ADPREM4       ADPREM4A
157800021220     C                   End
157900030103      *
158000030103     C                   If        ADPREM5  = *Zeros  and
1581000301031/3  C                             COVCD5   = *Blanks
158200021220     C                   Eval      ADPREM5A = *Blanks
158300021220     C                   Else
158400021220     C                   Move      ADPREM5       ADPREM5A
158500021220     C                   End
158600030103      *
158700030103     C                   If        ADPREM6  = *Zeros     and
1588000301031/3  C                             COVCD6   = *Blanks
158900021220     C                   Eval      ADPREM6A = *Blanks
159000021220     C                   Else
159100021220     C                   Move      ADPREM6       ADPREM6A
159200021220     C                   End
159300030103      *
159400030103     C                   If        ADPREM7  = *Zeros  and
1595000301031/3  C                             COVCD7   = *Blanks
159600021220     C                   Eval      ADPREM7A = *Blanks
159700021220     C                   Else
159800021220     C                   Move      ADPREM7       ADPREM7A
159900021220     C                   End
160000030103      *
160100030103     C                   If        ADPREM8  = *Zeros  and
1602000301031/3  C                             COVCD8   = *Blanks
160300021220     C                   Eval      ADPREM8A = *Blanks
160400021220     C                   Else
160500021220     C                   Move      ADPREM8       ADPREM8A
160600021220     C                   End
160700030103      *
160800030103     C                   If        ADPREM9  = *Zeros and
1609000301031/3  C                             COVCD9   = *Blanks
161000021220     C                   Eval      ADPREM9A = *Blanks
161100021220     C                   Else
161200021220     C                   Move      ADPREM9       ADPREM9A
161300021220     C                   End
161400030103      *
161500030103     C                   If        ADPREM10  = *Zeros  and
1616000301031/3  C                             COVCD10  = *Blanks
161700021220     C                   Eval      ADPREM10A = *Blanks
161800021220     C                   Else
161900021220     C                   Move      ADPREM10      ADPREM10A
162000021220     C                   End
162100030103      *
162200030103     C                   If        ADPREM11  = *Zeros and
1623000301031/3  C                             COVCD11  = *Blanks
162400021220     C                   Eval      ADPREM11A = *Blanks
162500021220     C                   Else
162600021220     C                   Move      ADPREM11      ADPREM11A
162700021220     C                   End
162800030103      *
162900030103     C                   If        ADPREM12  = *Zeros  and
1630000301031/3  C                             COVCD12  = *Blanks
163100021220     C                   Eval      ADPREM12A = *Blanks
163200021220     C                   Else
163300021220     C                   Move      ADPREM12      ADPREM12A
163400021220     C                   End
163500030103      *
163600030103     C                   If        ADPREM13  = *Zeros and
1637000301031/3  C                             COVCD13  = *Blanks
163800021220     C                   Eval      ADPREM13A = *Blanks
163900021220     C                   Else
164000021220     C                   Move      ADPREM13      ADPREM13A
164100021220     C                   End
164200030103      *
164300030103     C                   If        ADPREM14  = *Zeros  and
1644000301031/3  C                             COVCD14  = *Blanks
164500021220     C                   Eval      ADPREM14A = *Blanks
164600021220     C                   Else
164700021220     C                   Move      ADPREM14      ADPREM14A
164800021220     C                   End
164900030103      *
165000030103     C                   If        ADPREM15  = *Zeros  and
1651000301031/3  C                             COVCD15  = *Blanks
165200021220     C                   Eval      ADPREM15A = *Blanks
165300021220     C                   Else
165400021220     C                   Move      ADPREM15      ADPREM15A
165500021220     C                   End
165600030103      *
165700030103     C                   If        ADPREM16  = *Zeros  and
1658000301031/3  C                             COVCD16  = *Blanks
165900021220     C                   Eval      ADPREM16A = *Blanks
166000021220     C                   Else
166100021220     C                   Move      ADPREM16      ADPREM16A
166200021220     C                   End
166300030103      *
166400030103     C                   If        ADPREM17  = *Zeros  and
1665000301031/3  C                             COVCD17  = *Blanks
166600021220     C                   Eval      ADPREM17A = *Blanks
166700021220     C                   Else
166800021220     C                   Move      ADPREM17      ADPREM17A
166900021220     C                   End
167000021220      *
167100021220    ?C                   Endsr
167200021031      *___________________________________________________________________
167300021031      * Clear all amounts and space delimiter fields.
167400021031      *___________________________________________________________________
167500021031     C     ClearAll      BEGSR
167600021031      *
167700021224     C                   Eval      VLSIGN1 = *Blanks
167800021031     C                   Z-add     *Zeros        CLIFEV1
167900021224     C                   Eval      VLSIGN2 = *Blanks
168000021031     C                   Z-add     *Zeros        CLIFEV2
168100021224     C                   Eval      VLSIGN3 = *Blanks
168200021031     C                   Z-add     *Zeros        CLIFEV3
168300021224     C                   Eval      VLSIGN4 = *Blanks
168400021031     C                   Z-add     *Zeros        CLIFEV4
168500021224     C                   Eval      VLSIGN5 = *Blanks
168600021031     C                   Z-add     *Zeros        CLIFEV5
168700021224     C                   Eval      VLSIGN6 = *Blanks
168800021031     C                   Z-add     *Zeros        CLIFEV6
168900021224     C                   Eval      VLSIGN7 = *Blanks
169000021031     C                   Z-add     *Zeros        CLIFEV7
169100021224     C                   Eval      VLSIGN8 = *Blanks
169200021031     C                   Z-add     *Zeros        CLIFEV8
169300021224     C                   Eval      VLSIGN9 = *Blanks
169400021031     C                   Z-add     *Zeros        CLIFEV9
169500021224     C                   Eval      VLSIGN10 = *Blanks
169600021031     C                   Z-add     *Zeros        CLIFEV10
169700021224     C                   Eval      VLSIGN11 = *Blanks
169800021031     C                   Z-add     *Zeros        CLIFEV11
169900021224     C                   Eval      VLSIGN12 = *Blanks
170000021031     C                   Z-add     *Zeros        CLIFEV12
170100021224     C                   Eval      VLSIGN13 = *Blanks
170200021031     C                   Z-add     *Zeros        CLIFEV13
170300021224     C                   Eval      VLSIGN14 = *Blanks
170400021031     C                   Z-add     *Zeros        CLIFEV14
170500021224     C                   Eval      VLSIGN15 = *Blanks
170600021031     C                   Z-add     *Zeros        CLIFEV15
170700021224     C                   Eval      VLSIGN16 = *Blanks
170800021031     C                   Z-add     *Zeros        CLIFEV16
170900021224     C                   Eval      VLSIGN17 = *Blanks
171000021203     C                   Z-add     *Zeros        CLIFEV17
171100021031      *
171200021224     C                   Eval      LISIGN1 = *Blanks
171300021031     C                   Z-add     *Zeros        CLIVES1
171400021224     C                   Eval      LISIGN2 = *Blanks
171500021031     C                   Z-add     *Zeros        CLIVES2
171600021224     C                   Eval      LISIGN3 = *Blanks
171700021031     C                   Z-add     *Zeros        CLIVES3
171800021224     C                   Eval      LISIGN4 = *Blanks
171900021031     C                   Z-add     *Zeros        CLIVES4
172000021224     C                   Eval      LISIGN5 = *Blanks
172100021031     C                   Z-add     *Zeros        CLIVES5
172200021224     C                   Eval      LISIGN6 = *Blanks
172300021031     C                   Z-add     *Zeros        CLIVES6
172400021224     C                   Eval      LISIGN7 = *Blanks
172500021031     C                   Z-add     *Zeros        CLIVES7
172600021224     C                   Eval      LISIGN8 = *Blanks
172700021031     C                   Z-add     *Zeros        CLIVES8
172800021224     C                   Eval      LISIGN9 = *Blanks
172900021031     C                   Z-add     *Zeros        CLIVES9
173000021224     C                   Eval      LISIGN10 = *Blanks
173100021031     C                   Z-add     *Zeros        CLIVES10
173200021224     C                   Eval      LISIGN11 = *Blanks
173300021031     C                   Z-add     *Zeros        CLIVES11
173400021224     C                   Eval      LISIGN12 = *Blanks
173500021031     C                   Z-add     *Zeros        CLIVES12
173600021224     C                   Eval      LISIGN13 = *Blanks
173700021031     C                   Z-add     *Zeros        CLIVES13
173800021224     C                   Eval      LISIGN14 = *Blanks
173900021031     C                   Z-add     *Zeros        CLIVES14
174000021224     C                   Eval      LISIGN15 = *Blanks
174100021031     C                   Z-add     *Zeros        CLIVES15
174200021224     C                   Eval      LISIGN16 = *Blanks
174300021031     C                   Z-add     *Zeros        CLIVES16
174400021224     C                   Eval      LISIGN17 = *Blanks
174500021203     C                   Z-add     *Zeros        CLIVES17
174600021031      *
174700021031     C                   Z-add     *Zeros        PREMIUM1
174800021224     C                   Eval      PRSIGN1 = *Blanks
174900021031     C                   Z-add     *Zeros        PREMIUM2
175000021224     C                   Eval      PRSIGN2 = *Blanks
175100021031     C                   Z-add     *Zeros        PREMIUM3
175200021224     C                   Eval      PRSIGN3 = *Blanks
175300021031     C                   Z-add     *Zeros        PREMIUM4
175400021224     C                   Eval      PRSIGN4 = *Blanks
175500021031     C                   Z-add     *Zeros        PREMIUM5
175600021224     C                   Eval      PRSIGN5 = *Blanks
175700021031     C                   Z-add     *Zeros        PREMIUM6
175800021224     C                   Eval      PRSIGN6 = *Blanks
175900021031     C                   Z-add     *Zeros        PREMIUM7
176000021224     C                   Eval      PRSIGN7 = *Blanks
176100021031     C                   Z-add     *Zeros        PREMIUM8
176200021224     C                   Eval      PRSIGN8 = *Blanks
176300021031     C                   Z-add     *Zeros        PREMIUM9
176400021224     C                   Eval      PRSIGN9 = *Blanks
176500021031     C                   Z-add     *Zeros        PREMIUM10
176600021224     C                   Eval      PRSIGN10 = *Blanks
176700021031     C                   Z-add     *Zeros        PREMIUM11
176800021224     C                   Eval      PRSIGN11 = *Blanks
176900021031     C                   Z-add     *Zeros        PREMIUM12
177000021224     C                   Eval      PRSIGN12 = *Blanks
177100021031     C                   Z-add     *Zeros        PREMIUM13
177200021224     C                   Eval      PRSIGN13 = *Blanks
177300021031     C                   Z-add     *Zeros        PREMIUM14
177400021224     C                   Eval      PRSIGN14 = *Blanks
177500021031     C                   Z-add     *Zeros        PREMIUM15
177600021224     C                   Eval      PRSIGN15 = *Blanks
177700021031     C                   Z-add     *Zeros        PREMIUM16
177800021224     C                   Eval      PRSIGN16 = *Blanks
177900021203     C                   Z-add     *Zeros        PREMIUM17
178000021224     C                   Eval      PRSIGN17 = *Blanks
178100021031      *
178200021031     C                   Z-add     *Zeros        ADPREM1
178300021224     C                   Eval      APSIGN1 = *Blanks
178400021031     C                   Z-add     *Zeros        ADPREM2
178500021224     C                   Eval      APSIGN2 = *Blanks
178600021031     C                   Z-add     *Zeros        ADPREM3
178700021224     C                   Eval      APSIGN3 = *Blanks
178800021031     C                   Z-add     *Zeros        ADPREM4
178900021224     C                   Eval      APSIGN4 = *Blanks
179000021031     C                   Z-add     *Zeros        ADPREM5
179100021224     C                   Eval      APSIGN5 = *Blanks
179200021031     C                   Z-add     *Zeros        ADPREM6
179300021224     C                   Eval      APSIGN6 = *Blanks
179400021031     C                   Z-add     *Zeros        ADPREM7
179500021224     C                   Eval      APSIGN7 = *Blanks
179600021031     C                   Z-add     *Zeros        ADPREM8
179700021224     C                   Eval      APSIGN8 = *Blanks
179800021031     C                   Z-add     *Zeros        ADPREM9
179900021224     C                   Eval      APSIGN9 = *Blanks
180000021031     C                   Z-add     *Zeros        ADPREM10
180100021224     C                   Eval      APSIGN10 = *Blanks
180200021031     C                   Z-add     *Zeros        ADPREM11
180300021224     C                   Eval      APSIGN11 = *Blanks
180400021031     C                   Z-add     *Zeros        ADPREM12
180500021224     C                   Eval      APSIGN12 = *Blanks
180600021031     C                   Z-add     *Zeros        ADPREM13
180700021224     C                   Eval      APSIGN13 = *Blanks
180800021031     C                   Z-add     *Zeros        ADPREM14
180900021224     C                   Eval      APSIGN14 = *Blanks
181000021031     C                   Z-add     *Zeros        ADPREM15
181100021224     C                   Eval      APSIGN15 = *Blanks
181200021031     C                   Z-add     *Zeros        ADPREM16
181300021224     C                   Eval      APSIGN16 = *Blanks
181400021203     C                   Z-add     *Zeros        ADPREM17
181500021224     C                   Eval      APSIGN17 = *Blanks
181600021031      *
181700021031     C                   Move      ' '           FIL1
181800021031     C                   Move      ' '           FIL2
181900021031     C                   Move      ' '           FIL3
182000021031     C                   Move      ' '           FIL4
182100021031     C                   Move      ' '           FIL5
182200021031     C                   Move      ' '           FIL6
182300021031     C                   Move      ' '           FILB1C1
182400021031     C                   Move      ' '           FILB1C2
182500021031     C                   Move      ' '           FILB1C3
182600021031     C                   Move      ' '           FILB1C4
182700021031     C                   Move      ' '           FILB1C5
182800021031     C                   Move      ' '           FILB2C1
182900021031     C                   Move      ' '           FILB2C2
183000021031     C                   Move      ' '           FILB2C3
183100021031     C                   Move      ' '           FILB2C4
183200021031     C                   Move      ' '           FILB2C5
183300021031     C                   Move      ' '           FILB3C1
183400021031     C                   Move      ' '           FILB3C2
183500021031     C                   Move      ' '           FILB3C3
183600021031     C                   Move      ' '           FILB3C4
183700021031     C                   Move      ' '           FILB3C5
183800021031     C                   Move      ' '           FILB4C1
183900021031     C                   Move      ' '           FILB4C2
184000021031     C                   Move      ' '           FILB4C3
184100021031     C                   Move      ' '           FILB4C4
184200021031     C                   Move      ' '           FILB4C5
184300021031     C                   Move      ' '           FILB5C1
184400021031     C                   Move      ' '           FILB5C2
184500021031     C                   Move      ' '           FILB5C3
184600021031     C                   Move      ' '           FILB5C4
184700021031     C                   Move      ' '           FILB5C5
184800021031     C                   Move      ' '           FILB6C1
184900021031     C                   Move      ' '           FILB6C2
185000021031     C                   Move      ' '           FILB6C3
185100021031     C                   Move      ' '           FILB6C4
185200021031     C                   Move      ' '           FILB6C5
185300021031     C                   Move      ' '           FILB7C1
185400021031     C                   Move      ' '           FILB7C2
185500021031     C                   Move      ' '           FILB7C3
185600021031     C                   Move      ' '           FILB7C4
185700021031     C                   Move      ' '           FILB7C5
185800021031     C                   Move      ' '           FILB8C1
185900021031     C                   Move      ' '           FILB8C2
186000021031     C                   Move      ' '           FILB8C3
186100021031     C                   Move      ' '           FILB8C4
186200021031     C                   Move      ' '           FILB8C5
186300021031     C                   Move      ' '           FILB9C1
186400021031     C                   Move      ' '           FILB9C2
186500021031     C                   Move      ' '           FILB9C3
186600021031     C                   Move      ' '           FILB9C4
186700021031     C                   Move      ' '           FILB9C5
186800021031     C                   Move      ' '           FILB10C1
186900021031     C                   Move      ' '           FILB10C2
187000021031     C                   Move      ' '           FILB10C3
187100021031     C                   Move      ' '           FILB10C4
187200021031     C                   Move      ' '           FILB10C5
187300021031     C                   Move      ' '           FILB11C1
187400021031     C                   Move      ' '           FILB11C2
187500021031     C                   Move      ' '           FILB11C3
187600021031     C                   Move      ' '           FILB11C4
187700021031     C                   Move      ' '           FILB11C5
187800021031     C                   Move      ' '           FILB12C1
187900021031     C                   Move      ' '           FILB12C2
188000021031     C                   Move      ' '           FILB12C3
188100021031     C                   Move      ' '           FILB12C4
188200021031     C                   Move      ' '           FILB12C5
188300021031     C                   Move      ' '           FILB13C1
188400021031     C                   Move      ' '           FILB13C2
188500021031     C                   Move      ' '           FILB13C3
188600021031     C                   Move      ' '           FILB13C4
188700021031     C                   Move      ' '           FILB13C5
188800021031     C                   Move      ' '           FILB14C1
188900021031     C                   Move      ' '           FILB14C2
189000021031     C                   Move      ' '           FILB14C3
189100021031     C                   Move      ' '           FILB14C4
189200021031     C                   Move      ' '           FILB14C5
189300021031     C                   Move      ' '           FILB15C1
189400021031     C                   Move      ' '           FILB15C2
189500021031     C                   Move      ' '           FILB15C3
189600021031     C                   Move      ' '           FILB15C4
189700021031     C                   Move      ' '           FILB15C5
189800021031     C                   Move      ' '           FILB16C1
189900021031     C                   Move      ' '           FILB16C2
190000021031     C                   Move      ' '           FILB16C3
190100021031     C                   Move      ' '           FILB16C4
190200021031     C                   Move      ' '           FILB16C5
190300021203     C                   Move      ' '           FILB17C1
190400021203     C                   Move      ' '           FILB17C2
190500021203     C                   Move      ' '           FILB17C3
190600021203     C                   Move      ' '           FILB17C4
190700021203     C                   Move      ' '           FILB17C5
190800021031      *
190900021031    ?C                   Endsr
191000021025      *___________________________________________________________________
191100021025      * Clear coverage code block fields after writing the output record.
191200021025      *___________________________________________________________________
191300021025     C     ClearAfter    BEGSR
191400021025      *
191500030807     C                   Clear                   CR170JR
191600021025     C                   Clear                   Box
191700021025     C                   Reset                   B
191800021025     C                   Clear                   CL01              5 0
191900021025     C                   Clear                   CL02              5 0
192000021025     C                   Clear                   CL03              5 0
192100021025     C                   Clear                   CL04              5 0
192200021025     C                   Clear                   CL05              5 0
192300021025     C                   Clear                   CL06              5 0
192400021025     C                   Clear                   CL07              5 0
192500021025     C                   Clear                   CL08              5 0
192600021025     C                   Clear                   CL09              5 0
192700021025     C                   Clear                   CL10              5 0
192800021025     C                   Clear                   CL11              5 0
192900021025     C                   Clear                   CL12              5 0
193000021025     C                   Clear                   CL13              5 0
193100021025     C                   Clear                   CL14              5 0
193200021025     C                   Clear                   CL15              5 0
193300021025     C                   Clear                   CL16              5 0
193400021203     C                   Clear                   CL17              5 0
193500021025     C                   Clear                   CLV01             9 0
193600021025     C                   Clear                   CLV02             9 0
193700021025     C                   Clear                   CLV03             9 0
193800021025     C                   Clear                   CLV04             9 0
193900021025     C                   Clear                   CLV05             9 0
194000021025     C                   Clear                   CLV06             9 0
194100021025     C                   Clear                   CLV07             9 0
194200021025     C                   Clear                   CLV08             9 0
194300021025     C                   Clear                   CLV09             9 0
194400021025     C                   Clear                   CLV10             9 0
194500021025     C                   Clear                   CLV11             9 0
194600021025     C                   Clear                   CLV12             9 0
194700021025     C                   Clear                   CLV13             9 0
194800021025     C                   Clear                   CLV14             9 0
194900021025     C                   Clear                   CLV15             9 0
195000021025     C                   Clear                   CLV16             9 0
195100021203     C                   Clear                   CLV17             9 0
195200021025     C                   Clear                   CP01              9 2
195300021025     C                   Clear                   CP02              9 2
195400021025     C                   Clear                   CP03              9 2
195500021025     C                   Clear                   CP04              9 2
195600021025     C                   Clear                   CP05              9 2
195700021025     C                   Clear                   CP06              9 2
195800021025     C                   Clear                   CP07              9 2
195900021025     C                   Clear                   CP08              9 2
196000021025     C                   Clear                   CP09              9 2
196100021025     C                   Clear                   CP10              9 2
196200021025     C                   Clear                   CP11              9 2
196300021025     C                   Clear                   CP12              9 2
196400021025     C                   Clear                   CP13              9 2
196500021025     C                   Clear                   CP14              9 2
196600021025     C                   Clear                   CP15              9 2
196700021025     C                   Clear                   CP16              9 2
196800021203     C                   Clear                   CP17              9 2
196900021028     C                   Clear                   Caamt01           9 2
197000021028     C                   Clear                   Caamt02           9 2
197100021028     C                   Clear                   Caamt03           9 2
197200021028     C                   Clear                   Caamt04           9 2
197300021028     C                   Clear                   Caamt05           9 2
197400021028     C                   Clear                   Caamt06           9 2
197500021028     C                   Clear                   Caamt07           9 2
197600021028     C                   Clear                   Caamt08           9 2
197700021028     C                   Clear                   Caamt09           9 2
197800021028     C                   Clear                   Caamt10           9 2
197900021028     C                   Clear                   Caamt11           9 2
198000021028     C                   Clear                   Caamt12           9 2
198100021028     C                   Clear                   Caamt13           9 2
198200021028     C                   Clear                   Caamt14           9 2
198300021028     C                   Clear                   Caamt15           9 2
198400021028     C                   Clear                   Caamt16           9 2
198500021203     C                   Clear                   Caamt17           9 2
198600021224     C                   Eval      LCSIGN  = *Blanks
198700021028     C                   Z-add     *Zeros        CCOMELT
198800021224     C                   Eval      HCSIGN  = *Blanks
198900021028     C                   Z-add     *Zeros        CCOMEHT
199000021025      *
199100021025    ?C                   Endsr
199200131017      *___________________________________________________________________
199300020716      * Program initialization
199400020716      *___________________________________________________________________
199500020716     C     *INZSR        BEGSR
199600020716      *
199700021021     C     PlnKey        KLIST
199800021021     C                   KFLD                    CTRUST
199900021021     C                   KFLD                    CSUB
200000021021     C                   KFLD                    CPLAN
200100021021
200200021022     C     AccKey        KLIST
200300021022     C                   KFLD                    CTRUST
200400021022     C                   KFLD                    CSUB
200500021022     C                   KFLD                    CACCT
200600021022
200700021001     C     LMDY          MULT      10000.0001    EFFDT             8 0
2008000704124/07 C                   Movel     EFFDT         CCYYMM            6 0
2009000704124/07 C                   Movel     CCYYMM        CmpYear           4 0
2010000704124/07 C                   Move      CCYYMM        CmpMonth          2 0
201100021001     C                   Move      '-'           Minus             1
201200021001     C                   Move      '+'           Plus              1
201300021022     C                   Z-add     *Zero         ErrorCtr          7 0
201400021022     C                   TIME                    TIME_DATE
201500021024     C                   Write     Head
201600021025     C                   Write     Sub
201700020716      *
201800020716    ?C                   Endsr
