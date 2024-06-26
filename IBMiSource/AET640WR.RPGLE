000100150415      *=============================================================================================
000200150415     H DFTACTGRP(*NO)
000300150415      *=============================================================================================
000400150415
000500150415     Facmunique if   e           k disk    rename(accmsr:acctFile)
000600150415      * Account master by Trust, Sub#, Account...
000700150415
000800150415     Fcarplnp   if a e           k disk    rename(carplnr:planFile)
000900150417      * Account master by Unique field, Trust, Sub#, Account...
001000150415
001100150417     Fcaraccp   if   e           k disk    rename(caraccr:carEFile)
001200150417      * Carrier Export Control By Unique field, Trust, Sub#, Account...
001300150417
001400150513     Faet004wf  if a e           k disk    rename(aef04:methodFile)
001500150415      * Method mapping by Trust, Sub#, Account, Plan...
001600150415
001700150415     Faet640wd  cf   e             workstn infds(wsds)
001800150415      * Display file...
001900150415
002000150415      *=============================================================================================
002100150415      * Standalone fields and data sructures
002200150415      *=============================================================================================
002300150415
002400991216     D WSDS            DS
002500991216     D  FKEY                 369    369A
002600150415
002700991216     D  F1             C                   CONST(X'31')
002800991216     D  F2             C                   CONST(X'32')
002900991216     D  F3             C                   CONST(X'33')
003000991216     D  F4             C                   CONST(X'34')
003100991216     D  F5             C                   CONST(X'35')
003200991216     D  F6             C                   CONST(X'36')
003300991216     D  F7             C                   CONST(X'37')
003400991216     D  F8             C                   CONST(X'38')
003500991216     D  F9             C                   CONST(X'39')
003600991216     D  F10            C                   CONST(X'3A')
003700991216     D  F11            C                   CONST(X'3B')
003800991216     D  F12            C                   CONST(X'3C')
003900991216     D  F13            C                   CONST(X'B1')
004000991216     D  F14            C                   CONST(X'B2')
004100991216     D  F15            C                   CONST(X'B3')
004200991216     D  F16            C                   CONST(X'B4')
004300991216     D  F17            C                   CONST(X'B5')
004400991216     D  F18            C                   CONST(X'B6')
004500991216     D  F19            C                   CONST(X'B7')
004600991216     D  F20            C                   CONST(X'B8')
004700991216     D  F21            C                   CONST(X'B9')
004800991216     D  F22            C                   CONST(X'BA')
004900991216     D  F23            C                   CONST(X'BB')
005000991216     D  F24            C                   CONST(X'BC')
005100150415     D  ENTER          C                   Const(X'F1')
005200150415
005300150415     D unique          s             10a   INZ('0000000127')
005400150415
005500150415     D aet640wr        pi
005600150415     d  p_trust                       3  0 const
005700150415     d  p_sub#                        3  0 const
005800150415     d  p_acct                        4  0 const
005900150415
006000150415      *=============================================================================================
006100150415      * Mainline
006200150415      *=============================================================================================
006300150415    *
006400150415       exsr init;
006500150415       exsr main;
006600150415       exsr exit;
006700150415
006800150415      *=============================================================================================
006900150415
007000150415       begsr main;
007100150415
007200150415        dow fkey <> f3;
007300150415
007400150415        write popmsg;
007500150415         write dummy;
007600150415         exfmt popmsg;
007700150415
007800150415         select;
007900150415          when fkey = enter;
008000150415           exsr vldchk;
008100150415          when fkey = f3;
008200150415           exsr dumb;
008300150415          other;
008400150415           exsr invalidKey;
008500150415         endsl;
008600150415
008700150415        enddo;
008800150415
008900150415       endsr;
009000150415
009100150415       //===========================================================================================
009200150415       // invalid key pressed
009300150415       //===========================================================================================
009400150415
009500150415       begsr invalidKey;
009600150415
009700150415        emsg = 'Invalid command key pressed';
009800150415
009900150415       endsr;
010000150415
010100150415       //===========================================================================================
010200150415       // dummy - do nothing
010300150415       //===========================================================================================
010400150415
010500150415       begsr dumb;
010600150415
010700150415       endsr;
010800150415
010900150415       //===========================================================================================
011000150415       // vldchk - validity checking
011100150415       //===========================================================================================
011200150415
011300150415       begsr vldchk;
011400150415
011500150415        emsg = ' ';
011600150415
011700150417        // See if 'From and To' Trust, Sub# and Account are the same...
011800150417        if ftrust = ttrust and fsub# = tsub# and facct = tacct;
011900150417         emsg = 'From and To Accounts cannot be the same';
012000150417         leavesr;
012100150417        endif;
012200150417
012300150417        // Look to see if record exist in caraccp file...
012400150417        chain (unique : ttrust : tsub# : tacct) carEFile;
012500150417        if not %found;
012600150417         emsg = 'Please add Account record first';
012700150417         leavesr;
012800150417        endif;
012900150417
013000150415        // Look to see if records were already copied to this acct...
013100150415        chain (unique : ttrust : tsub# : tacct) planFile;
013200150415        if %found;
013300150415         emsg = 'Plans already exist for this Account';
013400150415         leavesr;
013500150415        endif;
013600150415
013700150415        // Look for valid record...
013800150415        chain (ttrust : tsub# : tacct) acctFile;
013900150415        if not %found;
014000150415         emsg = 'Trust/Sub/Account not found';
014100150415          leavesr;
014200150415        else;
014300150415          exsr copyRecords;
014400150415         leavesr;
014500150415        endif;
014600150415
014700150415       endsr;
014800150415
014900150415       //===========================================================================================
015000150415       // Exit subroutine
015100150415       //===========================================================================================
015200150415
015300150415       begsr copyRecords;
015400150415
015500150415       setll (unique : ftrust : fsub# : facct) planFile;
015600150415       reade (unique : ftrust : fsub# : facct) planFile;
015700150415
015800150415       dow not(%eof);
015900150415
016000150415        cpuniq = unique;
016100150415        cptrst = ttrust;
016200150415        cpsub# = tsub#;
016300150415        cpacct = tacct;
016400150415
016500150415        write planFile;
016600150415
016700150415       reade (unique : ftrust : fsub# : facct) planFile;
016800150415       enddo;
016900150415
017000150415       setll (ftrust : fsub# : facct) methodFile;
017100150415       reade (ftrust : fsub# : facct) methodFile;
017200150415
017300150415       dow not(%eof);
017400150415
017500150513        ae4trs = ttrust;
017600150513        ae4sub = tsub#;
017700150513        ae4acc = tacct;
017800150415
017900150415        write methodFile;
018000150415
018100150415       reade (ftrust : fsub# : facct) methodFile;
018200150415       enddo;
018300150415
018400150415       emsg = 'Records have been copied';
018500150415
018600150415       endsr;
018700150415
018800150415       //===========================================================================================
018900150415       // Exit subroutine
019000150415       //===========================================================================================
019100150415
019200150415       begsr exit;
019300150415
019400150415        *inlr = *on;
019500150415        return;
019600150415
019700150415       endsr;
019800150415
019900150415       //===========================================================================================
020000150415       // Init subroutine
020100150415       //===========================================================================================
020200150415
020300150415       begsr init;
020400150415
020500150415       // In Parms...
020600150415        ftrust = p_trust;
020700150415        fsub# = p_sub#;
020800150415        facct = p_acct;
020900150415
021000150415       // Error msg...
021100150415        emsg = ' ';
021200150415
021300150415       endsr;
021400150415
