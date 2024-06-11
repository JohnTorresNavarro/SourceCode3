000100020304      *_________________________________________________________________________
000200020304      *
000300120530      *  Description:  Change COBRA INITIAL LETTER
000400020304      *
000500090204      *  (c)Copyright 2009 by Group Benefit Services, Inc.
000600020304      *_________________________________________________________________________
000700120530     FCHGCIND   CF   E             WORKSTN INFDS(DSPD)
000800120531     FACMUNIQUE IF   E           K DISK
000900020304      *
001000020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001100020304     D WAD             S             80    DIM(6)
001200020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001300020304      *_________________________________________________________________________
001400020304      * Data structure
001500120530     D WUDTA         E DS                  EXTNAME(COB440W2)
001600020304      *
001700020304      * Program status data structure
001800020304     D PGMD          ESDS                  EXTNAME(IOPGMD)
001900020304      *
002000020304      * Display file data structure
002100020304     D DSPD          E DS                  EXTNAME(IODSPD)
002200020304      *
002300020304      * CURSOR LOCATION
002400020304     D                 DS
002500020304     D  WWCRSL                 1      2
002600020304     D  WWCRSN                 1      2B 0
002700020304     ***
002800020304     D WWDTA           S                   LIKE(WUDTA)
002900021008     ***
003000021008     D WIFKV           S             60A
003100021008     D WIFKY           S                   LIKE(WIFKV)
003200021008     D WIOPV           S                   LIKE(WIFKV)
003300021008     D WIRQS           S              8A
003400021008     D WORTN           S              8A
003500021008     D WUPGM           S             10A
003600021008     D WWCHG           S              1A
003700021008     D WWDLT           S              1A
003800021008     D WWDTAQ          S             10A
003900021008     D WWENDF          S              3A
004000021008     D WWENDO          S                   LIKE(WWENDF)
004100021008     D WWERR           S              1A
004200021008     D WWFIL           S             10A
004300021008     D WWFKA           S              8A
004400021008     D WWFKV           S                   LIKE(WIFKV)
004500021008     D WWFKY           S                   LIKE(WIFKV)
004600021008     D WWFLK           S            128A
004700021008     D WWFMTN          S              8A
004800021008     D WWFNC           S              8A
004900021008     D WWIJI           S             16A
005000021008     D WWIN            S             99A
005100021008     D WWLIB           S             10A
005200021008     D WWMSG           S             80A
005300021008     D WWMSGC          S              7A
005400021008     D WWOCD           S              8A
005500021008     D WWOPA           S              8A
005600021008     D WWOPN           S              1A
005700021008     D WWOPT           S              8A
005800021008     D WWOPV           S                   LIKE(WIFKV)
005900021008     D WWORQS          S                   LIKE(WIRQS)
006000021008     D WWPSNC          S              1A
006100021008     D WWQJN           S             26A
006200021008     D WWRQS           S                   LIKE(WIRQS)
006300021008     D WWRQSD          S                   LIKE(WIRQS)
006400021008     D WWRTN           S                   LIKE(WORTN)
006500021008     D WWRTND          S                   LIKE(WORTN)
006600021008     D WWRTNH          S                   LIKE(WORTN)
006700021008     D WWSFLE          S              1A
006800021008     D WWSTT           S              3A
006900021008     D WWTSK           S              8A
007000021008     D WWTXT           S             60A
007100021008     D WWUPD           S              1A
007200021008     D WWWRNF          S              1A
007300021008     D WWZERO          S             40A
007400021008     D WFRRN           S              4P 0
007500021008     D WW              S              3P 0
007600021008     D WWFKS           S              1P 0
007700021008     D WWFKSO          S                   LIKE(WWFKS)
007800021008     D WWLMT           S              2P 0
007900021008     D WWLNG           S             15P 5
008000021008     D WWLNGQ          S              5P 0
008100021008     D WWLOWR          S              4P 0
008200021008     D WWLSTS          S              2P 0
008300021008     D WWOPS           S              1P 0
008400021008     D WWOPSO          S                   LIKE(WWOPS)
008500021008     D WWPNL           S              1P 0
008600021008     D WWPNLN          S                   LIKE(WWPNL)
008700021008     D WWPNLO          S                   LIKE(WWPNL)
008800021008     D WWPSNI          S              2P 0
008900021008     D WWPSNN          S              1P 0
009000021008     D WWPSNP          S                   LIKE(WWPSNN)
009100021008     D WWRRN           S              4P 0
009200120531     ***
009300120531     D CMPNY           DS
009400120531     D  BLAH                   1    240a
009500120531     D  CONAME               200    240a
009600120531      *
009700020304     ***
009800020304      *_________________________________________________________________________
009900020304      *
010000020304      * Process Entry Panel
010100090317B1   C                   If        WWTSK = 'COPY' Or WWTSK = 'CPYKEY'
010200090317     C                   Eval      WWDTA = WUDTA
010300090317E1   C                   EndIf
010400020304      *
010500090317     C                   ExSR      PRPPNL
010600020304      *
010700120710     C                   EVAL      D_ACCT = *BLANKS
010800090317B1   C                   DoW       WWSTT <> 'END'
010900090317     C                   ExSR      RCVMSG
011000090317     C                   ExSR      DSPPNL
011100090317     C                   ExSR      PRCFKY
011200020304      *
011300090317B2   C     WWFKA         CasEq     'KEYS    '    PRCDKY
011400090317     C     WWFKA         CasEq     'EXIT    '    PRCEXT
011500090317     C     WWFKA         CasEq     'PROMPT  '    PRCPMT
011600090317     C     WWFKA         CasEq     'REFRESH '    PRPPNL
011700090317     C     WWFKA         CasEq     'CANCEL  '    PRCCNL
011800090317     C     WWFKA         CasEq     'ROLLUP  '    PRCRUP
011900090317     C     WWFKA         CasEq     'ROLLDOWN'    PRCRDN
012000090317     C     WWFKA         CasEq     'ENTER   '    PRCPNL
012100090317     C     WWFKA         CasEq     'UPDATE  '    PRCEXT
012200090317E2   C                   EndCs
012300020304      *
012400020304B2   C                   IF        WWSTT = 'END'
012500090317     C                   ExSR      PRCEND
012600090317E2   C                   EndIf
012700090317E1   C                   EndDo
012800020304      *
012900020304      * Send Info Updated message.
013000090317     C                   If        WWCHG = 'Y'
013100090317     C                   Eval      WORTN = 'UPDATE'
013200090317     C                   EndIf
013300120710     C**********         CLEAR                   WUDTA
013400020304      *
013500020304     C                   Return
013600020304      *___________________________________________________________________
013700020304      * Prepare panel
013800020304      *___________________________________________________________________
013900020304     C     PRPPNL        Begsr
014000120531      *
014100120531     C     *DTAARA       DEFINE    *LDA          CMPNY
014200120531     C                   IN        CMPNY
014300120531     C                   EVAL      WSNAME = CONAME
014400120531      *
014500120710     C                   EVAL      D_ACCT = *BLANKS
014600090317     c                   Eval      WORTN= *Blanks
014700090317     c                   Eval      WWERR = 'N'
014800090317     C                   Eval      WWCHG = 'N'
014900090317     C                   Eval      WWWRNF = 'N'
015000090317     C                   Eval      WWSTT = *Blanks
015100090317     C                   Z-Add     1             WWPNL
015200090317     C                   Z-Add     1             WWFKS
015300090317     C                   MoveA     WWZERO        *IN(60)
015400090317     C                   Eval      WWSTT = *Blanks
015500020304      *
015600090317B1   C                   If        WQPGMN = WUPGM
015700090317B2   C                   If        WIRQS <> WWORQS
015800020304     C                   Move      *BLANKS       WUPGM
015900090317E2   C                   EndIf
016000020304     C                   Move      WIRQS         WWORQS
016100090317E1   C                   EndIf
016200020304      *
016300020304     C                   Exsr      BLDFKY
016400020304      *
016500020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
016600020304     C     WWTSK         Caseq     'ADD     '    PRPADD
016700020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
016800020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
016900020304     C                   Cas                     PRCERR
017000020304E1   C                   Endcs
017100020304      *
017200020304      *
017300020304     C                   Endsr
017400020304      *___________________________________________________________________
017500020304      * Prepare ADD request
017600020304      *___________________________________________________________________
017700020304     C     PRPADD        Begsr
017800020304     C                   Clear                   WUDTA
017900020304     C                   Exsr      DFTDTA
018000020304     C                   Endsr
018100020304      *___________________________________________________________________
018200020304      * Prepare CHANGE request
018300020304      *___________________________________________________________________
018400020304     C     PRPCHG        Begsr
018500120530     C                   Call      'UPDCIN  '
018600020304     C                   Parm      'GET     '    WWRQS
018700020304     C                   Parm                    WWRTN
018800020304     C                   Parm                    WUDTA
018900020304B1   C                   IF        WWRTN <> *BLANKS
019000020304B2   C                   IF        WWRTN = 'NOTAVL'
019100020304     C                   Movel     WTM(5)        WWMSG
019200020304X2   C                   Else
019300020304     C                   Movel     WTM(4)        WWMSG
019400020304E2   C                   Endif
019500020304     C                   Exsr      SNDMSG
019600020304     C                   Move      'ERROR   '    WORTN
019700020304     C                   Move      'END'         WWSTT
019800020304E1   C                   End
019900020304     C                   Endsr
020000020304      *___________________________________________________________________
020100020304      * Prepare COPY request
020200020304      *___________________________________________________________________
020300020304     C     PRPCPY        Begsr
020400020304     C                   Move      WWDTA         WUDTA
020500120530     C                   Call      'UPDCIN  '
020600020304     C                   Parm      'GETNL   '    WWRQS
020700020304     C                   Parm                    WWRTN
020800020304     C                   Parm                    WUDTA
020900020304B1   C                   IF        WWRTN <> *BLANKS
021000020304     C                   Movel     WTM(4)        WWMSG
021100020304     C                   Exsr      SNDMSG
021200020304     C                   Move      'ERROR   '    WORTN
021300020304     C                   Move      'END'         WWSTT
021400020304X1   C                   Else
021500020304     C                   Move      'Y'           WWCHG
021600020304     ***                 Clear                   MSMSID
021700020304E1   C                   Endif
021800020304     C                   Endsr
021900020304      *___________________________________________________________________
022000020304      * Default Data
022100020304      *___________________________________________________________________
022200020304     C     DFTDTA        Begsr
022300120530     C                   Call      'CHKCIN  '
022400020304     C                   Parm      'DFTDTA'      WWRQS
022500020304     C                   Parm                    WWRTN
022600020304     C                   Parm                    WUDTA
022700020304B1   C                   IF        WWRTN <> *BLANKS
022800020304     C                   Movel     WTM(7)        WWMSG
022900020304     C                   Exsr      SNDMSG
023000020304     C                   Move      'ERROR   '    WORTN
023100020304     C                   Move      'END'         WWSTT
023200020304E1   C                   Endif
023300020304     C                   Endsr
023400020304      *___________________________________________________________________
023500020304      * Process ERROR function
023600020304      *___________________________________________________________________
023700020304     C     PRCERR        Begsr
023800020304     C                   Move      WTM(1)        WWMSG
023900020304     C                   Exsr      SNDMSG
024000020304     C                   Move      'ERROR   '    WORTN
024100020304     C                   Move      'END'         WWSTT
024200020304     C                   Endsr
024300020304      *___________________________________________________________________
024400020304      * Receive messages
024500020304      *___________________________________________________________________
024600020304     C     RCVMSG        Begsr
024700020304B1   C                   IF        WWMSGC <> 'NORESET'
024800020304     C                   Movel     'RECEIVE'     WWRQS
024900020304X1   C                   Else
025000020304     C                   Movel     'DISPLAY'     WWRQS
025100020304E1   C                   Endif
025200020304     C                   Movel     'RESET   '    WWMSGC
025300020304     C                   Movea     *IN           WWIN
025400020304     C                   Call      'PRCMSG2'
025500020304     C                   Parm                    WWRQS
025600020304     C                   Parm                    WWIN
025700020304     C                   Parm                    WWRTN
025800020304     C                   Movea     WWIN          *IN
025900020304     C                   Endsr
026000020304      *___________________________________________________________________
026100020304      * Display panels
026200020304      *___________________________________________________________________
026300020304     C     DSPPNL        Begsr
026400020304      *
026500020304      * Set PUTOVR based on last display file processed
026600020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
026700020304     C                   MOVE      *OFF          *IN35
026800020304     C                   Move      WQPGMN        WUPGM
026900020304     C                   Move      WWPNL         WWPNLO
027000020304X1   C                   Else
027100020304     C                   MOVE      *ON           *IN35
027200020304E1   C                   Endif
027300020304      *
027400020304      * Set PROTECT key based on request
027500020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
027600020304     C                             WWTSK = 'COPY  '
027700100618 001 C                   Eval      *in40 = *off
027800020304X001 C                   Else
027900100618 001 C                   Eval      *in40 = *on
028000020304E001 C                   Endif
028100020304      *
028200020304      * Select title
028300020304     C                   IF        WWTSK = 'CHANGE'
028400100618 001 C                   Eval      *in38 = *off
028500020304X001 C                   Else
028600100618 001 C                   Eval      *in38 = *on
028700020304E001 C                   Endif
028800020304      *
028900020304      * Position cursor based on error status
029000020304     C                   IF        WWERR = 'Y'
029100100618 001 C                   Eval      *in99 = *on
029200020304X001 C                   Else
029300100618 001 C                   Eval      *in99 = *off
029400020304E001 C                   Endif
029500020304      *
029600020304      * Write message subfile
029700020304     C                   Seton                                        30
029800020304     C                   Write     MSGCTL
029900020304      *
030000020304      * Write entry panel
030100120606     C                   EVAL      D_ACCT = *BLANKS
030200020304B001 C                   Select
030300020304     C                   WHEN      WWPNL = 1
030400120531     C                   EXSR      $GETDTA
030500020304 001 C                   Exfmt     ENTPNL
030600120531     C                   EXSR      $RTVDTA
030700020304 001 C                   Setoff                                       37
030800020304E001 C                   Endsl
030900020304      *
031000020304B001 C                   If        *IN39 = *ON
031100100618 001 C                   Eval      WWCHG = 'Y'
031200020304E001 C                   Endif
031300020304     C                   Endsr
031400120531   S***S
031500120531     C     $GETDTA       BEGSR
031600120531      *
031700120531     C     KL#TSA        KLIST
031800120531     C                   KFLD                    C2TRST
031900120531     C                   KFLD                    C2SUB#
032000120531     C                   KFLD                    C2ACCT
032100120531      *
032200120531     C     KL#TSA        CHAIN     ACCMSR
032300120710     C                   IF        %FOUND(ACMUNIQUE)
032400120531     C                   EVAL      D_ACCT = %TRIM(ACNAM1)
032500120531     C                   ENDIF
032600120531      *
032700120531     C                   IF        C2START > 0
032800120531     C     C2START       MULT      10000.0001    SCSTART
032900120531     C                   ELSE
033000120531     C                   EVAL      SCSTART = 0
033100120531     C                   ENDIF
033200120531      *
033300120531     C                   IF        C2ENDDT > 0
033400120531     C     C2ENDDT       MULT      10000.0001    SCENDDT
033500120531     C                   ELSE
033600120531     C                   EVAL      SCENDDT = 0
033700120531     C                   ENDIF
033800120531      *
033900120531     C                   IF        C2EDATE > 0
034000120531     C     C2EDATE       MULT      10000.0001    SCEDATE
034100120531     C                   ELSE
034200120531     C                   EVAL      SCEDATE = 0
034300120531     C                   ENDIF
034400120531      *
034500120531     C                   IF        C2CDATE > 0
034600120531     C     C2CDATE       MULT      10000.0001    SCCDATE
034700120531     C                   ELSE
034800120531     C                   EVAL      SCCDATE = 0
034900120531     C                   ENDIF
035000120531      *
035100120531     C                   ENDSR
035200120531   S***S
035300120531     C     $RTVDTA       BEGSR
035400120531      *
035500120531     C                   IF        SCSTART > 0
035600120531     C     SCSTART       MULT      10000.0001    C2START
035700120531     C                   ELSE
035800120531     C                   EVAL      C2START = 0
035900120531     C                   ENDIF
036000120531      *
036100120531     C                   IF        SCENDDT > 0
036200120531     C     SCENDDT       MULT      10000.0001    C2ENDDT
036300120531     C                   ELSE
036400120531     C                   EVAL      C2ENDDT = 0
036500120531     C                   ENDIF
036600120531      *
036700120531     C                   ENDSR
036800120531   S***S
036900020304      *___________________________________________________________________
037000020304      * Process function key
037100020304      *___________________________________________________________________
037200020304     C     PRCFKY        Begsr
037300020304     C                   Movea     *IN           WWIN
037400020304     C                   Call      'PRCFKY2'
037500020304     C                   Parm      'PROCESS '    WWRQS
037600020304     C     WWFKA         Parm                    WWRTN
037700020304     C                   Parm                    WAD
037800020304     C                   Parm                    WWIN
037900020304     C                   Parm                    WAF
038000020304     C                   Parm                    WIFKV
038100020304     C                   Endsr
038200020304      *___________________________________________________________________
038300020304      * Process KEYS function
038400020304      *___________________________________________________________________
038500020304     C     PRCDKY        Begsr
038600020304     C                   Z-add     1             WW
038700020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
038800060317 001 C                   Add       1             WWFKS
038900020304 001  *
039000020304     C                   IF        WWFKS > 3
039100020304 002 C                   Z-add     1             WWFKS
039200020304E002 C                   Endif
039300020304 001  *
039400060317     C                   Eval      WW = WWFKS + WWFKS
039500020304 001 C                   Sub       1             WW
039600020304E001 C                   Enddo
039700020304      *
039800020304     C                   Movel     WAD(WW)       WSFKD1
039900020304     C                   Add       1             WW
040000020304     C                   Movel     WAD(WW)       WSFKD2
040100020304     C                   Endsr
040200020304      *___________________________________________________________________
040300020304      * Process EXIT Function
040400020304      *___________________________________________________________________
040500020304     C     PRCEXT        Begsr
040600020304      *
040700020304     C                   Exsr      PRCPNL
040800020304      *
040900020304     C                   IF        WWERR = 'Y'
041000020304 001 C                   Move      *BLANKS       WWSTT
041100020304X001 C                   Else
041200020304 001 C                   Movel     WWFKA         WORTN
041300020304 001 C                   Move      'END'         WWSTT
041400020304E001 C                   Endif
041500020304     C                   Endsr
041600020304      *___________________________________________________________________
041700020304      * Process PROMPT function
041800020304      *___________________________________________________________________
041900020304     C     PRCPMT        Begsr
042000020304     C                   Movel     WDCRSL        WWRQS
042100020304     C                   Move      'Y'           WWCHG
042200020304     C                   Move      'N'           WWWRNF
042300020304     C                   Movel     'NORESET '    WWMSGC
042400020304      *
042500020304B001 C                   Select
042600120530 001 C                   When      WSFLD = 'XXXXXX'
042700020304     C*                  Call      'SLCCRM'                                     *ENTRY LIST
042800040305     C*                  Parm                    WWRQS                          PROGRAM REQUEST
042900040305     C*                  Parm                    WWRTN                          RETURN CODE
043000040305     C*                  Parm                    WUPGM                          LAST PGM NAME
043100020304     C*                  Parm                    WDCARP                         RECORD DS
043200020304     C                   IF        WWRTN = *BLANKS
043300020304     C*                  Eval      MSCAID   =    CMCARR
043400020304     C*                  EVAL      WSCNAME  =    CMNAME
043500020304E001 C                   Endif
043600020304 001  *
043700020304 001 C                   Other
043800020304 001 C                   Move      WTM(6)        WWMSG
043900020304 001 C                   Exsr      SNDMSG
044000020304E001 C                   Endsl
044100020304      *
044200020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
044300020304     C                   Movel     WDCRSL        WWCRSL
044400020304     C     WWCRSN        Div       256           WSROW
044500020304     C                   Mvr                     WSLIN
044600020304     C                   Seton                                        37
044700020304      *
044800020304     C                   Endsr
044900020304      *___________________________________________________________________
045000020304      * Process CANCEL Function
045100020304      *___________________________________________________________________
045200020304     C     PRCCNL        Begsr
045300020304     C                   Movel     WWFKA         WORTN
045400020304     C                   Move      'END'         WWSTT
045500020304     C                   Move      'N'           WWCHG
045600120710     C                   EVAL      D_ACCT = *BLANKS
045700020304     C                   Endsr
045800020304      *___________________________________________________________________
045900020304      * Process ROLLUP function
046000020304      *___________________________________________________________________
046100020304     C     PRCRUP        Begsr
046200020304     C     WWPNL         Add       1             WWPNL
046300020304     C                   IF        WWPNL > WWPNLN
046400020304 001 C     WWPNL         Sub       1             WWPNL
046500020304E001 C                   Endif
046600020304     C                   Movel     'NORESET '    WWMSGC
046700020304     C                   Endsr
046800020304      *___________________________________________________________________
046900020304      * Process ROLLDOWN function
047000020304      *___________________________________________________________________
047100020304     C     PRCRDN        Begsr
047200020304     C     WWPNL         Sub       1             WWPNL
047300020304     C                   IF        WWPNL < 1
047400020304 001 C     WWPNL         Add       1             WWPNL
047500020304E001 C                   Endif
047600020304     C                   Movel     'NORESET '    WWMSGC
047700020304     C                   Endsr
047800020304      *___________________________________________________________________
047900020304      * Process ENTER function
048000020304      *___________________________________________________________________
048100020304     C     PRCPNL        Begsr
048200020304     C                   Move      *BLANKS       WWRTN
048300020304     C                   Movea     *ZEROS        *IN(60)
048400020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
048500020304 001 C                   Move      'N'           WWWRNF
048600020304     C                   IF        WWTSK = 'CHANGE  '
048700120530 001 C                   Call      'CHKCIN  '
048800020304 001 C                   Parm      'EDTCHG  '    WWRQS
048900020304 001 C                   Parm                    WWRTN
049000020304 001 C                   Parm                    WUDTA
049100020304     C                   ELSE
049200120530 001 C                   Call      'CHKCIN  '
049300020304 001 C                   Parm      'EDTADD  '    WWRQS
049400020304 001 C                   Parm                    WWRTN
049500020304 001 C                   Parm                    WUDTA
049600020304E001 C                   Endif
049700020304E001 C                   Endif
049800020304      *
049900020304B001 C                   Select
050000020304     C                   WHEN      WWRTN = *BLANKS
050100020304 001 C                   Move      'N'           WWERR
050200020304 001  *
050300020304     C                   WHEN      WWRTN = 'WARNING'
050400020304     C                   IF        WWWRNF = 'Y'
050500020304 002 C                   Move      'N'           WWERR
050600020304X002 C                   Else
050700020304 002 C                   Move      'Y'           WWWRNF
050800020304 002 C                   Move      'Y'           WWERR
050900020304E002 C                   Endif
051000020304 001  *
051100020304     C                   WHEN      WWRTN = 'ERROR  '
051200020304 001 C                   Move      'Y'           WWERR
051300020304 001 C                   Move      *BLANKS       WWSTT
051400020304 001 C                   Move      'N'           WWWRNF
051500020304E001 C                   Endsl
051600020304      *
051700020304     C                   Endsr
051800020304      *___________________________________________________________________
051900020304      * Process end - write data or release record
052000020304      *___________________________________________________________________
052100020304     C     PRCEND        Begsr
052200020304      *
052300020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
052400020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
052500020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
052600020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
052700020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
052800020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
052900020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
053000020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
053100020304 001 C                   Endcs
053200020304 001  *
053300020304     C                   IF        WWRTN <> *BLANKS
053400020304 002 C                   Move      *BLANKS       WWSTT
053500020304 002  *
053600020304X002 C                   Else
053700020304     C                   IF        WWFKA <> 'EXIT'
053800020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
053900020304 004 C                   Exsr      PRPPNL
054000020304E004 C                   Endif
054100020304E003 C                   Endif
054200020304E002 C                   Endif
054300020304 001  *
054400020304X001 C                   Else
054500020304 001 C                   Exsr      RELREC
054600020304E001 C                   Endif
054700020304      *
054800020304     C                   Endsr
054900020304      *___________________________________________________________________
055000020304      * Add new record
055100020304      *___________________________________________________________________
055200020304     C     WRTADD        Begsr
055300020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
055400020304     C                             WWTSK = 'COPY  '
055500020304 001 C                   Movel     'ADD    '     WWRQS
055600020304E001 C                   Endif
055700020304      *
055800020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
055900020304     C                             WWTSK = 'CPYKEY'
056000020304 001 C                   Movel     'ADDKEY '     WWRQS
056100020304E001 C                   Endif
056200020304      *
056300120530     C                   Call      'UPDCIN  '
056400020304     C                   Parm                    WWRQS
056500020304     C                   Parm                    WWRTN
056600020304     C                   Parm                    WUDTA
056700020304      *
056800020304     C                   IF        WWRTN <> *BLANKS
056900020304 001 C                   Movel     WTM(3)        WWMSG
057000020304 001 C                   Exsr      SNDMSG
057100020304X001 C                   Else
057200020304E001 C                   Endif
057300020304      *
057400020304     C                   Endsr
057500020304      *___________________________________________________________________
057600020304      * Write changed record
057700020304      *___________________________________________________________________
057800020304     C     WRTCHG        Begsr
057900120530     C                   Call      'UPDCIN  '
058000020304     C                   Parm      'CHANGE'      WWRQS
058100020304     C                   Parm                    WWRTN
058200020304     C                   Parm                    WUDTA
058300020304     C                   IF        WWRTN <> *BLANKS
058400020304 001 C                   Movel     WTM(2)        WWMSG
058500020304 001 C                   Exsr      SNDMSG
058600020304E001 C                   Endif
058700020304      *
058800020304     C                   Endsr
058900020304      *___________________________________________________________________
059000020304      * Release record
059100020304      *___________________________________________________________________
059200020304     C     RELREC        Begsr
059300120530     C                   Call      'UPDCIN  '
059400020304     C                   Parm      'RELEASE '    WWRQS
059500020304     C                   Parm                    WWRTN
059600020304     C                   Parm                    WUDTA
059700020304     C                   IF        WWRTN <> *BLANKS
059800020304 001 C                   Movel     WTM(4)        WWMSG
059900020304 001 C                   Exsr      SNDMSG
060000020304E001 C                   Endif
060100020304     C                   Endsr
060200020304      *___________________________________________________________________
060300020304      * Build function keys
060400020304      *___________________________________________________________________
060500020304     C     BLDFKY        Begsr
060600020304     C                   Movea     *IN           WWIN
060700020304     C                   Call      'PRCFKY2'
060800020304     C                   Parm      'BUILD   '    WWRQS
060900020304     C     WWFKA         Parm                    WWRTN
061000020304     C                   Parm                    WAD
061100020304     C                   Parm                    WWIN
061200020304     C                   Parm                    WAF
061300020304     C                   Parm                    WIFKV
061400020304     C     WWFKS         Add       WWFKS         WW
061500020304     C                   Movel     WAD(WW)       WSFKD2
061600020304     C                   Sub       1             WW
061700020304     C                   Movel     WAD(WW)       WSFKD1
061800020304     C                   Endsr
061900020304      *___________________________________________________________________
062000020304      * Send message
062100020304      *___________________________________________________________________
062200020304     C     SNDMSG        Begsr
062300020304     C                   Call      'QSNDDTAQ'
062400020304     C                   Parm                    WWDTAQ
062500020304     C                   Parm                    WWLIB
062600020304     C                   Parm                    WWLNGQ
062700020304     C                   Parm                    WWMSG
062800020304     C                   Endsr
062900020304      *___________________________________________________________________
063000020304      * Paremater list
063100020304      *___________________________________________________________________
063200020304     C     PLIST         Begsr
063300020304     C     *ENTRY        Plist
063400020304     C     WWTSK         Parm                    WIRQS
063500020304     C                   Parm                    WORTN
063600020304     C                   Parm                    WUPGM
063700020304     C                   Parm                    WUDTA
063800020304     C                   Parm                    WIFKV
063900020304     C                   Endsr
064000020304      *___________________________________________________________________
064100020304      * Initialize routine
064200020304      *___________________________________________________________________
064300020304     C     *INZSR        Begsr
064400020304     C     *LIKE         Define    WUDTA         WWDTA
064500020304     C     *LIKE         Define    WIRQS         WWRQS
064600020304     C     *LIKE         Define    WIRQS         WWORQS
064700020304     C     *LIKE         Define    WIRQS         WWTSK
064800020304     C     *LIKE         Define    WORTN         WWRTN
064900020304     C     *LIKE         Define    WORTN         WWFKA
065000020304     C     *LIKE         Define    WIFKV         WWFKV
065100020304     C     *LIKE         Define    WIFKV         WWOPV
065200020304     C                   Movel     'RESET   '    WWMSGC
065300020304     C                   Movel     '*'           MSPGMQ
065400020304     C                   Movel     'MSGDTAQ'     WWDTAQ
065500020304     C                   Movel     'QTEMP'       WWLIB
065600020304     C                   Z-add     80            WWLNGQ
065700020304     C                   Move      *BLANKS       WWMSG
065800020304     C                   Move      *BLANKS       WWIN
065900020304     C                   Move      *BLANKS       WWSTT
066000020304     C                   Move      *ZEROS        WWZERO
066100020304     C                   Z-add     1             WWPNL
066200020304     C                   Z-add     1             WWPNLN
066300020304     C                   Z-add     1             WWFKS
066400020304     C                   Move      'N'           WWERR
066500020304     C                   Move      'N'           WWCHG
066600020304     C                   Move      'N'           WWWRNF
066700020304     C                   Z-add     0             WW
066800120530     C                   Movel(P)  'COB440W2'    WWFIL
066900020304     C                   Move      *BLANKS       WWFLK
067000020304     C                   Move      *BLANKS       WWTXT
067100020304     C                   Endsr
067200020304      *___________________________________________________________________
067300020304      * Program error handler
067400020304      *___________________________________________________________________
067500020304     C     *PSSR         Begsr
067600020304     C                   Call      'SNDRPGM'                            50
067700020304     C                   Parm                    WQPGMN
067800020304     C                   Parm                    WQSTSC
067900020304     C                   Parm                    WQRPGS
068000020304     C                   Parm                    WQMSG
068100020304     C                   Endsr     '*CANCL'
068200020304      *___________________________________________________________________
068300020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06840002030403EXIT    F3=Exit
06850002030404PROMPT  F4=Prompt
06860002030405REFRESH F5=Refresh
06870002030410UPDATE  F10=Update
06880002030412CANCEL  F12=Cancel
06890002030425ROLLUP
06900002030426ROLLDOWN
069100020304** WTM
06920012053000Request not supported in program CHGCIN.
06930002030400Update error.  Data was not updated.
06940002030400Duplicate key detected.  Data was NOT added to file.
06950002030400Record not found.
06960002030400Record not available now.
06970002030400The cursor is not in a prompt area.
06980002030400Default error.  Data not defaulted.
