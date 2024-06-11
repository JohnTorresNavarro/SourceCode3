000100000000     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200000000      *-------------------------------------------------------------------------
000300000000      *
000400000000      *  Description:
000500000000      *  Programmer.:
000600000000      *  Date.......:  04/22/2016
000700000000      *
000800000000      *-------------------------------------------------------------------------
000900000000     FGBS0008D  CF   E             WORKSTN
001000000000     F                                     SFILE(LSTSFL:rrn)
001100000000     F                                     INFDS(DSPD)
001200000000     FSHPLNK    uf a e           k Disk
001300000000     F
001400000000      *-------------------------------------------------------------------------
001500000000
001600000000      * Program status data structure
001700000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001800000000     D  @pgmq            *proc
001900000000
002000000000      * Display file data structure
002100000000     D DSPD            DS
002200000000     D  Key                  369    369
002300000000     D  Currec               378    379b 0
002400000000
002500000000      * Variables
002600000000     D F01             C                   CONST(X'31')
002700000000     D F02             C                   CONST(X'32')
002800000000     D F03             C                   CONST(X'33')
002900000000     D F04             C                   CONST(X'34')
003000000000     D F05             C                   CONST(X'35')
003100000000     D F06             C                   CONST(X'36')
003200000000     D F07             C                   CONST(X'37')
003300000000     D F08             C                   CONST(X'38')
003400000000     D F09             C                   CONST(X'39')
003500000000     D F10             C                   CONST(X'3A')
003600000000     D F11             C                   CONST(X'3B')
003700000000     D F12             C                   CONST(X'3C')
003800000000     D F13             C                   CONST(X'B1')
003900000000     D F14             C                   CONST(X'B2')
004000000000     D F15             C                   CONST(X'B3')
004100000000     D F16             C                   CONST(X'B4')
004200000000     D F17             C                   CONST(X'B5')
004300000000     D F18             C                   CONST(X'B6')
004400000000     D F19             C                   CONST(X'B7')
004500000000     D F20             C                   CONST(X'B8')
004600000000     D F21             C                   CONST(X'B9')
004700000000     D F22             C                   CONST(X'BA')
004800000000     D F23             C                   CONST(X'BB')
004900000000     D F24             C                   CONST(X'BC')
005000000000     D Enter           C                   const(X'F1')
005100160422
005200160422      * For the Calendar
005300160422     d calYear         s              4
005400160422     d calMonth        s              2
005500160422     d calDay          s              2
005600160422     d StartLin        s              3    inz('00')
005700160422     d StartCol        s              3    inz('00')
005800160422
005900160422     D Popup_Cal       pr                  extpgm('UTL2000R')
006000160422     D   $Year                        4
006100160422     D   $Month                       2
006200160422     D   $Day                         2
006300160422     d   $Line                        3
006400160422     d   $Col                         3
006500160422
006600000000
006700000000     d Rrn             s              5s 0 inz
006800000000     d SaveCursPos     S              4S 0
006900000000     d ReLoad          s              1
007000000000     d RcdMode         s             10
007100000000     d hasError        s               n
007200160422     d hldSearch       S                   like(mySearch)
007300160422
007400000000      *--------------------------------------------
007500000000      * Procedures
007600000000      *--------------------------------------------
007700000000     D/COPY *LIBL/QMODSRC,PR0001RPR            // Case Functions
007800000000     D/include *LIBL/QMODSRC,#MSGSUBF          // Message Subfile Procedures.
007900160425
008000160425      *?Procedure to call LaunchURL
008100160425     D LaunchUrl       PR                  ExtPgm('LAUNCHURL')
008200160425     D                              255
008300000000
008400000000      *-------------------------------------------------------------------------
008500000000      * Mainline Program
008600000000      *-------------------------------------------------------------------------
008700000000     C*    *entry        plist
008800000000     C*                  parm                    xxxxx
008900000000
009000000000      /Free
009100000000
009200000000       Dow key <> F03;
009300000000
009400160422         If Reload = 'Y' or HldSearch <> mySearch;
009500160422           HldSearch= mySearch;
009600160422           exsr CLEAR;
009700160422           exsr LOAD;
009800160422           Reload = 'N';
009900160422         endIf;
010000000000
010100160422         exsr DISPLY;
010200000000
010300160422         // Process Selections
010400160422         Select;
010500000000
010600160422         When key = ENTER and Rrn > 0;
010700160422           exsr PROCES;
010800000000
010900160422         EndSl;
011000000000       enddo;
011100000000
011200000000       *inlr = *on;
011300000000
011400160422       // ----------------------------------------------------------------
011500000000       Begsr *Inzsr;
011600000000
011700000000         Reload = 'Y';
011800000000
011900000000       Endsr;
012000000000       // ----------------------------------------------------------------
012100000000       Begsr CLEAR;
012200000000
012300160422         RcdNbr = 1;
012400160422         If SaveCursPos > 0;
012500160422           RcdNbr = SaveCursPos;
012600160422           SaveCursPos = 0;
012700160422         endIf;
012800000000
012900160422         // Clear the Subfile.
013000160422         *in31 = *off;                     // Subfile Display
013100160422         *in32 = *off;                     // Subfile Disp Control
013200160422         *in33 = *on;                      // Subfile Clear
013300000000
013400160422         write LstCtl;
013500000000
013600160422         *in31 = *off;                     // Subfile Display
013700160422         *in32 = *on;                      // Subfile Disp Control
013800160422         *in33 = *off;                     // Subfile Clear
013900160422         rrn = 0;
014000000000
014100000000       Endsr;
014200000000       // ----------------------------------------------------------------
014300000000
014400160422       Begsr Load;
014500000000
014600160422         *in37 = *off;
014700000000
014800000000
014900160422         Setll (*loval) SHPLNK;
015000160422         dou %eof(SHPLNK);
015100160422           read(n) SHPLNK;
015200000000
015300160422           if %eof(SHPLNK);
015400160422             *in37 = *on;
015500160422             leave;
015600160422           endif;
015700000000
015800160422           // Only Load Carrier Plan ID's
015900160422           if slCarPln = *Blanks;
016000160422              iter;
016100160422           EndIf;
016200160422
016300160422           S1CARPLN = SLCARPLN  ;
016400160422           S1DESCR = SLDESCR   ;
016500160422           S1EFFSDT = %Char(%Date(slEffSdt:*iso):*Usa);
016600160422           S1EFFEDT = %Char(%Date(slEffEdt:*iso):*Usa);
016700160422
016800160422           If mySearch = *Blanks;
016900160422              rrn = rrn + 1;
017000160422              write LstSfl;
017100160422           endif;
017200160422
017300160422           If mySearch > *Blanks;
017400160422              mySearch = ucase(mySearch);
017500160422              If %Scan( %Trim(mySearch) : uCase(s1carpln) ) > 0  or
017600160422                 %Scan( %Trim(mySearch) : uCase(s1Descr) ) > 0  or
017700160422                 %Scan( %Trim(mySearch) : s1effSdt ) > 0  or
017800160422                 %Scan( %Trim(mySearch) : s1EffEdt) > 0  ;
017900160422                 rrn = rrn + 1;
018000160422                 write LstSfl;
018100160422              endIf;
018200160422           endIf;
018300160422
018400160422
018500160422
018600160422           If rrn >= 9999;
018700160422             leave;
018800160422           endIf;
018900000000
019000160422         enddo;
019100000000
019200160422       Endsr;
019300000000
019400160422       // ----------------------------------------------------------------
019500160422       Begsr DISPLY;
019600000000
019700160422         If rrn = 0;
019800160422           *in31 = *off;
019900160422           write NoRcd;
020000160422           reload = 'Y';
020100160422         endIf;
020200000000
020300160422         If rrn > 0;
020400160422           write Cmd;
020500160422           *in31 = *on;
020600160422         endIf;
020700000000
020800160422         if RcdNbr > rrn;
020900160422           RcdNbr = rrn;
021000160422         EndIf;
021100000000
021200160422         EXFMT LstCtl;
021300000000
021400000000
021500160422       Endsr;
021600160422       // ----------------------------------------------------------------
021700160422       Begsr PROCES;
021800000000
021900160422         Dou *in95 = *on;
022000160422           Readc LstSfl;
022100160422           *in95 = %eof;
022200000000
022300160422           if *in95 = *Off;
022400160422             SaveCursPos = rrn;
022500000000
022600160422             If s1Opt  = '2';
022700160422               RcdMode = 'Change';
022800160422               Exsr $LoadData;
022900160422               Exsr $EditAcct;
023000160422             Endif;
023100000000
023200000000
023300160422             if s1opt  = '3';        // COPY...
023400160422               RcdMode = 'Add';
023500160422               Exsr $LoadData;
023600160422               Exsr $EditAcct;
023700160422             Endif;
023800000000
023900160422             If s1Opt = '4';
024000160422               chain (S1CARPLN) SHPLNK;
024100000000
024200160422               if %Found(SHPLNK);
024300160422                 delete SHPLNK;
024400000000
024500160422                 If SaveCursPos > 1;
024600160422                   SaveCursPos = SaveCursPos -1;
024700160422                 Endif;
024800160422               Endif;
024900160422             Endif;
025000000000
025100160422             If s1Opt  = '5';
025200160422               RcdMode = 'View';
025300160422               exsr $LoadData;
025400160422               exsr $EditAcct;
025500160422             endIf;
025600000000
025700160422             s1Opt = '';
025800160422             update LstSfl;
025900160422             Reload = 'Y';
026000160422           endIf;
026100000000
026200160422         enddo;
026300160422       Endsr;
026400000000
026500000000       // ----------------------------------------------------------------
026600000000
026700160422       Begsr $LoadData;
026800000000
026900160422         chain (S1CARPLN) SHPLNK;
027000000000
027100160422         if %Found(SHPLNK);
027200160422           S2CARPLN = SLCARPLN  ;
027300160422           S2DESCR = SLDESCR   ;
027400160422           S2METALVL = SLMETALVL ;
027500160422           S2EFFSDT = %Char(%Date(slEffSdt:*iso):*Usa);
027600160422           S2EFFEDT = %Char(%Date(slEffedt:*iso):*Usa);
027700160425           S2Link = slLink;
027800160422         endif;
027900000000
028000160422       Endsr;
028100000000
028200000000       // ----------------------------------------------------------------
028300000000
028400160422       Begsr $EditAcct;
028500000000
028600160422         dou *in12 = *on;
028700160422           write MSGCTL;
028800000000
028900160422           Select;
029000160422           When RcdMode = 'Change';
029100160422             exfmt EditScr;
029200160422           When RcdMode = 'View';
029300160422             exfmt ViewScr;
029400160422           endsl;
029500160422           exsr RemoveMsg;
029600160422           *in50 = *off;
029700000000
029800160425           if key = F11;
029900160425              clear key;
030000160425              LaunchURL(s2Link);
030100160422           EndIf;
030200160425
030300160425           if *in12 = *on;
030400160425             *in12 = *off;
030500160425             leave;
030600160425           EndIf;
030700000000
030800160422           if key = F04;
030900160422                  //?Popup Calendar
031000160422                 if fld = 'S2EFFSDT';
031100160422                   calYear  = %Subst(s2EffSdt: 7 : 4);
031200160422                   calMonth = %Subst(s2EffSdt: 1 : 2);
031300160422                   calDay   = %Subst(s2EffSdt: 4 : 2);
031400160422                   Popup_Cal(calYear : calMonth : calDay :
031500160422                         StartLin : StartCol);
031600160422                   if CalMonth > '0';
031700160422                      s2EffSdt = calMonth + '/' + calDay + '/' + calYear;
031800160422                   endif;
031900160422                   clear key;
032000160422                 EndIf;
032100160422
032200160422                  //?Popup Calendar
032300160422                 if fld = 'S2EFFEDT';
032400160422                   calYear  = %Subst(s2EffEdt: 7 : 4);
032500160422                   calMonth = %Subst(s2EffEdt: 1 : 2);
032600160422                   calDay   = %Subst(s2EffEdt: 4 : 2);
032700160422                   Popup_Cal(calYear : calMonth : calDay :
032800160422                         StartLin : StartCol);
032900160422                   if CalMonth > '0';
033000160422                      s2EffEdt = calMonth + '/' + calDay + '/' + calYear;
033100160422                   endif;
033200160422                   *in64 = *on;
033300160422                   clear key;
033400160422                 EndIf;
033500160422
033600160422                 iter;
033700160422              endif;
033800160422
033900160422
034000160422
034100160422
034200160422           if Key = Enter;
034300160422             exsr Validate;
034400160422             if hasError = *on;
034500160422               iter;
034600160422             EndIf;
034700000000
034800160422             // No Error... Update Files
034900160422             if RcdMode = 'Change';
035000160422               SLCARPLN = S2CARPLN  ;
035100160422               SLDESCR = S2DESCR   ;
035200160422               SLMETALVL = S2METALVL ;
035300160422
035400160422               SLEFFSDT = %dec(%Date(s2effsdt : *usa) );
035500160422               SLEFFEDT = %dec(%Date(s2effedt : *usa) );
035600160422               Update R_SHPLNK  ;
035700160422
035800160422               MsgData ='Record has been Modified.';
035900160422               exsr SendMsg;
036000160422
036100160422
036200160422             Endif;
036300000000
036400000000
036500160422           endif;
036600160422         EndDo;
036700000000
036800160422       Endsr;
036900160422       //------------------------------------------------------
037000160422       Begsr Validate;
037100000000
037200160422         hasError = *off;
037300000000
037400160422       // Error Checking..
037500160422       // hasError = *on;
037600000000
037700160422       // *in50 = *on;
037800160422       // MsgData = 'Plan ' + %Trim(s2Plan) + ' is already in the system.';
037900160422       // exsr SendMsg;
038000000000
038100160422       Endsr;
038200160422       //------------------------------------------------------
038300160422       Begsr SendMsg;
038400000000
038500160422         messageid = '';
038600160422         qualmsgf   = '';
038700000000
038800000000         //      msgdata     = 'This is an error message';
038900000000
039000160422         msgdtalen  = %len(%trim(msgdata));
039100160422         msgtype    = '*DIAG';
039200160422         callstkent = '*';
039300160422         callstkcnt = 0;
039400160422         messagekey = ' ';
039500000000
039600160422         sndpgmmsg( messageid: qualmsgf:
039700160422             msgdata : msgdtalen: msgtype:
039800160422             callstkent: callstkcnt: messagekey:
039900160422             *null );
040000160422       Endsr;
040100000000
040200000000       //------------------------------------------------------
040300160422       Begsr RemoveMsg;
040400000000
040500160422         messageRmv = '*ALL';
040600160422         callstkent = '*';
040700160422         callstkcnt = 0;
040800160422         messagekey = ' ';
040900160422         clrpgmmsg(
041000160422             callstkent: callstkcnt: messagekey:
041100160422             messageRmv : *null );
041200000000
041300160422       Endsr;
