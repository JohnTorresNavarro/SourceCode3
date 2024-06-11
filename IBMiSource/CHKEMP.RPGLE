000100000000      *_________________________________________________________________________
000200000000      *
000300111212      *  Description: EMPLOYEE AUXILIARY
000400000000      *
000500090204      *  (C)COPYRIGHT 2009 BY GROUP BENEFIT SERVICES, INC.
000600000000      *___________________________________________________________________
000700000000      *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900000000    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001000000000      *
001100000000      *___________________________________________________________________
001200000000      *
001300111212     D @TS40           S             40A
001400111212     D @TIMESTAMP      DS
001500111212     D  #TSCYMD                1      8S 0
001600111212     D  #TSTIME                9     14S 0
001700111212     D  @TSJOB                15     24
001800111212     D  @TSUSER               25     34
001900111212     D  #TSNBR                35     40S 0
002000111212     ***
002100000000      * Data structure
002200111212    ?D WUDTA         E DS                  EXTNAME(EMPAUX)
002300000000      *
002400000000      * Program status data structure
002500000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002600000000      *
002700000000      *
002800021008     D WIFKV           S             60A
002900021008     D WIFKY           S                   LIKE(WIFKV)
003000021008     D WIOPV           S                   LIKE(WIFKV)
003100021008     D WIRQS           S              8A
003200021008     D WORTN           S              8A
003300021008     D WUPGM           S             10A
003400021008     D WWCHG           S              1A
003500021008     D WWDLT           S              1A
003600021008     D WWDTAQ          S             10A
003700021008     D WWENDF          S              3A
003800021008     D WWENDO          S                   LIKE(WWENDF)
003900021008     D WWERR           S              1A
004000021008     D WWFIL           S             10A
004100021008     D WWFKA           S              8A
004200021008     D WWFKV           S                   LIKE(WIFKV)
004300021008     D WWFKY           S                   LIKE(WIFKV)
004400021008     D WWFLK           S            128A
004500021008     D WWFMTN          S              8A
004600021008     D WWFNC           S              8A
004700021008     D WWIJI           S             16A
004800021008     D WWIN            S             99A
004900021008     D WWLIB           S             10A
005000021008     D WWMSG           S             80A
005100021008     D WWMSGC          S              7A
005200021008     D WWOCD           S              8A
005300021008     D WWOPA           S              8A
005400021008     D WWOPN           S              1A
005500021008     D WWOPT           S              8A
005600021008     D WWOPV           S                   LIKE(WIFKV)
005700021008     D WWORQS          S                   LIKE(WIRQS)
005800021008     D WWPSNC          S              1A
005900021008     D WWQJN           S             26A
006000021008     D WWRQS           S                   LIKE(WIRQS)
006100021008     D WWRQSD          S                   LIKE(WIRQS)
006200021008     D WWRTN           S                   LIKE(WORTN)
006300021008     D WWRTND          S                   LIKE(WORTN)
006400021008     D WWRTNH          S                   LIKE(WORTN)
006500021008     D WWSFLE          S              1A
006600021008     D WWSTT           S              3A
006700021008     D WWTSK           S              8A
006800021008     D WWTXT           S             60A
006900021008     D WWUPD           S              1A
007000021008     D WWWRNF          S              1A
007100021008     D WWZERO          S             40A
007200021008     D WFRRN           S              4P 0
007300021008     D WW              S              3P 0
007400021008     D WWFKS           S              1P 0
007500021008     D WWFKSO          S                   LIKE(WWFKS)
007600021008     D WWLMT           S              2P 0
007700021008     D WWLNG           S             15P 5
007800021008     D WWLNGQ          S              5P 0
007900021008     D WWLOWR          S              4P 0
008000021008     D WWLSTS          S              2P 0
008100021008     D WWOPS           S              1P 0
008200021008     D WWOPSO          S                   LIKE(WWOPS)
008300021008     D WWPNL           S              1P 0
008400021008     D WWPNLN          S                   LIKE(WWPNL)
008500021008     D WWPNLO          S                   LIKE(WWPNL)
008600021008     D WWPSNI          S              2P 0
008700021008     D WWPSNN          S              1P 0
008800021008     D WWPSNP          S                   LIKE(WWPSNN)
008900021008     D WWRRN           S              4P 0
009000000000      *
009100000000      *___________________________________________________________________
009200000000      * Process check request
009300000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
009400040305     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
009500040305     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
009600000000     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
009700000000     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
009800000000     C                   Cas                     PRCERR                         REQUEST ERROR
009900000000     C                   Endcs                                                  END CASE
010000000000    ?C                   Return                                                 RETURN
010100000000      *___________________________________________________________________
010200040305      * Edit record - ADD
010300000000      *___________________________________________________________________
010400040305     C     EDTADD        Begsr                                                  EDIT RECORD
010500000000      *
010600040305     C                   EXSR      $COMMON
010700040305      *
010800040305     C                   Endsr                                                  END DLT RQST
010900040305      *___________________________________________________________________
011000040305      * Edit record - COMMON EDITS
011100040305      *___________________________________________________________________
011200040305     C     $COMMON       Begsr                                                  EDIT RECORD
011300040305      *
011400111212     C                   If        EATRST  = 0 OR EASUB# = 0 OR
011500111212     C                             EAACCT = 0
011600111212    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011700111212    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
011800111212    ?C                   Exsr      SNDMSG                                       SEND MSG
011900111212     C                   Endif
012000000000      *
012100000000     C                   Endsr                                                  END DLT RQST
012200040305      *___________________________________________________________________
012300040305      * Edit record - CHANGE
012400040305      *___________________________________________________________________
012500040305     C     EDTCHG        Begsr                                                  EDIT RECORD
012600040305      *
012700040305     C                   EXSR      $COMMON
012800040305      *
012900040305     C                   Endsr                                                  END DLT RQST
013000000000      *___________________________________________________________________
013100000000      * Edit delete request
013200000000      *___________________________________________________________________
013300000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
013400000000     C                   Endsr                                                  END DLT RQST
013500000000      *___________________________________________________________________
013600000000      * Default data
013700000000      *___________________________________________________________________
013800000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
013900111212     C                   MOVE      *BLANKS       @TS40
014000111212     C                   CALL      'TIMESTMP'
014100111212     C                   PARM                    @TS40
014200111212     C                   MOVEL     @TS40         @TIMESTAMP
014300111212     C                   EVAL      EAADBY = @TSUSER
014400111212     C                   MOVE      #TSCYMD       EAADDT
014500000000     C                   Endsr                                                  END DFT DATA
014600000000      *___________________________________________________________________
014700000000      * Send messages
014800000000      *___________________________________________________________________
014900000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
015000000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
015100000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
015200000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
015300000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
015400000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
015500000000     C                   Endsr                                                  END SND ERRMSG
015600000000      *___________________________________________________________________
015700000000      * Process error
015800000000      *___________________________________________________________________
015900000000     C     PRCERR        Begsr                                                  PROCESS ERROR
016000000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016100000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
016200000000    ?C                   Exsr      SNDMSG                                       SEND MSG
016300000000     C                   Endsr                                                  END PRCERR
016400000000      *___________________________________________________________________
016500000000      * Parameter list
016600000000      *___________________________________________________________________
016700000000     C     PLIST         Begsr                                                  PARM LISTS
016800000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
016900000000    ?C                   Parm                    WIRQS                          REQUEST
017000000000    ?C                   Parm                    WORTN                          RETURN CODE
017100000000    ?C                   Parm                    WUDTA                          DATA
017200000000     C                   Endsr                                                  END PLIST
017300000000      *___________________________________________________________________
017400000000      * Define Variables and Key Lists
017500000000      *___________________________________________________________________
017600000000     C     *INZSR        Begsr
017700000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
017800000000     C                   Endsr                                                  END DEFN
017900000000      *___________________________________________________________________
018000000000      * Program error handler
018100000000      *___________________________________________________________________
018200000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
018300000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
018400000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
018500000000    ?C                   Parm                    WQSTSC                         STATUS CODE
018600000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
018700000000    ?C                   Parm                    WQMSG                          MESSAGE ID
018800000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
018900020228      *___________________________________________________________________
019000000000** WTMP
01910000000000T-Record is not eligible for deletion.
01920011121200Request not supported by program CHKEMP.
019300000000** WTM
01940011121261ACCOUNT NUMBER ERROR.
01950000000062X
01960000000063X
