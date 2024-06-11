000100171229
000200171229       Ctl-Opt option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*No)
000300171229          ActGrp(*New);
000400171229
000500171229      *-------------------------------------------------------------------------
000600171229      *
000700171229      *  Description:  Member Inquiry - Carrier Selection Window
000800171229      *  Programmer.:  Brian Rees
000900171229      *  Date.......:  09/19/2017
001000171229      *
001100171229      *-------------------------------------------------------------------------
001200171229
001300171229      *-------------------------------------------------------------------------
001400171229      *
001500171229      * Declare Files
001600171229      *
001700171229      *-------------------------------------------------------------------------
001800171229       Dcl-f Inq004d WorkStn
001900171229          Handler('PROFOUNDUI(HANDLER)');
002000171229
002100171229
002200171229      *-------------------------------------------------------------------------
002300171229      *
002400171229      * Global Variables
002500171229      *
002600171229      *-------------------------------------------------------------------------
002700171229       dcl-s @GrpCd Char(2);
002800171229       dcl-s @cName Char(40);
002900171229
003000180404
003100180404      *-------------------------------------------------------------------------
003200180404      *
003300180404      * *Entry Procedure
003400180404      *
003500180404      *-------------------------------------------------------------------------
003600180404       Dcl-pr Main ExtPgm;
003700180404          *N  Zoned(3);
003800180404          *N  Zoned(3);
003900180404          *N  Zoned(9);
004000190410          *N  Zoned(4);
004100180404          *N  Char(40);
004200180404          *N  Char(1) ;
004300180404       End-Pr;
004400180404
004500180404       dcl-pi Main;
004600180404          pTrst    Zoned(3);
004700180404          pSub#    Zoned(3);
004800180404          pMember  Zoned(9);
004900190410          pAcct    Zoned(4);
005000180404          pCarGrp  Char(40);
005100180404          pCancel  Char(1);
005200180404       End-Pi;
005300180404
005400180404
005500170919
005600161111
005700171229      *-------------------------------------------------------------------------
005800171229      *
005900171229      * Mainline Program
006000171229      *
006100171229      *-------------------------------------------------------------------------
006200180404
006300171229       Exec Sql  Set Option Commit=*None, Naming=*Sys;
006400170606
006500190408       if pMember > 0;
006600171229       // Load the Carrier Values...
006700171229       Exec Sql Declare C1 Cursor For
006800171229          Select Distinct Cgrpcd, Cname
006900171229          From "F.PLNMST" Join "F.CARMST" On Carrcd = Pcarr
007000171229          Where Pltrst = :Ptrst And Plsub# = :Psub#
007100171229          And Plplan In ( Select Mcplan From "F.MCOV" Where
007200171229          Mcssno = :Pmember );
007300190408       else;
007400190408       // Load the Carrier Values...
007500190410       Exec Sql
007600190410          Declare c2 Cursor For
007700190410             Select Distinct cgrpcd, cname
007800190410                From "F.PLNMST"
007900190410                Join "F.CARMST" On carrcd = pcarr
008000190410                Where pltrst = :ptrst
008100190410                      And plsub# = :psub#
008200190410                      And plplan In (Select mcplan
008300190410                                        From "F.MCOV"
008400190410                                        Where mctrst = :ptrst
008500190410                                              And mcsub# = :psub#
008600190410                                              And acc# = :pacct);
008700190408        endif;
008800190408
008900171229       // Populate the Drop Down Box
009000171229       carChoice = *Blanks;
009100171229       carValues = *Blanks;
009200170919
009300171229       // Add NC to the choice
009400171229       carValues = 'NC';
009500171229       carChoice = 'NOT CARRIER SPECIFIC';
009600170919
009700190408       if pMember > 0;
009800171229       Exec Sql Open C1;
009900190408       else;
010000190408       Exec Sql Open C2;
010100190408       endif;
010200190408
010300171229       dou SqlCod <> *zero;
010400190408          if pMember > 0;
010500171229          Exec Sql Fetch Next From C1 Into :@grpcd, :@cname;
010600190408          else;
010700190408          Exec Sql Fetch Next From C2 Into :@grpcd, :@cname;
010800190408          endif;
010900190408
011000171229          if SqlCod <> *Zero;
011100171229             leave;
011200171229          endif;
011300170919
011400190408          @cName = %ScanRpl(',':'':@cName);
011500190408
011600171229          carChoice = %Trim(carChoice) + ',' + %Trim( @cName );
011700171229          carValues = %Trim(carValues) + ',' + %Trim( @GrpCd );
011800171229       enddo;
011900171229
012000190408       if pMember > 0;
012100171229       Exec Sql Close C1;
012200190408       else;
012300190408       Exec Sql Close C2;
012400190408       endif;
012500170919
012600170905
012700170905
012800170905       //----------------------------------------------------------
012900171229       //
013000171229       // Display Window
013100171229       //
013200170905       //----------------------------------------------------------
013300170901       Dou btnExit = *on;
013400161109
013500170919          Exfmt Screen1;
013600161109
013700170919          if btnExit = *on;
013800170919             pCarGrp = *Blanks;
013900170919             pCancel = 'Y';
014000170919             leave;
014100170919          endif;
014200170919
014300170919          if btnAccept = *on;
014400170920
014500171229             // if 'Not Carrier Specific' is selected, remove all others.
014600170920             if %Scan( 'NC' : s1CarGrp ) > 0;
014700170920                s1CarGrp = 'NC';
014800170920             endif;
014900170920
015000171229             // Remove the comma..  The result will be placed in a DS.
015100170920             pCarGrp =  %ScanRpl( ',' : '' : s1CarGrp );
015200170919             pCancel = *blanks;
015300170919             leave;
015400170920
015500170919          endif;
015600170919
015700170919
015800170901       enddo;
015900161109
016000170901       *inlr = *on;
016100161109
016200170905
