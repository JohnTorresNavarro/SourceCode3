000100210428
000200171229       Ctl-Opt option(*noDebugIo) bnddir('GBSBIND')  DftActGrp(*no)
000300171229          ActGrp(*New);
000400171227
000500171229      *-------------------------------------------------------------------------
000600171229      *
000700210428      *  Description: Renewal List
000800171229      *  Programmer.: Brian Rees
000900210428      *  Date.......: 04/28/2021
001000210428      *
001100210428      *  Ticket: INC0640095
001200210428      *
001300210428      *  User wanted an X4, but a program is better.
001400171229      *
001500171229      *-------------------------------------------------------------------------
001600161109
001700180228      *-------------------------------------------------------------------------
001800180228      *
001900180911      * Change Log
002000180228      *
002100210812      *-------------------------------------------------------------------------
002200210812      * Modifications
002300210812      *
002400210812      * 08/12/2021  B.Rees   Added EASE Group.
002500210924      * 09/24/2021  B.Rees   Added Broker EASE Subscription
002600180228      *-------------------------------------------------------------------------
002700171229
002800171229      *-------------------------------------------------------------------------
002900171229      *
003000171229      * Declare Files
003100171229      *
003200171229      *-------------------------------------------------------------------------
003300171229
003400171227
003500180911       Dcl-f Grat26 ExtDesc('F.GRAT26')  ExtFile(*extdesc) keyed;
003600171227       Dcl-f CMCT14 ExtDesc('F.CMCT14') ExtFile(*extdesc) keyed;
003700171227       Dcl-f SMan   ExtDesc('F.SMAN')   ExtFile(*extdesc) keyed;
003800171227       Dcl-f CarMst ExtDesc('F.CARMST') ExtFile(*extdesc) keyed;
003900171227       Dcl-f PlnMst ExtDesc('F.PLNMST') ExtFile(*extdesc) keyed;
004000171227       Dcl-f AccMst ExtDesc('F.ACCMST') ExtFile(*extdesc) keyed;
004100180111       Dcl-f Agency ExtDesc('F.AGENCY') ExtFile(*extdesc) keyed;
004200180111       Dcl-f SMANRLT ExtDesc('F.SMANRLT') ExtFile(*extdesc) keyed;
004300180111       Dcl-f SPRAGXR2 ExtDesc('F.SPRAGXR2') ExtFile(*extdesc) keyed;
004400210421       Dcl-f Carmksz1 ExtDesc('F.CARMKSZ1') ExtFile(*extdesc) keyed;
004500210421
004600210421       dcl-f TrkRnwl7 keyed;
004700210419       dcl-f gbs0071p  keyed usage(*Update : *Output ) ;
004800180626
004900161109
005000170420
005100171229      *-------------------------------------------------------------------------
005200171229      *
005300171229      * Global Variables
005400171229      *
005500171229      *-------------------------------------------------------------------------
005600210428       dcl-s today Zoned(8);
005700210428       dcl-s wMonth Zoned(2);
005800210812       dcl-s wGroup Char(20);
005900210812
006000180102      *-------------------------------------------------------------------------
006100171229      *
006200180102      * Mainline Program
006300171229      *
006400180102      *-------------------------------------------------------------------------
006500210415       today = %Dec(%Date);
006600210428       CalcRunMonth();
006700210419
006800210419
006900210419
007000210419       setll *loval  CmCt14;
007100210419       dou %Eof( CmCt14 ) ;
007200210419         read  CmCt14;
007300210419
007400210419         if %Eof( CmCt14 ) ;
007500210419           leave;
007600210419         endif;
007700210419
007800210419         if cmdltd = 'C';
007900210419           iter;
008000210419         EndIf;
008100210419
008200210419         if ( cmCan <= today and cmCan > 0 ) ;
008300210419           iter;
008400210419         EndIf;
008500210419
008600210419
008700210419         a8trst = cmTrst;
008800210419         a8Sub# = csubdv;
008900210419         a8Acct = cmAcct;
009000210419
009100210419         a8ActNam = '';
009200210419         chain ( a8Trst : a8Sub# : a8Acct ) AccMst;
009300210419         a8ActNam = acNam1;
009400210419
009500210419         a8Plan = cmPlan;
009600210419         a8RelID = cmRelId;
009700210429
009800210429         if acdltd = 'C';
009900210429           iter;
010000210429         EndIf;
010100210419
010200210419
010300210419         // Retrieve the Renewal Month
010400210419         a8RenMth = 0;
010500210419         chain ( a8Trst : a8Sub# : a8Plan ) PlnMst;
010600210419         if %Found( PlnMst );
010700210419           a8RenMth = Prenew;
010800210419           a8Desc = pDescr;
010900210419           a8PlnCat = PlnCat;
011000210428
011100210428           // Only load for 3 months out.
011200210428           if prenew <> wMonth;
011300210428             iter;
011400210428           EndIf;
011500210428
011600210419         endif;
011700210419
011800210428         a8MktSize = '';
011900210428         a8MktFr = 0;
012000210428         a8MktTo = 0;
012100210428
012200210421         chain ( a8Trst : a8Sub# : a8Acct: a8Plan ) Trkrnwl7;
012300210421         if %Found( TrkRnwl7 );
012400210421           if trpCarr in %List( 'EDT' : 'EVT' );
012500210421             iter;
012600210421           EndIf;
012700210421
012800210421           a8MktSize = trMktSize;
012900210428
013000210421           chain ( pCarr : trMktSize ) Carmksz1;
013100210421           if %Found ( CarMksz1 ) ;
013200210421             a8MktFr = CZFRSZ ;
013300210421             a8mktto = CZTOSZ ;
013400210428
013500210428
013600210421           EndIf;
013700210421
013800210421         EndIf;
013900210428
014000210428         // If Market Size is blank.. Just search by the carrier code.
014100210428         if a8MktSize = '';
014200210428
014300210428           Exec Sql
014400210428             select czszcd, czfrsz, cztosz
014500210428               into :a8MktSize, :a8MktFr, :a8mktto
014600210428               from "F.MKTCARA0"
014700210428                    join "F.CARMKSZ0"
014800210428                      on czcarr = macarr and
014900210428                        czszcd = maszcd
015000210428               Where maTrst = :a8Trst and
015100210428                     maSub# = :a8Sub# and
015200210428                     maAcc# = :a8Acct and
015300210428                     maCarr = :pCarr and
015400210428                     (matodt = 0 or
015500210428                       matodt >= :today);
015600210428
015700210428
015800210428         EndIf;
015900210428
016000210428         if a8MktFr > 50;
016100210428           iter;
016200210428         endif;
016300210419
016400210419         chain SlsMan sMan;
016500210419         a8smanfnam =  sfname;
016600210419         a8smanlnam =  slname;
016700210422         A8SlsCode = slsman;
016800210924         a8EaseSubs = bkEaseSubs;
016900210419
017000210419         chain ( a8Trst : a8Sub# : a8Plan ) Grat26;
017100210419         chain pCarr CarMst;
017200210419
017300210421
017400210421
017500210421         a8Group# = Group#;
017600210419         a8Carr = pCarr;
017700210419         a8CarrNam = cName;
017800210419
017900210419         chain a8Relid SmanRlt;
018000210419         chain srasid  spragxr2;
018100210419
018200210924
018300210419         // Agency
018400210419         chain sxagcy Agency;
018500210419         a8Agncy = sxAgcy;
018600210419         a8Agncyd = agnam1;
018700210419
018800210812         // Ease Group
018900210812         wGroup = %Editc(a8Trst : 'X' ) +
019000210812                  %Editc(a8Sub# : 'X' ) +
019100210812                  %Editc(a8Acct : 'X' );
019200210812
019300210812         a8Ease = '';
019400210812
019500210815         //------------------------------------------
019600210815         // SKip for Joseph Appelbaum. He has his own
019700210815         // Ease License.
019800210815         //------------------------------------------
019900210815
020000210815         if a8SlsCode <> 'PIB';
020100210815
020200210812         Exec Sql
020300210812           select ftEase
020400210812             into :a8Ease
020500210813           from GBS0030p where ftGroup = :wGroup
020600210813                and FTRCDSTS = 'A';
020700210812
020800210815
020900210815          endif;
021000210815
021100210815
021200210815
021300210812         // Check for Active Member
021400210419         a8MbrCnt = 0;
021500210428         Exec Sql
021600210428           Select Count(*)
021700210428             Into :a8MbrCnt
021800210428             From "F.MCOV"
021900210428             Where Mctrst = :a8trst And
022000210428                   Mcsub# = :a8sub# And
022100210428                   Acc# = :a8acct And
022200210428                   Mcplan = :a8Plan And
022300210428                   Candt = 0;
022400210419
022500210419         write r_gbs0071 ;
022600210419       enddo;
022700210419
022800210419
022900161109
023000210419       *inlr = *on;
023100161109
023200210428
023300210428
023400210428       // ----------------------------------------------------------------
023500210428       dcl-proc CalcRunMonth;
023600210428
023700210428         //----------------------------------------------------
023800210428         //
023900210428         //  The Run month should be 3 months after the current month.
024000210428         //
024100210428         //----------------------------------------------------
024200210428
024300210428
024400210428         wMonth = %Subdt(%Date:*M);
024500210428
024600210428         select;
024700210428         when wMonth < 10;
024800210428           wMonth = wMonth + 3;
024900210428         when wMonth = 10;
025000210428           wMonth = 1;
025100210428         when wMonth = 11;
025200210428           wMonth = 2;
025300210428         when wMonth = 12;
025400210428           wMonth = 3;
025500210428         EndSl;
025600210428
025700210428
025800210428       end-proc;
025900210428
026000210428
