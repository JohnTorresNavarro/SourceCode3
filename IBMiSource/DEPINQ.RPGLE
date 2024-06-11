000100111208     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*NEW)
000200111208     H option(*SRCSTMT: *NODEBUGIO)
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500040826    ? *  (c)Copyright 2004 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800111208    ?FDEPINQD   CF   E             WORKSTN SFILE(LSTSFL:WFRRN) INFDS(DSPD)
000900130123    ?FDEPENDQTMPIF   E           K DISK    RENAME(DEPENR:DEPDNTR)
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
002300111208     D p#              S              3S 0
002400111208
002500111208     d  DepCovg      e ds          1475    extname(webdcov)
002600111208     d  dpln                   1    100a   dim(25) inz
002700111208     d  dcat                 101    175a   dim(25) inz
002800111208     d  ddsc                 176   1175a   dim(25) inz
002900111208     d  deff                1176   1425d   dim(25) inz datfmt(*usa)
003000111208     d  dcsq                1426   1475s 0 dim(25) inz
003100111208
003200000000    ? *_________________________________________________________________________
003300000407    ? * Data structure
003400111208    ?D WIDTA         E DS                  EXTNAME(MEMBER)
003500020521    ? *
003600000000    ? * Option code data structure
003700000000    ?D                 DS
003800000000    ?D  WDOPC                  1      2
003900000000    ?D  WDOPC1                 1      1
004000000000    ?D  WDOPC2                 2      2
004100000000    ? *
004200000000    ? * CURSOR LOCATION
004300000000    ?D                 DS
004400000000    ?D  WWCRSL                 1      2
004500000000    ?D  WWCRSN                 1      2B 0
004600020926    ? *
004700000000    ? * Program status data structure
004800991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
004900000000    ? *
005000000000    ? * Display file data structure
005100991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
005200000000    ? *___________________________________________________________________
005300111007     C     *Entry        Plist
005400111208     C                   Parm                    WIDTA
005500111208
005600111208     C                   Eval      WIRQS = 'LOAD'
005700111208    ?C                   Movel     'I     '      WWOPV            60            OPTIONS VALID
005800111208    ?C                   Movel     'X     '      WWFKV            60            FUNCTIONS VALID
005900111021
006000000000    ? * Process list panel
006100000000B001?C     WIRQS         Ifne      'SLCNXT  '                                   IF NOT NEXT SELECT
006200000000 001?C                   Exsr      DEFN                                         DEFINE FIELDS
006300000000E001?C                   Endif                                                  ENDIF NEXT SELECT
006400000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
006500000000    ? *
006600000000B001?C     WWENDF        Downe     'END'                                        DOWHILE NOT END
006700000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
006800000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
006900111208 001?C                   Exsr      PRCFKY                                       PROC FN KEYS
007000000000 001? *
007100000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
007200111021 001?C     WWFKA         Caseq     'REFRESH '    PRCRFR                         REFRESH
007300111021 001?C     WWFKA         Caseq     'PRINT   '    PRCPRT                         REFRESH
007400000000 001?C     WWFKA         Caseq     'PMTPSN  '    PRCPMT                         PMT POSITION TO
007500000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
007600000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
007700000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLLDOWN
007800000000 001?C     WWFKA         Caseq     'ENTER   '    PRCENT                         ENTER
007900000000 001?C                   Endcs                                                  END CASE
008000000000E001?C                   Enddo                                                  END DOWHILE
008100000000    ? *
008200000000    ?C                   Write     REMOVE                                       REMOVE WINDOW
008300111208     C                   Return
008400020212    ?C                   Move      *on           *inlr                          RETURN
008500000000    ? *___________________________________________________________________
008600000000    ? * Prepare list panel
008700000000    ? *___________________________________________________________________
008800000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008900020911    ***
009000000000    ?C                   Exsr      SETPSN                                       SET POSITION TO IND
009100000000    ? *
009200020212     C                   Move      *Date         #today
009300020212    ? *
009400000000B001?C     WIRQS         Ifeq      'SLCNXT'                                     IF SELECT NEXT
009500000000 001?C                   Exsr      SLCNXT                                       SELECT NEXT
009600000000X001?C                   Else                                                   ELSE
009700000000 001?C                   Exsr      PRCPSN                                       PROC POSITION TO
009800000000E001?C                   Endif                                                  END IF SELECT NEXT
009900000000    ?C                   Endsr                                                  END PRPPNL
010000000000    ? *___________________________________________________________________
010100000000    ? * Set position to screen indicators
010200000000    ? *___________________________________________________________________
010300000000    ?C     SETPSN        Begsr                                                  SET POSITION TO
010400000000B001?C     WWPSNI        Do        WWLMT         WW                             DO FOR NBR VIEWS
010500000000 001?C                   Move      '0'           *IN(WW)                        SET OFF PSN
010600000000E001?C                   Enddo                                                  END DO
010700000000    ?C     WWPSNI        Add       WWPSNP        WW                             VIEW# -> IND#
010800000000    ?C     WW            Sub       1             WW                             VIEW# -> IND#
010900000000    ?C                   Move      '1'           *IN(WW)                        DISPLAY PSN TO
011000000000    ?C                   Endsr                                                  END SETPSN
011100000000    ? *___________________________________________________________________
011200000000    ? * Display list panel
011300000000    ? *___________________________________________________________________
011400000000    ?C     DSPPNL        Begsr                                                  DISPALY PANEL
011500000000    ? *
011600000000    ? * Set OVERLAY based on last display file processed
011700000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
011800000000 001?C                   Setoff                                       35        OVERLAY OFF
011900000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
012000000000X001?C                   Else                                                   ELSE SAME PGM
012100000000 001?C                   Seton                                        35        OVERLAY ON
012200000000E001?C                   Endif                                                  END IF NEW PGM
012300000000    ? *
012400000000    ? * Write message subfile
012500000000    ?C                   Seton                                        30        SFLMSG DISPLAY
012600000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
012700000000    ? *
012800000000    ? * Write function keys
012900000000B001?C     *IN35         Ifeq      *OFF                                         IF OVERLAY OFF
013000000000 001?C                   Write     FKYDSC                                       DSP FNC KEY DSC
013100000000E001?C                   Endif                                                  END IF F KEY SET
013200000000    ? *
013300000000    ? * Set subfile control panel overrides
013400000000B001?C     WWPSNC        Ifeq      'Y'                                          IF PSN CHANGED
013500000000 001?C                   Setoff                                       36        DO NOT PUTOVR
013600000000 001?C                   Move      'N'           WWPSNC                         NOT CHANGED
013700000000X001?C                   Else                                                   ELSE
013800000000 001?C                   Seton                                        36        PUTOVR
013900000000E001?C                   Endif                                                  END IF PSN
014000000000    ? *
014100000000    ? * Set subfile control inticators
014200000000B001?C     WFRRN         Ifeq      0                                            IF SUBFILE EMPTY
014300000000 001?C                   Setoff                                       30        ERASE SUBFILE
014400000000X001?C                   Else                                                   ELSE SUBFILE
014500000000 001?C                   Seton                                        30        DISPLAY SUBFILE
014600000000E001?C                   Endif                                                  END IF SFL EMPTY
014700000000    ? *
014800000000    ? * Write subfile
014900000000    ?C                   Exfmt     LSTCTL                                       DSP LST PANEL
015000000000    ?C                   Z-add     WDLOWR        WWLOWR                         SAVE SFL RCD NBR
015100000000    ?C                   Z-add     WDLOWR        WSPAG                          SET CURRENT PAGE
015200000000    ?C                   Setoff                                       626336    RESET SCREEN CTL
015300000000    ?C                   Endsr                                                  END DSPPNL
015400000000    ? *___________________________________________________________________
015500000000    ? * Process function key pressed
015600000000    ? *___________________________________________________________________
015700000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
015800991108    ?C                   Movea     *IN           WWIN                           INDICATORS
015900991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
016000000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
016100000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
016200000000    ?C                   Parm                    WAD                            FNC DESC
016300991108    ?C                   Parm                    WWIN                           *IN
016400000000    ?C                   Parm                    WAF                            FNC KEY TABLE
016500000000    ?C                   Parm                    WWFKV                          FNC KYS ALLWD
016600000000    ?C                   Endsr                                                  END PRC FKY
016700000000    ? *___________________________________________________________________
016800000000    ? * Process EXIT function
016900000000    ? *___________________________________________________________________
017000000000    ?C     PRCEXT        Begsr                                                  PROCESS EXIT
017100000000    ?C                   Movel     WWFKA         WORTN                          SET RETURN CODE
017200000000    ?C                   Move      'END'         WWENDF                         END FNC LOOP
017300000000    ?C                   Endsr                                                  END PRCEXT
017400000000    ? *___________________________________________________________________
017500000000    ? * Process REFRESH function
017600000000    ? *___________________________________________________________________
017700000000    ?C     PRCRFR        Begsr                                                  PROCESS REFRESH
017800000000    ?C                   Exsr      PRCPSN                                       POSITION TO
017900000000B001?C     WSPAG         Dowlt     WWLOWR                                       DO WHILE NOT PRV PAG
018000000000 001?C     WWSFLE        Andne     'Y'                                          AND NOT EOF
018100000000 001?C                   Exsr      PRCRUP                                       LOAD SUBFILE
018200000000E001?C                   Enddo                                                  END DO NOT PRV PAG
018300000000    ?C                   Endsr                                                  END PRCRFR
018400111021    ? *___________________________________________________________________
018500111021    ? * Process PRINT function
018600111021    ? *___________________________________________________________________
018700111021    ?C     PRCPRT        Begsr                                                  PROCESS REFRESH
018800111021    ?C                   Endsr                                                  END PRCRFR
018900000000    ? *___________________________________________________________________
019000000000    ? * Process CANCEL function
019100000000    ? *___________________________________________________________________
019200000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
019300000000    ?C                   Movel     WWFKA         WORTN                          SET RETURN CODE
019400000000    ?C                   Move      'END'         WWENDF                         END FNC LOOP
019500000000    ?C                   Endsr                                                  END PRCCNL
019600000000    ? *___________________________________________________________________
019700000000    ? * Process POSITION TO function
019800000000    ? *___________________________________________________________________
019900000000    ?C     PRCPMT        Begsr                                                  PROCESS POSITION
020000000000    ? *
020100000000    ?C                   Move      '     '       WSFLD                          TRUNCATE FIELD
020200000000B001?C     WSFLD         Ifeq      'WSPSN'                                      IF CURSOR ON PSN
020300000000 001?C     WWPSNP        Add       1             WWPSNP                         BUMP PSN TO VIEW
020400000000B002?C     WWPSNP        Ifgt      WWPSNN                                       IF GT HIGH VIEW
020500000000 002?C                   Z-add     1             WWPSNP                         SET TO BGN VIEW
020600000000E002?C                   Endif                                                  END IF GT HIGH PSN
020700000000 001? *
020800000000 001?C                   Exsr      SETPSN                                       SET PSN TO IND
020900000000E001?C                   Endif                                                  END IF CSR ON PSN
021000000000    ? *
021100000000    ?C                   Seton                                        63        POSITION CURSOR
021200000000    ?C                   Move      'Y'           WWPSNC                         SET PSN CHANGED
021300000000    ? *
021400000000    ?C                   Endsr                                                  END PRCPMT
021500000000    ? *___________________________________________________________________
021600000000    ? * Process ROLL UP function (add a page to list subfile)
021700000000    ? *___________________________________________________________________
021800000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
021900000000    ?C                   Move      'N'           WWSFLE                         SUBFILE END
022000000000    ?C                   Z-add     WWRRN         WSPAG                          SFL PAG = LAST PAGE
022100000000    ?C                   Z-add     1             WW                             WINDOW INDEX
022200000000    ?C                   Z-add     WWRRN         WFRRN                          HIGH SFL RRN
022300000000    ?C                   Setoff                                       50        RESET EOF IND
022400000000    ?C                   Setoff                                       6061      SUBFILE SRC CTL
022500000000    ?C                   Clear                   LSTSFL                         BLANK SFL RECORD
022600000000    ? *
022700000000B001?C     WW            Dowle     WWLSTS                                       DO WHILE PAG SIZ
022800000000 001?C     *IN50         Andeq     '0'                                          AND RECORDS
022900130123 002?C     MBSSNO        Reade     DEPENDQTMP                             50    READ FILE
023000010223B002?C     *IN50         Ifeq      '0'                                          IF RECORD READ
023100111208     C                   If        DPDLTD <> 'C'
023200111208
023300111006 002?C                   Add       1             WFRRN                          BUMP SFL RRN
023400111006 002?C                   Add       1             WW                             BUMP INDEX
023500111208     C                   Exsr      LOAD_DEP
023600111208
023700100617 002?C                   Write     LSTSFL                                       WRITE SFL REC
023800111208     C                   End
023900000000X002?C                   Else                                                   ELSE EOF
024000000000 002?C                   Move      'Y'           WWSFLE                         SET EOF
024100000000E002?C                   Endif                                                  END IF REC READ
024200000000 001? *
024300000000E001?C                   Enddo                                                  END DO
024400111007    ? *
024500111208     C                   If        ww = 10
024600130123 002?C     MBSSNO        Reade     DEPENDQTMP                             50    READ FILE
024700111007B002?C     *IN50         Ifeq      '0'                                          IF RECORD READ
024800130123 002?C     MBSSNO        Readpe    DEPENDQTMP                             50    READ FILE
024900111007     C                   Else
025000111007 002?C                   Move      'Y'           WWSFLE                         SET EOF
025100111007     C                   End
025200111007     C                   End
025300000000    ? *
025400000000B001?C     WFRRN         Ifgt      WWRRN                                        IF RECORDS ADDED
025500000000 001?C     WWRRN         Add       1             WSPAG                          SFL PAG = 1ST NEW RC
025600000000 001?C                   Z-add     WFRRN         WWRRN                          SAVE HIGH SFL RRN
025700000000E001?C                   Endif                                                  END IF RCDS ADDED
025800000000    ? *
025900000000B001?C     WFRRN         Ifeq      0                                            IF SFL EMPTY
026000991116 001?C                   Move      WTM(3)        WWMSG                          EOF MSG
026100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
026200000000E001?C                   Endif                                                  IF SFL EMPTY
026300000000    ? *
026400000000B001?C     WWSFLE        Ifeq      'Y'                                          AT END OF FILE?
026500000000 001?C                   Move      WTM(2)        WWMSG                          EOF MSG
026600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
026700000000E001?C                   Endif                                                  END IF END OF FILE
026800111007    ? *
026900111007B001?C     WWSFLE        Ifeq      'Y'                                          AT END OF FILE?
027000111007 001?C                   Seton                                        39        SFLEND BOTTOM
027100111007X001?C                   Else                                                   ELSE
027200111007 001?C                   Setoff                                       39        SFLEND MORE...
027300111007E001?C                   Endif                                                  END IF END OF FILE
027400000000    ? *
027500111208     C                   Endsr                                                  END PRCRUP
027600111208    ? *___________________________________________________________________
027700111208    ? * Load Dep SFL
027800111208    ? *___________________________________________________________________
027900111208    ?C     LOAD_DEP      Begsr                                                  PROCESS ROLLDOWN
028000111208     C                   Clear                   WSNAM
028100111208     C                   Clear                   WSREL
028200111208     C                   Clear                   WSDOB
028300111208     C                   Clear                   WSEFF
028400111208     C                   Clear                   WSCOV
028500111208     C                   If        %trim(DMI) <> *blanks
028600111208     C                   Eval      WSNAM = %trim(DFNAME) + ' ' +
028700111208     C                                     %trim(DMI) + ' ' +
028800111208     C                                     %trim(DLNAME)
028900111208     C                   Else
029000111208     C                   Eval      WSNAM = %trim(DFNAME) + ' ' +
029100111208     C                                     %trim(DLNAME)
029200111208     C                   End
029300111208     C                   Select
029400111208     C                   When      %trim(DRELCD) = 'RDA'
029500111208     C                   Eval      WSREL = 'DAUGHTER'
029600111208     C                   When      %trim(DRELCD) = 'RWI'
029700111208     C                   Eval      WSREL = 'WIFE    '
029800111208     C                   When      %trim(DRELCD) = 'RSO'
029900111208     C                   Eval      WSREL = 'SON     '
030000111208     C                   When      %trim(DRELCD) = 'RHU'
030100111208     C                   Eval      WSREL = 'HUSBAND '
030200111208     C                   Other
030300111208     C                   Eval      WSREL = 'OTHER   '
030400111208     C                   Endsl
030500111208     C     DBIRTH        Mult      10000.0001    WSDOB
030600111208
030700111208     C                   Clear                   DepCovg
030800111208     C                   Clear                   w80date
030900111208     C                   Clear                   WWMED            10
031000111208     C                   Clear                   WWDEN            10
031100111208     C                   Clear                   WWVIS            10
031200111208     C                   Eval      DepCovg = #sfldcov(MBSSNO:DPSEQ#:MBTRST:
031300111208     C                                       MBSUB#:MBACCT:'N':'N')
031400111208     C                   Eval      p# = 1
031500111208     C                   If        dpln(p#) <> *blanks
031600111208     C                   Dow       dpln(p#) <> *blanks
031700111208     C                   If        dpln(p#) <> 'XXXX'
031800111208
031900111208     C                   Select
032000111208     C                   When      dcat(p#) = 'PMM'
032100111208     C                   Eval      WWMED = 'MEDICAL'
032200111208     C                   Eval      w80date = #get80i(deff(p#))
032300111208     C                   When      dcat(p#) = 'PDR'
032400111208     C                   Eval      WWDEN = 'DENTAL '
032500111208     C                   When      dcat(p#) = 'PDN'
032600111208     C                   Eval      WWDEN = 'DENTAL '
032700111208     C                   When      dcat(p#) = 'PVR'
032800111208     C                   Eval      WWVIS = 'VISION '
032900111208     C                   When      dcat(p#) = 'PVS'
033000111208     C                   Eval      WWVIS = 'VISION '
033100111208     C                   Endsl
033200111208
033300111208     C                   If        w80date = 0
033400111208     C                   Eval      w80date = #get80i(deff(p#))
033500111208     C                   End
033600111208
033700111208     C                   End
033800111208     C                   Eval      p# = p# + 1
033900111208     C                   Enddo
034000111208     C                   End
034100111208
034200111208     C                   Select
034300111208     C                   When      %trim(WWMED) <> *blanks  and
034400111208     C                             %trim(WWDEN) <> *blanks  and
034500111208     C                             %trim(WWVIS) <> *blanks
034600111208     C                   Eval      WSCOV = %trim(WWMED) + '\' +
034700111208     C                                     %trim(WWDEN) + '\' +
034800111208     C                                     %trim(WWVIS)
034900111208     C                   When      %trim(WWMED) <> *blanks  and
035000111208     C                             %trim(WWDEN) <> *blanks  and
035100111208     C                             %trim(WWVIS) =  *blanks
035200111208     C                   Eval      WSCOV = %trim(WWMED) + '\' +
035300111208     C                                     %trim(WWDEN)
035400111208     C                   When      %trim(WWMED) <> *blanks  and
035500111208     C                             %trim(WWDEN) =  *blanks  and
035600111208     C                             %trim(WWVIS) <> *blanks
035700111208     C                   Eval      WSCOV = %trim(WWMED) + '\' +
035800111208     C                                     %trim(WWVIS)
035900111208     C                   When      %trim(WWMED) <> *blanks  and
036000111208     C                             %trim(WWDEN) =  *blanks  and
036100111208     C                             %trim(WWVIS) =  *blanks
036200111208     C                   Eval      WSCOV = %trim(WWMED)
036300111208     C                   When      %trim(WWMED) =  *blanks  and
036400111208     C                             %trim(WWDEN) <> *blanks  and
036500111208     C                             %trim(WWVIS) <> *blanks
036600111208     C                   Eval      WSCOV = %trim(WWDEN) + '\' +
036700111208     C                                     %trim(WWVIS)
036800111208     C                   When      %trim(WWMED) =  *blanks  and
036900111208     C                             %trim(WWDEN) <> *blanks  and
037000111208     C                             %trim(WWVIS) =  *blanks
037100111208     C                   Eval      WSCOV = %trim(WWDEN)
037200111208     C                   When      %trim(WWMED) =  *blanks  and
037300111208     C                             %trim(WWDEN) =  *blanks  and
037400111208     C                             %trim(WWVIS) <> *blanks
037500111208     C                   Eval      WSCOV = %trim(WWVIS)
037600111208     C                   Endsl
037700111208
037800120109     C                   If        W80date <> 0
037900120109     C                   Eval      *in75 = *off
038000111208     C     W80date       Mult      10000.0001    WSEFF
038100120109     C                   Else
038200120109     C                   Eval      *in75 = *on
038300120109     C                   End
038400120109
038500120109     C                   If        %trim(WSCOV) = *blanks
038600120109     C                   Eval      WSCOV = 'Not Enrolled'
038700120109     C                   End
038800111208
038900111208     C                   Endsr                                                  END PRCRUP
039000000000    ? *___________________________________________________________________
039100000000    ? * Process ROLLDOWN function (beginning of SFL reached)
039200000000    ? *___________________________________________________________________
039300000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
039400000000    ?C                   Z-add     1             WSPAG                          DSP 1ST PAGE
039500000000    ?C                   Move      WTM(1)        WWMSG                          BGN SFL MSG
039600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
039700000000    ?C                   Endsr                                                  END PRCRDN
039800000000    ? *___________________________________________________________________
039900000000    ? * Process ENTER function
040000000000    ? *___________________________________________________________________
040100000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
040200000000    ?C                   Move      *BLANKS       WWENDO                         OPT LOOP STATE
040300000000    ?C                   Move      *BLANKS       WWRTN                          RETURN VALUE
040400000000    ?C                   Setoff                                       50        RESET EOF IND
040500000000    ? *
040600000000B001?C     WFRRN         Ifgt      0                                            IF SFL RECORDS
040700000000 001? *
040800000000B002?C     WWENDO        Downe     'END'                                        DOWHILE NOT END
040900000000 002?C     *IN50         Andne     *ON                                          AND NOT EOF
041000000000 002?C                   Readc     LSTSFL                                 50    READ CHNG SBF
041100000000 002? *
041200000000B003?C     *IN50         Ifeq      *OFF                                         IF CHANGED RECORD
041300000000 003?C     WSOPC         Andne     *BLANKS                                      AND OPTION CODE
041400000000 003?C                   Exsr      PRCSLC                                       PROCESS SELECTION
041500000000 003?C                   Exsr      PRCRTN                                       PROCESS OPT RETURN
041600000000E003?C                   Endif                                                  END IF SELECTION
041700000000E002?C                   Enddo                                                  END DO WHILE NOT END
041800000000E001?C                   Endif                                                  END IF SFL RCDS
041900000000    ? *
042000000000B001?C     *IN38         Ifeq      *ON                                          IF PSN CHANGED
042100000000 001?C     WWENDO        Andne     'END   '                                     AND NOT ERROR
042200000000B002?C     WWPSNP        Ifeq      1                                            IF PSN VIEW 1
042300111006 002?C*                  Movel     WSPSN1        WWPSN1           20            SAVE PSN TO
042400000000E002?C                   Endif                                                  IF PSN VIEW 1
042500000000 001?C                   Exsr      PRCPSN                                       PROC POSTN TO
042600000000E001?C                   Endif                                                  IF PSN PMT
042700000000    ?C                   Endsr                                                  END PRCENT
042800000000    ? *___________________________________________________________________
042900000000    ? * Receive messages from a data queue and send to program queue
043000000000    ? *___________________________________________________________________
043100000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
043200000000    ?C                   Movea     *IN           WWIN                           INDICATORS
043300000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
043400000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST MSG DSP
043500000000    ?C                   Parm                    WWIN                           INDICATORS
043600000000    ?C                   Parm                    WWRTN                          RETURN CODE
043700000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
043800000000    ?C                   Endsr                                                  END RCV MSG
043900000000    ? *___________________________________________________________________
044000000000    ? * Clear list subfile
044100000000    ? *___________________________________________________________________
044200000000    ?C     CLRSFL        Begsr                                                  CLEAR SUBFILE
044300000000    ?C                   Seton                                        31        CLEAR SUBFILE
044400000000    ?C                   Write     LSTCTL                                       CLEAR SUBFILE
044500000000    ?C                   Setoff                                       31        CLEAR SUBFILE
044600000000    ?C                   Z-add     0             WSPAG                          SLF PAGE
044700000000    ?C                   Z-add     0             WFRRN                          SFL RRN
044800000000    ?C                   Z-add     0             WWRRN                          HIGH SFL RRN
044900000000    ?C                   Endsr                                                  END CLEAR SFL
045000000000    ? *___________________________________________________________________
045100000000    ? * Process SLCNXT Request
045200000000    ? *___________________________________________________________________
045300000000    ?C     SLCNXT        Begsr                                                  SELECT NEXT
045400000000    ?C                   Movel     'ERROR'       WORTN                          SET RETURN CODE
045500000000    ?C                   Move      *BLANKS       WWENDO                         LOOP END OPTION
045600000000B001?C     WFRRN         Ifgt      0                                            IF SFL RECORDS
045700000000 001? *
045800000000B002?C     WWENDO        Downe     'END'                                        DOWHILE NOT END
045900000000 002?C                   Readc     LSTSFL                                 50    READ CHNG SBF
046000000000 002? *
046100000000B003?C     *IN50         Ifeq      *OFF                                         IF CHANGED RECORD
046200000000B004?C     WSOPC         Ifne      *BLANKS                                      IF OPTION CODE
046300000000 004?C                   Exsr      PRCOPT                                       PROCESS OPTION
046400000000B005?C     WWOPA         Ifeq      'SELECT'                                     IF SELECT
046500000000 005?C                   Exsr      PRCSEL                                       PROCESS SELECT
046600000000E005?C                   Endif                                                  END IF SELECT
046700000000E004?C                   Endif                                                  END IF OPTION CODE
046800000000 003? *
046900000000X003?C                   Else                                                   ELSE
047000000000 003?C                   Movel     'END'         WWENDO                         END OPTIONS
047100000000E003?C                   Endif                                                  END IF CHG RCD
047200000000E002?C                   Enddo                                                  END DO WHILE NOT END
047300000000E001?C                   Endif                                                  END IF SFL RCDS
047400000000    ? *
047500000000    ?C                   Move      'END'         WWENDF                         END PGM LOOP
047600000000    ?C                   Endsr                                                  END SLCNXT
047700000000    ? *___________________________________________________________________
047800000000    ? * Process option selected
047900000000    ? *___________________________________________________________________
048000000000    ?C     PRCOPT        Begsr                                                  PROCESS OPTION
048100000000    ?C                   Move      *BLANKS       WWRQS                          CLEAR RQS FLD
048200000000    ?C                   Move      WSOPC         WDOPC                          BLD OPTION CODE
048300000000    ? *
048400000000    ?C                   Call      'PRCOPT2'                                    PROCESS OPTIONS
048500000000    ?C                   Parm      WDOPC         WWRQS                          DISPLAY REQUEST
048600000000    ?C     WWOPA         Parm                    WWRTN                          RETURN CODE
048700000000    ?C                   Parm                    WAP                            OPTION DESC
048800000000    ?C                   Parm                    WAO                            OPTION TAPLE
048900000000    ?C                   Parm                    WWOPV                          OPTIONS ALLOWED
049000000000    ?C                   Endsr                                                  END PRCOPT
049100000000    ? *___________________________________________________________________
049200000000    ? * Process selection
049300000000    ? *___________________________________________________________________
049400000000    ?C     PRCSLC        Begsr                                                  PROCESS SELECTION
049500000000    ?C                   Exsr      PRCOPT                                       PROCESS OPTION
049600000000    ?C     WWOPA         Caseq     'DISPLAY'     PRCDSP                         DISPLAY
049700000000    ?C     WWOPA         Caseq     'SELECT'      PRCSEL                         SELECT
049800000000    ?C                   Endcs                                                  END CASE
049900000000    ?C                   Endsr                                                  END PRCSLC
050000000000    ? *___________________________________________________________________
050100000000    ? * Process SELECT Option
050200000000    ? *___________________________________________________________________
050300000000    ?C     PRCSEL        Begsr                                                  PROCESS SELECT
050400000000    ?C                   Move      'END'         WWENDO                         END OPT LOOP
050500000000    ?C                   Move      'END'         WWENDF                         END PGM LOOP
050600000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
050700000000    ?C                   Endsr                                                  END PRCSEL
050800000000    ? *___________________________________________________________________
050900000000    ? * Process DISPLAY option
051000000000    ? *___________________________________________________________________
051100000000    ?C     PRCDSP        Begsr                                                  DISPLAY
051200000000    ?C                   Endsr                                                  END PRC DSPL
051300000000    ? *___________________________________________________________________
051400000000    ? * Process option Return
051500000000    ? *___________________________________________________________________
051600000000    ?C     PRCRTN        Begsr                                                  PROCESS OPT RTN
051700000000    ? *
051800000000B001?C     WWRTN         Ifeq      'ERROR '                                     IF RTN ERROR
051900000000 001?C                   Seton                                        60        REVERSE IMAGE OPT
052000000000 001?C                   Movel     'END   '      WWENDO                         END PROCESSING
052100000000X001?C                   Else                                                   ELSE
052200000000 001?C                   Setoff                                       60        NO REVERSE IMAGE
052300000000 001?C                   Move      *BLANKS       WSOPC                          CLEAR OPTION
052400000000E001?C                   Endif                                                  ENDIF ERROR
052500000000    ? *
052600000000B001?C     WWRTN         Ifeq      'CANCEL'                                     IF CANCEL
052700000000 001?C                   Movel     'END   '      WWENDO                         END PROCESSING
052800000000E001?C                   Endif                                                  END IF EXIT/CANCEL
052900000000    ? *
053000000000    ?C                   Update    LSTSFL                                       UPDATE SFL
053100000000    ?C                   Z-add     WFRRN         WSPAG                          SET SFL PAGE
053200000000    ?C                   Endsr                                                  END PRCRTN
053300000000    ? *___________________________________________________________________
053400000000    ? * Process POSITION TO option
053500000000    ? *___________________________________________________________________
053600000000    ?C     PRCPSN        Begsr                                                  POSITION TO
053700130123 001?C     MBSSNO        Setll     DEPENDQTMP                                   PSN DB CURSOR
053800000000    ?C                   Exsr      CLRSFL                                       CLEAR SUBFILE
053900000000    ?C                   Exsr      PRCRUP                                       LOAD SUBFILE
054000000000    ?C                   Move      'Y'           WWPSNC                         SET PSN CHANGED
054100000000    ?C                   Endsr                                                  END POSITION TO
054200000000    ? *___________________________________________________________________
054300000000    ? * Send message
054400000000    ? *___________________________________________________________________
054500000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
054600000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
054700000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
054800000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
054900000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
055000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
055100000000    ?C                   Endsr                                                  END PROC FNC
055200000000    ? *___________________________________________________________________
055300000000    ? * Parameter lists
055400000000    ? *___________________________________________________________________
055500000000    ?C     PLIST         Begsr                                                  PARM LISTS
055600111006    ?C     KEYFAKE       Klist                                                  *ENTRY LIST
055700111006    ?C                   kfld                    WIRQS             8            PROGRAM REQUEST
055800111006    ?C                   kfld                    WORTN             8            RETURN CODE
055900111006    ?C                   kfld                    WUPGM            10            LAST PGM NAME
056000111208    ?C                   kfld                    WIDTA                          RECORD DS
056100000000    ?C                   Endsr
056200000000    ? *___________________________________________________________________
056300000000    ? * Define Variables
056400000000    ? *___________________________________________________________________
056500000000    ?C     DEFN          Begsr                                                  DEFINITIONS
056600000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST CODE
056700000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
056800000000    ?C                   Move      *BLANKS       WWOPV            60            OPTIONS VALID
056900000000    ?C                   Move      *BLANKS       WWFKV            60            FUNCTIONS VALID
057000000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
057100000000    ?C                   Move      *BLANKS       WWFKA             8            FUNCTION ACTION
057200000000    ?C                   Move      *BLANKS       WWENDF            3            FUNCTION CONTROL
057300000000    ?C                   Move      *BLANKS       WWOPA             8            OPTION ACTION
057400000000    ?C                   Move      *BLANKS       WWENDO            3            OPTION CONTROL
057500000000    ?C                   Move      'N'           WWSFLE            1            SUBFILE END
057600000000    ?C                   Z-add     0             WWLOWR            4 0          SUB FILE LOW REL REC
057700000000    ?C                   Z-add     0             WW                3 0          ARRAY  INDEX
057800111021    ?C                   Z-add     14            WWLSTS            2 0          LST SFL PAG SIZ
057900000000    ?C                   Z-add     0             WFRRN             4 0          LST SFL RRN
058000000000    ?C                   Z-add     0             WWRRN             4 0          LST SFL HIGH RRN
058100990824    ?C                   Z-add     1             WWPSNP            1 0          POSITION TO VIEW#
058200000000    ?C                   Move      'Y'           WWPSNC            1            POSITION TO CHANGED
058300990824    ?C                   Z-add     1             WWPSNN            1 0          NBR PSN TO PMTS
058400000000    ?C                   Z-add     41            WWPSNI            2 0          PSN TO BASE IND
058500000000    ?C     WWPSNI        Add       WWPSNN        WWLMT             2 0          PSN TO IND LMT
058600000000    ?C     WWLMT         Sub       1             WWLMT                          PSN TO IND LMT
058700000000    ?C                   Movel     '*'           MSPGMQ                         MSG SFL JOB MSGQ
058800111006    ?C                   Move      *BLANKS       WSOPC             1            OPTION CODE
058900000000    ?C                   Endsr                                                  END DEFN
059000000000    ? *___________________________________________________________________
059100000000    ? * Key lists
059200000000    ? *___________________________________________________________________
059300000000    ?C     KLIST         Begsr                                                  KEY LISTS
059400000000    ?C                   Endsr                                                  END KLIST
059500000000    ? *___________________________________________________________________
059600000000    ? * Program error handler
059700000000    ? *___________________________________________________________________
059800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
059900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
060000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
060100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
060200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
060300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
060400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
060500000000    ? *___________________________________________________________________
060600000000**  WAO OPTION TABLE - 30X38            |OPTION 2A, ACTION 8A, DESCRIPTION 28A |
060700000000 1SELECT  1=Select
060800000000 5DISPLAY 5=Display
060900000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION 8A, DESCR 30A   |
06100000000003EXIT    F3=Exit
06110000000025ROLLUP
06120000000026ROLLDOWN
061300000000** WTM
06140000000000You have reached the top of the list.
06150000000000You have reached the bottom of the list.
06160011102100No records found.
06170011120800
