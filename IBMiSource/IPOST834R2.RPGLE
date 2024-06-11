000100150424      * ------------------------------------------------------------------------------
000200000000      *  This code uses service program JDBCR4 referenced in binding directory JDBC
000300150424      *  ** Copied from Scott Klement
000400240118      *?
000500240118      *? IPOST834R2 - J.Allen  01.17.2024
000600150424      *
000700240118      * ?Example of Reading a Database via Select Where=Parm1
000800150424      * ------------------------------------------------------------------------------
000900000000     H DFTACTGRP(*NO) BNDDIR('JDBC')
001000000000
001100240117       dcl-f IPOSTCONP keyed usage( *input );
001200240117
001300000000      /copy qrpglesrc,jdbc_h
001400000000
001500240117     D IPOST834R2      PR                  extpgm('IPOST834R2')
001600000000     D    driver                    128A   const
001700000000     D    url                       128A   const
001800000000     D    database                   30A   const
001900000000     D    userid                     15A   const
002000000000     D    passwrd                    15A   const
002100230120     D    sql                       256A   const
002200240117     D    parm1                     128A   const
002300240117     D    rtn                         1A
002400150424
002500240117     D IPOST834R2      PI
002600000000     D    driver                    128A   const
002700000000     D    url                       128A   const
002800000000     D    database                   30A   const
002900000000     D    userid                     15A   const
003000000000     D    passwrd                    15A   const
003100000000     D    sql                       256A   const
003200240117     D    parm1                     128A   const
003300240117     D    rtn                         1A
003400000000
003500000000     D conn            s                   like(Connection)
003600000000     D ErrMsg          s             50A
003700000000     D wait            s              1A
003800000000     D idx             s             10I 0
003900000000     D colcnt          s             10I 0
004000000000     D rs              s                   like(ResultSet)
004100000000     D rsmd            s                   like(ResultSetMetaData)
004200000000     D Row1            s            132A
004300000000     D prop            s                   like(Properties)
004400230120     D xtrs            s              3s 0
004500230120     D xsub            s              3s 0
004600230120     D xact            s              4s 0
004700230120
004800000000      /free
004900000000         *inlr = *on;
005000000000
005100000000         prop = JDBC_Properties();
005200000000         JDBC_setProp(prop: 'User'    : %trim(userid));
005300000000         JDBC_setProp(prop: 'Password': %trim(passwrd));
005400000000         JDBC_setProp(prop: 'DatabaseName': %trim(database));
005500000000
005600000000         conn = JDBC_ConnProp( %trim(driver)
005700000000                             : %trim(url)
005800000000                             : prop );
005900000000         JDBC_freeProp(prop);
006000000000
006100000000         if (conn = *NULL);
006200000000             return;
006300000000         endif;
006400000000
006500150424
006600150424         //?Query the database
006700000000         rs = jdbc_ExecQry( conn
006800000000                          : %trim(sql)
006900000000                          );
007000000000         rsmd = jdbc_GetMetaData(rs);
007100000000         colcnt = jdbc_GetColCount(rsmd);
007200000000
007300150424
007400150424         //?Get column names
007500000000         idx = 1;
007600240117         Row1 = jdbc_getColName(rsmd: idx);
007700150424
007800240118         //?ROW will only have the col header in it not the data
007900240118         //?ROW will be blank if no matching record is found
008000240117         if   %trim(ROW1) = 'Origination';
008100240117         rtn = 'Y';
008200240117         else;
008300240117         rtn = 'N';
008400240117         endif;
008500230120
008600240117         // jdbc_freeResult(rs);
008700000000
008800000000         jdbc_close(conn);
008900000000         return;
009000000000      /end-free
009100000000
