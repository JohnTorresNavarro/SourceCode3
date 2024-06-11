000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300070216    ? *  Description:  Delete Market Exclude Account
000400000000    ? *
000500070216    ? *  (c)Copyright 2007 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800070216    ?FDLTMKED   CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
001000070216    ?FMKTRNE    if   e           k disk
001200060712    ?FACCMST    if   e           k disk
001300000000    ? *_________________________________________________________________________
001400000000    ? *
001500000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001600000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001700010219    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001800000000    ? *_________________________________________________________________________
001900000000    ? *
002000000406    ? * Data structure
002100070216    ?D WDDTA         E DS                  EXTNAME(MKTRNE)
003200000000    ? *
003300000000    ? * Program status data structure
003400991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003500000000    ? *
003600000000    ? * Display file data structure
003700991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003800000000    ? *
003900991108    ?D WDFILE        E DS                  EXTNAME(IODBFD)
004000000000    ? *___________________________________________________________________
004100000000    ? * Process delete request
004200000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
004300000000    ?C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
004400000000    ?C                   Cas                     PRCERR                         PROCESS ERROR
004500000000    ?C                   Endcs                                                  END CASE
004600000000    ?C                   Return                                                 RETURN
004700000000    ? *___________________________________________________________________
004800000000    ? * Process ERROR function
004900000000    ? *___________________________________________________________________
005000000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
005100010219    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
005200000000    ?C                   Exsr      SNDMSG                                       SEND MSG
005300000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
005400000000    ?C                   Endsr                                                  END PRCERR
005500000000    ? *___________________________________________________________________
005600000000    ? * Delete record with confirmation
005700000000    ? *___________________________________________________________________
005800000000    ?C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
005900000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
006000000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
006100000000 001?C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
006200000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
006300000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
006400000000 001?C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
006500000000 001?C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006600000000 001?C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
006700000000 001?C                   Endcs                                                  END CASE
006800000000E001?C                   Enddo                                                  END DOWHILE
006900000000    ?C                   Endsr                                                  END PRCCNF
007000000000    ? *___________________________________________________________________
007100000000    ? * Prepare panel
007200000000    ? *___________________________________________________________________
007300000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
007400060712    ? *
007600060712     C                   Clear                   ACNAM1
007700000000    ?C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
007800000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
007900000000    ?C                   Exsr      GETREC                                       GET RECORD
008000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
008100000000 001?C                   Move      WTM(2)        WWMSG                          GET MESSAGE
008200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
008300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
008400000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
008500000000E001?C                   Endif                                                  END IF ERROR
008600000000    ?C                   Endsr                                                  END PRPPNL
008700000000    ? *___________________________________________________________________
008800000000    ? * Get record for delete
008900000000    ? *___________________________________________________________________
009000000000    ?C     GETREC        Begsr                                                  GET REC FOR DLT
009100070216    ?C                   Call      'UPDMKE  '                                   PROCESS REC IO
009200000000    ?C                   Parm      'GET     '    WWRQS             8            GET RECORD
009300991201    ?C                   Parm                    WWRTN                          RETURN CODE
009400000614    ?C                   Parm                    WDDTA                          REC DATA
009500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
009600000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
009700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
009800000000 001?C                   Movel     'ERROR'       WORTN                          RETURN ERROR
009900000000 001?C                   Movel     'END'         WWSTT                          RETURN END
010000000000E001?C                   Endif                                                  END ERROR
010100000000    ?C                   Endsr                                                  END PREP CHANGE
010200000000    ? *___________________________________________________________________
010300000000    ? * Dispaly delete confirmation panel
010400000000    ? *___________________________________________________________________
010500000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
010600000000    ? * Set OVERLAY based on last display file processed
010700000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
010800000000 001?C                   Setoff                                       35        OVERLAY OFF
010900000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
011000000000X001?C                   Else                                                   SAME PGM
011100000000 001?C                   Seton                                        35        OVERLAY ON
011200000000E001?C                   Endif                                                  END IF NEW PGM
011300000000    ? * Write message subfile
011400000000    ?C                   Seton                                        30        MSGSFL DISPLAY
011500000000    ?C                   Write     MSGSFLC                                      DISPLAY MSG SFL
011600000000    ? * Write delete confirmation panel
011700070216    ?C     MKEKEY        klist
011900070216     C                   Kfld                    METRST
012000070216     C                   Kfld                    MESUB#
012100070216     C                   Kfld                    MEACCT
012200070216    ?C     MKEKEY        Chain     MKTRNE
012300060712    ? *
012301070216     C     MEEEDT        Mult      10000.0001    MEEEDT
012302070216     C     MECHDT        Mult      10000.0001    MECHDT
012303070216    ? *
012900060712     C     ACCKEY        klist
013000070216     C                   kfld                    METRST
013100070216     C                   kfld                    MESUB#
013200070216     C                   kfld                    MEACCT
013201070216    ? *
013300060712     C     ACCKEY        Chain     ACCMST
013400060712    ? *
013500000000    ?C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
013600000000    ?C                   Endsr                                                  END DSPPNL
013700000000    ? *___________________________________________________________________
013800000000    ? * Process ENTER request
013900000000    ? *___________________________________________________________________
014000000000    ?C     PRCENT        Begsr                                                  PROC ENTER RQS
014100000000    ?C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
014200991201B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
014300000000 001?C                   Exsr      DLTREC                                       DELETE RECORD
014400000000E001?C                   Endif                                                  END IF DLT ALLOWED
014500000000    ? *
014600000000B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
014700000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
014800000000 001?C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
014900000000E001?C                   Endif                                                  END IF DLT ALLOWED
015000000000    ?C                   Endsr                                                  END PRCENT
015100000000    ? *___________________________________________________________________
015200000000    ? * Delete record
015300000000    ? *___________________________________________________________________
015400000000    ?C     DLTREC        Begsr                                                  DELETE RECORD
015500070216    ?C                   Call      'UPDMKE  '                                   PROCESS REC IO
015600000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
015700000000    ?C                   Parm                    WWRTN                          RETURN CODE
015800000614    ?C                   Parm                    WDDTA                          REC DATA
015900000000    ? *
016000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
016100000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
016200000000 001?C                   Exsr      SNDMSG                                       SEND MSG
016300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016400000000E001?C                   Endif                                                  END IF ERROR
016500000000    ?C                   Endsr                                                  END PRCENT
016600000000    ? *___________________________________________________________________
016700000000    ? * Check if delete allowed
016800000000    ? *___________________________________________________________________
016900000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
017000991201    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
017100000000    ?C                   Endsr                                                  END CHECK DLT
017200000000    ? *___________________________________________________________________
017300000000    ? * Release the record
017400000000    ? *___________________________________________________________________
017500000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
017600070216    ?C                   Call      'UPDMKE  '                                   PROCESS REC IO
017700000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
017800991201    ?C                   Parm                    WWRTN                          RETURN CODE
017900000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
018000000000    ?C                   Endsr                                                  END RELREC
018100000000    ? *___________________________________________________________________
018200000000    ? * Receive messages
018300000000    ? *___________________________________________________________________
018400000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
018500000000    ?C                   Movea     *IN           WWIN                           INDICATORS
018600000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
018700000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
018800000000    ?C                   Parm                    WWIN                           INDICATORS
018900000000    ?C                   Parm                    WWRTN                          RETURN CODE
019000000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
019100000000    ?C                   Endsr                                                  END RCV MSG
019200000000    ? *___________________________________________________________________
019300000000    ? * Build function key information
019400000000    ? *___________________________________________________________________
019500000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
019600991108    ?C                   Movea     *IN           WWIN                           INDICATORS
019700991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
019800000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
019900000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
020000000000    ?C                   Parm                    WAD                            FNC DESC
020100991108    ?C                   Parm                    WWIN                           *IN
020200000000    ?C                   Parm                    WAF                            FNC KEY TABLE
020300000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
020400000000    ? *
020500010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
020600010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
020700010913    ?C                   Sub       1             WW                             BUMP IDX
020800010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
020900000000    ?C                   Endsr                                                  END BLD FNCTNS
021000000000    ? *___________________________________________________________________
021100000000    ? * Process function keys
021200000000    ? *___________________________________________________________________
021300000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
021400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
021500991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
021600000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
021700000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
021800000000    ?C                   Parm                    WAD                            FNC DESC
021900991108    ?C                   Parm                    WWIN                           *IN
022000000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
022100000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
022200000000    ?C                   Endsr                                                  END PROC FNCTNS
022300000000    ? *___________________________________________________________________
022400000000    ? * Process EXIT function
022500000000    ? *___________________________________________________________________
022600000000    ?C     PRCEXT        Begsr                                                  EXIT
022700000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
022800000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
022900000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
023000000000    ?C                   Endsr                                                  END RETURN
023100000000    ? *___________________________________________________________________
023200000000    ? * Process CANCEL function
023300000000    ? *___________________________________________________________________
023400000000    ?C     PRCCNL        Begsr                                                  CANCEL
023500000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
023600000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
023700000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
023800000000    ?C                   Endsr                                                  END RETURN
023900000000    ? *___________________________________________________________________
024000000000    ? * Send message
024100000000    ? *___________________________________________________________________
024200000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
024300000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
024400000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
024500000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
024600000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
024700000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
024800000000    ?C                   Endsr                                                  END PROC FNC
024900000000    ? *___________________________________________________________________
025000000000    ? * Parameter lists
025100000000    ? *___________________________________________________________________
025200000000    ?C     PLIST         Begsr                                                  PARM LISTS
025300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
025400000000    ?C                   Parm                    WIRQS             8            EXT MODE
025500000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
025600000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
025700000614    ?C                   Parm                    WDDTA                          RECORD DS
025800000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
025900000000    ?C                   Endsr                                                  END PLIST
026000000000    ? *___________________________________________________________________
026100000000    ? * Initialize routine
026200000000    ? *___________________________________________________________________
026300000000    ?C     *INZSR        Begsr                                                  INITIALIZE
026400000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
026500000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
026600000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
026700000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
026800000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
026900000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
027000000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
027100000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
027200000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
027300000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
027400000000    ?C                   Endsr                                                  END *INZSR
027500000000    ? *___________________________________________________________________
027600000000    ? * Program error handler
027700000000    ? *___________________________________________________________________
027800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
027900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
028000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
028100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
028200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
028300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
028400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
028500000000    ? *___________________________________________________________________
028600070216**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A               |
02870000000003EXIT    F3=Exit
02880000000012CANCEL  F12=Cancel
028900000000** WTM
02900000000000Record not deleted. No longer available.
02910006071200Category Note record not found.
02920007021600Call to UPDMKE failed.
02930007021600Request not supported in program DLTMKE.
