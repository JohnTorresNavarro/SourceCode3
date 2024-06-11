000100170720     H option(*noDebugIo)
000200000000      *_________________________________________________________________________
000300000000      *
000400110831      *  Description:  Delete ACH Override Amounts
000500000000      *
000600110715      *  (C)COPYRIGHT 2011 BY GROUP BENEFIT SERVICES, INC.
000700000000      *_________________________________________________________________________
000800000000      *
000900110831     FDLTACOD   CF   E             WORKSTN INFDS(DSPD)
001000170801     FACCMST    IF   E           K Disk    ExtFile('F.TRSMST')
001100170718     FAFAREM    IF   E           K DISK
001200000000      *_________________________________________________________________________
001300000000      *
001400000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001600000000     D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001700000000      *_________________________________________________________________________
001800000000      *
001900000000      * Data structure
002000170718     D WDDTA         E DS                  EXTNAME(AFAAOV)
002100000000      *
002200000000      * Program status data structure
002300000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002400000000      *
002500000000      * Display file data structure
002600000000     D DSPD          E DS                  EXTNAME(IODSPD)
002700000000      *
002800000000     D WDFILE        E DS                  EXTNAME(IODBFD)
002900000000      *
003000021008     D WIFKV           S             60A
003100021008     D WIFKY           S                   LIKE(WIFKV)
003200021008     D WIOPV           S                   LIKE(WIFKV)
003300021008     D WIRQS           S              8A
003400021008     D WORTN           S              8A
003500021008     D WUPGM           S             10A
003600021008     D WWCHG           S              1A
003700021008     D WWDLT           S              1A
003800021008     D WWDTAQ          S             10A
003900021008     D WWENDF          S              3A
004000021008     D WWENDO          S                   LIKE(WWENDF)
004100021008     D WWERR           S              1A
004200021008     D WWFIL           S             10A
004300021008     D WWFKA           S              8A
004400021008     D WWFKV           S                   LIKE(WIFKV)
004500021008     D WWFKY           S                   LIKE(WIFKV)
004600021008     D WWFLK           S            128A
004700021008     D WWFMTN          S              8A
004800021008     D WWFNC           S              8A
004900021008     D WWIJI           S             16A
005000021008     D WWIN            S             99A
005100021008     D WWLIB           S             10A
005200021008     D WWMSG           S             80A
005300021008     D WWMSGC          S              7A
005400021008     D WWOCD           S              8A
005500021008     D WWOPA           S              8A
005600021008     D WWOPN           S              1A
005700021008     D WWOPT           S              8A
005800021008     D WWOPV           S                   LIKE(WIFKV)
005900021008     D WWORQS          S                   LIKE(WIRQS)
006000021008     D WWPSNC          S              1A
006100021008     D WWQJN           S             26A
006200021008     D WWRQS           S                   LIKE(WIRQS)
006300021008     D WWRQSD          S                   LIKE(WIRQS)
006400021008     D WWRTN           S                   LIKE(WORTN)
006500021008     D WWRTND          S                   LIKE(WORTN)
006600021008     D WWRTNH          S                   LIKE(WORTN)
006700021008     D WWSFLE          S              1A
006800021008     D WWSTT           S              3A
006900021008     D WWTSK           S              8A
007000021008     D WWTXT           S             60A
007100021008     D WWUPD           S              1A
007200021008     D WWWRNF          S              1A
007300021008     D WWZERO          S             40A
007400021008     D WFRRN           S              4P 0
007500021008     D WW              S              3P 0
007600021008     D WWFKS           S              1P 0
007700021008     D WWFKSO          S                   LIKE(WWFKS)
007800021008     D WWLMT           S              2P 0
007900021008     D WWLNG           S             15P 5
008000021008     D WWLNGQ          S              5P 0
008100021008     D WWLOWR          S              4P 0
008200021008     D WWLSTS          S              2P 0
008300021008     D WWOPS           S              1P 0
008400021008     D WWOPSO          S                   LIKE(WWOPS)
008500021008     D WWPNL           S              1P 0
008600021008     D WWPNLN          S                   LIKE(WWPNL)
008700021008     D WWPNLO          S                   LIKE(WWPNL)
008800021008     D WWPSNI          S              2P 0
008900021008     D WWPSNN          S              1P 0
009000021008     D WWPSNP          S                   LIKE(WWPSNN)
009100021008     D WWRRN           S              4P 0
009200000000      *
009300040518     ***
009400040518     d bch@lda         ds
009500040518     d blah                    1    240a
009600040518     d co_name               200    240a
009700040518      *___________________________________________________________________
009800040518     C     *dtaara       define    *lda          bch@lda
009900040518     C                   in        bch@lda
010000040518     c                   eval      wsname = co_name
010100110715    ?C     AccKey        Chain     ACCMST
010200110715    ?C                   If        %Found(ACCMST)
010300110715     C                   Eval      WSNAM1   =    ACNAM1
010400110715    ?C                   Else
010500110715     C                   Clear                   WSNAM1
010600110715    ?C                   End
010700000000      *___________________________________________________________________
010800000000      * Process delete request
010900000000     C                   Move      *BLANKS       WORTN                          SET RETURN CODE
011000000000     C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
011100000000     C                   Cas                     PRCERR                         PROCESS ERROR
011200000000     C                   Endcs                                                  END CASE
011300000000     C                   Return                                                 RETURN
011400000000      *___________________________________________________________________
011500000000      * Process ERROR function
011600000000      *___________________________________________________________________
011700000000     C     PRCERR        Begsr                                                  PROC ADD RQST
011800000000     C                   Move      WTM(4)        WWMSG                          PASS MSG
011900000000     C                   Exsr      SNDMSG                                       SEND MSG
012000000000     C                   Move      'ERROR   '    WORTN                          RETURN ERROR
012100000000     C                   Endsr                                                  END PRCERR
012200000000      *___________________________________________________________________
012300000000      * Delete record with confirmation
012400000000      *___________________________________________________________________
012500000000     C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
012600000000     C                   Exsr      PRPPNL                                       PREPARE PANEL
012700000000B001 C                   Dow       WWSTT <> 'END'                               DOWHILE NOT END
012800000000 001 C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
012900000000 001 C                   Exsr      DSPPNL                                       DISPLAY PANEL
013000000000 001 C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
013100000000 001 C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
013200000000 001 C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
013300000000 001 C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
013400000000 001 C                   Endcs                                                  END CASE
013500000000E001 C                   Enddo                                                  END DOWHILE
013600000000     C                   Endsr                                                  END PRCCNF
013700000000      *___________________________________________________________________
013800000000      * Prepare panel
013900000000      *___________________________________________________________________
014000000000     C     PRPPNL        Begsr                                                  PREPARE PANEL
014100000000     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
014200000000     C                   Exsr      BLDFKY                                       BUILD FNCTNS
014300000000     C                   Exsr      GETREC                                       GET RECORD
014400170718     C     AccKey        Chain     AFAREM
014500170718     C                   If        %Found(AFAREM)
014600110906     C                   Eval      ARWAMT = DATOT
014700110906     C                   Else
014800110906     C                   End
014900000000     C                   IF        WWRTN <> *BLANKS
015000000000 001 C                   Move      WTM(2)        WWMSG                          GET MESSAGE
015100000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
015200000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015300000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
015400000000E001 C                   Endif                                                  END IF ERROR
015500000000      *
015600000000     C                   Endsr                                                  END PRPPNL
015700000000      *___________________________________________________________________
015800000000      * Get record for delete
015900000000      *___________________________________________________________________
016000000000     C     GETREC        Begsr                                                  GET REC FOR DLT
016100170720     C                   Call      'UPDAFO  '                                   PROCESS REC IO
016200000000     C                   Parm      'GET     '    WWRQS                          GET RECORD
016300000000     C                   Parm                    WWRTN                          RETURN CODE
016400000000     C                   Parm                    WDDTA                          REC DATA
016500000000B001 C                   If        WWRTN <> *BLANKS                             IF GET ERROR
016600000000 001 C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
016700000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
016800000000 001 C                   Movel     'ERROR'       WORTN                          RETURN ERROR
016900000000 001 C                   Movel     'END'         WWSTT                          RETURN END
017000000000E001 C                   Endif                                                  END ERROR
017100000000     C                   Endsr                                                  END PREP CHANGE
017200000000      *___________________________________________________________________
017300000000      * Dispaly delete confirmation panel
017400000000      *___________________________________________________________________
017500000000     C     DSPPNL        Begsr                                                  DISPLAY PANEL
017600000000      * Set OVERLAY based on last display file processed
017700000000     C                   IF        WQPGMN <> WUPGM
017800000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
017900000000 001 C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
018000000000X001 C                   Else                                                   SAME PGM
018100000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
018200000000E001 C                   Endif                                                  END IF NEW PGM
018300000000      * Write message subfile
018400000000 001 C                   MOVE      *ON           *IN30                          MSGSFLYDISPLAY
018500020226     C                   Write     MSGSFLC                                      DISPLAY MSG SFL
018600000000      * Write delete confirmation panel
018700020226     C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
018800000000     C                   Endsr                                                  END DSPPNL
018900000000      *___________________________________________________________________
019000000000      * Process ENTER request
019100000000      *___________________________________________________________________
019200000000     C     PRCENT        Begsr                                                  PROC ENTER RQS
019300000000     C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
019400000000     C                   IF        WWRTN = *BLANKS
019500000000 001 C                   Exsr      DLTREC                                       DELETE RECORD
019600000000E001 C                   Endif                                                  END IF DLT ALLOWED
019700000000      *
019800000000     C                   IF        WWRTN = *BLANKS
019900000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
020000000000 001 C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
020100000000E001 C                   Endif                                                  END IF DLT ALLOWED
020200000000     C                   Endsr                                                  END PRCENT
020300000000      *___________________________________________________________________
020400000000      * Delete record
020500000000      *___________________________________________________________________
020600000000     C     DLTREC        Begsr                                                  DELETE RECORD
020700000000      *
020800170720     C                   Call      'UPDAFO  '                                   PROCESS REC IO
020900000000     C                   Parm      'DELETE  '    WWRQS                          GET REC
021000000000     C                   Parm                    WWRTN                          RETURN CODE
021100000000     C                   Parm                    WDDTA                          REC DATA
021200000000      *
021300000000     C                   IF        WWRTN <> *BLANKS
021400000000 001 C                   Move      WTM(1)        WWMSG                          GET MESSAGE
021500000000 001 C                   Exsr      SNDMSG                                       SEND MSG
021600000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
021700000000E001 C                   Endif                                                  END IF ERROR
021800000000     C                   Endsr                                                  END PRCENT
021900000000      *___________________________________________________________________
022000000000      * Check if delete allowed
022100000000      *___________________________________________________________________
022200000000     C     CHKDLT        Begsr                                                  CHECK DELETE
022300000000     C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
022400000000     C                   Endsr                                                  END CHECK DLT
022500000000      *___________________________________________________________________
022600000000      * Release the record
022700000000      *___________________________________________________________________
022800000000     C     RELREC        Begsr                                                  RELEASE RECORD
022900170720     C                   Call      'UPDAFO  '                                   PROCESS REC IO
023000000000     C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
023100000000     C                   Parm                    WWRTN                          RETURN CODE
023200000000     C                   Parm                    WDDTA                          REC DATA STRUCTURE
023300000000     C                   Endsr                                                  END RELREC
023400000000      *___________________________________________________________________
023500000000      * Receive messages
023600000000      *___________________________________________________________________
023700000000     C     RCVMSG        Begsr                                                  RECEIVE MSG
023800000000     C                   Movea     *IN           WWIN                           INDICATORS
023900000000     C                   Call      'PRCMSG2'                                    CALL MSG PGM
024000000000     C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
024100000000     C                   Parm                    WWIN                           INDICATORS
024200000000     C                   Parm                    WWRTN                          RETURN CODE
024300000000     C                   Movea     WWIN          *IN                            INDICATORS RET
024400000000     C                   Endsr                                                  END RCV MSG
024500000000      *___________________________________________________________________
024600000000      * Build function key information
024700000000      *___________________________________________________________________
024800000000     C     BLDFKY        Begsr                                                  BUILD FNC KEYS
024900000000     C                   Movea     *IN           WWIN                           INDICATORS
025000000000     C                   Call      'PRCFKY2'                                    PROC FNC KYS
025100000000     C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
025200000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
025300000000     C                   Parm                    WAD                            FNC DESC
025400000000     C                   Parm                    WWIN                           *IN
025500000000     C                   Parm                    WAF                            FNC KEY TABLE
025600000000     C                   Parm                    WIFKV                          FNC KYS ALLWD
025700000000      *
025800000000     C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
025900000000     C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
026000000000     C                   Sub       1             WW                             BUMP IDX
026100000000     C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
026200000000     C                   Endsr                                                  END BLD FNCTNS
026300000000      *___________________________________________________________________
026400000000      * Process function keys
026500000000      *___________________________________________________________________
026600000000     C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
026700000000     C                   Movea     *IN           WWIN                           INDICATORS
026800000000     C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
026900000000     C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
027000000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
027100000000     C                   Parm                    WAD                            FNC DESC
027200000000     C                   Parm                    WWIN                           *IN
027300000000     C                   Parm                    WAF                            FNCTN KEY TABLE
027400000000     C                   Parm                    WIFKV                          FNCTN KYS ALLWD
027500000000     C                   Endsr                                                  END PROC FNCTNS
027600000000      *___________________________________________________________________
027700000000      * Process EXIT function
027800000000      *___________________________________________________________________
027900000000     C     PRCEXT        Begsr                                                  EXIT
028000000000     C                   Exsr      RELREC                                       RELEASE RECORD
028100000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
028200000000     C                   Move      'END'         WWSTT                          END INVOCATION
028300000000     C                   Endsr                                                  END RETURN
028400000000      *___________________________________________________________________
028500000000      * Process CANCEL function
028600000000      *___________________________________________________________________
028700000000     C     PRCCNL        Begsr                                                  CANCEL
028800000000     C                   Exsr      RELREC                                       RELEASE RECORD
028900000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
029000000000     C                   Move      'END'         WWSTT                          END INVOCATION
029100000000     C                   Endsr                                                  END RETURN
029200000000      *___________________________________________________________________
029300000000      * Send message
029400000000      *___________________________________________________________________
029500000000     C     SNDMSG        Begsr                                                  SEND MESSAGE
029600000000     C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
029700000000     C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
029800000000     C                   Parm      'QTEMP'       WWLIB                          DATA QUEUE LIB
029900000000     C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
030000000000     C                   Parm                    WWMSG                          ERROR MESSAGE
030100000000     C                   Endsr                                                  END PROC FNC
030200000000      *___________________________________________________________________
030300000000      * Parameter lists
030400000000      *___________________________________________________________________
030500000000     C     PLIST         Begsr                                                  PARM LISTS
030600000000     C     *ENTRY        Plist                                                  *ENTRY LIST
030700000000     C                   Parm                    WIRQS                          EXT MODE
030800000000     C                   Parm                    WORTN                          INTERNAL MODE
030900000000     C                   Parm                    WUPGM                          LAST PGM NAME
031000000000     C                   Parm                    WDDTA                          RECORD DS
031100000000     C                   Parm                    WIFKV                          FUNCTIONS VALID
031200000000     C                   Endsr                                                  END PLIST
031300000000      *___________________________________________________________________
031400000000      * Initialize routine
031500000000      *___________________________________________________________________
031600000000     C     *INZSR        Begsr                                                  INITIALIZE
031700000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
031800000000     C                   Z-add     1             WWFKS                          FNC KEY SET
031900000000     C                   Z-add     *ZEROS        WW                             WORK INDEX
032000000000     C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
032100000000     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
032200000000     C                   Move      *BLANKS       WWRTN                          RETURN CODE
032300000000     C                   Endsr                                                  END *INZSR
032400110715      *___________________________________________________________________
032500110715      * Key lists
032600110715      *___________________________________________________________________
032700110715     C     KLIST         Begsr                                                  KEY LISTS
032800110715    ?C     SubKey        Klist                                                  ACKCTL
032900110831    ?C                   Kfld                    ARTRST
033000110831    ?C                   Kfld                    ARSUB#
033100110715    ?C     AccKey        Klist                                                  ACKCTL
033200110831    ?C                   Kfld                    ARTRST
033300110831    ?C                   Kfld                    ARSUB#
033400110831    ?C                   Kfld                    ARACCT
033500110715     C                   Endsr                                                  END KLIST
033600000000      * Program error handler
033700000000      *___________________________________________________________________
033800000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
033900000000     C                   Call      'SNDRPGM'                            50      SEND RPG MSG
034000000000     C                   Parm                    WQPGMN                         PROGRAM NAME
034100000000     C                   Parm                    WQSTSC                         STATUS CODE
034200000000     C                   Parm                    WQRPGS                         RPG STATEMENT
034300000000     C                   Parm                    WQMSG                          MESSAGE ID
034400000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
034500000000      *___________________________________________________________________
034600000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03470000000003EXIT    F3=Exit
03480000000012CANCEL  F12=Cancel
034900000000** WTM
03500000000000Record not deleted. No longer available.
03510011071500Exclusion record not found.
03520011083100Call to UPDACO failed.
03530011083100Request not supported in program DLTACO.
