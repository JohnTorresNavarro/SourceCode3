000100000000      *_________________________________________________________________________
000200000000      *
000300060313      *  Description: RELATIONSHIP MANAGER MASTER
000400000000      *
000500060310      *  (C)COPYRIGHT 2006 BY GROUP BENEFIT SERVICES, INC.
000600000000      *___________________________________________________________________
000700060313      *
000800060313     FAGCYRMG1  IF   E           K DISK    RENAME(AGCYRMGR:FSGR)
000900060313     FAGCYRMG2  IF   E           K DISK    RENAME(AGCYRMGR:FLGR)
001000060313     FAGCYRMG3  IF   E           K DISK    RENAME(AGCYRMGR:FMGR)
001100000000      *
001200000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001300060313    ?D WTM             S             80    DIM(4) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001400000000      *
001500000000      *___________________________________________________________________
001600000000      *
001700000000      * Data structure
001800060313    ?D WUDTA         E DS                  EXTNAME(RMGRMST0)
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
010200060313     C                   If        RMCODE  = *Blanks
010300000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
010400000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
010500000000    ?C                   Exsr      SNDMSG                                       SEND MSG
010600000000     C                   Endif
010700040305      *
010800040305     C                   EXSR      $COMMON
010900040305      *
011000040305     C                   Endsr                                                  END DLT RQST
011100040305      *___________________________________________________________________
011200040305      * Edit record - COMMON EDITS
011300040305      *___________________________________________________________________
011400040305     C     $COMMON       Begsr                                                  EDIT RECORD
011500040305      *
011600060313     C                   If        RMNAME  = *Blanks
011700060313    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011800060313    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
011900060313    ?C                   Exsr      SNDMSG                                       SEND MSG
012000060313     C                   Endif
012100000000      *
012200060313     C                   If        RMSGR = *Blanks AND RMLGR = *BLANKS AND
012300060313     C                             RMRMGR = *BLANKS
012400060313    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012500060313    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
012600060313    ?C                   Exsr      SNDMSG                                       SEND MSG
012700060313     C                   Endif
012800060313      *
012900000000     C                   Endsr                                                  END DLT RQST
013000040305      *___________________________________________________________________
013100040305      * Edit record - CHANGE
013200040305      *___________________________________________________________________
013300040305     C     EDTCHG        Begsr                                                  EDIT RECORD
013400040305      *
013500040305     C                   EXSR      $COMMON
013600060313      *
013700060313     C     RMCODE        CHAIN     FSGR
013800060313     C                   IF        %FOUND(AGCYRMG1) AND RMSGR = *BLANKS
013900060313    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014000060313    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
014100060313    ?C                   Exsr      SNDMSG                                       SEND MSG
014200060313     C                   Endif
014300060313      *
014400060313     C     RMCODE        CHAIN     FLGR
014500060313     C                   IF        %FOUND(AGCYRMG2) AND RMLGR = *BLANKS
014600060313    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014700060313    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
014800060313    ?C                   Exsr      SNDMSG                                       SEND MSG
014900060313     C                   Endif
015000060313      *
015100060313     C     RMCODE        CHAIN     FMGR
015200060313     C                   IF        %FOUND(AGCYRMG3) AND RMRMGR = *BLANKS
015300060313    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
015400060313    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
015500060313    ?C                   Exsr      SNDMSG                                       SEND MSG
015600060313     C                   Endif
015700040305      *
015800040305     C                   Endsr                                                  END DLT RQST
015900000000      *___________________________________________________________________
016000000000      * Edit delete request
016100000000      *___________________________________________________________________
016200000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
016300060313      *
016400060313     C     RMCODE        CHAIN     FSGR
016500060313     C                   IF        %FOUND(AGCYRMG1)
016600060313    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016700060313    ?C                   Move      WTMP(1)       WWMSG                          PASS MSG
016800060313    ?C                   Exsr      SNDMSG                                       SEND MSG
016900060313     C                   LEAVESR
017000060313     C                   Endif
017100060313      *
017200060313     C     RMCODE        CHAIN     FLGR
017300060313     C                   IF        %FOUND(AGCYRMG2)
017400060313    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
017500060313    ?C                   Move      WTMP(1)       WWMSG                          PASS MSG
017600060313    ?C                   Exsr      SNDMSG                                       SEND MSG
017700060313     C                   LEAVESR
017800060313     C                   Endif
017900060313      *
018000060313     C     RMCODE        CHAIN     FMGR
018100060313     C                   IF        %FOUND(AGCYRMG3)
018200060313    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
018300060313    ?C                   Move      WTMP(1)       WWMSG                          PASS MSG
018400060313    ?C                   Exsr      SNDMSG                                       SEND MSG
018500060313     C                   LEAVESR
018600060313     C                   Endif
018700060313      *
018800000000     C                   Endsr                                                  END DLT RQST
018900000000      *___________________________________________________________________
019000000000      * Default data
019100000000      *___________________________________________________________________
019200000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
019300000000     C                   Endsr                                                  END DFT DATA
019400000000      *___________________________________________________________________
019500000000      * Send messages
019600000000      *___________________________________________________________________
019700000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
019800000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
019900000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
020000000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
020100000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
020200000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
020300000000     C                   Endsr                                                  END SND ERRMSG
020400000000      *___________________________________________________________________
020500000000      * Process error
020600000000      *___________________________________________________________________
020700000000     C     PRCERR        Begsr                                                  PROCESS ERROR
020800000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
020900000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
021000000000    ?C                   Exsr      SNDMSG                                       SEND MSG
021100000000     C                   Endsr                                                  END PRCERR
021200000000      *___________________________________________________________________
021300000000      * Parameter list
021400000000      *___________________________________________________________________
021500000000     C     PLIST         Begsr                                                  PARM LISTS
021600000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
021700000000    ?C                   Parm                    WIRQS                          REQUEST
021800000000    ?C                   Parm                    WORTN                          RETURN CODE
021900000000    ?C                   Parm                    WUDTA                          DATA
022000000000     C                   Endsr                                                  END PLIST
022100000000      *___________________________________________________________________
022200000000      * Define Variables and Key Lists
022300000000      *___________________________________________________________________
022400000000     C     *INZSR        Begsr
022500000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
022600000000     C                   Endsr                                                  END DEFN
022700000000      *___________________________________________________________________
022800000000      * Program error handler
022900000000      *___________________________________________________________________
023000000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
023100000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
023200000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
023300000000    ?C                   Parm                    WQSTSC                         STATUS CODE
023400000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
023500000000    ?C                   Parm                    WQMSG                          MESSAGE ID
023600000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
023700020228      *___________________________________________________________________
023800000000** WTMP
02390000000000T-Record is not eligible for deletion.
02400006031300Request not supported by program CHKRMM.
024100000000** WTM
02420006031361CODE INVALID
02430006031362NAME IS BLANK
02440006031363SELECT AT LEAST ONE CATEGORY
02450006031363CANNOT UNSELECT A CATEGORY THAT IS IN USE
