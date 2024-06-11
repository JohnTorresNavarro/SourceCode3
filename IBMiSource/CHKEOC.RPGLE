000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300030717    ? *  Description:  Check E&O Coverage file
000400000000    ? *
000500030716    ? *  (c)Copyright 2003 by Group Benefit Services, Inc.
000600000000    ? *___________________________________________________________________
000700000000    ? *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900030722    ?D WTM             S             80    DIM(5) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001000000000    ? *___________________________________________________________________
001100000000    ? *
001200000614    ? * Data structure
001300030717    ?D WUDTA         E DS                  EXTNAME(BLIEOC)
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
003400030716    ? * RELATIONSHIP ID
003500030717     C                   If        LERELI = *BLANKS
003600010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003700010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003800010219    ?C                   Exsr      SNDMSG                                       SEND MSG
003900010219     C                   Endif
004000010220    ? *
004100030717    ? * INSURED
004200030717     C                   If        LEINSR = *BLANKS
004300010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400010220    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004500010220    ?C                   Exsr      SNDMSG                                       SEND MSG
004600030722     C                   Else
004700030722     C                   If        LEINSR <> '1' and
004800030722     C                             LEINSR <> '2' and
004900030722     C                             LEINSR <> '3'
005000030722    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005100030722    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005200030722    ?C                   Exsr      SNDMSG                                       SEND MSG
005300030722     C                   Endif
005400010220     C                   Endif
005500010220    ? *
005600030722    ? * EFFECT DATE
005700030722     C                   If        LEEFFD <>     *ZEROS
005800030722     C                   movel     LEEFFD        Input_Date
005900010220     C                   Exsr      EDTDAT
006000010220     C                   If        Output_Error <> *Blanks
006100010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006200030717    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
006300010220    ?C                   Exsr      SNDMSG                                       SEND MSG
006400010220     C                   Endif
006500010220     C                   Endif
006600010220    ? *
006700030722    ? * EXP DATE
006701031105     C                   If        LEEXPD <> *ZEROS  and
006800031105     C                             LEEXPD <> 99999999
006900030722     C                   movel     LEEXPD        Input_Date
007000010220     C                   Exsr      EDTDAT
007100010220     C                   If        Output_Error <> *Blanks
007200010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007300030717    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
007400010220    ?C                   Exsr      SNDMSG                                       SEND MSG
007500030717     C                   End
007600030717     C                   End
007700030722    ? *
007800030722    ? * EXPIRE > EFF DATE
007900030722     C                   If        LEEXPD <> *ZEROS and
008000030722     C                             LEEFFD <> *ZEROS
008100030722     C     LEEXPD        Mult      10000.0001    WWTRDT            8 0
008200030722     C     LEEFFD        Mult      10000.0001    WWEFDT            8 0
008300030722     C                   If        WWEFDT  > WWTRDT
008400030722    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008500030722    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
008600030722    ?C                   Exsr      SNDMSG                                       SEND MSG
008700030722     C                   Endif
008800030722     C                   Endif
008900000810    ? *
009000000000    ?C                   Endsr                                                  END EDIT RECORD
009100010220    ? *___________________________________________________________________
009200010220    ? * format Date edit
009300010220    ? *___________________________________________________________________
009400010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
009500010220     C                   movel     'MMDDYYYY'    Input_Format
009600010220     C                   Call      'FMTDATE'
009700010220     C                   Parm                    Input_Date       32
009800010220     C                   Parm                    Input_Format     32
009900010220     C                   Parm                    Output_Format    32
010000010220     C                   Parm                    Output_Date      32
010100010220     C                   Parm                    Output_Error     10
010200010220    ?C                   Endsr                                                  END DLT RQST
010300000000    ? *___________________________________________________________________
010400000000    ? * Edit delete request
010500000000    ? *___________________________________________________________________
010600000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
010700000000    ?C                   Endsr                                                  END DLT RQST
010800000000    ? *___________________________________________________________________
010900000000    ? * Default data
011000000000    ? *___________________________________________________________________
011100000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
011200000000    ?C                   Endsr                                                  END DFT DATA
011300000000    ? *___________________________________________________________________
011400000000    ? * Send messages
011500000000    ? *___________________________________________________________________
011600000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
011700000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
011800000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
011900000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
012000000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
012100000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
012200000000    ?C                   Endsr                                                  END SND ERRMSG
012300000000    ? *___________________________________________________________________
012400000000    ? * Process error
012500000000    ? *___________________________________________________________________
012600000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
012700000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012800000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
012900000000    ?C                   Exsr      SNDMSG                                       SEND MSG
013000000000    ?C                   Endsr                                                  END PRCERR
013100000000    ? *___________________________________________________________________
013200000000    ? * Parameter list
013300000000    ? *___________________________________________________________________
013400000000    ?C     PLIST         Begsr                                                  PARM LISTS
013500000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
013600000000    ?C                   Parm                    WIRQS             8            REQUEST
013700000000    ?C                   Parm                    WORTN             8            RETURN CODE
013800000614    ?C                   Parm                    WUDTA                          DATA
013900000000    ?C                   Endsr                                                  END PLIST
014000000000    ? *___________________________________________________________________
014100000000    ? * Define Variables and Key Lists
014200000000    ? *___________________________________________________________________
014300000000    ?C     DEFN          Begsr                                                  PARM LISTS
014400000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
014500000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
014600000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
014700000000    ?C                   Endsr                                                  END DEFN
014800000000    ? *___________________________________________________________________
014900000000    ? * Program error handler
015000000000    ? *___________________________________________________________________
015100000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
015200000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
015300000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
015400000000    ?C                   Parm                    WQSTSC                         STATUS CODE
015500000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
015600000000    ?C                   Parm                    WQMSG                          MESSAGE ID
015700000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
015800000000    ? *___________________________________________________________________
015900000112** WTMP
01600000000000T-Record is not eligible for deletion.
01610003071700Request not supported by program CHKEOC.
016200000117** WTM
01630003071661Relationship ID must be valid.
01640003072262Insured must be 1=Salesman,2=Agency,3=Super.
01650003072263Effective Date must be valid.
01660003072264Expire Date must be valid.
01670003072263Expire Date must be > Effective Date.
