000100221108     H option(*noDebugIo)  DftActGrp(*no)  bnddir('GBSBIND')
000200160928      *-------------------------------------------------------------------------
000300160928      *
000400221205      *  Description: PDF Letters
000500211230      *  Programmer.: Jon Allen
000600221205      *  Date.......: 12/05/2021
000700220907      *
000800170322      *
000900160928      *-------------------------------------------------------------------------
001000160928      * Modifications
001100160928      *
001200190509      * Date         Programmer    Mod      Description
001300160928      *-------------------------------------------------------------------------
001400160928      *-------------------------------------------------------------------------
001500180322
001600221205       dcl-f gbs0087d Workstn
001700190508         HANDLER('PROFOUNDUI(HANDLER)')
001800211230         SFILE( LSTSFL   : rrn  ) ;
001900180323
002000221206       dcl-f pdfletters keyed usropn
002100210822         usage( *input : *output : *update : *delete) ;
002200220412
002300161005
002400160218      *--------------------------------------------------------------------
002500220415
002600220415       dcl-ds pgmd
002700190509         ExtName('IOPGMD') PSDS;
002800190509         @pgmq *proc;
002900190509       end-ds;
003000190509
003100190509       dcl-s reLoad Char(1);
003200190509       dcl-s rrn Zoned(5);
003300221003       dcl-s xContinue  Char(1);
003400180920
003500211230       Dcl-s Library Char(10);
003600221110       dcl-s Library2 Char(10);
003700220418       dcl-s Tofile   Char(300);
003800220418       dcl-s Frfile   Char(300);
003900220907
004000220907       dcl-s wdate Zoned(8);
004100220907       dcl-s wtime Zoned(6);
004200221205       dcl-s w1RCV Char(8);
004300221205       dcl-s w2RCV Char(10);
004400221206       dcl-s w3RCV Char(8);
004500221206       dcl-s oRtn Char(1);
004600200821
004700220107
004800200821       dcl-s ok_Cont Char(1);
004900201117       dcl-c q '''';
005000220414
005100220426       dcl-s pos      zoned(3);
005200220505       dcl-s  e1Envir  Char(15);
005300220505       dcl-s  e1Libl   Char(10);
005400220505       dcl-s  e1Lib2   Char(10);
005500220505       dcl-s  envColor Char(10);
005600220505       dcl-s  e1Acnm   Char(40);
005700220505
005800220505       dcl-ds OutEnvr  Qualified  ;
005900220505         e1Envir  Char(15);
006000220505         e1Libl   Char(10);
006100220505         e1Lib2   Char(10);
006200220505         envColor Char(10);
006300220505         e1Acnm   Char(40);
006400220505       End-Ds;
006500210512
006600161227      *--------------------------------------------
006700180917      *
006800161227      * Procedures
006900180917      *
007000161227      *--------------------------------------------
007100190508br02  /include *LIBL/QMODSRC,#ChkFncAth         // Check Function Authority
007200221121      /include *LIBL/QMODSRC,#COMMANDPR         // Command
007300221205      /Include *LIBL/QMODSRC,#GetEnvrPr         // Get Environment
007400221121
007500221121       dcl-pr CHKPGMAUTH ExtPgm('CHKPGMAUTH');
007600221121         Program  char(10);
007700221121         Continue char(1);
007800221121       end-pr;
007900221206
008000221206       dcl-pr GBS0087C1 ExtPgm('GBS0087C1');
008100221206         pFile char(100);
008200221206         pRtn  char(1);
008300221206       End-Pr;
008400221109
008500180920      *-----------------------------------------------------------------------
008600180917      *
008700160928      *?Mainline Program
008800180917      *
008900180920      *-----------------------------------------------------------------------
009000220124       Exec Sql
009100220124         Set Option Commit = *None, Naming = *Sys;
009200190508
009300190508       init();
009400221208
009500221208         //?Check Program Authority
009600221208         ChkPgmAuth(@pgmq : oContinue);
009700221208         if oContinue = 'N';
009800221208            *inlr = *on;
009900221208            Return;
010000221208         endif;
010100190508
010200161223       dou btnExit = *on;
010300160928
010400201117         exsr ClearS1;
010500220104
010600220107         exsr LoadS1;
010700180817
010800190508         exsr DisplyS1;
010900190711
011000190711         if btnExit = *on;
011100190711           leave;
011200190711         endif;
011300221206
011400221206         if btnFilters = *on;
011500221206           exfmt Filter;
011600221206           btnFilters = *off;
011700221206         endif;
011800161223
011900190711           exsr ReadChanged;
012000161223
012100180920       enddo;
012200160928
012300161223       *inlr = *on;
012400160928
012500180920      *-----------------------------------------------------------------------
012600161222       Begsr ClearS1;
012700160928
012800190711         //?Clear the Subfile
012900190711         ClrSfl = *on;
013000190711         Write LstCtl;
013100190711         ClrSfl = *off;
013200160928
013300190711         rrn = 0;
013400160928
013500180920       Endsr;
013600180920      **-----------------------------------------------------------------------
013700161222       Begsr DisplyS1;
013800160928
013900190711         DspSfl = *on  ;
014000190711         exfmt  LstCtl ;
014100190711         DspSfl = *off;
014200160928
014300160928       Endsr;
014400180920      *-----------------------------------------------------------------------
014500161222       Begsr LoadS1;
014600220906
014700220906           if oContinue <> 'Y';
014800220906             leaveSR;
014900220906           endif;
015000220415
015100210512
015200190711         //----------------------------------------------------
015300220412         //?Load the Subfile
015400190711         //----------------------------------------------------
015500221206
015600221206         if not %open(PDFLETTERS) ;
015700221206            open PDFLETTERS ;
015800221206         endif ;
015900220412
016000221205         Setll *loval PDFLETTERS;
016100221205         dou %Eof(PDFLETTERS);
016200221205           read(n) PDFLETTERS;
016300220412
016400221205           if %Eof(PDFLETTERS);
016500220412             leave;
016600220412           endif;
016700221108
016800220415         exsr LoadData;
016900220413
017000220412         // clear   s1search;
017100220412
017200220412         enddo;
017300221206
017400221206         if %open(PDFLETTERS) ;
017500221206            close PDFLETTERS ;
017600221206         endif ;
017700220412
017800220412       Endsr;
017900220412      *-----------------------------------------------------------------------
018000220412       Begsr LoadData;
018100221206
018200221206         If ChkHideOpn = 'Y' and PDOPNBY <> *blanks;
018300221206         LeaveSR;
018400221206         EndIf;
018500220413
018600221206         If ChkHideArc = 'Y' and PDARCBY <> *blanks;
018700221206         LeaveSR;
018800221206         EndIf;
018900221206
019000221209           HideFolder = *on;
019100221206
019200220413          // Load hidden fields
019300221206           s1fileName  = PDFILENAME;
019400230315           pos = %scan('/testing':PDFILENAME);
019500230315           if pos > 0;
019600230315           s1DispName  = %scanrpl('/pdf_letters/testing/':'':PDFILENAME);
019700230315           else;
019800221208           s1DispName  = %scanrpl('/pdf_letters/':'':PDFILENAME);
019900230315           endif;
020000221205           s1fileDate  = %Char(%Date(PDFileDate:*iso):*Usa);
020100221205           s1OpenBy    = PDOPNBY;
020200221205           if pdopndt > 0;
020300221205           s1OpenDate  = %Char(%Date(PDOPNDT:*iso):*Usa);
020400221205           s1OpenTime  = %Char(%Time(PDOPNTM) :*usa);
020500221206           else;
020600221209           HideFolder = *off;
020700221206           s1OpenDate  = *blanks;
020800221206           s1OpenTime  = *blanks;
020900221205           endif;
021000221208
021100221205           s1ArchBy    = PDARCBY;
021200221205           if pdarcdt > 0;
021300221208           HideFolder = *off;
021400221208           s1fileName  = %scanrpl('s/':'s/archive/':PDFILENAME);
021500221205           s1ArchDate  = %Char(%Date(PDARCDT:*iso):*Usa);
021600221205           s1ArchTime  = %Char(%Time(PDARCTM) :*usa);
021700221206           else;
021800221206           s1ArchDate  = *blanks;
021900221206           s1ArchTime  = *blanks;
022000221205           endif;
022100220107
022200220107           if s1Search = *blanks;
022300220621
022400220621           if rrn > 999;
022500220621           leavesr;
022600220621           endif;
022700180612
022800220124             rrn = rrn + 1;
022900220124             write LstSfl;
023000180612
023100220107           else;   //?Search Field
023200220107
023300221205             w1RCV  = %editc(PDFILEDATE: 'X');
023400221205             w2RCV  = %Char(%Date(PDFILEDATE:*iso):*Usa);
023500221205             w3RCV  = %Char( %dec(%char(%date(PDFILEDATE:*iso):*usa0):8:0));
023600220107
023700221205             if %scan( %Trim(s1Search) : %upper(PDFILENAME) ) > 0 or
023800221205               %Scan( %Trim(s1Search) : %upper(PDOPNBY) ) > 0  or
023900221205               %Scan( %Trim(s1Search) : %upper(PDARCBY) ) > 0  or
024000220124               %Scan( %Trim(s1Search) : w1RCV ) > 0       or
024100220124               %Scan( %Trim(s1Search) : w2RCV ) > 0       or
024200220124               %Scan( %Trim(s1Search) : w3RCV ) > 0  ;
024300220621
024400220621           if rrn > 999;
024500220621           leavesr;
024600220621           endif;
024700220107
024800220124               rrn = rrn + 1;
024900220124               write LstSfl;
025000220107
025100220107             endif;
025200220107           endif;
025300161005
025400180920       Endsr;
025500161223
025600161223      *-------------------------------------------------------------------------
025700190711       Begsr ReadChanged;
025800161223
025900190711         Dou *in95 = *ON;
026000190710           READC LstSfl;
026100190710           *in95 = %EOF;
026200161223
026300190711           If *in95 = *OFF;
026400220105
026500221205             if rtnValue = 'btnView';
026600221206               FileOpened();
026700220106             endIf;
026800221206
026900221206             if rtnValue = 'btnArchive';
027000221206               FileArchive();
027100221206             endIf;
027200220105
027300221205             rtnValue = '';
027400220106             update LstSfl;
027500161223
027600201201           endIf;
027700220105
027800220106           Reload = 'Y';
027900161223
028000201201         enddo;
028100220415
028200190710       Endsr;
028300221205       //-----------------------------------------------------------------
028400221205       //
028500221205       //                     Open the file
028600221205       //
028700221205       //-----------------------------------------------------------------
028800221206       Dcl-Proc FileOpened;
028900221206
029000221206         if not %open(PDFLETTERS) ;
029100221206            open PDFLETTERS ;
029200221206         endif ;
029300221206
029400221206        chain (s1FileName) pdfletters;
029500221206        if   %found(pdfletters);
029600221206        pdopnby = wqusrn;
029700221206        pdopndt = %dec(%date);
029800221206        pdopntm = %dec(%time);
029900221206        update R_PDFLTR;
030000221206        endif;
030100221206
030200221206         if %open(PDFLETTERS) ;
030300221206            close PDFLETTERS ;
030400221206         endif ;
030500180914
030600221205       end-proc;
030700221206       //-----------------------------------------------------------------
030800221206       //
030900221206       //                     Archive the file
031000221206       //
031100221206       //-----------------------------------------------------------------
031200221206       Dcl-Proc FileArchive;
031300221206
031400221206               gbs0087c1( s1FileName : oRtn );
031500221206
031600221206         if oRtn = 'Y';
031700221206
031800221206         if not %open(PDFLETTERS) ;
031900221206            open PDFLETTERS ;
032000221206         endif ;
032100221206
032200221206        chain (s1FileName) pdfletters;
032300221206        if   %found(pdfletters);
032400221206        pdarcby = wqusrn;
032500221206        pdarcdt = %dec(%date);
032600221206        pdarctm = %dec(%time);
032700221206        update R_PDFLTR;
032800221206        endif;
032900221206
033000221206         if %open(PDFLETTERS) ;
033100221206            close PDFLETTERS ;
033200221206         endif ;
033300221206
033400221206         endif ;
033500221206
033600221206       end-proc;
033700210923       //-----------------------------------------------------------------
033800190710       //
033900190710       //                     Initialize Routine
034000190710       //
034100190710       //-----------------------------------------------------------------
034200190711br02   Dcl-Proc Init;
034300221205
034400220907
034500220907         wDATE  = %Dec(%Date);
034600220907         wTIME  = %Dec(%Time);
034700190508
034800190509         Reload = 'Y';
034900220104         s1search = *blanks;
035000221206         FltrName = 'Filters';
035100221220         ChkHideOpn = ' ';
035200221220         ChkHideArc = 'Y';
035300220909
035400220106         //------------------------------
035500220106         // Get the Environment
035600220106         //------------------------------
035700220124         Exec Sql
035800220124           Select Objlo00002
035900220124             Into :Library
036000220124             From
036100220124               Table (
036200220124                 Qsys2.Object_Statistics(
036300220124                   '*LIBL', 'FILE', Object_Name => '"F.ACCMST"')
036400220124               ) As X;
036500210923
036600210923
036700220106         S1Envir = '';
036800220106         if Library = 'GBSDTAT';
036900220106           S1Envir = 'Development';
037000220106         EndIf;
037100210923
037200220415        Get_Env();
037300210923
037400190710       End-Proc;
037500220415       // ----------------------------------------------------------------
037600220415       dcl-proc Get_Env;
037700220415
037800220505           OutEnvr = GetEnvironment(' ');
037900220505           s1envir = outenvr.e1envir;
038000220505           s1libl  = outenvr.e1libl;
038100220505           Library2 = outenvr.e1lib2;
038200220505           s1acnm  = outenvr.e1acnm;
038300220505           envColor = outenvr.envcolor;
038400220415
038500220415       End-Proc;
038600221109
