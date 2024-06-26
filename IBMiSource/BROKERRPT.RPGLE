000100170224      *=========================================================================
000200170224     H option(*noDebugIo)
000300170224      *=========================================================================
000400170224
000500220307     fsman      if   e           k disk    rename(smanr:smanFile)
000600220307     f                                     extfile('F.SMAN')
000700170224
001000220307     fsmanrmgl  uf a e           k disk    rename(smanrmgr:xrefFile)
001100170224
001200220307     fsman2l    if   e           k disk    rename(sman2r:sman2File)
001201220307     f                                     extfile('F.SMAN2L')
001300170224
001400220307     Fbrkrpt    o    e             disk    rename(brkrptr:outFile)
001401220307     F
001402220307
001403220307     fsmanrlt1  if   e           k disk    rename(srf:smanRlt)
001404220307     f                                     extfile('F.SMANRLT1')
001500170224
001501220307     fagency    if   e           k disk    rename(agenr:agencyFile)
001502220307     f                                     extfile('F.AGENCY')
001503220307
001504220307     fspragxr2  if   e           k disk    rename(sxf:sagyxRef)
001505220307     f                                     extfile('F.SPRAGXR2')
001506220307
001600170224      *=========================================================================
001601220308
001700220308     d today           s              8  0
001701220308
001702220308
001901220307     d brokerRpt       pi
001902220307     d  inRelMgr                      4
001903220307
002001220308      //=======================================================================
002002220308      // mainline
002003220308      //=======================================================================
002004220308
002005220308       exsr init;
002006220308       exsr main;
002007220308       exsr exit;
002008220308
002009220308      //=======================================================================
002100170224
002200220308       begsr main;
002201220308
002203220308        setll inRelMgr xrefFile;
002300220308        reade inRelMgr xrefFile;
002400220308
002500220308        dow not %eof;
002600220308
002700220308         chain smsman smanFile;
002800220308         if %found;
002900220308
002905220308          if senddt > today or senddt = 0;
002906220308
002907220308           scoder = smancd;
002908220308           slastr = slname;
002909220308           sfirstr = sfname;
002910220308
002911220308           semailr = ' ';
002912220308           chain sgrp sman2file;
002913220308           if %found;
002914220308            semailr = %trim(sbreml);
002915220308           endif;
002916220308
002917220308           sphoner = ' ';
002918220308           sphoner = %char(sarea) + %char(sphone);
004000220308
004001220308           sageaddr = saddr;
004003220308           sagecityr = scity;
004004220308           sstater =sstate;
004005220308           szipr = %char(szipcd);
004006220308
004007220308           chain smancd smanRlt;
004008220308           if %found;
004009220308            chain srasid sagyXref;
004010220308            if %found;
004011220308             chain sxagcy agencyFile;
004012220308             if %found;
004013220308              sagencynmr = agnam1;
004014220308             endif;
004015220308            endif;
004016220308
004017220308           endif;
004018220308
004020220308
004021220308           write outFile;
004022220308
004023220308          endif;
004024220308
004100220308         endif;
004200170224
004201220308        reade inRelMgr xrefFile;
004400220308        enddo;
004401220308
004402220308       endsr;
004500170224
006100220308      //=======================================================================
006101220308      // exit
006102220308      //=======================================================================
006103220308
006104220308       begsr exit;
006105220308
006106220308        *inlr = '1';
006107220308        return;
006108220308
006109220308       endsr;
006110220308
006111220308      //=======================================================================
006112220308      // init
006113220308      //=======================================================================
006114220308
006115220308       begsr init;
006116220308
006117220308        today = %dec(%date);
006118220308
006147220308       endsr;
006148220308
006149220308      //=======================================================================
006400170224
