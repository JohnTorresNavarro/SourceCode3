000100190517       Ctl-opt option(*noDebugIo)   DftActGrp(*no);
000200180718
000300180718      *-------------------------------------------------------------------------
000400180718      *
000500190607      *  Description: Broker / Account List
000600180718      *  Programmer.: Brian Rees
000700190607      *  Date.......: 06/07/2019
000800180723      *
000900180723      *
001000180718      *-------------------------------------------------------------------------
001100180718
001200180718      *-------------------------------------------------------------------------
001300180718      *
001400180718      * Declare Files
001500180718      *
001600180718      *-------------------------------------------------------------------------
001700190607       dcl-f GBS0058P usage(*Output );
001800201023       dcl-f GBS0058P2 usage(*Output );
001801201023
001900190607       Dcl-f SMan keyed ExtDesc('F.SMAN') ExtFile(*extdesc);
002000190607       Dcl-f ACCMST5 keyed ExtDesc('F.ACCMST5') ExtFile(*extdesc);
002001201026       Dcl-f ACCMST  keyed ExtDesc('F.ACCMST') ExtFile(*extdesc)
002002201026          rename( accmsr : Rcd1 );
002100190607       dcl-f aoecod keyed;
002200190607       dcl-f accospl2 keyed;
002300190610       dcl-f oereposl2 keyed;
002400201023       Dcl-f CMCT14 ExtDesc('F.CMCT14') ExtFile(*extdesc) keyed;
002401201023       Dcl-f PlnMst ExtDesc('F.PLNMST') ExtFile(*extdesc) keyed;
002500201029       dcl-f Ac2Mstl2 keyed;
002502201029
002600180718
002700180718      *-------------------------------------------------------------------------
002800180718      *
002900180718      * Global Variables
003000180718      *
003100180718      *-------------------------------------------------------------------------
003200190607       dcl-s sqlstmt Char(500);
003300190508
003400190508
003500190508
003600180718      *-------------------------------------------------------------------------
003700180718      *
003800180718      * Mainline Program
003900180718      *
004000180718      *-------------------------------------------------------------------------
004100190517
004200190607
004300190607       Setll *loval SMAN;
004400190607
004500190607       Dou %Eof(SMAN);
004600190607         read SMAN;
004700190607         if %eof(SMAN);
004800190607           leave;
004900190607         endif;
005000190607
005100190607         // Skip Termed Records
005200190607         if smdltd = 'D';
005300190607           iter;
005400190607         EndIf;
005500190607
005600190607         a8Code = smancd;
005700190607         a8Name = %trim(slname) + ', ' + %Trim( sfname );
005800190607
005900190607
005901201029
005902201029
006000190607         // Get Account List
006100201023         Account_List();
006200190607
006201201023         // Get Plans and Renewal
006202201023         Get_Plans();
006203201023
006204201023
006300190607       Enddo;
006400190607
006500190607
006600190530       *inlr = *on;
006700190607
006800190607
006900190607
007000190607
007100190607       // ----------------------------------------------------------------
007200190607       dcl-proc Account_List;
007300190607
007400190607         dcl-s library Char(10);
007500190607         dcl-s hasRec  Char(1);
007600190610         dcl-s wId     Char(40);
007601191119         dcl-s AgcAccCnt Zoned(9);
007700190607
007800190607         Setll smancd ACCMST5;
007900190607
008000190607         Dou %Eof(ACCMST5);
008100190607           reade smancd ACCMST5;
008200190607           if %eof(ACCMST5);
008300190607             leave;
008400190607           endif;
008500190607
008600190607           if  acdltd = 'C';
008700190607             iter;
008800190607           EndIf;
008900190607
009000190607
009100190607           A8TRST = actrst;
009200190607           A8SUB# = acSub#;
009300190607           A8ACCT = acAcct;
009400190607           A8ACTNAM = acNam1;
009500201026           a8Count = totEmp;
009600190607
009700190607           a8olecode = 0;
009800190607           a8oleDesc = '';
009900190607
009901201029           chain ( a8Trst : a8Sub# : a8Acct ) Ac2Mstl2;
009902201029           A8CODE1 = a2Code1;
009903201029           a8BrkName = '';
009904201029
009905201029           exec sql
009906201029             select trim(sfname) || ' ' || trim( slname)
009907201029           into :a8BrkName
009908201029           from "F.SMAN"
009909201029           where smancd = :a2Code1;
009910201029
009914201029
010000190607           chain ( actrst : acSub# : acAcct )  accospl2;
010100190607           if %Found( accospl2) ;
010200190610             if aoendt = 0 or aoendt >= %Dec(%date);
010300190607
010400190610               a8oleCode = aocode;
010500190607
010600190610               chain aoCode aoecod;
010700190610               a8oleDesc = aedesc;
010800190607
010900190610             EndIf;
011000190610           endif;
011100190607
011200190610           // Check the Repository to see if the broker is setup.
011300190607           a8bkracc = '';
011400190610           wId = sGrp;
011500190610           chain wId oereposl2;
011600190610           if %Found( oeReposl2 );
011601201023             if rGrid = 100119;   // OE Access
011700201023               a8bkracc = 'Broker Access';
011701200107             endif;
011702201023
011704201023             if rGrid = 100063 ;   // OE Access
011705201023               a8bkracc = 'Broker Access';
011706201023             endif;
011707201023
011708201023             if rGrid = 100167 ;   // OE Access
011709201023               a8bkracc = 'Agecny Access';
011710201023             endif;
011711201023
011712201023             if rGrid = 100067 ;   // OE Access
011713201023               a8bkracc = 'Agency Access';
011714201023             endif;
011715201023
011800190610           EndIf;
011900190610
012000190610
012100191119           // Agency Access.
012101201023           AgcAccCnt = 0;
012102191119
012103201029           exec sql
012104201029             Select count(*)
012105201029               into :agcAccCnt
012106201029               from oeReposp
012107201029               where RIDEN = trim(:Free15) and
012108201029                     rgrid = '100118';
012109191119
012110201023           if AgcAccCnt > 0;
012111201023             a8bkracc = 'Agency Access';
012112201023           EndIf;
012113191119
012114191119
012115191119
012200190607
012300190607           //----------------------------------------------------
012400190607           //
012500190607           //   if an ER Access only group, check the users who
012600190607           //   had made changes.
012700190607           //
012800190607           //----------------------------------------------------
012900190607           library = '';
013000190607           if aocode = 4 or aoCode = 6;
013100190607             Library = 'RPGSPPAYR';
013200190607           EndIf;
013300190607
013400190607           if aocode = 8;
013500190607             Library = 'RPGSPDASH';
013600190607           EndIf;
013700190607
013800190607
013900190607           hasRec = 'N';
014000190607           a8usage  = '';
014100190607
014200190607           if library > '';
014300190607             SqlStmt =
014400190607               'select distinct oecnfu from ' + Library + '/webtran ' +
014500190607               'where oetrst = ' + %Char( actrst ) +
014600190607               ' and  oeSub# = ' + %Char( acSub# ) +
014700190607               ' and oeAcct = '  + %Char( acAcct );
014800190607
014900201029             Exec Sql
015000201029               Declare c1 Cursor For sqlstmt;
015100201029             Exec Sql
015200201029               Prepare sqlstmt From :sqlstmt;
015300201029             Exec Sql
015400201029               Open c1;
015500190607
015600190607             dou SqlCod <> *Zero;
015700201029               Exec Sql
015800201029                 Fetch Next From c1
015801201029                   Into :a8usage;
015900190607
016000190607               if SqlCod <> *zero;
016100190607                 leave;
016200190607               endif;
016300190607
016400190607
016500190607               hasRec = 'Y';
016600190607               write r_gbs0058;
016700190607
016800190607             enddo;
016900201029             Exec Sql
017000201029               Close c1;
017100190607
017200190607
017300190607           endif;
017400190607
017500190607           if hasRec = 'N';
017600190607             write r_gbs0058;
017700190607           endif;
017800190607
017900190607         Enddo;
018000190607
018100190607
018200190607
018300190607       end-proc;
018301201023
018302201023
018303201023
018304201023       // ----------------------------------------------------------------
018305201023       dcl-proc Get_Plans;
018306201023
018313201023         setll ( a8Trst : a8Sub# : a8Acct ) CmCt14;
018314201023         dou %Eof( CmCt14 ) ;
018315201023           reade ( a8Trst : a8Sub# : a8Acct ) CmCt14;
018316201023
018317201023           if %Eof( CmCt14 ) ;
018318201023             leave;
018319201023           endif;
018320201023
018345201023
018346201023           if cmCan = 0 or cmCan >= %Dec(%Date);
018347201023
018348201023             a8Plan = cmPlan;
018362201023
018368201023             // Retrieve the Renewal Month
018369201023             a8Renewal = 0;
018370201023             chain ( a8Trst : a8Sub# : cmPlan ) PlnMst;
018371201023
018372201023             if %Found( PlnMst );
018373201023               a8Renewal = Prenew;
018374201023               a8Desc = PDESCR;
018375201023             endif;
018376201023
018377201026             a8Count = 0;
018378201026             chain ( a8Trst : a8Sub# : a8Acct ) AccMst;
018379201026             if %Found( accMst ) ;
018380201026               a8Count = totEmp;
018381201026             endif;
018382201026
018383201029
018384201029             chain ( a8Trst : a8Sub# : a8Acct ) Ac2Mstl2;
018385201029             A8CODE1 = a2Code1;
018386201029             a8BrkName = '';
018387201029
018388201029             exec sql
018389201029               select trim(sfname) || ' ' || trim( slname)
018390201029             into :a8BrkName
018391201029             from "F.SMAN"
018392201029             where smancd = :a2Code1;
018393201029
018394201029
018401201023             write R_GBS00582 ;
018402201023           EndIf;
018403201023
018404201023
018405201023         enddo;
018406201023
018407201023
018408201023
018409201023
018410201023       End-Proc;
018411201023
