000100000407      *  COMPILE:
000200000000      *    CRTBNDRPG  PGM(&O/&N) SRCFILE(&L/&F) DBGVIEW(*SOURCE)
000300000000      *_________________________________________________________________________
000400000000      *
000500000000      *  Description:  Prompt for Individual ID Card Print
000600000000      *
000700000000      *  (c)Copyright 1999 by Inovative Outsourcing, Inc.
000800000000      *  This document contains restricted materials of IO, Inc.
000900000000      *
001000000000      *  History:
001100000000      *_________________________________________________________________________
001200991208     FMEMBER    IF   E           K DISK
001300991208     FRPF012WK  O  a E           K DISK
001400991208     FPMTINDD   CF   E             WORKSTN
001500000000     F                                     INFDS(DSPD)
001600000000      *_________________________________________________________________________
001700000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001800000000     D WAD             S             80    DIM(6)
001900991208     D WTM             S             80    DIM(2) CTDATA PERRCD(1)
002000000000      *_________________________________________________________________________
002100000000      * Program status data structure
002200991108     D PGMD          ESDS                  EXTNAME(IOPGMD)
002300000000      *
002400000000      * Display file data structure
002500991108     D DSPD          E DS                  EXTNAME(IODSPD)
002600991116      *
002700991208     D WDIND         E DS                  EXTNAME(MEMBER)
002800980311      *
002900980311      * CURSOR LOCATION
003000980311     D                 DS
003100980311     D  WWCRSL                 1      2
003200980311     D  WWCRSN                 1      2B 0
003300000000      *_________________________________________________________________________
003400000000      * Process display panel
003500000000     C                   Exsr      PRPPNL
003600000000      *
003700000000B001 C     WWSTT         Downe     'END'
003800000000 001 C                   Exsr      RCVMSG
003900000000 001 C                   Exsr      DSPPNL
004000000000 001 C                   Exsr      PRCFKY
004100000000 001  *
004200000000 001 C     WWFNC         Caseq     'KEYS'        PRCDKY
004300000000 001 C     WWFNC         Caseq     'EXIT'        PRCRTN
004400980311 001 C     WWFNC         Caseq     'PROMPT  '    PRCPMT
004500000000 001 C     WWFNC         Caseq     'CANCEL'      PRCCNL
004600980323 001 C     WWFNC         Caseq     'ENTER '      PRCENT
004700980312 001  *
004800000000 001 C                   Endcs
004900000000 001  *
005000000000E001 C                   Enddo
005100980402     C                   Move      *ON           *INLR
005200000000      *___________________________________________________________________
005300000000      * Prepare display panel
005400000000      *___________________________________________________________________
005500000000     C     PRPPNL        Begsr
005600000000      *
005700000000      * Initialize variables
005800000000     C                   Move      *BLANKS       WWIN
005900000000     C                   Move      *BLANKS       WWOCD
006000000000     C                   Move      *BLANKS       WWSTT
006100000000     C                   Move      *BLANKS       WORTN
006200000000     C                   Z-add     1             WWPNL
006300000000     C                   Z-add     1             WWPNLN
006400000000     C                   Z-add     1             WWFKS
006500000000     C                   Z-add     *ZEROS        WW
006600980323     C                   Z-add     1             WWDSP
006700991108      *
006800000000     C                   Exsr      BLDFKY
006900991108      *
007000000000     C                   Endsr
007100000000      *___________________________________________________________________
007200000000      * Receive messages
007300000000      *___________________________________________________________________
007400000000     C     RCVMSG        Begsr
007500000000     C                   Movea     *IN           WWIN
007600000000     C                   Call      'PRCMSG2'
007700980223     C                   Parm      'RECEIVE '    WWRQS             8
007800000000     C                   Parm                    WWIN
007900000000     C                   Parm                    WWRTN             8
008000000000     C                   Movea     WWIN          *IN
008100000000     C                   Endsr
008200000000      *___________________________________________________________________
008300000000      * Display the display panel
008400000000      *___________________________________________________________________
008500000000     C     DSPPNL        Begsr
008600000000      *
008700000000      * Set OVERLAY based on last display file processed
008800000000B001 C     WQPGMN        Ifne      WUPGM
008900000000 001 C                   Setoff                                       35
009000000000 001 C                   Move      WQPGMN        WUPGM
009100000000X001 C                   Else
009200000000 001 C                   Seton                                        35
009300000000E001 C                   Endif
009400000000      *
009500000000      * Write message subfile
009600000000     C                   Seton                                        30
009700980216     C                   Write     MSGCTL
009800000000      *
009900000000      * Write display panels
010000980218      *
010100980323B001 C     WWDSP         Ifeq      1
010200980216 001 C                   Exfmt     DSPPNL1
010300980323E001 C                   Endif
010400980323      *
010500000000     C                   Endsr
010600000000      *___________________________________________________________________
010700000000      * Build function key information
010800000000      *___________________________________________________________________
010900000000     C     BLDFKY        Begsr
011000991108     C                   Movea     *IN           WWIN
011100991108     C                   Call      'PRCFKY2'
011200000000     C                   Parm      'BUILD   '    WWRQS
011300000000     C     WWFNC         Parm                    WWRTN
011400000000     C                   Parm                    WAD
011500991108     C                   Parm                    WWIN
011600000000     C                   Parm                    WAF
011700000000     C                   Parm                    WIFKY
011800000000      *
011900000000     C     WWFKS         Add       WWFKS         WW
012000000000     C                   Sub       1             WW
012100980312      *
012200000000     C                   Endsr
012300000000      *___________________________________________________________________
012400000000      * Process function keys
012500000000      *___________________________________________________________________
012600000000     C     PRCFKY        Begsr
012700991108     C                   Movea     *IN           WWIN
012800991108     C                   Call      'PRCFKY2'
012900000000     C                   Parm      'PROCESS '    WWRQS
013000000000     C     WWFNC         Parm                    WWRTN
013100000000     C                   Parm                    WAD
013200991108     C                   Parm                    WWIN
013300000000     C                   Parm                    WAF
013400000000     C                   Parm                    WIFKY
013500000000     C                   Endsr
013600000000      *___________________________________________________________________
013700000000      * Process KEYS function
013800000000      *___________________________________________________________________
013900000000     C     PRCDKY        Begsr
014000000000     C                   Z-add     1             WW
014100000000B001 C     WWFKS         Doueq     1
014200000000 001 C     WAD(WW)       Orne      *BLANKS
014300000000 001  *
014400000000 001 C     WWFKS         Add       1             WWFKS
014500000000B002 C     WWFKS         Ifgt      3
014600000000 002 C                   Z-add     1             WWFKS
014700000000E002 C                   Endif
014800000000 001  *
014900000000 001 C     WWFKS         Mult      2             WW
015000000000 001 C                   Sub       1             WW
015100000000E001 C                   Enddo
015200000000      *
015300000000     C     WWFKS         Add       WWFKS         WW
015400000000     C                   Sub       1             WW
015500000000      *
015600000000     C                   Endsr
015700000000      *___________________________________________________________________
015800000000      * Process RETURN function
015900000000      *___________________________________________________________________
016000000000     C     PRCRTN        Begsr
016100000000     C                   Movel     WWFNC         WORTN
016200000000     C                   Move      'END'         WWSTT
016300000000     C                   Endsr
016400980311      *___________________________________________________________________
016500980311      * Process PROMPT function
016600980311      *___________________________________________________________________
016700980311     C     PRCPMT        Begsr
016800980311      *
016900980311     C                   Movel     WDCRSL        WWRQS
017000991208      *
017100991208     C                   Movel     WTM(1)        WWMSG
017200991208     C                   Exsr      SNDMSG
017300980403      *
017400980311      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
017500980311     C                   Movel     WDCRSL        WWCRSL
017600980311     C     WWCRSN        Div       256           WSROW
017700980311     C                   Mvr                     WSLIN
017800980311     C                   Seton                                        37
017900980311      *
018000980311     C                   Endsr
018100000000      *___________________________________________________________________
018200000000      * Process CANCEL function
018300000000      *___________________________________________________________________
018400000000     C     PRCCNL        Begsr
018500000000     C                   Movel     WWFNC         WORTN
018600000000     C                   Move      'END'         WWSTT
018700000000     C                   Endsr
018800000000      *___________________________________________________________________
018900000000      * Process ROLLUP function
019000000000      *___________________________________________________________________
019100000000     C     PRCRUP        Begsr
019200000000     C     WWPNL         Add       1             WWPNL
019300000000B001 C     WWPNL         Ifgt      WWPNLN
019400000000 001 C     WWPNL         Sub       1             WWPNL
019500000000E001 C                   Endif
019600000000     C                   Endsr
019700000000      *___________________________________________________________________
019800000000      * Process ROLLDOWN function
019900000000      *___________________________________________________________________
020000000000     C     PRCRDN        Begsr
020100000000     C     WWPNL         Sub       1             WWPNL
020200000000B001 C     WWPNL         Iflt      1
020300000000 001 C     WWPNL         Add       1             WWPNL
020400000000E001 C                   Endif
020500000000     C                   Endsr
020600000000      *___________________________________________________________________
020700000000      * Process ENTER function
020800000000      *___________________________________________________________________
020900000000     C     PRCENT        Begsr
021000980323      *
021100980402     C                   Move      *BLANKS       WWRTN
021200980402     C                   Exsr      CHKDTA
021300980415      *
021400980415      * SET RETURN PARMS
021500991208B001 C     WWRTN         Ifeq      'WARNING '
021600991208 001 C                   Movel     WSSSN         SSN
021700991208 001 C                   Movel     'I'           TYPE
021800991208 001 C                   Movel     *BLANKS       ACCNO
021900980402 001 C                   Move      *BLANKS       WORTN
022000991208 001 C                   Write     RPF012
022100991208X001 C                   Else
022200991208 001 C                   Clear                   WSSSN
022300991208 001 C                   Clear                   WSNAME
022400980430E001 C                   Endif
022500980430      *
022600000000     C                   Endsr
022700980402      *___________________________________________________________________
022800980402      * Check data
022900980402      *___________________________________________________________________
023000980402     C     CHKDTA        Begsr
023100980402      *
023200980402     C                   Move      *BLANKS       WWRTN
023300980402     C                   Movea     *ALL'0'       *IN(60)
023400991206      *
023500991206      * Location must be selected.
023600991208     C     WSSSN         Chain     Member                             50
023700991206B001 C     *IN50         Ifeq      *ON
023800991208 001 C                   Movel     *Blanks       WSNAME
023900991206 001 C                   Movel     WTM(2)        WWMSG
024000991206 001 C                   Exsr      SNDMSG
024100991206 001 C                   Move      'ERROR   '    WWRTN
024200991207X001 C                   Else
024300991208 001 C                   Clear                   wsdesc
024400991208 001 C                   Clear                   wsname
024500991208 001 C     MLNAME        Cat       ',':0         WSDESC           19
024600991208 001 C     WSDESC        Cat       MFNAME:2      WSNAME
024700991207E001 C                   Endif
024800991116      *
024900980415      * WWCNT is for Enter Key control (x2)
025000991108B001 C     WWCNT         Ifeq      *ZEROS
025100980403 001 C     WWRTN         Andeq     *BLANKS
025200980403 001 C                   Add       1             WWCNT
025300980403 001 C                   Move      'WARNING '    WWRTN
025400980403X001 C                   Else
025500980403 001 C                   Z-add     *ZEROS        WWCNT
025600980403E001 C                   Endif
025700980402      *
025800980402     C                   Endsr
025900000000      *___________________________________________________________________
026000000000      * Send message
026100000000      *___________________________________________________________________
026200000000     C     SNDMSG        Begsr
026300000000     C                   Call      'QSNDDTAQ'
026400000000     C                   Parm      'MSGDTAQ'     WWDTAQ           10
026500000000     C                   Parm      'QTEMP'       WWLIB            10
026600000000     C                   Parm      80            WWLNGQ            5 0
026700000000     C                   Parm                    WWMSG            80
026800000000     C                   Endsr
026900000000      *___________________________________________________________________
027000000000      * Parameter lists
027100000000      *___________________________________________________________________
027200000000     C     PLIST         Begsr
027300000000     C     *ENTRY        Plist
027400000000     C     WWTSK         Parm                    WIRQS             8
027500000000     C                   Parm                    WORTN             8
027600000000     C                   Parm                    WUPGM            10
027700000000     C                   Parm                    WIFKY            60
027800000000     C                   Endsr
027900000000      *___________________________________________________________________
028000000000      * Initialize routine
028100000000      *___________________________________________________________________
028200000000     C     *INZSR        Begsr
028300000000     C                   Movel     '*'           MSPGMQ
028400991208     C                   Movel     'MEMBER  '    WWFIL
028500000000     C                   Move      *BLANKS       WWFLK
028600000000     C                   Move      *BLANKS       WWTXT
028700000000     C                   Endsr
028800000000      *___________________________________________________________________
028900000000      * Define  routine
029000000000      *___________________________________________________________________
029100000000     C     DEFN          Begsr
029200980311      *
029300980311     C     *LIKE         Define    WIRQS         WWORQS
029400980311     C     *LIKE         Define    WWPNL         WWPNLO
029500980323     C     *LIKE         Define    WWPNL         WWDSP
029600980311      *
029700000000     C     *LIKE         Define    WIRQS         WWTSK
029800000000     C     *LIKE         Define    WORTN         WWFNC
029900000000     C     *LIKE         Define    WIFKY         WWFKY
030000000000     C     *LIKE         Define    WIFKY         WWFKV
030100000000     C     *LIKE         Define    WIFKY         WWOPV
030200000000     C                   Move      WWIN          WWIN             99
030300000000     C                   Move      WWOCD         WWOCD             8
030400000000     C                   Move      WWSTT         WWSTT             3
030500000000     C                   Z-add     WWPNL         WWPNL             1 0
030600000000     C                   Z-add     WWPNLN        WWPNLN            1 0
030700000000     C                   Z-add     WWFKS         WWFKS             1 0
030800000000     C                   Z-add     WW            WW                3 0
030900000000     C                   Move      WWFIL         WWFIL            10
031000000000     C                   Move      WWFLK         WWFLK           128
031100000000     C                   Move      WWTXT         WWTXT            60
031200980312      *
031300980403     C     *LIKE         Define    WW            WWCNT
031400980312      *
031500000000     C                   Endsr
031600000000      *___________________________________________________________________
031700000000      * Program error handler
031800000000      *___________________________________________________________________
031900000000     C     *PSSR         Begsr
032000000000     C                   Call      'SNDRPGM'                            50
032100000000     C                   Parm                    WQPGMN
032200000000     C                   Parm                    WQSTSC
032300000000     C                   Parm                    WQRPGS
032400000000     C                   Parm                    WQMSG
032500000000     C                   Endsr     '*CANCL'
032600980312      *
032700991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03280099120803EXIT    F3=Exit
03290000000012CANCEL  F12=Cancel
03300098032425ROLLUP
03310098032426ROLLDOWN
033200980312** WTM
03330098031200The cursor is not in a prompt area.
03340099120861Member SSN must be valid.
