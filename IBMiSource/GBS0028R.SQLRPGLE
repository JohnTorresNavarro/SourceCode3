000100211028     H option(*noDebugIo)  DftActGrp(*no)    bnddir('GBSBIND')
000200160928      *-------------------------------------------------------------------------
000300160928      *
000400171211      *  Description: File Import Settings
000500161007      *  Programmer.: Brian Rees
000600171211      *  Date.......: 12/11/2017
000700160928      *
000800170322      *
000900160928      *-------------------------------------------------------------------------
001000160928      * Modifications
001100160928      *
001200160928      * Date         Programmer    Mod      Description
001300200113      * 01/13/2020   B.Rees
001400200113      *  Removed the File Type from being updated by this program.
001500200113      *  The filetype will be maintained by GBS0030.
001600200113      *  It still needs to be in this file for the CL's that read it.
001700211012      *
001800211012      * 10/12/2021   B.Rees
001900211012      *  Added a way for Deborah to change the AA from the Formatted
002000211012      *  File Listings...
002100211028      *
002200211028      * 10/28/2021  B.Rees  Added Cost Center Cross Reference Maintenace
002300211207      * 12/07/2021  B.Rees  Added Class Cross Reference Maintenace
002400211209      * 12/9/2021   B.Rees  Removed the AACode File Reference. Not Needed.
002500160928      *-------------------------------------------------------------------------
002600160928      *
002700160928      *
002800160928      *-------------------------------------------------------------------------
002900211011
003000211011       Dcl-f GBS0028D WorkStn
003100211011          Handler('PROFOUNDUI(HANDLER)')
003200211012          SFILE(LstSfl:rrn);
003300211011
003400211011       dcl-f Gbs0028p keyed usage( *update: *Delete: *output);
003500211011       dcl-f Gbs0028e keyed usage( *update: *Delete: *output);
003600211209       // dcl-f aaCode keyed;
003700161005
003800211011
003900211011
004000160218      *--------------------------------------------------------------------
004100161223     d PGMD          ESDS                  EXTNAME(IOPGMD)
004200161227     D  @pgmq            *proc
004300161223
004400161222     d HasError        s               n
004500161222     d ReLoad          s              1
004600161222     d rrn             s              5s 0
004700161222
004800171211     d wTrst           s              3s 0
004900171211     d wSub#           s              3s 0
005000171211     d wAcct           s              4s 0
005100200908
005200210219       dcl-s wTermDt Zoned(8);
005300211011       dcl-s rrn2 zoned(5);
005400211209       // dcl-s wAACode Char(3);
005500211012       dcl-s aaSelected Char(1);
005600211011
005700161227      *--------------------------------------------
005800161227      * Procedures
005900161227      *--------------------------------------------
006000210219      /include *LIBL/QMODSRC,PR0001RPR            // Case Functions
006100210219
006200211011      * Email List
006300171212     D GBS0028R1       pr                  extpgm('GBS0028R1')
006400171212     D   iKey                        10
006500171212     D   iAccountName                40
006600161223
006700180924
006800180924
006900180924       // Plan Cross Reference Maintenance
007000180924       dcl-pr gbs0044R  ExtPgm('GBS0044R');
007100210219         oKey Char(10);
007200180924       end-Pr;
007300180924       dcl-s oKey Char(10);
007400171211
007500211028       // Cost Center Cross Reference Maintenance
007600211028       dcl-pr gbs0077R  ExtPgm('GBS0077R');
007700211028         oKey Char(10);
007800211028       end-Pr;
007900211028
008000211207       // Class Cross Reference Maintenance
008100211207       dcl-pr EaseClasr ExtPgm('EASECLASR');
008200211207         oKey Char(10);
008300211207       end-Pr;
008400211207
008500161005      *-------------------------------------------------------------------------
008600211011      * Mainline Program
008700161005      *-------------------------------------------------------------------------
008800211012       Exec Sql
008900211012         Set Option Commit = *None, Naming = *Sys;
009000161222       Reload = 'Y';
009100161222
009200150902
009300161223       dou btnExit = *on;
009400160928
009500210219         //  if Reload = 'Y';
009600211011         ClearS1();
009700211011         LoadS1();
009800210219         //     Reload = 'N';
009900210219         //  endif;
010000160928
010100211011         DisplyS1();
010200160928
010300210219         if btnExit = *on;
010400210219           leave;
010500210219         endif;
010600161223
010700161223
010800210219         Select;
010900161223
011000210219         when btnRefresh = *on;
011100210219           s1Search = '';
011200210219           iter;
011300210219
011400210219         when  btnAddNew = *on;
011500210219           Clear AddScreen;
011600210219           ReLoad = 'Y';
011700211011           $AddRecord();
011800161223
011900210219         other;
012000211011           ReadChanged();
012100161223
012200210219         endsl;
012300161223
012400161223       enddo;
012500160928
012600161223       *inlr = *on;
012700160928
012800160928      *-------------------------------------------------------------------------
012900211011       dcl-proc ClearS1;
013000160928
013100211011         // Clear the Subfile
013200210219         ClrSfl = *on;
013300210219         Write LstCtl;
013400210219         ClrSfl = *off;
013500160928
013600210219         rrn = 0;
013700160928
013800211011       end-proc;
013900160928      *-------------------------------------------------------------------------
014000211011       dcl-proc DisplyS1;
014100160928
014200210219         exfmt  LstCtl ;
014300160928
014400211011       end-proc;
014500160928      *-------------------------------------------------------------------------
014600211011       dcl-proc  LoadS1;
014700161005
014800210219         //----------------------------------------------------
014900211011         // Load the Subfile.
015000210219         //----------------------------------------------------
015100210219         Setll *loval GBS0028P;
015200210219         dou %Eof(GBS0028P);
015300210219           read(n) GBS0028P;
015400161005
015500210219           if %Eof(GBS0028P);
015600210219             leave;
015700210219           endif;
015800161222
015900210219           s1Account = %Subst(apKey : 1 : 3) + '-' +
016000210219           %Subst(apKey : 4 : 3) + '-' +
016100210219           %Subst(apKey : 7 : 4);
016200171211
016300210219           s1Key = apKey;
016400210219           s1CompName = apCompName;
016500171211
016600210219           s1RunDate = *Blanks;
016700210219           if apLastDate > 0;
016800210219             s1RunDate = %Char(%Date(apLastDate:*iso):*Usa);
016900210219           endif;
017000171211
017100210219           s1RunAuto = apRunAuto;
017200210219           s1FileType = apFileType;
017300171211
017400210219           wTrst = %Dec( %Subst(apKey : 1 : 3) : 3 : 0 );
017500210219           wSub# = %Dec( %Subst(apKey : 4 : 3) : 3 : 0 );
017600210219           wAcct = %Dec( %Subst(apKey : 7 : 4) : 4 : 0 );
017700171211
017800210219           // Use SQL to get the Company Name;
017900211012           Exec Sql
018000211012             Select Acnam1, atrmdt
018100211012               Into :S1actnam, :wTermDt
018200211012               From "F.ACCMST"
018300211012               Where Actrst = :Wtrst And
018400211012                     Acsub# = :Wsub# And
018500211012                     Acacct = :Wacct;
018600171211
018700210219           s1Termed = '';
018800200908
018900210219           if sqlcod <> 0;
019000210219             s1ActNam = '';
019100210219           else;
019200210219             if wTermdt > 0;
019300210219               s1Termed = 'Yes';
019400180125             endif;
019500200908           endif;
019600200908
019700200908
019800210219           if s1Search = '';
019900210219             rrn = rrn + 1;
020000210219             write LstSfl;
020100210219           else;
020200210219
020300210219             if %scan( %Trim(s1Search) : ucase(s1Account)) >  0 or
020400210219                %scan( %Trim(s1Search) : ucase(s1ActNAm)) >  0 or
020500210219                %scan( %Trim(s1Search) : ucase(s1CompName)) >  0 or
020600210219                %scan( %Trim(s1Search) : ucase(s1FileType)) >  0 ;
020700210219
020800210219               rrn = rrn + 1;
020900210219               write LstSfl;
021000210219
021100210219
021200210219             EndIf;
021300210219           EndIf;
021400161223
021500161223
021600210219         enddo;
021700161005
021800161005
021900161005
022000161005
022100211011       end-proc;
022200161223
022300161223      *-------------------------------------------------------------------------
022400211011       dcl-proc  $AddRecord;
022500161223
022600161223
022700210219         dou btnCancel = *on;
022800161223
022900210219           exfmt AddScreen;
023000211011           Validate();
023100210219           if hasError = *on;
023200210219             iter;
023300210219           EndIf;
023400161223
023500210219           if btnAccept = *on;
023600161223
023700210219             apKey = s2Key;
023800210219             apCompName = s2CompName;
023900210219             apLastDate = 0;
024000210219             apRunAuto = s2RunAuto;
024100171211
024200210219             write r_gbs0028;
024300180822
024400210219             // Add Email Records.
024500210219             aeKey = s2Key;
024600210219             aeFileType = 'T';
024700220518             aeEmail = 'payrolledi@amwins.com';
024800210219             write r_gbs0028e;
024900180822
025000210219             aeFileType = 'P';
025100210219             write r_gbs0028e;
025200180822
025300210219             leave;
025400161223
025500210219           EndIf;
025600161223
025700161223
025800210219         EndDo;
025900161223
026000161223
026100211011       end-proc;
026200161223
026300161223      *-------------------------------------------------------------------------
026400211011       dcl-proc  LoadData;
026500161223
026600210219         Clear EditScreen;
026700161223
026800210219         chain s1Key gbs0028P;
026900171211
027000210219         s2Key = apKey;
027100210219         s2CompName = apCompName;
027200210219         s2RunAuto  = apRunAuto;
027300171211
027400161223
027500211011       end-proc;
027600161223      *-------------------------------------------------------------------------
027700211011       dcl-proc  $EditRecord;
027800161223
027900161223
028000211011         LoadData();
028100161223
028200210219         dou btnCancel = *on;
028300161223
028400210219           exfmt EditScreen;
028500161223
028600210219           if btnAccept = *on;
028700210219             chain s2Key gbs0028P;
028800210219             if %Found( gbs0028p ) ;
028900171211
029000210219               apCompName = s2CompName;
029100210219               apLastDate = 0;
029200210219               apRunAuto = s2RunAuto;
029300171211
029400210219               update r_gbs0028;
029500210219             endif;
029600210219             leave;
029700161223
029800210219           EndIf;
029900161223
030000161223
030100210219         EndDo;
030200161223
030300161223
030400211011       end-proc;
030500161007      *-------------------------------------------------------------------------
030600211011       dcl-proc  Validate;
030700161007
030800210219         hasError = *off;
030900161223
031000211011       end-proc;
031100161223
031200161223      *-------------------------------------------------------------------------
031300211011       dcl-proc  ReadChanged;
031400161223
031500210219         Dou *in95 = *ON;
031600210219           READC LstSfl;
031700210219           *in95 = %EOF;
031800161223
031900210219           If *in95 = *OFF;
032000161223
032100210219             If btnEdit = *on;
032200211011               $EditRecord();
032300210219             endIf;
032400161223
032500161223
032600210219             If btnDelete= *on;
032700211011               $DelRecord();
032800210219             endIf;
032900161223
033000171212
033100210219             If btnEmail = *on;
033200210219               GBS0028R1(s1Key : s1ActNam );
033300210219             endIf;
033400171212
033500210219             if runOption = 'PlnxRef';
033600210219               oKey = %scanrpl('-':'':s1Account);
033700210219               gbs0044R(  oKey );
033800210219             EndIf;
033900180924
034000211028             if runOption = 'cntrxRef';
034100211028               oKey = %scanrpl('-':'':s1Account);
034200211028               gbs0077R(  oKey );
034300211028             EndIf;
034400211028
034500211207             if runOption = 'ClassRef';
034600211207               oKey = %scanrpl('-':'':s1Account);
034700211207               EaseClasr(  oKey );
034800211207             EndIf;
034900211207
035000211011
035100180924
035200210219             runOption = '';
035300210219             btnEmail  = *off;
035400210219             btnDelete = *off;
035500210219             btnEdit = *off;
035600210219             update LstSfl;
035700161223
035800210219             Reload = 'Y';
035900210219           endIf;
036000161223
036100161223
036200210219         enddo;
036300211011       end-proc;
036400161223
036500161223
036600161223      *-------------------------------------------------------------------------
036700211011       dcl-proc  $DelRecord;
036800161223
036900161223
037000211011         LoadData();
037100161223
037200210219         dou btnCancel = *on;
037300210219           exfmt Confirm;
037400161223
037500161223
037600210219           if btnAccept = *on;
037700211012             Exec Sql
037800211012               Delete From GBS0028E Where aeKey = :s1Key;
037900211012             Exec Sql
038000211012               Delete From GBS0028P Where apKey = :s1Key;
038100171213
038200210219             leave;
038300210219           EndIf;
038400161223
038500210219         enddo;
038600161223
038700161223
038800211011       end-proc;
038900161223
039000211011
