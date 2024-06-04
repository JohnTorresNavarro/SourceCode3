     *_________________________________________________________________________
     *
     *  Description:  Work with Generic Notes file
     *
     *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
     *
     *_________________________________________________________________________
    FWRKNOTD   CF   E             WORKSTN
    F                                     SFILE(LSTSFL:WFRRN)
    F                                     INFDS(DSPD)
    FNOTESHL3  IF   E           K DISK
    F                                     RENAME(RNOTH:PSN1)
    FNOTESHL2  IF   E           K DISK
    F                                     RENAME(RNOTH:PSN2)
     FHSCTLL    IF   E           K DISK
     *______________________________________________________________________

    ___
     *
    D WAO             S             38    DIM(30) CTDATA PERRCD(1)             OPTION TABLE
    D WAP             S             75    DIM(6)                               OPTION DESC
    D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
    D WAD             S             80    DIM(6)                               FUNCTION DESC
    D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
     D ID#             S              9S 0 inz
     *_________________________________________________________________________
     * Data structure
    D WHDTA         E DS                  EXTNAME(NOTESH)
    D WDDTA         E DS                  EXTNAME(NOTESD)
    D WSDTA         E DS                  EXTNAME(HCTAMP)
     *
     * Option code data structure
    D                 DS
    D  WDOPC                  1      2
    D  WDOPC1                 1      1
    D  WDOPC2                 2      2
     *
     * Program status data structure
    D PGMD          ESDS                  EXTNAME(IOPGMD)
     *
     * Display file data structure
    D DSPD          E DS                  EXTNAME(IODSPD)
     *
     *   Standard parameter subfields
     D*STDPRM          DS                  Inz
     D STDPRM          DS
     D  APPCDE                 1     10
     D  HMONAM                11     50
     D  SYSKEY                51     62
     D  SYSTEM                51     52
     D  HYPHEN                53     53
     D  KEYWRD                54     62
     D  KEYDSC                63    102
     D  FRMPGM               103    112
     D  TOPGM                113    122
     D  ACTCDE               123    123
     D  RTNCDE               124    124
     D  JOB                  125    134
     D  USER                 135    144
     D  JOBNBR               145    150
     D  DFLTYR               151    152
     D  HMOCDE               153    156
     D  SBMUSR               157    166
     D  PARM                 167    198
     D    WSPACE             167    172
     D    WID#               173    181
     D    CFKEY              182    182
     *___________________________________________________________________
     * Process list panel
B001C     WIRQS         Ifne      'SLCNXT  '                                   IF NOT NEXT SELECT
 001C                   Exsr      DEFN                                         DEFINE FIELDS
E001C                   End                                                    ENDIF NEXT SELECT
    C                   Exsr      PRPPNL                                       PREPARE PANEL
     *
B001C     WWENDF        Downe     'END'                                        DOWHILE NOT END
 001C                   Exsr      RCVMSG                                       RECEIVE MSGS
 001C                   Exsr      DSPPNL                                       DISPLAY PANEL
 001C                   Exsr      PRCFKY                                       PROC FN KEYS
 001 *
 001C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
 001C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
 001C     WWFKA         Caseq     'REFRESH '    PRCRFR                         REFRESH
 001C     WWFKA         Caseq     'ADD     '    PRCADD                         ADD
 001C     WWFKA         Caseq     'INSERT  '    PRCADD                         INSERT
 001C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
 001C     WWFKA         Caseq     'PMTPSN  '    PRCPMT                         PMT POSITION TO
 001C     WWFKA         Caseq     'OPTIONS '    PRCDOP                         DISPLAY OPTIONS
 001C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
 001C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLLDOWN
 001C     WWFKA         Caseq     'ENTER   '    PRCENT                         ENTER
 001C                   Endcs                                                  END CASE
E001C                   Enddo                                                  END DOWHILE
    C                   Return                                                 RETURN
     *___________________________________________________________________
     * Prepare list panel
     *___________________________________________________________________
    C     PRPPNL        Begsr                                                  PREPARE PANEL
     C                   Movel(p)  NHSUBJ        WSSUBJ
     C                   Move      *Blanks       WWPSN1
     C                   Move      NHID#         WSID#
     *
     * Get Database Name for display.
     C                   MOVEL(P)  'HMONAM  '    SCKEY
     C     SCKEY         CHAIN     HSCTLL
     C                   IF        %FOUND
     C                   MOVEL(P)  SCDTA         WISTR
     C                   Z-ADD     50            WILEN
     C                   CALL      'UTLCENSTR'
     C                   PARM                    WISTR           256
     C                   PARM                    WILEN             3 0
     C                   MOVEL     WISTR         WSNAME
     C                   END
     *
    C                   Exsr      SETPSN                                       SET POSITION TO IND
     *
B001C                   Select                                                 SELECT
 001C     WIRQS         Wheneq    'ADD'                                        IF ADD RQS
 001C     WIRQS         Oreq      'ADDKEY'                                     OR ADDKEY RQS
 001C     WIRQS         Oreq      'INSERT'                                     OR INSERT RQS
 001C     WIRQS         Oreq      'INSKEY'                                     OR INSKEY RQS
 001C                   Move      WIRQS         WWFKA                          DEFINE FUNCTION
 001C                   Exsr      PRCADD                                       PRC ADD RQS
 001 *
 001C     WIRQS         Wheneq    'CHANGE'                                     IF CHANGE RQS
 001C                   Exsr      PRCCHG                                       PRC CHG RQS
 001 *
 001C     WIRQS         Wheneq    'LOAD'                                       IF LOAD REQUEST
 001C                   Exsr      PRCPSN                                       PROC POSITION TO
 001 *
 001C     WIRQS         Wheneq    'CLEAR'                                      IF CLEAR REQUEST
 001C                   Exsr      CLRSFL                                       CLEAR SUBFILE
 001 *
 001C     WIRQS         Wheneq    'SLCNXT'                                     IF SELECT NEXT
 001C                   Exsr      SLCNXT                                       SELECT NEXT
E001C                   Endsl                                                  END SELECT
     *
B001C     WWENDF        Ifne      'END'                                        IF NOT END
 001C                   Exsr      BLDOPT                                       BUILD OPTIONS
 001C                   Exsr      BLDFKY                                       BUILD FNC DSC
