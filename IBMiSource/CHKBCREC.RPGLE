000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010126    ? *  Description:  Check BCREC file
000400000000    ? *
000500010126    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *  This document contains restricted materials of IO, Inc.
000900000000    ? *___________________________________________________________________
001000000000    ? *
001100000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001200000000    ?D WTM             S             80    DIM(32) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001300000000    ? *___________________________________________________________________
001400000000    ? *
001500000614    ? * Data structure
001600010126    ?D WUDTA         E DS                  EXTNAME(BCREC)
001700000000    ? *
001800000000    ? * Program status data structure
001900991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002000000000    ? *___________________________________________________________________
002100000000    ? * Process check request
002200000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002300000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002400000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002500000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002600000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002700000000    ?C                   Endcs                                                  END CASE
002800000000    ?C                   Return                                                 RETURN
002900000000    ? *___________________________________________________________________
003000000000    ? * Edit record
003100000000    ? *___________________________________________________________________
003200000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003300000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003400010126     C                   if        'X' <> 'X'
003600000824    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003700000824    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003800000824    ?C                   Exsr      SNDMSG                                       SEND MSG
003900000824     C                   end
004000000000    ?C                   Endsr                                                  END EDIT RECORD
004100000000    ? *___________________________________________________________________
004200000000    ? * Edit delete request
004300000000    ? *___________________________________________________________________
004400000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
004500000000    ?C                   Endsr                                                  END DLT RQST
004600000000    ? *___________________________________________________________________
004700000000    ? * Default data
004800000000    ? *___________________________________________________________________
004900000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
005300000000    ?C                   Endsr                                                  END DFT DATA
005400000000    ? *___________________________________________________________________
005500000000    ? * Send messages
005600000000    ? *___________________________________________________________________
005700000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
005800000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
005900000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
006000000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
006100000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
006200000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
006300000000    ?C                   Endsr                                                  END SND ERRMSG
006400000000    ? *___________________________________________________________________
006500000000    ? * Process error
006600000000    ? *___________________________________________________________________
006700000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
006800000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006900000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
007000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
007100000000    ?C                   Endsr                                                  END PRCERR
007200000000    ? *___________________________________________________________________
007300000000    ? * Parameter list
007400000000    ? *___________________________________________________________________
007500000000    ?C     PLIST         Begsr                                                  PARM LISTS
007600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
007700000000    ?C                   Parm                    WIRQS             8            REQUEST
007800000000    ?C                   Parm                    WORTN             8            RETURN CODE
007900000614    ?C                   Parm                    WUDTA                          DATA
008000000000    ?C                   Endsr                                                  END PLIST
008100000000    ? *___________________________________________________________________
008200000000    ? * Define Variables and Key Lists
008300000000    ? *___________________________________________________________________
008400000000    ?C     DEFN          Begsr                                                  PARM LISTS
008500000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
008600000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
008700000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
008800000000    ?C                   Endsr                                                  END DEFN
008900000000    ? *___________________________________________________________________
009000000000    ? * Program error handler
009100000000    ? *___________________________________________________________________
009200000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
009300000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
009400000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
009500000000    ?C                   Parm                    WQSTSC                         STATUS CODE
009600000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
009700000000    ?C                   Parm                    WQMSG                          MESSAGE ID
009800000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
009900000000    ? *___________________________________________________________________
010000000112** WTMP
01010000000000T-Record is not eligible for deletion.
01020001012600Request not supported by program CHKBCREC.
010300000117** WTM
010400010126
