000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300000000    ? *
000400090224    ? *  (c)Copyright 2009 by GBS,Inc.
000500050318    ? *  This document contains restricted materials of GBS,Inc.
000600070516    ? *
000700050318    ? *___________________________________________________________________
000800090707    ?FODCCTLP   IF   E           K DISK
000900000000    ? *
001000010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100090304    ?D WTM             S             80    DIM(9) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001200000000    ? *___________________________________________________________________
001300000000    ? *
001400000614    ? * Data structure
001500090707    ?D WUDTA         E DS                  EXTNAME(ODCCTLP)
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
003300000810    ? * Defualt Data
003400000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003500010219    ? *
003600090224    ? * ACH Routing Number
003700090319     C****               If        AHROUT   =    *Zeros
003800090319    ?C****               Move      'ERROR   '    WORTN                          REQUEST ERROR
003900090319    ?C****               Move      WTM(4)        WWMSG                          PASS MSG
004000090319    ?C****               Exsr      SNDMSG                                       SEND MSG
004100090319     C****               Exsr      SNDMSG
004200090319     C****               Endif
004300070518    ? *
004400090224    ? * ACH Account Number
004500010301    ? *
004600090319     C****               If        AHACT#   =    *Zeros
004700090319     C****               Move      'ERROR   '    WORTN
004800090319     C****               Move      WTM(7)        WWMSG
004900090319     C****               Exsr      SNDMSG
005000090319     C****               Endif
005100090319    ? *
005200000000    ?C                   Endsr                                                  END EDIT RECORD
005300010301    ? *___________________________________________________________________
005400010301    ? * format Date edit
005500010301    ? *___________________________________________________________________
005600010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
005700010301     C                   movel     'MMDDYYYY'    Input_Format
005800010301     C                   Call      'FMTDATE'
005900010301     C                   Parm                    Input_Date       32
006000010301     C                   Parm                    Input_Format     32
006100010301     C                   Parm                    Output_Format    32
006200010301     C                   Parm                    Output_Date      32
006300010301     C                   Parm                    Output_Error     10
006400010301    ?C                   Endsr                                                  END DLT RQST
006500000000    ? *___________________________________________________________________
006600000000    ? * Edit delete request
006700000000    ? *___________________________________________________________________
006800000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
006900000000    ?C                   Endsr                                                  END DLT RQST
007000000000    ? *___________________________________________________________________
007100000000    ? * Default data
007200000000    ? *___________________________________________________________________
007300000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
007400000000    ?C                   Endsr                                                  END DFT DATA
007500000000    ? *___________________________________________________________________
007600000000    ? * Send messages
007700000000    ? *___________________________________________________________________
007800000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
007900000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
008000000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
008100000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
008200000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
008300000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
008400000000    ?C                   Endsr                                                  END SND ERRMSG
008500000000    ? *___________________________________________________________________
008600000000    ? * Process error
008700000000    ? *___________________________________________________________________
008800000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
008900000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009000000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
009100000000    ?C                   Exsr      SNDMSG                                       SEND MSG
009200000000    ?C                   Endsr                                                  END PRCERR
009300000000    ? *___________________________________________________________________
009400000000    ? * Parameter list
009500000000    ? *___________________________________________________________________
009600000000    ?C     PLIST         Begsr                                                  PARM LISTS
009700000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
009800000000    ?C                   Parm                    WIRQS             8            REQUEST
009900000000    ?C                   Parm                    WORTN             8            RETURN CODE
010000000614    ?C                   Parm                    WUDTA                          DATA
010100000000    ?C                   Endsr                                                  END PLIST
010200000000    ? *___________________________________________________________________
010300000000    ? * Define Variables and Key Lists
010400000000    ? *___________________________________________________________________
010500000000    ?C     DEFN          Begsr                                                  PARM LISTS
010600000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
010700000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
010800000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
010900000000    ?C                   Endsr                                                  END DEFN
011000000000    ? *___________________________________________________________________
011100000000    ? * Program error handler
011200000000    ? *___________________________________________________________________
011300000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
011400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
011500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
011600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
011700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
011800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
011900000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
012000000000    ? *___________________________________________________________________
012100000112** WTMP
01220000000000T-Record is not eligible for deletion.
01230009070700Request not supported by program CHKCCO
012400000117** WTM
01250009022461AHC begin date must be a valid date.
01260009022462ACH end date must be a valid date.