E001C                   End                                                    END IF NOT END
    C                   Endsr                                                  END PRPPNL
     *___________________________________________________________________
     * Set position to screen indicators
     *___________________________________________________________________
    C     SETPSN        Begsr                                                  SET POSITION TO
B001C     WWPSNI        Do        WWLMT         WW                             DO FOR NBR VIEWS
 001C                   Move      '0'           *IN(WW)                        SET OFF PSN
E001C                   Enddo                                                  END DO
    C     WWPSNI        Add       WWPSNP        WW                             VIEW# -> IND#
    C     WW            Sub       1             WW                             VIEW# -> IND#
    C                   Move      '1'           *IN(WW)                        DISPLAY PSN TO
    C                   Endsr                                                  END SETPSN
     *___________________________________________________________________
     * Display list panel
     *___________________________________________________________________
    C     DSPPNL        Begsr                                                  DISPALY PANEL
     * Set OVERLAY based on last display file processed
B001C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
 001C                   Setoff                                       35        OVERLAY OFF
 001C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
X001C                   Else                                                   ELSE SAME PGM
 001C                   Seton                                        35        OVERLAY ON
E001C                   End                                                    END IF NEW PGM
     * Write message subfile
    C                   Seton                                        30        SFLMSG DISPLAY
    C                   Write     MSGCTL                                       DISPLAY MSG SFL
     * Write function keys
B001C     *IN35         Ifeq      *OFF                                         IF OVERLAY OFF
 001C     WWFKS         Orne      WWFKSO                                       OR NEW F KEY SET
 001C                   Write     FKYDSC                                       DSP FNC KEY DSC
 001C                   Z-add     WWFKS         WWFKSO                         SAVE F KEY SET
E001C                   End                                                    END IF F KEY SET
     * Set subfile control panel overrides
B001C     WWPSNC        Ifeq      'Y'                                          IF PSN CHANGED
 001C                   Setoff                                       36        DO NOT PUTOVR
 001C                   Move      'N'           WWPSNC                         NOT CHANGED
X001C                   Else                                                   ELSE
 001C                   Seton                                        36        PUTOVR
E001C                   End                                                    END IF PSN
B001C     WWOPS         Ifne      WWOPSO                                       IF NEW OPT KEY SET
 001C                   Seton                                        37        DSP OPT KEY DSC
 001C                   Z-add     WWOPS         WWOPSO                         SAVE OPT KEY SET
X001C                   Else                                                   ELSE
 001C                   Setoff                                       37        NO OVRATR
E001C                   End                                                    END IF OPT KEY SET
     * Set subfile control inticators
B001C     WFRRN         Ifeq      0                                            IF SUBFILE EMPTY
 001C                   Setoff                                       30        ERASE SUBFILE
X001C                   Else                                                   ELSE SUBFILE
 001C                   Seton                                        30        DISPLAY SUBFILE
E001C                   End                                                    END IF SFL EMPTY
     * Write subfile
    C                   Exfmt     LSTCTL                                       DSP LST PANEL
    C                   Z-add     WDLOWR        WWLOWR                         SAVE SFL RCD NBR
    C                   Z-add     WDLOWR        WSPAG                          SET CURRENT PAGE
    C                   Setoff                                       626336    RESET SCREEN CTL
    C                   Endsr                                                  END DSPPNL
     *___________________________________________________________________
     * Process function key pressed
     *___________________________________________________________________
    C     PRCFKY        Begsr                                                  PROC FNC KEYS
    C                   Movea     *IN           WWIN                           INDICATORS
    C                   Call      'PRCFKY2'                                    PROC FNC KYS
    C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
    C     WWFKA         Parm                    WWRTN                          RETURN CODE
    C                   Parm                    WAD                            FNC DESC
    C                   Parm                    WWIN                           AID BYTE
    C                   Parm                    WAF                            FNC KEY TABLE
    C                   Parm                    WIFKV                          FNC KYS ALLWD
    C                   Endsr                                                  END PRC FKY
     *___________________________________________________________________
     * Process KEYS function
     *___________________________________________________________________
    C     PRCDKY        Begsr                                                  PROCESS KEYS
    C                   Z-add     1             WW                             KEY DSC IDX
B001C     WWFKS         Doueq     1                                            DO UNTIL SET=1
 001C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
 001C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
 001 *
B002C     WWFKS         Ifgt      3                                            IF OVER 3
 002C                   Z-add     1             WWFKS                          SET TO 1
E002C                   End                                                    END IF OVER 3
 001 *
 001C     WWFKS         Mult      2             WW                             KEY DESCR IDX
 001C                   Sub       1             WW                             KEY DESCR IDX
E001C                   Enddo                                                  END DO KEYS
     *
    C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
    C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
    C                   Sub       1             WW                             BUMP IDX
    C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
    C                   Endsr                                                  END PRCDKY
     *___________________________________________________________________
     * Process EXIT function
     *___________________________________________________________________
    C     PRCEXT        Begsr                                                  PROCESS EXIT
    C                   Movel     WWFKA         WORTN                          SET RETURN CODE
    C                   Move      'END'         WWENDF                         END FNC LOOP
    C                   Endsr                                                  END PRCEXT
     *___________________________________________________________________
     * Process REFRESH function
     *___________________________________________________________________
    C     PRCRFR        Begsr                                                  PROCESS REFRESH
    C                   Exsr      PRCPSN                                       POSITION TO
B001C     WSPAG         Dowlt     WWLOWR                                       DO WHILE NOT PRV PAG
 001C     WWSFLE        Andne     'Y'                                          AND NOT EOF
 001C                   Exsr      PRCRUP                                       LOAD SUBFILE
E001C                   Enddo                                                  END DO NOT PRV PAG
    C                   Endsr                                                  END PRCRFR
     *___________________________________________________________________
     * Process ADD function
     *___________________________________________________________________
    C     PRCADD        Begsr                                                  PROCESS ADD
     *
     C                   Call      'SLCNOT'                             99
    C                   Parm                    WSRQS             8            PROGRAM REQUEST
    C                   Parm                    WSRTN             8            RETURN CODE
    C                   Parm                    WUPGM            10            LAST PGM NAME
    C                   Parm                    WSDTA                          RECORD DS
     *
B001C     *IN99         Ifeq      '1'                                          IF CALL ERROR
 001C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
 001C                   Exsr      SNDMSG                                       SEND MESSAGE
 001C                   Movel     'ERROR'       WORTN                          RETURN ERROR
 001C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
