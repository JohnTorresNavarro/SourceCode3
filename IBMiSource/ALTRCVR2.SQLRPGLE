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
002500161221     D AltType         s              4
002600190102     D onepos          s              1
002700150414
002800150501     D rcvFile       e ds                  extname(evgaltrcvf)
002900150413
003000190102      //=======================================================================
003100190102      // main process
003200190102      //=======================================================================
003300190102
003400150323       exsr init;
003500150323       exsr main;
003600150323       exsr exit;
003700150323
003800190102      //=======================================================================
003900190102      // main
004000190102      //=======================================================================
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
005800190102      //=======================================================================
005900190102      // prepare Statements
006000190102      //=======================================================================
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
007400190102      //=======================================================================
007500190102      // prepare Statement for SQL
007600190102      //=======================================================================
007700150326
007800150326       begsr prepareStatement;
007900150326
008000150501        selectFrom1 = 'select * from evgaltrcvf';
008100150326
008200160418        // whereClause1 = ' where altID like ''%-01%'' ' ;
008300150326       endsr;
008400150326
008500190102      //=======================================================================
008600190102      // prepare Sql
008700190102      //=======================================================================
008800150326
008900150326       begsr prepareSQL;
009000150326
009100150326        exec sql prepare stmt1 from :SqlStmt1;
009200150326        exec sql declare c1 cursor for stmt1;
009300150326        exec sql open c1;
009400150326
009500150326       endsr;
009600150326
009700190102      //=======================================================================
009800190102      // fetch Sql
009900190102      //=======================================================================
010000150326
010100150326       begsr fetchSql;
010200150326
010300150409        exec sql fetch c1 into :rcvFile;
010400150326
010500150326       endsr;
010600150326
010700190102      //=======================================================================
010800190102      // close Sql
010900190102      //=======================================================================
011000150326
011100150326       begsr closeSql;
011200150326
011300150326        exec Sql close c1;
011400150326
011500150326       endsr;
011600150326
011700190102      //=======================================================================
011800190102      // process
011900190102      //=======================================================================
012000150324
012100150326       begsr process;
012200150324
012300150429        // If record is found, write to error report...
012400161216        // Found, but not AltType write new record...
012500150429        // Not found, write new record...
012600150413
012700150429        // Record alredy exist... Write report and get the heck out!
012800161216        chain ( (%dec(%subst(ssn:1:9):9:0)) :AltType) altFile;
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
014100161216         if maalttp <> AltType;
014200150429          mamemid = %dec(ssn:9:0);
014300190102
014400181220           maaltid = %trim(altId);
014500190102           onepos = %subst(maaltid:1:1);
014600190102           if onepos = ' ';
014700190102            maaltid = %subst(maaltid:2:13);
014800190102           endif;
014900190102
015000161216            maalttp = AltType;
015100150429             malname = lname;
015200150429              mafname = fname;
015300150429             macrtdt = %dec(%date: *iso);
015400150429            write altFile;
015500150429         endif;
015600150429        endif;
015700150429
015800150429        // Record does not exist... write it...
015900150416        if not %found;
016000150417         mamemid = %dec(ssn:9:0);
016100190102
016200181220          maaltid = %trim(altId);
016300190102           onepos = %subst(maaltid:1:1);
016400190102           if onepos = ' ';
016500190102            maaltid = %subst(maaltid:2:13);
016600190102           endif;
016700190102
016800161216           maalttp = AltType;
016900150417            malname = lname;
017000150417           mafname = fname;
017100150417          macrtdt = %dec(%date: *iso);
017200150417         write altFile;
017300150416        endif;
017400150416
017500150326       endsr;
017600150324
017700190102      //=======================================================================
017800190102      // error report
017900190102      //=======================================================================
018000150416
018100150416       begsr errorReport;
018200150416
018300150428        errorF = %trim(altid) + ',' + %trim(maaltid) + ',' +
018400150416                 %trim(fname) + ',' +  %trim(lname) + ',' +
018500150416                 %trim(ssn);
018600150416
018700150416        write errorFile;
018800150416
018900150416       endsr;
019000150416
019100190102      //=======================================================================
019200190102      // exit
019300190102      //=======================================================================
019400150323
019500150323       begsr exit;
019600150323
019700150323        *inlr = *on;
019800150323        return;
019900150323
020000150323       endsr;
020100150323
020200190102      //=======================================================================
020300190102      // init
020400190102      //=======================================================================
020500150323
020600150323       begsr init;
020700161216
020800161216     c     *entry        plist
020900161216     c                   parm                    AltType
021000161216
021100161216
021200161216
021300161216
021400150416        // Write column headers on error file...
021500161216        errorF = %trim('Alt ID') + ',' + %trim('Alt File ID') + ',' +
021600150416                 %trim('First Name') + ',' + %trim('Last Name') + ',' +
021700150428                 %trim('SSN');
021800150416
021900150416        write errorFile;
022000190102
022100190102       endsr;
022200150323
022300190102      //=======================================================================
