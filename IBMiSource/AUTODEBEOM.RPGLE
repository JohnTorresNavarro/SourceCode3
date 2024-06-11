000100140325     Hoption(*nodebugio) debug actgrp(*caller) dftactgrp(*no)
000200140325     Hbnddir('ALLSRVPGMN')
000300140327    ? *_________________________________________________________________________
000400140327    ? *
000500140327      *  Program:      AUTODEBEOM
000600140403    ? *  Description:  See if Auto Debit (update run) or (trial run) should
000700140403    ? *                run today.  The "update run" should execute on the
000800140403    ? *                LAST GBS WORKDAY....the "trial run" should run one
000900140403    ? *                day before that.
001000140327    ? *  Written by:   Debora Bond
001100140327    ? *  Date Written: 04/01/2014
001200140327    ? *  Called from:  AUTDEBC (robot job)
001300140327    ? *
001400140327    ? *  (c)Copyright 2009 by GBS, Inc.
001500140327    ? *  This document contains restricted materials of GBS,Inc.
001600140327    ? *
001700140327    ? *_________________________________________________________________________
001800140327    ? *  Modifications:
001900140327    ? *_________________________________________________________________________
002000140327     D gbseom          s               d
002100140327     D runjob          s              1
002200140325
002300140327      /define copy_#get_gbs_eom_prototype
002400140327      /define copy_#get_gbs_eom_fields
002500140327      /copy qcpysrc,datsrvpgmp
002600140327      /undefine copy_#get_gbs_eom_prototype
002700140327      /undefine copy_#get_gbs_eom_fields
002800140325
002900140327     C     *entry        plist
003000140327     C                   parm                    runjob            1
003100140327
003200140325      /free
003300140325
003400140327       //?------------------------------------------------------------------
003500140327    ?  // Mainline routine
003600140327       //?------------------------------------------------------------------
003700140327       clear runjob ;
003800140327
003900140327       //?retrieve GBS last business day of this month
004000140327       gbseom = #get_gbs_eom() ;
004100140327
004200140327       //?determine if it's time to run either Auto Debit job
004300140327       if gbseom = %date() ; // today is the last business day - run update
004400140327        runjob = 'U' ;
004500140424       elseif %date() = gbseom - %days(1) ; // else run Trial job
004600140327        runjob = 'T' ;
004700140327       endif ;
004800140325
004900140325       *inlr = *on ;
005000140325       return ;
005100140325
005200140325      /end-free
