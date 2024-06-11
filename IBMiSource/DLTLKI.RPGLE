000100000000      *_________________________________________________________________________
000200000000      *
000300090317      *  Description:  Delete LINK ID MAINT
000400000000      *
000500090204      *  (C)COPYRIGHT 2009 BY GROUP BENEFIT SERVICES, INC.
000600000000      *_________________________________________________________________________
000700000000      *
000800090317     FDLTLKID   CF   E             WORKSTN INFDS(DSPD)
000900000000      *_________________________________________________________________________
001000090318      *
001100090318     D #ISO            S               D   DATFMT(*ISO)
001200090318     D @44             S             44A
001300000000      *
001400000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001600000000     D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001700000000      *_________________________________________________________________________
001800000000      *
001900000000      * Data structure
002000090318     D WDDTA         E DS                  EXTNAME(SPRAGXRF)
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
009300000000      *___________________________________________________________________
009400000000      * Process delete request
009500000000     C                   Move      *BLANKS       WORTN                          SET RETURN CODE
009600000000     C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
009700000000     C                   Cas                     PRCERR                         PROCESS ERROR
009800000000     C                   Endcs                                                  END CASE
009900000000     C                   Return                                                 RETURN
010000000000      *___________________________________________________________________
010100000000      * Process ERROR function
010200000000      *___________________________________________________________________
010300000000     C     PRCERR        Begsr                                                  PROC ADD RQST
010400000000     C                   Move      WTM(4)        WWMSG                          PASS MSG
010500000000     C                   Exsr      SNDMSG                                       SEND MSG
010600000000     C                   Move      'ERROR   '    WORTN                          RETURN ERROR
010700000000     C                   Endsr                                                  END PRCERR
010800000000      *___________________________________________________________________
010900000000      * Delete record with confirmation
011000000000      *___________________________________________________________________
011100000000     C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
011200000000     C                   Exsr      PRPPNL                                       PREPARE PANEL
011300000000B001 C                   Dow       WWSTT <> 'END'                               DOWHILE NOT END
011400000000 001 C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
011500000000 001 C                   Exsr      DSPPNL                                       DISPLAY PANEL
011600000000 001 C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
011700000000 001 C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
011800000000 001 C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
011900000000 001 C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
012000000000 001 C                   Endcs                                                  END CASE
012100000000E001 C                   Enddo                                                  END DOWHILE
012200000000     C                   Endsr                                                  END PRCCNF
012300000000      *___________________________________________________________________
012400000000      * Prepare panel
012500000000      *___________________________________________________________________
012600000000     C     PRPPNL        Begsr                                                  PREPARE PANEL
012700090318    ***
012800090318     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
012900090318     C                   IN        @DTA50
013000090318     C                   EVAL      WSNAME = %SUBST(@DTA50:1:40)
013100090318    ***
013200090318     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
013300090318    ***
013400090318     C                   Exsr      BLDFKY                                       BUILD FNCTNS
013500090318     C                   Exsr      GETREC                                       GET RECORD
013600000000     C                   IF        WWRTN <> *BLANKS
013700000000 001 C                   Move      WTM(2)        WWMSG                          GET MESSAGE
013800000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
013900000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
014000000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
014100000000E001 C                   Endif                                                  END IF ERROR
014200000000      *
014300000000     C                   Endsr                                                  END PRPPNL
014400000000      *___________________________________________________________________
014500000000      * Get record for delete
014600000000      *___________________________________________________________________
014700000000     C     GETREC        Begsr                                                  GET REC FOR DLT
014800090317     C                   Call      'UPDLKI  '                                   PROCESS REC IO
014900000000     C                   Parm      'GET     '    WWRQS                          GET RECORD
015000000000     C                   Parm                    WWRTN                          RETURN CODE
015100000000     C                   Parm                    WDDTA                          REC DATA
015200000000B001 C                   If        WWRTN <> *BLANKS                             IF GET ERROR
015300000000 001 C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
015400000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
015500000000 001 C                   Movel     'ERROR'       WORTN                          RETURN ERROR
015600000000 001 C                   Movel     'END'         WWSTT                          RETURN END
015700000000E001 C                   Endif                                                  END ERROR
015800000000     C                   Endsr                                                  END PREP CHANGE
015900000000      *___________________________________________________________________
016000000000      * Dispaly delete confirmation panel
016100000000      *___________________________________________________________________
016200000000     C     DSPPNL        Begsr                                                  DISPLAY PANEL
016300000000      * Set OVERLAY based on last display file processed
016400000000     C                   IF        WQPGMN <> WUPGM
016500000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
016600000000 001 C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
016700000000X001 C                   Else                                                   SAME PGM
016800000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
016900000000E001 C                   Endif                                                  END IF NEW PGM
017000000000      * Write message subfile
017100000000 001 C                   MOVE      *ON           *IN30                          MSGSFLYDISPLAY
017200020226     C                   Write     MSGSFLC                                      DISPLAY MSG SFL
017300000000      * Write delete confirmation panel
017400090318     C                   EXSR      $GETDTA
017500020226     C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
017600000000     C                   Endsr                                                  END DSPPNL
017700090318   S***S
017800090318     C     $GETDTA       Begsr
017900090318    ***
018000090318     C                   EVAL      D_AGENCY = *BLANKS
018100090318     C                   EVAL      D_SUPER  = *BLANKS
018200090318    ***
018300090318     C                   IF        SXEFFDTE <> 0
018400090318     C                   MOVE      SXEFFDTE      #ISO
018500090318     C     *USA          MOVE      #ISO          SCEFFDTE
018600090318     C                   ELSE
018700090318     C                   EVAL      SCEFFDTE = 0
018800090318     C                   ENDIF
018900090318    ***
019000090318     C                   IF        SXTRMDTE <> 0
019100090318     C                   MOVE      SXTRMDTE      #ISO
019200090318     C     *USA          MOVE      #ISO          SCTRMDTE
019300090318     C                   ELSE
019400090318     C                   EVAL      SCTRMDTE = 0
019500090318     C                   ENDIF
019600090318    ***
019700090318     C                   IF        SXAGCY <> *BLANKS
019800090318     C                   EVAL      @44 = SXAGCY
019900090318     C                   EVAL      %SUBST(@44:44:1) = 'A'
020000090318     C                   CALL      'RTVSAS'
020100090318     C                   PARM                    @44
020200090318     C                   EVAL      D_AGENCY = %SUBST(@44:4:40)
020300090318     C                   ENDIF
020400090318    ***
020500090318     C                   IF        SXSUPER <> *BLANKS
020600090318     C                   EVAL      @44 = SXSUPER
020700090318     C                   EVAL      %SUBST(@44:44:1) = 'U'
020800090318     C                   CALL      'RTVSAS'
020900090318     C                   PARM                    @44
021000090318     C                   EVAL      D_SUPER  = %SUBST(@44:4:40)
021100090318     C                   ENDIF
021200090318    ***
021300090318     C                   ENDSR
021400090318   S***S
021500000000      *___________________________________________________________________
021600000000      * Process ENTER request
021700000000      *___________________________________________________________________
021800000000     C     PRCENT        Begsr                                                  PROC ENTER RQS
021900000000     C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
022000000000     C                   IF        WWRTN = *BLANKS
022100000000 001 C                   Exsr      DLTREC                                       DELETE RECORD
022200000000E001 C                   Endif                                                  END IF DLT ALLOWED
022300000000      *
022400000000     C                   IF        WWRTN = *BLANKS
022500000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
022600000000 001 C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
022700000000E001 C                   Endif                                                  END IF DLT ALLOWED
022800000000     C                   Endsr                                                  END PRCENT
022900000000      *___________________________________________________________________
023000000000      * Delete record
023100000000      *___________________________________________________________________
023200000000     C     DLTREC        Begsr                                                  DELETE RECORD
023300000000      *
023400090317     C                   Call      'UPDLKI  '                                   PROCESS REC IO
023500000000     C                   Parm      'DELETE  '    WWRQS                          GET REC
023600000000     C                   Parm                    WWRTN                          RETURN CODE
023700000000     C                   Parm                    WDDTA                          REC DATA
023800000000      *
023900000000     C                   IF        WWRTN <> *BLANKS
024000000000 001 C                   Move      WTM(1)        WWMSG                          GET MESSAGE
024100000000 001 C                   Exsr      SNDMSG                                       SEND MSG
024200000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
024300000000E001 C                   Endif                                                  END IF ERROR
024400000000     C                   Endsr                                                  END PRCENT
024500000000      *___________________________________________________________________
024600000000      * Check if delete allowed
024700000000      *___________________________________________________________________
024800000000     C     CHKDLT        Begsr                                                  CHECK DELETE
024900000000     C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
025000090317     C                   Call      'CHKLKI  '                                   PROCESS REC IO
025100060317     C                   Parm      'EDTDLT'      WWRQS                          RELEASE RECORD
025200060317     C                   Parm                    WWRTN                          RETURN CODE
025300060317     C                   Parm                    WDDTA                          REC DATA STRUCTURE
025400000000     C                   Endsr                                                  END CHECK DLT
025500000000      *___________________________________________________________________
025600000000      * Release the record
025700000000      *___________________________________________________________________
025800000000     C     RELREC        Begsr                                                  RELEASE RECORD
025900090317     C                   Call      'UPDLKI  '                                   PROCESS REC IO
026000000000     C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
026100000000     C                   Parm                    WWRTN                          RETURN CODE
026200000000     C                   Parm                    WDDTA                          REC DATA STRUCTURE
026300000000     C                   Endsr                                                  END RELREC
026400000000      *___________________________________________________________________
026500000000      * Receive messages
026600000000      *___________________________________________________________________
026700000000     C     RCVMSG        Begsr                                                  RECEIVE MSG
026800000000     C                   Movea     *IN           WWIN                           INDICATORS
026900000000     C                   Call      'PRCMSG2'                                    CALL MSG PGM
027000000000     C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
027100000000     C                   Parm                    WWIN                           INDICATORS
027200000000     C                   Parm                    WWRTN                          RETURN CODE
027300000000     C                   Movea     WWIN          *IN                            INDICATORS RET
027400000000     C                   Endsr                                                  END RCV MSG
027500000000      *___________________________________________________________________
027600000000      * Build function key information
027700000000      *___________________________________________________________________
027800000000     C     BLDFKY        Begsr                                                  BUILD FNC KEYS
027900000000     C                   Movea     *IN           WWIN                           INDICATORS
028000000000     C                   Call      'PRCFKY2'                                    PROC FNC KYS
028100000000     C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
028200000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
028300000000     C                   Parm                    WAD                            FNC DESC
028400000000     C                   Parm                    WWIN                           *IN
028500000000     C                   Parm                    WAF                            FNC KEY TABLE
028600000000     C                   Parm                    WIFKV                          FNC KYS ALLWD
028700000000      *
028800000000     C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
028900000000     C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
029000000000     C                   Sub       1             WW                             BUMP IDX
029100000000     C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
029200000000     C                   Endsr                                                  END BLD FNCTNS
029300000000      *___________________________________________________________________
029400000000      * Process function keys
029500000000      *___________________________________________________________________
029600000000     C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
029700000000     C                   Movea     *IN           WWIN                           INDICATORS
029800000000     C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
029900000000     C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
030000000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
030100000000     C                   Parm                    WAD                            FNC DESC
030200000000     C                   Parm                    WWIN                           *IN
030300000000     C                   Parm                    WAF                            FNCTN KEY TABLE
030400000000     C                   Parm                    WIFKV                          FNCTN KYS ALLWD
030500000000     C                   Endsr                                                  END PROC FNCTNS
030600000000      *___________________________________________________________________
030700000000      * Process EXIT function
030800000000      *___________________________________________________________________
030900000000     C     PRCEXT        Begsr                                                  EXIT
031000000000     C                   Exsr      RELREC                                       RELEASE RECORD
031100000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
031200000000     C                   Move      'END'         WWSTT                          END INVOCATION
031300000000     C                   Endsr                                                  END RETURN
031400000000      *___________________________________________________________________
031500000000      * Process CANCEL function
031600000000      *___________________________________________________________________
031700000000     C     PRCCNL        Begsr                                                  CANCEL
031800000000     C                   Exsr      RELREC                                       RELEASE RECORD
031900000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
032000000000     C                   Move      'END'         WWSTT                          END INVOCATION
032100000000     C                   Endsr                                                  END RETURN
032200000000      *___________________________________________________________________
032300000000      * Send message
032400000000      *___________________________________________________________________
032500000000     C     SNDMSG        Begsr                                                  SEND MESSAGE
032600000000     C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
032700000000     C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
032800000000     C                   Parm      'QTEMP'       WWLIB                          DATA QUEUE LIB
032900000000     C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
033000000000     C                   Parm                    WWMSG                          ERROR MESSAGE
033100000000     C                   Endsr                                                  END PROC FNC
033200000000      *___________________________________________________________________
033300000000      * Parameter lists
033400000000      *___________________________________________________________________
033500000000     C     PLIST         Begsr                                                  PARM LISTS
033600000000     C     *ENTRY        Plist                                                  *ENTRY LIST
033700000000     C                   Parm                    WIRQS                          EXT MODE
033800000000     C                   Parm                    WORTN                          INTERNAL MODE
033900000000     C                   Parm                    WUPGM                          LAST PGM NAME
034000000000     C                   Parm                    WDDTA                          RECORD DS
034100000000     C                   Parm                    WIFKV                          FUNCTIONS VALID
034200000000     C                   Endsr                                                  END PLIST
034300000000      *___________________________________________________________________
034400000000      * Initialize routine
034500000000      *___________________________________________________________________
034600000000     C     *INZSR        Begsr                                                  INITIALIZE
034700000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
034800000000     C                   Z-add     1             WWFKS                          FNC KEY SET
034900000000     C                   Z-add     *ZEROS        WW                             WORK INDEX
035000000000     C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
035100000000     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
035200000000     C                   Move      *BLANKS       WWRTN                          RETURN CODE
035300000000     C                   Endsr                                                  END *INZSR
035400000000      *___________________________________________________________________
035500000000      * Program error handler
035600000000      *___________________________________________________________________
035700000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
035800000000     C                   Call      'SNDRPGM'                            50      SEND RPG MSG
035900000000     C                   Parm                    WQPGMN                         PROGRAM NAME
036000000000     C                   Parm                    WQSTSC                         STATUS CODE
036100000000     C                   Parm                    WQRPGS                         RPG STATEMENT
036200000000     C                   Parm                    WQMSG                          MESSAGE ID
036300000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
036400000000      *___________________________________________________________________
036500000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03660000000003EXIT    F3=Exit
03670000000012CANCEL  F12=Cancel
036800000000** WTM
03690000000000Record not deleted. No longer available.
03700009031700LINK ID MAINT record not found.
03710009031700Call to UPDLKI failed.
03720009031700Request not supported in program DLTLKI.
