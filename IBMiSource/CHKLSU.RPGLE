000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300030716    ? *  Description:  Check  Broker Carrier Licensing file
000400000000    ? *
000500030716    ? *  (c)Copyright 2003 by Group Benefit Services, Inc.
000600000000    ? *___________________________________________________________________
000601030812    ?FSUPRAGCY  IF   E           K DISK
000602030825    ?FSTATECD   IF   E           K DISK
000700000000    ? *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900010522    ?D WTM             S             80    DIM(7) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001000000000    ? *___________________________________________________________________
001100000000    ? *
001200000614    ? * Data structure
001300030812    ?D WUDTA         E DS                  EXTNAME(BLILSU)
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
003400030812    ? * SUPER AGENCY
003500030812     C                   If        LUSUPR = *BLANKS
003600010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003700010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003800010219    ?C                   Exsr      SNDMSG                                       SEND MSG
003801030811     C                   Else
003802030812     C     LUSUPR        Chain     SUPRAGCY
003803030811     C                   If        Not %Found
003804030811    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003805030811    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003806030811    ?C                   Exsr      SNDMSG                                       SEND MSG
003807030811     C                   Endif
003900010219     C                   Endif
004000010220    ? *
004100030716    ? * STATE
004201030825     C     LUSTAT        CHAIN     STATECD
004202030825     C                   If        not %Found
004300010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400010220    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004500010220    ?C                   Exsr      SNDMSG                                       SEND MSG
004600010220     C                   Endif
004700030716    ? *
004800030716    ? * LICENSE
004900030812     C                   If        LULICN = *BLANKS
005000030716    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005100030716    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
005200030716    ?C                   Exsr      SNDMSG                                       SEND MSG
005300030716     C                   Endif
005400030722    ? *
005500030722    ? * BUSINESS TYPE
005600030812     C                   If        LUTYPE = *BLANKS
005700030722    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005800030722    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
005900030722    ?C                   Exsr      SNDMSG                                       SEND MSG
006000030722     C                   Else
006100030812     C                   If        LUTYPE <> 'L' and
006200030812     C                             LUTYPE <> 'H' and
006300030812     C                             LUTYPE <> 'B'
006400030722    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006500030722    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
006600030722    ?C                   Exsr      SNDMSG                                       SEND MSG
006700030722     C                   Endif
006800030722     C                   Endif
006900010220    ? *
007000030722    ? * EFFECTIVE DATE
007100030812     C                   If        LUEFFD <>     *ZEROS
007200030812     C                   movel     LUEFFD        Input_Date
007300010220     C                   Exsr      EDTDAT
007400010220     C                   If        Output_Error <> *Blanks
007500010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007600010220    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
007700010220    ?C                   Exsr      SNDMSG                                       SEND MSG
007800010220     C                   Endif
007900010220     C                   Endif
008000010220    ? *
008100030722    ? * EXPIRE DATE
008101031105     C                   If        LUEXPD <> *ZEROS   and
008200031105     C                             LUEXPD <> 99999999
008300030812     C                   movel     LUEXPD        Input_Date
008400010220     C                   Exsr      EDTDAT
008500010220     C                   If        Output_Error <> *Blanks
008600010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008700010220    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
008800010220    ?C                   Exsr      SNDMSG                                       SEND MSG
008900010223     C                   Else
009000010223    ? *
009100030722    ? * EXPIRE > EFF DATE
009200030812     C                   If        LUEXPD <> *ZEROS and
009300030812     C                             LUEFFD <> *ZEROS
009400030812     C     LUEXPD        Mult      10000.0001    WWTRDT            8 0
009500030812     C     LUEFFD        Mult      10000.0001    WWEFDT            8 0
009600030716     C                   If        WWEFDT  > WWTRDT
009700030722    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009800030722    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
009900030722    ?C                   Exsr      SNDMSG                                       SEND MSG
010000010223     C                   Endif
010100010223     C                   Endif
010200010220     C                   Endif
010300010220     C                   Endif
010400000810    ? *
010500000000    ?C                   Endsr                                                  END EDIT RECORD
010600010220    ? *___________________________________________________________________
010700010220    ? * format Date edit
010800010220    ? *___________________________________________________________________
010900010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
011000010220     C                   movel     'MMDDYYYY'    Input_Format
011100010220     C                   Call      'FMTDATE'
011200010220     C                   Parm                    Input_Date       32
011300010220     C                   Parm                    Input_Format     32
011400010220     C                   Parm                    Output_Format    32
011500010220     C                   Parm                    Output_Date      32
011600010220     C                   Parm                    Output_Error     10
011700010220    ?C                   Endsr                                                  END DLT RQST
011800000000    ? *___________________________________________________________________
011900000000    ? * Edit delete request
012000000000    ? *___________________________________________________________________
012100000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
012200000000    ?C                   Endsr                                                  END DLT RQST
012300000000    ? *___________________________________________________________________
012400000000    ? * Default data
012500000000    ? *___________________________________________________________________
012600000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
012700000000    ?C                   Endsr                                                  END DFT DATA
012800000000    ? *___________________________________________________________________
012900000000    ? * Send messages
013000000000    ? *___________________________________________________________________
013100000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
013200000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
013300000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
013400000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
013500000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
013600000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
013700000000    ?C                   Endsr                                                  END SND ERRMSG
013800000000    ? *___________________________________________________________________
013900000000    ? * Process error
014000000000    ? *___________________________________________________________________
014100000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
014200000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014300000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
014400000000    ?C                   Exsr      SNDMSG                                       SEND MSG
014500000000    ?C                   Endsr                                                  END PRCERR
014600000000    ? *___________________________________________________________________
014700000000    ? * Parameter list
014800000000    ? *___________________________________________________________________
014900000000    ?C     PLIST         Begsr                                                  PARM LISTS
015000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
015100000000    ?C                   Parm                    WIRQS             8            REQUEST
015200000000    ?C                   Parm                    WORTN             8            RETURN CODE
015300000614    ?C                   Parm                    WUDTA                          DATA
015400000000    ?C                   Endsr                                                  END PLIST
015500000000    ? *___________________________________________________________________
015600000000    ? * Define Variables and Key Lists
015700000000    ? *___________________________________________________________________
015800000000    ?C     DEFN          Begsr                                                  PARM LISTS
015900000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
016000000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
016100000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
016200000000    ?C                   Endsr                                                  END DEFN
016300000000    ? *___________________________________________________________________
016400000000    ? * Program error handler
016500000000    ? *___________________________________________________________________
016600000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
016700000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
016800000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
016900000000    ?C                   Parm                    WQSTSC                         STATUS CODE
017000000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
017100000000    ?C                   Parm                    WQMSG                          MESSAGE ID
017200000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
017300000000    ? *___________________________________________________________________
017400000112** WTMP
01750000000000T-Record is not eligible for deletion.
01760003081200Request not supported by program CHKLSU.
017700000117** WTM
01780003081161Agency must be valid.
01790003071662State must be entered.
01800003071663License must be entered.
01810003072264Effective Date must be valid.
01820003072265Expire Date must be valid.
01830003072264Expire Date must be > Effective Date.
01840003072266Business Type must be (L)ife, (H)ealth, or (B)oth.
