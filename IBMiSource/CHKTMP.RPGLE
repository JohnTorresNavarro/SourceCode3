000100000000      *_________________________________________________________________________
000200000000      *
000300030521      *  Description:  TEMPORARY GROUP NUMBER
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *  This document contains restricted materials of IO, Inc.
000700000000      *___________________________________________________________________
000800000000      *
000900000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001000000000    ?D WTM             S             80    DIM(3) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001100000000      *
001200000000      *___________________________________________________________________
001300000000      *
001400000000      * Data structure
001500030521    ?D WUDTA         E DS                  EXTNAME(TEMPG#)
001600000000      *
001700000000      * Program status data structure
001800000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000      *
002000000000      *
002100021008     D WIFKV           S             60A
002200021008     D WIFKY           S                   LIKE(WIFKV)
002300021008     D WIOPV           S                   LIKE(WIFKV)
002400021008     D WIRQS           S              8A
002500021008     D WORTN           S              8A
002600021008     D WUPGM           S             10A
002700021008     D WWCHG           S              1A
002800021008     D WWDLT           S              1A
002900021008     D WWDTAQ          S             10A
003000021008     D WWENDF          S              3A
003100021008     D WWENDO          S                   LIKE(WWENDF)
003200021008     D WWERR           S              1A
003300021008     D WWFIL           S             10A
003400021008     D WWFKA           S              8A
003500021008     D WWFKV           S                   LIKE(WIFKV)
003600021008     D WWFKY           S                   LIKE(WIFKV)
003700021008     D WWFLK           S            128A
003800021008     D WWFMTN          S              8A
003900021008     D WWFNC           S              8A
004000021008     D WWIJI           S             16A
004100021008     D WWIN            S             99A
004200021008     D WWLIB           S             10A
004300021008     D WWMSG           S             80A
004400021008     D WWMSGC          S              7A
004500021008     D WWOCD           S              8A
004600021008     D WWOPA           S              8A
004700021008     D WWOPN           S              1A
004800021008     D WWOPT           S              8A
004900021008     D WWOPV           S                   LIKE(WIFKV)
005000021008     D WWORQS          S                   LIKE(WIRQS)
005100021008     D WWPSNC          S              1A
005200021008     D WWQJN           S             26A
005300021008     D WWRQS           S                   LIKE(WIRQS)
005400021008     D WWRQSD          S                   LIKE(WIRQS)
005500021008     D WWRTN           S                   LIKE(WORTN)
005600021008     D WWRTND          S                   LIKE(WORTN)
005700021008     D WWRTNH          S                   LIKE(WORTN)
005800021008     D WWSFLE          S              1A
005900021008     D WWSTT           S              3A
006000021008     D WWTSK           S              8A
006100021008     D WWTXT           S             60A
006200021008     D WWUPD           S              1A
006300021008     D WWWRNF          S              1A
006400021008     D WWZERO          S             40A
006500021008     D WFRRN           S              4P 0
006600021008     D WW              S              3P 0
006700021008     D WWFKS           S              1P 0
006800021008     D WWFKSO          S                   LIKE(WWFKS)
006900021008     D WWLMT           S              2P 0
007000021008     D WWLNG           S             15P 5
007100021008     D WWLNGQ          S              5P 0
007200021008     D WWLOWR          S              4P 0
007300021008     D WWLSTS          S              2P 0
007400021008     D WWOPS           S              1P 0
007500021008     D WWOPSO          S                   LIKE(WWOPS)
007600021008     D WWPNL           S              1P 0
007700021008     D WWPNLN          S                   LIKE(WWPNL)
007800021008     D WWPNLO          S                   LIKE(WWPNL)
007900021008     D WWPSNI          S              2P 0
008000021008     D WWPSNN          S              1P 0
008100021008     D WWPSNP          S                   LIKE(WWPSNN)
008200021008     D WWRRN           S              4P 0
008300000000      *
008400000000      *___________________________________________________________________
008500000000      * Process check request
008600000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
008700030521     C     WIRQS         Caseq     'EDTADD'      EDTRCD                         EDIT RECORD
008800030521     C     WIRQS         Caseq     'EDTCHG'      EDTRCD                         EDIT RECORD
008900000000     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
009000000000     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
009100000000     C                   Cas                     PRCERR                         REQUEST ERROR
009200000000     C                   Endcs                                                  END CASE
009300000000    ?C                   Return                                                 RETURN
009400000000      *___________________________________________________________________
009500000000      * Edit record
009600000000      *___________________________________________________________________
009700000000     C     EDTRCD        Begsr                                                  EDIT RECORD
009800000000      *
009900030521     C                   If        TETEMPG# = *BLANKS
010000000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010100000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
010200000000    ?C                   Exsr      SNDMSG                                       SEND MSG
010300000000     C                   Endif
010400000000      *
010500000000     C                   Endsr                                                  END DLT RQST
010600000000      *___________________________________________________________________
010700000000      * Edit delete request
010800000000      *___________________________________________________________________
010900000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
011000000000     C                   Endsr                                                  END DLT RQST
011100000000      *___________________________________________________________________
011200000000      * Default data
011300000000      *___________________________________________________________________
011400000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
011500030521    * *
011600030521     C                   MOVE      *BLANKS       @40              40
011700030521     C                   CALL      'TIMESTMP'
011800030521     C                   PARM                    @40
011900030521     C                   MOVEL     @40           @8                8
012000030521     C                   MOVE      @8            TEADDT
012100030521     C                   EVAL      TEADUSER = %SUBST(@40:25:10)
012200030521    * *
012300000000     C                   Endsr                                                  END DFT DATA
012400000000      *___________________________________________________________________
012500000000      * Send messages
012600000000      *___________________________________________________________________
012700000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
012800000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
012900000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
013000000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
013100000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
013200000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
013300000000     C                   Endsr                                                  END SND ERRMSG
013400000000      *___________________________________________________________________
013500000000      * Process error
013600000000      *___________________________________________________________________
013700000000     C     PRCERR        Begsr                                                  PROCESS ERROR
013800000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
013900000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
014000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
014100000000     C                   Endsr                                                  END PRCERR
014200000000      *___________________________________________________________________
014300000000      * Parameter list
014400000000      *___________________________________________________________________
014500000000     C     PLIST         Begsr                                                  PARM LISTS
014600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
014700000000    ?C                   Parm                    WIRQS                          REQUEST
014800000000    ?C                   Parm                    WORTN                          RETURN CODE
014900000000    ?C                   Parm                    WUDTA                          DATA
015000000000     C                   Endsr                                                  END PLIST
015100000000      *___________________________________________________________________
015200000000      * Define Variables and Key Lists
015300000000      *___________________________________________________________________
015400000000     C     *INZSR        Begsr
015500000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
015600000000     C                   Endsr                                                  END DEFN
015700000000      *___________________________________________________________________
015800000000      * Program error handler
015900000000      *___________________________________________________________________
016000000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
016100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
016200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
016300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
016400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
016500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
016600000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
016700020228      *___________________________________________________________________
016800000000** WTMP
01690000000000T-Record is not eligible for deletion.
01700003052100Request not supported by program CHKTMP.
017100000000** WTM
01720003052161TEMPORARY GROUP # CANNOT BE BLANK.
01730000000062X
01740000000063X
