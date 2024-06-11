000100000000      *_________________________________________________________________________
000200000000      *
000300090312      *  Description: RELATIONSHIP ID MAINT
000400000000      *
000500090204      *  (C)COPYRIGHT 2009 BY GROUP BENEFIT SERVICES, INC.
000600000000      *___________________________________________________________________
000700000000      *
000800090312     FSPRAGXR2  IF   E           K DISK
000900090312     FSMAN      IF   E           K DISK
001000090312     FBRKPRDL   IF   E           K DISK
001100090312     FCMCTLF    IF   E           K DISK
001200090317     FMKTSTSP   IF   E           K DISK
001300090312      *
001400000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001500090317    ?D WTM             S             80    DIM(8) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001600090317     D @ACTIVE         S              1A
001700000000      *
001800000000      *___________________________________________________________________
001900000000      *
002000000000      * Data structure
002100090312    ?D WUDTA         E DS                  EXTNAME(SMANRLT)
002200000000      *
002300000000      * Program status data structure
002400000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002500000000      *
002600000000      *
002700021008     D WIFKV           S             60A
002800021008     D WIFKY           S                   LIKE(WIFKV)
002900021008     D WIOPV           S                   LIKE(WIFKV)
003000021008     D WIRQS           S              8A
003100021008     D WORTN           S              8A
003200021008     D WUPGM           S             10A
003300021008     D WWCHG           S              1A
003400021008     D WWDLT           S              1A
003500021008     D WWDTAQ          S             10A
003600021008     D WWENDF          S              3A
003700021008     D WWENDO          S                   LIKE(WWENDF)
003800021008     D WWERR           S              1A
003900021008     D WWFIL           S             10A
004000021008     D WWFKA           S              8A
004100021008     D WWFKV           S                   LIKE(WIFKV)
004200021008     D WWFKY           S                   LIKE(WIFKV)
004300021008     D WWFLK           S            128A
004400021008     D WWFMTN          S              8A
004500021008     D WWFNC           S              8A
004600021008     D WWIJI           S             16A
004700021008     D WWIN            S             99A
004800021008     D WWLIB           S             10A
004900021008     D WWMSG           S             80A
005000021008     D WWMSGC          S              7A
005100021008     D WWOCD           S              8A
005200021008     D WWOPA           S              8A
005300021008     D WWOPN           S              1A
005400021008     D WWOPT           S              8A
005500021008     D WWOPV           S                   LIKE(WIFKV)
005600021008     D WWORQS          S                   LIKE(WIRQS)
005700021008     D WWPSNC          S              1A
005800021008     D WWQJN           S             26A
005900021008     D WWRQS           S                   LIKE(WIRQS)
006000021008     D WWRQSD          S                   LIKE(WIRQS)
006100021008     D WWRTN           S                   LIKE(WORTN)
006200021008     D WWRTND          S                   LIKE(WORTN)
006300021008     D WWRTNH          S                   LIKE(WORTN)
006400021008     D WWSFLE          S              1A
006500021008     D WWSTT           S              3A
006600021008     D WWTSK           S              8A
006700021008     D WWTXT           S             60A
006800021008     D WWUPD           S              1A
006900021008     D WWWRNF          S              1A
007000021008     D WWZERO          S             40A
007100021008     D WFRRN           S              4P 0
007200090317     D LINK_FND        S              1A
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
010700090317      *
010800090317     C     KL#MST        KLIST
010900090317     C                   KFLD                    K@CTYPE           1
011000090317     C                   KFLD                    K@CODE            3
011100090317     C                   EVAL      K@CTYPE = 'S'
011200090317     C                   EVAL      K@CODE = SRSMAN
011300090317     C     KL#MST        CHAIN     MKTSTSR
011400090317     C                   IF        %FOUND(MKTSTSP) AND
011500090317     C                             %SUBST(MSREASN:1:1) = 'T'
011600090317    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
011700090317    ?C                   EVAL      WWMSG = WTM(7)                               PASS MSG
011800090317    ?C                   Exsr      SNDMSG                                       SEND MSG
011900090317     C                   ENDIF
012000040305      *
012100090317     C                   IF        LINK_FND = 'Y' AND
012200090317     C                             SXTRMDTE <> 0
012300090317    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
012400090317    ?C                   EVAL      WWMSG = WTM(8)                               PASS MSG
012500090317    ?C                   Exsr      SNDMSG                                       SEND MSG
012600090317     C                   Endif
012700090317      *
012800040305     C                   Endsr                                                  END DLT RQST
012900040305      *___________________________________________________________________
013000040305      * Edit record - COMMON EDITS
013100040305      *___________________________________________________________________
013200040305     C     $COMMON       Begsr                                                  EDIT RECORD
013300040305      *
013400090317     C                   EVAL      LINK_FND = 'N'
013500090312     C                   IF        SRASID = *BLANKS OR
013600090312     C                             SRASID = '00000000'
013700090312    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
013800090312    ?C                   EVAL      WWMSG = WTM(1)                               PASS MSG
013900090312    ?C                   Exsr      SNDMSG                                       SEND MSG
014000090312     C                   ELSE
014100090312     C     SRASID        CHAIN     SXF
014200090312     C                   IF        NOT %FOUND(SPRAGXR2)
014300090312    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
014400090317    ?C                   EVAL      WWMSG = WTM(1)                               PASS MSG
014500090312    ?C                   Exsr      SNDMSG                                       SEND MSG
014600090317     C                   ELSE
014700090317     C                   EVAL      LINK_FND = 'Y'
014800090316     C                   Endif
014900090312     C                   Endif
015000000000      *
015100090312     C                   IF        SREFFDTE <> 0
015200090312     C                   TEST(DE)                SREFFDTE
015300090312     C                   IF        %ERROR
015400090312    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
015500090312    ?C                   EVAL      WWMSG = WTM(2)                               PASS MSG
015600090312    ?C                   Exsr      SNDMSG                                       SEND MSG
015700090312     C                   Endif
015800090312     C                   ELSE
015900090312    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
016000090312    ?C                   EVAL      WWMSG = WTM(2)                               PASS MSG
016100090312    ?C                   Exsr      SNDMSG                                       SEND MSG
016200090312     C                   Endif
016300090312      *
016400090312     C                   IF        SRTRMDTE <> 0
016500090312     C                   TEST(DE)                SREFFDTE
016600090312     C                   IF        %ERROR
016700090312    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
016800090312    ?C                   EVAL      WWMSG = WTM(3)                               PASS MSG
016900090312    ?C                   Exsr      SNDMSG                                       SEND MSG
017000090312     C                   Endif
017100090312     C                   Endif
017200090312      *
017300090312     C                   IF        SRRELID = *BLANKS OR
017400090312     C                             SRRELID = '00000000'
017500090312    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
017600090312    ?C                   EVAL      WWMSG = WTM(4)                               PASS MSG
017700090312    ?C                   Exsr      SNDMSG                                       SEND MSG
017800090312     C                   Endif
017900090312      *
018000090312     C                   IF        SRSMAN = *BLANKS
018100090312    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
018200090312    ?C                   EVAL      WWMSG = WTM(5)                               PASS MSG
018300090312    ?C                   Exsr      SNDMSG                                       SEND MSG
018400090312     C                   ELSE
018500090312     C     SRSMAN        CHAIN     SMANR
018600090312     C                   IF        NOT %FOUND(SMAN)
018700090312    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
018800090317    ?C                   EVAL      WWMSG = WTM(5)                               PASS MSG
018900090312    ?C                   Exsr      SNDMSG                                       SEND MSG
019000090316     C                   Endif
019100090312     C                   Endif
019200090312      *
019300000000     C                   Endsr                                                  END DLT RQST
019400040305      *___________________________________________________________________
019500040305      * Edit record - CHANGE
019600040305      *___________________________________________________________________
019700040305     C     EDTCHG        Begsr                                                  EDIT RECORD
019800040305      *
019900040305     C                   EXSR      $COMMON
020000040305      *
020100090317     C                   EXSR      $ACTIVE
020200090317     C                   IF        @ACTIVE = 'Y' AND
020300090317     C                             SRTRMDTE <> 0
020400090317    ?C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
020500090317    ?C                   EVAL      WWMSG = WTM(6)                               PASS MSG
020600090317    ?C                   Exsr      SNDMSG                                       SEND MSG
020700090317     C                   Endif
020800090317    ***
020900040305     C                   Endsr                                                  END DLT RQST
021000090317   S***S
021100090317     C     $ACTIVE       Begsr                                                  EDIT RECORD
021200090317    ***
021300090317     C                   EVAL      @ACTIVE = 'N'
021400090317     C     SRRELID       CHAIN     BRKPRDR
021500090317     C                   IF        %FOUND(BRKPRDL)
021600090317    * *
021700090317     C     SRRELID       SETLL     BRKPRDR
021800090317     C                   DOU       %EOF(BRKPRDL) OR
021900090317     C                             @ACTIVE = 'Y'
022000090317     C     SRRELID       READE     BRKPRDR
022100090317     C                   IF        NOT %EOF(BRKPRDL) AND
022200090317     C                             @ACTIVE = 'N'
022300090317    * *
022400090317     C                   IF        BPTRDT = D'9999-12-31'
022500090317     C                   EVAL      @ACTIVE = 'Y'
022600090317     C                   ENDIF
022700090317    * *
022800090317     C                   ENDIF
022900090317     C                   ENDDO
023000090317    * *
023100090317     C                   ENDIF
023200090317    ***
023300090317     C                   IF        @ACTIVE = 'Y'
023400090317     C                   LEAVESR
023500090317     C                   ENDIF
023600090317    ***
023700090317     C     SRRELID       CHAIN     COMCXR
023800090317     C                   IF        %FOUND(CMCTLF)
023900090317    * *
024000090317     C     SRRELID       SETLL     COMCXR
024100090317     C                   DOU       %EOF(CMCTLF) OR
024200090317     C                             @ACTIVE = 'Y'
024300090317     C     SRRELID       READE     COMCXR
024400090317     C                   IF        NOT %EOF(CMCTLF) AND
024500090317     C                             @ACTIVE = 'N'
024600090317    * *
024700090317     C                   IF        CMCAN = 0
024800090317     C                   EVAL      @ACTIVE = 'Y'
024900090317     C                   ENDIF
025000090317    * *
025100090317     C                   ENDIF
025200090317     C                   ENDDO
025300090317    * *
025400090317     C                   ENDIF
025500090317    ***
025600090317     C                   Endsr                                                  END DLT RQST
025700090317   S***S
025800090312      *___________________________________________________________________
025900000000      * Edit delete request
026000000000      *___________________________________________________________________
026100000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
026200090312    ***
026300090317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
026400090317    ?C                   Move      WTMP(1)       WWMSG                          PASS MSG
026500090317    ?C                   Exsr      SNDMSG                                       SEND MSG
026600090312    ***
026700000000     C                   Endsr                                                  END DLT RQST
026800000000      *___________________________________________________________________
026900000000      * Default data
027000000000      *___________________________________________________________________
027100000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
027200090316    ***
027300090316     C     *DTAARA       DEFINE    SRRELID#      #SEQ
027400090316     C     *LOCK         IN        #SEQ
027500090316     C                   ADD       1             #SEQ              8 0
027600090316     C                   MOVE      #SEQ          SRRELID
027700090316     C                   OUT       #SEQ
027800090316     C                   UNLOCK    #SEQ
027900090312    ***
028000000000     C                   Endsr                                                  END DFT DATA
028100000000      *___________________________________________________________________
028200000000      * Send messages
028300000000      *___________________________________________________________________
028400000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
028500000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
028600000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
028700000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
028800000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
028900000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
029000000000     C                   Endsr                                                  END SND ERRMSG
029100000000      *___________________________________________________________________
029200000000      * Process error
029300000000      *___________________________________________________________________
029400000000     C     PRCERR        Begsr                                                  PROCESS ERROR
029500000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
029600000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
029700000000    ?C                   Exsr      SNDMSG                                       SEND MSG
029800000000     C                   Endsr                                                  END PRCERR
029900000000      *___________________________________________________________________
030000000000      * Parameter list
030100000000      *___________________________________________________________________
030200000000     C     PLIST         Begsr                                                  PARM LISTS
030300000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
030400000000    ?C                   Parm                    WIRQS                          REQUEST
030500000000    ?C                   Parm                    WORTN                          RETURN CODE
030600000000    ?C                   Parm                    WUDTA                          DATA
030700000000     C                   Endsr                                                  END PLIST
030800000000      *___________________________________________________________________
030900000000      * Define Variables and Key Lists
031000000000      *___________________________________________________________________
031100000000     C     *INZSR        Begsr
031200000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
031300000000     C                   Endsr                                                  END DEFN
031400000000      *___________________________________________________________________
031500000000      * Program error handler
031600000000      *___________________________________________________________________
031700000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
031800000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
031900000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
032000000000    ?C                   Parm                    WQSTSC                         STATUS CODE
032100000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
032200000000    ?C                   Parm                    WQMSG                          MESSAGE ID
032300000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
032400020228      *___________________________________________________________________
032500000000** WTMP
03260000000000T-Record is not eligible for deletion.
03270009031200Request not supported by program CHKSRE.
032800090312** WTM
03290009031261AGENCY/SUPER AGENCY LINK IS INVALID
03300009031262EFFECTIVE DATE IS INVALID
03310009031263TERM DATE IS INVALID
03320009031264RELID REQUIRED
03330009031265BLANK OR INVALID SMAN CODE
03340009031763CANNOT TERM, ACTIVE COMMISSIONS
03350009031765CANNOT ADD, SMAN STATUS IS TERMED
03360009031765CANNOT ADD, LINK IS TERMED
