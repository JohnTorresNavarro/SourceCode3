000100140402     Hoption(*nodebugio) debug actgrp(*caller) dftactgrp(*no)
000200140402    ? *_________________________________________________________________________
000300140402    ? *
000400140402      *  Program:      DW222DATE
000500140425    ? *  Description:  Validate payment posting date for ACH.  Date must
000600140425    ? *                be a valid date, can only be a date in the past IF
000700140425    ? *                not auto debit posting (and no more than 4 days in
000800140425    ? *                the past), date cannot be more than 3 days in the
000900140425    ? *                future, and for auto debit posting the date MUST
001000140425    ? *                be <= to the 7th.  (invoices run on the 7th)
001100140402    ? *  Written by:   Debora Bond
001200140402    ? *  Date Written: 04/02/2014
001300140402    ? *  Called from:  DW222CL
001400140402    ? *
001500140402    ? *  (c)Copyright 2009 by GBS, Inc.
001600140402    ? *  This document contains restricted materials of GBS,Inc.
001700140402    ? *
001800140402    ? *_________________________________________________________________________
001900140402    ? *  Modifications:
002000140402    ? *_________________________________________________________________________
002100140402     D work_date       s               d
002200140425     D days_diff       s              5  0
002300140402
002400140402     C     *entry        plist
002500140402     C                   parm                    achdate           8
002600140402     C                   parm                    autodebit         1
002700140402     C                   parm                    errormsg         75
002800140402
002900140402       //?------------------------------------------------------------------
003000140402    ?  // Mainline routine
003100140402       //?------------------------------------------------------------------
003200140402       clear errormsg ;
003300140402
003400140425       //?ensure posting date is a valid date, not in the past and not
003500140425       //?more than 3 days in the future.
003600140402       monitor ;
003700140402        work_date = %date(achdate:*usa0) ;
003800140425        days_diff = %diff(work_date:%date():*days) ;
003900140425
004000140425        if days_diff < -4 ;
004100140425         errormsg = 'Date entered too many days in the past.' ;
004200140425        elseif days_diff > 3 ;
004300140425         errormsg = 'Date entered too many days in the future.' ;
004400140425        elseif autodebit = 'Y' ;
004500140425         if work_date < %date() ;
004600140425          errormsg = 'Auto Debit Date cannot be in the past.' ;
004700140425         elseif %subdt(work_date:*d) > 07 ;
004800140425          errormsg = 'For Auto Debit posting - date must be prior to the 8th.';
004900140425         endif ;
005000140402        endif ;
005100140425
005200140402       on-error ;
005300140402        errormsg = 'Invalid Date' ;
005400140402       endmon ;
005500140402
005600140425       if errormsg = *blanks ;
005700140425        achdate = %char(work_date:*iso0) ;
005800140425       endif ;
005900140425
006000140402       *inlr = *on ;
006100140402       return ;
006200140425
