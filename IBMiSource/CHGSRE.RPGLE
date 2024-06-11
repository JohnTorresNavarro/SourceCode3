000100161019      *=============================================================================================
000200161019     H option(*noDebugIo)
000300161019      *=============================================================================================
000400090311      *  Description:  Change SALESMAN RELATIONSHIP RECORD
000500020304      *
000600090204      *  (c)Copyright 2009 by Group Benefit Services, Inc.
000700161019
000800161019      *=============================================================================================
000900161019
001000161019      *                R E V I S I O N    H I S T O R Y
001100161019      *
001200161019      *  Date      Int    Desctiption
001300161019      *  --------  ---    --------------------------------------------------------------------------
001400161019      *  10/17/16  JT     Changed dspf file to not protect field when adding (SRRELID).
001500200401      *  04/01/2020 B.Rees  Fixed issue where the display file would remove the heading after F4.
001600161019      *=============================================================================================
001700161019
001800090311     FCHGSRED   CF   E             WORKSTN INFDS(DSPD)
001900161019
002000090312     FSPRAGXR2  IF   E           K DISK
002100161019
002200090316     FSRLHIST0  O  A E             DISK
002300161019
002400161019      *=============================================================================================
002500161019
002600020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
002700020304     D WAD             S             80    DIM(6)
002800090312     D #ISO            S               D   DATFMT(*ISO)
002900090312     D @30             S             30A
003000020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
003100161019
003200161019      *=============================================================================================
003300020304      * Data structure
003400090316     D H@DTA           S             35A
003500090311     D WUDTA         E DS                  EXTNAME(SMANRLT)
003600090312     D WDSMAN        E DS                  EXTNAME(SMAN)
003700020304      *
003800090317     D                 DS
003900090317     D  HMSG@                  1    100A
004000090316     D  HMSG1                  1     50A
004100090316     D  HMSG2                 51    100A
004200090316    ***
004300020304      * Program status data structure
004400020304     D PGMD          ESDS                  EXTNAME(IOPGMD)
004500020304      *
004600020304      * Display file data structure
004700020304     D DSPD          E DS                  EXTNAME(IODSPD)
004800020304      *
004900020304      * CURSOR LOCATION
005000020304     D                 DS
005100020304     D  WWCRSL                 1      2
005200020304     D  WWCRSN                 1      2B 0
005300090311     ***
005400090311     D @P              S             44A
005500090311    ***
005600090311     D                 DS
005700090311     D P@DS                    1     44A
005800090311     D  P@CODE                 1      3A
005900090311     D  P@NAME                 4     43A
006000090311     D  P@TYPE                44     44A
006100020304     ***
006200020304     D WWDTA           S                   LIKE(WUDTA)
006300021008     ***
006400021008     D WIFKV           S             60A
006500021008     D WIFKY           S                   LIKE(WIFKV)
006600021008     D WIOPV           S                   LIKE(WIFKV)
006700021008     D WIRQS           S              8A
006800021008     D WORTN           S              8A
006900021008     D WUPGM           S             10A
007000021008     D WWCHG           S              1A
007100021008     D WWDLT           S              1A
007200021008     D WWDTAQ          S             10A
007300021008     D WWENDF          S              3A
007400021008     D WWENDO          S                   LIKE(WWENDF)
007500021008     D WWERR           S              1A
007600021008     D WWFIL           S             10A
007700021008     D WWFKA           S              8A
007800021008     D WWFKV           S                   LIKE(WIFKV)
007900021008     D WWFKY           S                   LIKE(WIFKV)
008000021008     D WWFLK           S            128A
008100021008     D WWFMTN          S              8A
008200021008     D WWFNC           S              8A
008300021008     D WWIJI           S             16A
008400021008     D WWIN            S             99A
008500021008     D WWLIB           S             10A
008600021008     D WWMSG           S             80A
008700021008     D WWMSGC          S              7A
008800021008     D WWOCD           S              8A
008900021008     D WWOPA           S              8A
009000021008     D WWOPN           S              1A
009100021008     D WWOPT           S              8A
009200021008     D WWOPV           S                   LIKE(WIFKV)
009300021008     D WWORQS          S                   LIKE(WIRQS)
009400021008     D WWPSNC          S              1A
009500021008     D WWQJN           S             26A
009600021008     D WWRQS           S                   LIKE(WIRQS)
009700021008     D WWRQSD          S                   LIKE(WIRQS)
009800021008     D WWRTN           S                   LIKE(WORTN)
009900021008     D WWRTND          S                   LIKE(WORTN)
010000021008     D WWRTNH          S                   LIKE(WORTN)
010100021008     D WWSFLE          S              1A
010200021008     D WWSTT           S              3A
010300021008     D WWTSK           S              8A
010400021008     D WWTXT           S             60A
010500021008     D WWUPD           S              1A
010600021008     D WWWRNF          S              1A
010700021008     D WWZERO          S             40A
010800021008     D WFRRN           S              4P 0
010900021008     D WW              S              3P 0
011000021008     D WWFKS           S              1P 0
011100021008     D WWFKSO          S                   LIKE(WWFKS)
011200021008     D WWLMT           S              2P 0
011300021008     D WWLNG           S             15P 5
011400021008     D WWLNGQ          S              5P 0
011500021008     D WWLOWR          S              4P 0
011600021008     D WWLSTS          S              2P 0
011700021008     D WWOPS           S              1P 0
011800021008     D WWOPSO          S                   LIKE(WWOPS)
011900021008     D WWPNL           S              1P 0
012000021008     D WWPNLN          S                   LIKE(WWPNL)
012100021008     D WWPNLO          S                   LIKE(WWPNL)
012200021008     D WWPSNI          S              2P 0
012300021008     D WWPSNN          S              1P 0
012400021008     D WWPSNP          S                   LIKE(WWPSNN)
012500021008     D WWRRN           S              4P 0
012600090317    ***
012700090317     D @TS40           S             40A
012800090317     D @TIMESTAMP      DS
012900090317     D  #TSCYMD                1      8S 0
013000090317     D  #TSTIME                9     14S 0
013100090317     D  @TSJOB                15     24
013200090317     D  @TSUSER               25     34
013300090317     D  #TSNBR                35     40S 0
013400161019
013500161019      *=============================================================================================
013600020304      *
013700020304      * Process Entry Panel
013800020304B1   C                   IF        WWTSK = 'COPY' OR WWTSK = 'CPYKEY'
013900020304     C                   Move      WUDTA         WWDTA
014000020304E1   C                   ENDIF
014100020304      *
014200090316     C                   EVAL      H@DTA = WUDTA
014300020304     C                   Exsr      PRPPNL
014400020304      *
014500020304B1   C                   DOW       WWSTT <> 'END'
014600020304     C                   Exsr      RCVMSG
014700020304     C                   Exsr      DSPPNL
014800020304     C                   Exsr      PRCFKY
014900020304      *
015000020304B2   C     WWFKA         Caseq     'KEYS    '    PRCDKY
015100020304     C     WWFKA         Caseq     'EXIT    '    PRCEXT
015200020304     C     WWFKA         Caseq     'PROMPT  '    PRCPMT
015300020304     C     WWFKA         Caseq     'REFRESH '    PRPPNL
015400020304     C     WWFKA         Caseq     'CANCEL  '    PRCCNL
015500020304     C     WWFKA         Caseq     'ROLLUP  '    PRCRUP
015600020304     C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN
015700020304     C     WWFKA         Caseq     'ENTER   '    PRCPNL
015800020304     C     WWFKA         Caseq     'UPDATE  '    PRCEXT
015900020304E2   C                   Endcs
016000020304      *
016100020304B2   C                   IF        WWSTT = 'END'
016200020304     C                   Exsr      PRCEND
016300020304E2   C                   Endif
016400020304E1   C                   Enddo
016500020304      *
016600020304      * Send Info Updated message.
016700020304     C                   IF        WWCHG = 'Y'
016800020304     C                   MOVEL     'UPDATE  '    WORTN
016900020304     C                   Endif
017000020304      *
017100020304     C                   Return
017200020304      *___________________________________________________________________
017300020304      * Prepare panel
017400020304      *___________________________________________________________________
017500020304     C     PRPPNL        Begsr
017600020304     C                   Move      *BLANKS       WORTN
017700020304     C                   Move      'N'           WWERR
017800020304     C                   Move      'N'           WWCHG
017900020304     C                   Move      'N'           WWWRNF
018000020304     C                   Move      *BLANKS       WWSTT
018100020304     C                   Z-add     1             WWPNL
018200020304     C                   Z-add     1             WWFKS
018300020304     C                   Movea     WWZERO        *IN(60)
018400020304     C                   Move      *BLANKS       WWSTT
018500090316      *
018600090316     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
018700090316     C                   IN        @DTA50
018800090316     C                   EVAL      WSNAME = %SUBST(@DTA50:1:40)
018900020304      *
019000020304B1   C                   IF        WQPGMN = WUPGM
019100020304B2   C                   IF        WIRQS <> WWORQS
019200020304     C                   Move      *BLANKS       WUPGM
019300020304E2   C                   Endif
019400020304     C                   Move      WIRQS         WWORQS
019500020304E1   C                   Endif
019600020304      *
019700020304     C                   Exsr      BLDFKY
019800020304      *
019900020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
020000020304     C     WWTSK         Caseq     'ADD     '    PRPADD
020100020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
020200020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
020300020304     C                   Cas                     PRCERR
020400020304E1   C                   Endcs
020500020304      *
020600020304      *
020700020304     C                   Endsr
020800020304      *___________________________________________________________________
020900020304      * Prepare ADD request
021000020304      *___________________________________________________________________
021100020304     C     PRPADD        Begsr
021200161017     C                   movel     *off          *in31
021300020304     C                   Clear                   WUDTA
021400100113     C                   EVAL      D_SMAN   = *BLANKS
021500100113     C                   EVAL      D_AGENCY = *BLANKS
021600100113     C                   EVAL      D_ANAME  = *BLANKS
021700100113     C                   EVAL      D_SUPER  = *BLANKS
021800100113     C                   EVAL      D_SNAME  = *BLANKS
021900020304     C                   Exsr      DFTDTA
022000020304     C                   Endsr
022100020304      *___________________________________________________________________
022200020304      * Prepare CHANGE request
022300020304      *___________________________________________________________________
022400020304     C     PRPCHG        Begsr
022500161017     C                   movel     *on           *in31
022600090311     C                   Call      'UPDSRE  '
022700020304     C                   Parm      'GET     '    WWRQS
022800020304     C                   Parm                    WWRTN
022900020304     C                   Parm                    WUDTA
023000020304B1   C                   IF        WWRTN <> *BLANKS
023100020304B2   C                   IF        WWRTN = 'NOTAVL'
023200020304     C                   Movel     WTM(5)        WWMSG
023300020304X2   C                   Else
023400020304     C                   Movel     WTM(4)        WWMSG
023500020304E2   C                   Endif
023600020304     C                   Exsr      SNDMSG
023700020304     C                   Move      'ERROR   '    WORTN
023800020304     C                   Move      'END'         WWSTT
023900020304E1   C                   End
024000020304     C                   Endsr
024100020304      *___________________________________________________________________
024200020304      * Prepare COPY request
024300020304      *___________________________________________________________________
024400020304     C     PRPCPY        Begsr
024500020304     C                   Move      WWDTA         WUDTA
024600090311     C                   Call      'UPDSRE  '
024700020304     C                   Parm      'GETNL   '    WWRQS
024800020304     C                   Parm                    WWRTN
024900020304     C                   Parm                    WUDTA
025000020304B1   C                   IF        WWRTN <> *BLANKS
025100020304     C                   Movel     WTM(4)        WWMSG
025200020304     C                   Exsr      SNDMSG
025300020304     C                   Move      'ERROR   '    WORTN
025400020304     C                   Move      'END'         WWSTT
025500020304X1   C                   Else
025600020304     C                   Move      'Y'           WWCHG
025700020304     ***                 Clear                   MSMSID
025800020304E1   C                   Endif
025900020304     C                   Endsr
026000020304      *___________________________________________________________________
026100020304      * Default Data
026200020304      *___________________________________________________________________
026300020304     C     DFTDTA        Begsr
026400090311     C                   Call      'CHKSRE  '
026500020304     C                   Parm      'DFTDTA'      WWRQS
026600020304     C                   Parm                    WWRTN
026700020304     C                   Parm                    WUDTA
026800020304B1   C                   IF        WWRTN <> *BLANKS
026900020304     C                   Movel     WTM(7)        WWMSG
027000020304     C                   Exsr      SNDMSG
027100020304     C                   Move      'ERROR   '    WORTN
027200020304     C                   Move      'END'         WWSTT
027300020304E1   C                   Endif
027400020304     C                   Endsr
027500020304      *___________________________________________________________________
027600020304      * Process ERROR function
027700020304      *___________________________________________________________________
027800020304     C     PRCERR        Begsr
027900020304     C                   Move      WTM(1)        WWMSG
028000020304     C                   Exsr      SNDMSG
028100020304     C                   Move      'ERROR   '    WORTN
028200020304     C                   Move      'END'         WWSTT
028300020304     C                   Endsr
028400020304      *___________________________________________________________________
028500020304      * Receive messages
028600020304      *___________________________________________________________________
028700020304     C     RCVMSG        Begsr
028800020304B1   C                   IF        WWMSGC <> 'NORESET'
028900020304     C                   Movel     'RECEIVE'     WWRQS
029000020304X1   C                   Else
029100020304     C                   Movel     'DISPLAY'     WWRQS
029200020304E1   C                   Endif
029300020304     C                   Movel     'RESET   '    WWMSGC
029400020304     C                   Movea     *IN           WWIN
029500020304     C                   Call      'PRCMSG2'
029600020304     C                   Parm                    WWRQS
029700020304     C                   Parm                    WWIN
029800020304     C                   Parm                    WWRTN
029900020304     C                   Movea     WWIN          *IN
030000020304     C                   Endsr
030100020304      *___________________________________________________________________
030200020304      * Display panels
030300020304      *___________________________________________________________________
030400020304     C     DSPPNL        Begsr
030500020304      *
030600020304      * Set PUTOVR based on last display file processed
030700020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
030800020304     C                   MOVE      *OFF          *IN35
030900020304     C                   Move      WQPGMN        WUPGM
031000020304     C                   Move      WWPNL         WWPNLO
031100020304X1   C                   Else
031200020304     C                   MOVE      *ON           *IN35
031300020304E1   C                   Endif
031400020304      *
031500020304      * Set PROTECT key based on request
031600020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
031700020304     C                             WWTSK = 'COPY  '
031800020304 001 C                   Setoff                                       40
031900020304X001 C                   Else
032000020304 001 C                   Seton                                        40
032100020304E001 C                   Endif
032200020304      *
032300020304      * Select title
032400020304     C                   IF        WWTSK = 'CHANGE'
032500020304 001 C                   MOVE      *OFF          *IN38
032600020304X001 C                   Else
032700020304 001 C                   MOVE      *ON           *IN38
032800020304E001 C                   Endif
032900020304      *
033000020304      * Position cursor based on error status
033100020304     C                   IF        WWERR = 'Y'
033200020304 001 C                   MOVE      *ON           *IN99
033300020304X001 C                   Else
033400020304 001 C                   MOVE      *OFF          *IN99
033500020304E001 C                   Endif
033600020304      *
033700020304      * Write message subfile
033800020304     C                   Seton                                        30
033900020304     C                   Write     MSGCTL
034000020304      *
034100020304      * Write entry panel
034200020304B001 C                   Select
034300020304     C                   WHEN      WWPNL = 1
034400090312     C                   EXSR      $GETDTA
034500020304 001 C                   Exfmt     ENTPNL
034600090312     C                   EXSR      $FMTDTA
034700200401 001 C* br01             Setoff                                       37
034800020304E001 C                   Endsl
034900020304      *
035000020304B001 C                   If        *IN39 = *ON
035100020304 001 C                   Move      'Y'           WWCHG
035200020304E001 C                   Endif
035300020304     C                   Endsr
035400090312   S***S
035500090312     C     $GETDTA       BEGSR
035600090312    ***
035700090312     C                   EVAL      D_SMAN   = *BLANKS
035800090312     C                   EVAL      D_AGENCY = *BLANKS
035900090312     C                   EVAL      D_ANAME  = *BLANKS
036000090312     C                   EVAL      D_SUPER  = *BLANKS
036100090312     C                   EVAL      D_SNAME  = *BLANKS
036200090312    ***
036300090312     C                   IF        SRSMAN <> *BLANKS
036400090312     C                   EVAL      @44 = SRSMAN
036500090312     C                   EVAL      %SUBST(@44:44:1) = 'S'
036600090312     C                   CALL      'RTVSAS'
036700090312     C                   PARM                    @44              44
036800090312     C                   EVAL      D_SMAN = %SUBST(@44:4:40)
036900090312     C                   ENDIF
037000090312    ***
037100090312     C                   IF        SREFFDTE <> 0
037200090312     C                   MOVE      SREFFDTE      #ISO
037300090312     C     *USA          MOVE      #ISO          SCEFFDTE
037400090312     C                   ELSE
037500090312     C                   EVAL      SCEFFDTE = 0
037600090312     C                   ENDIF
037700090312    ***
037800090312     C                   IF        SRTRMDTE <> 0
037900090312     C                   MOVE      SRTRMDTE      #ISO
038000090312     C     *USA          MOVE      #ISO          SCTRMDTE
038100090312     C                   ELSE
038200090312     C                   EVAL      SCTRMDTE = 0
038300090312     C                   ENDIF
038400090312    ***
038500090312     C                   IF        SRASID <> *BLANKS AND
038600090312     C                             SRASID <> '00000000'
038700090312     C     SRASID        CHAIN     SXF
038800090312     C                   IF        NOT %FOUND(SPRAGXR2)
038900090312     C                   LEAVESR
039000090312     C                   ENDIF
039100090312     C                   ENDIF
039200090312    ***
039300090312     C                   EVAL      @44 = SXAGCY
039400090312     C                   EVAL      %SUBST(@44:44:1) = 'A'
039500090312     C                   CALL      'RTVSAS'
039600090312     C                   PARM                    @44
039700090312     C                   EVAL      D_ANAME = %SUBST(@44:4:40)
039800090312     C                   EVAL      D_AGENCY = SXAGCY
039900090312    ***
040000090312     C                   EVAL      @44 = SXSUPER
040100090312     C                   EVAL      %SUBST(@44:44:1) = 'U'
040200090312     C                   CALL      'RTVSAS'
040300090312     C                   PARM                    @44
040400090312     C                   EVAL      D_SUPER  = SXSUPER
040500090312     C                   EVAL      D_SNAME  = %SUBST(@44:4:40)
040600090312    ***
040700090312     C                   ENDSR
040800090312   S***S
040900090312     C     $FMTDTA       BEGSR
041000090312    ***
041100090312     C                   IF        SCEFFDTE <> 0
041200090312     C     SCEFFDTE      MULT      10000.0001    SREFFDTE
041300090312     C                   ELSE
041400090312     C                   EVAL      SREFFDTE = 0
041500090312     C                   ENDIF
041600090312    ***
041700090312     C                   IF        SCTRMDTE <> 0
041800090312     C     SCTRMDTE      MULT      10000.0001    SRTRMDTE
041900090312     C                   ELSE
042000090312     C                   EVAL      SRTRMDTE = 0
042100090312     C                   ENDIF
042200090312    ***
042300090312     C                   ENDSR
042400090312   S***S
042500020304      *___________________________________________________________________
042600020304      * Process function key
042700020304      *___________________________________________________________________
042800020304     C     PRCFKY        Begsr
042900020304     C                   Movea     *IN           WWIN
043000020304     C                   Call      'PRCFKY2'
043100020304     C                   Parm      'PROCESS '    WWRQS
043200020304     C     WWFKA         Parm                    WWRTN
043300020304     C                   Parm                    WAD
043400020304     C                   Parm                    WWIN
043500020304     C                   Parm                    WAF
043600020304     C                   Parm                    WIFKV
043700020304     C                   Endsr
043800020304      *___________________________________________________________________
043900020304      * Process KEYS function
044000020304      *___________________________________________________________________
044100020304     C     PRCDKY        Begsr
044200020304     C                   Z-add     1             WW
044300020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
044400060317 001 C                   Add       1             WWFKS
044500020304 001  *
044600020304     C                   IF        WWFKS > 3
044700020304 002 C                   Z-add     1             WWFKS
044800020304E002 C                   Endif
044900020304 001  *
045000060317     C                   Eval      WW = WWFKS + WWFKS
045100020304 001 C                   Sub       1             WW
045200020304E001 C                   Enddo
045300020304      *
045400020304     C                   Movel     WAD(WW)       WSFKD1
045500020304     C                   Add       1             WW
045600020304     C                   Movel     WAD(WW)       WSFKD2
045700020304     C                   Endsr
045800020304      *___________________________________________________________________
045900020304      * Process EXIT Function
046000020304      *___________________________________________________________________
046100020304     C     PRCEXT        Begsr
046200020304      *
046300020304     C                   Exsr      PRCPNL
046400020304      *
046500020304     C                   IF        WWERR = 'Y'
046600020304 001 C                   Move      *BLANKS       WWSTT
046700020304X001 C                   Else
046800020304 001 C                   Movel     WWFKA         WORTN
046900020304 001 C                   Move      'END'         WWSTT
047000020304E001 C                   Endif
047100020304     C                   Endsr
047200020304      *___________________________________________________________________
047300020304      * Process PROMPT function
047400020304      *___________________________________________________________________
047500020304     C     PRCPMT        Begsr
047600200401
047700200401
047800020304     C                   Movel     WDCRSL        WWRQS
047900020304     C                   Move      'Y'           WWCHG
048000020304     C                   Move      'N'           WWWRNF
048100020304     C                   Movel     'NORESET '    WWMSGC
048200020304      *
048300020304B001 C                   Select
048400090311      *
048500090311 001 C                   When      WSFLD = 'SRASID'
048600090312     C                   Call      'SLCSXFCL'                                   *ENTRY LIST
048700090312     C                   Parm                    @30
048800090312     C                   IF        @30 <> '*LR'
048900090312     C                   Eval      SRASID = %SUBST(@30:23:8)
049000090311E001 C                   Endif
049100200401
049200200401
049300090311 001  *
049400090311 001 C                   When      WSFLD = 'SRSMAN'
049500090311     C                   Call      'SLCSMANCL'                                  *ENTRY LIST
049600090311     C                   Parm                    WWRQS                          PROGRAM REQUEST
049700090311     C                   Parm                    WWRTN                          RETURN CODE
049800090311     C                   Parm                    WUPGM                          LAST PGM NAME
049900090312     C                   Parm                    WDSMAN                         RECORD DS
050000020304     C                   IF        WWRTN = *BLANKS
050100090311     C                   Eval      SRSMAN = SMANCD
050200020304E001 C                   Endif
050300200401
050400020304 001  *
050500020304 001 C                   Other
050600020304 001 C                   Move      WTM(6)        WWMSG
050700020304 001 C                   Exsr      SNDMSG
050800020304E001 C                   Endsl
050900020304      *
051000020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
051100200401br01 C**                 Movel     WDCRSL        WWCRSL
051200200401br01 C**   WWCRSN        Div       256           WSROW
051300200401br01 C**                 Mvr                     WSLIN
051400200401br01 C**                 Seton                                        37
051500020304      *
051600020304     C                   Endsr
051700020304      *___________________________________________________________________
051800020304      * Process CANCEL Function
051900020304      *___________________________________________________________________
052000020304     C     PRCCNL        Begsr
052100020304     C                   Movel     WWFKA         WORTN
052200020304     C                   Move      'END'         WWSTT
052300020304     C                   Move      'N'           WWCHG
052400020304     C                   Endsr
052500020304      *___________________________________________________________________
052600020304      * Process ROLLUP function
052700020304      *___________________________________________________________________
052800020304     C     PRCRUP        Begsr
052900020304     C     WWPNL         Add       1             WWPNL
053000020304     C                   IF        WWPNL > WWPNLN
053100020304 001 C     WWPNL         Sub       1             WWPNL
053200020304E001 C                   Endif
053300020304     C                   Movel     'NORESET '    WWMSGC
053400020304     C                   Endsr
053500020304      *___________________________________________________________________
053600020304      * Process ROLLDOWN function
053700020304      *___________________________________________________________________
053800020304     C     PRCRDN        Begsr
053900020304     C     WWPNL         Sub       1             WWPNL
054000020304     C                   IF        WWPNL < 1
054100020304 001 C     WWPNL         Add       1             WWPNL
054200020304E001 C                   Endif
054300020304     C                   Movel     'NORESET '    WWMSGC
054400020304     C                   Endsr
054500020304      *___________________________________________________________________
054600020304      * Process ENTER function
054700020304      *___________________________________________________________________
054800020304     C     PRCPNL        Begsr
054900020304     C                   Move      *BLANKS       WWRTN
055000020304     C                   Movea     *ZEROS        *IN(60)
055100020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
055200020304 001 C                   Move      'N'           WWWRNF
055300020304     C                   IF        WWTSK = 'CHANGE  '
055400090311 001 C                   Call      'CHKSRE  '
055500020304 001 C                   Parm      'EDTCHG  '    WWRQS
055600020304 001 C                   Parm                    WWRTN
055700020304 001 C                   Parm                    WUDTA
055800020304     C                   ELSE
055900090311 001 C                   Call      'CHKSRE  '
056000020304 001 C                   Parm      'EDTADD  '    WWRQS
056100020304 001 C                   Parm                    WWRTN
056200020304 001 C                   Parm                    WUDTA
056300020304E001 C                   Endif
056400020304E001 C                   Endif
056500020304      *
056600020304B001 C                   Select
056700020304     C                   WHEN      WWRTN = *BLANKS
056800020304 001 C                   Move      'N'           WWERR
056900020304 001  *
057000020304     C                   WHEN      WWRTN = 'WARNING'
057100020304     C                   IF        WWWRNF = 'Y'
057200020304 002 C                   Move      'N'           WWERR
057300020304X002 C                   Else
057400020304 002 C                   Move      'Y'           WWWRNF
057500020304 002 C                   Move      'Y'           WWERR
057600020304E002 C                   Endif
057700020304 001  *
057800020304     C                   WHEN      WWRTN = 'ERROR  '
057900020304 001 C                   Move      'Y'           WWERR
058000020304 001 C                   Move      *BLANKS       WWSTT
058100020304 001 C                   Move      'N'           WWWRNF
058200020304E001 C                   Endsl
058300020304      *
058400020304     C                   Endsr
058500020304      *___________________________________________________________________
058600020304      * Process end - write data or release record
058700020304      *___________________________________________________________________
058800020304     C     PRCEND        Begsr
058900020304      *
059000020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
059100020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
059200020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
059300020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
059400020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
059500020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
059600020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
059700020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
059800020304 001 C                   Endcs
059900020304 001  *
060000020304     C                   IF        WWRTN <> *BLANKS
060100020304 002 C                   Move      *BLANKS       WWSTT
060200020304 002  *
060300020304X002 C                   Else
060400020304     C                   IF        WWFKA <> 'EXIT'
060500020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
060600020304 004 C                   Exsr      PRPPNL
060700020304E004 C                   Endif
060800020304E003 C                   Endif
060900020304E002 C                   Endif
061000020304 001  *
061100020304X001 C                   Else
061200020304 001 C                   Exsr      RELREC
061300020304E001 C                   Endif
061400020304      *
061500020304     C                   Endsr
061600020304      *___________________________________________________________________
061700020304      * Add new record
061800020304      *___________________________________________________________________
061900020304     C     WRTADD        Begsr
062000161017     C                   movel     *off          *in31
062100020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
062200020304     C                             WWTSK = 'COPY  '
062300020304 001 C                   Movel     'ADD    '     WWRQS
062400020304E001 C                   Endif
062500020304      *
062600020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
062700020304     C                             WWTSK = 'CPYKEY'
062800020304 001 C                   Movel     'ADDKEY '     WWRQS
062900020304E001 C                   Endif
063000020304      *
063100090311     C                   Call      'UPDSRE  '
063200020304     C                   Parm                    WWRQS
063300020304     C                   Parm                    WWRTN
063400020304     C                   Parm                    WUDTA
063500020304      *
063600020304     C                   IF        WWRTN <> *BLANKS
063700020304 001 C                   Movel     WTM(3)        WWMSG
063800020304 001 C                   Exsr      SNDMSG
063900020304X001 C                   Else
064000090317     C                   CLEAR                   RSRLHIST
064100090316    *C                   MOVE      *BLANKS       @TS40
064200090316    *C                   CALL      'TIMESTMP'
064300090316    *C                   PARM                    @TS40
064400090316    *C                   MOVEL     @TS40         @TIMESTAMP
064500090316    *C                   EVAL      HRELID = SRRELID
064600090316    *C                   EVAL      HJOB = @TSJOB
064700090316    *C                   EVAL      HUSERID = @TSUSER
064800090316    *C                   MOVE      #TSNBR        HNUMBER
064900090316    *C                   MOVE      #TSCYMD       HDATE
065000090316    *C                   MOVE      #TSTIME       HTIME
065100090316     C                   EVAL      HAFTER = WUDTA
065200090317     C                   EVAL      HMSG = %TRIM(HMSG@)
065300090316     C                   WRITE     RSRLHIST
065400020304E001 C                   Endif
065500020304      *
065600020304     C                   Endsr
065700020304      *___________________________________________________________________
065800020304      * Write changed record
065900020304      *___________________________________________________________________
066000020304     C     WRTCHG        Begsr
066100161017     C                   movel     *on           *in31
066200090311     C                   Call      'UPDSRE  '
066300020304     C                   Parm      'CHANGE'      WWRQS
066400020304     C                   Parm                    WWRTN
066500020304     C                   Parm                    WUDTA
066600020304     C                   IF        WWRTN <> *BLANKS
066700020304 001 C                   Movel     WTM(2)        WWMSG
066800020304 001 C                   Exsr      SNDMSG
066900090316     C                   ELSE
067000090317     C                   CLEAR                   RSRLHIST
067100090316     C                   EVAL      HBEFORE = H@DTA
067200090316    *C                   MOVE      *BLANKS       @TS40
067300090316    *C                   CALL      'TIMESTMP'
067400090316    *C                   PARM                    @TS40
067500090316    *C                   MOVEL     @TS40         @TIMESTAMP
067600090316    *C                   EVAL      HRELID = SRRELID
067700090316    *C                   EVAL      HJOB = @TSJOB
067800090316    *C                   EVAL      HUSERID = @TSUSER
067900090316    *C                   MOVE      #TSNBR        HNUMBER
068000090316    *C                   MOVE      #TSCYMD       HDATE
068100090316    *C                   MOVE      #TSTIME       HTIME
068200090317     C                   EVAL      HMSG = %TRIM(HMSG@)
068300090316     C                   EVAL      HAFTER = WUDTA
068400090316     C                   WRITE     RSRLHIST
068500020304E001 C                   Endif
068600020304      *
068700020304     C                   Endsr
068800020304      *___________________________________________________________________
068900020304      * Release record
069000020304      *___________________________________________________________________
069100020304     C     RELREC        Begsr
069200090311     C                   Call      'UPDSRE  '
069300020304     C                   Parm      'RELEASE '    WWRQS
069400020304     C                   Parm                    WWRTN
069500020304     C                   Parm                    WUDTA
069600020304     C                   IF        WWRTN <> *BLANKS
069700020304 001 C                   Movel     WTM(4)        WWMSG
069800020304 001 C                   Exsr      SNDMSG
069900020304E001 C                   Endif
070000020304     C                   Endsr
070100020304      *___________________________________________________________________
070200020304      * Build function keys
070300020304      *___________________________________________________________________
070400020304     C     BLDFKY        Begsr
070500020304     C                   Movea     *IN           WWIN
070600020304     C                   Call      'PRCFKY2'
070700020304     C                   Parm      'BUILD   '    WWRQS
070800020304     C     WWFKA         Parm                    WWRTN
070900020304     C                   Parm                    WAD
071000020304     C                   Parm                    WWIN
071100020304     C                   Parm                    WAF
071200020304     C                   Parm                    WIFKV
071300020304     C     WWFKS         Add       WWFKS         WW
071400020304     C                   Movel     WAD(WW)       WSFKD2
071500020304     C                   Sub       1             WW
071600020304     C                   Movel     WAD(WW)       WSFKD1
071700020304     C                   Endsr
071800020304      *___________________________________________________________________
071900020304      * Send message
072000020304      *___________________________________________________________________
072100020304     C     SNDMSG        Begsr
072200020304     C                   Call      'QSNDDTAQ'
072300020304     C                   Parm                    WWDTAQ
072400020304     C                   Parm                    WWLIB
072500020304     C                   Parm                    WWLNGQ
072600020304     C                   Parm                    WWMSG
072700020304     C                   Endsr
072800020304      *___________________________________________________________________
072900020304      * Paremater list
073000020304      *___________________________________________________________________
073100020304     C     PLIST         Begsr
073200020304     C     *ENTRY        Plist
073300020304     C     WWTSK         Parm                    WIRQS
073400020304     C                   Parm                    WORTN
073500020304     C                   Parm                    WUPGM
073600020304     C                   Parm                    WUDTA
073700020304     C                   Parm                    WIFKV
073800020304     C                   Endsr
073900020304      *___________________________________________________________________
074000020304      * Initialize routine
074100020304      *___________________________________________________________________
074200020304     C     *INZSR        Begsr
074300020304     C     *LIKE         Define    WUDTA         WWDTA
074400020304     C     *LIKE         Define    WIRQS         WWRQS
074500020304     C     *LIKE         Define    WIRQS         WWORQS
074600020304     C     *LIKE         Define    WIRQS         WWTSK
074700020304     C     *LIKE         Define    WORTN         WWRTN
074800020304     C     *LIKE         Define    WORTN         WWFKA
074900020304     C     *LIKE         Define    WIFKV         WWFKV
075000020304     C     *LIKE         Define    WIFKV         WWOPV
075100020304     C                   Movel     'RESET   '    WWMSGC
075200020304     C                   Movel     '*'           MSPGMQ
075300020304     C                   Movel     'MSGDTAQ'     WWDTAQ
075400020304     C                   Movel     'QTEMP'       WWLIB
075500020304     C                   Z-add     80            WWLNGQ
075600020304     C                   Move      *BLANKS       WWMSG
075700020304     C                   Move      *BLANKS       WWIN
075800020304     C                   Move      *BLANKS       WWSTT
075900020304     C                   Move      *ZEROS        WWZERO
076000020304     C                   Z-add     1             WWPNL
076100020304     C                   Z-add     1             WWPNLN
076200020304     C                   Z-add     1             WWFKS
076300020304     C                   Move      'N'           WWERR
076400020304     C                   Move      'N'           WWCHG
076500020304     C                   Move      'N'           WWWRNF
076600020304     C                   Z-add     0             WW
076700090311     C                   EVAL      WWFIL = 'SMANRLT'
076800020304     C                   Move      *BLANKS       WWFLK
076900020304     C                   Move      *BLANKS       WWTXT
077000020304     C                   Endsr
077100020304      *___________________________________________________________________
077200020304      * Program error handler
077300020304      *___________________________________________________________________
077400020304     C     *PSSR         Begsr
077500020304     C                   Call      'SNDRPGM'                            50
077600020304     C                   Parm                    WQPGMN
077700020304     C                   Parm                    WQSTSC
077800020304     C                   Parm                    WQRPGS
077900020304     C                   Parm                    WQMSG
078000020304     C                   Endsr     '*CANCL'
078100020304      *___________________________________________________________________
078200020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
07830002030403EXIT    F3=Exit
07840002030404PROMPT  F4=Prompt
07850002030405REFRESH F5=Refresh
07860002030410UPDATE  F10=Update
07870002030412CANCEL  F12=Cancel
07880002030425ROLLUP
07890002030426ROLLDOWN
079000020304** WTM
07910009031100Request not supported in program CHGSRE.
07920002030400Update error.  Data was not updated.
07930002030400Duplicate key detected.  Data was NOT added to file.
07940002030400Record not found.
07950002030400Record not available now.
07960002030400The cursor is not in a prompt area.
07970002030400Default error.  Data not defaulted.
