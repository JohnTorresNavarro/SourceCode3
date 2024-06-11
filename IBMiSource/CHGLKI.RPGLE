000100020304      *_________________________________________________________________________
000200020304      *
000300090317      *  Description:  Change LINK ID MAINT
000400020304      *
000500090204      *  (c)Copyright 2009 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700090317     FCHGLKID   CF   E             WORKSTN INFDS(DSPD)
000800020304      *
000900090318     D #ISO            S               D   DATFMT(*ISO)
001000090318     D @44             S             44A
001100020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001200020304     D WAD             S             80    DIM(6)
001300020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001400020304      *_________________________________________________________________________
001500020304      * Data structure
001600090317     D WUDTA         E DS                  EXTNAME(SPRAGXRF)
001700020304      *
001800020304      * Program status data structure
001900020304     D PGMD          ESDS                  EXTNAME(IOPGMD)
002000020304      *
002100020304      * Display file data structure
002200020304     D DSPD          E DS                  EXTNAME(IODSPD)
002300020304      *
002400020304      * CURSOR LOCATION
002500020304     D                 DS
002600020304     D  WWCRSL                 1      2
002700020304     D  WWCRSN                 1      2B 0
002800020304     ***
002900020304     D WWDTA           S                   LIKE(WUDTA)
003000021008     ***
003100021008     D WIFKV           S             60A
003200021008     D WIFKY           S                   LIKE(WIFKV)
003300021008     D WIOPV           S                   LIKE(WIFKV)
003400021008     D WIRQS           S              8A
003500021008     D WORTN           S              8A
003600021008     D WUPGM           S             10A
003700021008     D WWCHG           S              1A
003800021008     D WWDLT           S              1A
003900021008     D WWDTAQ          S             10A
004000021008     D WWENDF          S              3A
004100021008     D WWENDO          S                   LIKE(WWENDF)
004200021008     D WWERR           S              1A
004300021008     D WWFIL           S             10A
004400021008     D WWFKA           S              8A
004500021008     D WWFKV           S                   LIKE(WIFKV)
004600021008     D WWFKY           S                   LIKE(WIFKV)
004700021008     D WWFLK           S            128A
004800021008     D WWFMTN          S              8A
004900021008     D WWFNC           S              8A
005000021008     D WWIJI           S             16A
005100021008     D WWIN            S             99A
005200021008     D WWLIB           S             10A
005300021008     D WWMSG           S             80A
005400021008     D WWMSGC          S              7A
005500021008     D WWOCD           S              8A
005600021008     D WWOPA           S              8A
005700021008     D WWOPN           S              1A
005800021008     D WWOPT           S              8A
005900021008     D WWOPV           S                   LIKE(WIFKV)
006000021008     D WWORQS          S                   LIKE(WIRQS)
006100021008     D WWPSNC          S              1A
006200021008     D WWQJN           S             26A
006300021008     D WWRQS           S                   LIKE(WIRQS)
006400021008     D WWRQSD          S                   LIKE(WIRQS)
006500021008     D WWRTN           S                   LIKE(WORTN)
006600021008     D WWRTND          S                   LIKE(WORTN)
006700021008     D WWRTNH          S                   LIKE(WORTN)
006800021008     D WWSFLE          S              1A
006900021008     D WWSTT           S              3A
007000021008     D WWTSK           S              8A
007100021008     D WWTXT           S             60A
007200021008     D WWUPD           S              1A
007300021008     D WWWRNF          S              1A
007400021008     D WWZERO          S             40A
007500021008     D WFRRN           S              4P 0
007600021008     D WW              S              3P 0
007700021008     D WWFKS           S              1P 0
007800021008     D WWFKSO          S                   LIKE(WWFKS)
007900021008     D WWLMT           S              2P 0
008000021008     D WWLNG           S             15P 5
008100021008     D WWLNGQ          S              5P 0
008200021008     D WWLOWR          S              4P 0
008300021008     D WWLSTS          S              2P 0
008400021008     D WWOPS           S              1P 0
008500021008     D WWOPSO          S                   LIKE(WWOPS)
008600021008     D WWPNL           S              1P 0
008700021008     D WWPNLN          S                   LIKE(WWPNL)
008800021008     D WWPNLO          S                   LIKE(WWPNL)
008900021008     D WWPSNI          S              2P 0
009000021008     D WWPSNN          S              1P 0
009100021008     D WWPSNP          S                   LIKE(WWPSNN)
009200021008     D WWRRN           S              4P 0
009300020304     ***
009400020304      *_________________________________________________________________________
009500020304      *
009600020304      * Process Entry Panel
009700020304B1   C                   IF        WWTSK = 'COPY' OR WWTSK = 'CPYKEY'
009800020304     C                   Move      WUDTA         WWDTA
009900020304E1   C                   ENDIF
010000020304      *
010100020304     C                   Exsr      PRPPNL
010200020304      *
010300020304B1   C                   DOW       WWSTT <> 'END'
010400020304     C                   Exsr      RCVMSG
010500020304     C                   Exsr      DSPPNL
010600020304     C                   Exsr      PRCFKY
010700020304      *
010800020304B2   C     WWFKA         Caseq     'KEYS    '    PRCDKY
010900020304     C     WWFKA         Caseq     'EXIT    '    PRCEXT
011000020304     C     WWFKA         Caseq     'PROMPT  '    PRCPMT
011100020304     C     WWFKA         Caseq     'REFRESH '    PRPPNL
011200020304     C     WWFKA         Caseq     'CANCEL  '    PRCCNL
011300020304     C     WWFKA         Caseq     'ROLLUP  '    PRCRUP
011400020304     C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN
011500020304     C     WWFKA         Caseq     'ENTER   '    PRCPNL
011600020304     C     WWFKA         Caseq     'UPDATE  '    PRCEXT
011700020304E2   C                   Endcs
011800020304      *
011900020304B2   C                   IF        WWSTT = 'END'
012000020304     C                   Exsr      PRCEND
012100020304E2   C                   Endif
012200020304E1   C                   Enddo
012300020304      *
012400020304      * Send Info Updated message.
012500020304     C                   IF        WWCHG = 'Y'
012600020304     C                   MOVEL     'UPDATE  '    WORTN
012700020304     C                   Endif
012800020304      *
012900020304     C                   Return
013000020304      *___________________________________________________________________
013100020304      * Prepare panel
013200020304      *___________________________________________________________________
013300020304     C     PRPPNL        Begsr
013400020304     C                   Move      *BLANKS       WORTN
013500020304     C                   Move      'N'           WWERR
013600020304     C                   Move      'N'           WWCHG
013700020304     C                   Move      'N'           WWWRNF
013800020304     C                   Move      *BLANKS       WWSTT
013900020304     C                   Z-add     1             WWPNL
014000020304     C                   Z-add     1             WWFKS
014100020304     C                   Movea     WWZERO        *IN(60)
014200020304     C                   Move      *BLANKS       WWSTT
014300020304      *
014400090317     C     *DTAARA       DEFINE    COMPANY       @DTA50           50
014500090317     C                   IN        @DTA50
014600090317     C                   EVAL      WSNAME = %SUBST(@DTA50:1:40)
014700090317      *
014800020304B1   C                   IF        WQPGMN = WUPGM
014900020304B2   C                   IF        WIRQS <> WWORQS
015000020304     C                   Move      *BLANKS       WUPGM
015100020304E2   C                   Endif
015200020304     C                   Move      WIRQS         WWORQS
015300020304E1   C                   Endif
015400020304      *
015500020304     C                   Exsr      BLDFKY
015600020304      *
015700020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
015800020304     C     WWTSK         Caseq     'ADD     '    PRPADD
015900020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
016000020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
016100020304     C                   Cas                     PRCERR
016200020304E1   C                   Endcs
016300020304      *
016400020304      *
016500020304     C                   Endsr
016600020304      *___________________________________________________________________
016700020304      * Prepare ADD request
016800020304      *___________________________________________________________________
016900020304     C     PRPADD        Begsr
017000020304     C                   Clear                   WUDTA
017100100113     C                   EVAL      D_AGENCY = *BLANKS
017200100113     C                   EVAL      D_SUPER  = *BLANKS
017300100113    ***
017400020304     C                   Exsr      DFTDTA
017500020304     C                   Endsr
017600020304      *___________________________________________________________________
017700020304      * Prepare CHANGE request
017800020304      *___________________________________________________________________
017900020304     C     PRPCHG        Begsr
018000090317     C                   Call      'UPDLKI  '
018100020304     C                   Parm      'GET     '    WWRQS
018200020304     C                   Parm                    WWRTN
018300020304     C                   Parm                    WUDTA
018400020304B1   C                   IF        WWRTN <> *BLANKS
018500020304B2   C                   IF        WWRTN = 'NOTAVL'
018600020304     C                   Movel     WTM(5)        WWMSG
018700020304X2   C                   Else
018800020304     C                   Movel     WTM(4)        WWMSG
018900020304E2   C                   Endif
019000020304     C                   Exsr      SNDMSG
019100020304     C                   Move      'ERROR   '    WORTN
019200020304     C                   Move      'END'         WWSTT
019300020304E1   C                   End
019400020304     C                   Endsr
019500020304      *___________________________________________________________________
019600020304      * Prepare COPY request
019700020304      *___________________________________________________________________
019800020304     C     PRPCPY        Begsr
019900020304     C                   Move      WWDTA         WUDTA
020000090317     C                   Call      'UPDLKI  '
020100020304     C                   Parm      'GETNL   '    WWRQS
020200020304     C                   Parm                    WWRTN
020300020304     C                   Parm                    WUDTA
020400020304B1   C                   IF        WWRTN <> *BLANKS
020500020304     C                   Movel     WTM(4)        WWMSG
020600020304     C                   Exsr      SNDMSG
020700020304     C                   Move      'ERROR   '    WORTN
020800020304     C                   Move      'END'         WWSTT
020900020304X1   C                   Else
021000020304     C                   Move      'Y'           WWCHG
021100020304     ***                 Clear                   MSMSID
021200020304E1   C                   Endif
021300020304     C                   Endsr
021400020304      *___________________________________________________________________
021500020304      * Default Data
021600020304      *___________________________________________________________________
021700020304     C     DFTDTA        Begsr
021800090317     C                   Call      'CHKLKI  '
021900020304     C                   Parm      'DFTDTA'      WWRQS
022000020304     C                   Parm                    WWRTN
022100020304     C                   Parm                    WUDTA
022200020304B1   C                   IF        WWRTN <> *BLANKS
022300020304     C                   Movel     WTM(7)        WWMSG
022400020304     C                   Exsr      SNDMSG
022500020304     C                   Move      'ERROR   '    WORTN
022600020304     C                   Move      'END'         WWSTT
022700020304E1   C                   Endif
022800020304     C                   Endsr
022900020304      *___________________________________________________________________
023000020304      * Process ERROR function
023100020304      *___________________________________________________________________
023200020304     C     PRCERR        Begsr
023300020304     C                   Move      WTM(1)        WWMSG
023400020304     C                   Exsr      SNDMSG
023500020304     C                   Move      'ERROR   '    WORTN
023600020304     C                   Move      'END'         WWSTT
023700020304     C                   Endsr
023800020304      *___________________________________________________________________
023900020304      * Receive messages
024000020304      *___________________________________________________________________
024100020304     C     RCVMSG        Begsr
024200020304B1   C                   IF        WWMSGC <> 'NORESET'
024300020304     C                   Movel     'RECEIVE'     WWRQS
024400020304X1   C                   Else
024500020304     C                   Movel     'DISPLAY'     WWRQS
024600020304E1   C                   Endif
024700020304     C                   Movel     'RESET   '    WWMSGC
024800020304     C                   Movea     *IN           WWIN
024900020304     C                   Call      'PRCMSG2'
025000020304     C                   Parm                    WWRQS
025100020304     C                   Parm                    WWIN
025200020304     C                   Parm                    WWRTN
025300020304     C                   Movea     WWIN          *IN
025400020304     C                   Endsr
025500020304      *___________________________________________________________________
025600020304      * Display panels
025700020304      *___________________________________________________________________
025800020304     C     DSPPNL        Begsr
025900020304      *
026000020304      * Set PUTOVR based on last display file processed
026100020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
026200020304     C                   MOVE      *OFF          *IN35
026300020304     C                   Move      WQPGMN        WUPGM
026400020304     C                   Move      WWPNL         WWPNLO
026500020304X1   C                   Else
026600020304     C                   MOVE      *ON           *IN35
026700020304E1   C                   Endif
026800020304      *
026900020304      * Set PROTECT key based on request
027000020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
027100020304     C                             WWTSK = 'COPY  '
027200020304 001 C                   Setoff                                       40
027300020304X001 C                   Else
027400020304 001 C                   Seton                                        40
027500020304E001 C                   Endif
027600020304      *
027700020304      * Select title
027800020304     C                   IF        WWTSK = 'CHANGE'
027900020304 001 C                   MOVE      *OFF          *IN38
028000020304X001 C                   Else
028100020304 001 C                   MOVE      *ON           *IN38
028200020304E001 C                   Endif
028300020304      *
028400020304      * Position cursor based on error status
028500020304     C                   IF        WWERR = 'Y'
028600020304 001 C                   MOVE      *ON           *IN99
028700020304X001 C                   Else
028800020304 001 C                   MOVE      *OFF          *IN99
028900020304E001 C                   Endif
029000020304      *
029100020304      * Write message subfile
029200020304     C                   Seton                                        30
029300020304     C                   Write     MSGCTL
029400020304      *
029500020304      * Write entry panel
029600020304B001 C                   Select
029700020304     C                   WHEN      WWPNL = 1
029800090317     C                   EXSR      $GETDTA
029900020304 001 C                   Exfmt     ENTPNL
030000090317     C                   EXSR      $FMTDTA
030100020304 001 C                   Setoff                                       37
030200020304E001 C                   Endsl
030300020304      *
030400020304B001 C                   If        *IN39 = *ON
030500020304 001 C                   Move      'Y'           WWCHG
030600020304E001 C                   Endif
030700020304     C                   Endsr
030800090317   S***S
030900090317     C     $GETDTA       Begsr
031000090317    ***
031100090317     C                   EVAL      D_AGENCY = *BLANKS
031200090317     C                   EVAL      D_SUPER  = *BLANKS
031300090317    ***
031400090317     C                   IF        SXEFFDTE <> 0
031500090317     C                   MOVE      SXEFFDTE      #ISO
031600090317     C     *USA          MOVE      #ISO          SCEFFDTE
031700090317     C                   ELSE
031800090317     C                   EVAL      SCEFFDTE = 0
031900090317     C                   ENDIF
032000090317    ***
032100090317     C                   IF        SXTRMDTE <> 0
032200090317     C                   MOVE      SXTRMDTE      #ISO
032300090317     C     *USA          MOVE      #ISO          SCTRMDTE
032400090317     C                   ELSE
032500090317     C                   EVAL      SCTRMDTE = 0
032600090317     C                   ENDIF
032700090317    ***
032800090317     C                   IF        SXAGCY <> *BLANKS
032900090317     C                   EVAL      @44 = SXAGCY
033000090317     C                   EVAL      %SUBST(@44:44:1) = 'A'
033100090317     C                   CALL      'RTVSAS'
033200090317     C                   PARM                    @44
033300090317     C                   EVAL      D_AGENCY = %SUBST(@44:4:40)
033400090317     C                   ENDIF
033500090317    ***
033600090317     C                   IF        SXSUPER <> *BLANKS
033700090317     C                   EVAL      @44 = SXSUPER
033800090317     C                   EVAL      %SUBST(@44:44:1) = 'U'
033900090317     C                   CALL      'RTVSAS'
034000090317     C                   PARM                    @44
034100090317     C                   EVAL      D_SUPER  = %SUBST(@44:4:40)
034200090317     C                   ENDIF
034300090317    ***
034400090317     C                   ENDSR
034500090317   S***S
034600090317     C     $FMTDTA       BEGSR
034700090317    ***
034800090317     C                   IF        SCEFFDTE <> 0
034900090317     C     SCEFFDTE      MULT      10000.0001    SXEFFDTE
035000090317     C                   ELSE
035100090317     C                   EVAL      SXEFFDTE = 0
035200090317     C                   ENDIF
035300090317    ***
035400090317     C                   IF        SCTRMDTE <> 0
035500090317     C     SCTRMDTE      MULT      10000.0001    SXTRMDTE
035600090317     C                   ELSE
035700090317     C                   EVAL      SXTRMDTE = 0
035800090317     C                   ENDIF
035900090317    ***
036000090317     C                   Endsr
036100090317   S***S
036200020304      *___________________________________________________________________
036300020304      * Process function key
036400020304      *___________________________________________________________________
036500020304     C     PRCFKY        Begsr
036600020304     C                   Movea     *IN           WWIN
036700020304     C                   Call      'PRCFKY2'
036800020304     C                   Parm      'PROCESS '    WWRQS
036900020304     C     WWFKA         Parm                    WWRTN
037000020304     C                   Parm                    WAD
037100020304     C                   Parm                    WWIN
037200020304     C                   Parm                    WAF
037300020304     C                   Parm                    WIFKV
037400020304     C                   Endsr
037500020304      *___________________________________________________________________
037600020304      * Process KEYS function
037700020304      *___________________________________________________________________
037800020304     C     PRCDKY        Begsr
037900020304     C                   Z-add     1             WW
038000020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
038100060317 001 C                   Add       1             WWFKS
038200020304 001  *
038300020304     C                   IF        WWFKS > 3
038400020304 002 C                   Z-add     1             WWFKS
038500020304E002 C                   Endif
038600020304 001  *
038700060317     C                   Eval      WW = WWFKS + WWFKS
038800020304 001 C                   Sub       1             WW
038900020304E001 C                   Enddo
039000020304      *
039100020304     C                   Movel     WAD(WW)       WSFKD1
039200020304     C                   Add       1             WW
039300020304     C                   Movel     WAD(WW)       WSFKD2
039400020304     C                   Endsr
039500020304      *___________________________________________________________________
039600020304      * Process EXIT Function
039700020304      *___________________________________________________________________
039800020304     C     PRCEXT        Begsr
039900020304      *
040000020304     C                   Exsr      PRCPNL
040100020304      *
040200020304     C                   IF        WWERR = 'Y'
040300020304 001 C                   Move      *BLANKS       WWSTT
040400020304X001 C                   Else
040500020304 001 C                   Movel     WWFKA         WORTN
040600020304 001 C                   Move      'END'         WWSTT
040700020304E001 C                   Endif
040800020304     C                   Endsr
040900020304      *___________________________________________________________________
041000020304      * Process PROMPT function
041100020304      *___________________________________________________________________
041200020304     C     PRCPMT        Begsr
041300020304     C                   Movel     WDCRSL        WWRQS
041400020304     C                   Move      'Y'           WWCHG
041500020304     C                   Move      'N'           WWWRNF
041600020304     C                   Movel     'NORESET '    WWMSGC
041700020304      *
041800020304B001 C                   Select
041900020304 001 C                   When      WSFLD = 'XXXXXX'
042000020304     C*                  Call      'SLCCRM'                                     *ENTRY LIST
042100040305     C*                  Parm                    WWRQS                          PROGRAM REQUEST
042200040305     C*                  Parm                    WWRTN                          RETURN CODE
042300040305     C*                  Parm                    WUPGM                          LAST PGM NAME
042400020304     C*                  Parm                    WDCARP                         RECORD DS
042500020304     C                   IF        WWRTN = *BLANKS
042600020304     C*                  Eval      MSCAID   =    CMCARR
042700020304     C*                  EVAL      WSCNAME  =    CMNAME
042800020304E001 C                   Endif
042900020304 001  *
043000020304 001 C                   Other
043100020304 001 C                   Move      WTM(6)        WWMSG
043200020304 001 C                   Exsr      SNDMSG
043300020304E001 C                   Endsl
043400020304      *
043500020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
043600020304     C                   Movel     WDCRSL        WWCRSL
043700020304     C     WWCRSN        Div       256           WSROW
043800020304     C                   Mvr                     WSLIN
043900020304     C                   Seton                                        37
044000020304      *
044100020304     C                   Endsr
044200020304      *___________________________________________________________________
044300020304      * Process CANCEL Function
044400020304      *___________________________________________________________________
044500020304     C     PRCCNL        Begsr
044600020304     C                   Movel     WWFKA         WORTN
044700020304     C                   Move      'END'         WWSTT
044800020304     C                   Move      'N'           WWCHG
044900020304     C                   Endsr
045000020304      *___________________________________________________________________
045100020304      * Process ROLLUP function
045200020304      *___________________________________________________________________
045300020304     C     PRCRUP        Begsr
045400020304     C     WWPNL         Add       1             WWPNL
045500020304     C                   IF        WWPNL > WWPNLN
045600020304 001 C     WWPNL         Sub       1             WWPNL
045700020304E001 C                   Endif
045800020304     C                   Movel     'NORESET '    WWMSGC
045900020304     C                   Endsr
046000020304      *___________________________________________________________________
046100020304      * Process ROLLDOWN function
046200020304      *___________________________________________________________________
046300020304     C     PRCRDN        Begsr
046400020304     C     WWPNL         Sub       1             WWPNL
046500020304     C                   IF        WWPNL < 1
046600020304 001 C     WWPNL         Add       1             WWPNL
046700020304E001 C                   Endif
046800020304     C                   Movel     'NORESET '    WWMSGC
046900020304     C                   Endsr
047000020304      *___________________________________________________________________
047100020304      * Process ENTER function
047200020304      *___________________________________________________________________
047300020304     C     PRCPNL        Begsr
047400020304     C                   Move      *BLANKS       WWRTN
047500020304     C                   Movea     *ZEROS        *IN(60)
047600020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
047700020304 001 C                   Move      'N'           WWWRNF
047800020304     C                   IF        WWTSK = 'CHANGE  '
047900090317 001 C                   Call      'CHKLKI  '
048000020304 001 C                   Parm      'EDTCHG  '    WWRQS
048100020304 001 C                   Parm                    WWRTN
048200020304 001 C                   Parm                    WUDTA
048300020304     C                   ELSE
048400090317 001 C                   Call      'CHKLKI  '
048500020304 001 C                   Parm      'EDTADD  '    WWRQS
048600020304 001 C                   Parm                    WWRTN
048700020304 001 C                   Parm                    WUDTA
048800020304E001 C                   Endif
048900020304E001 C                   Endif
049000020304      *
049100020304B001 C                   Select
049200020304     C                   WHEN      WWRTN = *BLANKS
049300020304 001 C                   Move      'N'           WWERR
049400020304 001  *
049500020304     C                   WHEN      WWRTN = 'WARNING'
049600020304     C                   IF        WWWRNF = 'Y'
049700020304 002 C                   Move      'N'           WWERR
049800020304X002 C                   Else
049900020304 002 C                   Move      'Y'           WWWRNF
050000020304 002 C                   Move      'Y'           WWERR
050100020304E002 C                   Endif
050200020304 001  *
050300020304     C                   WHEN      WWRTN = 'ERROR  '
050400020304 001 C                   Move      'Y'           WWERR
050500020304 001 C                   Move      *BLANKS       WWSTT
050600020304 001 C                   Move      'N'           WWWRNF
050700020304E001 C                   Endsl
050800020304      *
050900020304     C                   Endsr
051000020304      *___________________________________________________________________
051100020304      * Process end - write data or release record
051200020304      *___________________________________________________________________
051300020304     C     PRCEND        Begsr
051400020304      *
051500020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
051600020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
051700020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
051800020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
051900020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
052000020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
052100020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
052200020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
052300020304 001 C                   Endcs
052400020304 001  *
052500020304     C                   IF        WWRTN <> *BLANKS
052600020304 002 C                   Move      *BLANKS       WWSTT
052700020304 002  *
052800020304X002 C                   Else
052900020304     C                   IF        WWFKA <> 'EXIT'
053000020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
053100020304 004 C                   Exsr      PRPPNL
053200020304E004 C                   Endif
053300020304E003 C                   Endif
053400020304E002 C                   Endif
053500020304 001  *
053600020304X001 C                   Else
053700020304 001 C                   Exsr      RELREC
053800020304E001 C                   Endif
053900020304      *
054000020304     C                   Endsr
054100020304      *___________________________________________________________________
054200020304      * Add new record
054300020304      *___________________________________________________________________
054400020304     C     WRTADD        Begsr
054500020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
054600020304     C                             WWTSK = 'COPY  '
054700020304 001 C                   Movel     'ADD    '     WWRQS
054800020304E001 C                   Endif
054900020304      *
055000020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
055100020304     C                             WWTSK = 'CPYKEY'
055200020304 001 C                   Movel     'ADDKEY '     WWRQS
055300020304E001 C                   Endif
055400020304      *
055500090317     C                   Call      'UPDLKI  '
055600020304     C                   Parm                    WWRQS
055700020304     C                   Parm                    WWRTN
055800020304     C                   Parm                    WUDTA
055900020304      *
056000020304     C                   IF        WWRTN <> *BLANKS
056100020304 001 C                   Movel     WTM(3)        WWMSG
056200020304 001 C                   Exsr      SNDMSG
056300020304X001 C                   Else
056400020304E001 C                   Endif
056500020304      *
056600020304     C                   Endsr
056700020304      *___________________________________________________________________
056800020304      * Write changed record
056900020304      *___________________________________________________________________
057000020304     C     WRTCHG        Begsr
057100090317     C                   Call      'UPDLKI  '
057200020304     C                   Parm      'CHANGE'      WWRQS
057300020304     C                   Parm                    WWRTN
057400020304     C                   Parm                    WUDTA
057500020304     C                   IF        WWRTN <> *BLANKS
057600020304 001 C                   Movel     WTM(2)        WWMSG
057700020304 001 C                   Exsr      SNDMSG
057800020304E001 C                   Endif
057900020304      *
058000020304     C                   Endsr
058100020304      *___________________________________________________________________
058200020304      * Release record
058300020304      *___________________________________________________________________
058400020304     C     RELREC        Begsr
058500090317     C                   Call      'UPDLKI  '
058600020304     C                   Parm      'RELEASE '    WWRQS
058700020304     C                   Parm                    WWRTN
058800020304     C                   Parm                    WUDTA
058900020304     C                   IF        WWRTN <> *BLANKS
059000020304 001 C                   Movel     WTM(4)        WWMSG
059100020304 001 C                   Exsr      SNDMSG
059200020304E001 C                   Endif
059300020304     C                   Endsr
059400020304      *___________________________________________________________________
059500020304      * Build function keys
059600020304      *___________________________________________________________________
059700020304     C     BLDFKY        Begsr
059800020304     C                   Movea     *IN           WWIN
059900020304     C                   Call      'PRCFKY2'
060000020304     C                   Parm      'BUILD   '    WWRQS
060100020304     C     WWFKA         Parm                    WWRTN
060200020304     C                   Parm                    WAD
060300020304     C                   Parm                    WWIN
060400020304     C                   Parm                    WAF
060500020304     C                   Parm                    WIFKV
060600020304     C     WWFKS         Add       WWFKS         WW
060700020304     C                   Movel     WAD(WW)       WSFKD2
060800020304     C                   Sub       1             WW
060900020304     C                   Movel     WAD(WW)       WSFKD1
061000020304     C                   Endsr
061100020304      *___________________________________________________________________
061200020304      * Send message
061300020304      *___________________________________________________________________
061400020304     C     SNDMSG        Begsr
061500020304     C                   Call      'QSNDDTAQ'
061600020304     C                   Parm                    WWDTAQ
061700020304     C                   Parm                    WWLIB
061800020304     C                   Parm                    WWLNGQ
061900020304     C                   Parm                    WWMSG
062000020304     C                   Endsr
062100020304      *___________________________________________________________________
062200020304      * Paremater list
062300020304      *___________________________________________________________________
062400020304     C     PLIST         Begsr
062500020304     C     *ENTRY        Plist
062600020304     C     WWTSK         Parm                    WIRQS
062700020304     C                   Parm                    WORTN
062800020304     C                   Parm                    WUPGM
062900020304     C                   Parm                    WUDTA
063000020304     C                   Parm                    WIFKV
063100020304     C                   Endsr
063200020304      *___________________________________________________________________
063300020304      * Initialize routine
063400020304      *___________________________________________________________________
063500020304     C     *INZSR        Begsr
063600020304     C     *LIKE         Define    WUDTA         WWDTA
063700020304     C     *LIKE         Define    WIRQS         WWRQS
063800020304     C     *LIKE         Define    WIRQS         WWORQS
063900020304     C     *LIKE         Define    WIRQS         WWTSK
064000020304     C     *LIKE         Define    WORTN         WWRTN
064100020304     C     *LIKE         Define    WORTN         WWFKA
064200020304     C     *LIKE         Define    WIFKV         WWFKV
064300020304     C     *LIKE         Define    WIFKV         WWOPV
064400020304     C                   Movel     'RESET   '    WWMSGC
064500020304     C                   Movel     '*'           MSPGMQ
064600020304     C                   Movel     'MSGDTAQ'     WWDTAQ
064700020304     C                   Movel     'QTEMP'       WWLIB
064800020304     C                   Z-add     80            WWLNGQ
064900020304     C                   Move      *BLANKS       WWMSG
065000020304     C                   Move      *BLANKS       WWIN
065100020304     C                   Move      *BLANKS       WWSTT
065200020304     C                   Move      *ZEROS        WWZERO
065300020304     C                   Z-add     1             WWPNL
065400020304     C                   Z-add     1             WWPNLN
065500020304     C                   Z-add     1             WWFKS
065600020304     C                   Move      'N'           WWERR
065700020304     C                   Move      'N'           WWCHG
065800020304     C                   Move      'N'           WWWRNF
065900090317     C                   Z-add     0             WW
066000090317     C                   Movel(P)  'SPRAGXRF'    WWFIL
066100020304     C                   Move      *BLANKS       WWFLK
066200020304     C                   Move      *BLANKS       WWTXT
066300020304     C                   Endsr
066400020304      *___________________________________________________________________
066500020304      * Program error handler
066600020304      *___________________________________________________________________
066700020304     C     *PSSR         Begsr
066800020304     C                   Call      'SNDRPGM'                            50
066900020304     C                   Parm                    WQPGMN
067000020304     C                   Parm                    WQSTSC
067100020304     C                   Parm                    WQRPGS
067200020304     C                   Parm                    WQMSG
067300020304     C                   Endsr     '*CANCL'
067400020304      *___________________________________________________________________
067500020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06760002030403EXIT    F3=Exit
06770002030404PROMPT  F4=Prompt
06780002030405REFRESH F5=Refresh
06790002030410UPDATE  F10=Update
06800002030412CANCEL  F12=Cancel
06810002030425ROLLUP
06820002030426ROLLDOWN
068300020304** WTM
06840009031700Request not supported in program CHGLKI.
06850002030400Update error.  Data was not updated.
06860002030400Duplicate key detected.  Data was NOT added to file.
06870002030400Record not found.
06880002030400Record not available now.
06890002030400The cursor is not in a prompt area.
06900002030400Default error.  Data not defaulted.
