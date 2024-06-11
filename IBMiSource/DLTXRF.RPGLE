000100130204     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200130204     H option(*SRCSTMT: *NODEBUGIO)
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500101220    ? *  Description:  Delete Payroll SSN Xref
000600000000    ? *
000700010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000800000000    ? *_________________________________________________________________________
000900000000    ? *
001000130204    ?FDLTXRFD   CF   E             WORKSTN
001100000000    ?F                                     INFDS(DSPD)
001200130204     FACCMST    IF   E           K DISK
001300130204     FPLNMST    IF   E           K DISK
001400000000    ? *_________________________________________________________________________
001500000000    ? *
001600000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
001700000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
001800010219    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              PANEL MESSAGES
001900000000    ? *_________________________________________________________________________
002000130204      /COPY *LIBL/QMODSRC,#PROTO
002100130204     D w80date         s              8S 0 inz
002200000000    ? *
002300000406    ? * Data structure
002400130204    ?D WDDTA         E DS                  EXTNAME(WEBPLNXRFP)
002500130204     D webnote       e ds                  extname(webnotp) inz
002600000000    ? *
002700000000    ? * Program status data structure
002800991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
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
008200130204    ?C                   Call      'UPDXRF  '                                   PROCESS REC IO
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
010700101220    ?
010800130204    ? *
010900130204     C     ACCKEY        Chain     ACCMST
011000130204     C                   If        %found(ACCMST)
011100130204     C                   Eval      WSNAME = %trim(ACNAM1)
011200130204     C                   Else
011300130204     C                   Eval      WSNAME = *Blanks
011400130204     C                   End
011500130204    ? *
011600130204     C     plnkey        Chain     PLNMST
011700130204     C                   Eval      webnote = #getnot(plncat:xltrst:xlsub#:
011800130204     C                                               xlacct:w80date:xlplan)
011900130204     C                   Eval      wsdesc = %trim(CNDSC)
012000130204     C     plnkeyx       Chain     PLNMST
012100130204     C                   Eval      webnote = #getnot(plncat:xltrst:xlsub#:
012200130204     C                                               xlacct:w80date:xlxpln)
012300130204     C                   Eval      wxdesc = %trim(CNDSC)
012400130204    ? *
012500100521
012600000000    ? * Write delete confirmation panel
012700000000    ?C                   Exfmt     DLTPNLR                                      DSPLY DLT PNL
012800000000    ?C                   Endsr                                                  END DSPPNL
012900000000    ? *___________________________________________________________________
013000000000    ? * Process ENTER request
013100000000    ? *___________________________________________________________________
013200000000    ?C     PRCENT        Begsr                                                  PROC ENTER RQS
013300000000    ?C                   Exsr      CHKDLT                                       CHECK DLT ALLWD
013400991201B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
013500000000 001?C                   Exsr      DLTREC                                       DELETE RECORD
013600000000E001?C                   Endif                                                  END IF DLT ALLOWED
013700000000    ? *
013800000000B001?C     WWRTN         Ifeq      *BLANKS                                      IF DELETE ALLOWED
013900000000 001?C                   Move      'END'         WWSTT                          END PROGRAM
014000000000 001?C                   Move      *BLANKS       WORTN                          RETURN GOOD DELETE
014100000000E001?C                   Endif                                                  END IF DLT ALLOWED
014200000000    ?C                   Endsr                                                  END PRCENT
014300000000    ? *___________________________________________________________________
014400000000    ? * Delete record
014500000000    ? *___________________________________________________________________
014600000000    ?C     DLTREC        Begsr                                                  DELETE RECORD
014700130204    ?C                   Call      'UPDXRF  '                                   PROCESS REC IO
014800000000    ?C                   Parm      'DELETE  '    WWRQS                          GET REC
014900000000    ?C                   Parm                    WWRTN                          RETURN CODE
015000000614    ?C                   Parm                    WDDTA                          REC DATA
015100000000    ? *
015200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF DELETE ERROR
015300000000 001?C                   Move      WTM(1)        WWMSG                          GET MESSAGE
015400000000 001?C                   Exsr      SNDMSG                                       SEND MSG
015500000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
015600000000E001?C                   Endif                                                  END IF ERROR
015700000000    ?C                   Endsr                                                  END PRCENT
015800000000    ? *___________________________________________________________________
015900000000    ? * Check if delete allowed
016000000000    ? *___________________________________________________________________
016100000000    ?C     CHKDLT        Begsr                                                  CHECK DELETE
016200991201    ?C                   Move      *BLANKS       WWRTN                          RETURN GOOD DELETE
016300100609    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
016400100609    ? *
016500130204 001?C                   Call      'CHKXRF  '                                   CHECK DATA
016600100609 001?C                   Parm      'EDTDLT  '    WWRQS                          EDIT REQUEST
016700100609 001?C                   Parm                    WWRTN                          RETURN CODE
016800100609 001?C                   Parm                    WDDTA                          REC DATA
016900100609    ? *
017000000000    ?C                   Endsr                                                  END CHECK DLT
017100000000    ? *___________________________________________________________________
017200000000    ? * Release the record
017300000000    ? *___________________________________________________________________
017400000000    ?C     RELREC        Begsr                                                  RELEASE RECORD
017500130204    ?C                   Call      'UPDXRF  '                                   PROCESS REC IO
017600000000    ?C                   Parm      'RELEASE '    WWRQS             8            RELEASE RECORD
017700991201    ?C                   Parm                    WWRTN                          RETURN CODE
017800000614    ?C                   Parm                    WDDTA                          REC DATA STRUCTURE
017900000000    ?C                   Endsr                                                  END RELREC
018000000000    ? *___________________________________________________________________
018100000000    ? * Receive messages
018200000000    ? *___________________________________________________________________
018300000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
018400000000    ?C                   Movea     *IN           WWIN                           INDICATORS
018500000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
018600000000    ?C                   Parm      'RECEIVE '    WWRQS                          REQUEST RECEIVE
018700000000    ?C                   Parm                    WWIN                           INDICATORS
018800000000    ?C                   Parm                    WWRTN                          RETURN CODE
018900000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
019000000000    ?C                   Endsr                                                  END RCV MSG
019100000000    ? *___________________________________________________________________
019200000000    ? * Build function key information
019300000000    ? *___________________________________________________________________
019400000000    ?C     BLDFKY        Begsr                                                  BUILD FNC KEYS
019500991108    ?C                   Movea     *IN           WWIN                           INDICATORS
019600991108    ?C                   Call      'PRCFKY2'                                    PROC FNC KYS
019700000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
019800000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
019900000000    ?C                   Parm                    WAD                            FNC DESC
020000991108    ?C                   Parm                    WWIN                           *IN
020100000000    ?C                   Parm                    WAF                            FNC KEY TABLE
020200000000    ?C                   Parm                    WIFKV                          FNC KYS ALLWD
020300000000    ? *
020400010913    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
020500010913    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
020600010913    ?C                   Sub       1             WW                             BUMP IDX
020700010913    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
020800000000    ?C                   Endsr                                                  END BLD FNCTNS
020900000000    ? *___________________________________________________________________
021000000000    ? * Process function keys
021100000000    ? *___________________________________________________________________
021200000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
021300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
021400991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
021500000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
021600000000    ?C     WWFNC         Parm                    WWRTN                          RETURN CODE
021700000000    ?C                   Parm                    WAD                            FNC DESC
021800991108    ?C                   Parm                    WWIN                           *IN
021900000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
022000000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
022100000000    ?C                   Endsr                                                  END PROC FNCTNS
022200000000    ? *___________________________________________________________________
022300000000    ? * Process EXIT function
022400000000    ? *___________________________________________________________________
022500000000    ?C     PRCEXT        Begsr                                                  EXIT
022600000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
022700000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
022800000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
022900000000    ?C                   Endsr                                                  END RETURN
023000000000    ? *___________________________________________________________________
023100000000    ? * Process CANCEL function
023200000000    ? *___________________________________________________________________
023300000000    ?C     PRCCNL        Begsr                                                  CANCEL
023400000000    ?C                   Exsr      RELREC                                       RELEASE RECORD
023500000000    ?C                   Movel     WWFNC         WORTN                          RETURN CODE
023600000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
023700000000    ?C                   Endsr                                                  END RETURN
023800000000    ? *___________________________________________________________________
023900000000    ? * Send message
024000000000    ? *___________________________________________________________________
024100000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
024200000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
024300000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
024400000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA QUEUE LIB
024500000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
024600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
024700000000    ?C                   Endsr                                                  END PROC FNC
024800000000    ? *___________________________________________________________________
024900000000    ? * Parameter lists
025000000000    ? *___________________________________________________________________
025100000000    ?C     PLIST         Begsr                                                  PARM LISTS
025200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
025300000000    ?C                   Parm                    WIRQS             8            EXT MODE
025400000000    ?C                   Parm                    WORTN             8            INTERNAL MODE
025500000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
025600000614    ?C                   Parm                    WDDTA                          RECORD DS
025700000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
025800000000    ?C                   Endsr                                                  END PLIST
025900000000    ? *___________________________________________________________________
026000000000    ? * Initialize routine
026100000000    ? *___________________________________________________________________
026200000000    ?C     *INZSR        Begsr                                                  INITIALIZE
026300010913      *
026400000000    ?C     *LIKE         Define    WORTN         WWFNC                          FUNCTION CODE
026500000000    ?C     *LIKE         Define    WORTN         WWOPT                          OPTION CODE
026600000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTIONS VALID
026700000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
026800000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
026900000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
027000000000    ?C                   Z-add     *ZEROS        WW                3 0          WORK INDEX
027100000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
027200000000    ?C                   Move      *BLANKS       WWSTT             3            LOOP CONTROL
027300000000    ?C                   Move      *BLANKS       WWRTN             8            RETURN CODE
027400130204     C     *date         Mult      10000.0001    w80date
027500130204    ?C     ACCKEY        Klist                                                  ACKCTL
027600130204    ?C                   Kfld                    XLTRST                         POSITION TO 1
027700130204    ?C                   Kfld                    XLSUB#                         POSITION TO 1
027800130204    ?C                   Kfld                    XLACCT                         POSITION TO 1
027900130204    ?C     PLNKEY        Klist                                                  ACKCTL
028000130204    ?C                   Kfld                    XLTRST                         POSITION TO 1
028100130204    ?C                   Kfld                    XLSUB#                         POSITION TO 1
028200130204    ?C                   Kfld                    XLPLAN                         POSITION TO 1
028300130204    ?C     PLNKEYx       Klist                                                  ACKCTL
028400130204    ?C                   Kfld                    XLTRST                         POSITION TO 1
028500130204    ?C                   Kfld                    XLSUB#                         POSITION TO 1
028600130204    ?C                   Kfld                    XLXPLN                         POSITION TO 1
028700000000    ?C                   Endsr                                                  END *INZSR
028800000000    ? *___________________________________________________________________
028900000000    ? * Program error handler
029000000000    ? *___________________________________________________________________
029100000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
029200000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
029300000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
029400000000    ?C                   Parm                    WQSTSC                         STATUS CODE
029500000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
029600000000    ?C                   Parm                    WQMSG                          MESSAGE ID
029700000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
029800000000    ? *___________________________________________________________________
029900000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03000000000003EXIT    F3=Exit
03010000000012CANCEL  F12=Cancel
030200000000** WTM
03030000000000Record not deleted. No longer available.
03040010122000Record not found.
03050010122000Call to UPDPXR failed.
03060010122000Request not supported in program DLTPXR.