E001C                   Else                                                   END ERROR
     *
B001C     WSRTN         Ifeq      'EXIT'                                       IF CALL ERROR
B001C     WSRTN         Oreq      'CANCEL'                                     IF CALL ERROR
     * Do nothing......
X001C                   Else                                                   END ERROR
     C                   Movel(p)  CTAMCD        NHCODE
     C                   Movel(p)  CTAMDS        NHSUBJ
     C                   CALL      'UPDNOT'
    C                   Parm      'ADD     '    WWRQS             8            REQUEST
    C                   Parm      *BLANKS       WWRTN             8            RETURN CODE
    C                   Parm                    WHDTA                          DATA
     C                   If        WWRTN    =    *Blanks
    C                   Call      'WRKNDT  '                           99      DLT RECORD
    C                   Parm      'MNT     '    WWRQS                          DLT REQUEST
    C                   Parm      *BLANKS       WWRTN                          RETURN CODE
    C                   Parm                    WUPGM                          LAST PGM NAME
    C                   Parm                    WHDTA                          RECORD DS
    C                   Parm      'X 010312'    WWFKV                          FUNCTIONS VALID
     C                   Parm                    WSTXT1           60
     C                   Parm                    WSTXT2           60
     C                   Parm                    WSTXT3           10
     C                   Parm                    WSTXT4           10
    C     WWRTN         Ifeq      'UPDATE  '                                   IF CALL ERROR
    C                   Movel     WTM(9)        WWMSG                          PASS MESSAGE
    C                   Exsr      SNDMSG                                       SEND MESSAGE
    C                   Exsr      PRCRFR
     C                   End
     C                   Else
    C                   Movel     WTM(7)        WWMSG                          PASS MESSAGE
     C                   Exsr      SNDMSG                                       SEND MESSAGE
    C                   Movel     'ERROR'       WORTN                          RETURN ERROR
    C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
     C                   End
E001C                   End                                                    END ERROR
E001C                   End                                                    END ERROR
     *
    C                   Endsr                                                  END ADD
     *___________________________________________________________________
     * Process RENAME Function
     *___________________________________________________________________
    C     PRCRNM        Begsr                                                  PROCESS ADD
     *
     C                   Call      'SLCNOT'                             99
    C                   Parm                    WSRQS             8            PROGRAM REQUEST
    C                   Parm                    WSRTN             8            RETURN CODE
    C                   Parm                    WUPGM            10            LAST PGM NAME
    C                   Parm                    WSDTA                          RECORD DS
     *
B001C     *IN99         Ifeq      '1'                                          IF CALL ERROR
 001C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
 001C                   Exsr      SNDMSG                                       SEND MESSAGE
 001C                   Movel     'ERROR'       WORTN                          RETURN ERROR
 001C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
E001C                   Else                                                   END ERROR
     *
B001C     WSRTN         Ifeq      'EXIT'                                       IF CALL ERROR
B001C     WSRTN         Oreq      'CANCEL'                                     IF CALL ERROR
     * Do nothing......
X001C                   Else                                                   END ERROR
     *
     C                   Eval      weid#    =    nhid#
     C                   Eval      wecode   =    ctamcd
     C     WKEDIT        Setll     Noteshl3
     C                   If        %Equal
    C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
    C                   Exsr      SNDMSG                                       SEND MESSAGE
    C                   Movel     'ERROR'       WORTN                          RETURN ERROR
    C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
     C                   Else
     *
     C                   move      NHID#         NDID#
     C                   Movel(p)  CTAMCD        NDCODE
    C                   Call      'UPDNDT'                                     *ENTRY LIST
    C                   Parm      'RENAME  '    WDRQS             8            REQUEST
    C                   Parm                    WDRTN             8            RETURN CODE
    C                   Parm                    WHDTA                          DATA
    C                   Parm                    WDDTA                          DATA
     *
     C                   Movel(p)  CTAMCD        NHCODE
     C                   Movel(p)  CTAMDS        NHSUBJ
     C                   CALL      'UPDNOT'
    C                   Parm      'ADD     '    WWRQS             8            REQUEST
    C                   Parm      *BLANKS       WWRTN             8            RETURN CODE
    C                   Parm                    WHDTA                          DATA
     *
     C                   If        WWRTN    =    *Blanks
    C                   Call      'WRKNDT  '                           99      DLT RECORD
    C                   Parm      'MNT     '    WWRQS                          DLT REQUEST
    C                   Parm      *BLANKS       WWRTN                          RETURN CODE
    C                   Parm                    WUPGM                          LAST PGM NAME
    C                   Parm                    WHDTA                          RECORD DS
    C                   Parm      'X 010312'    WWFKV                          FUNCTIONS VALID
     C                   Parm                    WSTXT1           60
     C                   Parm                    WSTXT2           60
     C                   Parm                    WSTXT3           10
     C                   Parm                    WSTXT4           10
    C     WWRTN         Ifeq      'UPDATE  '                                   IF CALL ERROR
    C                   Movel     WTM(9)        WWMSG                          PASS MESSAGE
    C                   Exsr      SNDMSG                                       SEND MESSAGE
    C                   Exsr      PRCRFR
     C                   End
     C                   Else
    C                   Movel     WTM(7)        WWMSG                          PASS MESSAGE
     C                   Exsr      SNDMSG                                       SEND MESSAGE
    C                   Movel     'ERROR'       WORTN                          RETURN ERROR
    C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
     C                   End
E001C                   End                                                    END ERROR
E001C                   End                                                    END ERROR
E001C                   End                                                    END ERROR
     *
    C                   Endsr                                                  END ADD
     *___________________________________________________________________
     * Process CANCEL function
     *___________________________________________________________________
    C     PRCCNL        Begsr                                                  PROCESS CANCEL
    C                   Movel     WWFKA         WORTN                          SET RETURN CODE
    C                   Move      'END'         WWENDF                         END FNC LOOP
    C                   Endsr                                                  END PRCCNL
     *___________________________________________________________________
     * Process POSITION TO function
     *___________________________________________________________________
    C     PRCPMT        Begsr                                                  PROCESS POSITION
     *
    C                   Move      '     '       WSFLD                          TRUNCATE FIELD
