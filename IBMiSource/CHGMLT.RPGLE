000100020304      *_________________________________________________________________________
000200020304      *
000300130131      *  Description:  Change MEMBER ALTERNATE ID
000400020304      *
000500130131      *  (c)Copyright 2013 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700130131     FCHGMLTD   CF   E             WORKSTN INFDS(DSPD)
000800020304      *
000900020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001000020304     D WAD             S             80    DIM(6)
001100020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001200020304      *_________________________________________________________________________
001300020304      * Data structure
001400130131     D WUDTA         E DS                  EXTNAME(MEMALT)
001500130131      *
001600020304      * Program status data structure
001700020304     D PGMD          ESDS                  EXTNAME(IOPGMD)
001800020304      *
001900020304      * Display file data structure
002000020304     D DSPD          E DS                  EXTNAME(IODSPD)
002100020304      *
002200020304      * CURSOR LOCATION
002300020304     D                 DS
002400020304     D  WWCRSL                 1      2
002500020304     D  WWCRSN                 1      2B 0
002600020304     ***
002700020304     D WWDTA           S                   LIKE(WUDTA)
002800021008     ***
002900021008     D WIFKV           S             60A
003000021008     D WIFKY           S                   LIKE(WIFKV)
003100021008     D WIOPV           S                   LIKE(WIFKV)
003200021008     D WIRQS           S              8A
003300021008     D WORTN           S              8A
003400021008     D WUPGM           S             10A
003500021008     D WWCHG           S              1A
003600021008     D WWDLT           S              1A
003700021008     D WWDTAQ          S             10A
003800021008     D WWENDF          S              3A
003900021008     D WWENDO          S                   LIKE(WWENDF)
004000021008     D WWERR           S              1A
004100021008     D WWFIL           S             10A
004200021008     D WWFKA           S              8A
004300021008     D WWFKV           S                   LIKE(WIFKV)
004400021008     D WWFKY           S                   LIKE(WIFKV)
004500021008     D WWFLK           S            128A
004600021008     D WWFMTN          S              8A
004700021008     D WWFNC           S              8A
004800021008     D WWIJI           S             16A
004900021008     D WWIN            S             99A
005000021008     D WWLIB           S             10A
005100021008     D WWMSG           S             80A
005200021008     D WWMSGC          S              7A
005300021008     D WWOCD           S              8A
005400021008     D WWOPA           S              8A
005500021008     D WWOPN           S              1A
005600021008     D WWOPT           S              8A
005700021008     D WWOPV           S                   LIKE(WIFKV)
005800021008     D WWORQS          S                   LIKE(WIRQS)
005900021008     D WWPSNC          S              1A
006000021008     D WWQJN           S             26A
006100021008     D WWRQS           S                   LIKE(WIRQS)
006200021008     D WWRQSD          S                   LIKE(WIRQS)
006300021008     D WWRTN           S                   LIKE(WORTN)
006400021008     D WWRTND          S                   LIKE(WORTN)
006500021008     D WWRTNH          S                   LIKE(WORTN)
006600021008     D WWSFLE          S              1A
006700021008     D WWSTT           S              3A
006800021008     D WWTSK           S              8A
006900021008     D WWTXT           S             60A
007000021008     D WWUPD           S              1A
007100021008     D WWWRNF          S              1A
007200021008     D WWZERO          S             40A
007300021008     D WFRRN           S              4P 0
007400021008     D WW              S              3P 0
007500021008     D WWFKS           S              1P 0
007600021008     D WWFKSO          S                   LIKE(WWFKS)
007700021008     D WWLMT           S              2P 0
007800021008     D WWLNG           S             15P 5
007900021008     D WWLNGQ          S              5P 0
008000021008     D WWLOWR          S              4P 0
008100021008     D WWLSTS          S              2P 0
008200021008     D WWOPS           S              1P 0
008300021008     D WWOPSO          S                   LIKE(WWOPS)
008400021008     D WWPNL           S              1P 0
008500021008     D WWPNLN          S                   LIKE(WWPNL)
008600021008     D WWPNLO          S                   LIKE(WWPNL)
008700021008     D WWPSNI          S              2P 0
008800021008     D WWPSNN          S              1P 0
008900021008     D WWPSNP          S                   LIKE(WWPSNN)
009000021008     D WWRRN           S              4P 0
009100020304     ***
009200020304      *_________________________________________________________________________
009300020304      *
009400020304      * Process Entry Panel
009500090317B1   C                   If        WWTSK = 'COPY' Or WWTSK = 'CPYKEY'
009600090317     C                   Eval      WWDTA = WUDTA
009700090317E1   C                   EndIf
009800020304      *
009900090317     C                   ExSR      PRPPNL
010000020304      *
010100090317B1   C                   DoW       WWSTT <> 'END'
010200090317     C                   ExSR      RCVMSG
010300090317     C                   ExSR      DSPPNL
010400090317     C                   ExSR      PRCFKY
010500020304      *
010600090317B2   C     WWFKA         CasEq     'KEYS    '    PRCDKY
010700090317     C     WWFKA         CasEq     'EXIT    '    PRCEXT
010800090317     C     WWFKA         CasEq     'PROMPT  '    PRCPMT
010900090317     C     WWFKA         CasEq     'REFRESH '    PRPPNL
011000090317     C     WWFKA         CasEq     'CANCEL  '    PRCCNL
011100090317     C     WWFKA         CasEq     'ROLLUP  '    PRCRUP
011200090317     C     WWFKA         CasEq     'ROLLDOWN'    PRCRDN
011300090317     C     WWFKA         CasEq     'ENTER   '    PRCPNL
011400090317     C     WWFKA         CasEq     'UPDATE  '    PRCEXT
011500090317E2   C                   EndCs
011600020304      *
011700020304B2   C                   IF        WWSTT = 'END'
011800090317     C                   ExSR      PRCEND
011900090317E2   C                   EndIf
012000090317E1   C                   EndDo
012100020304      *
012200020304      * Send Info Updated message.
012300090317     C                   If        WWCHG = 'Y'
012400090317     C                   Eval      WORTN = 'UPDATE'
012500090317     C                   EndIf
012600020304      *
012700020304     C                   Return
012800020304      *___________________________________________________________________
012900020304      * Prepare panel
013000020304      *___________________________________________________________________
013100020304     C     PRPPNL        Begsr
013200130208    ***
013300130208     C     *DTAARA       DEFINE    COMPANY       @LDA             50
013400130208     C                   IN        @LDA
013500130208     c                   EVAL      WSNAME = %SUBST(@LDA:1:40)
013600130208    ***
013700090317     c                   Eval      WORTN= *Blanks
013800090317     c                   Eval      WWERR = 'N'
013900090317     C                   Eval      WWCHG = 'N'
014000090317     C                   Eval      WWWRNF = 'N'
014100090317     C                   Eval      WWSTT = *Blanks
014200090317     C                   Z-Add     1             WWPNL
014300090317     C                   Z-Add     1             WWFKS
014400090317     C                   MoveA     WWZERO        *IN(60)
014500090317     C                   Eval      WWSTT = *Blanks
014600020304      *
014700090317B1   C                   If        WQPGMN = WUPGM
014800090317B2   C                   If        WIRQS <> WWORQS
014900020304     C                   Move      *BLANKS       WUPGM
015000090317E2   C                   EndIf
015100020304     C                   Move      WIRQS         WWORQS
015200090317E1   C                   EndIf
015300020304      *
015400020304     C                   Exsr      BLDFKY
015500020304      *
015600020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
015700020304     C     WWTSK         Caseq     'ADD     '    PRPADD
015800020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
015900020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
016000020304     C                   Cas                     PRCERR
016100020304E1   C                   Endcs
016200020304      *
016300020304      *
016400020304     C                   Endsr
016500020304      *___________________________________________________________________
016600020304      * Prepare ADD request
016700020304      *___________________________________________________________________
016800020304     C     PRPADD        Begsr
016900020304     C                   Clear                   WUDTA
017000020304     C                   Exsr      DFTDTA
017100020304     C                   Endsr
017200020304      *___________________________________________________________________
017300020304      * Prepare CHANGE request
017400020304      *___________________________________________________________________
017500020304     C     PRPCHG        Begsr
017600130131     C                   Call      'UPDMLT  '
017700020304     C                   Parm      'GET     '    WWRQS
017800020304     C                   Parm                    WWRTN
017900020304     C                   Parm                    WUDTA
018000020304B1   C                   IF        WWRTN <> *BLANKS
018100020304B2   C                   IF        WWRTN = 'NOTAVL'
018200020304     C                   Movel     WTM(5)        WWMSG
018300020304X2   C                   Else
018400020304     C                   Movel     WTM(4)        WWMSG
018500020304E2   C                   Endif
018600020304     C                   Exsr      SNDMSG
018700020304     C                   Move      'ERROR   '    WORTN
018800020304     C                   Move      'END'         WWSTT
018900020304E1   C                   End
019000020304     C                   Endsr
019100020304      *___________________________________________________________________
019200020304      * Prepare COPY request
019300020304      *___________________________________________________________________
019400020304     C     PRPCPY        Begsr
019500020304     C                   Move      WWDTA         WUDTA
019600130131     C                   Call      'UPDMLT  '
019700020304     C                   Parm      'GETNL   '    WWRQS
019800020304     C                   Parm                    WWRTN
019900020304     C                   Parm                    WUDTA
020000020304B1   C                   IF        WWRTN <> *BLANKS
020100020304     C                   Movel     WTM(4)        WWMSG
020200020304     C                   Exsr      SNDMSG
020300020304     C                   Move      'ERROR   '    WORTN
020400020304     C                   Move      'END'         WWSTT
020500020304X1   C                   Else
020600020304     C                   Move      'Y'           WWCHG
020700020304     ***                 Clear                   MSMSID
020800020304E1   C                   Endif
020900020304     C                   Endsr
021000020304      *___________________________________________________________________
021100020304      * Default Data
021200020304      *___________________________________________________________________
021300020304     C     DFTDTA        Begsr
021400130131     C                   Call      'CHKMLT  '
021500020304     C                   Parm      'DFTDTA'      WWRQS
021600020304     C                   Parm                    WWRTN
021700020304     C                   Parm                    WUDTA
021800020304B1   C                   IF        WWRTN <> *BLANKS
021900020304     C                   Movel     WTM(7)        WWMSG
022000020304     C                   Exsr      SNDMSG
022100020304     C                   Move      'ERROR   '    WORTN
022200020304     C                   Move      'END'         WWSTT
022300020304E1   C                   Endif
022400020304     C                   Endsr
022500020304      *___________________________________________________________________
022600020304      * Process ERROR function
022700020304      *___________________________________________________________________
022800020304     C     PRCERR        Begsr
022900020304     C                   Move      WTM(1)        WWMSG
023000020304     C                   Exsr      SNDMSG
023100020304     C                   Move      'ERROR   '    WORTN
023200020304     C                   Move      'END'         WWSTT
023300020304     C                   Endsr
023400020304      *___________________________________________________________________
023500020304      * Receive messages
023600020304      *___________________________________________________________________
023700020304     C     RCVMSG        Begsr
023800020304B1   C                   IF        WWMSGC <> 'NORESET'
023900020304     C                   Movel     'RECEIVE'     WWRQS
024000020304X1   C                   Else
024100020304     C                   Movel     'DISPLAY'     WWRQS
024200020304E1   C                   Endif
024300020304     C                   Movel     'RESET   '    WWMSGC
024400020304     C                   Movea     *IN           WWIN
024500020304     C                   Call      'PRCMSG2'
024600020304     C                   Parm                    WWRQS
024700020304     C                   Parm                    WWIN
024800020304     C                   Parm                    WWRTN
024900020304     C                   Movea     WWIN          *IN
025000020304     C                   Endsr
025100020304      *___________________________________________________________________
025200020304      * Display panels
025300020304      *___________________________________________________________________
025400020304     C     DSPPNL        Begsr
025500020304      *
025600020304      * Set PUTOVR based on last display file processed
025700020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
025800020304     C                   MOVE      *OFF          *IN35
025900020304     C                   Move      WQPGMN        WUPGM
026000020304     C                   Move      WWPNL         WWPNLO
026100020304X1   C                   Else
026200020304     C                   MOVE      *ON           *IN35
026300020304E1   C                   Endif
026400020304      *
026500020304      * Set PROTECT key based on request
026600020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
026700020304     C                             WWTSK = 'COPY  '
026800100618 001 C                   Eval      *in40 = *off
026900020304X001 C                   Else
027000100618 001 C                   Eval      *in40 = *on
027100020304E001 C                   Endif
027200020304      *
027300020304      * Select title
027400020304     C                   IF        WWTSK = 'CHANGE'
027500100618 001 C                   Eval      *in38 = *off
027600020304X001 C                   Else
027700100618 001 C                   Eval      *in38 = *on
027800020304E001 C                   Endif
027900020304      *
028000020304      * Position cursor based on error status
028100020304     C                   IF        WWERR = 'Y'
028200100618 001 C                   Eval      *in99 = *on
028300020304X001 C                   Else
028400100618 001 C                   Eval      *in99 = *off
028500020304E001 C                   Endif
028600020304      *
028700020304      * Write message subfile
028800020304     C                   Seton                                        30
028900020304     C                   Write     MSGCTL
029000020304      *
029100020304      * Write entry panel
029200020304B001 C                   Select
029300020304     C                   WHEN      WWPNL = 1
029400130208     C                   EXSR      $GETDTA
029500020304 001 C                   Exfmt     ENTPNL
029600020304 001 C                   Setoff                                       37
029700020304E001 C                   Endsl
029800020304      *
029900020304B001 C                   If        *IN39 = *ON
030000100618 001 C                   Eval      WWCHG = 'Y'
030100020304E001 C                   Endif
030200020304     C                   Endsr
030300130208   S***S
030400130208     C     $GETDTA       BEGSR
030500130208    ***
030600130208     C                   EVAL      D_ALTTP = *BLANKS
030700130208     C                   SELECT
030800130208     C                   WHEN      MAALTTP = 'AH'
030900130208     C                   EVAL      D_ALTTP = 'AETNA (US) HEALTHCARE'
031000130208     C                   WHEN      MAALTTP = 'CH '
031100130208     C                   EVAL      D_ALTTP = 'COVENTRY HEALTH'
031200130208     C                   WHEN      MAALTTP = 'CI '
031300130208     C                   EVAL      D_ALTTP = 'CIGNA'
031400130208     C                   WHEN      MAALTTP = 'FI '
031500130208     C                   EVAL      D_ALTTP = 'MARYLAND FIDELITY'
031600130208     C                   WHEN      MAALTTP = 'GBS'
031700130208     C                   EVAL      D_ALTTP = 'GBS - ALTERNATE ID'
031800130208     C                   WHEN      MAALTTP = 'HI '
031900130208     C                   EVAL      D_ALTTP = 'HIGHMARK'
032000130208     C                   WHEN      MAALTTP = 'HRO'
032100130208     C                   EVAL      D_ALTTP = 'HR OFFICE'
032200130208     C                   WHEN      MAALTTP = 'IMD'
032300130208     C                   EVAL      D_ALTTP = 'G.A.S. IND MKT DIV MEMBERS'
032400130208     C                   WHEN      MAALTTP = 'KP '
032500130208     C                   EVAL      D_ALTTP = 'KAISER PERMANENTE'
032600130208     C                   WHEN      MAALTTP = 'MA '
032700130208     C                   EVAL      D_ALTTP = 'MAMSI/OPTIMUM'
032800130208     C                   WHEN      MAALTTP = 'UH '
032900130208     C                   EVAL      D_ALTTP = 'UNITED HEALTHCARE'
033000130208     C                   WHEN      MAALTTP = '00 '
033100130208     C                   EVAL      D_ALTTP = 'CARE FIRST - NASCO'
033200130208     C                   WHEN      MAALTTP = '01 '
033300130208     C                   EVAL      D_ALTTP = 'CARE FIRST - EAB'
033400130208     C                   WHEN      MAALTTP = '08 '
033500130208     C                   EVAL      D_ALTTP = 'CARE FIRST - FACETS'
033600130208     C                   ENDSL
033700130208    ***
033800130208     C     MACRTDT       MULT      10000.0001    SCCRTDT
033900130208    ***
034000130208     C                   ENDSR
034100130208   S***S
034200020304      *___________________________________________________________________
034300020304      * Process function key
034400020304      *___________________________________________________________________
034500020304     C     PRCFKY        Begsr
034600020304     C                   Movea     *IN           WWIN
034700020304     C                   Call      'PRCFKY2'
034800020304     C                   Parm      'PROCESS '    WWRQS
034900020304     C     WWFKA         Parm                    WWRTN
035000020304     C                   Parm                    WAD
035100020304     C                   Parm                    WWIN
035200020304     C                   Parm                    WAF
035300020304     C                   Parm                    WIFKV
035400020304     C                   Endsr
035500020304      *___________________________________________________________________
035600020304      * Process KEYS function
035700020304      *___________________________________________________________________
035800020304     C     PRCDKY        Begsr
035900020304     C                   Z-add     1             WW
036000020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
036100060317 001 C                   Add       1             WWFKS
036200020304 001  *
036300020304     C                   IF        WWFKS > 3
036400020304 002 C                   Z-add     1             WWFKS
036500020304E002 C                   Endif
036600020304 001  *
036700060317     C                   Eval      WW = WWFKS + WWFKS
036800020304 001 C                   Sub       1             WW
036900020304E001 C                   Enddo
037000020304      *
037100020304     C                   Movel     WAD(WW)       WSFKD1
037200020304     C                   Add       1             WW
037300020304     C                   Movel     WAD(WW)       WSFKD2
037400020304     C                   Endsr
037500020304      *___________________________________________________________________
037600020304      * Process EXIT Function
037700020304      *___________________________________________________________________
037800020304     C     PRCEXT        Begsr
037900020304      *
038000020304     C                   Exsr      PRCPNL
038100020304      *
038200020304     C                   IF        WWERR = 'Y'
038300020304 001 C                   Move      *BLANKS       WWSTT
038400020304X001 C                   Else
038500020304 001 C                   Movel     WWFKA         WORTN
038600020304 001 C                   Move      'END'         WWSTT
038700020304E001 C                   Endif
038800020304     C                   Endsr
038900020304      *___________________________________________________________________
039000020304      * Process PROMPT function
039100020304      *___________________________________________________________________
039200020304     C     PRCPMT        Begsr
039300020304     C                   Movel     WDCRSL        WWRQS
039400020304     C                   Move      'Y'           WWCHG
039500020304     C                   Move      'N'           WWWRNF
039600020304     C                   Movel     'NORESET '    WWMSGC
039700020304      *
039800130305B001 C                   Select
039900130305 001 C                   When      WSFLD = 'MAALTTP'
040000130305     C                   Call      'SLCALTCL'                                   *ENTRY LIST
040100130305     C                   Parm                    WWRQS                          PROGRAM REQUEST
040200130305     C                   Parm                    WWRTN                          RETURN CODE
040300130305     C                   Parm                    WUPGM                          LAST PGM NAME
040400130305     C                   Parm                    @34              34            RECORD DS
040500130305     C                   IF        WWRTN = *BLANKS
040600130305     C                   Eval      MAALTTP  = %SUBST(@34:1:4)
040700130305     C                   EVAL      D_ALTTP  = %SUBST(@34:5:30)
040800130305E001 C                   Endif
040900130208 001  *
041000130305 001 C                   Other
041100130305 001 C                   Move      WTM(6)        WWMSG
041200130305 001 C                   Exsr      SNDMSG
041300130305E001 C                   Endsl
041400020304      *
041500020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
041600020304     C                   Movel     WDCRSL        WWCRSL
041700020304     C     WWCRSN        Div       256           WSROW
041800020304     C                   Mvr                     WSLIN
041900020304     C                   Seton                                        37
042000020304      *
042100020304     C                   Endsr
042200020304      *___________________________________________________________________
042300020304      * Process CANCEL Function
042400020304      *___________________________________________________________________
042500020304     C     PRCCNL        Begsr
042600020304     C                   Movel     WWFKA         WORTN
042700020304     C                   Move      'END'         WWSTT
042800020304     C                   Move      'N'           WWCHG
042900020304     C                   Endsr
043000020304      *___________________________________________________________________
043100020304      * Process ROLLUP function
043200020304      *___________________________________________________________________
043300020304     C     PRCRUP        Begsr
043400020304     C     WWPNL         Add       1             WWPNL
043500020304     C                   IF        WWPNL > WWPNLN
043600020304 001 C     WWPNL         Sub       1             WWPNL
043700020304E001 C                   Endif
043800020304     C                   Movel     'NORESET '    WWMSGC
043900020304     C                   Endsr
044000020304      *___________________________________________________________________
044100020304      * Process ROLLDOWN function
044200020304      *___________________________________________________________________
044300020304     C     PRCRDN        Begsr
044400020304     C     WWPNL         Sub       1             WWPNL
044500020304     C                   IF        WWPNL < 1
044600020304 001 C     WWPNL         Add       1             WWPNL
044700020304E001 C                   Endif
044800020304     C                   Movel     'NORESET '    WWMSGC
044900020304     C                   Endsr
045000020304      *___________________________________________________________________
045100020304      * Process ENTER function
045200020304      *___________________________________________________________________
045300020304     C     PRCPNL        Begsr
045400020304     C                   Move      *BLANKS       WWRTN
045500020304     C                   Movea     *ZEROS        *IN(60)
045600020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
045700020304 001 C                   Move      'N'           WWWRNF
045800020304     C                   IF        WWTSK = 'CHANGE  '
045900130131 001 C                   Call      'CHKMLT  '
046000020304 001 C                   Parm      'EDTCHG  '    WWRQS
046100020304 001 C                   Parm                    WWRTN
046200020304 001 C                   Parm                    WUDTA
046300020304     C                   ELSE
046400130131 001 C                   Call      'CHKMLT  '
046500020304 001 C                   Parm      'EDTADD  '    WWRQS
046600020304 001 C                   Parm                    WWRTN
046700020304 001 C                   Parm                    WUDTA
046800020304E001 C                   Endif
046900020304E001 C                   Endif
047000020304      *
047100020304B001 C                   Select
047200020304     C                   WHEN      WWRTN = *BLANKS
047300020304 001 C                   Move      'N'           WWERR
047400020304 001  *
047500020304     C                   WHEN      WWRTN = 'WARNING'
047600020304     C                   IF        WWWRNF = 'Y'
047700020304 002 C                   Move      'N'           WWERR
047800020304X002 C                   Else
047900020304 002 C                   Move      'Y'           WWWRNF
048000020304 002 C                   Move      'Y'           WWERR
048100020304E002 C                   Endif
048200020304 001  *
048300020304     C                   WHEN      WWRTN = 'ERROR  '
048400020304 001 C                   Move      'Y'           WWERR
048500020304 001 C                   Move      *BLANKS       WWSTT
048600020304 001 C                   Move      'N'           WWWRNF
048700020304E001 C                   Endsl
048800020304      *
048900020304     C                   Endsr
049000020304      *___________________________________________________________________
049100020304      * Process end - write data or release record
049200020304      *___________________________________________________________________
049300020304     C     PRCEND        Begsr
049400020304      *
049500020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
049600020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
049700020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
049800020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
049900020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
050000020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
050100020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
050200020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
050300020304 001 C                   Endcs
050400020304 001  *
050500020304     C                   IF        WWRTN <> *BLANKS
050600020304 002 C                   Move      *BLANKS       WWSTT
050700020304 002  *
050800020304X002 C                   Else
050900020304     C                   IF        WWFKA <> 'EXIT'
051000020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
051100020304 004 C                   Exsr      PRPPNL
051200020304E004 C                   Endif
051300020304E003 C                   Endif
051400020304E002 C                   Endif
051500020304 001  *
051600020304X001 C                   Else
051700020304 001 C                   Exsr      RELREC
051800020304E001 C                   Endif
051900020304      *
052000020304     C                   Endsr
052100020304      *___________________________________________________________________
052200020304      * Add new record
052300020304      *___________________________________________________________________
052400020304     C     WRTADD        Begsr
052500020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
052600020304     C                             WWTSK = 'COPY  '
052700020304 001 C                   Movel     'ADD    '     WWRQS
052800020304E001 C                   Endif
052900020304      *
053000020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
053100020304     C                             WWTSK = 'CPYKEY'
053200020304 001 C                   Movel     'ADDKEY '     WWRQS
053300020304E001 C                   Endif
053400020304      *
053500130131     C                   Call      'UPDMLT  '
053600020304     C                   Parm                    WWRQS
053700020304     C                   Parm                    WWRTN
053800020304     C                   Parm                    WUDTA
053900020304      *
054000020304     C                   IF        WWRTN <> *BLANKS
054100020304 001 C                   Movel     WTM(3)        WWMSG
054200020304 001 C                   Exsr      SNDMSG
054300020304X001 C                   Else
054400020304E001 C                   Endif
054500020304      *
054600020304     C                   Endsr
054700020304      *___________________________________________________________________
054800020304      * Write changed record
054900020304      *___________________________________________________________________
055000020304     C     WRTCHG        Begsr
055100130131     C                   Call      'UPDMLT  '
055200020304     C                   Parm      'CHANGE'      WWRQS
055300020304     C                   Parm                    WWRTN
055400020304     C                   Parm                    WUDTA
055500020304     C                   IF        WWRTN <> *BLANKS
055600020304 001 C                   Movel     WTM(2)        WWMSG
055700020304 001 C                   Exsr      SNDMSG
055800020304E001 C                   Endif
055900020304      *
056000020304     C                   Endsr
056100020304      *___________________________________________________________________
056200020304      * Release record
056300020304      *___________________________________________________________________
056400020304     C     RELREC        Begsr
056500130131     C                   Call      'UPDMLT  '
056600020304     C                   Parm      'RELEASE '    WWRQS
056700020304     C                   Parm                    WWRTN
056800020304     C                   Parm                    WUDTA
056900020304     C                   IF        WWRTN <> *BLANKS
057000020304 001 C                   Movel     WTM(4)        WWMSG
057100020304 001 C                   Exsr      SNDMSG
057200020304E001 C                   Endif
057300020304     C                   Endsr
057400020304      *___________________________________________________________________
057500020304      * Build function keys
057600020304      *___________________________________________________________________
057700020304     C     BLDFKY        Begsr
057800020304     C                   Movea     *IN           WWIN
057900020304     C                   Call      'PRCFKY2'
058000020304     C                   Parm      'BUILD   '    WWRQS
058100020304     C     WWFKA         Parm                    WWRTN
058200020304     C                   Parm                    WAD
058300020304     C                   Parm                    WWIN
058400020304     C                   Parm                    WAF
058500020304     C                   Parm                    WIFKV
058600020304     C     WWFKS         Add       WWFKS         WW
058700020304     C                   Movel     WAD(WW)       WSFKD2
058800020304     C                   Sub       1             WW
058900020304     C                   Movel     WAD(WW)       WSFKD1
059000020304     C                   Endsr
059100020304      *___________________________________________________________________
059200020304      * Send message
059300020304      *___________________________________________________________________
059400020304     C     SNDMSG        Begsr
059500020304     C                   Call      'QSNDDTAQ'
059600020304     C                   Parm                    WWDTAQ
059700020304     C                   Parm                    WWLIB
059800020304     C                   Parm                    WWLNGQ
059900020304     C                   Parm                    WWMSG
060000020304     C                   Endsr
060100020304      *___________________________________________________________________
060200020304      * Paremater list
060300020304      *___________________________________________________________________
060400020304     C     PLIST         Begsr
060500020304     C     *ENTRY        Plist
060600020304     C     WWTSK         Parm                    WIRQS
060700020304     C                   Parm                    WORTN
060800020304     C                   Parm                    WUPGM
060900020304     C                   Parm                    WUDTA
061000020304     C                   Parm                    WIFKV
061100020304     C                   Endsr
061200020304      *___________________________________________________________________
061300020304      * Initialize routine
061400020304      *___________________________________________________________________
061500020304     C     *INZSR        Begsr
061600020304     C     *LIKE         Define    WUDTA         WWDTA
061700020304     C     *LIKE         Define    WIRQS         WWRQS
061800020304     C     *LIKE         Define    WIRQS         WWORQS
061900020304     C     *LIKE         Define    WIRQS         WWTSK
062000020304     C     *LIKE         Define    WORTN         WWRTN
062100020304     C     *LIKE         Define    WORTN         WWFKA
062200020304     C     *LIKE         Define    WIFKV         WWFKV
062300020304     C     *LIKE         Define    WIFKV         WWOPV
062400020304     C                   Movel     'RESET   '    WWMSGC
062500020304     C                   Movel     '*'           MSPGMQ
062600020304     C                   Movel     'MSGDTAQ'     WWDTAQ
062700020304     C                   Movel     'QTEMP'       WWLIB
062800020304     C                   Z-add     80            WWLNGQ
062900020304     C                   Move      *BLANKS       WWMSG
063000020304     C                   Move      *BLANKS       WWIN
063100020304     C                   Move      *BLANKS       WWSTT
063200020304     C                   Move      *ZEROS        WWZERO
063300020304     C                   Z-add     1             WWPNL
063400020304     C                   Z-add     1             WWPNLN
063500020304     C                   Z-add     1             WWFKS
063600020304     C                   Move      'N'           WWERR
063700020304     C                   Move      'N'           WWCHG
063800020304     C                   Move      'N'           WWWRNF
063900020304     C                   Z-add     0             WW
064000130131     C                   Movel(P)  'MEMAL'       WWFIL
064100020304     C                   Move      *BLANKS       WWFLK
064200020304     C                   Move      *BLANKS       WWTXT
064300020304     C                   Endsr
064400020304      *___________________________________________________________________
064500020304      * Program error handler
064600020304      *___________________________________________________________________
064700020304     C     *PSSR         Begsr
064800020304     C                   Call      'SNDRPGM'                            50
064900020304     C                   Parm                    WQPGMN
065000020304     C                   Parm                    WQSTSC
065100020304     C                   Parm                    WQRPGS
065200020304     C                   Parm                    WQMSG
065300020304     C                   Endsr     '*CANCL'
065400020304      *___________________________________________________________________
065500020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06560002030403EXIT    F3=Exit
06570002030404PROMPT  F4=Prompt
06580002030405REFRESH F5=Refresh
06590002030410UPDATE  F10=Update
06600002030412CANCEL  F12=Cancel
06610002030425ROLLUP
06620002030426ROLLDOWN
066300020304** WTM
06640013013100Request not supported in program CHGMLT.
06650002030400Update error.  Data was not updated.
06660002030400Duplicate key detected.  Data was NOT added to file.
06670002030400Record not found.
06680002030400Record not available now.
06690002030400The cursor is not in a prompt area.
06700002030400Default error.  Data not defaulted.
