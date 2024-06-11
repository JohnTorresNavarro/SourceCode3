000100000000      *_________________________________________________________________________
000200000000      *
000300130809      *  Description: NASCO ALT ID XRF
000400000000      *
000500130131      *  (C)COPYRIGHT 2013 BY GROUP BENEFIT SERVICES, INC.
000600000000      *___________________________________________________________________
000700130809      *
000800130809     FMEMBER    IF   E           K DISK
000900000000      *
001000000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100130809    ?D WTM             S             80    DIM(2) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001200000000      *
001300000000      *___________________________________________________________________
001400000000      *
001500000000      * Data structure
001600130809    ?D WUDTA         E DS                  EXTNAME(MEMALT)
001700000000      *
001800000000      * Program status data structure
001900000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002000000000      *
002100000000      *
002200130809     D #ISO            S               D   DATFMT(*ISO)
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
010000040305      *
010100040305     C                   EXSR      $COMMON
010200040305      *
010300040305     C                   Endsr                                                  END DLT RQST
010400040305      *___________________________________________________________________
010500040305      * Edit record - COMMON EDITS
010600040305      *___________________________________________________________________
010700040305     C     $COMMON       Begsr                                                  EDIT RECORD
010800040305      *
010900130809      * MEMBER SSN
011000130809     C                   If        MAMEMID = *ZEROS
011100130809    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011200130809    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
011300130809    ?C                   Exsr      SNDMSG                                       SEND MSG
011400130809     C                   ELSE
011500130809     C     MAMEMID       CHAIN     MEMBR
011600130809     C                   IF        NOT %FOUND(MEMBER)
011700130809     C                   EVAL      MALNAME = '*NOT USED*'
011800130809     C                   EVAL      MAFNAME = '*NOT USED*'
011900130809     C                   ELSE
012000130809     C                   EVAL      MALNAME = MLNAME
012100130809     C                   EVAL      MAFNAME = MFNAME
012200130809     C                   ENDIF
012300130809     C                   Endif
012400130809      *
012500130809      * MEMBER ALT ID
012600130809     C                   If        MAALTID = *Blanks
012700130809    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012800130809    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
012900130809    ?C                   Exsr      SNDMSG                                       SEND MSG
013000130809     C                   Endif
013100000000      *
013200000000     C                   Endsr                                                  END DLT RQST
013300040305      *___________________________________________________________________
013400040305      * Edit record - CHANGE
013500040305      *___________________________________________________________________
013600040305     C     EDTCHG        Begsr                                                  EDIT RECORD
013700040305      *
013800040305     C                   EXSR      $COMMON
013900040305      *
014000040305     C                   Endsr                                                  END DLT RQST
014100000000      *___________________________________________________________________
014200000000      * Edit delete request
014300000000      *___________________________________________________________________
014400000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
014500000000     C                   Endsr                                                  END DLT RQST
014600000000      *___________________________________________________________________
014700000000      * Default data
014800000000      *___________________________________________________________________
014900000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
015000130809    ***
015100130809     C                   EVAL      #ISO = %DATE
015200130809     C                   MOVE      #ISO          MACRTDT
015300130809     C                   EVAL      MAALTTP = 'MIS'
015400130809    ***
015500000000     C                   Endsr                                                  END DFT DATA
015600000000      *___________________________________________________________________
015700000000      * Send messages
015800000000      *___________________________________________________________________
015900000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
016000000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
016100000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
016200000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
016300000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
016400000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
016500000000     C                   Endsr                                                  END SND ERRMSG
016600000000      *___________________________________________________________________
016700000000      * Process error
016800000000      *___________________________________________________________________
016900000000     C     PRCERR        Begsr                                                  PROCESS ERROR
017000000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
017100000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
017200000000    ?C                   Exsr      SNDMSG                                       SEND MSG
017300000000     C                   Endsr                                                  END PRCERR
017400000000      *___________________________________________________________________
017500000000      * Parameter list
017600000000      *___________________________________________________________________
017700000000     C     PLIST         Begsr                                                  PARM LISTS
017800000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
017900000000    ?C                   Parm                    WIRQS                          REQUEST
018000000000    ?C                   Parm                    WORTN                          RETURN CODE
018100000000    ?C                   Parm                    WUDTA                          DATA
018200000000     C                   Endsr                                                  END PLIST
018300000000      *___________________________________________________________________
018400000000      * Define Variables and Key Lists
018500000000      *___________________________________________________________________
018600000000     C     *INZSR        Begsr
018700000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
018800000000     C                   Endsr                                                  END DEFN
018900000000      *___________________________________________________________________
019000000000      * Program error handler
019100000000      *___________________________________________________________________
019200000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
019300000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
019400000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
019500000000    ?C                   Parm                    WQSTSC                         STATUS CODE
019600000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
019700000000    ?C                   Parm                    WQMSG                          MESSAGE ID
019800000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
019900020228      *___________________________________________________________________
020000000000** WTMP
02010000000000T-Record is not eligible for deletion.
02020013080900Request not supported by program CHKNAI.
020300000000** WTM
02040013080963BAD SSN
02050013080962NO ALT ID
