000100180607      *=========================================================================
000200180607     H option(*noDebugIo)
000300180607      *=================================================================================
000400180607    ? *  CHGOCN - Change Onsite Dental Contact Data
000500180607      *========================================================================
000600090710    ? *  Revision History
000700180607      *========================================================================
000800180607      * Date        Int   Description
000900180607      * ----------  ---   -----------------------------------------------------
001000180607      * 07/10/2009  ssz   Clear 2nd/3rd phone and fax fields on blank screen.
001100180607
001200180607      * 06/07/2018  jt    Moved facility info to screen on "ADD".
001300180607
001400180607      *========================================================================
001500090305    ?FCHGOCND   CF   E             WORKSTN
001600000000    ?F                                     INFDS(DSPD)
001700090305    ?FODCNTCP   If   E           k Disk
001800090312     FTRSMST    IF   E           K Disk
001900050318     FACCMST    IF   E           K Disk
002000090312     FSUBMST    IF   E           K Disk
002100090319    ?FODCCTL2   IF   E           K DISK
002200090323     FODCMGRP   IF   E           K Disk
002300000000    ? *
002400090407     D                 DS
002500090407     D sdphn1                  1     12
002600090407     D  cph13                  1      3
002700090407     D  cph1                   4      4    INZ('-')
002800090407     D  cph46                  5      7
002900090407     D  cph2                   8      8    INZ('-')
003000090407     D  cph710                 9     12
003100090710     D                 DS
003200090710     D sdphn2                  1     12
003300090710     D  cph132                 1      3
003400090710     D  cph21                  4      4    INZ('-')
003500090710     D  cph462                 5      7
003600090710     D  cph22                  8      8    INZ('-')
003700090710     D  cph7102                9     12
003800090710     D                 DS
003900090710     D sdphn3                  1     12
004000090710     D  cph133                 1      3
004100090710     D  cph31                  4      4    INZ('-')
004200090710     D  cph463                 5      7
004300090710     D  cph32                  8      8    INZ('-')
004400090710     D  cph7103                9     12
004500090710     D                 DS
004600090710     D sdphnF                  1     12
004700090710     D  cFA13                  1      3
004800090710     D  cphF1                  4      4    INZ('-')
004900090710     D  cFA46                  5      7
005000090710     D  cphF2                  8      8    INZ('-')
005100090710     D  cFA710                 9     12
005200090407     D                 DS
005300090407     D OCPHON                  1     10
005400090407     D  odph13                 1      3
005500090407     D  odph46                 4      6
005600090407     D  odph710                7     10
005700090407     D                 DS
005800090407     D s2phon                  1     10
005900090407     D  sph13                  1      3
006000090407     D  sph46                  4      6
006100090407     D  sph710                 7     10
006200090407    * *
006300090309     D HstTracker      DS
006400090309     D  CTCode                 1      1
006500090309     D  CTitle                 2      2
006600090309     D  LastN                  3      3
006700090309     D  FirstN                 4      4
006800090309     D  Addr1                  5      5
006900090309     D  Addr2                  6      6
007000090309     D  City                   7      7
007100090309     D  State                  8      8
007200090309     D  Zip                    9      9
007300090309     D  Phon1                 10     10
007400090309     D  Phon2                 11     11
007500090309     D  Phon3                 12     12
007600090309     D  Fax                   13     13
007700090309     D  Email                 14     14
007800090309     D  CaseM                 15     15
007900090309     D  EffDt                 16     16
008000090309     D  TrmDt                 17     17
008100090309     D  SaveField             18    273
008200090309     D   SaveCTCode           18     32
008300090309     D   SaveCTitle           33     47
008400090309     D   SaveLastN            48     62
008500090309     D   SaveFirstN           63     77
008600090309     D   SaveAddr1            78     92
008700090309     D   SaveAddr2            93    107
008800090309     D   SaveCity            108    122
008900090309     D   SaveState           123    137
009000090309     D   SaveZip             138    152
009100090309     D   SavePhon1           153    167
009200090309     D   SavePhon2           168    182
009300090309     D   SavePhon3           183    197
009400090309     D   SaveFax             198    212
009500090309     D   SaveEmail           213    227
009600090309     D   SaveCaseM           228    243
009700090309     D   SaveEffDt           244    258
009800090309     D   SaveTrmDt           259    273
009900000000    ?D WAF             S             40    DIM(30) CTDATA PERRCD(1)             FUNCTION TABLE
010000000000    ?D WAD             S             80    DIM(6)                               FUNCTION DESC
010100000000    ?D WTM             S             80    DIM(10) CTDATA PERRCD(1)             PANEL MESSAGES
010200000000    ? *_________________________________________________________________________
010300000406    ? * Data structure
010400090305    ?D WUDTA         E DS                  EXTNAME(ODCNTCP)
010500000000    ? *
010600090319    ?D WCDTA         E DS                  EXTNAME(ODCCTLP)
010700090319    ? *
010800000000    ? * Program status data structure
010900991108    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
011000000000    ? *
011100000000    ? * Display file data structure
011200991108    ?D DSPD          E DS                  EXTNAME(IODSPD)
011300000000    ? *
011400000000    ? * CURSOR LOCATION
011500000000    ?D                 DS
011600000000    ?D  WWCRSL                 1      2
011700000000    ?D  WWCRSN                 1      2B 0
011800100726     D WKTRST          S                   LIKE(OCTRST)
011900090305     D WWTRST          S                   LIKE(OCTRST)
012000090305     D WWSUB#          S                   LIKE(OCSUB#)
012100090305     D WWACCT          S                   LIKE(OCACCT)
012200000000    ? *_________________________________________________________________________
012300000000    ? *
012400090305     C                   Eval      SVBEDT   =    OCEFF
012500090305     C                   Eval      SVENDT   =    OCTRM
012600090305     C                   Eval      SVCCOD   =    OCCCOD
012700090305     C                   Eval      SVTITL   =    OCTITL
012800090305     C                   Eval      SVLNAM   =    OCLNAM
012900090305     C                   Eval      SVFNAM   =    OCFNAM
013000090305     C                   Eval      SVADD1   =    OCADD1
013100090305     C                   Eval      SVADD2   =    OCADD2
013200090305     C                   Eval      SVCITY   =    OCCITY
013300090305     C                   Eval      SVST     =    OCST
013400090305     C                   Eval      SVZIP    =    OCZIP
013500090305     C                   Eval      SVPHN1   =    OCPHN1
013600090305     C                   Eval      SVPHN2   =    OCPHN2
013700090305     C                   Eval      SVPHN3   =    OCPHN3
013800090305     C                   Eval      SVFAX    =    OCFAX
013900090305     C                   Eval      SVEMAL   =    OCEMAL
014000090305     C                   Eval      SVCMGR   =    OCCMGR
014100070614     C     SVBEDT        MULT      10000.0001    SVBEDT
014200070614     C     SVENDT        MULT      10000.0001    SVENDT
014300000614    ? * Process Entry Panel
014400000000B001?C     WWTSK         Ifeq      'COPY'                                       IF COPY
014500000000 001?C     WWTSK         Oreq      'CPYKEY'                                     OR COPY W/KEY
014600000614 001?C                   Move      WUDTA         WWDTA                          SAVE RECORD DS
014700000000E001?C                   Endif                                                  END COPY/CPYKEY
014800000000    ? *
014900000000    ?C                   Exsr      PRPPNL                                       PREPARE PANEL
015000000000    ? *
015100000000B001?C     WWSTT         Downe     'END'                                        DOWHILE NOT END
015200000000 001?C                   Exsr      RCVMSG                                       RECEIVE MSGS
015300000000 001?C                   Exsr      DSPPNL                                       DSPL ENTRY PANL
015400000000 001?C                   Exsr      PRCFKY                                       PROC FNCTN KEYS
015500000000 001? *
015600000000 001?C     WWFKA         Caseq     'KEYS    '    PRCDKY                         DISPLAY KEYS
015700000000 001?C     WWFKA         Caseq     'EXIT    '    PRCEXT                         EXIT
015800000000 001?C     WWFKA         Caseq     'PROMPT  '    PRCPMT                         PROMPT
015900000000 001?C     WWFKA         Caseq     'REFRESH '    PRPPNL                         REFRESH
016000000000 001?C     WWFKA         Caseq     'CANCEL  '    PRCCNL                         CANCEL
016100000000 001?C     WWFKA         Caseq     'ROLLUP  '    PRCRUP                         ROLL UP
016200000000 001?C     WWFKA         Caseq     'ROLLDOWN'    PRCRDN                         ROLL DOWN
016300000000 001?C     WWFKA         Caseq     'ENTER   '    PRCPNL                         ENTER
016400000707 001?C     WWFKA         Caseq     'UPDATE  '    PRCEXT                         ENTER
016500000000 001?C                   Endcs                                                  END CASE
016600000000 001? *
016700000000B002?C     WWSTT         Ifeq      'END'                                        IF END REQUESTED
016800000000 002?C                   Exsr      PRCEND                                       PROCESS END
016900000000E002?C                   Endif                                                  END IF END REQ
017000000000E001?C                   Enddo                                                  END DOWHILE
017100000000    ? *
017200000707    ? * Send Info Updated message.
017300000707     C     WwChg         Ifeq      'Y'
017400000707     C                   Movel     'UPDATE  '    WORTN
017500000707     C                   Endif
017600000707    ? *
017700000000    ?C                   Return                                                 RETURN
017800000000    ? *___________________________________________________________________
017900000000    ? * Prepare panel
018000000000    ? *___________________________________________________________________
018100000000    ?C     PRPPNL        Begsr                                                  PREPARE PANEL
018200000000    ?C                   Move      *BLANKS       WORTN                          RETURN CODE
018300090407     C                   Move      *Blanks       SDPHN1
018400090710     C                   Move      *Blanks       SDPHN2
018500090710     C                   Move      *Blanks       SDPHN3
018600090710     C                   Move      *Blanks       SDPHNF
018700050317    ?C                   Move      *ZEROS        WSBEDT                         RETURN CODE
018800050317    ?C                   Move      *ZEROS        WSENDT                         RETURN CODE
018900090323     C                   Move      *Blanks       WSLNAM
019000090323     C                   Move      *Blanks       WSFNAM
019100991108    ?C                   Move      'N'           WWERR                          NO ERRORS
019200000000    ?C                   Move      'N'           WWCHG                          NO CHANGES
019300000000    ?C                   Move      'N'           WWWRNF                         NO WARNINGS
019400000000    ?C                   Move      *BLANKS       WWSTT                          STATUS
019500000000    ?C                   Z-add     1             WWPNL                          CURRENT PNL
019600000000    ?C                   Z-add     1             WWFKS                          FNC KEY SET
019700000000    ?C                   Movea     WWZERO        *IN(60)                        RESET ERR INDS
019800000000    ?C                   Move      *BLANKS       WWSTT                          RESET END
019900000000    ? *
020000000000B001?C     WQPGMN        Ifeq      WUPGM                                        IF NEW PROGRAM
020100000000B002?C     WIRQS         Ifne      WWORQS                                       SAME AS OLD REQUEST?
020200000000 002?C                   Move      *BLANKS       WUPGM                          DO NOT PUTOVR
020300000000E002?C                   Endif                                                  ENDIF SAME REQUEST
020400000000 001?C                   Move      WIRQS         WWORQS                         SAVE REQUEST
020500000000E001?C                   Endif                                                  ENDIF SAME PROGRAM
020600050318      *
020700090305     C                   Eval      WWTRST = OCTRST
020800090305     C                   Eval      WWSUB# = OCSUB#
020900090305     C                   Eval      WWACCT = OCACCT
021000090305     C                   Movel     OCTRST        Trst              3
021100090305     C                   Movel     OCSUB#        Sub#              3
021200090305     C                   Movel     OCACCT        Acct              4
021300090312     C     OCTRST        Chain     TRSMST
021400090312     C                   If        %Found(TRSMST)
021500090312     C     SKey          Chain     SUBMST
021600090312     C                   If        %Found(SUBMST)
021700090312     C                   If        Acct   <> '0000'
021800090224     C     AKey          Chain     ACCMST
021900050318     C                   If        %Found(ACCMST)
022000090312     C                   Eval      WWNAME  = 'Trust#     ' + ' '  +
022100090312     C                                       %trim(Trst) + '  ' + TDESCR
022200090312     C                   Eval      WWNAM1  = %trim('Subdivision') + ' ' +
022300090312     C                                       %trim(Sub#) + '  ' + SUBDSC
022400090312     C                   Eval      WWNAM2  = 'Account    ' + ' ' +
022500090312     C                                       %trim(Acct) + ' ' + ACNAM1
022600050318     C                   End
022700090312     C                   End
022800090312     C                   If        Acct    = '0000'
022900090312     C                   Eval      WWNAME  = 'Trust#     ' + ' '  +
023000090312     C                                       %trim(Trst) + ' ' + TDESCR
023100090312     C                   Eval      WWNAM1  = %trim('Subdivision') + ' ' +
023200090312     C                                       %trim(Sub#) + ' ' + SUBDSC
023300090312     C                   End
023400090312     C                   End
023500090312     C                   End
023600000000    ? *
023700000000    ?C                   Exsr      BLDFKY                                       BUILD F KEYS
023800000000    ? *
023900000000    ?C     WWTSK         Caseq     'CHANGE  '    PRPCHG                         PREP FOR CHANGE
024000000000    ?C     WWTSK         Caseq     'ADD     '    PRPADD                         PREP FOR ADD
024100000000    ?C     WWTSK         Caseq     'INSERT  '    PRPADD                         PREP FOR INSERT
024200000000    ?C     WWTSK         Caseq     'COPY    '    PRPCPY                         PREP FOR COPY
024300000000    ?C                   Cas                     PRCERR                         PROC ERROR
024400000000    ?C                   Endcs                                                  END CASE
024500000000    ? *
024600000000    ?C                   Endsr                                                  END PRPPNL
024700000000    ? *___________________________________________________________________
024800000000    ? * Prepare ADD request
024900000000    ? *___________________________________________________________________
025000000000    ?C     PRPADD        Begsr                                                  PREP FOR ADD
025100090305    ?C                   Clear                   OCEFF                          CLEAR RECORD
025200090305    ?C                   Clear                   OCTRM                          CLEAR RECORD
025300090305    ?C                   Clear                   OCCCOD                         CLEAR RECORD
025400090305    ?C                   Clear                   OCTITL                         CLEAR RECORD
025500180618    ?C****               Clear                   OCLNAM                         CLEAR RECORD
025600180618    ?C****               Clear                   OCFNAM                         CLEAR RECORD
025700180607
025800180618       if acacct > 0;
025900180618        chain (octrst : ocsub# : ocacct ) accmsr;
026000180618        if ASPHFL = 'F';
026100180618         if wirqs = 'ADD';
026200090305    ?C                   Clear                   OCADD1                         CLEAR RECORD
026300090305    ?C                   Clear                   OCADD2                         CLEAR RECORD
026400090305    ?C                   Clear                   OCCITY                         CLEAR RECORD
026500090305    ?C                   Clear                   OCST                           CLEAR RECORD
026600090305    ?C                   Clear                   OCZIP                          CLEAR RECORD
026700090305    ?C                   Clear                   OCPHN1                         CLEAR RECORD
026800090305    ?C                   Clear                   OCPHN2                         CLEAR RECORD
026900090305    ?C                   Clear                   OCPHN3                         CLEAR RECORD
027000090305    ?C                   Clear                   OCFAX                          CLEAR RECORD
027100180618    ?C                   Clear                   OCLNAM                         CLEAR RECORD
027200180618    ?C                   Clear                   OCFNAM                         CLEAR RECORD
027300180618         endif;
027400180618        endif;
027500180607
027600180618        if ASPHFL = 'D';
027700180618         if wirqs = 'ADD';
027800180618          cph13 = %subst(ocphn1:1:3);
027900180618           cph46 = %subst(ocphn1:4:3);
028000180618            cph710 = %subst(ocphn1:7:4);
028100180618             cph132= %subst(ocphn2:1:3);
028200180618              cph462 = %subst(ocphn2:4:3);
028300180618               cph7102 = %subst(ocphn2:7:4);
028400180618                cph133= %subst(ocphn3:1:3);
028500180618                 cph463 = %subst(ocphn3:4:3);
028600180618                cph7103 = %subst(ocphn3:7:4);
028700180618               cfa13 = %subst(ocfax:1:3);
028800180618              cfa46 = %subst(ocfax:4:3);
028900180618             cfa710 = %subst(ocfax:7:4);
029000180618            cfa710 = %subst(ocfax:7:4);
029100180618           wslnam = oclnam;
029200180618          wsfnam = ocfnam;
029300180618         endif;
029400180618        endif;
029500180618       else;
029600180618        cph13 = %subst(ocphn1:1:3);
029700180618         cph46 = %subst(ocphn1:4:3);
029800180618          cph710 = %subst(ocphn1:7:4);
029900180618           cph132= %subst(ocphn2:1:3);
030000180618            cph462 = %subst(ocphn2:4:3);
030100180618             cph7102 = %subst(ocphn2:7:4);
030200180618             cph133= %subst(ocphn3:1:3);
030300180618             cph463 = %subst(ocphn3:4:3);
030400180618            cph7103 = %subst(ocphn3:7:4);
030500180618           cfa13 = %subst(ocfax:1:3);
030600180618          cfa46 = %subst(ocfax:4:3);
030700180618         cfa710 = %subst(ocfax:7:4);
030800180618        cfa710 = %subst(ocfax:7:4);
030900180618       endif;
031000180607
031100090305    ?C                   Clear                   OCEMAL                         CLEAR RECORD
031200090305    ?C                   Clear                   OCCMGR                         CLEAR RECORD
031300000000    ?C                   Exsr      DFTDTA                                       DEFAULT DATA
031400000000    ?C                   Endsr                                                  END PRP ADD
031500000000    ? *___________________________________________________________________
031600000000    ? * Prepare CHANGE request
031700000000    ? *___________________________________________________________________
031800000000    ?C     PRPCHG        Begsr                                                  PREP FOR CHANGE
031900090309     C                   Movel     HstTracker    Whist
032000090305    ?C                   Call      'UPDOCN  '                                   PROCESS REC IO
032100000000    ?C                   Parm      'GET     '    WWRQS                          GET RECORD
032200000000    ?C                   Parm                    WWRTN                          RETURN CODE
032300000614    ?C                   Parm                    WUDTA                          REC DATA
032400090309    ?C                   Parm                    Whist           273            DATA
032500000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
032600000000B002?C     WWRTN         Ifeq      'NOTAVL'                                     IF RCD NOT AVAIL
032700000000 002?C                   Movel     WTM(8)        WWMSG                          PASS MESSAGE
032800000000X002?C                   Else                                                   ELSE
032900000000 002?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
033000000000E002?C                   Endif                                                  END RCD NOT AVL
033100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
033200000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
033300000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
033400000810E001?C                   Else                                                   END IF ERROR
033500090305     C     OCEFF         MULT      10000.0001    WSBEDT
033600090305     C     OCTRM         MULT      10000.0001    WSENDT
033700090407     C*****              Movel     OCPHN1        WSPHN1
033800090408     C                   Clear                   OCPHON
033900090407     C                   Move      OCPHN1        OCPHON
034000090407     C                   movel     odph13        cph13
034100090407     C                   movel     odph46        cph46
034200090407     C                   movel     odph710       cph710
034300090408     C                   Clear                   OCPHON
034400090408     C                   Move      OCPHN2        OCPHON
034500090408     C                   movel     odph13        cph132
034600090408     C                   movel     odph46        cph462
034700090408     C                   movel     odph710       cph7102
034800090408     C                   Clear                   OCPHON
034900090408     C                   Move      OCPHN3        OCPHON
035000090408     C                   movel     odph13        cph133
035100090408     C                   movel     odph46        cph463
035200090408     C                   movel     odph710       cph7103
035300090408     C                   Clear                   OCPHON
035400090408     C                   Move      OCFAX         OCPHON
035500090408     C                   movel     odph13        cfa13
035600090408     C                   movel     odph46        cfa46
035700090408     C                   movel     odph710       cfa710
035800090323     C                   If        OCCCOD  <>    ACM
035900090323     C                   Eval      WSLNAM   =    %Trim(OCLNAM)
036000090323     C                   Eval      WSFNAM   =    %Trim(OCFNAM)
036100090323     C                   Else
036200090323     C     ACMKey        Chain     ODCMGRP
036300090323     C                   If        %Found(ODCMGRP)
036400090323     C                   Eval      WSLNAM   =    %Trim(CMLNAM)
036500090323     C                   Eval      WSFNAM   =    %Trim(CMFNAM)
036600090323     C                   Else
036700090323     C                   Eval      WSLNAM = %Trim('Not on File')
036800090323     C                   End
036900090323     C                   End
037000000810E001?C                   Endif                                                  END IF ERROR
037100000000    ?C                   Endsr                                                  END PRP CHANGE
037200000000    ? *___________________________________________________________________
037300000000    ? * Prepare COPY request
037400000000    ? *___________________________________________________________________
037500000000    ?C     PRPCPY        Begsr                                                  PREP FOR COPY
037600000614    ?C                   Move      WWDTA         WUDTA                          RESTORE RECORD DS
037700090305    ?C                   Call      'UPDOCN  '                                   PROCESS REC IO
037800000000    ?C                   Parm      'GETNL   '    WWRQS                          GET RECORD
037900000000    ?C                   Parm                    WWRTN                          RETURN CODE
038000000614    ?C                   Parm                    WUDTA                          REC DATA
038100090309    ?C                   Parm                    Whist                          DATA
038200000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
038300000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
038400000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
038500000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
038600000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
038700000000X001?C                   Else                                                   ELSE
038800000000 001?C                   Move      'Y'           WWCHG                          DATA CHANGED
038900090305     C     OCEFF         MULT      10000.0001    WSBEDT
039000090305     C     OCTRM         MULT      10000.0001    WSENDT
039100090407     C********           Movel     OCPHN1        WSPHN1
039200090408     C                   Clear                   OCPHON
039300090407     C                   Move      OCPHN1        OCPHON
039400090407     C                   movel     odph13        cph13
039500090407     C                   movel     odph46        cph46
039600090407     C                   movel     odph710       cph710
039700090408     C                   Clear                   OCPHON
039800090408     C                   Move      OCPHN2        OCPHON
039900090408     C                   movel     odph13        cph132
040000090408     C                   movel     odph46        cph462
040100090408     C                   movel     odph710       cph7102
040200090408     C                   Clear                   OCPHON
040300090408     C                   Move      OCPHN3        OCPHON
040400090408     C                   movel     odph13        cph133
040500090408     C                   movel     odph46        cph463
040600090408     C                   movel     odph710       cph7103
040700090408     C                   Clear                   OCPHON
040800090408     C                   Move      OCFAX         OCPHON
040900090408     C                   movel     odph13        cfa13
041000090408     C                   movel     odph46        cfa46
041100090408     C                   movel     odph710       cfa710
041200090323     C                   If        OCCCOD  <>    ACM
041300090323     C                   Eval      WSLNAM   =    %Trim(OCLNAM)
041400090323     C                   Eval      WSFNAM   =    %Trim(OCFNAM)
041500090323     C                   Else
041600090323     C     ACMKey        Chain     ODCMGRP
041700090323     C                   If        %Found(ODCMGRP)
041800090323     C                   Eval      WSLNAM   =    %Trim(CMLNAM)
041900090323     C                   Eval      WSFNAM   =    %Trim(CMFNAM)
042000090323     C                   Else
042100090323     C                   Eval      WSLNAM = %Trim('Not on File')
042200090323     C                   End
042300090323     C                   End
042400000000E001?C                   Endif                                                  END IF ERROR
042500000000    ?C                   Endsr                                                  END PREP COPY
042600000000    ? *___________________________________________________________________
042700000000    ? * Default Data
042800000000    ? *___________________________________________________________________
042900000000    ?C     DFTDTA        Begsr                                                  DEFAULT DATA
043000090305    ?C                   Call      'CHKOCN  '                                   PROCESS REC IO
043100000000    ?C                   Parm      'DFTDTA'      WWRQS                          GENERATE KEY
043200000000    ?C                   Parm                    WWRTN                          RETURN CODE
043300000614    ?C                   Parm                    WUDTA                          REC DATA
043400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
043500000000 001?C                   Movel     WTM(10)       WWMSG                          PASS MESSAGE
043600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
043700000000 001?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
043800000000 001?C                   Move      'END'         WWSTT                          EXIT CHG PGM
043900000000E001?C                   Endif                                                  END IF ERROR
044000000000    ?C                   Endsr                                                  END DFTDTA
044100000000    ? *___________________________________________________________________
044200000000    ? * Process ERROR function
044300000000    ? *___________________________________________________________________
044400000000    ?C     PRCERR        Begsr                                                  PROC ADD RQST
044500000000    ?C                   Move      WTM(1)        WWMSG                          PASS MSG
044600000000    ?C                   Exsr      SNDMSG                                       SEND MSG
044700000000    ?C                   Move      'ERROR   '    WORTN                          RETURN ERROR
044800000000    ?C                   Move      'END'         WWSTT                          END STATE
044900000000    ?C                   Endsr                                                  END PRCERR
045000000000    ? *___________________________________________________________________
045100000000    ? * Receive messages
045200000000    ? *___________________________________________________________________
045300000000    ?C     RCVMSG        Begsr                                                  RECEIVE MSG
045400000000B001?C     WWMSGC        Ifne      'NORESET'                                    IF NOT NORESET
045500000000 001?C                   Movel     'RECEIVE'     WWRQS                          RCV/CLR MESSAGES
045600000000X001?C                   Else                                                   ELSE
045700000000 001?C                   Movel     'DISPLAY'     WWRQS                          JUST DISPLAY
045800000000E001?C                   Endif                                                  ENDIF NOT NORESET
045900000000    ?C                   Movel     'RESET   '    WWMSGC                         FORCE TO RESET
046000000000    ?C                   Movea     *IN           WWIN                           INDICATORS
046100000000    ?C                   Call      'PRCMSG2'                                    CALL MSG PGM
046200000000    ?C                   Parm                    WWRQS                          REQUEST MSG DSP
046300000000    ?C                   Parm                    WWIN                           INDICATORS
046400000000    ?C                   Parm                    WWRTN                          RETURN CODE
046500000000    ?C                   Movea     WWIN          *IN                            INDICATORS RET
046600000000    ?C                   Endsr                                                  END RCV MSG
046700000000    ? *___________________________________________________________________
046800000000    ? * Display panels
046900000000    ? *___________________________________________________________________
047000000000    ?C     DSPPNL        Begsr                                                  DISPLAY PANELS
047100000000    ? *
047200000000    ? * Set PUTOVR based on last display file processed
047300000000B001?C     WQPGMN        Ifne      WUPGM                                        IF NEW PROGRAM
047400000000 001?C     WWPNL         Orne      WWPNLO                                       OR NEW PANEL
047500000000 001?C                   Setoff                                       35        PUTOVR OFF
047600000000 001?C                   Move      WQPGMN        WUPGM                          SAVE PGM NAM
047700000000 001?C                   Move      WWPNL         WWPNLO                         SAVE PNL NBR
047800000000X001?C                   Else                                                   ELSE SAME PGM
047900000000 001?C                   Seton                                        35        PUTOVR ON
048000000000E001?C                   Endif                                                  END IF NEW PGM
048100000000    ? *
048200000614    ? * Set PROTECT key based on request
048300000000B001?C     WWTSK         Ifeq      'ADD   '                                     IF ADD
048400000000 001?C     WWTSK         Oreq      'INSERT'                                     OR INSERT
048500000000 001?C     WWTSK         Oreq      'COPY  '                                     OR COPY
048600000000 001?C                   Setoff                                       40        NO PROTECT KEY
048700000000X001?C                   Else                                                   ELSE
048800000000 001?C                   Seton                                        40        PROTECT KEY
048900000000E001?C                   Endif                                                  END IF ADD
049000000000    ? *
049100000000    ? * Select title
049200000000B001?C     WWTSK         Ifeq      'CHANGE'                                     IF CHANGE
049300000000 001?C                   Setoff                                       38        CHANGE TITLE
049400000000X001?C                   Else                                                   ELSE
049500000000 001?C                   Seton                                        38        ADD TITLE
049600000000E001?C                   Endif                                                  END IF CHANGE
049700000000    ? *
049800000000    ? * Position cursor based on error status
049900000000B001?C     WWERR         Ifeq      'Y'                                          IF ERROR
050000000000 001?C                   Seton                                        99        POS CSR TO ERROR
050100000000X001?C                   Else                                                   ELSE
050200000000 001?C                   Setoff                                       99        POS CSR TO FIRST
050300000000E001?C                   Endif                                                  END IF ERROR
050400000000    ? *
050500000000    ? * Write message subfile
050600000000    ?C                   Seton                                        30        MSGSFL DISPLAY
050700000000    ?C                   Write     MSGCTL                                       DISPLAY MSG SFL
050800000000    ? *
050900000000    ? * Write entry panel
051000000000B001?C                   Select
051100000000 001?C     WWPNL         Wheneq    1                                            IF PANEL 1
051200000000 001?C                   Exfmt     ENTPNL                                       DSPLY ENTRY PNL1
051300000000 001?C                   Setoff                                       37        RESET CRSLOC
051400000000E001?C                   Endsl                                                  END SELECT
051500000000    ? *
051600000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
051700000000 001?C                   Move      'Y'           WWCHG                          RECORD CHANGED
051800000000E001?C                   Endif                                                  END IF DATA CHG
051900000000    ?C                   Endsr                                                  END DSPENT
052000000000    ? *___________________________________________________________________
052100000000    ? * Process function key
052200000000    ? *___________________________________________________________________
052300000000    ?C     PRCFKY        Begsr                                                  PROC FNCTN KEYS
052400991108    ?C                   Movea     *IN           WWIN                           INDICATORS
052500991108    ?C                   Call      'PRCFKY2'                                    PROCESS FNC KEYS
052600000000    ?C                   Parm      'PROCESS '    WWRQS                          REQUEST PROCESS
052700000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
052800000000    ?C                   Parm                    WAD                            FNC DESC
052900991108    ?C                   Parm                    WWIN                           AID BYTE
053000000000    ?C                   Parm                    WAF                            FNC KEY TABLE
053100000000    ?C                   Parm                    WIFKV                          FNC KEY ALLOWED
053200000000    ?C                   Endsr                                                  END PRCFKY
053300000000    ? *___________________________________________________________________
053400000000    ? * Process KEYS function
053500000000    ? *___________________________________________________________________
053600000000    ?C     PRCDKY        Begsr                                                  PROCESS KEYS
053700000000    ?C                   Z-add     1             WW                             KEY DSC IDX
053800000000B001?C     WWFKS         Doueq     1                                            DO UNTIL SET=1
053900000000 001?C     WAD(WW)       Orne      *BLANKS                                      OR KEYS FOUND
054000000000 001?C     WWFKS         Add       1             WWFKS                          NEXT KEY SET
054100000000 001? *
054200000000B002?C     WWFKS         Ifgt      3                                            IF OVER 3
054300000000 002?C                   Z-add     1             WWFKS                          SET TO 1
054400000000E002?C                   Endif                                                  END IF OVER 3
054500000000 001? *
054600000000 001?C     WWFKS         Add       WWFKS         WW                             KEY DESCR IDX
054700000000 001?C                   Sub       1             WW                             KEY DESCR IDX
054800000000E001?C                   Enddo                                                  END DO KEYS
054900000000    ? *
055000000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
055100000000    ?C                   Add       1             WW                             BUMP IDX
055200000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
055300000000    ?C                   Endsr                                                  END PRCDKY
055400000000    ? *___________________________________________________________________
055500000000    ? * Process EXIT Function
055600000000    ? *___________________________________________________________________
055700000000    ?C     PRCEXT        Begsr                                                  RETURN
055800000000    ? *
055900000000    ?C                   Exsr      PRCPNL                                       PROCESS THE PANEL
056000000000    ? *
056100000000B001?C     WWERR         Ifeq      'Y'                                          IF ERRORS
056200000000 001?C                   Move      *BLANKS       WWSTT                          REDISPLAY PANEL
056300000000X001?C                   Else                                                   ELSE NO ERRORS
056400000000 001?C                   Movel     WWFKA         WORTN                          RETURN CODE
056500000000 001?C                   Move      'END'         WWSTT                          END INVOCATION
056600000000E001?C                   Endif                                                  END IF ERRORS
056700000000    ?C                   Endsr                                                  END PRCEXT
056800000000    ? *___________________________________________________________________
056900000000    ? * Process PROMPT function
057000000000    ? *___________________________________________________________________
057100000000    ?C     PRCPMT        Begsr                                                  PROCESS PROMPT
057200000000    ?C                   Movel     WDCRSL        WWRQS                          REQUEST CURSOR PSN
057300000000    ?C                   Move      'Y'           WWCHG                          RECORD CHANGED
057400000000    ?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
057500000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
057600090319    ?C                   Eval      CCTRST  =  OCTRST
057700090319    ?C                   Eval      CCSUB#  =  OCSUB#
057800090319    ?C                   Eval      CCACCT  =  OCACCT                            POSITION TO 1
057900090317B001 C                   Select
058000090318 001 C                   When      WSFLD = 'OCCCOD'
058100090317     C                   Call      'SLCCCO'                                     *ENTRY LIST
058200090317     C                   Parm                    WWRQS                          PROGRAM REQUEST
058300090317     C                   Parm                    WWRTN                          RETURN CODE
058400090317     C                   Parm                    WUPGM                          LAST PGM NAME
058500090319     C                   Parm                    WCDTA                          RECORD DS
058600090317     C                   IF        WWRTN = *BLANKS
058700090319    ?C                   Eval      OCCCOD = CCCCOD                              POSITION TO 1
058800090319    ?C                   Eval      OCTITL = CCTITL                              POSITION TO 1
058900090317E001 C                   Endif
059000090317 001  *
059100090317 001 C                   Other
059200090317 001 C                   Move      WTM(6)        WWMSG
059300090317 001 C                   Exsr      SNDMSG
059400090317E001 C                   Endsl
059500090317      *
059600000000    ? *
059700000000    ? * RETRIEVE CURSOR LOCATION FOR POSITION CURSOR
059800000000    ?C                   Movel     WDCRSL        WWCRSL                         REQUEST CURSOR PSN
059900000000    ?C     WWCRSN        Div       256           WSROW                          CURSOR ROW
060000000000    ?C                   Mvr                     WSLIN                          CURSOR COL
060100000000    ?C                   Seton                                        37        SET ON CRSLOC
060200000000    ? *
060300000000    ?C                   Endsr                                                  END PRCPMT
060400000000    ? *___________________________________________________________________
060500000000    ? * Process CANCEL Function
060600000000    ? *___________________________________________________________________
060700000000    ?C     PRCCNL        Begsr                                                  CANCEL
060800000000    ?C                   Movel     WWFKA         WORTN                          RETURN CODE
060900000000    ?C                   Move      'END'         WWSTT                          END INVOCATION
061000000000    ?C                   Move      'N'           WWCHG                          NO RCD UPDATE
061100000000    ?C                   Endsr                                                  END RETURN
061200000000    ? *___________________________________________________________________
061300000000    ? * Process ROLLUP function
061400000000    ? *___________________________________________________________________
061500000000    ?C     PRCRUP        Begsr                                                  PROCESS ROLLUP
061600000000    ?C     WWPNL         Add       1             WWPNL                          NEXT PANEL
061700000000B001?C     WWPNL         Ifgt      WWPNLN                                       IF GT LAST PNL
061800000000 001?C     WWPNL         Sub       1             WWPNL                          LAST PANEL
061900000000E001?C                   Endif                                                  END IF GT LST PNL
062000000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
062100000000    ?C                   Endsr                                                  END PRCRUP
062200000000    ? *___________________________________________________________________
062300000000    ? * Process ROLLDOWN function
062400000000    ? *___________________________________________________________________
062500000000    ?C     PRCRDN        Begsr                                                  PROCESS ROLLDOWN
062600000000    ?C     WWPNL         Sub       1             WWPNL                          PRV PANEL
062700000000B001?C     WWPNL         Iflt      1                                            IF LT FIRST PNL
062800000000 001?C     WWPNL         Add       1             WWPNL                          LAST PANEL
062900000000E001?C                   Endif                                                  END IF LT FST PNL
063000000000    ?C                   Movel     'NORESET '    WWMSGC                         DON'T CLEAR PGMQ
063100000000    ?C                   Endsr                                                  END PRCRDN
063200000000    ? *___________________________________________________________________
063300000000    ? * Process ENTER function
063400000000    ? *___________________________________________________________________
063500000000    ?C     PRCPNL        Begsr                                                  PROCESS PANEL
063600000000    ?C                   Move      *BLANKS       WWRTN                          RESET RETURN
063700000000    ?C                   Movea     *ZEROS        *IN(60)                        RESET ERR INDS
063800000000B001?C     *IN39         Ifeq      *ON                                          IF DATA CHANGED
063900000000 001?C     WWWRNF        Oreq      'N'                                          OR NO WARNINGS
064000000000 001?C                   Move      'N'           WWWRNF                         SET WRN DSP OFF
064100090305     C                   Z-add     WSBEDT        OCEFF
064200090305     C                   Z-add     WSENDT        OCTRM
064300090407     C**********         Movel     WSPHN1        OCPHN1
064400090408     C                   Clear                   OCPHON
064500090407     C                   movel     cph13         odph13
064600090407     C                   movel     cph46         odph46
064700090407     C                   movel     cph710        odph710
064800090407     C                   Movel     OCPHON        OCPHN1
064900090408     C                   Clear                   OCPHON
065000090408     C                   movel     cph132        odph13
065100090408     C                   movel     cph462        odph46
065200090408     C                   movel     cph7102       odph710
065300090408     C                   Movel     OCPHON        OCPHN2
065400090408     C                   Clear                   OCPHON
065500090408     C                   movel     cph133        odph13
065600090408     C                   movel     cph463        odph46
065700090408     C                   movel     cph7103       odph710
065800090408     C                   Movel     OCPHON        OCPHN3
065900090408     C                   Clear                   OCPHON
066000090408     C                   movel     cfa13         odph13
066100090408     C                   movel     cfa46         odph46
066200090408     C                   movel     cfa710        odph710
066300090408     C                   Movel     OCPHON        OCFAX
066400090325     C                   Eval      OCLNAM   =    %Trim(WSLNAM)
066500090325     C                   Eval      OCFNAM   =    %Trim(WSFNAM)
066600090305 001?C                   Call      'CHKOCN  '                                   CHECK DATA
066700000000 001?C                   Parm      'EDIT    '    WWRQS                          EDIT REQUEST
066800000000 001?C                   Parm                    WWRTN                          RETURN CODE
066900000614 001?C                   Parm                    WUDTA                          REC DATA
067000000000E001?C                   Endif                                                  ENDIF
067100000000    ? *
067200000000B001?C                   Select                                                 PRC RETURN CDE
067300000000 001?C     WWRTN         Wheneq    *BLANKS                                      NO ERRORS
067400000000 001?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
067500000000 001? *
067600000000 001?C     WWRTN         Wheneq    'WARNING'                                    WARNING ERRORS
067700000000B002?C     WWWRNF        Ifeq      'Y'                                          IF WARNING DISPLAYED
067800000000 002?C                   Move      'N'           WWERR                          NO ERRORS IN DTA
067900000000X002?C                   Else                                                   ELSE
068000000000 002?C                   Move      'Y'           WWWRNF                         SET WARNING DSP'D
068100000000 002?C                   Move      'Y'           WWERR                          ERRORS IN DATA
068200000000E002?C                   Endif                                                  IF WARNING
068300000000 001? *
068400000000 001?C     WWRTN         Wheneq    'ERROR  '                                    ERRORS
068500000000 001?C                   Move      'Y'           WWERR                          NO ERRORS IN DTA
068600000000 001?C                   Move      *BLANKS       WWSTT                          DONT END INVOCATION
068700000000 001?C                   Move      'N'           WWWRNF                         RESET WARNING FLAG
068800000000E001?C                   Endsl                                                  RETURN CODE SEL
068900090319    ? *
069000090319     C                   Exsr      GETDSC
069100000000    ? *
069200000000    ?C                   Endsr                                                  END PRCPNL
069300090319    ? *
069400090319    ? *
069500090319    ?C     GETDSC        Begsr                                                  PROCESS END
069600090319    ? *
069700090319     C                   Eval      OCTITL = *blanks
069800100726     C                   Eval      WKTRST = 999
069900090319    ? * Validate Code
070000090319     C     WKCCOD        Setll     ODCCTL2                                      PSN DB CURSOR
070100090319     C     WKCCOD        Reade     ODCCTL2                                50    READ FILE
070200090319     C                   Dow       not %eof(ODCCTL2)                            IF RECORD READ
070300100726     C                   If        OCACCT <> 0   AND
070400100726     C                             CCACCT = 9999 OR
070500100726     C                             OCACCT = 0    AND
070600100726     C                             CCACCT = 0000
070700090319     C                   Eval      OCTITL = CCTITL
070800090319     C                   Leave
070900090319     C                   End                                                    END IF REC READ
071000090319     C     WKCCOD        Reade     ODCCTL2                                50    READ FILE
071100090319     C                   Enddo                                                  END DO
071200090319    ? *
071300090319    ?C                   Endsr                                                  END PRCPNL
071400000000    ? *___________________________________________________________________
071500000000    ? * Process end - write data or release record
071600000000    ? *___________________________________________________________________
071700000000    ?C     PRCEND        Begsr                                                  PROCESS END
071800000000    ? *
071900000000B001?C     WWCHG         Ifeq      'Y'                                          IF RECORD CHANGED
072000000000 001?C     WWERR         Andeq     'N'                                          AND NO ERRORS
072100000000 001?C     WWTSK         Caseq     'ADD     '    WRTADD                         WRITE ADD
072200000000 001?C     WWTSK         Caseq     'ADDKEY  '    WRTADD                         WRITE ADD
072300000000 001?C     WWTSK         Caseq     'INSKEY  '    WRTADD                         WRITE ADD
072400000000 001?C     WWTSK         Caseq     'CPYKEY  '    WRTADD                         WRITE ADD
072500000000 001?C     WWTSK         Caseq     'CHANGE  '    WRTCHG                         WRITE CHANGE
072600000000 001?C     WWTSK         Caseq     'COPY    '    WRTADD                         WRITE COPY (ADD)
072700000000 001?C     WWTSK         Caseq     'INSERT  '    WRTADD                         WRITE INSERT (ADD)
072800000000 001?C                   Endcs                                                  END CASE
072900000000 001? *
073000000000B002?C     WWRTN         Ifne      *BLANKS                                      IF WRITE ERROR
073100000000 002?C                   Move      *BLANKS       WWSTT                          DO NOT END
073200000000 002? *
073300000000X002?C                   Else                                                   ELSE NO WRT ERR
073400000000B003?C     WWFKA         Ifne      'EXIT'                                       IF NOT END
073500000810B004?C     WWTSK         Ifeq      'BYPASS  '                                   IF ADD
073600000810 004?C     WWTSK         Oreq      'SKIP    '                                   OR ADD KEY
073700000000 004?C                   Exsr      PRPPNL                                       DO NOT END
073800000810E004?C                   Endif                                                  END IF ADD
073900000000E003?C                   Endif                                                  END IF NOT END
074000000000E002?C                   Endif                                                  END IF WRITE ERROR
074100000000 001? *
074200000000X001?C                   Else                                                   ELSE IF RCD NOT CHG
074300000000 001?C                   Exsr      RELREC                                       RELEASE REC
074400000000E001?C                   Endif                                                  END IF RCD CHANGED
074500000000    ? *
074600000000    ?C                   Endsr                                                  END PRCEND
074700000000    ? *___________________________________________________________________
074800000000    ? * Add new record
074900000000    ? *___________________________________________________________________
075000000000    ?C     WRTADD        Begsr                                                  WRITE ADD
075100000000B001?C     WWTSK         Ifeq      'ADD    '                                    IF ADD
075200000000 001?C     WWTSK         Oreq      'INSERT '                                    OR INSERT
075300000000 001?C     WWTSK         Oreq      'COPY   '                                    OR COPY
075400000000 001?C                   Movel     'ADD    '     WWRQS                          THEN ADD RCD
075500000000E001?C                   Endif                                                  END IF ADD
075600000000    ? *
075700000000B001?C     WWTSK         Ifeq      'ADDKEY '                                    IF ADD KEY
075800000000 001?C     WWTSK         Oreq      'INSKEY '                                    OR INSERT KEY
075900000000 001?C     WWTSK         Oreq      'CPYKEY '                                    OR COPY KEY
076000000000 001?C                   Movel     'ADDKEY '     WWRQS                          THEN ADD KEY
076100000000E001?C                   Endif                                                  END IF ADD KEY
076200000000    ? *
076300090309     C                   Movel     HstTracker    Whist
076400090305    ?C                   Call      'UPDOCN  '                                   PROCESS REC IO
076500000000    ?C                   Parm                    WWRQS                          ADD RECORD
076600000000    ?C                   Parm                    WWRTN                          RETURN CODE
076700000614    ?C                   Parm                    WUDTA                          REC DATA
076800090309    ?C                   Parm                    Whist                          DATA
076900000000    ? *
077000000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ADD ERROR
077100000000 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
077200000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
077300000000X001?C                   Else                                                   ELSE
077400000000E001?C                   Endif                                                  END IF CALL ERROR
077500000000    ? *
077600000000    ?C                   Endsr                                                  END WRTADD
077700000000    ? *___________________________________________________________________
077800000000    ? * Write changed record
077900000000    ? *___________________________________________________________________
078000000000    ?C     WRTCHG        Begsr                                                  WRITE CHANGE
078100070614     C                   If        SVBEDT     >  20000000
078200070614     C     SVBEDT        MULT      10000.0001    SVBEDT
078300070614     C                   End
078400070614     C                   If        SVENDT     >  20000000
078500070614     C     SVENDT        MULT      10000.0001    SVENDT
078600070614     C                   End
078700090309     C                   Clear                   HstTracker
078800090309      * Contact Type Code
078900090309     C                   If        SVCCOD    <>  OCCCOD
079000090309     C                   Movel     SVCCOD        SaveCTCode
079100090309     C                   Eval      CTCode    =   'X'
079200090309     C                   End
079300090309      * Contact Title
079400090309     C                   If        SVTITL    <>  OCTITL
079500090309     C                   Movel     SVTITL        SaveCTitle
079600090309     C                   Eval      CTitle    =   'X'
079700090309     C                   End
079800090309      * Last Name
079900090309     C                   If        SVLNAM    <>  OCLNAM
080000090309     C                   Movel     SVLNAM        SaveLastN
080100090309     C                   Eval      LastN     =   'X'
080200090309     C                   End
080300090309      * First Name
080400090309     C                   If        SVFNAM    <>  OCFNAM
080500090309     C                   Movel     SVFNAM        SaveFirstN
080600090309     C                   Eval      FirstN    =   'X'
080700090309     C                   End
080800090309      * Address 1
080900090309     C                   If        SVADD1    <>  OCADD1
081000090309     C                   Movel     SVADD1        SaveAddr1
081100090309     C                   Eval      Addr1     =   'X'
081200090309     C                   End
081300090309      * Address 2
081400090309     C                   If        SVADD2    <>  OCADD2
081500090309     C                   Movel     SVADD2        SaveAddr2
081600090309     C                   Eval      Addr2     =   'X'
081700090309     C                   End
081800090309      * City
081900090309     C                   If        SVCITY    <>  OCCITY
082000090309     C                   Movel     SVCITY        SaveCity
082100090309     C                   Eval      City      =   'X'
082200090309     C                   End
082300090309      * State
082400090309     C                   If        SVST      <>  OCST
082500090309     C                   Movel     SVST          SaveState
082600090309     C                   Eval      State     =   'X'
082700090309     C                   End
082800090309      * Zip
082900090309     C                   If        SVZIP     <>  OCZIP
083000090309     C                   Movel     SVZip         SaveZip
083100090309     C                   Eval      Zip       =   'X'
083200090309     C                   End
083300090309      * Phone1
083400090309     C                   If        SVPHN1    <>  OCPHN1
083500090309     C                   Movel     SVPHN1        SavePhon1
083600090309     C                   Eval      Phon1     =   'X'
083700090309     C                   End
083800090309      * Phone2
083900090309     C                   If        SVPHN2    <>  OCPHN2
084000090309     C                   Movel     SVPHN2        SavePhon2
084100090309     C                   Eval      Phon2     =   'X'
084200090309     C                   End
084300090309      * Phone3
084400090309     C                   If        SVPHN3    <>  OCPHN3
084500090309     C                   Movel     SVPHN3        SavePhon3
084600090309     C                   Eval      Phon3     =   'X'
084700090309     C                   End
084800090309      * Fax
084900090309     C                   If        SVFAX     <>  OCFAX
085000090309     C                   Movel     SVFAX         SaveFax
085100090309     C                   Eval      Fax       =   'X'
085200090309     C                   End
085300090309      * Email
085400090309     C                   If        SVEMAL    <>  OCEMAL
085500090309     C                   Movel     SVEMAL        SaveEmail
085600090309     C                   Eval      Email     =   'X'
085700090309     C                   End
085800090309      * Case Manager
085900090309     C                   If        SVCMGR    <>  OCCMGR
086000090309     C                   Movel     SVCMGR        SaveCaseM
086100090309     C                   Eval      CaseM     =   'X'
086200090309     C                   End
086300090309      * Effective Date
086400090309     C                   If        SVBEDT    <>  OCEFF
086500090309     C                   Movel     SVBEDT        SaveEffDt
086600090309     C                   Eval      EffDt     =   'X'
086700090309     C                   End
086800090309      * Termination Date
086900090309     C                   If        SVENDT    <>  OCTRM
087000090309     C                   Movel     SVENDT        SaveTrmDt
087100090309     C                   Eval      TrmDt     =   'X'
087200090309     C                   End
087300090309     C                   Movel     HstTracker    Whist
087400090305    ?C                   Call      'UPDOCN  '                                   PROCESS REC IO
087500000000    ?C                   Parm      'CHANGE'      WWRQS                          UPDATE RECORD
087600000000    ?C                   Parm                    WWRTN                          RETURN CODE
087700000614    ?C                   Parm                    WUDTA                          REC DATA
087800090309    ?C                   Parm                    Whist                          DATA
087900000000B001?C     WWRTN         Ifne      *BLANKS                                      IF UPDATE ERROR
088000070614 001?C                   Movel     WTM(3)        WWMSG                          PASS MESSAGE
088100000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
088200000000E001?C                   Endif                                                  END IF CALL ERROR
088300000000    ? *
088400000000    ?C                   Endsr                                                  END WRTCHG
088500000000    ? *___________________________________________________________________
088600000000    ? * Release record
088700000000    ? *___________________________________________________________________
088800000000    ?C     RELREC        Begsr                                                  PROC CHG RQST
088900090305    ?C                   Call      'UPDOCN  '                                   PROCESS REC IO
089000000000    ?C                   Parm      'RELEASE '    WWRQS                          RELEASE RECORD
089100000000    ?C                   Parm                    WWRTN                          RETURN CODE
089200000614    ?C                   Parm                    WUDTA                          REC DATA
089300090309    ?C                   Parm                    Whist                          DATA
089400000000B001?C     WWRTN         Ifne      *BLANKS                                      IF ERROR
089500000000 001?C                   Movel     WTM(6)        WWMSG                          PASS MESSAGE
089600000000 001?C                   Exsr      SNDMSG                                       SEND MESSAGE
089700000000E001?C                   Endif                                                  END IF CALL ERROR
089800000000    ?C                   Endsr                                                  END RELREC
089900000000    ? *___________________________________________________________________
090000000000    ? * Build function keys
090100000000    ? *___________________________________________________________________
090200000000    ?C     BLDFKY        Begsr                                                  BUILD FNCT KEYS
090300991108    ?C                   Movea     *IN           WWIN                           INDICATORS
090400991108    ?C                   Call      'PRCFKY2'                                    PROC FNCTN KYS
090500000000    ?C                   Parm      'BUILD   '    WWRQS                          REQUEST PROCESS
090600000000    ?C     WWFKA         Parm                    WWRTN                          RETURN CODE
090700000000    ?C                   Parm                    WAD                            FNC DESC
090800991108    ?C                   Parm                    WWIN                           AID BYTE
090900000000    ?C                   Parm                    WAF                            FNCTN KEY TABLE
091000000000    ?C                   Parm                    WIFKV                          FNCTN KYS ALLWD
091100000000    ?C     WWFKS         Add       WWFKS         WW                             KEY DSC IDX
091200000000    ?C                   Movel     WAD(WW)       WSFKD2                         LOAD LINE 2
091300000000    ?C                   Sub       1             WW                             BUMP IDX
091400000000    ?C                   Movel     WAD(WW)       WSFKD1                         LOAD LINE 1
091500000000    ?C                   Endsr                                                  END BLD FNCTNS
091600000000    ? *___________________________________________________________________
091700000000    ? * Send message
091800000000    ? *___________________________________________________________________
091900000000    ?C     SNDMSG        Begsr                                                  SEND MESSAGE
092000000000    ?C                   Call      'QSNDDTAQ'                                   SEND MESSAGE
092100000000    ?C                   Parm                    WWDTAQ           10            DATA QUEUE NAME
092200000000    ?C                   Parm                    WWLIB            10            DATA QUEUE LIB
092300000000    ?C                   Parm                    WWLNGQ            5 0          MESSAGE LENGTH
092400000000    ?C                   Parm                    WWMSG            80            ERROR MESSAGE
092500000000    ?C                   Endsr                                                  END SNDMSG
092600000000    ? *___________________________________________________________________
092700000000    ? * Paremater list
092800000000    ? *___________________________________________________________________
092900000000    ?C     PLIST         Begsr                                                  PARM LISTS
093000000000    ?C     *ENTRY        Plist                                                  *ENTRY LIST
093100000000    ?C     WWTSK         Parm                    WIRQS             8            REQUEST
093200000000    ?C                   Parm                    WORTN             8            RETURN CODE
093300000000    ?C                   Parm                    WUPGM            10            LAST PGM NAME
093400000614    ?C                   Parm                    WUDTA                          RECORD KEY
093500000000    ?C                   Parm                    WIFKV            60            FUNCTIONS VALID
093600090309    ?C                   Parm                    Whist                          DATA
093700000000    ?C                   Endsr                                                  END PLIST
093800050318    ? *___________________________________________________________________
093900050318    ? * Key lists
094000050318    ? *___________________________________________________________________
094100050318    ?C     KLIST         Begsr                                                  KEY LISTS
094200050318    ?C     AKey          Klist                                                  ACKCTL
094300090305    ?C                   Kfld                    OCTRST
094400090305    ?C                   Kfld                    OCSUB#
094500090305    ?C                   Kfld                    OCACCT                         POSITION TO 1
094600090226    ?C     AccKey        Klist                                                  ACKCTL
094700090305    ?C                   Kfld                    OCTRST
094800090305    ?C                   Kfld                    OCSUB#
094900090305    ?C                   Kfld                    OCACCT                         POSITION TO 1
095000090312    ?C     SKey          Klist                                                  ACKCTL
095100090312    ?C                   Kfld                    OCTRST
095200090312    ?C                   Kfld                    OCSUB#
095300090323    ?C     WKCCOD        Klist                                                  AGENCY
095400100726    ?C                   Kfld                    WKTRST                         POSITION TO 1
095500090323    ?C                   Kfld                    OCCCOD                         POSITION TO 1
095600050318    ?C                   Endsr                                                  END KLIST
095700090323    ?C     ACMKey        Klist                                                  AGENCY
095800090323    ?C                   Kfld                    OCTRST                         POSITION TO 1
095900090323    ?C                   Kfld                    OCCMGR                         POSITION TO 1
096000000000    ? *___________________________________________________________________
096100000000    ? * Initialize routine
096200000000    ? *___________________________________________________________________
096300000000    ?C     *INZSR        Begsr                                                  INITIALIZE
096400000614    ?C     *LIKE         Define    WUDTA         WWDTA                          RECORD DS
096500000000    ?C     *LIKE         Define    WIRQS         WWRQS                          TASK REQUEST
096600000000    ?C     *LIKE         Define    WIRQS         WWORQS                         SAVE REQUEST
096700000000    ?C     *LIKE         Define    WIRQS         WWTSK                          TASK REQUESTED
096800000000    ?C     *LIKE         Define    WORTN         WWRTN                          RETURN CODE
096900000000    ?C     *LIKE         Define    WORTN         WWFKA                          FUNCTION CODE
097000000000    ?C     *LIKE         Define    WIFKV         WWFKV                          FUNCTION KEY VALID
097100000000    ?C     *LIKE         Define    WIFKV         WWOPV                          OPTIONS VALID
097200000000    ?C     *LIKE         Define    WWPNL         WWPNLO                         PREVIOUS PANEL
097300090305    ?C                   Clear                   SVBEDT            8 0          CLEAR RECORD
097400090305    ?C                   Clear                   SVENDT            8 0          CLEAR RECORD
097500090305    ?C                   Clear                   SVCCOD            3            CLEAR RECORD
097600090305    ?C                   Clear                   SVTITL           40            CLEAR RECORD
097700090305    ?C                   Clear                   SVLNAM           20            CLEAR RECORD
097800090305    ?C                   Clear                   SVFNAM           20            CLEAR RECORD
097900090305    ?C                   Clear                   SVADD1           40            CLEAR RECORD
098000090305    ?C                   Clear                   SVADD2           40            CLEAR RECORD
098100090305    ?C                   Clear                   SVCITY           20            CLEAR RECORD
098200090305    ?C                   Clear                   SVST              2            CLEAR RECORD
098300090305    ?C                   Clear                   SVZIP             9            CLEAR RECORD
098400090305    ?C                   Clear                   SVPHN1           10            CLEAR RECORD
098500090305    ?C                   Clear                   SVPHN2           10            CLEAR RECORD
098600090305    ?C                   Clear                   SVPHN3           10            CLEAR RECORD
098700090305    ?C                   Clear                   SVFAX            10            CLEAR RECORD
098800090305    ?C                   Clear                   SVEMAL           50            CLEAR RECORD
098900090305    ?C                   Clear                   SVCMGR            5 0          CLEAR RECORD
099000000000    ?C                   Movel     'RESET   '    WWMSGC            7            RCV MESSAGE CLEAR
099100000000    ?C                   Movel     '*'           MSPGMQ                         JOB'S MSGQ
099200000000    ?C                   Movel     'MSGDTAQ'     WWDTAQ           10            DATA QUEUE NAME
099300000000    ?C                   Movel     'QTEMP'       WWLIB            10            DATA QUEUE LIB
099400000000    ?C                   Z-add     80            WWLNGQ            5 0          MESSAGE LENGTH
099500000000    ?C                   Move      *BLANKS       WWMSG            80            ERROR MESSAGE
099600000000    ?C                   Move      *BLANKS       WWIN             99            INDICATOR FIELD
099700000000    ?C                   Move      *BLANKS       WWSTT             3            STATUS
099800000000    ?C                   Move      *ZEROS        WWZERO           40            ZEROS
099900000000    ?C                   Z-add     1             WWPNL             1 0          CURRENT PNL
100000000810    ?C                   Z-add     1             WWPNLN            1 0          NBR OF PNLS
100100000000    ?C                   Z-add     1             WWFKS             1 0          FNC KEY SET
100200000000    ?C                   Move      'N'           WWERR             1            NO ERRORS
100300000000    ?C                   Move      'N'           WWCHG             1            NO CHANGES
100400000000    ?C                   Move      'N'           WWWRNF            1            NO WARNINGS
100500000000    ?C                   Z-add     0             WW                3 0          WORK INDEX
100600090305    ?C                   Movel     'ODCNTCP '    WWFIL            10            FILE NAME-NOTES
100700000000    ?C                   Move      *BLANKS       WWFLK           128            FILE KEY - NOTES
100800000000    ?C                   Move      *BLANKS       WWTXT            60            TEXT - NOTES
100900090323     C                   Movel     'ACM'         ACM               3
101000000000    ?C                   Endsr                                                  END INITIALIZE
101100000000    ? *___________________________________________________________________
101200000000    ? * Program error handler
101300000000    ? *___________________________________________________________________
101400000000    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
101500000000    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
101600000000    ?C                   Parm                    WQPGMN                         PROGRAM NAME
101700000000    ?C                   Parm                    WQSTSC                         STATUS CODE
101800000000    ?C                   Parm                    WQRPGS                         RPG STATEMENT
101900000000    ?C                   Parm                    WQMSG                          MESSAGE ID
102000000000    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
102100000000    ? *___________________________________________________________________
102200000000**  WAF FUNCTION KEY TABLE - 30X40      |INDICATOR 2.0, ACTION8A, DESCR 30A    |
10230009031201CANCEL  F1=Return
10240009031205UPDATE  F5=Update
10250009031206REFRESH F6=Refresh
10260009031207EXIT    F3=End Job
10270009031710PROMPT  F10=Prompt
10280000000025ROLLUP
10290000000026ROLLDOWN
103000000000** WTM
10310009030500Request not supported in program CHGOCN.
10320000000000Update error.  Data was not updated.
10330007061400Duplicate Begin Date not allowed.
10340000000000Call to notes ended in error.
10350000000000Initialize error.  Record not initialized.
10360000000000Record not found.
10370000000000Generate error.  Key not generated.
10380000000000Record not available now.
10390000000000The cursor is not in a prompt area.
10400000000000Default error.  Data not defaulted.