B001C     WSFLD         Ifeq      'WSPSN'                                      IF CURSOR ON PSN
 001C     WWPSNP        Add       1             WWPSNP                         BUMP PSN TO VIEW
B002C     WWPSNP        Ifgt      WWPSNN                                       IF GT HIGH VIEW
 002C                   Z-add     1             WWPSNP                         SET TO BGN VIEW
E002C                   End                                                    END IF GT HIGH PSN
 001C                   Exsr      SETPSN                                       SET PSN TO IND
E001C                   End                                                    END IF CSR ON PSN
    C                   Seton                                        63        POSITION CURSOR
    C                   Move      'Y'           WWPSNC                         SET PSN CHANGED
    C                   Endsr                                                  END PRCPMT
     *___________________________________________________________________
     * Process OPTIONS function
     *___________________________________________________________________
    C     PRCDOP        Begsr                                                  PROCESS DSP OPT
    C                   Z-add     1             WW                             OPT DSC IDX
B001C     WWOPS         Doueq     1                                            DO UNTIL SET=1
 001C     WAP(WW)       Orne      *BLANKS                                      OR OPTS FOUND
 001C     WWOPS         Add       1             WWOPS                          NEXT OPT SET
 001 *
B002C     WWOPS         Ifgt      3                                            IF OVER 3
 002C                   Z-add     1             WWOPS                          SET TO 1
E002C                   End                                                    END IF OVER 3
 001 *
 001C     WWOPS         Mult      2             WW                             OPT DESCR IDX
 001C                   Sub       1             WW                             OPT DESCR IDX
E001C                   Enddo                                                  END DO OPTS
     *
    C     WWOPS         Add       WWOPS         WW                             OPT DSC IDX
    C                   Movel     WAP(WW)       WSOPD2                         LOAD LINE 2
    C                   Sub       1             WW                             BUMP IDX
    C                   Movel     WAP(WW)       WSOPD1                         LOAD LINE 1
    C                   Seton                                        36        OVRDTA OPTIONS
    C                   Endsr                                                  END PRCDOP
     *___________________________________________________________________
     * Process ROLL UP function (add a page to list subfile)
     *___________________________________________________________________
    C     PRCRUP        Begsr                                                  PROCESS ROLLUP
    C                   Move      'N'           WWSFLE                         SUBFILE END
    C                   Z-add     WWRRN         WSPAG                          SFL PAG = LAST PAGE
    C                   Z-add     1             WW                             WINDOW INDEX
    C                   Z-add     WWRRN         WFRRN                          HIGH SFL RRN
    C                   Setoff                                       50        RESET EOF IND
    C                   Setoff                                       6061      SUBFILE SRC CTL
    C                   Clear                   LSTSFL                         BLANK SFL RECORD
B001C     WW            Dowle     WWLSTS                                       DO WHILE PAG SIZ
 001C     *IN50         Andeq     '0'                                          AND RECORDS
B002C     WWPSNP        Ifeq      1                                            IF PSN VIEW 1
 002C     WKID#         Reade     NOTESHL3                               50    READ FILE
E002C                   End                                                    END IF PSN VIEW 1
B002C     WWPSNP        Ifeq      2                                            IF PSN VIEW 1
 002C     WKID#         Reade     NOTESHL2                               50    READ FILE
E002C                   End                                                    END IF PSN VIEW 1
B002C     *IN50         Ifeq      '0'                                          IF RECORD READ
     C                   Exsr      LoadWrk
 002C                   Add       1             WFRRN                          BUMP SFL RRN
 002C                   Add       1             WW                             BUMP INDEX
 002C                   Write     LSTSFL                                       WRITE SFL REC
X002C                   Else                                                   ELSE EOF
 002C                   Move      'Y'           WWSFLE                         SET EOF
E002C                   End                                                    END IF REC READ
 001 *
E001C                   Enddo                                                  END DO
     *
B001C     WFRRN         Ifgt      WWRRN                                        IF RECORDS ADDED
 001C     WWRRN         Add       1             WSPAG                          SFL PAG = 1ST NEW RC
 001C                   Z-add     WFRRN         WWRRN                          SAVE HIGH SFL RRN
E001C                   End                                                    END IF RCDS ADDED
     *
B001C     WFRRN         Ifeq      0                                            IF SFL EMPTY
 001C                   Move      WTM(5)        WWMSG                          EOF MSG
 001C                   Exsr      SNDMSG                                       SEND MESSAGE
E001C                   End                                                    IF SFL EMPTY
     *
B001C     WWSFLE        Ifeq      'Y'                                          AT END OF FILE?
 001C                   Seton                                        39        SFLEND BOTTOM
X001C                   Else                                                   ELSE
 001C                   Setoff                                       39        SFLEND MORE...
E001C                   End                                                    END IF END OF FILE
     *
    C                   Endsr                                                  END PRCRUP
     *___________________________________________________________________
     * Process ROLLDOWN function (beginning of SFL reached)
     *___________________________________________________________________
    C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
    C                   Z-add     1             WSPAG                          DSP 1ST PAGE
    C                   Move      WTM(1)        WWMSG                          BGN SFL MSG
    C                   Exsr      SNDMSG                                       SEND MSG
    C                   Endsr                                                  END PRCRDN
     *___________________________________________________________________
     * Process ENTER function
     *___________________________________________________________________
    C     PRCENT        Begsr                                                  PROCESS ENTER
    C                   Move      *BLANKS       WWENDO                         OPT LOOP STATE
    C                   Move      *BLANKS       WWRTN                          RETURN VALUE
    C                   Move      *BLANKS       WWDLT                          DELETE FLAG
    C                   Setoff                                       50        RESET EOF IND
     *
B001C     WFRRN         Ifgt      0                                            IF SFL RECORDS
 001 *
B002C     WWENDO        Downe     'END'                                        DOWHILE NOT END
 002C     *IN50         Andne     *ON                                          AND NOT EOF
 002C                   Readc     LSTSFL                                 50    READ CHNG SBF
 002 *
B003C     *IN50         Ifeq      *OFF                                         IF CHANGED RECORD
 003C     WSOPC         Andne     *BLANKS                                      AND OPTION CODE
 003C                   Exsr      PRCSLC                                       PROCESS SELECTION
 003C                   Exsr      PRCRTN                                       PROCESS OPT RETURN
 003C                   Exsr      PRCRFR                                       PROCESS OPT RETURN
