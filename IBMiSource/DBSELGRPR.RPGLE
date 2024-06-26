000100180323      *=========================================================================
000200180323     h dftactgrp(*no) option(*noDebugIo) bnddir('GBSBIND')
000300180323      *=========================================================================
000400240123      * DBSELBRPR - Aetna Mapping Group Size Selection
000500180326      *========================================================================
000600180326      * Date         Int  Description
000700180326      * ---------    ---  -----------------------------------------------------
000800240125      * 01/23/2024   RLJ  Original Creation
000900180326      *========================================================================
001000180628
001100240123     fdbselgrpd cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
001101240125
001102240125       Dcl-f delball keyed ExtDesc('DELBALL') ExtFile(*extdesc);
001200180323
001300180323      //========================================================================
001400180323
001500180323     d psds           sds
001600180323     d proc_name         *proc
001700180323
001701240123     d  selgrp         s              4
001702240125     d  errselect      s              1
001703240207     d  errfmt         s              1
001704240207     d  err            s              1
001705240207
001706240207     d                 ds
001707240207     d  slgrp#                 1      4
001708240207     d   slgr1                 1      1
001709240207     d   slgr2                 2      2
001710240207     d   slgr3                 3      3
001711240207     d   slgr4                 4      4
001712240207
001713200124     d
001800240123     d groupRetrv      pr                  ExtPgm('DBGETGRPC')
001900240123     d  selgrp                        4    const
002004200316
002100180323      //========================================================================
002200180323      // mainline
002300180323      //========================================================================
002400180323
002500180323       exsr init;
002600180323       exsr main;
002700180323       exsr exit;
002800180323
002900180323      //========================================================================
003000180323      // main
003100180323      //========================================================================
003200240207
003300240207       begsr main;
003400240207
003500240125        dow btnExit = '0';
003600240125
003700240125         exfmt screen1;
003800240125
003900240125         exsr checkButton;
004000240125
004100240125        enddo;
004200240125
004300240125       endsr;
004400180323
004500180323      //========================================================================
004600180323      // checkButton
004700180323      //========================================================================
004800180323
004900180323       begsr checkButton;
005000180323
005100240206        errSelect = '0';
005101240207        errfmt    = '0';
005102240207        err       = '0';
005200180323
005300180323        if btnExit = '1';
005400180323         leavesr;
005500180323        endif;
005600180323
005700180323        if btnEnter = '1';
005800180323         exsr validCheck;
006000180323
006100240207         if err = '0';
006101240123
006102240207          selgrp = slgrp#;
006103200124
006105240207          groupRetrv(selgrp);
006106200316
006201240207          slgrp# = '    ';
006202240209
006203240209          btnExit = '1';
006204240209
006300240207         endif;
006400180323
006401240207        endif;
006402240207
006500240206        btnEnter = '0';
006600180323
006700180323       endsr;
006800180323
006900180323      //========================================================================
007000180323      // valid check
007100180323      //========================================================================
007200180323
007300180323       begsr validCheck;
007400180323
007500240125        errSelect = '0';
007501240125
007503240207        if slgr1 = ' ' or slgr2 = ' ' or slgr3 = ' ' or slgr4 = ' ';
007504240207          errfmt    = '1';
007505240207          err       = '1';
007506240207          leavesr;
007507240207        EndIf;
007508240125
007509240207
007510240207        chain ( slgrp# ) delball;
007511240207        if %Found( delball ) ;
007512240207          errselect = '1';
007513240207          err       = '1';
007514240207        EndIf;
007515240207
007600180323
008100180323       endsr;
008200180323
008300180323      //========================================================================
008400180323      // exit
008500180323      //========================================================================
008600180323
008700180323       begsr exit;
008800180323
008900180323        *inlr = '1';
009000180323        return;
009100180323
009200180323       endsr;
009300180323
009400180323      //========================================================================
009500180323      // init
009600180323      //========================================================================
009700180323
009800180323       begsr init;
009900180323
010000180323        btnEnter = '0';
010100180323        btnExit = '0';
010201200318        btnCancel = '0';
010202200318        btnAccept = '0';
010300180323        pgmname = proc_name;
010400240123        selgrp = '    ';
010401240123        slgrp# = '    ';
010500240209        errSelect = '0';
010600180323
010700180323       endsr;
010800180323
010900180323      //========================================================================
