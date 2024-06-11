000100000331    ? *  COMPILE:
000200000407    ? *?   CRTBNDRPG  PGM(&O/&N) SRCFILE(&L/&F) DFTACTGRP(*NO) DBGVIEW(*SOURCE)
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500000331    ? *  Description:  Prompt Sample
000600000000    ? *
000700000000    ? *  (c)Copyright 2000 by Innovative Outsourcing, Inc.
000800000000    ? *  This document contains restricted materials of IO, Inc.
000900000000    ? *
001000000000    ? *  History:
001100000000    ? *_________________________________________________________________________
001200000000    ? *
001300000410    ?FFM145D    CF   E             WORKSTN
001400000000    ?F                                     INFDS(DSPD)
001500000410    ?FFM140W    IF   E           K DISK
001600000331    ?FTMPREF    IF   E           K DISK
001700000000    ? *_________________________________________________________________________
001800000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001900000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002000000331    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
002100000000    ? *_________________________________________________________________________
002200000000    ? *
002300991206    ? * Stand alone work fields
002400991206    ?D  WWFDAT         S              8  0
002500991206    ?D  WWTDAT         S              8  0
002600991206    ?D  WOFDAT         S              8
002700991206    ?D  WOTDAT         S              8
002800000331    ? *?________________________________________________________________________
002900000331    ? *?PROCEDURES
003000000331    ? /COPY QGPL/QRPGLESRC,FUNCT_PR#
003100000331    ? /COPY QGPL/QRPGLESRC,SNDRPG_PR#
003200000331    ? /COPY QGPL/QRPGLESRC,SNDMSG_PR#
003300000331    ? *
003400000000    ? * Program status data structure
003500991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003600000000    ? *
003700000000    ? * Display file data structure
003800991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003900991116    ? *
004000991116    ? * Date data structure
004100991116    ?D DATD          E DS                  EXTNAME(IODATD)
004200991206    ? *
004300000410    ? * AACODE Prompt DS
004400000410    ?D WDACD         E DS                  EXTNAME(FM140W)
004500000331    ? *
004600991206    ? * Screen Date - From
004700991116    ?D                 DS                  INZ
004800991206    ?D  WSFDAT                 1      6  0
004900991206    ?D  WDFM6                  1      2  0
005000991206    ?D  WDFD6                  3      4  0
005100991206    ?D  WDFY6                  5      6  0
005200991206    ? *
005300991206    ? * Screen Date - To
005400991206    ?D                 DS                  INZ
005500991206    ?D  WSTDAT                 1      6  0
005600991206    ?D  WDTM6                  1      2  0
005700991206    ?D  WDTD6                  3      4  0
005800991206    ?D  WDTY6                  5      6  0
005900991116    ? *
006000991206    ? * Output Date - From
006100991116    ?D                 DS                  INZ
006200991206    ?D  WDFDAT                 1      8  0
006300991206    ?D  WDFM8                  1      2  0
006400991206    ?D  WDFD8                  3      4  0
006500991206    ?D  WDFY8                  5      8  0
006600991206    ? *
006700991206    ? * Output Date - To
006800991206    ?D                 DS                  INZ
006900991206    ?D  WDTDAT                 1      8  0
007000991206    ?D  WDTM8                  1      2  0
007100991206    ?D  WDTD8                  3      4  0
007200991206    ?D  WDTY8                  5      8  0
007300991206    ? *
007400980311    ? *
007500980311    ? * CURSOR LOCATION
007600980311    ?D                 DS
007700980311    ?D  WWCRSL                 1      2
007800980311    ?D  WWCRSN                 1      2B 0
007900000000    ? *_________________________________________________________________________
008000000000    ? * Process display panel
008100000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
008200000000    ? *
008300000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
008400000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
008500000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
008600000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
008700000000 001? *
008800000000 001?C     WWFNC         Caseq     'KEYS'        PRCDKY                         DISPLAY KEYS
008900000000 001?C     WWFNC         Caseq     'EXIT'        PRCRTN                         EXIT
009000980311 001?C     WWFNC         Caseq     'PROMPT  '    PRCPMT                         PROMPT
009100000000 001?C     WWFNC         Caseq     'CANCEL'      PRCCNL                         CANCEL
009200980323 001?C     WWFNC         Caseq     'ENTER '      PRCENT                         ENTER
009300980312 001? *
009400000000 001?C                   Endcs                                                  END CASE
009500000000 001? *
009600000000E001?C                   Enddo                                                  END DOWHILE
009700980402    ?C                   Move      *ON           *INLR                          GET THE HECK OUT
009800000000    ? *___________________________________________________________________
009900000000    ? * Prepare display panel
010000000000    ? *___________________________________________________________________
010100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
010200000000    ? *
010300000000    ? * Initialize variables
010400000000    ?C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
010500000000    ?C                   Move      *BLANKS       WWOCD                          OPTION CODE
010600000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
010700000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
010800000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
010900000000    ?C                   Z-add     1             WWPNLN                         NBR OF PNLS
011000000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
011100000000    ?C                   Z-add     *ZEROS        WW                             WORK INDEX
011200980323    ?C                   Z-add     1             WWDSP                          CURRENT DSP
011300991108    ? *
011400000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
011500991108    ? *
011600000000    ?C                   Endsr                                                  END PRPPNL
011700000000    ? *___________________________________________________________________
011800000000    ? * Receive messages
011900000000    ? *___________________________________________________________________
012000000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
012100000000    ?C                   Movea     *IN           WWIN                           INDICATORS
012200000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
012300000407    ?C                   Parm      'RECEIVE '    WWRQS                          RECEIVE MESSAGES
012400000000    ?C                   Parm                    WWIN                           INDICATORS
012500000407    ?C                   Parm                    WWRTN                          RETURN CODE
012600000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
012700000000    ?C                   Endsr                                                  END RCV MSG
012800000000    ? *___________________________________________________________________
012900000000    ? * Display the display panel
013000000000    ? *___________________________________________________________________
013100000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
013200000000    ? *
013300000000    ? * Set OVERLAY based on last display file processed
013400000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
013500000000 001?C                   Setoff                                       35        OVERLAY OFF
013600000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
013700000000X001?C                   Else                                                   SAME PGM
013800000000 001?C                   Seton                                        35        OVERLAY ON
013900000000E001?C                   Endif                                                  END IF NEW PGM
014000000000    ? *
014100000000    ? * Write message subfile
014200000000    ?C                   Seton                                        30        SFLMSG DISPLAY
014300980216    ?C                   Write     MSGCTL                                       WRITE MSG SFL
014400000000    ? *
014500000000    ? * Write display panels
014600980218    ? *
014700980323B001?C     WWDSP         Ifeq      1
014800980216 001?C                   Exfmt     DSPPNL1                                      DSPLY PNL1
014900980323E001?C                   Endif
015000980323    ? *
015100000000    ?C                   Endsr                                                  END DSP DSP
015200000000    ? *___________________________________________________________________
015300000000    ? * Build function key information
015400000000    ? *___________________________________________________________________
015500000000    ?C     BLDFKY        Begsr                                                  BLD FNC KEYS
015600000331    ?C                   Eval      FUNCTION = 'BUILD   '
015700000331    ?C                   Callp     FUNCT
015800000331    ?C                   Eval      WW = WWFKS + WWFKS
015900000331    ?C                   Movel     WAD(WW)       WSFKD2
016000000331    ?C                   Eval      WW = WW -1
016100000331    ?C                   Movel     WAD(WW)       WSFKD1
016200000000    ?C                   Endsr                                                  END BLD FKY
016300000000    ? *___________________________________________________________________
016400000000    ? * Process function keys
016500000000    ? *___________________________________________________________________
016600000000    ?C     PRCFKY        Begsr                                                  PROC FNC KEYS
016700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
016800991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KEY
016900000000    ?C                   Parm      'PROCESS '    WWRQS                          PROCESS REQUEST
017000000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
017100000000    ?C                   Parm                    WAD                            FNC DESC
017200991108    ?C                   Parm                    WWIN                           *IN
017300000000    ?C                   Parm                    WAF                            FNC KEY TABLE
017400000000    ?C                   Parm                    WIFKY                          FNC KYS ALLWD
017500000000    ?C                   Endsr                                                  END PRCFKY
017600000000    ? *___________________________________________________________________
017700000000    ? * Process KEYS function
017800000000    ? *___________________________________________________________________
017900000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
018000000000    ?C                   Z-add     1             WW                             KEY DSC IDX
018100000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
018200000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
018300000000 001? *
018400000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
018500000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
018600000000 002?C                   Z-add     1             WWFKS                          SET TO 1
018700000000E002?C                   Endif                                                  END IF OVER 3
018800000000 001? *
018900000000 001?C     WWFKS         Mult      2             WW                             KEY DESCR IDX
019000000000 001?C                   Sub       1             WW                             KEY DESCR IDX
019100000000E001?C                   Enddo                                                  END DO KEYS
019200000000    ? *
019300000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
019400000000    ?C                   Sub       1             WW                             BUMP IDX
019500000000    ? *
019600000000    ?C                   Endsr                                                  END PRCDKY
019700000000    ? *___________________________________________________________________
019800000000    ? * Process RETURN function
019900000000    ? *___________________________________________________________________
020000000000    ?C     PRCRTN        Begsr                                                  PROCESS RETURN
020100000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
020200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
020300000000    ?C                   Endsr                                                  END RETURN
020400980311    ? *___________________________________________________________________
020500980311    ? * Process PROMPT function
020600980311    ? *___________________________________________________________________
020700980311    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
020800980311    ? *
020900980311    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
021000980311    ? *
021100991108    ? * PROMPT MEMBER
021200000410B001?C     WSFLD         Ifeq      'WPACOD '                                    WHERE FIELD NAME
021300000331 001?C                   Call      'PRRSLC  '                                   CALL SELECT PROGRAM
021400000331 001?C                   Parm                    WWRQS                          REQUEST
021500000331 001?C                   Parm                    WWRTN                          RETURN CODE
021600000331 001?C                   Parm                    WUPGM                          PROGRAM
021700000410 001?C                   Parm                    WDACD                          RECORD DS
021800000410B002?C     ACODE         Ifne      *blanks
021900000410 002?C                   Eval      WPACOD   =    ACODE
022000000331E002?C                   Endif
022100991116X001?C                   Else                                                               NAME
022200991108 001?C                   Movel     WTM(1)        WWMSG                          PASS MESSAGE
022300000331 001?C                   Callp     SNDMSG
022400991116E001?C                   Endif
022500980403    ? *
022600980311    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
022700980311    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
022800980311    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
022900980311    ?C                   Mvr                     WSLIN                          CURSOR COL
023000980311    ?C                   Seton                                        37        SET ON CRSLOC
023100980311    ? *
023200980311    ?C                   Endsr                                                  END PRCPMT
023300000000    ? *___________________________________________________________________
023400000000    ? * Process CANCEL function
023500000000    ? *___________________________________________________________________
023600000000    ?C     PRCCNL        Begsr                                                  PROCESS CANCEL
023700000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
023800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
023900000000    ?C                   Endsr                                                  END PRCCNL
024000000000    ? *___________________________________________________________________
024100000000    ? * Process ROLLUP function
024200000000    ? *___________________________________________________________________
024300000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
024400000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
024500000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
024600000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
024700000000E001?C                   Endif                                                  END IF GT LST PNL
024800000000    ?C                   Endsr                                                  END PRCRUP
024900000000    ? *___________________________________________________________________
025000000000    ? * Process ROLLDOWN function
025100000000    ? *___________________________________________________________________
025200000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
025300000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
025400000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
025500000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
025600000000E001?C                   Endif                                                  END IF LT FST PNL
025700000000    ?C                   Endsr                                                  END PRCRDN
025800000000    ? *___________________________________________________________________
025900000000    ? * Process ENTER function
026000000000    ? *___________________________________________________________________
026100000000    ?C     PRCENT        Begsr                                                  PROCESS ENTER
026200980323    ? *
026300980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
026400980402    ?C                   Exsr      CHKDTA                                       CHECK DATA
026500000331    ? *
026600000331    ? *************************
026700000331    ? * SET RETURN PARMS ******
026800000331    ? *************************
026900980402B001?C     WWRTN         Ifeq      *BLANKS                                      NO ERRORS
027000991206 001?C                   Movel     WWFDAT        WOFDAT
027100991206 001?C                   Movel     WWTDAT        WOTDAT
027200980402 001?C                   Move      *BLANKS       WORTN                          RETURN CODE
027300980323 001?C                   Move      'END'         WWSTT                          END PROMPT
027400980430E001?C                   Endif                                                  END RAM
027500980430    ? *
027600000000    ?C                   Endsr                                                  END PRCENT
027700980402    ? *___________________________________________________________________
027800980402    ? * Check data
027900980402    ? *___________________________________________________________________
028000980402    ?C     CHKDTA        Begsr                                                  Check data
028100980402    ? *
028200980402    ?C                   Move      *BLANKS       WWRTN                          RETURN CODE
028300980402    ?C                   Movea     *ALL'0'       *IN(60)                        RESET ERR IND
028400990329    ? *
028500991206    ? * From Date Must be valid.
028600991206    ?C                   Clear                   WDFDAT                         RESET OUTPUT
028700991116    ?C                   Call      'CHKDAT'                                     CHECK DATE
028800991206    ?C     WDFM8         Parm      WDFM6         WRM                            6 TO 8
028900991206    ?C     WDFD8         Parm      WDFD6         WRD                            6 TO 8
029000991206    ?C     WDFY8         Parm      WDFY6         WRY                            6 TO 8
029100991116    ?C                   Parm                    WWRTN                          RETURN CODE
029200991116B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
029300000315 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
029400000331 001?C                   Callp     SNDMSG
029500991116 001?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
029600991206X001?C                   Else
029700991206 001? *
029800991206 001? * To Date Must be valid.
029900991206 001?C                   Clear                   WDTDAT                         RESET OUTPUT
030000991206 001?C                   Call      'CHKDAT'                                     CHECK DATE
030100991206 001?C     WDTM8         Parm      WDTM6         WRM                            6 TO 8
030200991206 001?C     WDTD8         Parm      WDTD6         WRD                            6 TO 8
030300991206 001?C     WDTY8         Parm      WDTY6         WRY                            6 TO 8
030400991206 001?C                   Parm                    WWRTN                          RETURN CODE
030500991206B002?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
030600000315 002?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
030700000331 002?C                   Callp     SNDMSG
030800991206 002?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
030900991206E002?C                   Endif                                                  END ERROR
031000991206E001?C                   Endif                                                  END ERROR
031100991206    ? *
031200991206    ? * If dates valid, From date cannot be greater than To date.
031300991206B001?C     WWRTN         Ifeq      *BLANKS                                      IF ERROR
031400991206 001?C     WDFDAT        Mult      10000.0001    WWFDAT
031500991206 001?C     WDTDAT        Mult      10000.0001    WWTDAT
031600991206B002?C     WWFDAT        Ifgt      WWTDAT
031700000315 002?C                   Movel     WTM(4)        WWMSG                          PASS MESSAGE
031800000331 002?C                   Callp     SNDMSG
031900991206 002?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
032000991206E002?C                   Endif                                                  END ERROR
032100991206E001?C                   Endif                                                  END ERROR
032200000331    ? *
032300000410    ? * Validate AACODE.
032400000410    ?C     WPACOD        Chain     FM140W
032500000331B001?C                   If        Not %Found                                   IF ERROR
032600000331 001?C                   Movel     WTM(5)        WWMSG                          PASS MESSAGE
032700000331 001?C                   Callp     SNDMSG
032800000331 001?C                   Move      'ERROR   '    WWRTN                          RETURN ERROR
032900000331E001?C                   Endif
033000991116    ? *
033100980415    ? * WWCNT is for Enter Key control (x2)
033200991108B001?C     WWCNT         Ifeq      *ZEROS                                       and 1 Enter
033300980403 001?C     WWRTN         Andeq     *BLANKS                                      and no error
033400980403 001?C                   Add       1             WWCNT                          INC COUNT
033500980403 001?C                   Move      'WARNING '    WWRTN                          RETURN ERROR
033600980403X001?C                   Else                                                   ELSE
033700980403 001?C                   Z-add     *ZEROS        WWCNT                          SET COUNT
033800980403E001?C                   Endif                                                  ENDIF
033900980402    ? *
034000980402    ?C                   Endsr                                                  END SND MSG
034100000000    ? *___________________________________________________________________
034200000000    ? * Parameter lists
034300000000    ? *___________________________________________________________________
034400000000    ?C     PLIST         Begsr                                                  PARM LISTS
034500000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
034600000407    ?C     WWTSK         Parm                    WIRQS                          EXT MODE
034700000407    ?C                   Parm                    WORTN                          INTERNAL MODE
034800000407    ?C                   Parm                    WUPGM                          LAST PGM NAME
034900000407    ?C                   Parm                    WIFKY                          FUNCTIONS VALID
035000000410    ?C                   Parm                    WPACOD                         PMT - OUT   R
035100000331    ?C                   Parm                    WOFDAT                         PMT - OUT   R
035200991206    ?C                   Parm                    WOTDAT                         PMT - OUT   R
035300000000    ?C                   Endsr                                                  END PLIST
035400000000    ? *___________________________________________________________________
035500000000    ? * Initialize routine
035600000000    ? *___________________________________________________________________
035700000000    ?C     *INZSR        Begsr                                                  INITIALIZE
035800000000    ?C                   Movel     '*'           MSPGMQ                         SRT JOB'S MSGQ
035900000410    ?C                   Movel     'FM140W  '    WWFIL                          FILE NAME-NOTES
036000000000    ?C                   Move      *BLANKS       WWFLK                          FILE KEY - NOTES
036100000000    ?C                   Move      *BLANKS       WWTXT                          TEXT - NOTES
036200980311    ? *
036300000000    ?C                   Endsr                                                  END *INZSR
036400000000    ? *___________________________________________________________________
036500000000    ? * Define  routine
036600000000    ? *___________________________________________________________________
036700000000    ?C     DEFN          Begsr                                                  Define Fields
036800980311    ? *
036900980323    ?C     *LIKE         Define    WWPNL         WWDSP                          CURRENT DSP US PANEL
037000000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
037100000407    ?C     *LIKE         Define    WWFKY         WIFKY                          FUNCTIONS VALID
037200000407    ?C     *LIKE         Define    WWFKY         WWFKV                          FUNCTION KEY VALID
037300000407    ?C     *LIKE         Define    WWFKY         WWOPV                          OPTIONS VALID
037400000407    ? *
037500000000    ?C                   Move      WWFIL         WWFIL            10            FILE NAME-NOTES
037600000000    ?C                   Move      WWFLK         WWFLK           128            FILE KEY - NOTES
037700000000    ?C                   Move      WWTXT         WWTXT            60            TEXT - NOTES
037800980312    ? *
037900000000    ?C                   Endsr                                                  END DEFN
038000000000    ? *___________________________________________________________________
038100000000    ? * Program error handler
038200000000    ? *___________________________________________________________________
038300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
038400000331    ?C                   Callp     SNDRPG
038500000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
038600000331    ? *?__________________________________________________________________
038700000331    ? *?PROCEDURES      ________________________________________________________
038800000331    ? /COPY QGPL/QRPGLESRC,FUNCT#
038900000331    ? /COPY QGPL/QRPGLESRC,SNDRPG#
039000000331    ? /COPY QGPL/QRPGLESRC,SNDMSG#
039100000331    ? *?__________________________________________________________________
039200980312    ? *
039300991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03940000031503EXIT    F3=Exit
03950000031504PROMPT  F4=Prompt
03960000000012CANCEL  F12=Cancel
03970098032425ROLLUP
03980098032426ROLLDOWN
039900980312** WTM
04000098031200The cursor is not in a prompt area.
04010000033161From Date must be valid MMDDYY format.
04020000033162To Date must be valid MMDDYY format.
04030000033161From Date must be less than or equal to To Date.
04040000041063AACODE must be valid.
