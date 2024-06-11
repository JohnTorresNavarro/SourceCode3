000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300040826    ? *  (c)Copyright 2004 by GBS, Inc.
000400000000    ? *_________________________________________________________________________
000500000000    ? *
000600111018    ?FINQBSMODD CF   E             WORKSTN SFILE(LSTSFL:WFRRN) INFDS(DSPD)
000800111006    ?FBENSUMF   IF   E             DISK
000900000000    ? *_________________________________________________________________________
001000000000    ? *
001100000000    ?D WAO             S             38    DIM(30) CTDATA PERRCD(1)             OPTION TABLE
001200000000    ?D WAP             S             75    DIM(6)                               OPTION DESC
001300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001500000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
001600020212     D #TODAY          S               D   DATFMT(*ISO)
001700000000    ? *_________________________________________________________________________
001800000407    ? * Data structure
001801111007    ?D WUPAYP        E DS                  EXTNAME(BENSUMF)
001900111007    ?D WMEMBER       E DS                  EXTNAME(MEMBER)
002200020521    ? *
002300000000    ? * Option code data structure
002400000000    ?D                 DS
002500000000    ?D  WDOPC                  1      2
002600000000    ?D  WDOPC1                 1      1
002700000000    ?D  WDOPC2                 2      2
002800000000    ? *
002900000000    ? * CURSOR LOCATION
003000000000    ?D                 DS
003100000000    ?D  WWCRSL                 1      2
003200000000    ?D  WWCRSN                 1      2B 0
003300020926    ? *
003400000000    ? * Program status data structure
003500991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003600000000    ? *
003700000000    ? * Display file data structure
003800991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003900000000    ? *___________________________________________________________________
003901111007     C     *Entry        Plist
003902111007     C                   Parm                    WHEAD            10
004100000000    ? * Process list panel
004200000000B001?C     WIRQS         Ifne      'SLCNXT  '                                   IF NOT NEXT SELECT
004300000000 001?C                   Exsr      DEFN                                         DEFINE FIELDS
004400000000E001?C                   Endif                                                  ENDIF NEXT SELECT
004500000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004600000000    ? *
004700000000B001?C     WWENDF        Downe     'END'                                        DOWHILE NOT END
004800000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
004900000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005000000000 001?C                   Exsr      PRCFKY                                       PROC FN KEYS
005100000000 001? *
005200000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
005300000000 001?C     WWFKA         Caseq     'REFRESH '    PRCRFR                         REFRESH
005400000000 001?C     WWFKA         Caseq     'PMTPSN  '    PRCPMT                         PMT POSITION TO
005500000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005600000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
005700000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLLDOWN
005800000000 001?C     WWFKA         Caseq     'ENTER   '    PRCENT                         ENTER
005900000000 001?C                   Endcs                                                  END CASE
006000000000E001?C                   Enddo                                                  END DOWHILE
006100000000    ? *
006200000000    ?C                   Write     REMOVE                                       REMOVE WINDOW
006300020212    ?C                   Move      *on           *inlr                          RETURN
006400000000    ? *___________________________________________________________________
006500000000    ? * Prepare list panel
006600000000    ? *___________________________________________________________________
006700000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006800020911    ***
006900000000    ?C                   Exsr      SETPSN                                       SET POSITION TO IND
007000000000    ? *
007100020212     C                   Move      *Date         #today
007200020212    ? *
007300000000B001?C     WIRQS         Ifeq      'SLCNXT'                                     IF SELECT NEXT
007400000000 001?C                   Exsr      SLCNXT                                       SELECT NEXT
007500000000X001?C                   Else                                                   ELSE
007600000000 001?C                   Exsr      PRCPSN                                       PROC POSITION TO
007700000000E001?C                   Endif                                                  END IF SELECT NEXT
007800000000    ?C                   Endsr                                                  END PRPPNL
007900000000    ? *___________________________________________________________________
008000000000    ? * Set position to screen indicators
008100000000    ? *___________________________________________________________________
008200000000    ?C     SETPSN        Begsr                                                  SET POSITION TO
008300000000B001?C     WWPSNI        Do        WWLMT         WW                             DO FOR NBR VIEWS
008400000000 001?C                   Move      '0'           *IN(WW)                        SET OFF PSN
008500000000E001?C                   Enddo                                                  END DO
008600000000    ?C     WWPSNI        Add       WWPSNP        WW                             VIEW# -> IND#
008700000000    ?C     WW            Sub       1             WW                             VIEW# -> IND#
008800000000    ?C                   Move      '1'           *IN(WW)                        DISPLAY PSN TO
008900000000    ?C                   Endsr                                                  END SETPSN
009000000000    ? *___________________________________________________________________
009100000000    ? * Display list panel
009200000000    ? *___________________________________________________________________
009300000000    ?C     DSPPNL        Begsr                                                  DISPALY PANEL
009400000000    ? *
009500000000    ? * Set OVERLAY based on last display file processed
009600000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
009700000000 001?C                   Setoff                                       35        OVERLAY OFF
009800000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
009900000000X001?C                   Else                                                   ELSE SAME PGM
010000000000 001?C                   Seton                                        35        OVERLAY ON
010100000000E001?C                   Endif                                                  END IF NEW PGM
010200000000    ? *
010300000000    ? * Write message subfile
010400000000    ?C                   Seton                                        30        SFLMSG DISPLAY
010500000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
010600000000    ? *
010700000000    ? * Write function keys
010800000000B001?C     *IN35         Ifeq      *OFF                                         IF OVERLAY OFF
010900000000 001?C                   Write     FKYDSC                                       DSP FNC KEY DSC
011000000000E001?C                   Endif                                                  END IF F KEY SET
011100000000    ? *
011200000000    ? * Set subfile control panel overrides
011300000000B001?C     WWPSNC        Ifeq      'Y'                                          IF PSN CHANGED
011400000000 001?C                   Setoff                                       36        DO NOT PUTOVR
011500000000 001?C                   Move      'N'           WWPSNC                         NOT CHANGED
011600000000X001?C                   Else                                                   ELSE
011700000000 001?C                   Seton                                        36        PUTOVR
011800000000E001?C                   Endif                                                  END IF PSN
011900000000    ? *
012000000000    ? * Set subfile control inticators
012100000000B001?C     WFRRN         Ifeq      0                                            IF SUBFILE EMPTY
012200000000 001?C                   Setoff                                       30        ERASE SUBFILE
012300000000X001?C                   Else                                                   ELSE SUBFILE
012400000000 001?C                   Seton                                        30        DISPLAY SUBFILE
012500000000E001?C                   Endif                                                  END IF SFL EMPTY
012600000000    ? *
012700000000    ? * Write subfile
012800000000    ?C                   Exfmt     LSTCTL                                       DSP LST PANEL
012900000000    ?C                   Z-add     WDLOWR        WWLOWR                         SAVE SFL RCD NBR
013000000000    ?C                   Z-add     WDLOWR        WSPAG                          SET CURRENT PAGE
013100000000    ?C                   Setoff                                       626336    RESET SCREEN CTL
013200000000    ?C                   Endsr                                                  END DSPPNL
013300000000    ? *___________________________________________________________________
013400000000    ? * Process function key pressed
013500000000    ? *___________________________________________________________________
013600000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
013700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
013800991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
013900000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
014000000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
014100000000    ?C                   Parm                    WAD                            FNC DESC
014200991108    ?C                   Parm                    WWIN                           *IN
014300000000    ?C                   Parm                    WAF                            FNC KEY TABLE
014400000000    ?C                   Parm                    WWFKV                          FNC KYS ALLWD
014500000000    ?C                   Endsr                                                  END PRC FKY
014600000000    ? *___________________________________________________________________
014700000000    ? * Process EXIT function
014800000000    ? *___________________________________________________________________
014900000000    ?C     PRCEXT        Begsr                                                  PROCESS EXIT
015000000000    ?C                   Movel     WWFKA         WORTN                          SET RETURN CODE
015100000000    ?C                   Move      'END'         WWENDF                         END FNC LOOP
015200000000    ?C                   Endsr                                                  END PRCEXT
015300000000    ? *___________________________________________________________________
015400000000    ? * Process REFRESH function
015500000000    ? *___________________________________________________________________
015600000000    ?C     PRCRFR        Begsr                                                  PROCESS REFRESH
015700000000    ?C                   Exsr      PRCPSN                                       POSITION TO
015800000000B001?C     WSPAG         Dowlt     WWLOWR                                       DO WHILE NOT PRV PAG
015900000000 001?C     WWSFLE        Andne     'Y'                                          AND NOT EOF
016000000000 001?C                   Exsr      PRCRUP                                       LOAD SUBFILE
016100000000E001?C                   Enddo                                                  END DO NOT PRV PAG
016200000000    ?C                   Endsr                                                  END PRCRFR
016300000000    ? *___________________________________________________________________
016400000000    ? * Process CANCEL function
016500000000    ? *___________________________________________________________________
016600000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
016700000000    ?C                   Movel     WWFKA         WORTN                          SET RETURN CODE
016800000000    ?C                   Move      'END'         WWENDF                         END FNC LOOP
016900000000    ?C                   Endsr                                                  END PRCCNL
017000000000    ? *___________________________________________________________________
017100000000    ? * Process POSITION TO function
017200000000    ? *___________________________________________________________________
017300000000    ?C     PRCPMT        Begsr                                                  PROCESS POSITION
017400000000    ? *
017500000000    ?C                   Move      '     '       WSFLD                          TRUNCATE FIELD
017600000000B001?C     WSFLD         Ifeq      'WSPSN'                                      IF CURSOR ON PSN
017700000000 001?C     WWPSNP        Add       1             WWPSNP                         BUMP PSN TO VIEW
017800000000B002?C     WWPSNP        Ifgt      WWPSNN                                       IF GT HIGH VIEW
017900000000 002?C                   Z-add     1             WWPSNP                         SET TO BGN VIEW
018000000000E002?C                   Endif                                                  END IF GT HIGH PSN
018100000000 001? *
018200000000 001?C                   Exsr      SETPSN                                       SET PSN TO IND
018300000000E001?C                   Endif                                                  END IF CSR ON PSN
018400000000    ? *
018500000000    ?C                   Seton                                        63        POSITION CURSOR
018600000000    ?C                   Move      'Y'           WWPSNC                         SET PSN CHANGED
018700000000    ? *
018800000000    ?C                   Endsr                                                  END PRCPMT
018900000000    ? *___________________________________________________________________
019000000000    ? * Process ROLL UP function (add a page to list subfile)
019100000000    ? *___________________________________________________________________
019200000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
019300000000    ?C                   Move      'N'           WWSFLE                         SUBFILE END
019400000000    ?C                   Z-add     WWRRN         WSPAG                          SFL PAG = LAST PAGE
019500000000    ?C                   Z-add     1             WW                             WINDOW INDEX
019600000000    ?C                   Z-add     WWRRN         WFRRN                          HIGH SFL RRN
019700000000    ?C                   Setoff                                       50        RESET EOF IND
019800000000    ?C                   Setoff                                       6061      SUBFILE SRC CTL
019900000000    ?C                   Clear                   LSTSFL                         BLANK SFL RECORD
020000000000    ? *
020100000000B001?C     WW            Dowle     WWLSTS                                       DO WHILE PAG SIZ
020200000000 001?C     *IN50         Andeq     '0'                                          AND RECORDS
020400111006 002?C                   Read      BENSUMF                                50    READ FILE
020600010223B002?C     *IN50         Ifeq      '0'                                          IF RECORD READ
020601111006 002?C                   Add       1             WFRRN                          BUMP SFL RRN
020602111006 002?C                   Add       1             WW                             BUMP INDEX
020603111006     C                   Movel     BSFLAT        WSFLAT
020606111007     C                   Select
020607111007     C                   When      %trim(BSFLAT) = *blanks
020608111007     C                   Eval      *in99 = *off
020609111007     C                   Other
020610111007     C                   Move      BSFLAT        W1                1
020611111007     C                   If        %trim(W1) = *blanks
020612111007     C                   Eval      *in99 = *on
020613111007     C                   Else
020614111007     C                   Eval      *in99 = *off
020615111007     C                   End
020616111007     C                   Endsl
020617100617 002?C                   Write     LSTSFL                                       WRITE SFL REC
021400000000X002?C                   Else                                                   ELSE EOF
021500000000 002?C                   Move      'Y'           WWSFLE                         SET EOF
021600000000E002?C                   Endif                                                  END IF REC READ
021700000000 001? *
021800000000E001?C                   Enddo                                                  END DO
021801111007    ? *
021802111007     C                   If        ww = 9
021803111007 002?C                   Read      BENSUMF                                50    READ FILE
021804111007B002?C     *IN50         Ifeq      '0'                                          IF RECORD READ
021805111007 002?C                   Readp     BENSUMF                                50    READ FILE
021806111007     C                   Else
021807111007 002?C                   Move      'Y'           WWSFLE                         SET EOF
021808111007     C                   End
021809111007     C                   End
021900000000    ? *
022000000000B001?C     WFRRN         Ifgt      WWRRN                                        IF RECORDS ADDED
022100000000 001?C     WWRRN         Add       1             WSPAG                          SFL PAG = 1ST NEW RC
022200000000 001?C                   Z-add     WFRRN         WWRRN                          SAVE HIGH SFL RRN
022300000000E001?C                   Endif                                                  END IF RCDS ADDED
022400000000    ? *
022500000000B001?C     WFRRN         Ifeq      0                                            IF SFL EMPTY
022600991116 001?C                   Move      WTM(3)        WWMSG                          EOF MSG
022700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
022800000000E001?C                   Endif                                                  IF SFL EMPTY
022900000000    ? *
023000000000B001?C     WWSFLE        Ifeq      'Y'                                          AT END OF FILE?
023100000000 001?C                   Move      WTM(2)        WWMSG                          EOF MSG
023200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
023300000000E001?C                   Endif                                                  END IF END OF FILE
023301111007    ? *
023302111007B001?C     WWSFLE        Ifeq      'Y'                                          AT END OF FILE?
023303111007 001?C                   Seton                                        39        SFLEND BOTTOM
023304111007X001?C                   Else                                                   ELSE
023305111007 001?C                   Setoff                                       39        SFLEND MORE...
023306111007E001?C                   Endif                                                  END IF END OF FILE
023400000000    ? *
023500000000    ?C                   Endsr                                                  END PRCRUP
023600000000    ? *___________________________________________________________________
023700000000    ? * Process ROLLDOWN function (beginning of SFL reached)
023800000000    ? *___________________________________________________________________
023900000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
024000000000    ?C                   Z-add     1             WSPAG                          DSP 1ST PAGE
024100000000    ?C                   Move      WTM(1)        WWMSG                          BGN SFL MSG
024200000000    ?C                   Exsr      SNDMSG                                       SEND MSG
024300000000    ?C                   Endsr                                                  END PRCRDN
024400000000    ? *___________________________________________________________________
024500000000    ? * Process ENTER function
024600000000    ? *___________________________________________________________________
024700000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
024800000000    ?C                   Move      *BLANKS       WWENDO                         OPT LOOP STATE
024900000000    ?C                   Move      *BLANKS       WWRTN                          RETURN VALUE
025000000000    ?C                   Setoff                                       50        RESET EOF IND
025100000000    ? *
025200000000B001?C     WFRRN         Ifgt      0                                            IF SFL RECORDS
025300000000 001? *
025400000000B002?C     WWENDO        Downe     'END'                                        DOWHILE NOT END
025500000000 002?C     *IN50         Andne     *ON                                          AND NOT EOF
025600000000 002?C                   Readc     LSTSFL                                 50    READ CHNG SBF
025700000000 002? *
025800000000B003?C     *IN50         Ifeq      *OFF                                         IF CHANGED RECORD
025900000000 003?C     WSOPC         Andne     *BLANKS                                      AND OPTION CODE
026000000000 003?C                   Exsr      PRCSLC                                       PROCESS SELECTION
026100000000 003?C                   Exsr      PRCRTN                                       PROCESS OPT RETURN
026200000000E003?C                   Endif                                                  END IF SELECTION
026300000000E002?C                   Enddo                                                  END DO WHILE NOT END
026400000000E001?C                   Endif                                                  END IF SFL RCDS
026500000000    ? *
026600000000B001?C     *IN38         Ifeq      *ON                                          IF PSN CHANGED
026700000000 001?C     WWENDO        Andne     'END   '                                     AND NOT ERROR
026800000000B002?C     WWPSNP        Ifeq      1                                            IF PSN VIEW 1
026900111006 002?C*                  Movel     WSPSN1        WWPSN1           20            SAVE PSN TO
027000000000E002?C                   Endif                                                  IF PSN VIEW 1
027100000000 001?C                   Exsr      PRCPSN                                       PROC POSTN TO
027200000000E001?C                   Endif                                                  IF PSN PMT
027300000000    ?C                   Endsr                                                  END PRCENT
027400000000    ? *___________________________________________________________________
027500000000    ? * Receive messages from a data queue and send to program queue
027600000000    ? *___________________________________________________________________
027700000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
027800000000    ?C                   Movea     *IN           WWIN                           INDICATORS
027900000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
028000000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST MSG DSP
028100000000    ?C                   Parm                    WWIN                           INDICATORS
028200000000    ?C                   Parm                    WWRTN                          RETURN CODE
028300000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
028400000000    ?C                   Endsr                                                  END RCV MSG
028500000000    ? *___________________________________________________________________
028600000000    ? * Clear list subfile
028700000000    ? *___________________________________________________________________
028800000000    ?C     CLRSFL        Begsr                                                  CLEAR SUBFILE
028900000000    ?C                   Seton                                        31        CLEAR SUBFILE
029000000000    ?C                   Write     LSTCTL                                       CLEAR SUBFILE
029100000000    ?C                   Setoff                                       31        CLEAR SUBFILE
029200000000    ?C                   Z-add     0             WSPAG                          SLF PAGE
029300000000    ?C                   Z-add     0             WFRRN                          SFL RRN
029400000000    ?C                   Z-add     0             WWRRN                          HIGH SFL RRN
029500000000    ?C                   Endsr                                                  END CLEAR SFL
029600000000    ? *___________________________________________________________________
029700000000    ? * Process SLCNXT Request
029800000000    ? *___________________________________________________________________
029900000000    ?C     SLCNXT        Begsr                                                  SELECT NEXT
030000000000    ?C                   Movel     'ERROR'       WORTN                          SET RETURN CODE
030100000000    ?C                   Move      *BLANKS       WWENDO                         LOOP END OPTION
030200000000B001?C     WFRRN         Ifgt      0                                            IF SFL RECORDS
030300000000 001? *
030400000000B002?C     WWENDO        Downe     'END'                                        DOWHILE NOT END
030500000000 002?C                   Readc     LSTSFL                                 50    READ CHNG SBF
030600000000 002? *
030700000000B003?C     *IN50         Ifeq      *OFF                                         IF CHANGED RECORD
030800000000B004?C     WSOPC         Ifne      *BLANKS                                      IF OPTION CODE
030900000000 004?C                   Exsr      PRCOPT                                       PROCESS OPTION
031000000000B005?C     WWOPA         Ifeq      'SELECT'                                     IF SELECT
031100000000 005?C                   Exsr      PRCSEL                                       PROCESS SELECT
031200000000E005?C                   Endif                                                  END IF SELECT
031300000000E004?C                   Endif                                                  END IF OPTION CODE
031400000000 003? *
031500000000X003?C                   Else                                                   ELSE
031600000000 003?C                   Movel     'END'         WWENDO                         END OPTIONS
031700000000E003?C                   Endif                                                  END IF CHG RCD
031800000000E002?C                   Enddo                                                  END DO WHILE NOT END
031900000000E001?C                   Endif                                                  END IF SFL RCDS
032000000000    ? *
032100000000    ?C                   Move      'END'         WWENDF                         END PGM LOOP
032200000000    ?C                   Endsr                                                  END SLCNXT
032300000000    ? *___________________________________________________________________
032400000000    ? * Process option selected
032500000000    ? *___________________________________________________________________
032600000000    ?C     PRCOPT        Begsr                                                  PROCESS OPTION
032700000000    ?C                   Move      *BLANKS       WWRQS                          CLEAR RQS FLD
032800000000    ?C                   Move      WSOPC         WDOPC                          BLD OPTION CODE
032900000000    ? *
033000000000    ?C                   Call      'PRCOPT2'                                    PROCESS OPTIONS
033100000000    ?C                   Parm      WDOPC         WWRQS                          DISPLAY REQUEST
033200000000    ?C     WWOPA         Parm                    WWRTN                          RETURN CODE
033300000000    ?C                   Parm                    WAP                            OPTION DESC
033400000000    ?C                   Parm                    WAO                            OPTION TAPLE
033500000000    ?C                   Parm                    WWOPV                          OPTIONS ALLOWED
033600000000    ?C                   Endsr                                                  END PRCOPT
033700000000    ? *___________________________________________________________________
033800000000    ? * Process selection
033900000000    ? *___________________________________________________________________
034000000000    ?C     PRCSLC        Begsr                                                  PROCESS SELECTION
034100000000    ?C                   Exsr      PRCOPT                                       PROCESS OPTION
034200000000    ?C     WWOPA         Caseq     'DISPLAY'     PRCDSP                         DISPLAY
034300000000    ?C     WWOPA         Caseq     'SELECT'      PRCSEL                         SELECT
034400000000    ?C                   Endcs                                                  END CASE
034500000000    ?C                   Endsr                                                  END PRCSLC
034600000000    ? *___________________________________________________________________
034700000000    ? * Process SELECT Option
034800000000    ? *___________________________________________________________________
034900000000    ?C     PRCSEL        Begsr                                                  PROCESS SELECT
035000000000    ?C                   Move      'END'         WWENDO                         END OPT LOOP
035100000000    ?C                   Move      'END'         WWENDF                         END PGM LOOP
035200000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
035300000000    ?C                   Endsr                                                  END PRCSEL
035400000000    ? *___________________________________________________________________
035500000000    ? * Process DISPLAY option
035600000000    ? *___________________________________________________________________
035700000000    ?C     PRCDSP        Begsr                                                  DISPLAY
035800000000    ?C                   Endsr                                                  END PRC DSPL
035900000000    ? *___________________________________________________________________
036000000000    ? * Process option Return
036100000000    ? *___________________________________________________________________
036200000000    ?C     PRCRTN        Begsr                                                  PROCESS OPT RTN
036300000000    ? *
036400000000B001?C     WWRTN         Ifeq      'ERROR '                                     IF RTN ERROR
036500000000 001?C                   Seton                                        60        REVERSE IMAGE OPT
036600000000 001?C                   Movel     'END   '      WWENDO                         END PROCESSING
036700000000X001?C                   Else                                                   ELSE
036800000000 001?C                   Setoff                                       60        NO REVERSE IMAGE
036900000000 001?C                   Move      *BLANKS       WSOPC                          CLEAR OPTION
037000000000E001?C                   Endif                                                  ENDIF ERROR
037100000000    ? *
037200000000B001?C     WWRTN         Ifeq      'CANCEL'                                     IF CANCEL
037300000000 001?C                   Movel     'END   '      WWENDO                         END PROCESSING
037400000000E001?C                   Endif                                                  END IF EXIT/CANCEL
037500000000    ? *
037600000000    ?C                   Update    LSTSFL                                       UPDATE SFL
037700000000    ?C                   Z-add     WFRRN         WSPAG                          SET SFL PAGE
037800000000    ?C                   Endsr                                                  END PRCRTN
037900000000    ? *___________________________________________________________________
038000000000    ? * Process POSITION TO option
038100000000    ? *___________________________________________________________________
038200000000    ?C     PRCPSN        Begsr                                                  POSITION TO
038511111006 001?C     1             Setll     BENSUMF                                      PSN DB CURSOR
038700000000    ?C                   Exsr      CLRSFL                                       CLEAR SUBFILE
038800000000    ?C                   Exsr      PRCRUP                                       LOAD SUBFILE
038900000000    ?C                   Move      'Y'           WWPSNC                         SET PSN CHANGED
039000000000    ?C                   Endsr                                                  END POSITION TO
039100000000    ? *___________________________________________________________________
039200000000    ? * Send message
039300000000    ? *___________________________________________________________________
039400000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
039500000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
039600000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
039700000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
039800000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
039900000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
040000000000    ?C                   Endsr                                                  END PROC FNC
040100000000    ? *___________________________________________________________________
040200000000    ? * Parameter lists
040300000000    ? *___________________________________________________________________
040400000000    ?C     PLIST         Begsr                                                  PARM LISTS
040500111006    ?C     KEYFAKE       Klist                                                  *ENTRY LIST
040600111006    ?C                   kfld                    WIRQS             8            PROGRAM REQUEST
040700111006    ?C                   kfld                    WORTN             8            RETURN CODE
040800111006    ?C                   kfld                    WUPGM            10            LAST PGM NAME
040900111006    ?C                   kfld                    WUPAYP                         RECORD DS
041000000000    ?C                   Endsr
041100000000    ? *___________________________________________________________________
041200000000    ? * Define Variables
041300000000    ? *___________________________________________________________________
041400000000    ?C     DEFN          Begsr                                                  DEFINITIONS
041500000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST CODE
041600000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
041700000000    ?C                   Move      *BLANKS       WWOPV            60            OPTIONS VALID
041800000000    ?C                   Move      *BLANKS       WWFKV            60            FUNCTIONS VALID
041900000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
042000000000    ?C                   Move      *BLANKS       WWFKA             8            FUNCTION ACTION
042100000000    ?C                   Move      *BLANKS       WWENDF            3            FUNCTION CONTROL
042200000000    ?C                   Move      *BLANKS       WWOPA             8            OPTION ACTION
042300000000    ?C                   Move      *BLANKS       WWENDO            3            OPTION CONTROL
042400000000    ?C                   Move      'N'           WWSFLE            1            SUBFILE END
042500000000    ?C                   Z-add     0             WWLOWR            4 0          SUB FILE LOW REL REC
042600000000    ?C                   Z-add     0             WW                3 0          ARRAY  INDEX
042700111006    ?C                   Z-add     8             WWLSTS            2 0          LST SFL PAG SIZ
042800000000    ?C                   Z-add     0             WFRRN             4 0          LST SFL RRN
042900000000    ?C                   Z-add     0             WWRRN             4 0          LST SFL HIGH RRN
043000990824    ?C                   Z-add     1             WWPSNP            1 0          POSITION TO VIEW#
043100000000    ?C                   Move      'Y'           WWPSNC            1            POSITION TO CHANGED
043200990824    ?C                   Z-add     1             WWPSNN            1 0          NBR PSN TO PMTS
043400000000    ?C                   Z-add     41            WWPSNI            2 0          PSN TO BASE IND
043500000000    ?C     WWPSNI        Add       WWPSNN        WWLMT             2 0          PSN TO IND LMT
043600000000    ?C     WWLMT         Sub       1             WWLMT                          PSN TO IND LMT
043700000000    ?C                   Movel     '*'           MSPGMQ                         MSG SFL JOB MSGQ
043800111006    ?C                   Move      *BLANKS       WSOPC             1            OPTION CODE
043900000000    ?C                   Endsr                                                  END DEFN
044000000000    ? *___________________________________________________________________
044100000000    ? * Key lists
044200000000    ? *___________________________________________________________________
044300000000    ?C     KLIST         Begsr                                                  KEY LISTS
044700000000    ?C                   Endsr                                                  END KLIST
044800000000    ? *___________________________________________________________________
044900000000    ? * Program error handler
045000000000    ? *___________________________________________________________________
045100000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
045200000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
045300000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
045400000000    ?C                   Parm                    WQSTSC                         STATUS CODE
045500000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
045600000000    ?C                   Parm                    WQMSG                          MESSAGE ID
045700000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
045800000000    ? *___________________________________________________________________
045900000000**  WAO OPTION TABLE - 30X38            |OPTION 2A, ACTION 8A, DESCRIPTION 28A |
046000000000 1SELECT  1=Select
046100000000 5DISPLAY 5=Display
046200000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION 8A, DESCR 30A   |
04630000000003EXIT    F3=Exit
04640000000005REFRESH F5=Refresh
04650000000010PMTPSN  F10=Position
04660000000012CANCEL  F12=Cancel
04670000000025ROLLUP
04680000000026ROLLDOWN
046900000000** WTM
04700000000000You have reached the top of the list.
04710000000000You have reached the bottom of the list.
04720000000000No records found.
