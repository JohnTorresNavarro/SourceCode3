000100150226     H option(*noDebugIo)
000200150226      *-------------------------------------------------------------------------
000300150226      *
000400151015      *  Description: Evergreen 834 Export. Create Incremential File.
000500151015      *  Programmer.: John Torres (cloned from Brian Rees - GBS0002R1)
000600151015      *  Date.......: 9/01/2015
000700150226      *
000800151015      *  Overview...: Evergreen had requested that we would send a incremential file
000900150812      *    instead of a full file.  A new database was setup to hold the sent
001000150812      *    records.
001100150812      *
001200150812      *
001300150226      *-------------------------------------------------------------------------
001400150807      * Modifications
001500150807      *
001600150807      * Date         Programmer    Mod      Description
001700150807      *-------------------------------------------------------------------------
001800150812      *
001900150812      *
002000150807      *-------------------------------------------------------------------------
002100151014     Fevrgrenxpnuf   e           k disk    rename(evgxptf:workFile)
002200151014     Fevrgrenxpsuf a e           k disk    rename(evgxpts:sendFile)
002300151014     F                                     prefix(sn)
002400151020     Fevrgrenxphuf a e           k disk    rename(evgxpth:holdFile)
002500150226      *-------------------------------------------------------------------------
002600150812     D SendData        s              1A
002700150812     D Mode            s             10A
002800150226      *-------------------------------------------------------------------------
002900150812      /Free
003000150812
003100151015            setll *loval workFile;
003200151014            read workFile;
003300151015
003400151015            dow not %eof;
003500150812
003600150812            SendData = 'Y';
003700150812            Mode = 'ADD';
003800150812
003900151014          chain evgrpseq sendFile;
004000151014            if %Found(evrgrenxps);
004100150812               Exsr CompareData;
004200150812            endif;
004300150812
004400150812            if SendData = 'Y';
004500150812               exsr WriteRcd;
004600151014                evtrncode = snevtrncode; // Update with Record Status.
004700151014               update workFile;
004800150812            else;
004900151014             delete workFile;
005000150812            endif;
005100151015
005200151015         read workFile;
005300150812         enddo;
005400150812
005500150812         *inlr = *on;
005600150812
005700150812         //-------------------------------------------------------
005800150812         Begsr CompareData;
005900151014
006000150812            SendData = 'N' ;
006100151014
006200151019            //?Something has changed...
006300151019            if EVGRPSEQ  <> snevGRPSEQ;
006400151019                Mode = 'CHANGE';
006500151019                SendData = 'Y';
006600151019            endif;
006700151019
006800151019            if EVACCNAME <> snevACCNAME;
006900151019                Mode = 'CHANGE';
007000151019                SendData = 'Y';
007100151019            endif;
007200151019
007300151019            if EVTAXID   <> snevTAXID;
007400151019                Mode = 'CHANGE';
007500151019                SendData = 'Y';
007600151019            endif;
007700151019
007800151019            if EVGRPNBR  <> snevGRPNBR;
007900151019                Mode = 'CHANGE';
008000151019                SendData = 'Y';
008100151019            endif;
008200151019
008300151019            if EVMBRDEP  <> snevMBRDEP;
008400151019                Mode = 'CHANGE';
008500151019                SendData = 'Y';
008600151019            endif;
008700151019
008800151019            if EVRELCODE <> snevRELCODE;
008900151019                Mode = 'CHANGE';
009000151019                SendData = 'Y';
009100151019            endif;
009200151019
009300151019            if EVMEDIND  <> snevMEDIND;
009400151019                Mode = 'CHANGE';
009500151019                SendData = 'Y';
009600151019            endif;
009700151019
009800151019            if EVEMPSTS  <> snevEMPSTS;
009900151019                Mode = 'CHANGE';
010000151019                SendData = 'Y';
010100151019            endif;
010200151019
010300151019            if EVSTUD    <> snevSTUD;
010400151019                Mode = 'CHANGE';
010500151019                SendData = 'Y';
010600151019            endif;
010700151019
010800151019            if EVHNDCP   <> snevHNDCP;
010900151019                Mode = 'CHANGE';
011000151019                SendData = 'Y';
011100151019            endif;
011200151019
011300151019            if EVSSNMBR  <> snevSSNMBR;
011400151019                evreasoncd = '25';
011500151019                Mode = 'CHANGE';
011600151019                SendData = 'Y';
011700151019            endif;
011800151019
011900151019            if EVSSNDEP  <> snevSSNDEP;
012000151019                evreasoncd = '25';
012100151019                Mode = 'CHANGE';
012200151019                SendData = 'Y';
012300151019            endif;
012400151019
012500151019            if EVHIRE    <> snevHIRE;
012600151019                Mode = 'CHANGE';
012700151019                SendData = 'Y';
012800151019            endif;
012900151019
013000151019            if EVENRL    <> snevENRL;
013100151019                Mode = 'CHANGE';
013200151019                SendData = 'Y';
013300151019            endif;
013400151019
013500151019            if EVLNAM    <> snevLNAM;
013600151019                evreasoncd = '25';
013700151019                Mode = 'CHANGE';
013800151019                SendData = 'Y';
013900151019            endif;
014000151019
014100151019            if EVFNAM    <> snevFNAM;
014200151019                evreasoncd = '25';
014300151019                Mode = 'CHANGE';
014400151019                SendData = 'Y';
014500151019            endif;
014600151019
014700151019            if EVMNAM    <> snevMNAM;
014800151019                evreasoncd = '25';
014900151019                Mode = 'CHANGE';
015000151019                SendData = 'Y';
015100151019            endif;
015200151019
015300160226            if EVSUBSCR    <> snevSUBSCR;
015400160226                Mode = 'CHANGE';
015500160226                SendData = 'Y';
015600160226            endif;
015700160226
015800151019            if EVPHONE   <> snevPHONE;
015900151019                Mode = 'CHANGE';
016000151019                SendData = 'Y';
016100151019            endif;
016200151019
016300151019            if EVEMAIL   <> snevEMAIL;
016400151019                Mode = 'CHANGE';
016500151019                SendData = 'Y';
016600151019            endif;
016700151019
016800151019            if EVADDR1   <> snevADDR1;
016900151019                evreasoncd = '43';
017000151019                Mode = 'CHANGE';
017100151019                SendData = 'Y';
017200151019            endif;
017300151019
017400151019            if EVADDR2   <> snevADDR2;
017500151019                evreasoncd = '43';
017600151019                Mode = 'CHANGE';
017700151019                SendData = 'Y';
017800151019            endif;
017900151019
018000151019            if EVCITY    <> snevCITY;
018100151019                evreasoncd = '43';
018200151019                Mode = 'CHANGE';
018300151019                SendData = 'Y';
018400151019            endif;
018500151019
018600151019            if EVSTATE   <> snevSTATE;
018700151019                evreasoncd = '43';
018800151019                Mode = 'CHANGE';
018900151019                SendData = 'Y';
019000151019            endif;
019100151019
019200151019            if EVZIP     <> snevZIP;
019300151019                evreasoncd = '43';
019400151019                Mode = 'CHANGE';
019500151019                SendData = 'Y';
019600151019            endif;
019700151019
019800151019            if EVDOB     <> snevDOB;
019900151019                evreasoncd = '25';
020000151019                Mode = 'CHANGE';
020100151019                SendData = 'Y';
020200151019            endif;
020300151019
020400151019            if EVGENDR   <> snevGENDR;
020500151019                Mode = 'CHANGE';
020600151019                SendData = 'Y';
020700151019            endif;
020800151019
020900151019            if EVSALRY   <> snevSALRY;
021000151019                Mode = 'CHANGE';
021100151019                SendData = 'Y';
021200151019            endif;
021300151019
021400151019            if EVSMOKE   <> snevSMOKE;
021500151019                Mode = 'CHANGE';
021600151019                SendData = 'Y';
021700151019            endif;
021800151019
021900151019            if EVPRDCT   <> snevPRDCT;
022000151019                Mode = 'CHANGE';
022100151019                SendData = 'Y';
022200151019            endif;
022300151019
022400151019            if EVCOVLVL  <> snevCOVLVL;
022500151019                Mode = 'CHANGE';
022600151019                SendData = 'Y';
022700151019            endif;
022800151019
022900151019            if EVCOVEFF  <> snevCOVEFF;
023000151019                Mode = 'CHANGE';
023100151019                SendData = 'Y';
023200151019            endif;
023300151019
023400151019            if EVDIVISN  <> snevDIVISN;
023500151019                Mode = 'CHANGE';
023600151019                SendData = 'Y';
023700151019            endif;
023800151019
023900151019            if EVPLANCD  <> snevPLANCD;
024000151019                evreasoncd = '22';
024100151019                Mode = 'CHANGE';
024200151019                SendData = 'Y';
024300151019            endif;
024400151019
024500151019            if EVCOMPST  <> snevCOMPST;
024600151019                Mode = 'CHANGE';
024700151019                SendData = 'Y';
024800151019            endif;
024900150813
025000151110            if EVCOVEND  <> snevCOVEND;
025100151110            if evcovend > '0' ;
025200151110             evreasoncd = '08';
025300151110             Mode = 'TERMED';
025400151110             SendData = 'Y';
025500151110            endif;
025600151110            endif;
025700151110
025800150813                //?Check to see if the Member was Termed.
025900151110                if evTerm <> snevterm ;
026000151014                if evTerm > '0' ;
026100151019                  evreasoncd = '08';
026200150813                  Mode = 'TERMED';
026300151019                  SendData = 'Y';
026400150813                endif;
026500151110                endif;
026600150813
026700150813                //?Check to see if the Member was Reinstated.
026800151014                if evTerm = '0'  and snevTerm <> '0';
026900150813                  Mode = 'REINSTATE';
027000151019                  SendData = 'Y';
027100150813                endif;
027200150813
027300151019                if SendData = 'Y';
027400151019                 delete sendFile;
027500151019                endif;
027600150812
027700150812         EndSr;
027800150812         //-------------------------------------------------------
027900150812         Begsr WriteRcd;
028000150812
028100151014            snevGRPSEQ  = EVGRPSEQ;
028200151014            snevACCNAME = EVACCNAME;
028300151014            snevTAXID   = EVTAXID  ;
028400151014            snevGRPNBR  = EVGRPNBR ;
028500151014            snevMBRDEP  = EVMBRDEP ;
028600151014            snevRELCODE = EVRELCODE;
028700151014            snevMEDIND  = EVMEDIND ;
028800151014            snevEMPSTS  = EVEMPSTS ;
028900151014            snevSTUD    = EVSTUD   ;
029000151014            snevHNDCP   = EVHNDCP  ;
029100151014            snevSSNMBR  = EVSSNMBR ;
029200151014            snevSSNDEP  = EVSSNDEP ;
029300151014            snevHIRE    = EVHIRE   ;
029400151014            snevENRL    = EVENRL   ;
029500151014            snevTERM    = EVTERM   ;
029600151014            snevLNAM    = EVLNAM   ;
029700151014            snevFNAM    = EVFNAM   ;
029800151014            snevMNAM    = EVMNAM   ;
029900151014            snevSUBSCR  = EVSUBSCR ;
030000151014            snevPHONE   = EVPHONE ;
030100151014            snevEMAIL   = EVEMAIL ;
030200151014            snevADDR1   = EVADDR1;
030300151014            snevADDR2   = EVADDR2;
030400151014            snevCITY    = EVCITY ;
030500151014            snevSTATE   = EVSTATE;
030600151014            snevZIP     = EVZIP  ;
030700151014            snevDOB     = EVDOB  ;
030800151014            snevGENDR   = EVGENDR;
030900151014            snevSALRY   = EVSALRY;
031000151014            snevSMOKE   = EVSMOKE;
031100151014            snevPRDCT   = EVPRDCT;
031200151014            snevCOVLVL  = EVCOVLVL;
031300151014            snevCOVEFF  = EVCOVEFF;
031400151014            snevCOVEND  = EVCOVEND;
031500151014            snevDIVISN  = EVDIVISN;
031600151014            snevPLANCD  = EVPLANCD;
031700151014            snevCOMPST  = EVCOMPST;
031800151020            snevREASONCD  = EVREASONCD ;
031900151112            snevtdate = evtdate ;
032000150813
032100150813            //?Write Record Status.
032200150813            Select;
032300150813            when Mode = 'ADD';
032400151014             snevtrncode = '021';
032500150813            when Mode = 'CHANGE';
032600151014             snevtrncode = '001';
032700151020             write holdFile;
032800150813            when Mode = 'TERMED';
032900151014             snevtrncode = '024';
033000150813            when Mode = 'REINSTATE';
033100151014             snevtrncode = '025';
033200150813            EndSl;
033300150813
033400151014            write sendFile;
033500150812
033600150812         Endsr;
