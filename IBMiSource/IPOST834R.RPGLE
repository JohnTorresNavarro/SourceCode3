000100000000      *  This code uses service program JDBCR4 referenced in binding directory JDBC
000200000000      *
000300000000      *  To Compile:
000400000000      *     CRTBNDRPG JDBCTEST4 DBGVIEW(*LIST)
000500240117      *?
000600240117      *?IPOST834C - J.Allen  01.17.2024
000700240117      *?
000800240117      *?EXAMPLE:  This program will call a stored procedure on SQL Server
000900240117      *?passing in 6 parameters and writing to SQL Server database.
001000240117      *?
001100160113      *----------------------------------------------------------------------------
001200000000      *  Java data type numeric values
001300160113      *  VARCHAR     12          TIME        92
001400160113      *  INTEGER     4           TIMESTAMP   93
001500160113      *  SMALLINT    5           CHAR        1
001600160113      *  DECIMAL     3           DOUBLE      8
001700160113      *  BOOLEAN     16          BIGINT      -5
001800000000      *  DATE        91
001900160113      *----------------------------------------------------------------------------
002000000000     H DFTACTGRP(*NO) BNDDIR('JDBC')
002100230120
002200160113      *----------------------------------------------------------------------------
002300000000      /copy qrpglesrc,jdbc_h
002400000000
002500240117     D IPOST834R       PR                  extpgm('IPOST834R')
002600230119     D    driver                    128A   const
002700240117     D    url                       256A   const
002800230119     D    database                   30A   const
002900230119     D    userid                     15A   const
003000230119     D    passwrd                    15A   const
003100230119     D    sql                       256A   const
003200240117     D    parm1                     128A   const
003300240117     D    parm2                     128A   const
003400240117     D    parm3                     128A   const
003500240117     D    parm4                     128A   const
003600240117     D    parm5                     128A   const
003700240117     D    parm6                     128A   const
003800150424
003900240117     D IPOST834R       PI
004000230119     D    driver                    128A   const
004100240117     D    url                       256A   const
004200230119     D    database                   30A   const
004300230119     D    userid                     15A   const
004400230119     D    passwrd                    15A   const
004500230119     D    sql                       256A   const
004600240117     D    parm1                     128A   const
004700240117     D    parm2                     128A   const
004800240117     D    parm3                     128A   const
004900240117     D    parm4                     128A   const
005000240117     D    parm5                     128A   const
005100240117     D    parm6                     128A   const
005200000000
005300000000     D conn            s                   like(Connection)
005400000000     D ErrMsg          s             50A
005500000000     D wait            s              1A
005600000000     D idx             s             10I 0
005700000000     D rc              s              1N
005800000000     D Row1            s            132A
005900000000     D stmt            s                   like(CallableStatement)
006000000000     D prop            s                   like(Properties)
006100000000     D parm2UCS2       s             50C
006200000000
006300150424     D rs              s                   like(ResultSet)
006400150424     D rsmd            s                   like(ResultSetMetaData)
006500150424     D IsResultSet     s              1n
006600150424     D x               s             10i 0
006700230119     D msg             s             52a
006800230119     D wwDateC         s             10A
006900230119     D wwTimeC         s              8A
007000230119     D wwDateM         s             10A
007100230119     D wwTimeM         s              8A
007200230119     D time_taken      s             15p 0
007300230119
007400160113      *----------------------------------------------------------------------------
007500000000      /free
007600000000         *inlr = *on;
007700230119
007800230119         //?Java Properties
007900000000
008000000000         prop = JDBC_Properties();
008100000000         JDBC_setProp(prop: 'User'    : %trim(userid));
008200000000         JDBC_setProp(prop: 'Password': %trim(passwrd));
008300000000         JDBC_setProp(prop: 'DatabaseName': %trim(database));
008400000000
008500000000         conn = JDBC_ConnProp( %trim(driver)
008600000000                             : %trim(url)
008700000000                             : prop );
008800000000         JDBC_freeProp(prop);
008900000000
009000000000         if (conn = *NULL);
009100000000             return;
009200000000         endif;
009300000000
009400160113
009500160113         //?Prepare the stored-proc statement
009600000000         stmt = jdbc_PrepCall( conn
009700000000                             : %trim(sql)
009800000000                             );
009900000000
010000000000         if (stmt = *NULL);
010100000000             return;
010200000000         endif;
010300000000
010400240118         //?Set the SP paramaters
010500230119         jdbc_setString (stmt: 1: Parm1);
010600240117         jdbc_setString (stmt: 2: Parm2);
010700240117         jdbc_setString (stmt: 3: Parm3);
010800240117         jdbc_setString (stmt: 4: Parm4);
010900240117         jdbc_setString (stmt: 5: Parm5);
011000240117         jdbc_setString (stmt: 6: Parm6);
011100150424
011200150424         IsResultSet = JDBC_execCall( stmt );
011300160113
011400150424         dow IsResultSet;
011500150424             rs = JDBC_getResultSet( stmt );
011600150424             rsmd = JDBC_getMetaData(rs);
011700150424
011800150424             dow JDBC_nextRow(rs);
011900150424                for x = 1 to JDBC_getColCount(rsmd);
012000150424                   msg = JDBC_getColName(rsmd: x)
012100150424                       + '='
012200150424                       + JDBC_getCol(rs: x);
012300230119
012400150424                endfor;
012500150424             enddo;
012600150424
012700150424             IsResultSet = JDBC_getMoreResults( stmt );
012800150424         enddo;
012900230119
013000150424         JDBC_FreeCAllStmt(stmt);
013100150424
013200000000
013300000000         jdbc_close(conn);
013400000000         return;
013500000000      /end-free
