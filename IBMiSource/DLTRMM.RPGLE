000100000000      *_________________________________________________________________________
000200000000      *
000300060313      *  Description:  Delete RELATIONSHIP MANAGER MASTER
000400000000      *
000500060310      *  (C)COPYRIGHT 2006 BY GROUP BENEFIT SERVICES, INC.
000600000000      *_________________________________________________________________________
000700000000      *
000800060313     FDLTRMMD   CF   E             WORKSTN INFDS(DSPD)
000900000000      *_________________________________________________________________________
001000000000      *
001100000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001300000000     D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001400000000      *_________________________________________________________________________
001500000000      *
001600000000      * Data structure
001700060313     D WDDTA         E DS                  EXTNAME(RMGRMST0)
001800000000      *
001900000000      * Program status data structure
002000000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002100000000      *
002200000000      * Display file data structure
002300000000     D DSPD          E DS                  EXTNAME(IODSPD)
002400000000      *
002500000000     D WDFILE        E DS                  EXTNAME(IODBFD)
002600000000      *
002700021008     D WIFKV           S             60A
002800021008     D WIFKY           S                   LIKE(WIFKV)
002900021008     D WIOPV           S                   LIKE(WIFKV)
003000021008     D WIRQS           S              8A
003100021008     D WORTN           S              8A
003200021008     D WUPGM           S             10A
003300021008     D WWCHG           S              1A
003400021008     D WWDLT           S              1A
003500021008     D WWDTAQ          S             10A
003600021008     D WWENDF          S              3A
003700021008     D WWENDO          S                   LIKE(WWENDF)
003800021008     D WWERR           S              1A
003900021008     D WWFIL           S             10A
004000021008     D WWFKA           S              8A
004100021008     D WWFKV           S                   LIKE(WIFKV)
004200021008     D WWFKY           S                   LIKE(WIFKV)
004300021008     D WWFLK           S            128A
004400021008     D WWFMTN          S              8A
004500021008     D WWFNC           S              8A
004600021008     D WWIJI           S             16A
004700021008     D WWIN            S             99A
004800021008     D WWLIB           S             10A
004900021008     D WWMSG           S             80A
005000021008     D WWMSGC          S              7A
005100021008     D WWOCD           S              8A
005200021008     D WWOPA           S              8A
005300021008     D WWOPN           S              1A
005400021008     D WWOPT           S              8A
005500021008     D WWOPV           S                   LIKE(WIFKV)
005600021008     D WWORQS          S                   LIKE(WIRQS)
005700021008     D WWPSNC          S              1A
005800021008     D WWQJN           S             26A
005900021008     D WWRQS           S                   LIKE(WIRQS)
006000021008     D WWRQSD          S                   LIKE(WIRQS)
006100021008     D WWRTN           S                   LIKE(WORTN)
006200021008     D WWRTND          S                   LIKE(WORTN)
006300021008     D WWRTNH          S                   LIKE(WORTN)
006400021008     D WWSFLE          S              1A
006500021008     D WWSTT           S              3A
006600021008     D WWTSK           S              8A
006700021008     D WWTXT           S             60A
006800021008     D WWUPD           S              1A
006900021008     D WWWRNF          S              1A
007000021008     D WWZERO          S             40A
007100021008     D WFRRN           S              4P 0
007200021008     D WW              S              3P 0
007300021008     D WWFKS           S              1P 0
007400021008     D WWFKSO          S                   LIKE(WWFKS)
007500021008     D WWLMT           S              2P 0
007600021008     D WWLNG           S             15P 5
007700021008     D WWLNGQ          S              5P 0
007800021008     D WWLOWR          S              4P 0
007900021008     D WWLSTS          S              2P 0
008000021008     D WWOPS           S              1P 0
008100021008     D WWOPSO          S                   LIKE(WWOPS)
008200021008     D WWPNL           S              1P 0
008300021008     D WWPNLN          S                   LIKE(WWPNL)
008400021008     D WWPNLO          S                   LIKE(WWPNL)
008500021008     D WWPSNI          S              2P 0
008600021008     D WWPSNN          S              1P 0
008700021008     D WWPSNP          S                   LIKE(WWPSNN)
008800021008     D WWRRN           S              4P 0
008900000000      *
009000000000      *___________________________________________________________________
009100000000      * Process delete request
009200000000     C                   Move      *BLANKS       WORTN                          SET RETURN CODE
009300000000     C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
009400000000     C                   Cas                     PRCERR                         PROCESS ERROR
009500000000     C                   Endcs                                                  END CASE
009600000000     C                   Return                                                 RETURN
009700000000      *___________________________________________________________________
009800000000      * Process ERROR function
009900000000      *___________________________________________________________________
010000000000     C     PRCERR        Begsr                                                  PROC ADD RQST
010100000000     C                   Move      WTM(4)        WWMSG                          PASS MSG
010200000000     C                   Exsr      SNDMSG                                       SEND MSG
010300000000     C                   Move      'ERROR   '    WORTN                          RETURN ERROR
010400000000     C                   Endsr                                                  END PRCERR
010500000000      *___________________________________________________________________
010600000000      * Delete record with confirmation
010700000000      *___________________________________________________________________
010800000000     C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
010900000000     C                   Exsr      PRPPNL                                       PREPARE PANEL
011000000000B001 C                   Dow       WWSTT <> 'END'                               DOWHILE NOT END
011100000000 001 C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
011200000000 001 C                   Exsr      DSPPNL                                       DISPLAY PANEL
011300000000 001 C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
011400000000 001 C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
011500000000 001 C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
011600000000 001 C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
011700000000 001 C                   Endcs                                                  END CASE
011800000000E001 C                   Enddo                                                  END DOWHILE
011900000000     C                   Endsr                                                  END PRCCNF
012000000000      *___________________________________________________________________
012100000000      * Prepare panel
012200000000      *___________________________________________________________________
012300000000     C     PRPPNL        Begsr                                                  PREPARE PANEL
012400000000     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
012500000000     C                   Exsr      BLDFKY                                       BUILD FNCTNS
012600000000     C                   Exsr      GETREC                                       GET RECORD
012700000000     C                   IF        WWRTN <> *BLANKS
012800000000 001 C                   Move      WTM(2)        WWMSG                          GET MESSAGE
012900000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
013000000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013100000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
013200000000E001 C                   Endif                                                  END IF ERROR
013300000000      *
013400000000     C                   Endsr                                                  END PRPPNL
013500000000      *___________________________________________________________________
013600000000      * Get record for delete
013700000000      *___________________________________________________________________
013800000000     C     GETREC        Begsr                                                  GET REC FOR DLT
013900060313     C                   Call      'UPDRMM  '                                   PROCESS REC IO
014000000000     C                   Parm      'GET     '    WWRQS                          GET RECORD
014100000000     C                   Parm                    WWRTN                          RETURN CODE
014200000000     C                   Parm                    WDDTA                          REC DATA
014300000000B001 C                   If        WWRTN <> *BLANKS                             IF GET ERROR
014400000000 001 C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
014500000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
014600000000 001 C                   Movel     'ERROR'       WORTN                          RETURN ERROR
014700000000 001 C                   Movel     'END'         WWSTT                          RETURN END
014800000000E001 C                   Endif                                                  END ERROR
014900000000     C                   Endsr                                                  END PREP CHANGE
015000000000      *___________________________________________________________________
015100000000      * Dispaly delete confirmation panel
015200000000      *___________________________________________________________________
015300000000     C     DSPPNL        Begsr                                                  DISPLAY PANEL
015400000000      * Set OVERLAY based on last display file processed
015500000000     C                   IF        WQPGMN <> WUPGM
015600000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
015700000000 001 C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
015800000000X001 C                   Else                                                   SAME PGM
015900000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
016000000000E001 C                   Endif                                                  END IF NEW PGM
016100000000      * Write message subfile
016200000000 001 C                   MOVE      *ON           *IN30                          MSGSFLYDISPLAY
016300020226     C                   Write     MSGSFLC                                      DISPLAY MSG SFL
016400000000      * Write delete confirmation panel
016500020226     C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
016600000000     C                   Endsr                                                  END DSPPNL
016700000000      *___________________________________________________________________
016800000000      * Process ENTER request
016900000000      *___________________________________________________________________
017000000000     C     PRCENT        Begsr                                                  PROC ENTER RQS
017100000000     C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
017200000000     C                   IF        WWRTN = *BLANKS
017300000000 001 C                   Exsr      DLTREC                                       DELETE RECORD
017400000000E001 C                   Endif                                                  END IF DLT ALLOWED
017500000000      *
017600000000     C                   IF        WWRTN = *BLANKS
017700000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
017800000000 001 C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
017900000000E001 C                   Endif                                                  END IF DLT ALLOWED
018000000000     C                   Endsr                                                  END PRCENT
018100000000      *___________________________________________________________________
018200000000      * Delete record
018300000000      *___________________________________________________________________
018400000000     C     DLTREC        Begsr                                                  DELETE RECORD
018500000000      *
018600060313     C                   Call      'UPDRMM  '                                   PROCESS REC IO
018700000000     C                   Parm      'DELETE  '    WWRQS                          GET REC
018800000000     C                   Parm                    WWRTN                          RETURN CODE
018900000000     C                   Parm                    WDDTA                          REC DATA
019000000000      *
019100000000     C                   IF        WWRTN <> *BLANKS
019200000000 001 C                   Move      WTM(1)        WWMSG                          GET MESSAGE
019300000000 001 C                   Exsr      SNDMSG                                       SEND MSG
019400000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019500000000E001 C                   Endif                                                  END IF ERROR
019600000000     C                   Endsr                                                  END PRCENT
019700000000      *___________________________________________________________________
019800000000      * Check if delete allowed
019900000000      *___________________________________________________________________
020000000000     C     CHKDLT        Begsr                                                  CHECK DELETE
020100000000     C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
020200060316     C                   Call      'CHKRMM  '                                   PROCESS REC IO
020300060316     C                   Parm      'EDTDLT'      WWRQS                          RELEASE RECORD
020400060316     C                   Parm                    WWRTN                          RETURN CODE
020500060316     C                   Parm                    WDDTA                          REC DATA STRUCTURE
020600000000     C                   Endsr                                                  END CHECK DLT
020700000000      *___________________________________________________________________
020800000000      * Release the record
020900000000      *___________________________________________________________________
021000000000     C     RELREC        Begsr                                                  RELEASE RECORD
021100060313     C                   Call      'UPDRMM  '                                   PROCESS REC IO
021200000000     C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
021300000000     C                   Parm                    WWRTN                          RETURN CODE
021400000000     C                   Parm                    WDDTA                          REC DATA STRUCTURE
021500000000     C                   Endsr                                                  END RELREC
021600000000      *___________________________________________________________________
021700000000      * Receive messages
021800000000      *___________________________________________________________________
021900000000     C     RCVMSG        Begsr                                                  RECEIVE MSG
022000000000     C                   Movea     *IN           WWIN                           INDICATORS
022100000000     C                   Call      'PRCMSG2'                                    CALL MSG PGM
022200000000     C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
022300000000     C                   Parm                    WWIN                           INDICATORS
022400000000     C                   Parm                    WWRTN                          RETURN CODE
022500000000     C                   Movea     WWIN          *IN                            INDICATORS RET
022600000000     C                   Endsr                                                  END RCV MSG
022700000000      *___________________________________________________________________
022800000000      * Build function key information
022900000000      *___________________________________________________________________
023000000000     C     BLDFKY        Begsr                                                  BUILD FNC KEYS
023100000000     C                   Movea     *IN           WWIN                           INDICATORS
023200000000     C                   Call      'PRCFKY2'                                    PROC FNC KYS
023300000000     C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
023400000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
023500000000     C                   Parm                    WAD                            FNC DESC
023600000000     C                   Parm                    WWIN                           *IN
023700000000     C                   Parm                    WAF                            FNC KEY TABLE
023800000000     C                   Parm                    WIFKV                          FNC KYS ALLWD
023900000000      *
024000000000     C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
024100000000     C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
024200000000     C                   Sub       1             WW                             BUMP IDX
024300000000     C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
024400000000     C                   Endsr                                                  END BLD FNCTNS
024500000000      *___________________________________________________________________
024600000000      * Process function keys
024700000000      *___________________________________________________________________
024800000000     C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
024900000000     C                   Movea     *IN           WWIN                           INDICATORS
025000000000     C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
025100000000     C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
025200000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
025300000000     C                   Parm                    WAD                            FNC DESC
025400000000     C                   Parm                    WWIN                           *IN
025500000000     C                   Parm                    WAF                            FNCTN KEY TABLE
025600000000     C                   Parm                    WIFKV                          FNCTN KYS ALLWD
025700000000     C                   Endsr                                                  END PROC FNCTNS
025800000000      *___________________________________________________________________
025900000000      * Process EXIT function
026000000000      *___________________________________________________________________
026100000000     C     PRCEXT        Begsr                                                  EXIT
026200000000     C                   Exsr      RELREC                                       RELEASE RECORD
026300000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
026400000000     C                   Move      'END'         WWSTT                          END INVOCATION
026500000000     C                   Endsr                                                  END RETURN
026600000000      *___________________________________________________________________
026700000000      * Process CANCEL function
026800000000      *___________________________________________________________________
026900000000     C     PRCCNL        Begsr                                                  CANCEL
027000000000     C                   Exsr      RELREC                                       RELEASE RECORD
027100000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
027200000000     C                   Move      'END'         WWSTT                          END INVOCATION
027300000000     C                   Endsr                                                  END RETURN
027400000000      *___________________________________________________________________
027500000000      * Send message
027600000000      *___________________________________________________________________
027700000000     C     SNDMSG        Begsr                                                  SEND MESSAGE
027800000000     C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
027900000000     C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
028000000000     C                   Parm      'QTEMP'       WWLIB                          DATA QUEUE LIB
028100000000     C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
028200000000     C                   Parm                    WWMSG                          ERROR MESSAGE
028300000000     C                   Endsr                                                  END PROC FNC
028400000000      *___________________________________________________________________
028500000000      * Parameter lists
028600000000      *___________________________________________________________________
028700000000     C     PLIST         Begsr                                                  PARM LISTS
028800000000     C     *ENTRY        Plist                                                  *ENTRY LIST
028900000000     C                   Parm                    WIRQS                          EXT MODE
029000000000     C                   Parm                    WORTN                          INTERNAL MODE
029100000000     C                   Parm                    WUPGM                          LAST PGM NAME
029200000000     C                   Parm                    WDDTA                          RECORD DS
029300000000     C                   Parm                    WIFKV                          FUNCTIONS VALID
029400000000     C                   Endsr                                                  END PLIST
029500000000      *___________________________________________________________________
029600000000      * Initialize routine
029700000000      *___________________________________________________________________
029800000000     C     *INZSR        Begsr                                                  INITIALIZE
029900000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
030000000000     C                   Z-add     1             WWFKS                          FNC KEY SET
030100000000     C                   Z-add     *ZEROS        WW                             WORK INDEX
030200000000     C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
030300000000     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
030400000000     C                   Move      *BLANKS       WWRTN                          RETURN CODE
030500000000     C                   Endsr                                                  END *INZSR
030600000000      *___________________________________________________________________
030700000000      * Program error handler
030800000000      *___________________________________________________________________
030900000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
031000000000     C                   Call      'SNDRPGM'                            50      SEND RPG MSG
031100000000     C                   Parm                    WQPGMN                         PROGRAM NAME
031200000000     C                   Parm                    WQSTSC                         STATUS CODE
031300000000     C                   Parm                    WQRPGS                         RPG STATEMENT
031400000000     C                   Parm                    WQMSG                          MESSAGE ID
031500000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
031600000000      *___________________________________________________________________
031700000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03180000000003EXIT    F3=Exit
03190000000012CANCEL  F12=Cancel
032000000000** WTM
03210000000000Record not deleted. No longer available.
03220006031300RELATIONSHIP MANAGER MASTER record not found.
03230006031300Call to UPDRMM failed.
03240006031300Request not supported in program DLTRMM.
