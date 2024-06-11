000100000407      *  COMPILE:
000200000000      *    CRTBNDRPG  PGM(&O/&N) SRCFILE(&L/&F) DBGVIEW(*SOURCE)
000300000000      *_________________________________________________________________________
000400000000      *
000500991208      *  Description:  Prompt for ACCOUNT ID Card Print
000600000000      *
000700000000      *  (c)Copyright 1999 by Inovative Outsourcing, Inc.
000800000000      *  This document contains restricted materials of IO, Inc.
000900000000      *
001000000000      *  History:
001100000000      *_________________________________________________________________________
001200991208     FACCMST    IF   E           K DISK
001300991208     FRPF012WK  O  a E           K DISK
001400991208     FPMTACCD   CF   E             WORKSTN
001500000000     F                                     INFDS(DSPD)
001600000000      *_________________________________________________________________________
001700000000     D WAF             S             40    DIM(30) CTDATA PERRCD(1)
001800000000     D WAD             S             80    DIM(6)
001900991230     D WTM             S             80    DIM(4) CTDATA PERRCD(1)
002000000000      *_________________________________________________________________________
002100991230      *
002200991230      * Account key
002300991230     D                 DS                  INZ
002400991230     D  WDACC                  1     10
002500991230     D  WDtrst                 1      3s 0
002600991230     D  WDsub#                 4      6s 0
002700991230     D  WDacct                 7     10s 0
002800991206      *
002900000000      * Program status data structure
003000991108     D PGMD          ESDS                  EXTNAME(IOPGMD)
003100000000      *
003200000000      * Display file data structure
003300991108     D DSPD          E DS                  EXTNAME(IODSPD)
003400991116      *
003500991208     D WDACCDS       E DS                  EXTNAME(ACCMST)
003600980311      *
003700980311      * CURSOR LOCATION
003800980311     D                 DS
003900980311     D  WWCRSL                 1      2
004000980311     D  WWCRSN                 1      2B 0
004100000000      *_________________________________________________________________________
004200000000      * Process display panel
004300000000     C                   Exsr      PRPPNL
004400000000      *
004500000000B001 C     WWSTT         Downe     'END'
004600000000 001 C                   Exsr      RCVMSG
004700000000 001 C                   Exsr      DSPPNL
004800000000 001 C                   Exsr      PRCFKY
004900000000 001  *
005000000000 001 C     WWFNC         Caseq     'KEYS'        PRCDKY
005100000000 001 C     WWFNC         Caseq     'EXIT'        PRCRTN
005200980311 001 C     WWFNC         Caseq     'PROMPT  '    PRCPMT
005300000000 001 C     WWFNC         Caseq     'CANCEL'      PRCCNL
005400980323 001 C     WWFNC         Caseq     'ENTER '      PRCENT
005500980312 001  *
005600000000 001 C                   Endcs
005700000000 001  *
005800000000E001 C                   Enddo
005900980402     C                   Move      *ON           *INLR
006000000000      *___________________________________________________________________
006100000000      * Prepare display panel
006200000000      *___________________________________________________________________
006300000000     C     PRPPNL        Begsr
006400000000      *
006500000000      * Initialize variables
006600000000     C                   Move      *BLANKS       WWIN
006700000000     C                   Move      *BLANKS       WWOCD
006800000000     C                   Move      *BLANKS       WWSTT
006900000000     C                   Move      *BLANKS       WORTN
007000000000     C                   Z-add     1             WWPNL
007100000000     C                   Z-add     1             WWPNLN
007200000000     C                   Z-add     1             WWFKS
007300000000     C                   Z-add     *ZEROS        WW
007400980323     C                   Z-add     1             WWDSP
007500991108      *
007600000000     C                   Exsr      BLDFKY
007700991108      *
007800000000     C                   Endsr
007900000000      *___________________________________________________________________
008000000000      * Receive messages
008100000000      *___________________________________________________________________
008200000000     C     RCVMSG        Begsr
008300000000     C                   Movea     *IN           WWIN
008400000000     C                   Call      'PRCMSG2'
008500980223     C                   Parm      'RECEIVE '    WWRQS             8
008600000000     C                   Parm                    WWIN
008700000000     C                   Parm                    WWRTN             8
008800000000     C                   Movea     WWIN          *IN
008900000000     C                   Endsr
009000000000      *___________________________________________________________________
009100000000      * Display the display panel
009200000000      *___________________________________________________________________
009300000000     C     DSPPNL        Begsr
009400000000      *
009500000000      * Set OVERLAY based on last display file processed
009600000000B001 C     WQPGMN        Ifne      WUPGM
009700000000 001 C                   Setoff                                       35
009800000000 001 C                   Move      WQPGMN        WUPGM
009900000000X001 C                   Else
010000000000 001 C                   Seton                                        35
010100000000E001 C                   Endif
010200000000      *
010300000000      * Write message subfile
010400000000     C                   Seton                                        30
010500980216     C                   Write     MSGCTL
010600000000      *
010700000000      * Write display panels
010800980218      *
010900980323B001 C     WWDSP         Ifeq      1
011000980216 001 C                   Exfmt     DSPPNL1
011100980323E001 C                   Endif
011200980323      *
011300000000     C                   Endsr
011400000000      *___________________________________________________________________
011500000000      * Build function key information
011600000000      *___________________________________________________________________
011700000000     C     BLDFKY        Begsr
011800991108     C                   Movea     *IN           WWIN
011900991108     C                   Call      'PRCFKY2'
012000000000     C                   Parm      'BUILD   '    WWRQS
012100000000     C     WWFNC         Parm                    WWRTN
012200000000     C                   Parm                    WAD
012300991108     C                   Parm                    WWIN
012400000000     C                   Parm                    WAF
012500000000     C                   Parm                    WIFKY
012600000000      *
012700000000     C     WWFKS         Add       WWFKS         WW
012800000000     C                   Sub       1             WW
012900980312      *
013000000000     C                   Endsr
013100000000      *___________________________________________________________________
013200000000      * Process function keys
013300000000      *___________________________________________________________________
013400000000     C     PRCFKY        Begsr
013500991108     C                   Movea     *IN           WWIN
013600991108     C                   Call      'PRCFKY2'
013700000000     C                   Parm      'PROCESS '    WWRQS
013800000000     C     WWFNC         Parm                    WWRTN
013900000000     C                   Parm                    WAD
014000991108     C                   Parm                    WWIN
014100000000     C                   Parm                    WAF
014200000000     C                   Parm                    WIFKY
014300000000     C                   Endsr
014400000000      *___________________________________________________________________
014500000000      * Process KEYS function
014600000000      *___________________________________________________________________
014700000000     C     PRCDKY        Begsr
014800000000     C                   Z-add     1             WW
014900000000B001 C     WWFKS         Doueq     1
015000000000 001 C     WAD(WW)       Orne      *BLANKS
015100000000 001  *
015200000000 001 C     WWFKS         Add       1             WWFKS
015300000000B002 C     WWFKS         Ifgt      3
015400000000 002 C                   Z-add     1             WWFKS
015500000000E002 C                   Endif
015600000000 001  *
015700000000 001 C     WWFKS         Mult      2             WW
015800000000 001 C                   Sub       1             WW
015900000000E001 C                   Enddo
016000000000      *
016100000000     C     WWFKS         Add       WWFKS         WW
016200000000     C                   Sub       1             WW
016300000000      *
016400000000     C                   Endsr
016500000000      *___________________________________________________________________
016600000000      * Process RETURN function
016700000000      *___________________________________________________________________
016800000000     C     PRCRTN        Begsr
016900000000     C                   Movel     WWFNC         WORTN
017000000000     C                   Move      'END'         WWSTT
017100000000     C                   Endsr
017200980311      *___________________________________________________________________
017300980311      * Process PROMPT function
017400980311      *___________________________________________________________________
017500980311     C     PRCPMT        Begsr
017600980311      *
017700980311     C                   Movel     WDCRSL        WWRQS
017800991208      *
017900991208     C                   Movel     WTM(1)        WWMSG
018000991208     C                   Exsr      SNDMSG
018100980403      *
018200980311      * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
018300980311     C                   Movel     WDCRSL        WWCRSL
018400980311     C     WWCRSN        Div       256           WSROW
018500980311     C                   Mvr                     WSLIN
018600980311     C                   Seton                                        37
018700980311      *
018800980311     C                   Endsr
018900000000      *___________________________________________________________________
019000000000      * Process CANCEL function
019100000000      *___________________________________________________________________
019200000000     C     PRCCNL        Begsr
019300000000     C                   Movel     WWFNC         WORTN
019400000000     C                   Move      'END'         WWSTT
019500000000     C                   Endsr
019600000000      *___________________________________________________________________
019700000000      * Process ROLLUP function
019800000000      *___________________________________________________________________
019900000000     C     PRCRUP        Begsr
020000000000     C     WWPNL         Add       1             WWPNL
020100000000B001 C     WWPNL         Ifgt      WWPNLN
020200000000 001 C     WWPNL         Sub       1             WWPNL
020300000000E001 C                   Endif
020400000000     C                   Endsr
020500000000      *___________________________________________________________________
020600000000      * Process ROLLDOWN function
020700000000      *___________________________________________________________________
020800000000     C     PRCRDN        Begsr
020900000000     C     WWPNL         Sub       1             WWPNL
021000000000B001 C     WWPNL         Iflt      1
021100000000 001 C     WWPNL         Add       1             WWPNL
021200000000E001 C                   Endif
021300000000     C                   Endsr
021400000000      *___________________________________________________________________
021500000000      * Process ENTER function
021600000000      *___________________________________________________________________
021700000000     C     PRCENT        Begsr
021800980323      *
021900980402     C                   Move      *BLANKS       WWRTN
022000980402     C                   Exsr      CHKDTA
022100980415      *
022200980415      * SET RETURN PARMS
022300991208B001 C     WWRTN         Ifeq      'WARNING '
022400991230 001 C                   Movel     WDACC         ACCNO
022500991208 001 C                   Movel     'A'           TYPE
022600991208 001 C                   Movel     *BLANKS       SSN
022700980402 001 C                   Move      *BLANKS       WORTN
022800991208 001 C                   Write     RPF012
022900991208X001 C                   Else
023000991230 001 C                   Clear                   Wstrst
023100991230 001 C                   Clear                   Wssub#
023200991230 001 C                   Clear                   Wsacct
023300991230 001 C                   Clear                   Wdtrst
023400991230 001 C                   Clear                   Wdsub#
023500991230 001 C                   Clear                   Wdacct
023600991208 001 C                   Clear                   WSNAME
023700980430E001 C                   Endif
023800980430      *
023900000000     C                   Endsr
024000980402      *___________________________________________________________________
024100980402      * Check data
024200980402      *___________________________________________________________________
024300980402     C     CHKDTA        Begsr
024400980402      *
024500980402     C                   Move      *BLANKS       WWRTN
024600991230     C                   Movel     *Blanks       WSNAME
024700980402     C                   Movea     *ALL'0'       *IN(60)
024800991230     C                   Z-add     WsTrst        wdTrst
024900991230     C                   Z-add     WsSub#        wdSub#
025000991230     C                   Z-add     WsAcct        wdAcct
025100991206      *
025200991230      * Print by Trust.
025300991230B001 C                   Select
025400991230 001 C                   When      WsTrst  <>    *Zeros
025500991230 001 C                             and WsSub# =  *Zeros
025600991230 001 C                             and WsAcct =  *Zeros
025700991230 001 C                   Movel     WTM(2)        WSNAME
025800991230 001  *
025900991230 001  * Print by Trust,Divistion,
026000991230 001 C                   When      WsTrst  <>    *Zeros
026100991230 001 C                             and WsSub# <> *Zeros
026200991230 001 C                             and WsAcct =  *Zeros
026300991230 001 C                   Movel     WTM(3)        WSNAME
026400991230 001  *
026500991230 001  * Print by Account.
026600991230 001 C                   Other
026700991208 001 C     wkacc         Klist
026800991230 001 C                   Kfld                    WsTrst
026900991230 001 C                   Kfld                    WsSub#
027000991230 001 C                   Kfld                    WsAcct
027100991208 001 C     WKACC         Chain     ACCMST                             50
027200991206B002 C     *IN50         Ifeq      *ON
027300991230 002 C                   Movel     WTM(4)        WWMSG
027400991206 002 C                   Exsr      SNDMSG
027500991206 002 C                   Move      'ERROR   '    WWRTN
027600991207X002 C                   Else
027700991208 002 C                   Clear                   WSNAME
027800991208 002 C                   Movel     ACNAM1        WSNAME
027900991207E002 C                   Endif
028000991230 001  *
028100991230E001 C                   Endsl
028200991116      *
028300980415      * WWCNT is for Enter Key control (x2)
028400991108B001 C     WWCNT         Ifeq      *ZEROS
028500980403 001 C     WWRTN         Andeq     *BLANKS
028600980403 001 C                   Add       1             WWCNT
028700980403 001 C                   Move      'WARNING '    WWRTN
028800980403X001 C                   Else
028900980403 001 C                   Z-add     *ZEROS        WWCNT
029000980403E001 C                   Endif
029100980402      *
029200980402     C                   Endsr
029300000000      *___________________________________________________________________
029400000000      * Send message
029500000000      *___________________________________________________________________
029600000000     C     SNDMSG        Begsr
029700000000     C                   Call      'QSNDDTAQ'
029800000000     C                   Parm      'MSGDTAQ'     WWDTAQ           10
029900000000     C                   Parm      'QTEMP'       WWLIB            10
030000000000     C                   Parm      80            WWLNGQ            5 0
030100000000     C                   Parm                    WWMSG            80
030200000000     C                   Endsr
030300000000      *___________________________________________________________________
030400000000      * Parameter lists
030500000000      *___________________________________________________________________
030600000000     C     PLIST         Begsr
030700000000     C     *ENTRY        Plist
030800000000     C     WWTSK         Parm                    WIRQS             8
030900000000     C                   Parm                    WORTN             8
031000000000     C                   Parm                    WUPGM            10
031100000000     C                   Parm                    WIFKY            60
031200000000     C                   Endsr
031300000000      *___________________________________________________________________
031400000000      * Initialize routine
031500000000      *___________________________________________________________________
031600000000     C     *INZSR        Begsr
031700000000     C                   Movel     '*'           MSPGMQ
031800991208     C                   Movel     'ACCMST  '    WWFIL
031900000000     C                   Move      *BLANKS       WWFLK
032000000000     C                   Move      *BLANKS       WWTXT
032100000000     C                   Endsr
032200000000      *___________________________________________________________________
032300000000      * Define  routine
032400000000      *___________________________________________________________________
032500000000     C     DEFN          Begsr
032600980311      *
032700980311     C     *LIKE         Define    WIRQS         WWORQS
032800980311     C     *LIKE         Define    WWPNL         WWPNLO
032900980323     C     *LIKE         Define    WWPNL         WWDSP
033000980311      *
033100000000     C     *LIKE         Define    WIRQS         WWTSK
033200000000     C     *LIKE         Define    WORTN         WWFNC
033300000000     C     *LIKE         Define    WIFKY         WWFKY
033400000000     C     *LIKE         Define    WIFKY         WWFKV
033500000000     C     *LIKE         Define    WIFKY         WWOPV
033600000000     C                   Move      WWIN          WWIN             99
033700000000     C                   Move      WWOCD         WWOCD             8
033800000000     C                   Move      WWSTT         WWSTT             3
033900000000     C                   Z-add     WWPNL         WWPNL             1 0
034000000000     C                   Z-add     WWPNLN        WWPNLN            1 0
034100000000     C                   Z-add     WWFKS         WWFKS             1 0
034200000000     C                   Z-add     WW            WW                3 0
034300000000     C                   Move      WWFIL         WWFIL            10
034400000000     C                   Move      WWFLK         WWFLK           128
034500000000     C                   Move      WWTXT         WWTXT            60
034600980312      *
034700980403     C     *LIKE         Define    WW            WWCNT
034800980312      *
034900000000     C                   Endsr
035000000000      *___________________________________________________________________
035100000000      * Program error handler
035200000000      *___________________________________________________________________
035300000000     C     *PSSR         Begsr
035400000000     C                   Call      'SNDRPGM'                            50
035500000000     C                   Parm                    WQPGMN
035600000000     C                   Parm                    WQSTSC
035700000000     C                   Parm                    WQRPGS
035800000000     C                   Parm                    WQMSG
035900000000     C                   Endsr     '*CANCL'
036000980312      *
036100991116**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
03620099120803EXIT    F3=Exit
03630000000012CANCEL  F12=Cancel
03640098032425ROLLUP
03650098032426ROLLDOWN
036600980312** WTM
03670098031200The cursor is not in a prompt area.
036800991230Print by Trust
036900991230Print by Trust, Division
03700099123061Account Number must be valid.
