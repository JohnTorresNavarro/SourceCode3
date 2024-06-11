000100150407     h option(*nodebugio)  bnddir('GBSBIND')  DftActGrp(*No)
000200150407      *-------------------------------------------------------------------------
000300000000    ? *
000400040825    ? *  Description:  Change Claims Payment Address
000500000000    ? *
000600040825    ? *  (c)Copyright 2004 by Group Benefit Services, Inc.
000700150130      *
000800150407      * Modifications
000900150407      * Date         Progammer     MOD
001000150407      *-------------------------------------------------------------------------
001100150407      * 01/30/2015   sbt
001200150407      *     Add hcname (hypername) and csphon10 to screen
001300150407      * 04/07/2015   B.Rees        br01
001400150407      *     Changed the output field (Phone Number) to be an edited field.
001500150407      *
001600150407      *-------------------------------------------------------------------------
001700040825    ?FCHGCPAD   CF   E             WORKSTN
001800000000    ?F                                     INFDS(DSPD)
001900150407br01 FCarMst    if   e           k Disk    extDesc('F.CARMST')
002000150407br01 F                                     ExtFile(*extDesc)
002100150130    ?Fhypercarr if   e           K DISK
002200150407     FSTATECD   IF   E           K Disk
002300000000    ? *
002400000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
002500000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
002600000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
002700150130    ?D hypername       S             30                                         hypercarr name
002800150130    ?D csphon14        S             14                                         formatted phone#
002900000000    ? *_________________________________________________________________________
003000000406    ? * Data structure
003100040825    ?D WUDTA         E DS                  EXTNAME(CPAYAD)
003200150407     D  CsPhoneNbr                   14
003300150407     D
003400040825    ?D WDCAR         E DS                  EXTNAME(CARMST)
003500040826    ?D WDSTA         E DS                  EXTNAME(STATECD)
003600040826     D  StateName              3     32
003700000000    ? *
003800000000    ? * Program status data structure
003900991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
004000000000    ? *
004100000000    ? * Display file data structure
004200991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
004300000000    ? *
004400000000    ? * CURSOR LOCATION
004500000000    ?D                 DS
004600000000    ?D  WWCRSL                 1      2
004700000000    ?D  WWCRSN                 1      2B 0
004800040825     D                 DS
004900040825     D ParmP
005000040825     D  FillerP                       3    Overlay(ParmP)
005100040825     D  P                             1    Overlay(ParmP:4)
005200150407     D
005300150407      *--------------------------------------------
005400150407      * Procedures
005500150407      *--------------------------------------------
005600150407     D/COPY *LIBL/QMODSRC,#EDTPHONPR            // Edit Phone Number
005700150407
005800000000    ? *_________________________________________________________________________
005900000000    ? *
006000000614    ? * Process Entry Panel
006100000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
006200000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
006300000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
006400000000E001?C                   Endif                                                  END COPY/CPYKEY
006500000000    ? *
006600000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
006700000000    ? *
006800000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
006900000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
007000000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
007100000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
007200000000 001? *
007300000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
007400000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
007500000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
007600000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
007700000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
007800000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
007900000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
008000000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
008100000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
008200040825 001?C     WWFKA         Caseq     'DFTADR  '    PRCDFT                         ENTER
008300000000 001?C                   Endcs                                                  END CASE
008400000000 001? *
008500000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
008600000000 002?C                   Exsr      PRCEND                                       PROCESS END
008700000000E002?C                   Endif                                                  END IF END REQ
008800000000E001?C                   Enddo                                                  END DOWHILE
008900000000    ? *
009000000707    ? * Send Info Updated message.
009100000707     C     WwChg         Ifeq      'Y'
009200000707     C                   Movel     'UPDATE  '    WORTN
009300000707     C                   Endif
009400000707    ? *
009500040826      *
009600040826      * In order to get the carrier code parm from the calling program,
009700040826      * INZSR has to be executed each time this program is called.
009800040826      *
009900040826     C                   Eval      *InLR    =    *On
010000000000    ? *___________________________________________________________________
010100000000    ? * Prepare panel
010200000000    ? *___________________________________________________________________
010300000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
010400000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
010500991108    ?C                   Move      'N'           WWERR                          NO ERRORS
010600000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
010700000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
010800000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
010900000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
011000000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
011100000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
011200000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
011300040826      *
011400150407     C     CPCACD        Chain     CARMST
011500150130      *
011600150130    ? * Get carrier name and customer service phone number for display
011700150408      * -- Has Area Code
011800150408     C                   if        %Len(%Trim(csphon)) = 10
011900150130     C                   eval      csphon14 = %trim(csphon14) +
012000150130     C                              '(' + %subst(csphon:1:3) + ') ' +
012100150130     C                              %subst(csphon:4:3) + '-' +
012200150130     C                              %subst(csphon:7:4)
012300150408     C                   endif
012400150408     C* -- No Area Code
012500150408     C                   if        %Len(%Trim(csphon)) = 7
012600150408     C                   eval      csphon14 = %trim(csphon14) +
012700150408     C                              %subst(csphon:1:3) + '-' +
012800150408     C                              %subst(csphon:4:4)
012900150408     C                   endif
013000150408     C
013100150408     C
013200150408     C
013300150408     C
013400150130     C     cgrpcd        chain     hypercarr
013500150130     C                   if        %found(hypercarr)
013600150130     C                   eval      hypername = hcname
013700150130E001?C                   endif
013800150130
013900040826     C     CPSTAT        Chain     STATECD
014000040826     C                   If        %Found(STATECD)
014100040826     C                   Eval      WSSTNM = STNAME
014200040826     C                   Else
014300040826     C                   Eval      WSSTNM = *Blanks
014400040826     C                   End
014500000000    ? *
014600000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
014700000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
014800000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
014900000000E002?C                   Endif                                                  ENDIF SAME REQUEST
015000000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
015100000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
015200000000    ? *
015300000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
015400000000    ? *
015500000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
015600000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
015700000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
015800000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
015900000000    ?C                   Cas                     PRCERR                         PROC ERROR
016000000000    ?C                   Endcs                                                  END CASE
016100000000    ? *
016200000000    ?C                   Endsr                                                  END PRPPNL
016300000000    ? *___________________________________________________________________
016400000000    ? * Prepare ADD request
016500000000    ? *___________________________________________________________________
016600000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
016700000614    ?C                   Clear                   WUDTA                          CLEAR RECORD
016800040826     C                   CLEAR                   WSSTNM
016900000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
017000000000    ?C                   Endsr                                                  END PRP ADD
017100000000    ? *___________________________________________________________________
017200000000    ? * Prepare CHANGE request
017300000000    ? *___________________________________________________________________
017400000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
017500040825    ?C                   Call      'UPDCPA  '                                   PROCESS REC IO
017600000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
017700000000    ?C                   Parm                    WWRTN                          RETURN CODE
017800000614    ?C                   Parm                    WUDTA                          REC DATA
017900040825B001?C                   If        WWRTN <> *Blanks                             IF ERROR
018000040825B002?C                   If        WWRTN =  'NOTAVL'                            IF RCD NOT AVAIL
018100000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
018200000000X002?C                   Else                                                   ELSE
018300000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
018400000000E002?C                   Endif                                                  END RCD NOT AVL
018500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
018600000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
018700000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
018800000810E001?C                   Endif                                                  END IF ERROR
018900000000    ?C                   Endsr                                                  END PRP CHANGE
019000000000    ? *___________________________________________________________________
019100000000    ? * Prepare COPY request
019200000000    ? *___________________________________________________________________
019300000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
019400000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
019500040825    ?C                   Call      'UPDCPA  '                                   PROCESS REC IO
019600000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
019700000000    ?C                   Parm                    WWRTN                          RETURN CODE
019800000614    ?C                   Parm                    WUDTA                          REC DATA
019900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
020000000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
020100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
020200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
020300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
020400000000X001?C                   Else                                                   ELSE
020500000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
020600000000E001?C                   Endif                                                  END IF ERROR
020700000000    ?C                   Endsr                                                  END PREP COPY
020800000000    ? *___________________________________________________________________
020900000000    ? * Default Data
021000000000    ? *___________________________________________________________________
021100000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
021200040825     C                   Movel     TCarrier      CPCACD
021300040825    ?C                   Call      'CHKCPA  '                                   PROCESS REC IO
021400000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
021500000000    ?C                   Parm                    WWRTN                          RETURN CODE
021600000614    ?C                   Parm                    WUDTA                          REC DATA
021700000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
021800000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
021900000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
022000000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
022100000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
022200000000E001?C                   Endif                                                  END IF ERROR
022300000000    ?C                   Endsr                                                  END DFTDTA
022400000000    ? *___________________________________________________________________
022500000000    ? * Process ERROR function
022600000000    ? *___________________________________________________________________
022700000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
022800000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
022900000000    ?C                   Exsr      SNDMSG                                       SEND MSG
023000000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
023100000000    ?C                   Move      'END'         WWSTT                          END STATE
023200000000    ?C                   Endsr                                                  END PRCERR
023300000000    ? *___________________________________________________________________
023400000000    ? * Receive messages
023500000000    ? *___________________________________________________________________
023600000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
023700000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
023800000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
023900000000X001?C                   Else                                                   ELSE
024000000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
024100000000E001?C                   Endif                                                  ENDIF NOT NORESET
024200000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
024300000000    ?C                   Movea     *IN           WWIN                           INDICATORS
024400000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
024500000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
024600000000    ?C                   Parm                    WWIN                           INDICATORS
024700000000    ?C                   Parm                    WWRTN                          RETURN CODE
024800000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
024900000000    ?C                   Endsr                                                  END RCV MSG
025000000000    ? *___________________________________________________________________
025100000000    ? * Display panels
025200000000    ? *___________________________________________________________________
025300000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
025400000000    ? *
025500000000    ? * Set PUTOVR based on last display file processed
025600000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
025700000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
025800000000 001?C                   Setoff                                       35        PUTOVR OFF
025900000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
026000000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
026100000000X001?C                   Else                                                   ELSE SAME PGM
026200000000 001?C                   Seton                                        35        PUTOVR ON
026300000000E001?C                   Endif                                                  END IF NEW PGM
026400000000    ? *
026500000614    ? * Set PROTECT key based on request
026600000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
026700000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
026800000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
026900000000 001?C                   Setoff                                       40        NO PROTECT KEY
027000000000X001?C                   Else                                                   ELSE
027100000000 001?C                   Seton                                        40        PROTECT KEY
027200000000E001?C                   Endif                                                  END IF ADD
027300000000    ? *
027400000000    ? * Select title
027500000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
027600000000 001?C                   Setoff                                       38        CHANGE TITLE
027700000000X001?C                   Else                                                   ELSE
027800000000 001?C                   Seton                                        38        ADD TITLE
027900000000E001?C                   Endif                                                  END IF CHANGE
028000000000    ? *
028100000000    ? * Position cursor based on error status
028200000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
028300000000 001?C                   Seton                                        99        POS CSR TO ERROR
028400000000X001?C                   Else                                                   ELSE
028500000000 001?C                   Setoff                                       99        POS CSR TO FIRST
028600000000E001?C                   Endif                                                  END IF ERROR
028700000000    ? *
028800000000    ? * Write message subfile
028900000000    ?C                   Seton                                        30        MSGSFL DISPLAY
029000000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
029100000000    ? *
029200000000    ? * Write entry panel
029300000000B001?C                   Select
029400000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
029500040826      *
029600040826      * If *In11 is on, the carrier code is not protected for the stand
029700040826      *  alone program where no carrier code is passed into this program.
029800040826     C                   If        P     =  'P'
029900040826     C                   Eval      *In11 =  *Off
030000040826     C                   Else
030100040826     C                   Eval      *In11 =  *On
030200040826     C                   End
030300000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
030400150407 br01C                   eval      csPhoneNbr = #EditPhone(csPhon14)
030500150407     C
030600000000 001?C                   Setoff                                       37        RESET CRSLOC
030700000000E001?C                   Endsl                                                  END SELECT
030800000000    ? *
030900000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
031000000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
031100000000E001?C                   Endif                                                  END IF DATA CHG
031200000000    ?C                   Endsr                                                  END DSPENT
031300000000    ? *___________________________________________________________________
031400000000    ? * Process function key
031500000000    ? *___________________________________________________________________
031600000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
031700991108    ?C                   Movea     *IN           WWIN                           INDICATORS
031800991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
031900000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
032000000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
032100000000    ?C                   Parm                    WAD                            FNC DESC
032200991108    ?C                   Parm                    WWIN                           AID BYTE
032300000000    ?C                   Parm                    WAF                            FNC KEY TABLE
032400000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
032500000000    ?C                   Endsr                                                  END PRCFKY
032600000000    ? *___________________________________________________________________
032700000000    ? * Process KEYS function
032800000000    ? *___________________________________________________________________
032900000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
033000000000    ?C                   Z-add     1             WW                             KEY DSC IDX
033100000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
033200000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
033300000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
033400000000 001? *
033500000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
033600000000 002?C                   Z-add     1             WWFKS                          SET TO 1
033700000000E002?C                   Endif                                                  END IF OVER 3
033800000000 001? *
033900000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
034000000000 001?C                   Sub       1             WW                             KEY DESCR IDX
034100000000E001?C                   Enddo                                                  END DO KEYS
034200000000    ? *
034300000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
034400000000    ?C                   Add       1             WW                             BUMP IDX
034500000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
034600000000    ?C                   Endsr                                                  END PRCDKY
034700000000    ? *___________________________________________________________________
034800000000    ? * Process EXIT Function
034900000000    ? *___________________________________________________________________
035000000000    ?C     PRCEXT        Begsr                                                  RETURN
035100040826    ? *
035200040826    ? * Force UPDATE
035300040826     C                   Eval      *in39 = *on
035400040826     C                   Eval      WWCHG = 'Y'
035500000000    ? *
035600000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
035700000000    ? *
035800000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
035900000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
036000000000X001?C                   Else                                                   ELSE NO ERRORS
036100000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
036200000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
036300000000E001?C                   Endif                                                  END IF ERRORS
036400000000    ?C                   Endsr                                                  END PRCEXT
036500000000    ? *___________________________________________________________________
036600000000    ? * Process PROMPT function
036700000000    ? *___________________________________________________________________
036800000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
036900040825    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
037000000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
037100000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
037200000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
037300000000    ? *
037400000000B001?C                   Select                                                 SELECT
037500040825 001 C                   When      WSFLD = 'CPCACD'
037600150409 001?C                   Call      'SLCCARCL'                                   CALL SELECT PROGRAM
037700040825 001?C                   Parm                    WWRQS                          REQUEST
037800040825 001?C                   Parm                    WWRTN                          RETURN CODE
037900040825 001?C                   Parm                    WUPGM                          PROGRAM
038000040825 001?C                   Parm                    WDCAR                          RECORD DS
038100040825B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
038200040825 003?C                   Eval      CPCACD = %trim(CARRCD)                       SET CODE
038300040825E001?C                   Endif
038400000112 001? *
038500040826 001 C                   When      WSFLD = 'CPSTAT'
038600040826 001?C                   Call      'SLCSTA  '                                   CALL SELECT PROGRAM
038700040826 001?C                   Parm                    WWRQS                          REQUEST
038800040826 001?C                   Parm                    WWRTN                          RETURN CODE
038900040826 001?C                   Parm                    WUPGM                          PROGRAM
039000040826 001?C                   Parm                    WDSTA                          RECORD DS
039100040826B002?C     WWRTN         Ifeq      *BLANKS                                      ENTER
039200040826 003?C                   Eval      CPSTAT = %trim(WDSTA)                        SET CODE
039300040826 003?C                   Eval      WSSTNM = %trim(StateName)                    SET CODE
039400040826E001?C                   Endif
039500040826 001? *
039600000000 001?C                   Other                                                  WHERE ERROR
039700000000 001?C                   Move      WTM(9)        WWMSG                          PASS MSG
039800000000 001?C                   Exsr      SNDMSG                                       SEND MSG
039900000000E001?C                   Endsl                                                  END SELECT
040000000000    ? *
040100000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
040200000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
040300000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
040400030717    ?C                   Mvr                     WSLIN                          CURSOR COL
040500000000    ?C                   Seton                                        37        SET ON CRSLOC
040600000000    ? *
040700000000    ?C                   Endsr                                                  END PRCPMT
040800040825    ? *___________________________________________________________________
040900040825    ? * Process Default Carrier Master Address function
041000040825    ? *___________________________________________________________________
041100040825    ?C     PRCDFT        Begsr                                                  PROCESS PROMPT
041200150407     C     CPCACD        Chain     CARMST
041300040825     C                   If        %Found(CARMST)
041400040825     C                   Eval      CPADD1 = CADDR1
041500040825     C                   Eval      CPADD2 = CADDR2
041600040825     C                   Eval      CPCITY = CCITY
041700040825     C                   Eval      CPSTAT = CSTATE
041800040825     C                   Eval      CPZIP  = CZIP
041900040908     C                   Eval      CPWEBD = CWEBD
042000040826      *
042100040826      * Refresh State Description
042200040826     C     CPSTAT        Chain     STATECD
042300040826     C                   If        %Found(STATECD)
042400040826     C                   Eval      WSSTNM = STNAME
042500040826     C                   Else
042600040826     C                   Eval      WSSTNM = *Blanks
042700040826     C                   End
042800040825     C                   End
042900040825    ? *
043000040825    ?C                   Endsr                                                  END PRCPMT
043100000000    ? *___________________________________________________________________
043200000000    ? * Process CANCEL Function
043300000000    ? *___________________________________________________________________
043400000000    ?C     PRCCNL        Begsr                                                  CANCEL
043500000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
043600000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
043700000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
043800000000    ?C                   Endsr                                                  END RETURN
043900000000    ? *___________________________________________________________________
044000000000    ? * Process ROLLUP function
044100000000    ? *___________________________________________________________________
044200000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
044300000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
044400000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
044500000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
044600000000E001?C                   Endif                                                  END IF GT LST PNL
044700000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
044800000000    ?C                   Endsr                                                  END PRCRUP
044900000000    ? *___________________________________________________________________
045000000000    ? * Process ROLLDOWN function
045100000000    ? *___________________________________________________________________
045200000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
045300000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
045400000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
045500000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
045600000000E001?C                   Endif                                                  END IF LT FST PNL
045700000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
045800000000    ?C                   Endsr                                                  END PRCRDN
045900000000    ? *___________________________________________________________________
046000000000    ? * Process ENTER function
046100000000    ? *___________________________________________________________________
046200000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
046300000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
046400000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
046500040825?    C                   If        *In39  = *On or WWWRNF = 'N'                 IF DATA CHANGED
046600040825    ?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
046700040825     C                   IF        WWTSK = 'CHANGE  '
046800040825 001 C                   Call      'CHKCPA  '
046900040825 001 C                   Parm      'EDTCHG  '    WWRQS
047000040825 001 C                   Parm                    WWRTN
047100040825 001 C                   Parm                    WUDTA
047200040825     C                   ELSE
047300040825 001?C                   Call      'CHKCPA  '                                   CHECK DATA
047400000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
047500000000 001?C                   Parm                    WWRTN                          RETURN CODE
047600000614 001?C                   Parm                    WUDTA                          REC DATA
047700000000E001?C                   Endif                                                  ENDIF
047800040825E001 C                   Endif
047900000000    ? *
048000000000B001?C                   Select                                                 PRC RETURN CDE
048100000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
048200000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
048300000000 001? *
048400000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
048500000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
048600000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
048700000000X002?C                   Else                                                   ELSE
048800000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
048900000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
049000000000E002?C                   Endif                                                  IF WARNING
049100000000 001? *
049200000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
049300000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
049400000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
049500000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
049600000000E001?C                   Endsl                                                  RETURN CODE SEL
049700000000    ? *
049800000000    ?C                   Endsr                                                  END PRCPNL
049900000000    ? *___________________________________________________________________
050000000000    ? * Process end - write data or release record
050100000000    ? *___________________________________________________________________
050200000000    ?C     PRCEND        Begsr                                                  PROCESS END
050300000000    ? *
050400000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
050500000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
050600000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
050700000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
050800000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
050900000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
051000000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
051100000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
051200000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
051300000000 001?C                   Endcs                                                  END CASE
051400000000 001? *
051500000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
051600000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
051700000000 002? *
051800000000X002?C                   Else                                                   ELSE NO WRT ERR
051900000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
052000000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
052100000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
052200000000 004?C                   Exsr      PRPPNL                                       DO NOT END
052300000810E004?C                   Endif                                                  END IF ADD
052400000000E003?C                   Endif                                                  END IF NOT END
052500000000E002?C                   Endif                                                  END IF WRITE ERROR
052600000000 001? *
052700000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
052800000000 001?C                   Exsr      RELREC                                       RELEASE REC
052900000000E001?C                   Endif                                                  END IF RCD CHANGED
053000000000    ? *
053100000000    ?C                   Endsr                                                  END PRCEND
053200000000    ? *___________________________________________________________________
053300000000    ? * Add new record
053400000000    ? *___________________________________________________________________
053500000000    ?C     WRTADD        Begsr                                                  WRITE ADD
053600000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
053700000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
053800000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
053900000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
054000000000E001?C                   Endif                                                  END IF ADD
054100000000    ? *
054200000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
054300000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
054400000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
054500000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
054600000000E001?C                   Endif                                                  END IF ADD KEY
054700000000    ? *
054800040825    ?C                   Call      'UPDCPA  '                                   PROCESS REC IO
054900000000    ?C                   Parm                    WWRQS                          ADD RECORD
055000000000    ?C                   Parm                    WWRTN                          RETURN CODE
055100000614    ?C                   Parm                    WUDTA                          REC DATA
055200000000    ? *
055300000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
055400000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
055500000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
055600000000X001?C                   Else                                                   ELSE
055700000000E001?C                   Endif                                                  END IF CALL ERROR
055800000000    ? *
055900000000    ?C                   Endsr                                                  END WRTADD
056000000000    ? *___________________________________________________________________
056100000000    ? * Write changed record
056200000000    ? *___________________________________________________________________
056300000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
056400040825    ?C                   Call      'UPDCPA  '                                   PROCESS REC IO
056500000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
056600000000    ?C                   Parm                    WWRTN                          RETURN CODE
056700000614    ?C                   Parm                    WUDTA                          REC DATA
056800000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
056900000000 001?C                   Movel     WTM(2)        WWMSG                          PASS MESSAGE
057000000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
057100000000E001?C                   Endif                                                  END IF CALL ERROR
057200000000    ? *
057300000000    ?C                   Endsr                                                  END WRTCHG
057400000000    ? *___________________________________________________________________
057500000000    ? * Release record
057600000000    ? *___________________________________________________________________
057700000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
057800040825    ?C                   Call      'UPDCPA  '                                   PROCESS REC IO
057900000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
058000000000    ?C                   Parm                    WWRTN                          RETURN CODE
058100000614    ?C                   Parm                    WUDTA                          REC DATA
058200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
058300000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
058400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
058500000000E001?C                   Endif                                                  END IF CALL ERROR
058600000000    ?C                   Endsr                                                  END RELREC
058700000000    ? *___________________________________________________________________
058800000000    ? * Build function keys
058900000000    ? *___________________________________________________________________
059000000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
059100991108    ?C                   Movea     *IN           WWIN                           INDICATORS
059200991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
059300000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
059400000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
059500000000    ?C                   Parm                    WAD                            FNC DESC
059600991108    ?C                   Parm                    WWIN                           AID BYTE
059700000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
059800000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
059900000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
060000000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
060100000000    ?C                   Sub       1             WW                             BUMP IDX
060200000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
060300000000    ?C                   Endsr                                                  END BLD FNCTNS
060400000000    ? *___________________________________________________________________
060500000000    ? * Send message
060600000000    ? *___________________________________________________________________
060700000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
060800000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
060900000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
061000000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
061100000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
061200000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
061300000000    ?C                   Endsr                                                  END SNDMSG
061400000000    ? *___________________________________________________________________
061500040826    ? * Parameter list
061600000000    ? *___________________________________________________________________
061700000000    ?C     PLIST         Begsr                                                  PARM LISTS
061800000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
061900000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
062000000000    ?C                   Parm                    WORTN             8            RETURN CODE
062100000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
062200000614    ?C                   Parm                    WUDTA                          RECORD KEY
062300000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
062400000000    ?C                   Endsr                                                  END PLIST
062500000000    ? *___________________________________________________________________
062600000000    ? * Initialize routine
062700000000    ? *___________________________________________________________________
062800000000    ?C     *INZSR        Begsr                                                  INITIALIZE
062900040825      *---
063000040825      * The P parm is passed only if this is called from Carrier Master Maint
063100040825      *---
063200040826     C                   Movel     WORTN         ParmP
063300040826     C                   If        P        =    'P'
063400040826     C                   Eval      *In11    =    *Off
063500040826     C                   Movel     CPCACD        TCarrier          3
063600040826     C                   Else
063700040826     C                   Eval      *In11    =    *On
063800040826     C                   End
063900040825      *
064000000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
064100000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
064200000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
064300000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
064400000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
064500000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
064600000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
064700000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
064800000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
064900000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
065000000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
065100000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
065200000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
065300000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
065400000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
065500000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
065600000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
065700000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
065800000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
065900000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
066000000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
066100000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
066200000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
066300000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
066400000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
066500040825    ?C                   Movel     'CPAYAD  '    WWFIL            10            FILE NAME-NOTES
066600000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
066700000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
066800000000    ?C                   Endsr                                                  END INITIALIZE
066900000000    ? *___________________________________________________________________
067000000000    ? * Program error handler
067100000000    ? *___________________________________________________________________
067200000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
067300000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
067400000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
067500000000    ?C                   Parm                    WQSTSC                         STATUS CODE
067600000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
067700000000    ?C                   Parm                    WQMSG                          MESSAGE ID
067800000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
067900000000    ? *___________________________________________________________________
068000000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
06810000000003EXIT    F3=Exit
06820000000004PROMPT  F4=Prompt
06830000000005REFRESH F5=Refresh
06840004082508DFTADR  F8=Dft Address
06850000070710UPDATE  F10=Update
06860000061412CANCEL  F12=Cancel
06870000000025ROLLUP
06880000000026ROLLDOWN
068900000000** WTM
06900004082500Request not supported in program CHGCPA.
06910000000000Update error.  Data was not updated.
06920000000000Duplicate key detected.  Data was NOT added to file.
06930004082500   THIS LINE --WTM(4) IS AVAILABLE
06940000000000Initialize error.  Record not initialized.
06950000000000Record not found.
06960000000000Generate error.  Key not generated.
06970000000000Record not available now.
06980000000000The cursor is not in a prompt area.
06990000000000Default error.  Data not defaulted.
