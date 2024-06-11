000100000000      *_________________________________________________________________________
000200000000      *
000300130131      *  Description: MEMBER ALTERNATE ID
000400000000      *
000500130131      *  (C)COPYRIGHT 2013 BY GROUP BENEFIT SERVICES, INC.
000600000000      *___________________________________________________________________
000700130208     FMEMBER    IF   E           K DISK
000800130208     FALTTYP    IF   E           K DISK
000900000000      *
001000130208     D #ISO            S               D   DATFMT(*ISO)
001100000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001200000000    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001300000000      *
001400000000      *___________________________________________________________________
001500000000      *
001600000000      * Data structure
001700130208    ?D WUDTA         E DS                  EXTNAME(MEMALT)
001800000000      *
001900000000      * Program status data structure
002000000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002100000000      *
002200000000      *
002300021008     D WIFKV           S             60A
002400021008     D WIFKY           S                   LIKE(WIFKV)
002500021008     D WIOPV           S                   LIKE(WIFKV)
002600021008     D WIRQS           S              8A
002700021008     D WORTN           S              8A
002800021008     D WUPGM           S             10A
002900021008     D WWCHG           S              1A
003000021008     D WWDLT           S              1A
003100021008     D WWDTAQ          S             10A
003200021008     D WWENDF          S              3A
003300021008     D WWENDO          S                   LIKE(WWENDF)
003400021008     D WWERR           S              1A
003500021008     D WWFIL           S             10A
003600021008     D WWFKA           S              8A
003700021008     D WWFKV           S                   LIKE(WIFKV)
003800021008     D WWFKY           S                   LIKE(WIFKV)
003900021008     D WWFLK           S            128A
004000021008     D WWFMTN          S              8A
004100021008     D WWFNC           S              8A
004200021008     D WWIJI           S             16A
004300021008     D WWIN            S             99A
004400021008     D WWLIB           S             10A
004500021008     D WWMSG           S             80A
004600021008     D WWMSGC          S              7A
004700021008     D WWOCD           S              8A
004800021008     D WWOPA           S              8A
004900021008     D WWOPN           S              1A
005000021008     D WWOPT           S              8A
005100021008     D WWOPV           S                   LIKE(WIFKV)
005200021008     D WWORQS          S                   LIKE(WIRQS)
005300021008     D WWPSNC          S              1A
005400021008     D WWQJN           S             26A
005500021008     D WWRQS           S                   LIKE(WIRQS)
005600021008     D WWRQSD          S                   LIKE(WIRQS)
005700021008     D WWRTN           S                   LIKE(WORTN)
005800021008     D WWRTND          S                   LIKE(WORTN)
005900021008     D WWRTNH          S                   LIKE(WORTN)
006000021008     D WWSFLE          S              1A
006100021008     D WWSTT           S              3A
006200021008     D WWTSK           S              8A
006300021008     D WWTXT           S             60A
006400021008     D WWUPD           S              1A
006500021008     D WWWRNF          S              1A
006600021008     D WWZERO          S             40A
006700021008     D WFRRN           S              4P 0
006800021008     D WW              S              3P 0
006900021008     D WWFKS           S              1P 0
007000021008     D WWFKSO          S                   LIKE(WWFKS)
007100021008     D WWLMT           S              2P 0
007200021008     D WWLNG           S             15P 5
007300021008     D WWLNGQ          S              5P 0
007400021008     D WWLOWR          S              4P 0
007500021008     D WWLSTS          S              2P 0
007600021008     D WWOPS           S              1P 0
007700021008     D WWOPSO          S                   LIKE(WWOPS)
007800021008     D WWPNL           S              1P 0
007900021008     D WWPNLN          S                   LIKE(WWPNL)
008000021008     D WWPNLO          S                   LIKE(WWPNL)
008100021008     D WWPSNI          S              2P 0
008200021008     D WWPSNN          S              1P 0
008300021008     D WWPSNP          S                   LIKE(WWPSNN)
008400021008     D WWRRN           S              4P 0
008500000000      *
008600000000      *___________________________________________________________________
008700000000      * Process check request
008800000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
008900040305     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
009000040305     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
009100000000     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
009200000000     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
009300000000     C                   Cas                     PRCERR                         REQUEST ERROR
009400000000     C                   Endcs                                                  END CASE
009500000000    ?C                   Return                                                 RETURN
009600000000      *___________________________________________________________________
009700040305      * Edit record - ADD
009800000000      *___________________________________________________________________
009900040305     C     EDTADD        Begsr                                                  EDIT RECORD
010000000000      *
010100040305     C                   EXSR      $COMMON
010200040305      *
010300040305     C                   Endsr                                                  END DLT RQST
010400040305      *___________________________________________________________________
010500040305      * Edit record - COMMON EDITS
010600040305      *___________________________________________________________________
010700040305     C     $COMMON       Begsr                                                  EDIT RECORD
010800040305      *
010900130208     C     MAMEMID       CHAIN     MEMBR
011000130208     C                   If        NOT %FOUND(MEMBER)
011100130208    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011200130208    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
011300130208    ?C                   Exsr      SNDMSG                                       SEND MSG
011400130208     C                   ELSE
011500130208     C                   EVAL      MALNAME = MLNAME
011600130208     C                   EVAL      MAFNAME = MFNAME
011700130208     C                   Endif
011800130208      *
011900130208     C                   If        MAALTID = *Blanks
012000130208    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012100130208    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
012200130208    ?C                   Exsr      SNDMSG                                       SEND MSG
012300130208     C                   Endif
012400000000      *
012500130208     C                   If        MAALTTP = *Blanks
012600130208    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012700130208    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
012800130208    ?C                   Exsr      SNDMSG                                       SEND MSG
012900130208     C                   Endif
013000130208      *
013100130208     C     MAALTTP       CHAIN     ALTTYPR
013200130208     C                   If        NOT %FOUND(ALTTYP)
013300130208    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013400130208    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
013500130208    ?C                   Exsr      SNDMSG                                       SEND MSG
013600130208     C                   Endif
013700130307      *
013800130307     C                   If        MAALTTP = 'GBS' OR MAALTTP = 'IMD'
013900130307    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014000130307    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
014100130307    ?C                   Exsr      SNDMSG                                       SEND MSG
014200130307     C                   Endif
014300130307      *
014400130211     C                   If        MAALTTP = 'MA ' OR MAALTTP = 'HRO'
014500130211    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014600130211    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
014700130211    ?C                   Exsr      SNDMSG                                       SEND MSG
014800130211     C                   Endif
014900130208      *
015000000000     C                   Endsr                                                  END DLT RQST
015100040305      *___________________________________________________________________
015200040305      * Edit record - CHANGE
015300040305      *___________________________________________________________________
015400040305     C     EDTCHG        Begsr                                                  EDIT RECORD
015500040305      *
015600040305     C                   EXSR      $COMMON
015700040305      *
015800040305     C                   Endsr                                                  END DLT RQST
015900000000      *___________________________________________________________________
016000000000      * Edit delete request
016100000000      *___________________________________________________________________
016200000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
016300000000     C                   Endsr                                                  END DLT RQST
016400000000      *___________________________________________________________________
016500000000      * Default data
016600000000      *___________________________________________________________________
016700000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
016800130208     C                   EVAL      #ISO = %DATE
016900130208     C                   MOVE      #ISO          MACRTDT
017000000000     C                   Endsr                                                  END DFT DATA
017100000000      *___________________________________________________________________
017200000000      * Send messages
017300000000      *___________________________________________________________________
017400000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
017500000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
017600000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
017700000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
017800000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
017900000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
018000000000     C                   Endsr                                                  END SND ERRMSG
018100000000      *___________________________________________________________________
018200000000      * Process error
018300000000      *___________________________________________________________________
018400000000     C     PRCERR        Begsr                                                  PROCESS ERROR
018500000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
018600000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
018700000000    ?C                   Exsr      SNDMSG                                       SEND MSG
018800000000     C                   Endsr                                                  END PRCERR
018900000000      *___________________________________________________________________
019000000000      * Parameter list
019100000000      *___________________________________________________________________
019200000000     C     PLIST         Begsr                                                  PARM LISTS
019300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
019400000000    ?C                   Parm                    WIRQS                          REQUEST
019500000000    ?C                   Parm                    WORTN                          RETURN CODE
019600000000    ?C                   Parm                    WUDTA                          DATA
019700000000     C                   Endsr                                                  END PLIST
019800000000      *___________________________________________________________________
019900000000      * Define Variables and Key Lists
020000000000      *___________________________________________________________________
020100000000     C     *INZSR        Begsr
020200000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
020300000000     C                   Endsr                                                  END DEFN
020400000000      *___________________________________________________________________
020500000000      * Program error handler
020600000000      *___________________________________________________________________
020700000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
020800000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
020900000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
021000000000    ?C                   Parm                    WQSTSC                         STATUS CODE
021100000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
021200000000    ?C                   Parm                    WQMSG                          MESSAGE ID
021300000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
021400020228      *___________________________________________________________________
021500000000** WTMP
02160000000000T-Record is not eligible for deletion.
02170013020800Request not supported by program CHKMLT.
021800000000** WTM
02190013020861MEMBER SSN ERROR
02200013020862ALTERNATE ID ERROR
02210013020863ALTERNATE ID TYPE ERROR
