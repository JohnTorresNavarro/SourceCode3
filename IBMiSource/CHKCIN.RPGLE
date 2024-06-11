000100120530      *_________________________________________________________________________
000200120530      *
000300120530      *  Description: COBRA INITIAL LETTER
000400120530      *
000500120530      *  (C)COPYRIGHT 2012 BY GROUP BENEFIT SERVICES, INC.
000600120530      *___________________________________________________________________
000700120530      *
000800120530     FACMUNIQUE IF   E           K DISK
000900120530      *
001000120530    ?D WTMP            S             80    DIM(2) CTDATA PERRCD(1)              PROG ERR MSG TBL
001100120718    ?D WTM             S             80    DIM(7) CTDATA PERRCD(1)              ERROR MESSAGE TBL
001200120530      *
001300120530     D @TIMESTAMP      DS
001400120530     D  #TSCYMD                1      8S 0
001500120530     D  #TSTIME                9     14S 0
001600120530     D  @TSJOB                15     24
001700120530     D  @TSUSER               25     34
001800120530     D  #TSNBR                35     40S 0
001900120530      *
002000120530     D @TS40           S             40A
002100120530      *
002200120530      *
002300120530      *
002400120530      * Data structure
002500120530    ?D WUDTA         E DS                  EXTNAME(COB440W2)
002600120530      *
002700120530      * Program status data structure
002800120530    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002900120530      *
003000120530      *
003100120530     D WIFKV           S             60A
003200120530     D WIFKY           S                   LIKE(WIFKV)
003300120530     D WIOPV           S                   LIKE(WIFKV)
003400120530     D WIRQS           S              8A
003500120530     D WORTN           S              8A
003600120530     D WUPGM           S             10A
003700120530     D WWCHG           S              1A
003800120530     D WWDLT           S              1A
003900120530     D WWDTAQ          S             10A
004000120530     D WWENDF          S              3A
004100120530     D WWENDO          S                   LIKE(WWENDF)
004200120530     D WWERR           S              1A
004300120530     D WWFIL           S             10A
004400120530     D WWFKA           S              8A
004500120530     D WWFKV           S                   LIKE(WIFKV)
004600120530     D WWFKY           S                   LIKE(WIFKV)
004700120530     D WWFLK           S            128A
004800120530     D WWFMTN          S              8A
004900120530     D WWFNC           S              8A
005000120530     D WWIJI           S             16A
005100120530     D WWIN            S             99A
005200120530     D WWLIB           S             10A
005300120530     D WWMSG           S             80A
005400120530     D WWMSGC          S              7A
005500120530     D WWOCD           S              8A
005600120530     D WWOPA           S              8A
005700120530     D WWOPN           S              1A
005800120530     D WWOPT           S              8A
005900120530     D WWOPV           S                   LIKE(WIFKV)
006000120530     D WWORQS          S                   LIKE(WIRQS)
006100120530     D WWPSNC          S              1A
006200120530     D WWQJN           S             26A
006300120530     D WWRQS           S                   LIKE(WIRQS)
006400120530     D WWRQSD          S                   LIKE(WIRQS)
006500120530     D WWRTN           S                   LIKE(WORTN)
006600120530     D WWRTND          S                   LIKE(WORTN)
006700120530     D WWRTNH          S                   LIKE(WORTN)
006800120530     D WWSFLE          S              1A
006900120530     D WWSTT           S              3A
007000120530     D WWTSK           S              8A
007100120530     D WWTXT           S             60A
007200120530     D WWUPD           S              1A
007300120530     D WWWRNF          S              1A
007400120530     D WWZERO          S             40A
007500120530     D WFRRN           S              4P 0
007600120530     D WW              S              3P 0
007700120530     D WWFKS           S              1P 0
007800120530     D WWFKSO          S                   LIKE(WWFKS)
007900120530     D WWLMT           S              2P 0
008000120530     D WWLNG           S             15P 5
008100120530     D WWLNGQ          S              5P 0
008200120530     D WWLOWR          S              4P 0
008300120530     D WWLSTS          S              2P 0
008400120530     D WWOPS           S              1P 0
008500120530     D WWOPSO          S                   LIKE(WWOPS)
008600120530     D WWPNL           S              1P 0
008700120530     D WWPNLN          S                   LIKE(WWPNL)
008800120530     D WWPNLO          S                   LIKE(WWPNL)
008900120530     D WWPSNI          S              2P 0
009000120530     D WWPSNN          S              1P 0
009100120530     D WWPSNP          S                   LIKE(WWPSNN)
009200120530     D WWRRN           S              4P 0
009300120530      *
009400120530     D @60             S             60A
009500120530     D L               S              5U 0
009600120530      *
009700120530     c                   clear                   @timestamp
009800120530     C                   MOVE      *BLANKS       @TS40
009900120530     C                   CALL      'TIMESTMP'
010000120530     C                   PARM                    @TS40
010100120530     C                   MOVEL     @TS40         @TIMESTAMP
010200120530      *
010300120530      *___________________________________________________________________
010400120530      * Process check request
010500120530    ?C                   Move      *BLANKS       WORTN                          SET RETURN CODE
010600120530     C     WIRQS         Caseq     'EDTADD'      EDTADD                         EDIT RECORD
010700120530     C     WIRQS         Caseq     'EDTCHG'      EDTCHG                         EDIT RECORD
010800120530     C     WIRQS         Caseq     'EDTDLT'      EDTDLT                         EDIT DLT RQST
010900120530     C     WIRQS         Caseq     'DFTDTA'      DFTDTA                         DEFAULT DATA
011000120530     C                   Cas                     PRCERR                         REQUEST ERROR
011100120530     C                   Endcs                                                  END CASE
011200120530    ?C                   Return                                                 RETURN
011300120530      *___________________________________________________________________
011400120530      * Edit record - ADD
011500120530      *___________________________________________________________________
011600120530     C     EDTADD        Begsr                                                  EDIT RECORD
011700120530      *
011800120530     C                   IF        C2START > 0 AND
011900120530     C                             C2START < #TSCYMD
012000120718     C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
012100120718    ?C                   EVAL      WWMSG = WTM(4)                               PASS MSG
012200120530    ?C                   Exsr      SNDMSG                                       SEND MSG
012300120530     C                   ENDIF
012400120530      *
012500120530     C                   EXSR      $COMMON
012600120718      *
012700120718     C                   IF        %FOUND(ACMUNIQUE) AND
012800120718     C                             (FCSTFL <> 'F' OR ATRMDT > 0  OR
012900120718     C                              ACOBSRV <> 'F')
013000120718     C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
013100120718    ?C                   EVAL      WWMSG = WTM(1)                               PASS MSG
013200120718    ?C                   Exsr      SNDMSG                                       SEND MSG
013300120718     C                   ENDIF
013400120530      *
013500120530     C                   Endsr                                                  END DLT RQST
013600120530      *___________________________________________________________________
013700120530      * Edit record - COMMON EDITS
013800120530      *___________________________________________________________________
013900120530     C     $COMMON       Begsr                                                  EDIT RECORD
014000120530      *
014100120530     C     KL#TSA        KLIST
014200120530     C                   KFLD                    C2TRST
014300120530     C                   KFLD                    C2SUB#
014400120530     C                   KFLD                    C2ACCT
014500120530      *
014600120530     C     KL#TSA        CHAIN     ACCMSR
014700120530     C                   IF        NOT %FOUND(ACMUNIQUE)
014800120530    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
014900120530    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
015000120530    ?C                   Exsr      SNDMSG                                       SEND MSG
015100120718     C                   ENDIF
015200120530      *
015300120718    1C                   IF        C2REMK = *BLANKS
015400120718    2C                   IF        %FOUND(ACMUNIQUE)
015500120530     C                   EVAL      @60 = %TRIM(ACNAM1)
015600120530     C                   EVAL      L = %LEN(%TRIM(@60))
015700120718    3C                   IF        L > 37
015800120530     C                   EVAL      C2REMK = %SUBST(@60:1:37) +
015900120530     C                             ' BENEFIT PLAN'
016000120718    3C                   ELSE
016100120530     C                   EVAL      C2REMK = %SUBST(@60:1:L) +
016200120530     C                             ' BENEFIT PLAN'
016300120718    3C                   ENDIF
016400120718    2C                   ELSE
016500120718     C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
016600120718    ?C                   EVAL      WWMSG = WTM(2)                               PASS MSG
016700120530    ?C                   Exsr      SNDMSG                                       SEND MSG
016800120718    2C                   ENDIF
016900120718    1C                   ENDIF
017000120530      *
017100120530     C                   IF        C2PROC <> 'Y' AND C2PROC <> 'N'
017200120530    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
017300120530    ?C                   Move      WTM(3)        WWMSG                          PASS MSG
017400120530    ?C                   Exsr      SNDMSG                                       SEND MSG
017500120530     C                   ENDIF
017600120530      *
017700120530     C                   IF        C2START = 0
017800120530    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
017900120530    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
018000120530    ?C                   Exsr      SNDMSG                                       SEND MSG
018100120530     C                   ENDIF
018200120530      *
018300120530     C                   IF        C2START > 0
018400120530     C                   TEST(DE)                C2START
018500120530     C                   IF        %ERROR
018600120530    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
018700120530    ?C                   Move      WTM(4)        WWMSG                          PASS MSG
018800120530    ?C                   Exsr      SNDMSG                                       SEND MSG
018900120530     C                   ENDIF
019000120530     C                   ENDIF
019100120530      *
019200120530     C                   IF        C2ENDDT > 0
019300120530     C                   TEST(DE)                C2ENDDT
019400120530     C                   IF        %ERROR
019500120530    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
019600120530    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
019700120530    ?C                   Exsr      SNDMSG                                       SEND MSG
019800120530     C                   ENDIF
019900120530     C                   ENDIF
020000120530      *
020100120530     C                   IF        C2ENDDT < C2START AND
020200120530     C                             C2ENDDT > 0
020300120530    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
020400120530    ?C                   Move      WTM(5)        WWMSG                          PASS MSG
020500120530    ?C                   Exsr      SNDMSG                                       SEND MSG
020600120530     C                   ENDIF
020700120530      *
020800120718     C                   IF        C2PROC = 'Y' AND C2ENDDT > 0
020900120718     C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
021000120718    ?C                   EVAL      WWMSG = WTM(6)                               PASS MSG
021100120718    ?C                   Exsr      SNDMSG                                       SEND MSG
021200120718     C                   ENDIF
021300120530      *
021400120718     C                   IF        C2PROC = 'N' AND C2ENDDT = 0
021500120718     C                   EVAL      WORTN = 'ERROR'                              REQUEST ERROR
021600120718    ?C                   EVAL      WWMSG = WTM(7)                               PASS MSG
021700120718    ?C                   Exsr      SNDMSG                                       SEND MSG
021800120718     C                   ENDIF
021900120718      *
022000120530     C                   Endsr                                                  END DLT RQST
022100120530      *___________________________________________________________________
022200120530      * Edit record - CHANGE
022300120530      *___________________________________________________________________
022400120530     C     EDTCHG        Begsr                                                  EDIT RECORD
022500120530      *
022600120530     C                   EVAL      C2CUSER = @TSUSER
022700120530     C                   EVAL      C2CTIME = #TSTIME
022800120530     C                   EVAL      C2CDATE = #TSCYMD
022900120530      *
023000120530     C                   EXSR      $COMMON
023100120530      *
023200120718     C                   IF        %FOUND(ACMUNIQUE) AND
023300120718     C                             (FCSTFL <> 'F' OR ATRMDT > 0  OR
023400120718     C                              ACOBSRV <> 'F')
023500120718     C                   EVAL      WORTN = 'WARNING'                            REQUEST ERROR
023600120718    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
023700120718    ?C                   Exsr      SNDMSG                                       SEND MSG
023800120718     C                   ENDIF
023900120718      *
024000120530     C                   Endsr                                                  END DLT RQST
024100120530      *___________________________________________________________________
024200120530      * Edit delete request
024300120530      *___________________________________________________________________
024400120530     C     EDTDLT        Begsr                                                  EDIT DELETE RQS
024500120530     C                   Endsr                                                  END DLT RQST
024600120530      *___________________________________________________________________
024700120530      * Default data
024800120530      *___________________________________________________________________
024900120530     C     DFTDTA        Begsr                                                  DEFAULT DATA
025000120530     C*
025100120530     C                   CLEAR                   WUDTA
025200120530     C                   EVAL      C2PROC = 'N'
025300120530     C*
025400120530     C                   EVAL      C2EUSER = @TSUSER
025500120530     C                   EVAL      C2ETIME = #TSTIME
025600120530     C                   EVAL      C2EDATE = #TSCYMD
025700120530     C                   EVAL      C2START = #TSCYMD
025800120530     C*
025900120530     C                   Endsr                                                  END DFT DATA
026000120530      *___________________________________________________________________
026100120530      * Send messages
026200120530      *___________________________________________________________________
026300120530     C     SNDMSG        Begsr                                                  SEND ERROR MSG
026400120530    ?C                   Call      'QSNDDTAQ'                                   SEND ERROR
026500120530    ?C                   Parm      'MSGDTAQ'     WWDTAQ                         DATA Q NAME
026600120530    ?C                   Parm      'QTEMP'       WWLIB                          DATA Q LIB
026700120530    ?C                   Parm      80            WWLNGQ                         MESSAGE LENGTH
026800120530    ?C                   Parm                    WWMSG                          ERROR MESSAGE
026900120530     C                   Endsr                                                  END SND ERRMSG
027000120530      *___________________________________________________________________
027100120530      * Process error
027200120530      *___________________________________________________________________
027300120530     C     PRCERR        Begsr                                                  PROCESS ERROR
027400120530    ?C                   Move      'ERROR   '    WORTN                          REQUEST ERROR
027500120530    ?C                   Move      WTMP(2)       WWMSG                          PASS MSG
027600120530    ?C                   Exsr      SNDMSG                                       SEND MSG
027700120530     C                   Endsr                                                  END PRCERR
027800120530      *___________________________________________________________________
027900120530      * Parameter list
028000120530      *___________________________________________________________________
028100120530     C     PLIST         Begsr                                                  PARM LISTS
028200120530    ?C     *ENTRY        Plist                                                  *ENTRY LIST
028300120530    ?C                   Parm                    WIRQS                          REQUEST
028400120530    ?C                   Parm                    WORTN                          RETURN CODE
028500120530    ?C                   Parm                    WUDTA                          DATA
028600120530     C                   Endsr                                                  END PLIST
028700120530      *___________________________________________________________________
028800120530      * Define Variables and Key Lists
028900120530      *___________________________________________________________________
029000120530     C     *INZSR        Begsr
029100120530    ?C                   Move      WTM(1)        WTM(1)                         DEFINE MSG TBL
029200120530     C                   Endsr                                                  END DEFN
029300120530      *___________________________________________________________________
029400120530      * Program error handler
029500120530      *___________________________________________________________________
029600120530     C     *PSSR         Begsr                                                  PROGRAM ERROR
029700120530    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
029800120530    ?C                   Parm                    WQPGMN                         PROGRAM NAME
029900120530    ?C                   Parm                    WQSTSC                         STATUS CODE
030000120530    ?C                   Parm                    WQRPGS                         RPG STATEMENT
030100120530    ?C                   Parm                    WQMSG                          MESSAGE ID
030200120530     C                   Endsr     '*CANCL'                                     END PGM ERROR
030300120530      *___________________________________________________________________
030400120530** WTMP
03050012053000T-Record is not eligible for deletion.
03060012053000Request not supported by program CHKCIN.
030700120530** WTM
03080012053061ACTIVE ACCOUNT REQUIRED & MUST HAVE COBRA FEDERAL FULL SERVICE
03090012053062NEED A PROPER REMARK FIELD
03100012053063PROCESS FLAG IS EITHER Y OR N
03110012053064START DATE IS REQUIRED AND MUST BE VALID
03120012053065END DATE MUST BE VALID AND AFTER START DATE
03130012071865PROCESS FLAG OF Y MUST NOT HAVE END DATE
03140012071865PROCESS FLAG OF N MUST HAVE END DATE
