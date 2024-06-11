000100051216      *_________________________________________________________________________
000200051216      *
000300051216      *  Description: PROVIDERS FOR MBR/GRP
000400051216      *
000500051216      *  (C)COPYRIGHT 2006 BY GROUP BENEFIT SERVICES, INC.
000600051216      *___________________________________________________________________
000700051216      *
000800051216    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900051216    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001000051216      *
001100051216      *___________________________________________________________________
001200051216      *
001300051216      * Data structure
001400051216    ?D WUDTA         E DS                  EXTNAME(DBEDOC)
001500051216      *
001600051216      * Program status data structure
001700051216    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001800051216      *
001900051216      *
002000051216     D WIFKV           S             60A
002100051216     D WIFKY           S                   LIKE(WIFKV)
002200051216     D WIOPV           S                   LIKE(WIFKV)
002300051216     D WIRQS           S              8A
002400051216     D WORTN           S              8A
002500051216     D WUPGM           S             10A
002600051216     D WWCHG           S              1A
002700051216     D WWDLT           S              1A
002800051216     D WWDTAQ          S             10A
002900051216     D WWENDF          S              3A
003000051216     D WWENDO          S                   LIKE(WWENDF)
003100051216     D WWERR           S              1A
003200051216     D WWFIL           S             10A
003300051216     D WWFKA           S              8A
003400051216     D WWFKV           S                   LIKE(WIFKV)
003500051216     D WWFKY           S                   LIKE(WIFKV)
003600051216     D WWFLK           S            128A
003700051216     D WWFMTN          S              8A
003800051216     D WWFNC           S              8A
003900051216     D WWIJI           S             16A
004000051216     D WWIN            S             99A
004100051216     D WWLIB           S             10A
004200051216     D WWMSG           S             80A
004300051216     D WWMSGC          S              7A
004400051216     D WWOCD           S              8A
004500051216     D WWOPA           S              8A
004600051216     D WWOPN           S              1A
004700051216     D WWOPT           S              8A
004800051216     D WWOPV           S                   LIKE(WIFKV)
004900051216     D WWORQS          S                   LIKE(WIRQS)
005000051216     D WWPSNC          S              1A
005100051216     D WWQJN           S             26A
005200051216     D WWRQS           S                   LIKE(WIRQS)
005300051216     D WWRQSD          S                   LIKE(WIRQS)
005400051216     D WWRTN           S                   LIKE(WORTN)
005500051216     D WWRTND          S                   LIKE(WORTN)
005600051216     D WWRTNH          S                   LIKE(WORTN)
005700051216     D WWSFLE          S              1A
005800051216     D WWSTT           S              3A
005900051216     D WWTSK           S              8A
006000051216     D WWTXT           S             60A
006100051216     D WWUPD           S              1A
006200051216     D WWWRNF          S              1A
006300051216     D WWZERO          S             40A
006400051216     D WFRRN           S              4P 0
006500051216     D WW              S              3P 0
006600051216     D WWFKS           S              1P 0
006700051216     D WWFKSO          S                   LIKE(WWFKS)
006800051216     D WWLMT           S              2P 0
006900051216     D WWLNG           S             15P 5
007000051216     D WWLNGQ          S              5P 0
007100051216     D WWLOWR          S              4P 0
007200051216     D WWLSTS          S              2P 0
007300051216     D WWOPS           S              1P 0
007400051216     D WWOPSO          S                   LIKE(WWOPS)
007500051216     D WWPNL           S              1P 0
007600051216     D WWPNLN          S                   LIKE(WWPNL)
007700051216     D WWPNLO          S                   LIKE(WWPNL)
007800051216     D WWPSNI          S              2P 0
007900051216     D WWPSNN          S              1P 0
008000051216     D WWPSNP          S                   LIKE(WWPSNN)
008100051216     D WWRRN           S              4P 0
008200051216      *
008300051216      *___________________________________________________________________
008400051216      * Process check request
008500051216    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
008600051216     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
008700051216     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
008800051216     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
008900051216     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
009000051216     C                   Cas                     PRCERR                         REQUEST ERROR
009100051216     C                   Endcs                                                  END CASE
009200051216    ?C                   Return                                                 RETURN
009300051216      *___________________________________________________________________
009400051216      * Edit record - ADD
009500051216      *___________________________________________________________________
009600051216     C     EDTADD        Begsr                                                  EDIT RECORD
009700051216      *
009800051216     C*                  If        CDTYPE  = *Blanks
009900051216    ?C*                  Move      'ERROR   '    WORTN                          REQUEST ERROR
010000051216    ?C*                  Move      WTM(1)        WWMSG                          PASS MSG
010100051216    ?C*                  Exsr      SNDMSG                                       SEND MSG
010200051216     C*                  Endif
010300051216      *
010400051216     C*                  EXSR      $COMMON
010500051216      *
010600051216     C                   Endsr                                                  END DLT RQST
010700051216      *___________________________________________________________________
010800051216      * Edit record - COMMON EDITS
010900051216      *___________________________________________________________________
011000051216     C     $COMMON       Begsr                                                  EDIT RECORD
011100051216      *
011200051216      *
011300051216     C                   Endsr                                                  END DLT RQST
011400051216      *___________________________________________________________________
011500051216      * Edit record - CHANGE
011600051216      *___________________________________________________________________
011700051216     C     EDTCHG        Begsr                                                  EDIT RECORD
011800051216      *
011900051216     C*                  If        CDTYPE  = *Blanks
012000051216    ?C*                  Move      'ERROR   '    WORTN                          REQUEST ERROR
012100051216    ?C*                  Move      WTM(1)        WWMSG                          PASS MSG
012200051216    ?C*                  Exsr      SNDMSG                                       SEND MSG
012300051216     C*                  Endif
012400051216      *
012500051216     C*                  EXSR      $COMMON
012600051216      *
012700051216     C                   Endsr                                                  END DLT RQST
012800051216      *___________________________________________________________________
012900051216      * Edit delete request
013000051216      *___________________________________________________________________
013100051216     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
013200051216     C                   Endsr                                                  END DLT RQST
013300051216      *___________________________________________________________________
013400051216      * Default data
013500051216      *___________________________________________________________________
013600051216     C     DFTDTA        Begsr                                                  DEFAULT DATA
013700051216     C                   Endsr                                                  END DFT DATA
013800051216      *___________________________________________________________________
013900051216      * Send messages
014000051216      *___________________________________________________________________
014100051216     C     SNDMSG        Begsr                                                  SEND ERROR MSG
014200051216    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
014300051216    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
014400051216    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
014500051216    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
014600051216    ?C                   Parm                    WWMSG                          ERROR MESSAGE
014700051216     C                   Endsr                                                  END SND ERRMSG
014800051216      *___________________________________________________________________
014900051216      * Process error
015000051216      *___________________________________________________________________
015100051216     C     PRCERR        Begsr                                                  PROCESS ERROR
015200051216    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
015300051216    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
015400051216    ?C                   Exsr      SNDMSG                                       SEND MSG
015500051216     C                   Endsr                                                  END PRCERR
015600051216      *___________________________________________________________________
015700051216      * Parameter list
015800051216      *___________________________________________________________________
015900051216     C     PLIST         Begsr                                                  PARM LISTS
016000051216    ?C     *ENTRY        Plist                                                  *ENTRY LIST
016100051216    ?C                   Parm                    WIRQS                          REQUEST
016200051216    ?C                   Parm                    WORTN                          RETURN CODE
016300051216    ?C                   Parm                    WUDTA                          DATA
016400051216     C                   Endsr                                                  END PLIST
016500051216      *___________________________________________________________________
016600051216      * Define Variables and Key Lists
016700051216      *___________________________________________________________________
016800051216     C     *INZSR        Begsr
016900051216    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
017000051216     C                   Endsr                                                  END DEFN
017100051216      *___________________________________________________________________
017200051216      * Program error handler
017300051216      *___________________________________________________________________
017400051216     C     *PSSR         Begsr                                                  PROGRAM ERROR
017500051216    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
017600051216    ?C                   Parm                    WQPGMN                         PROGRAM NAME
017700051216    ?C                   Parm                    WQSTSC                         STATUS CODE
017800051216    ?C                   Parm                    WQRPGS                         RPG STATEMENT
017900051216    ?C                   Parm                    WQMSG                          MESSAGE ID
018000051216     C                   Endsr     '*CANCL'                                     END PGM ERROR
018100051216      *___________________________________________________________________
018200051216** WTMP
01830005121600T-Record is not eligible for deletion.
01840005121600Request not supported by program CHKDDC.
018500051216** WTM
01860005121661X
01870005121662X
01880005121663X