E003C                   End                                                    END IF SELECTION
E002C                   Enddo                                                  END DO WHILE NOT END
E001C                   End                                                    END IF SFL RCDS
     *
B001C     *IN38         Ifeq      *ON                                          IF PSN CHANGED
 001C     WWENDO        Andne     'END   '                                     AND NOT ERROR
B002C     WWPSNP        Ifeq      1                                            IF PSN VIEW 1
 002C                   Move      WSPSN1        WWPSN1                         SAVE PSN TO
E002C                   End                                                    IF PSN VIEW 1
B002C     WWPSNP        Ifeq      2                                            IF PSN VIEW 1
 002C                   Move      WSPSN2        WWPSN2                         SAVE PSN TO
E002C                   End                                                    IF PSN VIEW 1
 001C                   Exsr      PRCPSN                                       PROC POSTN TO
E001C                   End                                                    IF PSN PMT
     *
B001C     WWDLT         Ifeq      'Y'                                          IF DELETED RCD
 001C     *IN38         Andeq     *OFF                                         AND PSN NOT CHG
 001C     WWENDO        Andne     'END   '                                     AND NOT ERROR
 001C                   Exsr      PRCRFR                                       PROC REFRESH
E001C                   End                                                    IF PSN PMT
    C                   Endsr                                                  END PRCENT
     *___________________________________________________________________
     * Receive messages from a data queue and send to program queue
     *___________________________________________________________________
    C     RCVMSG        Begsr                                                  RECEIVE MSG
    C                   Movea     *IN           WWIN                           INDICATORS
    C                   Call      'PRCMSG2'                                    CALL MSG PGM
    C                   Parm      'RECEIVE '    WWRQS                          REQUEST MSG DSP
    C                   Parm                    WWIN                           INDICATORS
    C                   Parm                    WWRTN                          RETURN CODE
    C                   Movea     WWIN          *IN                            INDICATORS RET
    C                   Endsr                                                  END RCV MSG
     *___________________________________________________________________
     * Build option information
     *___________________________________________________________________
    C     BLDOPT        Begsr                                                  BUILD OPTIONS
    C                   Call      'PRCOPT2'                                    PROCESS OPTIONS
    C                   Parm      'BUILD   '    WWRQS                          BUILD REQUEST
    C                   Parm                    WWRTN                          RETURN CODE
    C                   Parm                    WAP                            OPTION DESC
    C                   Parm                    WAO                            OPTION TAPLE
    C                   Parm                    WIOPV                          OPTIONS ALLOWED
    C     WWOPS         Add       WWOPS         WW                             OPT DSC IDX
    C                   Movel     WAP(WW)       WSOPD2                         LOAD LINE 2
    C                   Sub       1             WW                             BUMP IDX
    C                   Movel     WAP(WW)       WSOPD1                         LOAD LINE 1
    C                   Endsr                                                  END BLD OPTIONS
     *___________________________________________________________________
     * Build function key information for this program
     *___________________________________________________________________
    C     BLDFKY        Begsr                                                  BUILD FNC KEYS
    C                   Movea     *IN           WWIN                           INDICATORS
    C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
    C                   Parm      'BUILD   '    WWRQS                          REQUEST BUILD
    C                   Parm                    WWRTN                          RETURN CODE
    C                   Parm                    WAD                            FNC DESC
    C                   Parm                    WWIN                           AID BYTE
    C                   Parm                    WAF                            FNC KEY TABLE
    C                   Parm                    WIFKV                          FNCTN KYS ALLWD
    C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
    C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
    C                   Sub       1             WW                             BUMP IDX
    C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
    C                   Endsr                                                  END BLD FNCTNS
     *___________________________________________________________________
     * Clear list subfile
     *___________________________________________________________________
    C     CLRSFL        Begsr                                                  CLEAR SUBFILE
    C                   Seton                                        31        CLEAR SUBFILE
    C                   Write     LSTCTL                                       CLEAR SUBFILE
    C                   Setoff                                       31        CLEAR SUBFILE
    C                   Z-add     0             WSPAG                          SLF PAGE
    C                   Z-add     0             WFRRN                          SFL RRN
    C                   Z-add     0             WWRRN                          HIGH SFL RRN
    C                   Endsr                                                  END CLEAR SFL
     *___________________________________________________________________
     * Process SLCNXT Request
     *___________________________________________________________________
    C     SLCNXT        Begsr                                                  SELECT NEXT
    C                   Movel     'ERROR'       WORTN                          SET RETURN CODE
    C                   Move      *BLANKS       WWENDO                         LOOP END OPTION
B001C     WFRRN         Ifgt      0                                            IF SFL RECORDS
 001 *
B002C     WWENDO        Downe     'END'                                        DOWHILE NOT END
 002C                   Readc     LSTSFL                                 50    READ CHNG SBF
 002 *
B003C     *IN50         Ifeq      *OFF                                         IF CHANGED RECORD
B004C     WSOPC         Ifne      *BLANKS                                      IF OPTION CODE
 004C                   Exsr      PRCOPT                                       PROCESS OPTION
B005C     WWOPA         Ifeq      'SELECT'                                     IF SELECT
 005C                   Exsr      PRCSEL                                       PROCESS SELECT
E005C                   End                                                    END IF SELECT
E004C                   End                                                    END IF OPTION CODE
X003C                   Else                                                   ELSE
 003C                   Movel     'END'         WWENDO                         END OPTIONS
E003C                   End                                                    END IF CHG RCD
E002C                   Enddo                                                  END DO WHILE NOT END
E001C                   End                                                    END IF SFL RCDS
     *
    C                   Move      'END'         WWENDF                         END PGM LOOP
    C                   Endsr                                                  END SLCNXT
     *___________________________________________________________________
     * Process option selected
     *___________________________________________________________________
    C     PRCOPT        Begsr                                                  PROCESS OPTION
    C                   Move      *BLANKS       WWRQS                          CLEAR RQS FLD
    C                   Move      WSOPC         WDOPC                          BLD OPTION CODE
     *
B001C     WDOPC2        Ifeq      ' '                                          IF NOT RIGHT ADJ
 001C     WDOPC1        Andge     '0'                                          AND NUMERIC
 001C                   Move      WDOPC1        WDOPC2                         RIGHT ADJUST
 001C                   Move      '0'           WDOPC1                         RIGHT ADJUST
