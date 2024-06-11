000100000000      *_________________________________________________________________________
000200000000      *
000300060315      *  Description: AGENCY RELATIONSHIP MANAGERS
000400000000      *
000500060310      *  (C)COPYRIGHT 2006 BY GROUP BENEFIT SERVICES, INC.
000600000000      *___________________________________________________________________
000700060315     FAGENCY    IF   E           K DISK
000800060315     FRMGRMST0  IF   E           K DISK
000900000000      *
001000000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100060315    ?D WTM             S             80    DIM(5) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001200000000      *
001300000000      *___________________________________________________________________
001400000000      *
001500000000      * Data structure
001600060315    ?D WUDTA         E DS                  EXTNAME(AGCYRMG0)
001700000000      *
001800000000      * Program status data structure
001900000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002000000000      *
002100000000      *
002200021008     D WIFKV           S             60A
002300021008     D WIFKY           S                   LIKE(WIFKV)
002400021008     D WIOPV           S                   LIKE(WIFKV)
002500021008     D WIRQS           S              8A
002600021008     D WORTN           S              8A
002700021008     D WUPGM           S             10A
002800021008     D WWCHG           S              1A
002900021008     D WWDLT           S              1A
003000021008     D WWDTAQ          S             10A
003100021008     D WWENDF          S              3A
003200021008     D WWENDO          S                   LIKE(WWENDF)
003300021008     D WWERR           S              1A
003400021008     D WWFIL           S             10A
003500021008     D WWFKA           S              8A
003600021008     D WWFKV           S                   LIKE(WIFKV)
003700021008     D WWFKY           S                   LIKE(WIFKV)
003800021008     D WWFLK           S            128A
003900021008     D WWFMTN          S              8A
004000021008     D WWFNC           S              8A
004100021008     D WWIJI           S             16A
004200021008     D WWIN            S             99A
004300021008     D WWLIB           S             10A
004400021008     D WWMSG           S             80A
004500021008     D WWMSGC          S              7A
004600021008     D WWOCD           S              8A
004700021008     D WWOPA           S              8A
004800021008     D WWOPN           S              1A
004900021008     D WWOPT           S              8A
005000021008     D WWOPV           S                   LIKE(WIFKV)
005100021008     D WWORQS          S                   LIKE(WIRQS)
005200021008     D WWPSNC          S              1A
005300021008     D WWQJN           S             26A
005400021008     D WWRQS           S                   LIKE(WIRQS)
005500021008     D WWRQSD          S                   LIKE(WIRQS)
005600021008     D WWRTN           S                   LIKE(WORTN)
005700021008     D WWRTND          S                   LIKE(WORTN)
005800021008     D WWRTNH          S                   LIKE(WORTN)
005900021008     D WWSFLE          S              1A
006000021008     D WWSTT           S              3A
006100021008     D WWTSK           S              8A
006200021008     D WWTXT           S             60A
006300021008     D WWUPD           S              1A
006400021008     D WWWRNF          S              1A
006500021008     D WWZERO          S             40A
006600021008     D WFRRN           S              4P 0
006700021008     D WW              S              3P 0
006800021008     D WWFKS           S              1P 0
006900021008     D WWFKSO          S                   LIKE(WWFKS)
007000021008     D WWLMT           S              2P 0
007100021008     D WWLNG           S             15P 5
007200021008     D WWLNGQ          S              5P 0
007300021008     D WWLOWR          S              4P 0
007400021008     D WWLSTS          S              2P 0
007500021008     D WWOPS           S              1P 0
007600021008     D WWOPSO          S                   LIKE(WWOPS)
007700021008     D WWPNL           S              1P 0
007800021008     D WWPNLN          S                   LIKE(WWPNL)
007900021008     D WWPNLO          S                   LIKE(WWPNL)
008000021008     D WWPSNI          S              2P 0
008100021008     D WWPSNN          S              1P 0
008200021008     D WWPSNP          S                   LIKE(WWPSNN)
008300021008     D WWRRN           S              4P 0
008400000000      *
008500000000      *___________________________________________________________________
008600000000      * Process check request
008700000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
008800040305     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
008900040305     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
009000000000     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
009100000000     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
009200000000     C                   Cas                     PRCERR                         REQUEST ERROR
009300000000     C                   Endcs                                                  END CASE
009400000000    ?C                   Return                                                 RETURN
009500000000      *___________________________________________________________________
009600040305      * Edit record - ADD
009700000000      *___________________________________________________________________
009800040305     C     EDTADD        Begsr                                                  EDIT RECORD
009900000000      *
010000040305     C                   EXSR      $COMMON
010100040305      *
010200040305     C                   Endsr                                                  END DLT RQST
010300040305      *___________________________________________________________________
010400040305      * Edit record - COMMON EDITS
010500040305      *___________________________________________________________________
010600040305     C     $COMMON       Begsr                                                  EDIT RECORD
010700040305      *
010800060315     C                   If        ARAGCY = *Blanks
010900060315    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011000060315    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
011100060315    ?C                   Exsr      SNDMSG                                       SEND MSG
011200060315     C                   Endif
011300060315      *
011400060315     C     ARAGCY        CHAIN     AGENR
011500060315     C                   IF        NOT %FOUND(AGENCY)
011600060315    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011700060315    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
011800060315    ?C                   Exsr      SNDMSG                                       SEND MSG
011900060315     C                   Endif
012000060315      *
012100060315     C                   If        ARSGR = *Blanks
012200060315    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012300060315    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
012400060315    ?C                   Exsr      SNDMSG                                       SEND MSG
012500060315     C                   Endif
012600060315      *
012700060315     C     ARSGR         CHAIN     RMGRMSTR
012800060315     C                   IF        NOT %FOUND(RMGRMST0)
012900060315    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013000060315    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
013100060315    ?C                   Exsr      SNDMSG                                       SEND MSG
013200060315     C                   Endif
013300060315      *
013400060315     C                   If        ARLGR   = *Blanks
013500060315    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013600060315    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
013700060315    ?C                   Exsr      SNDMSG                                       SEND MSG
013800060315     C                   Endif
013900060315      *
014000060315     C     ARLGR         CHAIN     RMGRMSTR
014100060315     C                   IF        NOT %FOUND(RMGRMST0)
014200060315    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014300060315    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
014400060315    ?C                   Exsr      SNDMSG                                       SEND MSG
014500060315     C                   Endif
014600060315      *
014700060315     C                   If        ARRMGR  = *Blanks
014800060315    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014900060315    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
015000060315    ?C                   Exsr      SNDMSG                                       SEND MSG
015100060315     C                   Endif
015200060315      *
015300060315     C     ARRMGR        CHAIN     RMGRMSTR
015400060315     C                   IF        NOT %FOUND(RMGRMST0)
015500060315    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
015600060315    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
015700060315    ?C                   Exsr      SNDMSG                                       SEND MSG
015800060315     C                   Endif
015900060315      *
016000000000     C                   Endsr                                                  END DLT RQST
016100040305      *___________________________________________________________________
016200040305      * Edit record - CHANGE
016300040305      *___________________________________________________________________
016400040305     C     EDTCHG        Begsr                                                  EDIT RECORD
016500040305      *
016600040305     C                   EXSR      $COMMON
016700040305      *
016800040305     C                   Endsr                                                  END DLT RQST
016900000000      *___________________________________________________________________
017000000000      * Edit delete request
017100000000      *___________________________________________________________________
017200000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
017300000000     C                   Endsr                                                  END DLT RQST
017400000000      *___________________________________________________________________
017500000000      * Default data
017600000000      *___________________________________________________________________
017700000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
017800060315     C                   EVAL      ARSGR = '*UA*'
017900060315     C                   EVAL      ARLGR = '*UA*'
018000060315     C                   EVAL      ARRMGR = '*UA*'
018100000000     C                   Endsr                                                  END DFT DATA
018200000000      *___________________________________________________________________
018300000000      * Send messages
018400000000      *___________________________________________________________________
018500000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
018600000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
018700000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
018800000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
018900000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
019000000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
019100000000     C                   Endsr                                                  END SND ERRMSG
019200000000      *___________________________________________________________________
019300000000      * Process error
019400000000      *___________________________________________________________________
019500000000     C     PRCERR        Begsr                                                  PROCESS ERROR
019600000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
019700000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
019800000000    ?C                   Exsr      SNDMSG                                       SEND MSG
019900000000     C                   Endsr                                                  END PRCERR
020000000000      *___________________________________________________________________
020100000000      * Parameter list
020200000000      *___________________________________________________________________
020300000000     C     PLIST         Begsr                                                  PARM LISTS
020400000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
020500000000    ?C                   Parm                    WIRQS                          REQUEST
020600000000    ?C                   Parm                    WORTN                          RETURN CODE
020700000000    ?C                   Parm                    WUDTA                          DATA
020800000000     C                   Endsr                                                  END PLIST
020900000000      *___________________________________________________________________
021000000000      * Define Variables and Key Lists
021100000000      *___________________________________________________________________
021200000000     C     *INZSR        Begsr
021300000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
021400000000     C                   Endsr                                                  END DEFN
021500000000      *___________________________________________________________________
021600000000      * Program error handler
021700000000      *___________________________________________________________________
021800000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
021900000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
022000000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
022100000000    ?C                   Parm                    WQSTSC                         STATUS CODE
022200000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
022300000000    ?C                   Parm                    WQMSG                          MESSAGE ID
022400000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
022500020228      *___________________________________________________________________
022600000000** WTMP
02270000000000T-Record is not eligible for deletion.
02280006031500Request not supported by program CHKARM.
022900000000** WTM
02300006031562
02310006031561Agency is invalid.
02320006031563Valid SGR Manager is required.
02330006031564Valid LGR/SF Manager is required.
02340006031565Valid Relationship Manager is required.
