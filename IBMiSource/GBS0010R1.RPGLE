000100160811     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200160811    ? *-------------------------------------------------------------------------
000300160811    ? *
000400160811    ? *  Description:  Guardian File Transfer Maintenance
000500160811    ? *  Programmer.:  Brian Rees
000600160811    ? *  Date.......:  12/16/2015
000700160811    ? *
000800160811    ? *-------------------------------------------------------------------------
000900161004    ?FGBS0010D1 CF   E             WORKSTN
001000160810    ?F                                     SFILE(LSTSFL:rrn)
001100160810    ?F                                     INFDS(DSPD)
001200160809
001300160810     FTrsMst    if   e           k disk    ExtDesc('F.TRSMST') ExtFile(*extdesc)
001400160810     FSubMst    if   e           k disk    ExtDesc('F.SUBMST') ExtFile(*extdesc)
001500160810     FAccMst    if   e           k disk    ExtDesc('F.ACCMST') ExtFile(*extdesc)
001600160218      *--------------------------------------------------------------------
001700160809      * Program status data structure
001800160809     D PGMD          ESDS                  EXTNAME(IOPGMD)
001900160809     D  @pgmq            *proc
002000160811
002100160811    ? * Display file data structure
002200160811    ?D DSPD            DS
002300160811     D  Key                  369    369
002400160811     D  Currec               378    379b 0
002500160218
002600160811     d rrn             s              5s 0
002700160811     d HasError        s               n
002800160811
002900160812     d cancel          s              1a
003000160815     d wCount          s              5s 0
003100160812
003200161004     d pTrust          s              3  0
003300161004     d pSub            s              3  0
003400161004     d pAcct           s              4  0
003500161004
003600160811      *--------------------------------------------
003700160811      *?Procedures
003800160811      *--------------------------------------------
003900160811     D/include *LIBL/QMODSRC,#MSGSUBF             // Message Subfile Procedures.
004000160811
004100160812      *?Trust Selection Window
004200160812     D Trust_Window    pr                  extpgm('WN0004R')
004300160812     D   iTrust                       3s 0
004400160812     D   iDescr                      50
004500160812     D   iCancel                      1
004600160812     d iDescr          s             50
004700160812     D iTrust          s              3s 0
004800160812
004900160812      *?Subdivision Selection Window
005000160812     D Sub_Window      pr                  extpgm('WN0005R')
005100160812     D   iTrust                       3s 0
005200160812     D   iSub#                        3s 0
005300160812     D   iDescr                      50
005400160812     D   iCancel                      1
005500160812     D iSub#           s              3s 0
005600160812
005700160812      *?Account Selection Window
005800160812     D Acct_Window     pr                  extpgm('WN0006R')
005900160812     D   iTrust                       3s 0
006000160812     D   iSub#                        3s 0
006100160812     D   iAcct                        4s 0
006200160812     D   iDescr                      40
006300160812     D   iCancel                      1
006400160812     D iAcct           s              4s 0
006500160812     d iDescr40        s             40
006600160812
006700161004    ? *-------------------------------------------------------------------------
006800161004      *?Mainline Program
006900161004    ? *-------------------------------------------------------------------------
007000161004     C     *entry        plist
007100161011     C                   parm                    pCancel           1
007200161011     C                   parm                    pTrust
007300161004     C                   parm                    pSub
007400161004     C                   parm                    pAcct
007500160809
007600160816         *in80 = *off;
007700161011         pCancel = *Blanks;
007800161011
007900160810         Dou *in03 = *on;
008000160811            write MsgCtl;
008100160810            Exfmt Screen1;
008200160811            Exsr RemoveMsg;
008300160818
008400160818            %SubArr(*In : 50 : 7) = *Off;
008500160818            %SubArr(*In : 60 : 7) = *Off;
008600160811
008700160810            if *in03 = *on;
008800161011               pCancel = 'Y';
008900160810               leave;
009000160810            endif;
009100160810
009200160815
009300160815            //?F4=Prompt
009400160812            if *in04 = *on;
009500160815               exsr F4_Windows;
009600160818               iter;
009700160812            endif;
009800160812
009900160812
010000160812
010100160812           //?Validate Data...
010200160810           exsr Validate;
010300160810
010400160815
010500160812           if hasError = *on;
010600160812              iter;
010700160812           endif;
010800160812
010900160812
011000161004           exsr Process;
011100161004           pTrust = s1Trst;
011200161004           pSub = s1Sub#;
011300161004           pAcct = s1Acct;
011400161004           leave;
011500160815
011600160810         enddo;
011700160810
011800160810
011900160809
012000150119       *inlr = *on;
012100160810      *--------------------------------------------------------------------
012200150119
012300160810       Begsr Validate;
012400160810
012500160810          hasError = *off;
012600160810          s1tDesc   = *blanks;
012700160811          s1SubNam = *blanks;
012800160811          s1AcNam1 = *blanks;
012900160815
013000160811
013100160810          //?Trust Number
013200160810          if s1Trst = *Zero;
013300160810             hasError = *on;
013400160810             *in50 = *on;
013500160810             *in60 = *on;
013600160810             msgdata = 'Enter a Trust Number.';
013700160810             exsr SendMsg;
013800160810          Else;
013900160810
014000160810             chain s1Trst TrsMst;
014100160810             if not %Found(TrsMst);
014200160810                *in50 = *on;
014300160810                *in60 = *on;
014400160810                hasError = *on;
014500160810                msgdata = 'The Trust number was not found.';
014600160810                exsr SendMsg;
014700160810             else;
014800160811                s1tDesc = tDescr;
014900160810             endif;
015000160810
015100160810
015200160810             //?Sub Number
015300160810             if s1Sub# = *Zero;
015400160810                hasError = *on;
015500160810                *in51 = *on;
015600160810                *in61 = *on;
015700160810                msgdata = 'Enter a Sub Account Number.';
015800160810                exsr SendMsg;
015900160810             Else;
016000160810
016100160810                chain (s1Trst : s1Sub#) SubMst;
016200160810                if not %Found(SubMst);
016300160810                   hasError = *on;
016400160810                   *in51 = *on;
016500160810                   *in61 = *on;
016600160810                   msgdata = 'The Trust/Sub number was not found.';
016700160810                   exsr SendMsg;
016800160810                else;
016900160810                   s1SubNam = SubNam;
017000160810                EndIf;
017100160810
017200160810             EndIf;
017300160810
017400160810
017500160810             //?Account Number
017600160810             if s1Acct = *Zero;
017700160810                hasError = *on;
017800160810                *in52 = *on;
017900160810                *in62 = *on;
018000160810                msgdata = 'Enter a Account Number.';
018100160810                exsr SendMsg;
018200160810             Else;
018300160810
018400160810                chain (s1Trst : s1Sub# : s1Acct) AccMst;
018500160810                if not %Found(AccMst);
018600160810                   hasError = *on;
018700160810
018800160811                   S1AcNam1 = *Blanks;
018900160810                   hasError = *on;
019000160810                   *in52 = *on;
019100160810                   *in62 = *on;
019200160810                   msgdata = 'The Account number was not found.';
019300160810                   exsr SendMsg;
019400160810                else;
019500160810                   S1AcNam1 = acNam1;
019600160810                Endif;
019700160810             EndIf;
019800160810          endif;
019900160810
020000160816
020100160810       Endsr;
020200160811      *--------------------------------------------------------------------
020300160815       Begsr F4_Windows;
020400160811
020500160815          //?Trust Window
020600160815          if fld1 = 'S1TRST';
020700160815             iTrust = s1Trst;
020800160815             Trust_Window(iTrust : iDescr : Cancel);
020900160815             if Cancel = *Blanks;
021000160815                s1Trst = iTrust;
021100160815                s1tDesc = iDescr;
021200160815                s1Sub# = *zero;
021300160815                s1Acct = *zero;
021400160815             endif;
021500160815             *in60 = *on;
021600160815          endif;
021700160815
021800160815          //?Sub Window
021900160815          if fld1 = 'S1SUB#';
022000160815             iTrust = s1Trst;
022100160815             iSub# = s1Sub#;
022200160815             Sub_Window(iTrust : iSub# : iDescr : Cancel);
022300160815             if Cancel = *Blanks;
022400160815                s1Trst = iTrust;
022500160815                s1Sub# = iSub#;
022600160815                s1tDesc = iDescr;
022700160815                s1Acct = *zero;
022800160815             endif;
022900160815             *in61 = *on;
023000160815          endif;
023100160815
023200160815          //?Account Window
023300160815          if fld1 = 'S1ACCT';
023400160815             iTrust = s1Trst;
023500160815             iSub# = s1Sub#;
023600160815             iAcct = s1Acct;
023700160815             Acct_Window(iTrust : iSub# : iAcct: iDescr40 : Cancel);
023800160815             if Cancel = *Blanks;
023900160815                s1Trst = iTrust;
024000160815                s1Sub# = iSub#;
024100160815                s1Acct = iAcct;
024200160815                s1acNam1 = iDescr40;
024300160815             endif;
024400160815             *in62 = *on;
024500160815          endif;
024600160815
024700160815
024800160815       Endsr;
024900160815      *--------------------------------------------------------------------
025000160815
025100160811       Begsr Process;
025200160815
025300160816
025400160816
025500160811
025600160811       Endsr;
025700160811
025800160811       //------------------------------------------------------
025900160811         Begsr SendMsg;
026000160811
026100160811            messageid = '';
026200160811            qualmsgf   = '';
026300160811
026400160811       //      msgdata     = 'This is an error message';
026500160811
026600160811            msgdtalen  = %len(%trim(msgdata));
026700160811            msgtype    = '*DIAG';
026800160811            callstkent = '*';
026900160811            callstkcnt = 0;
027000160811            messagekey = ' ';
027100160811
027200160811            sndpgmmsg( messageid: qualmsgf:
027300160811                msgdata : msgdtalen: msgtype:
027400160811                callstkent: callstkcnt: messagekey:
027500160811                *null );
027600160811         Endsr;
027700160811
027800160811       //------------------------------------------------------
027900160811         Begsr RemoveMsg;
028000160811
028100160811            messageRmv = '*ALL';
028200160811            callstkent = '*';
028300160811            callstkcnt = 0;
028400160811            messagekey = ' ';
028500160811            clrpgmmsg(
028600160811                callstkent: callstkcnt: messagekey:
028700160811                messageRmv : *null );
028800160811
028900160811         Endsr;
