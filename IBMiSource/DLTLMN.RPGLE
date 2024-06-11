000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300040115    ? *  Description:  Delete Broker Licensing Salesperson File
000400000000    ? *
000500040115    ? *  (c)Copyright 2004 by Group Benefit Services, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800040115    ?FDLTLMND   CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
001000030717    ?FSMAN      IF   E           K DISK
001500000000    ? *_________________________________________________________________________
001600000000    ? *
001700000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001800000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001900010219    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
002000000000    ? *_________________________________________________________________________
002100000000    ? *
002200000406    ? * Data structure
002300040115    ?D WDDTA         E DS                  EXTNAME(BLILMAN)
002400000000    ? *
002500000000    ? * Program status data structure
002600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002700000000    ? *
002800000000    ? * Display file data structure
002900991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003000000000    ? *
003100991108    ?D WDFILE        E DS                  EXTNAME(IODBFD)
003200000000    ? *___________________________________________________________________
003300000000    ? * Process delete request
003400000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003500000000    ?C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
003600000000    ?C                   Cas                     PRCERR                         PROCESS ERROR
003700000000    ?C                   Endcs                                                  END CASE
003800000000    ?C                   Return                                                 RETURN
003900000000    ? *___________________________________________________________________
004000000000    ? * Process ERROR function
004100000000    ? *___________________________________________________________________
004200000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
004300010219    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
004400000000    ?C                   Exsr      SNDMSG                                       SEND MSG
004500000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
004600000000    ?C                   Endsr                                                  END PRCERR
004700000000    ? *___________________________________________________________________
004800000000    ? * Delete record with confirmation
004900000000    ? *___________________________________________________________________
005000000000    ?C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
005100000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005200040115     C*************      EXSR      GETSMAN
005300000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005400000000 001?C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
005500000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005600000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005700000000 001?C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
005800000000 001?C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005900000000 001?C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
006000000000 001?C                   Endcs                                                  END CASE
006100000000E001?C                   Enddo                                                  END DOWHILE
006200000000    ?C                   Endsr                                                  END PRCCNF
006300030716    ? *___________________________________________________________________
006400030716    ? * GET SALESMAN
006500030716    ? *___________________________________________________________________
006600040115    ?C***  GETSMAN       Begsr                                                  PARM LISTS
007100040115     C***  LSSMAN        CHAIN     SMAN
007200040115     C***                IF        NOT %FOUND
007300040115     C***                CLEAR                   WSNAME
007400040115     C***                ELSE
007500040115     C***                EVAL      WSNAME = %trim(SFNAME) + ' ' + %trim(SLNAME)
007600040115     C***                END
009700040115    ?C***                Endsr                                                  END PLIST
009800000000    ? *___________________________________________________________________
009900000000    ? * Prepare panel
010000000000    ? *___________________________________________________________________
010100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
010200000000    ?C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
010300000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
010400000000    ?C                   Exsr      GETREC                                       GET RECORD
010500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
010600000000 001?C                   Move      WTM(2)        WWMSG                          GET MESSAGE
010700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
010800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
010900000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
011000000000E001?C                   Endif                                                  END IF ERROR
011100000000    ?C                   Endsr                                                  END PRPPNL
011200000000    ? *___________________________________________________________________
011300000000    ? * Get record for delete
011400000000    ? *___________________________________________________________________
011500000000    ?C     GETREC        Begsr                                                  GET REC FOR DLT
011600040115    ?C                   Call      'UPDLMN  '                                   PROCESS REC IO
011700000000    ?C                   Parm      'GET     '    WWRQS             8            GET RECORD
011800991201    ?C                   Parm                    WWRTN                          RETURN CODE
011900000614    ?C                   Parm                    WDDTA                          REC DATA
012000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
012100000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
012200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
012300000000 001?C                   Movel     'ERROR'       WORTN                          RETURN ERROR
012400000000 001?C                   Movel     'END'         WWSTT                          RETURN END
012500000000E001?C                   Endif                                                  END ERROR
012900000000    ?C                   Endsr                                                  END PREP CHANGE
013000000000    ? *___________________________________________________________________
013100000000    ? * Dispaly delete confirmation panel
013200000000    ? *___________________________________________________________________
013300000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
013400000000    ? * Set OVERLAY based on last display file processed
013500000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
013600000000 001?C                   Setoff                                       35        OVERLAY OFF
013700000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
013800000000X001?C                   Else                                                   SAME PGM
013900000000 001?C                   Seton                                        35        OVERLAY ON
014000000000E001?C                   Endif                                                  END IF NEW PGM
014100000000    ? * Write message subfile
014200000000    ?C                   Seton                                        30        MSGSFL DISPLAY
014300000000    ?C                   Write     MSGSFLC                                      DISPLAY MSG SFL
014400000000    ?C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
014500000000    ?C                   Endsr                                                  END DSPPNL
014600000000    ? *___________________________________________________________________
014700000000    ? * Process ENTER request
014800000000    ? *___________________________________________________________________
014900000000    ?C     PRCENT        Begsr                                                  PROC ENTER RQS
015000000000    ?C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
015100991201B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
015200000000 001?C                   Exsr      DLTREC                                       DELETE RECORD
015300000000E001?C                   Endif                                                  END IF DLT ALLOWED
015400000000    ? *
015500000000B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
015600000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
015700000000 001?C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
015800000000E001?C                   Endif                                                  END IF DLT ALLOWED
015900000000    ?C                   Endsr                                                  END PRCENT
016000000000    ? *___________________________________________________________________
016100000000    ? * Delete record
016200000000    ? *___________________________________________________________________
016300000000    ?C     DLTREC        Begsr                                                  DELETE RECORD
016400040115    ?C                   Call      'UPDLMN  '                                   PROCESS REC IO
016500000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
016600000000    ?C                   Parm                    WWRTN                          RETURN CODE
016700000614    ?C                   Parm                    WDDTA                          REC DATA
016800000000    ? *
016900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
017000000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
017100000000 001?C                   Exsr      SNDMSG                                       SEND MSG
017200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017300000000E001?C                   Endif                                                  END IF ERROR
017400000000    ?C                   Endsr                                                  END PRCENT
017500000000    ? *___________________________________________________________________
017600000000    ? * Check if delete allowed
017700000000    ? *___________________________________________________________________
017800000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
017900991201    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
018000000000    ?C                   Endsr                                                  END CHECK DLT
018100000000    ? *___________________________________________________________________
018200000000    ? * Release the record
018300000000    ? *___________________________________________________________________
018400000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
018500040115    ?C                   Call      'UPDLMN  '                                   PROCESS REC IO
018600000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
018700991201    ?C                   Parm                    WWRTN                          RETURN CODE
018800000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
018900000000    ?C                   Endsr                                                  END RELREC
019000000000    ? *___________________________________________________________________
019100000000    ? * Receive messages
019200000000    ? *___________________________________________________________________
019300000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
019400000000    ?C                   Movea     *IN           WWIN                           INDICATORS
019500000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
019600000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
019700000000    ?C                   Parm                    WWIN                           INDICATORS
019800000000    ?C                   Parm                    WWRTN                          RETURN CODE
019900000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
020000000000    ?C                   Endsr                                                  END RCV MSG
020100000000    ? *___________________________________________________________________
020200000000    ? * Build function key information
020300000000    ? *___________________________________________________________________
020400000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
020500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
020600991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
020700000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
020800000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
020900000000    ?C                   Parm                    WAD                            FNC DESC
021000991108    ?C                   Parm                    WWIN                           *IN
021100000000    ?C                   Parm                    WAF                            FNC KEY TABLE
021200000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
021300000000    ? *
021400000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
021500000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
021600000000    ?C                   Sub       1             WW                             BUMP IDX
021700000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
021800000000    ?C                   Endsr                                                  END BLD FNCTNS
021900000000    ? *___________________________________________________________________
022000000000    ? * Process function keys
022100000000    ? *___________________________________________________________________
022200000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
022300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
022400991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
022500000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
022600000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
022700000000    ?C                   Parm                    WAD                            FNC DESC
022800991108    ?C                   Parm                    WWIN                           *IN
022900000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
023000000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
023100000000    ?C                   Endsr                                                  END PROC FNCTNS
023200000000    ? *___________________________________________________________________
023300000000    ? * Process EXIT function
023400000000    ? *___________________________________________________________________
023500000000    ?C     PRCEXT        Begsr                                                  EXIT
023600000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
023700000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
023800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
023900000000    ?C                   Endsr                                                  END RETURN
024000000000    ? *___________________________________________________________________
024100000000    ? * Process CANCEL function
024200000000    ? *___________________________________________________________________
024300000000    ?C     PRCCNL        Begsr                                                  CANCEL
024400000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
024500000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
024600000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
024700000000    ?C                   Endsr                                                  END RETURN
024800000000    ? *___________________________________________________________________
024900000000    ? * Send message
025000000000    ? *___________________________________________________________________
025100000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
025200000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
025300000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
025400000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
025500000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
025600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
025700000000    ?C                   Endsr                                                  END PROC FNC
025800000000    ? *___________________________________________________________________
025900000000    ? * Parameter lists
026000000000    ? *___________________________________________________________________
026100000000    ?C     PLIST         Begsr                                                  PARM LISTS
026200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
026300000000    ?C                   Parm                    WIRQS             8            EXT MODE
026400000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
026500000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
026600000614    ?C                   Parm                    WDDTA                          RECORD DS
026700000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
026800000000    ?C                   Endsr                                                  END PLIST
026900000000    ? *___________________________________________________________________
027000000000    ? * Initialize routine
027100000000    ? *___________________________________________________________________
027200000000    ?C     *INZSR        Begsr                                                  INITIALIZE
027300000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
027400000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
027500000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
027600000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
027700000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
027800000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
027900000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
028000000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
028100000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
028200000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
028300000000    ?C                   Endsr                                                  END *INZSR
028400000000    ? *___________________________________________________________________
028500000000    ? * Program error handler
028600000000    ? *___________________________________________________________________
028700000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
028800000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
028900000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
029000000000    ?C                   Parm                    WQSTSC                         STATUS CODE
029100000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
029200000000    ?C                   Parm                    WQMSG                          MESSAGE ID
029300000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
029400000000    ? *___________________________________________________________________
029500000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02960000000003EXIT    F3=Exit
02970000000012CANCEL  F12=Cancel
029800000000** WTM
02990000000000Record not deleted. No longer available.
03000004011500Broker Licensing Salesperson record not found.
03010004011500Call to UPDLMN failed.
03020004011500Request not supported in program DLTLMN.
