000100000407    ? *? COMPILE:
000200000407    ? *?   CRTBNDRPG  PGM(&O/&N) SRCFILE(&L/&F) DFTACTGRP(*NO) DBGVIEW(*SOURCE)
000300000000      *?________________________________________________________________________
000400000000      *?
000500000410      *? Description:  TEMPLATE  AACODE
000600000000      *?
000700000000      *? (c)Copyright 1999 by Inovative Outsourcing, Inc.
000800000000      *? This document contains restricted materials of IO, Inc.
000900000000      *?
001000000000      *? History:
001100000000      *?________________________________________________________________________
001200000000      *?
001300000410     FFM148D    CF   E             WORKSTN
001400000000     F                                     SFILE(LSTSFL:WFRRN)
001500000000     F                                     INFDS(DSPD)
001600000410     FFM140W    IF   E           K DISK
001700000410     F                                     RENAME(AACODR:RFMT)
001800000328      *
001900000327     FTMPREF    IF   E             DISK
002000000000      *?________________________________________________________________________
002100000000      *?
002200000210     D WAO             S             38    DIM(30) CTDATA PERRCD(1)
002300000210     D WAP             S             75    DIM(6)
002400000210     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
002500000210     D WAD             S             80    DIM(6)
002600000210     D WTM             S             80    DIM(10) CTDATA PERRCD(1)
002700000327     D ISO_DATE        S               D   DATFMT(*ISO)
002800000327     D USA_DATE        S               D   DATFMT(*USA)
002900000322      *?KEY FIELDS IN DISPLAY - ONE FOR EACH FIELD______________________    ____
003000000201     D WWPSN1          S                   LIKE(WSPSN1)
003100000328    ? *?________________________________________________________________________
003200000328    ? *?PROCEDURES
003300000308      /COPY QGPL/QRPGLESRC,FUNCT_PR#
003400000308      /COPY QGPL/QRPGLESRC,SNDRPG_PR#
003500000308      /COPY QGPL/QRPGLESRC,SNDMSG_PR#
003600020425      /COPY GBSPGM/QRPGLESRC,FM149#
003700000000      *?
003800000000      *?Option code data structure
003900000000     D                 DS
004000000000     D  WDOPC                  1      2
004100000000     D  WDOPC1                 1      1
004200000000     D  WDOPC2                 2      2
004300000000      *?
004400000327      *?Data structure
004500000410     D WDDATA        E DS                  EXTNAME(FM140W)
004600000208      *?
004700000000      *?Program status data structure
004800000118     D PGMD          ESDS                  EXTNAME(IOPGMD)
004900000000      *?
005000000000      *?Display file data structure
005100991108     D DSPD          E DS                  EXTNAME(IODSPD)
005200000000      *?__________________________________________________________________
005300000000      *?
005400000210     C                   EXSR      PRPPNL
005500000000      *?
005600000210    ?C                   DOU       WWENDF =  'END'
005700000215     C                   EXSR      RCVMSG
005800000210     C                   EXSR      DSPPNL
005900000131      *?__________________________________________________________________
006000000131      *?Process function key pressed
006100000131      *?__________________________________________________________________
006200000131     C                   EVAL      FUNCTION = 'PROCESS '
006300000131     C                   CALLP     FUNCT
006400000327      *?__________________________________________________________________
006500000127      *?
006600000118     C                   SELECT
006700000210
006800000210     C                   WHEN      WWFKA = 'ENTER   '
006900000118     C                   EXSR      PRCENT
007000000118
007100000210     C                   WHEN      WWFKA = 'EXIT    ' OR
007200000210     C                             WWFKA = 'CANCEL  '
007300000118     C                   EXSR      PRCEXT
007400000210
007500000210     C                   WHEN      WWFKA = 'ROLLUP  '
007600000118     C                   EXSR      PRCRUP
007700000210
007800000210     C                   WHEN      WWFKA = 'ROLLDOWN'
007900000118     C                   EXSR      PRCRDN
008000000118
008100000210     C                   WHEN      WWFKA = 'ADD     ' OR
008200000210     C                             WWFKA = 'INSERT  '
008300000118     C                   EXSR      PRCADD
008400000118
008500000118     C                   WHEN      WWFKA = 'KEYS    '
008600000118     C                   EXSR      PRCDKY
008700000210
008800000210     C                   WHEN      WWFKA = 'OPTIONS '
008900000118     C                   EXSR      PRCDOP
009000000210
009100000210     C                   WHEN      WWFKA = 'PMTPSN  '
009200000118     C                   EXSR      PRCPMT
009300000118
009400000210     C                   WHEN      WWFKA = 'REFRESH '
009500000118     C                   EXSR      PRCRFR
009600000327
009700000210     C                   ENDSL
009800000210    ?C                   ENDDO
009900000216     C                   EVAL      *INLR = *ON
010000000210     C                   RETURN
010100000327      *?__________________________________________________________________
010200000215     C     RCVMSG        BEGSR
010300000328     C                   MOVEA     *IN           WWIN
010400000328    ?C                   CALL      'PRCMSG2'
010500000328     C                   PARM      'RECEIVE '    WWRQS
010600000328     C                   PARM                    WWIN
010700000328     C                   PARM                    WWRTN
010800000328     C                   MOVEA     WWIN          *IN
010900000215     C                   ENDSR
011000000000      *?__________________________________________________________________
011100000000      *?Prepare list panel
011200000000      *?__________________________________________________________________
011300000210     C     PRPPNL        BEGSR
011400000210     C                   EXSR      SETPSN
011500000000      *?
011600000210     C                   SELECT
011700000210     C                   WHEN      WIRQS = 'ADD' OR
011800000210     C                             WIRQS = 'ADDKEY' OR
011900000210     C                             WIRQS = 'INSERT' OR
012000000210     C                             WIRQS = 'INSKEY'
012100000210     C                   MOVE      WIRQS         WWFKA
012200000210     C                   EXSR      PRCADD
012300000127      *?
012400000210     C                   WHEN      WIRQS = 'CHANGE'
012500000210     C                   EXSR      PRCCHG
012600000127      *?
012700000210     C                   WHEN      WIRQS = 'LOAD'
012800000210     C                   EXSR      PRCPSN
012900000127      *?
013000000210     C                   WHEN      WIRQS = 'CLEAR'
013100000210     C                   EXSR      CLRSFL
013200000127      *?
013300000210     C                   WHEN      WIRQS = 'SLCNXT'
013400000210     C                   EXSR      SLCNXT
013500000210     C                   ENDSL
013600000000      *?
013700000210     C                   IF        WWENDF <> 'END'
013800000210     C                   EXSR      BLDOPT
013900000201     C                   EXSR      BLDFKY
014000000210     C                   END
014100000210     C                   ENDSR
014200000000      *?__________________________________________________________________
014300000000      *?Set position to screen indicators
014400000000      *?__________________________________________________________________
014500000210     C     SETPSN        BEGSR
014600000210    ?C     WWPSNI        DO        WWLMT         WW
014700000210     C                   MOVE      '0'           *IN(WW)
014800000210    ?C                   ENDDO
014900000113     C                   EVAL      WW = (WWPSNI + WWPSNP) - 1
015000000210     C                   MOVE      '1'           *IN(WW)
015100000210     C                   ENDSR
015200000000      *?__________________________________________________________________
015300000000      *?Display list panel
015400000000      *?__________________________________________________________________
015500000210     C     DSPPNL        BEGSR
015600000000      *?Set OVERLAY based on last display file processed
015700000210     C                   IF        WQPGMN <> WUPGM
015800000113     C                   EVAL      *IN35 = *OFF
015900000210     C                   MOVE      WQPGMN        WUPGM
016000000210    C                   ELSE
016100000113     C                   EVAL      *IN35 = *ON
016200000210     C                   END
016300000000      *?Write message subfile
016400000113     C                   EVAL      *IN30 = *ON
016500000210    ?C                   WRITE     MSGCTL
016600000000      *?Write function keys
016700000210     C                   IF        *IN35 = *OFF OR
016800000210     C                             WWFKS <> WWFKSO
016900000201    ?C                   WRITE     FKYDSC
017000000114     C                   EVAL      WWFKSO = WWFKS
017100000210     C                   END
017200000114
017300000000      *?Set subfile control panel overrides
017400000210     C                   IF        WWPSNC = 'Y'
017500000113     C                   EVAL      *IN36 = *OFF
017600000210     C                   MOVE      'N'           WWPSNC
017700000210    C                   ELSE
017800000113     C                   EVAL      *IN36 = *ON
017900000210     C                   END
018000000114
018100000210     C                   IF        WWOPS <> WWOPSO
018200000113     C                   EVAL      *IN37 = *ON
018300000113     C                   EVAL      WWOPSO = WWOPS
018400000210    C                   ELSE
018500000113     C                   EVAL      *IN37 = *OFF
018600000210     C                   END
018700000114
018800000118      *?Set subfile control indicators
018900000210     C                   IF        WFRRN = *ZERO
019000000113     C                   EVAL      *IN30 = *OFF
019100000210    C                   ELSE
019200000113     C                   EVAL      *IN30 = *ON
019300000210     C                   END
019400000000      *?Write subfile
019500000210    ?C                   EXFMT     LSTCTL
019600000118
019700000113     C                   EVAL      *IN63 = *OFF
019800000113     C                   EVAL      *IN36 = *OFF
019900000210     C                   ENDSR
020000000000      *?__________________________________________________________________
020100000000      *?Process KEYS function
020200000000      *?__________________________________________________________________
020300000210     C     PRCDKY        BEGSR
020400000114     C                   EVAL      WW = 1
020500000210    ?C                   DOU       WWFKS   = 1 OR
020600000210     C                             WAD(WW) <> *BLANKS
020700000113     C                   EVAL      WWFKS = WWFKS + 1
020800000127      *?
020900000210     C                   IF        WWFKS > 3
021000000113     C                   EVAL      WWFKS = 1
021100000210     C                   END
021200000322      *?
021300000113     C                   EVAL      WW = (WWFKS * 2) - 1
021400000210    ?C                   ENDDO
021500000000      *?
021600000113     C                   EVAL      WW = WWFKS + WWFKS
021700000210     C                   MOVEL     WAD(WW)       WSFKD2
021800000113     C                   EVAL      WW =  WW - 1
021900000210     C                   MOVEL     WAD(WW)       WSFKD1
022000000210     C                   ENDSR
022100000000      *?__________________________________________________________________
022200000121      *?Process EXIT AND CANCEL function
022300000000      *?__________________________________________________________________
022400000210     C     PRCEXT        BEGSR
022500000328     C                   EVAL      FUNCTION = 'EXIT    '
022600000328     C                   CALLP     UPDAT
022700000328     C                   IF        WWRTN <> *BLANKS
022800000328     C                   MOVE      WTM(6)        WWMSG
022900000328     C                   CALLP     SNDMSG
023000000328     C                   END
023100000210     C                   MOVEL     WWFKA         WORTN
023200000201     C                   MOVE      'END'         WWENDF
023300000210     C                   ENDSR
023400000000      *?__________________________________________________________________
023500000000      *?Process REFRESH function
023600000000      *?__________________________________________________________________
023700000210     C     PRCRFR        BEGSR
023800000210     C                   EXSR      PRCPSN
023900000210    ?C                   DOW       WSPAG  < WWLOWR AND
024000000210     C                             WWSFLE <> 'Y'
024100000210     C                   EXSR      PRCRUP
024200000210    ?C                   ENDDO
024300000210     C                   ENDSR
024400000000      *?__________________________________________________________________
024500000000      *?Process ADD function
024600000000      *?__________________________________________________________________
024700000210     C     PRCADD        BEGSR
024800000410    ?C                   CALL      'FM142   '                           99
024900000210     C                   PARM      WWFKA         WWRQS
025000000210     C                   PARM                    WWRTN
025100000210     C                   PARM                    WUPGM
025200000327     C                   PARM                    WDDATA
025300000201     C                   PARM      *BLANKS       WWFKY
025400000000      *?
025500000113     C                   IF        *IN99 = *ON
025600000327     C                   MOVEL     WTM(2)        WWMSG
025700000131      *?__________________________________________________________________
025800000131      *?Send message
025900000131      *?__________________________________________________________________
026000000215     C                   CALLP     SNDMSG
026100000210     C                   MOVEL     'ERROR'       WORTN
026200000210     C                   MOVEL     'ERROR'       WWRTN
026300000210     C                   END
026400000000      *?
026500000113     C                   IF        WWRTN = 'EXIT'
026600000210     C                   MOVEL     WWRTN         WORTN
026700000210     C                   MOVE      'END'         WWENDF
026800000210    C                   ELSE
026900000210     C                   EXSR      PRCRFR
027000000210     C                   END
027100000210     C                   ENDSR
027200000000      *?__________________________________________________________________
027300000000      *?Process POSITION TO function
027400000000      *?__________________________________________________________________
027500000210     C     PRCPMT        BEGSR
027600000000      *?
027700000210     C                   MOVE      '     '       WSFLD
027800000113     C                   EVAL      *IN63 = *ON
027900000210     C                   MOVE      'Y'           WWPSNC
028000000329     C                   EVAL      WSPAG = WWRRN
028100000210     C                   ENDSR
028200000000      *?__________________________________________________________________
028300000000      *?Process OPTIONS function
028400000000      *?__________________________________________________________________
028500000210     C     PRCDOP        BEGSR
028600000113     C                   EVAL      WW = 1
028700000210    ?C                   DOU       WWOPS = 1 OR
028800000210     C                             WAP(WW) <> *BLANKS
028900000113     C                   EVAL      WWOPS = WWOPS + 1
029000000127      *?
029100000210     C                   IF        WWOPS > 3
029200000113     C                   EVAL      WWOPS = 1
029300000210     C                   END
029400000127      *?
029500000113     C                   EVAL      WW = (WWOPS *2) - 1
029600000210    ?C                   ENDDO
029700000000      *?
029800000113     C                   EVAL      WW = WWOPS + WWOPS
029900000210     C                   MOVEL     WAP(WW)       WSOPD2
030000000113     C                   EVAL      WW = WW - 1
030100000210     C                   MOVEL     WAP(WW)       WSOPD1
030200000113     C                   EVAL      *IN36 = *ON
030300000210     C                   ENDSR
030400000000      *?__________________________________________________________________
030500000000      *?Process ROLL UP function (add a page to list subfile)
030600000000      *?__________________________________________________________________
030700000210     C     PRCRUP        BEGSR
030800000210     C                   MOVE      'N'           WWSFLE
030900000113     C                   EVAL      WSPAG = WWRRN
031000000113     C                   EVAL      WW = 1
031100000113     C                   EVAL      WFRRN = WWRRN
031200000113     C                   EVAL      *IN60 = *OFF
031300000210    ?C                   CLEAR                   LSTSFL
031400000222     C                   EVAL      *IN61 = *ON
031500000210    ?C                   DOW       WW <= WWLSTS
031600000210
031700000210     C                   IF        WWPSNP = 1
031800000327    ?C                   READ      RFMT
031900000210     C                   IF        NOT %EOF
032000000119
032100000114     C                   EVAL      WFRRN = WFRRN + 1
032200000114     C                   EVAL      WW    = WW    + 1
032300000210    ?C                   WRITE     LSTSFL
032400000210    C                   ELSE
032500000210     C                   MOVE      'Y'           WWSFLE
032600000303     C                   LEAVE
032700000210     C                   END
032800000210     C                   END
032900000127      *?
033000000210    ?C                   ENDDO
033100000000      *?
033200000210     C                   IF        WFRRN > WWRRN
033300000113     C                   EVAL      WSPAG = WWRRN + 1
033400000113     C                   EVAL      WWRRN = WFRRN
033500000210     C                   END
033600000000      *?
033700000210     C                   IF        WFRRN = *ZEROS
033800000327     C                   MOVE      WTM(5)        WWMSG
033900000215     C                   CALLP     SNDMSG
034000000210     C                   END
034100000000      *?
034200000210     C                   IF        WWSFLE = 'Y'
034300000113     C                   EVAL      *IN39 = *ON
034400000210    C                   ELSE
034500000113     C                   EVAL      *IN39 = *OFF
034600000210     C                   END
034700000000      *?
034800000210     C                   ENDSR
034900000000      *?__________________________________________________________________
035000000000      *?Process ROLLDOWN function (beginning of SFL reached)
035100000000      *?__________________________________________________________________
035200000210     C     PRCRDN        BEGSR
035300000113     C                   EVAL      WSPAG = 1
035400000210     C                   MOVE      WTM(1)        WWMSG
035500000215     C                   CALLP     SNDMSG
035600000210     C                   ENDSR
035700000000      *?__________________________________________________________________
035800000000      *?Process ENTER function
035900000000      *?__________________________________________________________________
036000000210     C     PRCENT        BEGSR
036100000210     C                   MOVE      *BLANKS       WWRTN
036200000328     C                   MOVE      *BLANKS       WWDLT
036300000000      *?
036400000210     C                   IF        WFRRN > *ZERO
036500000127      *?
036600000210    ?C                   DOU       %EOF
036700000210
036800000210    ?C                   READC     LSTSFL
036900000127      *?
037000000210     C                   IF        NOT %EOF
037100000210     C                   IF        WSOPC <> *BLANKS
037200000210     C                   EXSR      PRCSLC
037300000210     C                   EXSR      PRCRTN
037400000210     C                   END
037500000118    C                   ELSE
037600000118     C                   LEAVE
037700000210     C                   END
037800000210    ?C                   ENDDO
037900000210     C                   END
038000000118      *?
038100000210     C                   IF        *IN38 = *ON
038200000210     C                   IF        WWPSNP = 1
038300000210     C                   MOVE      WSPSN1        WWPSN1
038400000210     C                   END
038500000210     C                   EXSR      PRCPSN
038600000118    C                   ELSE
038700000328     C                   IF        WWDLT    = 'Y'
038800000210     C                   EXSR      PRCRFR
038900000210     C                   END
039000000210     C                   END
039100000210     C                   ENDSR
039200000000      *?__________________________________________________________________
039300000000      *?Build option information
039400000000      *?__________________________________________________________________
039500000210     C     BLDOPT        BEGSR
039600000210    ?C                   CALL      'TMPRCOPT'
039700000210     C                   PARM      'BUILD   '    WWRQS
039800000210     C                   PARM                    WWRTN
039900000210     C                   PARM                    WAP
040000000210     C                   PARM                    WAO
040100000210     C                   PARM                    WIOPV
040200000114     C                   EVAL      WW = WWOPS + WWOPS
040300000210     C                   MOVEL     WAP(WW)       WSOPD2
040400000114     C                   EVAL      WW = WW - 1
040500000210     C                   MOVEL     WAP(WW)       WSOPD1
040600000210     C                   ENDSR
040700000000      *?__________________________________________________________________
040800000000      *?Build function key information for this program
040900000000      *?__________________________________________________________________
041000000201     C     BLDFKY        BEGSR
041100000128     C                   EVAL      FUNCTION = 'BUILD   '
041200000128     C                   CALLP     FUNCT
041300000113     C                   EVAL      WW = WWFKS + WWFKS
041400000210     C                   MOVEL     WAD(WW)       WSFKD2
041500000113     C                   EVAL      WW = WW -1
041600000210     C                   MOVEL     WAD(WW)       WSFKD1
041700000201     C                   ENDSR
041800000000      *?__________________________________________________________________
041900000000      *?Clear list subfile
042000000000      *?__________________________________________________________________
042100000210     C     CLRSFL        BEGSR
042200000121     C                   EVAL      *IN31 = *ON
042300000210    ?C                   WRITE     LSTCTL
042400000121     C                   EVAL      *IN31 = *OFF
042500000121     C                   EVAL      WSPAG = *ZERO
042600000121     C                   EVAL      WFRRN = *ZERO
042700000121     C                   EVAL      WWRRN = *ZERO
042800000210     C                   ENDSR
042900000000      *?__________________________________________________________________
043000000000      *?Process SLCNXT Request
043100000000      *?__________________________________________________________________
043200000210     C     SLCNXT        BEGSR
043300000210     C                   MOVEL     'ERROR'       WORTN
043400000210     C                   IF        WFRRN > *ZERO
043500000127      *?
043600000210    ?C                   DOU       %EOF
043700000210    ?C                   READC     LSTSFL
043800000127      *?
043900000210     C                   IF        NOT %EOF
044000000210     C                   IF        WSOPC <> *BLANKS
044100000210     C                   EXSR      PRCOPT
044200000210     C                   IF        WWOPA = 'SELECT'
044300000210     C                   EXSR      PRCSEL
044400000210     C                   END
044500000210     C                   END
044600000210    C                   ELSE
044700000210     C                   LEAVE
044800000210     C                   END
044900000210    ?C                   ENDDO
045000000210     C                   END
045100000000      *?
045200000210     C                   MOVE      'END'         WWENDF
045300000210     C                   ENDSR
045400000000      *?__________________________________________________________________
045500000000      *?Process option selected
045600000000      *?__________________________________________________________________
045700000210     C     PRCOPT        BEGSR
045800000210     C                   MOVE      *BLANKS       WWRQS
045900000210     C                   MOVE      WSOPC         WDOPC
046000000000      *?
046100000210     C                   IF        WDOPC2 = *BLANKS AND
046200000210     C                             WDOPC1 >= '0'
046300000210     C                   MOVE      WDOPC1        WDOPC2
046400000210     C                   MOVE      '0'           WDOPC1
046500000210     C                   END
046600000000      *?
046700000210     C                   IF        WDOPC1 = *BLANKS AND
046800000210     C                             WDOPC2 >= '0'
046900000210     C                   MOVE      '0'           WDOPC1
047000000210     C                   END
047100000000      *?
047200000210     C                   IF        WDOPC1 = *BLANKS AND
047300000210     C                             WDOPC2 <  '0'
047400000210     C                   MOVE      WDOPC2        WDOPC1
047500000210     C                   MOVE      ' '           WDOPC2
047600000210     C                   END
047700000000      *?
047800000210    ?C                   CALL      'TMPRCOPT'
047900000210     C                   PARM      WDOPC         WWRQS
048000000210     C     WWOPA         PARM                    WWRTN
048100000210     C                   PARM                    WAP
048200000210     C                   PARM                    WAO
048300000210     C                   PARM                    WIOPV
048400000210     C                   ENDSR
048500000000      *?__________________________________________________________________
048600000000      *?Process selection
048700000000      *?__________________________________________________________________
048800000210     C     PRCSLC        BEGSR
048900000210     C                   EXSR      PRCOPT
049000000118     C                   SELECT
049100000118
049200000216     C                   WHEN      WWOPA = 'DISPLAY'
049300000216     C                   EXSR      PRCDSP
049400000118
049500000210     C                   WHEN      WWOPA = 'CHANGE' OR
049600000210     C                             WWOPA = 'COPY  ' OR
049700000210     C                             WWOPA = 'CPYKEY'
049800000210     C                   EXSR      PRCCHG
049900000118
050000000410     C*                  WHEN      WWOPA = 'DELETE'
050100000410     C*                  EXSR      PRCDLT
050200000118
050300000210     C                   WHEN      WWOPA = 'SELECT'
050400000210     C                   EXSR      PRCSEL
050500000118
050600000210     C                   ENDSL
050700000210     C                   ENDSR
050800000000      *?__________________________________________________________________
050900000000      *?Process CHANGE option
051000000000      *?__________________________________________________________________
051100000210     C     PRCCHG        BEGSR
051200000410    ?C                   CALL      'FM142   '                           99
051300000210     C                   PARM      WWOPA         WWRQS
051400000210     C                   PARM                    WWRTN
051500000210     C                   PARM                    WUPGM
051600000327     C                   PARM                    WDDATA
051700000201     C                   PARM      *BLANKS       WWFKY
051800000000      *?
051900000131     C                   IF        *IN99 = *ON
052000000327     C                   MOVEL     WTM(2)        WWMSG
052100000215     C                   CALLP     SNDMSG
052200000210     C                   MOVEL     'ERROR'       WORTN
052300000210     C                   MOVEL     'ERROR'       WWRTN
052400000210     C                   END
052500000000      *?
052600000210     C                   IF        WWRTN = 'EXIT'
052700000210     C                   MOVEL     WWRTN         WORTN
052800000210     C                   MOVEL     'END'         WWENDF
052900000210     C                   END
053000000306      *?
053100000328      *?If record changed, set for refresh SFL.
053200000306     C                   IF        WWRTN = *BLANKS
053300000328     C                   MOVE      'Y'           WWDLT
053400000306     C                   END
053500000210     C                   ENDSR
053600000000      *?__________________________________________________________________
053700000000      *?Process DELETE option
053800000000      *?__________________________________________________________________
053900000210     C     PRCDLT        BEGSR
054000000327    ?C                   CALL      'PRRDLT  '                           99
054100000210     C                   PARM      'DELETE  '    WWRQS
054200000210     C                   PARM                    WWRTN
054300000210     C                   PARM                    WUPGM
054400000327     C                   PARM                    WDDATA
054500000201     C                   PARM      'X 03'        WWFKY
054600000000      *?
054700000131     C                   IF        *IN99 = *ON
054800000327     C                   MOVEL     WTM(3)        WWMSG
054900000215     C                   CALLP     SNDMSG
055000000210     C                   MOVEL     'ERROR'       WORTN
055100000210     C                   MOVEL     'ERROR'       WWRTN
055200000210     C                   END
055300000000      *?
055400000328      *?If record deleted, set for refresh SFL.
055500000210     C                   IF        WWRTN = *BLANKS
055600000328     C                   MOVE      'Y'           WWDLT
055700000210     C                   END
055800000210     C                   ENDSR
055900000000      *?__________________________________________________________________
056000000000      *?Process SELECT Option
056100000000      *?__________________________________________________________________
056200000210     C     PRCSEL        BEGSR
056300000210     C                   MOVE      'END'         WWENDF
056400000210     C                   MOVE      *BLANKS       WORTN
056500000210     C                   ENDSR
056600000000      *?__________________________________________________________________
056700000000      *?Process DISPLAY option
056800000000      *?__________________________________________________________________
056900000210     C     PRCDSP        BEGSR
057000000410    ?C                   CALL      'FM144 '                             99
057100000210     C                   PARM                    WWRQS
057200000210     C                   PARM                    WWRTN
057300000210     C                   PARM                    WUPGM
057400000327     C                   PARM                    WDDATA
057500000201     C                   PARM      *BLANKS       WWFKY
057600000131     C                   IF        *IN99 = *ON
057700000327     C                   MOVEL     WTM(4)        WWMSG
057800000215     C                   CALLP     SNDMSG
057900000210     C                   MOVEL     'ERROR'       WORTN
058000000210     C                   MOVEL     'ERROR'       WWRTN
058100000210     C                   END
058200000000      *?
058300000210     C                   IF        WWRTN = 'EXIT'
058400000210     C                   MOVEL     WWRTN         WORTN
058500000210     C                   MOVEL     'END'         WWENDF
058600000210     C                   END
058700000210     C                   ENDSR
058800000000      *?__________________________________________________________________
058900000000      *?Process option Return
059000000000      *?__________________________________________________________________
059100000210     C     PRCRTN        BEGSR
059200000210     C                   IF        WWOPA <> 'CHANGE  ' OR
059300000210     C                             WWOPA = 'CHANGE  '  AND
059400000210     C                             WWRTN = 'CANCEL  '
059500000210    ?C     WFRRN         CHAIN     LSTSFL
059600000210     C                   END
059700000000      *?
059800000210     C                   IF        WWRTN  = 'ERROR '
059900000113     C                   EVAL      *IN60 = *ON
060000000210    C                   ELSE
060100000113     C                   EVAL      *IN60 = *OFF
060200000210     C                   MOVE      *BLANKS       WSOPC
060300000210     C                   END
060400000119
060500000119     C                   IF        %FOUND
060600000210    ?C                   UPDATE    LSTSFL
060700000119     C                   END
060800000113     C                   EVAL      WSPAG = WFRRN
060900000210     C                   ENDSR
061000000119      *?__________________________________________________________________
061100000000      *?Process POSITION TO option
061200000000      *?__________________________________________________________________
061300000210     C     PRCPSN        BEGSR
061400000210     C                   IF        WWPSNP = 1
061500000327    ?C     WKPSN1        SETLL     RFMT
061600000210    ?C                   CLEAR                   WSPSN1
061700000210     C                   END
061800000210     C                   EXSR      CLRSFL
061900000210     C                   EXSR      PRCRUP
062000000210     C                   MOVE      'Y'           WWPSNC
062100000210     C                   ENDSR
062200000000      *?__________________________________________________________________
062300000000      *?Parameter lists
062400000000      *?__________________________________________________________________
062500000210     C     PLIST         BEGSR
062600000210     C     *ENTRY        PLIST
062700000210     C                   PARM                    WIRQS
062800000210     C                   PARM                    WORTN
062900000210     C                   PARM                    WUPGM
063000000327     C                   PARM                    WDDATA
063100000210     C                   PARM                    WIOPV
063200000210     C                   PARM                    WWFKY
063300000000     C                   ENDSR
063400000000      *?__________________________________________________________________
063500000000      *?Key lists
063600000000      *?__________________________________________________________________
063700000210     C     KLIST         BEGSR
063800000117     C     WKPSN1        KLIST
063900000210     C                   KFLD                    WWPSN1
064000000000      *?
064100000210     C                   ENDSR
064200000000      *?__________________________________________________________________
064300000000      *?Program error handler
064400000000      *?__________________________________________________________________
064500000215     C     *PSSR         BEGSR
064600000215     C                   CALLP     SNDRPG
064700000327     C                   ENDSR     '*CANCL'
064800000328      *?__________________________________________________________________
064900000328      *?Program open
065000000121      *?__________________________________________________________________
065100000210     C     *INZSR        BEGSR
065200000210     C                   EVAL      WWFKS = 1
065300000210     C                   EVAL      WWOPS  = 1
065400000210     C                   EVAL      WWPSNP = 1
065500000210     C                   EVAL      WWPSNN = 1
065600000210     C                   EVAL      WWLSTS = 11
065700000210     C                   EVAL      WWPSNI = 41
065800000210     C                   EVAL      WWPSNC = 'Y'
065900000328     C                   EVAL      WWDLT  = 'N'
066000000210     C                   EVAL      WWSFLE = 'N'
066100000216     C                   MOVEL     '*'           MSPGMQ
066200000216     C                   EVAL      WWLMT = (WWPSNI + WWPSNN) - 1
066300000210     C                   ENDSR
066400000131      *?__________________________________________________________________
066500000128      *?PROCEDURES      ________________________________________________________
066600000308      /COPY QGPL/QRPGLESRC,FUNCT#
066700000308      /COPY QGPL/QRPGLESRC,SNDRPG#
066800000308      /COPY QGPL/QRPGLESRC,SNDMSG#
066900020425      /COPY GBSPGM/QRPGLESRC,FM149
067000000000      *?__________________________________________________________________
067100000000**  WAO OPTION TABLE - 30X38            |OPTION 2A, ACTION 8A, DESCRIPTION 28A |
06720000020401SELECT  1=Select
06730000020402CHANGE  2=Change
06740000020403COPY    3=Copy
06760000020405DISPLAY 5=Display
067700000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION 8A, DESCR 30A   |
06780000032703EXIT    F3=Exit
06790000032705REFRESH F5=Refresh
06800000020406ADD     F6=Add
06810000032710PMTPSN  F10=Position
06820000032712CANCEL  F12=Cancel
06830000000025ROLLUP
06840000000026ROLLDOWN
068500000000** WTM
06860000000000You have reached the top of the list.
06870000041000Call to FM142 failed.  Data was not updated.
06880000032800Call to PRRDLT failed.  Data was not deleted.
06890000041000Call to FM144 failed.  Data was not displayed.
06900000000000No records found.
06910000041000Call to FM147 failed.  Program my not have ended normally.
