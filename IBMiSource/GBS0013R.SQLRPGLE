000100160928     H option(*noDebugIo)  DftActGrp(*no) BndDir('GBSBDIR')
000200160928      *-------------------------------------------------------------------------
000300160928      *
000400161222      *  Description: FTP Security Settings
000500161007      *  Programmer.: Brian Rees
000600161222      *  Date.......: 12/22/216
000700160928      *
000800161007      * ?This report uses Profound Logic.
000900161007      *
001000170322      *  Description: This will display the FTP User names and password
001100170322      *    for multiple accounts.
001200161007      *
001300170322      *  This uses the Encrypt and Decrypt SQL Commands to
001400170322      *  hide the usernames and passwords.
001500170322      *
001600160928      *-------------------------------------------------------------------------
001700160928      * Modifications
001800160928      *
001900160928      * Date         Programmer    Mod      Description
002000160928      *-------------------------------------------------------------------------
002100211122      * 11/22/2021   B.Rees
002101211122      *  Added Send Credientials Menu Option.
002200160928      *
002300160928      *-------------------------------------------------------------------------
002400161222     FGBS0013D  CF   E             WORKSTN
002500160928     F                                     HANDLER('PROFOUNDUI(HANDLER)')
002600160928     F                                     SFILE(LSTSFL:rrn)
002700160928     F
002800161227     fFtpSec    uf a e           k disk
002900161005
002901211122       dcl-f emailAddr keyed;
002902211122
003000160218      *--------------------------------------------------------------------
003100161223     d PGMD          ESDS                  EXTNAME(IOPGMD)
003200161227     D  @pgmq            *proc
003300161223
003400161222     d HasError        s               n
003500161222     d ReLoad          s              1
003600161222     d rrn             s              5s 0
003700161222
003800161222
003900161227     d myPassword      s             14a   inz
004000161223     d RcdMode         s             10a   inz
004100161223
004200161227      *--------------------------------------------
004300161227      * Procedures
004400161227      *--------------------------------------------
004500161227     D/COPY GBSPGM/QMODSRC,PR0003RPR            // Check Program Authority
004601211122      /include *LIBL/QMODSRC,#COMMANDPR         // Command
004602211122
004700161005      *-------------------------------------------------------------------------
004800211122      * Mainline Program
004900161005      *-------------------------------------------------------------------------
005000160928
005100161222       myPassWord = 'PineAppleAriel';
005200161222       Reload = 'Y';
005300161222
005400150902
005500160928
005600161223       dou btnExit = *on;
005700160928
005800211122         if Reload = 'Y';
005900211122           ClearS1();
006000211122           LoadS1();
006100211122           Reload = 'N';
006200211122         endif;
006300160928
006400211122         DisplyS1();
006500160928
006600211122         if btnExit = *on;
006700211122           leave;
006800211122         endif;
006900161223
007000161223
007100211122         Select;
007200161223
007300211122         when  btnAddNew = *on;
007400211122           Clear AddScreen;
007500211122           RcdMode = 'Add';
007600211122           ReLoad = 'Y';
007700211122           $AddRecord();
007800161223
007900211122         other;
008000211122           ReadChanged();
008100161223
008200211122         endsl;
008300161223
008400161223       enddo;
008500160928
008600161223       *inlr = *on;
008700160928
008800160928      *-------------------------------------------------------------------------
008900211122       dcl-proc ClearS1;
009000160928
009100211122         //?Clear the Subfile
009200211122         SflClr = *on;
009300211122         Write LstCtl;
009400211122         SflClr = *off;
009500160928
009600211122         rrn = 0;
009700160928
009800211122       end-proc;
009900160928      *-------------------------------------------------------------------------
010000211122       dcl-proc DisplyS1;
010100160928
010200211122         SflDsp = *on  ;
010300211122         exfmt  LstCtl ;
010400211122         SflDsp = *off;
010500160928
010600211122       end-proc;
010700160928      *-------------------------------------------------------------------------
010800211122       dcl-proc LoadS1;
010900160928
011000161005
011100211122         //----------------------------------------------------
011200211122         //?Load the FTP Sites
011300211122         //----------------------------------------------------
011400211122         Setll *loval FtpSec;
011500211122         dou %Eof(FtpSec);
011600211122           read(n) FtpSec;
011700161005
011800211122           if %Eof(FtpSec);
011900211122             leave;
012000211122           endif;
012100161222
012200211122           s1Name = ftName;
012300211122           s1Url  = ftUrl;
012400211122           s1Folder = ftFolder;
012500170106
012600211122           //?User ID
012700211122           Exec Sql
012800211122             Select Decrypt_Char(:Ftuser, :Mypassword)
012900211122               Into :S1user
013000211122               From Sysibm/Sysdummy1;
013100161222
013200211122           //?Password
013300211122           Exec Sql
013400211122             Select Decrypt_Char(:Ftpass, :Mypassword)
013500211122               Into :S1pass
013600211122               From Sysibm/Sysdummy1;
013700161222
013800211122           rrn = rrn + 1;
013900211122           write LstSfl;
014000161223
014100161223
014200211122         enddo;
014300161005
014400161005
014500161005
014600161005
014700211122       end-proc;
014800161223
014900161223      *-------------------------------------------------------------------------
015000211122       dcl-proc $AddRecord;
015100161223
015200161223
015300211122         dou btnCancel = *on;
015400161223
015500211122           exfmt AddScreen;
015501211122
015600211122           Validate();
015700211122           if hasError = *on;
015800211122             iter;
015900211122           EndIf;
016000161223
016100211122           if btnAccept = *on;
016200211122             ftName = s2Name;
016300211122             ftUrl = s2Url;
016400161223
016500211122             Exec Sql
016600211122               Select Encrypt_Rc2(:S2user, :Mypassword)
016700211122                 Into :Ftuser
016800211122                 From Sysibm/Sysdummy1;
016900161223
017000211122             Exec Sql
017100211122               Select Encrypt_Rc2(:S2pass, :Mypassword)
017200211122                 Into :Ftpass
017300211122                 From Sysibm/Sysdummy1;
017400161223
017500211122             ftFolder = s2Folder;
017600211122             ftPort  = s2Port;
017700211122             ftNotes = s2Notes;
017800161223
017900211122             ftCrtBy = wqusrn;
018000211122             ftCrtDt = %Dec(%Date);
018100211122             ftCrtTm = %Dec(%Time);
018200161223
018300211122             ftChgBy = *Blanks;
018400211122             ftChgDt = *Zero;
018500211122             ftChgTm = *Zero;
018600161223
018700211122             write ftpsec_R;
018800211122             leave;
018900161223
019000211122           EndIf;
019100161223
019200161223
019300211122         EndDo;
019400161223
019500161223
019600211122       end-proc;
019700161223
019800161223      *-------------------------------------------------------------------------
019900211122       dcl-proc LoadData;
020000161223
020100211122         clear EditScreen;
020200211122         Clear ViewScreen;
020300161223
020400211122         chain s1Name ftpSec;
020500161223
020600211122         s2Name = ftName;
020700211122         s2Url  = ftUrl;
020800211122         s2Folder = ftFolder;
020900211122         s2Port = ftPort;
021000161223
021100211122         //?User ID
021200211122         Exec Sql
021300211122           Select Decrypt_Char(:Ftuser, :Mypassword)
021400211122             Into :S2user
021500211122             From Sysibm/Sysdummy1;
021600161223
021700211122         //?Password
021800211122         Exec Sql
021900211122           Select Decrypt_Char(:Ftpass, :Mypassword)
022000211122             Into :S2pass
022100211122             From Sysibm/Sysdummy1;
022200161223
022300211122         s2Notes = ftNotes;
022400161223
022500211122         if ftCrtBy > *Blanks;
022600211122           s2Create =
022700211122             'Created by: ' + %Trim(ftCrtBy) + ' on ' +
022800211122              %Char(%date(ftCrtDt) :*usa) + ' at ' +
022900211122                   %Char(%Time(ftCrtTm) :*usa);
023000211122         endif;
023100161223
023200211122         if ftChgBy > *Blanks;
023300211122           s2Change =
023400211122             'Created by: ' + %Trim(ftChgBy) + ' on ' +
023500211122              %Char(%date(ftChgDt) :*usa) + ' at ' +
023600211122                   %Char(%Time(ftChgTm) :*usa);
023700211122         endif;
023800161223
023900161223
024000211122       end-proc;
024100161223      *-------------------------------------------------------------------------
024200211122       dcl-proc $EditRecord;
024300161223
024400161223
024500211122         LoadData();
024600161223
024700211122         dou btnCancel = *on;
024800161223
024900211122           exfmt EditScreen;
025000161223
025100211122           if btnAccept = *on;
025200161223
025300211122             ftUrl = s2Url;
025400161223
025500211122             Exec Sql
025600211122               Select Encrypt_Rc2(:S2user, :Mypassword)
025700211122                 Into :Ftuser
025800211122                 From Sysibm/Sysdummy1;
025900161223
026000211122             Exec Sql
026100211122               Select Encrypt_Rc2(:S2pass, :Mypassword)
026200211122                 Into :Ftpass
026300211122                 From Sysibm/Sysdummy1;
026400161223
026500161223
026600211122             ftFolder = s2Folder;
026700211122             ftNotes = s2Notes;
026800211122             ftPort = s2Port;
026900161223
027000161223
027100211122             ftChgBy = wqusrn;
027200211122             ftChgDt = %Dec(%Date);
027300211122             ftChgTm = %Dec(%Time);
027400161223
027500161223
027600211122             update ftpsec_R;
027700211122             leave;
027800161223
027900211122           EndIf;
028000161223
028100161223
028200211122         EndDo;
028300161223
028400161223
028500211122       end-proc;
028600161007      *-------------------------------------------------------------------------
028700211122       dcl-proc Validate;
028800161007
028900211122         hasError = *off;
029000211122         errName = *off;
029100161223
029200211122         chain s2Name ftpSec;
029300211122         if %Found(FtpSec);
029400211122           hasError = *on;
029500211122           errName = *on;
029600211122         EndIf;
029700161223
029800161223
029900161007
030000211122       end-proc;
030100161223
030200161223      *-------------------------------------------------------------------------
030300211122       dcl-proc ReadChanged;
030400161223
030500211122         Dou *in95 = *ON;
030600211122           READC LstSfl;
030700211122           *in95 = %EOF;
030800161223
030900211122           If *in95 = *OFF;
031000161223
031100211122             If btnEdit = *on;
031200211122               $EditRecord();
031300211122             endIf;
031400161223
031500161223
031600211122             If btnView = *on;
031700211122               $ViewRecord();
031800211122             endIf;
031900161223
032000161223
032100211122             If btnDelete= *on;
032200211122               $DelRecord();
032300211122             endIf;
032400161223
032500161223
032501211122             if runOption = 'sndCred';
032502211122               Send_Email();
032503211122             EndIf;
032504211122
032505211122
032506211122             runOption = '';
032600211122             btnDelete = *off;
032700211122             btnView = *off;
032800211122             btnEdit = *off;
032900211122             update LstSfl;
033000161223
033100211122             Reload = 'Y';
033200211122           endIf;
033300161223
033400161223
033500211122         enddo;
033600211122       end-proc;
033700161223
033800161223      *-------------------------------------------------------------------------
033900211122       dcl-proc $ViewRecord;
034000161223
034100161223
034200211122         LoadData();
034300161223
034400211122         dou btnCancel = *on;
034500211122           exfmt ViewScreen;
034600211122         enddo;
034700161223
034800161223
034900211122       end-proc;
035000161223
035100161223
035200161223
035300161223      *-------------------------------------------------------------------------
035400211122       dcl-proc $DelRecord;
035500161223
035600161223
035700211122         LoadData();
035800161223
035900211122         dou btnCancel = *on;
036000211122           exfmt Confirm;
036100161223
036200161223
036300211122           if btnAccept = *on;
036400211122             delete ftpsec_r;
036500211122             leave;
036600211122           EndIf;
036700161223
036800211122         enddo;
036900161223
037000161223
037100211122       end-proc;
037200161223
037201211122
037202211122      *-------------------------------------------------------------------------
037203211122       dcl-proc Send_Email;
037204211122
037206211122         Dcl-s Msg Char(2000);
037207211122         dcl-s Subject Char(100);
037208211122         dcl-s toAddr Char(200);
037210211122
037211211122         dcl-c q const ('''');
037213211122
037220211122
037241211122
037242211122         //------------------------------
037243211122         //
037244211122         // Get the Users Email
037245211122         //
037246211122         //------------------------------
037256211122         chain wqUsrn EmailAddr;
037257211122
037258211122         if not %Found( EmailAddr ) ;
037259211122           return;
037260211122         EndIf;
037261211122
037262211122
037263211122         toAddr = %lower(%Trim(eaEmail));
037264211122
037265211122         //----------------------------------------------------
037266211122         //
037267211122         //  User Name
037268211122         //
037269211122         //----------------------------------------------------
037271211122
037272211122         Subject = 'Account Credentials';
037273211122         Msg = '<p>' +
037274211122          'Your account login credentials have been created or were modified.'+
037275211122          '<br>Your new username and password are provided below: ' +
037276211122          '<p>Site Address: ' + %Trim( s1Url )  +
037277211122          '<br>Site URL: https://' +  %Trim( s1Url )  +
037278211122          '<p>' +
037279211122          'UserName: <b>' + %Trim( s1User ) + '</b><p>' +
037280211122          'Note: Your password will be sent in a separate email ' +
037281211122          'or out-of-band. ' +
037282211122          '<br><br>' +
037283211122          '<b><u>Supported transport methods are: </b></u><p>' +
037284211122          'HTTPS (using Internet Explorer, Firefox, or any other web ' +
037285211122          'browser that supports SSL) <br>' +
037286211122          'SFTP using SSH2 (Secure Shell) <br>'+
037287211122          'FTP with TLS/SSL (Port 990 - Implicit) <p>'+
037288211122          '<b><i>Please Note: If using HTTPs you must use ' +
037289211122          'HTTPS://Site Address listed above. ' +
037290211122          'Server will not auto redirect to https. </b></i><p>' +
037291211122          'Should further assistance be required please feel free ' +
037292211122          'to contact AmWINS Group Benefits EFT Support at eft.gb@amwins.com';
037293211122
037301211122
037302211122         CmdString = 'MailTool toAddr(' + toAddr + ') ' +
037303211122           ' Subject(' + q + %Trim( Subject)  + q + ') ' +
037304211122           ' Message(' + q + %Trim( Msg ) + q + ')' +
037305211122           ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
037306211122
037307211122         #Command(CmdString:%len(%Trim(CmdString)));
037309211122
037310211122
037311211122         //----------------------------------------------------
037312211122         //
037313211122         //  Password
037314211122         //
037315211122         //----------------------------------------------------
037316211122
037317211122         Msg = '<p>' +
037318211122          'Your account login credentials have been created or were modified.'+
037319211122          '<br>Your new username and password are provided below: ' +
037320211122          '<p>Site Address: ' + %Trim( s1Url )  +
037321211122          '<p>Site URL: https://' +  %Trim( s1Url )  +
037322211122          '<p>' +
037323211122          'Password: <b>' + %Trim( s1Pass ) + '</b><br>' +
037324211122          'Note: Your Username will be sent in a separate email.' +
037326211122          '<br><br>' +
037327211122          '<b><u>Supported transport methods are: </b></u><p>' +
037328211122          'HTTPS (using Internet Explorer, Firefox, or any other web ' +
037329211122          'browser that supports SSL) <br>' +
037330211122          'SFTP using SSH2 (Secure Shell) <br>'+
037331211122          'FTP with TLS/SSL (Port 990 - Implicit) <p>'+
037332211122          '<b><i>Please Note: If using HTTPs you must use ' +
037333211122          'HTTPS://Site Address listed above. ' +
037334211122          'Server will not auto redirect to https. </b></i><p>' +
037335211122          'Should further assistance be required please feel free ' +
037336211122          'to contact AmWINS Group Benefits EFT Support at eft.gb@amwins.com';
037337211122
037338211122
037339211122         CmdString = 'MailTool toAddr(' + toAddr + ') ' +
037340211122           ' Subject(' + q + %Trim( Subject)  + q + ') ' +
037341211122           ' Message(' + q + %Trim( Msg ) + q + ')' +
037342211122           ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
037343211122
037344211122         #Command(CmdString:%len(%Trim(CmdString)));
037345211122
037346211122
037347211122
037348211122       End-Proc;
037349211122
037350211122
037351211122
037352211122
