000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010220    ? *  Description:  Check Internal Sales Commission Type
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000    ? *___________________________________________________________________
000700000000    ? *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900010522    ?D WTM             S             80    DIM(7) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001000000000    ? *___________________________________________________________________
001100000000    ? *
001200000614    ? * Data structure
001300010220    ?D WUDTA         E DS                  EXTNAME(ISCGLB)
001400000810    ? *
001500000000    ? * Program status data structure
001600991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001700000000    ? *___________________________________________________________________
001800000000    ? * Process check request
001900000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
002000000000    ?C     WIRQS         Caseq     'EDIT'        EDTRCD                         EDIT RECORD
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
003300010219    ? *
003400010220    ? * INTERNAL SALES TYPE
003500010220     C                   If        IGITYP = *BLANKS
003600010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003700010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003800010219    ?C                   Exsr      SNDMSG                                       SEND MSG
003900010219     C                   Endif
004000010220    ? *
004100010220    ? * PLEASE ENTER A DESCRIPTION.
004200010220     C                   If        IGDESC = *BLANKS
004300010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400010220    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004500010220    ?C                   Exsr      SNDMSG                                       SEND MSG
004600010220     C                   Endif
004700010220    ? *
004800010220    ? * EFFECTIVE DATE
004900010220     C                   If        IGEFDT = *ZEROS
005000010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005100010220    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
005200010220    ?C                   Exsr      SNDMSG                                       SEND MSG
005300010220     C                   Else
005400010220     C                   movel     IGEFDT        Input_Date
005500010220     C                   Exsr      EDTDAT
005600010220     C                   If        Output_Error <> *Blanks
005700010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005800010220    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
005900010220    ?C                   Exsr      SNDMSG                                       SEND MSG
006000010220     C                   Endif
006100010220     C                   Endif
006200010220    ? *
006300010220    ? * TERM DATE
006400010220     C                   If        IGTRDT <> *ZEROS
006500010220     C                   movel     IGTRDT        Input_Date
006600010220     C                   Exsr      EDTDAT
006700010220     C                   If        Output_Error <> *Blanks
006800010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006900010220    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
007000010220    ?C                   Exsr      SNDMSG                                       SEND MSG
007100010223     C                   Else
007200010223    ? *
007300010223    ? * TERM DATE > EFF DATE
007400010223     C                   If        IGTRDT <> *ZEROS and
007500010223     C                             IGEFDT <> *ZEROS
007600010223     C     IGTRDT        Mult      10000.0001    WWTRDT            8 0
007700010223     C     IGEFDT        Mult      10000.0001    WWEFDT            8 0
007800010223     C                   If        WWEFDT  > WWTRDT
007900010223    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008000010223    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
008100010223    ?C                   Exsr      SNDMSG                                       SEND MSG
008200010223     C                   Endif
008300010223     C                   Endif
008400010220     C                   Endif
008500010220     C                   Endif
008600000810    ? *
008700000000    ?C                   Endsr                                                  END EDIT RECORD
008800010220    ? *___________________________________________________________________
008900010220    ? * format Date edit
009000010220    ? *___________________________________________________________________
009100010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
009200010220     C                   movel     'MMDDYYYY'    Input_Format
009300010220     C                   Call      'FMTDATE'
009400010220     C                   Parm                    Input_Date       32
009500010220     C                   Parm                    Input_Format     32
009600010220     C                   Parm                    Output_Format    32
009700010220     C                   Parm                    Output_Date      32
009800010220     C                   Parm                    Output_Error     10
009900010220    ?C                   Endsr                                                  END DLT RQST
010000000000    ? *___________________________________________________________________
010100000000    ? * Edit delete request
010200000000    ? *___________________________________________________________________
010300000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
010400000000    ?C                   Endsr                                                  END DLT RQST
010500000000    ? *___________________________________________________________________
010600000000    ? * Default data
010700000000    ? *___________________________________________________________________
010800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
010900000000    ?C                   Endsr                                                  END DFT DATA
011000000000    ? *___________________________________________________________________
011100000000    ? * Send messages
011200000000    ? *___________________________________________________________________
011300000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
011400000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
011500000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
011600000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
011700000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
011800000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
011900000000    ?C                   Endsr                                                  END SND ERRMSG
012000000000    ? *___________________________________________________________________
012100000000    ? * Process error
012200000000    ? *___________________________________________________________________
012300000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
012400000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012500000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
012600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
012700000000    ?C                   Endsr                                                  END PRCERR
012800000000    ? *___________________________________________________________________
012900000000    ? * Parameter list
013000000000    ? *___________________________________________________________________
013100000000    ?C     PLIST         Begsr                                                  PARM LISTS
013200000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
013300000000    ?C                   Parm                    WIRQS             8            REQUEST
013400000000    ?C                   Parm                    WORTN             8            RETURN CODE
013500000614    ?C                   Parm                    WUDTA                          DATA
013600000000    ?C                   Endsr                                                  END PLIST
013700000000    ? *___________________________________________________________________
013800000000    ? * Define Variables and Key Lists
013900000000    ? *___________________________________________________________________
014000000000    ?C     DEFN          Begsr                                                  PARM LISTS
014100000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
014200000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
014300000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
014400000000    ?C                   Endsr                                                  END DEFN
014500000000    ? *___________________________________________________________________
014600000000    ? * Program error handler
014700000000    ? *___________________________________________________________________
014800000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
014900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
015000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
015100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
015200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
015300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
015400000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
015500000000    ? *___________________________________________________________________
015600000112** WTMP
01570000000000T-Record is not eligible for deletion.
01580001022000Request not supported by program CHKGLB.
015900000117** WTM
01600001022061Internal Sales Type must be valid.
01610001022062Please enter a description.
016200030325
01630001022064Effective Date must be valid.
01640001022065Term Date must be valid.
01650001022365Term Date Cannot be less than Effective Date.
016600030325
