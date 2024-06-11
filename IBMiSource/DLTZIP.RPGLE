000100000000      *_________________________________________________________________________
000200000000      *
000300020927      *  Description:  Delete Zip Code Cross Reference
000400020521      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *_________________________________________________________________________
000700000000      *
000800021003     FDLTZIPD   CF   E             WORKSTN INFDS(DSPD)
000900020927     FNYSUASM0  IF   E           K DISK
001000000000      *_________________________________________________________________________
001100000000      *
001200000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001400000000     D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001500000000      *_________________________________________________________________________
001600000000      *
001700000000      * Data structure
001800020927     D WDDTA         E DS                  EXTNAME(NYZIPXF0)
001900000000      *
002000000000      * Program status data structure
002100000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002200000000      *
002300000000      * Display file data structure
002400000000     D DSPD          E DS                  EXTNAME(IODSPD)
002500000000      *
002600000000     D WDFILE        E DS                  EXTNAME(IODBFD)
002700000000      *
002800000000     D WIFKV           S             60A
002900020226     D WIRQS           S              8A
003000000000     D WORTN           S              8A
003100000000     D WUPGM           S             10A
003200000000     D WW              S              3P 0
003300000000     D WWDTAQ          S             10A
003400000000     D WWFKS           S              1P 0
003500000000     D WWFKV           S                   LIKE(WIFKV)                          FUNCTIONS VALID
003600000000     D WWFNC           S                   LIKE(WORTN)                          FUNCTION CODE
003700000000     D WWIN            S             99A
003800020226     D WWLIB           S             10A
003900020226     D WWLNGQ          S              5P 0
004000000000     D WWMSG           S             80A
004100000000     D WWOPT           S                   LIKE(WORTN)                          OPTION CODE
004200000000     D WWOPV           S                   LIKE(WIFKV)                          OPTIONS VALID
004300000000     D WWRQS           S              8A
004400000000     D WWRTN           S              8A
004500000000     D WWSTT           S              3A
004600000000      *
004700000000      *___________________________________________________________________
004800000000      * Process delete request
004900000000     C                   Move      *BLANKS       WORTN                          SET RETURN CODE
005000000000     C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
005100000000     C                   Cas                     PRCERR                         PROCESS ERROR
005200000000     C                   Endcs                                                  END CASE
005300000000     C                   Return                                                 RETURN
005400000000      *___________________________________________________________________
005500000000      * Process ERROR function
005600000000      *___________________________________________________________________
005700000000     C     PRCERR        Begsr                                                  PROC ADD RQST
005800000000     C                   Move      WTM(4)        WWMSG                          PASS MSG
005900000000     C                   Exsr      SNDMSG                                       SEND MSG
006000000000     C                   Move      'ERROR   '    WORTN                          RETURN ERROR
006100000000     C                   Endsr                                                  END PRCERR
006200000000      *___________________________________________________________________
006300000000      * Delete record with confirmation
006400000000      *___________________________________________________________________
006500000000     C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
006600000000     C                   Exsr      PRPPNL                                       PREPARE PANEL
006700000000B001 C                   Dow       WWSTT <> 'END'                               DOWHILE NOT END
006800000000 001 C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
006900000000 001 C                   Exsr      DSPPNL                                       DISPLAY PANEL
007000000000 001 C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
007100000000 001 C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
007200000000 001 C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
007300000000 001 C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
007400000000 001 C                   Endcs                                                  END CASE
007500000000E001 C                   Enddo                                                  END DOWHILE
007600000000     C                   Endsr                                                  END PRCCNF
007700000000      *___________________________________________________________________
007800000000      * Prepare panel
007900000000      *___________________________________________________________________
008000000000     C     PRPPNL        Begsr                                                  PREPARE PANEL
008100000000     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
008200000000     C                   Exsr      BLDFKY                                       BUILD FNCTNS
008300000000     C                   Exsr      GETREC                                       GET RECORD
008400000000     C                   IF        WWRTN <> *BLANKS
008500000000 001 C                   Move      WTM(2)        WWMSG                          GET MESSAGE
008600000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
008700000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
008800000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
008900000000E001 C                   Endif                                                  END IF ERROR
009000000000      *
009100000000     C                   Endsr                                                  END PRPPNL
009200000000      *___________________________________________________________________
009300000000      * Get record for delete
009400000000      *___________________________________________________________________
009500000000     C     GETREC        Begsr                                                  GET REC FOR DLT
009600021003     C                   Call      'UPDZIP  '                                   PROCESS REC IO
009700000000     C                   Parm      'GET     '    WWRQS                          GET RECORD
009800000000     C                   Parm                    WWRTN                          RETURN CODE
009900000000     C                   Parm                    WDDTA                          REC DATA
010000000000B001 C                   If        WWRTN <> *BLANKS                             IF GET ERROR
010100000000 001 C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
010200000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
010300000000 001 C                   Movel     'ERROR'       WORTN                          RETURN ERROR
010400000000 001 C                   Movel     'END'         WWSTT                          RETURN END
010500000000E001 C                   Endif                                                  END ERROR
010600000000     C                   Endsr                                                  END PREP CHANGE
010700000000      *___________________________________________________________________
010800000000      * Dispaly delete confirmation panel
010900000000      *___________________________________________________________________
011000000000     C     DSPPNL        Begsr                                                  DISPLAY PANEL
011100000000      * Set OVERLAY based on last display file processed
011200000000     C                   IF        WQPGMN <> WUPGM
011300000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
011400000000 001 C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
011500000000X001 C                   Else                                                   SAME PGM
011600000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
011700000000E001 C                   Endif                                                  END IF NEW PGM
011800000000      * Write message subfile
011900000000 001 C                   MOVE      *ON           *IN30                          MSGSFLYDISPLAY
012000020226     C                   Write     MSGSFLC                                      DISPLAY MSG SFL
012100000000      * Write delete confirmation panel
012200020927     C     ZXREGION      CHAIN     RNYSUASM
012300020927     C                   IF        NOT %FOUND(NYSUASM0)
012400020927     C                   EVAL      WWDESC = *BLANKS
012500020927     C                   ELSE
012600020927     C                   EVAL      WWDESC = %TRIM(SURGDESC)
012700020927     C                   ENDIF
012800020226     C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
012900000000     C                   Endsr                                                  END DSPPNL
013000000000      *___________________________________________________________________
013100000000      * Process ENTER request
013200000000      *___________________________________________________________________
013300000000     C     PRCENT        Begsr                                                  PROC ENTER RQS
013400000000     C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
013500000000     C                   IF        WWRTN = *BLANKS
013600000000 001 C                   Exsr      DLTREC                                       DELETE RECORD
013700000000E001 C                   Endif                                                  END IF DLT ALLOWED
013800000000      *
013900000000     C                   IF        WWRTN = *BLANKS
014000000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
014100000000 001 C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
014200000000E001 C                   Endif                                                  END IF DLT ALLOWED
014300000000     C                   Endsr                                                  END PRCENT
014400000000      *___________________________________________________________________
014500000000      * Delete record
014600000000      *___________________________________________________________________
014700000000     C     DLTREC        Begsr                                                  DELETE RECORD
014800000000      *
014900021003     C                   Call      'UPDZIP  '                                   PROCESS REC IO
015000000000     C                   Parm      'DELETE  '    WWRQS                          GET REC
015100000000     C                   Parm                    WWRTN                          RETURN CODE
015200000000     C                   Parm                    WDDTA                          REC DATA
015300000000      *
015400000000     C                   IF        WWRTN <> *BLANKS
015500000000 001 C                   Move      WTM(1)        WWMSG                          GET MESSAGE
015600000000 001 C                   Exsr      SNDMSG                                       SEND MSG
015700000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015800000000E001 C                   Endif                                                  END IF ERROR
015900000000     C                   Endsr                                                  END PRCENT
016000000000      *___________________________________________________________________
016100000000      * Check if delete allowed
016200000000      *___________________________________________________________________
016300000000     C     CHKDLT        Begsr                                                  CHECK DELETE
016400000000     C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
016500000000     C                   Endsr                                                  END CHECK DLT
016600000000      *___________________________________________________________________
016700000000      * Release the record
016800000000      *___________________________________________________________________
016900000000     C     RELREC        Begsr                                                  RELEASE RECORD
017000021003     C                   Call      'UPDZIP  '                                   PROCESS REC IO
017100000000     C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
017200000000     C                   Parm                    WWRTN                          RETURN CODE
017300000000     C                   Parm                    WDDTA                          REC DATA STRUCTURE
017400000000     C                   Endsr                                                  END RELREC
017500000000      *___________________________________________________________________
017600000000      * Receive messages
017700000000      *___________________________________________________________________
017800000000     C     RCVMSG        Begsr                                                  RECEIVE MSG
017900000000     C                   Movea     *IN           WWIN                           INDICATORS
018000000000     C                   Call      'PRCMSG2'                                    CALL MSG PGM
018100000000     C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
018200000000     C                   Parm                    WWIN                           INDICATORS
018300000000     C                   Parm                    WWRTN                          RETURN CODE
018400000000     C                   Movea     WWIN          *IN                            INDICATORS RET
018500000000     C                   Endsr                                                  END RCV MSG
018600000000      *___________________________________________________________________
018700000000      * Build function key information
018800000000      *___________________________________________________________________
018900000000     C     BLDFKY        Begsr                                                  BUILD FNC KEYS
019000000000     C                   Movea     *IN           WWIN                           INDICATORS
019100000000     C                   Call      'PRCFKY2'                                    PROC FNC KYS
019200000000     C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
019300000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
019400000000     C                   Parm                    WAD                            FNC DESC
019500000000     C                   Parm                    WWIN                           *IN
019600000000     C                   Parm                    WAF                            FNC KEY TABLE
019700000000     C                   Parm                    WIFKV                          FNC KYS ALLWD
019800000000      *
019900000000     C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
020000000000     C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
020100000000     C                   Sub       1             WW                             BUMP IDX
020200000000     C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
020300000000     C                   Endsr                                                  END BLD FNCTNS
020400000000      *___________________________________________________________________
020500000000      * Process function keys
020600000000      *___________________________________________________________________
020700000000     C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
020800000000     C                   Movea     *IN           WWIN                           INDICATORS
020900000000     C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
021000000000     C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
021100000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
021200000000     C                   Parm                    WAD                            FNC DESC
021300000000     C                   Parm                    WWIN                           *IN
021400000000     C                   Parm                    WAF                            FNCTN KEY TABLE
021500000000     C                   Parm                    WIFKV                          FNCTN KYS ALLWD
021600000000     C                   Endsr                                                  END PROC FNCTNS
021700000000      *___________________________________________________________________
021800000000      * Process EXIT function
021900000000      *___________________________________________________________________
022000000000     C     PRCEXT        Begsr                                                  EXIT
022100000000     C                   Exsr      RELREC                                       RELEASE RECORD
022200000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
022300000000     C                   Move      'END'         WWSTT                          END INVOCATION
022400000000     C                   Endsr                                                  END RETURN
022500000000      *___________________________________________________________________
022600000000      * Process CANCEL function
022700000000      *___________________________________________________________________
022800000000     C     PRCCNL        Begsr                                                  CANCEL
022900000000     C                   Exsr      RELREC                                       RELEASE RECORD
023000000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
023100000000     C                   Move      'END'         WWSTT                          END INVOCATION
023200000000     C                   Endsr                                                  END RETURN
023300000000      *___________________________________________________________________
023400000000      * Send message
023500000000      *___________________________________________________________________
023600000000     C     SNDMSG        Begsr                                                  SEND MESSAGE
023700000000     C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
023800000000     C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
023900000000     C                   Parm      'QTEMP'       WWLIB                          DATA QUEUE LIB
024000000000     C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
024100000000     C                   Parm                    WWMSG                          ERROR MESSAGE
024200000000     C                   Endsr                                                  END PROC FNC
024300000000      *___________________________________________________________________
024400000000      * Parameter lists
024500000000      *___________________________________________________________________
024600000000     C     PLIST         Begsr                                                  PARM LISTS
024700000000     C     *ENTRY        Plist                                                  *ENTRY LIST
024800000000     C                   Parm                    WIRQS                          EXT MODE
024900000000     C                   Parm                    WORTN                          INTERNAL MODE
025000000000     C                   Parm                    WUPGM                          LAST PGM NAME
025100000000     C                   Parm                    WDDTA                          RECORD DS
025200000000     C                   Parm                    WIFKV                          FUNCTIONS VALID
025300000000     C                   Endsr                                                  END PLIST
025400000000      *___________________________________________________________________
025500000000      * Initialize routine
025600000000      *___________________________________________________________________
025700000000     C     *INZSR        Begsr                                                  INITIALIZE
025800000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
025900000000     C                   Z-add     1             WWFKS                          FNC KEY SET
026000000000     C                   Z-add     *ZEROS        WW                             WORK INDEX
026100000000     C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
026200000000     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
026300000000     C                   Move      *BLANKS       WWRTN                          RETURN CODE
026400000000     C                   Endsr                                                  END *INZSR
026500000000      *___________________________________________________________________
026600000000      * Program error handler
026700000000      *___________________________________________________________________
026800000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
026900000000     C                   Call      'SNDRPGM'                            50      SEND RPG MSG
027000000000     C                   Parm                    WQPGMN                         PROGRAM NAME
027100000000     C                   Parm                    WQSTSC                         STATUS CODE
027200000000     C                   Parm                    WQRPGS                         RPG STATEMENT
027300000000     C                   Parm                    WQMSG                          MESSAGE ID
027400000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
027500000000      *___________________________________________________________________
027600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02770000000003EXIT    F3=Exit
02780000000012CANCEL  F12=Cancel
027900000000** WTM
02800000000000Record not deleted. No longer available.
02810002092700ZIP CODE CROSS REFERENCE record not found.
02820002100300Call to UPDZIP failed.
02830002100300Request not supported in program DLTZIP.