E001C                   End                                                    END RIGHT ADJ
     *
B001C     WDOPC1        Ifeq      ' '                                          IF LEADING BLANK
 001C     WDOPC2        Andge     '0'                                          AND NUMERIC
 001C                   Move      '0'           WDOPC1                         INSERT LEADING 0
E001C                   End                                                    END RIGHT ADJ
     *
B001C     WDOPC1        Ifeq      ' '                                          IF NOT LEFT ADJ
 001C     WDOPC2        Andlt     '0'                                          AND ALPHA
 001C                   Move      WDOPC2        WDOPC1                         LEFT ADJUST
 001C                   Move      ' '           WDOPC2                         LEFT ADJUST
E001C                   End                                                    END LEFT ADJ
     *
    C                   Call      'PRCOPT2'                                    PROCESS OPTIONS
    C                   Parm      WDOPC         WWRQS                          DISPLAY REQUEST
    C     WWOPA         Parm                    WWRTN                          RETURN CODE
    C                   Parm                    WAP                            OPTION DESC
    C                   Parm                    WAO                            OPTION TAPLE
    C                   Parm                    WIOPV                          OPTIONS ALLOWED
    C                   Endsr                                                  END PRCOPT
     *___________________________________________________________________
     * Process selection
     *___________________________________________________________________
    C     PRCSLC        Begsr                                                  PROCESS SELECTION
    C                   Exsr      PRCOPT                                       PROCESS OPTION
    C     WWOPA         Caseq     'DISPLAY'     PRCDSP                         DISPLAY
    C     WWOPA         Caseq     'CHANGE'      PRCCHG                         CHANGE
    C     WWOPA         Caseq     'RENAME'      PRCRNM                         CHANGE
    C     WWOPA         Caseq     'DELETE'      PRCDLT                         DELETE
    C     WWOPA         Caseq     'SELECT'      PRCSEL                         SELECT
    C     WWOPA         Caseq     'COPY   '     PRCCHG                         COPY
    C     WWOPA         Caseq     'CPYKEY '     PRCCHG                         COPY W/GENKEY
    C     WWOPA         Caseq     'PRINT   '    PRCPRT                         ADD
    C                   Endcs                                                  END CASE
    C                   Endsr                                                  END PRCSLC
     *___________________________________________________________________
     * Process CHANGE option
     *___________________________________________________________________
    C     PRCCHG        Begsr                                                  PROCESS CHANGE
      *
     C                   CALL      'UPDNOT'
    C                   Parm      'GET     '    WWRQS             8            REQUEST
    C                   Parm                    WWRTN             8            RETURN CODE
    C                   Parm                    WHDTA                          DATA
      *
    C     WWRTN         Ifeq      *Blanks                                      IF CALL ERROR
    C                   Call      'WRKNDT  '                           99      DLT RECORD
    C                   Parm      'MNT     '    WWRQS                          DLT REQUEST
    C                   Parm                    WWRTN                          RETURN CODE
    C                   Parm                    WUPGM                          LAST PGM NAME
    C                   Parm                    WHDTA                          RECORD DS
    C                   Parm      'X 010312'    WWFKV                          FUNCTIONS VALID
     C                   Parm                    WSTXT1           60
     C                   Parm                    WSTXT2           60
     C                   Parm                    WSTXT3           10
     C                   Parm                    WSTXT4           10
     *
B001C     WWRTN         Ifeq      'UPDATE  '                                   IF CALL ERROR
     C                   CALL      'UPDNOT'
    C                   Parm      'CHANGE  '    WWRQS             8            REQUEST
    C                   Parm                    WWRTN             8            RETURN CODE
    C                   Parm                    WHDTA                          DATA
 001C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
 001C                   Exsr      SNDMSG                                       SEND MESSAGE
E001C                   Else                                                   END ERROR
     C                   CALL      'UPDNOT'
    C                   Parm      'RELEASE '    WWRQS             8            REQUEST
    C                   Parm                    WWRTN             8            RETURN CODE
    C                   Parm                    WHDTA                          DATA
E001C                   End                                                    END ERROR
     *
B001C     *IN99         Ifeq      '1'                                          IF CALL ERROR
 001C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
 001C                   Exsr      SNDMSG                                       SEND MESSAGE
 001C                   Movel     'ERROR'       WORTN                          RETURN ERROR
 001C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
E001C                   End                                                    END ERROR
E001C                   Else                                                   END ERROR
 001C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
 001C                   Exsr      SNDMSG                                       SEND MESSAGE
 001C                   Movel     'ERROR'       WORTN                          RETURN ERROR
 001C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
E001C                   End                                                    END ERROR
     *
    C                   Endsr                                                  END PRCCHG
     *___________________________________________________________________
     * Process DELETE option
     *___________________________________________________________________
    C     PRCDLT        Begsr                                                  DELETE
    C                   Endsr                                                  END PRCDLT
     *___________________________________________________________________
     * Process SELECT Option
     *___________________________________________________________________
    C     PRCSEL        Begsr                                                  PROCESS SELECT
     C                   movel     syskey        savkey           12
     C                   movel     keydsc        savdsc           40
     C                   movel     wid#          savid#            9
     C                   Eval      syskey = 'CT-MNTNOT'
     * Center key Dsc for screen display
     C                   Eval      keydsc = 'WORK WITH NOTES'
     C                   Call      'UTLCENSTR'
     C     keydsc        Parm      keydsc        WISTR           256
     C                   Parm      40            WILEN             3 0
     * If CF1 was pressed in called program, end this program.
     C     CFKEY         Ifeq      '1'
     C                   Move      'END'         WWENDF
     C                   End
    C                   Endsr                                                  END PRCSEL
     *___________________________________________________________________
     * Process DISPLAY option
     *___________________________________________________________________
    C     PRCDSP        Begsr                                                  DISPLAY
     *
    C                   Call      'WRKNDT  '                           99      DLT RECORD
    C                   Parm      'DSP     '    WWRQS                          DLT REQUEST
    C                   Parm                    WWRTN                          RETURN CODE
    C                   Parm                    WUPGM                          LAST PGM NAME
    C                   Parm                    WHDTA                          RECORD DS
    C                   Parm      'X 0103051012'WWFKV                          FUNCTIONS VALID
     C                   Parm                    WSTXT1           60
     C                   Parm                    WSTXT2           60
     C                   Parm                    WSTXT3           10
     C                   Parm                    WSTXT4           10
     *
