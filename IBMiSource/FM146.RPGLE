000100000407    ? *? COMPILE:
000200000407    ? *?   CRTBNDRPG  PGM(&O/&N) SRCFILE(&L/&F) DFTACTGRP(*NO) DBGVIEW(*SOURCE)
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500000000    ? *  Description:  Select - Sample Data
000600000000    ? *
000700000000    ? *  (c)Copyright 2000 by Innovative Outsourcing, Inc.
000800000000    ? *  This document contains restricted materials of IO, Inc.
000900000000    ? *
001000000000    ? *  History:
001100000000    ? *_________________________________________________________________________
001200000410    ?FFM146D    CF   E             WORKSTN
001300000000    ?F                                     SFILE(LSTSFL:WFRRN)
001400000000    ?F                                     INFDS(DSPD)
001500000410    ?FFM140W    IF   E           K DISK
001600000410    ?F                                     RENAME(AACODR:PSN1)
001700000407    ?FTMPREF    IF   E           K DISK
001800000407    ? *?________________________________________________________________________
001900000407    ? * TABLE/ARRAYS
002000000000    ?D WAO             S             38    DIM(30) CTDATA PERRCD(1)             OPTION TABLE
002100000000    ?D WAP             S             75    DIM(6)                               OPTION DESC
002200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002300000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002400000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
002500000407    ? *?________________________________________________________________________
002600000407    ? * WORK FIELDS
002700000407    ?D WWOPV           S             60
002800000407    ?D WWFKV           S             60
002900000407    ?D WWENDO          S              3
003000000407    ?D WWPSN1          S                   LIKE(WSPSN1)
003100000407    ? *
003200000407    ? *?________________________________________________________________________
003300000407    ? *?PROCEDURES
003400000407      /COPY QGPL/QRPGLESRC,FUNCT_PR#
003500000407      /COPY QGPL/QRPGLESRC,SNDRPG_PR#
003600000407      /COPY QGPL/QRPGLESRC,SNDMSG_PR#
003700000407    ? *?________________________________________________________________________
003800000331    ? * Data structure
003900000410    ?D WUDTA         E DS                  EXTNAME(FM140W)
004000000000    ? *
004100000000    ? * Option code data structure
004200000000    ?D                 DS
004300000000    ?D  WDOPC                  1      2
004400000000    ?D  WDOPC1                 1      1
004500000000    ?D  WDOPC2                 2      2
004600000000    ? *
004700000000    ? * CURSOR LOCATION
004800000000    ?D                 DS
004900000000    ?D  WWCRSL                 1      2
005000000000    ?D  WWCRSN                 1      2B 0
005100000000    ? *
005200000000    ? * Program status data structure
005300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
005400000000    ? *
005500000000    ? * Display file data structure
005600991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
005700000000    ? *___________________________________________________________________
005800000407    ? * Process Panel
005900000407    ?C                   If        WIRQS   <>   'SLCNXT  '                      IF NOT NEXT SELECT
006000000407    ?C                   Exsr      DEFN                                         DEFINE FIELDS
006100000407    ?C                   End                                                    ENDIF NEXT SELECT
006200000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
006300000000    ? *
006400000407    ?C                   Dow       WWENDF  <>   'END'                           DOWHILE NOT END
006500000407    ?C                   Exsr      RCVMSG                                       RECEIVE MSGS
006600000407    ?C                   Exsr      DSPPNL                                       DISPLAY PANEL
006700000407     C                   EVAL      FUNCTION = 'PROCESS '
006800000407     C                   CALLP     FUNCT
006900000407    ? *
007000000407    ?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
007100000407    ?C     WWFKA         Caseq     'REFRESH '    PRCRFR                         REFRESH
007200000407    ?C     WWFKA         Caseq     'PMTPSN  '    PRCPMT                         PMT POSITION TO
007300000407    ?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
007400000407    ?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
007500000407    ?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLLDOWN
007600000407    ?C     WWFKA         Caseq     'ENTER   '    PRCENT                         ENTER
007700000407    ?C                   Endcs                                                  END CASE
007800000407    ?C                   Enddo                                                  END DOWHILE
007900000000    ? *
008000000000    ?C                   Write     REMOVE                                       REMOVE WINDOW
008100000407     C                   Eval      *INLR    =    *ON
008200000000    ? *___________________________________________________________________
008300000000    ? * Prepare list panel
008400000000    ? *___________________________________________________________________
008500000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
008600000000    ?C                   Exsr      SETPSN                                       SET POSITION TO IND
008700000000    ? *
008800000407    ?C                   If        WIRQS   =   'SLCNXT'                         IF SELECT NEXT
008900000407    ?C                   Exsr      SLCNXT                                       SELECT NEXT
009000000407    ?C                   Else                                                   ELSE
009100000407    ?C                   Exsr      PRCPSN                                       PROC POSITION TO
009200000407    ?C                   End                                                    END IF SELECT NEXT
009300000407    ? *
009400000000    ?C                   Endsr                                                  END PRPPNL
009500000000    ? *___________________________________________________________________
009600000000    ? * Set position to screen indicators
009700000000    ? *___________________________________________________________________
009800000000    ?C     SETPSN        Begsr                                                  SET POSITION TO
009900000407    ?C     WWPSNI        Do        WWLMT         WW                             DO FOR NBR VIEWS
010000000407    ?C                   Move      '0'           *IN(WW)                        SET OFF PSN
010100000407    ?C                   Enddo                                                  END DO
010200000407     C                   Eval      WW      =     WWPSNI + WWPSNP
010300000407     C                   Eval      WW      =     WW - 1
010400000000    ?C                   Move      '1'           *IN(WW)                        DISPLAY PSN TO
010500000000    ?C                   Endsr                                                  END SETPSN
010600000000    ? *___________________________________________________________________
010700000000    ? * Display list panel
010800000000    ? *___________________________________________________________________
010900000000    ?C     DSPPNL        Begsr                                                  DISPALY PANEL
011000000000    ? *
011100000000    ? * Set OVERLAY based on last display file processed
011200000407    ?C                   If        WQPGMN   <>   WUPGM                          IF NEW PROGRAM
011300000407    ?C                   Eval      *IN35    =    *OFF                           OVERLAY OFF
011400000407    ?C                   Eval      WUPGM    =    WQPGMN                         OVERLAY OFF
011500000407    ?C                   Else                                                   ELSE SAME PGM
011600000407    ?C                   Eval      *IN35    =    *ON                            OVERLAY OFF
011700000407    ?C                   End                                                    END IF NEW PGM
011800000000    ? *
011900000000    ? * Write message subfile
012000000407    ?C                   Eval      *IN30    =    *ON                            OVERLAY OFF
012100000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
012200000000    ? *
012300000000    ? * Write function keys
012400000407    ?C                   If        *IN35    =    *OFF                           IF OVERLAY OFF
012500000407    ?C                   Write     FKYDSC                                       DSP FNC KEY DSC
012600000407    ?C                   End                                                    END IF F KEY SET
012700000000    ? *
012800000000    ? * Set subfile control panel overrides
012900000407    ?C                   If        WWPSNC    =   'Y'                            IF PSN CHANGED
013000000407    ?C                   Eval      *IN36     =   *OFF                           DO NOT PUTOVR
013100000407    ?C                   Eval      WWPSNC    =   'N'                            DO NOT PUTOVR
013200000407    ?C                   Else                                                   ELSE
013300000407    ?C                   Eval      *IN36     =   *ON                            DO NOT PUTOVR
013400000407    ?C                   End                                                    END IF PSN
013500000000    ? *
013600000000    ? * Set subfile control inticators
013700000407    ?C                   If        WFRRN     =   0                              IF SUBFILE EMPTY
013800000407    ?C                   Eval      *IN30     =   *OFF                           DO NOT PUTOVR
013900000407    ?C                   Else                                                   ELSE SUBFILE
014000000407    ?C                   Eval      *IN30     =   *ON                            DO NOT PUTOVR
014100000407    ?C                   End                                                    END IF SFL EMPTY
014200000000    ? *
014300000000    ? * Write subfile
014400000000    ?C                   Exfmt     LSTCTL                                       DSP LST PANEL
014500000000    ?C                   Z-add     WDLOWR        WWLOWR                         SAVE SFL RCD NBR
014600000000    ?C                   Z-add     WDLOWR        WSPAG                          SET CURRENT PAGE
014700000407    ?C                   Eval      *IN62     =   *OFF                           DO NOT PUTOVR
014800000407    ?C                   Eval      *IN63     =   *OFF                           DO NOT PUTOVR
014900000407    ?C                   Eval      *IN36     =   *OFF                           DO NOT PUTOVR
015000000000    ?C                   Endsr                                                  END DSPPNL
015100000000    ? *___________________________________________________________________
015200000000    ? * Process EXIT function
015300000000    ? *___________________________________________________________________
015400000000    ?C     PRCEXT        Begsr                                                  PROCESS EXIT
015500000407     C                   Eval      WORTN   =     WWFKA
015600000407     C                   Eval      WWENDF  =     'END'
015700000000    ?C                   Endsr                                                  END PRCEXT
015800000000    ? *___________________________________________________________________
015900000000    ? * Process REFRESH function
016000000000    ? *___________________________________________________________________
016100000000    ?C     PRCRFR        Begsr                                                  PROCESS REFRESH
016200000000    ?C                   Exsr      PRCPSN                                       POSITION TO
016300000407    ?C     WSPAG         Dowlt     WWLOWR                                       DO WHILE NOT PRV PAG
016400000407    ?C     WWSFLE        Andne     'Y'                                          AND NOT EOF
016500000407    ?C                   Exsr      PRCRUP                                       LOAD SUBFILE
016600000407    ?C                   Enddo                                                  END DO NOT PRV PAG
016700000000    ?C                   Endsr                                                  END PRCRFR
016800000000    ? *___________________________________________________________________
016900000000    ? * Process CANCEL function
017000000000    ? *___________________________________________________________________
017100000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
017200000407     C                   Eval      WORTN   =     WWFKA
017300000407     C                   Eval      WWENDF  =     'END'
017400000000    ?C                   Endsr                                                  END PRCCNL
017500000000    ? *___________________________________________________________________
017600000000    ? * Process POSITION TO function
017700000000    ? *___________________________________________________________________
017800000000    ?C     PRCPMT        Begsr                                                  PROCESS POSITION
017900000000    ? *
018000000000    ?C                   Move      '     '       WSFLD                          TRUNCATE FIELD
018100000407    ?C                   If        WSFLD    =   'WSPSN'                         IF CURSOR ON PSN
018200000407    ?C                   Eval      WWPSNP   =    WWPSNP + 1                     BUMP PSN TO VIEW
018300000407     C                   If        WWPSNP   >    WWPSNN
018400000407    ?C                   Eval      WWPSNP   =    1                              BUMP PSN TO VIEW
018500000407    ?C                   End                                                    END IF GT HIGH PSN
018600000407    ? *
018700000407    ?C                   Exsr      SETPSN                                       SET PSN TO IND
018800000407    ?C                   End                                                    END IF CSR ON PSN
018900000000    ? *
019000000407     C                   Eval      *IN63    =    *ON
019100000407     C                   Eval      WWPSNC   =    'Y'
019200000000    ? *
019300000000    ?C                   Endsr                                                  END PRCPMT
019400000000    ? *___________________________________________________________________
019500000000    ? * Process ROLL UP function (add a page to list subfile)
019600000000    ? *___________________________________________________________________
019700000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
019800000407     C                   Eval      WWSFLE   =    'N'
019900000407     C                   Eval      WSPAG    =    WWRRN
020000000407    ?C                   Eval      WW       =    1                              SFL PAG = LAST PAGE
020100000407    ?C                   Eval      WFRRN    =    WWRRN                          WINDOW INDEX
020200000407    ?C                   Eval      *IN50    =    *OFF                           HIGH SFL RRN
020300000407    ?C                   Eval      *IN60    =    *OFF                           RESET EOF IND
020400000407    ?C                   Eval      *IN61    =    *OFF                           SUBFILE SRC CTL
020500000000    ?C                   Clear                   LSTSFL                         BLANK SFL RECORD
020600000000    ? *
020700000407     C                   Dow       WW     <=     WWLSTS  and
020800000407     C                             *IN50   =     *OFF
020900000407     C                   If        WWPSNP  =     1
021000000410    ?C                   Read      FM140W                                 50    READ FILE
021100000407    ?C                   End                                                    END IF PSN VIEW 1
021200000407     C                   If        *IN50   =     *OFF
021300000407     C                   Eval      WFRRN   =     WFRRN + 1
021400000407     C                   Eval      WW      =     WW    + 1
021500000407    ?C                   Write     LSTSFL                                       WRITE SFL REC
021600000407    ?C                   Else                                                   ELSE EOF
021700000407     C                   Eval      WWSFLE  =     'Y'
021800000407    ?C                   Endif                                                  END IF REC READ
021900000407    ? *
022000000407    ?C                   Enddo                                                  END DO
022100000000    ? *
022200000407     C                   If        WFRRN    >    WWRRN
022300000407     C                   Eval      WSPAG    =    WWRRN + 1
022400000407     C                   Eval      WWRRN    =    WFRRN
022500000407    ?C                   End                                                    END IF RCDS ADDED
022600000000    ? *
022700000407     C                   If        WFRRN    =    0
022800000407    ?C                   Move      WTM(3)        WWMSG                          EOF MSG
022900000407     C                   CALLP     SNDMSG
023000000407    ?C                   End                                                    IF SFL EMPTY
023100000000    ? *
023200000407     C                   If        WWSFLE   =    'Y'
023300000407    ?C                   Move      WTM(2)        WWMSG                          EOF MSG
023400000407     C                   CALLP     SNDMSG
023500000407    ?C                   Endif                                                  END IF END OF FILE
023600000000    ? *
023700000000    ?C                   Endsr                                                  END PRCRUP
023800000000    ? *___________________________________________________________________
023900000000    ? * Process ROLLDOWN function (beginning of SFL reached)
024000000000    ? *___________________________________________________________________
024100000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
024200000407     C                   Eval      WSPAG    =    1
024300000000    ?C                   Move      WTM(1)        WWMSG                          BGN SFL MSG
024400000407     C                   CALLP     SNDMSG
024500000000    ?C                   Endsr                                                  END PRCRDN
024600000000    ? *___________________________________________________________________
024700000000    ? * Process ENTER function
024800000000    ? *___________________________________________________________________
024900000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
025000000407     C                   Eval      WWENDO    =   *BLANKS
025100000407     C                   Eval      WWRTN     =   *BLANKS
025200000407     C                   Eval      *IN50     =   *OFF
025300000000    ? *
025400000407     C                   If        WFRRN     >   0
025500000407    ? *
025600000407     C                   Dow       WWENDO   <>   'END'  and
025700000407     C                             *IN50    <>   *ON
025800000407    ?C                   Readc     LSTSFL                                 50    READ CHNG SBF
025900000407    ? *
026000000407     C                   If        *IN50     =   *OFF   and
026100000407     C                             WSOPC    <>   *BLANKS
026200000407    ?C                   Exsr      PRCSLC                                       PROCESS SELECTION
026300000407    ?C                   Exsr      PRCRTN                                       PROCESS OPT RETURN
026400000407    ?C                   End                                                    END IF SELECTION
026500000407    ?C                   Enddo                                                  END DO WHILE NOT END
026600000407    ?C                   End                                                    END IF SFL RCDS
026700000000    ? *
026800000407     C                   If        *IN38    =    *ON   and
026900000407     C                             WWENDO  <>    'END'
027000000407     C                   If        WWPSNP   =    1
027100000407     C                   Eval      WWPSN1   =    WSPSN1
027200000407    ?C                   End                                                    IF PSN VIEW 1
027300000407    ?C                   Exsr      PRCPSN                                       PROC POSTN TO
027400000407    ?C                   End                                                    IF PSN PMT
027500000000    ?C                   Endsr                                                  END PRCENT
027600000000    ? *___________________________________________________________________
027700000000    ? * Receive messages from a data queue and send to program queue
027800000000    ? *___________________________________________________________________
027900000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
028000000000    ?C                   Movea     *IN           WWIN                           INDICATORS
028100000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
028200000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST MSG DSP
028300000000    ?C                   Parm                    WWIN                           INDICATORS
028400000000    ?C                   Parm                    WWRTN                          RETURN CODE
028500000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
028600000000    ?C                   Endsr                                                  END RCV MSG
028700000000    ? *___________________________________________________________________
028800000000    ? * Clear list subfile
028900000000    ? *___________________________________________________________________
029000000000    ?C     CLRSFL        Begsr                                                  CLEAR SUBFILE
029100000407     C                   Eval      *IN31    =    *ON
029200000000    ?C                   Write     LSTCTL                                       CLEAR SUBFILE
029300000407     C                   Eval      *IN31    =    *OFF
029400000407     C                   Eval      WSPAG    =    0
029500000407     C                   Eval      WFRRN    =    0
029600000407     C                   Eval      WWRRN    =    0
029700000000    ?C                   Endsr                                                  END CLEAR SFL
029800000000    ? *___________________________________________________________________
029900000000    ? * Process SLCNXT Request
030000000000    ? *___________________________________________________________________
030100000000    ?C     SLCNXT        Begsr                                                  SELECT NEXT
030200000000    ?C                   Movel     'ERROR'       WORTN                          SET RETURN CODE
030300000407     C                   Eval      WWENDO    =   *BLANKS
030400000407     C                   If        WFRRN     >   0
030500000407    ? *
030600000407    ?C                   Dow       WWENDO   <>  'END'                           DOWHILE NOT END
030700000407    ?C                   Readc     LSTSFL                                 50    READ CHNG SBF
030800000407    ? *
030900000407     C                   If        *IN50     =   *OFF
031000000407     C                   If        WSOPC    <>   *BLANKS
031100000407    ?C                   Exsr      PRCOPT                                       PROCESS OPTION
031200000407     C                   If        WWOPA     =   'SELECT'
031300000407    ?C                   Exsr      PRCSEL                                       PROCESS SELECT
031400000407    ?C                   End                                                    END IF SELECT
031500000407    ?C                   End                                                    END IF OPTION CODE
031600000407    ? *
031700000407    ?C                   Else                                                   ELSE
031800000407     C                   Eval      WWENDO    =   'END'
031900000407    ?C                   End                                                    END IF CHG RCD
032000000407    ?C                   Enddo                                                  END DO WHILE NOT END
032100000407    ?C                   End                                                    END IF SFL RCDS
032200000000    ? *
032300000407     C                   Eval      WWENDF    =   'END'
032400000000    ?C                   Endsr                                                  END SLCNXT
032500000000    ? *___________________________________________________________________
032600000000    ? * Process option selected
032700000000    ? *___________________________________________________________________
032800000000    ?C     PRCOPT        Begsr                                                  PROCESS OPTION
032900000407     C                   Eval      WWRQS    =    *BLANKS
033000000407     C                   Eval      WDOPC    =    WSOPC
033100000000    ? *
033200000407    ?C                   CALL      'TMPRCOPT'
033300000407     C                   PARM      WDOPC         WWRQS
033400000407     C     WWOPA         PARM                    WWRTN
033500000407     C                   PARM                    WAP
033600000407     C                   PARM                    WAO
033700000407     C                   PARM                    WIOPV
033800000000    ?C                   Endsr                                                  END PRCOPT
033900000000    ? *___________________________________________________________________
034000000000    ? * Process selection
034100000000    ? *___________________________________________________________________
034200000000    ?C     PRCSLC        Begsr                                                  PROCESS SELECTION
034300000000    ?C                   Exsr      PRCOPT                                       PROCESS OPTION
034400000000    ?C     WWOPA         Caseq     'DISPLAY'     PRCDSP                         DISPLAY
034500000000    ?C     WWOPA         Caseq     'SELECT'      PRCSEL                         SELECT
034600000000    ?C                   Endcs                                                  END CASE
034700000000    ?C                   Endsr                                                  END PRCSLC
034800000000    ? *___________________________________________________________________
034900000000    ? * Process SELECT Option
035000000000    ? *___________________________________________________________________
035100000000    ?C     PRCSEL        Begsr                                                  PROCESS SELECT
035200000407     C                   Eval      WWENDO   =    'END'
035300000407     C                   Eval      WWENDF   =    'END'
035400000407     C                   Eval      WORTN    =    *BLANKS
035500000000    ?C                   Endsr                                                  END PRCSEL
035600000000    ? *___________________________________________________________________
035700000000    ? * Process DISPLAY option
035800000000    ? *___________________________________________________________________
035900000000    ?C     PRCDSP        Begsr                                                  DISPLAY
036000000000    ?C                   Endsr                                                  END PRC DSPL
036100000000    ? *___________________________________________________________________
036200000000    ? * Process option Return
036300000000    ? *___________________________________________________________________
036400000000    ?C     PRCRTN        Begsr                                                  PROCESS OPT RTN
036500000000    ? *
036600000407     C                   If        WWRTN    =    'ERROR'
036700000407    ?C                   Eval      *IN60    =    *ON                            IF RTN ERROR
036800000407    ?C                   Eval      WWENDO   =    'END'                          REVERSE IMAGE OPT
036900000407    ?C                   Else                                                   ELSE
037000000407    ?C                   Eval      *IN60    =    *OFF                           IF RTN ERROR
037100000407    ?C                   Eval      WSOPC    =    *BLANKS                        CLEAR OPTION
037200000407    ?C                   End                                                    ENDIF ERROR
037300000000    ? *
037400000407    ?C                   If        WWRTN    =    'CANCEL'                       IF CANCEL
037500000407    ?C                   Eval      WWENDO   =    'END'                          REVERSE IMAGE OPT
037600000407    ?C                   End                                                    END IF EXIT/CANCEL
037700000000    ? *
037800000000    ?C                   Update    LSTSFL                                       UPDATE SFL
037900000407    ?C                   Eval      WSPAG    =    WFRRN                          SET SFL PAGE
038000000000    ?C                   Endsr                                                  END PRCRTN
038100000000    ? *___________________________________________________________________
038200000000    ? * Process POSITION TO option
038300000000    ? *___________________________________________________________________
038400000000    ?C     PRCPSN        Begsr                                                  POSITION TO
038500000407    ?C                   If        WWPSNP   =    1                              IF PSN VIEW 1
038600000410    ?C     WKPSN1        Setll     FM140W                                       PSN DB CURSOR
038700000407    ?C                   Clear                   WSPSN1                         CLEAR PSN TO
038800000407    ?C                   End                                                    IF PSN VIEW 1
038900000000    ?C                   Exsr      CLRSFL                                       CLEAR SUBFILE
039000000000    ?C                   Exsr      PRCRUP                                       LOAD SUBFILE
039100000407    ?C                   Eval      WWPSNC   =    'Y'                            SET PSN CHANGED
039200000000    ?C                   Endsr                                                  END POSITION TO
039300000000    ? *___________________________________________________________________
039400000000    ? * Parameter lists
039500000000    ? *___________________________________________________________________
039600000000    ?C     PLIST         Begsr                                                  PARM LISTS
039700000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
039800000407    ?C                   Parm                    WIRQS                          PROGRAM REQUEST
039900000407    ?C                   Parm                    WORTN                          RETURN CODE
040000000407    ?C                   Parm                    WUPGM                          LAST PGM NAME
040100000210    ?C                   Parm                    WUDTA                          RECORD DS
040200000000    ?C                   Endsr
040300000000    ? *___________________________________________________________________
040400000000    ? * Define Variables
040500000000    ? *___________________________________________________________________
040600000000    ?C     DEFN          Begsr                                                  DEFINITIONS
040700000407    ?C                   Eval      WWOPV     =   *BLANKS                        OPTIONS VALID
040800000407    ?C                   Eval      WWFKV     =   *BLANKS                        FUNCTIONS VALID
040900000407    ?C                   Eval      WWENDO    =   *BLANKS                        OPTION CONTROL
041000000407     C                   Eval      WWIN      =   *BLANKS
041100000407    ?C                   Eval      WWFKA     =   *BLANKS                        INDICATOR FIELD
041200000407    ?C                   Eval      WWENDF    =   *BLANKS                        FUNCTION ACTION
041300000407    ?C                   Eval      WWOPA     =   *BLANKS                        FUNCTION CONTROL
041400000407    ?C                   Eval      WWSFLE    =   'N'                            OPTION ACTION
041500000407    ?C                   Eval      WWLOWR    =   0                              SUBFILE END
041600000407    ?C                   Eval      WW        =   0                              SUB FILE LOW REL REC
041700000407    ?C                   Eval      WWLSTS    =   5                              ARRAY  INDEX
041800000407    ?C                   Eval      WFRRN     =   0                              LST SFL PAG SIZ
041900000407    ?C                   Eval      WWRRN     =   0                              LST SFL RRN
042000000407    ?C                   Eval      WWPSNP    =   1                              LST SFL HIGH RRN
042100000407    ?C                   Eval      WWPSNC    =   'Y'                            POSITION TO VIEW#
042200000407    ?C                   Eval      WWPSNN    =   1                              POSITION TO CHANGED
042300000407    ?C                   Eval      WWPSN1    =   *ZEROS                         FUNCTION CONTROL
042400000407    ?C                   Eval      WWPSNI    =   41                             POSITION TO CHANGED
042500000407     C                   Eval      WWLMT     =   (WWPSNI + WWPSNN) - 1
042600000000    ?C                   Movel     '*'           MSPGMQ                         MSG SFL JOB MSGQ
042700000407    ?C                   Eval      WSOPC     =   *BLANKS                        OPTION CODE
042800000000    ?C                   Endsr                                                  END DEFN
042900000000    ? *___________________________________________________________________
043000000000    ? * Key lists
043100000000    ? *___________________________________________________________________
043200000000    ?C     KLIST         Begsr                                                  KEY LISTS
043300000210    ?C     WKPSN1        Klist
043400000309    ?C                   Kfld                    WWPSN1                         POSITION TO 1
043500000000    ?C                   Endsr                                                  END KLIST
043600000000    ? *___________________________________________________________________
043700000000    ? * Program error handler
043800000000    ? *___________________________________________________________________
043900000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
044000000407     C                   CALLP     SNDRPG
044100000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
044200000407      *?__________________________________________________________________
044300000407      *?PROCEDURES      ________________________________________________________
044400000407      /COPY QGPL/QRPGLESRC,FUNCT#
044500000407      /COPY QGPL/QRPGLESRC,SNDRPG#
044600000407      /COPY QGPL/QRPGLESRC,SNDMSG#
044700000000    ? *___________________________________________________________________
044800000000**  WAO OPTION TABLE - 30X38            |OPTION 2A, ACTION 8A, DESCRIPTION 28A |
044900000000 1SELECT  1=Select
045000000000 5DISPLAY 5=Display
045100000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION 8A, DESCR 30A   |
04520000000003EXIT    F3=Exit
04530000000005REFRESH F5=Refresh
04540000000010PMTPSN  F10=Position
04550000000012CANCEL  F12=Cancel
04560000000025ROLLUP
04570000000026ROLLDOWN
045800000000** WTM
04590000000000You have reached the top of the list.
04600000000000You have reached the bottom of the list.
04610000000000No records found.
