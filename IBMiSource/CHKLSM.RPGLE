000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300030716    ? *  Description:  Check  Broker Carrier Licensing file
000400000000    ? *
000500030716    ? *  (c)Copyright 2003 by Group Benefit Services, Inc.
000600000000    ? *___________________________________________________________________
000700040203    ?FSMAN      IF   E           K DISK
000800040203    ?FBLILMANL1 IF   E           K DISK
000900030825    ?FSTATECD   IF   E           K DISK
001000000000    ? *
001100000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001200141106    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001300000000    ? *___________________________________________________________________
001400000000    ? *
001500000614    ? * Data structure
001600030811    ?D WUDTA         E DS                  EXTNAME(BLILSM)
001700000810    ? *
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
003300000810    ? *
003400000810    ? * Defualt Data
003500000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
003600010219    ? *
003700030811    ? * SALESMAN
003800030811     C                   If        LSSMAN = *BLANKS
003900010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004000010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004100010219    ?C                   Exsr      SNDMSG                                       SEND MSG
004200030811     C                   Else
004300030811     C     LSSMAN        Chain     SMAN
004400030811     C                   IF        not %Found
004500040203     C     LSSMAN        Chain     BLILMANL1
004600040203     C                   IF        not %Found
004700030811    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004800030811    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004900030811    ?C                   Exsr      SNDMSG                                       SEND MSG
005000040203     C                   Endif
005100030811     C                   Endif
005200010219     C                   Endif
005300010220    ? *
005400030716    ? * STATE
005500030825     C     LSSTAT        CHAIN     STATECD
005600030825     C                   If        not %Found
005700010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005800010220    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
005900010220    ?C                   Exsr      SNDMSG                                       SEND MSG
006000010220     C                   Endif
006100030716    ? *
006200030716    ? * LICENSE
006300030811     C                   If        LSLICN = *BLANKS
006400030716    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006500030716    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
006600030716    ?C                   Exsr      SNDMSG                                       SEND MSG
006700030716     C                   Endif
006800030722    ? *
006900030722    ? * BUSINESS TYPE
007000030811     C                   If        LSTYPE = *BLANKS
007100030722    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007200030722    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
007300030722    ?C                   Exsr      SNDMSG                                       SEND MSG
007400030722     C                   Else
007500030811     C                   If        LSTYPE <> 'L' and
007600030811     C                             LSTYPE <> 'H' and
007700030811     C                             LSTYPE <> 'B'
007800030722    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007900030722    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
008000030722    ?C                   Exsr      SNDMSG                                       SEND MSG
008100030722     C                   Endif
008200030722     C                   Endif
008300141106    ? *
008400141106    ? * SHOP
008500141106     C                   If        LSSHOP <> ' ' and
008600141106     C                             LSSHOP <> 'Y' and
008700141106     C                             LSSHOP <> 'N'
008800141106    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008900141106    ?C                   Move      WTM(8)        WWMSG                          PASS MSG
009000141106    ?C                   Exsr      SNDMSG                                       SEND MSG
009100141106     C                   Endif
009200010220    ? *
009300030722    ? * EFFECTIVE DATE
009400030811     C                   If        LSEFFD <>     *ZEROS
009500030811     C                   movel     LSEFFD        Input_Date
009600010220     C                   Exsr      EDTDAT
009700010220     C                   If        Output_Error <> *Blanks
009800010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009900010220    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
010000010220    ?C                   Exsr      SNDMSG                                       SEND MSG
010100010220     C                   Endif
010200010220     C                   Endif
010300010220    ? *
010400030722    ? * EXPIRE DATE
010500031105     C                   If        LSEXPD <> *ZEROS  and
010600031105     C                             LSEXPD <> 99999999
010700030811     C                   movel     LSEXPD        Input_Date
010800010220     C                   Exsr      EDTDAT
010900010220     C                   If        Output_Error <> *Blanks
011000010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011100010220    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
011200010220    ?C                   Exsr      SNDMSG                                       SEND MSG
011300010223     C                   Else
011400010223    ? *
011500030722    ? * EXPIRE > EFF DATE
011600030811     C                   If        LSEXPD <> *ZEROS and
011700030811     C                             LSEFFD <> *ZEROS
011800030811     C     LSEXPD        Mult      10000.0001    WWTRDT            8 0
011900030811     C     LSEFFD        Mult      10000.0001    WWEFDT            8 0
012000030716     C                   If        WWEFDT  > WWTRDT
012100030722    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012200030722    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
012300030722    ?C                   Exsr      SNDMSG                                       SEND MSG
012400010223     C                   Endif
012500010223     C                   Endif
012600010220     C                   Endif
012700010220     C                   Endif
012800000810    ? *
012900000000    ?C                   Endsr                                                  END EDIT RECORD
013000010220    ? *___________________________________________________________________
013100010220    ? * format Date edit
013200010220    ? *___________________________________________________________________
013300010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
013400010220     C                   movel     'MMDDYYYY'    Input_Format
013500010220     C                   Call      'FMTDATE'
013600010220     C                   Parm                    Input_Date       32
013700010220     C                   Parm                    Input_Format     32
013800010220     C                   Parm                    Output_Format    32
013900010220     C                   Parm                    Output_Date      32
014000010220     C                   Parm                    Output_Error     10
014100010220    ?C                   Endsr                                                  END DLT RQST
014200000000    ? *___________________________________________________________________
014300000000    ? * Edit delete request
014400000000    ? *___________________________________________________________________
014500000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
014600000000    ?C                   Endsr                                                  END DLT RQST
014700000000    ? *___________________________________________________________________
014800000000    ? * Default data
014900000000    ? *___________________________________________________________________
015000000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
015100000000    ?C                   Endsr                                                  END DFT DATA
015200000000    ? *___________________________________________________________________
015300000000    ? * Send messages
015400000000    ? *___________________________________________________________________
015500000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
015600000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
015700000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
015800000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
015900000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
016000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
016100000000    ?C                   Endsr                                                  END SND ERRMSG
016200000000    ? *___________________________________________________________________
016300000000    ? * Process error
016400000000    ? *___________________________________________________________________
016500000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
016600000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016700000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
016800000000    ?C                   Exsr      SNDMSG                                       SEND MSG
016900000000    ?C                   Endsr                                                  END PRCERR
017000000000    ? *___________________________________________________________________
017100000000    ? * Parameter list
017200000000    ? *___________________________________________________________________
017300000000    ?C     PLIST         Begsr                                                  PARM LISTS
017400000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
017500000000    ?C                   Parm                    WIRQS             8            REQUEST
017600000000    ?C                   Parm                    WORTN             8            RETURN CODE
017700000614    ?C                   Parm                    WUDTA                          DATA
017800000000    ?C                   Endsr                                                  END PLIST
017900000000    ? *___________________________________________________________________
018000000000    ? * Define Variables and Key Lists
018100000000    ? *___________________________________________________________________
018200000000    ?C     DEFN          Begsr                                                  PARM LISTS
018300000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
018400000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
018500000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
018600000000    ?C                   Endsr                                                  END DEFN
018700000000    ? *___________________________________________________________________
018800000000    ? * Program error handler
018900000000    ? *___________________________________________________________________
019000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
019100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
019200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
019300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
019400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
019500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
019600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
019700000000    ? *___________________________________________________________________
019800000112** WTMP
01990000000000T-Record is not eligible for deletion.
02000003081100Request not supported by program CHKLSM.
020100000117** WTM
02020003081161Salesman must be valid.
02030003071662State must be entered.
02040003071663License must be entered.
02050003072264Effective Date must be valid.
02060003072265Expire Date must be valid.
02070003072264Expire Date must be > Effective Date.
02080003072266Business Type must be (L)ife, (H)ealth, or (B)oth.
02090014110667SHOP must be (Y)Yes, (N)No, or blank.
