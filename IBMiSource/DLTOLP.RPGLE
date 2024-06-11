000100000000    ? *_________________________________________________________________________
000400000000    ? *
000500070524    ? *  (c)Copyright 2007 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800070524    ?FDLTOLPD   CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
000901070524     FCARMST    IF   E           K DISK
000902070524     FOLFCOVTP  IF   E           K DISK
000903070524     FOLFCARTP  IF   E           K DISK
001000000000    ? *_________________________________________________________________________
001100000000    ? *
001200000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001400010219    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001500000000    ? *_________________________________________________________________________
001600000000    ? *
001700000406    ? * Data structure
001800070524    ?D WDDTA         E DS                  EXTNAME(OLFPLANP)
001801070524    ?D WCDTA         E DS                  EXTNAME(OLFCARTP)
001802070524    ?D WODTA         E DS                  EXTNAME(OLFCOVTP)
001803070524    ?D WADTA         E DS                  EXTNAME(CARMST)
001900000000    ? *
002000000000    ? * Program status data structure
002100991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002200000000    ? *
002300000000    ? * Display file data structure
002400991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002500000000    ? *
002600991108    ?D WDFILE        E DS                  EXTNAME(IODBFD)
002700000000    ? *___________________________________________________________________
002800000000    ? * Process delete request
002900000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003000000000    ?C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
003100000000    ?C                   Cas                     PRCERR                         PROCESS ERROR
003200000000    ?C                   Endcs                                                  END CASE
003300000000    ?C                   Return                                                 RETURN
003400000000    ? *___________________________________________________________________
003500000000    ? * Process ERROR function
003600000000    ? *___________________________________________________________________
003700000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
003800010219    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
003900000000    ?C                   Exsr      SNDMSG                                       SEND MSG
004000000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
004100000000    ?C                   Endsr                                                  END PRCERR
004200000000    ? *___________________________________________________________________
004300000000    ? * Delete record with confirmation
004400000000    ? *___________________________________________________________________
004500000000    ?C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
004600000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
004700000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
004800000000 001?C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
004900000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005000000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005100000000 001?C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
005200000000 001?C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005300000000 001?C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
005400000000 001?C                   Endcs                                                  END CASE
005500000000E001?C                   Enddo                                                  END DOWHILE
005600000000    ?C                   Endsr                                                  END PRCCNF
005700000000    ? *___________________________________________________________________
005800000000    ? * Prepare panel
005900000000    ? *___________________________________________________________________
006000000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006001070525    ?C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
006002070525    ?C                   Move      *BLANKS       WCARD                          LOOP CONTROL
006100070525    ?C                   Move      *BLANKS       WTYPD                          LOOP CONTROL
006200000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
006300000000    ?C                   Exsr      GETREC                                       GET RECORD
006400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
006500000000 001?C                   Move      WTM(2)        WWMSG                          GET MESSAGE
006600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
006700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
006800000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
006900000000E001?C                   Endif                                                  END IF ERROR
007000000000    ?C                   Endsr                                                  END PRPPNL
007100000000    ? *___________________________________________________________________
007200000000    ? * Get record for delete
007300000000    ? *___________________________________________________________________
007400000000    ?C     GETREC        Begsr                                                  GET REC FOR DLT
007500070524    ?C                   Call      'UPDOLP  '                                   PROCESS REC IO
007600000000    ?C                   Parm      'GET     '    WWRQS             8            GET RECORD
007700991201    ?C                   Parm                    WWRTN                          RETURN CODE
007800000614    ?C                   Parm                    WDDTA                          REC DATA
008000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
008100000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
008200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
008300000000 001?C                   Movel     'ERROR'       WORTN                          RETURN ERROR
008400000000 001?C                   Movel     'END'         WWSTT                          RETURN END
008500000000E001?C                   Endif                                                  END ERROR
008600070524     C*    IGCHGD        MULT      10000.0001    WSDATE
008700070524     C*    IGEFDT        MULT      10000.0001    WSEFDT
008800070524     C*    IGTRDT        MULT      10000.0001    WSTRDT
008900000000    ?C                   Endsr                                                  END PREP CHANGE
009000000000    ? *___________________________________________________________________
009100000000    ? * Dispaly delete confirmation panel
009200000000    ? *___________________________________________________________________
009300000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
009400000000    ? * Set OVERLAY based on last display file processed
009500000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
009600000000 001?C                   Setoff                                       35        OVERLAY OFF
009700000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
009800000000X001?C                   Else                                                   SAME PGM
009900000000 001?C                   Seton                                        35        OVERLAY ON
010000000000E001?C                   Endif                                                  END IF NEW PGM
010001070524    ? *
010003070524     C     OKEY          Klist
010004070524     C                   Kfld                    OPCARC
010005070524     C                   Kfld                    OPTYPC
010006070524    ? *
010007070524    ?C     OCCARC        Chain     CARMST
010008070524 003?C                   Movel     CNAME         WCARD            30            SET CODE
010009070524    ?C     OKEY          Chain     OLFCARTP
010010070524 003?C                   Movel     OCDESC        WTYPD                          SET CODE
010016070524    ? *
010100000000    ? * Write message subfile
010200000000    ?C                   Seton                                        30        MSGSFL DISPLAY
010300000000    ?C                   Write     MSGSFLC                                      DISPLAY MSG SFL
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
012400070524    ?C                   Call      'UPDOLP  '                                   PROCESS REC IO
012500000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
012600000000    ?C                   Parm                    WWRTN                          RETURN CODE
012700000614    ?C                   Parm                    WDDTA                          REC DATA
012900000000    ? *
013000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
013100000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
013200000000 001?C                   Exsr      SNDMSG                                       SEND MSG
013300000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013400000000E001?C                   Endif                                                  END IF ERROR
013500000000    ?C                   Endsr                                                  END PRCENT
013600000000    ? *___________________________________________________________________
013700000000    ? * Check if delete allowed
013800000000    ? *___________________________________________________________________
013900000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
014000991201    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
014100000000    ?C                   Endsr                                                  END CHECK DLT
014200000000    ? *___________________________________________________________________
014300000000    ? * Release the record
014400000000    ? *___________________________________________________________________
014500000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
014600070524    ?C                   Call      'UPDOLA  '                                   PROCESS REC IO
014700000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
014800991201    ?C                   Parm                    WWRTN                          RETURN CODE
014900000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
015100000000    ?C                   Endsr                                                  END RELREC
015200000000    ? *___________________________________________________________________
015300000000    ? * Receive messages
015400000000    ? *___________________________________________________________________
015500000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
015600000000    ?C                   Movea     *IN           WWIN                           INDICATORS
015700000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
015800000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
015900000000    ?C                   Parm                    WWIN                           INDICATORS
016000000000    ?C                   Parm                    WWRTN                          RETURN CODE
016100000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
016200000000    ?C                   Endsr                                                  END RCV MSG
016300000000    ? *___________________________________________________________________
016400000000    ? * Build function key information
016500000000    ? *___________________________________________________________________
016600000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
016700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
016800991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
016900000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
017000000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
017100000000    ?C                   Parm                    WAD                            FNC DESC
017200991108    ?C                   Parm                    WWIN                           *IN
017300000000    ?C                   Parm                    WAF                            FNC KEY TABLE
017400000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
017500000000    ? *
017600000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
017700000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
017800000000    ?C                   Sub       1             WW                             BUMP IDX
017900000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
018000000000    ?C                   Endsr                                                  END BLD FNCTNS
018100000000    ? *___________________________________________________________________
018200000000    ? * Process function keys
018300000000    ? *___________________________________________________________________
018400000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
018500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
018600991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
018700000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
018800000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
018900000000    ?C                   Parm                    WAD                            FNC DESC
019000991108    ?C                   Parm                    WWIN                           *IN
019100000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
019200000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
019300000000    ?C                   Endsr                                                  END PROC FNCTNS
019400000000    ? *___________________________________________________________________
019500000000    ? * Process EXIT function
019600000000    ? *___________________________________________________________________
019700000000    ?C     PRCEXT        Begsr                                                  EXIT
019800000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
019900000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
020000000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
020100000000    ?C                   Endsr                                                  END RETURN
020200000000    ? *___________________________________________________________________
020300000000    ? * Process CANCEL function
020400000000    ? *___________________________________________________________________
020500000000    ?C     PRCCNL        Begsr                                                  CANCEL
020600000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
020700000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
020800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
020900000000    ?C                   Endsr                                                  END RETURN
021000000000    ? *___________________________________________________________________
021100000000    ? * Send message
021200000000    ? *___________________________________________________________________
021300000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
021400000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
021500000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
021600000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
021700000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
021800000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
021900000000    ?C                   Endsr                                                  END PROC FNC
022000000000    ? *___________________________________________________________________
022100000000    ? * Parameter lists
022200000000    ? *___________________________________________________________________
022300000000    ?C     PLIST         Begsr                                                  PARM LISTS
022400000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
022500000000    ?C                   Parm                    WIRQS             8            EXT MODE
022600000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
022700000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
022800000614    ?C                   Parm                    WDDTA                          RECORD DS
022900000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
023100000000    ?C                   Endsr                                                  END PLIST
023200000000    ? *___________________________________________________________________
023300000000    ? * Initialize routine
023400000000    ? *___________________________________________________________________
023500000000    ?C     *INZSR        Begsr                                                  INITIALIZE
023600000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
023700000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
023800000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
023900000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
024000000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
024100000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
024200000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
024300000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
024400000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
024500000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
024600000000    ?C                   Endsr                                                  END *INZSR
024700000000    ? *___________________________________________________________________
024800000000    ? * Program error handler
024900000000    ? *___________________________________________________________________
025000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
025100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
025200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
025300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
025400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
025500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
025600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
025700000000    ? *___________________________________________________________________
025800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02590000000003EXIT    F3=Exit
02600000000012CANCEL  F12=Cancel
026100000000** WTM
02620000000000Record not deleted. No longer available.
02630007052400Online Forms Plan record not found.
02640007052400Call to UPDOLP failed.
02650007052400Request not supported in program DLTOLP.
