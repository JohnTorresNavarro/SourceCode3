000100000000      *_________________________________________________________________________
000200000000      *
000300030521      *  Description:  Delete TEMPORARY GROUP NUMBER
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *_________________________________________________________________________
000700000000      *
000800030521     FDLTTMPD   CF   E             WORKSTN INFDS(DSPD)
000900000000      *_________________________________________________________________________
001000000000      *
001100000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001200000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001300000000     D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001400000000      *_________________________________________________________________________
001500000000      *
001600000000      * Data structure
001700030521     D WDDTA         E DS                  EXTNAME(TEMPG#)
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
002900030521     D WILEN           S              3P 0
003000021008     D WIOPV           S                   LIKE(WIFKV)
003100021008     D WIRQS           S              8A
003200030521     D WISTR           S            256A
003300021008     D WORTN           S              8A
003400021008     D WUPGM           S             10A
003500021008     D WWCHG           S              1A
003600021008     D WWDLT           S              1A
003700021008     D WWDTAQ          S             10A
003800021008     D WWENDF          S              3A
003900021008     D WWENDO          S                   LIKE(WWENDF)
004000021008     D WWERR           S              1A
004100021008     D WWFIL           S             10A
004200021008     D WWFKA           S              8A
004300021008     D WWFKV           S                   LIKE(WIFKV)
004400021008     D WWFKY           S                   LIKE(WIFKV)
004500021008     D WWFLK           S            128A
004600021008     D WWFMTN          S              8A
004700021008     D WWFNC           S              8A
004800021008     D WWIJI           S             16A
004900021008     D WWIN            S             99A
005000021008     D WWLIB           S             10A
005100021008     D WWMSG           S             80A
005200021008     D WWMSGC          S              7A
005300021008     D WWOCD           S              8A
005400021008     D WWOPA           S              8A
005500021008     D WWOPN           S              1A
005600021008     D WWOPT           S              8A
005700021008     D WWOPV           S                   LIKE(WIFKV)
005800021008     D WWORQS          S                   LIKE(WIRQS)
005900021008     D WWPSNC          S              1A
006000021008     D WWQJN           S             26A
006100021008     D WWRQS           S                   LIKE(WIRQS)
006200021008     D WWRQSD          S                   LIKE(WIRQS)
006300021008     D WWRTN           S                   LIKE(WORTN)
006400021008     D WWRTND          S                   LIKE(WORTN)
006500021008     D WWRTNH          S                   LIKE(WORTN)
006600021008     D WWSFLE          S              1A
006700021008     D WWSTT           S              3A
006800021008     D WWTSK           S              8A
006900021008     D WWTXT           S             60A
007000021008     D WWUPD           S              1A
007100021008     D WWWRNF          S              1A
007200021008     D WWZERO          S             40A
007300021008     D WFRRN           S              4P 0
007400021008     D WW              S              3P 0
007500021008     D WWFKS           S              1P 0
007600021008     D WWFKSO          S                   LIKE(WWFKS)
007700021008     D WWLMT           S              2P 0
007800021008     D WWLNG           S             15P 5
007900021008     D WWLNGQ          S              5P 0
008000021008     D WWLOWR          S              4P 0
008100021008     D WWLSTS          S              2P 0
008200021008     D WWOPS           S              1P 0
008300021008     D WWOPSO          S                   LIKE(WWOPS)
008400021008     D WWPNL           S              1P 0
008500021008     D WWPNLN          S                   LIKE(WWPNL)
008600021008     D WWPNLO          S                   LIKE(WWPNL)
008700021008     D WWPSNI          S              2P 0
008800021008     D WWPSNN          S              1P 0
008900021008     D WWPSNP          S                   LIKE(WWPSNN)
009000021008     D WWRRN           S              4P 0
009100000000      *
009200000000      *___________________________________________________________________
009300000000      * Process delete request
009400000000     C                   Move      *BLANKS       WORTN                          SET RETURN CODE
009500000000     C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
009600000000     C                   Cas                     PRCERR                         PROCESS ERROR
009700000000     C                   Endcs                                                  END CASE
009800000000     C                   Return                                                 RETURN
009900000000      *___________________________________________________________________
010000000000      * Process ERROR function
010100000000      *___________________________________________________________________
010200000000     C     PRCERR        Begsr                                                  PROC ADD RQST
010300000000     C                   Move      WTM(4)        WWMSG                          PASS MSG
010400000000     C                   Exsr      SNDMSG                                       SEND MSG
010500000000     C                   Move      'ERROR   '    WORTN                          RETURN ERROR
010600000000     C                   Endsr                                                  END PRCERR
010700000000      *___________________________________________________________________
010800000000      * Delete record with confirmation
010900000000      *___________________________________________________________________
011000000000     C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
011100000000     C                   Exsr      PRPPNL                                       PREPARE PANEL
011200000000B001 C                   Dow       WWSTT <> 'END'                               DOWHILE NOT END
011300000000 001 C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
011400000000 001 C                   Exsr      DSPPNL                                       DISPLAY PANEL
011500000000 001 C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
011600000000 001 C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
011700000000 001 C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
011800000000 001 C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
011900000000 001 C                   Endcs                                                  END CASE
012000000000E001 C                   Enddo                                                  END DOWHILE
012100000000     C                   Endsr                                                  END PRCCNF
012200000000      *___________________________________________________________________
012300000000      * Prepare panel
012400000000      *___________________________________________________________________
012500000000     C     PRPPNL        Begsr                                                  PREPARE PANEL
012600000000     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
012700000000     C                   Exsr      BLDFKY                                       BUILD FNCTNS
012800000000     C                   Exsr      GETREC                                       GET RECORD
012900000000     C                   IF        WWRTN <> *BLANKS
013000000000 001 C                   Move      WTM(2)        WWMSG                          GET MESSAGE
013100000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
013200000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013300000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
013400000000E001 C                   Endif                                                  END IF ERROR
013500000000      *
013600000000     C                   Endsr                                                  END PRPPNL
013700000000      *___________________________________________________________________
013800000000      * Get record for delete
013900000000      *___________________________________________________________________
014000000000     C     GETREC        Begsr                                                  GET REC FOR DLT
014100030521     C                   Call      'UPDTMP  '                                   PROCESS REC IO
014200000000     C                   Parm      'GET     '    WWRQS                          GET RECORD
014300000000     C                   Parm                    WWRTN                          RETURN CODE
014400000000     C                   Parm                    WDDTA                          REC DATA
014500000000B001 C                   If        WWRTN <> *BLANKS                             IF GET ERROR
014600000000 001 C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
014700000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
014800000000 001 C                   Movel     'ERROR'       WORTN                          RETURN ERROR
014900000000 001 C                   Movel     'END'         WWSTT                          RETURN END
015000000000E001 C                   Endif                                                  END ERROR
015100000000     C                   Endsr                                                  END PREP CHANGE
015200000000      *___________________________________________________________________
015300000000      * Dispaly delete confirmation panel
015400000000      *___________________________________________________________________
015500000000     C     DSPPNL        Begsr                                                  DISPLAY PANEL
015600000000      * Set OVERLAY based on last display file processed
015700000000     C                   IF        WQPGMN <> WUPGM
015800000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
015900000000 001 C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
016000000000X001 C                   Else                                                   SAME PGM
016100000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
016200000000E001 C                   Endif                                                  END IF NEW PGM
016300000000      * Write message subfile
016400000000 001 C                   MOVE      *ON           *IN30                          MSGSFLYDISPLAY
016500020226     C                   Write     MSGSFLC                                      DISPLAY MSG SFL
016600000000      * Write delete confirmation panel
016700020226     C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
016800000000     C                   Endsr                                                  END DSPPNL
016900000000      *___________________________________________________________________
017000000000      * Process ENTER request
017100000000      *___________________________________________________________________
017200000000     C     PRCENT        Begsr                                                  PROC ENTER RQS
017300000000     C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
017400000000     C                   IF        WWRTN = *BLANKS
017500000000 001 C                   Exsr      DLTREC                                       DELETE RECORD
017600000000E001 C                   Endif                                                  END IF DLT ALLOWED
017700000000      *
017800000000     C                   IF        WWRTN = *BLANKS
017900000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
018000000000 001 C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
018100000000E001 C                   Endif                                                  END IF DLT ALLOWED
018200000000     C                   Endsr                                                  END PRCENT
018300000000      *___________________________________________________________________
018400000000      * Delete record
018500000000      *___________________________________________________________________
018600000000     C     DLTREC        Begsr                                                  DELETE RECORD
018700000000      *
018800030521     C                   Call      'UPDTMP  '                                   PROCESS REC IO
018900000000     C                   Parm      'DELETE  '    WWRQS                          GET REC
019000000000     C                   Parm                    WWRTN                          RETURN CODE
019100000000     C                   Parm                    WDDTA                          REC DATA
019200000000      *
019300000000     C                   IF        WWRTN <> *BLANKS
019400000000 001 C                   Move      WTM(1)        WWMSG                          GET MESSAGE
019500000000 001 C                   Exsr      SNDMSG                                       SEND MSG
019600000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019700000000E001 C                   Endif                                                  END IF ERROR
019800000000     C                   Endsr                                                  END PRCENT
019900000000      *___________________________________________________________________
020000000000      * Check if delete allowed
020100000000      *___________________________________________________________________
020200000000     C     CHKDLT        Begsr                                                  CHECK DELETE
020300000000     C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
020400000000     C                   Endsr                                                  END CHECK DLT
020500000000      *___________________________________________________________________
020600000000      * Release the record
020700000000      *___________________________________________________________________
020800000000     C     RELREC        Begsr                                                  RELEASE RECORD
020900030521     C                   Call      'UPDTMP  '                                   PROCESS REC IO
021000000000     C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
021100000000     C                   Parm                    WWRTN                          RETURN CODE
021200000000     C                   Parm                    WDDTA                          REC DATA STRUCTURE
021300000000     C                   Endsr                                                  END RELREC
021400000000      *___________________________________________________________________
021500000000      * Receive messages
021600000000      *___________________________________________________________________
021700000000     C     RCVMSG        Begsr                                                  RECEIVE MSG
021800000000     C                   Movea     *IN           WWIN                           INDICATORS
021900000000     C                   Call      'PRCMSG2'                                    CALL MSG PGM
022000000000     C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
022100000000     C                   Parm                    WWIN                           INDICATORS
022200000000     C                   Parm                    WWRTN                          RETURN CODE
022300000000     C                   Movea     WWIN          *IN                            INDICATORS RET
022400000000     C                   Endsr                                                  END RCV MSG
022500000000      *___________________________________________________________________
022600000000      * Build function key information
022700000000      *___________________________________________________________________
022800000000     C     BLDFKY        Begsr                                                  BUILD FNC KEYS
022900000000     C                   Movea     *IN           WWIN                           INDICATORS
023000000000     C                   Call      'PRCFKY2'                                    PROC FNC KYS
023100000000     C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
023200000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
023300000000     C                   Parm                    WAD                            FNC DESC
023400000000     C                   Parm                    WWIN                           *IN
023500000000     C                   Parm                    WAF                            FNC KEY TABLE
023600000000     C                   Parm                    WIFKV                          FNC KYS ALLWD
023700000000      *
023800000000     C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
023900000000     C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
024000000000     C                   Sub       1             WW                             BUMP IDX
024100000000     C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
024200000000     C                   Endsr                                                  END BLD FNCTNS
024300000000      *___________________________________________________________________
024400000000      * Process function keys
024500000000      *___________________________________________________________________
024600000000     C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
024700000000     C                   Movea     *IN           WWIN                           INDICATORS
024800000000     C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
024900000000     C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
025000000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
025100000000     C                   Parm                    WAD                            FNC DESC
025200000000     C                   Parm                    WWIN                           *IN
025300000000     C                   Parm                    WAF                            FNCTN KEY TABLE
025400000000     C                   Parm                    WIFKV                          FNCTN KYS ALLWD
025500000000     C                   Endsr                                                  END PROC FNCTNS
025600000000      *___________________________________________________________________
025700000000      * Process EXIT function
025800000000      *___________________________________________________________________
025900000000     C     PRCEXT        Begsr                                                  EXIT
026000000000     C                   Exsr      RELREC                                       RELEASE RECORD
026100000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
026200000000     C                   Move      'END'         WWSTT                          END INVOCATION
026300000000     C                   Endsr                                                  END RETURN
026400000000      *___________________________________________________________________
026500000000      * Process CANCEL function
026600000000      *___________________________________________________________________
026700000000     C     PRCCNL        Begsr                                                  CANCEL
026800000000     C                   Exsr      RELREC                                       RELEASE RECORD
026900000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
027000000000     C                   Move      'END'         WWSTT                          END INVOCATION
027100000000     C                   Endsr                                                  END RETURN
027200000000      *___________________________________________________________________
027300000000      * Send message
027400000000      *___________________________________________________________________
027500000000     C     SNDMSG        Begsr                                                  SEND MESSAGE
027600000000     C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
027700000000     C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
027800000000     C                   Parm      'QTEMP'       WWLIB                          DATA QUEUE LIB
027900000000     C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
028000000000     C                   Parm                    WWMSG                          ERROR MESSAGE
028100000000     C                   Endsr                                                  END PROC FNC
028200000000      *___________________________________________________________________
028300000000      * Parameter lists
028400000000      *___________________________________________________________________
028500000000     C     PLIST         Begsr                                                  PARM LISTS
028600000000     C     *ENTRY        Plist                                                  *ENTRY LIST
028700000000     C                   Parm                    WIRQS                          EXT MODE
028800000000     C                   Parm                    WORTN                          INTERNAL MODE
028900000000     C                   Parm                    WUPGM                          LAST PGM NAME
029000000000     C                   Parm                    WDDTA                          RECORD DS
029100000000     C                   Parm                    WIFKV                          FUNCTIONS VALID
029200000000     C                   Endsr                                                  END PLIST
029300000000      *___________________________________________________________________
029400000000      * Initialize routine
029500000000      *___________________________________________________________________
029600000000     C     *INZSR        Begsr                                                  INITIALIZE
029700030521    ***
029800030521     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
029900030521     C                   IN        @DTA50
030000030521    ***
030100030521     C                   EVAL      wistr = %SUBST(@DTA50:1:40)
030200030521     C                   Z-ADD     50            WILEN
030300030521     C                   CALL      'UTLCENSTR'
030400030521     C                   PARM                    WISTR
030500030521     C                   PARM                    WILEN
030600030521     C                   MOVEL     WISTR         WSNAME
030700030521    ***
030800000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
030900000000     C                   Z-add     1             WWFKS                          FNC KEY SET
031000000000     C                   Z-add     *ZEROS        WW                             WORK INDEX
031100000000     C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
031200000000     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
031300000000     C                   Move      *BLANKS       WWRTN                          RETURN CODE
031400000000     C                   Endsr                                                  END *INZSR
031500000000      *___________________________________________________________________
031600000000      * Program error handler
031700000000      *___________________________________________________________________
031800000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
031900000000     C                   Call      'SNDRPGM'                            50      SEND RPG MSG
032000000000     C                   Parm                    WQPGMN                         PROGRAM NAME
032100000000     C                   Parm                    WQSTSC                         STATUS CODE
032200000000     C                   Parm                    WQRPGS                         RPG STATEMENT
032300000000     C                   Parm                    WQMSG                          MESSAGE ID
032400000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
032500000000      *___________________________________________________________________
032600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03270000000003EXIT    F3=Exit
03280000000012CANCEL  F12=Cancel
032900000000** WTM
03300000000000Record not deleted. No longer available.
03310003052100Temporary Group Number record not found.
03320003052100Call to UPDTMP failed.
03330003052100Request not supported in program DLTTMP.
