000100160831
000200160831      **********************************************************************************************
000300160831      *                                                                                            *
000400160831      *   Description: Profound UI File Download Exit Program                                      *
000500160831      *                                                                                            *
000600160831      *                Compile as PUIDNLEXIT in PROFOUNDUI product library using CRTBNDRPG.        *
000700160831      *                                                                                            *
000800160831      *                Return 1 in 'Allow' parameter to allow the download, any other value will   *
000900160831      *                prevent the download                                                        *
001000160831      *                                                                                            *
001100170713      *--------------------------------------------------------------------------------------------*
001200180823      *
001300180823      * 7/13/2017 B.Rees  Added IFSREPORT
001400180823      *  Mod ID: Br01
001500180823      *
001600180823      * 3/01/2018 B.Rees  Added creating the Member_List excel spread sheet.
001700180823      *  Mod ID: Br02
001800180823      *
001900180823      * 6/26/2018 B.Rees  Added creating the Commission Control Excel Spread Sheet
002000180823      *  Mod ID: Br03
002100180823      * 8/23/2018 B.Rees  Added Program Manual
002200180823      *  Mod ID: Br04
002300181106      *
002400181106      * 11/06/2018 B.Rees  Added IT Tracking Documents Download
002500181106      *  Mod ID: Br05
002600181112      *
002700181112      * 11/12/2018 B.Rees  Added NewHire_Old HTML Download
002800181112      *  Mod ID: Br06
002900190412      *
003000190412      * 04/12/2019 B.Rees  Changed the IT Tracking to FT_DOCS
003100190412      *  Mod ID: Br07
003200190412      *
003300190513      *  5/13/2019 B.Rees  Created Relationship Inquiry Report
003400190513      *  Mod ID: Br08
003500190513      *
003600191212      * 12/12/2019 B.Rees  Added Cobra/ Active Flags to Member_List Report
003700191212      *  Mod ID: Br09
003800220218      *
003900220218      * 02/18/2022 B.Rees  Added Autoload - Export Rules
004000221206      *
004100221206      * 12/06/2022 J.Allen Added pdf_letters Documents Download
004200221206      *  Mod ID: ja01
004300200316      *
004400160831      **********************************************************************************************
004500160831     H DFTACTGRP(*NO) ACTGRP(*CALLER)
004600160831
004700170329br01 FptDocsL1  if   e           k disk    usropn
004800190412br07 FftFmtFill1if   e           k disk    usropn
004900181112br06 FGBS0049P  if   e           k disk    usropn
005000161118
005100221208        dcl-s TempFile256 Char(256);
005200221208        dcl-s EncryptF256 Char(256);
005300161118
005400160831     D InputData_t     ds                  qualified
005500160831     D                                     based(Template)
005600160831     D   fileid                     640a   varying
005700160831     D   userid                      10a
005800160831     D   ipAddr                      15a
005900160831     D   inline                       1n
006000160831
006100160831     D Main            PR                  ExtPgm('PUIDNLEXIT')
006200160831     D   timingFlag                  10i 0 const
006300160831     D   inputData                         likeds(InputData_t) const
006400160831     D   stmfDir                    640a   varying
006500160831     D   stmfName                   256a   varying
006600160831     D   attName                    256a   varying
006700160831     D   contentType                255a   varying
006800160831     D   allow                        5i 0
006900160831
007000160831     D Main            PI
007100160831     D   timingFlag                  10i 0 const
007200160831     D   inputData                         likeds(InputData_t) const
007300160831     D   stmfDir                    640a   varying
007400160831     D   stmfName                   256a   varying
007500160831     D   attName                    256a   varying
007600160831     D   contentType                255a   varying
007700160831     D   allow                        5i 0
007800160831
007900161118br01  * -----------------------------------------
008000161118 |    * Upper Case Function
008100161118 |    * -----------------------------------------
008200161118 |   D uCase           PR            50
008300161118br01 D  text                         50    value
008400161118
008500180301br02  * -----------------------------------------
008600180301 |    * Generate an excel spread sheet containing
008700180301 |    * a list of members
008800180301 |    * -----------------------------------------
008900180301 |   D GenMbrList      PR
009000180302 |   D  tempfile                     50    const
009100180301 |   D  iAcct#                       12
009200191212br09 D  iCOBRA                        1
009300191212br09 D  iActive                       1
009400180301 |   D  iAcct#         s             12
009500191212
009600191212br02    dcl-s iCobra Char(1);
009700191212        dcl-s iActive Char(1);
009800180301
009900180626br03  * -----------------------------------------
010000180626 |    * Generate an excel spread sheet containing
010100180626 |    * the Commission Control Data
010200180626 |    * -----------------------------------------
010300180626 |   D GenCommCtl      PR
010400180626 |   D  tempfile                     50    const
010500180626 |   D  iAcct#                       12
010600180627 |   D  iHidePlans                    1
010700180627 |   D  iHidePlans     s              1
010800180626br03
010900180626
011000180301
011100190513br08    Dcl-pr  INQ020C  ExtPgm('INQ020C');
011200190513         otempfile Char(50);
011300190513         orelid Char(8);
011400190513        end-pr;
011500190513        dcl-s oTempFile Char(50);
011600190513        dcl-s oRelid Char(8);
011700190513
011800220218br08    Dcl-pr  alExpRule ExtPgm('ALEXPRULE');
011900220218         otempfile Char(50);
012000220218        end-pr;
012100220218
012200180301
012300161118br01  * ----------------------------------------------------------
012400161118 |    *  The tmpnam() call is an IBM-provided API to calculate a
012500161118 |    *  unique temporary file name. So this will just generate a name
012600161118 |    *  that's not in use. The tmpnam() will return a path name
012700161118 |    *  beginning with /tmp/Qxxxx -- but since PUI wants the directory
012800161118 |    *  name in a separate variable, we use %SUBST to remove the
012900161118 |    *  first 5 characters to remove "/tmp/" from the start.
013000161118 |    * ----------------------------------------------------------
013100161118 |   D tmpnam          PR              *   extproc('_C_IFS_tmpnam')
013200161118 |   D   string                      39A   options(*omit)
013300161118 |   D
013400161118 |   D unlink          PR            10I 0 ExtProc('unlink')
013500161118 |   D   path                          *   Value options(*string)
013600161118 |   D
013700161118 |   D CmdExc          PR                  ExtPgm('QCMDEXC')
013800161118 |   D   cmd                      32702a   const options(*varsize)
013900161118 |   D   len                         15p 5 const
014000161118 |   D  Cmd            s          32702a
014100161118 |   D  Len            s             15P 5
014200161118 |
014300161118 |   D  EncryptFile    s             64A
014400161118 |   D  Extension      s              5A
014500161118 |   D  TempFile       s             50A
014600170713 |   D  IFS_File       s            250A
014700220223 |      dcl-c q '''';
014800161118br01  * ----------------------------------------------------------
014900161118
015000161118         allow = 0;
015100161118
015200161118         if timingFlag=0;
015300161118
015400161118            Select;
015500161118
015600161118            //-------------------------------------------
015700161118            //?View OE Files.
015800161118            //-------------------------------------------
015900161118            when %Subst(inputData.fileId:1:7) = 'OE_DOCS';
016000170329              open ptDocsl1;
016100170317
016200161118              stmfDir     = '/tmp';
016300161118              stmfName    = %subst(%str(tmpnam(*omit)):6) ;
016400161118              TempFile = stmfDir + '/' + stmfName ;
016500161118              EncryptFile = %Subst(inputData.fileId:08);
016600161118
016700161118              //?Get the File information
016800170329              chain EncryptFile ptDocsl1;
016900170329              if %Found(ptDocsL1);
017000161118                 TempFile  = %Trim(TempFile) + '.' + %trim(odExt);
017100161118                 attName   = odFName;
017200161118                 Extension = odExt;
017300161118                 stmfName  = %Trim(stmfName) + '.' + %trim(odExt);
017400161118
017500161118                //?Copy the WebDocs File to TMP
017600161118                cmd = 'Copy Obj(''' +  '/webdocs/' +
017700161118                       %trim(odEncrypt) + ''')' +
017800161118                     ' ToObj(''' + %Trim(TempFile) + ''')' ;
017900161118                CmdExc(cmd: %len(cmd));
018000161118
018100161118                //?Get the Content Type
018200161118                ContentType = 'application/octet-stream' ;
018300161118
018400161118                Select;
018500161118                  when ucase(odExt) = 'PDF';
018600161118                     ContentType = 'application/pdf' ;
018700161118                  when ucase(odExt) = 'JPEG';
018800161118                     ContentType = 'image/jpeg' ;
018900161118                  when ucase(odExt) = 'JPG';
019000161118                     ContentType = 'image/jpeg' ;
019100161118                  when ucase(odExt) = 'GIF';
019200161118                     ContentType = 'image/gif' ;
019300161118                  when ucase(odExt) = 'PNG';
019400161118                     ContentType = 'image/png' ;
019500161118                 when ucase(odExt) = 'XLS';
019600161118                     ContentType = 'application/vnd.ms-excel';
019700161118                 when ucase(odExt) = 'XLSX';
019800161118                     ContentType = 'application/vnd.ms-excel';
019900161118                 when ucase(odExt) = 'XLSM';
020000161118                     ContentType = 'application/vnd.ms-excel';
020100161118                 when ucase(odExt) = 'DOCX';
020200161118                     ContentType = 'application/vnd.openxmlformats-'+
020300161118                     'officedocument.wordprocessingml.document';
020400161118                 when ucase(odExt) = 'DOC';
020500161118                     ContentType = 'application/msword';
020600161118               Endsl;
020700161118
020800161118              allow = 1;
020900161118
021000161118              if timingFlag=1 and
021100161118                 %Subst(inputData.fileId:1:7) = 'OE_DOCS';
021200161118                 unlink( stmfDir + '/' + stmfName + '.' + Extension);
021300161118              endif;
021400161118              endif;
021500161118
021600170329              Close ptDocsl1;
021700170317
021800221206
021900221206            //-------------------------------------------
022000221206            //?View PDF_Letters - ja01
022100221206            //-------------------------------------------
022200221206            when %Subst(inputData.fileId:1:11) = 'PDF_LETTERS';
022300221206
022400221206              stmfDir     = '/tmp';
022500221206              stmfName    = %subst(%str(tmpnam(*omit)):6) ;
022600221208              TempFile256 = stmfDir + '/' + stmfName ;
022700221208              EncryptF256 = %Subst(inputData.fileId:12);
022800221206
022900221206              //?Get the File information
023000221208                 TempFile256  = %Trim(TempFile256) + '.pdf';
023100221206                 attName   = 'Letter.pdf';
023200221206                 Extension = 'pdf';
023300221206                 stmfName  = %Trim(stmfName) + '.pdf';
023400221206
023500221206                //?Copy the WebDocs File to TMP
023600221206                cmd = 'Copy Obj(''' +
023700221208                       %trim(EncryptF256) + ''')' +
023800221208                     ' ToObj(''' + %Trim(TempFile256) + ''')' ;
023900221206                CmdExc(cmd: %len(cmd));
024000221206
024100221206                //?Get the Content Type
024200221206                     ContentType = 'application/pdf' ;
024300221206
024400221206              allow = 1;
024500221206
024600221206              if timingFlag=1 and
024700221206                 %Subst(inputData.fileId:1:11) = 'PDF_LETTERS';
024800221206                 unlink( stmfDir + '/' + stmfName + '.' + Extension);
024900221206              endif;
025000170713
025100170713            //-------------------------------------------
025200170713            //?View IFSREPORT.
025300170713            //-------------------------------------------
025400170713            when %Subst(inputData.fileId:1:9) = 'IFSREPORT';
025500170713
025600170713              stmfDir     = '/tmp';
025700170713              stmfName    = %subst(%str(tmpnam(*omit)):6) ;
025800170713              TempFile = stmfDir + '/' + stmfName ;
025900170713              IFS_File = %Subst(inputData.fileId:10);
026000170713
026100170713
026200170713             //?Copy the IFS File to TMP
026300170713             cmd = 'Copy Obj(''' +
026400170713                    %trim(IFS_File) + ''')' +
026500170713                  ' ToObj(''' + %Trim(TempFile) + ''')' ;
026600170713             CmdExc(cmd: %len(cmd));
026700170713
026800170713                //?Get the Content Type
026900170713                ContentType = 'application/octet-stream' ;
027000170713              allow = 1;
027100170713
027200170713              if timingFlag=1 and
027300170713                 %Subst(inputData.fileId:1:9) = 'IFSREPORT';
027400170713                 unlink( stmfDir + '/' + stmfName);
027500170713              endif;
027600170713
027700170713
027800220223
027900220224
028000220224            //-------------------------------------------
028100220224            //?Retrieve FTP File.
028200220224            //-------------------------------------------
028300220224            when %Subst(inputData.fileId:1:10) = 'RTVFTPFILE';
028400220224
028500220224              stmfDir     = '/tmp';
028600220224              stmfName = %Subst(inputData.fileId:11);
028700220224              TempFile = stmfDir + '/' + stmfName ;
028800220224
028900220224
029000220224
029100220224                //?Get the Content Type
029200220224                ContentType = 'application/octet-stream' ;
029300220224              allow = 1;
029400220224
029500220224              if timingFlag=1 and
029600220224                 %Subst(inputData.fileId:1:10) = 'RTVFTPFILE';
029700220224                 unlink( stmfDir + '/' + stmfName);
029800220224              endif;
029900220224
030000220224
030100170317
030200170317            //-------------------------------------------
030300170317            //?View GBS_DOC File.
030400170317            //?Example: GBS Census Spread Sheet
030500170317            //-------------------------------------------
030600170317            when %Subst(inputData.fileId:1:8) = 'GBS_DOCS';
030700170317
030800170317              stmfDir     = '/tmp';
030900170317              stmfName    = %subst(%str(tmpnam(*omit)):6) ;
031000170317              attName     = %Subst(inputData.fileId:9);
031100170317              TempFile = stmfDir + '/' + stmfName ;
031200170317
031300170317
031400170317                //?Copy the WebDocs File to TMP
031500170317                cmd = 'Copy Obj(''' +  '/webdocs/' +
031600170317                       %trim(attName) + ''')' +
031700170317                     ' ToObj(''' + %Trim(TempFile) + ''')' ;
031800170317                CmdExc(cmd: %len(cmd));
031900170317
032000170317                //?Get the Content Type
032100170317                ContentType = 'application/octet-stream' ;
032200170317
032300170317              allow = 1;
032400170317
032500170317              if timingFlag=1 and
032600180301                 %Subst(inputData.fileId:1:8) = 'GBS_DOCS';
032700170317                 unlink( stmfDir + '/' + stmfName + '.' + Extension);
032800170317              endif;
032900170317
033000180301
033100180301            //----------------------------------------------
033200180301            //
033300180301            //?Br02: Generate Member List
033400191212            // br09: Added COBRA Flag and ACTIVE Flag
033500180301            //
033600180301            //----------------------------------------------
033700180301            when %Subst(inputData.fileId:1:11) = 'Member_List';
033800180301
033900180301               stmfDir     = '/tmp';
034000180301               stmfName    = %subst(%str(tmpnam(*omit)):6) + '.xlsx';
034100180608               attName     = 'Member_List.xls';
034200180301               contentType = 'application/vnd.ms-excel';
034300180302               iAcct#      = %Subst(inputData.fileId:13:12);
034400191212
034500191212               iCobra      = %Subst(inputData.fileId:25:1);
034600191212               iActive     = %Subst(inputData.fileId:26:1);
034700191212
034800191212               GenMbrList( stmfDir + '/' + stmfName : iAcct#
034900191212                          : iCobra : iActive) ;
035000191212
035100180301               allow = 1;
035200180301
035300180301
035400180301               if timingFlag=1 and
035500180302                 %Subst(inputData.fileId:1:11) = 'Member_List';
035600180301                 unlink( stmfDir + '/' + stmfName );
035700180301               endif;
035800180301
035900180626
036000180626            //----------------------------------------------
036100180626            //
036200180626            //?Br03: Generate Commission Control
036300180626            //
036400180626            //----------------------------------------------
036500180626            when %Subst(inputData.fileId:1:11) = 'CommCtlList';
036600180626
036700180626               stmfDir     = '/tmp';
036800180626               stmfName    = %subst(%str(tmpnam(*omit)):6) + '.xlsx';
036900180626               attName     = 'Comm_Ctl.xls';
037000180626               contentType = 'application/vnd.ms-excel';
037100180626               iAcct#      = %Subst(inputData.fileId:13:12);
037200180627               iHidePlans  = %Subst(inputData.fileId:25:1);
037300180627               GenCommCtl( stmfDir + '/' + stmfName : iAcct#: iHidePlans ) ;
037400180626               allow = 1;
037500180626
037600180626
037700180626               if timingFlag=1 and
037800180626                 %Subst(inputData.fileId:1:11) = 'CommCtlList';
037900180626                 unlink( stmfDir + '/' + stmfName );
038000180626               endif;
038100180626
038200180301
038300180823
038400180823            //----------------------------------------------
038500180823            //
038600180823            //?Br04: Program Manual
038700180823            //
038800180823            //----------------------------------------------
038900190513            when %Subst(inputData.fileId:1:6) = 'MANUAL';
039000180823
039100180823              stmfDir     = '/tmp';
039200180823              stmfName    = %subst(%str(tmpnam(*omit)):6) ;
039300180823              attName     = %Subst(inputData.fileId:7);
039400180823              TempFile = stmfDir + '/' + stmfName ;
039500180823
039600180823
039700180823                //?Copy the WebDocs File to TMP
039800180823                cmd = 'Copy Obj(''' +  '/webdocs/' +
039900180823                       %trim(attName) + ''')' +
040000180823                     ' ToObj(''' + %Trim(TempFile) + ''')' ;
040100180823                CmdExc(cmd: %len(cmd));
040200180823
040300180823                //?Get the Content Type
040400180823                ContentType = 'application/octet-stream' ;
040500180823
040600180823              allow = 1;
040700180823
040800180823              if timingFlag=1 and
040900180823                 %Subst(inputData.fileId:1:6) = 'MANUAL';
041000180823                 unlink( stmfDir + '/' + stmfName + '.' + Extension);
041100180823              endif;
041200180823
041300181106
041400181106            //-------------------------------------------
041500190412            //?View IT Tracking Files.   BR07
041600181106            //-------------------------------------------
041700190412            when %Subst(inputData.fileId:1:7) = 'FT_DOCS';
041800190412              open ftFmtFill1;
041900181106
042000181106              stmfDir     = '/tmp';
042100181106              stmfName    = %subst(%str(tmpnam(*omit)):6) ;
042200181106              TempFile = stmfDir + '/' + stmfName ;
042300190412              EncryptFile = %Subst(inputData.fileId:08);
042400181106
042500181106              //?Get the File information
042600190412              chain EncryptFile ftfmtfill1;
042700190412              if %Found(ftfmtfill1);
042800190412                 TempFile  = %Trim(TempFile) + '.' + %trim(ffExt);
042900190412                 attName   = ffFName;
043000190412                 Extension = ffExt;
043100190412                 stmfName  = %Trim(stmfName) + '.' + %trim(ffExt);
043200181106
043300181106                //?Copy the WebDocs File to TMP
043400190412                cmd = 'Copy Obj(''' +  %Trim(ffIfsLoc) + '/' +
043500190412                       %trim(ffEncrypt) + ''')' +
043600181106                     ' ToObj(''' + %Trim(TempFile) + ''')' ;
043700181106                CmdExc(cmd: %len(cmd));
043800181106
043900181106                //?Get the Content Type
044000181106                ContentType = 'application/octet-stream' ;
044100181106
044200181106                Select;
044300200316                  when ucase(ffExt) = 'PDF';
044400181106                     ContentType = 'application/pdf' ;
044500200316                  when ucase(ffExt) = 'JPEG';
044600181106                     ContentType = 'image/jpeg' ;
044700200316                  when ucase(ffExt) = 'JPG';
044800181106                     ContentType = 'image/jpeg' ;
044900200316                  when ucase(ffExt) = 'GIF';
045000181106                     ContentType = 'image/gif' ;
045100200316                  when ucase(ffExt) = 'PNG';
045200181106                     ContentType = 'image/png' ;
045300200316                 when ucase(ffExt) = 'XLS';
045400181106                     ContentType = 'application/vnd.ms-excel';
045500200316                 when ucase(ffExt) = 'XLSX';
045600181106                     ContentType = 'application/vnd.ms-excel';
045700200316                 when ucase(ffExt) = 'XLSM';
045800181106                     ContentType = 'application/vnd.ms-excel';
045900200316                 when ucase(ffExt) = 'DOCX';
046000181106                     ContentType = 'application/vnd.openxmlformats-'+
046100181106                     'officedocument.wordprocessingml.document';
046200200316                 when ucase(ffExt) = 'DOC';
046300181106                     ContentType = 'application/msword';
046400181106               Endsl;
046500181106
046600181106              allow = 1;
046700181106
046800181106              if timingFlag=1 and
046900190412                 %Subst(inputData.fileId:1:7) = 'FT_DOCS';
047000181106                 unlink( stmfDir + '/' + stmfName + '.' + Extension);
047100181106              endif;
047200181106              endif;
047300181106
047400190412              Close ftfmtfill1;
047500181106
047600181106
047700180823
047800181112
047900181112            //-------------------------------------------
048000181112            //?View NewHire_Old Files.   BR06
048100181112            //-------------------------------------------
048200181112            when %Subst(inputData.fileId:1:11) = 'NewHire_Old';
048300181112              open gbs0049p;
048400181112
048500181112              stmfDir     = '/www/gbsapps/htdocs/gbsapps/oe/NEW_HIRES';
048600181112              stmfName    = %subst(%str(tmpnam(*omit)):6) ;
048700181112              TempFile = stmfDir + '/' + stmfName ;
048800181112              EncryptFile = %Subst(inputData.fileId:12);
048900181112
049000181112              //?Setup File information
049100181112                 TempFile  = EncryptFile;
049200181112                 attName   = EncryptFile;
049300181112                 Extension = 'HTML';
049400181112                 stmfName  = EncryptFile;
049500181112
049600181112                //?Get the Content Type
049700181112                ContentType = 'application/octet-stream' ;
049800181112
049900181112
050000181112              allow = 1;
050100181112
050200181112              if timingFlag=1 and
050300181112                 %Subst(inputData.fileId:1:11) = 'NewHire_Old';
050400181112                 unlink( stmfDir + '/' + stmfName + '.' + Extension);
050500181112              endif;
050600181112
050700181112              Close gbs0049p;
050800181112
050900190513
051000190513            //----------------------------------------------
051100190513            //
051200190513            //?Br08: Salesmen / Relationship Inquiry
051300190513            //
051400190513            //----------------------------------------------
051500190513            when %Subst(inputData.fileId:1:11) = 'RelationInq';
051600190513
051700190513               stmfDir     = '/tmp';
051800190513               stmfName    = %subst(%str(tmpnam(*omit)):6) + '.pdf';
051900190513               attName     = 'Relat_Rept.pdf';
052000190513               ContentType = 'application/pdf' ;
052100190513               orelid      = %Subst(inputData.fileId:12:08);
052200190513               oTempFile   = stmfDir + '/' + stmfName;
052300190513               INQ020C( oTempFile : oRelid) ;
052400190513               allow = 1;
052500190513
052600190513
052700190513               if timingFlag=1 and
052800190513                 %Subst(inputData.fileId:1:11) = 'RelationInq';
052900190513                 unlink( stmfDir + '/' + stmfName );
053000190513               endif;
053100190513
053200190513
053300220218
053400220218            //----------------------------------------------
053500220218            //
053600220218            //?Autoload - Export Rules to Excel.
053700220218            //
053800220218            //----------------------------------------------
053900220218            when %Subst(inputData.fileId:1:11) = 'ExportRules';
054000220218
054100220218               stmfDir     = '/tmp';
054200220218               stmfName    = %subst(%str(tmpnam(*omit)):6) + '.xls';
054300220218               attName     = 'Export_Rules.xls';
054400220218               ContentType = 'application/vnd.ms-excel';
054500220218               oTempFile   = stmfDir + '/' + stmfName;
054600220218               alExpRule( oTempFile ) ;
054700220218               allow = 1;
054800220218
054900220218
055000220218               if timingFlag=1 and
055100220218                 %Subst(inputData.fileId:1:11) = 'ExportRules';
055200220218                 unlink( stmfDir + '/' + stmfName );
055300220218               endif;
055400220218
055500220218
055600181114
055700181114
055800181114            //-------------------------------------------
055900181114            //?View OE_Old Files.   BR06
056000181114            //-------------------------------------------
056100181114            when %Subst(inputData.fileId:1:6) = 'OE_Old';
056200181114              open gbs0049p;
056300181114
056400181114              stmfDir     = '/www/gbsapps/htdocs/gbsapps/oe/QS36F';
056500181114              stmfName    = %subst(%str(tmpnam(*omit)):6) ;
056600181114              TempFile = stmfDir + '/' + stmfName ;
056700181114              EncryptFile = %Subst(inputData.fileId:7);
056800181114
056900181114              //?Setup File information
057000181114                 TempFile  = EncryptFile;
057100181114                 attName   = EncryptFile;
057200181114                 Extension = 'HTML';
057300181114                 stmfName  = EncryptFile;
057400181114
057500181114                //?Get the Content Type
057600181114                ContentType = 'application/octet-stream' ;
057700181114
057800181114
057900181114              allow = 1;
058000181114
058100181114              if timingFlag=1 and
058200181114                 %Subst(inputData.fileId:1:6) = 'OE_Old';
058300181114                 unlink( stmfDir + '/' + stmfName + '.' + Extension);
058400181114              endif;
058500181114
058600181114              Close gbs0049p;
058700181114
058800181112
058900161118            endsl;
059000161118          endif;
059100161118
059200161118
059300161118
059400160831         *inlr = *on;
059500161118
059600180301
059700180301      *-----------------------------------------------------
059800180301      *
059900180626      * GenMbrList()  ?br02
060000191212      *   br09: Added COBRA / Active
060100180301      *-----------------------------------------------------
060200180301     P GenMbrList      B
060300180301     d                 pi
060400180302     d  Tempfile                     50a   const
060500180301     d  iAcct#                       12a
060600191212     d  iCOBRA                        1a
060700191212     d  iActive                       1a
060800180301
060900180301     d Inq011C         pr                  ExtPgm('INQ011C')
061000180301     d  AcctNumber                   12a
061100180301     d  TempFile                     50a
061200191212     d  Cobra                         1a
061300191212     d  Active                        1a
061400180301     d myTempFile      s             50
061500180301
061600180301
061700180301       myTempFile = TempFile;
061800191212       Inq011C( iAcct# : myTempFile : iCobra : iActive );
061900180301
062000180301     p                 e
062100180301
062200180626      *-----------------------------------------------------
062300180626      *
062400180626      * GenCommCtl()  ?br03
062500180626      *
062600180626      *-----------------------------------------------------
062700180626     P GenCommCtl      B
062800180626     d                 pi
062900180626     d  Tempfile                     50a   const
063000180626     d  iAcct#                       12a
063100180627     d  iHidePlans                    1a
063200180626
063300180626     d Inq009C1        pr                  ExtPgm('INQ009C1')
063400180626     d  AcctNumber                   12a
063500180627     d  HidePlans                     1a
063600180626     d  TempFile                     50a
063700180626     d myTempFile      s             50
063800180626
063900180626
064000180626       myTempFile = TempFile;
064100180627       Inq009C1( iAcct# : iHidePlans : myTempFile );
064200180626
064300180626     p                 e
064400180626
064500180301      /end-free
064600180301
064700161118      *-----------------------------------------------------------------
064800161118      *?Upper Case Function
064900161118      *-----------------------------------------------------------------
065000161118     P uCase           B                   export
065100161118     D uCase           PI            50
065200161118     D   Text                        50    value
065300161118     D up              c                   CONST('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
065400161118     D lo              c                   CONST('abcdefghijklmnopqrstuvwxyz')
065500161118     D ReturnText      s             50
065600161118     C                   eval      ReturnText = %xlate(lo:up:Text)
065700161118     C                   Return    ReturnText
065800161118     P                 E
