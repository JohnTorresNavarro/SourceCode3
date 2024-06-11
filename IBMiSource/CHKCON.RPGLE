000100000000    ? *_________________________________________________________________________
000200000000    ? *
000300030717    ? *  Description:  Check Carrier Contract
000400000000    ? *
000500030716    ? *  (c)Copyright 2003 by Group Benefit Services, Inc.
000600000000    ? *___________________________________________________________________
000601040603     FHYPERCARR IF   E           K DISK
000700000000    ? *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900030717    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             ERROR MESSAGE TBL
001000000000    ? *___________________________________________________________________
001100000000    ? *
001200000614    ? * Data structure
001300030717    ?D WUDTA         E DS                  EXTNAME(BLICON)
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
003400030717     C                   If        LCRELI = *BLANKS
003500010219    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
003600010219    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
003700010219    ?C                   Exsr      SNDMSG                                       SEND MSG
003800030718     C                   Else
003900010219     C                   Endif
004000010220    ? *
004100030717    ? * CARRIER
004200030717     C                   If        LCCARR = *BLANKS
004300010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004400010220    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004500010220    ?C                   Exsr      SNDMSG                                       SEND MSG
004501040603     C                   ELSE
004502040603     C                   EVAL      HCCODE = %TRIM(LCCARR)
004503040603     C     HCCODE        CHAIN     HYPERCARR
004504040603     C                   IF        NOT %FOUND(HYPERCARR)
004505040603    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
004506040603    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
004507040603    ?C                   Exsr      SNDMSG                                       SEND MSG
004508040603     C                   Endif
004600010220     C                   Endif
004700030717    ? *
004800030717    ? * CONTRACTOR
004900030717     C                   If        LCCNTR = *BLANKS
005000030717    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005100030717    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
005200030717    ?C                   Exsr      SNDMSG                                       SEND MSG
005300030722     C                   Else
005400030722     C                   If        LCCNTR <>     '1' and
005500030722     C                             LCCNTR <>     '2' and
005600030722     C                             LCCNTR <>     '3'
005700030722    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
005800030722    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
005900030722    ?C                   Exsr      SNDMSG                                       SEND MSG
006000030722     C                   Endif
006100030717     C                   Endif
006200010220    ? *
006300030722    ? * AOC DATE
006400030722     C                   If        LCAOCR <>     *ZEROS
006500030722     C                   movel     LCAOCR        Input_Date
006600010220     C                   Exsr      EDTDAT
006700010220     C                   If        Output_Error <> *Blanks
006800010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
006900030717    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
007000010220    ?C                   Exsr      SNDMSG                                       SEND MSG
007100010220     C                   Endif
007200010220     C                   Endif
007300030722    ? *
007400030722    ? * EFFECT DATE
007500030722     C                   If        LCEFFD <>     *ZEROS
007600030722     C                   movel     LCEFFD        Input_Date
007700030722     C                   Exsr      EDTDAT
007800030722     C                   If        Output_Error <> *Blanks
007900030722    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
008000030722    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
008100030722    ?C                   Exsr      SNDMSG                                       SEND MSG
008200030722     C                   Endif
008300030722     C                   Endif
008400010220    ? *
008500010220    ? * TERM DATE
008501031105     C                   If        LCEXPD <> *ZEROS  and
008600031105     C                             LCEXPD <> 99999999
008700030722     C                   movel     LCEXPD        Input_Date
008800010220     C                   Exsr      EDTDAT
008900010220     C                   If        Output_Error <> *Blanks
009000010220    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
009100030722    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
009200010220    ?C                   Exsr      SNDMSG                                       SEND MSG
009300030722     C                   Endif
009400030722     C                   Endif
009500030717    ? *
009600030717    ? * TERM DATE > EFF DATE
009700030722     C                   If        LCEXPD <> *ZEROS and
009800030722     C                             LCEFFD <> *ZEROS
009900030722     C     LCEXPD        Mult      10000.0001    WWTRDT            8 0
010000030722     C     LCEFFD        Mult      10000.0001    WWEFDT            8 0
010100030717     C                   If        WWEFDT  > WWTRDT
010200030717    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010300030722    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
010400030717    ?C                   Exsr      SNDMSG                                       SEND MSG
010500030717     C                   Endif
010600030717     C                   Endif
010700000000    ?C                   Endsr                                                  END EDIT RECORD
010800010220    ? *___________________________________________________________________
010900010220    ? * format Date edit
011000010220    ? *___________________________________________________________________
011100010220    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
011200010220     C                   movel     'MMDDYYYY'    Input_Format
011300010220     C                   Call      'FMTDATE'
011400010220     C                   Parm                    Input_Date       32
011500010220     C                   Parm                    Input_Format     32
011600010220     C                   Parm                    Output_Format    32
011700010220     C                   Parm                    Output_Date      32
011800010220     C                   Parm                    Output_Error     10
011900010220    ?C                   Endsr                                                  END DLT RQST
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
014500000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
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
01780003071700Request not supported by program CHKCON.
017900000117** WTM
01800003071661Relationship ID must be valid.
01810004060362Hyper Carrier must be entered and or a valid hyper carrier.
01820003072263Contractor must be entered. (1=Salesman,2=Agency.3=Super)
01830003072264Assignment of Commissions Received Date must be valid.
01840003072265Effective Date must be valid.
01850003072266Term Date must be valid.
01860003072265Effective Date cannot be great than Term Date.