B001C     *IN99         Ifeq      '1'                                          IF CALL ERROR
 001C                   Movel     WTM(4)        WWMSG                          PASS MESSAGE
 001C                   Exsr      SNDMSG                                       SEND MESSAGE
 001C                   Movel     'ERROR'       WORTN                          RETURN ERROR
 001C                   Movel     'ERROR'       WWRTN                          RETURN ERROR
E001C                   End                                                    END ERROR
     *
B001C     WWRTN         Ifeq      'EXIT'                                       IF CALL ERROR
 001C                   Movel     WWRTN         WORTN                          RETURN ERROR
 001C                   Movel     'END'         WWENDF                         RETURN ERROR
E001C                   End                                                    END ERROR
     *
    C                   Endsr                                                  END PRC DSPL
     *___________________________________________________________________
     * Process PRINT option
     *___________________________________________________________________
    C     PRCPRT        Begsr                                                  DISPLAY
     *
     *
    C                   Endsr                                                  END PRC DSPL
     *___________________________________________________________________
     * Process option Return
     *___________________________________________________________________
    C     PRCRTN        Begsr                                                  PROCESS OPT RTN
B001C     WWOPA         Ifne      'CHANGE  '                                   IF NOT CHANGE
 001C     WWOPA         Oreq      'CHANGE  '                                   OR CHANGE
 001C     WWRTN         Andeq     'CANCEL  '                                   AND CANCEL RETURN
 001C     WFRRN         Chain     LSTSFL                             99        GET SUBFILE RCD
E001C                   End                                                    END IF DELETED
     *
B001C     WWRTN         Ifeq      'ERROR '                                     IF RTN ERROR
 001C                   Seton                                        60        REVERSE IMAGE OPT
 001C                   Movel     'END   '      WWENDO                         END PROCESSING
X001C                   Else                                                   ELSE
 001C                   Setoff                                       60        NO REVERSE IMAGE
 001C                   Move      *BLANKS       WSOPC                          CLEAR OPTION
E001C                   End                                                    ENDIF ERROR
     *
B001C     WWRTN         Ifeq      'CANCEL'                                     IF CANCEL
 001C                   Movel     'END   '      WWENDO                         END PROCESSING
