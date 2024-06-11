000100190218      *=========================================================================
000200190218     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300190218      *=========================================================================
000400200123      * AET933R - Aetna Plan Mapping drill down
000500190218      *========================================================================
000600190218      * Date         Int  Description
000700190218      * ---------    ---  -----------------------------------------------------
000800200123      * 01/13/2020   jt   Original Creation
000801200210      * 02/10/2020   jt   Fixed writting to method files (files are unique key)
000802200313      * 02/10/2020   jt   Fixed mapvalue when mapping method = to 'NORULE'
000803200317      * 03/24/2020   jt   Recompiled for DSPF change
000804200729      * 07/29/2020   jt   Added prcess to activate/retire more than one plan at
000805200729      *                   time.
000806200807      * 08/07/2020   jt   Fixed display of Mapping Method.
000807201006      * 09/17/2020   jt   Fixed edit check on Coverage Type.
000808201006      * 10/06/2020   jt   Added plan auxp to do valid checking.
000809210309      * 03/09/2021   jt   Unlocked file in entry.
000810210311      * 03/12/2021   jt   Fixed "Retire All/Activate All".
000811210811      * 08/11/2021   jt   Added "active only" feature.
000900190218      *========================================================================
001000190218
001100200123     Faet933d   cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
001200190218     F                                     SFile(SFL1 : RRN)
001300190218
001400190218     Faccmst    if   e           k disk    ExtFile('F.ACCMST')
001500190218     F                                     rename(accmsr:acctFile)
001600190218
001700190218     fcarplnx   uf a e           k disk    rename(carplnr:mainFile)
001800190218
001900190218     fplnmst    if   e           k disk    extfile('F.PLNMST')
002000190218     f                                     rename(plnmsr:planFile)
002100190218
002101201006     fplnauxl   if   e           k disk    rename(plnauxr:auxFile)
002102201006     f
002103201006
002200190218     fcarplnp   uf a e           k disk    rename(carplnr:mainFile2)
002300190218
002301200123     faet001wf  uf a e           k disk    rename(aef01:methodSM)
002302200123
002303200123     faet004wf  uf a e           k disk    rename(aef04:methodLG)
002304200123
002305200123     fcaraccp   if   e           k disk    rename(caraccr:setupFile)
002306200123
002307200729     fcarplnz   uf a e           k disk    rename(carplnr:mainFile3)
002308200729
002400190218      *=========================================================================
002500190218
002600190218     d psds           sds
002700190218     d proc_name         *proc
002800190218     d user                  254    263
002900190218
003000190218     d rrn             s              5i 0
003500190218     d valid           s              1
003800190218     d unique          s             10
003900190218     d runique         s             10
004000190218     d hunique         s             10
004301200123     d covtype         s              3
004302200313     d hsplan          s              4
004303200313     d hsmapvalue      s              3
004304200313     d hsmaptype       s              7
004305200313     d hscov           s              8
004306200313     d hselr#          s              3
004307200313     d hssuffix        s              3
004308200313     d hsaccount#      s              5
004309200313     d hsplanid        s              3
004310200313     d hsclaimoff      s              3
004311200624
004312200624     d showMembers     pr                  ExtPgm('MEMCOVR')
004313200624     d  ptrst                         3  0 const
004314200624     d  psub#                         3  0 const
004315200624     d  pacct                         4  0 const
004316200624     d  splan                         4    const
004317200624
004500200123     d aet933r         pi
004501200123     d  punique                      10    const
004600190218     d  ptrst                         3  0 const
004700190218     d  psub#                         3  0 const
004800190218     d  pacct                         4  0 const
004900190218
005000190218      //========================================================================
005100190218      // mainline
005200190218      //========================================================================
005300190218
005400190218       exsr init;
005500190218       exsr main;
005600190218       exsr exit;
005700190218
005800190218      //========================================================================
005900190218      // main
006000190218      //========================================================================
006100190218
006200190218       begsr main;
006300190218
006400190218        dow btnEXIT = '0';
006500190218
006600190218         // Clear the subfile...
006700190218         sflclr = '1';
006800190218
006900190218         write sflctl1;
007000190218         sflclr = '0';
007100190218         rrn = 0;
007200190218
007300190218         // Load the subfile...
007400190218         exsr loadSubfile;
007500190218
007600190218         // Display the subfile.
007700190218         sfldsp = '1';
007800190218         exfmt sflctl1;
007900190218
008000190218         exsr checkButton;
008100190218
008200190218         sfldsp = '1';
008300190218
008400190218        // Check for icon click.
008500190218        readc sfl1;
008600190218        if not %eof;
008700190218
008800190218         //Lock record for update, if in change mode.
008900190218         if buttonEdit ='1';
009000190218          exsr editRecord;
009100190218         endif;
009200190218
009300190218         if buttonDsp ='1';
009400190218          exsr displayRcd;
009500190218         endif;
009600190218
009700190218         if ar <> actret2;
009800190218          exsr activeRetire;
009900190218         endif;
009901200624
009902200624         if selplan = '1';
009903200624          exsr showPlan;
009904200624         endif;
010000190218
010001200729         //if selssn = '1';
010002200729          //exsr showInq;
010003200729         //endif;
010005200624
010100190218        endif;
010200190218       enddo;
010300190218
010400190218       endsr;
010500190218
010600190218      //========================================================================
010700190218      // load subfile
010800190218      //========================================================================
010900190218
011000190218       begsr loadSubfile;
011100190218
011101190904        if posPlan > ' ';
011200190904         setll (ptrst : psub# : pacct : posPlan) mainFile;
011201190904        else;
011202190904         setll (ptrst : psub# : pacct) mainFile;
011204190904        endif;
011205190904
011300210311        reade (ptrst : psub# : pacct) mainFile;
011400190218
011500190218        dow not %eof;
011600190218
011700190218         if cpuniq = unique or cpuniq = runique;
011701210811
011702210811          if activeOnly = 'Y';
011703210811
011704210811           if cpuniq = unique;
011800210811            rrn += 1;
011900210811             exsr moveFields;
012000210811            write sfl1;
012001210811           endif;
012002210811
012003210811          else;
012005210811           rrn += 1;
012006210811            exsr moveFields;
012007210811           write sfl1;
012008210811          endif;
012009210811
012100210811         endif;
012200190218
012300210311        reade (ptrst : psub# : pacct) mainFile;
012400190218        enddo;
012401190904
012402200313        //posPlan = ' ';
012500190218
012600190218       endsr;
012700190218
012800190218      //========================================================================
012900190218      // move fields
013000190218      //========================================================================
013100190218
013200190218       begsr moveFields;
013300190218
013400200123        splan = cpplan;
013500200123        smapvalue = cpcctr;
013600190218
013700190218        chain (ptrst : psub# : cpplan) planFile;
013800190218        if %found;
013900200123         spdesc = pdescr;
014000190218        endif;
014100190218
014300200313        smaptype = '**ERROR**';
014301200313        if punique = '0000000011';
014302200313         chain(n) (ptrst : psub# : pacct : cpplan) methodSM;
014303200313         if %found;
014304200313          smaptype = ae1map;
014305200313         endif;
014306200313        endif;
014307200313
014308200313        if punique = '0000000127';
014309200313         chain(n) (ptrst : psub# : pacct : cpplan) methodLG;
014310200313         if %found;
014311200313          smaptype = ae4map;
014312200313         endif;
014313200313        endif;
014314200313
014315200313        //ar = %subst(cpuniq:1:1);
014316200313
014400190218        actret = 'ACTIVE';
014500190218        actret2 = '1';
014600190218        ar = '1';
014601200123        showedit = '1';
014700190218        if %subst(cpuniq:1:1) = '9';
014800190218         actret = 'RETIRE';
014900200123          ar = '0';
014901200123          showedit = '0';
015000200123         actret2 = '0';
015100190218        endif;
015200190218
015300190218       endsr;
015400190218
015500190218      //========================================================================
015600190218      // load fields
015700190218      //========================================================================
015800190218
015900190218       begsr loadFields;
016000190218
016100190218        if actret = ('ACTIVE');
016200190218         hunique = unique;
016300190218        else;
016400190218         hunique = runique;
016500190218        endif;
016600190218
016700200123        chain(n)(hunique : ptrst : psub# : pacct : smapvalue : splan) mainfile2;
016800190218
016801200313        smaptype = ' ';
016802200123        if punique = '0000000011';
016803200807         chain(n) (ptrst : psub# :pacct : splan) methodSM;
016804200123         smaptype = ae1map;
016805200313        endif;
016806200313        if punique = '0000000127';
016807200807         chain(n) (ptrst : psub# :pacct : splan) methodLG;
016808200123         smaptype = ae4map;
016809200123        endif;
016810200123
016811200123        smapvalue = cpcctr;
017000190218        splan = cpplan;
017001200123
017002200123        select;
017003200123         when cpcid1 = 'MEA'
017004200123          or cpcid1 = 'HMO'
017005200123          or cpcid1 = 'PPO';
017006200123           scov = 'MED';
017007200123
017008200123         when cpcid1 = 'DEN';
017009200123          scov = 'DEN';
017010200123
017011200123         when cpcid1 = 'VIS';
017012200123          scov = 'VIS';
017013200123
017014200807         when cpcid1 = 'LTD';
017015200123          scov = 'LIF';
017016200807
017017200807         other;
017018200807          scov = ' ';
017019200807
017020200123        endsl;
017021200123
017100200123        selr# = cpcid2;
017200200123        ssuffix = cpcid3;
017300200123        saccount# = cpcid4;
017400200123        splanid = cpcid5;
017501200123        sclaimoff = cpcid6;
017600190218
017700190218        chain (ptrst : psub# : cpplan) planFile;
017800190218        if %found;
017900190218         spdesc = pdescr;
018000190218        endif;
018100190218
018200190218        acctname  = taname;
018300190218
018400190218       endsr;
018500190218
018600190218      //========================================================================
018700190218      // checkButton
018800190218      //========================================================================
018900190218
019000190218       begsr checkButton;
019100190218
019200190218        if buttonEdit = '1';
019300190218         exsr editRecord;
019400190218        endif;
019500190218
019600190218        if buttonAdd  = '1';
019700190218         exsr addRcd;
019800190218        endif;
019900200729
019901200313        if btnRefresh  = '1';
019902200313         posplan = ' ';
019903200313         btnRefresh = '0';
019904200313        endif;
019905200313
019906200729        if buttonAct  = '1' or buttonRet = '1';
019907200729         exsr activeRetireAll;
019908200729        endif;
019910200729
020000190218       endsr;
020100190218
020200190218      //========================================================================
020300190218      // add record
020400190218      //========================================================================
020500190218
020600190218       begsr addRcd;
020700190218
020800190218        addRecord = '0';
020900190218        btnExtAdd = '0';
021000190218        strst = ptrst;
021100190218        ssub# = psub#;
021200190218        sacct = pacct;
021201200313
021300190218        splan = ' ';
021301200313        if hsplan > ' ';
021302200313         splan = hsplan;
021303200313        endif;
021304200313
021400200123        smapvalue = ' ';
021401200313        if hsmapvalue > ' ';
021402200313         smapvalue = hsmapvalue;
021403200313        endif;
021404200313
021405200313        smaptype = 'NORULE';
021406200313        if hsmaptype > ' ';
021407200313         smaptype = hsmaptype;
021408200313        endif;
021409200313
021410200313        scov = ' ';
021411200313        if hscov > ' ';
021412200313         scov = hscov;
021413200313        endif;
021414200313
021415200123        selr# = ' ';
021416200313        if hselr# > ' ';
021417200313         selr# = hselr#;
021418200313        endif;
021419200313
021421200123        ssuffix = ' ';
021422200313        if hssuffix > ' ';
021423200313         ssuffix = hssuffix;
021424200313        endif;
021425200313
021427200123        saccount# = ' ';
021428200313        if hsaccount# > ' ';
021429200313         saccount# = hsaccount#;
021430200313        endif;
021431200313
021432200123        splanid = ' ';
021433200313        if hsplanid > ' ';
021434200313         splanid = hsplanid;
021435200313        endif;
021436200313
021437200123        sclaimoff = ' ';
021438200313        if hsclaimoff > ' ';
021439200313         sclaimoff = hsclaimoff;
021440200313        endif;
021441200313
022000190218        spdesc = ' ';
022100190218        errPlan = '0';
022300190218        errInvPlan = '0';
022500190218
022600190218        dow btnExtAdd = '0';
022601190412
022800190218         exfmt adddtl;
022900190218
023000190218         if btnExtAdd = '1';
023100190218          leavesr;
023200190218         endif;
023300190218
023400190218         exsr validAdd;
023500190218
023600190218         if valid  = '1';
023700190218          btnExtAdd = '0';
023800190218         else;
023900190218          btnExtAdd = '1';
024000190218         endif;
024100190218
024200190218        enddo;
024300190218
024400190218       endsr;
024500190218
024600190218      //========================================================================
024700200729      // active/retire
024800190218      //========================================================================
024900190218
025000190218       begsr activeRetire;
025100190218
025200200123        chain (unique : ptrst : psub# : pacct : smapvalue : splan) mainfile2;
025300190218        if %found;
025500200123         if cpuniq = '0000000011';
025600200123          cpuniq = '9000000011';
025700190218          update mainfile2;
025701210311          leavesr;
025800190218         endif;
026100190218        endif;
026200190218
026300200123        chain (runique : ptrst : psub# : pacct : smapvalue : splan) mainfile2;
026400190218        if %found;
026500200123         if cpuniq = '9000000011';
026600200123          cpuniq = '0000000011';
026700190218          update mainfile2;
026701210311          leavesr;
026800190218         endif;
027100190218        endif;
027200190218
027201200123        chain (unique : ptrst : psub# : pacct : smapvalue : splan) mainfile2;
027202200123        if %found;
027203200123         if cpuniq = '0000000127';
027204200123          cpuniq = '9000000127';
027205200123          update mainfile2;
027206210311          leavesr;
027207200123         endif;
027209200123        endif;
027210200123
027211200123        chain (runique : ptrst : psub# : pacct : smapvalue : splan) mainfile2;
027212200123        if %found;
027213200123         if cpuniq = '9000000127';
027214200123          cpuniq = '0000000127';
027215200123          update mainfile2;
027216210311          leavesr;
027217200123         endif;
027219200123        endif;
027220200123
027300190218       endsr;
027400190218
027401200729      //========================================================================
027402200729      // active/retire
027403200729      //========================================================================
027404200729
027405200729       begsr activeRetireAll;
027406200729
027407210311        if punique = '0000000011';
027408210311
027411210311         if buttonAct = '1';
027412210311
027413210311          setll (runique : ptrst : psub# : pacct) mainfile3;
027414210311          reade (runique : ptrst : psub# : pacct) mainfile3;
027415210311
027421210311          dow not %eof;
027424210311           cpuniq = '0000000011';
027425210311           update mainfile3;
027427210311
027429210311           reade (runique : ptrst : psub# : pacct) mainfile3;
027436210311           enddo;
027437210311
027439210311           buttonRet = '0';
027440210311           buttonAct = '0';
027441210311          leavesr;
027442210311
027443210311         endif;
027444200729
027445210311         if buttonRet = '1';
027446210311
027447210311          setll (unique : ptrst : psub# : pacct) mainfile3;
027448210311          reade (unique : ptrst : psub# : pacct) mainfile3;
027449210311
027450210311          dow not %eof;
027451210311           cpuniq = '9000000011';
027452210311           update mainfile3;
027453210311
027454210311           reade (unique : ptrst : psub# : pacct) mainfile3;
027455210311           enddo;
027456210311
027457210311           buttonRet = '0';
027458210311           buttonAct = '0';
027459210311          leavesr;
027460210311
027461210311         endif;
027462210311
027463210311        endif;
027464210311
027465210311        if punique = '0000000127';
027466210311
027467210311         if buttonAct = '1';
027468210311
027469210311          setll (runique : ptrst : psub# : pacct) mainfile3;
027470210311          reade (runique : ptrst : psub# : pacct) mainfile3;
027471210311
027472210311          dow not %eof;
027473210311           cpuniq = '0000000127';
027474210311           update mainfile3;
027475210311
027476210311           reade (runique : ptrst : psub# : pacct) mainfile3;
027477210311           enddo;
027478210311
027479210311           buttonRet = '0';
027480210311           buttonAct = '0';
027481210311          leavesr;
027482210311
027483210311         endif;
027484210311
027485210311         if buttonRet = '1';
027486210311
027487210311          setll (unique : ptrst : psub# : pacct) mainfile3;
027488210311          reade (unique : ptrst : psub# : pacct) mainfile3;
027489210311
027490210311          dow not %eof;
027491210311           cpuniq = '9000000127';
027492210311           update mainfile3;
027493210311
027494210311           reade (unique : ptrst : psub# : pacct) mainfile3;
027495210311           enddo;
027496210311
027497210311           buttonRet = '0';
027498210311           buttonAct = '0';
027499210311          leavesr;
027500210311
027501210311         endif;
027502210311
027503210311        endif;
027504210311
027558200729       endsr;
027559200729
027560210311      //========================================================================
027561210311      // active/retire
027562210311      //========================================================================
027563210311
027564210311       begsr activeRetireAll2;
027565210311
027566210311        if buttonAct = '1';
027567210311         if posPlan = ' ';
027568210311          setll (runique : ptrst : psub# : pacct) mainfile3;
027569210311          reade (runique : ptrst : psub# : pacct) mainfile3;
027570210311         endif;
027571210311
027572210311         if posPlan > ' ';
027573210311          setll (runique : ptrst : psub# : pacct : posPlan) mainfile3;
027574210311          reade (runique : ptrst : psub# : pacct : posPlan) mainfile3;
027575210311         endif;
027576210311
027577210311         dow not %eof;
027578210311
027579210311          if cpuniq = '9000000011';
027580210311           cpuniq = '0000000011';
027581210311           update mainfile3;
027582210311          endif;
027583210311
027584210311          if posPlan = ' ';
027585210311           reade (runique : ptrst : psub# : pacct) mainfile3;
027586210311          endif;
027587210311
027588210311          if posPlan > ' ';
027589210311           reade (runique : ptrst : psub# : pacct : posPlan) mainfile3;
027590210311          endif;
027591210311
027592210311          enddo;
027593210311
027594210311         buttonRet = '0';
027595210311         buttonAct = '0';
027596210311        endif;
027597210311
027598210311
027599210311         if buttonRet = '1';
027600210311          if posPlan = ' ';
027601210311           setll (unique : ptrst : psub# : pacct) mainfile3;
027602210311           reade (unique : ptrst : psub# : pacct) mainfile3;
027603210311          endif;
027604210311
027605210311          if posPlan > ' ';
027606210311           setll (unique : ptrst : psub# : pacct : posPlan) mainfile3;
027607210311           reade (unique : ptrst : psub# : pacct : posPlan) mainfile3;
027608210311          endif;
027609210311
027610210311          dow not %eof;
027611210311          if cpuniq = '0000000011';
027612210311           cpuniq = '9000000011';
027613210311           update mainfile3;
027614210311          endif;
027615210311
027616210311          if posPlan = ' ';
027617210311           reade (unique : ptrst : psub# : pacct) mainfile3;
027618210311          endif;
027619210311
027620210311          if posPlan > ' ';
027621210311           reade (unique : ptrst : psub# : pacct : posPlan) mainfile3;
027622210311          endif;
027623210311
027624210311          enddo;
027625210311
027626210311          buttonRet = '0';
027627210311          buttonAct = '0';
027628210311         endif;
027629210311
027630210311        if buttonAct = '1';
027631210311         if posPlan = ' ';
027632210311          setll (runique : ptrst : psub# : pacct) mainfile3;
027633210311          reade (runique : ptrst : psub# : pacct) mainfile3;
027634210311         endif;
027635210311
027636210311         if posPlan > ' ';
027637210311          setll (runique : ptrst : psub# : pacct : posPlan) mainfile3;
027638210311          reade (runique : ptrst : psub# : pacct : posPlan) mainfile3;
027639210311         endif;
027640210311
027641210311         dow not %eof;
027642210311
027643210311          if cpuniq = '9000000127';
027644210311           cpuniq = '0000000127';
027645210311           update mainfile3;
027646210311          endif;
027647210311
027648210311          if posPlan = ' ';
027649210311           reade (runique : ptrst : psub# : pacct) mainfile3;
027650210311          endif;
027651210311
027652210311          if posPlan > ' ';
027653210311           reade (runique : ptrst : psub# : pacct : posPlan) mainfile3;
027654210311          endif;
027655210311
027656210311         enddo;
027657210311
027658210311         buttonRet = '0';
027659210311         buttonAct = '0';
027660210311        endif;
027661210311
027662210311        if buttonRet = '1';
027663210311         if posPlan = ' ';
027664210311          setll (unique : ptrst : psub# : pacct) mainfile3;
027665210311          reade (unique : ptrst : psub# : pacct) mainfile3;
027666210311         endif;
027667210311
027668210311         if posPlan > ' ';
027669210311          setll (unique : ptrst : psub# : pacct : posPlan) mainfile3;
027670210311          reade (unique : ptrst : psub# : pacct : posPlan) mainfile3;
027671210311         endif;
027672210311
027673210311         dow not %eof;
027674210311         if cpuniq = '0000000127';
027675210311          cpuniq = '9000000127';
027676210311          update mainfile3;
027677210311         endif;
027678210311
027679210311         if posPlan = ' ';
027680210311          reade (unique : ptrst : psub# : pacct) mainfile3;
027681210311         endif;
027682210311
027683210311         if posPlan > ' ';
027684210311          reade (unique : ptrst : psub# : pacct : posPlan) mainfile3;
027685210311         endif;
027686210311
027687210311         enddo;
027688210311
027689210311         buttonRet = '0';
027690210311         buttonAct = '0';
027691210311        endif;
027692210311
027693210311       endsr;
027694210311
027695190218      //========================================================================
027696200729      // display record
027700190218      //========================================================================
027800190218
027900190218       begsr displayRcd;
028000190218
028100190218        btnExtDsp = '0';
028200190218        strst = ptrst;
028300190218        ssub# = psub#;
028400190218        sacct = pacct;
028500190218
028600190218        dow btnExtDsp = '0';
028700190218
028800190218         exsr loadFields;
028900190218
029000190218         exfmt dspdtl;
029100190218
029200190218        enddo;
029300190218
029301200313        posPlan = splan;
029400190218        buttonDsp = '0';
029500190218
029600190218       endsr;
029700190218
029800190218      //========================================================================
029900190218      // valid record
030000190218      //========================================================================
030100190218
030200190218       begsr validAdd;
030300190218
030400190218        valid = '0';
030500190218        strst = ptrst;
030600190218        ssub# = psub#;
030700190218        sacct = pacct;
030800190218        errPlan = '0';
031000190218        errInvPlan = '0';
031001200123        errMvalue = '0';
031002200917        errCovt = '0';
031003200123        errElr# = '0';
031004200123        errSuffix = '0';
031005200123        errAcct# = '0';
031006200123        errPlanid = '0';
031007200123        errClaim = '0';
031008200123
031300190218        if splan = ' ';
031400190218         errPlan = '1';
031500190218         valid = '1';
031600190218        endif;
031700190218
031701200123        if splan > ' ';
031702201006         chain (ptrst : psub# : pacct: splan) auxFile;
031703200123         if not %found;
031704200123          errInvPlan = '1';
031705200123          valid = '1';
031706200123         endif;
031707200123        endif;
031708200123
031800200123        if smapvalue = ' ';
031900200123         errMvalue = '1';
032000200123         valid = '1';
032100200123        endif;
032200190227
032201200313        if smapvalue = ' ' and smaptype = 'NORULE';
032202200313         errMvalue = '0';
032203200313         valid = '0';
032204200313        endif;
032205200313
032206200917        if scov = ' ';
032207200917         errCovt = '1';
032208200917         valid = '1';
032209200917        endif;
032210200917
032211200123        if selr# = ' ';
032212200123         errElr# = '1';
032213200123         valid = '1';
032214200123        endif;
032215190301
032216200123        if ssuffix = ' ';
032217200123         errSuffix = '1';
032218200123         valid = '1';
032219200123        endif;
032220200313
032221200313        if saccount# = ' ';
032222200313         errAcct# = '1';
032223200313         valid = '1';
032224200313        endif;
032225200313
032226200313        if splanid = ' ';
032227200313         errPlanid = '1';
032228200313         valid = '1';
032229200313        endif;
032230200313
035200200123        if sclaimoff = ' ';
035300200123         errClaim = '1';
035400200123         valid = '1';
035500200123        endif;
035501200123
035502200123        exsr check_forGroup#;
035600190218
035700190218        if valid = '0';
035800190218         exsr addRecd;
035801200313         posPlan = splan;
035900190218        endif;
036000190218
036100190218       endsr;
036200190218
036300190218      //========================================================================
036400190218      // valid add
036500190218      //========================================================================
036600190218
036700190218       begsr addRecd;
036800190218
036900190218        cpuniq = unique;
037000190218        cptrst = ptrst;
037100190218        cpsub# = psub#;
037200190218        cpacct = pacct;
037300200123        cpcctr = smapvalue;
037400190218        cpplan = splan;
037700200123        cpcid2 = selr#;
037900200123        cpcid3 = ssuffix;
038100200123        cpcid4 = saccount#;
038300200123        cpcid5 = splanid;
038401200123        cpcid6 = sclaimoff;
038500200123        cpcid5 = splanid;
038501200123
038502200123        select;
038503200807         when scov = 'MED';
038504200807         //when scov = 'MEA'
038505200807         // or scov = 'HMO'
038506200807         // or scov = 'PPO';
038507200123           cpcid1 = 'MEA';
038508200123
038509200123         when scov = 'DEN';
038510200123          cpcid1 = 'DEN';
038511200123
038512200123         when scov = 'VIS';
038513200123          cpcid1 = 'VIS';
038514200123
038515200807         when scov = 'LIF';
038516200807          cpcid1 = 'LTD';
038517200123        endsl;
038700190218
038703200123        if punique = '0000000011';
038704200313        chain(n) (ptrst : psub# :pacct : splan) methodSM;
038705200210         if not %found;
038706200123         ae1trs = ptrst;
038707200123          ae1sub = psub#;
038708200123           ae1acc = pacct;
038709200123           ae1pln = splan;
038710200123          ae1map = smaptype;
038711200123         write methodSM;
038712200210         endif;
038713200123        else;
038714200313         chain(n) (ptrst : psub# :pacct: splan) methodLG;
038715200210         if not %found;
038716200123         ae4trs = ptrst;
038717200123          ae4sub = psub#;
038718200123           ae4acc = pacct;
038719200123           ae4pln = splan;
038720200123          ae4map = smaptype;
038721200123         write methodLG;
038722200210        endif;
038723200123        endif;
038724200123
038800190218        write mainFile;
038801200313
038802200313        exsr saveHold;
038900190218
039000190218       endsr;
039100190218
039101200313      //========================================================================
039102200313      // save hold fields
039103200313      //========================================================================
039104200313
039105200313       begsr saveHold;
039106200313
039107200313        hsmapvalue = smapvalue;
039108200313        hsplan = splan;
039109200313        hsmaptype = smaptype;
039110200313        hscov = scov;
039111200313        hselr# = selr#;
039112200313        hssuffix = ssuffix;
039113200313        hsaccount# = saccount#;
039114200313        hsplanid = splanid;
039115200313        hsclaimoff = sclaimoff;
039116200313        hsplanid = splanid;
039117200313
039118200313       endsr;
039119200313
039200190218      //========================================================================
039300190218      // edit record
039400190218      //========================================================================
039500190218
039600190218       begsr editRecord;
039700190218
039800190218        btnUpdRcd = '0';
039900190218        btnExtEdt = '0';
040000190218        strst = ptrst;
040100190218        ssub# = psub#;
040200190218        sacct = pacct;
040300190218        errPlan = '0';
040500190218        errInvPlan = '0';
040700190218
040800190218        dow btnExtEdt = '0';
040900190218
041000190218         exsr loadFields;
041100190218
041200190218         exfmt maintdtl;
041300190218
041400190218         if btnUpdRcd = '1';
041500190218          exsr validEdit;
041600190218         endif;
041700190218
041800190218        enddo;
041900190218
042000190218        buttonEdit = '0';
042100190218
042200190218       endsr;
042300190218
042400190218      //========================================================================
042500190218      // valid record
042600190218      //========================================================================
042700190218
042800190218       begsr validEdit;
042900190218
043500200123        valid = '0';
043501200123        strst = ptrst;
043502200123        ssub# = psub#;
043503200123        sacct = pacct;
043504200123        errPlan = '0';
043505200123        errInvPlan = '0';
043506200123        errMvalue = '0';
043507200917        errCovt = '0';
043508200123        errElr# = '0';
043509200123        errSuffix = '0';
043510200123        errAcct# = '0';
043511200123        errPlanid = '0';
043512200123        errClaim = '0';
043513200123
043600190218        if splan = ' ';
043700190218         errPlan = '1';
043800190218         valid = '1';
043900190218        endif;
044505190301
044600190218        if splan > ' ';
044700201006         chain (ptrst : psub# : pacct: splan) auxFile;
044800190218         if not %found;
044900190218          errInvPlan = '1';
045000190218          valid = '1';
045100190218         endif;
045200190218        endif;
045300190218
046400200123        if smapvalue = ' ';
046401200123         errMvalue = '1';
046402200123         valid = '1';
046403200123        endif;
046404200123
046405200313        if smapvalue = ' ' and smaptype = 'NORULE';
046406200313         errMvalue = '0';
046407200313         valid = '0';
046408200313        endif;
046409200917
046410200917        if scov = ' ';
046411200917         errCovt = '1';
046412200917         valid = '1';
046413200917        endif;
046414200313
046415200123        if selr# = ' ';
046416200123         errElr# = '1';
046417200123         valid = '1';
046418200123        endif;
046419200123
046420200123        if ssuffix = ' ';
046421200123         errSuffix = '1';
046422200123         valid = '1';
046423200123        endif;
046424200313
046425200313        if saccount# = ' ';
046426200313         errAcct# = '1';
046427200313         valid = '1';
046428200313        endif;
046429200313
046430200313        if splanid = ' ';
046431200313         errPlanid = '1';
046432200313         valid = '1';
046433200313        endif;
046434200313
046435200313        if sclaimoff = ' ';
046436200313         errClaim = '1';
046437200313         valid = '1';
046438200313        endif;
046439200313
046440200313        //if smapvalue = ' ';
046441200313        // errMvalue = '1';
046442200313        // valid = '1';
046443200313        //endif;
046444200123
048000190218        if valid = '0';
048100190218         exsr edtRecord;
048102200313         posPlan = splan;
048200190218         btnExtEdt = '1';
048300200729        endif;
048400190218
048500190218        endsr;
048600190218
048601200624      //========================================================================
048602200624      // show members for plan
048603200624      //========================================================================
048604200624
048605200624       begsr showPlan;
048606200624
048607200624        showMembers(ptrst : psub# : pacct : splan);
048608200624
048609200624        selplan = '0';
048610200624
048611200624       endsr;
048613200624
048700190218      //========================================================================
048800200624      // edit record
048900190218      //========================================================================
049000190218
049100190218       begsr edtRecord;
049200190218
049300190218        if actret = ('ACTIVE');
049400190218         hunique = unique;
049500190218        else;
049600190218         hunique = runique;
049700190218        endif;
049800190218
049900200313        chain (hunique : ptrst : psub# : pacct : cpcctr : cpplan) mainfile2;
050000190218
050100200123        cpcctr = smapvalue;
050200190218        cpplan = splan;
050300200123        cpcid2 =  selr#;
050400200123        cpcid3 =  ssuffix;
050500200123        cpcid4 =  saccount#;
050600200123        cpcid5 = splanid;
050601200123        cpcid6 = sclaimoff;
050800190218
050801200123        select;
050802200807         when scov = 'MED';
050803200807         //when scov = 'MEA'
050804200807         // or scov = 'HMO'
050805200807         // or scov = 'PPO';
050806200807          cpcid1 = 'MEA';
050807200123
050808200123         when scov = 'DEN';
050809200123          cpcid1 = 'DEN';
050810200123
050811200123         when scov = 'VIS';
050812200123          cpcid1 = 'VIS';
050813200123
050814200123         when scov = 'LIF';
050815200807          cpcid1 = 'LTD';
050816200123        endsl;
050817200123
050818200313        if punique = '0000000011';
050819200313
050820200313         chain (ptrst : psub# : pacct : splan) methodSM;
050821200313         if %found;
050822200313          ae1map = smaptype;
050823200313          update methodSM;
050824200313         else;
050825200313          ae1trs = ptrst;
050826200313           ae1sub = psub#;
050827200313            ae1acc = pacct;
050828200313            ae1pln = splan;
050829200313           ae1map = smaptype;
050830200313          write methodSM;
050831200313         endif;
050832200313
050833200313        else;
050834200313
050835200313         chain (ptrst : psub# : pacct : splan) methodLG;
050836200313         if %found;
050837200313          ae4map = smaptype;
050838200313          update methodLG;
050839200313         else;
050840200313          ae4trs = ptrst;
050841200313           ae4sub = psub#;
050842200313            ae4acc = pacct;
050843200313            ae4pln = splan;
050844200313           ae4map = smaptype;
050845200313          write methodLG;
050846200313         endif;
050847200313
050848200313        endif;
050849200313
050900190218        update mainFile2;
051000190218
051100190218       endsr;
051200200123
051201200123      //========================================================================
051202200123      // check for group#
051203200123      //========================================================================
051204200123
051205200123       begsr check_forGroup#;
051206200123
051207200123        covtype = scov;
051210200123        if scov = 'MEA'
051211200123         or scov = 'HMO'
051212200807          or scov = 'MED'
051213200123          or scov = 'PPO';
051214200123         covtype = 'MED';
051215200123        endif;
051216200123
051217200807        chain (punique : ptrst : psub# : pacct) setupFile;
051218200123
051219200123        if covtype = 'MED';
051220200123         if cacid3 = ' ' and cacid5 = ' ';
051221200123          scovType = 'MEDICAL';
051222200123           exfmt msgWindow;
051223200123           valid = '1';
051224200123          leavesr;
051225200123         endif;
051226200123        endif;
051227200123
051228200123        if covtype = 'DEN';
051229200123         if cacid8 = ' ';
051230200123          scovType = 'DENTAL';
051231200123           exfmt msgWindow;
051232200123           valid = '1';
051233200123          leavesr;
051234200123         endif;
051235200123        endif;
051236200123
051237200123        if covtype = 'LIF';
051238200123         if cacid7 = ' ';
051239200123          scovType = 'LIFE';
051240200123           exfmt msgWindow;
051241200123           valid = '1';
051242200123          leavesr;
051243200123         endif;
051244200123        endif;
051245200123
051246200123        if covtype = 'VIS';
051247200123         if cacid4 = ' ';
051248200123          scovType = 'VISION';
051249200123           exfmt msgWindow;
051250200123           valid = '1';
051251200123          leavesr;
051252200123         endif;
051253200123        endif;
051254200123
051255200123       endsr;
051256200123
051300190218      //========================================================================
051400190218      // exit
051500190218      //========================================================================
051600190218
051700190218       begsr exit;
051800190218
051900190218        *inlr = '1';
052000190218        return;
052100190218
052200190218       endsr;
052300190218
052400190218      //========================================================================
052500190218      // init
052600190218      //========================================================================
052700190218
052800190218       begsr init;
052900190218
053000190218        btnREFRESH = '0';
053100190218        btnEXIT = '0';
053200190218        btnUpdRcd = '0';
053300190218        buttonDsp = '0';
053400190218        buttonEdit = '0';
053500190218        buttonAdd = '0';
053501200123        showedit = '1';
053502200624        selplan = '0';
053503210811        activeOnly = 'N';
053504200729        //selssn = '0';
053600190218
053700190218        sfldsp = '0';
053800190218        sflclr = '0';
053900200729
054000190218        pgmname = proc_name;
054100190218
054101200123        unique = punique;
054102200123
054300200123        if unique = '0000000011';
054301200123         runique = '9000000011';
054302200123         title = 'Aetna Account Plan Mapping - Small Groups';
054303200123        else;
054304200123         runique = '9000000127';
054305200123         title = 'Aetna Account Plan Mapping - Large Groups';
054306200123        endif;
054600190218
054700190218        ttrst = %editc(ptrst:'X');
054800190218        tsub# = %editc(psub#:'X');
054900190218        tacct = %editc(pacct:'X');
055000190218
055100190218        chain (ptrst : psub# : pacct) acctFile;
055200190218        if %found;
055300190218         taname = acnam1;
055400190218        endif;
055500190218
055600190218       endsr;
055700190218
055800190218      //========================================================================
