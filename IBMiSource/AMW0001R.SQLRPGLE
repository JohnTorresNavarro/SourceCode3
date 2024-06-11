000100221108     H option(*noDebugIo)  DftActGrp(*no)  bnddir('GBSBIND')
000200160928      *-------------------------------------------------------------------------
000300160928      *
000400220412      *  Description: Last Received OE Autoload file
000500211230      *  Programmer.: Jon Allen
000600211230      *  Date.......: 12/30/2021
000700220907      *
000800221110      *   Process:  1. Copy selected file from archive to oe_file/
000900220907      *             2. Retreive next test lib seq#
001000220907      *             3. Build test library
001100220907      *             4. Process the file in test environment
001200220907      *             5. Update processed info
001300170322      *
001400160928      *-------------------------------------------------------------------------
001500160928      * Modifications
001600160928      *
001700190509      * Date         Programmer    Mod      Description
001800160928      *-------------------------------------------------------------------------
001900221220      * 10.19.2022   Jon Allen              inTest - allow processing from
002000221019      *                                     whithin a test environment
002100221220      * 12.20.2022   Jon Allen     kb01     Convert file size to KB
002200230105      * 01.04.2023   Jon Allen     sr01     Added search of ACNAM1
002300230105      * 01.05.2023   Jon Allen     ff01     clear hist if first file selected
002400230105      *                                     by passing a 1 in FF flag to
002500230105      *                                     ft_t001c
002600230216      * 02.16.2023   Jon Allen     en01     Added Open/Closed Program
002700230417      * 03.31.2023   Jon Allen     f001     Added Make First File logic
002800230417      * 04.17.2023   Jon Allen     b001     blank out on new search
002900221220      *
003000160928      *-------------------------------------------------------------------------
003100180322
003200211230       dcl-f amw0001d Workstn
003300190508         HANDLER('PROFOUNDUI(HANDLER)')
003400211230         SFILE( LSTSFL   : rrn  ) ;
003500180323
003600220621       dcl-f amw0001l2 keyed
003700210822         usage( *input : *output : *update : *delete) ;
003800230217
003900230227       dcl-f amw0006l1 keyed  usage( *input ) ;
004000230224
004100230224       dcl-f amw0006P  keyed  usage( *input ) rename(R_AMW0006R:R_6R);
004200220412
004300220412       dcl-f amw0002p  keyed
004400220412         usage( *input : *output : *update : *delete) ;
004500220419
004600220419       dcl-f amw0001p keyed rename(R_AMW0001R:a1_R) prefix(a_)
004700220419         usage( *input : *update ) ;
004800230215
004900220415       dcl-f AccMst keyed usropn
005000200909          ExtDesc('F.ACCMST') ExtFile(*extdesc)  ;
005100220107
005200220107       dcl-f EmailAddr keyed;
005300221031
005400221031       dcl-f gbs0030L1 keyed;
005500221115
005600230331       dcl-f amw0005lf keyed;
005700230331       dcl-f amw0007lf keyed;
005800220415
005900220415       dcl-f TestEnvlf keyed usage(*input) rename(R_TESTENV:R_T) prefix(t_);
006000220415
006100220415       dcl-f TestEnvl2 keyed usage(*input) rename(R_TESTENV:R_2) prefix(t_);
006200161005
006300160218      *--------------------------------------------------------------------
006400220415
006500220415       dcl-ds pgmd
006600190509         ExtName('IOPGMD') PSDS;
006700190509         @pgmq *proc;
006800190509       end-ds;
006900190509
007000221109       dcl-s InTest ind;
007100221109       dcl-s InOther ind;
007200190509       dcl-s hasError ind;
007300190509       dcl-s reLoad Char(1);
007400190509       dcl-s rrn Zoned(5);
007500220104       dcl-s w1TSA Char(10);
007600220104       dcl-s w2TSA Char(12);
007700220104       dcl-s w1RCV Char(8);
007800220104       dcl-s w2RCV Char(10);
007900220104       dcl-s w3RCV Char(8);
008000220907       dcl-s wsrcvt Char(6);
008100220907       dcl-s wwtsa Char(10);
008200221003       dcl-s wtyp  Char(1);
008300221109       dcl-s FltrCnt Zoned(3);
008400221003       dcl-s xContinue  Char(1);
008500221026       dcl-s AMW0001DA Char(150) dtaara;
008600221109       dcl-s RTVMSGF Char(20);
008700221109       Dcl-S RtnMsg varchar(1000);
008800221220
008900221220       dcl-s kb_Size Zoned(15);
009000221220       dcl-s kb_Text Char(10);
009100180920
009200220426       dcl-s pAcct Char(12);
009300220426       dcl-s pAcctName Char(40);
009400221108       Dcl-s userColor  Char(10);
009500211230       Dcl-s Library Char(10);
009600221110       dcl-s Library2 Char(10);
009700221110       dcl-s OE_EASE Char(10);
009800220418       dcl-s Tofile   Char(300);
009900220418       dcl-s Frfile   Char(300);
010000220907
010100220907       dcl-s wdate Zoned(8);
010200220907       dcl-s wtime Zoned(6);
010300200821
010400220124       dcl-s myEmail Char(60);
010500220107
010600200821       dcl-s ok_Cont Char(1);
010700201117       dcl-c q '''';
010800220909       dcl-s FtProcess Char(40) dtaara;
010900220414
011000220414       dcl-s xTrs     char(3);
011100220414       dcl-s xSub     char(3);
011200220414       dcl-s xAct     char(4);
011300220419       dcl-s xDsh     char(1);
011400220419       dcl-s xSeq     char(5);
011500230331       dcl-s xRtn     char(1);
011600230331       dcl-s wRtn     char(1);
011700220415       dcl-s xSet     char(1);
011800220426       dcl-s xLib     char(10);
011900220426       dcl-s xFile    char(150);
012000220426       dcl-s pos      zoned(3);
012100220505       dcl-s  e1Envir  Char(15);
012200220505       dcl-s  e1Libl   Char(10);
012300220505       dcl-s  e1Lib2   Char(10);
012400220505       dcl-s  envColor Char(10);
012500220505       dcl-s  e1Acnm   Char(40);
012600220505
012700220505       dcl-ds OutEnvr  Qualified  ;
012800220505         e1Envir  Char(15);
012900220505         e1Libl   Char(10);
013000220505         e1Lib2   Char(10);
013100220505         envColor Char(10);
013200220505         e1Acnm   Char(40);
013300220505       End-Ds;
013400210512
013500161227      *--------------------------------------------
013600180917      *
013700161227      * Procedures
013800180917      *
013900161227      *--------------------------------------------
014000190508br02  /include *LIBL/QMODSRC,#ChkFncAth         // Check Function Authority
014100221121      /include *LIBL/QMODSRC,#COMMANDPR         // Command
014200221108      /Include *LIBL/QMODSRC,#GetEnvrPr            // Get Environment
014300221108      /Include *LIBL/QMODSRC,#uscolorPr            // User Color
014400220106
014500220106       dcl-pr vwcarftpc1 ExtPgm('VWCARFTPC1') ;
014600220106         FolderName Char(150);
014700220106       end-pr;
014800221121
014900221121       dcl-pr CHKPGMAUTH ExtPgm('CHKPGMAUTH');
015000221121         Program  char(10);
015100221121         Continue char(1);
015200221121       end-pr;
015300220414
015400220414       dcl-pr AMW0003C ExtPgm('AMW0003C');
015500220414         pTrs  char(3);
015600220414         pSub  char(3);
015700220414         pAct  char(4);
015800220414         pLib  char(10);
015900220414         pDsh  char(1);
016000220427         pFil  char(150);
016100221114         pChg  char(1);
016200221114         pFF   char(1);
016300220414         pRtn  char(1);
016400220414       End-Pr;
016500220418
016600230331       dcl-pr AMW0007R ExtPgm('AMW0007R');
016700230331         pTSA Char(10);
016800230331         pToFolder  char(150);
016900230331         pFileName char(150);
017000230331         pRtn  char(1);
017100220418       End-Pr;
017200230331
017300230331       dcl-pr AMW0003C1 ExtPgm('AMW0003C1');
017400230331         pFr   char(150);
017500230331         pTo   char(150);
017600230331       End-Pr;
017700220907
017800220907       dcl-pr FT_I001C ExtPgm('FT_T001C');
017900220907         pLib  char(10);
018000221019         pTyp  char(1);
018100221111         pChg  char(1);
018200221114         pFF   char(1);
018300221111         pTSA  char(10);
018400220907       End-Pr;
018500220415
018600220415       dcl-pr Setestlib ExtPgm('SETESTLIBC');
018700220415         pLib  char(10);
018800220415         pSet  char(1);
018900220415         pRtn  char(1);
019000220415       End-Pr;
019100230403
019200230403       dcl-pr AMW0070R extPgm('AMW0070R');
019300230403         iKey Char(10);
019400230403         iCompName Char(40);
019500230403       End-Pr;
019600230216
019700230216       dcl-pr AMW0060R extPgm('AMW0060R');
019800230216         iKey Char(10);
019900230216         iCompName Char(40);
020000230216       End-Pr;
020100230216       dcl-s iKey Char(10);
020200220415
020300221109       Dcl-DS APIErrorCode Qualified;
020400221109         BytesProvided Int(10) INZ(%size(APIErrorCode));
020500221109         BytesAvailable Int(10) INZ(0);
020600221109         ExceptionID Char(7);
020700221109         Reserved Char(1);
020800221109         ExceptionData char(32767);
020900221109       END-DS;
021000221109
021100221109       Dcl-PR QMHRTVM ExtPgm;
021200221109         MsgInfo char(9999999) options(*varsize);
021300221109         MsgInfoLen Int(10) const;
021400221109         FormatName Char(8) const;
021500221109         MsgID char(7) const;
021600221109         MsgFileName char(20) const;
021700221109         ReplData char(10000) options(*varsize) const;
021800221109         ReplDataLen Int(10) const;
021900221109         ReplSubVal Char(10) const;
022000221109         ReplFormatChar Char(10) const;
022100221109         ErrorCode LikeDS(APIErrorCode);
022200221109
022300221109         // Option Group 1
022400221109         RetrieveOption Char(10) options(*nopass);
022500221109         CCSIdentifier Int(10) options(*nopass);
022600221109         CCSReplData Int(10) options(*nopass);
022700221109       END-PR;
022800221109
022900221109       // Message format data structures
023000221109       Dcl-DS RTVM0100 Qualified INZ;
023100221109         BytRtn Int(10);
023200221109         BytAvl Int(10);
023300221109         RtnMsgLen Int(10);
023400221109         RtnMsgAvl Int(10);
023500221109         RtnHlpLen Int(10);
023600221109         RtnHlpAvl Int(10);
023700221109         Buffer char(32767);
023800221109       END-DS;
023900221109
024000180920      *-----------------------------------------------------------------------
024100180917      *
024200160928      *?Mainline Program
024300180917      *
024400180920      *-----------------------------------------------------------------------
024500220124       Exec Sql
024600220124         Set Option Commit = *None, Naming = *Sys;
024700190508
024800190508       init();
024900190508
025000161223       dou btnExit = *on;
025100160928
025200201117         exsr ClearS1;
025300220104
025400220107         exsr LoadS1;
025500220909
025600220909         in ftProcess;
025700220909         s1DtaAra = ftProcess;
025800180817
025900190508         exsr DisplyS1;
026000190711
026100190711         if btnExit = *on;
026200190711           leave;
026300190711         endif;
026400161223
026500190508         Select;
026600220415
026700221109         when   btnFilters = *on;
026800221109           exfmt Filter;
026900221109           btnFilters = *off;
027000221109           btnAccept = *off;
027100221109
027200221109         when   rmvEnv = *on;
027300221109         exsr Rmv_Env;
027400220909
027500220909         when ClrDtaAra = *on;
027600220909           in *lock ftProcess;
027700220909           ftProcess = '';
027800220909           out ftProcess;
027900220909           clrDtaAra = *off;
028000220909
028100220909           iter;
028200161223
028300190711         other;
028400190711           exsr ReadChanged;
028500161223
028600190711         endsl;
028700161223
028800180920       enddo;
028900160928
029000161223       *inlr = *on;
029100160928
029200180920      *-----------------------------------------------------------------------
029300161222       Begsr ClearS1;
029400160928
029500190711         //?Clear the Subfile
029600190711         ClrSfl = *on;
029700190711         Write LstCtl;
029800190711         ClrSfl = *off;
029900160928
030000190711         rrn = 0;
030100160928
030200180920       Endsr;
030300180920      **-----------------------------------------------------------------------
030400161222       Begsr DisplyS1;
030500221109
030600221109         fltrCnt = 0;
030700221109         FltrName = 'Filters';
030800221109         If ChkShowAll = 'Y';
030900221109           FltrCnt = fltrCnt + 1;
031000221109         EndIf;
031100221109
031200221109         if FltrCnt > 0;
031300221109           fltrName = %Trim( FltrName ) + ' ( ' +  %Char(FltrCnt) + ' )';
031400221109         EndIf;
031500160928
031600190711         DspSfl = *on  ;
031700190711         exfmt  LstCtl ;
031800190711         DspSfl = *off;
031900160928
032000160928       Endsr;
032100180920      *-----------------------------------------------------------------------
032200161222       Begsr LoadS1;
032300220906
032400220906           if oContinue <> 'Y';
032500220906             leaveSR;
032600220906           endif;
032700220415
032800220415           if  not %open(AccMst);
032900220415           open AccMst;
033000220415           endif;
033100210512
033200190711         //----------------------------------------------------
033300220412         //?Load the Subfile
033400190711         //----------------------------------------------------
033500220412
033600220412             if LastRCV = 'Y';
033700220412
033800220412         Setll *loval AMW0002P;
033900220412         dou %Eof(AMW0002P);
034000220412           read(n) AMW0002P;
034100220412
034200220412           if %Eof(AMW0002P);
034300220412             leave;
034400220412           endif;
034500221108
034600221108           select;
034700221108         //?When userColor is blank, stay you are not an AA.
034800221108           when  userColor = ' ';
034900221109           when  chkShowAll = 'Y';
035000221108         //?If you are an AA only show your color.
035100221108           when  userColor <> A1ASSIGN;
035200221108           iter;
035300221108           endsl;
035400220415
035500220415           if  %Subst( Library2 : 1 : 2) = 'AL';
035600220505           chain (Library2) testenvlf;
035700220415           if  T_tetrst <> a1trust or T_tesub# <> a1subno or
035800220415               T_teacct <> a1acctn;
035900220415           iter;
036000220415           endif;
036100220415           endif;
036200220412
036300220415         select;
036400220415         when HidePR = 'N' and DataYN = 'N';
036500220415         exsr LoadData;
036600220415         when HidePR = 'N' and DataYN = 'Y' and A1HASDATA = 'Y';
036700220415         exsr LoadData;
036800220415         when HidePR = 'Y' and %trim(A1PRCUSER) = *blanks and
036900220415              DataYN = 'Y' and A1HASDATA = 'Y';
037000220415         exsr LoadData;
037100220415         when HidePR = 'Y' and %trim(A1PRCUSER) = *blanks and
037200220415              DataYN = 'N';
037300220415         exsr LoadData;
037400220415         endsl;
037500220413
037600220412         // clear   s1search;
037700220412
037800220412         enddo;
037900220412
038000220412             else;
038100220412
038200220621         Setll *hival AMW0001L2;
038300220621         dou %Eof(AMW0001L2);
038400220621           read(n) AMW0001L2;
038500161005
038600220621           if %Eof(AMW0001L2);
038700190711             leave;
038800190711           endif;
038900221108
039000221108           select;
039100221108         //?When userColor is blank, stay you are not an AA.
039200221108           when  userColor = ' ';
039300221109           when  chkShowAll = 'Y';
039400221108         //?If you are an AA only show your color.
039500221108           when  userColor <> A1ASSIGN;
039600221108           iter;
039700221108           endsl;
039800220415
039900220415           if  %Subst( Library2 : 1 : 2) = 'AL';
040000220505           chain (Library2) testenvlf;
040100220415           if  T_tetrst <> a1trust or T_tesub# <> a1subno or
040200220415               T_teacct <> a1acctn;
040300220415           iter;
040400220415           endif;
040500220415           endif;
040600220412
040700220413         select;
040800220415         when HidePR = 'N' and DataYN = 'N';
040900220413         exsr LoadData;
041000220415         when HidePR = 'N' and DataYN = 'Y' and A1HASDATA = 'Y';
041100220415         exsr LoadData;
041200220415         when HidePR = 'Y' and %trim(A1PRCUSER) = *blanks and
041300220415              DataYN = 'Y' and A1HASDATA = 'Y';
041400220413         exsr LoadData;
041500220415         when HidePR = 'Y' and %trim(A1PRCUSER) = *blanks and
041600220415              DataYN = 'N';
041700220415         exsr LoadData;
041800220413         endsl;
041900220413
042000220412         // clear   s1search;
042100220412
042200220412         enddo;
042300220412
042400220412             endif;
042500220412
042600220415           if  %open(AccMst);
042700220415           close AccMst;
042800220415           endif;
042900220412
043000220412       Endsr;
043100220412      *-----------------------------------------------------------------------
043200220412       Begsr LoadData;
043300220413
043400220413          // Load hidden fields
043500220413           s1trust = a1trust;
043600220413           s1subno = a1subno;
043700220413           s1acctn = a1acctn;
043800220413           s1folder  = a1foldpath;
043900220413           s1file    = a1filename;
044000220413           s1rcvdate = a1rcvdate;
044100220413           s1rcvtime = a1rcvtime;
044200220413           s1prcdate = a1prcdate;
044300220413           s1prctime = a1prctime;
044400220413           s1prcuser = a1prcuser;
044500220419           wslibsq = a1libsq;
044600220413           FolderName = %trim(A1FOLDPATH) + %trim(A1FILENAME);
044700220106           chain (a1trust : a1subno : a1acctn ) AccMst;
044800220106           if %Found( AccMSt ) ;
044900220106             wsname = %trim(ACNAM1);
045000221006           Else;
045100221006             wsname = *blanks;
045200220106           EndIf;
045300220104
045400220106           wstsa  = %editc(a1Trust : 'X') + '-' +
045500220106                    %editc(a1Subno : 'X') + '-' +
045600220106                    %editc(a1acctn : 'X') ;
045700221031           wwtsa  = %editc(a1Trust : 'X') +
045800221031                    %editc(a1Subno : 'X') +
045900221031                    %editc(a1acctn : 'X') ;
046000221031
046100221031           chain (wwtsa ) gbs0030l1;
046200221031           if %Found( gbs0030l1) ;
046300221031           wsvend = %trim(FTFILETYP) + ' - ' + %trim(FTPAYVEND);
046400221031           EndIf;
046500200909
046600221102           wsfile = %trim(A1FILENAME);
046700221220
046800221220             kb_size = A1FILSZ / 1000;
046900221220             select;
047000221220             when  kb_Size > 0;
047100221220             kb_Text =  %Char(KB_Size);
047200221220             when  kb_Size = 0;
047300221220             kb_Text = '0';
047400221220             endsl;
047500221220
047600221220             if (A1FILSZ > 0 and kb_Size = 0 );
047700221220             kb_Text = '1';
047800221220             endif;
047900221220             kb_Text = %trim( kb_Text ) + ' KB';
048000220106
048100220104           wsrcvd = %Char(%Date(a1rcvdate:*iso):*Usa);
048200220104           wsrcvt = %Char(%Time(a1rcvtime) :*usa);
048300221108           wsuser = a1prcuser;
048400221108           wsassign = A1ASSIGN;
048500220107
048600220107           if s1Search = *blanks;
048700220621
048800220621           if rrn > 999;
048900220621           leavesr;
049000220621           endif;
049100230227
049200230227           chain (a1Trust:A1Subno:A1Acctn) amw0006l1;
049300230227           if %Found( amw0006l1 ) ;
049400230227           if A6CLOSED = 0;
049500230227           chain (a1filename) amw0005lf;
049600230227           if %Found( amw0005lf ) ;
049700230227             wfirst = 'Y';
049800230227           Else;
049900230227             wfirst = ' ';
050000230227           EndIf;
050100230227           If   A6OPENED = A1RCVDATE;
050200230227           wfirst = 'Y';
050300230227           Else;
050400230227             wfirst = ' ';
050500230227           Endif;
050600230227           Else;
050700230227           If   A6OPENED = A1RCVDATE;
050800230227           wfirst = 'Y';
050900230227           Else;
051000230227           wfirst = ' ';
051100230227           EndIf;
051200230227           EndIf;
051300230227           Else;
051400230227           clear  R_AMW0006R;
051500230227           clear  R_6R;
051600230227           setgt (a1Trust:A1Subno:A1Acctn) amw0006p;
051700230227           readpe (a1Trust:A1Subno:A1Acctn) amw0006p;
051800230227           dow not %eof( amw0006p ) ;
051900230227           Leave;
052000230227           Enddo;
052100230227           EndIf;
052200230331
052300230331        // F001 - Make First File logic
052400230331           if wfirst = ' ';
052500230331           chain (a1filename) amw0007lf;
052600230331           if %Found( amw0007lf ) ;
052700230331             wfirst = %char(A7MAKE);
052800230331           Endif;
052900230331           Endif;
053000230217
053100230217           if A6CLOSED = 0;
053200230217           A6CLOSED = 99999999;
053300230217           endif;
053400230217           if A1RCVDATE >= A6OPENED and A1RCVDATE <= A6CLOSED;
053500220124             rrn = rrn + 1;
053600220124             write LstSfl;
053700230217           endif;
053800180612
053900220107           else;   //?Search Field
054000230417
054100230417             // b001
054200230417             wfirst = *blanks;
054300230417
054400220124             w1tsa  = %editc(a1Trust : 'X') +
054500220124                      %editc(a1Subno : 'X') +
054600220124                      %editc(a1acctn : 'X') ;
054700220107
054800220124             w2tsa  = %editc(a1Trust : 'X') + '-' +
054900220124                      %editc(a1Subno : 'X') + '-' +
055000220124                      %editc(a1acctn : 'X') ;
055100220107
055200220124             w1RCV  = %editc(a1RCVDATE : 'X');
055300220124             w2RCV  = %Char(%Date(a1rcvdate:*iso):*Usa);
055400220124             w3RCV  = %Char( %dec(%char(%date(a1rcvdate:*iso):*usa0):8:0));
055500220107
055600220107
055700220124             if %scan( %Trim(s1Search) : %upper(a1FILENAME) ) > 0 or
055800221108               %Scan( %Trim(s1Search) : %upper(a1FOLDPATH) ) > 0  or
055900230104               %Scan( %Trim(s1Search) : %upper(a1ASSIGN) ) > 0  or
056000230104               %Scan( %Trim(s1Search) : %upper(ACNAM1) ) > 0  or
056100220124               %Scan( %Trim(s1Search) : w1TSA ) > 0       or
056200220124               %Scan( %Trim(s1Search) : w2TSA ) > 0       or
056300220124               %Scan( %Trim(s1Search) : w1RCV ) > 0       or
056400220124               %Scan( %Trim(s1Search) : w2RCV ) > 0       or
056500220124               %Scan( %Trim(s1Search) : w3RCV ) > 0  ;
056600220621
056700220621           if rrn > 999;
056800220621           leavesr;
056900220621           endif;
057000230227
057100230227           chain (a1Trust:A1Subno:A1Acctn) amw0006l1;
057200230227           if %Found( amw0006l1 ) ;
057300230227           if A6CLOSED = 0;
057400230227           chain (a1filename) amw0005lf;
057500230227           if %Found( amw0005lf ) ;
057600230227             wfirst = 'Y';
057700230227           Else;
057800230227             wfirst = ' ';
057900230227           EndIf;
058000230227           If   A6OPENED = A1RCVDATE;
058100230227           wfirst = 'Y';
058200230227           Else;
058300230227             wfirst = ' ';
058400230227           Endif;
058500230227           Else;
058600230227           If   A6OPENED = A1RCVDATE;
058700230227           wfirst = 'Y';
058800230227           Else;
058900230227           wfirst = ' ';
059000230227           EndIf;
059100230227           EndIf;
059200230227           Else;
059300230227           clear  R_AMW0006R;
059400230227           clear  R_6R;
059500230227           setgt (a1Trust:A1Subno:A1Acctn) amw0006p;
059600230227           readpe (a1Trust:A1Subno:A1Acctn) amw0006p;
059700230227           dow not %eof( amw0006p ) ;
059800230227           Leave;
059900230227           Enddo;
060000230227           EndIf;
060100230331
060200230331           if wfirst = ' ';
060300230331           chain (a1filename) amw0007lf;
060400230331           if %Found( amw0007lf ) ;
060500230331             wfirst = %char(A7MAKE);
060600230331           Endif;
060700230331           Endif;
060800220107
060900230217           if A6CLOSED = 0;
061000230217           A6CLOSED = 99999999;
061100230217           endif;
061200230217           if A1RCVDATE >= A6OPENED and A1RCVDATE <= A6CLOSED;
061300220124               rrn = rrn + 1;
061400220124               write LstSfl;
061500230217           endif;
061600220107
061700220107             endif;
061800220107           endif;
061900161005
062000180920       Endsr;
062100161223
062200220415      *-------------------------------------------------------------------------
062300220415       Begsr Rmv_Env;
062400220415
062500220509             If %trim(Library2) <> *blanks and
062600220509              %subst(%trim(Library2):1:2) = 'AL';
062700220415             CmdString = 'RmvLible ' + %trim(Library2) ;
062800220415             #Command(CmdString : %len(%Trim(CmdString))) ;
062900220415             clear Library2;
063000220415             clear R_2;
063100220415             endif;
063200220415
063300220415        Get_Env();
063400220415
063500220415         dspRmv = *off;
063600220415         rmvenv = *off;
063700220415
063800220415       Endsr;
063900161223      *-------------------------------------------------------------------------
064000190711       Begsr ReadChanged;
064100220415
064200220415           if  not %open(AccMst);
064300220415           open AccMst;
064400220415           endif;
064500161223
064600190711         Dou *in95 = *ON;
064700190710           READC LstSfl;
064800190710           *in95 = %EOF;
064900161223
065000190711           If *in95 = *OFF;
065100230216
065200230216             if runOption = 'Open';
065300230216             ikey = %editc(s1Trust : 'X') +
065400230216                    %editc(s1Subno : 'X') +
065500230216                    %editc(s1acctn : 'X') ;
065600230216             AMW0060R( iKey : wsName ) ;
065700230216             EndIf;
065800230403
065900230403             if runOption = 'History';
066000230403             ikey = %editc(s1Trust : 'X') +
066100230403                    %editc(s1Subno : 'X') +
066200230403                    %editc(s1acctn : 'X') ;
066300230403             AMW0070R( iKey : wsName ) ;
066400230403             EndIf;
066500220413
066600220413             if runOption = 'More';
066700220415               btn4Close = *off;
066800220415               btn4Set = *off;
066900220415               btn4SetDsp = *off;
067000220413
067100220413           s4tsa  = %editc(s1Trust : 'X') + '-' +
067200220413                    %editc(s1Subno : 'X') + '-' +
067300220413                    %editc(s1acctn : 'X') ;
067400220415
067500220415             s4libt = 'N/A';
067600220419           Setgt (s1file:99999) testenvl2;
067700220419           Readpe (s1file) testenvl2;
067800220419           if not %eof( testenvl2 ) ;
067900220415             s4libt = %trim(T_TELIBRARY);
068000220415               btn4SetDsp = *on;
068100220415           EndIf;
068200220413
068300220413           chain (s1trust : s1subno : s1acctn ) AccMst;
068400220413           if %Found( AccMSt ) ;
068500220413             s4name = %trim(ACNAM1);
068600221006           Else;
068700221006             s4name = *blanks;
068800220413           EndIf;
068900220413
069000220413           s4folder = %trim(s1folder);
069100220413           s4file   = %trim(s1file);
069200220413
069300220414           s4rdate = %Char(%Date(s1rcvdate:*iso):*Usa);
069400220414           s4rtime = %Char(%Time(s1rcvtime) :*usa);
069500220413
069600220413           if      a1prcdate <> 0;
069700220414           s4pdate = %Char(%Date(s1prcdate:*iso):*Usa);
069800220413           endif;
069900220413           if      a1prctime <> 0;
070000220414           s4ptime = %Char(%Time(s1prctime) :*usa);
070100220413           endif;
070200220413
070300220413           s4puser = a1prcuser;
070400220413
070500220413               dou btn4Close = *on;
070600220413                 exfmt moreInfo;
070700220413
070800220413                 if btn4Close = *on;
070900220413                   leave;
071000220413                 endif;
071100220415
071200220415                 if btn4Set = *on;
071300220415                 xset = 'T';
071400220415                 Setestlib( s4LibT : xSet : xrtn ) ;
071500220415                 Get_Env();
071600220415                 btn4Close = *on;
071700220415                 leave;
071800220415                 endif;
071900220413
072000220413               enddo;
072100220413             endIf;
072200220105
072300220106             if runOption = 'Download';
072400220106               s2FileName = FolderName;
072500220106               exfmt getReport;
072600220106               btnExit = *off;
072700220106             endIf;
072800220105
072900220106             if runOption = 'Email';
073000220124               SendEmail();
073100220107
073200220107               ebtnClose = *off;
073300220107
073400220107               dou ebtnClose = *on;
073500220124                 exfmt emailSent;
073600220107
073700220124                 if ebtnClose = *on;
073800220124                   leave;
073900220124                 endif;
074000220107
074100220124               enddo;
074200220105
074300220106             endIf;
074400220906
074500220908             if runOption = 'Process';
074600220906
074700220906               btn5Close = *off;
074800221114               chkchgOnly = ' ';
074900230316               FirstFile = ' ';
075000230316               MakeFirst = ' ';
075100230331           s4Note = getmessage('MSG0001');
075200230331           s4Note2 = getmessage('MSG0002');
075300220906
075400220906           s4tsa  = %editc(s1Trust : 'X') + '-' +
075500220906                    %editc(s1Subno : 'X') + '-' +
075600220906                    %editc(s1acctn : 'X') ;
075700220906
075800220906           chain (s1trust : s1subno : s1acctn ) AccMst;
075900220906           if %Found( AccMSt ) ;
076000220906             s4name = %trim(ACNAM1);
076100221006           Else;
076200221006             s4name = *blanks;
076300220906           EndIf;
076400220906
076500220906           s4folder = %trim(s1folder);
076600220906           s4file   = %trim(s1file);
076700220906
076800220906           s4rdate = %Char(%Date(s1rcvdate:*iso):*Usa);
076900220906           s4rtime = %Char(%Time(s1rcvtime) :*usa);
077000220906
077100220906               dou btn5Close = *on;
077200220907                 exfmt ProcTest;
077300220906
077400220906               if btn5Proc = *on;
077500220906
077600220906           xtrs = %Editc(s1trust: 'X');
077700220906           xsub = %Editc(s1subno: 'X');
077800220906           xact = %Editc(s1acctn: 'X');
077900220906           xdsh = 'N';
078000220906           xrtn = ' ';
078100220906           xlib = ' ';
078200230331            clear  a7foldpath;
078300230331            clear  a7filename;
078400230331           wrtn = ' ';
078500220906
078600220906               frFile =  %trim(s4folder) + %trim(s4file);
078700220906               toFile =  %trim(s4folder);
078800220906           //  toFile =  %Scanrpl('Archive/': '' : toFile );
078900221110               toFile =  %Scanrpl('Archive/': 'oe_file/' : toFile );
079000220906
079100220906               amw0003c1( frFile : toFile );
079200221019
079300220906           wslibsq = 0;
079400220906           exec sql
079500220906             select max(teseq#)
079600220906               into :wsLibsq
079700220906               from TESTENVP;
079800220906           wsLibsq = wslibsq + 1;
079900220906           xseq = %Editc(wslibsq: 'X');
080000230331
080100220907            chain (s1file:s1folder:s1rcvdate:s1rcvtime) AMW0001P;
080200220907            if %found(AMW0001P);
080300221019           if inTest = *off;
080400220907            a_a1libsq = wsLibsq;
080500221019           endif;
080600220908            a_a1PRCUSER  = wqusrn;
080700220908            a_a1PRCDATE  = wDate;
080800220908            a_a1PRCTIME  = wTime;
080900220907            update a1_R;
081000230331
081100230403            a7foldpath = %trim(s1folder);
081200230403            a7filename = %trim(s1file);
081300230331
081400220907            endif;
081500220907
081600220907            chain (s1trust : s1subno : s1acctn ) AMW0002P;
081700220907            if %found(AMW0002P);
081800221019           if inTest = *off;
081900220908            a1libsq = wsLibsq;
082000221019           endif;
082100220907            a1PRCUSER  = wqusrn;
082200220907            a1PRCDATE  = wDate;
082300220907            a1PRCTIME  = wTime;
082400220907            update R_AMW0002R;
082500220907            endif;
082600221019
082700221026           in *lock AMW0001DA;
082800221026           AMW0001DA = s1file;
082900221026           out AMW0001DA;
083000221111
083100221111             w1tsa  = %editc(s1Trust : 'X') +
083200221111                      %editc(s1Subno : 'X') +
083300221111                      %editc(s1acctn : 'X') ;
083400230331
083500230331          // F001 Create Make First
083600230331           if  MakeFirst = 'Y';
083700230331               amw0007R( w1tsa : A7FOLDPATH : A7FILENAME : wRtn );
083800230331           endif;
083900230105
084000230331          // F001 Make First
084100230331           if  FirstFile = ' ' and wfirst = 'Y' or
084200230331               FirstFile = ' ' and wfirst = '1' or
084300230331               FirstFile = ' ' and MakeFirst = 'Y';
084400230105           FirstFile = '1';
084500230105           endif;
084600221026
084700221109           select;
084800221109           when   inOther = *on;
084900221110           wtyp = 'P';
085000221110           OE_EASE = 'OE_EASE';
085100221114               FT_I001C( OE_EASE : wtyp : chkchgonly : FirstFile : w1tsa) ;
085200221109           other;
085300221019           if inTest = *on;
085400221019           wtyp = 'S';
085500221114               FT_I001C( Library2 : wtyp : chkchgonly : FirstFile : w1tsa) ;
085600221019           else;
085700220907               amw0003c( xtrs : xsub : xact : xlib :
085800221114               xdsh : s1file : chkchgonly: FirstFile: xrtn);
085900221109           endif;
086000221109           endsl;
086100220906
086200220906               jbtnClose = *off;
086300220906
086400220906               dou jbtnClose = *on;
086500220906                 exfmt ProcEmail;
086600220906
086700220906                 if jbtnClose = *on;
086800220906                   btn5Close = *on;
086900220906                   leave;
087000220906                 endif;
087100220906
087200220906               enddo;
087300220906
087400220906               endif;
087500220906
087600220906                 if btn5Close = *on;
087700220906                   leave;
087800220906                 endif;
087900220906
088000220906               enddo;
088100220906
088200220906             endIf;
088300220105
088400220106             runOption = '';
088500220106             update LstSfl;
088600161223
088700201201           endIf;
088800220105
088900220106           Reload = 'Y';
089000161223
089100201201         enddo;
089200220415
089300220415           if  %open(AccMst);
089400220415           close AccMst;
089500220415           endif;
089600220415
089700190710       Endsr;
089800180914
089900210923       //-----------------------------------------------------------------
090000190710       //
090100190710       //                     Initialize Routine
090200190710       //
090300190710       //-----------------------------------------------------------------
090400190711br02   Dcl-Proc Init;
090500220907
090600220907         wDATE  = %Dec(%Date);
090700220907         wTIME  = %Dec(%Time);
090800190508
090900220415         lastRCV = 'N';
091000220415         HidePR  = 'N';
091100220415         DataYN  = 'N';
091200220415         lastCHG = *off;
091300220415         rmvEnv = *off;
091400220415         dspRmv = *off;
091500190509         Reload = 'Y';
091600220104         s1search = *blanks;
091700190508
091800220124         myEmail = '';
091900221108
092000221108         userColor = #uscolor(wqusrn);
092100221108         if wqusrn = 'GBSTEST2';
092200221108         userColor = ' ';
092300221108         EndIf;
092400220107
092500220124         chain wqusrn EmailAddr;
092600220124         if %Found( EmailAddr ) ;
092700220124           myEmail = eaEmail;
092800220124         EndIf;
092900190508
093000190710         // User have all Access?
093100220906         oFunction = ' ';
093200190710         oDspErrMsg = 'N';
093300190508
093400220906         wsmsg = 'YOU DO NOT HAVE AUTHORITY PLEASE CONTACT YOUR MANAGER';
093500221121         //?Check Program Authority
093600221121         ChkPgmAuth(@pgmq: oContinue);
093700190711         if oContinue = 'Y';
093800220906         wsmsg = *blanks;
093900190508         endif;
094000190508
094100220909         // Show / Hide Data Area Line
094200220909
094300220909         oFunction = 'SHOW_DTARA';
094400220909         oDspErrMsg = 'N';
094500220909         HideDtaara = *off;
094600220909
094700221121         ChkFncAuth(@pgmq: oFunction : oDspErrMsg : xContinue);
094800221003         if xContinue = 'Y';
094900220909           HideDtaara = *on;
095000220909         endif;
095100220909
095200190508
095300220106         // Set the Environment
095400210923
095500210923
095600210923
095700220106         //------------------------------
095800220106         // Get the Environment
095900220106         //------------------------------
096000220124         Exec Sql
096100220124           Select Objlo00002
096200220124             Into :Library
096300220124             From
096400220124               Table (
096500220124                 Qsys2.Object_Statistics(
096600220124                   '*LIBL', 'FILE', Object_Name => '"F.ACCMST"')
096700220124               ) As X;
096800210923
096900210923
097000220106         S1Envir = '';
097100220106         if Library = 'GBSDTAT';
097200220106           S1Envir = 'Development';
097300220106         EndIf;
097400210923
097500220415        Get_Env();
097600210923
097700190710       End-Proc;
097800220107       //-----------------------------------------------------------------
097900220107       //
098000220107       //                     Send Email to requester
098100220107       //
098200220107       //-----------------------------------------------------------------
098300220107       Dcl-Proc SendEmail;
098400220107
098500220124         Dcl-s Msg Char(2000);
098600220124         dcl-s Subject Char(100);
098700220124         dcl-s toAddr Char(200);
098800220107
098900220412         dcl-s Attach1 Char(128) ;
099000220107
099100220124         dcl-c q const ('''');
099200220107
099300220124         toAddr = %Trim( myEmail );
099400220107
099500220124         Msg = '*ATT';
099600220107
099700220124         Subject = 'Request: Last Received Autoload file';
099800220107
099900220412         if %Len( %trim( FolderName )) > 128;
100000220412         Attach1 = *blanks;
100100220412         Msg = 'ERROR - Your requested attachment name is too long';
100200220412         else;
100300220412         Msg = 'Your requested file is attached';
100400220124         Attach1 = %trim(FolderName);
100500220412         endif;
100600220107
100700220124         CmdString = 'MailTool toAddr(' + %trim(toAddr) + ') ' +
100800220124            ' Subject(' + q + %Trim( Subject)  + q + ') ' +
100900220124            ' Message(' + q + %Trim( Msg ) + q + ')' +
101000220124            ' Attach( ' + q + %Trim( Attach1 ) + q +  ') ' +
101100220124            ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
101200220107
101300220124         #Command(CmdString:%len(%Trim(CmdString)));
101400220107
101500220107       end-proc;
101600220415       // ----------------------------------------------------------------
101700220415       dcl-proc Get_Env;
101800220415
101900221109         InOther = *on;
102000221109         RTVMSGF = 'AMW0001L  GBSPGM   ';
102100221109
102200221019         InTest = *off;
102300220505           OutEnvr = GetEnvironment(' ');
102400220505           s1envir = outenvr.e1envir;
102500220505           s1libl  = outenvr.e1libl;
102600220505           Library2 = outenvr.e1lib2;
102700220505           s1acnm  = outenvr.e1acnm;
102800220505           envColor = outenvr.envcolor;
102900220505
103000220505         if %trim(Library2) <> *blanks;
103100220509         if %subst(%trim(Library2):1:2) = 'AL';
103200221019         dspRmv = *on;
103300221019         InTest = *on;
103400221109         InOther = *off;
103500221109         RTVMSGF = 'AMW0001T  GBSPGM   ';
103600220509         endif;
103700220505         endif;
103800220415
103900220415       End-Proc;
104000221109       // ----------------------------------------------------------------
104100221109       dcl-proc GetMessage export;
104200221109
104300221109         dcl-pi *n char(125) ;
104400221109           inLine char(7) value ;
104500221109         end-pi ;
104600221109
104700221109
104800221109         QMHRTVM( RTVM0100 :%SIZE(RTVM0100):'RTVM0100'
104900221109           :inLIne
105000221109           :RTVMSGF :'' :0 :'*NO' :'*NO'
105100221109           : APIErrorCode );
105200221109
105300221109
105400221109         RtnMsg = %subst( RTVM0100.Buffer
105500221109           : 1
105600221109           : RTVM0100.RtnMsgLen);
105700221109
105800221109         Return RtnMsg;
105900221109
106000221109
106100221109       end-proc;
106200221109
106300221109       // ----------------------------------------------------------------
106400220415
