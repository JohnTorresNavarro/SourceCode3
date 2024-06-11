000100000000      *_________________________________________________________________________
000200000000      *
000300090317      *  Description: LINK ID MAINT
000400000000      *
000500090204      *  (C)COPYRIGHT 2009 BY GROUP BENEFIT SERVICES, INC.
000600000000      *___________________________________________________________________
000700000000      *
000800090318     FSUPRAGCY  IF   E           K DISK
000900090318     FAGENCY    IF   E           K DISK
001000090318     FSMANRLT3  IF   E           K DISK
001100090318     FMKTSTSP   IF   E           K DISK
001200090318      *
001300000000    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001400090318    ?D WTM             S             80    DIM(7) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001500090318     D F_ACTIVE        S              1A
001600000000      *
001700000000      *___________________________________________________________________
001800000000      *
001900000000      * Data structure
002000090317    ?D WUDTA         E DS                  EXTNAME(SPRAGXRF)
002100000000      *
002200000000      * Program status data structure
002300000000    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002400000000      *
002500000000      *
002600021008     D WIFKV           S             60A
002700021008     D WIFKY           S                   LIKE(WIFKV)
002800021008     D WIOPV           S                   LIKE(WIFKV)
002900021008     D WIRQS           S              8A
003000021008     D WORTN           S              8A
003100021008     D WUPGM           S             10A
003200021008     D WWCHG           S              1A
003300021008     D WWDLT           S              1A
003400021008     D WWDTAQ          S             10A
003500021008     D WWENDF          S              3A
003600021008     D WWENDO          S                   LIKE(WWENDF)
003700021008     D WWERR           S              1A
003800021008     D WWFIL           S             10A
003900021008     D WWFKA           S              8A
004000021008     D WWFKV           S                   LIKE(WIFKV)
004100021008     D WWFKY           S                   LIKE(WIFKV)
004200021008     D WWFLK           S            128A
004300021008     D WWFMTN          S              8A
004400021008     D WWFNC           S              8A
004500021008     D WWIJI           S             16A
004600021008     D WWIN            S             99A
004700021008     D WWLIB           S             10A
004800021008     D WWMSG           S             80A
004900021008     D WWMSGC          S              7A
005000021008     D WWOCD           S              8A
005100021008     D WWOPA           S              8A
005200021008     D WWOPN           S              1A
005300021008     D WWOPT           S              8A
005400021008     D WWOPV           S                   LIKE(WIFKV)
005500021008     D WWORQS          S                   LIKE(WIRQS)
005600021008     D WWPSNC          S              1A
005700021008     D WWQJN           S             26A
005800021008     D WWRQS           S                   LIKE(WIRQS)
005900021008     D WWRQSD          S                   LIKE(WIRQS)
006000021008     D WWRTN           S                   LIKE(WORTN)
006100021008     D WWRTND          S                   LIKE(WORTN)
006200021008     D WWRTNH          S                   LIKE(WORTN)
006300021008     D WWSFLE          S              1A
006400021008     D WWSTT           S              3A
006500021008     D WWTSK           S              8A
006600021008     D WWTXT           S             60A
006700021008     D WWUPD           S              1A
006800021008     D WWWRNF          S              1A
006900021008     D WWZERO          S             40A
007000021008     D WFRRN           S              4P 0
007100021008     D WW              S              3P 0
007200021008     D WWFKS           S              1P 0
007300021008     D WWFKSO          S                   LIKE(WWFKS)
007400021008     D WWLMT           S              2P 0
007500021008     D WWLNG           S             15P 5
007600021008     D WWLNGQ          S              5P 0
007700021008     D WWLOWR          S              4P 0
007800021008     D WWLSTS          S              2P 0
007900021008     D WWOPS           S              1P 0
008000021008     D WWOPSO          S                   LIKE(WWOPS)
008100021008     D WWPNL           S              1P 0
008200021008     D WWPNLN          S                   LIKE(WWPNL)
008300021008     D WWPNLO          S                   LIKE(WWPNL)
008400021008     D WWPSNI          S              2P 0
008500021008     D WWPSNN          S              1P 0
008600021008     D WWPSNP          S                   LIKE(WWPSNN)
008700021008     D WWRRN           S              4P 0
008800000000      *
008900000000      *___________________________________________________________________
009000000000      * Process check request
009100000000    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
009200040305     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
009300040305     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
009400000000     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
009500000000     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
009600000000     C                   Cas                     PRCERR                         REQUEST ERROR
009700000000     C                   Endcs                                                  END CASE
009800000000    ?C                   Return                                                 RETURN
009900000000      *___________________________________________________________________
010000040305      * Edit record - ADD
010100000000      *___________________________________________________________________
010200040305     C     EDTADD        Begsr                                                  EDIT RECORD
010300040305      *
010400040305     C                   EXSR      $COMMON
010500040305      *
010600090317     C                   IF        F_AGENCY = 'Y' AND
010700090317     C                             AGTMDT <> 0
010800090318     C                   EVAL      K@CTYPE = 'A'
010900090318     C                   EVAL      K@CODE = SXAGCY
011000090318     C     KL#MST        CHAIN     MKTSTSR
011100090318     C                   IF        %FOUND(MKTSTSP) AND
011200090318     C                             %SUBST(MSREASN:1:1) = 'T'
011300090318    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
011400090318    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
011500090318    ?C                   Exsr      SNDMSG                                       SEND MSG
011600090318     C                   ENDIF
011700090318     C                   Endif
011800090317      *
011900090317     C                   IF        F_SUPER = 'Y' AND
012000090317     C                             SATRMDTE <> 0
012100090318     C                   EVAL      K@CTYPE = 'U'
012200090318     C                   EVAL      K@CODE = SXSUPER
012300090318     C     KL#MST        CHAIN     MKTSTSR
012400090318     C                   IF        %FOUND(MKTSTSP) AND
012500090318     C                             %SUBST(MSREASN:1:1) = 'T'
012600090317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
012700090318    ?C                   Move      WTM(6)        WWMSG                          PASS MSG
012800090317    ?C                   Exsr      SNDMSG                                       SEND MSG
012900090317     C                   Endif
013000090318     C                   Endif
013100090317      *
013200040305     C                   Endsr                                                  END DLT RQST
013300040305      *___________________________________________________________________
013400040305      * Edit record - COMMON EDITS
013500040305      *___________________________________________________________________
013600040305     C     $COMMON       Begsr                                                  EDIT RECORD
013700040305      *
013800090318     C                   IF        SXEFFDTE = 0
013900090317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014000090317    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
014100090317    ?C                   Exsr      SNDMSG                                       SEND MSG
014200090317     C                   Endif
014300090318      *
014400090318     C                   IF        SXEFFDTE > 0
014500090318     C                   TEST(DE)                SXEFFDTE
014600090317     C                   IF        %ERROR
014700090317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014800090317    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
014900090317    ?C                   Exsr      SNDMSG                                       SEND MSG
015000090317     C                   Endif
015100090318     C                   Endif
015200090317      *
015300090318     C                   IF        SXTRMDTE > 0
015400090318     C                   TEST(DE)                SXTRMDTE
015500090317     C                   IF        %ERROR
015600090318    ?C                   Move      WTM(2)        WWMSG                          PASS MSG
015700090317    ?C                   Exsr      SNDMSG                                       SEND MSG
015800090317     C                   Endif
015900090318     C                   Endif
016000090317      *
016100090317     C                   MOVE      'N'           F_SUPER           1
016200090317     C                   IF        SXSUPER = *BLANKS
016300090317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
016400090318    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
016500090317    ?C                   Exsr      SNDMSG                                       SEND MSG
016600090317     C                   ELSE
016700090317     C     SXSUPER       CHAIN     SAF
016800090317     C                   IF        NOT %FOUND(SUPRAGCY)
016900090317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
017000090318    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
017100090317    ?C                   Exsr      SNDMSG                                       SEND MSG
017200090317     C                   ELSE
017300090317     C                   MOVE      'Y'           F_SUPER
017400090317     C                   Endif
017500090317     C                   Endif
017600090317      *
017700090317     C                   MOVE      'N'           F_AGENCY          1
017800090317     C                   IF        SXAGCY  = *BLANKS
017900090317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
018000090318    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
018100090317    ?C                   Exsr      SNDMSG                                       SEND MSG
018200090317     C                   ELSE
018300090317     C     SXAGCY        CHAIN     AGENR
018400090317     C                   IF        NOT %FOUND(AGENCY)
018500090317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
018600090318    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
018700090317    ?C                   Exsr      SNDMSG                                       SEND MSG
018800090317     C                   ELSE
018900090317     C                   MOVE      'Y'           F_AGENCY
019000090317     C                   Endif
019100090317     C                   Endif
019200090317      *
019300000000     C                   Endsr                                                  END DLT RQST
019400040305      *___________________________________________________________________
019500040305      * Edit record - CHANGE
019600040305      *___________________________________________________________________
019700040305     C     EDTCHG        Begsr                                                  EDIT RECORD
019800040305      *
019900040305     C                   EXSR      $COMMON
020000040305      *
020100090317     C     SXASID        CHAIN     SRF
020200090317     C                   IF        %FOUND(SMANRLT3)
020300090317     C                   EXSR      $CHKACT
020400090318     C                   IF        F_ACTIVE = 'Y' AND
020500090318     C                             SXTRMDTE <> 0
020600090317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
020700090318    ?C                   Move      WTM(7)        WWMSG                          PASS MSG
020800090317    ?C                   Exsr      SNDMSG                                       SEND MSG
020900090317     C                   ELSE
021000090317     C                   MOVE      'Y'           F_AGENCY
021100090317     C                   Endif
021200090318     C                   Endif
021300090317      *
021400090317     C                   Endsr                                                  END DLT RQST
021500090317   S***S
021600090317     C     $CHKACT       Begsr                                                  EDIT DELETE RQS
021700090317      *
021800090317     C                   EVAL      F_ACTIVE = 'N'
021900090317     C     SXASID        SETLL     SRF
022000090317     C                   DOU       %EOF(SMANRLT3)
022100090317     C     SXASID        READE     SRF
022200090317     C                   IF        NOT %EOF(SMANRLT3)
022300090317     C                   IF        SRTRMDTE = 0
022400090317     C                   EVAL      F_ACTIVE = 'Y'
022500090317     C                   ENDIF
022600090317     C                   ENDIF
022700090317     C                   ENDDO
022800090317      *
022900040305     C                   Endsr                                                  END DLT RQST
023000000000      *___________________________________________________________________
023100000000      * Edit delete request
023200000000      *___________________________________________________________________
023300000000     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
023400090317    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
023500090317    ?C                   Move      WTMP(1)       WWMSG                          PASS MSG
023600090317    ?C                   Exsr      SNDMSG                                       SEND MSG
023700000000     C                   Endsr                                                  END DLT RQST
023800000000      *___________________________________________________________________
023900000000      * Default data
024000000000      *___________________________________________________________________
024100000000     C     DFTDTA        Begsr                                                  DEFAULT DATA
024200090317    ***
024300090317     C     *DTAARA       DEFINE    SXASID#       #SEQ              8 0
024400090317     C     *LOCK         IN        #SEQ
024500090317     C                   ADD       1             #SEQ
024600090317     C                   MOVE      #SEQ          SXASID
024700090317     C                   OUT       #SEQ
024800090317     C                   UNLOCK    #SEQ
024900090317    ***
025000000000     C                   Endsr                                                  END DFT DATA
025100000000      *___________________________________________________________________
025200000000      * Send messages
025300000000      *___________________________________________________________________
025400000000     C     SNDMSG        Begsr                                                  SEND ERROR MSG
025500000000    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
025600000000    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
025700000000    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
025800000000    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
025900000000    ?C                   Parm                    WWMSG                          ERROR MESSAGE
026000000000     C                   Endsr                                                  END SND ERRMSG
026100000000      *___________________________________________________________________
026200000000      * Process error
026300000000      *___________________________________________________________________
026400000000     C     PRCERR        Begsr                                                  PROCESS ERROR
026500000000    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
026600000000    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
026700000000    ?C                   Exsr      SNDMSG                                       SEND MSG
026800000000     C                   Endsr                                                  END PRCERR
026900090318      *___________________________________________________________________
027000090318      * KEY LIST
027100090318      *___________________________________________________________________
027200090318     C     KLIST         Begsr                                                  PARM LISTS
027300090318     C     KL#MST        KLIST
027400090318     C                   KFLD                    K@CTYPE           1
027500090318     C                   KFLD                    K@CODE            3
027600090318     C                   Endsr                                                  END PLIST
027700000000      *___________________________________________________________________
027800000000      * Parameter list
027900000000      *___________________________________________________________________
028000000000     C     PLIST         Begsr                                                  PARM LISTS
028100000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
028200000000    ?C                   Parm                    WIRQS                          REQUEST
028300000000    ?C                   Parm                    WORTN                          RETURN CODE
028400000000    ?C                   Parm                    WUDTA                          DATA
028500000000     C                   Endsr                                                  END PLIST
028600000000      *___________________________________________________________________
028700000000      * Define Variables and Key Lists
028800000000      *___________________________________________________________________
028900000000     C     *INZSR        Begsr
029000000000    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
029100000000     C                   Endsr                                                  END DEFN
029200000000      *___________________________________________________________________
029300000000      * Program error handler
029400000000      *___________________________________________________________________
029500000000     C     *PSSR         Begsr                                                  PROGRAM ERROR
029600000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
029700000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
029800000000    ?C                   Parm                    WQSTSC                         STATUS CODE
029900000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
030000000000    ?C                   Parm                    WQMSG                          MESSAGE ID
030100000000     C                   Endsr     '*CANCL'                                     END PGM ERROR
030200020228      *___________________________________________________________________
030300000000** WTMP
03040000000000T-Record is not eligible for deletion.
03050009031700Request not supported by program CHKLKI.
030600000000** WTM
03070009031861EFFECTIVE DATE IS INVALID
03080009031862TERM DATE IS INVALID
03090009031863SUPER AGENCY CODE IS INVALID
03100009031864AGENCY CODE IS INVALID
03110009031864CANNOT ADD LINK TO TERMED AGENCY
03120009031863CANNOT ADD LINK TO TERMED SUPER AGENCY
03130009031862CANNOT TERM LINK, RELATIONSHIP IS ACTIVE
