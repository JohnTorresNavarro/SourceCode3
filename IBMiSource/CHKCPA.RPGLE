000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300040825    ? *  Description:  Check Claims Payment Address
000400000000    ? *
000500040825    ? *  (c)Copyright 2004 by Group Benefit Services, Inc.
000600000000    ? *___________________________________________________________________
000601040825     FCARMST    IF   E           K DISK
000602040825     FSTATECD   IF   E           K DISK
000700000000    ? *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900030717    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001000000000    ? *___________________________________________________________________
001100000000    ? *
001200000614    ? * Data structure
001300040825    ?D WUDTA         E DS                  EXTNAME(CPAYAD)
001400000810    ? *
001500000000    ? * Program status data structure
001600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001700000000    ? *___________________________________________________________________
001800000000    ? * Process check request
001900000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002000000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
002001040825     C     WIRQS         Caseq     'EDTCHG'      EDTRCD                         EDIT RECORD
002100000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
002200000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
002300000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
002400000000    ?C                   Endcs                                                  END CASE
002500000000    ?C                   Return                                                 RETURN
002600000000    ? *___________________________________________________________________
002700000000    ? * Edit record
002800000000    ? *___________________________________________________________________
002900000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
003000000810    ? *
003100000810    ? * Defualt Data
003200000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003201040825    ? *
003202040825    ? * Carrier Code
003203040825     C                   If        CPCACD = *BLANKS
003204040825    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003205040825    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
003206040825    ?C                   Exsr      SNDMSG                                       SEND MSG
003207040825     C                   Else
003208040825     C     CPCACD        CHAIN     CARMST
003209040825     C                   If        Not %FOUND(CARMST)
003210040825    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003211040825    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
003212040825    ?C                   Exsr      SNDMSG                                       SEND MSG
003213040825     C                   Endif
003214040825     C                   Endif
004000010220    ? *
004100040825    ? * STATE
004200040825     C                   If        CPSTAT = *BLANKS
004300010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400040825    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004500010220    ?C                   Exsr      SNDMSG                                       SEND MSG
004501040825     C                   Else
004502040825     C     CPSTAT        Chain     STATECD
004503040825     C                   If        Not %FOUND(STATECD)
004504040825    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004505040825    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004506040825    ?C                   Exsr      SNDMSG                                       SEND MSG
004507040825     C                   Endif
004600010220     C                   Endif
010700000000    ?C                   Endsr                                                  END EDIT RECORD
010701040825    ? *___________________________________________________________________
010702040825    ? * format Date edit
010703040825    ? *___________________________________________________________________
010704040825    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
010705040825    ?C                   Endsr                                                  END DLT RQST
012000000000    ? *___________________________________________________________________
012100000000    ? * Edit delete request
012200000000    ? *___________________________________________________________________
012300000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
012400000000    ?C                   Endsr                                                  END DLT RQST
012500000000    ? *___________________________________________________________________
012600000000    ? * Default data
012700000000    ? *___________________________________________________________________
012800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
012900000000    ?C                   Endsr                                                  END DFT DATA
013000000000    ? *___________________________________________________________________
013100000000    ? * Send messages
013200000000    ? *___________________________________________________________________
013300000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
013400000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
013500000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
013600000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
013700000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
013800000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
013900000000    ?C                   Endsr                                                  END SND ERRMSG
014000000000    ? *___________________________________________________________________
014100000000    ? * Process error
014200000000    ? *___________________________________________________________________
014300000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
014400000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014500040825    ?C                   Move      WTMP(1)       WWMSG                          PASS MSG
014600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
014700000000    ?C                   Endsr                                                  END PRCERR
014800000000    ? *___________________________________________________________________
014900000000    ? * Parameter list
015000000000    ? *___________________________________________________________________
015100000000    ?C     PLIST         Begsr                                                  PARM LISTS
015200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
015300000000    ?C                   Parm                    WIRQS             8            REQUEST
015400000000    ?C                   Parm                    WORTN             8            RETURN CODE
015500000614    ?C                   Parm                    WUDTA                          DATA
015600000000    ?C                   Endsr                                                  END PLIST
015700000000    ? *___________________________________________________________________
015800000000    ? * Define Variables and Key Lists
015900000000    ? *___________________________________________________________________
016000000000    ?C     DEFN          Begsr                                                  PARM LISTS
016100000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
016200000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
016300000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
016400000000    ?C                   Endsr                                                  END DEFN
016500000000    ? *___________________________________________________________________
016600000000    ? * Program error handler
016700000000    ? *___________________________________________________________________
016800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
016900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
017000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
017100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
017200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
017300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
017400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
017500000000    ? *___________________________________________________________________
017600000112** WTMP
01770000000000T-Record is not eligible for deletion.
01780004082500Request not supported by program CHKCPA.
017900000117** WTM
01810004082561Two-character state code must be valid.
01820004082562Carrier Code must be valid.
