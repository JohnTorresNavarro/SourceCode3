000100160203      *=========================================================================
000200160203     H option(*noDebugIo)
000300160203      *=========================================================================
000400160208      *
000500160208      *  Description: Aetna 834 Export. Create Incremential File.
000600160208      *  Programmer.: John Torres
000700160208      *  Date.......: 2/08/2016
000800160208      *
000900160208      *  Overview...: Aetna requested that we would send a incremential file
001000160208      *    instead of a full file.  A new database was setup to hold the sent
001100160208      *    records.
001200160208      *
001300160208      *
001400160208      *-------------------------------------------------------------------------
001500160208      * Modifications
001600160208      *
001700160208      * Date         Programmer    Description
001800160208      * ---------    ----------    ---------------------------------------------
001900160203
002000160208
002100160208      *=========================================================================
002200160208
002300170526     Faet090wd  uf   e             disk    rename(aet090wdr:mainFile)
002400160204     F                                     prefix(m_)
002500160203
002600170526     Faet090wds1uf a e           k disk    rename(aet090wdr:sentFile)
002700160204     F                                     prefix(s_)
002800160203
002900170526     Faet090wh  uf a e           k disk    rename(aet090wdr:holdFile)
003000160429     F                                     prefix(s_)
003100160428
003200160203      *=========================================================================
003300160204
003400160204     d mode            S              6
003500160204     d sendData        S              1
003600160208
003700160208      //========================================================================
003800160203
003900160203       setll 1 mainFile;
004000160203       read mainFile;
004100160203
004200160203       dow not %eof;
004300160204
004400160208        //?New record to be sent...
004500160208        mode = ' ';
004600160204        chain (m_e@key) sentFile;
004700160208        if not %found;
004800160208         mode = 'ADD';
004900160426          exsr writeTo_sentFile;
005000160426          m_e@trncode = s_e@trncode;
005100160426         update mainFile;
005200160804         write holdFile;
005300160208        endif;
005400160203
005500160208        //?See if it needs to be resent with changes...
005600160208        if %found;
005700160208         exsr compareTo_sentFile;
005800160204
005900160208         if sendData = 'Y';
006000160208          exsr updateRecord;
006100160428          m_e@trncode = s_e@trncode;
006200160428         update mainFile;
006300160208         endif;
006400160204
006500160208         if sendData = 'N';
006600160208          delete mainFile;
006700160208         endif;
006800160204
006900160208        endif;
007000160204
007100160203       read mainFile;
007200160203       enddo;
007300160203
007400160203       *inlr = *on;
007500160203       return;
007600160203
007700160204       //=========================================
007800160204       // Write to Saved file
007900160204       //=========================================
008000160204
008100160204       begsr writeTo_sentFile;
008200160204
008300160204        clear sentFile;
008400160204
008500160204        s_@ss1f = %trim(m_@ss1f);
008600160204        s_@ss2f = %trim(m_@ss2f);
008700160204        s_@fnf = %trim(m_@fnf);
008800160204        s_@mif = %trim(m_@mif);
008900160204        s_@lnf = %trim(m_@lnf);
009000160204        s_@relf = %trim(m_@relf);
009100160204        s_@sexf = %trim(m_@sexf);
009200160204        s_@dobf = %trim(m_@dobf);
009300160204        s_@specf = %trim(m_@specf);
009400160204        //s_@zero = %trim('0');
009500160204        s_@cobf = %trim(m_@cobf);
009600160204        s_@cobcf = %trim(m_@cobcf);
009700160204        s_@cobnf = %trim(m_@cobnf);
009800160204        s_@ad1f = %trim(m_@ad1f);
009900160204        s_@ad2f = %trim(m_@ad2f);
010000160204        s_@ctyf = %trim(m_@ctyf);
010100160204        s_@stf = %trim(m_@stf);
010200160204        s_@zp5f = %trim(m_@zp5f);
010300160204        s_@phnf = %trim(m_@phnf);
010400160204        s_@zipf = %trim(m_@zipf);
010500160204        s_@empstf = %trim(m_@empstf);
010600160204        s_x@elrf = %trim(m_x@elrf);
010700160204        s_h@c#f = %trim(m_h@c#f);
010800160204        s_e@sfxf = %trim(m_e@sfxf);
010900160204        s_e@acctf = %trim(m_e@acctf);
011000160204        s_e@planf = %trim(m_e@planf);
011100160301        s_e@prdct = %trim(m_e@prdct);
011200160204        s_x@efff = %trim(m_x@efff);
011300160204        s_x@trmf = %trim(m_x@trmf);
011400160204        s_e@clmf = %trim(m_e@clmf);
011500160204        s_e@pcpf = %trim(m_e@pcpf);
011600160204        s_e@cbrexpf = %trim(m_e@cbrexpf);
011700160204        s_e@cbrevtf = %trim(m_e@cbrevtf);
011800160208        s_@hiref = %trim(m_@hiref);
011900160204
012000160204        s_e@tdate =  %char(%dec(%date: *iso));
012100160204
012200160204        s_e@key = m_e@key;
012300160208
012400160208        s_e@trncode = '021';
012500160204
012600160204        write sentFile;
012700160204
012800160204       endsr;
012900160204
013000160204       //=========================================
013100160204       // Comapare to saved file
013200160204       //=========================================
013300160204
013400160204       begsr compareTo_sentFile;
013500160204
013600160204       sendData = 'N' ;
013700160204
013800160204       if m_@ss1f <> s_@ss1f;
013900160204        mode = 'CHANGE';
014000160208        sendData = 'Y';
014100160204       endif;
014200160204
014300160208       if m_@ss2f <> s_@ss2f;
014400160204        mode = 'CHANGE';
014500160208        sendData = 'Y';
014600160204       endif;
014700160204
014800160204       if m_@fnf <> s_@fnf;
014900160204        m_e@reasoncd = '25';
015000160204         mode = 'CHANGE';
015100160208        sendData = 'Y';
015200160204       endif;
015300160204
015400160204       if m_@lnf <> s_@lnf;
015500160204        m_e@reasoncd = '25';
015600160204         mode = 'CHANGE';
015700160208        sendData = 'Y';
015800160204       endif;
015900160204
016000160204       if m_@mif <> s_@mif;
016100160204        m_e@reasoncd = '25';
016200160204         mode = 'CHANGE';
016300160208        sendData = 'Y';
016400160204       endif;
016500160204
016600160204       if m_@relf <> s_@relf;
016700160204        mode = 'CHANGE';
016800160208        sendData = 'Y';
016900160204       endif;
017000160204
017100160204       if m_@sexf <> s_@sexf;
017200160204        mode = 'CHANGE';
017300160204        SendData = 'Y';
017400160204       endif;
017500160204
017600160204       if m_@dobf <> s_@dobf;
017700160204        m_e@reasoncd = '25';
017800160204         mode = 'CHANGE';
017900160208        sendData = 'Y';
018000160204       endif;
018100160204
018200160204       if m_@ad1f <> s_@ad1f;
018300160204        m_e@reasoncd = '43';
018400160204         mode = 'CHANGE';
018500160208        sendData = 'Y';
018600160204       endif;
018700160204
018800160204       if m_@ad2f <> s_@ad2f;
018900160204        m_e@reasoncd = '43';
019000160204          mode = 'CHANGE';
019100160204         SendData = 'Y';
019200160204       endif;
019300160204
019400160204       if m_@ctyf <> s_@ctyf;
019500160204        m_e@reasoncd = '43';
019600160204         mode = 'CHANGE';
019700160208        sendData = 'Y';
019800160204       endif;
019900160204
020000160204       if m_@stf <> s_@stf;
020100160204        m_e@reasoncd = '43';
020200160204         mode = 'CHANGE';
020300160208        sendData = 'Y';
020400160204       endif;
020500160204
020600160204       if m_@zp5f  <> s_@zp5f;
020700160204        m_e@reasoncd = '43';
020800160204         mode = 'CHANGE';
020900160204        sendData = 'Y';
021000160204       endif;
021100160204
021200160204       if m_@phnf <> s_@phnf;
021300160204        mode = 'CHANGE';
021400160204        sendData = 'Y';
021500160204       endif;
021600160204
021700160204       if m_@empstf  <> s_@empstf;
021800160204        Mode = 'CHANGE';
021900160208        sendData = 'Y';
022000160204       endif;
022100160204
022200160204       if m_x@elrf <> s_x@elrf;
022300160204        mode = 'CHANGE';
022400160204        sendData = 'Y';
022500160204       endif;
022600160204
022700160204       if m_h@c#f <> s_h@c#f;
022800160204        mode = 'CHANGE';
022900160204        sendData = 'Y';
023000160204       endif;
023100160204
023200160204       if m_e@sfxf <> s_e@sfxf;
023300160204        mode = 'CHANGE';
023400160204        sendData = 'Y';
023500160204       endif;
023600160204
023700160204       if m_e@acctf <> s_e@acctf;
023800160204        mode = 'CHANGE';
023900160204        sendData = 'Y';
024000160204       endif;
024100160204
024200160204       if m_e@planf <> s_e@planf;
024300160204        m_e@reasoncd = '22';
024400160204         mode = 'CHANGE';
024500160204        sendData = 'Y';
024600160204       endif;
024700160204
024800160208       if m_@hiref <> s_@hiref;
024900160208         mode = 'CHANGE';
025000160208        sendData = 'Y';
025100160208       endif;
025200160204
025300160204       //   if EVENRL    <> snevENRL;
025400160204       //       Mode = 'CHANGE';
025500160204       //       SendData = 'Y';
025600160204       //   endif;
025700160204
025800160301       if m_e@prdct <> s_e@prdct;
025900160301        mode = 'CHANGE';
026000160301        sendData = 'Y';
026100160301       endif;
026200160301
026300160204       if m_x@efff <> s_x@efff;
026400160204        mode = 'CHANGE';
026500160204        sendData = 'Y';
026600160204       endif;
026700160204
026800160208       //?Check to see if the Member was Termed.
026900160204       if m_x@trmf <> s_x@trmf;
027000160204        if m_x@trmf > '0' ;
027100160204         m_e@reasoncd = '08';
027200160204          mode = 'TERMED';
027300160204         sendData = 'Y';
027400160204        endif;
027500160204       endif;
027600160204
027700160204       //?Check to see if the Member was Termed.
027800160204       //if evTerm <> snevterm ;
027900160204       // if evTerm > '0' ;
028000160204       //  evreasoncd = '08';
028100160204       //   Mode = 'TERMED';
028200160204       //  SendData = 'Y';
028300160204       // endif;
028400160204       //endif;
028500160204
028600160208       //?Check to see if the Member was Reinstated.
028700160208       if m_x@trmf  = '0' and s_x@trmf <> '0';
028800160208        mode = 'REINSTATE';
028900160208        sendData = 'Y';
029000160208       endif;
029100160208
029200160204       //?Check to see if the Member was Reinstated.
029300160204       //if evTerm = '0'  and snevTerm <> '0';
029400160204       // Mode = 'REINSTATE';
029500160204       // SendData = 'Y';
029600160204       //endif;
029700160204
029800160204       if m_e@clmf <> s_e@clmf;
029900160204        mode = 'CHANGE';
030000160204        sendData = 'Y';
030100160204       endif;
030200160204
030300160204       if m_e@pcpf <> s_e@pcpf;
030400160204        mode = 'CHANGE';
030500160204        sendData = 'Y';
030600160204       endif;
030700160204
030800160204       if m_e@cbrexpf <> s_e@cbrexpf;
030900160204        mode = 'CHANGE';
031000160204        sendData = 'Y';
031100160204       endif;
031200160204
031300160204       if m_e@cbrevtf <> s_e@cbrevtf;
031400160204        mode = 'CHANGE';
031500160204        sendData = 'Y';
031600160204       endif;
031700160204
031800160204       endsr;
031900160204
032000160204       //=========================================
032100160204       // Write to Saved file
032200160204       //=========================================
032300160204
032400160204       begsr updateRecord;
032500160204
032600160204        s_@ss1f = %trim(m_@ss1f);
032700160204        s_@ss2f = %trim(m_@ss2f);
032800160204        s_@fnf = %trim(m_@fnf);
032900160204        s_@mif = %trim(m_@mif);
033000160204        s_@lnf = %trim(m_@lnf);
033100160204        s_@relf = %trim(m_@relf);
033200160204        s_@sexf = %trim(m_@sexf);
033300160204        s_@dobf = %trim(m_@dobf);
033400160204        s_@specf = %trim(m_@specf);
033500160204        //s_@zero = %trim('0');
033600160204        s_@cobf = %trim(m_@cobf);
033700160204        s_@cobcf = %trim(m_@cobcf);
033800160204        s_@cobnf = %trim(m_@cobnf);
033900160204        s_@ad1f = %trim(m_@ad1f);
034000160204        s_@ad2f = %trim(m_@ad2f);
034100160204        s_@ctyf = %trim(m_@ctyf);
034200160204        s_@stf = %trim(m_@stf);
034300160204        s_@zp5f = %trim(m_@zp5f);
034400160204        s_@phnf = %trim(m_@phnf);
034500160204        s_@zipf = %trim(m_@zipf);
034600160204        s_@empstf = %trim(m_@empstf);
034700160204        s_x@elrf = %trim(m_x@elrf);
034800160204        s_h@c#f = %trim(m_h@c#f);
034900160204        s_e@sfxf = %trim(m_e@sfxf);
035000160204        s_e@acctf = %trim(m_e@acctf);
035100160204        s_e@planf = %trim(m_e@planf);
035200160301        s_e@prdct = %trim(m_e@prdct);
035300160204        s_x@efff = %trim(m_x@efff);
035400160204        s_x@trmf = %trim(m_x@trmf);
035500160204        s_e@clmf = %trim(m_e@clmf);
035600160204        s_e@pcpf = %trim(m_e@pcpf);
035700160204        s_e@cbrexpf = %trim(m_e@cbrexpf);
035800160204        s_e@cbrevtf = %trim(m_e@cbrevtf);
035900160208        s_@hiref = %trim(m_@hiref);
036000160204
036100160204        s_e@tdate =  %char(%dec(%date: *iso));
036200160204
036300160204        s_e@key = m_e@key;
036400160204
036500160204        //?Write Record Status.
036600160204        Select;
036700160204         when Mode = 'ADD';
036800160419         s_e@trncode = '021';
036900160204
037000160204         when Mode = 'CHANGE';
037100160204         s_e@trncode = '001';
037200160428         write holdFile;
037300160204
037400160204         when Mode = 'TERMED';
037500160204         s_e@trncode = '024';
037600160204
037700160204         when Mode = 'REINSTATE';
037800160204         s_e@trncode = '025';
037900160204
038000160204        endsl;
038100160204
038200160204        update sentFile;
038300160204
038400160204       endsr;
038500160204
038600160203       //=========================================
