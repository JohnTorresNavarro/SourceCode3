000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010219    ? *  Description:  Check ISC Agency
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *  This document contains restricted materials of IO, Inc.
000900000000    ? *___________________________________________________________________
001000010219    ?FAGENCY    IF   E           K DISK
001001010219    ?FISCSMN    IF   E           K DISK
001100000000    ? *
001200010220    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300010301    ?D WTM             S             80    DIM(5) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001400000000    ? *___________________________________________________________________
001500000000    ? *
001600000614    ? * Data structure
001700010219    ?D WUDTA         E DS                  EXTNAME(ISCAGY)
002100000810    ? *
002200000000    ? * Program status data structure
002300991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003100000000    ? *___________________________________________________________________
003200000000    ? * Process check request
003300000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
003400000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
003500000000    ?C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
003600000000    ?C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
003700000000    ?C                   Cas                     PRCERR                         REQUEST ERROR
003800000000    ?C                   Endcs                                                  END CASE
003900000000    ?C                   Return                                                 RETURN
004000000000    ? *___________________________________________________________________
004100000000    ? * Edit record
004200000000    ? *___________________________________________________________________
004300000000    ?C     EDTRCD        Begsr                                                  EDIT RECORD
004400000810    ? *
004500000810    ? * Defualt Data
004600000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
004601010219    ? *
004602010219    ? * Check Agency
004603010219     C     IAAGNY        Chain     AGENCY
004604010219     C                   If        Not %Found
004605010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004606010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004607010219    ?C                   Exsr      SNDMSG                                       SEND MSG
004608010219     C                   Endif
004700000810    ? *
004800010219    ? * Check Salesman
004900010219     C     IASMAN        Chain     ISCSMN
005000000810     C                   If        Not %Found
005100000810    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005200010220    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005300000810    ?C                   Exsr      SNDMSG                                       SEND MSG
005400000810     C                   Endif
006900000810    ? *
006902010301    ? * EFFECTIVE DATE
006903010301     C                   If        IAEFDT = *ZEROS
006904010301    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006905010301    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
006906010301    ?C                   Exsr      SNDMSG                                       SEND MSG
006907010301     C                   Else
006908010301     C                   movel     IAEFDT        Input_Date
006909010301     C                   Exsr      EDTDAT
006910010301     C                   If        Output_Error <> *Blanks
006911010301    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006912010301    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
006913010301    ?C                   Exsr      SNDMSG                                       SEND MSG
006914010301     C                   Endif
006915010301     C                   Endif
006916010301    ? *
006917010301    ? * TERM DATE
006918010301     C                   If        IATRDT <> *ZEROS
006919010301     C                   movel     IATRDT        Input_Date
006920010301     C                   Exsr      EDTDAT
006921010301     C                   If        Output_Error <> *Blanks
006922010301    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006923010301    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
006924010301    ?C                   Exsr      SNDMSG                                       SEND MSG
006925010301     C                   Else
006926010301    ? *
006927010301    ? * TERM DATE > EFF DATE
006928010301     C                   If        IATRDT <> *ZEROS and
006929010301     C                             IAEFDT <> *ZEROS
006930010301     C     IATRDT        Mult      10000.0001    WWTRDT            8 0
006931010301     C     IAEFDT        Mult      10000.0001    WWEFDT            8 0
006932010301     C                   If        WWEFDT  > WWTRDT
006933010301    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006934010301    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
006935010301    ?C                   Exsr      SNDMSG                                       SEND MSG
006936010301     C                   Endif
006937010301     C                   Endif
006938010301     C                   Endif
006939010301     C                   Endif
006940010301    ? *
007000000000    ?C                   Endsr                                                  END EDIT RECORD
007001010301    ? *___________________________________________________________________
007002010301    ? * format Date edit
007003010301    ? *___________________________________________________________________
007004010301    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
007005010301     C                   movel     'MMDDYYYY'    Input_Format
007006010301     C                   Call      'FMTDATE'
007007010301     C                   Parm                    Input_Date       32
007008010301     C                   Parm                    Input_Format     32
007009010301     C                   Parm                    Output_Format    32
007010010301     C                   Parm                    Output_Date      32
007011010301     C                   Parm                    Output_Error     10
007012010301    ?C                   Endsr                                                  END DLT RQST
007100000000    ? *___________________________________________________________________
007200000000    ? * Edit delete request
007300000000    ? *___________________________________________________________________
007400000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
007500000000    ?C                   Endsr                                                  END DLT RQST
007600000000    ? *___________________________________________________________________
007700000000    ? * Default data
007800000000    ? *___________________________________________________________________
007900000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
008000000000    ?C                   Endsr                                                  END DFT DATA
008100000000    ? *___________________________________________________________________
008200000000    ? * Send messages
008300000000    ? *___________________________________________________________________
008400000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
008500000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
008600000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
008700000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
008800000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
008900000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
009000000000    ?C                   Endsr                                                  END SND ERRMSG
009100000000    ? *___________________________________________________________________
009200000000    ? * Process error
009300000000    ? *___________________________________________________________________
009400000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
009500000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009600000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
009700000000    ?C                   Exsr      SNDMSG                                       SEND MSG
009800000000    ?C                   Endsr                                                  END PRCERR
009900000000    ? *___________________________________________________________________
010000000000    ? * Parameter list
010100000000    ? *___________________________________________________________________
010200000000    ?C     PLIST         Begsr                                                  PARM LISTS
010300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
010400000000    ?C                   Parm                    WIRQS             8            REQUEST
010500000000    ?C                   Parm                    WORTN             8            RETURN CODE
010600000614    ?C                   Parm                    WUDTA                          DATA
010700000000    ?C                   Endsr                                                  END PLIST
010800000000    ? *___________________________________________________________________
010900000000    ? * Define Variables and Key Lists
011000000000    ? *___________________________________________________________________
011100000000    ?C     DEFN          Begsr                                                  PARM LISTS
011200000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
011300000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
011400000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
011500000000    ?C                   Endsr                                                  END DEFN
011600000000    ? *___________________________________________________________________
011700000000    ? * Program error handler
011800000000    ? *___________________________________________________________________
011900000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
012000000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
012100000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
012200000000    ?C                   Parm                    WQSTSC                         STATUS CODE
012300000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
012400000000    ?C                   Parm                    WQMSG                          MESSAGE ID
012500000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
012600000000    ? *___________________________________________________________________
012700000112** WTMP
01280000000000T-Record is not eligible for deletion.
01290001021900Request not supported by program CHKAGY.
013000000117** WTM
01310001021961Agency must be a valid Agency.
01330001030162Salesman must be a valid Internal Salesman.
01340001030163Effective Date must be valid.
01350001030164Term Date must be valid.
01360001030164Term Date Cannot be less than Effective Date.
