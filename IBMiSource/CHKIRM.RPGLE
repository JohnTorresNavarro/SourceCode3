000100000000      *_________________________________________________________________________
000200000000      *
000300081230      *  Description: INACTIVE REASON MAINT
000400000000      *
000500060310      *  (C)COPYRIGHT 2006 BY GROUP BENEFIT SERVICES, INC.
000600000000      *___________________________________________________________________
000700000000      *
000800000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
000900000000    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001000000000      *
001100000000      *___________________________________________________________________
001200000000      *
001300000000      * Data structure
001400081230    ?D WUDTA         E DS                  EXTNAME(IRMMSTP)
001500000000      *
001600000000      * Program status data structure
001700000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001800000000      *
001900000000      *
002000021008     D WIFKV           S             60A
002100021008     D WIFKY           S                   LIKE(WIFKV)
002200021008     D WIOPV           S                   LIKE(WIFKV)
002300021008     D WIRQS           S              8A
002400021008     D WORTN           S              8A
002500021008     D WUPGM           S             10A
002600021008     D WWCHG           S              1A
002700021008     D WWDLT           S              1A
002800021008     D WWDTAQ          S             10A
002900021008     D WWENDF          S              3A
003000021008     D WWENDO          S                   LIKE(WWENDF)
003100021008     D WWERR           S              1A
003200021008     D WWFIL           S             10A
003300021008     D WWFKA           S              8A
003400021008     D WWFKV           S                   LIKE(WIFKV)
003500021008     D WWFKY           S                   LIKE(WIFKV)
003600021008     D WWFLK           S            128A
003700021008     D WWFMTN          S              8A
003800021008     D WWFNC           S              8A
003900021008     D WWIJI           S             16A
004000021008     D WWIN            S             99A
004100021008     D WWLIB           S             10A
004200021008     D WWMSG           S             80A
004300021008     D WWMSGC          S              7A
004400021008     D WWOCD           S              8A
004500021008     D WWOPA           S              8A
004600021008     D WWOPN           S              1A
004700021008     D WWOPT           S              8A
004800021008     D WWOPV           S                   LIKE(WIFKV)
004900021008     D WWORQS          S                   LIKE(WIRQS)
005000021008     D WWPSNC          S              1A
005100021008     D WWQJN           S             26A
005200021008     D WWRQS           S                   LIKE(WIRQS)
005300021008     D WWRQSD          S                   LIKE(WIRQS)
005400021008     D WWRTN           S                   LIKE(WORTN)
005500021008     D WWRTND          S                   LIKE(WORTN)
005600021008     D WWRTNH          S                   LIKE(WORTN)
005700021008     D WWSFLE          S              1A
005800021008     D WWSTT           S              3A
005900021008     D WWTSK           S              8A
006000021008     D WWTXT           S             60A
006100021008     D WWUPD           S              1A
006200021008     D WWWRNF          S              1A
006300021008     D WWZERO          S             40A
006400021008     D WFRRN           S              4P 0
006500021008     D WW              S              3P 0
006600021008     D WWFKS           S              1P 0
006700021008     D WWFKSO          S                   LIKE(WWFKS)
006800021008     D WWLMT           S              2P 0
006900021008     D WWLNG           S             15P 5
007000021008     D WWLNGQ          S              5P 0
007100021008     D WWLOWR          S              4P 0
007200021008     D WWLSTS          S              2P 0
007300021008     D WWOPS           S              1P 0
007400021008     D WWOPSO          S                   LIKE(WWOPS)
007500021008     D WWPNL           S              1P 0
007600021008     D WWPNLN          S                   LIKE(WWPNL)
007700021008     D WWPNLO          S                   LIKE(WWPNL)
007800021008     D WWPSNI          S              2P 0
007900021008     D WWPSNN          S              1P 0
008000021008     D WWPSNP          S                   LIKE(WWPSNN)
008100021008     D WWRRN           S              4P 0
008200000000      *
008300000000      *___________________________________________________________________
008400000000      * Process check request
008500000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
008600040305     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
008700040305     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
008800000000     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
008900000000     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
009000000000     C                   Cas                     PRCERR                         REQUEST ERROR
009100000000     C                   Endcs                                                  END CASE
009200000000    ?C                   Return                                                 RETURN
009300000000      *___________________________________________________________________
009400040305      * Edit record - ADD
009500000000      *___________________________________________________________________
009600040305     C     EDTADD        Begsr                                                  EDIT RECORD
009700000000      *
009800040305     C                   EXSR      $COMMON
009900040305      *
010000040305     C                   Endsr                                                  END DLT RQST
010100040305      *___________________________________________________________________
010200040305      * Edit record - COMMON EDITS
010300040305      *___________________________________________________________________
010400040305     C     $COMMON       Begsr                                                  EDIT RECORD
010500040305      *
010600081230      * INACTIVE CODE
010700081230     C                   If        IMCODE  = *Blanks
010800081230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010900081230    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
011000081230    ?C                   Exsr      SNDMSG                                       SEND MSG
011100081230     C                   Endif
011200090206      *
011300090206      * MUST BE "I" OT "T"
011400090206     C                   If        %SUBST(IMCODE:1:1) <> 'I' AND
011500090206     C                             %SUBST(IMCODE:1:1) <> 'T'
011600090206    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011700090206    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
011800090206    ?C                   Exsr      SNDMSG                                       SEND MSG
011900090206     C                   Endif
012000000000      *
012100081230      * INACTIVE DESCRIPTION
012200081230     C                   If        IMTEXT  = *Blanks
012300081230    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012400081230    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
012500081230    ?C                   Exsr      SNDMSG                                       SEND MSG
012600081230     C                   Endif
012700081230      *
012800000000     C                   Endsr                                                  END DLT RQST
012900040305      *___________________________________________________________________
013000040305      * Edit record - CHANGE
013100040305      *___________________________________________________________________
013200040305     C     EDTCHG        Begsr                                                  EDIT RECORD
013300040305      *
013400040305     C                   EXSR      $COMMON
013500040305      *
013600040305     C                   Endsr                                                  END DLT RQST
013700000000      *___________________________________________________________________
013800000000      * Edit delete request
013900000000      *___________________________________________________________________
014000000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
014100000000     C                   Endsr                                                  END DLT RQST
014200000000      *___________________________________________________________________
014300000000      * Default data
014400000000      *___________________________________________________________________
014500000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
014600000000     C                   Endsr                                                  END DFT DATA
014700000000      *___________________________________________________________________
014800000000      * Send messages
014900000000      *___________________________________________________________________
015000000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
015100000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
015200000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
015300000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
015400000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
015500000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
015600000000     C                   Endsr                                                  END SND ERRMSG
015700000000      *___________________________________________________________________
015800000000      * Process error
015900000000      *___________________________________________________________________
016000000000     C     PRCERR        Begsr                                                  PROCESS ERROR
016100000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016200000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
016300000000    ?C                   Exsr      SNDMSG                                       SEND MSG
016400000000     C                   Endsr                                                  END PRCERR
016500000000      *___________________________________________________________________
016600000000      * Parameter list
016700000000      *___________________________________________________________________
016800000000     C     PLIST         Begsr                                                  PARM LISTS
016900000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
017000000000    ?C                   Parm                    WIRQS                          REQUEST
017100000000    ?C                   Parm                    WORTN                          RETURN CODE
017200000000    ?C                   Parm                    WUDTA                          DATA
017300000000     C                   Endsr                                                  END PLIST
017400000000      *___________________________________________________________________
017500000000      * Define Variables and Key Lists
017600000000      *___________________________________________________________________
017700000000     C     *INZSR        Begsr
017800000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
017900000000     C                   Endsr                                                  END DEFN
018000000000      *___________________________________________________________________
018100000000      * Program error handler
018200000000      *___________________________________________________________________
018300000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
018400000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
018500000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
018600000000    ?C                   Parm                    WQSTSC                         STATUS CODE
018700000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
018800000000    ?C                   Parm                    WQMSG                          MESSAGE ID
018900000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
019000020228      *___________________________________________________________________
019100000000** WTMP
01920000000000T-Record is not eligible for deletion.
01930008123000Request not supported by program CHKIRM.
019400000000** WTM
01950008123061CODE CANNOT BE BLANK
01960008123062DESCRIPTION CANNOT BE BLANK
01970009020661CODE MUST BEGIN WITH (I) OR (T)
