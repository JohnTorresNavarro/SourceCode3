000100140214     Hoption(*nodebugio) debug dftactgrp(*no) actgrp(*caller)
000200140611     Hbnddir('ALLSRVPGMN')
000300140214
000400000000      *_________________________________________________________________________
000500000000      *
000600000000      *  Description:  Delegated Billing Electronic Enrollment
000700000000      *
000800000000      *  (c)Copyright 2002 by Innovative Outsourcing, Inc.
000900000000      *
001000000000      *    Created by:  JALLEN - October 24, 2002
001100131010      *
001200131010      * 10/10/13 sbt - hist file expansion project
001300210218      *
001400000000      *_________________________________________________________________________
001500021024      *
001600021106     FDW310JF   IP   E           K DISK    Infds(DBFD)
001700090326     FTRNMIT    UF   E             DISK    Rename(TRNMIR:TRNUPD)
001800171207     F                                     extfile('F.TRNMIT')
001900180226     FUHCTEMP   IF A E           K DISK    extfile('QTEMP/UHCTEMP')
002000180725     FUHCHSTLF  IF A E           K DISK
002100171207
002200021106      * File DS
002300021106     D DBFD          E DS                  EXTNAME(IODBFD)
002400171207
002500021106      * Program status data structure
002600000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002700030513
002800021028     IJOINR         01
002900171207     I                                          SOCSOC        L2
003000121112      * Update Trans
003100180227     C   L2              Exsr      UpdateTranSR
003200180227     C   01WQRELR        delete    TRNUPD
003300021101      *___________________________________________________________________
003400171207      * Write UHC History Tracking and Remove Transmit Record
003500021101      *___________________________________________________________________
003600021101     C     UpdateTranSR  BEGSR
003700180725
003800180725      * if it is already in the queue, leave
003900180725     C     SOCSOC        chain     UHCHSTLF
004000180725     C                   if        %found(UHCHSTLF)
004100180725     C                   LeaveSR
004200180725     C                   end
004300171207
004400171207     C                   eval      UHTRST = TRUST
004500171207     C                   eval      UHSUB# = SUBNO
004600171207     C                   eval      UHACCT = ACCNO
004700171207     C                   eval      UHSSNO = SOCSOC
004800171207     C                   eval      UHLAST = %trim(LNAME)
004900180626     C                   eval      UHFIRST= %trim(FNAME)
005000180626     C                   eval      UHGROUP = %trim(GROUP#)
005100171207     C                   eval      UHTRNU = %trim(QQUSER)
005200171207     C                   eval      UHTRND = QQDATE
005300171207     C                   eval      UHTRNT = QQTIME
005400171207     C                   eval      UHAPPU = *blanks
005500171207     C                   eval      UHAPPD = *zeros
005600171207     C                   eval      UHAPPT = *zeros
005700180725     C                   eval      UHNOTE = *blanks
005800180725     C                   eval      UHCOMP = *blanks
005900180226
006000180226      * Do not duplicate per load
006100180226     C     UHSSNO        chain     UHCTEMP
006200180226     C                   if        not %found(UHCTEMP)
006300180622     C                   eval      TESSNO = UHSSNO
006400180226     C                   write     UHCTMPR
006500171207     C                   write     UHCHSTR
006600210218     C                   end
006700171207
006800171207     C     WQRELR        delete    TRNUPD
006900171207
007000021101     C                   ENDSR
