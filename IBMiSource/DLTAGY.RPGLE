000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010219    ? *  Description:  Delete ISC Agency
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800010219    ?FDLTAGYD   CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
001000010219    ?FISCSMN    if   e           k disk
001100010219    ?FAGENCY    if   e           k Disk
001200000000    ? *_________________________________________________________________________
001300000000    ? *
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001600010219    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001700000000    ? *_________________________________________________________________________
001800000000    ? *
001900000406    ? * Data structure
002000010219    ?D WDDTA         E DS                  EXTNAME(ISCAGY)
002100000000    ? *
002200000000    ? * Program status data structure
002300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002400000000    ? *
002500000000    ? * Display file data structure
002600991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002700000000    ? *
002800991108    ?D WDFILE        E DS                  EXTNAME(IODBFD)
002900000000    ? *___________________________________________________________________
003000000000    ? * Process delete request
003100000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003200000000    ?C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
003300000000    ?C                   Cas                     PRCERR                         PROCESS ERROR
003400000000    ?C                   Endcs                                                  END CASE
003500000000    ?C                   Return                                                 RETURN
003600000000    ? *___________________________________________________________________
003700000000    ? * Process ERROR function
003800000000    ? *___________________________________________________________________
003900000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
004000010219    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
004100000000    ?C                   Exsr      SNDMSG                                       SEND MSG
004200000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
004300000000    ?C                   Endsr                                                  END PRCERR
004400000000    ? *___________________________________________________________________
004500000000    ? * Delete record with confirmation
004600000000    ? *___________________________________________________________________
004700000000    ?C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
004800000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004900000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005000000000 001?C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
005100000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005200000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005300000000 001?C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
005400000000 001?C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005500000000 001?C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
005600000000 001?C                   Endcs                                                  END CASE
005700000000E001?C                   Enddo                                                  END DOWHILE
005800000000    ?C                   Endsr                                                  END PRCCNF
005900000000    ? *___________________________________________________________________
006000000000    ? * Prepare panel
006100000000    ? *___________________________________________________________________
006200000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006300000000    ?C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
006400000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
006500000000    ?C                   Exsr      GETREC                                       GET RECORD
006600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
006700000000 001?C                   Move      WTM(2)        WWMSG                          GET MESSAGE
006800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
006900000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
007000000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
007100000000E001?C                   Endif                                                  END IF ERROR
007200000000    ?C                   Endsr                                                  END PRPPNL
007300000000    ? *___________________________________________________________________
007400000000    ? * Get record for delete
007500000000    ? *___________________________________________________________________
007600000000    ?C     GETREC        Begsr                                                  GET REC FOR DLT
007700010219    ?C                   Call      'UPDAGY  '                                   PROCESS REC IO
007800000000    ?C                   Parm      'GET     '    WWRQS             8            GET RECORD
007900991201    ?C                   Parm                    WWRTN                          RETURN CODE
008000000614    ?C                   Parm                    WDDTA                          REC DATA
008100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
008200000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
008300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
008400000000 001?C                   Movel     'ERROR'       WORTN                          RETURN ERROR
008500000000 001?C                   Movel     'END'         WWSTT                          RETURN END
008600000000E001?C                   Endif                                                  END ERROR
008700010301     C     IAEFDT        MULT      10000.0001    WSEFDT
008800010301     C     IATRDT        MULT      10000.0001    WSTRDT
008900010301     C     IACHGD        MULT      10000.0001    WSDATE
009000000000    ?C                   Endsr                                                  END PREP CHANGE
009100000000    ? *___________________________________________________________________
009200000000    ? * Dispaly delete confirmation panel
009300000000    ? *___________________________________________________________________
009400000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
009500000000    ? * Set OVERLAY based on last display file processed
009600000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
009700000000 001?C                   Setoff                                       35        OVERLAY OFF
009800000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
009900000000X001?C                   Else                                                   SAME PGM
010000000000 001?C                   Seton                                        35        OVERLAY ON
010100000000E001?C                   Endif                                                  END IF NEW PGM
010200000000    ? * Write message subfile
010300000000    ?C                   Seton                                        30        MSGSFL DISPLAY
010400000000    ?C                   Write     MSGSFLC                                      DISPLAY MSG SFL
010500000000    ? * Write delete confirmation panel
010600010219    ?C     IAAGNY        Chain     AGENCY
010700010219B003?C                   If        %found
010800010219     C                   MOVEL     AGNAM1        WSAGNY
010900010219E003?C                   Else
011000010219     C                   Clear                   WSAGNY
011100010219E003?C                   End
011200010219    ?C     IASMAN        Chain     ISCSMN
011300010219B003?C                   If        %found
011400010219 003?C                   Eval      WSNAME   =    %trim(ISFNAM) +
011500010219 003?C                                           ' ' + ISLNAM
011600010219E003?C                   Else
011700010219     C                   Clear                   WSNAME
011800010219E003?C                   End
011900000000    ?C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
012000000000    ?C                   Endsr                                                  END DSPPNL
012100000000    ? *___________________________________________________________________
012200000000    ? * Process ENTER request
012300000000    ? *___________________________________________________________________
012400000000    ?C     PRCENT        Begsr                                                  PROC ENTER RQS
012500000000    ?C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
012600991201B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
012700000000 001?C                   Exsr      DLTREC                                       DELETE RECORD
012800000000E001?C                   Endif                                                  END IF DLT ALLOWED
012900000000    ? *
013000000000B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
013100000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
013200000000 001?C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
013300000000E001?C                   Endif                                                  END IF DLT ALLOWED
013400000000    ?C                   Endsr                                                  END PRCENT
013500000000    ? *___________________________________________________________________
013600000000    ? * Delete record
013700000000    ? *___________________________________________________________________
013800000000    ?C     DLTREC        Begsr                                                  DELETE RECORD
013900010219    ?C                   Call      'UPDAGY  '                                   PROCESS REC IO
014000000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
014100000000    ?C                   Parm                    WWRTN                          RETURN CODE
014200000614    ?C                   Parm                    WDDTA                          REC DATA
014300000000    ? *
014400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
014500000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
014600000000 001?C                   Exsr      SNDMSG                                       SEND MSG
014700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014800000000E001?C                   Endif                                                  END IF ERROR
014900000000    ?C                   Endsr                                                  END PRCENT
015000000000    ? *___________________________________________________________________
015100000000    ? * Check if delete allowed
015200000000    ? *___________________________________________________________________
015300000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
015400991201    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
015500000000    ?C                   Endsr                                                  END CHECK DLT
015600000000    ? *___________________________________________________________________
015700000000    ? * Release the record
015800000000    ? *___________________________________________________________________
015900000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
016000010219    ?C                   Call      'UPDAGY  '                                   PROCESS REC IO
016100000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
016200991201    ?C                   Parm                    WWRTN                          RETURN CODE
016300000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
016400000000    ?C                   Endsr                                                  END RELREC
016500000000    ? *___________________________________________________________________
016600000000    ? * Receive messages
016700000000    ? *___________________________________________________________________
016800000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
016900000000    ?C                   Movea     *IN           WWIN                           INDICATORS
017000000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
017100000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
017200000000    ?C                   Parm                    WWIN                           INDICATORS
017300000000    ?C                   Parm                    WWRTN                          RETURN CODE
017400000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
017500000000    ?C                   Endsr                                                  END RCV MSG
017600000000    ? *___________________________________________________________________
017700000000    ? * Build function key information
017800000000    ? *___________________________________________________________________
017900000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
018000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
018100991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
018200000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
018300000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
018400000000    ?C                   Parm                    WAD                            FNC DESC
018500991108    ?C                   Parm                    WWIN                           *IN
018600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
018700000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
018800000000    ? *
018900000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
019000000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
019100000000    ?C                   Sub       1             WW                             BUMP IDX
019200000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
019300000000    ?C                   Endsr                                                  END BLD FNCTNS
019400000000    ? *___________________________________________________________________
019500000000    ? * Process function keys
019600000000    ? *___________________________________________________________________
019700000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
019800991108    ?C                   Movea     *IN           WWIN                           INDICATORS
019900991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
020000000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
020100000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
020200000000    ?C                   Parm                    WAD                            FNC DESC
020300991108    ?C                   Parm                    WWIN                           *IN
020400000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
020500000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
020600000000    ?C                   Endsr                                                  END PROC FNCTNS
020700000000    ? *___________________________________________________________________
020800000000    ? * Process EXIT function
020900000000    ? *___________________________________________________________________
021000000000    ?C     PRCEXT        Begsr                                                  EXIT
021100000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
021200000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
021300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
021400000000    ?C                   Endsr                                                  END RETURN
021500000000    ? *___________________________________________________________________
021600000000    ? * Process CANCEL function
021700000000    ? *___________________________________________________________________
021800000000    ?C     PRCCNL        Begsr                                                  CANCEL
021900000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
022000000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
022100000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
022200000000    ?C                   Endsr                                                  END RETURN
022300000000    ? *___________________________________________________________________
022400000000    ? * Send message
022500000000    ? *___________________________________________________________________
022600000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
022700000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
022800000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
022900000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
023000000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
023100000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
023200000000    ?C                   Endsr                                                  END PROC FNC
023300000000    ? *___________________________________________________________________
023400000000    ? * Parameter lists
023500000000    ? *___________________________________________________________________
023600000000    ?C     PLIST         Begsr                                                  PARM LISTS
023700000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
023800000000    ?C                   Parm                    WIRQS             8            EXT MODE
023900000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
024000000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
024100000614    ?C                   Parm                    WDDTA                          RECORD DS
024200000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
024300000000    ?C                   Endsr                                                  END PLIST
024400000000    ? *___________________________________________________________________
024500000000    ? * Initialize routine
024600000000    ? *___________________________________________________________________
024700000000    ?C     *INZSR        Begsr                                                  INITIALIZE
024800000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
024900000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
025000000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
025100000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
025200000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
025300000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
025400000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
025500000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
025600000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
025700000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
025800000000    ?C                   Endsr                                                  END *INZSR
025900000000    ? *___________________________________________________________________
026000000000    ? * Program error handler
026100000000    ? *___________________________________________________________________
026200000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
026300000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
026400000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
026500000000    ?C                   Parm                    WQSTSC                         STATUS CODE
026600000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
026700000000    ?C                   Parm                    WQMSG                          MESSAGE ID
026800000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
026900000000    ? *___________________________________________________________________
027000000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02710000000003EXIT    F3=Exit
02720000000012CANCEL  F12=Cancel
027300000000** WTM
02740000000000Record not deleted. No longer available.
02750001021900Internal Sales Commission record not found.
02760001021900Call to UPDAGY failed.
02770001021900Request not supported in program DLTAGY.
