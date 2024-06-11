000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300020227    ? *  Description:  Delete ISC Print Zero Commissions
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800020306    ?FDLTPWMD   CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
001000000000    ? *_________________________________________________________________________
001100000000    ? *
001200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001400020412    ?D WTM             S             80    DIM(5) CTDATA PERRCD(1)              PANEL MESSAGES
001500000000    ? *_________________________________________________________________________
001600000000    ? *
001700000406    ? * Data structure
001800020306    ?D WDDTA         E DS                  EXTNAME(PWVMNU)
001900020412    ?D WDDTL         E DS                  EXTNAME(PWVDTL)
002000000000    ? *
002100000000    ? * Program status data structure
002200991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000    ? *
002400000000    ? * Display file data structure
002500991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002600000000    ? *
002700991108    ?D WDFILE        E DS                  EXTNAME(IODBFD)
002800000000    ? *___________________________________________________________________
002900000000    ? * Process delete request
003000000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003100000000    ?C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
003200000000    ?C                   Cas                     PRCERR                         PROCESS ERROR
003300000000    ?C                   Endcs                                                  END CASE
003400000000    ?C                   Return                                                 RETURN
003500000000    ? *___________________________________________________________________
003600000000    ? * Process ERROR function
003700000000    ? *___________________________________________________________________
003800000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
003900010219    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
004000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
004100000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
004200000000    ?C                   Endsr                                                  END PRCERR
004300000000    ? *___________________________________________________________________
004400000000    ? * Delete record with confirmation
004500000000    ? *___________________________________________________________________
004600000000    ?C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
004700000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004800000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004900000000 001?C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
005000000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005100000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005200000000 001?C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
005300000000 001?C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005400000000 001?C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
005500000000 001?C                   Endcs                                                  END CASE
005600000000E001?C                   Enddo                                                  END DOWHILE
005700000000    ?C                   Endsr                                                  END PRCCNF
005800000000    ? *___________________________________________________________________
005900000000    ? * Prepare panel
006000000000    ? *___________________________________________________________________
006100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006200000000    ?C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
006300020412     C                   Z-add     0             double            1 0
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
007700020306    ?C                   Call      'UPDPWM  '                                   PROCESS REC IO
007800000000    ?C                   Parm      'GET     '    WWRQS             8            GET RECORD
007900991201    ?C                   Parm                    WWRTN                          RETURN CODE
008000000614    ?C                   Parm                    WDDTA                          REC DATA
008100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
008200000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
008300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
008400000000 001?C                   Movel     'ERROR'       WORTN                          RETURN ERROR
008500000000 001?C                   Movel     'END'         WWSTT                          RETURN END
008600000000E001?C                   Endif                                                  END ERROR
008700000000    ?C                   Endsr                                                  END PREP CHANGE
008800000000    ? *___________________________________________________________________
008900000000    ? * Dispaly delete confirmation panel
009000000000    ? *___________________________________________________________________
009100000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
009200000000    ? * Set OVERLAY based on last display file processed
009300000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
009400000000 001?C                   Setoff                                       35        OVERLAY OFF
009500000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
009600000000X001?C                   Else                                                   SAME PGM
009700000000 001?C                   Seton                                        35        OVERLAY ON
009800000000E001?C                   Endif                                                  END IF NEW PGM
009900000000    ? * Write message subfile
010000000000    ?C                   Seton                                        30        MSGSFL DISPLAY
010100000000    ?C                   Write     MSGSFLC                                      DISPLAY MSG SFL
010200000000    ?C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
010300000000    ?C                   Endsr                                                  END DSPPNL
010400000000    ? *___________________________________________________________________
010500000000    ? * Process ENTER request
010600000000    ? *___________________________________________________________________
010700000000    ?C     PRCENT        Begsr                                                  PROC ENTER RQS
010800000000    ?C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
010900991201B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
011000000000 001?C                   Exsr      DLTREC                                       DELETE RECORD
011100000000E001?C                   Endif                                                  END IF DLT ALLOWED
011200000000    ? *
011300000000B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
011400000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
011500000000 001?C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
011600000000E001?C                   Endif                                                  END IF DLT ALLOWED
011700000000    ?C                   Endsr                                                  END PRCENT
011800000000    ? *___________________________________________________________________
011900000000    ? * Delete record
012000000000    ? *___________________________________________________________________
012100000000    ?C     DLTREC        Begsr                                                  DELETE RECORD
012200020306    ?C                   Call      'UPDPWM  '                                   PROCESS REC IO
012300000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
012400000000    ?C                   Parm                    WWRTN                          RETURN CODE
012500000614    ?C                   Parm                    WDDTA                          REC DATA
012600000000    ? *
012700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
012800000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
012900000000 001?C                   Exsr      SNDMSG                                       SEND MSG
013000020412 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013100020412E001?C                   Else                                                   END IF ERROR
013200020412 001?C                   Exsr      DLTDTL                                       DELETE RECORD
013300020412E001?C                   Endif                                                  END IF ERROR
013400000000    ?C                   Endsr                                                  END PRCENT
013500020412    ? *___________________________________________________________________
013600020412    ? * Delete DETAIL
013700020412    ? *___________________________________________________________________
013800020412    ?C     DLTDTL        Begsr                                                  DELETE RECORD
013900020412     C                   Eval      PDMENU    =   PMMENU
014000020412     C                   Eval      PDOPTN    =   PMOPTN
014100020412    ?C                   Call      'UPDPWD  '                                   PROCESS REC IO
014200020412    ?C                   Parm      'DELALL  '    WWRQS                          GET REC
014300020412    ?C                   Parm                    WWRTN                          RETURN CODE
014400020412    ?C                   Parm                    WDDTL                          REC DATA
014500020412    ? *
014600020412B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
014700020412 001?C                   Move      WTM(5)        WWMSG                          GET MESSAGE
014800020412 001?C                   Exsr      SNDMSG                                       SEND MSG
014900020412 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015000020412E001?C                   Endif                                                  END IF ERROR
015100020412    ?C                   Endsr                                                  END PRCENT
015200000000    ? *___________________________________________________________________
015300000000    ? * Check if delete allowed
015400000000    ? *___________________________________________________________________
015500000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
015600020412    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
015700000000    ?C                   Endsr                                                  END CHECK DLT
015800000000    ? *___________________________________________________________________
015900000000    ? * Release the record
016000000000    ? *___________________________________________________________________
016100000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
016200020306    ?C                   Call      'UPDPWM  '                                   PROCESS REC IO
016300000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
016400991201    ?C                   Parm                    WWRTN                          RETURN CODE
016500000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
016600000000    ?C                   Endsr                                                  END RELREC
016700000000    ? *___________________________________________________________________
016800000000    ? * Receive messages
016900000000    ? *___________________________________________________________________
017000000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
017100000000    ?C                   Movea     *IN           WWIN                           INDICATORS
017200000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
017300000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
017400000000    ?C                   Parm                    WWIN                           INDICATORS
017500000000    ?C                   Parm                    WWRTN                          RETURN CODE
017600000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
017700000000    ?C                   Endsr                                                  END RCV MSG
017800000000    ? *___________________________________________________________________
017900000000    ? * Build function key information
018000000000    ? *___________________________________________________________________
018100000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
018200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
018300991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
018400000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
018500000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
018600000000    ?C                   Parm                    WAD                            FNC DESC
018700991108    ?C                   Parm                    WWIN                           *IN
018800000000    ?C                   Parm                    WAF                            FNC KEY TABLE
018900000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
019000000000    ? *
019100000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
019200000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
019300000000    ?C                   Sub       1             WW                             BUMP IDX
019400000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
019500000000    ?C                   Endsr                                                  END BLD FNCTNS
019600000000    ? *___________________________________________________________________
019700000000    ? * Process function keys
019800000000    ? *___________________________________________________________________
019900000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
020000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
020100991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
020200000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
020300000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
020400000000    ?C                   Parm                    WAD                            FNC DESC
020500991108    ?C                   Parm                    WWIN                           *IN
020600000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
020700000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
020800000000    ?C                   Endsr                                                  END PROC FNCTNS
020900000000    ? *___________________________________________________________________
021000000000    ? * Process EXIT function
021100000000    ? *___________________________________________________________________
021200000000    ?C     PRCEXT        Begsr                                                  EXIT
021300000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
021400000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
021500000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
021600000000    ?C                   Endsr                                                  END RETURN
021700000000    ? *___________________________________________________________________
021800000000    ? * Process CANCEL function
021900000000    ? *___________________________________________________________________
022000000000    ?C     PRCCNL        Begsr                                                  CANCEL
022100000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
022200000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
022300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
022400000000    ?C                   Endsr                                                  END RETURN
022500000000    ? *___________________________________________________________________
022600000000    ? * Send message
022700000000    ? *___________________________________________________________________
022800000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
022900000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
023000000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
023100000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
023200000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
023300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
023400000000    ?C                   Endsr                                                  END PROC FNC
023500000000    ? *___________________________________________________________________
023600000000    ? * Parameter lists
023700000000    ? *___________________________________________________________________
023800000000    ?C     PLIST         Begsr                                                  PARM LISTS
023900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
024000000000    ?C                   Parm                    WIRQS             8            EXT MODE
024100000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
024200000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
024300000614    ?C                   Parm                    WDDTA                          RECORD DS
024400000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
024500000000    ?C                   Endsr                                                  END PLIST
024600000000    ? *___________________________________________________________________
024700000000    ? * Initialize routine
024800000000    ? *___________________________________________________________________
024900000000    ?C     *INZSR        Begsr                                                  INITIALIZE
025000000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
025100000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
025200000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
025300000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
025400000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
025500000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
025600000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
025700000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
025800000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
025900000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
026000000000    ?C                   Endsr                                                  END *INZSR
026100000000    ? *___________________________________________________________________
026200000000    ? * Program error handler
026300000000    ? *___________________________________________________________________
026400000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
026500000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
026600000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
026700000000    ?C                   Parm                    WQSTSC                         STATUS CODE
026800000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
026900000000    ?C                   Parm                    WQMSG                          MESSAGE ID
027000000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
027100000000    ? *___________________________________________________________________
027200000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02730000000003EXIT    F3=Exit
02740000000012CANCEL  F12=Cancel
027500000000** WTM
02760000000000Record not deleted. No longer available.
02770002030600Password Validation Menu Opt record not found.
02780002030600Call to UPDPWM failed.
02790002030600Request not supported in program DLTPWM.
02800002041200Error deleting detail records.
