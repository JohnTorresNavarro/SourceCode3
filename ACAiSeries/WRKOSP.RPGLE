000100220120     h option(*noDebugIO)    DftActGrp(*no)
000200000000     *_________________________________________________________________________
000300000000     *
000400061207     *  Description:  Work with OLE Code Supplemental Data
000500000000     *
000600061129     *  (c)Copyright 2006 by GBS, Inc.
000700210813     *
000800220120      *------------------------------------------------------------
000900210813     *  J. Allen   08.13.2021 - ADD1
001000210813     *  Fixed issue where the add was being auto-termed.
001100000000     *
001200220809      *  B.Rees  1/20/2022  Converted to use PL Screens.
001300220809      *  J.Allen 8.09.2022  Include return 'UPDATE'
001400220120      *
001500000000     *_________________________________________________________________________
001600220120      *
001700061129    FWRKOSPD   CF   E             WORKSTN
001800000000    F                                     SFILE(LSTSFL:WFRRN)
001900000000    F                                     INFDS(DSPD)
002000220120     F                                     HANDLER('PROFOUNDUI(HANDLER)')
002100061129    FACCOSP    IF   E           K DISK    INFDS(DBFD)
002200061212    F                                     RENAME(ACCOSPR:PSN1)
002300210813     FACCOSPL1  UF   E           K DISK    RENAME(ACCOSPR:OSP) Prefix(OS)
002400061212    FAOECOD    IF   E           K DISK
002500050317     FACCMST    IF   E           K Disk
002600000000     *_________________________________________________________________________
002700000000     *
002800000000    D WAO             S             38    DIM(30) CTDATA PERRCD(1)             OPTION TABLE
002900000000    D WAP             S             75    DIM(6)                               OPTION DESC
003000000000    D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
003100000000    D WAD             S             80    DIM(6)                               FUNCTION DESC
003200000000    D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
003300000000     *_________________________________________________________________________
003400210813     D ddcount         S              3s 0
003500210813     D mycount         S              3s 0
003600030317     *
003700061129     D WWTRST          S                   LIKE(AOTRST)
003800061129     D WWSUB#          S                   LIKE(AOSUB#)
003900061129     D WWACCT          S                   LIKE(AOACCT)
004000030317     *
004100000406     * Data structure
004200061129    D WDDTA         E DS                  EXTNAME(ACCOSP)
004300061129    D WXDTA         E DS                  EXTNAME(ACCOSP) prefix(X) inz
004400000000     *
004500000000     * Option code data structure
004600000000    D                 DS
004700000000    D  WDOPC                  1      2
004800000000    D  WDOPC1                 1      1
004900000000    D  WDOPC2                 2      2
005000000000     *
005100000000     * Program status data structure
005200991105    D PGMD          ESDS                  EXTNAME(IOPGMD)
005300000000     *
005400000000     * Display file data structure
005500991108    D DSPD          E DS                  EXTNAME(IODSPD)
005600020220     D DBFD          E DS                  EXTNAME(IODBFD)
005700120228     *
005800120228     D ALLOW           s              1a   inz
005900000000     *___________________________________________________________________
006000120228     C                   If        %trim(WORTN) = '*ALLOW'
006100120228     C                   eval      allow = 'Y'
006200120228     C                   else
006300120228     C                   eval      allow = 'N'
006400120228     C                   end
006500000000     *
006600000000     * Process list panel
006700000000B001C     WIRQS         Ifne      'SLCNXT  '                                   IF NOT NEXT SELECT
006800000000 001C                   Exsr      DEFN                                         DEFINE FIELDS
006900000000E001C                   Endif                                                  ENDIF NEXT SELECT
007000061208     C                   eval      xaotrst = aotrst
007100061208     C                   eval      xaosub# = aosub#
007200061208     C                   eval      xaoacct = aoacct
007300000000    C                   Exsr      PRPPNL                                       PREPARE PANEL
007400000000     *
007500000000B001C     WWENDF        Downe     'END'                                        DOWHILE NOT END
007600210813ADD1C                   Exsr      CLEANUP                                      RECEIVE MSGS
007700000000 001C                   Exsr      RCVMSG                                       RECEIVE MSGS
007800000000 001C                   Exsr      DSPPNL                                       DISPLAY PANEL
007900000000 001C                   Exsr      PRCFKY                                       PROC FN KEYS
008000000000 001 *
008100000000 001C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
008200000000 001C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
008300000000 001C     WWFKA         Caseq     'REFRESH '    PRCRFR                         REFRESH
008400000000 001C     WWFKA         Caseq     'ADD     '    PRCADD                         ADD
008500000000 001C     WWFKA         Caseq     'INSERT  '    PRCADD                         INSERT
008600000000 001C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
008700000000 001C     WWFKA         Caseq     'PMTPSN  '    PRCPMT                         PMT POSITION TO
008800000000 001C     WWFKA         Caseq     'OPTIONS '    PRCDOP                         DISPLAY OPTIONS
008900000000 001C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
009000000000 001C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLLDOWN
009100000000 001C     WWFKA         Caseq     'ENTER   '    PRCENT                         ENTER
009200000000 001C                   Endcs                                                  END CASE
009300000000E001C                   Enddo                                                  END DOWHILE
009400220120       *inlr = *on;
009500000000     *___________________________________________________________________
009600000000     * Prepare list panel
009700000000     *___________________________________________________________________
009800000000    C     PRPPNL        Begsr                                                  PREPARE PANEL
009900000000    C                   Exsr      SETPSN                                       SET POSITION TO IND
010000030317     *
010100061129     C                   Eval      WWTRST = AOTRST
010200061129     C                   Eval      WWSUB# = AOSUB#
010300061129     C                   Eval      WWACCT = AOACCT
010400061129     C                   Movel     AOTRST        Trst              3
010500061129     C                   Movel     AOSUB#        Sub#              3
010600061129     C                   Movel     AOACCT        Acct              4
010700050317     C     AKey          Chain     ACCMST
010800050317     C                   If        %Found(ACCMST)
010900050414B001C     ATRMDT        Ifne      *Zero                                        IF CALL ERROR
011000050414 001C                   Movel     WTM(7)        WWMSG                          PASS MESSAGE
011100050414 001C                   Exsr      SNDMSG                                       SEND MESSAGE
011200050414 001C                   Movel     'ERROR'       WORTN                          RETURN ERROR
011300050414 001C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
011400050414E001C                   Endif                                                  END ERROR
011500050318     C                   Eval      WWNAME  = %trim(Trst) + '-'   +
011600050318     C                                       %trim(Sub#) + '-'   +
011700050318     C                                       %trim(Acct) + '  '  +
011800050318     C                                       %trim(ACNAM1)
011900050318     C                   Movel(P)  WWNAME        WISTR
012000051027     C                   Z-add     60            WILEN
012100050318     C                   Call      'UTLCENSTR'
012200050318     C                   Parm                    WISTR           256
012300050318     C                   Parm                    WILEN             3 0
012400050318     C                   Movel     WISTR         WWNAME
012500050317     C                   End
012600000000     *
012700000000B001C                   Select                                                 SELECT
012800000000 001C     WIRQS         Wheneq    'ADD'                                        IF ADD RQS
012900000000 001C     WIRQS         Oreq      'ADDKEY'                                     OR ADDKEY RQS
013000000000 001C     WIRQS         Oreq      'INSERT'                                     OR INSERT RQS
013100000000 001C     WIRQS         Oreq      'INSKEY'                                     OR INSKEY RQS
013200000000 001C                   Move      WIRQS         WWFKA                          DEFINE FUNCTION
013300000000 001C                   Exsr      PRCADD                                       PRC ADD RQS
013400000000 001 *
013500000000 001C     WIRQS         Wheneq    'CHANGE'                                     IF CHANGE RQS
013600000000 001C                   Exsr      PRCCHG                                       PRC CHG RQS
013700000000 001 *
013800000000 001C     WIRQS         Wheneq    'LOAD'                                       IF LOAD REQUEST
013900000000 001C                   Exsr      PRCPSN                                       PROC POSITION TO
014000000000 001 *
014100000000 001C     WIRQS         Wheneq    'CLEAR'                                      IF CLEAR REQUEST
014200000000 001C                   Exsr      CLRSFL                                       CLEAR SUBFILE
014300000000 001 *
014400000000 001C     WIRQS         Wheneq    'SLCNXT'                                     IF SELECT NEXT
014500000000 001C                   Exsr      SLCNXT                                       SELECT NEXT
014600000000E001C                   Endsl                                                  END SELECT
014700000000     *
014800000000B001C     WWENDF        Ifne      'END'                                        IF NOT END
014900000000 001C                   Exsr      BLDOPT                                       BUILD OPTIONS
015000000000 001C                   Exsr      BLDFKY                                       BUILD FNC DSC
015100000000E001C                   Endif                                                  END IF NOT END
015200061221     C                   Exsr      PRCRFR
015300000000    C                   Endsr                                                  END PRPPNL
015400000000     *___________________________________________________________________
015500000000     * Set position to screen indicators
015600000000     *___________________________________________________________________
015700000000    C     SETPSN        Begsr                                                  SET POSITION TO
015800000000B001C     WWPSNI        Do        WWLMT         WW                             DO FOR NBR VIEWS
015900000000 001C                   Move      '0'           *IN(WW)                        SET OFF PSN
016000000000E001C                   Enddo                                                  END DO
016100000000    C     WWPSNI        Add       WWPSNP        WW                             VIEW# -> IND#
016200000000    C     WW            Sub       1             WW                             VIEW# -> IND#
016300000000    C                   Move      '1'           *IN(WW)                        DISPLAY PSN TO
016400000000    C                   Endsr                                                  END SETPSN
016500000000     *___________________________________________________________________
016600000000     * Display list panel
016700000000     *___________________________________________________________________
016800000000    C     DSPPNL        Begsr                                                  DISPALY PANEL
016900000000     * Set OVERLAY based on last display file processed
017000000000B001C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
017100000000 001C                   Setoff                                       35        OVERLAY OFF
017200000000 001C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
017300000000X001C                   Else                                                   ELSE SAME PGM
017400000000 001C                   Seton                                        35        OVERLAY ON
017500000000E001C                   Endif                                                  END IF NEW PGM
017600000000     * Write message subfile
017700000000    C                   Seton                                        30        SFLMSG DISPLAY
017800000000    C                   Write     MSGCTL                                       DISPLAY MSG SFL
017900000000     * Write function keys
018000000000B001C     *IN35         Ifeq      *OFF                                         IF OVERLAY OFF
018100000000 001C     WWFKS         Orne      WWFKSO                                       OR NEW F KEY SET
018200000000 001C                   Write     FKYDSC                                       DSP FNC KEY DSC
018300000000 001C                   Z-add     WWFKS         WWFKSO                         SAVE F KEY SET
018400000000E001C                   Endif                                                  END IF F KEY SET
018500000000     * Set subfile control panel overrides
018600000000B001C     WWPSNC        Ifeq      'Y'                                          IF PSN CHANGED
018700000000 001C                   Setoff                                       36        DO NOT PUTOVR
018800000000 001C                   Move      'N'           WWPSNC                         NOT CHANGED
018900000000X001C                   Else                                                   ELSE
019000000000 001C                   Seton                                        36        PUTOVR
019100000000E001C                   Endif                                                  END IF PSN
019200000000B001C     WWOPS         Ifne      WWOPSO                                       IF NEW OPT KEY SET
019300000000 001C                   Seton                                        37        DSP OPT KEY DSC
019400000000 001C                   Z-add     WWOPS         WWOPSO                         SAVE OPT KEY SET
019500000000X001C                   Else                                                   ELSE
019600000000 001C                   Setoff                                       37        NO OVRATR
019700000000E001C                   Endif                                                  END IF OPT KEY SET
019800000000     * Set subfile control inticators
019900000000B001C     WFRRN         Ifeq      0                                            IF SUBFILE EMPTY
020000000000 001C                   Setoff                                       30        ERASE SUBFILE
020100000000X001C                   Else                                                   ELSE SUBFILE
020200000000 001C                   Seton                                        30        DISPLAY SUBFILE
020300000000E001C                   Endif                                                  END IF SFL EMPTY
020400000000     * Write subfile
020500000000    C                   Exfmt     LSTCTL                                       DSP LST PANEL
020600000000    C                   Z-add     WDLOWR        WWLOWR                         SAVE SFL RCD NBR
020700000000    C                   Z-add     WDLOWR        WSPAG                          SET CURRENT PAGE
020800000000    C                   Setoff                                       626336    RESET SCREEN CTL
020900000000    C                   Endsr                                                  END DSPPNL
021000000000     *___________________________________________________________________
021100000000     * Process function key pressed
021200000000     *___________________________________________________________________
021300000000    C     PRCFKY        Begsr                                                  PROC FNC KEYS
021400991108    C                   Movea     *IN           WWIN                           INDICATORS
021500991108    C                   Call      'PRCFKY2'                                    PROC FNC KYS
021600000000    C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
021700000000    C     WWFKA         Parm                    WWRTN                          RETURN CODE
021800000000    C                   Parm                    WAD                            FNC DESC
021900991108    C                   Parm                    WWIN                           AID BYTE
022000000000    C                   Parm                    WAF                            FNC KEY TABLE
022100000000    C                   Parm                    WIFKV                          FNC KYS ALLWD
022200000000    C                   Endsr                                                  END PRC FKY
022300000000     *___________________________________________________________________
022400000000     * Process KEYS function
022500000000     *___________________________________________________________________
022600000000    C     PRCDKY        Begsr                                                  PROCESS KEYS
022700000000    C                   Z-add     1             WW                             KEY DSC IDX
022800000000B001C     WWFKS         Doueq     1                                            DO UNTIL SET=1
022900000000 001C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
023000000000 001C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
023100000000 001 *
023200000000B002C     WWFKS         Ifgt      3                                            IF OVER 3
023300000000 002C                   Z-add     1             WWFKS                          SET TO 1
023400000000E002C                   Endif                                                  END IF OVER 3
023500000000 001 *
023600000000 001C     WWFKS         Mult      2             WW                             KEY DESCR IDX
023700000000 001C                   Sub       1             WW                             KEY DESCR IDX
023800000000E001C                   Enddo                                                  END DO KEYS
023900000000     *
024000000000    C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
024100000000    C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
024200000000    C                   Sub       1             WW                             BUMP IDX
024300000000    C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
024400000000    C                   Endsr                                                  END PRCDKY
024500000000     *___________________________________________________________________
024600000000     * Process EXIT function
024700000000     *___________________________________________________________________
024800000000    C     PRCEXT        Begsr                                                  PROCESS EXIT
024900000000    C                   Movel     WWFKA         WORTN                          SET RETURN CODE
025000000000    C                   Move      'END'         WWENDF                         END FNC LOOP
025100000000    C                   Endsr                                                  END PRCEXT
025200000000     *___________________________________________________________________
025300000000     * Process REFRESH function
025400000000     *___________________________________________________________________
025500000000    C     PRCRFR        Begsr                                                  PROCESS REFRESH
025600000000    C                   Exsr      PRCPSN                                       POSITION TO
025700000000B001C     WSPAG         Dowlt     WWLOWR                                       DO WHILE NOT PRV PAG
025800000000 001C     WWSFLE        Andne     'Y'                                          AND NOT EOF
025900000000 001C                   Exsr      PRCRUP                                       LOAD SUBFILE
026000000000E001C                   Enddo                                                  END DO NOT PRV PAG
026100000000    C                   Endsr                                                  END PRCRFR
026200000000     *___________________________________________________________________
026300000000     * Process ADD function
026400000000     *___________________________________________________________________
026500000000    C     PRCADD        Begsr                                                  PROCESS ADD
026600050318     *
026700061208     C                   eval      aotrst = xaotrst
026800061208     C                   eval      aosub# = xaosub#
026900061208     C                   eval      aoacct = xaoacct
027000061129     C     WSBEDT        MULT      10000.0001    aobedt
027100061201     C     WSENDT        MULT      10000.0001    aoendt
027200070313     C     WSDTDT        MULT      10000.0001    aodtdt
027300170914     C                   eval      aoStsDt = %Dec(%Date)
027400170914     C                   eval      aoStstm = %Dec(%Time)
027500170914     C
027600170914     C
027700170914     C
027800061212     C                   Clear                   WSDESC
027900061212     C     AOCODE        Chain     AOECOD
028000061212     C                   If        %Found(AOECOD)
028100061212     C                   Eval      WSDESC   =    %Trim(AEDESC)
028200061212     C                   End
028300120228     *
028400120228     C                   If        %trim(allow) = 'Y'
028500120228     C                   eval      WWRTN = '*ALLOW'
028600120228     C                   end
028700000113     *
028800061129    C                   Call      'CHGOSP  '                           99      DLT RECORD
028900050317    C                   Parm      WWFKA         WWRQS                          DLT REQUEST
029000050317    C                   Parm                    WWRTN                          RETURN CODE
029100050317    C                   Parm                    WUPGM                          PROGRAM NAME
029200050317    C                   Parm                    WDDTA                          RECORD DS
029300210708    C                   Parm      'X 0304  '    WWFKV                          FNC KEY ALLOWED
029400050413    C                   Parm                    Whist             3            DATA
029500050317     *
029600000113B001C     *IN99         Ifeq      '1'                                          IF CALL ERROR
029700000117 001C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
029800000113 001C                   Exsr      SNDMSG                                       SEND MESSAGE
029900000113 001C                   Movel     'ERROR'       WORTN                          RETURN ERROR
030000000113 001C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
030100000113E001C                   Endif                                                  END ERROR
030200000113     *
030300000113B001C     WWRTN         Ifeq      'EXIT'                                       IF CALL ERROR
030400000113 001C                   Movel     WWRTN         WORTN                          RETURN ERROR
030500000113 001C                   Movel     'END'         WWENDF                         RETURN ERROR
030600061221X001C                   Else                                                   END ERROR
030700061221 001C                   Exsr      PRCRFR
030800061221E001C                   Endif                                                  END ERROR
030900061221     *
031000000000    C                   Endsr                                                  END ADD
031100000000     *___________________________________________________________________
031200000000     * Process CANCEL function
031300000000     *___________________________________________________________________
031400000000    C     PRCCNL        Begsr                                                  PROCESS CANCEL
031500000000    C                   Movel     WWFKA         WORTN                          SET RETURN CODE
031600000000    C                   Move      'END'         WWENDF                         END FNC LOOP
031700000000    C                   Endsr                                                  END PRCCNL
031800000000     *___________________________________________________________________
031900000000     * Process POSITION TO function
032000000000     *___________________________________________________________________
032100000000    C     PRCPMT        Begsr                                                  PROCESS POSITION
032200000000     *
032300000000    C                   Move      '     '       WSFLD                          TRUNCATE FIELD
032400000000B001C     WSFLD         Ifeq      'WSPSN'                                      IF CURSOR ON PSN
032500000000 001C     WWPSNP        Add       1             WWPSNP                         BUMP PSN TO VIEW
032600000000B002C     WWPSNP        Ifgt      WWPSNN                                       IF GT HIGH VIEW
032700000000 002C                   Z-add     1             WWPSNP                         SET TO BGN VIEW
032800000000E002C                   Endif                                                  END IF GT HIGH PSN
032900000000 001C                   Exsr      SETPSN                                       SET PSN TO IND
033000000000E001C                   Endif                                                  END IF CSR ON PSN
033100000000    C                   Seton                                        63        POSITION CURSOR
033200000000    C                   Move      'Y'           WWPSNC                         SET PSN CHANGED
033300000000    C                   Endsr                                                  END PRCPMT
033400000000     *___________________________________________________________________
033500000000     * Process OPTIONS function
033600000000     *___________________________________________________________________
033700000000    C     PRCDOP        Begsr                                                  PROCESS DSP OPT
033800000000    C                   Z-add     1             WW                             OPT DSC IDX
033900000000B001C     WWOPS         Doueq     1                                            DO UNTIL SET=1
034000000000 001C     WAP(WW)       Orne      *BLANKS                                      OR OPTS FOUND
034100000000 001C     WWOPS         Add       1             WWOPS                          NEXT OPT SET
034200000000 001 *
034300000000B002C     WWOPS         Ifgt      3                                            IF OVER 3
034400000000 002C                   Z-add     1             WWOPS                          SET TO 1
034500000000E002C                   Endif                                                  END IF OVER 3
034600000000 001 *
034700000000 001C     WWOPS         Mult      2             WW                             OPT DESCR IDX
034800000000 001C                   Sub       1             WW                             OPT DESCR IDX
034900000000E001C                   Enddo                                                  END DO OPTS
035000000000     *
035100000000    C     WWOPS         Add       WWOPS         WW                             OPT DSC IDX
035200000000    C                   Movel     WAP(WW)       WSOPD2                         LOAD LINE 2
035300000000    C                   Sub       1             WW                             BUMP IDX
035400000000    C                   Movel     WAP(WW)       WSOPD1                         LOAD LINE 1
035500000000    C                   Seton                                        36        OVRDTA OPTIONS
035600000000    C                   Endsr                                                  END PRCDOP
035700000000     *___________________________________________________________________
035800000000     * Process ROLL UP function (add a page to list subfile)
035900000000     *___________________________________________________________________
036000000000    C     PRCRUP        Begsr                                                  PROCESS ROLLUP
036100000000    C                   Move      'N'           WWSFLE                         SUBFILE END
036200000000    C                   Z-add     WWRRN         WSPAG                          SFL PAG = LAST PAGE
036300000000    C                   Z-add     1             WW                             WINDOW INDEX
036400000000    C                   Z-add     WWRRN         WFRRN                          HIGH SFL RRN
036500000000    C                   Setoff                                       50        RESET EOF IND
036600000000    C                   Setoff                                       6061      SUBFILE SRC CTL
036700000000    C                   Clear                   LSTSFL                         BLANK SFL RECORD
036800000000B001C     WW            Dowle     WWLSTS                                       DO WHILE PAG SIZ
036900000000 001C     *IN50         Andeq     '0'                                          AND RECORDS
037000061129 002C     WKOSP         Reade     ACCOSP                                 50    READ FILE
037100000000B002C     *IN50         Ifeq      '0'                                          IF RECORD READ
037200061129     C     AOBEDT        MULT      10000.0001    WSBEDT
037300061129     C     AOENDT        MULT      10000.0001    WSENDT
037400070313     C     AODTDT        MULT      10000.0001    WSDTDT
037500061212     C                   Clear                   WSDESC
037600061212     C     AOCODE        Chain     AOECOD
037700061212     C                   If        %Found(AOECOD)
037800061212     C                   Eval      WSDESC   =    %Trim(AEDESC)
037900061212     C                   End
038000000000 002C                   Add       1             WFRRN                          BUMP SFL RRN
038100000000 002C                   Add       1             WW                             BUMP INDEX
038200000000 002C                   Write     LSTSFL                                       WRITE SFL REC
038300000000X002C                   Else                                                   ELSE EOF
038400000000 002C                   Move      'Y'           WWSFLE                         SET EOF
038500000000E002C                   Endif                                                  END IF REC READ
038600000000 001 *
038700000000E001C                   Enddo                                                  END DO
038800000000     *
038900000000B001C     WFRRN         Ifgt      WWRRN                                        IF RECORDS ADDED
039000000000 001C     WWRRN         Add       1             WSPAG                          SFL PAG = 1ST NEW RC
039100000000 001C                   Z-add     WFRRN         WWRRN                          SAVE HIGH SFL RRN
039200000000E001C                   Endif                                                  END IF RCDS ADDED
039300000000     *
039400000000B001C     WFRRN         Ifeq      0                                            IF SFL EMPTY
039500000614 001C                   Move      WTM(5)        WWMSG                          EOF MSG
039600000000 001C                   Exsr      SNDMSG                                       SEND MESSAGE
039700000000E001C                   Endif                                                  IF SFL EMPTY
039800000000     *
039900000000B001C     WWSFLE        Ifeq      'Y'                                          AT END OF FILE?
040000000000 001C                   Seton                                        39        SFLEND BOTTOM
040100000000X001C                   Else                                                   ELSE
040200000000 001C                   Setoff                                       39        SFLEND MORE...
040300000000E001C                   Endif                                                  END IF END OF FILE
040400000000     *
040500000000    C                   Endsr                                                  END PRCRUP
040600000000     *___________________________________________________________________
040700000000     * Process ROLLDOWN function (beginning of SFL reached)
040800000000     *___________________________________________________________________
040900000000    C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
041000000000    C                   Z-add     1             WSPAG                          DSP 1ST PAGE
041100000000    C                   Move      WTM(1)        WWMSG                          BGN SFL MSG
041200000000    C                   Exsr      SNDMSG                                       SEND MSG
041300000000    C                   Endsr                                                  END PRCRDN
041400000000     *___________________________________________________________________
041500000000     * Process ENTER function
041600000000     *___________________________________________________________________
041700000000    C     PRCENT        Begsr                                                  PROCESS ENTER
041800000000    C                   Move      *BLANKS       WWENDO                         OPT LOOP STATE
041900000000    C                   Move      *BLANKS       WWRTN                          RETURN VALUE
042000000000    C                   Move      *BLANKS       WWDLT                          DELETE FLAG
042100000000    C                   Setoff                                       50        RESET EOF IND
042200000000     *
042300000000B001C     WFRRN         Ifgt      0                                            IF SFL RECORDS
042400000000 001 *
042500000000B002C     WWENDO        Downe     'END'                                        DOWHILE NOT END
042600000000 002C     *IN50         Andne     *ON                                          AND NOT EOF
042700000000 002C                   Readc     LSTSFL                                 50    READ CHNG SBF
042800000000 002 *
042900000000B003C     *IN50         Ifeq      *OFF                                         IF CHANGED RECORD
043000000000 003C     WSOPC         Andne     *BLANKS                                      AND OPTION CODE
043100000000 003C                   Exsr      PRCSLC                                       PROCESS SELECTION
043200000000 003C                   Exsr      PRCRTN                                       PROCESS OPT RETURN
043300000000E003C                   Endif                                                  END IF SELECTION
043400000000E002C                   Enddo                                                  END DO WHILE NOT END
043500000000E001C                   Endif                                                  END IF SFL RCDS
043600000000     *
043700000000B001C     *IN38         Ifeq      *ON                                          IF PSN CHANGED
043800000000 001C     WWENDO        Andne     'END   '                                     AND NOT ERROR
043900000000B002C     WWPSNP        Ifeq      1                                            IF PSN VIEW 1
044000050317 002C                   Move      WSPSN1        WWPSN1                         SAVE PSN TO
044100000000E002C                   Endif                                                  IF PSN VIEW 1
044200000000 001C                   Exsr      PRCPSN                                       PROC POSTN TO
044300000000E001C                   Endif                                                  IF PSN PMT
044400000000     *
044500000000B001C     WWDLT         Ifeq      'Y'                                          IF DELETED RCD
044600000000 001C     *IN38         Andeq     *OFF                                         AND PSN NOT CHG
044700000000 001C     WWENDO        Andne     'END   '                                     AND NOT ERROR
044800000000 001C                   Exsr      PRCRFR                                       PROC REFRESH
044900000000E001C                   Endif                                                  IF PSN PMT
045000000000    C                   Endsr                                                  END PRCENT
045100000000     *___________________________________________________________________
045200000000     * Receive messages from a data queue and send to program queue
045300000000     *___________________________________________________________________
045400000000    C     RCVMSG        Begsr                                                  RECEIVE MSG
045500000000    C                   Movea     *IN           WWIN                           INDICATORS
045600000000    C                   Call      'PRCMSG2'                                    CALL MSG PGM
045700000000    C                   Parm      'RECEIVE '    WWRQS                          REQUEST MSG DSP
045800000000    C                   Parm                    WWIN                           INDICATORS
045900000000    C                   Parm                    WWRTN                          RETURN CODE
046000000000    C                   Movea     WWIN          *IN                            INDICATORS RET
046100000000    C                   Endsr                                                  END RCV MSG
046200000000     *___________________________________________________________________
046300000000     * Build option information
046400000000     *___________________________________________________________________
046500000000    C     BLDOPT        Begsr                                                  BUILD OPTIONS
046600000000    C                   Call      'PRCOPT2'                                    PROCESS OPTIONS
046700000000    C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
046800000000    C                   Parm                    WWRTN                          RETURN CODE
046900000000    C                   Parm                    WAP                            OPTION DESC
047000000000    C                   Parm                    WAO                            OPTION TAPLE
047100000000    C                   Parm                    WIOPV                          OPTIONS ALLOWED
047200000000    C     WWOPS         Add       WWOPS         WW                             OPT DSC IDX
047300000000    C                   Movel     WAP(WW)       WSOPD2                         LOAD LINE 2
047400000000    C                   Sub       1             WW                             BUMP IDX
047500000000    C                   Movel     WAP(WW)       WSOPD1                         LOAD LINE 1
047600000000    C                   Endsr                                                  END BLD OPTIONS
047700000000     *___________________________________________________________________
047800000000     * Build function key information for this program
047900000000     *___________________________________________________________________
048000000000    C     BLDFKY        Begsr                                                  BUILD FNC KEYS
048100991108    C                   Movea     *IN           WWIN                           INDICATORS
048200991108    C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
048300000000    C                   Parm      'BUILD   '    WWRQS                          REQUEST BUILD
048400000000    C                   Parm                    WWRTN                          RETURN CODE
048500000000    C                   Parm                    WAD                            FNC DESC
048600991108    C                   Parm                    WWIN                           AID BYTE
048700000000    C                   Parm                    WAF                            FNC KEY TABLE
048800000000    C                   Parm                    WIFKV                          FNCTN KYS ALLWD
048900000000    C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
049000000000    C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
049100000000    C                   Sub       1             WW                             BUMP IDX
049200000000    C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
049300000000    C                   Endsr                                                  END BLD FNCTNS
049400000000     *___________________________________________________________________
049500000000     * Clear list subfile
049600000000     *___________________________________________________________________
049700000000    C     CLRSFL        Begsr                                                  CLEAR SUBFILE
049800000000    C                   Seton                                        31        CLEAR SUBFILE
049900000000    C                   Write     LSTCTL                                       CLEAR SUBFILE
050000000000    C                   Setoff                                       31        CLEAR SUBFILE
050100000000    C                   Z-add     0             WSPAG                          SLF PAGE
050200000000    C                   Z-add     0             WFRRN                          SFL RRN
050300000000    C                   Z-add     0             WWRRN                          HIGH SFL RRN
050400000000    C                   Endsr                                                  END CLEAR SFL
050500000000     *___________________________________________________________________
050600000000     * Process SLCNXT Request
050700000000     *___________________________________________________________________
050800000000    C     SLCNXT        Begsr                                                  SELECT NEXT
050900000000    C                   Movel     'ERROR'       WORTN                          SET RETURN CODE
051000000000    C                   Move      *BLANKS       WWENDO                         LOOP END OPTION
051100000000B001C     WFRRN         Ifgt      0                                            IF SFL RECORDS
051200000000 001 *
051300000000B002C     WWENDO        Downe     'END'                                        DOWHILE NOT END
051400000000 002C                   Readc     LSTSFL                                 50    READ CHNG SBF
051500000000 002 *
051600000000B003C     *IN50         Ifeq      *OFF                                         IF CHANGED RECORD
051700000000B004C     WSOPC         Ifne      *BLANKS                                      IF OPTION CODE
051800000000 004C                   Exsr      PRCOPT                                       PROCESS OPTION
051900000000B005C     WWOPA         Ifeq      'SELECT'                                     IF SELECT
052000000000 005C                   Exsr      PRCSEL                                       PROCESS SELECT
052100000000E005C                   Endif                                                  END IF SELECT
052200000000E004C                   Endif                                                  END IF OPTION CODE
052300000000X003C                   Else                                                   ELSE
052400000000 003C                   Movel     'END'         WWENDO                         END OPTIONS
052500000000E003C                   Endif                                                  END IF CHG RCD
052600000000E002C                   Enddo                                                  END DO WHILE NOT END
052700000000E001C                   Endif                                                  END IF SFL RCDS
052800000000     *
052900000000    C                   Move      'END'         WWENDF                         END PGM LOOP
053000000000    C                   Endsr                                                  END SLCNXT
053100000000     *___________________________________________________________________
053200000000     * Process option selected
053300000000     *___________________________________________________________________
053400000000    C     PRCOPT        Begsr                                                  PROCESS OPTION
053500000000    C                   Move      *BLANKS       WWRQS                          CLEAR RQS FLD
053600000000    C                   Move      WSOPC         WDOPC                          BLD OPTION CODE
053700000000     *
053800000000B001C     WDOPC2        Ifeq      ' '                                          IF NOT RIGHT ADJ
053900000000 001C     WDOPC1        Andge     '0'                                          AND NUMERIC
054000000000 001C                   Move      WDOPC1        WDOPC2                         RIGHT ADJUST
054100000000 001C                   Move      '0'           WDOPC1                         RIGHT ADJUST
054200000000E001C                   Endif                                                  END RIGHT ADJ
054300000000     *
054400000000B001C     WDOPC1        Ifeq      ' '                                          IF LEADING BLANK
054500000000 001C     WDOPC2        Andge     '0'                                          AND NUMERIC
054600000000 001C                   Move      '0'           WDOPC1                         INSERT LEADING 0
054700000000E001C                   Endif                                                  END RIGHT ADJ
054800000000     *
054900000000B001C     WDOPC1        Ifeq      ' '                                          IF NOT LEFT ADJ
055000000000 001C     WDOPC2        Andlt     '0'                                          AND ALPHA
055100000000 001C                   Move      WDOPC2        WDOPC1                         LEFT ADJUST
055200000000 001C                   Move      ' '           WDOPC2                         LEFT ADJUST
055300000000E001C                   Endif                                                  END LEFT ADJ
055400000000     *
055500000000    C                   Call      'PRCOPT2'                                    PROCESS OPTIONS
055600000000    C                   Parm      WDOPC         WWRQS                          DISPLAY REQUEST
055700000000    C     WWOPA         Parm                    WWRTN                          RETURN CODE
055800000000    C                   Parm                    WAP                            OPTION DESC
055900000000    C                   Parm                    WAO                            OPTION TAPLE
056000000000    C                   Parm                    WIOPV                          OPTIONS ALLOWED
056100000000    C                   Endsr                                                  END PRCOPT
056200000000     *___________________________________________________________________
056300000000     * Process selection
056400000000     *___________________________________________________________________
056500000000    C     PRCSLC        Begsr                                                  PROCESS SELECTION
056600000000    C                   Exsr      PRCOPT                                       PROCESS OPTION
056700000000    C     WWOPA         Caseq     'DISPLAY'     PRCDSP                         DISPLAY
056800000000    C     WWOPA         Caseq     'CHANGE'      PRCCHG                         CHANGE
056900000000    C     WWOPA         Caseq     'DELETE'      PRCDLT                         DELETE
057000000000    C     WWOPA         Caseq     'SELECT'      PRCSEL                         SELECT
057100000000    C     WWOPA         Caseq     'COPY   '     PRCCHG                         COPY
057200000000    C     WWOPA         Caseq     'CPYKEY '     PRCCHG                         COPY W/GENKEY
057300000810    C     WWOPA         Caseq     'PRINT   '    PRCPRT                         ADD
057400000000    C                   Endcs                                                  END CASE
057500000000    C                   Endsr                                                  END PRCSLC
057600000000     *___________________________________________________________________
057700000000     * Process CHANGE option
057800000000     *___________________________________________________________________
057900000000    C     PRCCHG        Begsr                                                  PROCESS CHANGE
058000070103     ****
058100070103    C                   Move      'Y'           WWDLT                          SET EOF
058200061207     ****
058300061208     C                   eval      aotrst = xaotrst
058400061208     C                   eval      aosub# = xaosub#
058500061208     C                   eval      aoacct = xaoacct
058600061129     C     WSBEDT        MULT      10000.0001    aobedt
058700061201     C     WSENDT        MULT      10000.0001    aoendt
058800070313     C     WSDTDT        MULT      10000.0001    aodtdt
058900120228     *
059000120228     C                   If        %trim(allow) = 'Y'
059100120228     C                   eval      WWRTN = '*ALLOW'
059200170221    C                   eval      WWFKV = 'X 03  '                             FNC KEY ALLOWED
059300170221     C                   else
059400170221     C                   eval      WWRTN = *blanks
059500170221    C                   eval      WWFKV = 'X 0304'                             FNC KEY ALLOWED
059600120228     C                   end
059700050318     *
059800061129    C                   Call      'CHGOSP  '                           99      DLT RECORD
059900050317    C                   Parm      WWOPA         WWRQS                          DLT REQUEST
060000050317    C                   Parm                    WWRTN                          RETURN CODE
060100050317    C                   Parm                    WUPGM                          PROGRAM NAME
060200050317    C                   Parm                    WDDTA                          RECORD DS
060300210708    C                   Parm      'X 0304  '    WWFKV                          FNC KEY ALLOWED
060400050413    C                   Parm                    Whist             3            DATA
060500000707     *
060600061221     C**   AOBEDT        MULT      10000.0001    WSBEDT
060700061221     C**   AOENDT        MULT      10000.0001    WSENDT
060800061212     C                   Clear                   WSDESC
060900220802J001 C                   Exsr      PRCRFR
061000061212     C     AOCODE        Chain     AOECOD
061100061212     C                   If        %Found(AOECOD)
061200061212     C                   Eval      WSDESC   =    %Trim(AEDESC)
061300061212     C                   End
061400000707B001C     WWRTN         Ifeq      'UPDATE  '                                   IF CALL ERROR
061500000810 001C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
061600000707 001C                   Exsr      SNDMSG                                       SEND MESSAGE
061700000707E001C                   Endif                                                  END ERROR
061800000112     *
061900000112B001C     *IN99         Ifeq      '1'                                          IF CALL ERROR
062000000117 001C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
062100000112 001C                   Exsr      SNDMSG                                       SEND MESSAGE
062200000112 001C                   Movel     'ERROR'       WORTN                          RETURN ERROR
062300000112 001C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
062400000112E001C                   Endif                                                  END ERROR
062500061201     *
062600000000    C                   Endsr                                                  END PRCCHG
062700000000     *___________________________________________________________________
062800000000     * Process DELETE option
062900000000     *___________________________________________________________________
063000000000    C     PRCDLT        Begsr                                                  DELETE
063100061207     ****
063200061208     C                   eval      aotrst = xaotrst
063300061208     C                   eval      aosub# = xaosub#
063400061208     C                   eval      aoacct = xaoacct
063500061129     C     WSBEDT        MULT      10000.0001    aobedt
063600061201     C     WSENDT        MULT      10000.0001    aoendt
063700070313     C     WSDTDT        MULT      10000.0001    aodtdt
063800050318     *
063900061213    C                   Call      'DLTOSP  '                           99      DLT RECORD
064000061213    C                   Parm      'DELETE  '    WWRQS                          DLT REQUEST
064100061213    C                   Parm                    WWRTN                          RETURN CODE
064200061213    C                   Parm                    WUPGM                          PROGRAM NAME
064300061213    C                   Parm                    WDDTA                          RECORD DS
064400061213    C                   Parm      'X 03'        WWFKV                          FNC KEY ALLOWED
064500061213    C                   Parm                    WFRRN                          FNC KEY ALLOWED
064600061213    C                   Parm                    Whist             3            DATA
064700000000     *
064800000000B001C     *IN99         Ifeq      '1'                                          IF CALL ERROR
064900000614 001C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
065000000000 001C                   Exsr      SNDMSG                                       SEND MESSAGE
065100000000 001C                   Movel     'ERROR'       WORTN                          RETURN ERROR
065200000124 001C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
065300000000E001C                   Endif                                                  END ERROR
065400000000     *
065500000000B001C     WWRTN         Ifeq      *BLANKS                                      IF DELETED
065600000000 001C                   Move      'Y'           WWDLT                          SET DELETE FLAG
065700000000E001C                   Endif                                                  END IF DELETED
065800000000    C                   Endsr                                                  END PRCDLT
065900000000     *___________________________________________________________________
066000000000     * Process SELECT Option
066100000000     *___________________________________________________________________
066200000000    C     PRCSEL        Begsr                                                  PROCESS SELECT
066300000000    C                   Move      'END'         WWENDO                         END OPT LOOP
066400000000    C                   Move      'END'         WWENDF                         END PGM LOOP
066500000000    C                   Move      *BLANKS       WORTN                          SET RETURN CODE
066600000000    C                   Endsr                                                  END PRCSEL
066700000000     *___________________________________________________________________
066800000000     * Process DISPLAY option
066900000000     *___________________________________________________________________
067000000000    C     PRCDSP        Begsr                                                  DISPLAY
067100061207     ****
067200061208     C                   eval      aotrst = xaotrst
067300061208     C                   eval      aosub# = xaosub#
067400061208     C                   eval      aoacct = xaoacct
067500061129     C     WSBEDT        MULT      10000.0001    aobedt
067600061201     C     WSENDT        MULT      10000.0001    aoendt
067700070313     C     WSDTDT        MULT      10000.0001    aodtdt
067800000113     *
067900061129    C                   Call      'DSPOSP  '                           99      DLT RECORD
068000050317    C                   Parm                    WWRQS                          DLT REQUEST
068100050317    C                   Parm                    WWRTN                          RETURN CODE
068200050317    C                   Parm                    WUPGM                          PROGRAM NAME
068300050317    C                   Parm                    WDDTA                          RECORD DS
068400080318    C                   Parm      'X 12'        WWFKV                          FNC KEY ALLOWED
068500050413    C                   Parm                    Whist             3            DATA
068600050317     *
068700000113B001C     *IN99         Ifeq      '1'                                          IF CALL ERROR
068800000614 001C                   Movel     WTM(4)        WWMSG                          PASS MESSAGE
068900000113 001C                   Exsr      SNDMSG                                       SEND MESSAGE
069000000113 001C                   Movel     'ERROR'       WORTN                          RETURN ERROR
069100000113 001C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
069200000113E001C                   Endif                                                  END ERROR
069300000113     *
069400000113B001C     WWRTN         Ifeq      'EXIT'                                       IF CALL ERROR
069500000113 001C                   Movel     WWRTN         WORTN                          RETURN ERROR
069600000113 001C                   Movel     'END'         WWENDF                         RETURN ERROR
069700000113E001C                   Endif                                                  END ERROR
069800000113     *
069900000000    C                   Endsr                                                  END PRC DSPL
070000000124     *___________________________________________________________________
070100000614     * Process PRINT option
070200000124     *___________________________________________________________________
070300000614    C     PRCPRT        Begsr                                                  DISPLAY
070400000124     *
070500000124     *
070600000124    C                   Endsr                                                  END PRC DSPL
070700000000     *___________________________________________________________________
070800000000     * Process option Return
070900000000     *___________________________________________________________________
071000000000    C     PRCRTN        Begsr                                                  PROCESS OPT RTN
071100000000B001C     WWOPA         Ifne      'CHANGE  '                                   IF NOT CHANGE
071200000000 001C     WWOPA         Oreq      'CHANGE  '                                   OR CHANGE
071300000000 001C     WWRTN         Andeq     'CANCEL  '                                   AND CANCEL RETURN
071400220809 001C     WWOPA         Oreq      'CHANGE  '                                   OR CHANGE
071500220809 001C     WWRTN         Andeq     'UPDATE  '                                   AND CANCEL RETURN
071600000000 001C     WFRRN         Chain     LSTSFL                             99        GET SUBFILE RCD
071700000000E001C                   Endif                                                  END IF DELETED
071800000000     *
071900000000B001C     WWRTN         Ifeq      'ERROR '                                     IF RTN ERROR
072000000000 001C                   Seton                                        60        REVERSE IMAGE OPT
072100000000 001C                   Movel     'END   '      WWENDO                         END PROCESSING
072200000000X001C                   Else                                                   ELSE
072300000000 001C                   Setoff                                       60        NO REVERSE IMAGE
072400000000 001C                   Move      *BLANKS       WSOPC                          CLEAR OPTION
072500000000E001C                   Endif                                                  ENDIF ERROR
072600000000     *
072700000000B001C     WWRTN         Ifeq      'CANCEL'                                     IF CANCEL
072800000000 001C                   Movel     'END   '      WWENDO                         END PROCESSING
072900000000E001C                   Endif                                                  END IF EXIT/CANCEL
073000000000     *
073100000000    C                   Update    LSTSFL                                       UPDATE SFL
073200000000    C                   Z-add     WFRRN         WSPAG                          SET SFL PAGE
073300000000    C                   Endsr                                                  END PRCRTN
073400000000     *___________________________________________________________________
073500000000     * Process POSITION TO option
073600000000     *___________________________________________________________________
073700000000    C     PRCPSN        Begsr                                                  POSITION TO
073800991208     *
073900061129    C     WKOSP         Setll     ACCOSP                                       PSN DB CURSOR
074000050317    C                   Clear                   WSPSN1                         CLEAR PSN TO
074100000000    C                   Exsr      CLRSFL                                       CLEAR SUBFILE
074200000000    C                   Exsr      PRCRUP                                       LOAD SUBFILE
074300000000    C                   Move      'Y'           WWPSNC                         SET PSN CHANGED
074400050318     *
074500000000    C                   Endsr                                                  END POSITION TO
074600210813     *___________________________________________________________________
074700210813ADD1 * Process CLEANUP
074800210813ADD1 *___________________________________________________________________
074900210813ADD1C     CLEANUP       Begsr                                                  POSITION TO
075000210813
075100210813     C                   eval      mycount = 0
075200210813     C                   eval      ddcount = 0
075300210813
075400210813     C     Akey          Setgt     ACCOSPL1
075500210813     C     Akey          Readpe    ACCOSPL1
075600210813     C                   Dow       Not %Eof(ACCOSPL1)
075700210813     C                   if        OSAOENDT = 0
075800210813     C                   eval      mycount = mycount + 1
075900210813     C                   end
076000210813     C     Akey          Readpe    ACCOSPL1
076100210813     C                   Enddo
076200210813
076300210813     C                   if        mycount > 1
076400210813     C     Akey          Setgt     ACCOSPL1
076500210813     C     Akey          Readpe    ACCOSPL1
076600210813     C                   Dow       Not %Eof(ACCOSPL1)
076700210813     C                   if        OSAOENDT = 0
076800210813     C                   eval      ddcount = ddcount + 1
076900210813     C                   if        ddcount = mycount
077000210813     C                   eval      OSAOENDT = OSAOBEDT
077100210813     C                   update    osp
077200210813     C                   leave
077300210813     C                   end
077400210813     C                   end
077500210813     C     Akey          Readpe    ACCOSPL1
077600210813     C                   Enddo
077700210813     C                   end
077800210813    C                   Endsr                                                  END POSITION TO
077900000000     *___________________________________________________________________
078000000000     * Send message
078100000000     *___________________________________________________________________
078200000000    C     SNDMSG        Begsr                                                  SEND MESSAGE
078300000000    C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
078400000000    C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
078500000000    C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
078600000000    C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
078700000000    C                   Parm                    WWMSG            80            ERROR MESSAGE
078800000000    C                   Endsr                                                  END PROC FNC
078900000000     *___________________________________________________________________
079000000000     * Parameter lists
079100000000     *___________________________________________________________________
079200000000    C     PLIST         Begsr                                                  PARM LISTS
079300000000    C     *ENTRY        Plist                                                  *ENTRY LIST
079400000000    C                   Parm                    WIRQS             8            PROGRAM REQUEST
079500000000    C                   Parm                    WORTN             8            RETURN CODE
079600000000    C                   Parm                    WUPGM            10            LAST PGM NAME
079700000614    C                   Parm                    WDDTA                          RECORD DS
079800000000    C                   Parm                    WIOPV            60            OPTIONS VALID
079900000000    C                   Parm                    WIFKV            60            FUNCTIONS VALID
080000050413    C                   Parm                    Whist             3            PROGRAM REQUEST
080100000000    C                   Endsr
080200000000     *___________________________________________________________________
080300000000     * Define Variables
080400000000     *___________________________________________________________________
080500000000    C     DEFN          Begsr                                                  DEFINITIONS
080600000000    C     *LIKE         Define    WIRQS         WWRQS                          REQUEST CODE
080700000000    C     *LIKE         Define    WIRQS         WWRQSD                         REQUEST CODE DTL
080800000000    C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
080900000000    C     *LIKE         Define    WORTN         WWRTNH                         RETURN CODE
081000000000    C     *LIKE         Define    WORTN         WWRTND                         RETURN CODE
081100000000    C     *LIKE         Define    WIOPV         WWOPV                          OPTIONS VALID
081200000000    C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
081300000000    C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
081400000000    C                   Move      *BLANKS       WWFKA             8            FUNCTION ACTION
081500000000    C                   Move      *BLANKS       WWENDF            3            FUNCTION CONTROL
081600000000    C                   Move      *BLANKS       WWOPA             8            OPTION ACTION
081700000000    C                   Move      *BLANKS       WDOPC             2            OPTION CODE 2A
081800000000    C                   Move      *BLANKS       WWENDO            3            OPTION CONTROL
081900000000    C                   Move      'N'           WWSFLE            1            SUBFILE END
082000000000    C                   Z-add     0             WWLOWR            4 0          SUB FILE LOW REL REC
082100000000    C                   Z-add     0             WW                3 0          ARRAY  INDEX
082200000000    C                   Z-add     11            WWLSTS            2 0          LST SFL PAG SIZ
082300000000    C                   Z-add     0             WFRRN             4 0          LST SFL RRN
082400000000    C                   Z-add     0             WWRRN             4 0          LST SFL HIGH RRN
082500000000    C                   Z-add     1             WWOPS             1 0          OPTION SET
082600000000    C                   Z-add     0             WWOPSO            1 0          OPTION SET OLD
082700000000    C                   Z-add     1             WWFKS             1 0          FUNTION KEY SET
082800000000    C                   Z-add     0             WWFKSO            1 0          FUNTION KEY SET OLD
082900000000    C                   Z-add     1             WWPSNP            1 0          POSITION TO VIEW#
083000000000    C                   Move      'Y'           WWPSNC            1            POSITION TO CHANGED
083100000000    C                   Move      'N'           WWDLT             1            DELETE?
083200010219    C                   Z-add     1             WWPSNN            1 0          NBR PSN TO PMTS
083300030425      **  Position not used in this program.
083400061129     C     *Like         Define    AOTRST        WSPSN1
083500000127    C     *LIKE         Define    WSPSN1        WWPSN1                         SAVE POSITION TO
083600000000    C                   Z-add     41            WWPSNI            2 0          PSN TO BASE IND
083700000000    C     WWPSNI        Add       WWPSNN        WWLMT             2 0          PSN TO IND LMT
083800000000    C     WWLMT         Sub       1             WWLMT                          PSN TO IND LMT
083900000000    C                   Movel     '*'           MSPGMQ                         MSG SFL JOB MSGQ
084000000000    C                   Move      *BLANKS       WSOPC                          OPTION CODE
084100000000    C                   Endsr                                                  END DEFN
084200000000     *___________________________________________________________________
084300000000     * Key lists
084400000000     *___________________________________________________________________
084500000000    C     KLIST         Begsr                                                  KEY LISTS
084600991201    C     WKPSN1        Klist                                                  ACKCTL
084700050317    C                   Kfld                    WWTRST
084800061129    C     WKOSP         Klist                                                  ACKCTL
084900050317    C                   Kfld                    WWTRST
085000050317    C                   Kfld                    WWSUB#
085100050317     C                   Kfld                    WWACCT
085200050317    C     AKey          Klist                                                  ACKCTL
085300061129    C                   Kfld                    AOTRST
085400061129    C                   Kfld                    AOSUB#
085500061129    C                   Kfld                    AOACCT                         POSITION TO 1
085600000000    C                   Endsr                                                  END KLIST
085700000000     *___________________________________________________________________
085800000000     * Program error handler
085900000000     *___________________________________________________________________
086000000000    C     *PSSR         Begsr                                                  PROGRAM ERROR
086100000000    C                   Call      'SNDRPGM'                            50      SEND RPG MSG
086200000000    C                   Parm                    WQPGMN                         PROGRAM NAME
086300000000    C                   Parm                    WQSTSC                         STATUS CODE
086400000000    C                   Parm                    WQRPGS                         RPG STATEMENT
086500000000    C                   Parm                    WQMSG                          MESSAGE ID
086600000000    C                   Endsr     '*CANCL'                                     END PGM ERROR
086700000000     *___________________________________________________________________
086800000000**  WAO OPTION TABLE - 30X38            |OPTION 2A, ACTION 8A, DESCRIPTION 28A |
08690000000001SELECT  1=Select
08700000000002CHANGE  2=Change
08710000000003COPY    3=Copy
08720000000004DELETE  4=Delete
08730000000005DISPLAY 5=Display
087400000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION 8A, DESCR 30A   |
08750000000003EXIT    F3=Exit
08760000000005REFRESH F5=Refresh
08770000011206ADD     F6=Add
08780003042510PMTPSN
08790021070812CANCEL  F12=Exit
08800000000025ROLLUP
08810000000026ROLLDOWN
088200000000** WTM
08830000000000You have reached the top of the list.
08840006112900Call to CHGOSP failed.  Data was not changed.
08850006112900Call to DLTOSP failed.  Data was not deleted.
08860006112900Call to DSPOSP failed.  Data was not displayed.
08870000000000No records found.
08880006120700Account OLE code data has been updated.
08890005041400Account has been termed.
