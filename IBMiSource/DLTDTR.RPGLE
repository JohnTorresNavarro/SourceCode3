000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300101019    ? *  Description:  Delete Date Ranges
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800101019    ?FDLTDTRD   CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
001000100521     FACCMST    IF   E           K DISK
001100100617     FWEBPAYCHP IF   E           K DISK
001200000000    ? *_________________________________________________________________________
001300000000    ? *
001400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001600010219    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001700100618     D WSDESC          S             20A
001800000000    ? *_________________________________________________________________________
001900000000    ? *
002000000406    ? * Data structure
002100101019    ?D WDDTA         E DS                  EXTNAME(WEBPAYDTR)
002200170822    ?D OEStatus                       1a
002300000000    ? *
002400000000    ? * Program status data structure
002500991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002600000000    ? *
002700000000    ? * Display file data structure
002800991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
002900000000    ? *
003000991108    ?D WDFILE        E DS                  EXTNAME(IODBFD)
003100000000    ? *___________________________________________________________________
003200000000    ? * Process delete request
003300000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003400000000    ?C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
003500000000    ?C                   Cas                     PRCERR                         PROCESS ERROR
003600000000    ?C                   Endcs                                                  END CASE
003700000000    ?C                   Return                                                 RETURN
003800000000    ? *___________________________________________________________________
003900000000    ? * Process ERROR function
004000000000    ? *___________________________________________________________________
004100000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
004200010219    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
004300000000    ?C                   Exsr      SNDMSG                                       SEND MSG
004400000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
004500000000    ?C                   Endsr                                                  END PRCERR
004600000000    ? *___________________________________________________________________
004700000000    ? * Delete record with confirmation
004800000000    ? *___________________________________________________________________
004900000000    ?C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
005000000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005100000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
005300000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005400000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005500000000 001?C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
005600000000 001?C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
005700000000 001?C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
005800000000 001?C                   Endcs                                                  END CASE
005900000000E001?C                   Enddo                                                  END DOWHILE
006000000000    ?C                   Endsr                                                  END PRCCNF
006100000000    ? *___________________________________________________________________
006200000000    ? * Prepare panel
006300000000    ? *___________________________________________________________________
006400000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006500000000    ?C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
006600000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
006700000000    ?C                   Exsr      GETREC                                       GET RECORD
006800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
006900000000 001?C                   Move      WTM(2)        WWMSG                          GET MESSAGE
007000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
007100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
007200000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
007300000000E001?C                   Endif                                                  END IF ERROR
007400000000    ?C                   Endsr                                                  END PRPPNL
007500000000    ? *___________________________________________________________________
007600000000    ? * Get record for delete
007700000000    ? *___________________________________________________________________
007800000000    ?C     GETREC        Begsr                                                  GET REC FOR DLT
007900101019    ?C                   Call      'UPDDTR  '                                   PROCESS REC IO
008000000000    ?C                   Parm      'GET     '    WWRQS             8            GET RECORD
008100991201    ?C                   Parm                    WWRTN                          RETURN CODE
008200000614    ?C                   Parm                    WDDTA                          REC DATA
008300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
008400000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
008500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
008600000000 001?C                   Movel     'ERROR'       WORTN                          RETURN ERROR
008700000000 001?C                   Movel     'END'         WWSTT                          RETURN END
008800010914E001?C                   Endif                                                  END ERROR
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
010100000000    ? * Write message subfile
010200000000    ?C                   Seton                                        30        MSGSFL DISPLAY
010300000000    ?C                   Write     MSGSFLC                                      DISPLAY MSG SFL
010400100521
010500100521     C     KEYACC        Klist
010600101019     C                   kfld                    PGTRST
010700101019     C                   kfld                    PGSUB#
010800101019     C                   kfld                    PGACCT
010900100521
011000100521     C     KEYACC        Chain     ACCMST
011100100521     C                   if        %found(ACCMST)
011200100521     C                   Eval      WWANAM = %trim(ACNAM1)
011300100521     C                   Else
011400100617     C                   Eval      WWANAM = *BLANKS
011500100521     C                   End
011600100617    ? *
011700100617     C                   Eval      WSDESC = *blanks
011800101019     C                   If        PGGRPR <> *blanks
011900101019     C                   eval      PCTRST = 0
012000101019     C                   eval      PCSUB# = 0
012100101019     C                   eval      PCACCT = 0
012200100617     C     KEYOPT        Klist
012300100617     C                   kfld                    PCTRST
012400100617     C                   kfld                    PCSUB#
012500100617     C                   kfld                    PCACCT
012600101019     C                   kfld                    PGGRPR
012700101019     C                   kfld                    PGCODE
012800100617     C     KEYOPT        Chain     WEBPAYCHP
012900100617     C                   if        %found(WEBPAYCHP)
013000100617     C                   Eval      WSDESC = %trim(PCDESC)
013100100617     C                   Else
013200100617     C                   Eval      WSDESC = *blanks
013300100617     C                   End
013400100617     C                   End
013500100617
013600101019     C                   Eval      WSFRDT = PGFRDT
013700101019     C                   Eval      WSTODT = PGTODT
013800161014     C                   Eval      WSEFDT = PGEFDT
013900161014     C                   Eval      WSMFDT = PGMFDT
014000161014     C                   Eval      WSMTDT = PGMTDT
014100100521
014200000000    ? * Write delete confirmation panel
014300000000    ?C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
014400000000    ?C                   Endsr                                                  END DSPPNL
014500000000    ? *___________________________________________________________________
014600000000    ? * Process ENTER request
014700000000    ? *___________________________________________________________________
014800000000    ?C     PRCENT        Begsr                                                  PROC ENTER RQS
014900000000    ?C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
015000991201B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
015100000000 001?C                   Exsr      DLTREC                                       DELETE RECORD
015200000000E001?C                   Endif                                                  END IF DLT ALLOWED
015300000000    ? *
015400000000B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
015500000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
015600000000 001?C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
015700000000E001?C                   Endif                                                  END IF DLT ALLOWED
015800000000    ?C                   Endsr                                                  END PRCENT
015900000000    ? *___________________________________________________________________
016000000000    ? * Delete record
016100000000    ? *___________________________________________________________________
016200000000    ?C     DLTREC        Begsr                                                  DELETE RECORD
016300101019    ?C                   Call      'UPDDTR  '                                   PROCESS REC IO
016400000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
016500000000    ?C                   Parm                    WWRTN                          RETURN CODE
016600000614    ?C                   Parm                    WDDTA                          REC DATA
016700000000    ? *
016800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
016900000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
017000000000 001?C                   Exsr      SNDMSG                                       SEND MSG
017100000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
017200000000E001?C                   Endif                                                  END IF ERROR
017300000000    ?C                   Endsr                                                  END PRCENT
017400000000    ? *___________________________________________________________________
017500000000    ? * Check if delete allowed
017600000000    ? *___________________________________________________________________
017700000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
017800991201    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
017900100609    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
018000100609    ? *
018100101019 001?C                   Call      'CHKDTR  '                                   CHECK DATA
018200100609 001?C                   Parm      'EDTDLT  '    WWRQS                          EDIT REQUEST
018300100609 001?C                   Parm                    WWRTN                          RETURN CODE
018400100609 001?C                   Parm                    WDDTA                          REC DATA
018500100609    ? *
018600000000    ?C                   Endsr                                                  END CHECK DLT
018700000000    ? *___________________________________________________________________
018800000000    ? * Release the record
018900000000    ? *___________________________________________________________________
019000000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
019100101019    ?C                   Call      'UPDDTR  '                                   PROCESS REC IO
019200000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
019300991201    ?C                   Parm                    WWRTN                          RETURN CODE
019400000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
019500000000    ?C                   Endsr                                                  END RELREC
019600000000    ? *___________________________________________________________________
019700000000    ? * Receive messages
019800000000    ? *___________________________________________________________________
019900000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
020000000000    ?C                   Movea     *IN           WWIN                           INDICATORS
020100000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
020200000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
020300000000    ?C                   Parm                    WWIN                           INDICATORS
020400000000    ?C                   Parm                    WWRTN                          RETURN CODE
020500000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
020600000000    ?C                   Endsr                                                  END RCV MSG
020700000000    ? *___________________________________________________________________
020800000000    ? * Build function key information
020900000000    ? *___________________________________________________________________
021000000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
021100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
021200991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
021300000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
021400000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
021500000000    ?C                   Parm                    WAD                            FNC DESC
021600991108    ?C                   Parm                    WWIN                           *IN
021700000000    ?C                   Parm                    WAF                            FNC KEY TABLE
021800000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
021900000000    ? *
022000010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
022100010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
022200010913    ?C                   Sub       1             WW                             BUMP IDX
022300010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
022400000000    ?C                   Endsr                                                  END BLD FNCTNS
022500000000    ? *___________________________________________________________________
022600000000    ? * Process function keys
022700000000    ? *___________________________________________________________________
022800000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
022900991108    ?C                   Movea     *IN           WWIN                           INDICATORS
023000991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
023100000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
023200000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
023300000000    ?C                   Parm                    WAD                            FNC DESC
023400991108    ?C                   Parm                    WWIN                           *IN
023500000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
023600000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
023700000000    ?C                   Endsr                                                  END PROC FNCTNS
023800000000    ? *___________________________________________________________________
023900000000    ? * Process EXIT function
024000000000    ? *___________________________________________________________________
024100000000    ?C     PRCEXT        Begsr                                                  EXIT
024200000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
024300000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
024400000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
024500000000    ?C                   Endsr                                                  END RETURN
024600000000    ? *___________________________________________________________________
024700000000    ? * Process CANCEL function
024800000000    ? *___________________________________________________________________
024900000000    ?C     PRCCNL        Begsr                                                  CANCEL
025000000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
025100000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
025200000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
025300000000    ?C                   Endsr                                                  END RETURN
025400000000    ? *___________________________________________________________________
025500000000    ? * Send message
025600000000    ? *___________________________________________________________________
025700000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
025800000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
025900000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
026000000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
026100000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
026200000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
026300000000    ?C                   Endsr                                                  END PROC FNC
026400000000    ? *___________________________________________________________________
026500000000    ? * Parameter lists
026600000000    ? *___________________________________________________________________
026700000000    ?C     PLIST         Begsr                                                  PARM LISTS
026800000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
026900000000    ?C                   Parm                    WIRQS             8            EXT MODE
027000000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
027100000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
027200000614    ?C                   Parm                    WDDTA                          RECORD DS
027300000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
027400000000    ?C                   Endsr                                                  END PLIST
027500000000    ? *___________________________________________________________________
027600000000    ? * Initialize routine
027700000000    ? *___________________________________________________________________
027800000000    ?C     *INZSR        Begsr                                                  INITIALIZE
027900010913      *
028000000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
028100000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
028200000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
028300000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
028400000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
028500000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
028600000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
028700000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
028800000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
028900000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
029000000000    ?C                   Endsr                                                  END *INZSR
029100000000    ? *___________________________________________________________________
029200000000    ? * Program error handler
029300000000    ? *___________________________________________________________________
029400000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
029500000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
029600000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
029700000000    ?C                   Parm                    WQSTSC                         STATUS CODE
029800000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
029900000000    ?C                   Parm                    WQMSG                          MESSAGE ID
030000000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
030100000000    ? *___________________________________________________________________
030200000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03030000000003EXIT    F3=Exit
03040000000012CANCEL  F12=Cancel
030500000000** WTM
03060000000000Record not deleted. No longer available.
03070010101900Date Range record not found.
03080010101900Call to UPDDTR failed.
03090010101900Request not supported in program DLTDTR.
