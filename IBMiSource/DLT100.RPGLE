000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300140328    ? *  Description:  Delete Longer Name
000400000000    ? *
000500140328    ? *  (c)Copyright 2014 by GBS, Inc.
000600000000    ? *_________________________________________________________________________
000700000000    ? *
000800140328    ?FDLT100D   CF   E             WORKSTN
000900000000    ?F                                     INFDS(DSPD)
001000140328     FMEMBER    IF   E           K DISK    EXTFILE('F.MEMBER')
001100140328     FDEPNDC    IF   E           K DISK    EXTFILE('F.DEPNDC')
001200140328     FCFS100P   IF   E           K DISK
001300000000    ? *_________________________________________________________________________
001400000000    ? *
001500000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001600000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001700010219    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001800100618     D WSDESC          S             20A
001900000000    ? *_________________________________________________________________________
002000000000    ? *
002100000406    ? * Data structure
002200140328    ?D WDDTA         E DS                  EXTNAME(CFS100P)
002300000000    ? *
002400000000    ? * Program status data structure
002500991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002600140328
002700140328     D                UDS
002800140328     D  TITLE                201    240
002900000000    ? *
003000000000    ? * Display file data structure
003100991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
003200000000    ? *
003300991108    ?D WDFILE        E DS                  EXTNAME(IODBFD)
003400000000    ? *___________________________________________________________________
003500000000    ? * Process delete request
003600000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003700000000    ?C     WIRQS         Caseq     'DELETE'      PRCCNF                         DELETE CONFIRM
003800000000    ?C                   Cas                     PRCERR                         PROCESS ERROR
003900000000    ?C                   Endcs                                                  END CASE
004000000000    ?C                   Return                                                 RETURN
004100000000    ? *___________________________________________________________________
004200000000    ? * Process ERROR function
004300000000    ? *___________________________________________________________________
004400000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
004500010219    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
004600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
004700000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
004800000000    ?C                   Endsr                                                  END PRCERR
004900000000    ? *___________________________________________________________________
005000000000    ? * Delete record with confirmation
005100000000    ? *___________________________________________________________________
005200000000    ?C     PRCCNF        Begsr                                                  DELETE CONFIRMATION
005300000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
005400000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
005500000000 001?C                   Exsr      RCVMSG                                       RECEIVE MESSAGES
005600000000 001?C                   Exsr      DSPPNL                                       DISPLAY PANEL
005700000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
005800000000 001?C     WWFNC         Caseq     'EXIT    '    PRCEXT                         EXIT
005900000000 001?C     WWFNC         Caseq     'CANCEL  '    PRCCNL                         CANCEL
006000000000 001?C     WWFNC         Caseq     'ENTER   '    PRCENT                         ENTER
006100000000 001?C                   Endcs                                                  END CASE
006200000000E001?C                   Enddo                                                  END DOWHILE
006300000000    ?C                   Endsr                                                  END PRCCNF
006400000000    ? *___________________________________________________________________
006500000000    ? * Prepare panel
006600000000    ? *___________________________________________________________________
006700000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
006800000000    ?C                   Move      *BLANKS       WWSTT                          LOOP CONTROL
006900000000    ?C                   Exsr      BLDFKY                                       BUILD FNCTNS
007000000000    ?C                   Exsr      GETREC                                       GET RECORD
007100000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
007200000000 001?C                   Move      WTM(2)        WWMSG                          GET MESSAGE
007300000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
007400000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
007500000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
007600000000E001?C                   Endif                                                  END IF ERROR
007700000000    ?C                   Endsr                                                  END PRPPNL
007800000000    ? *___________________________________________________________________
007900000000    ? * Get record for delete
008000000000    ? *___________________________________________________________________
008100000000    ?C     GETREC        Begsr                                                  GET REC FOR DLT
008200140328    ?C                   Call      'UPD100  '                                   PROCESS REC IO
008300000000    ?C                   Parm      'GET     '    WWRQS             8            GET RECORD
008400991201    ?C                   Parm                    WWRTN                          RETURN CODE
008500000614    ?C                   Parm                    WDDTA                          REC DATA
008600000000B001?C     WWRTN         Ifne      *BLANKS                                      IF GET ERROR
008700000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
008800000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
008900000000 001?C                   Movel     'ERROR'       WORTN                          RETURN ERROR
009000000000 001?C                   Movel     'END'         WWSTT                          RETURN END
009100010914E001?C                   Endif                                                  END ERROR
009200000000    ?C                   Endsr                                                  END PREP CHANGE
009300000000    ? *___________________________________________________________________
009400000000    ? * Dispaly delete confirmation panel
009500000000    ? *___________________________________________________________________
009600000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANEL
009700000000    ? * Set OVERLAY based on last display file processed
009800000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
009900000000 001?C                   Setoff                                       35        OVERLAY OFF
010000000000 001?C                   Move      WQPGMN        WUPGM                          SAVE CRNT PGM
010100000000X001?C                   Else                                                   SAME PGM
010200000000 001?C                   Seton                                        35        OVERLAY ON
010300000000E001?C                   Endif                                                  END IF NEW PGM
010400000000    ? * Write message subfile
010500000000    ?C                   Seton                                        30        MSGSFL DISPLAY
010600000000    ?C                   Write     MSGSFLC                                      DISPLAY MSG SFL
010700100521
010800140328     C                   If        CFSEQ = 0
010900140328     C     CFSSN         Chain     MEMBER
011000140328     C                   if        %found(MEMBER)
011100140328     C                   Eval      WSFST  = %trim(MFNAME)
011200140328     C                   Eval      WSLST  = %trim(MLNAME)
011300140328     C                   Else
011400140328     C                   Eval      WSFST = *blanks
011500140328     C                   Eval      WSLST = *blanks
011600140328     C                   End
011700140328
011800140328     C                   Else
011900140328     C     DPKEY         Chain     DEPNDC
012000140328     C                   if        %found(DEPNDC)
012100140328     C                   Eval      WSFST  = %trim(DFNAME)
012200140328     C                   Eval      WSLST  = %trim(DLNAME)
012300140328     C                   Else
012400140328     C                   Eval      WSFST = *blanks
012500140328     C                   Eval      WSLST = *blanks
012600140328     C                   End
012700140328     C                   End
012800140328
012900140328     C     DPKEY         Klist
013000140328     C                   kfld                    CFSSN
013100140328     C                   kfld                    CFSEQ
013200100521
013300000000    ? * Write delete confirmation panel
013400000000    ?C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
013500000000    ?C                   Endsr                                                  END DSPPNL
013600000000    ? *___________________________________________________________________
013700000000    ? * Process ENTER request
013800000000    ? *___________________________________________________________________
013900000000    ?C     PRCENT        Begsr                                                  PROC ENTER RQS
014000000000    ?C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
014100991201B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
014200000000 001?C                   Exsr      DLTREC                                       DELETE RECORD
014300000000E001?C                   Endif                                                  END IF DLT ALLOWED
014400000000    ? *
014500000000B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
014600000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
014700000000 001?C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
014800000000E001?C                   Endif                                                  END IF DLT ALLOWED
014900000000    ?C                   Endsr                                                  END PRCENT
015000000000    ? *___________________________________________________________________
015100000000    ? * Delete record
015200000000    ? *___________________________________________________________________
015300000000    ?C     DLTREC        Begsr                                                  DELETE RECORD
015400140328    ?C                   Call      'UPD100  '                                   PROCESS REC IO
015500000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
015600000000    ?C                   Parm                    WWRTN                          RETURN CODE
015700000614    ?C                   Parm                    WDDTA                          REC DATA
015800000000    ? *
015900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
016000000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
016100000000 001?C                   Exsr      SNDMSG                                       SEND MSG
016200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
016300000000E001?C                   Endif                                                  END IF ERROR
016400000000    ?C                   Endsr                                                  END PRCENT
016500000000    ? *___________________________________________________________________
016600000000    ? * Check if delete allowed
016700000000    ? *___________________________________________________________________
016800000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
016900991201    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
017000100609    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
017100100609    ? *
017200140328 001?C                   Call      'CHK100  '                                   CHECK DATA
017300100609 001?C                   Parm      'EDTDLT  '    WWRQS                          EDIT REQUEST
017400100609 001?C                   Parm                    WWRTN                          RETURN CODE
017500100609 001?C                   Parm                    WDDTA                          REC DATA
017600100609    ? *
017700000000    ?C                   Endsr                                                  END CHECK DLT
017800000000    ? *___________________________________________________________________
017900000000    ? * Release the record
018000000000    ? *___________________________________________________________________
018100000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
018200140328    ?C                   Call      'UPD100  '                                   PROCESS REC IO
018300000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
018400991201    ?C                   Parm                    WWRTN                          RETURN CODE
018500000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
018600000000    ?C                   Endsr                                                  END RELREC
018700000000    ? *___________________________________________________________________
018800000000    ? * Receive messages
018900000000    ? *___________________________________________________________________
019000000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
019100000000    ?C                   Movea     *IN           WWIN                           INDICATORS
019200000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
019300000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
019400000000    ?C                   Parm                    WWIN                           INDICATORS
019500000000    ?C                   Parm                    WWRTN                          RETURN CODE
019600000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
019700000000    ?C                   Endsr                                                  END RCV MSG
019800000000    ? *___________________________________________________________________
019900000000    ? * Build function key information
020000000000    ? *___________________________________________________________________
020100000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
020200991108    ?C                   Movea     *IN           WWIN                           INDICATORS
020300991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
020400000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
020500000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
020600000000    ?C                   Parm                    WAD                            FNC DESC
020700991108    ?C                   Parm                    WWIN                           *IN
020800000000    ?C                   Parm                    WAF                            FNC KEY TABLE
020900000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
021000000000    ? *
021100010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
021200010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
021300010913    ?C                   Sub       1             WW                             BUMP IDX
021400010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
021500000000    ?C                   Endsr                                                  END BLD FNCTNS
021600000000    ? *___________________________________________________________________
021700000000    ? * Process function keys
021800000000    ? *___________________________________________________________________
021900000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
022000991108    ?C                   Movea     *IN           WWIN                           INDICATORS
022100991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
022200000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
022300000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
022400000000    ?C                   Parm                    WAD                            FNC DESC
022500991108    ?C                   Parm                    WWIN                           *IN
022600000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
022700000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
022800000000    ?C                   Endsr                                                  END PROC FNCTNS
022900000000    ? *___________________________________________________________________
023000000000    ? * Process EXIT function
023100000000    ? *___________________________________________________________________
023200000000    ?C     PRCEXT        Begsr                                                  EXIT
023300000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
023400000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
023500000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
023600000000    ?C                   Endsr                                                  END RETURN
023700000000    ? *___________________________________________________________________
023800000000    ? * Process CANCEL function
023900000000    ? *___________________________________________________________________
024000000000    ?C     PRCCNL        Begsr                                                  CANCEL
024100000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
024200000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
024300000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
024400000000    ?C                   Endsr                                                  END RETURN
024500000000    ? *___________________________________________________________________
024600000000    ? * Send message
024700000000    ? *___________________________________________________________________
024800000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
024900000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
025000000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
025100000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
025200000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
025300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
025400000000    ?C                   Endsr                                                  END PROC FNC
025500000000    ? *___________________________________________________________________
025600000000    ? * Parameter lists
025700000000    ? *___________________________________________________________________
025800000000    ?C     PLIST         Begsr                                                  PARM LISTS
025900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
026000000000    ?C                   Parm                    WIRQS             8            EXT MODE
026100000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
026200000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
026300000614    ?C                   Parm                    WDDTA                          RECORD DS
026400000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
026500000000    ?C                   Endsr                                                  END PLIST
026600000000    ? *___________________________________________________________________
026700000000    ? * Initialize routine
026800000000    ? *___________________________________________________________________
026900000000    ?C     *INZSR        Begsr                                                  INITIALIZE
027000010913      *
027100000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
027200000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
027300000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
027400000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
027500000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
027600000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
027700000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
027800000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
027900000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
028000000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
028100000000    ?C                   Endsr                                                  END *INZSR
028200000000    ? *___________________________________________________________________
028300000000    ? * Program error handler
028400000000    ? *___________________________________________________________________
028500000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
028600000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
028700000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
028800000000    ?C                   Parm                    WQSTSC                         STATUS CODE
028900000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
029000000000    ?C                   Parm                    WQMSG                          MESSAGE ID
029100000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
029200000000    ? *___________________________________________________________________
029300000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
02940000000003EXIT    F3=Exit
02950000000012CANCEL  F12=Cancel
029600000000** WTM
02970000000000Record not deleted. No longer available.
02980010101900Date Range record not found.
02990014032800Call to UPD100 failed.
03000014032800Request not supported in program DLT100.
