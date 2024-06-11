000100220505       Ctl-opt option(*nodebugio) DftActGrp(*no) bnddir('GBSBIND');
000200211020
000300211020      *-------------------------------------------------------------------------
000400211020      *
000500231215      *  Description: Duplicate FT Files maintenance
000600220502      *  Programmer.: Jon Allen
000700231215      *  Date.......: 12/15/2023
000800211020      *
000900231215      *  NOTES:  Use this program to remove a record so a file can be
001000231215      *          reprocessed through the queue.  It will not process
001100231215      *          if it exists in this file so remove it first.
001200231215      *
001300231215      *  NOTES:  Init load skips loading data.  You must use Search to get
001400231215      *          data loaded.  By date 12/10/2023 or A3_Con by group.
001500231215      *
001600231215      *  NOTES:  This program is called from GO BREES/REES option 22
001700231215      *
001800211020      *-------------------------------------------------------------------------
001900211020
002000211020      *-------------------------------------------------------------------------
002100211020      *
002200220502      * Declare Files
002300211020      *
002400211020      *-------------------------------------------------------------------------
002500231215       Dcl-f DUP0002D WorkStn
002600220329       Handler('PROFOUNDUI(HANDLER)')
002700220329         SFILE(LstSfl:rrn) ;
002800231215
002900231215       dcl-f gbs0086p keyed usage( *input : *delete ) ;
003000220502
003100211020      *-------------------------------------------------------------------------
003200211020      *
003300211020      * Global Variables
003400211020      *
003500211020      *-------------------------------------------------------------------------
003600220328
003700231215       dcl-s sdate Char(10);
003800220328       dcl-s hasError ind;
003900220329       dcl-s errAccount ind;
004000220408       dcl-s s1protect ind;
004100220407       dcl-s ExitCancel ind;
004200220329
004300220329       dcl-s wRtn     Char(1);
004400220329       dcl-s rrn Zoned(5);
004500220329       dcl-s reload Char(1) inz('Y');
004600220407       dcl-s Library Char(10);
004700220407       dcl-s Library2 Char(10);
004800220505
004900220505       dcl-ds OutEnvr  Qualified  ;
005000220505         e1Envir  Char(15);
005100220505         e1Libl   Char(10);
005200220505         e1Lib2   Char(10);
005300220505         envColor Char(10);
005400220505         e1Acnm   Char(40);
005500220505       End-Ds;
005600220328
005700211026       dcl-ds pgmd
005800211026         ExtName('IOPGMD') PSDS;
005900220408         @pgmq *proc;
006000211026       end-ds;
006100211026
006200211020      *--------------------------------------------
006300211020      *
006400211020      * Procedures
006500211020      *
006600211020      *--------------------------------------------
006700220329
006800220329       /include GBSPGM/QMODSRC,#ChkFncAth           // Check Function Authority
006900220505      /Include *LIBL/QMODSRC,#GetEnvrPr            // Get Environment
007000220505       /include *LIBL/QMODSRC,#COMMANDPR         // Command
007100220502
007200211020      *-------------------------------------------------------------------------
007300211020      *
007400211020      * Mainline Program
007500211020      *
007600211020      *-------------------------------------------------------------------------
007700220329
007800220329       init();
007900211020
008000220328       dou btnCancel = *on;
008100211026
008200220329         if reload = 'Y';
008300220329           ClearS1();
008400220329           LoadS1();
008500220329           reload = 'N';
008600220329         endif;
008700220329
008800220328         Exfmt LSTCTL;
008900211027
009000220329           ReadChangedS1();
009100220311
009200211026       enddo;
009300211026
009400211020
009500211026       *inlr = *on;
009600231215
009700220505
009800220329       // ----------------------------------------------------------------
009900220329       dcl-proc CLEARS1;
010000220329
010100220329         //-------------------------
010200220329         //
010300220329         // Clear the Subfile
010400220329         //
010500220329         //-------------------------
010600220329
010700220329         SflClr = *on;
010800220329         Write LstCtl;
010900220329         SflClr= *off;
011000220329         rrn = 0;
011100220329
011200220329       End-Proc;
011300220329       // ----------------------------------------------------------------
011400220329       Dcl-Proc LoadS1;
011500220329
011600231215           if s1Search <> *blanks;
011700231215
011800231215         Setll *loval GBS0086P;
011900231215         dou %Eof(GBS0086P);
012000231215           read(n) GBS0086P;
012100231215
012200231215           if %Eof(GBS0086P);
012300231215             leave;
012400231215           endif;
012500231215
012600231215           loadData();
012700231215
012800231215         // clear   s1search;
012900231215
013000231215         enddo;
013100231215
013200231215           endif;
013300220329
013400220329       End-Proc;
013500220329
013600220329       // ----------------------------------------------------------------
013700220329       Dcl-Proc ReadChangedS1;
013800220329
013900220329         reload = 'Y';
014000220329
014100220329         Dou *in95 = *ON;
014200220329           READC LstSfl;
014300220329           *in95 = %EOF;
014400220330
014500220404           if btnDLTLIB = *on;
014600220407           eDelete();
014700220404           btnDLTLIB = *off;
014800220502           endIf;
014900220329
015000220329         EndDo;
015100220329
015200220329       End-Proc;
015300220329
015400220329       // ----------------------------------------------------------------
015500220329
015600220407
015700220407       // ----------------------------------------------------------------
015800220407       dcl-proc Get_Env;
015900220505
016000220505           OutEnvr = GetEnvironment(' ');
016100220505
016200220505           s1envir = outenvr.e1envir;
016300220505           s1libl  = outenvr.e1libl;
016400220505           Library2 = outenvr.e1lib2;
016500220505           s1acnm  = outenvr.e1acnm;
016600220505           envColor = outenvr.envcolor;
016700220407
016800220407       End-Proc;
016900220407
017000220407       // ----------------------------------------------------------------
017100220407       dcl-proc eDelete;
017200231215
017300231215          s2FileName = s1DispName;
017400231215          s2Date = s1FileDate;
017500231215          s2Time = s1FileTime;
017600231215
017700231215         dou btnExit4 = *on;
017800231215           Exfmt DLTSCREEN;
017900220407
018000231215         if btnAccept4 = *on;
018100231215
018200231215           pdGroup = %trim(s1DispGrp);
018300231215           pdFile  = %trim(s1DispName);
018400231215           pdHash = %trim(s1Hash);
018500231215
018600231215           chain (pdGroup : pdFile : pdHash) gbs0086p;
018700231215           if %found( gbs0086p) ;
018800231215           delete R_GBS0086;
018900231215           endif;
019000231215
019100231215         btnExit4 = *on;
019200231215         exitcancel = *on;
019300231215         EndIf;
019400231215
019500231215         enddo;
019600231215
019700231215         btnAccept4 = *off;
019800231215         btnExit4 = *off;
019900220407
020000220407       End-Proc;
020100220408       // ----------------------------------------------------------------
020200220408       Dcl-Proc Init;
020300220408
020400220408
020500220408         // User Allowed to Edit?
020600220408         s1Protect = *off;
020700231215         oFunction = 'DELETE';
020800220408         oDspErrMsg = 'N';
020900220408
021000220408         ChkFncAuth(WQpgmn : oFunction : oDspErrMsg : oContinue);
021100220408         if oContinue = 'Y';
021200220408           s1Protect = *on;
021300220408         endif;
021400220408
021500220408         Get_Env();
021600220408
021700220408
021800220408       End-Proc;
021900231215      *-----------------------------------------------------------------------
022000231215       Dcl-Proc loadData;
022100231215
022200231215          // Load hidden fields
022300231215           s1DispGrp = %trim(PDGROUP);
022400231215           s1DispName  = %trim(PDFILE);
022500231215           s1Hash  = %trim(PDHASH);
022600231215           s1FileDate  = %Char(%Date(PDCRTDT:*iso):*Usa);
022700231215           s1FileTime  = %Char(%Time(PDCRTTM) :*usa);
022800231215
022900231215           if s1Search = *blanks;
023000231215
023100231215           else;   //?Search Field
023200231215
023300231215             sdate  = %Char(%Date(PDCRTDT:*iso):*Usa);
023400231215
023500231215             if %scan( %Trim(s1Search) : %upper(PDFILE) ) > 0 or
023600231215               %Scan( %Trim(s1Search) : %trim(%char(PDCRTDT)) ) > 0    or
023700231215               %Scan( %Trim(s1Search) : %trim(Sdate) ) > 0 ;
023800231215
023900231215           if rrn < 999;
024000231215
024100231215               rrn = rrn + 1;
024200231215               write LstSfl;
024300231215
024400231215           endif;
024500231215
024600231215             endif;
024700231215          endif;
024800231215
024900231215       End-Proc;
