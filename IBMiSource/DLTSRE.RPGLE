000100000000      *_________________________________________________________________________
000200000000      *
000300090316      *  Description:  DELETE RELATIONSHIP ID MAINT
000400000000      *
000500090204      *  (C)COPYRIGHT 2009 BY GROUP BENEFIT SERVICES, INC.
000600000000      *_________________________________________________________________________
000700000000      *
000800090316     FDLTSRED   CF   E             WORKSTN INFDS(DSPD)
000900090316     FSPRAGXR2  IF   E           K DISK
001000000000      *_________________________________________________________________________
001100000000      *
001200000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001300000000     D WAD             S             80    DIM(6)                               FUNCTION DESC
001400000000     D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001500090316     D #ISO            S               D   DATFMT(*ISO)
001600000000      *_________________________________________________________________________
001700000000      *
001800000000      * Data structure
001900090316     D WDDTA         E DS                  EXTNAME(SMANRLT)
002000000000      *
002100000000      * Program status data structure
002200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000      *
002400000000      * Display file data structure
002500000000     D DSPD          E DS                  EXTNAME(IODSPD)
002600000000      *
002700000000     D WDFILE        E DS                  EXTNAME(IODBFD)
002800000000      *
002900021008     D WIFKV           S             60A
003000021008     D WIFKY           S                   LIKE(WIFKV)
003100021008     D WIOPV           S                   LIKE(WIFKV)
003200021008     D WIRQS           S              8A
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
012700090317     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
012800090317     C                   IN        @DTA50
012900090317     C                   EVAL      WSNAME = %SUBST(@DTA50:1:40)
013000000000     C                   Exsr      BLDFKY                                       BUILD FNCTNS
013100000000     C                   Exsr      GETREC                                       GET RECORD
013200000000     C                   IF        WWRTN <> *BLANKS
013300000000 001 C                   Move      WTM(2)        WWMSG                          GET MESSAGE
013400000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
013500000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013600000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
013700000000E001 C                   Endif                                                  END IF ERROR
013800000000      *
013900000000     C                   Endsr                                                  END PRPPNL
014000000000      *___________________________________________________________________
014100000000      * Get record for delete
014200000000      *___________________________________________________________________
014300000000     C     GETREC        Begsr                                                  GET REC FOR DLT
014400090316     C                   Call      'UPDSRE  '                                   PROCESS REC IO
014500000000     C                   Parm      'GET     '    WWRQS                          GET RECORD
014600000000     C                   Parm                    WWRTN                          RETURN CODE
014700000000     C                   Parm                    WDDTA                          REC DATA
014800000000B001 C                   If        WWRTN <> *BLANKS                             IF GET ERROR
014900000000 001 C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
015000000000 001 C                   Exsr      SNDMSG                                       SEND MESSAGE
015100000000 001 C                   Movel     'ERROR'       WORTN                          RETURN ERROR
015200000000 001 C                   Movel     'END'         WWSTT                          RETURN END
015300000000E001 C                   Endif                                                  END ERROR
015400000000     C                   Endsr                                                  END PREP CHANGE
015500000000      *___________________________________________________________________
015600000000      * Dispaly delete confirmation panel
015700000000      *___________________________________________________________________
015800000000     C     DSPPNL        Begsr                                                  DISPLAY PANEL
015900000000      * Set OVERLAY based on last display file processed
016000000000     C                   IF        WQPGMN <> WUPGM
016100000000 001 C                   MOVE      *OFF          *IN35                          OVERLAY OFF
016200000000 001 C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
016300000000X001 C                   Else                                                   SAME PGM
016400000000 001 C                   MOVE      *ON           *IN35                          OVERLAY ON
016500000000E001 C                   Endif                                                  END IF NEW PGM
016600000000      * Write message subfile
016700000000 001 C                   MOVE      *ON           *IN30                          MSGSFLYDISPLAY
016800020226     C                   Write     MSGSFLC                                      DISPLAY MSG SFL
016900000000      * Write delete confirmation panel
017000090316     C                   EXSR      $GETDTA
017100020226     C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
017200000000     C                   Endsr                                                  END DSPPNL
017300090316   S***S
017400090316     C     $GETDTA       BEGSR
017500090316    ***
017600090316     C                   EVAL      D_SMAN   = *BLANKS
017700090316     C                   EVAL      D_AGENCY = *BLANKS
017800090316     C                   EVAL      D_ANAME  = *BLANKS
017900090316     C                   EVAL      D_SUPER  = *BLANKS
018000090316     C                   EVAL      D_SNAME  = *BLANKS
018100090316    ***
018200090316     C                   IF        SRSMAN <> *BLANKS
018300090316     C                   EVAL      @44 = SRSMAN
018400090316     C                   EVAL      %SUBST(@44:44:1) = 'S'
018500090316     C                   CALL      'RTVSAS'
018600090316     C                   PARM                    @44              44
018700090316     C                   EVAL      D_SMAN = %SUBST(@44:4:40)
018800090316     C                   ENDIF
018900090316    ***
019000090316     C                   IF        SREFFDTE <> 0
019100090316     C                   MOVE      SREFFDTE      #ISO
019200090316     C     *USA          MOVE      #ISO          SCEFFDTE
019300090316     C                   ELSE
019400090316     C                   EVAL      SCEFFDTE = 0
019500090316     C                   ENDIF
019600090316    ***
019700090316     C                   IF        SRTRMDTE <> 0
019800090316     C                   MOVE      SRTRMDTE      #ISO
019900090316     C     *USA          MOVE      #ISO          SCTRMDTE
020000090316     C                   ELSE
020100090316     C                   EVAL      SCTRMDTE = 0
020200090316     C                   ENDIF
020300090316    ***
020400090316     C                   IF        SRASID <> *BLANKS AND
020500090316     C                             SRASID <> '00000000'
020600090316     C     SRASID        CHAIN     SXF
020700090316     C                   IF        NOT %FOUND(SPRAGXR2)
020800090316     C                   LEAVESR
020900090316     C                   ENDIF
021000090316     C                   ENDIF
021100090316    ***
021200090316     C                   EVAL      @44 = SXAGCY
021300090316     C                   EVAL      %SUBST(@44:44:1) = 'A'
021400090316     C                   CALL      'RTVSAS'
021500090316     C                   PARM                    @44
021600090316     C                   EVAL      D_ANAME = %SUBST(@44:4:40)
021700090316     C                   EVAL      D_AGENCY = SXAGCY
021800090316    ***
021900090316     C                   EVAL      @44 = SXSUPER
022000090316     C                   EVAL      %SUBST(@44:44:1) = 'U'
022100090316     C                   CALL      'RTVSAS'
022200090316     C                   PARM                    @44
022300090316     C                   EVAL      D_SUPER  = SXSUPER
022400090316     C                   EVAL      D_SNAME  = %SUBST(@44:4:40)
022500090316    ***
022600090316     C                   ENDSR
022700090316   S***S
022800000000      *___________________________________________________________________
022900000000      * Process ENTER request
023000000000      *___________________________________________________________________
023100000000     C     PRCENT        Begsr                                                  PROC ENTER RQS
023200000000     C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
023300000000     C                   IF        WWRTN = *BLANKS
023400000000 001 C                   Exsr      DLTREC                                       DELETE RECORD
023500000000E001 C                   Endif                                                  END IF DLT ALLOWED
023600000000      *
023700000000     C                   IF        WWRTN = *BLANKS
023800000000 001 C                   Move      'END'         WWSTT                          END PROGRAM
023900000000 001 C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
024000000000E001 C                   Endif                                                  END IF DLT ALLOWED
024100000000     C                   Endsr                                                  END PRCENT
024200000000      *___________________________________________________________________
024300000000      * Delete record
024400000000      *___________________________________________________________________
024500000000     C     DLTREC        Begsr                                                  DELETE RECORD
024600000000      *
024700090316     C                   Call      'UPDSRE  '                                   PROCESS REC IO
024800000000     C                   Parm      'DELETE  '    WWRQS                          GET REC
024900000000     C                   Parm                    WWRTN                          RETURN CODE
025000000000     C                   Parm                    WDDTA                          REC DATA
025100000000      *
025200000000     C                   IF        WWRTN <> *BLANKS
025300000000 001 C                   Move      WTM(1)        WWMSG                          GET MESSAGE
025400000000 001 C                   Exsr      SNDMSG                                       SEND MSG
025500000000 001 C                   Move      'ERROR   '    WORTN                          RETURN ERROR
025600000000E001 C                   Endif                                                  END IF ERROR
025700000000     C                   Endsr                                                  END PRCENT
025800000000      *___________________________________________________________________
025900000000      * Check if delete allowed
026000000000      *___________________________________________________________________
026100000000     C     CHKDLT        Begsr                                                  CHECK DELETE
026200000000     C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
026300090316     C                   Call      'CHKSRE  '                                   PROCESS REC IO
026400060317     C                   Parm      'EDTDLT'      WWRQS                          RELEASE RECORD
026500060317     C                   Parm                    WWRTN                          RETURN CODE
026600060317     C                   Parm                    WDDTA                          REC DATA STRUCTURE
026700000000     C                   Endsr                                                  END CHECK DLT
026800000000      *___________________________________________________________________
026900000000      * Release the record
027000000000      *___________________________________________________________________
027100000000     C     RELREC        Begsr                                                  RELEASE RECORD
027200090316     C                   Call      'UPDSRE  '                                   PROCESS REC IO
027300000000     C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
027400000000     C                   Parm                    WWRTN                          RETURN CODE
027500000000     C                   Parm                    WDDTA                          REC DATA STRUCTURE
027600000000     C                   Endsr                                                  END RELREC
027700000000      *___________________________________________________________________
027800000000      * Receive messages
027900000000      *___________________________________________________________________
028000000000     C     RCVMSG        Begsr                                                  RECEIVE MSG
028100000000     C                   Movea     *IN           WWIN                           INDICATORS
028200000000     C                   Call      'PRCMSG2'                                    CALL MSG PGM
028300000000     C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
028400000000     C                   Parm                    WWIN                           INDICATORS
028500000000     C                   Parm                    WWRTN                          RETURN CODE
028600000000     C                   Movea     WWIN          *IN                            INDICATORS RET
028700000000     C                   Endsr                                                  END RCV MSG
028800000000      *___________________________________________________________________
028900000000      * Build function key information
029000000000      *___________________________________________________________________
029100000000     C     BLDFKY        Begsr                                                  BUILD FNC KEYS
029200000000     C                   Movea     *IN           WWIN                           INDICATORS
029300000000     C                   Call      'PRCFKY2'                                    PROC FNC KYS
029400000000     C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
029500000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
029600000000     C                   Parm                    WAD                            FNC DESC
029700000000     C                   Parm                    WWIN                           *IN
029800000000     C                   Parm                    WAF                            FNC KEY TABLE
029900000000     C                   Parm                    WIFKV                          FNC KYS ALLWD
030000000000      *
030100000000     C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
030200000000     C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
030300000000     C                   Sub       1             WW                             BUMP IDX
030400000000     C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
030500000000     C                   Endsr                                                  END BLD FNCTNS
030600000000      *___________________________________________________________________
030700000000      * Process function keys
030800000000      *___________________________________________________________________
030900000000     C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
031000000000     C                   Movea     *IN           WWIN                           INDICATORS
031100000000     C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
031200000000     C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
031300000000     C     WWFNC         Parm                    WWRTN                          RETURN CODE
031400000000     C                   Parm                    WAD                            FNC DESC
031500000000     C                   Parm                    WWIN                           *IN
031600000000     C                   Parm                    WAF                            FNCTN KEY TABLE
031700000000     C                   Parm                    WIFKV                          FNCTN KYS ALLWD
031800000000     C                   Endsr                                                  END PROC FNCTNS
031900000000      *___________________________________________________________________
032000000000      * Process EXIT function
032100000000      *___________________________________________________________________
032200000000     C     PRCEXT        Begsr                                                  EXIT
032300000000     C                   Exsr      RELREC                                       RELEASE RECORD
032400000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
032500000000     C                   Move      'END'         WWSTT                          END INVOCATION
032600000000     C                   Endsr                                                  END RETURN
032700000000      *___________________________________________________________________
032800000000      * Process CANCEL function
032900000000      *___________________________________________________________________
033000000000     C     PRCCNL        Begsr                                                  CANCEL
033100000000     C                   Exsr      RELREC                                       RELEASE RECORD
033200000000     C                   Movel     WWFNC         WORTN                          RETURN CODE
033300000000     C                   Move      'END'         WWSTT                          END INVOCATION
033400000000     C                   Endsr                                                  END RETURN
033500000000      *___________________________________________________________________
033600000000      * Send message
033700000000      *___________________________________________________________________
033800000000     C     SNDMSG        Begsr                                                  SEND MESSAGE
033900000000     C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
034000000000     C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA QUEUE NAME
034100000000     C                   Parm      'QTEMP'       WWLIB                          DATA QUEUE LIB
034200000000     C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
034300000000     C                   Parm                    WWMSG                          ERROR MESSAGE
034400000000     C                   Endsr                                                  END PROC FNC
034500000000      *___________________________________________________________________
034600000000      * Parameter lists
034700000000      *___________________________________________________________________
034800000000     C     PLIST         Begsr                                                  PARM LISTS
034900000000     C     *ENTRY        Plist                                                  *ENTRY LIST
035000000000     C                   Parm                    WIRQS                          EXT MODE
035100000000     C                   Parm                    WORTN                          INTERNAL MODE
035200000000     C                   Parm                    WUPGM                          LAST PGM NAME
035300000000     C                   Parm                    WDDTA                          RECORD DS
035400000000     C                   Parm                    WIFKV                          FUNCTIONS VALID
035500000000     C                   Endsr                                                  END PLIST
035600000000      *___________________________________________________________________
035700000000      * Initialize routine
035800000000      *___________________________________________________________________
035900000000     C     *INZSR        Begsr                                                  INITIALIZE
036000000000     C                   Move      *BLANKS       WWIN                           INDICATOR FIELD
036100000000     C                   Z-add     1             WWFKS                          FNC KEY SET
036200000000     C                   Z-add     *ZEROS        WW                             WORK INDEX
036300000000     C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
036400000000     C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
036500000000     C                   Move      *BLANKS       WWRTN                          RETURN CODE
036600000000     C                   Endsr                                                  END *INZSR
036700000000      *___________________________________________________________________
036800000000      * Program error handler
036900000000      *___________________________________________________________________
037000000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
037100000000     C                   Call      'SNDRPGM'                            50      SEND RPG MSG
037200000000     C                   Parm                    WQPGMN                         PROGRAM NAME
037300000000     C                   Parm                    WQSTSC                         STATUS CODE
037400000000     C                   Parm                    WQRPGS                         RPG STATEMENT
037500000000     C                   Parm                    WQMSG                          MESSAGE ID
037600000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
037700000000      *___________________________________________________________________
037800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03790000000003EXIT    F3=Exit
03800000000012CANCEL  F12=Cancel
038100000000** WTM
03820000000000Record not deleted. No longer available.
03830009031600RELATIONSHIP ID record not found.
03840009031600Call to UPDSRE failed.
03850009031600Request not supported in program DLTSRE.
