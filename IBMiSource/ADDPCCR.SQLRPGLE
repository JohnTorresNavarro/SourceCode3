000100170428     H option(*noDebugIo)
000200160120      *-------------------------------------------------------------------------
000300160120      *
000400170508      *  Description: This program will allow the user to copy an entire
000500170508      *               group of drop down codes.
000600170428      *  Programmer.: B.Rees
000700170428      *  Date.......: 04/28/2017
000800160120      *
000900160120      *-------------------------------------------------------------------------
001000170428     FADDPCCD   CF   E             WORKSTN
001100160120     F                                     INFDS(DSPD)
001200160120     F
001300160120     FTrsMst    if   e           k disk    ExtDesc('F.TRSMST') ExtFile(*extdesc)
001400160120     FSubMst    if   e           k disk    ExtDesc('F.SUBMST') ExtFile(*extdesc)
001500160914     FAccMst    if   e           k disk    ExtDesc('F.ACCMST') ExtFile(*extdesc)
001600170428     FWebPayChp if   e           k disk
001700160120      *-------------------------------------------------------------------------
001800160120
001900160120      * Program status data structure
002000160120     D PGMD          ESDS                  EXTNAME(IOPGMD)
002100160120     D  @pgmq            *proc
002200160120
002300160120      * Display file data structure
002400160120     D DSPD            DS
002500160120     D  Key                  369    369
002600160120     D  Currec               378    379b 0
002700160120
002800160120      * Variables
002900160120     D F03             C                   CONST(X'33')
003000160120     D F04             C                   CONST(X'34')
003100170428     D Enter           C                   const(X'F1')
003200160120
003300170428     d hasError        s               n
003400170428     d SqlStmt         s            700a   inz
003500160914      *--------------------------------------------
003600160914      *?Procedures
003700160914      *--------------------------------------------
003800160120     D/include *LIBL/QMODSRC,#MSGSUBF          // Message Subfile Procedures.
003900160914
004000160914      *?Trust Selection Window
004100160914     D Trust_Window    pr                  extpgm('WN0004R')
004200160914     D   iTrust                       3s 0
004300160914     D   iDescr                      50
004400160914     D   iCancel                      1
004500160914     d iDescr          s             50
004600160914     D iTrust          s              3s 0
004700170428     d Cancel          s              1
004800170428
004900160914      *?Subdivision Selection Window
005000160914     D Sub_Window      pr                  extpgm('WN0005R')
005100160914     D   iTrust                       3s 0
005200160914     D   iSub#                        3s 0
005300160914     D   iDescr                      50
005400160914     D   iCancel                      1
005500160914     D iSub#           s              3s 0
005600160914
005700160914      *?Account Selection Window
005800160914     D Acct_Window     pr                  extpgm('WN0006R')
005900160914     D   iTrust                       3s 0
006000160914     D   iSub#                        3s 0
006100160914     D   iAcct                        4s 0
006200160914     D   iDescr                      40
006300160914     D   iCancel                      1
006400160914     D iAcct           s              4s 0
006500160914     d iDescr40        s             40
006600160914
006700160120      *-------------------------------------------------------------------------
006800160120      *?Mainline Program
006900160120      *-------------------------------------------------------------------------
007000160120       Dow key <> F03;
007100160120
007200170428          write MSGCTL;
007300160120
007400170428          exfmt AddScreen;
007500160120
007600170428          exsr RemoveMsg;
007700170428          %SubArr(*In : 50 : 6) = *Off;
007800170428          %SubArr(*In : 60 : 6) = *Off;
007900161031
008000170428          if *in03 = *on;
008100170428             leave;
008200170428          EndIf;
008300160120
008400170428          //?Prompt Functions..
008500170428          if Key = F04;
008600170428             exsr F4_Windows;
008700170428             iter;
008800170428          endif;
008900160120
009000161031
009100170428          if Key = Enter;
009200170428             exsr Validate;
009300160120
009400170428             if hasError = *on;
009500170428                iter;
009600170428             EndIf;
009700160120
009800170428             // No Error... Update Files
009900170428             SqlStmt =
010000170428               'Insert into WebPayChp Select ' + %char(tTrst) +
010100170428                 ', ' + %Char(tSub#) + ', ' + %Char(tacct) +
010200170428                 ', PCGRPR, PCCODE, PCDESC, PCEMPC, PCPPAY ' +
010300170428                 ', PCPYER, PCHRSW, PCSEQ# FROM webpaychp ' +
010400170428                 ' WHERE PCTRST = ' + %char(fTrst) +
010500170428                 '   and PCSUB# = ' + %Char(fSub#)   +
010600170428                 '   and PCACCT = ' + %Char(facct) ;
010700170428
010800170428
010900170428             //-------------------------
011000170428             // Run the SQL Statement.
011100170428             //-------------------------
011200170428             Exec Sql Prepare D1 From :Sqlstmt ;
011300170428             Exec Sql Execute D1 ;
011400170428
011500170428
011600170428
011700170428
011800170428             Msgdata ='Records have been Added.';
011900170428             exsr SendMsg;
012000170428             leave;
012100170428          endif;
012200170428       EndDo;
012300160120
012400170428       *inlr = *on;
012500170428       //------------------------------------------------------
012600170428       Begsr Validate;
012700160120
012800170428          hasError = *off;
012900160120
013000170428          //-----------------------------------
013100170428          // From Fields...
013200170428          //-----------------------------------
013300170428
013400170428          fTDesc = *blanks;
013500170428          fSDesc = *blanks;
013600170428          fAcNam1 = *blanks;
013700170428
013800170428          //?Trust
013900170428          if fTrst > 0;
014000170428             chain fTrst TrsMst;
014100170428             if %Found(TrsMst);
014200170428                fTDesc = tDescr;
014300170428             else;
014400160120                *in50 = *on;
014500170428                *in60 = *on;
014600160120                hasError = *on;
014700170428                msgData = 'FROM Trust Number was not found.';
014800160120                exsr SendMsg;
014900170428             endif;
015000170428          else;
015100160120             *in50 = *on;
015200170428             *in60 = *on;
015300160120             hasError = *on;
015400170428             msgData = 'FROM Trust Number cannot be zero.';
015500160120             exsr SendMsg;
015600170428          endif;
015700160120
015800170428          //?Sub
015900170428          if fSub# > 0 and fTrst > 0;
016000170428             chain (fTrst : fSub#) SubMst;
016100170428             if %Found(SubMst);
016200170428                fSDesc = SubDsc;
016300170428             else;
016400170428                *in51 = *on;
016500170428                *in61 = *on;
016600160120                hasError = *on;
016700170428                msgData = 'FROM Sub Account Number was not found.';
016800160120                exsr SendMsg;
016900170428             endif;
017000170428          else;
017100160120             *in51 = *on;
017200170428             *in61 = *on;
017300160120             hasError = *on;
017400170428             msgData = 'FROM Sub Account Number cannot be zero.';
017500160120             exsr SendMsg;
017600170428          endif;
017700160120
017800170428          //?Account
017900170428          if fAcct > 0 and fSub# > 0 and fTrst > 0;
018000170428             chain (fTrst : fSub# : fAcct) AccMst;
018100170428             if %Found(AccMst);
018200170428                fAcNam1 = acNam1;
018300170428             else;
018400170428                *in52 = *on;
018500170428                *in62 = *on;
018600170428                hasError = *on;
018700170428                msgData = 'FROM Account was not found.';
018800170428                exsr SendMsg;
018900170428             endif;
019000170428          else;
019100170428             *in52 = *on;
019200170428             *in62 = *on;
019300170428             hasError = *on;
019400170428             msgData = 'FROM Account cannot be zero.';
019500170428             exsr SendMsg;
019600170428          endif;
019700160914
019800160121
019900170428
020000170428          //-----------------------------------
020100170428          // To Fields...
020200170428          //-----------------------------------
020300170428
020400170428          tTDesc = *blanks;
020500170428          tSDesc = *blanks;
020600170428          tAcNam1 = *blanks;
020700170428
020800170428          //?Trust
020900170428          if tTrst > 0;
021000170428             chain tTrst TrsMst;
021100170428             if %Found(TrsMst);
021200170428                tTDesc = tDescr;
021300170428             else;
021400170428                *in53 = *on;
021500170428                *in63 = *on;
021600170428                hasError = *on;
021700170428                msgData = 'TO Trust Number was not found.';
021800170428                exsr SendMsg;
021900170428             endif;
022000170428          else;
022100170428             *in53 = *on;
022200170428             *in63 = *on;
022300170428             hasError = *on;
022400170428             msgData = 'TO Trust Number cannot be zero.';
022500170428             exsr SendMsg;
022600170428          endif;
022700170428
022800170428          //?Sub
022900170428          if tSub# > 0 and tTrst > 0;
023000170428             chain (tTrst : tSub#) SubMst;
023100170428             if %Found(SubMst);
023200170428                tSDesc = SubDsc;
023300170428             else;
023400170428                *in54 = *on;
023500170428                *in64 = *on;
023600170428                hasError = *on;
023700170428                msgData = 'TO Sub Account Number was not found.';
023800170428                exsr SendMsg;
023900170428             endif;
024000170428          else;
024100170428             *in54 = *on;
024200170428             *in64 = *on;
024300170428             hasError = *on;
024400170428             msgData = 'TO Sub Account Number cannot be zero.';
024500170428             exsr SendMsg;
024600170428          endif;
024700170428
024800170428          //?Account
024900170428          if tAcct > 0 and tSub# > 0 and tTrst > 0;
025000170428             chain (tTrst : tSub# : tAcct) AccMst;
025100170428             if %Found(AccMst);
025200170428                tAcNam1 = acNam1;
025300170428             else;
025400170428                *in55 = *on;
025500170428                *in65 = *on;
025600170428                hasError = *on;
025700170428                msgData = 'TO Account was not found.';
025800170428                exsr SendMsg;
025900170428             endif;
026000170428          else;
026100170428             *in55 = *on;
026200170428             *in65 = *on;
026300170428             hasError = *on;
026400170428             msgData = 'TO Account cannot be zero.';
026500170428             exsr SendMsg;
026600170428          endif;
026700170428
026800170428
026900170428
027000170428          // Make sure there are no records in the TO Account
027100170428          // File: WebPayChp
027200170428
027300170428          if *in53 = *off and *in54 = *off and *in55 = *off;
027400170428             chain ( tTrst : tSub# : tAcct) WebPayChp;
027500170428             if %Found(WebPayChp);
027600170428                *in55 = *on;
027700170428                *in65 = *on;
027800170428                hasError = *on;
027900170428                msgData = 'This Account all ready has records in WEBPAYCHP.';
028000170428                exsr SendMsg;
028100170428
028200170428             EndIf;
028300170428          EndIf;
028400170428
028500160120
028600170428       Endsr;
028700160914      *--------------------------------------------------------------------
028800160914       Begsr F4_Windows;
028900160914
029000160914          //?Trust Window
029100170428          if fld = 'FTRST';
029200170428             iTrust = fTrst;
029300160914             Trust_Window(iTrust : iDescr : Cancel);
029400160914             if Cancel = *Blanks;
029500170428                fTrst = iTrust;
029600170428                fTDesc = iDescr;
029700170428                fSub# = *zero;
029800170428                fAcct = *zero;
029900160914             endif;
030000160914             *in61 = *on;
030100160914          endif;
030200160914
030300160914          //?Sub Window
030400170428          if fld = 'FSUB#';
030500170428             iTrust = fTrst;
030600170428             iSub# = fSub#;
030700160914             Sub_Window(iTrust : iSub# : iDescr : Cancel);
030800160914             if Cancel = *Blanks;
030900170428                fTrst = iTrust;
031000170428                fSub# = iSub#;
031100170428                fSDesc = iDescr;
031200170428                fAcct = *zero;
031300160914             endif;
031400160914             *in62 = *on;
031500160914          endif;
031600160914
031700160914
031800160914          //?Account Window
031900170428          if fld = 'FACCT';
032000170428             iTrust = fTrst;
032100170428             iSub# = fSub#;
032200170428             iAcct = fAcct;
032300160914             Acct_Window(iTrust : iSub# : iAcct: iDescr40 : Cancel);
032400160914             if Cancel = *Blanks;
032500170428                fTrst = iTrust;
032600170428                fSub# = iSub#;
032700170428                fAcct = iAcct;
032800170428                facNam1 = iDescr40;
032900160914             endif;
033000160914             *in63 = *on;
033100160914          endif;
033200160914
033300160914
033400170428          //----------------------------------------
033500170428          // To Records...
033600170428          //----------------------------------------
033700170428
033800170428          //?Trust Window
033900170428          if fld = 'TTRST';
034000170428             iTrust = tTrst;
034100170428             Trust_Window(iTrust : iDescr : Cancel);
034200170428             if Cancel = *Blanks;
034300170428                tTrst = iTrust;
034400170428                tTDesc = iDescr;
034500170428                tSub# = *zero;
034600170428                tAcct = *zero;
034700170428             endif;
034800170428             *in63 = *on;
034900170428          endif;
035000170428
035100170428          //?Sub Window
035200170428          if fld = 'TSUB#';
035300170428             iTrust = tTrst;
035400170428             iSub# = tSub#;
035500170428             Sub_Window(iTrust : iSub# : iDescr : Cancel);
035600170428             if Cancel = *Blanks;
035700170428                tTrst = iTrust;
035800170428                tSub# = iSub#;
035900170428                tSDesc = iDescr;
036000170428                tAcct = *zero;
036100170428             endif;
036200170428             *in64 = *on;
036300170428          endif;
036400170428
036500170428
036600170428          //?Account Window
036700170428          if fld = 'TACCT';
036800170428             iTrust = tTrst;
036900170428             iSub# = tSub#;
037000170428             iAcct = tAcct;
037100170428             Acct_Window(iTrust : iSub# : iAcct: iDescr40 : Cancel);
037200170428             if Cancel = *Blanks;
037300170428                tTrst = iTrust;
037400170428                tSub# = iSub#;
037500170428                tAcct = iAcct;
037600170428                tacNam1 = iDescr40;
037700170428             endif;
037800170428             *in65 = *on;
037900170428          endif;
038000170428
038100170428
038200170428
038300160914
038400160914       Endsr;
038500170428       //------------------------------------------------------
038600160120
038700170428       Begsr SendMsg;
038800160120
038900170428          messageid = '';
039000170428          qualmsgf   = '';
039100160120
039200160120
039300170428          msgdtalen  = %len(%trim(msgdata));
039400170428          msgtype    = '*DIAG';
039500170428          callstkent = '*';
039600170428          callstkcnt = 0;
039700170428          messagekey = ' ';
039800160120
039900170428          sndpgmmsg( messageid: qualmsgf:
040000170428              msgdata : msgdtalen: msgtype:
040100170428              callstkent: callstkcnt: messagekey:
040200170428              *null );
040300170428       Endsr;
040400160120
040500160120       //------------------------------------------------------
040600170428       Begsr RemoveMsg;
040700160120
040800170428          messageRmv = '*ALL';
040900170428          callstkent = '*';
041000170428          callstkcnt = 0;
041100170428          messagekey = ' ';
041200170428          clrpgmmsg(
041300170428              callstkent: callstkcnt: messagekey:
041400170428              messageRmv : *null );
041500160120
041600170428       Endsr;
041700160120
