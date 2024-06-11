000100180423       Ctl-opt option(*noDebugIo)   DftActGrp(*no);
000200180423
000300180412      *------------------------------------------------------------------------
000400180411      *
000500180411      *  Description:
000600180411      *  Programmer.:  Brian Rees
000700180411      *  Date.......:  00/00/0000
000800180411      *
000900180412      *------------------------------------------------------------------------
001000180411
001100180412      *------------------------------------------------------------------------
001200180411      *
001300180411      * Declare Files
001400180411      *
001500180412      *------------------------------------------------------------------------
001600180411
001700180412       Dcl-f EmpDedExp keyed usage( *output : *update ) ;
001800180412       dcl-f Member    keyed ExtFile('F.MEMBER');
001900180430       dcl-f MemAlt    keyed;
002000180430       dcl-f McfXRef   keyed;
002100180412
002200180411
002300180412      *------------------------------------------------------------------------
002400180411      *
002500180412      *   Global Variables
002600180411      *
002700180412      *------------------------------------------------------------------------
002800180411
002900180412       dcl-s pTrst Zoned(3);
003000180412       dcl-s pSub Zoned(3);
003100180412       dcl-s pAcct Zoned(4);
003200180411
003300180412       dcl-s SqlStmt Char(1000);
003400180412       dcl-s wDate Date;
003500180430       dcl-s wCode Char(4) inz('MCF');
003600180430
003700180412
003800180412       dcl-ds sq_data;
003900180412          sqssn Zoned(9);
004000180412          sqPlan Char(4);
004100180423          sqPlnCode Char(20);
004200180423          sqEmpDed Zoned(6:2);
004300180423          sqEmrDed Zoned(6:2);
004400180412          sqAction Char(1);
004500180412       End-Ds;
004600180412
004700180420
004800180412      *------------------------------------------------------------------------
004900180411      *
005000180412      * Mainline Program
005100180411      *
005200180412      *------------------------------------------------------------------------
005300180411
005400180412       pTrst = 590;
005500180412       pSub = 1;
005600180412       pAcct = 43;
005700180411
005800180412
005900180412
006000180412       //------------------------------------------------------------------------
006100180412       //
006200180412       // Date Logic -
006300180412       //    This program was created for MacFadden / Costpoint. If other
006400180412       //    groups start requesting this, we will have to tweak this program
006500180412       //    to retrieve data from a database instead of inline calculations
006600180412       //
006700180412       //
006800180412       //  MacFadden Pay Period runs from Monday - Sunday ( Bi-weekly )
006900180412       //  They Requested that the data file is generated on Thursday.
007000180412       //  leaving 4 days within the current pay cycle.
007100180412       //
007200180412       //  The 4 days in the previous week would have to be ADDED to the
007300180412       //  current week.
007400180412       //
007500180412       //  The wDate ( Work Date ) will be the current Date ( Thursday ) and
007600180412       //  subtract 13 days. ( To pickup any files after the last run date )
007700180412       //
007800180412       //------------------------------------------------------------------------
007900180412
008000180412       wDate = %date() - %days(13);
008100180412
008200180412
008300180412
008400180412       SqlStmt =
008500180423          'Select edssn, edplan, EDPLNCODE, edempded, edemrded, edAction ' +
008600180412          ' From EmpDedp ' +
008700180412          ' Where edRunDate >= ' + %Char(%Dec( wDate )) +
008800180412          '  and edTrst = ' + %Char( pTrst ) +
008900180412          '  and edSub# = ' + %Char( pSub ) +
009000180423          '  and edAcct = ' + %Char( pAcct ) ;
009100180412
009200180412
009300180423       Exec Sql
009400180423          Declare C1 Cursor For Sqlstmt;
009500180412       Exec Sql
009600180423          Prepare Sqlstmt From :Sqlstmt;
009700180412       Exec Sql
009800180412          Open C1;
009900180412
010000180412       dou SqlCod <> *Zero;
010100180412          Exec Sql
010200180412             Fetch Next From C1 Into :Sq_Data;
010300180412
010400180412          if SqlCod <> *zero;
010500180412             Leave;
010600180412          endif;
010700180423
010800180423          if %trim(sqPlnCode) = '';
010900180423             iter;
011000180423          EndIf;
011100180423
011200180412
011300180412          chain sqssn Member;
011400180430          exEmpId = %Char( sqssn ) ;
011500180430
011600180430
011700180430          //-----------------------------
011800180430          //
011900180430          // Check Alt-ID
012000180430          //
012100180430          //-----------------------------
012200180430          chain ( sqssn : wCode ) MemAlt;
012300180430          if %Found( MemAlt ) ;
012400180430             exEmpId = maAltId;
012500180621          else;
012600180621             exEmpId = exEmpId;   /// for Debugging
012700180430          EndIf;
012800180430
012900180430
013000180412
013100180412          //-------------------------------------------
013200180412          //
013300180412          // Write to the Export File.
013400180412          //
013500180412          //-------------------------------------------
013600180412
013700180412          exDedCde = sqPlan;             // Deduction Cross Ref
013800180430          chain sqPlan McfXref;
013900180430          if %Found( mcfxref ) ;
014000180430             exDedCde = mxDed;
014100180430          EndIf;
014200180412
014300180430
014400180423          chain ( exEmpId :  sqPlnCode ) empDedExp;
014500180412
014600180412          if %Found( empDedExp ) ;
014700180412             exEmpDed = sqEmpDed + exEmpded;
014800180412             exEmrDed = sqEmrDed + exEmrDed;
014900180412             update r_empexp;
015000180430
015100180412          else;
015200180412
015300180412             exlname = mlname;
015400180412             exfname = mfname;
015500180423             exEmpDed = sqEmpDed;
015600180423             exdedcde = sqPlnCode;
015700180412             exEmrDed = sqEmrDed;
015800180412             exAction = sqAction;
015900180413
016000180423             if sqAction <> 'N';
016100180413                Write r_empexp;
016200180413             endif;
016300180412
016400180412          EndIf;
016500180412
016600180412
016700180412
016800180412       enddo;
016900180423
017000180423
017100180412       Exec Sql
017200180412          Close C1;
017300180412
017400180412       *inlr = *on;
