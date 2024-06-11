000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010220    ? *  Description:  Delete ISC override
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000800000000    ? *_________________________________________________________________________
000900000000    ? *
001000010220    ?FDLTOVRD   CF   E             WORKSTN
001100000000    ?F                                     INFDS(DSPD)
001101010220    ?FACCMST    IF   E           K DISK
001102010220    ?FPLNMST    IF   E           K DISK
001200000000    ? *_________________________________________________________________________
001300000000    ? *
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001600010219    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001700000000    ? *_________________________________________________________________________
001800000000    ? *
001900000406    ? * Data structure
002000010220    ?D WDDTA         E DS                  EXTNAME(ISCOVR)
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
007700010220    ?C                   Call      'UPDOVR  '                                   PROCESS REC IO
007800000000    ?C                   Parm      'GET     '    WWRQS             8            GET RECORD
007900991201    ?C                   Parm                    WWRTN                          RETURN CODE
008000000614    ?C                   Parm                    WDDTA                          REC DATA
008100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
008200000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
008300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
008400000000 001?C                   Movel     'ERROR'       WORTN                          RETURN ERROR
008500000000 001?C                   Movel     'END'         WWSTT                          RETURN END
008600000000E001?C                   Endif                                                  END ERROR
008601010223     C     IOEFDT        MULT      10000.0001    WSEFDT
008602010223     C     IOTRDT        MULT      10000.0001    WSTRDT
008603010220     C     IOCHGD        MULT      10000.0001    WSDATE
008604010220     C     KACC          Chain     ACCMST
008605010220     C                   If        %Found
008606010220     C                   Movel     acnam1        wsdes1
008607010220E001?C                   Endif                                                  END IF ERROR
008608010220     C     KPLN          Chain     PLNMST
008609010220     C                   If        %Found
008610010220     C                   Movel     pdescr        wsdes2
008611010220E001?C                   Endif                                                  END IF ERROR
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
010400000000    ?C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
010500000000    ?C                   Endsr                                                  END DSPPNL
010600000000    ? *___________________________________________________________________
010700000000    ? * Process ENTER request
010800000000    ? *___________________________________________________________________
010900000000    ?C     PRCENT        Begsr                                                  PROC ENTER RQS
011000000000    ?C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
011100991201B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
011200000000 001?C                   Exsr      DLTREC                                       DELETE RECORD
011300000000E001?C                   Endif                                                  END IF DLT ALLOWED
011400000000    ? *
011500000000B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
011600000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
011700000000 001?C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
011800000000E001?C                   Endif                                                  END IF DLT ALLOWED
011900000000    ?C                   Endsr                                                  END PRCENT
012000000000    ? *___________________________________________________________________
012100000000    ? * Delete record
012200000000    ? *___________________________________________________________________
012300000000    ?C     DLTREC        Begsr                                                  DELETE RECORD
012400010220    ?C                   Call      'UPDOVR  '                                   PROCESS REC IO
012500000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
012600000000    ?C                   Parm                    WWRTN                          RETURN CODE
012700000614    ?C                   Parm                    WDDTA                          REC DATA
012800000000    ? *
012900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
013000000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
013100000000 001?C                   Exsr      SNDMSG                                       SEND MSG
013200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013300000000E001?C                   Endif                                                  END IF ERROR
013400000000    ?C                   Endsr                                                  END PRCENT
013500000000    ? *___________________________________________________________________
013600000000    ? * Check if delete allowed
013700000000    ? *___________________________________________________________________
013800000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
013900991201    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
014000000000    ?C                   Endsr                                                  END CHECK DLT
014100000000    ? *___________________________________________________________________
014200000000    ? * Release the record
014300000000    ? *___________________________________________________________________
014400000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
014500010220    ?C                   Call      'UPDOVR  '                                   PROCESS REC IO
014600000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
014700991201    ?C                   Parm                    WWRTN                          RETURN CODE
014800000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
014900000000    ?C                   Endsr                                                  END RELREC
015000000000    ? *___________________________________________________________________
015100000000    ? * Receive messages
015200000000    ? *___________________________________________________________________
015300000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
015400000000    ?C                   Movea     *IN           WWIN                           INDICATORS
015500000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
015600000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
015700000000    ?C                   Parm                    WWIN                           INDICATORS
015800000000    ?C                   Parm                    WWRTN                          RETURN CODE
015900000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
016000000000    ?C                   Endsr                                                  END RCV MSG
016100000000    ? *___________________________________________________________________
016200000000    ? * Build function key information
016300000000    ? *___________________________________________________________________
016400000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
016500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
016600991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
016700000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
016800000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
016900000000    ?C                   Parm                    WAD                            FNC DESC
017000991108    ?C                   Parm                    WWIN                           *IN
017100000000    ?C                   Parm                    WAF                            FNC KEY TABLE
017200000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
017300000000    ? *
017400000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
017500000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
017600000000    ?C                   Sub       1             WW                             BUMP IDX
017700000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
017800000000    ?C                   Endsr                                                  END BLD FNCTNS
017900000000    ? *___________________________________________________________________
018000000000    ? * Process function keys
018100000000    ? *___________________________________________________________________
018200000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
018300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
018400991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
018500000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
018600000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
018700000000    ?C                   Parm                    WAD                            FNC DESC
018800991108    ?C                   Parm                    WWIN                           *IN
018900000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
019000000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
019100000000    ?C                   Endsr                                                  END PROC FNCTNS
019200000000    ? *___________________________________________________________________
019300000000    ? * Process EXIT function
019400000000    ? *___________________________________________________________________
019500000000    ?C     PRCEXT        Begsr                                                  EXIT
019600000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
019700000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
019800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
019900000000    ?C                   Endsr                                                  END RETURN
020000000000    ? *___________________________________________________________________
020100000000    ? * Process CANCEL function
020200000000    ? *___________________________________________________________________
020300000000    ?C     PRCCNL        Begsr                                                  CANCEL
020400000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
020500000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
020600000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
020700000000    ?C                   Endsr                                                  END RETURN
020800000000    ? *___________________________________________________________________
020900000000    ? * Send message
021000000000    ? *___________________________________________________________________
021100000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
021200000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
021300000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
021400000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
021500000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
021600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
021700000000    ?C                   Endsr                                                  END PROC FNC
021800000000    ? *___________________________________________________________________
021900000000    ? * Parameter lists
022000000000    ? *___________________________________________________________________
022100000000    ?C     PLIST         Begsr                                                  PARM LISTS
022200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
022300000000    ?C                   Parm                    WIRQS             8            EXT MODE
022400000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
022500000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
022600000614    ?C                   Parm                    WDDTA                          RECORD DS
022700000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
022800000000    ?C                   Endsr                                                  END PLIST
022900000000    ? *___________________________________________________________________
023000000000    ? * Initialize routine
023100000000    ? *___________________________________________________________________
023200000000    ?C     *INZSR        Begsr                                                  INITIALIZE
023300000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
023400000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
023500000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
023600000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
023700000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
023800000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
023900000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
024000000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
024100000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
024200000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
024201010220    ?C     KACC          Klist                                                  DEFAULT DATA
024202010220     C                   Kfld                    IOTRST
024203010220     C                   Kfld                    IOSUB#
024204010220     C                   Kfld                    IOACCT
024205010220    ?C     KPLN          Klist                                                  DEFAULT DATA
024206010220     C                   Kfld                    IOTRST
024207010220     C                   Kfld                    IOSUB#
024208010220     C                   Kfld                    IOPLAN
024300000000    ?C                   Endsr                                                  END *INZSR
024400000000    ? *___________________________________________________________________
024500000000    ? * Program error handler
024600000000    ? *___________________________________________________________________
024700000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
024800000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
024900000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
025000000000    ?C                   Parm                    WQSTSC                         STATUS CODE
025100000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
025200000000    ?C                   Parm                    WQMSG                          MESSAGE ID
025300000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
025400000000    ? *___________________________________________________________________
025500000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02560000000003EXIT    F3=Exit
02570000000012CANCEL  F12=Cancel
025800000000** WTM
02590000000000Record not deleted. No longer available.
02600001022000Internal Sales Commission Type record not found.
02610001022000Call to UPDOVR failed.
02640001022000Request not supported in program DLTOVR.
