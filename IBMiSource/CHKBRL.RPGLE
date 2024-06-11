000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300040219    ? *  Description:  Check Broker Representative Table
000400000000    ? *
000500040219    ? *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600000000    ? *  This document contains restricted materials of IO, Inc.
000700000000    ? *___________________________________________________________________
000800040219    ?FBRKREP    IF   E           K DISK
000900000000    ? *
001000010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100011022    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001200000000    ? *___________________________________________________________________
001300000000    ? *
001400000614    ? * Data structure
001500040219    ?D WUDTA         E DS                  EXTNAME(BRKREP)
001600000810    ? *
001700000000    ? * Program status data structure
001800991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000    ? *___________________________________________________________________
002000000000    ? * Process check request
002100000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002200000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002300000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002400000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002500000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002600000000    ?C                   Endcs                                                  END CASE
002700000000    ?C                   Return                                                 RETURN
002800000000    ? *___________________________________________________________________
002900000000    ? * Edit record
003000000000    ? *___________________________________________________________________
003100000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003200000810    ? *
003300040219    ? * Check Broker First Name
003400040219     C     BRKFNM        Ifeq      *Blanks
003500010914    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003600010914    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
003700010914    ?C                   Exsr      SNDMSG                                       SEND MSG
003800010914     C                   Endif
003900011022    ? *
004000040219    ? * Check Broker Last Name
004100040219     C     BRKLNM        Ifeq      *Blanks
004200011022    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004300011022    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
004400011022    ?C                   Exsr      SNDMSG                                       SEND MSG
004500040219     C                   Endif
004600040322    ? *
004700040322    ? * Check Term Date
004800040322     C                   IF        brktmd <> *ZEROS
004900040325     C     *USA          TEST(DE)                brktmd
005000040322    1C                   IF        %ERROR
005100040322    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005200040322    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
005300040322    ?C                   Exsr      SNDMSG                                       SEND MSG
005400040322     C                   END
005500040322     C                   ENDIF
005600010914    ? *
005700010913    ?C                   Endsr                                                  END DLT RQST
005800010301    ? *___________________________________________________________________
005900010301    ? * format Date edit
006000010301    ? *___________________________________________________________________
006100010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
006200010301     C                   movel     'MMDDYYYY'    Input_Format
006300010301     C                   Call      'FMTDATE'
006400010301     C                   Parm                    Input_Date       32
006500010301     C                   Parm                    Input_Format     32
006600010301     C                   Parm                    Output_Format    32
006700010301     C                   Parm                    Output_Date      32
006800010301     C                   Parm                    Output_Error     10
006900010301    ?C                   Endsr                                                  END DLT RQST
007000000000    ? *___________________________________________________________________
007100000000    ? * Edit delete request
007200000000    ? *___________________________________________________________________
007300000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
007400000000    ?C                   Endsr                                                  END DLT RQST
007500000000    ? *___________________________________________________________________
007600000000    ? * Default data
007700000000    ? *___________________________________________________________________
007800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
007900000000    ?C                   Endsr                                                  END DFT DATA
008000000000    ? *___________________________________________________________________
008100000000    ? * Send messages
008200000000    ? *___________________________________________________________________
008300000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
008400000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
008500000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
008600000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
008700000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
008800000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
008900000000    ?C                   Endsr                                                  END SND ERRMSG
009000000000    ? *___________________________________________________________________
009100000000    ? * Process error
009200000000    ? *___________________________________________________________________
009300000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
009400000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009500000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
009600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
009700000000    ?C                   Endsr                                                  END PRCERR
009800000000    ? *___________________________________________________________________
009900000000    ? * Parameter list
010000000000    ? *___________________________________________________________________
010100000000    ?C     PLIST         Begsr                                                  PARM LISTS
010200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
010300000000    ?C                   Parm                    WIRQS             8            REQUEST
010400000000    ?C                   Parm                    WORTN             8            RETURN CODE
010500000614    ?C                   Parm                    WUDTA                          DATA
010600000000    ?C                   Endsr                                                  END PLIST
010700000000    ? *___________________________________________________________________
010800000000    ? * Define Variables and Key Lists
010900000000    ? *___________________________________________________________________
011000000000    ?C     DEFN          Begsr                                                  PARM LISTS
011100000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
011200000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
011300000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
011400000000    ?C                   Endsr                                                  END DEFN
011500000000    ? *___________________________________________________________________
011600000000    ? * Program error handler
011700000000    ? *___________________________________________________________________
011800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
011900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
012000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
012100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
012200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
012300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
012400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
012500000000    ? *___________________________________________________________________
012600000112** WTMP
01270000000000T-Record is not eligible for deletion.
01280004021900Request not supported by program CHKBRL.
012900000117** WTM
01300004032264Term Date is invalid.
01310004021962First name must be entered.
01320004021963Last name must be entered.
