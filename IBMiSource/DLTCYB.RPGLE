000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300030717    ? *  Description:  Delete E&O Coverage file
000400000000    ? *
000500030716    ? *  (c)Copyright 2003 by Group Benefit Services, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800180319    ?FDLTCYBD   CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
001000030717    ?FSMAN      IF   E           K DISK
001100030717    ?FSMANRLT   IF   E           K DISK
001200030717    ?FAGENCY    IF   E           K DISK
001300030717    ?FSPRAGXR2  IF   E           K DISK
001400030717    ?FSUPRAGCY  IF   E           K DISK
001500031117    ?FBLILMANL2 IF   E           K DISK
001600000000    ? *_________________________________________________________________________
001700000000    ? *
001800000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001900000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002000010219    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
002100000000    ? *_________________________________________________________________________
002200000000    ? *
002300000406    ? * Data structure
002400180319    ?D WDDTA         E DS                  EXTNAME(BLICYB)
002500000000    ? *
002600000000    ? * Program status data structure
002700991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002800000000    ? *
002900000000    ? * Display file data structure
003000991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003100000000    ? *
003200991108    ?D WDFILE        E DS                  EXTNAME(IODBFD)
003300000000    ? *___________________________________________________________________
003400000000    ? * Process delete request
003500031117     C                   If        WORTN    =    'NON'
003600031117     C                   Move      'Y'           Noncom            1
003700031117     C                   Eval      WTITLE = 'Non Commission'
003800031117     C                   Else
003900031117     C                   Move      ' '           Noncom
004000031117     C                   Eval      WTITLE = '  Commission  '
004100031117     C                   End
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
006000030716     C                   EXSR      GETSMAN
006100000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
006200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
006300000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
006400000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
006500000000 001?C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
006600000000 001?C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006700000000 001?C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
006800000000 001?C                   Endcs                                                  END CASE
006900000000E001?C                   Enddo                                                  END DOWHILE
007000000000    ?C                   Endsr                                                  END PRCCNF
007100030716    ? *___________________________________________________________________
007200030716    ? * GET SALESMAN
007300030716    ? *___________________________________________________________________
007400030716    ?C     GETSMAN       Begsr                                                  PARM LISTS
007500031117     C                   If        NonCom = 'Y'
007600031117     C     LERELI        CHAIN     BLILMANL2
007700031117     C                   IF        %FOUND
007800031117     C                   Eval      wssman = lmanc
007900031117     C                   Eval      wsnam1 = %trim(lmann)
008000031117     C                   Eval      wsagcy = lagcy
008100031117     C                   Eval      wsnam2 = %trim(lagcn)
008200031117     C                   Eval      wssupr = lsupr
008300031117     C                   Eval      wsnam3 = %trim(lsupn)
008400031117     C                   End
008500031117     C                   Else
008600030717     C     LERELI        CHAIN     SMANRLT
008700030717     C                   IF        NOT %FOUND
008800031117     C                   CLEAR                   WSSMAN
008900030717     C                   ELSE
009000031117     C                   EVAL      WSSMAN   =    SRSMAN
009100030717     C     SRSMAN        CHAIN     SMAN
009200030717     C                   IF        NOT %FOUND
009300030717     C                   CLEAR                   WSNAM1
009400030717     C                   ELSE
009500030717     C                   EVAL      WSNAM1 = %trim(SFNAME) + ' ' + %trim(SLNAME)
009600030717     C                   END
009700030717     C                   END
009800030717     C     SRASID        CHAIN     SPRAGXR2
009900030717     C                   IF        NOT %FOUND
010000031117     C                   CLEAR                   WSSUPR
010100031117     C                   CLEAR                   WSAGCY
010200031117     C                   CLEAR                   WSNAM3
010300030717     C                   ELSE
010400031117     C                   EVAL      WSSUPR =      SXSUPER
010500031117     C                   EVAL      WSAGCY =      SXAGCY
010600030717     C     SXAGCY        CHAIN     AGENCY
010700030717     C                   IF        NOT %FOUND
010800030717     C                   CLEAR                   WSNAM2
010900030717     C                   ELSE
011000030717     C                   EVAL      WSNAM2 = %trim(AGNAM1)
011100030717     C                   END
011200030717     C     SXSUPER       CHAIN     SUPRAGCY
011300030717     C                   IF        NOT %FOUND
011400030717     C                   CLEAR                   WSNAM3
011500030717     C                   ELSE
011600030717     C                   EVAL      WSNAM3 = %trim(SANAME1)
011700030717     C                   END
011800031117     C                   END
011900030717     C                   END
012000030716    ?C                   Endsr                                                  END PLIST
012100000000    ? *___________________________________________________________________
012200000000    ? * Prepare panel
012300000000    ? *___________________________________________________________________
012400000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
012500000000    ?C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
012600000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
012700000000    ?C                   Exsr      GETREC                                       GET RECORD
012800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
012900000000 001?C                   Move      WTM(2)        WWMSG                          GET MESSAGE
013000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
013100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
013200000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
013300000000E001?C                   Endif                                                  END IF ERROR
013400000000    ?C                   Endsr                                                  END PRPPNL
013500000000    ? *___________________________________________________________________
013600000000    ? * Get record for delete
013700000000    ? *___________________________________________________________________
013800000000    ?C     GETREC        Begsr                                                  GET REC FOR DLT
013900180319    ?C                   Call      'UPDCYB  '                                   PROCESS REC IO
014000000000    ?C                   Parm      'GET     '    WWRQS             8            GET RECORD
014100991201    ?C                   Parm                    WWRTN                          RETURN CODE
014200000614    ?C                   Parm                    WDDTA                          REC DATA
014300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
014400000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
014500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
014600000000 001?C                   Movel     'ERROR'       WORTN                          RETURN ERROR
014700000000 001?C                   Movel     'END'         WWSTT                          RETURN END
014800000000E001?C                   Endif                                                  END ERROR
014900030717     C     LECHGD        MULT      10000.0001    WSDATE
015000030722     C     LEEFFD        MULT      10000.0001    WSEFDT
015100030722     C     LEEXPD        MULT      10000.0001    WSTRDT
015200000000    ?C                   Endsr                                                  END PREP CHANGE
015300000000    ? *___________________________________________________________________
015400000000    ? * Dispaly delete confirmation panel
015500000000    ? *___________________________________________________________________
015600000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
015700000000    ? * Set OVERLAY based on last display file processed
015800000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
015900000000 001?C                   Setoff                                       35        OVERLAY OFF
016000000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
016100000000X001?C                   Else                                                   SAME PGM
016200000000 001?C                   Seton                                        35        OVERLAY ON
016300000000E001?C                   Endif                                                  END IF NEW PGM
016400000000    ? * Write message subfile
016500000000    ?C                   Seton                                        30        MSGSFL DISPLAY
016600000000    ?C                   Write     MSGSFLC                                      DISPLAY MSG SFL
016700000000    ?C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
016800000000    ?C                   Endsr                                                  END DSPPNL
016900000000    ? *___________________________________________________________________
017000000000    ? * Process ENTER request
017100000000    ? *___________________________________________________________________
017200000000    ?C     PRCENT        Begsr                                                  PROC ENTER RQS
017300000000    ?C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
017400991201B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
017500000000 001?C                   Exsr      DLTREC                                       DELETE RECORD
017600000000E001?C                   Endif                                                  END IF DLT ALLOWED
017700000000    ? *
017800000000B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
017900000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
018000000000 001?C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
018100000000E001?C                   Endif                                                  END IF DLT ALLOWED
018200000000    ?C                   Endsr                                                  END PRCENT
018300000000    ? *___________________________________________________________________
018400000000    ? * Delete record
018500000000    ? *___________________________________________________________________
018600000000    ?C     DLTREC        Begsr                                                  DELETE RECORD
018700180319    ?C                   Call      'UPDCYB  '                                   PROCESS REC IO
018800000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
018900000000    ?C                   Parm                    WWRTN                          RETURN CODE
019000000614    ?C                   Parm                    WDDTA                          REC DATA
019100000000    ? *
019200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
019300000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
019400000000 001?C                   Exsr      SNDMSG                                       SEND MSG
019500000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
019600000000E001?C                   Endif                                                  END IF ERROR
019700000000    ?C                   Endsr                                                  END PRCENT
019800000000    ? *___________________________________________________________________
019900000000    ? * Check if delete allowed
020000000000    ? *___________________________________________________________________
020100000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
020200991201    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
020300000000    ?C                   Endsr                                                  END CHECK DLT
020400000000    ? *___________________________________________________________________
020500000000    ? * Release the record
020600000000    ? *___________________________________________________________________
020700000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
020800180319    ?C                   Call      'UPDCYB  '                                   PROCESS REC IO
020900000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
021000991201    ?C                   Parm                    WWRTN                          RETURN CODE
021100000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
021200000000    ?C                   Endsr                                                  END RELREC
021300000000    ? *___________________________________________________________________
021400000000    ? * Receive messages
021500000000    ? *___________________________________________________________________
021600000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
021700000000    ?C                   Movea     *IN           WWIN                           INDICATORS
021800000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
021900000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
022000000000    ?C                   Parm                    WWIN                           INDICATORS
022100000000    ?C                   Parm                    WWRTN                          RETURN CODE
022200000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
022300000000    ?C                   Endsr                                                  END RCV MSG
022400000000    ? *___________________________________________________________________
022500000000    ? * Build function key information
022600000000    ? *___________________________________________________________________
022700000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
022800991108    ?C                   Movea     *IN           WWIN                           INDICATORS
022900991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
023000000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
023100000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
023200000000    ?C                   Parm                    WAD                            FNC DESC
023300991108    ?C                   Parm                    WWIN                           *IN
023400000000    ?C                   Parm                    WAF                            FNC KEY TABLE
023500000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
023600000000    ? *
023700000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
023800000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
023900000000    ?C                   Sub       1             WW                             BUMP IDX
024000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
024100000000    ?C                   Endsr                                                  END BLD FNCTNS
024200000000    ? *___________________________________________________________________
024300000000    ? * Process function keys
024400000000    ? *___________________________________________________________________
024500000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
024600991108    ?C                   Movea     *IN           WWIN                           INDICATORS
024700991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
024800000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
024900000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
025000000000    ?C                   Parm                    WAD                            FNC DESC
025100991108    ?C                   Parm                    WWIN                           *IN
025200000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
025300000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
025400000000    ?C                   Endsr                                                  END PROC FNCTNS
025500000000    ? *___________________________________________________________________
025600000000    ? * Process EXIT function
025700000000    ? *___________________________________________________________________
025800000000    ?C     PRCEXT        Begsr                                                  EXIT
025900000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
026000000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
026100000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
026200000000    ?C                   Endsr                                                  END RETURN
026300000000    ? *___________________________________________________________________
026400000000    ? * Process CANCEL function
026500000000    ? *___________________________________________________________________
026600000000    ?C     PRCCNL        Begsr                                                  CANCEL
026700000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
026800000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
026900000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
027000000000    ?C                   Endsr                                                  END RETURN
027100000000    ? *___________________________________________________________________
027200000000    ? * Send message
027300000000    ? *___________________________________________________________________
027400000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
027500000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
027600000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
027700000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
027800000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
027900000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
028000000000    ?C                   Endsr                                                  END PROC FNC
028100000000    ? *___________________________________________________________________
028200000000    ? * Parameter lists
028300000000    ? *___________________________________________________________________
028400000000    ?C     PLIST         Begsr                                                  PARM LISTS
028500000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
028600000000    ?C                   Parm                    WIRQS             8            EXT MODE
028700000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
028800000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
028900000614    ?C                   Parm                    WDDTA                          RECORD DS
029000000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
029100000000    ?C                   Endsr                                                  END PLIST
029200000000    ? *___________________________________________________________________
029300000000    ? * Initialize routine
029400000000    ? *___________________________________________________________________
029500000000    ?C     *INZSR        Begsr                                                  INITIALIZE
029600000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
029700000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
029800000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
029900000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
030000000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
030100000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
030200000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
030300000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
030400000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
030500000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
030600000000    ?C                   Endsr                                                  END *INZSR
030700000000    ? *___________________________________________________________________
030800000000    ? * Program error handler
030900000000    ? *___________________________________________________________________
031000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
031100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
031200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
031300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
031400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
031500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
031600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
031700000000    ? *___________________________________________________________________
031800000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03190000000003EXIT    F3=Exit
03200000000012CANCEL  F12=Cancel
032100000000** WTM
03220000000000Record not deleted. No longer available.
03230003071700E&O Coverage record not found.
03240018031900Call to UPDCYB failed.
03250018031900Request not supported in program DLTCYB.
