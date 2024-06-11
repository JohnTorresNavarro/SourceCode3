000100000218     **********************************************************************
000200000223     ** FM050 APPLICATION = DECLINING LIFE FILE MAINTENANCE
000300000218     **
000400000223     ** FM050R - MAINTENANCE PROGRAM TO ADD/CHANGE GRATE FILE RECORDS.
000500000218     **
000600000223     ** ORIGINAL SOURCE BY WALTER J. PICCININI 19900416 [S/36-RPGII]
000700000218     **                    GROUP BENEFIT SERVICES SOFTWARE  1988
000800000218     **
000900000223     ** REWRITTEN SOURCE BY STEPHEN S. KING 20000223 [AS/400-RPGIV]
001000000218     **                     INNOVATIVE OUTSOURCING SOFTWARE  2000
001100000428     **.4
001200010618     ** 06/18/01 DLK - Allow "AC" plan type
001300011023     ** 10/23/01 DLK - Allow "BD" plan type
001400020121     ** 01.21.02 DMA - Allow "EV" plan type
001500030730     ** 07/30/03 DLK - Allow "OA" & "CC" plan type
001600031222     ** 12/22/03 DLK - Allow "LS" & "SA" plan type
001700040809     ** 08/09/04 DLK - Allow "SS" plan type
001800060323     ** 03/23/06 DLK - Allow "SP" plan type
001900070824     ** 08.23.07 DMA - Allow "AA" plan type
002000090115     ** 01/15/09 DLK - Allow "TL" plan type
002100090728     ** 07/28/09 DLK - Allow "NS" & "NE" plan types
002200110711     ** 07.11.11 DMA - Allow S1-S9, D1-D3 and O1-O3
002300120521     ** 05/21/12 DLK - Allow "A1" & "LL" plan types
002400130213     ** 02/13/13 DLK - no change to this program but the hard coded list of
002500130213     **                plan types has been removed from DB932I and DB933 so
002600130213     **                it is no longer necessary replicate it in those pgms
002700170620     ** 06/20/17 DLK - Allow "CB" plan type
002800191003     ** 10/03/2019 B.Rees  Allow "06" Plan Type.
002900191003     **   Ticket #: CR000169
003000191003     **   Mod ID:  Br01
003100200612     ** 06/12/20 DLK - Allow "32" & "33" plan types per Brandon.
003200211220     ** 12/20/21 DLK - Allow "VW" plan type per Shelly
003300191003     **
003400000218     **********************************************************************
003500000218     **
003600000218     ** MODIFICATION HISTORY
003700000218     **
003800000218     ** ### UUU CCYYMMDD X---->
003900000223     ** 000 SSK 20000223 REWRITE OF 1990 SOURCE
004000001121     ** 001 SSK 20001121 FIX FLAG USAGE FOR UPDATES
004100011009     ** 002 SSK 20011009 ADD TRUST, SUB, & PLAN INQUIRIES
004200130917     ** 003 SSK 20130917 REMOVE DELETE/REVIVE FUNCTIONS PER RAPSKI AND WILLIAMS
004300130917     **
004400130917     **
004500000218     **********************************************************************
004600000223     FDECLIF    UF A E           K DISK
004700000223     ** DECLINING LIFE BENEFIT RATE PHYSICAL FILE
004800000210     FPLNMST    IF   E           K DISK
004900000218     ** PLAN MASTER FILE
005000000210     FTRSMST    IF   E           K DISK
005100000218     ** TRUST MASTER FILE
005200000210     FSUBMST    IF   E           K DISK
005300000218     ** SUBDIVISION MASTER FILE
005400000223     FDLFHIST0  O  A E             DISK
005500000223     ** DECLINING LIFE BENEFIT RATE PHYSICAL FILE
005600000428     FFM050D    CF   E             WORKSTN INFDS(WSDS)
005700000223     F                                     SFILE(IO02S:RRT)
005800000218     ** MAINTENANCE SCREEN
005900000209   X***X
006000000218    *** COMPANY TITLE
006100000211     D                UDS
006200000211     D  TITLE                201    240A
006300000218      *
006400000218    *** INDICATOR FIELDS DATA STRUCTURE
006500000218      *
006600000209     D WSDS            DS
006700000209     D  FKEY                 369    369A
006800000228      *
006900000228      *
007000000228      *
007100000228     D PLNCAT          DS
007200000228     D  @PTYPE                 2      3A
007300000218      *
007400000218    *** TIMESTAMP FIELDS DATA STRUCTURE
007500000218      *
007600000211     D @TIMESTAMP      DS
007700000211     D  #TSCYMD                1      8S 0
007800000211     D  #TSTIME                9     14S 0
007900000211     D  @TSJOB                15     24
008000000211     D  @TSUSER               25     34
008100000211     D  #TSNBR                35     40S 0
008200000218      *
008300000218    *** FM041 PARAMETERS DATA STRUCTURE
008400000218      *
008500000216     D @PARM           DS
008600000223     D  #TRST                  1      3S 0
008700000223     D  #SUB                   4      6S 0
008800000223     D  @PLAN                  7     10A
008900000218      *
009000000218    *** FUNCTION KEY CONSTANTS
009100000218      *
009200000209     D  F1             C                   CONST(X'31')
009300000209     D  F2             C                   CONST(X'32')
009400000209     D  F3             C                   CONST(X'33')
009500000209     D  F4             C                   CONST(X'34')
009600000209     D  F5             C                   CONST(X'35')
009700000209     D  F6             C                   CONST(X'36')
009800000209     D  F7             C                   CONST(X'37')
009900000209     D  F8             C                   CONST(X'38')
010000000209     D  F9             C                   CONST(X'39')
010100000209     D  F10            C                   CONST(X'3A')
010200000209     D  F11            C                   CONST(X'3B')
010300000209     D  F12            C                   CONST(X'3C')
010400000209     D  F13            C                   CONST(X'B1')
010500000209     D  F14            C                   CONST(X'B2')
010600000209     D  F15            C                   CONST(X'B3')
010700000209     D  F16            C                   CONST(X'B4')
010800000209     D  F17            C                   CONST(X'B5')
010900000209     D  F18            C                   CONST(X'B6')
011000000209     D  F19            C                   CONST(X'B7')
011100000209     D  F20            C                   CONST(X'B8')
011200000209     D  F21            C                   CONST(X'B9')
011300000209     D  F22            C                   CONST(X'BA')
011400000209     D  F23            C                   CONST(X'BB')
011500000209     D  F24            C                   CONST(X'BC')
011600000218      *
011700000218    *** ERROR MESSAGE AND DAYS OF MONTH ARRAYS
011800000218      *
011900011009     D MSG             S             45    DIM(15) CTDATA PERRCD(1)
012000000218      *
012100000218    *** AGE BANDS FROM DATE ARRAY
012200000218      *
012300000210     D                 DS
012400000210     D AFR                     1     60  0 DIM(20)
012500000223     D   ABF01                 1      3  0
012600000223     D   ABF02                 4      6  0
012700000223     D   ABF03                 7      9  0
012800000223     D   ABF04                10     12  0
012900000223     D   ABF05                13     15  0
013000000223     D   ABF06                16     18  0
013100000223     D   ABF07                19     21  0
013200000223     D   ABF08                22     24  0
013300000223     D   ABF09                25     27  0
013400000223     D   ABF10                28     30  0
013500000223     D   ABF11                31     33  0
013600000223     D   ABF12                34     36  0
013700000223     D   ABF13                37     39  0
013800000223     D   ABF14                40     42  0
013900000223     D   ABF15                43     45  0
014000000223     D   ABF16                46     48  0
014100000223     D   ABF17                49     51  0
014200000223     D   ABF18                52     54  0
014300000223     D   ABF19                55     57  0
014400000223     D   ABF20                58     60  0
014500000218      *
014600000218    *** AGE BANDS TO DATE ARRAY
014700000218      *
014800000210     D                 DS
014900000211     D ATO                     1     60  0 DIM(20)
015000000223     D   ABT01                 1      3  0
015100000223     D   ABT02                 4      6  0
015200000223     D   ABT03                 7      9  0
015300000223     D   ABT04                10     12  0
015400000223     D   ABT05                13     15  0
015500000223     D   ABT06                16     18  0
015600000223     D   ABT07                19     21  0
015700000223     D   ABT08                22     24  0
015800000223     D   ABT09                25     27  0
015900000223     D   ABT10                28     30  0
016000000223     D   ABT11                31     33  0
016100000223     D   ABT12                34     36  0
016200000223     D   ABT13                37     39  0
016300000223     D   ABT14                40     42  0
016400000223     D   ABT15                43     45  0
016500000223     D   ABT16                46     48  0
016600000223     D   ABT17                49     51  0
016700000223     D   ABT18                52     54  0
016800000223     D   ABT19                55     57  0
016900000223     D   ABT20                58     60  0
017000000223      *
017100000223    *** AGE BANDS % OF BEN ARRAY
017200000223      *
017300000223     D                 DS
017400000228     D DPR                     1     60P 3 DIM(20)
017500000228     D  DPER01                 1      3P 3
017600000228     D  DPER02                 4      6P 3
017700000228     D  DPER03                 7      9P 3
017800000228     D  DPER04                10     12P 3
017900000228     D  DPER05                13     15P 3
018000000228     D  DPER06                16     18P 3
018100000228     D  DPER07                19     21P 3
018200000228     D  DPER08                22     24P 3
018300000228     D  DPER09                25     27P 3
018400000228     D  DPER10                28     30P 3
018500000228     D  DPER11                31     33P 3
018600000228     D  DPER12                34     36P 3
018700000228     D  DPER13                37     39P 3
018800000228     D  DPER14                40     42P 3
018900000228     D  DPER15                43     45P 3
019000000228     D  DPER16                46     48P 3
019100000228     D  DPER17                49     51P 3
019200000228     D  DPER18                52     54P 3
019300000228     D  DPER19                55     57P 3
019400000228     D  DPER20                58     60P 3
019500000225      *
019600000225    *** AGE BANDS FROM DATE ARRAY - HISTORY BEFORE
019700000225      *
019800000225     D                 DS
019900000225     D AFRB                    1     60  0 DIM(20)
020000000225     D HBABF01                 1      3  0
020100000225     D HBABF02                 4      6  0
020200000225     D HBABF03                 7      9  0
020300000225     D HBABF04                10     12  0
020400000225     D HBABF05                13     15  0
020500000225     D HBABF06                16     18  0
020600000225     D HBABF07                19     21  0
020700000225     D HBABF08                22     24  0
020800000225     D HBABF09                25     27  0
020900000225     D HBABF10                28     30  0
021000000225     D HBABF11                31     33  0
021100000225     D HBABF12                34     36  0
021200000225     D HBABF13                37     39  0
021300000225     D HBABF14                40     42  0
021400000225     D HBABF15                43     45  0
021500000225     D HBABF16                46     48  0
021600000225     D HBABF17                49     51  0
021700000225     D HBABF18                52     54  0
021800000225     D HBABF19                55     57  0
021900000225     D HBABF20                58     60  0
022000000225      *
022100000225    *** AGE BANDS TO DATE ARRAY - HISTORY BEFORE
022200000225      *
022300000225     D                 DS
022400000225     D ATOB                    1     60  0 DIM(20)
022500000225     D HBABT01                 1      3  0
022600000225     D HBABT02                 4      6  0
022700000225     D HBABT03                 7      9  0
022800000225     D HBABT04                10     12  0
022900000225     D HBABT05                13     15  0
023000000225     D HBABT06                16     18  0
023100000225     D HBABT07                19     21  0
023200000225     D HBABT08                22     24  0
023300000225     D HBABT09                25     27  0
023400000225     D HBABT10                28     30  0
023500000225     D HBABT11                31     33  0
023600000225     D HBABT12                34     36  0
023700000225     D HBABT13                37     39  0
023800000225     D HBABT14                40     42  0
023900000225     D HBABT15                43     45  0
024000000225     D HBABT16                46     48  0
024100000225     D HBABT17                49     51  0
024200000225     D HBABT18                52     54  0
024300000225     D HBABT19                55     57  0
024400000225     D HBABT20                58     60  0
024500000225      *
024600000225    *** AGE BANDS % OF BEN ARRAY  HISTORY BEFORE
024700000225      *
024800000225     D                 DS
024900000228     D DPRB                    1     60P 3 DIM(20)
025000000228     D HBDPER01                1      3P 3
025100000228     D HBDPER02                4      6P 3
025200000228     D HBDPER03                7      9P 3
025300000228     D HBDPER04               10     12P 3
025400000228     D HBDPER05               13     15P 3
025500000228     D HBDPER06               16     18P 3
025600000228     D HBDPER07               19     21P 3
025700000228     D HBDPER08               22     24P 3
025800000228     D HBDPER09               25     27P 3
025900000228     D HBDPER10               28     30P 3
026000000228     D HBDPER11               31     33P 3
026100000228     D HBDPER12               34     36P 3
026200000228     D HBDPER13               37     39P 3
026300000228     D HBDPER14               40     42P 3
026400000228     D HBDPER15               43     45P 3
026500000228     D HBDPER16               46     48P 3
026600000228     D HBDPER17               49     51P 3
026700000228     D HBDPER18               52     54P 3
026800000228     D HBDPER19               55     57P 3
026900000228     D HBDPER20               58     60P 3
027000000225      *
027100000225    *** AGE BANDS FROM DATE ARRAY - HISTORY AFTER
027200000225      *
027300000225     D                 DS
027400000225     D AFRA                    1     60  0 DIM(20)
027500000225     D HAABF01                 1      3  0
027600000225     D HAABF02                 4      6  0
027700000225     D HAABF03                 7      9  0
027800000225     D HAABF04                10     12  0
027900000225     D HAABF05                13     15  0
028000000225     D HAABF06                16     18  0
028100000225     D HAABF07                19     21  0
028200000225     D HAABF08                22     24  0
028300000225     D HAABF09                25     27  0
028400000225     D HAABF10                28     30  0
028500000225     D HAABF11                31     33  0
028600000225     D HAABF12                34     36  0
028700000225     D HAABF13                37     39  0
028800000225     D HAABF14                40     42  0
028900000225     D HAABF15                43     45  0
029000000225     D HAABF16                46     48  0
029100000225     D HAABF17                49     51  0
029200000225     D HAABF18                52     54  0
029300000225     D HAABF19                55     57  0
029400000225     D HAABF20                58     60  0
029500000225      *
029600000225    *** AGE BANDS TO DATE ARRAY - HISTORY AFTER
029700000225      *
029800000225     D                 DS
029900000225     D ATOA                    1     60  0 DIM(20)
030000000225     D HAABT01                 1      3  0
030100000225     D HAABT02                 4      6  0
030200000225     D HAABT03                 7      9  0
030300000225     D HAABT04                10     12  0
030400000225     D HAABT05                13     15  0
030500000225     D HAABT06                16     18  0
030600000225     D HAABT07                19     21  0
030700000225     D HAABT08                22     24  0
030800000225     D HAABT09                25     27  0
030900000225     D HAABT10                28     30  0
031000000225     D HAABT11                31     33  0
031100000225     D HAABT12                34     36  0
031200000225     D HAABT13                37     39  0
031300000225     D HAABT14                40     42  0
031400000225     D HAABT15                43     45  0
031500000225     D HAABT16                46     48  0
031600000225     D HAABT17                49     51  0
031700000225     D HAABT18                52     54  0
031800000225     D HAABT19                55     57  0
031900000225     D HAABT20                58     60  0
032000000225      *
032100000225    *** AGE BANDS % OF BEN ARRAY  HISTORY AFTER
032200000225      *
032300000225     D                 DS
032400000228     D DPRA                    1     60P 3 DIM(20)
032500000228     D HADPER01                1      3P 3
032600000228     D HADPER02                4      6P 3
032700000228     D HADPER03                7      9P 3
032800000228     D HADPER04               10     12P 3
032900000228     D HADPER05               13     15P 3
033000000228     D HADPER06               16     18P 3
033100000228     D HADPER07               19     21P 3
033200000228     D HADPER08               22     24P 3
033300000228     D HADPER09               25     27P 3
033400000228     D HADPER10               28     30P 3
033500000228     D HADPER11               31     33P 3
033600000228     D HADPER12               34     36P 3
033700000228     D HADPER13               37     39P 3
033800000228     D HADPER14               40     42P 3
033900000228     D HADPER15               43     45P 3
034000000228     D HADPER16               46     48P 3
034100000228     D HADPER17               49     51P 3
034200000228     D HADPER18               52     54P 3
034300000228     D HADPER19               55     57P 3
034400000228     D HADPER20               58     60P 3
034500000209   X***X
034600000210     C*
034700000210     C* MAIN CONTROL LOOP
034800000210     C*
034900000211    1C                   DOU       @STEP = 'EXIT  '
035000000211    2C     @STEP         CASEQ     'STEP1 '      $STEP1
035100000211    2C     @STEP         CASEQ     'STEP2 '      $STEP2
035200000211    2C     @STEP         CASEQ     'STEP3 '      $STEP3
035300000211    2C                   ENDCS
035400000211    1C                   ENDDO
035500000210     C                   MOVE      *ON           *INLR
035600000218     C*
035700000218     C* INITIAL SUBROUTINE
035800000210     C*
035900000211    SC     *INZSR        BEGSR
036000000210     C*
036100011009     C     *LIKE         DEFINE    PLTRST        VLTRST
036200011009     C     *LIKE         DEFINE    PLSUB#        VLSUB#
036300011009     C     *LIKE         DEFINE    PLPLAN        VLPLAN
036400000210     C                   MOVE      *ZERO         RRT               3 0
036500000210     C                   MOVE      *ZEROS        #CNTREC           3 0
036600000211     C                   MOVE      *ZEROS        #DLOOP            3 0
036700000210     C*
036800000210     C                   MOVE      '0'           @1STLOOP          1
036900000210     C                   MOVE      *BLANKS       @EMSG            50
037000000210     C                   MOVE      'STEP1 '      @STEP             6
037100000211     C                   MOVE      *BLANKS       @TS40            40
037200000210     C*
037300011009     C*
037400011009     C     KEY#SUB       KLIST
037500011009     C                   KFLD                    VLTRST
037600011009     C                   KFLD                    VLSUB#
037700011009     C*
037800011009     C     KEY#PLAN      KLIST
037900011009     C                   KFLD                    VLTRST
038000011009     C                   KFLD                    VLSUB#
038100011009     C                   KFLD                    VLPLAN
038200011009     C*
038300000210     C     SUBKEY        KLIST
038400000228     C                   KFLD                    DCTRST
038500000228     C                   KFLD                    DCSUB#
038600000210     C     PLNKEY        KLIST
038700000228     C                   KFLD                    DCTRST
038800000228     C                   KFLD                    DCSUB#
038900000228     C                   KFLD                    DCPLAN
039000000210     C*
039100000211    SC                   ENDSR
039200000428   S***S
039300000210     C*
039400000210     C* INITIAL SCREEN FOR TRUST/SUB/PLAN
039500000210     C*
039600000211    SC     $STEP1        BEGSR
039700000210     C*
039800000210     C                   MOVEL(P)  @EMSG         SMSG
039900000210     C                   EXFMT     IO01
040000000210     C*
040100000210     C                   MOVE      *BLANKS       @EMSG
040200011009     C                   MOVE      *BLANKS       TNAME
040300011009     C                   MOVE      *BLANKS       SUBNAM
040400011009     C                   MOVE      *BLANKS       PDESCR
040500000210     C*
040600000211    1C                   IF        FKEY = F7
040700000210     C                   MOVEL(P)  'EXIT  '      @STEP
040800000210     C                   LEAVESR
040900000211    1C                   ENDIF
041000000210     C*
041100011009    *** TRUST SELECTOR
041200011009    1C                   IF        FKEY = F2
041300011009     C                   EXSR      $F2PROC
041400011009     C                   LEAVESR
041500011009    1C                   ENDIF
041600011009    *** SUB SELECTOR
041700011009    1C                   IF        FKEY = F4
041800011009     C                   EXSR      $F4PROC
041900011009     C                   LEAVESR
042000011009    1C                   ENDIF
042100011009    *** PLAN SELECTOR
042200011009    1C                   IF        FKEY = F6
042300011009     C                   EXSR      $F6PROC
042400011009     C                   LEAVESR
042500011009    1C                   ENDIF
042600011009    *** VALIDATIONS
042700011009     C                   Z-ADD     DCTRST        VLTRST
042800011009     C                   EXSR      $CHK_TRST
042900011009    1C                   IF        @@VT <> '0'
043000011009     C                   MOVEL     MSG(1)        @EMSG
043100011009     C                   LEAVESR
043200011009    1C                   ENDIF
043300011009     C*
043400011009     C                   Z-ADD     DCSUB#        VLSUB#
043500011009     C                   EXSR      $CHK_SUBD
043600011009    1C                   IF        @@VS <> '0'
043700011009     C                   MOVEL(P)  MSG(2)        @EMSG
043800011009     C                   LEAVESR
043900011009    1C                   ENDIF
044000011009     C*
044100011009     C                   MOVEL(P)  DCPLAN        VLPLAN
044200011009     C                   EXSR      $CHK_PLAN
044300011009    1C                   IF        @@VP <> '0'
044400011009     C                   MOVEL(P)  MSG(3)        @EMSG
044500011009     C                   LEAVESR
044600011009    1C                   ENDIF
044700011009    ***
044800010618     C                   IF        @PTYPE <> 'SL' AND @PTYPE <> 'LF' and
044900020121     C                             @PTYPE <> 'AC' and @ptype <> 'BD' and
045000030730     C                             @PTYPE <> 'CC' and @ptype <> 'OA' and
045100031222     C                             @PTYPE <> 'LS' and @ptype <> 'SA' and
045200060323     C                             @ptype <> 'EV' and @ptype <> 'SS' and
045300090115     C                             @ptype <> 'SP' and @ptype <> 'AA' and
045400090728     C                             @ptype <> 'NS' and @ptype <> 'NE' and
045500110711     C                             @ptype <> 'TL' and @ptype <> 'S1' and
045600110711     C                             @PTYPE <> 'S2' and @ptype <> 'S3' and
045700110711     C                             @PTYPE <> 'S4' and @ptype <> 'S5' and
045800110711     C                             @ptype <> 'S6' and @ptype <> 'S7' and
045900110711     C                             @ptype <> 'S8' and @ptype <> 'S9' and
046000110711     C                             @PTYPE <> 'D1' and @ptype <> 'D2' and
046100110711     C                             @PTYPE <> 'D3' and @ptype <> 'O1' and
046200110711     C                             @ptype <> 'O2' and @ptype <> 'O3' and
046300120521     C                             @ptype <> 'NS' and @ptype <> 'NE' and
046400170620     C                             @ptype <> 'A1' and @ptype <> 'LL' and
046500200612br01 C                             @ptype <> 'CB' and @ptype <> '06' and
046600211220br01 C                             @ptype <> '32' and @ptype <> '33' and
046700211220br01 C                             @ptype <> 'VW'
046800000225     C                   MOVEL     MSG(4)        @EMSG
046900000225     C                   LEAVESR
047000000228    1C                   ENDIF
047100000210     C*
047200000210     C                   MOVEL(P)  'STEP2 '      @STEP
047300000210     C                   MOVE      *BLANKS       @EMSG
047400000210     C*
047500000211    SC                   ENDSR
047600011009   S***S
047700011009    *** TRUST SELECTION WINDOW
047800011009     C     $F2PROC       BEGSR
047900011009    ***
048000011009     C                   MOVE      *BLANKS       @3                3
048100011009     C                   CALL      'FM006CL'
048200011009     C                   PARM                    @3
048300011009    1C                   IF        @3 = '*LR'
048400011009     C                   MOVEL(P)  MSG(13)       @EMSG
048500011009     C                   LEAVESR
048600011009    1C                   ENDIF
048700011009    ***
048800011009     C                   MOVE      @3            DCTRST
048900011009    ***
049000011009     C                   MOVE      @3            VLTRST
049100011009     C                   EXSR      $CHK_TRST
049200011009    1C                   IF        @@VT <> '0'
049300011009     C                   MOVEL(P)  MSG(1)        @EMSG
049400011009    1C                   ENDIF
049500011009    ***
049600011009     C                   ENDSR
049700011009   S***S
049800011009    *** SUBDIVISION SELECTION WINDOW
049900011009    ***    REQUIRES A VALID TRUST NUMBER TO CALL PROGRAM
050000011009     C     $F4PROC       BEGSR
050100011009    ***
050200011009     C                   MOVE      *BLANKS       @6                6
050300011009     C*
050400011009     C                   Z-ADD     DCTRST        VLTRST
050500011009     C                   EXSR      $CHK_TRST
050600011009     C*
050700011009    1C                   IF        @@VT <> '0'
050800011009     C                   MOVEL(P)  MSG(1)        @EMSG
050900011009     C                   LEAVESR
051000011009    1C                   ENDIF
051100011009    ***
051200011009     C                   MOVE      VLTRST        @3                3
051300011009     C                   MOVEL(P)  @3            @6
051400011009     C                   CALL      'FM007CL'
051500011009     C                   PARM                    @6
051600011009     C                   MOVE      @6            @3
051700011009    ***
051800011009    1C                   IF        @3 = '*LR'
051900011009     C                   MOVEL(P)  MSG(14)       @EMSG
052000011009     C                   LEAVESR
052100011009    1C                   ENDIF
052200011009    ***
052300011009     C                   MOVE      @3            DCSUB#
052400011009     C*
052500011009     C                   MOVE      @3            VLSUB#
052600011009     C                   EXSR      $CHK_SUBD
052700011009    1C                   IF        @@VS <> '0'
052800011009     C                   MOVEL(P)  MSG(2)        @EMSG
052900011009    1C                   ENDIF
053000011009    ***
053100011009     C                   ENDSR
053200011009   S***S
053300011009    *** EXISTING PLAN NUMBER INQUIRY
053400011009    ***    REQUIRES VALID TRUST AND VALID SUBDIVISION NUMBERS PRIOR TO CALL
053500011009     C     $F6PROC       BEGSR
053600011009    ***
053700011009     C                   MOVE      *BLANKS       @10              10
053800011009    ***
053900011009     C                   Z-ADD     DCTRST        VLTRST
054000011009     C                   EXSR      $CHK_TRST
054100011009     C*
054200011009    1C                   IF        @@VT <> '0'
054300011009     C                   MOVEL(P)  MSG(1)        @EMSG
054400011009     C                   LEAVESR
054500011009    1C                   ENDIF
054600011009    ***
054700011009     C                   Z-ADD     DCSUB#        VLSUB#
054800011009     C                   EXSR      $CHK_SUBD
054900011009     C*
055000011009    1C                   IF        @@VS <> '0'
055100011009     C                   MOVEL(P)  MSG(2)        @EMSG
055200011009     C                   LEAVESR
055300011009    1C                   ENDIF
055400011009    ***
055500011009     C                   MOVE      VLTRST        @3
055600011009     C                   MOVEL(P)  @3            @10
055700011009     C                   MOVE      VLSUB#        @3
055800011009     C                   CAT       @3:0          @10
055900011009     C                   CALL      'FM004CL'
056000011009     C                   PARM                    @10
056100011009     C     4             SUBST     @10:7         @4                4
056200011009    ***
056300011009    1C                   IF        @4 = '*LR ' OR @4 = ' *LR'
056400011009     C                   MOVEL(P)  MSG(15)       @EMSG
056500011009     C                   LEAVESR
056600011009    1C                   ENDIF
056700011009    ***
056800011009     C                   MOVEL(P)  @4            DCPLAN
056900011009    ***
057000011009     C                   MOVEL(P)  @4            VLPLAN
057100011009     C                   EXSR      $CHK_PLAN
057200011009    1C                   IF        @@VP <> '0'
057300011009     C                   MOVEL(P)  MSG(3)        @EMSG
057400011009    1C                   ENDIF
057500011009    ***
057600011009     C                   ENDSR
057700011009   S***S
057800011009     C     $CHK_TRST     BEGSR
057900011009    ***
058000011009     C                   MOVE      '1'           @@VT              1            VALID TRUST FLAG
058100011009    1C                   IF        VLTRST <> 0
058200011009     C     VLTRST        CHAIN(N)  TRSMSR
058300011009    2C                   IF        %FOUND(TRSMST)
058400011009     C                   MOVE      '0'           @@VT
058500011009    2C                   ENDIF
058600011009    1C                   ENDIF
058700011009    ***
058800011009     C                   ENDSR
058900011009   S***S
059000011009     C     $CHK_SUBD     BEGSR
059100011009    ***
059200011009     C                   MOVE      '1'           @@VS              1            VALID SUBD FLAG
059300011009    1C                   IF        VLSUB# <> 0
059400011009     C     KEY#SUB       CHAIN(N)  SUBMSR
059500011009    2C                   IF        %FOUND(SUBMST)
059600011009     C                   MOVE      '0'           @@VS
059700011009    2C                   ENDIF
059800011009    1C                   ENDIF
059900011009    ***
060000011009     C                   ENDSR
060100011009   S***S
060200011009     C     $CHK_PLAN     BEGSR
060300011009    ***
060400011009     C                   MOVE      '1'           @@VP              1
060500011009    1C                   IF        VLPLAN <> *BLANKS
060600011009     C     KEY#PLAN      CHAIN     PLNMSR
060700011009    2C                   IF        %FOUND(PLNMST)
060800011009     C                   MOVE      '0'           @@VP
060900011009    2C                   ENDIF
061000011009    1C                   ENDIF
061100011009    ***
061200011009     C                   ENDSR
061300000428   S***S
061400000210     C*
061500000225     C* INITIAL SCREEN BUILD
061600000210     C*
061700000211    SC     $STEP2        BEGSR
061800000210     C* CLEAR SFL
061900000210     C                   MOVEA     '011'         *IN(25)
062000000228     C                   WRITE     IO02C
062100000210     C                   MOVEA     '010'         *IN(25)
062200000225     C*
062300000225     C                   MOVE      *BLANKS       @EMSG
062400000228     C*
062500000228     C                   MOVE      *ZEROS        AFR
062600000228     C                   MOVE      *ZEROS        ATO
062700000228     C                   MOVE      *ZEROS        DPR
062800000228     C                   MOVE      *ZEROS        AFRB
062900000228     C                   MOVE      *ZEROS        ATOB
063000000228     C                   MOVE      *ZEROS        DPRB
063100000228     C                   MOVE      *ZEROS        AFRA
063200000228     C                   MOVE      *ZEROS        ATOA
063300000228     C                   MOVE      *ZEROS        DPRA
063400000907     C                   CLEAR                   RDLFHIST
063500000225     C*
063600000225     C* CTL BUILD
063700000225     C*
063800000225     C     PLNKEY        CHAIN     DECLIR
063900000428    1C                   IF        %FOUND(DECLIF)
064000000228     C                   EXSR      $LOADBFR
064100000428    2C                   IF        DCDLTD = 'D'
064200130917     C** 003 ************MOVEA*****'101'**********IN(39)************************
064300130917     C                   EVAL      *IN39 = *ON
064400000428     C                   MOVEL     MSG(5)        @EMSG
064500000428    2C                   ELSE
064600130917     C** 003 ************MOVEA*****'010'**********IN(39)************************
064700130917     C                   EVAL      *IN39 = *OFF
064800000428    2C                   ENDIF
064900000428    1C                   ELSE
065000130917     C** 003 ************MOVEA*****'000'**********IN(39)************************
065100130917     C                   EVAL      *IN39 = *OFF
065200000428    1C                   ENDIF
065300000225     C*
065400000210     C* SFL BUILD
065500000225     C*    CLEAR COUNTERS; LOAD ONLY THOSE RECORDS FOR A TRUST/SUB/PLAN.
065600000210     C*
065700000210     C                   Z-ADD     *ZERO         RRT
065800000210     C                   MOVE      '0'           @1STLOOP
065900000210     C*
066000000225     C                   MOVE      *ZEROS        X                 2 0
066100000225    1C     1             DO        20            X
066200000228     C                   MOVE      *ON           *IN25
066300000225    3C                   Z-ADD     AFR(X)        SFABF
066400000225     C                   Z-ADD     ATO(X)        SFABT
066500000225    2C                   Z-ADD     DPR(X)        SFDPER
066600000225     C                   ADD       1             RRT
066700000225    4C                   IF        @1STLOOP = '0'
066800000225     C                   Z-ADD     RRT           SFLPOS
066900000225     C                   MOVE      '1'           @1STLOOP
067000000225    4C                   ENDIF
067100000228     C                   WRITE     IO02S
067200000225     C                   ENDDO     1
067300000210     C*
067400000210     C                   MOVEL(P)  'STEP3 '      @STEP
067500000225     C                   Z-ADD     DCTRST        HTRST
067600000225     C                   Z-ADD     DCSUB#        HSUB
067700000225     C                   MOVEL     DCPLAN        HPLAN
067800000210     C*
067900000211    SC                   ENDSR
068000000428   S***S
068100000218     C*
068200000225     C* INTERACT WITH DELINING LIFE RECORD
068300000218     C*
068400000211    SC     $STEP3        BEGSR
068500000210     C*
068600000210     C                   MOVEL(P)  @EMSG         SMSG
068700000210     C*
068800000228     C                   WRITE     IO02R
068900000228     C                   EXFMT     IO02C
069000000210     C*
069100000210     C                   MOVE      *BLANKS       @EMSG
069200000210     C*
069300000211    1C                   SELECT
069400000210     C*
069500000210     C* BACK TO INITIAL SCREEN
069600000210     C*
069700000211    1C                   WHEN      FKEY = F1
069800000210     C                   MOVEL(P)  'STEP1 '      @STEP
069900000210     C                   LEAVESR
070000000225     C*
070100130917     *** 003 *******************************************************************
070200130917    1C** 003 ************WHEN******FKEY*=*F4************************************
070300130917     C** 003 ************EXSR******$LOADBFR*************************************
070400130917     C** 003 ************MOVE******'D'***********DCDLTD*************************
070500130917     C** 003 ************MOVE******'D'***********HADCDLTD***********************
070600130917     C** 003 ************EXSR******$TSTAMP**************************************
070700130917     C** 003 ************WRITE*****RDLFHIST*************************************
070800130917     C** 003 ************UPDATE****DECLIR***************************************
070900130917     C** 003 ************MOVEL(P)**'STEP1*'******@STEP**************************
071000130917     C** 003 ************LEAVESR************************************************
071100000216     C*
071200000216     C* HISTORY INQUIRY
071300000216     C*
071400000225    1C                   WHEN      FKEY = F5
071500000225     C                   MOVEL(P)  '000000'      @PARM
071600000225     C                   Z-ADD     DCTRST        #TRST
071700000225     C                   Z-ADD     DCSUB#        #SUB
071800000225     C                   MOVEL(P)  DCPLAN        @PLAN
071900000225     C                   MOVEL(P)  @PARM         @10              10
072000000225     C                   CALL      'FM051R'
072100000225     C                   PARM                    @10
072200000216     C                   LEAVESR
072300000210     C*
072400000428     C* RE-ACTIVATE RECORD
072500000210     C*
072600130917    1C** 003 ************WHEN******FKEY*=*F6************************************
072700130917     C** 003 ************EXSR******$LOADBFR*************************************
072800130917     C** 003 ************MOVE******'A'***********DCDLTD*************************
072900130917     C** 003 ************MOVE******'A'***********HADCDLTD***********************
073000130917     C** 003 ************EXSR******$TSTAMP**************************************
073100130917     C** 003 ************WRITE*****RDLFHIST*************************************
073200130917     C** 003 ************UPDATE****DECLIR***************************************
073300130917     C** 003 ************MOVEL(P)**'STEP1*'******@STEP**************************
073400130917     C** 003 ************LEAVESR************************************************
073500000210     C*
073600000210     C* CHECK SELECTIONS
073700000210     C*
073800000211    1C                   OTHER
073900130917     C** 003 ************IF*********IN41*=**OFF*********************************
074000000210     C                   EXSR      $CHKSELC
074100130917     C** 003 ************ENDIF**************************************************
074200000210     C*
074300000211    1C                   ENDSL
074400000210     C*
074500000211    SC                   ENDSR
074600000428   S***S
074700000225     C*
074800000225     C     $TSTAMP       BEGSR
074900000225     C*
075000000225     C                   CLEAR                   @TIMESTAMP
075100000225     C                   MOVE      *BLANKS       @TS40            40
075200000225     C                   CALL      'TIMESTMP'
075300000225     C                   PARM                    @TS40
075400000225     C                   MOVEL     @TS40         @TIMESTAMP
075500000225     C                   MOVEL     @TSUSER       HUSERID
075600000225     C                   MOVE      #TSCYMD       HDATE
075700000225     C                   MOVE      #TSTIME       HTIME
075800000225     C                   MOVEL     @TSJOB        HJOB
075900000225     C                   MOVE      #TSNBR        HNUMBER
076000000225     C                   ENDSR
076100000428   S***S
076200000225     C*
076300000225     C     $LOADBFR      BEGSR
076400000225     C*
076500000225     C                   MOVE      *ZEROS        X
076600000225     C     1             DO        20            X
076700000225     C                   Z-ADD     AFR(X)        AFRB(X)
076800000225     C                   Z-ADD     ATO(X)        ATOB(X)
076900000225     C                   Z-ADD     DPR(X)        DPRB(X)
077000001020     C                   Z-ADD     AFR(X)        AFRA(X)
077100001020     C                   Z-ADD     ATO(X)        ATOA(X)
077200001020     C                   Z-ADD     DPR(X)        DPRA(X)
077300000225     C                   ENDDO     1
077400000225     C*
077500000225     C                   MOVE      RNDFLG        HBRNDFLG
077600000225     C                   Z-ADD     RNDAMT        HBRNDAMT
077700000225     C                   MOVE      DCDLTD        HBDCDLTD
077800001020     C                   MOVE      RNDFLG        HARNDFLG
077900001020     C                   Z-ADD     RNDAMT        HARNDAMT
078000001020     C                   MOVE      DCDLTD        HADCDLTD
078100000225     C*
078200000225    SC                   ENDSR
078300000428   S***S
078400000218     C*
078500000218     C* CHECK SUBFILE FOR SELECTION OF DATE RANGE
078600000210     C*
078700000216    SC     $CHKSELC      BEGSR
078800000216     C*
078900001121001  C                   MOVE      '0'           @UPDTE            1
079000001121001  C*
079100000225     C                   IF        RNDFLG <> 'U' AND RNDFLG <> 'D'
079200000225     C                   MOVEL(P)  MSG(6)        @EMSG
079300000225     C                   LEAVESR
079400001121001  C                   ELSE
079500001121001  C                   IF        RNDFLG <> HBRNDFLG
079600001121001  C                   MOVE      '1'           @UPDTE
079700001121001  C                   ENDIF
079800000225     C                   ENDIF
079900000225     C*
080000000225     C                   IF        RNDAMT < 1
080100000225     C                   MOVEL(P)  MSG(7)        @EMSG
080200000225     C                   LEAVESR
080300001121001  C                   ELSE
080400001121001  C                   IF        RNDAMT <> HBRNDAMT
080500001121001  C                   MOVE      '1'           @UPDTE
080600001121001  C                   ENDIF
080700000225     C                   ENDIF
080800000225     C*
080900001121001  C**DLT              MOVE      '0'           @UPDTE            1
081000000228     C                   MOVE      *ZEROS        X
081100000228    1C                   DOU       X = 20 OR @EMSG <> *BLANKS
081200000228     C                   ADD       1             X
081300000225     C                   Z-ADD     X             RRT
081400000228    2C     RRT           CHAIN     IO02S
081500000225     C                   IF        SFABF <> AFR(X) OR SFABT <> ATO(X) OR
081600000225     C                             SFDPER <> DPR(X)
081700000225    3C                   EXSR      $EDITSFL
081800000228     C                   IF        @EMSG = *BLANKS
081900000228     C                   MOVE      '1'           @UPDTE
082000000228     C                   Z-ADD     SFABF         AFR(X)
082100000228     C                   Z-ADD     SFABT         ATO(X)
082200000228     C                   Z-ADD     SFDPER        DPR(X)
082300000228     C                   ENDIF
082400000228     C                   ENDIF
082500000228     C                   ENDDO
082600000228     C*
082700000228     C                   IF        @EMSG = *BLANKS AND @UPDTE = '1'
082800000225     C                   EXSR      $UPDATES
082900001122     C                   MOVEL(P)  'STEP2 '      @STEP
083000000228     C                   ENDIF
083100000216     C*
083200000216    SC                   ENDSR
083300000225   S***S
083400000428     C*
083500000428     C* EDIT SUBFILE FOR CHANGES
083600000428     C*
083700000225     C     $EDITSFL      BEGSR
083800000225     C*
083900000225     C                   SELECT
084000000225     C*
084100000225     C                   WHEN      SFABF =  0 AND SFABT <> 0
084200000225     C                   MOVEL(P)  MSG(8)        @EMSG
084300000225     C                   WHEN      SFABF <> 0 AND SFABT =  0
084400000225     C                   MOVEL(P)  MSG(9)        @EMSG
084500000225     C                   WHEN      SFABF <> 0 AND SFABT <> 0 AND SFDPER =  0
084600000225     C                   MOVEL(P)  MSG(10)       @EMSG
084700000225     C                   WHEN      SFABF =  0 AND SFABT =  0 AND SFDPER <> 0
084800000225     C                   MOVEL(P)  MSG(11)       @EMSG
084900000225     C                   WHEN      SFABF > SFABT
085000000225     C                   MOVEL(P)  MSG(12)       @EMSG
085100000225     C*
085200000225     C                   ENDSL
085300000225     C*
085400000228     C                   ENDSR
085500000428   S***S
085600000225     C*
085700000225     C     $UPDATES      BEGSR
085800000225     C*
085900000225     C                   IF        %FOUND(DECLIF)
086000000428     C                   EXSR      $TSTAMP
086100000225     C                   EXSR      $CHGREC
086200000225     C                   ELSE
086300000428     C                   EXSR      $TSTAMP
086400000225     C                   EXSR      $ADDREC
086500000225     C                   ENDIF
086600001121001  C*
086700001121001  C                   CLEAR                   RDLFHIST
086800001121001  C                   Z-ADD     DCTRST        HTRST
086900001121001  C                   Z-ADD     DCSUB#        HSUB
087000001121001  C                   MOVEL     DCPLAN        HPLAN
087100001121001  C                   EXSR      $LOADBFR
087200000225     C*
087300000225     C                   ENDSR
087400000428   S***S
087500000225     C*
087600000225     C*
087700000225     C*
087800000225     C     $CHGREC       BEGSR
087900000225     C*
088000001020     C                   MOVE      'N'           @CHG              1
088100000228     C                   MOVE      *ZEROS        X
088200000228     C     1             DO        20            X
088300000228     C                   IF        AFR(X) <> AFRB(X)
088400000228     C                   Z-ADD     AFR(X)        AFRA(X)
088500001020     C                   MOVE      'Y'           @CHG
088600000228     C                   ENDIF
088700000907     C                   IF        ATO(X) <> ATOB(X)
088800000228     C                   Z-ADD     ATO(X)        ATOA(X)
088900001020     C                   MOVE      'Y'           @CHG
089000000228     C                   ENDIF
089100000907     C                   IF        DPR(X) <> DPRB(X)
089200000228     C                   Z-ADD     DPR(X)        DPRA(X)
089300001020     C                   MOVE      'Y'           @CHG
089400000228     C                   ENDIF
089500000228     C                   ENDDO     1
089600000228     C*
089700001020     C                   IF        RNDFLG <> HBRNDFLG OR RNDAMT <> HBRNDAMT OR
089800001020     C                             DCDLTD <> HBDCDLTD
089900000225     C                   MOVE      RNDFLG        HARNDFLG
090000000225     C                   Z-ADD     RNDAMT        HARNDAMT
090100000225     C                   MOVE      DCDLTD        HADCDLTD
090200001020     C                   MOVE      'Y'           @CHG
090300001020     C                   ENDIF
090400000225     C*
090500001020     C                   IF        @CHG = 'Y'
090600000225     C                   WRITE     RDLFHIST
090700001020     C                   ENDIF
090800000228     C                   UPDATE    DECLIR
090900000225     C*
091000000228     C                   ENDSR
091100000428   S***S
091200000225     C*
091300000225     C     $ADDREC       BEGSR
091400000225     C*
091500000225     C                   MOVE      'A'           DCDLTD
091600000225     C*
091700000225     C                   MOVE      *ZEROS        X
091800000225     C     1             DO        20            X
091900000225     C                   Z-ADD     AFR(X)        AFRA(X)
092000000225     C                   Z-ADD     ATO(X)        ATOA(X)
092100000225     C                   Z-ADD     DPR(X)        DPRA(X)
092200000225     C                   ENDDO     1
092300000225     C*
092400000225     C                   MOVE      RNDFLG        HARNDFLG
092500000225     C                   Z-ADD     RNDAMT        HARNDAMT
092600000225     C                   MOVE      DCDLTD        HADCDLTD
092700000225     C*
092800000225     C                   WRITE     RDLFHIST
092900000225     C                   WRITE     DECLIR
093000000225     C*
093100000225     C                   ENDSR
093200000428   S***S
093300000225     C*
093400000225     C*
093500000225123456*89012345678901234567890123456789012345
093600000225** CTDATA MSG
093700000428TRUST NUMBER IS INVALID
093800000428TRUST #/SUBDIVISION NUMBER IS INVALID
093900000428TRUST #/SUB #/PLAN NUMBER IS INVALID
094000060323PLAN ENTERED IS NOT A LIFE OR AD&D PLAN
094100000428RECORD DELETED- F6 TO REINSTATE
094200000428ROUNDING ENTRY REQUIRED (U/D)
094300000428ROUNDING AMOUNT MUST BE > 1
094400000428FROM AGE MUST BE ENTERED
094500000428TO AGE MUST BE ENTERED
094600000428DECLINING RATE MUST BE ENTERED
094700000428FROM AGE/TO AGE: INVALID ENTRY
094800000428FROM AGE > TO AGE: INVALID ENTRY
094900011009NO SELECT MADE FROM TRUST INQUIRY
095000011009NO SELECT MADE FROM SUB INQUIRY
095100011009NO SELECT MADE FROM PLAN INQUIRY
