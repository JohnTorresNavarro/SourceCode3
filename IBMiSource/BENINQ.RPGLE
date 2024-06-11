000100111208     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*NEW)
000200111208     H option(*SRCSTMT: *NODEBUGIO)
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500040826    ? *  (c)Copyright 2004 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800121203    ?FBENINQD   CF   E             WORKSTN SFILE(LSTSFL:WFRRN) INFDS(DSPD)
000900121203    ?FBENINQP   IF   E           K DISK
001000000000    ? *_________________________________________________________________________
001100111208
001200111208      * Prototype defintions
001300111208      /COPY *LIBL/QMODSRC,#PROTO
001400111208
001500000000    ?D WAO             S             38    DIM(30) CTDATA PERRCD(1)             OPTION TABLE
001600000000    ?D WAP             S             75    DIM(6)                               OPTION DESC
001700000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001800000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001900000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
002000111021
002100111208     D #TODAY          S               D   DATFMT(*ISO)
002200111208     D W80DATE         S              8S 0
002300121203     D weff            s               d   datfmt(*iso)
002400111208     D p#              S              3S 0
002500111208
002600111208
002700000000    ? *_________________________________________________________________________
002800000407    ? * Data structure
002900111208    ?D WIDTA         E DS                  EXTNAME(MEMBER)
003000020521    ? *
003100000000    ? * Option code data structure
003200000000    ?D                 DS
003300000000    ?D  WDOPC                  1      2
003400000000    ?D  WDOPC1                 1      1
003500000000    ?D  WDOPC2                 2      2
003600000000    ? *
003700000000    ? * CURSOR LOCATION
003800000000    ?D                 DS
003900000000    ?D  WWCRSL                 1      2
004000000000    ?D  WWCRSN                 1      2B 0
004100020926    ? *
004200000000    ? * Program status data structure
004300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
004400000000    ? *
004500000000    ? * Display file data structure
004600991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
004700000000    ? *___________________________________________________________________
004800111007     C     *Entry        Plist
004900111208     C                   Parm                    WIDTA
005000111208
005100111208     C                   Eval      WIRQS = 'LOAD'
005200111208    ?C                   Movel     'I     '      WWOPV            60            OPTIONS VALID
005300111208    ?C                   Movel     'X     '      WWFKV            60            FUNCTIONS VALID
005400111021
005500000000    ? * Process list panel
005600000000B001?C     WIRQS         Ifne      'SLCNXT  '                                   IF NOT NEXT SELECT
005700000000 001?C                   Exsr      DEFN                                         DEFINE FIELDS
005800000000E001?C                   Endif                                                  ENDIF NEXT SELECT
005900000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
006000000000    ? *
006100000000B001?C     WWENDF        Downe     'END'                                        DOWHILE NOT END
006200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
006300000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
006400111208 001?C                   Exsr      PRCFKY                                       PROC FN KEYS
006500000000 001? *
006600000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
006700111021 001?C     WWFKA         Caseq     'REFRESH '    PRCRFR                         REFRESH
006800111021 001?C     WWFKA         Caseq     'PRINT   '    PRCPRT                         REFRESH
006900000000 001?C     WWFKA         Caseq     'PMTPSN  '    PRCPMT                         PMT POSITION TO
007000000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
007100000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
007200000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLLDOWN
007300000000 001?C     WWFKA         Caseq     'ENTER   '    PRCENT                         ENTER
007400000000 001?C                   Endcs                                                  END CASE
007500000000E001?C                   Enddo                                                  END DOWHILE
007600000000    ? *
007700000000    ?C                   Write     REMOVE                                       REMOVE WINDOW
007800111208     C                   Return
007900020212    ?C                   Move      *on           *inlr                          RETURN
008000000000    ? *___________________________________________________________________
008100000000    ? * Prepare list panel
008200000000    ? *___________________________________________________________________
008300000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008400020911    ***
008500000000    ?C                   Exsr      SETPSN                                       SET POSITION TO IND
008600000000    ? *
008700020212     C                   Move      *Date         #today
008800020212    ? *
008900000000B001?C     WIRQS         Ifeq      'SLCNXT'                                     IF SELECT NEXT
009000000000 001?C                   Exsr      SLCNXT                                       SELECT NEXT
009100000000X001?C                   Else                                                   ELSE
009200000000 001?C                   Exsr      PRCPSN                                       PROC POSITION TO
009300000000E001?C                   Endif                                                  END IF SELECT NEXT
009400000000    ?C                   Endsr                                                  END PRPPNL
009500000000    ? *___________________________________________________________________
009600000000    ? * Set position to screen indicators
009700000000    ? *___________________________________________________________________
009800000000    ?C     SETPSN        Begsr                                                  SET POSITION TO
009900000000B001?C     WWPSNI        Do        WWLMT         WW                             DO FOR NBR VIEWS
010000000000 001?C                   Move      '0'           *IN(WW)                        SET OFF PSN
010100000000E001?C                   Enddo                                                  END DO
010200000000    ?C     WWPSNI        Add       WWPSNP        WW                             VIEW# -> IND#
010300000000    ?C     WW            Sub       1             WW                             VIEW# -> IND#
010400000000    ?C                   Move      '1'           *IN(WW)                        DISPLAY PSN TO
010500000000    ?C                   Endsr                                                  END SETPSN
010600000000    ? *___________________________________________________________________
010700000000    ? * Display list panel
010800000000    ? *___________________________________________________________________
010900000000    ?C     DSPPNL        Begsr                                                  DISPALY PANEL
011000000000    ? *
011100000000    ? * Set OVERLAY based on last display file processed
011200000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
011300000000 001?C                   Setoff                                       35        OVERLAY OFF
011400000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
011500000000X001?C                   Else                                                   ELSE SAME PGM
011600000000 001?C                   Seton                                        35        OVERLAY ON
011700000000E001?C                   Endif                                                  END IF NEW PGM
011800000000    ? *
011900000000    ? * Write message subfile
012000000000    ?C                   Seton                                        30        SFLMSG DISPLAY
012100000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
012200000000    ? *
012300000000    ? * Write function keys
012400000000B001?C     *IN35         Ifeq      *OFF                                         IF OVERLAY OFF
012500000000 001?C                   Write     FKYDSC                                       DSP FNC KEY DSC
012600000000E001?C                   Endif                                                  END IF F KEY SET
012700000000    ? *
012800000000    ? * Set subfile control panel overrides
012900000000B001?C     WWPSNC        Ifeq      'Y'                                          IF PSN CHANGED
013000000000 001?C                   Setoff                                       36        DO NOT PUTOVR
013100000000 001?C                   Move      'N'           WWPSNC                         NOT CHANGED
013200000000X001?C                   Else                                                   ELSE
013300000000 001?C                   Seton                                        36        PUTOVR
013400000000E001?C                   Endif                                                  END IF PSN
013500000000    ? *
013600000000    ? * Set subfile control inticators
013700000000B001?C     WFRRN         Ifeq      0                                            IF SUBFILE EMPTY
013800000000 001?C                   Setoff                                       30        ERASE SUBFILE
013900000000X001?C                   Else                                                   ELSE SUBFILE
014000000000 001?C                   Seton                                        30        DISPLAY SUBFILE
014100000000E001?C                   Endif                                                  END IF SFL EMPTY
014200000000    ? *
014300000000    ? * Write subfile
014400000000    ?C                   Exfmt     LSTCTL                                       DSP LST PANEL
014500000000    ?C                   Z-add     WDLOWR        WWLOWR                         SAVE SFL RCD NBR
014600000000    ?C                   Z-add     WDLOWR        WSPAG                          SET CURRENT PAGE
014700000000    ?C                   Setoff                                       626336    RESET SCREEN CTL
014800000000    ?C                   Endsr                                                  END DSPPNL
014900000000    ? *___________________________________________________________________
015000000000    ? * Process function key pressed
015100000000    ? *___________________________________________________________________
015200000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
015300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
015400991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
015500000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
015600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
015700000000    ?C                   Parm                    WAD                            FNC DESC
015800991108    ?C                   Parm                    WWIN                           *IN
015900000000    ?C                   Parm                    WAF                            FNC KEY TABLE
016000000000    ?C                   Parm                    WWFKV                          FNC KYS ALLWD
016100000000    ?C                   Endsr                                                  END PRC FKY
016200000000    ? *___________________________________________________________________
016300000000    ? * Process EXIT function
016400000000    ? *___________________________________________________________________
016500000000    ?C     PRCEXT        Begsr                                                  PROCESS EXIT
016600000000    ?C                   Movel     WWFKA         WORTN                          SET RETURN CODE
016700000000    ?C                   Move      'END'         WWENDF                         END FNC LOOP
016800000000    ?C                   Endsr                                                  END PRCEXT
016900000000    ? *___________________________________________________________________
017000000000    ? * Process REFRESH function
017100000000    ? *___________________________________________________________________
017200000000    ?C     PRCRFR        Begsr                                                  PROCESS REFRESH
017300000000    ?C                   Exsr      PRCPSN                                       POSITION TO
017400000000B001?C     WSPAG         Dowlt     WWLOWR                                       DO WHILE NOT PRV PAG
017500000000 001?C     WWSFLE        Andne     'Y'                                          AND NOT EOF
017600000000 001?C                   Exsr      PRCRUP                                       LOAD SUBFILE
017700000000E001?C                   Enddo                                                  END DO NOT PRV PAG
017800000000    ?C                   Endsr                                                  END PRCRFR
017900111021    ? *___________________________________________________________________
018000111021    ? * Process PRINT function
018100111021    ? *___________________________________________________________________
018200111021    ?C     PRCPRT        Begsr                                                  PROCESS REFRESH
018300111021    ?C                   Endsr                                                  END PRCRFR
018400000000    ? *___________________________________________________________________
018500000000    ? * Process CANCEL function
018600000000    ? *___________________________________________________________________
018700000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
018800000000    ?C                   Movel     WWFKA         WORTN                          SET RETURN CODE
018900000000    ?C                   Move      'END'         WWENDF                         END FNC LOOP
019000000000    ?C                   Endsr                                                  END PRCCNL
019100000000    ? *___________________________________________________________________
019200000000    ? * Process POSITION TO function
019300000000    ? *___________________________________________________________________
019400000000    ?C     PRCPMT        Begsr                                                  PROCESS POSITION
019500000000    ? *
019600000000    ?C                   Move      '     '       WSFLD                          TRUNCATE FIELD
019700000000B001?C     WSFLD         Ifeq      'WSPSN'                                      IF CURSOR ON PSN
019800000000 001?C     WWPSNP        Add       1             WWPSNP                         BUMP PSN TO VIEW
019900000000B002?C     WWPSNP        Ifgt      WWPSNN                                       IF GT HIGH VIEW
020000000000 002?C                   Z-add     1             WWPSNP                         SET TO BGN VIEW
020100000000E002?C                   Endif                                                  END IF GT HIGH PSN
020200000000 001? *
020300000000 001?C                   Exsr      SETPSN                                       SET PSN TO IND
020400000000E001?C                   Endif                                                  END IF CSR ON PSN
020500000000    ? *
020600000000    ?C                   Seton                                        63        POSITION CURSOR
020700000000    ?C                   Move      'Y'           WWPSNC                         SET PSN CHANGED
020800000000    ? *
020900000000    ?C                   Endsr                                                  END PRCPMT
021000000000    ? *___________________________________________________________________
021100000000    ? * Process ROLL UP function (add a page to list subfile)
021200000000    ? *___________________________________________________________________
021300000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
021400000000    ?C                   Move      'N'           WWSFLE                         SUBFILE END
021500000000    ?C                   Z-add     WWRRN         WSPAG                          SFL PAG = LAST PAGE
021600000000    ?C                   Z-add     1             WW                             WINDOW INDEX
021700000000    ?C                   Z-add     WWRRN         WFRRN                          HIGH SFL RRN
021800000000    ?C                   Setoff                                       50        RESET EOF IND
021900000000    ?C                   Setoff                                       6061      SUBFILE SRC CTL
022000000000    ?C                   Clear                   LSTSFL                         BLANK SFL RECORD
022100000000    ? *
022200000000B001?C     WW            Dowle     WWLSTS                                       DO WHILE PAG SIZ
022300000000 001?C     *IN50         Andeq     '0'                                          AND RECORDS
022400121203 002?C     MBSSNO        Reade     BENINQP                                50    READ FILE
022500010223B002?C     *IN50         Ifeq      '0'                                          IF RECORD READ
022600111208
022700111006 002?C                   Add       1             WFRRN                          BUMP SFL RRN
022800111006 002?C                   Add       1             WW                             BUMP INDEX
022900121203     C                   Exsr      LOAD_BEN
023000100617 002?C                   Write     LSTSFL                                       WRITE SFL REC
023100000000X002?C                   Else                                                   ELSE EOF
023200000000 002?C                   Move      'Y'           WWSFLE                         SET EOF
023300000000E002?C                   Endif                                                  END IF REC READ
023400000000 001? *
023500000000E001?C                   Enddo                                                  END DO
023600111007    ? *
023700111208     C                   If        ww = 10
023800121203 002?C     MBSSNO        Reade     BENINQP                                50    READ FILE
023900111007B002?C     *IN50         Ifeq      '0'                                          IF RECORD READ
024000121203 002?C     MBSSNO        Readpe    BENINQP                                50    READ FILE
024100111007     C                   Else
024200111007 002?C                   Move      'Y'           WWSFLE                         SET EOF
024300111007     C                   End
024400111007     C                   End
024500000000    ? *
024600000000B001?C     WFRRN         Ifgt      WWRRN                                        IF RECORDS ADDED
024700000000 001?C     WWRRN         Add       1             WSPAG                          SFL PAG = 1ST NEW RC
024800000000 001?C                   Z-add     WFRRN         WWRRN                          SAVE HIGH SFL RRN
024900000000E001?C                   Endif                                                  END IF RCDS ADDED
025000000000    ? *
025100000000B001?C     WFRRN         Ifeq      0                                            IF SFL EMPTY
025200991116 001?C                   Move      WTM(3)        WWMSG                          EOF MSG
025300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
025400000000E001?C                   Endif                                                  IF SFL EMPTY
025500000000    ? *
025600000000B001?C     WWSFLE        Ifeq      'Y'                                          AT END OF FILE?
025700000000 001?C                   Move      WTM(2)        WWMSG                          EOF MSG
025800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
025900000000E001?C                   Endif                                                  END IF END OF FILE
026000111007    ? *
026100111007B001?C     WWSFLE        Ifeq      'Y'                                          AT END OF FILE?
026200111007 001?C                   Seton                                        39        SFLEND BOTTOM
026300111007X001?C                   Else                                                   ELSE
026400111007 001?C                   Setoff                                       39        SFLEND MORE...
026500111007E001?C                   Endif                                                  END IF END OF FILE
026600000000    ? *
026700111208     C                   Endsr                                                  END PRCRUP
026800111208    ? *___________________________________________________________________
026900111208    ? * Load Dep SFL
027000111208    ? *___________________________________________________________________
027100121203    ?C     LOAD_BEN      Begsr                                                  PROCESS ROLLDOWN
027200121203
027300121203     C                   Clear                   WSBEN
027400111208     C                   Clear                   WSREL
027500121203     C                   Clear                   WSEFF
027600121203     C                   Clear                   WSPER
027700121203     C                   Clear                   WSTYP
027800121203
027900121203     C                   Eval      WSBEN = %trim(BNAM)
028000121203
028100121203     C                   If        BPER > 0
028200121203     C                   Select
028300121203     C                   When      %trim(BREL) = 'RDA'
028400121203     C                   Eval      WSREL = 'Daughter'
028500121203     C                   When      %trim(BREL) = 'RWI'
028600121203     C                   Eval      WSREL = 'Wife    '
028700121203     C                   When      %trim(BREL) = 'RSO'
028800121203     C                   Eval      WSREL = 'Son     '
028900121203     C                   When      %trim(BREL) = 'RHU'
029000121203     C                   Eval      WSREL = 'Husband '
029100121203     C                   Other
029200121203     C                   Eval      WSREL = 'Other   '
029300121203     C                   Endsl
029400121203     C                   End
029500121203
029600121203     C                   eval      WSEFF = %trim(BEFF)
029700121203     C                   If        BPER > 0
029800121203     C                   Eval      WSPER = %char(BPER)
029900121203     C                   Else
030000121203     C                   Eval      WSPER = *blanks
030100121203     C                   End
030200121203     C                   Eval      WSTYP = %trim(BTYP)
030300111208
030400111208     C                   Endsr                                                  END PRCRUP
030500000000    ? *___________________________________________________________________
030600000000    ? * Process ROLLDOWN function (beginning of SFL reached)
030700000000    ? *___________________________________________________________________
030800000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
030900000000    ?C                   Z-add     1             WSPAG                          DSP 1ST PAGE
031000000000    ?C                   Move      WTM(1)        WWMSG                          BGN SFL MSG
031100000000    ?C                   Exsr      SNDMSG                                       SEND MSG
031200000000    ?C                   Endsr                                                  END PRCRDN
031300000000    ? *___________________________________________________________________
031400000000    ? * Process ENTER function
031500000000    ? *___________________________________________________________________
031600000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
031700000000    ?C                   Move      *BLANKS       WWENDO                         OPT LOOP STATE
031800000000    ?C                   Move      *BLANKS       WWRTN                          RETURN VALUE
031900000000    ?C                   Setoff                                       50        RESET EOF IND
032000000000    ? *
032100000000B001?C     WFRRN         Ifgt      0                                            IF SFL RECORDS
032200000000 001? *
032300000000B002?C     WWENDO        Downe     'END'                                        DOWHILE NOT END
032400000000 002?C     *IN50         Andne     *ON                                          AND NOT EOF
032500000000 002?C                   Readc     LSTSFL                                 50    READ CHNG SBF
032600000000 002? *
032700000000B003?C     *IN50         Ifeq      *OFF                                         IF CHANGED RECORD
032800000000 003?C     WSOPC         Andne     *BLANKS                                      AND OPTION CODE
032900000000 003?C                   Exsr      PRCSLC                                       PROCESS SELECTION
033000000000 003?C                   Exsr      PRCRTN                                       PROCESS OPT RETURN
033100000000E003?C                   Endif                                                  END IF SELECTION
033200000000E002?C                   Enddo                                                  END DO WHILE NOT END
033300000000E001?C                   Endif                                                  END IF SFL RCDS
033400000000    ? *
033500000000B001?C     *IN38         Ifeq      *ON                                          IF PSN CHANGED
033600000000 001?C     WWENDO        Andne     'END   '                                     AND NOT ERROR
033700000000B002?C     WWPSNP        Ifeq      1                                            IF PSN VIEW 1
033800111006 002?C*                  Movel     WSPSN1        WWPSN1           20            SAVE PSN TO
033900000000E002?C                   Endif                                                  IF PSN VIEW 1
034000000000 001?C                   Exsr      PRCPSN                                       PROC POSTN TO
034100000000E001?C                   Endif                                                  IF PSN PMT
034200000000    ?C                   Endsr                                                  END PRCENT
034300000000    ? *___________________________________________________________________
034400000000    ? * Receive messages from a data queue and send to program queue
034500000000    ? *___________________________________________________________________
034600000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
034700000000    ?C                   Movea     *IN           WWIN                           INDICATORS
034800000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
034900000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST MSG DSP
035000000000    ?C                   Parm                    WWIN                           INDICATORS
035100000000    ?C                   Parm                    WWRTN                          RETURN CODE
035200000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
035300000000    ?C                   Endsr                                                  END RCV MSG
035400000000    ? *___________________________________________________________________
035500000000    ? * Clear list subfile
035600000000    ? *___________________________________________________________________
035700000000    ?C     CLRSFL        Begsr                                                  CLEAR SUBFILE
035800000000    ?C                   Seton                                        31        CLEAR SUBFILE
035900000000    ?C                   Write     LSTCTL                                       CLEAR SUBFILE
036000000000    ?C                   Setoff                                       31        CLEAR SUBFILE
036100000000    ?C                   Z-add     0             WSPAG                          SLF PAGE
036200000000    ?C                   Z-add     0             WFRRN                          SFL RRN
036300000000    ?C                   Z-add     0             WWRRN                          HIGH SFL RRN
036400000000    ?C                   Endsr                                                  END CLEAR SFL
036500000000    ? *___________________________________________________________________
036600000000    ? * Process SLCNXT Request
036700000000    ? *___________________________________________________________________
036800000000    ?C     SLCNXT        Begsr                                                  SELECT NEXT
036900000000    ?C                   Movel     'ERROR'       WORTN                          SET RETURN CODE
037000000000    ?C                   Move      *BLANKS       WWENDO                         LOOP END OPTION
037100000000B001?C     WFRRN         Ifgt      0                                            IF SFL RECORDS
037200000000 001? *
037300000000B002?C     WWENDO        Downe     'END'                                        DOWHILE NOT END
037400000000 002?C                   Readc     LSTSFL                                 50    READ CHNG SBF
037500000000 002? *
037600000000B003?C     *IN50         Ifeq      *OFF                                         IF CHANGED RECORD
037700000000B004?C     WSOPC         Ifne      *BLANKS                                      IF OPTION CODE
037800000000 004?C                   Exsr      PRCOPT                                       PROCESS OPTION
037900000000B005?C     WWOPA         Ifeq      'SELECT'                                     IF SELECT
038000000000 005?C                   Exsr      PRCSEL                                       PROCESS SELECT
038100000000E005?C                   Endif                                                  END IF SELECT
038200000000E004?C                   Endif                                                  END IF OPTION CODE
038300000000 003? *
038400000000X003?C                   Else                                                   ELSE
038500000000 003?C                   Movel     'END'         WWENDO                         END OPTIONS
038600000000E003?C                   Endif                                                  END IF CHG RCD
038700000000E002?C                   Enddo                                                  END DO WHILE NOT END
038800000000E001?C                   Endif                                                  END IF SFL RCDS
038900000000    ? *
039000000000    ?C                   Move      'END'         WWENDF                         END PGM LOOP
039100000000    ?C                   Endsr                                                  END SLCNXT
039200000000    ? *___________________________________________________________________
039300000000    ? * Process option selected
039400000000    ? *___________________________________________________________________
039500000000    ?C     PRCOPT        Begsr                                                  PROCESS OPTION
039600000000    ?C                   Move      *BLANKS       WWRQS                          CLEAR RQS FLD
039700000000    ?C                   Move      WSOPC         WDOPC                          BLD OPTION CODE
039800000000    ? *
039900000000    ?C                   Call      'PRCOPT2'                                    PROCESS OPTIONS
040000000000    ?C                   Parm      WDOPC         WWRQS                          DISPLAY REQUEST
040100000000    ?C     WWOPA         Parm                    WWRTN                          RETURN CODE
040200000000    ?C                   Parm                    WAP                            OPTION DESC
040300000000    ?C                   Parm                    WAO                            OPTION TAPLE
040400000000    ?C                   Parm                    WWOPV                          OPTIONS ALLOWED
040500000000    ?C                   Endsr                                                  END PRCOPT
040600000000    ? *___________________________________________________________________
040700000000    ? * Process selection
040800000000    ? *___________________________________________________________________
040900000000    ?C     PRCSLC        Begsr                                                  PROCESS SELECTION
041000000000    ?C                   Exsr      PRCOPT                                       PROCESS OPTION
041100000000    ?C     WWOPA         Caseq     'DISPLAY'     PRCDSP                         DISPLAY
041200000000    ?C     WWOPA         Caseq     'SELECT'      PRCSEL                         SELECT
041300000000    ?C                   Endcs                                                  END CASE
041400000000    ?C                   Endsr                                                  END PRCSLC
041500000000    ? *___________________________________________________________________
041600000000    ? * Process SELECT Option
041700000000    ? *___________________________________________________________________
041800000000    ?C     PRCSEL        Begsr                                                  PROCESS SELECT
041900000000    ?C                   Move      'END'         WWENDO                         END OPT LOOP
042000000000    ?C                   Move      'END'         WWENDF                         END PGM LOOP
042100000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
042200000000    ?C                   Endsr                                                  END PRCSEL
042300000000    ? *___________________________________________________________________
042400000000    ? * Process DISPLAY option
042500000000    ? *___________________________________________________________________
042600000000    ?C     PRCDSP        Begsr                                                  DISPLAY
042700000000    ?C                   Endsr                                                  END PRC DSPL
042800000000    ? *___________________________________________________________________
042900000000    ? * Process option Return
043000000000    ? *___________________________________________________________________
043100000000    ?C     PRCRTN        Begsr                                                  PROCESS OPT RTN
043200000000    ? *
043300000000B001?C     WWRTN         Ifeq      'ERROR '                                     IF RTN ERROR
043400000000 001?C                   Seton                                        60        REVERSE IMAGE OPT
043500000000 001?C                   Movel     'END   '      WWENDO                         END PROCESSING
043600000000X001?C                   Else                                                   ELSE
043700000000 001?C                   Setoff                                       60        NO REVERSE IMAGE
043800000000 001?C                   Move      *BLANKS       WSOPC                          CLEAR OPTION
043900000000E001?C                   Endif                                                  ENDIF ERROR
044000000000    ? *
044100000000B001?C     WWRTN         Ifeq      'CANCEL'                                     IF CANCEL
044200000000 001?C                   Movel     'END   '      WWENDO                         END PROCESSING
044300000000E001?C                   Endif                                                  END IF EXIT/CANCEL
044400000000    ? *
044500000000    ?C                   Update    LSTSFL                                       UPDATE SFL
044600000000    ?C                   Z-add     WFRRN         WSPAG                          SET SFL PAGE
044700000000    ?C                   Endsr                                                  END PRCRTN
044800000000    ? *___________________________________________________________________
044900000000    ? * Process POSITION TO option
045000000000    ? *___________________________________________________________________
045100000000    ?C     PRCPSN        Begsr                                                  POSITION TO
045200121203 001?C     MBSSNO        Setll     BENINQP                                      PSN DB CURSOR
045300000000    ?C                   Exsr      CLRSFL                                       CLEAR SUBFILE
045400000000    ?C                   Exsr      PRCRUP                                       LOAD SUBFILE
045500000000    ?C                   Move      'Y'           WWPSNC                         SET PSN CHANGED
045600000000    ?C                   Endsr                                                  END POSITION TO
045700000000    ? *___________________________________________________________________
045800000000    ? * Send message
045900000000    ? *___________________________________________________________________
046000000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
046100000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
046200000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
046300000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
046400000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
046500000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
046600000000    ?C                   Endsr                                                  END PROC FNC
046700000000    ? *___________________________________________________________________
046800000000    ? * Parameter lists
046900000000    ? *___________________________________________________________________
047000000000    ?C     PLIST         Begsr                                                  PARM LISTS
047100111006    ?C     KEYFAKE       Klist                                                  *ENTRY LIST
047200111006    ?C                   kfld                    WIRQS             8            PROGRAM REQUEST
047300111006    ?C                   kfld                    WORTN             8            RETURN CODE
047400111006    ?C                   kfld                    WUPGM            10            LAST PGM NAME
047500111208    ?C                   kfld                    WIDTA                          RECORD DS
047600000000    ?C                   Endsr
047700000000    ? *___________________________________________________________________
047800000000    ? * Define Variables
047900000000    ? *___________________________________________________________________
048000000000    ?C     DEFN          Begsr                                                  DEFINITIONS
048100000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST CODE
048200000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
048300000000    ?C                   Move      *BLANKS       WWOPV            60            OPTIONS VALID
048400000000    ?C                   Move      *BLANKS       WWFKV            60            FUNCTIONS VALID
048500000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
048600000000    ?C                   Move      *BLANKS       WWFKA             8            FUNCTION ACTION
048700000000    ?C                   Move      *BLANKS       WWENDF            3            FUNCTION CONTROL
048800000000    ?C                   Move      *BLANKS       WWOPA             8            OPTION ACTION
048900000000    ?C                   Move      *BLANKS       WWENDO            3            OPTION CONTROL
049000000000    ?C                   Move      'N'           WWSFLE            1            SUBFILE END
049100000000    ?C                   Z-add     0             WWLOWR            4 0          SUB FILE LOW REL REC
049200000000    ?C                   Z-add     0             WW                3 0          ARRAY  INDEX
049300111021    ?C                   Z-add     14            WWLSTS            2 0          LST SFL PAG SIZ
049400000000    ?C                   Z-add     0             WFRRN             4 0          LST SFL RRN
049500000000    ?C                   Z-add     0             WWRRN             4 0          LST SFL HIGH RRN
049600990824    ?C                   Z-add     1             WWPSNP            1 0          POSITION TO VIEW#
049700000000    ?C                   Move      'Y'           WWPSNC            1            POSITION TO CHANGED
049800990824    ?C                   Z-add     1             WWPSNN            1 0          NBR PSN TO PMTS
049900000000    ?C                   Z-add     41            WWPSNI            2 0          PSN TO BASE IND
050000000000    ?C     WWPSNI        Add       WWPSNN        WWLMT             2 0          PSN TO IND LMT
050100000000    ?C     WWLMT         Sub       1             WWLMT                          PSN TO IND LMT
050200000000    ?C                   Movel     '*'           MSPGMQ                         MSG SFL JOB MSGQ
050300111006    ?C                   Move      *BLANKS       WSOPC             1            OPTION CODE
050400000000    ?C                   Endsr                                                  END DEFN
050500000000    ? *___________________________________________________________________
050600000000    ? * Key lists
050700000000    ? *___________________________________________________________________
050800000000    ?C     KLIST         Begsr                                                  KEY LISTS
050900000000    ?C                   Endsr                                                  END KLIST
051000000000    ? *___________________________________________________________________
051100000000    ? * Program error handler
051200000000    ? *___________________________________________________________________
051300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
051400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
051500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
051600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
051700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
051800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
051900000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
052000000000    ? *___________________________________________________________________
052100000000**  WAO OPTION TABLE - 30X38            |OPTION 2A, ACTION 8A, DESCRIPTION 28A |
052200000000 1SELECT  1=Select
052300000000 5DISPLAY 5=Display
052400000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION 8A, DESCR 30A   |
05250000000003EXIT    F3=Exit
05260000000025ROLLUP
05270000000026ROLLDOWN
052800000000** WTM
05290000000000You have reached the top of the list.
05300000000000You have reached the bottom of the list.
05310011102100No records found.
05320011120800
