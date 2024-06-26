000100170711      *=========================================================================
000200170711     H option(*noDebugIo)
000300170711      *=========================================================================
000400200204      * CSWELLETR - Care Service Management welcome letter
000500170711      *=========================================================================
000600170711      *  Date        Int  Description
000700170711      *  ----------  ---  ------------------------------------------------------
000800200204      *  02/04/2020  jt   Original Creation
000900200918      *  07/24/2020  jt   Added subr to skip trust.
001000200928      *  09/18/2020  ja   Added trust 81 per Shelly.
001100200928      *  09/28/2020  ja   Added trust 82 per Shelly.
001200170711      *=========================================================================
001300170810
001400180426     finvsum    if   e           k disk    ExtFile('F.INVSUM')
001500180426     f                                     rename(invsmr:invFile)
001600180426
001700180426     ftrsmst    if   e           k disk    ExtFile('F.TRSMST')
001800180426     f                                     rename(trsmsr:trustFile)
001900180426
002000180426     faccmst    if   e           k disk    ExtFile('F.ACCMST')
002100180426     f                                     rename(accmsr:actmstFile)
002200180517
002300180517     faccmsp    if   e           k disk    rename(accmspr:miscFile)
002400180517
002500180426     fhistaa    if   e           k disk    ExtFile('F.HISTAA')
002600180426     f                                     rename(histr:histFile)
002700180426
002800200204     fcswellet  o    e             disk    rename(amwelr:welFile)
002900170810
003000170711      *=========================================================================
003100061017
003200180426     d startDate       s              8  0
003300180426     d endDate         s              8  0
003400180426     d histkey         s             10
003500180426     d SrDenAdvMob     s              3
003600180426     d fmtDate         s               d   datfmt(*usa)
003700180426     d totalAmount     s              8  2
003800180426     d remainingBal    s              8  2
003900180426     d proceed         s              1
004000200724     d skipYN          s              1
004100180904     d writeRec        s              1
004200180426
004300200204     d cswelletr       pi
004400180426     d  type                          1    const
004500180426
004600170711      //========================================================================
004700170711      // mainline
004800170711      //========================================================================
004900170711
005000170711       exsr init;
005100170711       exsr main;
005200170711       exsr exit;
005300170711
005400170711      //========================================================================
005500170711      // main
005600170711      //========================================================================
005700170711
005800170711       begsr main;
005900170711
006000180426        setll *loval actmstFile;
006100180426        read actmstFile;
006200180426
006300180426        dow not %eof;
006400180426
006500180426         chain actrst trustFile;
006600180426         if %found;
006700200724
006800200724          exsr checkTrust;
006900200724          if skipYN = 'N';
007000180426
007100200724           if tscode = SrDenAdvMob;
007200180426
007300200724            if enroll >= startDate;
007400180426             clear totalAmount;
007500200724              exsr process;
007600200724
007700200724              if proceed = 'Y';
007800200724               exsr compare;
007900180904
008000200724               if writeRec = 'Y';
008100200724                exsr writeRecord;
008200200724               endif;
008300180904
008400200724              endif;
008500180426
008600200724            endif;
008700180426
008800200724           endif;
008900200724
009000180426          endif;
009100180426
009200180426         endif;
009300180426
009400180426        read actmstFile;
009500180426        enddo;
009600180426
009700180426       endsr;
009800170711
009900170711      //========================================================================
010000170711      // process
010100170711      //========================================================================
010200170711
010300170711       begsr process;
010400180426
010500180426        proceed = 'Y';
010600180426        if enroll = atrmdt;
010700180426         proceed = 'N';
010800180426         leavesr;
010900180426        endif;
011000180426
011100180426        histKey = %editc(actrst:'X') + %editc(acsub#:'X') + %editc(acacct:'X');
011200180426
011300180426        setll (histkey : 'BMP') histFile;
011400180426        reade (histkey : 'BMP') histFile;
011500180426
011600180426         proceed = 'N';
011700180426         dow not %eof;
011800180426
011900180515          if cm$flg > ' ';
012000180426           proceed = 'Y';
012100180426           exsr addAmounts;
012200180426          endif;
012300180426
012400180426        reade (histkey : 'BMP') histFile;
012500180426        enddo;
012600180426
012700170711       endsr;
012800170711
012900180426      //=======================================================================
013000180426      // add amounts
013100180426      //=======================================================================
013200180426
013300180426       begsr addAmounts;
013400180426
013500180426        totalAmount = totalAmount + tramt;
013600180426
013700180426       endsr;
013800180426
013900180426      //=======================================================================
014000180426      // compare
014100180426      //=======================================================================
014200180426
014300180426       begsr compare;
014400180426
014500180904        writeRec = 'Y';
014600180904
014700180426        setll (actrst : acsub# : acacct) invFile;
014800180426        reade (actrst : acsub# : acacct) invFile;
014900180426
015000180426        dow not %eof;
015100180426         if inrc = 'KEB';
015200180426          leave;
015300180426         endif;
015400180426        reade (actrst : acsub# : acacct) invFile;
015500180426        enddo;
015600180426
015700180904        if totalAmount = 0;
015800180904         writeRec = 'N';
015900180904         leavesr;
016000180904        endif;
016100180904
016200180426        remainingBal = inendb / totalAmount;
016300180426
016400180426       endsr;
016500180426
016600180426      //=======================================================================
016700180426      // write record
016800180426      //=======================================================================
016900180426
017000180426       begsr writeRecord;
017100180426
017200180426        clear welFile;
017300180426
017400180426        amtsa = %editc(actrst:'X') + '-' + %editc(acsub#:'X') + '-' +
017500180426                %editc(acacct:'X');
017600180426
017700180426        amacname = acnam1;
017800180427
017900180427        amasphfl = asphfl;
018000180426
018100180426        aminitinv = inendb;
018200180426        ampaidamt = totalAmount * -1;
018300180426
018400180426        fmtDate = %date(trdate:*iso);
018500180426        amtrdate = %char(fmtDate);
018600180426
018700180426        fmtDate = %date(enroll:*iso);
018800180426        ameffdate = %char(fmtDate);
018900180426
019000180426        fmtDate = %date(recvdt:*iso);
019100180426        amdatepay = %char(fmtDate);
019200180426
019300180517        chain (actrst : acsub# : acacct) miscFile;
019400180517        if %found;
019500180517         ammedicaid = ammaid;
019600180517        endif;
019700180517
019800180426        write welFile;
019900180426
020000180426       endsr;
020100180426
020200200724      //=======================================================================
020300200724      // check trust
020400200724      //=======================================================================
020500200724
020600200724       begsr checkTrust;
020700200724
020800200724        skipYN = 'N';
020900200724
021000200724        if actrst = 80;
021100200724         skipYN = 'Y';
021200200724        endif;
021300200918
021400200918        if actrst = 81;
021500200918         skipYN = 'Y';
021600200918        endif;
021700200928
021800200928        if actrst = 82;
021900200928         skipYN = 'Y';
022000200928        endif;
022100200724
022200200724       endsr;
022300200724
022400170711      //=======================================================================
022500200724      // exit
022600170711      //=======================================================================
022700170711
022800170711       begsr exit;
022900170711
023000170711        *inlr = '1';
023100170711        return;
023200170711
023300170711       endsr;
023400170711
023500170711      //=======================================================================
023600170711      // Init
023700170711      //=======================================================================
023800170711
023900170711       begsr init;
024000170712
024100180426        startDate = 20171024;
024200180426        //endDate = 20180320;
024300180426
024400180426        select;
024500180426         when type = 'S';
024600180426          SrDenAdvMob = 'O N';
024700180426         when type = 'M';
024800180426          SrDenAdvMob = 'O M';
024900180426         when type = 'A';
025000180426          SrDenAdvMob = 'O A';
025100200204         when type = 'C';
025200200204          SrDenAdvMob = 'O D';
025300180426        endsl;
025400180426
025500170711       endsr;
025600170711
025700170711      //=======================================================================
