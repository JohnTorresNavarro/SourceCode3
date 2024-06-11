000100180103
000200180103       Ctl-Opt Option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no);
000300180103
000400000000      *-------------------------------------------------------------------------
000500000000      *
000600181001      *  Description: Account Installation Menu
000700170526      *  Programmer.: B.Rees
000800190815      *  Date.......: 10/01/2018
000900000000      *
001000000000      *-------------------------------------------------------------------------
001100190815
001200190815      * 08/15/2019 - jt - Changed to call to new procedure (UTL130CLB).
001300190827
001400190827      * 08/27/2019 - ja - Changed to call to new procedure (PRTWLT01R).
001500191003      * 10/03/2019 - B.Rees - Added Broker Plus
001501201218      * 12/18/2020 - B.Rees - Added Batch Load the Enrollment Date
001600220819      * 06/02/2022 - jt - Changed to use new Plan Maintenace
001601220819      * 08/19/2022 - jt - Changed option 7 (Declining Benefit Rates) to
001602220819      *                   use new PL program.
001700180103      *-------------------------------------------------------------------------
001800180103      *
001900180103      * Declare Files
002000180103      *
002100180103      *-------------------------------------------------------------------------
002200181001       Dcl-f GBS0046D WorkStn
002300180105          HANDLER('PROFOUNDUI(HANDLER)');
002400180103
002500180103
002600180103
002700180103
002800180103      *-------------------------------------------------------------------------
002900180103      *
003000180103      * Global Variables
003100180103      *
003200180103      *-------------------------------------------------------------------------
003300180105       dcl-s Library Char(10);
003301220907       dcl-s mode Char(1);
003400180105
003500180105
003600180105
003700180105
003800180103
003900180103      *-------------------------------------------------------------------------
004000180103      *
004100180103      * Procedures
004200180103      *
004300180103      *-------------------------------------------------------------------------
004400181001       Dcl-Pr INQ001C  Extpgm('INQ001C')  End-Pr;
004500220602       Dcl-Pr FM031CL  Extpgm('FM031CL')  End-Pr;
004600181001       Dcl-Pr FM040CL  Extpgm('FM040CL')  End-Pr;
004700190814       Dcl-Pr UTL130CLB Extpgm('UTL130CLB') End-Pr;
004800181001       Dcl-Pr UTL200CL Extpgm('UTL200CL') End-Pr;
004900181001       Dcl-Pr FM060CL  Extpgm('FM060CL')  End-Pr;
005000181001
005100220907       Dcl-Pr FM050R1  Extpgm('FM050R1');
005101220907              mode Char(1);
005102220907              End-Pr;
005200181001       Dcl-Pr WRKNOTCL Extpgm('WRKNOTCL') End-Pr;
005300181001
005400181001       Dcl-Pr FM070CL  Extpgm('FM070CL')  End-Pr;
005500181001       Dcl-Pr TR100CL  Extpgm('TR100CL')  End-Pr;
005600181001       Dcl-Pr WRK100CL Extpgm('WRK100CL') End-Pr;
005700181001       Dcl-Pr WRKMLTCL Extpgm('WRKMLTCL') End-Pr;
005800181001       Dcl-Pr UTL170CL Extpgm('UTL170CL') End-Pr;
005900181001       Dcl-Pr TR050CL  Extpgm('TR050CL')  End-Pr;
006000181001
006100181001       Dcl-Pr GBS0040C1  Extpgm('GBS0040C1')  End-Pr;
006200181001       Dcl-Pr TR060CL    Extpgm('TR060CL')    End-Pr;
006300181001       Dcl-Pr RP010CL    Extpgm('RP010CL')    End-Pr;
006400180105
006500190715       Dcl-Pr FM360CL    Extpgm('FM360CL')    End-Pr;
006600190715       Dcl-Pr WRKSMICL   Extpgm('WRKSMICL')   End-Pr;
006700190715       Dcl-Pr FM170CL    Extpgm('FM170CL')    End-Pr;
006800181001
006900190827       Dcl-Pr PRTWLT01C  Extpgm('PRTWLT01C')  End-Pr;
007000191003       Dcl-Pr BRKPLUSC   Extpgm('BRKPLUSC')  End-Pr;
007001200121       Dcl-Pr CENSUS1C   Extpgm('CENSUS1C')  End-Pr;
007002201218       Dcl-Pr GBS0066C   Extpgm('GBS0066C')  End-Pr;
007100181001
007200201020      /include GBSPGM/QMODSRC,#CommandPr
007201201020
007300000000      *-------------------------------------------------------------------------
007400180103      *
007500000000      * Mainline Program
007600180103      *
007700000000      *-------------------------------------------------------------------------
007800000000
007900180105       //------------------------------
008000180105       // Get the Environment
008100180105       //------------------------------
008200201020       Exec Sql
008300201020         Select Objlo00002
008400201020           Into :Library
008500201020           From
008600201020             Table (
008700201020               Qsys2.Object_Statistics(
008701201020                 '*LIBL', 'FILE', Object_Name => '"F.ACCMST"')
008702201020             ) As X;
008800180105
008900180105
009000180105       S1Envir = '** Unknown **';
009100180105       if Library = 'GBSDTAT';
009200201020         S1Envir = 'Development';
009300201020       EndIf;
009400180105
009500180105       if Library = 'QS36F';
009600201020         S1Envir = 'Production';
009700180105       EndIf;
009800180105
009900180105
010000180105
010100180105
010200180105       //------------------------------
010300180105       // Display Screen
010400180105       //------------------------------
010500180103       Dou btnExit = *on;
010600181001
010700201020         s1Opt = 0;
010800201020         Exfmt Screen1;
010900180105
011000180105
011100181001
011200201020         if btnExit = *on;
011300201020           leave;
011400201020         EndIf;
011500181001
011600181001
011700201020         Select;
011800181001
011900181001
012000201020         //----------------------------------------------------
012100201020         //
012200201020         //  Account Setup
012300201020         //
012400201020         //----------------------------------------------------
012500181001
012600201020         // Member/ Account Inquiry
012700201020         When Opt_01 = *on or s1Opt = 1;
012800201020           INQ001C();
012900181001
013000181001
013100201020         // Plan Master File
013200201020         When Opt_02 = *on or s1Opt = 2;
013300220602           FM031CL();
013400181001
013500181001
013600201020         // Group Rates File
013700201020         When Opt_03 = *on or s1Opt = 3;
013800201020           FM040CL();
013900181001
014000181001
014100201020         // Plan Copy
014200201020         When Opt_04 = *on or s1Opt = 4;
014300201020           UTL130CLB();
014400181001
014500181001
014600201020         // Plan Rate Copy
014700201020         When Opt_05 = *on or s1Opt = 5;
014800201020           UTL200CL();
014900181001
015000181001
015100201020         // Account Master File Maintenance
015200201020         When Opt_06 = *on or s1Opt = 6;
015300201020           FM060CL();
015400181001
015500181001
015600201020         //----------------------------------------------------
015700201020         //
015800201020         //  Account Setup ( Life Options Only )
015900201020         //
016000201020         //----------------------------------------------------
016100181001
016200181001
016300201020         // Declining Benefit Rates
016400201020         When Opt_07 = *on or s1Opt = 7;
016401220907           mode = 'M';
016500220907           FM050R1(mode);
016600181001
016700181001
016800201020         // Consolidated Life Plans ( OE )
016900201020         When Opt_08 = *on or s1Opt = 8;
017000201020           WRKNOTCL();
017100181001
017200181001
017300181001
017400201020         //----------------------------------------------------
017500201020         //
017600201020         //  Enrollment
017700201020         //
017800201020         //----------------------------------------------------
017900181001
018000181001
018100201020         // Enrollment Entry
018200201020         When Opt_09 = *on or s1Opt = 9;
018300201020           FM070CL();
018400181001
018500181001
018600201020         // Account Transfer/ Member Transfer
018700201020         When Opt_10 = *on or s1Opt = 10;
018800201020           TR100CL();
018900181001
019000181001
019100201020         // Work with Longer Names
019200201020         When Opt_11 = *on or s1Opt = 11;
019300201020           WRK100CL();
019400181001
019500181001
019600201020         // Member Alternate ID Maint
019700201020         When Opt_12 = *on or s1Opt = 12;
019800201020           WRKMLTCL();
019900181001
020000181001
020100201020         // Mass Plan Additions
020200201020         When Opt_13 = *on or s1Opt = 13;
020300201020           UTL170CL();
020400181001
020500181001
020600201020         // Account Plan Change
020700201020         When Opt_14 = *on or s1Opt = 14;
020800201020           TR050CL();
020900181001
021000181001
021100201020         // Download Maintenance Screen
021200201020         When Opt_18 = *on or s1Opt = 18;
021300201020           fm360CL();
021400190715
021500190715
021600201020         // Retreive SMAN Relationship ID
021700201020         When Opt_19 = *on or s1Opt = 19;
021800201020           wrksmicl();
021900190715
022000190715
022100201020         // Pull List
022200201020         When Opt_20 = *on or s1Opt = 20;
022300201020           fm170cl();
022400190715
022500201020         // Print welcome to group letters
022600201020         When Opt_21 = *on or s1Opt = 21;
022700201020           PRTWLT01C();
022800190827
022801201020         // Run Census Uploadp letters
022802201020         When Opt_23 = *on or s1Opt = 23;
022803201020           Census1c();
022804200121
022805201218         // Run Census Uploadp letters
022806201218         When Opt_25 = *on or s1Opt = 25;
022807201218           GBS0066C();
022808201218
022900190715
023000201020         //----------------------------------------------------
023100201020         //
023200201020         //  Noting and Reporting Options
023300201020         //
023400201020         //----------------------------------------------------
023500181001
023600181001
023700201020         // Account/Member Diary Notes - Batch
023800201020         When Opt_15 = *on or s1Opt = 15;
023900201020           GBS0040C1();
024000181001
024100181001
024200201020         // Premium Calculation
024300201020         When Opt_16 = *on or s1Opt = 16;
024400201020           TR060CL();
024500181001
024600181001
024700201020         // Member List by Account
024800201020         When Opt_17 = *on or s1Opt = 17;
024900201020           RP010CL();
025000181001
025100191003
025200201020         // Print welcome to group letters
025300201020         When Opt_22 = *on or s1Opt = 22;
025400201020           BRKPLUSC();
025500181001
025700180105
025800201020         // File Transfer Menu
025900201020         When Opt_24 = *on or s1Opt = 24;
025901201020           CmdString = 'GO FileTr';
025902201020           #Command(CmdString:%len(%Trim(CmdString)));
026000181001
026001201020         EndSl;
026100181001
026200000000       enddo;
026300000000
026400000000       *inlr = *on;
026500000000
026600180105
