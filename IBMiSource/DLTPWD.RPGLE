000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300020306    ? *  Description:  Delete PassWord Validation User Detail
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800020306    ?FDLTPWDD   CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
001000020306     FPWVMNU    IF   E           K DISK
001100000000    ? *_________________________________________________________________________
001200000000    ? *
001300000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001400000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001500010219    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001600000000    ? *_________________________________________________________________________
001700000000    ? *
001800000406    ? * Data structure
001900020306    ?D WDDTA         E DS                  EXTNAME(PWVDTL)
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
006300000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
006400000000    ?C                   Exsr      GETREC                                       GET RECORD
006500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
006600000000 001?C                   Move      WTM(2)        WWMSG                          GET MESSAGE
006700000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
006800000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
006900000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
007000020306E001?C                   Else                                                   END IF ERROR
007100020306     C     WKMNU         Klist
007200020306     C                   Kfld                    PDMENU
007300020306     C                   Kfld                    PDOPTN
007400020306     C     WKMNU         Chain     PWVMNU
007500020306     C                   If        not %Found
007600020306     C                   Clear                   PMDESC
007700020306E001?C                   End                                                    ENDIF
007800020306E001?C                   Endif                                                  END IF ERROR
007900000000    ?C                   Endsr                                                  END PRPPNL
008000000000    ? *___________________________________________________________________
008100000000    ? * Get record for delete
008200000000    ? *___________________________________________________________________
008300000000    ?C     GETREC        Begsr                                                  GET REC FOR DLT
008400020306    ?C                   Call      'UPDPWD  '                                   PROCESS REC IO
008500000000    ?C                   Parm      'GET     '    WWRQS             8            GET RECORD
008600991201    ?C                   Parm                    WWRTN                          RETURN CODE
008700000614    ?C                   Parm                    WDDTA                          REC DATA
008800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
008900000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
009000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
009100000000 001?C                   Movel     'ERROR'       WORTN                          RETURN ERROR
009200000000 001?C                   Movel     'END'         WWSTT                          RETURN END
009300000000E001?C                   Endif                                                  END ERROR
009400000000    ?C                   Endsr                                                  END PREP CHANGE
009500000000    ? *___________________________________________________________________
009600000000    ? * Dispaly delete confirmation panel
009700000000    ? *___________________________________________________________________
009800000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
009900000000    ? * Set OVERLAY based on last display file processed
010000000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
010100000000 001?C                   Setoff                                       35        OVERLAY OFF
010200000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
010300000000X001?C                   Else                                                   SAME PGM
010400000000 001?C                   Seton                                        35        OVERLAY ON
010500000000E001?C                   Endif                                                  END IF NEW PGM
010600000000    ? * Write message subfile
010700000000    ?C                   Seton                                        30        MSGSFL DISPLAY
010800000000    ?C                   Write     MSGSFLC                                      DISPLAY MSG SFL
010900000000    ?C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
011000000000    ?C                   Endsr                                                  END DSPPNL
011100000000    ? *___________________________________________________________________
011200000000    ? * Process ENTER request
011300000000    ? *___________________________________________________________________
011400000000    ?C     PRCENT        Begsr                                                  PROC ENTER RQS
011500000000    ?C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
011600991201B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
011700000000 001?C                   Exsr      DLTREC                                       DELETE RECORD
011800000000E001?C                   Endif                                                  END IF DLT ALLOWED
011900000000    ? *
012000000000B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
012100000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
012200000000 001?C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
012300000000E001?C                   Endif                                                  END IF DLT ALLOWED
012400000000    ?C                   Endsr                                                  END PRCENT
012500000000    ? *___________________________________________________________________
012600000000    ? * Delete record
012700000000    ? *___________________________________________________________________
012800000000    ?C     DLTREC        Begsr                                                  DELETE RECORD
012900020306    ?C                   Call      'UPDPWD  '                                   PROCESS REC IO
013000000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
013100000000    ?C                   Parm                    WWRTN                          RETURN CODE
013200000614    ?C                   Parm                    WDDTA                          REC DATA
013300000000    ? *
013400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
013500000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
013600000000 001?C                   Exsr      SNDMSG                                       SEND MSG
013700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013800000000E001?C                   Endif                                                  END IF ERROR
013900000000    ?C                   Endsr                                                  END PRCENT
014000000000    ? *___________________________________________________________________
014100000000    ? * Check if delete allowed
014200000000    ? *___________________________________________________________________
014300000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
014400991201    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
014500000000    ?C                   Endsr                                                  END CHECK DLT
014600000000    ? *___________________________________________________________________
014700000000    ? * Release the record
014800000000    ? *___________________________________________________________________
014900000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
015000020306    ?C                   Call      'UPDPWD  '                                   PROCESS REC IO
015100000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
015200991201    ?C                   Parm                    WWRTN                          RETURN CODE
015300000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
015400000000    ?C                   Endsr                                                  END RELREC
015500000000    ? *___________________________________________________________________
015600000000    ? * Receive messages
015700000000    ? *___________________________________________________________________
015800000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
015900000000    ?C                   Movea     *IN           WWIN                           INDICATORS
016000000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
016100000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
016200000000    ?C                   Parm                    WWIN                           INDICATORS
016300000000    ?C                   Parm                    WWRTN                          RETURN CODE
016400000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
016500000000    ?C                   Endsr                                                  END RCV MSG
016600000000    ? *___________________________________________________________________
016700000000    ? * Build function key information
016800000000    ? *___________________________________________________________________
016900000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
017000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
017100991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
017200000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
017300000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
017400000000    ?C                   Parm                    WAD                            FNC DESC
017500991108    ?C                   Parm                    WWIN                           *IN
017600000000    ?C                   Parm                    WAF                            FNC KEY TABLE
017700000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
017800000000    ? *
017900000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
018000000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
018100000000    ?C                   Sub       1             WW                             BUMP IDX
018200000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
018300000000    ?C                   Endsr                                                  END BLD FNCTNS
018400000000    ? *___________________________________________________________________
018500000000    ? * Process function keys
018600000000    ? *___________________________________________________________________
018700000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
018800991108    ?C                   Movea     *IN           WWIN                           INDICATORS
018900991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
019000000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
019100000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
019200000000    ?C                   Parm                    WAD                            FNC DESC
019300991108    ?C                   Parm                    WWIN                           *IN
019400000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
019500000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
019600000000    ?C                   Endsr                                                  END PROC FNCTNS
019700000000    ? *___________________________________________________________________
019800000000    ? * Process EXIT function
019900000000    ? *___________________________________________________________________
020000000000    ?C     PRCEXT        Begsr                                                  EXIT
020100000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
020200000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
020300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
020400000000    ?C                   Endsr                                                  END RETURN
020500000000    ? *___________________________________________________________________
020600000000    ? * Process CANCEL function
020700000000    ? *___________________________________________________________________
020800000000    ?C     PRCCNL        Begsr                                                  CANCEL
020900000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
021000000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
021100000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
021200000000    ?C                   Endsr                                                  END RETURN
021300000000    ? *___________________________________________________________________
021400000000    ? * Send message
021500000000    ? *___________________________________________________________________
021600000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
021700000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
021800000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
021900000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
022000000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
022100000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
022200000000    ?C                   Endsr                                                  END PROC FNC
022300000000    ? *___________________________________________________________________
022400000000    ? * Parameter lists
022500000000    ? *___________________________________________________________________
022600000000    ?C     PLIST         Begsr                                                  PARM LISTS
022700000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
022800000000    ?C                   Parm                    WIRQS             8            EXT MODE
022900000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
023000000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
023100000614    ?C                   Parm                    WDDTA                          RECORD DS
023200000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
023300000000    ?C                   Endsr                                                  END PLIST
023400000000    ? *___________________________________________________________________
023500000000    ? * Initialize routine
023600000000    ? *___________________________________________________________________
023700000000    ?C     *INZSR        Begsr                                                  INITIALIZE
023800000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
023900000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
024000000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
024100000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
024200000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
024300000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
024400000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
024500000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
024600000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
024700000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
024800000000    ?C                   Endsr                                                  END *INZSR
024900000000    ? *___________________________________________________________________
025000000000    ? * Program error handler
025100000000    ? *___________________________________________________________________
025200000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
025300000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
025400000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
025500000000    ?C                   Parm                    WQSTSC                         STATUS CODE
025600000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
025700000000    ?C                   Parm                    WQMSG                          MESSAGE ID
025800000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
025900000000    ? *___________________________________________________________________
026000000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02610000000003EXIT    F3=Exit
02620000000012CANCEL  F12=Cancel
026300000000** WTM
02640000000000Record not deleted. No longer available.
02650002030600Password Validation User Menu Opt record not found.
02660002030600Call to UPDPWD failed.
02670002030600Request not supported in program DLTPWD.
