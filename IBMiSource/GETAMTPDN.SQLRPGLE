000100180326      *=========================================================================
000200180326     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300180326      *=========================================================================
000400230707      * GETAMTPD = Get Amount Paid
000500191209      *=========================================================================
000600180326      * Date         Int  Description
000700230427      * ----------   ---  ------------------------------------------------------
000800230707      * 07/06/2023   jt   Original Creation
000900191209      *=========================================================================
000901230814
004003230814     frpayhisl1 if   e           k disk    rename(rpayhisr:payhis)
004004230814
004308230707       dcl-s SqlStmt char(500);
004309230707       dcl-s SqlStmt2 char(500);
004310230707       dcl-s date zoned(8);
004311230814       dcl-s date2 zoned(8);
004312230706
004313230707       dcl-c q '''';
007407221206
007408230814     d abrcode         s              1
007409230814     d abrcd           s              1
007410230814     d dateISO         s               d
007411230814     d dateISO2        s               d
007412230814     d ntrust          s              3  0
007413230814     d nsub            s              3  0
007414230814     d nacct           s              4  0
007415230814
007416230814     d getamtpdn       pi
007417230707     d  inTrust                       3
007418230707     d  inSub                         3
007419230707     d  inAcct                        4
007420230707     d  inInv#                        7
007421230707     d  inCarrierCD                   3
007422230707     d  outDate                       8
007423230707     d  outAmt                       11  2
007424230814     d  pOvr                        100
007425230706
007500170829      //========================================================================
007600180320      // mainline
007700180320      //========================================================================
007800170829
007801230706       Exec Sql
007802230706        Set Option Commit = *None, Naming = *Sys;
007808230706
007809230814       SqlStmt = 'Select idpaid from "F.INVDET" ' +
007810230707                 'where idtrst = ' + intrust +
007811230707                 ' and idsubd = ' + insub + ' and idacct = ' + inacct +
007812230707                 ' and idcar = ' + q + incarriercd + q + ' +
007813230707                 and idinv# = ' + inInv# + ' and idpaid <> 0';
007814230707
007815230707       Exec Sql
007816230707        Declare c1 Cursor For sqlstmt;
007817230707
007818230707       Exec Sql
007820230707        Prepare sqlstmt From :sqlstmt;
007821230707
007822230707       Exec Sql
007823230707        Open c1;
007824230707
007825230707       outDate = ' ';
007826230707       date = 0;
007827230707
007828230707       Exec Sql
007829230814       Fetch Next From c1 Into :date;
007830230814
007831230707
007832230707        outDate = %char(date);
007833230814        if date > 0;
007834230814         dateISO = %date(date);
007835230814        else;
007836230814         dateISO = d'0001-01-01';
007837230814        endif;
007838230814
007839230814        ntrust = %dec(intrust:3:0);
007840230814        nsub = %dec(insub:3:0);
007841230814        nacct = %dec(inacct:4:0);
007842230707
007843230707       Exec Sql
007844230707        Close C1;
007845230707
007846230707       SqlStmt = 'Select sum(idtram) from "F.INVDET" ' +
007847230707                 'where idtrst = ' + intrust +
007848230707                 ' and idsubd = ' + insub + ' and idacct = ' + inacct +
007849230707                 ' and idcar = ' + q + incarriercd + q + ' +
007850230707                 and idinv# = ' + inInv# + ' and idpaid <> 0';
007851230707
007852230707       Exec Sql
007853230707        Prepare sqlstmt From :sqlstmt;
007854230707
007855230707       Exec Sql
007856230707        Open c1;
007857230707
007858230707       outAmt = 0;
007859230707
007860230707       Exec Sql
007861230707        Fetch Next From c1 Into :outAmt;
007862230707
007863230707       Exec Sql
007864230707        Close C1;
007865230814
007866230814        pOvr = ' ';
007867230814        setll (ntrust:nsub:nacct:inCarrierCD:dateISO) payhis;
007868230814        reade (ntrust:nsub:nacct:inCarrierCD:dateISO) payhis;
007869230814        dow not %eof;
007870230814         select;
007871230814          when rypayovr = '1';
007872230814           pOvr = rypayovr + '-' +'Canceled acct with zero or credit balance';
007873230814           leave;
007874230814
007875230814          when rypayovr = '2';
007876230814           pOvr = rypayovr + '-' + 'Credit ending balance (invoice)';
007877230814           leave;
007878230814
007879230814          when rypayovr = '3';
007880230814           pOvr = rypayovr + '-' + 'Missing invoice-Credit account balance';
007881230814           leave;
007882230814
007883230814          when rypayovr = '4';
007884230814           pOvr = rypayovr + '-' + 'Miss. inv-Paym. for eff date of bill run';
007885230814           leave;
007886230814
007887230814          when rypayovr = '5';
007888230814           pOvr = rypayovr + '-' + 'Paym. on inv reduced ending balance due';
007889230814           leave;
007890230814
007891230814          when rypayovr = '6';
007892230814           pOvr = rypayovr + '-' + 'A later invoice month is paid';
007893230814           leave;
007894230814         endsl;
007895230814
007896230814        reade (ntrust:nsub:nacct:inCarrierCD:dateISO) payhis;
007897230814        enddo;
007898230707
063837230706       return;
064200170829
064345200313      //========================================================================
