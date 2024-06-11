000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300010219    ? *  Description:  Check Internal Sales Commission Salesman
000400000000    ? *
000500010219    ? *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600030219    ? *
000700030219    ? *  Revised by:   SZZ  February 17, 2003
000800030219    ? *                Add fields for new rate structure.
000900000000    ? *___________________________________________________________________
001000000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100030317    ?D WTM             S             80    DIM(18) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001200000000    ? *___________________________________________________________________
001300000000    ? *
001400000614    ? * Data structure
001500010219    ?D WUDTA         E DS                  EXTNAME(ISCSMN)
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
003600010219    ? * SALESMAN CODE
003700010219     C                   If        ISSMAN = *BLANKS
003800010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003900010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
004000010219    ?C                   Exsr      SNDMSG                                       SEND MSG
004100010219     C                   Endif
004200010219    ? * LAST NAME
004300010219     C                   If        ISLNAM = *BLANKS
004400010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004500010219    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004600010219    ?C                   Exsr      SNDMSG                                       SEND MSG
004700010219     C                   Endif
004800010219    ? * FIRST NAME
004900010219     C                   If        ISFNAM = *BLANKS
005000010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005100010219    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
005200010219    ?C                   Exsr      SNDMSG                                       SEND MSG
005300010219     C                   Endif
005400010219    ? * ADDRESS
005500010219     C                   If        ISADDR = *BLANKS
005600010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005700010219    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
005800010219    ?C                   Exsr      SNDMSG                                       SEND MSG
005900010219     C                   Endif
006000010219    ? * CITY
006100010219     C                   If        ISCITY = *BLANKS
006200010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006300010219    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
006400010219    ?C                   Exsr      SNDMSG                                       SEND MSG
006500010219     C                   Endif
006600010219    ? * STATE
006700010219     C                   If        ISSTAT = *BLANKS
006800010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006900010219    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
007000010219    ?C                   Exsr      SNDMSG                                       SEND MSG
007100010219     C                   Endif
007200010219    ? * ZIP
007300010219     C                   If        ISZIP  = *ZEROS
007400010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
007500010219    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
007600010219    ?C                   Exsr      SNDMSG                                       SEND MSG
007700010219     C                   Endif
007800020220    ? *
007900000000    ?C                   Endsr                                                  END EDIT RECORD
008000000000    ? *___________________________________________________________________
008100000000    ? * Edit delete request
008200000000    ? *___________________________________________________________________
008300000000    ?C     EDTDLT        Begsr                                                  EDIT DELETE RQS
008400000000    ?C                   Endsr                                                  END DLT RQST
008500000000    ? *___________________________________________________________________
008600000000    ? * Default data
008700000000    ? *___________________________________________________________________
008800000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
008900000000    ?C                   Endsr                                                  END DFT DATA
009000020220    ? *___________________________________________________________________
009100020220    ? * format Date edit
009200020220    ? *___________________________________________________________________
009300020220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
009400020220     C                   movel     'MMDDYYYY'    Input_Format
009500020220     C                   Call      'FMTDATE'
009600020220     C                   Parm                    Input_Date       32
009700020220     C                   Parm                    Input_Format     32
009800020220     C                   Parm                    Output_Format    32
009900020220     C                   Parm                    Output_Date      32
010000020220     C                   Parm                    Output_Error     10
010100020220    ?C                   Endsr                                                  END DLT RQST
010200000000    ? *___________________________________________________________________
010300000000    ? * Send messages
010400000000    ? *___________________________________________________________________
010500000000    ?C     SNDMSG        Begsr                                                  SEND ERROR MSG
010600000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
010700000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ           10            DATA Q NAME
010800000000    ?C                   Parm      'QTEMP'       WWLIB            10            DATA Q LIB
010900000000    ?C                   Parm      80            WWLNGQ            5 0          MESSAGE LENGTH
011000000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
011100000000    ?C                   Endsr                                                  END SND ERRMSG
011200000000    ? *___________________________________________________________________
011300000000    ? * Process error
011400000000    ? *___________________________________________________________________
011500000000    ?C     PRCERR        Begsr                                                  PROCESS ERROR
011600000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011700000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
011800000000    ?C                   Exsr      SNDMSG                                       SEND MSG
011900000000    ?C                   Endsr                                                  END PRCERR
012000000000    ? *___________________________________________________________________
012100000000    ? * Parameter list
012200000000    ? *___________________________________________________________________
012300000000    ?C     PLIST         Begsr                                                  PARM LISTS
012400000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
012500000000    ?C                   Parm                    WIRQS             8            REQUEST
012600000000    ?C                   Parm                    WORTN             8            RETURN CODE
012700000614    ?C                   Parm                    WUDTA                          DATA
012800000000    ?C                   Endsr                                                  END PLIST
012900000000    ? *___________________________________________________________________
013000000000    ? * Define Variables and Key Lists
013100000000    ? *___________________________________________________________________
013200000000    ?C     DEFN          Begsr                                                  PARM LISTS
013300000000    ?C     *LIKE         Define    WIRQS         WWRQS                          REQUEST
013400000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
013500000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
013600000000    ?C                   Endsr                                                  END DEFN
013700000000    ? *___________________________________________________________________
013800000000    ? * Program error handler
013900000000    ? *___________________________________________________________________
014000000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
014100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
014200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
014300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
014400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
014500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
014600000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
014700000000    ? *___________________________________________________________________
014800000112** WTMP
01490000000000T-Record is not eligible for deletion.
01500001021900Request not supported by program CHKSMN.
015100000117** WTM
01520001021961Salesman Code must be entered.
01530001021962Salesman last name must be entered.
01540001021963Salesman first name must be entered.
01550001021964Address must be entered.
01560001021965City must be entered.
01570001021966State must be entered.
01580001021967Zip Code must be entered.
