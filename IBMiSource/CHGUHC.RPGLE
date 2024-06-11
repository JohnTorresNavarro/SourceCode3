000100220124        Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200220124                         DftActGrp(*no)
000300220124                         bnddir('GBSBIND' )   ;
000400020304      *_________________________________________________________________________
000500020304      *
000600171207      *  Description: Change United Health Care History Tracking
000700020304      *
000800171207      *  (c)Copyright 2017 by Group Benefit Services, Inc.
000900020304      *_________________________________________________________________________
001000171207     FCHGUHCD   CF   E             WORKSTN INFDS(DSPD)
001100220124     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001200171208     FACCMST    IF   E           K DISK    EXTFILE('F.ACCMST') PREFIX(A_)
001300171208     FAACODE    IF   E           K DISK
001400220209     FTRNERRP   IF   e           K disk
001500020304      *
001600020304     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001700020304     D WAD             S             80    DIM(6)
001800020304     D WTM             S             80    DIM(7)  CTDATA PERRCD(1)
001900020304      *_________________________________________________________________________
002000020304      * Data structure
002100171207     D WUDTA         E DS                  EXTNAME(UHCHSTP)
002200020304      *
002300020304      * Program status data structure
002400020304     D PGMD          ESDS                  EXTNAME(IOPGMD)
002500020304      *
002600020304      * Display file data structure
002700020304     D DSPD          E DS                  EXTNAME(IODSPD)
002800020304      *
002900020304      * CURSOR LOCATION
003000020304     D                 DS
003100020304     D  WWCRSL                 1      2
003200020304     D  WWCRSN                 1      2B 0
003300020304     ***
003400020304     D WWDTA           S                   LIKE(WUDTA)
003500021008     ***
003600021008     D WIFKV           S             60A
003700021008     D WIFKY           S                   LIKE(WIFKV)
003800021008     D WIOPV           S                   LIKE(WIFKV)
003900021008     D WIRQS           S              8A
004000021008     D WORTN           S              8A
004100021008     D WUPGM           S             10A
004200021008     D WWCHG           S              1A
004300021008     D WWDLT           S              1A
004400021008     D WWDTAQ          S             10A
004500021008     D WWENDF          S              3A
004600021008     D WWENDO          S                   LIKE(WWENDF)
004700021008     D WWERR           S              1A
004800021008     D WWFIL           S             10A
004900021008     D WWFKA           S              8A
005000021008     D WWFKV           S                   LIKE(WIFKV)
005100021008     D WWFKY           S                   LIKE(WIFKV)
005200021008     D WWFLK           S            128A
005300021008     D WWFMTN          S              8A
005400021008     D WWFNC           S              8A
005500021008     D WWIJI           S             16A
005600021008     D WWIN            S             99A
005700021008     D WWLIB           S             10A
005800021008     D WWMSG           S             80A
005900021008     D WWMSGC          S              7A
006000021008     D WWOCD           S              8A
006100021008     D WWOPA           S              8A
006200021008     D WWOPN           S              1A
006300021008     D WWOPT           S              8A
006400021008     D WWOPV           S                   LIKE(WIFKV)
006500021008     D WWORQS          S                   LIKE(WIRQS)
006600021008     D WWPSNC          S              1A
006700021008     D WWQJN           S             26A
006800021008     D WWRQS           S                   LIKE(WIRQS)
006900021008     D WWRQSD          S                   LIKE(WIRQS)
007000021008     D WWRTN           S                   LIKE(WORTN)
007100021008     D WWRTND          S                   LIKE(WORTN)
007200021008     D WWRTNH          S                   LIKE(WORTN)
007300021008     D WWSFLE          S              1A
007400021008     D WWSTT           S              3A
007500021008     D WWTSK           S              8A
007600021008     D WWTXT           S             60A
007700021008     D WWUPD           S              1A
007800021008     D WWWRNF          S              1A
007900021008     D WWZERO          S             40A
008000021008     D WFRRN           S              4P 0
008100021008     D WW              S              3P 0
008200021008     D WWFKS           S              1P 0
008300021008     D WWFKSO          S                   LIKE(WWFKS)
008400021008     D WWLMT           S              2P 0
008500021008     D WWLNG           S             15P 5
008600021008     D WWLNGQ          S              5P 0
008700021008     D WWLOWR          S              4P 0
008800021008     D WWLSTS          S              2P 0
008900021008     D WWOPS           S              1P 0
009000021008     D WWOPSO          S                   LIKE(WWOPS)
009100021008     D WWPNL           S              1P 0
009200021008     D WWPNLN          S                   LIKE(WWPNL)
009300021008     D WWPNLO          S                   LIKE(WWPNL)
009400021008     D WWPSNI          S              2P 0
009500021008     D WWPSNN          S              1P 0
009600021008     D WWPSNP          S                   LIKE(WWPSNN)
009700021008     D WWRRN           S              4P 0
009800020304     ***
009900020304      *_________________________________________________________________________
010000171207      *
010100020304      * Process Entry Panel
010200020304B1   C                   IF        WWTSK = 'COPY' OR WWTSK = 'CPYKEY'
010300020304     C                   Move      WUDTA         WWDTA
010400020304E1   C                   ENDIF
010500020304      *
010600020304     C                   Exsr      PRPPNL
010700020304      *
010800020304B1   C                   DOW       WWSTT <> 'END'
010900020304     C                   Exsr      RCVMSG
011000020304     C                   Exsr      DSPPNL
011100020304     C                   Exsr      PRCFKY
011200020304      *
011300020304B2   C     WWFKA         Caseq     'KEYS    '    PRCDKY
011400020304     C     WWFKA         Caseq     'EXIT    '    PRCEXT
011500020304     C     WWFKA         Caseq     'PROMPT  '    PRCPMT
011600020304     C     WWFKA         Caseq     'REFRESH '    PRPPNL
011700020304     C     WWFKA         Caseq     'CANCEL  '    PRCCNL
011800020304     C     WWFKA         Caseq     'ROLLUP  '    PRCRUP
011900020304     C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN
012000020304     C     WWFKA         Caseq     'ENTER   '    PRCPNL
012100020304     C     WWFKA         Caseq     'UPDATE  '    PRCEXT
012200020304E2   C                   Endcs
012300020304      *
012400020304B2   C                   IF        WWSTT = 'END'
012500020304     C                   Exsr      PRCEND
012600020304E2   C                   Endif
012700020304E1   C                   Enddo
012800020304      *
012900020304      * Send Info Updated message.
013000020304     C                   IF        WWCHG = 'Y'
013100020304     C                   MOVEL     'UPDATE  '    WORTN
013200020304     C                   Endif
013300020304      *
013400220124     C                   eval      *inLR = *on
013500020304      *___________________________________________________________________
013600020304      * Prepare panel
013700020304      *___________________________________________________________________
013800020304     C     PRPPNL        Begsr
013900020304     C                   Move      *BLANKS       WORTN
014000020304     C                   Move      'N'           WWERR
014100020304     C                   Move      'N'           WWCHG
014200020304     C                   Move      'N'           WWWRNF
014300020304     C                   Move      *BLANKS       WWSTT
014400020304     C                   Z-add     1             WWPNL
014500020304     C                   Z-add     1             WWFKS
014600020304     C                   Movea     WWZERO        *IN(60)
014700020304     C                   Move      *BLANKS       WWSTT
014800020304      *
014900020304B1   C                   IF        WQPGMN = WUPGM
015000020304B2   C                   IF        WIRQS <> WWORQS
015100020304     C                   Move      *BLANKS       WUPGM
015200020304E2   C                   Endif
015300020304     C                   Move      WIRQS         WWORQS
015400020304E1   C                   Endif
015500020304      *
015600020304     C                   Exsr      BLDFKY
015700020304      *
015800020304B1   C     WWTSK         Caseq     'CHANGE  '    PRPCHG
015900020304     C     WWTSK         Caseq     'ADD     '    PRPADD
016000020304     C     WWTSK         Caseq     'INSERT  '    PRPADD
016100020304     C     WWTSK         Caseq     'COPY    '    PRPCPY
016200020304     C                   Cas                     PRCERR
016300020304E1   C                   Endcs
016400020304      *
016500020304      *
016600020304     C                   Endsr
016700020304      *___________________________________________________________________
016800020304      * Prepare ADD request
016900020304      *___________________________________________________________________
017000020304     C     PRPADD        Begsr
017100020304     C                   Clear                   WUDTA
017200020304     C                   Exsr      DFTDTA
017300020304     C                   Endsr
017400020304      *___________________________________________________________________
017500020304      * Prepare CHANGE request
017600020304      *___________________________________________________________________
017700020304     C     PRPCHG        Begsr
017800171207     C                   Call      'UPDUHC  '
017900020304     C                   Parm      'GET     '    WWRQS
018000020304     C                   Parm                    WWRTN
018100020304     C                   Parm                    WUDTA
018200020304B1   C                   IF        WWRTN <> *BLANKS
018300020304B2   C                   IF        WWRTN = 'NOTAVL'
018400020304     C                   Movel     WTM(5)        WWMSG
018500020304X2   C                   Else
018600020304     C                   Movel     WTM(4)        WWMSG
018700020304E2   C                   Endif
018800020304     C                   Exsr      SNDMSG
018900020304     C                   Move      'ERROR   '    WORTN
019000020304     C                   Move      'END'         WWSTT
019100020304E1   C                   End
019200020304     C                   Endsr
019300020304      *___________________________________________________________________
019400020304      * Prepare COPY request
019500020304      *___________________________________________________________________
019600020304     C     PRPCPY        Begsr
019700020304     C                   Move      WWDTA         WUDTA
019800171207     C                   Call      'UPDUHC  '
019900020304     C                   Parm      'GETNL   '    WWRQS
020000020304     C                   Parm                    WWRTN
020100020304     C                   Parm                    WUDTA
020200020304B1   C                   IF        WWRTN <> *BLANKS
020300020304     C                   Movel     WTM(4)        WWMSG
020400020304     C                   Exsr      SNDMSG
020500020304     C                   Move      'ERROR   '    WORTN
020600020304     C                   Move      'END'         WWSTT
020700020304X1   C                   Else
020800020304     C                   Move      'Y'           WWCHG
020900020304     ***                 Clear                   MSMSID
021000020304E1   C                   Endif
021100020304     C                   Endsr
021200020304      *___________________________________________________________________
021300020304      * Default Data
021400020304      *___________________________________________________________________
021500020304     C     DFTDTA        Begsr
021600171207     C                   Call      'CHKUHC  '
021700020304     C                   Parm      'DFTDTA'      WWRQS
021800020304     C                   Parm                    WWRTN
021900020304     C                   Parm                    WUDTA
022000020304B1   C                   IF        WWRTN <> *BLANKS
022100020304     C                   Movel     WTM(7)        WWMSG
022200020304     C                   Exsr      SNDMSG
022300020304     C                   Move      'ERROR   '    WORTN
022400020304     C                   Move      'END'         WWSTT
022500020304E1   C                   Endif
022600020304     C                   Endsr
022700020304      *___________________________________________________________________
022800020304      * Process ERROR function
022900020304      *___________________________________________________________________
023000020304     C     PRCERR        Begsr
023100020304     C                   Move      WTM(1)        WWMSG
023200020304     C                   Exsr      SNDMSG
023300020304     C                   Move      'ERROR   '    WORTN
023400020304     C                   Move      'END'         WWSTT
023500020304     C                   Endsr
023600020304      *___________________________________________________________________
023700020304      * Receive messages
023800020304      *___________________________________________________________________
023900020304     C     RCVMSG        Begsr
024000020304B1   C                   IF        WWMSGC <> 'NORESET'
024100020304     C                   Movel     'RECEIVE'     WWRQS
024200020304X1   C                   Else
024300020304     C                   Movel     'DISPLAY'     WWRQS
024400020304E1   C                   Endif
024500020304     C                   Movel     'RESET   '    WWMSGC
024600020304     C                   Movea     *IN           WWIN
024700020304     C                   Call      'PRCMSG2'
024800020304     C                   Parm                    WWRQS
024900020304     C                   Parm                    WWIN
025000020304     C                   Parm                    WWRTN
025100020304     C                   Movea     WWIN          *IN
025200020304     C                   Endsr
025300020304      *___________________________________________________________________
025400020304      * Display panels
025500020304      *___________________________________________________________________
025600020304     C     DSPPNL        Begsr
025700020304      *
025800020304      * Set PUTOVR based on last display file processed
025900020304B1   C                   IF        WUPGM <> WQPGMN OR WWPNL <> WWPNLO
026000020304     C                   MOVE      *OFF          *IN35
026100020304     C                   Move      WQPGMN        WUPGM
026200020304     C                   Move      WWPNL         WWPNLO
026300020304X1   C                   Else
026400020304     C                   MOVE      *ON           *IN35
026500020304E1   C                   Endif
026600020304      *
026700020304      * Set PROTECT key based on request
026800020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
026900020304     C                             WWTSK = 'COPY  '
027000020304 001 C                   Setoff                                       40
027100020304X001 C                   Else
027200020304 001 C                   Seton                                        40
027300020304E001 C                   Endif
027400020304      *
027500020304      * Select title
027600020304     C                   IF        WWTSK = 'CHANGE'
027700020304 001 C                   MOVE      *OFF          *IN38
027800020304X001 C                   Else
027900020304 001 C                   MOVE      *ON           *IN38
028000020304E001 C                   Endif
028100020304      *
028200020304      * Position cursor based on error status
028300020304     C                   IF        WWERR = 'Y'
028400020304 001 C                   MOVE      *ON           *IN99
028500020304X001 C                   Else
028600020304 001 C                   MOVE      *OFF          *IN99
028700020304E001 C                   Endif
028800020304      *
028900020304      * Write message subfile
029000020304     C                   Seton                                        30
029100020304     C                   Write     MSGCTL
029200060105    ***
029300020304      * Write entry panel
029400020304B001 C                   Select
029500020304     C                   WHEN      WWPNL = 1
029600171207     C                   eval      WSNAME = %trim(UHFIRST) + ' ' +
029700171207     C                                      %trim(UHLAST)
029800171208     C     UHTRND        mult      10000.0001    WSTRND
029900171208     C     UHAPPD        mult      10000.0001    WSAPPD
030000220209
030100220209     C                   clear                   WSERRR
030200220209     C     UHERRR        chain     TRNERRP
030300220209     C                   if        %found(TRNERRP)
030400220209     C                   eval      WSERRR  = %trim(ERREAS)
030500220209     C                   end
030600220209
030700171207     C     ACCKEY        chain     ACCMST
030800171208     C                   eval      WSACNM = %trim(A_ACNAM1)
030900171208     C     A_AACODE      chain     AACODE
031000171208     C                   eval      WSAANM = %trim(AFNAM) + ' ' +
031100171208     C                                      %trim(ALNAM)
031200020304 001 C                   Exfmt     ENTPNL
031300020304 001 C                   Setoff                                       37
031400020304E001 C                   Endsl
031500020304      *
031600020304B001 C                   If        *IN39 = *ON
031700020304 001 C                   Move      'Y'           WWCHG
031800020304E001 C                   Endif
031900171207    ***
032000171207     C     ACCKEY        klist
032100171207     C                   kfld                    UHTRST
032200171207     C                   kfld                    UHSUB#
032300171207     C                   kfld                    UHACCT
032400020304     C                   Endsr
032500020304      *___________________________________________________________________
032600020304      * Process function key
032700020304      *___________________________________________________________________
032800020304     C     PRCFKY        Begsr
032900020304     C                   Movea     *IN           WWIN
033000020304     C                   Call      'PRCFKY2'
033100020304     C                   Parm      'PROCESS '    WWRQS
033200020304     C     WWFKA         Parm                    WWRTN
033300020304     C                   Parm                    WAD
033400020304     C                   Parm                    WWIN
033500020304     C                   Parm                    WAF
033600020304     C                   Parm                    WIFKV
033700020304     C                   Endsr
033800020304      *___________________________________________________________________
033900020304      * Process KEYS function
034000020304      *___________________________________________________________________
034100020304     C     PRCDKY        Begsr
034200020304     C                   Z-add     1             WW
034300020304     C                   DOU       WWFKS = 1 OR WAD(WW) <> *BLANKS
034400020304 001 C     WWFKS         Add       1             WWFKS
034500020304 001  *
034600020304     C                   IF        WWFKS > 3
034700020304 002 C                   Z-add     1             WWFKS
034800020304E002 C                   Endif
034900020304 001  *
035000020304 001 C     WWFKS         Add       WWFKS         WW
035100020304 001 C                   Sub       1             WW
035200020304E001 C                   Enddo
035300020304      *
035400020304     C                   Movel     WAD(WW)       WSFKD1
035500020304     C                   Add       1             WW
035600020304     C                   Movel     WAD(WW)       WSFKD2
035700020304     C                   Endsr
035800020304      *___________________________________________________________________
035900020304      * Process EXIT Function
036000020304      *___________________________________________________________________
036100020304     C     PRCEXT        Begsr
036200020304      *
036300020304     C                   Exsr      PRCPNL
036400020304      *
036500020304     C                   IF        WWERR = 'Y'
036600020304 001 C                   Move      *BLANKS       WWSTT
036700020304X001 C                   Else
036800020304 001 C                   Movel     WWFKA         WORTN
036900020304 001 C                   Move      'END'         WWSTT
037000020304E001 C                   Endif
037100020304     C                   Endsr
037200020304      *___________________________________________________________________
037300020304      * Process PROMPT function
037400020304      *___________________________________________________________________
037500020304     C     PRCPMT        Begsr
037600020304     C                   Movel     WDCRSL        WWRQS
037700020304     C                   Move      'Y'           WWCHG
037800020304     C                   Move      'N'           WWWRNF
037900020304     C                   Movel     'NORESET '    WWMSGC
038000020304      *
038100020304B001 C                   Select
038200060105 001 C                   When      WSFLD = 'XXXXXX'
038300020304     C*                  Call      'SLCCRM'                                     *ENTRY LIST
038400040305     C*                  Parm                    WWRQS                          PROGRAM REQUEST
038500040305     C*                  Parm                    WWRTN                          RETURN CODE
038600040305     C*                  Parm                    WUPGM                          LAST PGM NAME
038700020304     C*                  Parm                    WDCARP                         RECORD DS
038800020304     C                   IF        WWRTN = *BLANKS
038900020304     C*                  Eval      MSCAID   =    CMCARR
039000020304     C*                  EVAL      WSCNAME  =    CMNAME
039100020304E001 C                   Endif
039200020304 001  *
039300020304 001 C                   Other
039400020304 001 C                   Move      WTM(6)        WWMSG
039500020304 001 C                   Exsr      SNDMSG
039600020304E001 C                   Endsl
039700020304      *
039800020304      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
039900020304     C                   Movel     WDCRSL        WWCRSL
040000020304     C     WWCRSN        Div       256           WSROW
040100020304     C                   Mvr                     WSLIN
040200020304     C                   Seton                                        37
040300020304      *
040400020304     C                   Endsr
040500020304      *___________________________________________________________________
040600020304      * Process CANCEL Function
040700020304      *___________________________________________________________________
040800020304     C     PRCCNL        Begsr
040900020304     C                   Movel     WWFKA         WORTN
041000020304     C                   Move      'END'         WWSTT
041100020304     C                   Move      'N'           WWCHG
041200020304     C                   Endsr
041300020304      *___________________________________________________________________
041400020304      * Process ROLLUP function
041500020304      *___________________________________________________________________
041600020304     C     PRCRUP        Begsr
041700020304     C     WWPNL         Add       1             WWPNL
041800020304     C                   IF        WWPNL > WWPNLN
041900020304 001 C     WWPNL         Sub       1             WWPNL
042000020304E001 C                   Endif
042100020304     C                   Movel     'NORESET '    WWMSGC
042200020304     C                   Endsr
042300020304      *___________________________________________________________________
042400020304      * Process ROLLDOWN function
042500020304      *___________________________________________________________________
042600020304     C     PRCRDN        Begsr
042700020304     C     WWPNL         Sub       1             WWPNL
042800020304     C                   IF        WWPNL < 1
042900020304 001 C     WWPNL         Add       1             WWPNL
043000020304E001 C                   Endif
043100020304     C                   Movel     'NORESET '    WWMSGC
043200020304     C                   Endsr
043300020304      *___________________________________________________________________
043400020304      * Process ENTER function
043500020304      *___________________________________________________________________
043600020304     C     PRCPNL        Begsr
043700020304     C                   Move      *BLANKS       WWRTN
043800020304     C                   Movea     *ZEROS        *IN(60)
043900020304     C                   IF        *IN39 = *ON OR WWWRNF = 'N'
044000020304 001 C                   Move      'N'           WWWRNF
044100020304     C                   IF        WWTSK = 'CHANGE  '
044200171207 001 C                   Call      'CHKUHC  '
044300020304 001 C                   Parm      'EDTCHG  '    WWRQS
044400020304 001 C                   Parm                    WWRTN
044500171207 001 C                   Parm                    WUDTA
044600020304     C                   ELSE
044700171207 001 C                   Call      'CHKUHC  '
044800020304 001 C                   Parm      'EDTADD  '    WWRQS
044900020304 001 C                   Parm                    WWRTN
045000171207 001 C                   Parm                    WUDTA
045100020304E001 C                   Endif
045200020304E001 C                   Endif
045300020304      *
045400020304B001 C                   Select
045500020304     C                   WHEN      WWRTN = *BLANKS
045600020304 001 C                   Move      'N'           WWERR
045700020304 001  *
045800020304     C                   WHEN      WWRTN = 'WARNING'
045900020304     C                   IF        WWWRNF = 'Y'
046000020304 002 C                   Move      'N'           WWERR
046100020304X002 C                   Else
046200020304 002 C                   Move      'Y'           WWWRNF
046300020304 002 C                   Move      'Y'           WWERR
046400020304E002 C                   Endif
046500020304 001  *
046600020304     C                   WHEN      WWRTN = 'ERROR  '
046700020304 001 C                   Move      'Y'           WWERR
046800020304 001 C                   Move      *BLANKS       WWSTT
046900020304 001 C                   Move      'N'           WWWRNF
047000020304E001 C                   Endsl
047100020304      *
047200020304     C                   Endsr
047300020304      *___________________________________________________________________
047400020304      * Process end - write data or release record
047500020304      *___________________________________________________________________
047600020304     C     PRCEND        Begsr
047700020304      *
047800020304     C                   IF        WWCHG = 'Y' AND WWERR = 'N'
047900020304 001 C     WWTSK         Caseq     'ADD     '    WRTADD
048000020304 001 C     WWTSK         Caseq     'ADDKEY  '    WRTADD
048100020304 001 C     WWTSK         Caseq     'INSKEY  '    WRTADD
048200020304 001 C     WWTSK         Caseq     'CPYKEY  '    WRTADD
048300020304 001 C     WWTSK         Caseq     'CHANGE  '    WRTCHG
048400020304 001 C     WWTSK         Caseq     'COPY    '    WRTADD
048500020304 001 C     WWTSK         Caseq     'INSERT  '    WRTADD
048600020304 001 C                   Endcs
048700020304 001  *
048800020304     C                   IF        WWRTN <> *BLANKS
048900020304 002 C                   Move      *BLANKS       WWSTT
049000020304 002  *
049100020304X002 C                   Else
049200020304     C                   IF        WWFKA <> 'EXIT'
049300020304     C                   IF        WWTSK = 'BYPASS  ' OR WWTSK = 'SKIP    '
049400020304 004 C                   Exsr      PRPPNL
049500020304E004 C                   Endif
049600020304E003 C                   Endif
049700020304E002 C                   Endif
049800020304 001  *
049900020304X001 C                   Else
050000020304 001 C                   Exsr      RELREC
050100020304E001 C                   Endif
050200020304      *
050300020304     C                   Endsr
050400020304      *___________________________________________________________________
050500020304      * Add new record
050600020304      *___________________________________________________________________
050700020304     C     WRTADD        Begsr
050800020304     C                   IF        WWTSK = 'ADD   ' OR WWTSK = 'INSERT' OR
050900020304     C                             WWTSK = 'COPY  '
051000020304 001 C                   Movel     'ADD    '     WWRQS
051100020304E001 C                   Endif
051200020304      *
051300020304     C                   IF        WWTSK = 'ADDKEY' OR WWTSK = 'INSKEY' OR
051400020304     C                             WWTSK = 'CPYKEY'
051500020304 001 C                   Movel     'ADDKEY '     WWRQS
051600020304E001 C                   Endif
051700020304      *
051800171207     C                   Call      'UPDUHC  '
051900020304     C                   Parm                    WWRQS
052000020304     C                   Parm                    WWRTN
052100020304     C                   Parm                    WUDTA
052200020304      *
052300020304     C                   IF        WWRTN <> *BLANKS
052400020304 001 C                   Movel     WTM(3)        WWMSG
052500020304 001 C                   Exsr      SNDMSG
052600020304X001 C                   Else
052700020304E001 C                   Endif
052800020304      *
052900020304     C                   Endsr
053000020304      *___________________________________________________________________
053100020304      * Write changed record
053200020304      *___________________________________________________________________
053300020304     C     WRTCHG        Begsr
053400171207     C                   eval      UHAPPU = WQUSRN
053500171207     C     *DATE         mult      10000.0001    UHAPPD
053600171207     C                   Time                    UHAPPT
053700180725     C                   If        UHNOTE = 'M91' or
053800180725     C                             UHNOTE = 'M92' or
053900180725     C                             UHNOTE = 'M93' or
054000180725     C                             UHNOTE = 'M94' or
054100210629     C                             UHNOTE = 'M95' or
054200210629     C                             UHNOTE = 'M96' or
054300210629     C                             UHNOTE = 'M97'
054400180725     C                   eval      UHCOMP = 'Y'
054500180725     C                   End
054600171207     C                   Call      'UPDUHC  '
054700020304     C                   Parm      'CHANGE'      WWRQS
054800020304     C                   Parm                    WWRTN
054900020304     C                   Parm                    WUDTA
055000020304     C                   IF        WWRTN <> *BLANKS
055100020304 001 C                   Movel     WTM(2)        WWMSG
055200020304 001 C                   Exsr      SNDMSG
055300020304E001 C                   Endif
055400020304      *
055500020304     C                   Endsr
055600020304      *___________________________________________________________________
055700020304      * Release record
055800020304      *___________________________________________________________________
055900020304     C     RELREC        Begsr
056000171207     C                   Call      'UPDUHC  '
056100020304     C                   Parm      'RELEASE '    WWRQS
056200020304     C                   Parm                    WWRTN
056300020304     C                   Parm                    WUDTA
056400020304     C                   IF        WWRTN <> *BLANKS
056500020304 001 C                   Movel     WTM(4)        WWMSG
056600020304 001 C                   Exsr      SNDMSG
056700020304E001 C                   Endif
056800020304     C                   Endsr
056900020304      *___________________________________________________________________
057000020304      * Build function keys
057100020304      *___________________________________________________________________
057200020304     C     BLDFKY        Begsr
057300020304     C                   Movea     *IN           WWIN
057400020304     C                   Call      'PRCFKY2'
057500020304     C                   Parm      'BUILD   '    WWRQS
057600020304     C     WWFKA         Parm                    WWRTN
057700020304     C                   Parm                    WAD
057800020304     C                   Parm                    WWIN
057900020304     C                   Parm                    WAF
058000020304     C                   Parm                    WIFKV
058100020304     C     WWFKS         Add       WWFKS         WW
058200020304     C                   Movel     WAD(WW)       WSFKD2
058300020304     C                   Sub       1             WW
058400020304     C                   Movel     WAD(WW)       WSFKD1
058500020304     C                   Endsr
058600020304      *___________________________________________________________________
058700020304      * Send message
058800020304      *___________________________________________________________________
058900020304     C     SNDMSG        Begsr
059000020304     C                   Call      'QSNDDTAQ'
059100020304     C                   Parm                    WWDTAQ
059200020304     C                   Parm                    WWLIB
059300020304     C                   Parm                    WWLNGQ
059400020304     C                   Parm                    WWMSG
059500020304     C                   Endsr
059600020304      *___________________________________________________________________
059700020304      * Paremater list
059800020304      *___________________________________________________________________
059900020304     C     PLIST         Begsr
060000020304     C     *ENTRY        Plist
060100020304     C     WWTSK         Parm                    WIRQS
060200020304     C                   Parm                    WORTN
060300020304     C                   Parm                    WUPGM
060400020304     C                   Parm                    WUDTA
060500020304     C                   Parm                    WIFKV
060600020304     C                   Endsr
060700020304      *___________________________________________________________________
060800020304      * Initialize routine
060900020304      *___________________________________________________________________
061000020304     C     *INZSR        Begsr
061100020304     C     *LIKE         Define    WUDTA         WWDTA
061200020304     C     *LIKE         Define    WIRQS         WWRQS
061300020304     C     *LIKE         Define    WIRQS         WWORQS
061400020304     C     *LIKE         Define    WIRQS         WWTSK
061500020304     C     *LIKE         Define    WORTN         WWRTN
061600020304     C     *LIKE         Define    WORTN         WWFKA
061700020304     C     *LIKE         Define    WIFKV         WWFKV
061800020304     C     *LIKE         Define    WIFKV         WWOPV
061900020304     C                   Movel     'RESET   '    WWMSGC
062000020304     C                   Movel     '*'           MSPGMQ
062100020304     C                   Movel     'MSGDTAQ'     WWDTAQ
062200020304     C                   Movel     'QTEMP'       WWLIB
062300020304     C                   Z-add     80            WWLNGQ
062400020304     C                   Move      *BLANKS       WWMSG
062500020304     C                   Move      *BLANKS       WWIN
062600020304     C                   Move      *BLANKS       WWSTT
062700020304     C                   Move      *ZEROS        WWZERO
062800020304     C                   Z-add     1             WWPNL
062900020304     C                   Z-add     1             WWPNLN
063000020304     C                   Z-add     1             WWFKS
063100020304     C                   Move      'N'           WWERR
063200020304     C                   Move      'N'           WWCHG
063300020304     C                   Move      'N'           WWWRNF
063400020304     C                   Z-add     0             WW
063500171207     C                   Movel(P)  'UHCHSTP'     WWFIL
063600020304     C                   Move      *BLANKS       WWFLK
063700020304     C                   Move      *BLANKS       WWTXT
063800020304     C                   Endsr
063900020304      *___________________________________________________________________
064000020304      * Program error handler
064100020304      *___________________________________________________________________
064200020304     C     *PSSR         Begsr
064300020304     C                   Call      'SNDRPGM'                            50
064400020304     C                   Parm                    WQPGMN
064500020304     C                   Parm                    WQSTSC
064600020304     C                   Parm                    WQRPGS
064700020304     C                   Parm                    WQMSG
064800020304     C                   Endsr     '*CANCL'
064900020304      *___________________________________________________________________
065000020304**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06510002030403EXIT    F3=Exit
06520002030404PROMPT  F4=Prompt
06530002030405REFRESH F5=Refresh
06540002030410UPDATE  F10=Update
06550002030412CANCEL  F12=Cancel
06560002030425ROLLUP
06570002030426ROLLDOWN
065800020304** WTM
06590017120700Request not supported in program CHGUHC.
06600002030400Update error.  Data was not updated.
06610002030400Duplicate key detected.  Data was NOT added to file.
06620002030400Record not found.
06630002030400Record not available now.
06640002030400The cursor is not in a prompt area.
06650002030400Default error.  Data not defaulted.
