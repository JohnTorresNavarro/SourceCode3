000100000327      *? COMPILE:
000200000407      *?   CRTBNDRPG  PGM(&O/&N) SRCFILE(&L/&F) DFTACTGRP(*NO) DBGVIEW(*SOURCE)
000300000000      *?________________________________________________________________________
000400000000      *?
000500000410      *? Description:  Change AACODE file
000600000000      *?
000700000000      *? (c)Copyright 1999 by Inovative Outsourcing, Inc.
000800000000      *? This document contains restricted materials of IO, Inc.
000900000000      *?
001000000000      *? History:
001100000000      *?________________________________________________________________________
001200000322
001300000410     FFM142D    CF   E             WORKSTN
001400000114     F                                     INFDS(DSPD)
001500000127     FTMPREF    IF   E             DISK
001600000000      *?________________________________________________________________________
001700000000      *?
001800000210     D WAD             S             80    DIM(6)
001900000327     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
002000000210     D WTM             S             80    DIM(10) CTDATA PERRCD(1)
002100000000      *?________________________________________________________________________
002200000114     D ISO_DATE        S               D   DATFMT(*ISO)
002300000114     D USA_DATE        S               D   DATFMT(*USA)
002400000327     D WWDATA          S                   LIKE(WDDATA)
002500000328    ? *?________________________________________________________________________
002600000328    ? *?PROCEDURES
002700000308      /COPY QGPL/QRPGLESRC,FUNCT_PR#
002800000308      /COPY QGPL/QRPGLESRC,SNDRPG_PR#
002900000315      /COPY QGPL/QRPGLESRC,SNDMSG_PR#
003000020425      /COPY GBSPGM/QRPGLESRC,FM149#
003100020425      /COPY GBSPGM/QRPGLESRC,FM141#
003200000000      *?
003300000328      *?Data structure
003400000410     D WDDATA        E DS                  EXTNAME(FM140W)
003500000322      *?KEY FIELDS
003600000410     D  ACODE2                        3    OVERLAY(WDDATA)
003700000000      *?
003800000000      *?Program status data structure
003900000114     D PGMD          ESDS                  EXTNAME(IOPGMD)
004000000000      *?
004100000000      *?Display file data structure
004200000114     D DSPD          E DS                  EXTNAME(IODSPD)
004300000000      *?
004400000000      *?CURSOR LOCATION
004500000114     D                 DS
004600000114     D  WWCRSL                 1      2
004700000114     D  WWCRSN                 1      2B 0
004800000000      *?________________________________________________________________________
004900000000      *?
005000000308      *?Process   POVR    entry panel
005100000210     C                   IF        WWTSK = 'COPY' OR
005200000210     C                             WWTSK = 'CPYKEY'
005300000327     C                   MOVE      WDDATA        WWDATA
005400000210     C                   END
005500000000      *?
005600000210     C                   EXSR      PRPPNL
005700000000      *?
005800000210    ?C                   DOW       WWSTT <> 'END'
005900000215     C                   IF        WWMSGC <> 'NORESET'
006000000215     C                   MOVEL     'RECEIVE'     WWRQS
006100000215    C                   ELSE
006200000215     C                   MOVEL     'DISPLAY'     WWRQS
006300000215     C                   END
006400000215     C                   MOVEL     'RESET   '    WWMSGC
006500000215     C                   EXSR      RCVMSG
006600000210     C                   EXSR      DSPPNL
006700000201     C                   EXSR      PRCFKY
006800000127      *?
006900000119     C                   SELECT
007000000127      *?
007100000210     C                   WHEN      WWFKA = 'EXIT    '
007200000222     C                   EVAL      WWSTT =  'END'
007300000127      *?
007400000210     C                   WHEN      WWFKA = 'REFRESH ' OR
007500000210     C                             WWFKA = 'ENTER   '
007600000201     C                   EXSR      PRCPNL
007700000127      *?
007800000210     C                   WHEN      WWFKA = 'CANCEL  '
007900000201     C                   EXSR      PRCCNL
008000000127      *?
008100000210     C                   WHEN      WWFKA = 'ROLLUP  '
008200000201     C                   EXSR      PRCRUP
008300000127      *?
008400000210     C                   WHEN      WWFKA = 'ROLLDOWN'
008500000201     C                   EXSR      PRCRDN
008600000127      *?
008700000210     C                   WHEN      WWFKA = 'PROMPT  '
008800000216     C                   EXSR      PRCPMT
008900000127      *?
009000000210     C                   WHEN      WWFKA = 'KEYS    '
009100000201     C                   EXSR      PRCDKY
009200000309      *?
009300000210     C                   ENDSL
009400000127      *?
009500000210     C                   IF        WWSTT = 'END'
009600000210     C                   EXSR      PRCEND
009700000210     C                   END
009800000210      *?
009900000210    ?C                   ENDDO
010000000000      *?
010100000216     C                   EVAL      *INLR = *ON
010200000210     C                   RETURN
010300000000      *?__________________________________________________________________
010400000000      *?Prepare panel
010500000000      *?__________________________________________________________________
010600000210     C     PRPPNL        BEGSR
010700000210     C                   MOVE      *BLANKS       WORTN
010800000210     C                   MOVE      'N'           WWERR
010900000210     C                   MOVE      'N'           WWCHG
011000000210     C                   MOVE      'N'           WWWRNF
011100000210     C                   MOVE      *BLANKS       WWSTT
011200000114     C                   EVAL      WWPNL = 1
011300000114     C                   EVAL      WWFKS = 1
011400000210     C                   MOVEA     WWZERO        *IN(60)
011500000210     C                   MOVE      *BLANKS       WWSTT
011600000000      *?
011700000210     C                   IF        WQPGMN = WUPGM
011800000210     C                   IF        WIRQS <> WWORQS
011900000210     C                   MOVE      *BLANKS       WUPGM
012000000210     C                   END
012100000210     C                   MOVE      WIRQS         WWORQS
012200000210     C                   END
012300000000      *?
012400000210     C                   EXSR      BLDFKY
012500000000      *?
012600000119     C                   SELECT
012700000210     C                   WHEN      WWTSK = 'CHANGE  '
012800000119     C                   EXSR      PRPCHG
012900000119      *?
013000000210     C                   WHEN      WWTSK = 'ADD     ' OR
013100000210     C                             WWTSK = 'INSERT  '
013200000119     C                   EXSR      PRPADD
013300000119      *?
013400000210     C                   WHEN      WWTSK = 'COPY    '
013500000119     C                   EXSR      PRPCPY
013600000119      *?
013700000119     C                   OTHER
013800000210     C                   EXSR      PRCERR
013900000210     C                   ENDSL
014000000000      *?
014100000210     C                   ENDSR
014200000000      *?__________________________________________________________________
014300000000      *?Prepare ADD request
014400000000      *?__________________________________________________________________
014500000210     C     PRPADD        BEGSR
014600000327    ?C                   CLEAR                   WDDATA
014700000210     C                   EXSR      DFTDTA
014800000210     C                   ENDSR
014900000000      *?__________________________________________________________________
015000000000      *?Prepare CHANGE request
015100000000      *?__________________________________________________________________
015200000210     C     PRPCHG        BEGSR
015300000131     C                   EVAL      FUNCTION = 'GET     '
015400000210     C                   CALLP     UPDAT
015500000210     C                   IF        WWRTN <> *BLANKS
015600000210     C                   IF        WWRTN = 'NOTAVL'
015700000327     C                   MOVEL     WTM(5)        WWMSG
015800000210    C                   ELSE
015900000327     C                   MOVEL     WTM(4)        WWMSG
016000000210     C                   END
016100000215     C                   CALLP     SNDMSG
016200000210     C                   MOVE      'ERROR   '    WORTN
016300000210     C                   MOVE      'END'         WWSTT
016400000210     C                   END
016500000210     C                   ENDSR
016600000000      *?__________________________________________________________________
016700000000      *?Prepare COPY request
016800000000      *?__________________________________________________________________
016900000210     C     PRPCPY        BEGSR
017000000322      *?KEY FIELD(S)______________________________________________________
017100000410     C                   EVAL      ACODE2   = ACODE
017200000308
017300000131     C                   EVAL      FUNCTION = 'GETNL   '
017400000210     C                   CALLP     UPDAT
017500000210     C                   IF        WWRTN <> *BLANKS
017600000327     C                   MOVEL     WTM(4)        WWMSG
017700000215     C                   CALLP     SNDMSG
017800000210     C                   MOVE      'ERROR   '    WORTN
017900000210     C                   MOVE      'END'         WWSTT
018000000210    C                   ELSE
018100000210     C                   MOVE      'Y'           WWCHG
018200000322      *?KEY FIELDS
018300000410    ?C                   CLEAR                   ACODE
018400000210     C                   END
018500000210     C                   ENDSR
018600000306      *?__________________________________________________________________
018700000306      *?Prepare COPY request
018800000306      *?__________________________________________________________________
018900000306     C     PRPCPY2       BEGSR
019000000306     C                   EVAL      FUNCTION = 'GETNL   '
019100000306     C                   CALLP     UPDAT
019200000306     C                   MOVE      'Y'           WWCHG
019300000410     C                   ENDSR
019400000000      *?__________________________________________________________________
019500000000      *?Default Data
019600000000      *?__________________________________________________________________
019700000210     C     DFTDTA        BEGSR
019800000131     C                   EVAL      FUNCTION = 'DFTDTA  '
019900000131     C                   CALLP     CHECK
020000000210     C                   IF        WWRTN <> *BLANKS
020100000327     C                   MOVEL     WTM(7)        WWMSG
020200000215     C                   CALLP     SNDMSG
020300000210     C                   MOVE      'ERROR   '    WORTN
020400000210     C                   MOVE      'END'         WWSTT
020500000210     C                   END
020600000210     C                   ENDSR
020700000000      *?__________________________________________________________________
020800000000      *?Process ERROR function
020900000000      *?__________________________________________________________________
021000000210     C     PRCERR        BEGSR
021100000210     C                   MOVE      WTM(1)        WWMSG
021200000215     C                   CALLP     SNDMSG
021300000210     C                   MOVE      'ERROR   '    WORTN
021400000210     C                   MOVE      'END'         WWSTT
021500000210     C                   ENDSR
021600000000      *?__________________________________________________________________
021700000000      *?Display panels
021800000000      *?__________________________________________________________________
021900000210     C     DSPPNL        BEGSR
022000000000      *?
022100000000      *?Set PUTOVR based on last display file processed
022200000113     C                   IF        WQPGMN <> WUPGM OR
022300000113     C                             WWPNL <> WWPNLO
022400000114     C                   EVAL      *IN35 = *OFF
022500000210     C                   MOVE      WQPGMN        WUPGM
022600000210     C                   MOVE      WWPNL         WWPNLO
022700000210    C                   ELSE
022800000114     C                   EVAL      *IN35 = *ON
022900000210     C                   END
023000000000      *?
023100000000      *?Set PROTECT key based on request
023200000210     C                   IF        WWTSK = 'ADD   ' OR
023300000210     C                             WWTSK = 'INSERT' OR
023400000210     C                             WWTSK = 'COPY  '
023500000114     C                   EVAL      *IN40 = *OFF
023600000210    C                   ELSE
023700000114     C                   EVAL      *IN40 = *ON
023800000210     C                   END
023900000000      *?
024000000000      *?Select title
024100000210     C                   IF        WWTSK = 'CHANGE'
024200000114     C                   EVAL      *IN38 = *OFF
024300000210    C                   ELSE
024400000114     C                   EVAL      *IN38 = *ON
024500000210     C                   END
024600000000      *?
024700000000      *?Position cursor based on error status
024800000210     C                   IF        WWERR = 'Y'
024900000114     C                   EVAL      *IN99 = *ON
025000000210    C                   ELSE
025100000114     C                   EVAL      *IN99 = *OFF
025200000210     C                   END
025300000000      *?
025400000000      *?Write message subfile
025500000114     C                   EVAL      *IN30 = *ON
025600000215    ?C                   WRITE     MSGSFLC
025700000000      *?
025800000000      *?Write entry panel
025900000127     C                   SELECT
026000000210     C                   WHEN      WWPNL = 1
026100000218     C     RETRY         TAG
026200000210    ?C                   EXFMT     ENTPNL
026300000114     C                   EVAL      *IN37 = *OFF
026400000119
026500000327     C*                  WHEN      WWPNL = 2
026600000327    ?C*                  EXFMT     ENTPNL2
026700000327     C*                  EVAL      *IN37 = *OFF
026800000119
026900000210     C                   ENDSL
027000000000      *?
027100000210     C                   IF        *IN39 = *ON
027200000210     C                   MOVE      'Y'           WWCHG
027300000210     C                   END
027400000210     C                   ENDSR
027500000000      *?__________________________________________________________________
027600000000      *?Process function key
027700000000      *?__________________________________________________________________
027800000201     C     PRCFKY        BEGSR
027900000128     C                   EVAL      FUNCTION = 'PROCESS '
028000000128     C                   CALLP     FUNCT
028100000210     C                   ENDSR
028200000000      *?__________________________________________________________________
028300000000      *?Process KEYS function
028400000000      *?__________________________________________________________________
028500000210     C     PRCDKY        BEGSR
028600000113     C                   EVAL      WW = 1
028700000210    ?C                   DOU       WWFKS = 1 OR
028800000210     C                             WAD(WW) <> *BLANKS
028900000210     C                   EVAL      WWFKS = WWFKS +1
029000000127      *?
029100000210     C                   IF        WWFKS > 3
029200000113     C                   EVAL      WWFKS = 1
029300000210     C                   END
029400000127      *?
029500000210     C                   EVAL      WW = WWFKS + WWFKS
029600000113     C                   EVAL      WW = WW - 1
029700000210    ?C                   ENDDO
029800000000      *?
029900000210     C                   MOVEL     WAD(WW)       WSFKD1
030000000113     C                   EVAL      WW = WW + 1
030100000210     C                   MOVEL     WAD(WW)       WSFKD2
030200000210     C                   ENDSR
030300000000      *?__________________________________________________________________
030400000000      *?Process EXIT Function
030500000000      *?__________________________________________________________________
030600000210     C     PRCEXT        BEGSR
030700000000      *?
030800000210     C                   EXSR      PRCPNL
030900000000      *?
031000000210     C                   IF        WWERR = 'Y'
031100000210     C                   MOVE      *BLANKS       WWSTT
031200000210    C                   ELSE
031300000210     C                   MOVEL     WWFKA         WORTN
031400000210     C                   MOVE      'END'         WWSTT
031500000210     C                   END
031600000210     C                   ENDSR
031700000121      *?__________________________________________________________________
031800000121      *?Process CANCEL Function
031900000121      *?__________________________________________________________________
032000000210     C     PRCCNL        BEGSR
032100000216     C                   MOVE      *BLANKS       WORTN
032200000210     C                   MOVE      'END'         WWSTT
032300000210     C                   MOVE      'N'           WWCHG
032400000210     C                   ENDSR
032500000000      *?__________________________________________________________________
032600000000      *?Process PROMPT function
032700000000      *?__________________________________________________________________
032800000216     C     PRCPMT        BEGSR
032900000210     C                   MOVE      'Y'           WWCHG
033000000210     C                   MOVE      'N'           WWWRNF
033100000210     C                   MOVEL     'NORESET '    WWMSGC
033200000000      *?
033300000210     C                   SELECT
033400000210     C                   OTHER
033500000327     C                   MOVE      WTM(6)        WWMSG
033600000131      *?__________________________________________________________________
033700000131      *?Send message
033800000131      *?__________________________________________________________________
033900000215     C                   CALLP     SNDMSG
034000000210     C                   ENDSL
034100000000      *?
034200000000      *?RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
034300000210     C                   MOVEL     WDCRSL        WWCRSL
034400000210     C     WWCRSN        DIV       256           WSROW
034500000210     C                   MVR                     WSLIN
034600000114     C                   EVAL      *IN37 = *ON
034700000000      *?
034800000210     C                   ENDSR
034900000000      *?__________________________________________________________________
035000000000      *?Process ROLLUP function
035100000000      *?__________________________________________________________________
035200000210     C     PRCRUP        BEGSR
035300000210     C                   EVAL      WWPNL = WWPNL + 1
035400000210     C                   IF        WWPNL > WWPNLN
035500000210     C                   EVAL      WWPNL = WWPNL - 1
035600000210     C                   END
035700000210     C                   MOVEL     'NORESET '    WWMSGC
035800000210     C                   ENDSR
035900000000      *?__________________________________________________________________
036000000000      *?Process ROLLDOWN function
036100000000      *?__________________________________________________________________
036200000210     C     PRCRDN        BEGSR
036300000210     C                   EVAL      WWPNL = WWPNL - 1
036400000210     C                   IF        WWPNL < 1
036500000210     C                   EVAL      WWPNL = WWPNL + 1
036600000210     C                   END
036700000210     C                   MOVEL     'NORESET '    WWMSGC
036800000210     C                   ENDSR
036900000000      *?__________________________________________________________________
037000000000      *?Process ENTER function
037100000000      *?__________________________________________________________________
037200000210     C     PRCPNL        BEGSR
037300000222
037400000210     C                   MOVE      *BLANKS       WWRTN
037500000210     C                   MOVEA     *ZEROS        *IN(60)
037600000210     C                   IF        *IN39 = *ON OR
037700000210     C                             WWWRNF = 'N'
037800000210     C                   MOVE      'N'           WWWRNF
037900000131     C                   EVAL      FUNCTION = 'EDIT    '
038000000131     C                   CALLP     CHECK
038100000210     C                   END
038200000000      *?
038300000210     C                   SELECT
038400000210     C                   WHEN      WWRTN = *BLANKS
038500000210     C                   MOVE      'N'           WWERR
038600000210     C                   MOVE      'END'         WWSTT
038700000127      *?
038800000210     C                   WHEN      WWRTN = 'WARNING'
038900000210     C                   IF        WWWRNF = 'Y'
039000000210     C                   MOVE      'N'           WWERR
039100000210     C                   MOVE      'END'         WWSTT
039200000210    C                   ELSE
039300000210     C                   MOVE      'Y'           WWWRNF
039400000210     C                   MOVE      'Y'           WWERR
039500000210     C                   END
039600000127      *?
039700000210     C                   WHEN      WWRTN = 'ERROR  '
039800000210     C                   MOVE      'Y'           WWERR
039900000210     C                   MOVE      *BLANKS       WWSTT
040000000210     C                   MOVE      'N'           WWWRNF
040100000210     C                   ENDSL
040200000000      *?
040300000216     C     ENDPNL        TAG
040400000210     C                   ENDSR
040500000000      *?__________________________________________________________________
040600000000      *?Process end - write data or release record
040700000000      *?__________________________________________________________________
040800000210     C     PRCEND        BEGSR
040900000000      *?
041000000210     C                   IF        WWCHG = 'Y' AND
041100000210     C                             WWERR = 'N'
041200000119      *?
041300000119     C                   SELECT
041400000210     C                   WHEN      WWTSK = 'CHANGE  '
041500000119     C                   EXSR      WRTCHG
041600000119      *?
041700000210     C                   WHEN      WWTSK = 'ADD     ' OR
041800000210     C                             WWTSK = 'INSERT  ' OR
041900000210     C                             WWTSK = 'INSKEY  ' OR
042000000222     C                             WWTSK = 'ADDKEY  '
042100000119     C                   EXSR      WRTADD
042200000222
042300000222     C                   WHEN      WWTSK = 'CPYKEY  ' OR
042400000222     C                             WWTSK = 'COPY    '
042500000306     C                   EXSR      PRPCPY2
042600000222     C                   EXSR      WRTADD
042700000119      *?
042800000210     C                   ENDSL
042900000127      *?
043000000210     C                   IF        WWRTN <> *BLANKS
043100000210     C                   MOVE      *BLANKS       WWSTT
043200000127      *?
043300000210    C                   ELSE
043400000210     C                   IF        WWFKA <> 'EXIT'
043500000210     C                   IF        WWTSK = 'ADD     ' OR
043600000210     C                             WWTSK = 'ADDKEY  '
043700000210     C                   EXSR      PRPPNL
043800000210     C                   END
043900000210     C                   END
044000000210     C                   END
044100000127      *?
044200000210    C                   ELSE
044300000210     C                   EXSR      RELREC
044400000210     C                   END
044500000000      *?
044600000210     C                   ENDSR
044700000000      *?__________________________________________________________________
044800000000      *?Add new record
044900000000      *?__________________________________________________________________
045000000210     C     WRTADD        BEGSR
045100000210     C                   IF        WWTSK = 'ADD    ' OR
045200000210     C                             WWTSK = 'INSERT ' OR
045300000210     C                             WWTSK = 'COPY   '
045400000210     C                   MOVEL     'ADD    '     WWRQS
045500000210     C                   END
045600000000      *?
045700000210     C                   IF        WWTSK = 'ADDKEY ' OR
045800000210     C                             WWTSK = 'INSKEY ' OR
045900000210     C                             WWTSK = 'CPYKEY '
046000000210     C                   MOVEL     'ADDKEY '     WWRQS
046100000210     C                   END
046200000000      *?
046300000222     C                   EVAL      FUNCTION = WWRQS
046400000210     C                   CALLP     UPDAT
046500000000      *?
046600000210     C                   IF        WWRTN <> *BLANKS
046700000210     C                   MOVEL     WTM(3)        WWMSG
046800000215     C                   CALLP     SNDMSG
046900000217    C                   ELSE
047000000327     C                   MOVEL     WTM(8)        WWMSG
047100000327     C                   CALLP     SNDMSG
047200000210     C                   END
047300000000      *?
047400000210     C                   ENDSR
047500000215      *?__________________________________________________________________
047600000215     C     RCVMSG        BEGSR
047700000215     C                   MOVEA     *IN           WWIN
047800000215    ?C                   CALL      'PRCMSG2'
047900000215     C                   PARM      'RECEIVE '    WWRQS
048000000215     C                   PARM                    WWIN
048100000215     C                   PARM                    WWRTN
048200000215     C                   MOVEA     WWIN          *IN
048300000215     C                   ENDSR
048400000000      *?__________________________________________________________________
048500000000      *?Write changed record
048600000000      *?__________________________________________________________________
048700000210     C     WRTCHG        BEGSR
048800000131      *?
048900000131     C                   EVAL      FUNCTION = 'CHANGE  '
049000000210     C                   CALLP     UPDAT
049100000210     C                   IF        WWRTN <> *BLANKS
049200000210     C                   MOVEL     WTM(2)        WWMSG
049300000215     C                   CALLP     SNDMSG
049400000217    C                   ELSE
049500000327     C                   MOVEL     WTM(9)        WWMSG
049600000327     C                   CALLP     SNDMSG
049700000210     C                   END
049800000000      *?
049900000210     C                   ENDSR
050000000000      *?__________________________________________________________________
050100000000      *?Release record
050200000000      *?__________________________________________________________________
050300000210     C     RELREC        BEGSR
050400000131     C                   EVAL      FUNCTION = 'RELEASE '
050500000210     C                   CALLP     UPDAT
050600000210     C                   IF        WWRTN <> *BLANKS
050700000327     C                   MOVEL     WTM(4)        WWMSG
050800000215     C                   CALLP     SNDMSG
050900000210     C                   END
051000000210     C                   ENDSR
051100000000      *?__________________________________________________________________
051200000000      *?Build function keys
051300000000      *?__________________________________________________________________
051400000201     C     BLDFKY        BEGSR
051500000128     C                   EVAL      FUNCTION = 'BUILD   '
051600000128     C                   CALLP     FUNCT
051700000210     C                   EVAL      WW = WWFKS + WWFKS
051800000210     C                   MOVEL     WAD(WW)       WSFKD2
051900000114     C                   EVAL      WW = WW -1
052000000210     C                   MOVEL     WAD(WW)       WSFKD1
052100000201     C                   ENDSR
052200000216      *?********************************************************88
052300000000      *?__________________________________________________________________
052400000000      *?Paremater list
052500000000      *?__________________________________________________________________
052600000210     C     PLIST         BEGSR
052700000210     C     *ENTRY        PLIST
052800000210     C     WWTSK         PARM                    WIRQS
052900000210     C                   PARM                    WORTN
053000000210     C                   PARM                    WUPGM
053100000327     C                   PARM                    WDDATA
053200000411     C                   PARM                    WIFKV
053300000210     C                   ENDSR
053400000000      *?__________________________________________________________________
053500000000      *?Initialize routine
053600000000      *?__________________________________________________________________
053700000210     C     *INZSR        BEGSR
053800000210     C                   MOVEL     '*'           MSPGMQ
053900000210     C                   EVAL      WWMSGC = 'RESET  '
054000000210     C                   EVAL      WWPNL  = 1
054100000322      *?NUMBER OF PANELS
054200000328     C                   EVAL      WWPNLN = 1
054300000210     C                   EVAL      WWFKS  = 1
054400000210     C                   EVAL      WWERR  = 'N'
054500000210     C                   EVAL      WWCHG  = 'N'
054600000210     C                   EVAL      WWWRNF = 'N'
054700000210     C                   ENDSR
054800000000      *?__________________________________________________________________
054900000000      *?Program error handler
055000000000      *?__________________________________________________________________
055100000215     C     *PSSR         BEGSR
055200000215     C                   CALLP     SNDRPG
055300000215     C                   ENDSR     '*CANCL'
055400000000      *?__________________________________________________________________
055500000327      *?PROCEDURES      ________________________________________________________
055600000327      /COPY QGPL/QRPGLESRC,FUNCT#
055700000327      /COPY QGPL/QRPGLESRC,SNDRPG#
055800000327      /COPY QGPL/QRPGLESRC,SNDMSG#
055900020425      /COPY GBSPGM/QRPGLESRC,FM149
056000020425      /COPY GBSPGM/QRPGLESRC,FM141
056100000000      *?__________________________________________________________________
056200000114**   AF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
05630000032703EXIT    F3=Exit
05640000032704PROMPT  F4=Prompt
05650000032705REFRESH F5=Refresh
05660000032712CANCEL  F12=Cancel
05670000011425ROLLUP
05680000011426ROLLDOWN
056900000114** WTM
05700000041000Request not supported in program FM142.
05710000011400Uppate error.  Data was not updated.
05720000011400Duplicate key detected.  Data was NOT added to file.
05730000011400Record not found.
05740000011400Record not available now.
05750000011400The cursor is not in a prompt area.
05760000011400Default error.  Data not defaulted.
05770000032700Record Added
05780000032700Record Changed
