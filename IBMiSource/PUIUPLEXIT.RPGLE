000100211102
000200160831     H**********************************************************************************************
000300160831     H*                                                                                            *
000400160831     H*   Description: Profound UI File Upload Widget Exit Program                                 *
000500160831     H*                                                                                            *
000600160831     H*                Usage notes:                                                                *
000700160831     H*                                                                                            *
000800160831     H*                See documentation here:                                                     *
000900160831     H*                                                                                            *
001000160831     H*                http://www.profoundlogic.com/docs/display/PUI/Security                      *
001100160831     H*                                                                                            *
001200160831     H*                The original copy of this source member in the product installation library *
001300160831     H*                should NOT be used directly, as this will be replaced on each update to     *
001400160831     H*                Profound UI.                                                                *
001500160831     H*                                                                                            *
001600160831     H*                Instead, you should copy the source member to a source file in another      *
001700160831     H*                library and work from there.                                                *
001800160831     H*                                                                                            *
001900160831     H*                Compile as PUIUPLEXIT in Profound UI product library using CRTBNDRPG.       *
002000160831     H*                                                                                            *
002100160831     H*                Your compiled program object will NEVER be replaced by Profound UI update.  *
002200160831     H*                                                                                            *
002300181017      *--------------------------------------------------------------------------------------------
002400181017      * Change Log
002500181017      * 10/17/2018  B.Rees  Added csv files to /GAS
002600211102      * 11/02/2021  B.Rees  Added Folder for /Payment Files/ACH Web
002700220406      * 04/06/2022  B.Rees  It appears that the browser is sending "text/csv" instead of
002800220406      *                     "text/plain" for CSV Files.  Adding "text/csv" to if Statement.
002801220506      * 05.06.2022  J.Allen Added type csv to file upload IFS
002802230504      * 05.04.2023  JT      Added MT Bank file. extension is numbers that differ every day
002900181017      *
003000160831     H**********************************************************************************************
003100160831
003200230503     H DFTACTGRP(*NO) ACTGRP(*CALLER)
003300160831
003400160831     D* DS template for FileInfo parameter.
003500160831     D fileinfo_t      DS                  Qualified Based(Template)
003600160831     D  WidgetId                    256A
003700160831     D  Directory                   256A
003800160831     D  Name                        256A
003900160831     D  Type                        256A
004000160831     D  Size                         10U 0
004100160831     D  Exists                         N
004200160831
004300160831     D* Do not change the prototype.
004400160831     D Main            PR                  ExtPgm('PUIUPLEXIT')
004500160831     D  FileInfo                           Const LikeDS(fileinfo_t)
004600160831     D  Allow                         5I 0
004700160831     D  ErrorMsg                    256A
004800160831
004900160831     D* Do not change the procedure interface.
005000160831     D Main            PI
005100160831     D  FileInfo                           Const LikeDS(fileinfo_t)
005200160831     D  Allow                         5I 0
005300160831     D  ErrorMsg                    256A
005400160831
005500160831     D* The current user can be retrieved this way.
005600160831     D PSDS           SDS                  Qualified
005700160831     D  CurrentUser          358    367A
005800160831
005801230504     d testcl          pr                  ExtPgm('TESTCL')
005802230504
005900160831      /FREE
006000160831
006100161118        //---------------------------------------------------
006200160831        // For example...
006300161118        //
006400160831        // 1. Allow only plain text files up to 10MB...
006500161118        //
006600160831        // 2. Allow writing files only into /tmp, do not overwrite
006700160831        //    existing files.
006800161118        //
006900161118        // 10MB = 1024
007000161118        //       x1024
007100161118        //       ------
007200161118        //      1048576 = 1 MB
007300181102        //         x 10
007400161118        //       ------
007500161118        //     10485760 = 10 MB
007600161118        //---------------------------------------------------
007700161118
007800161118
007900230503         Allow = 0;
007901230504
007902230504         //?MT file to TEMP/MTBankFile
008026230504         If FileInfo.Directory = '/temp/MTBankFile';
008028230504          Allow = 1;
008032230504         EndIf;
008033230503
008100170927         //?Text to Tmp
008200220406         If (FileInfo.Type = 'text/plain' or
008300220406             FileInfo.Type = 'text/csv' ) And FileInfo.Size <= 10485760;
008400160831           If FileInfo.Directory = '/tmp';
008500160831             Allow = 1;
008600160831           EndIf;
008700160831         EndIf;
008800170927
008900170927         //?Excel to Tmp
009000170927         If FileInfo.Type = 'application/vnd.ms-excel' and
009100170927            FileInfo.Size <= 10485760;
009200170927
009300170927           If FileInfo.Directory = '/tmp';
009400170927             Allow = 1;
009500170927           EndIf;
009600170927         EndIf;
009700160831
009800181017
009900181017
010000181017         //?Text to GAS    10/17/2018
010100181017         If FileInfo.Type = 'text/plain' And FileInfo.Size <= 10485760;
010200181017           If FileInfo.Directory = '/gas';
010300181017             Allow = 1;
010400181017           EndIf;
010500181017         EndIf;
010600181017
010700181017         //?Excel to Tmp  10/17/2018
010800181017         If FileInfo.Type = 'application/vnd.ms-excel' and
010900181017            FileInfo.Size <= 10485760;
011000181017
011100181017           If FileInfo.Directory = '/gas';
011200181017             Allow = 1;
011300181017           EndIf;
011400181017         EndIf;
011500181017
011600160926
011700160926         //?9/26/2016 - Added XLSX files to folder: FileUpload
011800160926         If FileInfo.Type =
011900160926          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
012000160926           and FileInfo.Size <= 10485760;
012100160926
012200160926           If FileInfo.Directory = '/FileUpload';
012300160926             Allow = 1;
012400160926           EndIf;
012500160926
012600160926         EndIf;
012700160926
012800180205
012900180205         //?2/05/2018 - Added CSV files to folder: FileUpload
013000180205         If FileInfo.Type =
013100180205          'application/vnd.ms-excel'
013200200519           and FileInfo.Size <= 20971520;   // 20 Gig.
013300180205
013400180205           If FileInfo.Directory = '/FileUpload';
013500180205             Allow = 1;
013600180205           EndIf;
013700180205
013800180205         EndIf;
013900180205
014000170801
014100170801         //?8/01/2017 - Added XLSX files to folder: Payment Files
014200170801         If ( FileInfo.Type = 'application/vnd.ms-excel' or
014300170801              FileInfo.Type =
014400170801         'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
014500170801           and FileInfo.Size <= 10485760;
014600170801
014700170801           If FileInfo.Directory = '/Payment Files';
014800170801             Allow = 1;
014900170801           EndIf;
015000170801
015100211102           If FileInfo.Directory = '/Payment Files/ACH Web';
015200211102             Allow = 1;
015300211102           EndIf;
015400211102
015500211102
015600211102
015700170801         EndIf;
015800170801
015900210322
016000170801
016100170801         //?8/01/2017 - Added XLSX files to folder: Midfiles
016200170801         If FileInfo.Type =
016300170801          'application/vnd.ms-excel'
016400170801           and FileInfo.Size <= 10485760;
016500170801
016600170801           If FileInfo.Directory = '/midfiles';
016700170801             Allow = 1;
016800170801           EndIf;
016900170801
017000170801         EndIf;
017100170801
017200161118
017300161118         //?11/18/2016 - Added PDF files to folder: FileUpload
017400161118         If FileInfo.Type = 'application/pdf'
017500161118           and FileInfo.Size <= 10485760;
017600161118
017700161118           If FileInfo.Directory = '/FileUpload';
017800161118             Allow = 1;
017900161118           EndIf;
018000161118
018100161118         EndIf;
018200161118
018300161118
018400161118         //?11/18/2016 - Added Word files to folder: FileUpload
018500161118         If FileInfo.Type =
018600161118          'application/vnd.openxmlformats-officedocument.' +
018700161118          'wordprocessingml.document'
018800161118           and FileInfo.Size <= 10485760;
018900161118
019000161118           If FileInfo.Directory = '/FileUpload';
019100161118             Allow = 1;
019200161118           EndIf;
019300161118
019400161118         EndIf;
019500161118
019600161118
019700210322
019800210322         // 3/22/2021 - Sending Any Excel or Text to the IFS.
019900210322         If ( FileInfo.Type = 'application/vnd.ms-excel' or
020000210322              FileInfo.Type = 'text/plain' or
020100220506             FileInfo.Type = 'text/csv' or
020200210322              FileInfo.Type =
020300220506            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
020400210322           and FileInfo.Size <= 10485760;
020500210322
020600210322             Allow = 1;
020700210322
020800210322         EndIf;
020900210322
021000230503        //return;
021100230503        *InLr = *On;
021200160831
021300160831      /END-FREE
021400160831
