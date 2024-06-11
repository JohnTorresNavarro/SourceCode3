000100101101      *_________________________________________________________________________
000200101101      *
000300101101      *  Description: GAS RENEWAL
000400101101      *
000500101101      *  (C)COPYRIGHT 2010 BY GROUP BENEFIT SERVICES, INC.
000600101101      *___________________________________________________________________
000700101101      *
000800101101     FCARMSTP   IF   E           K DISK
000900101101      *
001000101101    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100101101    ?D WTM             S             80    DIM(2) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001200101101      *
001300101101      *___________________________________________________________________
001400101101      *
001500101101      * Data structure
001600101101    ?D WUDTA         E DS                  EXTNAME(RNW01GRW)
001700101101      *
001800101101      * Program status data structure
001900101101    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002000101101      *
002100101101      *
002200101101     D WIFKV           S             60A
002300101101     D WIFKY           S                   LIKE(WIFKV)
002400101101     D WIOPV           S                   LIKE(WIFKV)
002500101101     D WIRQS           S              8A
002600101101     D WORTN           S              8A
002700101101     D WUPGM           S             10A
002800101101     D WWCHG           S              1A
002900101101     D WWDLT           S              1A
003000101101     D WWDTAQ          S             10A
003100101101     D WWENDF          S              3A
003200101101     D WWENDO          S                   LIKE(WWENDF)
003300101101     D WWERR           S              1A
003400101101     D WWFIL           S             10A
003500101101     D WWFKA           S              8A
003600101101     D WWFKV           S                   LIKE(WIFKV)
003700101101     D WWFKY           S                   LIKE(WIFKV)
003800101101     D WWFLK           S            128A
003900101101     D WWFMTN          S              8A
004000101101     D WWFNC           S              8A
004100101101     D WWIJI           S             16A
004200101101     D WWIN            S             99A
004300101101     D WWLIB           S             10A
004400101101     D WWMSG           S             80A
004500101101     D WWMSGC          S              7A
004600101101     D WWOCD           S              8A
004700101101     D WWOPA           S              8A
004800101101     D WWOPN           S              1A
004900101101     D WWOPT           S              8A
005000101101     D WWOPV           S                   LIKE(WIFKV)
005100101101     D WWORQS          S                   LIKE(WIRQS)
005200101101     D WWPSNC          S              1A
005300101101     D WWQJN           S             26A
005400101101     D WWRQS           S                   LIKE(WIRQS)
005500101101     D WWRQSD          S                   LIKE(WIRQS)
005600101101     D WWRTN           S                   LIKE(WORTN)
005700101101     D WWRTND          S                   LIKE(WORTN)
005800101101     D WWRTNH          S                   LIKE(WORTN)
005900101101     D WWSFLE          S              1A
006000101101     D WWSTT           S              3A
006100101101     D WWTSK           S              8A
006200101101     D WWTXT           S             60A
006300101101     D WWUPD           S              1A
006400101101     D WWWRNF          S              1A
006500101101     D WWZERO          S             40A
006600101101     D WFRRN           S              4P 0
006700101101     D WW              S              3P 0
006800101101     D WWFKS           S              1P 0
006900101101     D WWFKSO          S                   LIKE(WWFKS)
007000101101     D WWLMT           S              2P 0
007100101101     D WWLNG           S             15P 5
007200101101     D WWLNGQ          S              5P 0
007300101101     D WWLOWR          S              4P 0
007400101101     D WWLSTS          S              2P 0
007500101101     D WWOPS           S              1P 0
007600101101     D WWOPSO          S                   LIKE(WWOPS)
007700101101     D WWPNL           S              1P 0
007800101101     D WWPNLN          S                   LIKE(WWPNL)
007900101101     D WWPNLO          S                   LIKE(WWPNL)
008000101101     D WWPSNI          S              2P 0
008100101101     D WWPSNN          S              1P 0
008200101101     D WWPSNP          S                   LIKE(WWPSNN)
008300101101     D WWRRN           S              4P 0
008400101101      *
008500101101      *___________________________________________________________________
008600101101      * Process check request
008700101101    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
008800101101     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
008900101101     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
009000101101     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
009100101101     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
009200101101     C                   Cas                     PRCERR                         REQUEST ERROR
009300101101     C                   Endcs                                                  END CASE
009400101101    ?C                   Return                                                 RETURN
009500101101      *___________________________________________________________________
009600101101      * Edit record - ADD
009700101101      *___________________________________________________________________
009800101101     C     EDTADD        Begsr                                                  EDIT RECORD
009900101101      *
010000101101      *
010100101101     C                   EXSR      $COMMON
010200101101      *
010300101101     C                   Endsr                                                  END DLT RQST
010400101101      *___________________________________________________________________
010500101101      * Edit record - COMMON EDITS
010600101101      *___________________________________________________________________
010700101101     C     $COMMON       Begsr                                                  EDIT RECORD
010800101101      *
010900101101     C                   If        RGCAID  = *Blanks
011000101101    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011100101101    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
011200101101    ?C                   Exsr      SNDMSG                                       SEND MSG
011300101101     C                   Endif
011400101101      *
011500101101     C                   If        RGRENEW <> 'Y' AND
011600101101     C                             RGRENEW <> 'N'
011700101101    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011800101101    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
011900101101    ?C                   Exsr      SNDMSG                                       SEND MSG
012000101101     C                   Endif
012100101101      *
012200101101     C     RGCAID        CHAIN     CARMSTR
012300101101     C                   If        NOT %FOUND(CARMSTP)
012400101101    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012500101101    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
012600101101    ?C                   Exsr      SNDMSG                                       SEND MSG
012700101101     C                   Endif
012800101101      *
012900101101     C                   Endsr                                                  END DLT RQST
013000101101      *___________________________________________________________________
013100101101      * Edit record - CHANGE
013200101101      *___________________________________________________________________
013300101101     C     EDTCHG        Begsr                                                  EDIT RECORD
013400101101      *
013500101101      *
013600101101     C                   EXSR      $COMMON
013700101101      *
013800101101     C                   Endsr                                                  END DLT RQST
013900101101      *___________________________________________________________________
014000101101      * Edit delete request
014100101101      *___________________________________________________________________
014200101101     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
014300101101     C                   Endsr                                                  END DLT RQST
014400101101      *___________________________________________________________________
014500101101      * Default data
014600101101      *___________________________________________________________________
014700101101     C     DFTDTA        Begsr                                                  DEFAULT DATA
014800101101     C                   EVAL      RGRENEW = 'N'
014900101101     C                   Endsr                                                  END DFT DATA
015000101101      *___________________________________________________________________
015100101101      * Send messages
015200101101      *___________________________________________________________________
015300101101     C     SNDMSG        Begsr                                                  SEND ERROR MSG
015400101101    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
015500101101    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
015600101101    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
015700101101    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
015800101101    ?C                   Parm                    WWMSG                          ERROR MESSAGE
015900101101     C                   Endsr                                                  END SND ERRMSG
016000101101      *___________________________________________________________________
016100101101      * Process error
016200101101      *___________________________________________________________________
016300101101     C     PRCERR        Begsr                                                  PROCESS ERROR
016400101101    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016500101101    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
016600101101    ?C                   Exsr      SNDMSG                                       SEND MSG
016700101101     C                   Endsr                                                  END PRCERR
016800101101      *___________________________________________________________________
016900101101      * Parameter list
017000101101      *___________________________________________________________________
017100101101     C     PLIST         Begsr                                                  PARM LISTS
017200101101    ?C     *ENTRY        Plist                                                  *ENTRY LIST
017300101101    ?C                   Parm                    WIRQS                          REQUEST
017400101101    ?C                   Parm                    WORTN                          RETURN CODE
017500101101    ?C                   Parm                    WUDTA                          DATA
017600101101     C                   Endsr                                                  END PLIST
017700101101      *___________________________________________________________________
017800101101      * Define Variables and Key Lists
017900101101      *___________________________________________________________________
018000101101     C     *INZSR        Begsr
018100101101    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
018200101101     C                   Endsr                                                  END DEFN
018300101101      *___________________________________________________________________
018400101101      * Program error handler
018500101101      *___________________________________________________________________
018600101101     C     *PSSR         Begsr                                                  PROGRAM ERROR
018700101101    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
018800101101    ?C                   Parm                    WQPGMN                         PROGRAM NAME
018900101101    ?C                   Parm                    WQSTSC                         STATUS CODE
019000101101    ?C                   Parm                    WQRPGS                         RPG STATEMENT
019100101101    ?C                   Parm                    WQMSG                          MESSAGE ID
019200101101     C                   Endsr     '*CANCL'                                     END PGM ERROR
019300101101      *___________________________________________________________________
019400101101** WTMP
01950010110100T-Record is not eligible for deletion.
01960010110100Request not supported by program CHKGRW.
019700101101** WTM
01980010110161INVALID CARRIER CODE
01990010110162INVALID RENEWAL FLAG
