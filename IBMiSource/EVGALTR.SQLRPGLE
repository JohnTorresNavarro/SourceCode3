000100150326      *========================================================================
000200150323
000300150326      * Description:  Update Member Alternate ID
000400150323
000500150326      * (c)Copyright 2015 by GBS Inc.
000600150326      * This document contains restricted materials of GBS, Inc.
000700150326
000800150326      *   Created by:  J. Torres - March 26, 2015
000900150326      *========================================================================
001000150323
001100150416     Fmemaltl3  uf a e           k disk
001200150324      * Member Alternate ID by Soc Sec. Num./type
001300150324     F                                     rename(memaltr:altFile)
001400150323
001500150501     Fevgaltste if a e             disk
001600150326      * Member Alternate error file
001700150326     F                                     rename(memaltstr:errorFile)
001800150326
001900150326      *========================================================================
002000150326
002100150326     D SqlStmt1        s           3000a   varying
002200150326     D selectFrom1     s            100    varying
002300150326     D whereClause1    s           1000    varying
002400150326     D orderBy         s           1000    varying
002500150414
002600150501     D rcvFile       e ds                  extname(evgaltrcvf)
002700150416
002800150326      *========================================================================
002900150413
003000150413       //===================
003100150413       // main process
003200150413       //===================
003300150323
003400150323       exsr init;
003500150323       exsr main;
003600150323       exsr exit;
003700150323
003800150324       //===================
003900150323       // main subr
004000150324       //===================
004100150323
004200150323       begsr main;
004300150324
004400150326        exsr prepareStatements;
004500150326        exsr fetchSql;
004600150326
004700150326        dow sqlcod = 0;
004800150326
004900150326         exsr process;
005000150330
005100150330         exsr fetchSql;
005200150324        enddo;
005300150324
005400150326        exsr closeSQL;
005500150326
005600150323       endsr;
005700150323
005800150326       //===================
005900150326       // Prepare Statements
006000150326       //===================
006100150326
006200150326       begsr prepareStatements;
006300150326
006400150326        exsr prepareStatement;
006500150326
006600150326        SqlStmt1 =
006700150326         %trim(SelectFrom1) + ' ' +
006800150326         %trim(whereClause1);
006900150326
007000150326        exsr prepareSql;
007100150326
007200150326       endsr;
007300150326
007400150326       //===================
007500150326       //Prepare Statement for SQL
007600150326       //===================
007700150326
007800150326       begsr prepareStatement;
007900150326
008000150501        selectFrom1 = 'select * from evgaltrcvf';
008100150326
008200160418        // whereClause1 = ' where altID like ''%-01%'' ' ;
008300150326       endsr;
008400150326
008500150326       //===================
008600150326       // prepareSql
008700150326       //===================
008800150326
008900150326       begsr prepareSQL;
009000150326
009100150326        exec sql prepare stmt1 from :SqlStmt1;
009200150326        exec sql declare c1 cursor for stmt1;
009300150326        exec sql open c1;
009400150326
009500150326       endsr;
009600150326
009700150326       //===================
009800150326       // fetchSql
009900150326       //===================
010000150326
010100150326       begsr fetchSql;
010200150326
010300150409        exec sql fetch c1 into :rcvFile;
010400150326
010500150326       endsr;
010600150326
010700150326       //===================
010800150326       // closeSql
010900150326       //===================
011000150326
011100150326       begsr closeSql;
011200150326
011300150326        exec Sql close c1;
011400150326
011500150326       endsr;
011600150326
011700150324       //===================
011800150324       // process subr
011900150324       //===================
012000150324
012100150326       begsr process;
012200150324
012300150429        // If record is found, write to error report...
012400150429        // Found, but not EV, write new record...
012500150429        // Not found, write new record...
012600150413
012700150429        // Record alredy exist... Write report and get the heck out!
012800161216        chain ( (%dec(%subst(ssn:1:9):9:0)) :'CI') altFile;
012900150430
013000150416        if %found;
013100150430         if maaltid <> altid;
013200150429          exsr errorReport;
013300150430          leavesr;
013400150430         endif;
013500150430         leavesr;
013600150416        endif;
013700150416
013800150429        // Record alredy exist... but it is not a EV record...
013900150429        chain ( (%dec(%subst(ssn:1:9):9:0)) ) altFile;
014000150429        if %found;
014100161216         if maalttp <> 'CI';
014200150429          mamemid = %dec(ssn:9:0);
014300150429           maaltid = altId;
014400161216            maalttp = 'CI';
014500150429             malname = lname;
014600150429              mafname = fname;
014700150429             macrtdt = %dec(%date: *iso);
014800150429            write altFile;
014900150429         endif;
015000150429        endif;
015100150429
015200150429        // Record does not exist... write it...
015300150416        if not %found;
015400150417         mamemid = %dec(ssn:9:0);
015500150417          maaltid = altId;
015600161216           maalttp = 'CI';
015700150417            malname = lname;
015800150417           mafname = fname;
015900150417          macrtdt = %dec(%date: *iso);
016000150417         write altFile;
016100150416        endif;
016200150416
016300150326       endsr;
016400150324
016500150416       //===================
016600150416       // errorReport subr
016700150416       //===================
016800150416
016900150416       begsr errorReport;
017000150416
017100150428        errorF = %trim(altid) + ',' + %trim(maaltid) + ',' +
017200150416                 %trim(fname) + ',' +  %trim(lname) + ',' +
017300150416                 %trim(ssn);
017400150416
017500150416        write errorFile;
017600150416
017700150416       endsr;
017800150416
017900150324       //===================
018000150324       // exit subr
018100150324       //===================
018200150323
018300150323       begsr exit;
018400150323
018500150323        *inlr = *on;
018600150323        return;
018700150323
018800150323       endsr;
018900150323
019000150324       //===================
019100150323       // init subr
019200150324       //===================
019300150323
019400150323       begsr init;
019500150416
019600150416        // Write column headers on error file...
019700161216        errorF = %trim('CI ID') + ',' + %trim('Alt File ID') + ',' +
019800150416                 %trim('First Name') + ',' + %trim('Last Name') + ',' +
019900150428                 %trim('SSN');
020000150416
020100150416        write errorFile;
020200150323
020300150323       endsr;
020400150323
020500150413       //===================
