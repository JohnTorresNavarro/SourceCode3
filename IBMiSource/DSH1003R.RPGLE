000100170726     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200160708    ? *-------------------------------------------------------------------------
000300160708    ? *
000400170725    ? *  Description: OMIT From Expiring Report
000500160708      *
000600170629    ? *  Programmer.: Jon Allen
000700170725    ? *  Date.......: 07/25/2017
000800160708    ? *
000900160708    ? *
001000160708    ? *-------------------------------------------------------------------------
001100170725    ?FDSH1003D  CF   E             WORKSTN
001200160926     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001300170726     F                                     SFile(SFL1 : RRN)
001400160926
001500170726     FACCMST    IF   E           K DISK    extfile('F.ACCMST')
001600170731     FPRTREXPF  UF A E           K DISK
001700170818     FPLNAUXL   IF   E           K DISK
001800160708    ? *-------------------------------------------------------------------------
001900170726     D RRN             S              5I 0
002000170726     d hasError        s               n   inz
002100170731     d nopError        s               n   inz
002200170731     d n00Error        s               n   inz
002300170726     d errPlan         s               n   inz
002400170629     d errTrst         s               n   inz
002500170629     d errSub          s               n   inz
002600170731     d errAcct         s               n   inz
002700170731     d p01err          s               n   inz
002800161010
002801200128       dcl-s s1Trst Zoned(3);
002802200128       dcl-s s1Sub  Zoned(3);
002803200128       dcl-s s1Acct Zoned(4);
002804200128       dcl-c digits  '0123456789';
002805200128
002900200128      /COPY *LIBL/QMODSRC,PR0003RPR            // Check Program Authority
003000200128      /include GBSPGM/QMODSRC,#GettokPR
003001200128      /include GBSPGM/QMODSRC,#zFillpr
003002200128
003003200128
003100170726    ? * Program status data structure
003200170726    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003300170726     D  @pgmq            *proc
004300170726
004301200128
004400200128       Dcl-pr WN0011R  ExtPgm('WN0011R');
004401200128         oAcct Char(12);
004402200128         oAcctName Char(40);
004403200128       End-Pr;
004404200128       dcl-s oAcct Char(12);
004405200128       dcl-s oAcctName Char(40);
004406200128
004407200128
004408200128
004409200128
004410200128      *-------------------------------------------------------------------------
004411200128      *
004412200128      * Mainline Program
004413200128      *
004414200128      *-------------------------------------------------------------------------
004415200128
004500200128       btnView = *Off;
004600200128       btnBACK = *Off;
004700160708
004800200128       //?Stay unless exit is clicked
004900200128       Dou btnExit = *on;
005000200128         Exfmt Screen1;
005100160922
005200200128         //?If exit button leave
005300200128         if btnExit = *on;
005400200128           leave;
005500200128         endif;
005600160926
005601200128
005602200128
005603200128         //----------------------------------------
005604200128         //
005605200128         // Searching for an account
005606200128         //
005607200128         //----------------------------------------
005608200128         if SrchAcct = *on;
005609200128
005610200128           wn0011r( oAcct : oAcctName );
005611200128           if oAcct > '';
005612200128             s1ActNbr = oAcct;
005613200128             ActChgd = *on;
005614200128           EndIf;
005615200128
005616200128           if oAcct = '';
005617200128             iter;
005618200128           EndIf;
005619200128
005620200128         EndIf;
005621200128
005622200128
005623200128
005624200128         //----------------------------------------
005625200128         //
005626200128         // Account Number Changed?
005627200128         //
005628200128         //----------------------------------------
005629200128         if ActChgd = *on;
005630200128
005631200128           Check_AccountNbr();
005632200128           Load_Plans();
005633200128              iter;
005634200128         EndIf;
005635200128
005636200128
005700200128         //?Check for Errors
005800200128         //    if btnView = *off;
005900200128         exsr Validate;
006000200128         //    endif;
006100161103
006200200128         //?If TSA error then show error popup
006300200128         if hasError = *on ;
006400200128           exfmt TSAerror ;
006500200128           if errClose = *on ;
006600200128           endif;
006700200128         endif;
006800170629
006900200128         //?If PLN error then show error popup
007000200128         if nopError = *on ;
007100200128           exfmt PLNerror ;
007200200128           if errClose = *on ;
007300200128           endif;
007400200128         endif;
007500170731
007600200128         //?If Invalid PLN error then show error popup
007700200128         if n00Error = *on ;
007800200128           exfmt PLANerror ;
007900200128           if errClose = *on ;
008000200128           endif;
008100200128         endif;
008200170726
008300200128         //?If Add clicked and no errors, add plans
008400200128         if btnAdd = *on and hasError = *off and nopError = *off and
008500200128            btnView = *off and n00error = *off;
008600200128           exsr addPlan;
008700200128           exfmt PlanAdd;
008800170726         //  leave;
008900200128         else;
009000200128         //    trs = *blanks;
009100200128         //    sub = *blanks;
009200200128         //    act = *blanks;
009300200128         endif;
009400170629
009500170726
009600200128         //?If View clicked and no errors, View plans
009700200128         if btnView = *on and hasError = *off and nopError = *off and
009800200128            btnAdd = *off;
009900200128           exsr ViewPlan;
010000200128           btnView = *Off;
010100170726
010200170726
010300200128           DoW btnBACK = *Off;
010400170726
010500200128             // Clear the subfile.
010600200128             SFLCLR = *On;
010700200128             Write VIEWTSA;
010800200128             SFLCLR = *Off;
010900200128             RRN = 0;
011000170726
011100200128             // Load the subfile.
011200200128             SetLL (S1TRST:S1SUB:S1ACCT) PRTREXPF;
011300200128             Reade(n) (S1TRST:S1SUB:S1ACCT) PRTREXPF;
011400200128             DoW Not %EOF(PRTREXPF);
011500170726
011600200128               RRN += 1;
011700200128               Write SFL1;
011800170726
011900200128               Reade(n) (S1TRST:S1SUB:S1ACCT) PRTREXPF;
012000200128             EndDo;
012100170726
012200200128             // Display the subfile.
012300200128             SFLDSP = *On;
012400200128             ExFmt VIEWTSA;
012500170726
012600170726
012700200128             readc SFL1;
012800200128             if not %eof();
012900170726
013000200128               delete (S1TRST:S1SUB:S1ACCT:RXPLN) PRTREXPF;
013100170726
013200200128             endif;
013300170726
013400170726             //?If exit button leave
013500170726             if btnBack = *on;
013600200128               btnExit = *off;
013700170726             endif;
013800160926
013900200128           enddo;
014000200128         endif;
014100200128         btnBack = *off;
014200200128       enddo;
014300160922
014400170630       eval *inlr = *on;
014500170630       return;
014600160926      *-------------------------------------------------------------------------
014700160926       Begsr Validate;
014800160926
014900200128         hasError = *off;
015000200128         nopError = *off;
015100200128         n00Error = *off;
015200160926
015300200128         errTrst = *off;
015400200128         errSub  = *off;
015500200128         errAcct = *off;
015600200128         errPlan = *off;
015700200128         p01err  = *off;
015800200128         invplan01 = *blanks;
015900200128         invplan02 = *blanks;
016000200128         invplan03 = *blanks;
016100160926
016200200128         //?Trust Number.
016300200128         if s1Trst = *Zero;
016400200128           hasError = *on;
016500200128           errTrst = *on;
016600200128         endif;
016700160926
016800200128         //?Sub Account Number.
016900200128         if s1Sub = *Zero;
017000200128           hasError = *on;
017100200128           errSub = *on;
017200200128         endif;
017300160926
017400200128         //?Account Number.
017500200128         if s1Acct = *Zero;
017600200128           hasError = *on;
017700200128           errAcct = *on;
017800200128         endif;
017900170726
018000200128         //?Plan Number.
018100200128         if btnView = *off;
018200200128           if plan01 = *blanks;
018300170726             nopError = *on;
018400170726             errPlan = *on;
018500200128           endif;
018600200128         endif;
018700170731
018800200128         //?Invalid Plan Number.
018900200128         if btnView = *off;
019000200128           if plan01 <> *blanks;
019100170818             chain (s1trst:s1sub:s1acct:plan01) plnauxl;
019200170818             if not %found;
019300200128               n00Error = *on;
019400200128               p01err = *on;
019500200128               select ;
019600200128               when invplan01 = *blanks;
019700200128                 invplan01 = plan01;
019800200128               when invplan02 = *blanks;
019900200128                 invplan02 = plan01;
020000200128               when invplan03 = *blanks;
020100200128                 invplan03 = plan01;
020200200128               endsl;
020300170804             endif;
020400200128           endif;
020500200128         endif;
020600160926
020700200128         if btnView = *off;
020800200128           if plan02 <> *blanks;
020900170818             chain (s1trst:s1sub:s1acct:plan01) plnauxl;
021000170818             if not %found;
021100200128               n00Error = *on;
021200200128               p01err = *on;
021300200128               select ;
021400200128               when invplan01 = *blanks;
021500200128                 invplan01 = plan02;
021600200128               when invplan02 = *blanks;
021700200128                 invplan02 = plan02;
021800200128               when invplan03 = *blanks;
021900200128                 invplan03 = plan02;
022000200128               endsl;
022100170818             endif;
022200200128           endif;
022300200128         endif;
022400170731
022500200128         if btnView = *off;
022600200128           if plan03 <> *blanks;
022700170818             chain (s1trst:s1sub:s1acct:plan01) plnauxl;
022800170818             if not %found;
022900200128               n00Error = *on;
023000200128               p01err = *on;
023100200128               select ;
023200200128               when invplan01 = *blanks;
023300200128                 invplan01 = plan03;
023400200128               when invplan02 = *blanks;
023500200128                 invplan02 = plan03;
023600200128               when invplan03 = *blanks;
023700200128                 invplan03 = plan03;
023800200128               endsl;
023900170731             endif;
024000200128           endif;
024100200128         endif;
024200170731
024300200128         if btnView = *off;
024400200128           if plan04 <> *blanks;
024500170818             chain (s1trst:s1sub:s1acct:plan01) plnauxl;
024600170818             if not %found;
024700200128               n00Error = *on;
024800200128               p01err = *on;
024900200128               select ;
025000200128               when invplan01 = *blanks;
025100200128                 invplan01 = plan04;
025200200128               when invplan02 = *blanks;
025300200128                 invplan02 = plan04;
025400200128               when invplan03 = *blanks;
025500200128                 invplan03 = plan04;
025600200128               endsl;
025700170804             endif;
025800200128           endif;
025900200128         endif;
026000170731
026100200128         if btnView = *off;
026200200128           if plan05 <> *blanks;
026300170818             chain (s1trst:s1sub:s1acct:plan01) plnauxl;
026400170818             if not %found;
026500200128               n00Error = *on;
026600200128               p01err = *on;
026700200128               select ;
026800200128               when invplan01 = *blanks;
026900200128                 invplan01 = plan05;
027000200128               when invplan02 = *blanks;
027100200128                 invplan02 = plan05;
027200200128               when invplan03 = *blanks;
027300200128                 invplan03 = plan05;
027400200128               endsl;
027500170731             endif;
027600200128           endif;
027700200128         endif;
027800170731
027900200128         if btnView = *off;
028000200128           if plan06 <> *blanks;
028100170818             chain (s1trst:s1sub:s1acct:plan01) plnauxl;
028200170818             if not %found;
028300200128               n00Error = *on;
028400200128               p01err = *on;
028500200128               select ;
028600200128               when invplan01 = *blanks;
028700200128                 invplan01 = plan06;
028800200128               when invplan02 = *blanks;
028900200128                 invplan02 = plan06;
029000200128               when invplan03 = *blanks;
029100200128                 invplan03 = plan06;
029200200128               endsl;
029300170804             endif;
029400200128           endif;
029500200128         endif;
029600170731
029700200128         if btnView = *off;
029800200128           if plan07 <> *blanks;
029900170818             chain (s1trst:s1sub:s1acct:plan01) plnauxl;
030000170818             if not %found;
030100200128               n00Error = *on;
030200200128               p01err = *on;
030300200128               select ;
030400200128               when invplan01 = *blanks;
030500200128                 invplan01 = plan07;
030600200128               when invplan02 = *blanks;
030700200128                 invplan02 = plan07;
030800200128               when invplan03 = *blanks;
030900200128                 invplan03 = plan07;
031000200128               endsl;
031100170804             endif;
031200200128           endif;
031300200128         endif;
031400170731
031500200128         if btnView = *off;
031600200128           if plan08 <> *blanks;
031700170818             chain (s1trst:s1sub:s1acct:plan01) plnauxl;
031800170818             if not %found;
031900200128               n00Error = *on;
032000200128               p01err = *on;
032100200128               select ;
032200200128               when invplan01 = *blanks;
032300200128                 invplan01 = plan08;
032400200128               when invplan02 = *blanks;
032500200128                 invplan02 = plan08;
032600200128               when invplan03 = *blanks;
032700200128                 invplan03 = plan08;
032800200128               endsl;
032900170818             endif;
033000200128           endif;
033100200128         endif;
033200170731
033300200128         if btnView = *off;
033400200128           if plan09 <> *blanks;
033500170818             chain (s1trst:s1sub:s1acct:plan01) plnauxl;
033600170818             if not %found;
033700200128               n00Error = *on;
033800200128               p01err = *on;
033900200128               select ;
034000200128               when invplan01 = *blanks;
034100200128                 invplan01 = plan09;
034200200128               when invplan02 = *blanks;
034300200128                 invplan02 = plan09;
034400200128               when invplan03 = *blanks;
034500200128                 invplan03 = plan09;
034600200128               endsl;
034700170804             endif;
034800200128           endif;
034900200128         endif;
035000170731
035100200128         if btnView = *off;
035200200128           if plan10 <> *blanks;
035300170818             chain (s1trst:s1sub:s1acct:plan01) plnauxl;
035400170818             if not %found;
035500200128               n00Error = *on;
035600200128               p01err = *on;
035700200128               select ;
035800200128               when invplan01 = *blanks;
035900200128                 invplan01 = plan10;
036000200128               when invplan02 = *blanks;
036100200128                 invplan02 = plan10;
036200200128               when invplan03 = *blanks;
036300200128                 invplan03 = plan10;
036400200128               endsl;
036500170804             endif;
036600200128           endif;
036700200128         endif;
036800170731
036900200128         if invplan01 <> *blanks and
037000200128            invplan02 <> *blanks and
037100200128            invplan03 <> *blanks;
037200200128           leavesr;
037300200128         endif;
037400170731
037500160926
037600160926       Endsr;
037700170726      *-------------------------------------------------------------------------
037800170726     C     ViewPlan      begsr
037900170726     C                   eval      wtsa = %editc(s1TRST: 'X') + '-' +
038000170726     C                             %editc(s1sub: 'X') + '-' +
038100170726     C                             %editc(s1acct: 'X')
038200170726     C                   move      s1trst        RXTRS
038300170726     C                   move      s1sub         RXSUB
038400170726     C                   move      s1acct        RXACT
038500170726     C     ACCKEY        chain     ACCMSt
038600170726
038700170726     C     ACCKEY        klist
038800170726     C                   kfld                    RXTRS
038900170726     C                   kfld                    RXSUB
039000170726     C                   kfld                    RXACT
039100170726
039200170726     C                   endsr
039300170629      *-------------------------------------------------------------------------
039400170726     C     AddPlan       begsr
039500170726
039600170726     C     PLNKEY        klist
039700170726     C                   kfld                    RXTRS
039800170726     C                   kfld                    RXSUB
039900170726     C                   kfld                    RXACT
040000170726     C                   kfld                    RXPLN
040100170726
040200170726     C                   if        PLAN01 <> *blanks
040300170726     C                   move      s1trst        RXTRS
040400170726     C                   move      s1sub         RXSUB
040500170726     C                   move      s1acct        RXACT
040600170726     C                   move      PLAN01        RXPLN
040700170726     C     PLNKEY        chain     PRTREXPF
040800170726     C                   if        not %found(PRTREXPF)
040900170726     C                   write     PRTREXR
041000170726     C                   end
041100170726     C                   end
041200170726
041300170726     C                   if        PLAN02 <> *blanks
041400170726     C                   move      s1trst        RXTRS
041500170726     C                   move      s1sub         RXSUB
041600170726     C                   move      s1acct        RXACT
041700170726     C                   move      PLAN02        RXPLN
041800170726     C     PLNKEY        chain     PRTREXPF
041900170726     C                   if        not %found(PRTREXPF)
042000170726     C                   write     PRTREXR
042100170726     C                   end
042200170726     C                   end
042300170726
042400170726     C                   if        PLAN03 <> *blanks
042500170726     C                   move      s1trst        RXTRS
042600170726     C                   move      s1sub         RXSUB
042700170726     C                   move      s1acct        RXACT
042800170726     C                   move      PLAN03        RXPLN
042900170726     C     PLNKEY        chain     PRTREXPF
043000170726     C                   if        not %found(PRTREXPF)
043100170726     C                   write     PRTREXR
043200170726     C                   end
043300170726     C                   end
043400170726
043500170726     C                   if        PLAN04 <> *blanks
043600170726     C                   move      s1trst        RXTRS
043700170726     C                   move      s1sub         RXSUB
043800170726     C                   move      s1acct        RXACT
043900170726     C                   move      PLAN04        RXPLN
044000170726     C     PLNKEY        chain     PRTREXPF
044100170726     C                   if        not %found(PRTREXPF)
044200170726     C                   write     PRTREXR
044300170726     C                   end
044400170726     C                   end
044500170726
044600170726     C                   if        PLAN05 <> *blanks
044700170726     C                   move      s1trst        RXTRS
044800170726     C                   move      s1sub         RXSUB
044900170726     C                   move      s1acct        RXACT
045000170726     C                   move      PLAN05        RXPLN
045100170726     C     PLNKEY        chain     PRTREXPF
045200170726     C                   if        not %found(PRTREXPF)
045300170726     C                   write     PRTREXR
045400170726     C                   end
045500170726     C                   end
045600170726
045700170726     C                   if        PLAN06 <> *blanks
045800170726     C                   move      s1trst        RXTRS
045900170726     C                   move      s1sub         RXSUB
046000170726     C                   move      s1acct        RXACT
046100170726     C                   move      PLAN06        RXPLN
046200170726     C     PLNKEY        chain     PRTREXPF
046300170726     C                   if        not %found(PRTREXPF)
046400170726     C                   write     PRTREXR
046500170726     C                   end
046600170726     C                   end
046700170726
046800170726     C                   if        PLAN07 <> *blanks
046900170726     C                   move      s1trst        RXTRS
047000170726     C                   move      s1sub         RXSUB
047100170726     C                   move      s1acct        RXACT
047200170726     C                   move      PLAN07        RXPLN
047300170726     C     PLNKEY        chain     PRTREXPF
047400170726     C                   if        not %found(PRTREXPF)
047500170726     C                   write     PRTREXR
047600170726     C                   end
047700170726     C                   end
047800170726
047900170726     C                   if        PLAN08 <> *blanks
048000170726     C                   move      s1trst        RXTRS
048100170726     C                   move      s1sub         RXSUB
048200170726     C                   move      s1acct        RXACT
048300170726     C                   move      PLAN08        RXPLN
048400170726     C     PLNKEY        chain     PRTREXPF
048500170726     C                   if        not %found(PRTREXPF)
048600170726     C                   write     PRTREXR
048700170726     C                   end
048800170726     C                   end
048900170726
049000170726     C                   if        PLAN09 <> *blanks
049100170726     C                   move      s1trst        RXTRS
049200170726     C                   move      s1sub         RXSUB
049300170726     C                   move      s1acct        RXACT
049400170726     C                   move      PLAN09        RXPLN
049500170726     C                   write     PRTREXR
049600170726     C                   end
049700170726
049800170726     C                   if        PLAN10 <> *blanks
049900170726     C                   move      s1trst        RXTRS
050000170726     C                   move      s1sub         RXSUB
050100170726     C                   move      s1acct        RXACT
050200170726     C                   move      PLAN10        RXPLN
050300170726     C     PLNKEY        chain     PRTREXPF
050400170726     C                   if        not %found(PRTREXPF)
050500170726     C                   write     PRTREXR
050600170726     C                   end
050700170726     C                   end
050800170726
050900170726     C                   eval      PLAN01 = *blanks
051000170726     C                   eval      PLAN02 = *blanks
051100170726     C                   eval      PLAN03 = *blanks
051200170726     C                   eval      PLAN04 = *blanks
051300170726     C                   eval      PLAN05 = *blanks
051400170726     C                   eval      PLAN06 = *blanks
051500170726     C                   eval      PLAN07 = *blanks
051600170726     C                   eval      PLAN08 = *blanks
051700170726     C                   eval      PLAN09 = *blanks
051800170726     C                   eval      PLAN10 = *blanks
051900170726
052000170629     C                   endsr
052100200128       // ----------------------------------------------------------------
052200170726       Begsr *Inzsr;
052300170726
052400170726         //?Check Program Authority
052500170726         ChkPgmAuth(@pgmq : oContinue);
052600170726         if oContinue = 'N';
052700200128           *inlr = *on;
052800200128           Return;
052900170726         endif;
053000170726
053100170726       Endsr;
053101200128
053102200128
053103200128       //-------------------------------------------------------------------
053104200128
053105200128       dcl-proc Check_AccountNbr;
053106200128
053107200128         dcl-s wActNbr like( s1ActNbr);
053108200128
053109200128         ErrAccount = *off;
053110200128         if ActChgd = *on;
053111200128
053112200128           split();
053113200128           wActNbr = s1ActNbr;
053114200128
053115200128           if %Len( %Trim( wActNbr )) < 10;
053116200128             errAccount = *on;
053117200128             return;
053118200128           EndIf;
053119200128
053120200128           s1ActName = '';
053121200128           s1ActNbr = %ScanRpl( '-' : '' : s1ActNbr );
053122200128           s1ActNbr = %ScanRpl( ' ' : '' : s1ActNbr );
053123200128
053124200128           if %check( digits : %Trim( s1ActNbr )) = 0;
053125200128             s1Trst = %Dec( %Subst( s1ActNbr : 1 : 3) : 3 : 0 );
053126200128             s1Sub  = %Dec( %Subst( s1ActNbr : 4 : 3) : 3 : 0 );
053127200128             s1Acct = %Dec( %Subst( s1ActNbr : 7 : 4) : 4 : 0 );
053128200128
053129200128             chain ( s1Trst : s1Sub : s1Acct ) AccMst;
053130200128             if not %Found( AccMst );
053131200128               Clear Screen1;
053132200128               ErrAccount = *on;
053133200128               s1ActNBr = wActNbr;
053134200128             endif;
053135200128
053136200128             if %Found( AccMst ) ;
053137200128               s1ActName = acNam1;
053138200128               s1ActNbr = %editc( s1Trst : 'X' ) + '-' +
053139200128                 %editc( s1Sub : 'X' ) + '-' +
053140200128                 %editc( s1Acct : 'X' );
053141200128             EndIf;
053142200128
053143200128           endif;
053144200128         endif;
053145200128
053146200128
053147200128       End-Proc;
053148200128
053149200128
053150200128      *------------------------------------------------------------------
053151200128      *
053152200128      * Split out the account number
053153200128      *
053154200128      *------------------------------------------------------------------
053155200128       Dcl-Proc Split;
053156200128
053157200128         dcl-s x int(10);
053158200128         dcl-s tokens varchar(100) dim(50);
053159200128         dcl-s Trst Char(3);
053160200128         dcl-s Sub  Char(3);
053161200128         dcl-s Acct Char(4);
053162200128
053163200128         tokens(*) = #Gettok( s1ActNbr : '-' : x );
053164200128
053165200128
053166200128         // we should have 3 array elements filled  in.
053167200128         // the next blank space should be #4.
053168200128         x = %lookup( '' : tokens ) ;
053169200128         if x = 4;
053170200128           Trst = #zFill( 3 : %Trim( Tokens(1) ));
053171200128           Sub  = #zFill( 3 : %Trim( Tokens(2) ));
053172200128           Acct = #zFill( 4 : %Trim( Tokens(3) ));
053173200128
053174200128           s1ActNbr = trst + '-' + Sub + '-' + Acct;
053175200128
053176200128         EndIf;
053177200128
053178200128
053179200128       End-Proc;
053180200128
053181200128
053182200128      *------------------------------------------------------------------
053183200128      *
053184200128      * Load the plans from the file.
053185200128      *
053186200128      *------------------------------------------------------------------
053187200128       Dcl-Proc Load_Plans;
053196200128          dcl-s myCount zoned(3);
053197200128
053198200128       Setll (s1Trst : s1Sub : s1Acct ) PRTREXPF;
053199200128
053200200128       Dou %Eof(PRTREXPF);
053201200128          reade (s1Trst : s1Sub : s1Acct ) PRTREXPF;
053202200128          if %eof(PRTREXPF);
053203200128             leave;
053204200128          endif;
053205200128
053206200128         myCount = myCount + 1;
053207200128
053208200128
053209200128
053210200128
053211200128       Enddo;
053212200128
053213200128
053214200128
053215200128
053216200128
053217200128       End-Proc;
