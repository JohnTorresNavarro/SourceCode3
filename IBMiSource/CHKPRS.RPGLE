000100000000      *_________________________________________________________________________
000200000000      *
000300060124      *  Description: PERSISTENCY START COUNTS
000400000000      *
000500060125      *  (C)COPYRIGHT 2006 BY GROUP BENEFIT SERVICES, INC.
000600000000      *___________________________________________________________________
000700060201      *
000800060201     FSUPRAGCY  IF   E           K DISK
000900060201     FAGENCY    IF   E           K DISK
001000060201     FSMAN      IF   E           K DISK
001100000000      *
001200000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300060201    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001400000000      *
001500000000      *___________________________________________________________________
001600000000      *
001700000000      * Data structure
001800061113    ?D WUDTA         E DS                  EXTNAME(XXEOYCC)
001900000000      *
002000000000      * Program status data structure
002100000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002200000000      *
002300000000      *
002400021008     D WIFKV           S             60A
002500021008     D WIFKY           S                   LIKE(WIFKV)
002600021008     D WIOPV           S                   LIKE(WIFKV)
002700021008     D WIRQS           S              8A
002800021008     D WORTN           S              8A
002900021008     D WUPGM           S             10A
003000021008     D WWCHG           S              1A
003100021008     D WWDLT           S              1A
003200021008     D WWDTAQ          S             10A
003300021008     D WWENDF          S              3A
003400021008     D WWENDO          S                   LIKE(WWENDF)
003500021008     D WWERR           S              1A
003600021008     D WWFIL           S             10A
003700021008     D WWFKA           S              8A
003800021008     D WWFKV           S                   LIKE(WIFKV)
003900021008     D WWFKY           S                   LIKE(WIFKV)
004000021008     D WWFLK           S            128A
004100021008     D WWFMTN          S              8A
004200021008     D WWFNC           S              8A
004300021008     D WWIJI           S             16A
004400021008     D WWIN            S             99A
004500021008     D WWLIB           S             10A
004600021008     D WWMSG           S             80A
004700021008     D WWMSGC          S              7A
004800021008     D WWOCD           S              8A
004900021008     D WWOPA           S              8A
005000021008     D WWOPN           S              1A
005100021008     D WWOPT           S              8A
005200021008     D WWOPV           S                   LIKE(WIFKV)
005300021008     D WWORQS          S                   LIKE(WIRQS)
005400021008     D WWPSNC          S              1A
005500021008     D WWQJN           S             26A
005600021008     D WWRQS           S                   LIKE(WIRQS)
005700021008     D WWRQSD          S                   LIKE(WIRQS)
005800021008     D WWRTN           S                   LIKE(WORTN)
005900021008     D WWRTND          S                   LIKE(WORTN)
006000021008     D WWRTNH          S                   LIKE(WORTN)
006100021008     D WWSFLE          S              1A
006200021008     D WWSTT           S              3A
006300021008     D WWTSK           S              8A
006400021008     D WWTXT           S             60A
006500021008     D WWUPD           S              1A
006600021008     D WWWRNF          S              1A
006700021008     D WWZERO          S             40A
006800021008     D WFRRN           S              4P 0
006900021008     D WW              S              3P 0
007000021008     D WWFKS           S              1P 0
007100021008     D WWFKSO          S                   LIKE(WWFKS)
007200021008     D WWLMT           S              2P 0
007300021008     D WWLNG           S             15P 5
007400021008     D WWLNGQ          S              5P 0
007500021008     D WWLOWR          S              4P 0
007600021008     D WWLSTS          S              2P 0
007700021008     D WWOPS           S              1P 0
007800021008     D WWOPSO          S                   LIKE(WWOPS)
007900021008     D WWPNL           S              1P 0
008000021008     D WWPNLN          S                   LIKE(WWPNL)
008100021008     D WWPNLO          S                   LIKE(WWPNL)
008200021008     D WWPSNI          S              2P 0
008300021008     D WWPSNN          S              1P 0
008400021008     D WWPSNP          S                   LIKE(WWPSNN)
008500021008     D WWRRN           S              4P 0
008600000000      *
008700000000      *___________________________________________________________________
008800000000      * Process check request
008900000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
009000040305     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
009100040305     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
009200000000     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
009300000000     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
009400000000     C                   Cas                     PRCERR                         REQUEST ERROR
009500000000     C                   Endcs                                                  END CASE
009600000000    ?C                   Return                                                 RETURN
009700000000      *___________________________________________________________________
009800040305      * Edit record - ADD
009900000000      *___________________________________________________________________
010000040305     C     EDTADD        Begsr                                                  EDIT RECORD
010100000000      *
010200060201     C                   If        CYEFF = 0
010300000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010400000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
010500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
010600000000     C                   Endif
010700060201      *
010800060201     c                   test(de)                cyeff
010900060201     c                   if        %error
011000060201    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011100060201    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
011200060201    ?C                   Exsr      SNDMSG                                       SEND MSG
011300060201     C                   Endif
011400060201      *
011500060201     c                   move      cyeff         @8                8
011600060201     c                   if        %subst(@8:5:4) <> '1231'
011700060201    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011800060201    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
011900060201    ?C                   Exsr      SNDMSG                                       SEND MSG
012000060201     C                   Endif
012100040305      *
012200060201     C                   If        cysa = *blanks
012300060201    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012400060201    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
012500060201    ?C                   Exsr      SNDMSG                                       SEND MSG
012600060201     C                   Endif
012700060201      *
012800060201     C     CYSA          CHAIN     SAF
012900060201     c                   if        NOT %FOUND(SUPRAGCY)
013000060201    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013100060201    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
013200060201    ?C                   Exsr      SNDMSG                                       SEND MSG
013300060201     C                   Endif
013400060201      *
013500060201     C                   If        cyag = *blanks
013600060201    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013700060201    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
013800060201    ?C                   Exsr      SNDMSG                                       SEND MSG
013900060201     C                   Endif
014000060201      *
014100060201     C     CYAG          CHAIN     AGENR
014200060201     c                   if        NOT %FOUND(AGENCY)
014300060201    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014400060201    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
014500060201    ?C                   Exsr      SNDMSG                                       SEND MSG
014600060201     C                   Endif
014700060201      *
014800060201     C                   If        cysm = *blanks
014900060201    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
015000060201    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
015100060201    ?C                   Exsr      SNDMSG                                       SEND MSG
015200060201     C                   Endif
015300060201      *
015400060201     C     CYSM          CHAIN     SMANR
015500060201     c                   if        NOT %FOUND(SMAN)
015600060201    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
015700060201    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
015800060201    ?C                   Exsr      SNDMSG                                       SEND MSG
015900060201     C                   Endif
016000060201      *
016100060201     C                   EXSR      $COMMON
016200040305      *
016300040305     C                   Endsr                                                  END DLT RQST
016400040305      *___________________________________________________________________
016500040305      * Edit record - COMMON EDITS
016600040305      *___________________________________________________________________
016700060201     C     $COMMON       Begsr                                                  EDIT RECORD
016800040305      *
016900000000      *
017000060201     C                   Endsr                                                  END DLT RQST
017100040305      *___________________________________________________________________
017200040305      * Edit record - CHANGE
017300040305      *___________________________________________________________________
017400040305     C     EDTCHG        Begsr                                                  EDIT RECORD
017500040305      *
017600040305     C                   EXSR      $COMMON
017700040305      *
017800040305     C                   Endsr                                                  END DLT RQST
017900000000      *___________________________________________________________________
018000000000      * Edit delete request
018100000000      *___________________________________________________________________
018200000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
018300000000     C                   Endsr                                                  END DLT RQST
018400000000      *___________________________________________________________________
018500000000      * Default data
018600000000      *___________________________________________________________________
018700000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
018800000000     C                   Endsr                                                  END DFT DATA
018900000000      *___________________________________________________________________
019000000000      * Send messages
019100000000      *___________________________________________________________________
019200000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
019300000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
019400000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
019500000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
019600000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
019700000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
019800000000     C                   Endsr                                                  END SND ERRMSG
019900000000      *___________________________________________________________________
020000000000      * Process error
020100000000      *___________________________________________________________________
020200000000     C     PRCERR        Begsr                                                  PROCESS ERROR
020300000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
020400000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
020500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
020600000000     C                   Endsr                                                  END PRCERR
020700000000      *___________________________________________________________________
020800000000      * Parameter list
020900000000      *___________________________________________________________________
021000000000     C     PLIST         Begsr                                                  PARM LISTS
021100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
021200000000    ?C                   Parm                    WIRQS                          REQUEST
021300000000    ?C                   Parm                    WORTN                          RETURN CODE
021400000000    ?C                   Parm                    WUDTA                          DATA
021500000000     C                   Endsr                                                  END PLIST
021600000000      *___________________________________________________________________
021700000000      * Define Variables and Key Lists
021800000000      *___________________________________________________________________
021900000000     C     *INZSR        Begsr
022000000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
022100000000     C                   Endsr                                                  END DEFN
022200000000      *___________________________________________________________________
022300000000      * Program error handler
022400000000      *___________________________________________________________________
022500000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
022600000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
022700000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
022800000000    ?C                   Parm                    WQSTSC                         STATUS CODE
022900000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
023000000000    ?C                   Parm                    WQMSG                          MESSAGE ID
023100000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
023200020228      *___________________________________________________________________
023300000000** WTMP
02340000000000T-Record is not eligible for deletion.
02350006012500Request not supported by program CHKPRS.
023600000000** WTM
02370006020161Invalid date, 1231YYYY is the required format.
02380006020162Super Agency must be valid value.
02390006020163Agency must be valid value.
02400006020164Salesman Code must be valie value.