E001C                   End                                                    END IF EXIT/CANCEL
     *
    C                   Update    LSTSFL                                       UPDATE SFL
    C                   Z-add     WFRRN         WSPAG                          SET SFL PAGE
    C                   Endsr                                                  END PRCRTN
     *___________________________________________________________________
     * Process POSITION TO option
     *___________________________________________________________________
    C     PRCPSN        Begsr                                                  POSITION TO
     *
     C                   Select
    C     WWPSNP        Wheneq    1                                            IF PSN VIEW 1
    C     WKPSN1        Setll     NOTESHL3                                     PSN DB CURSOR
    C                   Clear                   WSPSN1                         CLEAR PSN TO
    C     WWPSNP        Wheneq    2                                            IF PSN VIEW 1
     C     WWPSN2        Mult      10000.0001    WWPSN2
    C     WKPSN2        Setll     NOTESHL2                                     PSN DB CURSOR
    C                   Clear                   WSPSN2                         CLEAR PSN TO
     C                   Endsl
    C                   Exsr      CLRSFL                                       CLEAR SUBFILE
    C                   Exsr      PRCRUP                                       LOAD SUBFILE
    C                   Move      'Y'           WWPSNC                         SET PSN CHANGED
    C                   Endsr                                                  END POSITION TO
     *___________________________________________________________________
     * Send message
     *___________________________________________________________________
    C     SNDMSG        Begsr                                                  SEND MESSAGE
    C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
    C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
    C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
    C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
    C                   Parm                    WWMSG            80            ERROR MESSAGE
    C                   Endsr                                                  END PROC FNC
     *___________________________________________________________________
     * Parameter lists
     *___________________________________________________________________
    C     PLIST         Begsr                                                  PARM LISTS
    C     *ENTRY        Plist                                                  *ENTRY LIST
    C                   Parm                    WIRQS             8            PROGRAM REQUEST
    C                   Parm                    WORTN             8            RETURN CODE
    C                   Parm                    WUPGM            10            LAST PGM NAME
    C                   Parm                    WIOPV            60            OPTIONS VALID
    C                   Parm                    WIFKV            60            FUNCTIONS VALID
    C                   Parm                    WSTXT1           60            FUNCTIONS VALID
    C                   Parm                    WSTXT2           60            FUNCTIONS VALID
    C                   Parm                    WSTXT3           10            FUNCTIONS VALID
     C                   Parm                    WSTXT4           10
    C                   Parm                    WHDTA                          RECORD DS
    C                   Endsr
     *___________________________________________________________________
     * Define Variables
     *___________________________________________________________________
    C     DEFN          Begsr                                                  DEFINITIONS
    C     *LIKE         Define    WIRQS         WWRQS                          REQUEST CODE
    C     *LIKE         Define    WIRQS         WWRQSD                         REQUEST CODE DTL
    C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
    C     *LIKE         Define    WORTN         WWRTNH                         RETURN CODE
    C     *LIKE         Define    WORTN         WWRTND                         RETURN CODE
    C     *LIKE         Define    WIOPV         WWOPV                          OPTIONS VALID
    C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
    C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
    C                   Move      *BLANKS       WWFKA             8            FUNCTION ACTION
    C                   Move      *BLANKS       WWENDF            3            FUNCTION CONTROL
    C                   Move      *BLANKS       WWOPA             8            OPTION ACTION
    C                   Move      *BLANKS       WDOPC             2            OPTION CODE 2A
    C                   Move      *BLANKS       WWENDO            3            OPTION CONTROL
    C                   Move      'N'           WWSFLE            1            SUBFILE END
    C                   Z-add     0             WWLOWR            4 0          SUB FILE LOW REL REC
    C                   Z-add     0             WW                3 0          ARRAY  INDEX
    C                   Z-add     11            WWLSTS            2 0          LST SFL PAG SIZ
    C                   Z-add     0             WFRRN             4 0          LST SFL RRN
    C                   Z-add     0             WWRRN             4 0          LST SFL HIGH RRN
    C                   Z-add     1             WWOPS             1 0          OPTION SET
    C                   Z-add     0             WWOPSO            1 0          OPTION SET OLD
    C                   Z-add     1             WWFKS             1 0          FUNTION KEY SET
    C                   Z-add     0             WWFKSO            1 0          FUNTION KEY SET OLD
    C                   Z-add     1             WWPSNP            1 0          POSITION TO VIEW#
    C                   Move      'Y'           WWPSNC            1            POSITION TO CHANGED
    C                   Move      'N'           WWDLT             1            DELETE?
    C                   Z-add     2             WWPSNN            1 0          NBR PSN TO PMTS
    C     *LIKE         Define    WSPSN1        WWPSN1                         SAVE POSITION TO
    C     *LIKE         Define    WSPSN2        WWPSN2                         SAVE POSITION TO
     C                   Z-add     0             WSPSN2
     C                   Z-add     0             WWPSN2
    C                   Z-add     41            WWPSNI            2 0          PSN TO BASE IND
    C     WWPSNI        Add       WWPSNN        WWLMT             2 0          PSN TO IND LMT
    C     WWLMT         Sub       1             WWLMT                          PSN TO IND LMT
    C                   Movel     '*'           MSPGMQ                         MSG SFL JOB MSGQ
    C                   Move      *BLANKS       WSOPC                          OPTION CODE
    C                   Endsr                                                  END DEFN
     *___________________________________________________________________
     * Load Work Fields
     *___________________________________________________________________
    C     LoadWrk       Begsr                                                  KEY LISTS
     C                   Reset                   Wsaddt
     C                   Reset                   Wssubj
     C                   Movel     Nhsubj        Wssubj
     C     Nhaddt        Ifne      *zero
     C                   movel     Nhaddt        Input_Date
     C                   Exsr      EDTDAT
     C                   If        Output_Error = *Blanks
     C                   Movel     Output_Date   Wsaddt
     C                   End
     C                   End
    C                   Endsr                                                  END DEFN
     *___________________________________________________________________
     * format Date edit
     *___________________________________________________________________
    C     EDTDAT        Begsr                                                  EDIT DELETE RQS
     C                   movel     'YYYYMMDD'    Input_Format
     C                   movel     'MMDDYY'      Output_Format
     C                   Call      'FMTDATE'
     C                   Parm                    Input_Date       32
     C                   Parm                    Input_Format     32
     C                   Parm                    Output_Format    32
     C                   Parm                    Output_Date      32
     C                   Parm                    Output_Error     10
    C                   Endsr                                                  END DLT RQST
     *----------------------------------------------------------------
     *  DETERMINE IF TIME IS AM OR PM
     *----------------------------------------------------------------
     C     SRTIME        BEGSR
     *
     *  CONVERT TIME FROM FILE TO SCREEN.
     *
     C     SVAMPM        IFEQ      '  '
     C     SVTIME        IFGE      1200
     C                   MOVE      'PM'          SVAMPM            2
     C     SVTIME        IFGE      1300
     C                   SUB       1200          SVTIME            4 0
     C                   END
     C                   ELSE
     C                   MOVE      'AM'          SVAMPM
     C     SVTIME        IFLT      0100
     C                   ADD       1200          SVTIME
     C                   END
     C                   END
     *
     *  CONVERT TIME FROM SCREEN TO FILE.
     *
     C                   ELSE
     C     SVAMPM        IFEQ      'A '
     C                   MOVE      'AM'          SVAMPM
     C     SVTIME        IFGE      1200
     C                   SUB       1200          SVTIME
     C                   END
     C                   ELSE
     C     SVAMPM        IFEQ      'P '
     C     SVTIME        ANDLT     1200
     C                   MOVE      'PM'          SVAMPM
     C                   ADD       1200          SVTIME
     C                   END
     C                   END
     C                   END
     *
     C                   ENDSR
     *___________________________________________________________________
     * Key lists
     *___________________________________________________________________
    C     KLIST         Begsr                                                  KEY LISTS
    C     WKID#         Klist                                                  ACKCTL
     C                   kfld                    NHID#
    C     WKPSN1        Klist                                                  ACKCTL
     C                   kfld                    NHID#
    C                   Kfld                    WWPSN1                         POSITION TO 1
    C     WKPSN2        Klist                                                  ACKCTL
     C                   kfld                    NHID#
    C                   Kfld                    WWPSN2                         POSITION TO 1
     C     *Like         Define    NHID#         WEID#
    C     *Like         Define    NHCODE        WECODE                         POSITION TO 1
    C     WKEDIT        Klist                                                  ACKCTL
     C                   kfld                    WEID#
    C                   Kfld                    WECODE                         POSITION TO 1
    C                   Endsr                                                  END KLIST
     *___________________________________________________________________
     * Program error handler
     *___________________________________________________________________
    C     *PSSR         Begsr                                                  PROGRAM ERROR
    C                   Call      'SNDRPGM'                            50      SEND RPG MSG
    C                   Parm                    WQPGMN                         PROGRAM NAME
    C                   Parm                    WQSTSC                         STATUS CODE
    C                   Parm                    WQRPGS                         RPG STATEMENT
    C                   Parm                    WQMSG                          MESSAGE ID
    C                   Endsr     '*CANCL'                                     END PGM ERROR
     *___________________________________________________________________
**  WAO OPTION TABLE - 30X38            |OPTION 2A, ACTION 8A, DESCRIPTION 28A |
01SELECT  1=Select
02CHANGE  2=Change
03COPY    3=Copy
04DELETE  4=Delete
05DISPLAY 5=Display
07RENAME  7=Rename
**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION 8A, DESCR 30A   |
01EXIT    F1=Exit
02CANCEL  F2=PrvScr
05REFRESH F5=Refresh
06ADD     F6=Add
10PMTPSN  F10=Position
12CANCEL  F12=Cancel
25ROLLUP
26ROLLDOWN
** WTM
00You have reached the top of the list.
00Call to SLCNOT failed.  Data was not changed.
00Call to DLTNOT failed.  Data was not deleted.
00Call to DSPNOT failed.  Data was not displayed.
00No records found.
00Notes record has been Updated.
00Notes record was not added.
00Notes record could not be found.
00Notes record has been Added.
00Rename not allowed.  Code already exists.
