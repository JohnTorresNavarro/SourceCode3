000100080618     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200080618     H option(*SRCSTMT: *NODEBUGIO)
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500070717    ? *  Description:  BUILD PW FILES "A" RECORDS
000600070806    ? *
000700070806    ? *  MUST RUN BEFORE *MID-NIGHT*
000800000000    ? *
000900061129    ? *  (c)Copyright 2006 by GBS, Inc.
001000000000    ? *___________________________________________________________________
001100070718     FACCOSP    UP   E           K DISK
001200120606     FOEUSER    UF   E           K Disk
001300130524     FACCMST    IF   E           K Disk
001400130524     FACCMSP    IF   E           K Disk
001500080424     FHISTLF    IF   E           K Disk
001600070723     FOEREPOSL2 IF   E           K Disk
001700070723     FPWINFOLF  UF A E           K Disk
001800070718     FPWGRID    UF A E           K Disk
001900070718
002000080618      * Prototypes
002100080618      /COPY *LIBL/QMODSRC,#PROTO
002200080618
002300070719     D Today           s              8S 0 inz
002400070719     D Tomorrow        s              8S 0 inz
002500070719    ?D  TodayISO       S               D   datfmt(*ISO)
002600070720
002700120606     D WWEMAL          s            100    inz
002800070720     D TranFlag        s              1    inz
002900080618     D Tic             s              1a   inz(x'7D')
003000080618     D Pos             s              3s 0 inz
003100080424
003200070718     D OETSA           DS
003300070718     D OE                      1      2    Inz('OE')
003400070718     D Trst                    3      5    Inz
003500070718     D Sub#                    6      8    Inz
003600070718     D Acct                    9     12    Inz
003700070718
003800070718      *---------------------------------------------------------------*
003900191120     C                   If        AOTRST = 905 and
004000160323     C                             AOSUB# = 001 and
004100191120     C                             AOACCT = 0140
004200130524
004300130524
004400130524      * Get payroll code
004500130524     C     AKey          Chain     ACCMSP
004600130524     C                   If        not %found(ACCMSP)
004700130524     C                   Clear                   AMPAYR
004800130524     C                   End
004900120817
005000111017      * If changing from 2-6 or 3-7 - ReSend users to Kevin
005100111017     C                   If        AODTDT = *Zeros  and
005200111017     C                             AOBEDT <> AOENDT and
005300111017     C                             AOBEDT >= Today  and
005400111017     C                             %trim(AOLMXGRP) = 'CHANGE'
005500111017     C     AKey          Setll     OEUSER
005600111017     C     AKey          Reade     OEUSER
005700111017    ?C                   Dow       Not %Eof(OEUSER)
005800111017     C                   If        OUENDT = 0
005900111017     C                   Eval      OUESNT = 0
006000111017     C                   Update    OEUSERR
006100111017     C                   End
006200111017     C     AKey          Reade     OEUSER
006300111017     C                   Enddo
006400111017     C                   End
006500080506
006600070720     C                   eval      TranFlag = 'N'
006700070718      * Process records equal to Today
006800070718     C                   Select
006900100921      *
007000100921      * Activation New Logic send same day entered into system. Per Dave A.
007100100921      * Per Dave A. Cindy, Kathy. 9/21/2010
007200100921     C                   When      AODTDT = *Zeros  and
007300120712     C                             AOBEDT <> AOENDT and
007400120712     C                             AOENDT =  0      and
007500120921     C                             AOBEDT >= Today  or
007600120921     C                             AODTDT = *Zeros  and
007700120921     C                             AOBEDT <> AOENDT and
007800120921     C                             AOENDT =  0      and
007900120921     C                             AOBEDT <  Today
008000100921     C                   Exsr      PWreset
008100100921     C                   Exsr      Activate
008200120831
008300120831      * Same Day Terms - Do nothing
008400120831     C                   When      AOBEDT = AOENDT
008500100921
008600080424      * Same Day Terms - Check for email sent
008700080507     C                   When      AOBEDT = AOENDT  and
008800080507     C                             AOBEDT = Today
008900080424     C                   Exsr      CheckHist
009000070718      * Activate
009100121107     C*****              When      AOBEDT = Tomorrow and
009200121107     C*****                        AOENDT =  0      and
009300121107     C*****                        AOBEDT <> AOENDT
009400121107     C*****              Exsr      PWreset
009500121107     C*****              Exsr      Activate
009600070718      * Terminate
009700121107     C                   When      AOENDT = Tomorrow and
009800121107     C                             AODTDT = *Zeros
009900070718     C                   Exsr      PWreset
010000070718     C                   Exsr      Terminate
010100080513      * Daily 1
010200070718     C                   When      Today  > AOBEDT and
010300070718     C                             Today  < AOENDT
010400070718     C                   Exsr      PWreset
010500070718     C                   Exsr      CheckDaily
010600080513      * Daily 2
010700080513     C                   When      Today  > AOBEDT and
010800080513     C                             AOENDT = 0
010900080513     C                   Exsr      PWreset
011000080513     C                   Exsr      CheckDaily
011100070718     C                   Endsl
011200070720
011300070720      * Check for Transmission
011400070720     C                   Exsr      Transmit
011500120817
011600160323     C                   End
011700070718      *---------------------------------------------------------------*
011800070718     C     Activate      Begsr
011900070718     C     AKey          Setll     OEUSER
012000070718     C     AKey          Reade     OEUSER
012100070718    ?C                   Dow       Not %Eof(OEUSER)
012200121015     C                   If        OUENDT = 0  and
012300110713     C                             OUESNT = 0
012400121015
012500120606      * Save email
012600120606     C                   Eval      WWEMAL = %trim(OUEMAL)
012700111017
012800111017      * If changing from 2-6 or 3-7 - Do Not Send Emails
012900130218      * per Cindy 02.18.2013 allow emails to go out.
013000130218     C*******            If        %trim(AOLMXGRP) = 'CHANGE'
013100130218     C*******            Eval      WWEMAL = *blanks
013200130218     C*******            End
013300070828
013400110316     C                   Eval      PKID   = Trst + Sub# + Acct
013500110316     C                   Eval      PKAL   = %trim(OUUSER)
013600110316
013700100921     C*** Per Dave A.    If        Tomorrow >= OUBEDT and
013800100921     C*** Per Cindy                OUENDT = 0       or
013900100921     C*** Per Kathy                Tomorrow >= OUBEDT and
014000100921     C***                          Tomorrow <= OUENDT
014100070723
014200070718     C                   Select
014300070718     C                   When      AOCODE = 01
014400070718     C                   Exsr      CODE01
014500070718     C                   When      AOCODE = 02
014600070718     C                   Exsr      CODE02
014700070718     C                   When      AOCODE = 03
014800070718     C                   Exsr      CODE03
014900110412     C                   When      AOCODE = 04
015000110412     C                   Exsr      CODE04
015100110412     C                   When      AOCODE = 05
015200110412     C                   Exsr      CODE05
015300111017     C                   When      AOCODE = 06
015400111017     C                   Exsr      CODE06
015500111017     C                   When      AOCODE = 07
015600111017     C                   Exsr      CODE07
015700150422     C                   When      AOCODE = 08
015800150422     C                   Exsr      CODE08
015900150422     C                   When      AOCODE = 09
016000150422     C                   Exsr      CODE09
016100070718     C                   Endsl
016200070724
016300100921     C***                End
016400120606
016500120606     C                   Eval      OUESNT = Today
016600120606     C                   Update    OEUSERR
016700110713
016800110713     C                   End
016900070718     C     AKey          Reade     OEUSER
017000070718     C                   Enddo
017100070718
017200070718      * Create OE Generic Login
017300070720     C                   If        AOCODE   = 03  and
017400070720     C                             TranFlag = 'Y'
017500070718     C                   Exsr      OE03
017600070718     C                   End
017700120828
017800110412     C                   If        AOCODE   = 05  and
017900110412     C                             TranFlag = 'Y'
018000110817     C** No Screen 2     Exsr      OE05
018100110412     C                   End
018200120828
018300120828     C                   If        AOCODE   = 07  and
018400120828     C                             TranFlag = 'Y'
018500120828     C                   Exsr      OE07
018600120828     C                   End
018700070718
018800070718     C                   Endsr
018900070718      *---------------------------------------------------------------*
019000070718     C     Terminate     Begsr
019100070718     C     AKey          Setll     OEUSER
019200070718     C     AKey          Reade     OEUSER
019300070718    ?C                   Dow       Not %Eof(OEUSER)
019400121015
019500121015      * If "A" skip Kevin process
019600160309     C***                If        %trim(OUEMEX) = 'A'
019700160309     C***                LeaveSR
019800160309     C***                End
019900110316
020000110316     C                   Eval      PKID   = Trst + Sub# + Acct
020100110316     C                   Eval      PKAL   = %trim(OUUSER)
020200120625
020300130607      * Terminating = no email to user
020400130607     C                   Eval      WWEMAL = *blanks
020500070718
020600070718     C                   If        Today >= OUBEDT and
020700070718     C                             OUENDT = 0       or
020800070718     C                             Today >= OUBEDT and
020900070718     C                             Today <= OUENDT
021000070723
021100070718     C                   Select
021200070718     C                   When      AOCODE = 01
021300070718     C                   Exsr      CODE01T
021400070718     C                   When      AOCODE = 02
021500070718     C                   Exsr      CODE02T
021600070718     C                   When      AOCODE = 03
021700070718     C                   Exsr      CODE03T
021800110412     C                   When      AOCODE = 04
021900110412     C                   Exsr      CODE04T
022000110412     C                   When      AOCODE = 05
022100110412     C                   Exsr      CODE05T
022200111017     C                   When      AOCODE = 06
022300111017     C                   Exsr      CODE06T
022400111017     C                   When      AOCODE = 07
022500111017     C                   Exsr      CODE07T
022600150422     C                   When      AOCODE = 08
022700150422     C                   Exsr      CODE08T
022800150422     C                   When      AOCODE = 09
022900150422     C                   Exsr      CODE09T
023000070718     C                   Endsl
023100120606
023200121009      * DO NOT UPDATE the SENT Date on a Term
023300121009      * otherwise the ADD that follows will not send (leave it alone)
023400121009     C****               Eval      OUESNT = Today
023500121009
023600120606     C                   Update    OEUSERR
023700070724
023800070718     C                   End
023900070718
024000070718     C     AKey          Reade     OEUSER
024100070718     C                   Enddo
024200070718
024300070718      * Create OE Generic Login
024400070720     C                   If        AOCODE   = 03  and
024500070720     C                             TranFlag = 'Y'
024600070718     C                   Exsr      OE03T
024700070718     C                   End
024800110412     C                   If        AOCODE   = 05  and
024900110412     C                             TranFlag = 'Y'
025000110817     C** No Screen 2     Exsr      OE05T
025100110412     C                   End
025200120828     C                   If        AOCODE   = 07  and
025300120828     C                             TranFlag = 'Y'
025400120828     C                   Exsr      OE07T
025500120828     C                   End
025600070718
025700070718     C                   Endsr
025800080424      *---------------------------------------------------------------*
025900080424     C     CheckHist     Begsr
026000080424      *
026100080424      * If email was sent already for this same day term, then
026200080424      * we do want to process this term.
026300080512
026400080512     C                   Movel     AOTRST        Trst
026500080512     C                   Movel     AOSUB#        Sub#
026600080512     C                   Movel     AOACCT        Acct
026700080424      *
026800080424     C                   Eval      HKEY   = Trst + Sub# + Acct
026900080424      *
027000080508     C     HKEY          Setll     HISTLF
027100080508     C     HKEY          Reade     HISTLF
027200080424     C                   Dow       not %eof(HISTLF)
027300080424     C                   Select
027400080508     C                   When      TRCODE = 'U44' and
027500080508     C                             COVTDT = AOBEDT
027600080424     C                   Exsr      PWreset
027700080424     C                   Exsr      Terminate
027800080508     C                   When      TRCODE = 'U45' and
027900080508     C                             COVTDT = AOBEDT
028000080424     C                   Exsr      PWreset
028100080424     C                   Exsr      Terminate
028200080508     C                   When      TRCODE = 'U46' and
028300080508     C                             COVTDT = AOBEDT
028400080424     C                   Exsr      PWreset
028500080424     C                   Exsr      Terminate
028600080508     C                   When      TRCODE = 'U47' and
028700080508     C                             COVTDT = AOBEDT
028800080424     C                   Exsr      PWreset
028900080424     C                   Exsr      Terminate
029000080508     C                   When      TRCODE = 'U48' and
029100080508     C                             COVTDT = AOBEDT
029200080424     C                   Exsr      PWreset
029300080424     C                   Exsr      Terminate
029400080508     C                   When      TRCODE = 'U49' and
029500080508     C                             COVTDT = AOBEDT
029600080424     C                   Exsr      PWreset
029700080424     C                   Exsr      Terminate
029800080424     C                   Endsl
029900080508     C     HKEY          Reade     HISTLF
030000080424     C                   Enddo
030100080424
030200080424     C                   Endsr
030300070718      *---------------------------------------------------------------*
030400070718     C     CheckDaily    Begsr
030500070718     C     AKey          Setll     OEUSER
030600070718     C     AKey          Reade     OEUSER
030700070718    ?C                   Dow       Not %Eof(OEUSER)
030800121015
030900121015      * If "A" skip Kevin process
031000160309     C***                If        %trim(OUEMEX) = 'A'
031100160309     C***                LeaveSR
031200160309     C***                End
031300110316
031400110316     C                   Eval      PKID   = Trst + Sub# + Acct
031500110316     C                   Eval      PKAL   = %trim(OUUSER)
031600120625
031700120625      * Save email
031800120625     C                   Eval      WWEMAL = %trim(OUEMAL)
031900070718
032000070718      * If Starting Today
032100110713     C                   If        Today  = OUBEDT  and
032200110713     C                             OUENDT = 0       and
032300110713     C                             OUESNT = 0
032400070723
032500070718     C                   Select
032600070718     C                   When      AOCODE = 01
032700070718     C                   Exsr      CODE01
032800070718     C                   When      AOCODE = 02
032900070718     C                   Exsr      CODE02
033000070719     C                   When      AOCODE = 03
033100070719     C                   Exsr      CODE03
033200110412     C                   When      AOCODE = 04
033300110412     C                   Exsr      CODE04
033400110412     C                   When      AOCODE = 05
033500110412     C                   Exsr      CODE05
033600111017     C                   When      AOCODE = 06
033700111017     C                   Exsr      CODE06
033800111017     C                   When      AOCODE = 07
033900111017     C                   Exsr      CODE07
034000150422     C                   When      AOCODE = 08
034100150422     C                   Exsr      CODE08
034200150422     C                   When      AOCODE = 09
034300150422     C                   Exsr      CODE09
034400070718     C                   Endsl
034500120606
034600120606     C                   Eval      OUESNT = Today
034700120606     C                   Update    OEUSERR
034800070724
034900070718     C                   End
035000070718
035100100512      * If user is terming today create pwinfo record, no email.
035200070718     C                   If        Today  = OUENDT
035300070724
035400100512     C                   Select
035500100512     C                   When      AOCODE = 01
035600100512     C                   Exsr      CODE01U
035700100512     C                   When      AOCODE = 02
035800100512     C                   Exsr      CODE02U
035900100512     C                   When      AOCODE = 03
036000100512     C                   Exsr      CODE03U
036100110412     C                   When      AOCODE = 04
036200110412     C                   Exsr      CODE04U
036300110412     C                   When      AOCODE = 05
036400110412     C                   Exsr      CODE05U
036500111017     C                   When      AOCODE = 06
036600111017     C                   Exsr      CODE06U
036700111017     C                   When      AOCODE = 07
036800111017     C                   Exsr      CODE07U
036900150422     C                   When      AOCODE = 08
037000150422     C                   Exsr      CODE08U
037100150422     C                   When      AOCODE = 09
037200150422     C                   Exsr      CODE09U
037300100512     C                   Endsl
037400070724
037500070718     C                   End
037600070718
037700070718     C     AKey          Reade     OEUSER
037800070718     C                   Enddo
037900070718     C                   Endsr
038000070718      *---------------------------------------------------------------*
038100070718     C     Code01        Begsr
038200070723     C     PKEY          Chain     PWINFOLF
038300070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
038400070718     C                   Eval      PWALUS = %trim(OUUSER)
038500070718     C                   Eval      PWROLE = 'act_'
038600070718     C                   Eval      PWDESC = %trim(ACNAM1)
038700120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
038800070718     C                   Eval      PWCODE = AOCODE
038900070718     C                   Eval      PWUBDT = OUBEDT
039000070718     C                   Eval      PWAACD = %trim(AACODE)
039100070718     C                   Eval      PWULNM = %trim(OULNAM)
039200070720     C                   Eval      PWUFNM = %trim(OUFNAM)
039300070720     C                   Eval      PWDTDT = TODAY
039400070718     C                   Exsr      GenPW
039500070723     C                   If        %found(PWINFOLF)
039600070723     C                   Update    PWINFOR
039700070723     C                   Else
039800070718     C                   Write     PWINFOR
039900070723     C                   End
040000070720     C                   eval      TranFlag = 'Y'
040100080307
040200070718      * 01
040300070718     C                   Eval      GRALUS = %trim(PWALUS)
040400070718     C                   Eval      GRGRPID = 100002
040500070718     C                   Eval      GRACTCD = 'A'
040600070720     C                   Eval      GRDTDT = TODAY
040700070723     C                   Eval      GRCODE = AOCODE
040800070718     C                   Write     PWGRIDR
040900070718
041000070718     C                   Endsr
041100070718      *---------------------------------------------------------------*
041200070718     C     Code02        Begsr
041300070723     C     PKEY          Chain     PWINFOLF
041400070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
041500070718     C                   Eval      PWALUS = %trim(OUUSER)
041600070718     C                   Eval      PWROLE = 'act_'
041700070718     C                   Eval      PWDESC = %trim(ACNAM1)
041800120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
041900070718     C                   Eval      PWCODE = AOCODE
042000070718     C                   Eval      PWUBDT = OUBEDT
042100070718     C                   Eval      PWAACD = %trim(AACODE)
042200070718     C                   Eval      PWULNM = %trim(OULNAM)
042300070718     C                   Eval      PWUFNM = %trim(OUFNAM)
042400070720     C                   Eval      PWDTDT = TODAY
042500070718     C                   Exsr      GenPW
042600070723     C                   If        %found(PWINFOLF)
042700070723     C                   Update    PWINFOR
042800070723     C                   Else
042900070723     C                   Write     PWINFOR
043000070723     C                   End
043100070720     C                   eval      TranFlag = 'Y'
043200070718
043300070718      * 01
043400070718     C                   Eval      GRALUS = %trim(PWALUS)
043500070718     C                   Eval      GRGRPID = 100002
043600070718     C                   Eval      GRACTCD = 'A'
043700070720     C                   Eval      GRDTDT = TODAY
043800070723     C                   Eval      GRCODE = AOCODE
043900070718     C                   Write     PWGRIDR
044000070718
044100070718      * 02
044200070718     C                   Eval      GRALUS = %trim(PWALUS)
044300070718     C                   Eval      GRGRPID = 100115
044400070718     C                   Eval      GRACTCD = 'A'
044500070720     C                   Eval      GRDTDT = TODAY
044600070723     C                   Eval      GRCODE = AOCODE
044700070718     C                   Write     PWGRIDR
044800070718
044900070718     C                   Endsr
045000070718      *---------------------------------------------------------------*
045100070718     C     Code03        Begsr
045200070723     C     PKEY          Chain     PWINFOLF
045300070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
045400070718     C                   Eval      PWALUS = %trim(OUUSER)
045500070723     C                   Eval      PWROLE = 'act_'
045600070718     C                   Eval      PWDESC = %trim(ACNAM1)
045700120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
045800070718     C                   Eval      PWCODE = AOCODE
045900070718     C                   Eval      PWUBDT = OUBEDT
046000070718     C                   Eval      PWAACD = %trim(AACODE)
046100070718     C                   Eval      PWULNM = %trim(OULNAM)
046200070718     C                   Eval      PWUFNM = %trim(OUFNAM)
046300070720     C                   Eval      PWDTDT = TODAY
046400070718     C                   Exsr      GenPW
046500070723     C                   If        %found(PWINFOLF)
046600070723     C                   Update    PWINFOR
046700070723     C                   Else
046800070723     C                   Write     PWINFOR
046900070723     C                   End
047000070720     C                   eval      TranFlag = 'Y'
047100070718
047200070718      * 01
047300070718     C                   Eval      GRALUS = %trim(PWALUS)
047400070718     C                   Eval      GRGRPID = 100002
047500070718     C                   Eval      GRACTCD = 'A'
047600070720     C                   Eval      GRDTDT = TODAY
047700070723     C                   Eval      GRCODE = AOCODE
047800070718     C                   Write     PWGRIDR
047900070718
048000070718      * 02
048100070718     C                   Eval      GRALUS = %trim(PWALUS)
048200070718     C                   Eval      GRGRPID = 100115
048300070718     C                   Eval      GRACTCD = 'A'
048400070720     C                   Eval      GRDTDT = TODAY
048500070723     C                   Eval      GRCODE = AOCODE
048600070718     C                   Write     PWGRIDR
048700070731
048800070731      * 03
048900070731     C                   Eval      GRALUS = %trim(PWALUS)
049000070731     C                   Eval      GRGRPID = 100130
049100070731     C                   Eval      GRACTCD = 'A'
049200070731     C                   Eval      GRDTDT = TODAY
049300070731     C                   Eval      GRCODE = AOCODE
049400070731     C                   Write     PWGRIDR
049500130110      * 04
049600130110     C                   Eval      GRALUS = %trim(PWALUS)
049700130110     C                   Eval      GRGRPID = 100140
049800130110     C                   Eval      GRACTCD = 'A'
049900130110     C                   Eval      GRDTDT = TODAY
050000130110     C                   Eval      GRCODE = AOCODE
050100130110     C                   Write     PWGRIDR
050200070718
050300070718     C                   Endsr
050400110412      *---------------------------------------------------------------*
050500110412     C     Code04        Begsr
050600110412     C     PKEY          Chain     PWINFOLF
050700110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
050800110412     C                   Eval      PWALUS = %trim(OUUSER)
050900110412     C                   Eval      PWROLE = 'act_'
051000110412     C                   Eval      PWDESC = %trim(ACNAM1)
051100120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
051200110412     C                   Eval      PWCODE = AOCODE
051300110412     C                   Eval      PWUBDT = OUBEDT
051400110412     C                   Eval      PWAACD = %trim(AACODE)
051500110412     C                   Eval      PWULNM = %trim(OULNAM)
051600110412     C                   Eval      PWUFNM = %trim(OUFNAM)
051700110412     C                   Eval      PWDTDT = TODAY
051800110412     C                   Exsr      GenPW
051900110412     C                   If        %found(PWINFOLF)
052000110412     C                   Update    PWINFOR
052100110412     C                   Else
052200110412     C                   Write     PWINFOR
052300110412     C                   End
052400110412     C                   eval      TranFlag = 'Y'
052500110412
052600110412      * 01
052700110412     C                   Eval      GRALUS = %trim(PWALUS)
052800110412     C                   Eval      GRGRPID = 100002
052900110412     C                   Eval      GRACTCD = 'A'
053000110412     C                   Eval      GRDTDT = TODAY
053100110412     C                   Eval      GRCODE = AOCODE
053200110412     C                   Write     PWGRIDR
053300110412
053400110412      * 02
053500130524     C                   Eval      GRGRPID = 102115
053600110412     C                   Eval      GRALUS = %trim(PWALUS)
053700110412     C                   Eval      GRACTCD = 'A'
053800110412     C                   Eval      GRDTDT = TODAY
053900110412     C                   Eval      GRCODE = AOCODE
054000110412     C                   Write     PWGRIDR
054100110412
054200110412     C                   Endsr
054300110412      *---------------------------------------------------------------*
054400110412     C     Code05        Begsr
054500110412     C     PKEY          Chain     PWINFOLF
054600110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
054700110412     C                   Eval      PWALUS = %trim(OUUSER)
054800110412     C                   Eval      PWROLE = 'act_'
054900110412     C                   Eval      PWDESC = %trim(ACNAM1)
055000120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
055100110412     C                   Eval      PWCODE = AOCODE
055200110412     C                   Eval      PWUBDT = OUBEDT
055300110412     C                   Eval      PWAACD = %trim(AACODE)
055400110412     C                   Eval      PWULNM = %trim(OULNAM)
055500110412     C                   Eval      PWUFNM = %trim(OUFNAM)
055600110412     C                   Eval      PWDTDT = TODAY
055700110412     C                   Exsr      GenPW
055800110412     C                   If        %found(PWINFOLF)
055900110412     C                   Update    PWINFOR
056000110412     C                   Else
056100110412     C                   Write     PWINFOR
056200110412     C                   End
056300110412     C                   eval      TranFlag = 'Y'
056400110412
056500110412      * 01
056600110412     C                   Eval      GRALUS = %trim(PWALUS)
056700110412     C                   Eval      GRGRPID = 100002
056800110412     C                   Eval      GRACTCD = 'A'
056900110412     C                   Eval      GRDTDT = TODAY
057000110412     C                   Eval      GRCODE = AOCODE
057100110412     C                   Write     PWGRIDR
057200110412
057300110412      * 02
057400130524     C                   Eval      GRGRPID = 102115
057500110412     C                   Eval      GRALUS = %trim(PWALUS)
057600110412     C                   Eval      GRACTCD = 'A'
057700110412     C                   Eval      GRDTDT = TODAY
057800110412     C                   Eval      GRCODE = AOCODE
057900110412     C                   Write     PWGRIDR
058000110412
058100110412      * 03
058200110412     C                   Eval      GRALUS = %trim(PWALUS)
058300130110     C                   Eval      GRGRPID = 100140
058400110412     C                   Eval      GRACTCD = 'A'
058500110412     C                   Eval      GRDTDT = TODAY
058600110412     C                   Eval      GRCODE = AOCODE
058700110412     C                   Write     PWGRIDR
058800110412
058900110412     C                   Endsr
059000111017      *---------------------------------------------------------------*
059100111017     C     Code06        Begsr
059200111017     C     PKEY          Chain     PWINFOLF
059300111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
059400111017     C                   Eval      PWALUS = %trim(OUUSER)
059500111017     C                   Eval      PWROLE = 'act_'
059600111017     C                   Eval      PWDESC = %trim(ACNAM1)
059700120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
059800111017     C                   Eval      PWCODE = AOCODE
059900111017     C                   Eval      PWUBDT = OUBEDT
060000111017     C                   Eval      PWAACD = %trim(AACODE)
060100111017     C                   Eval      PWULNM = %trim(OULNAM)
060200111017     C                   Eval      PWUFNM = %trim(OUFNAM)
060300111017     C                   Eval      PWDTDT = TODAY
060400111017     C                   Exsr      GenPW
060500111017     C                   If        %found(PWINFOLF)
060600111017     C                   Update    PWINFOR
060700111017     C                   Else
060800111017     C                   Write     PWINFOR
060900111017     C                   End
061000111017     C                   eval      TranFlag = 'Y'
061100111017
061200111017      * 01
061300111017     C                   Eval      GRALUS = %trim(PWALUS)
061400111017     C                   Eval      GRGRPID = 100002
061500111017     C                   Eval      GRACTCD = 'A'
061600111017     C                   Eval      GRDTDT = TODAY
061700111017     C                   Eval      GRCODE = AOCODE
061800111017     C                   Write     PWGRIDR
061900111017
062000111017      * 02
062100111017     C                   Eval      GRALUS = %trim(PWALUS)
062200130524     C                   Eval      GRGRPID = 102115
062300111017     C                   Eval      GRACTCD = 'A'
062400111017     C                   Eval      GRDTDT = TODAY
062500111017     C                   Eval      GRCODE = AOCODE
062600111017     C                   Write     PWGRIDR
062700111017
062800111017     C                   Endsr
062900111017      *---------------------------------------------------------------*
063000111017     C     Code07        Begsr
063100111017     C     PKEY          Chain     PWINFOLF
063200111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
063300111017     C                   Eval      PWALUS = %trim(OUUSER)
063400111017     C                   Eval      PWROLE = 'act_'
063500111017     C                   Eval      PWDESC = %trim(ACNAM1)
063600120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
063700111017     C                   Eval      PWCODE = AOCODE
063800111017     C                   Eval      PWUBDT = OUBEDT
063900111017     C                   Eval      PWAACD = %trim(AACODE)
064000111017     C                   Eval      PWULNM = %trim(OULNAM)
064100111017     C                   Eval      PWUFNM = %trim(OUFNAM)
064200111017     C                   Eval      PWDTDT = TODAY
064300111017     C                   Exsr      GenPW
064400111017     C                   If        %found(PWINFOLF)
064500111017     C                   Update    PWINFOR
064600111017     C                   Else
064700111017     C                   Write     PWINFOR
064800111017     C                   End
064900111017     C                   eval      TranFlag = 'Y'
065000111017
065100111017      * 01
065200111017     C                   Eval      GRALUS = %trim(PWALUS)
065300111017     C                   Eval      GRGRPID = 100002
065400111017     C                   Eval      GRACTCD = 'A'
065500111017     C                   Eval      GRDTDT = TODAY
065600111017     C                   Eval      GRCODE = AOCODE
065700111017     C                   Write     PWGRIDR
065800111017
065900111017      * 02
066000111017     C                   Eval      GRALUS = %trim(PWALUS)
066100111017     C                   Eval      GRGRPID = 102115
066200111017     C                   Eval      GRACTCD = 'A'
066300111017     C                   Eval      GRDTDT = TODAY
066400111017     C                   Eval      GRCODE = AOCODE
066500111017     C                   Write     PWGRIDR
066600111017
066700111017      * 03
066800111017     C                   Eval      GRALUS = %trim(PWALUS)
066900130110     C                   Eval      GRGRPID = 100140
067000111017     C                   Eval      GRACTCD = 'A'
067100111017     C                   Eval      GRDTDT = TODAY
067200111017     C                   Eval      GRCODE = AOCODE
067300111017     C                   Write     PWGRIDR
067400111017
067500111017     C                   Endsr
067600150422      *---------------------------------------------------------------*
067700150422     C     Code08        Begsr
067800150422     C     PKEY          Chain     PWINFOLF
067900150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
068000150422     C                   Eval      PWALUS = %trim(OUUSER)
068100150422     C                   Eval      PWROLE = 'act_'
068200150422     C                   Eval      PWDESC = %trim(ACNAM1)
068300150422     C                   Eval      PWEMAIL = %trim(WWEMAL)
068400150422     C                   Eval      PWCODE = AOCODE
068500150422     C                   Eval      PWUBDT = OUBEDT
068600150422     C                   Eval      PWAACD = %trim(AACODE)
068700150422     C                   Eval      PWULNM = %trim(OULNAM)
068800150422     C                   Eval      PWUFNM = %trim(OUFNAM)
068900150422     C                   Eval      PWDTDT = TODAY
069000150422     C                   Exsr      GenPW
069100150422     C                   If        %found(PWINFOLF)
069200150422     C                   Update    PWINFOR
069300150422     C                   Else
069400150422     C                   Write     PWINFOR
069500150422     C                   End
069600150422     C                   eval      TranFlag = 'Y'
069700150422
069800150422      * 01
069900150422     C                   Eval      GRALUS = %trim(PWALUS)
070000150715     C                   Eval      GRGRPID = 100003
070100150422     C                   Eval      GRACTCD = 'A'
070200150422     C                   Eval      GRDTDT = TODAY
070300150422     C                   Eval      GRCODE = AOCODE
070400150422     C                   Write     PWGRIDR
070500150422
070600150422      * 02
070700150422     C                   Eval      GRGRPID = 100115
070800150422     C                   Eval      GRALUS = %trim(PWALUS)
070900150422     C                   Eval      GRACTCD = 'A'
071000150422     C                   Eval      GRDTDT = TODAY
071100150422     C                   Eval      GRCODE = AOCODE
071200150422     C                   Write     PWGRIDR
071300150422
071400150422     C                   Endsr
071500150422      *---------------------------------------------------------------*
071600150422     C     Code09        Begsr
071700150422     C     PKEY          Chain     PWINFOLF
071800150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
071900150422     C                   Eval      PWALUS = %trim(OUUSER)
072000150422     C                   Eval      PWROLE = 'act_'
072100150422     C                   Eval      PWDESC = %trim(ACNAM1)
072200150422     C                   Eval      PWEMAIL = %trim(WWEMAL)
072300150422     C                   Eval      PWCODE = AOCODE
072400150422     C                   Eval      PWUBDT = OUBEDT
072500150422     C                   Eval      PWAACD = %trim(AACODE)
072600150422     C                   Eval      PWULNM = %trim(OULNAM)
072700150422     C                   Eval      PWUFNM = %trim(OUFNAM)
072800150422     C                   Eval      PWDTDT = TODAY
072900150422     C                   Exsr      GenPW
073000150422     C                   If        %found(PWINFOLF)
073100150422     C                   Update    PWINFOR
073200150422     C                   Else
073300150422     C                   Write     PWINFOR
073400150422     C                   End
073500150422     C                   eval      TranFlag = 'Y'
073600150422
073700150422      * 01
073800150422     C                   Eval      GRALUS = %trim(PWALUS)
073900150715     C                   Eval      GRGRPID = 100003
074000150422     C                   Eval      GRACTCD = 'A'
074100150422     C                   Eval      GRDTDT = TODAY
074200150422     C                   Eval      GRCODE = AOCODE
074300150422     C                   Write     PWGRIDR
074400150422
074500150422      * 02
074600150422     C                   Eval      GRGRPID = 100115
074700150422     C                   Eval      GRALUS = %trim(PWALUS)
074800150422     C                   Eval      GRACTCD = 'A'
074900150422     C                   Eval      GRDTDT = TODAY
075000150422     C                   Eval      GRCODE = AOCODE
075100150422     C                   Write     PWGRIDR
075200150422
075300150422      * 03
075400150422     C                   Eval      GRALUS = %trim(PWALUS)
075500150422     C                   Eval      GRGRPID = 100140
075600150422     C                   Eval      GRACTCD = 'A'
075700150422     C                   Eval      GRDTDT = TODAY
075800150422     C                   Eval      GRCODE = AOCODE
075900150422     C                   Write     PWGRIDR
076000150422
076100150422     C                   Endsr
076200070718      *---------------------------------------------------------------*
076300070718     C     Code01T       Begsr
076400070723     C     PKEY          Chain     PWINFOLF
076500070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
076600070718     C                   Eval      PWALUS = %trim(OUUSER)
076700070718     C                   Eval      PWROLE = 'act_'
076800070718     C                   Eval      PWDESC = %trim(ACNAM1)
076900120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
077000070718     C                   Eval      PWCODE = AOCODE
077100070718     C                   Eval      PWUBDT = OUBEDT
077200070718     C                   Eval      PWAACD = %trim(AACODE)
077300070718     C                   Eval      PWULNM = %trim(OULNAM)
077400070718     C                   Eval      PWUFNM = %trim(OUFNAM)
077500130607     C                   Eval      PWOLPW = *BLANKS
077600070720     C                   Eval      PWDTDT = TODAY
077700070723     C                   If        %found(PWINFOLF)
077800070723     C                   Update    PWINFOR
077900070723     C                   Else
078000070723     C                   Write     PWINFOR
078100070723     C                   End
078200070720     C                   eval      TranFlag = 'Y'
078300070718
078400070718      * 01
078500070718     C                   Eval      GRALUS = %trim(PWALUS)
078600070718     C                   Eval      GRGRPID = 100002
078700070718     C                   Eval      GRACTCD = 'D'
078800070720     C                   Eval      GRDTDT = TODAY
078900070723     C                   Eval      GRCODE = AOCODE
079000070718     C                   Write     PWGRIDR
079100070718
079200070718     C                   Endsr
079300070718      *---------------------------------------------------------------*
079400070718     C     Code02T       Begsr
079500070723     C     PKEY          Chain     PWINFOLF
079600070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
079700070718     C                   Eval      PWALUS = %trim(OUUSER)
079800070718     C                   Eval      PWROLE = 'act_'
079900070718     C                   Eval      PWDESC = %trim(ACNAM1)
080000120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
080100070718     C                   Eval      PWCODE = AOCODE
080200070718     C                   Eval      PWUBDT = OUBEDT
080300070718     C                   Eval      PWAACD = %trim(AACODE)
080400070718     C                   Eval      PWULNM = %trim(OULNAM)
080500070718     C                   Eval      PWUFNM = %trim(OUFNAM)
080600130607     C                   Eval      PWOLPW = *BLANKS
080700070720     C                   Eval      PWDTDT = TODAY
080800070723     C                   If        %found(PWINFOLF)
080900070723     C                   Update    PWINFOR
081000070723     C                   Else
081100070723     C                   Write     PWINFOR
081200070723     C                   End
081300070720     C                   eval      TranFlag = 'Y'
081400080307
081500070718      * 01
081600070718     C                   Eval      GRALUS = %trim(PWALUS)
081700070718     C                   Eval      GRGRPID = 100002
081800070718     C                   Eval      GRACTCD = 'D'
081900070720     C                   Eval      GRDTDT = TODAY
082000070723     C                   Eval      GRCODE = AOCODE
082100070718     C                   Write     PWGRIDR
082200070718
082300070718      * 02
082400070718     C                   Eval      GRALUS = %trim(PWALUS)
082500070718     C                   Eval      GRGRPID = 100115
082600070718     C                   Eval      GRACTCD = 'D'
082700070720     C                   Eval      GRDTDT = TODAY
082800070723     C                   Eval      GRCODE = AOCODE
082900070718     C                   Write     PWGRIDR
083000070718
083100070718     C                   Endsr
083200070718      *---------------------------------------------------------------*
083300070718     C     Code03T       Begsr
083400070723     C     PKEY          Chain     PWINFOLF
083500070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
083600070718     C                   Eval      PWALUS = %trim(OUUSER)
083700070723     C                   Eval      PWROLE = 'act_'
083800070718     C                   Eval      PWDESC = %trim(ACNAM1)
083900120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
084000070718     C                   Eval      PWCODE = AOCODE
084100070718     C                   Eval      PWUBDT = OUBEDT
084200070718     C                   Eval      PWAACD = %trim(AACODE)
084300070718     C                   Eval      PWULNM = %trim(OULNAM)
084400070718     C                   Eval      PWUFNM = %trim(OUFNAM)
084500130607     C                   Eval      PWOLPW = *BLANKS
084600070720     C                   Eval      PWDTDT = TODAY
084700070723     C                   If        %found(PWINFOLF)
084800070723     C                   Update    PWINFOR
084900070723     C                   Else
085000070723     C                   Write     PWINFOR
085100070723     C                   End
085200070720     C                   eval      TranFlag = 'Y'
085300070718
085400070718      * 01
085500070718     C                   Eval      GRALUS = %trim(PWALUS)
085600070718     C                   Eval      GRGRPID = 100002
085700070718     C                   Eval      GRACTCD = 'D'
085800070720     C                   Eval      GRDTDT = TODAY
085900070723     C                   Eval      GRCODE = AOCODE
086000070718     C                   Write     PWGRIDR
086100070718
086200070718      * 02
086300070718     C                   Eval      GRALUS = %trim(PWALUS)
086400070718     C                   Eval      GRGRPID = 100115
086500070718     C                   Eval      GRACTCD = 'D'
086600070720     C                   Eval      GRDTDT = TODAY
086700070723     C                   Eval      GRCODE = AOCODE
086800070718     C                   Write     PWGRIDR
086900070731
087000070731      * 03
087100070731     C                   Eval      GRALUS = %trim(PWALUS)
087200070731     C                   Eval      GRGRPID = 100130
087300070731     C                   Eval      GRACTCD = 'D'
087400070731     C                   Eval      GRDTDT = TODAY
087500070731     C                   Eval      GRCODE = AOCODE
087600070731     C                   Write     PWGRIDR
087700130110
087800130110      * 03
087900130110     C                   Eval      GRALUS = %trim(PWALUS)
088000130110     C                   Eval      GRGRPID = 100140
088100130110     C                   Eval      GRACTCD = 'D'
088200130110     C                   Eval      GRDTDT = TODAY
088300130110     C                   Eval      GRCODE = AOCODE
088400130110     C                   Write     PWGRIDR
088500070718
088600070718     C                   Endsr
088700110412      *---------------------------------------------------------------*
088800110412     C     Code04T       Begsr
088900110412     C     PKEY          Chain     PWINFOLF
089000110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
089100110412     C                   Eval      PWALUS = %trim(OUUSER)
089200110412     C                   Eval      PWROLE = 'act_'
089300110412     C                   Eval      PWDESC = %trim(ACNAM1)
089400120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
089500110412     C                   Eval      PWCODE = AOCODE
089600110412     C                   Eval      PWUBDT = OUBEDT
089700110412     C                   Eval      PWAACD = %trim(AACODE)
089800110412     C                   Eval      PWULNM = %trim(OULNAM)
089900110412     C                   Eval      PWUFNM = %trim(OUFNAM)
090000130607     C                   Eval      PWOLPW = *BLANKS
090100110412     C                   Eval      PWDTDT = TODAY
090200110412     C                   If        %found(PWINFOLF)
090300110412     C                   Update    PWINFOR
090400110412     C                   Else
090500110412     C                   Write     PWINFOR
090600110412     C                   End
090700110412     C                   eval      TranFlag = 'Y'
090800110412
090900110412      * 01
091000110412     C                   Eval      GRALUS = %trim(PWALUS)
091100110412     C                   Eval      GRGRPID = 100002
091200110412     C                   Eval      GRACTCD = 'D'
091300110412     C                   Eval      GRDTDT = TODAY
091400110412     C                   Eval      GRCODE = AOCODE
091500110412     C                   Write     PWGRIDR
091600110412
091700110412      * 02
091800130524     C                   Eval      GRGRPID = 102115
091900110412     C                   Eval      GRALUS = %trim(PWALUS)
092000110412     C                   Eval      GRACTCD = 'D'
092100110412     C                   Eval      GRDTDT = TODAY
092200110412     C                   Eval      GRCODE = AOCODE
092300110412     C                   Write     PWGRIDR
092400110412
092500110412     C                   Endsr
092600110412      *---------------------------------------------------------------*
092700110412     C     Code05T       Begsr
092800110412     C     PKEY          Chain     PWINFOLF
092900110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
093000110412     C                   Eval      PWALUS = %trim(OUUSER)
093100110412     C                   Eval      PWROLE = 'act_'
093200110412     C                   Eval      PWDESC = %trim(ACNAM1)
093300120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
093400110412     C                   Eval      PWCODE = AOCODE
093500110412     C                   Eval      PWUBDT = OUBEDT
093600110412     C                   Eval      PWAACD = %trim(AACODE)
093700110412     C                   Eval      PWULNM = %trim(OULNAM)
093800110412     C                   Eval      PWUFNM = %trim(OUFNAM)
093900130607     C                   Eval      PWOLPW = *BLANKS
094000110412     C                   Eval      PWDTDT = TODAY
094100110412     C                   If        %found(PWINFOLF)
094200110412     C                   Update    PWINFOR
094300110412     C                   Else
094400110412     C                   Write     PWINFOR
094500110412     C                   End
094600110412     C                   eval      TranFlag = 'Y'
094700110412
094800110412      * 01
094900110412     C                   Eval      GRALUS = %trim(PWALUS)
095000110412     C                   Eval      GRGRPID = 100002
095100110412     C                   Eval      GRACTCD = 'D'
095200110412     C                   Eval      GRDTDT = TODAY
095300110412     C                   Eval      GRCODE = AOCODE
095400110412     C                   Write     PWGRIDR
095500110412
095600110412      * 02
095700130524     C                   Eval      GRGRPID = 102115
095800110412     C                   Eval      GRALUS = %trim(PWALUS)
095900110412     C                   Eval      GRACTCD = 'D'
096000110412     C                   Eval      GRDTDT = TODAY
096100110412     C                   Eval      GRCODE = AOCODE
096200110412     C                   Write     PWGRIDR
096300110412
096400110412      * 03
096500110412     C                   Eval      GRALUS = %trim(PWALUS)
096600130110     C                   Eval      GRGRPID = 100140
096700110412     C                   Eval      GRACTCD = 'D'
096800110412     C                   Eval      GRDTDT = TODAY
096900110412     C                   Eval      GRCODE = AOCODE
097000110412     C                   Write     PWGRIDR
097100110412
097200110412     C                   Endsr
097300111017      *---------------------------------------------------------------*
097400111017     C     Code06T       Begsr
097500111017     C     PKEY          Chain     PWINFOLF
097600111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
097700111017     C                   Eval      PWALUS = %trim(OUUSER)
097800111017     C                   Eval      PWROLE = 'act_'
097900111017     C                   Eval      PWDESC = %trim(ACNAM1)
098000120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
098100111017     C                   Eval      PWCODE = AOCODE
098200111017     C                   Eval      PWUBDT = OUBEDT
098300111017     C                   Eval      PWAACD = %trim(AACODE)
098400111017     C                   Eval      PWULNM = %trim(OULNAM)
098500111017     C                   Eval      PWUFNM = %trim(OUFNAM)
098600130607     C                   Eval      PWOLPW = *BLANKS
098700111017     C                   Eval      PWDTDT = TODAY
098800111017     C                   If        %found(PWINFOLF)
098900111017     C                   Update    PWINFOR
099000111017     C                   Else
099100111017     C                   Write     PWINFOR
099200111017     C                   End
099300111017     C                   eval      TranFlag = 'Y'
099400111017
099500111017      * 01
099600111017     C                   Eval      GRALUS = %trim(PWALUS)
099700111017     C                   Eval      GRGRPID = 100002
099800111017     C                   Eval      GRACTCD = 'D'
099900111017     C                   Eval      GRDTDT = TODAY
100000111017     C                   Eval      GRCODE = AOCODE
100100111017     C                   Write     PWGRIDR
100200111017
100300111017      * 02
100400111017     C                   Eval      GRALUS = %trim(PWALUS)
100500111017     C                   Eval      GRGRPID = 102115
100600111017     C                   Eval      GRACTCD = 'D'
100700111017     C                   Eval      GRDTDT = TODAY
100800111017     C                   Eval      GRCODE = AOCODE
100900111017     C                   Write     PWGRIDR
101000111017
101100111017     C                   Endsr
101200111017      *---------------------------------------------------------------*
101300111017     C     Code07T       Begsr
101400111017     C     PKEY          Chain     PWINFOLF
101500111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
101600111017     C                   Eval      PWALUS = %trim(OUUSER)
101700111017     C                   Eval      PWROLE = 'act_'
101800111017     C                   Eval      PWDESC = %trim(ACNAM1)
101900120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
102000111017     C                   Eval      PWCODE = AOCODE
102100111017     C                   Eval      PWUBDT = OUBEDT
102200111017     C                   Eval      PWAACD = %trim(AACODE)
102300111017     C                   Eval      PWULNM = %trim(OULNAM)
102400111017     C                   Eval      PWUFNM = %trim(OUFNAM)
102500130607     C                   Eval      PWOLPW = *BLANKS
102600111017     C                   Eval      PWDTDT = TODAY
102700111017     C                   If        %found(PWINFOLF)
102800111017     C                   Update    PWINFOR
102900111017     C                   Else
103000111017     C                   Write     PWINFOR
103100111017     C                   End
103200111017     C                   eval      TranFlag = 'Y'
103300111017
103400111017      * 01
103500111017     C                   Eval      GRALUS = %trim(PWALUS)
103600111017     C                   Eval      GRGRPID = 100002
103700111017     C                   Eval      GRACTCD = 'D'
103800111017     C                   Eval      GRDTDT = TODAY
103900111017     C                   Eval      GRCODE = AOCODE
104000111017     C                   Write     PWGRIDR
104100111017
104200111017      * 02
104300111017     C                   Eval      GRALUS = %trim(PWALUS)
104400111017     C                   Eval      GRGRPID = 102115
104500111017     C                   Eval      GRACTCD = 'D'
104600111017     C                   Eval      GRDTDT = TODAY
104700111017     C                   Eval      GRCODE = AOCODE
104800111017     C                   Write     PWGRIDR
104900111017
105000111017      * 03
105100111017     C                   Eval      GRALUS = %trim(PWALUS)
105200130110     C                   Eval      GRGRPID = 100140
105300111017     C                   Eval      GRACTCD = 'D'
105400111017     C                   Eval      GRDTDT = TODAY
105500111017     C                   Eval      GRCODE = AOCODE
105600111017     C                   Write     PWGRIDR
105700111017
105800111017     C                   Endsr
105900150422      *---------------------------------------------------------------*
106000150422     C     Code08T       Begsr
106100150422     C     PKEY          Chain     PWINFOLF
106200150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
106300150422     C                   Eval      PWALUS = %trim(OUUSER)
106400150422     C                   Eval      PWROLE = 'act_'
106500150422     C                   Eval      PWDESC = %trim(ACNAM1)
106600150422     C                   Eval      PWEMAIL = %trim(WWEMAL)
106700150422     C                   Eval      PWCODE = AOCODE
106800150422     C                   Eval      PWUBDT = OUBEDT
106900150422     C                   Eval      PWAACD = %trim(AACODE)
107000150422     C                   Eval      PWULNM = %trim(OULNAM)
107100150422     C                   Eval      PWUFNM = %trim(OUFNAM)
107200150422     C                   Eval      PWOLPW = *BLANKS
107300150422     C                   Eval      PWDTDT = TODAY
107400150422     C                   If        %found(PWINFOLF)
107500150422     C                   Update    PWINFOR
107600150422     C                   Else
107700150422     C                   Write     PWINFOR
107800150422     C                   End
107900150422     C                   eval      TranFlag = 'Y'
108000150422
108100150422      * 01
108200150422     C                   Eval      GRALUS = %trim(PWALUS)
108300150715     C                   Eval      GRGRPID = 100003
108400150422     C                   Eval      GRACTCD = 'D'
108500150422     C                   Eval      GRDTDT = TODAY
108600150422     C                   Eval      GRCODE = AOCODE
108700150422     C                   Write     PWGRIDR
108800150422
108900150422      * 02
109000150422     C                   Eval      GRGRPID = 100115
109100150422     C                   Eval      GRALUS = %trim(PWALUS)
109200150422     C                   Eval      GRACTCD = 'D'
109300150422     C                   Eval      GRDTDT = TODAY
109400150422     C                   Eval      GRCODE = AOCODE
109500150422     C                   Write     PWGRIDR
109600150422
109700150422     C                   Endsr
109800150422      *---------------------------------------------------------------*
109900150422     C     Code09T       Begsr
110000150422     C     PKEY          Chain     PWINFOLF
110100150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
110200150422     C                   Eval      PWALUS = %trim(OUUSER)
110300150422     C                   Eval      PWROLE = 'act_'
110400150422     C                   Eval      PWDESC = %trim(ACNAM1)
110500150422     C                   Eval      PWEMAIL = %trim(WWEMAL)
110600150422     C                   Eval      PWCODE = AOCODE
110700150422     C                   Eval      PWUBDT = OUBEDT
110800150422     C                   Eval      PWAACD = %trim(AACODE)
110900150422     C                   Eval      PWULNM = %trim(OULNAM)
111000150422     C                   Eval      PWUFNM = %trim(OUFNAM)
111100150422     C                   Eval      PWOLPW = *BLANKS
111200150422     C                   Eval      PWDTDT = TODAY
111300150422     C                   If        %found(PWINFOLF)
111400150422     C                   Update    PWINFOR
111500150422     C                   Else
111600150422     C                   Write     PWINFOR
111700150422     C                   End
111800150422     C                   eval      TranFlag = 'Y'
111900150422
112000150422      * 01
112100150422     C                   Eval      GRALUS = %trim(PWALUS)
112200150715     C                   Eval      GRGRPID = 100003
112300150422     C                   Eval      GRACTCD = 'D'
112400150422     C                   Eval      GRDTDT = TODAY
112500150422     C                   Eval      GRCODE = AOCODE
112600150422     C                   Write     PWGRIDR
112700150422
112800150422      * 02
112900150422     C                   Eval      GRGRPID = 100115
113000150422     C                   Eval      GRALUS = %trim(PWALUS)
113100150422     C                   Eval      GRACTCD = 'D'
113200150422     C                   Eval      GRDTDT = TODAY
113300150422     C                   Eval      GRCODE = AOCODE
113400150422     C                   Write     PWGRIDR
113500150422
113600150422      * 03
113700150422     C                   Eval      GRALUS = %trim(PWALUS)
113800150422     C                   Eval      GRGRPID = 100140
113900150422     C                   Eval      GRACTCD = 'D'
114000150422     C                   Eval      GRDTDT = TODAY
114100150422     C                   Eval      GRCODE = AOCODE
114200150422     C                   Write     PWGRIDR
114300150422
114400150422     C                   Endsr
114500100512      *---------------------------------------------------------------*
114600100512     C     Code01U       Begsr
114700100512     C     PKEY          Chain     PWINFOLF
114800100512     C                   Eval      PWIDEN = Trst + Sub# + Acct
114900100512     C                   Eval      PWALUS = %trim(OUUSER)
115000100512     C                   Eval      PWROLE = 'act_'
115100100512     C                   Eval      PWDESC = %trim(ACNAM1)
115200100512     C                   Eval      PWEMAIL = 'TERM_USER'
115300100512     C                   Eval      PWCODE = AOCODE
115400100512     C                   Eval      PWUBDT = OUBEDT
115500100512     C                   Eval      PWAACD = %trim(AACODE)
115600100512     C                   Eval      PWULNM = %trim(OULNAM)
115700100512     C                   Eval      PWUFNM = %trim(OUFNAM)
115800130607     C                   Eval      PWOLPW = *BLANKS
115900100512     C                   Eval      PWDTDT = TODAY
116000100512     C                   If        %found(PWINFOLF)
116100100512     C                   Update    PWINFOR
116200100512     C                   Else
116300100512     C                   Write     PWINFOR
116400100512     C                   End
116500100512     C                   eval      TranFlag = 'Y'
116600100512
116700100512      * 01
116800100512     C                   Eval      GRALUS = %trim(PWALUS)
116900100512     C                   Eval      GRGRPID = 100002
117000100512     C                   Eval      GRACTCD = 'D'
117100100512     C                   Eval      GRDTDT = TODAY
117200100512     C                   Eval      GRCODE = AOCODE
117300100512     C                   Write     PWGRIDR
117400100512
117500100512     C                   Endsr
117600100512      *---------------------------------------------------------------*
117700100512     C     Code02U       Begsr
117800100512     C     PKEY          Chain     PWINFOLF
117900100512     C                   Eval      PWIDEN = Trst + Sub# + Acct
118000100512     C                   Eval      PWALUS = %trim(OUUSER)
118100100512     C                   Eval      PWROLE = 'act_'
118200100512     C                   Eval      PWDESC = %trim(ACNAM1)
118300100512     C                   Eval      PWEMAIL = 'TERM_USER'
118400100512     C                   Eval      PWCODE = AOCODE
118500100512     C                   Eval      PWUBDT = OUBEDT
118600100512     C                   Eval      PWAACD = %trim(AACODE)
118700100512     C                   Eval      PWULNM = %trim(OULNAM)
118800100512     C                   Eval      PWUFNM = %trim(OUFNAM)
118900130607     C                   Eval      PWOLPW = *BLANKS
119000100512     C                   Eval      PWDTDT = TODAY
119100100512     C                   If        %found(PWINFOLF)
119200100512     C                   Update    PWINFOR
119300100512     C                   Else
119400100512     C                   Write     PWINFOR
119500100512     C                   End
119600100512     C                   eval      TranFlag = 'Y'
119700100512
119800100512      * 01
119900100512     C                   Eval      GRALUS = %trim(PWALUS)
120000100512     C                   Eval      GRGRPID = 100002
120100100512     C                   Eval      GRACTCD = 'D'
120200100512     C                   Eval      GRDTDT = TODAY
120300100512     C                   Eval      GRCODE = AOCODE
120400100512     C                   Write     PWGRIDR
120500100512
120600100512      * 02
120700100512     C                   Eval      GRALUS = %trim(PWALUS)
120800100512     C                   Eval      GRGRPID = 100115
120900100512     C                   Eval      GRACTCD = 'D'
121000100512     C                   Eval      GRDTDT = TODAY
121100100512     C                   Eval      GRCODE = AOCODE
121200100512     C                   Write     PWGRIDR
121300100512
121400100512     C                   Endsr
121500100512      *---------------------------------------------------------------*
121600100512     C     Code03U       Begsr
121700100512     C     PKEY          Chain     PWINFOLF
121800100512     C                   Eval      PWIDEN = Trst + Sub# + Acct
121900100512     C                   Eval      PWALUS = %trim(OUUSER)
122000100512     C                   Eval      PWROLE = 'act_'
122100100512     C                   Eval      PWDESC = %trim(ACNAM1)
122200100512     C                   Eval      PWEMAIL = 'TERM_USER'
122300100512     C                   Eval      PWCODE = AOCODE
122400100512     C                   Eval      PWUBDT = OUBEDT
122500100512     C                   Eval      PWAACD = %trim(AACODE)
122600100512     C                   Eval      PWULNM = %trim(OULNAM)
122700100512     C                   Eval      PWUFNM = %trim(OUFNAM)
122800130607     C                   Eval      PWOLPW = *BLANKS
122900100512     C                   Eval      PWDTDT = TODAY
123000100512     C                   If        %found(PWINFOLF)
123100100512     C                   Update    PWINFOR
123200100512     C                   Else
123300100512     C                   Write     PWINFOR
123400100512     C                   End
123500100512     C                   eval      TranFlag = 'Y'
123600100512
123700100512      * 01
123800100512     C                   Eval      GRALUS = %trim(PWALUS)
123900100512     C                   Eval      GRGRPID = 100002
124000100512     C                   Eval      GRACTCD = 'D'
124100100512     C                   Eval      GRDTDT = TODAY
124200100512     C                   Eval      GRCODE = AOCODE
124300100512     C                   Write     PWGRIDR
124400100512
124500100512      * 02
124600100512     C                   Eval      GRALUS = %trim(PWALUS)
124700100512     C                   Eval      GRGRPID = 100115
124800100512     C                   Eval      GRACTCD = 'D'
124900100512     C                   Eval      GRDTDT = TODAY
125000100512     C                   Eval      GRCODE = AOCODE
125100100512     C                   Write     PWGRIDR
125200100512
125300100512      * 03
125400100512     C                   Eval      GRALUS = %trim(PWALUS)
125500100512     C                   Eval      GRGRPID = 100130
125600100512     C                   Eval      GRACTCD = 'D'
125700100512     C                   Eval      GRDTDT = TODAY
125800100512     C                   Eval      GRCODE = AOCODE
125900100512     C                   Write     PWGRIDR
126000130110
126100130110      * 03
126200130110     C                   Eval      GRALUS = %trim(PWALUS)
126300130110     C                   Eval      GRGRPID = 100140
126400130110     C                   Eval      GRACTCD = 'D'
126500130110     C                   Eval      GRDTDT = TODAY
126600130110     C                   Eval      GRCODE = AOCODE
126700130110     C                   Write     PWGRIDR
126800100512
126900100512     C                   Endsr
127000110412      *---------------------------------------------------------------*
127100110412     C     Code04U       Begsr
127200110412     C     PKEY          Chain     PWINFOLF
127300110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
127400110412     C                   Eval      PWALUS = %trim(OUUSER)
127500110412     C                   Eval      PWROLE = 'act_'
127600110412     C                   Eval      PWDESC = %trim(ACNAM1)
127700110412     C                   Eval      PWEMAIL = 'TERM_USER'
127800110412     C                   Eval      PWCODE = AOCODE
127900110412     C                   Eval      PWUBDT = OUBEDT
128000110412     C                   Eval      PWAACD = %trim(AACODE)
128100110412     C                   Eval      PWULNM = %trim(OULNAM)
128200110412     C                   Eval      PWUFNM = %trim(OUFNAM)
128300130607     C                   Eval      PWOLPW = *BLANKS
128400110412     C                   Eval      PWDTDT = TODAY
128500110412     C                   If        %found(PWINFOLF)
128600110412     C                   Update    PWINFOR
128700110412     C                   Else
128800110412     C                   Write     PWINFOR
128900110412     C                   End
129000110412     C                   eval      TranFlag = 'Y'
129100110412
129200110412      * 01
129300110412     C                   Eval      GRALUS = %trim(PWALUS)
129400110412     C                   Eval      GRGRPID = 100002
129500110412     C                   Eval      GRACTCD = 'D'
129600110412     C                   Eval      GRDTDT = TODAY
129700110412     C                   Eval      GRCODE = AOCODE
129800110412     C                   Write     PWGRIDR
129900110412
130000110412      * 02
130100130524     C                   Eval      GRGRPID = 102115
130200110412     C                   Eval      GRALUS = %trim(PWALUS)
130300110412     C                   Eval      GRACTCD = 'D'
130400110412     C                   Eval      GRDTDT = TODAY
130500110412     C                   Eval      GRCODE = AOCODE
130600110412     C                   Write     PWGRIDR
130700110412
130800110412     C                   Endsr
130900110412      *---------------------------------------------------------------*
131000110412     C     Code05U       Begsr
131100110412     C     PKEY          Chain     PWINFOLF
131200110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
131300110412     C                   Eval      PWALUS = %trim(OUUSER)
131400110412     C                   Eval      PWROLE = 'act_'
131500110412     C                   Eval      PWDESC = %trim(ACNAM1)
131600110412     C                   Eval      PWEMAIL = 'TERM_USER'
131700110412     C                   Eval      PWCODE = AOCODE
131800110412     C                   Eval      PWUBDT = OUBEDT
131900110412     C                   Eval      PWAACD = %trim(AACODE)
132000110412     C                   Eval      PWULNM = %trim(OULNAM)
132100110412     C                   Eval      PWUFNM = %trim(OUFNAM)
132200130607     C                   Eval      PWOLPW = *BLANKS
132300110412     C                   Eval      PWDTDT = TODAY
132400110412     C                   If        %found(PWINFOLF)
132500110412     C                   Update    PWINFOR
132600110412     C                   Else
132700110412     C                   Write     PWINFOR
132800110412     C                   End
132900110412     C                   eval      TranFlag = 'Y'
133000110412
133100110412      * 01
133200110412     C                   Eval      GRALUS = %trim(PWALUS)
133300110412     C                   Eval      GRGRPID = 100002
133400110412     C                   Eval      GRACTCD = 'D'
133500110412     C                   Eval      GRDTDT = TODAY
133600110412     C                   Eval      GRCODE = AOCODE
133700110412     C                   Write     PWGRIDR
133800110412
133900110412      * 02
134000130524     C                   Eval      GRGRPID = 102115
134100110412     C                   Eval      GRALUS = %trim(PWALUS)
134200110412     C                   Eval      GRACTCD = 'D'
134300110412     C                   Eval      GRDTDT = TODAY
134400110412     C                   Eval      GRCODE = AOCODE
134500110412     C                   Write     PWGRIDR
134600110412
134700110412      * 03
134800110412     C                   Eval      GRALUS = %trim(PWALUS)
134900130110     C                   Eval      GRGRPID = 100140
135000110412     C                   Eval      GRACTCD = 'D'
135100110412     C                   Eval      GRDTDT = TODAY
135200110412     C                   Eval      GRCODE = AOCODE
135300110412     C                   Write     PWGRIDR
135400110412
135500110412     C                   Endsr
135600111017      *---------------------------------------------------------------*
135700111017     C     Code06U       Begsr
135800111017     C     PKEY          Chain     PWINFOLF
135900111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
136000111017     C                   Eval      PWALUS = %trim(OUUSER)
136100111017     C                   Eval      PWROLE = 'act_'
136200111017     C                   Eval      PWDESC = %trim(ACNAM1)
136300111017     C                   Eval      PWEMAIL = 'TERM_USER'
136400111017     C                   Eval      PWCODE = AOCODE
136500111017     C                   Eval      PWUBDT = OUBEDT
136600111017     C                   Eval      PWAACD = %trim(AACODE)
136700111017     C                   Eval      PWULNM = %trim(OULNAM)
136800111017     C                   Eval      PWUFNM = %trim(OUFNAM)
136900130607     C                   Eval      PWOLPW = *BLANKS
137000111017     C                   Eval      PWDTDT = TODAY
137100111017     C                   If        %found(PWINFOLF)
137200111017     C                   Update    PWINFOR
137300111017     C                   Else
137400111017     C                   Write     PWINFOR
137500111017     C                   End
137600111017     C                   eval      TranFlag = 'Y'
137700111017
137800111017      * 01
137900111017     C                   Eval      GRALUS = %trim(PWALUS)
138000111017     C                   Eval      GRGRPID = 100002
138100111017     C                   Eval      GRACTCD = 'D'
138200111017     C                   Eval      GRDTDT = TODAY
138300111017     C                   Eval      GRCODE = AOCODE
138400111017     C                   Write     PWGRIDR
138500111017
138600111017      * 02
138700111017     C                   Eval      GRALUS = %trim(PWALUS)
138800111017     C                   Eval      GRGRPID = 102115
138900111017     C                   Eval      GRACTCD = 'D'
139000111017     C                   Eval      GRDTDT = TODAY
139100111017     C                   Eval      GRCODE = AOCODE
139200111017     C                   Write     PWGRIDR
139300111017
139400111017     C                   Endsr
139500111017      *---------------------------------------------------------------*
139600111017     C     Code07U       Begsr
139700111017     C     PKEY          Chain     PWINFOLF
139800111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
139900111017     C                   Eval      PWALUS = %trim(OUUSER)
140000111017     C                   Eval      PWROLE = 'act_'
140100111017     C                   Eval      PWDESC = %trim(ACNAM1)
140200111017     C                   Eval      PWEMAIL = 'TERM_USER'
140300111017     C                   Eval      PWCODE = AOCODE
140400111017     C                   Eval      PWUBDT = OUBEDT
140500111017     C                   Eval      PWAACD = %trim(AACODE)
140600111017     C                   Eval      PWULNM = %trim(OULNAM)
140700111017     C                   Eval      PWUFNM = %trim(OUFNAM)
140800130607     C                   Eval      PWOLPW = *BLANKS
140900111017     C                   Eval      PWDTDT = TODAY
141000111017     C                   If        %found(PWINFOLF)
141100111017     C                   Update    PWINFOR
141200111017     C                   Else
141300111017     C                   Write     PWINFOR
141400111017     C                   End
141500111017     C                   eval      TranFlag = 'Y'
141600111017
141700111017      * 01
141800111017     C                   Eval      GRALUS = %trim(PWALUS)
141900111017     C                   Eval      GRGRPID = 100002
142000111017     C                   Eval      GRACTCD = 'D'
142100111017     C                   Eval      GRDTDT = TODAY
142200111017     C                   Eval      GRCODE = AOCODE
142300111017     C                   Write     PWGRIDR
142400111017
142500111017      * 02
142600111017     C                   Eval      GRALUS = %trim(PWALUS)
142700111017     C                   Eval      GRGRPID = 102115
142800111017     C                   Eval      GRACTCD = 'D'
142900111017     C                   Eval      GRDTDT = TODAY
143000111017     C                   Eval      GRCODE = AOCODE
143100111017     C                   Write     PWGRIDR
143200111017
143300111017      * 03
143400111017     C                   Eval      GRALUS = %trim(PWALUS)
143500130110     C                   Eval      GRGRPID = 100140
143600111017     C                   Eval      GRACTCD = 'D'
143700111017     C                   Eval      GRDTDT = TODAY
143800111017     C                   Eval      GRCODE = AOCODE
143900111017     C                   Write     PWGRIDR
144000111017
144100111017     C                   Endsr
144200150422      *---------------------------------------------------------------*
144300150422     C     Code08U       Begsr
144400150422     C     PKEY          Chain     PWINFOLF
144500150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
144600150422     C                   Eval      PWALUS = %trim(OUUSER)
144700150422     C                   Eval      PWROLE = 'act_'
144800150422     C                   Eval      PWDESC = %trim(ACNAM1)
144900150422     C                   Eval      PWEMAIL = 'TERM_USER'
145000150422     C                   Eval      PWCODE = AOCODE
145100150422     C                   Eval      PWUBDT = OUBEDT
145200150422     C                   Eval      PWAACD = %trim(AACODE)
145300150422     C                   Eval      PWULNM = %trim(OULNAM)
145400150422     C                   Eval      PWUFNM = %trim(OUFNAM)
145500150422     C                   Eval      PWOLPW = *BLANKS
145600150422     C                   Eval      PWDTDT = TODAY
145700150422     C                   If        %found(PWINFOLF)
145800150422     C                   Update    PWINFOR
145900150422     C                   Else
146000150422     C                   Write     PWINFOR
146100150422     C                   End
146200150422     C                   eval      TranFlag = 'Y'
146300150422
146400150422      * 01
146500150422     C                   Eval      GRALUS = %trim(PWALUS)
146600150715     C                   Eval      GRGRPID = 100003
146700150422     C                   Eval      GRACTCD = 'D'
146800150422     C                   Eval      GRDTDT = TODAY
146900150422     C                   Eval      GRCODE = AOCODE
147000150422     C                   Write     PWGRIDR
147100150422
147200150422      * 02
147300150422     C                   Eval      GRGRPID = 100115
147400150422     C                   Eval      GRALUS = %trim(PWALUS)
147500150422     C                   Eval      GRACTCD = 'D'
147600150422     C                   Eval      GRDTDT = TODAY
147700150422     C                   Eval      GRCODE = AOCODE
147800150422     C                   Write     PWGRIDR
147900150422
148000150422     C                   Endsr
148100150422      *---------------------------------------------------------------*
148200150422     C     Code09U       Begsr
148300150422     C     PKEY          Chain     PWINFOLF
148400150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
148500150422     C                   Eval      PWALUS = %trim(OUUSER)
148600150422     C                   Eval      PWROLE = 'act_'
148700150422     C                   Eval      PWDESC = %trim(ACNAM1)
148800150422     C                   Eval      PWEMAIL = 'TERM_USER'
148900150422     C                   Eval      PWCODE = AOCODE
149000150422     C                   Eval      PWUBDT = OUBEDT
149100150422     C                   Eval      PWAACD = %trim(AACODE)
149200150422     C                   Eval      PWULNM = %trim(OULNAM)
149300150422     C                   Eval      PWUFNM = %trim(OUFNAM)
149400150422     C                   Eval      PWOLPW = *BLANKS
149500150422     C                   Eval      PWDTDT = TODAY
149600150422     C                   If        %found(PWINFOLF)
149700150422     C                   Update    PWINFOR
149800150422     C                   Else
149900150422     C                   Write     PWINFOR
150000150422     C                   End
150100150422     C                   eval      TranFlag = 'Y'
150200150422
150300150422      * 01
150400150422     C                   Eval      GRALUS = %trim(PWALUS)
150500150715     C                   Eval      GRGRPID = 100003
150600150422     C                   Eval      GRACTCD = 'D'
150700150422     C                   Eval      GRDTDT = TODAY
150800150422     C                   Eval      GRCODE = AOCODE
150900150422     C                   Write     PWGRIDR
151000150422
151100150422      * 02
151200150422     C                   Eval      GRGRPID = 100115
151300150422     C                   Eval      GRALUS = %trim(PWALUS)
151400150422     C                   Eval      GRACTCD = 'D'
151500150422     C                   Eval      GRDTDT = TODAY
151600150422     C                   Eval      GRCODE = AOCODE
151700150422     C                   Write     PWGRIDR
151800150422
151900150422      * 03
152000150422     C                   Eval      GRALUS = %trim(PWALUS)
152100150422     C                   Eval      GRGRPID = 100140
152200150422     C                   Eval      GRACTCD = 'D'
152300150422     C                   Eval      GRDTDT = TODAY
152400150422     C                   Eval      GRCODE = AOCODE
152500150422     C                   Write     PWGRIDR
152600150422
152700150422     C                   Endsr
152800070718      *---------------------------------------------------------------*
152900070718     C     OE03          Begsr
153000070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
153100070718     C                   Eval      PWALUS = %trim(OETSA)
153200080331
153300080331     C                   Eval      PKID   = %trim(PWIDEN)
153400080331     C                   Eval      PKAL   = %trim(PWALUS)
153500080331
153600070718     C                   Eval      PWROLE = 'aoe_'
153700070718     C                   Eval      PWDESC = %trim(ACNAM1)
153800070718     C                   Eval      PWEMAIL = *blanks
153900070718     C                   Eval      PWCODE = AOCODE
154000070718     C                   Eval      PWUBDT = Today
154100070718     C                   Eval      PWAACD = %trim(AACODE)
154200070720     C                   Eval      PWULNM = %trim(ACNAM1)
154300070720     C                   Eval      PWUFNM = 'GENERIC OE'
154400070720     C                   Exsr      GenPW
154500070720     C                   Eval      PWDTDT = TODAY
154600070723     C                   Write     PWINFOR
154700070720     C                   eval      TranFlag = 'Y'
154800070718
154900070718      * 03
155000070718     C                   Eval      GRALUS = %trim(PWALUS)
155100070718     C                   Eval      GRGRPID = 100126
155200070718     C                   Eval      GRACTCD = 'A'
155300070720     C                   Eval      GRDTDT = TODAY
155400070723     C                   Eval      GRCODE = AOCODE
155500070718     C                   Write     PWGRIDR
155600070718
155700070718     C                   Endsr
155800110412      *---------------------------------------------------------------*
155900110412     C     OE05          Begsr
156000110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
156100110412     C                   Eval      PWALUS = %trim(OETSA)
156200110412
156300110412     C                   Eval      PKID   = %trim(PWIDEN)
156400110412     C                   Eval      PKAL   = %trim(PWALUS)
156500110412
156600110412     C                   Eval      PWROLE = 'aoe_'
156700110412     C                   Eval      PWDESC = %trim(ACNAM1)
156800110412     C                   Eval      PWEMAIL = *blanks
156900110412     C                   Eval      PWCODE = AOCODE
157000110412     C                   Eval      PWUBDT = Today
157100110412     C                   Eval      PWAACD = %trim(AACODE)
157200110412     C                   Eval      PWULNM = %trim(ACNAM1)
157300110412     C                   Eval      PWUFNM = 'GENERIC OE'
157400110412     C                   Exsr      GenPW
157500110412     C                   Eval      PWDTDT = TODAY
157600110412     C                   Write     PWINFOR
157700110412     C                   eval      TranFlag = 'Y'
157800110412
157900110412      * 03
158000110412     C                   Eval      GRALUS = %trim(PWALUS)
158100110412     C                   Eval      GRGRPID = 100126
158200110412     C                   Eval      GRACTCD = 'A'
158300110412     C                   Eval      GRDTDT = TODAY
158400110412     C                   Eval      GRCODE = AOCODE
158500110412     C                   Write     PWGRIDR
158600110412
158700110412     C                   Endsr
158800120828      *---------------------------------------------------------------*
158900120828     C     OE07          Begsr
159000120828     C                   Eval      PWIDEN = Trst + Sub# + Acct
159100120828     C                   Eval      PWALUS = %trim(OETSA)
159200120828
159300120828     C                   Eval      PKID   = %trim(PWIDEN)
159400120828     C                   Eval      PKAL   = %trim(PWALUS)
159500120828
159600120828     C                   Eval      PWROLE = 'aoe_'
159700120828     C                   Eval      PWDESC = %trim(ACNAM1)
159800120828     C                   Eval      PWEMAIL = *blanks
159900120828     C                   Eval      PWCODE = AOCODE
160000120828     C                   Eval      PWUBDT = Today
160100120828     C                   Eval      PWAACD = %trim(AACODE)
160200120828     C                   Eval      PWULNM = %trim(ACNAM1)
160300120828     C                   Eval      PWUFNM = 'GENERIC OE'
160400120828     C                   Exsr      GenPW
160500120828     C                   Eval      PWDTDT = TODAY
160600120828     C                   Write     PWINFOR
160700120828     C                   eval      TranFlag = 'Y'
160800120828
160900120828      * 07
161000120828     C                   Eval      GRALUS = %trim(PWALUS)
161100120828     C                   Eval      GRGRPID = 100126
161200120828     C                   Eval      GRACTCD = 'A'
161300120828     C                   Eval      GRDTDT = TODAY
161400120828     C                   Eval      GRCODE = AOCODE
161500120828     C                   Write     PWGRIDR
161600120828
161700120828     C                   Endsr
161800070718      *---------------------------------------------------------------*
161900070718     C     OE03T         Begsr
162000070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
162100070718     C                   Eval      PWALUS = %trim(OETSA)
162200080331
162300080331     C                   Eval      PKID   = %trim(PWIDEN)
162400080331     C                   Eval      PKAL   = %trim(PWALUS)
162500080331
162600070718     C                   Eval      PWROLE = 'aoe_'
162700070718     C                   Eval      PWDESC = %trim(ACNAM1)
162800070718     C                   Eval      PWEMAIL = *blanks
162900070718     C                   Eval      PWCODE = AOCODE
163000070718     C                   Eval      PWUBDT = Today
163100070718     C                   Eval      PWAACD = %trim(AACODE)
163200070720     C                   Eval      PWULNM = %trim(ACNAM1)
163300070720     C                   Eval      PWUFNM = 'GENERIC OE'
163400130607     C                   Eval      PWOLPW = *blanks
163500070720     C                   Eval      PWDTDT = TODAY
163600070723     C                   Write     PWINFOR
163700070720     C                   eval      TranFlag = 'Y'
163800070718
163900070718      * 03
164000070718     C                   Eval      GRALUS = %trim(PWALUS)
164100070718     C                   Eval      GRGRPID = 100126
164200070718     C                   Eval      GRACTCD = 'D'
164300070720     C                   Eval      GRDTDT = TODAY
164400070723     C                   Eval      GRCODE = AOCODE
164500070718     C                   Write     PWGRIDR
164600070718
164700070718     C                   Endsr
164800110412      *---------------------------------------------------------------*
164900110412     C     OE05T         Begsr
165000110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
165100110412     C                   Eval      PWALUS = %trim(OETSA)
165200110412
165300110412     C                   Eval      PKID   = %trim(PWIDEN)
165400110412     C                   Eval      PKAL   = %trim(PWALUS)
165500110412
165600110412     C                   Eval      PWROLE = 'aoe_'
165700110412     C                   Eval      PWDESC = %trim(ACNAM1)
165800110412     C                   Eval      PWEMAIL = *blanks
165900110412     C                   Eval      PWCODE = AOCODE
166000110412     C                   Eval      PWUBDT = Today
166100110412     C                   Eval      PWAACD = %trim(AACODE)
166200110412     C                   Eval      PWULNM = %trim(ACNAM1)
166300110412     C                   Eval      PWUFNM = 'GENERIC OE'
166400130607     C                   Eval      PWOLPW = *blanks
166500110412     C                   Eval      PWDTDT = TODAY
166600110412     C                   Write     PWINFOR
166700110412     C                   eval      TranFlag = 'Y'
166800110412
166900110412      * 03
167000110412     C                   Eval      GRALUS = %trim(PWALUS)
167100110412     C                   Eval      GRGRPID = 100126
167200110412     C                   Eval      GRACTCD = 'D'
167300110412     C                   Eval      GRDTDT = TODAY
167400110412     C                   Eval      GRCODE = AOCODE
167500110412     C                   Write     PWGRIDR
167600110412
167700110412     C                   Endsr
167800120828      *---------------------------------------------------------------*
167900120828     C     OE07T         Begsr
168000120828     C                   Eval      PWIDEN = Trst + Sub# + Acct
168100120828     C                   Eval      PWALUS = %trim(OETSA)
168200120828
168300120828     C                   Eval      PKID   = %trim(PWIDEN)
168400120828     C                   Eval      PKAL   = %trim(PWALUS)
168500120828
168600120828     C                   Eval      PWROLE = 'aoe_'
168700120828     C                   Eval      PWDESC = %trim(ACNAM1)
168800120828     C                   Eval      PWEMAIL = *blanks
168900120828     C                   Eval      PWCODE = AOCODE
169000120828     C                   Eval      PWUBDT = Today
169100120828     C                   Eval      PWAACD = %trim(AACODE)
169200120828     C                   Eval      PWULNM = %trim(ACNAM1)
169300120828     C                   Eval      PWUFNM = 'GENERIC OE'
169400130607     C                   Eval      PWOLPW = *blanks
169500120828     C                   Eval      PWDTDT = TODAY
169600120828     C                   Write     PWINFOR
169700120828     C                   eval      TranFlag = 'Y'
169800120828
169900120828      * 07
170000120828     C                   Eval      GRALUS = %trim(PWALUS)
170100120828     C                   Eval      GRGRPID = 100126
170200120828     C                   Eval      GRACTCD = 'D'
170300120828     C                   Eval      GRDTDT = TODAY
170400120828     C                   Eval      GRCODE = AOCODE
170500120828     C                   Write     PWGRIDR
170600120828
170700120828     C                   Endsr
170800070718      *---------------------------------------------------------------*
170900070718     C     PWreset       Begsr
171000070718
171100070718     C                   Clear                   PWINFOR
171200070718     C                   Clear                   PWGRIDR
171300070718
171400070718     C                   Movel     AOTRST        Trst
171500070718     C                   Movel     AOSUB#        Sub#
171600070718     C                   Movel     AOACCT        Acct
171700070723
171800070718     C     AKey          klist
171900070718     C                   Kfld                    AOTRST
172000070718     C                   Kfld                    AOSUB#
172100070718     C                   Kfld                    AOACCT
172200070718
172300070718     C     AKey          Chain     ACCMST
172400070718     C                   If        not %found(ACCMST)
172500070718     C                   Eval      ACNAM1 = *blanks
172600070718     C                   Eval      AACODE = *blanks
172700070718     C                   End
172800070718
172900070723     C     PKey          klist
173000070723     C                   Kfld                    PKID             40
173100070723     C                   Kfld                    PKAL             40
173200070723
173300070718     C                   Endsr
173400070718      *---------------------------------------------------------------*
173500070718     C     Transmit      Begsr
173600070720     C                   If        TranFlag = 'Y'
173700070718     C                   Z-add     Today         AODTDT
173800070718    ?C                   Update    ACCOSPR                              99
173900070720     C                   End
174000070718     C                   Endsr
174100070718    ? *___________________________________________________________________
174200070718    ? * Generate Password
174300070718    ? *___________________________________________________________________
174400070718    ?C     GenPW         Begsr
174500120605
174600120605      * If user/pass sent from green screen use it.
174700120605     C                   If        %trim(OUUSPW) <> *blanks
174800120605     C                   Eval      PWOLPW = %trim(OUUSPW)
174900120605     C                   Else
175000120605
175100120605      * otherwise generate it.
175200070723     C     PKey          Chain     OEREPOSL2
175300070723     C                   If        %found(OEREPOSL2)
175400070723     C                   Eval      PWOLPW = %trim(RPASS)
175500070723     C                   Else
175600070905     C                   eval      HHMMSS = HHMMSS + 3
175700070720     C                   Movel     HHMMSS        WTIME             6
175800080618     C                   Move      *blanks       PW4              10
175900080618      *
176000080618     C                   Eval      PW4 = #randstr()
176100070720     C                   eval      PWOLPW = %subst(%trim(PW4):1:4) +
176200070718     C                                      %trim(wtime)
176300130607     C                   Eval      OUUSPW = %trim(PWOLPW)
176400080618      *
176500070723     C                   End
176600120605     C                   End
176700120605      *
176800080618    ?C                   Endsr
176900070718      *---------------------------------------------------------------*
177000070718     C     *inzsr        Begsr
177100070718     C     *Entry        Plist
177200070718     C                   Parm                    Wtoday            8
177300070718     C                   move      wtoday        Today
177400070719     C     *ISO          Move      Today         TodayISO
177500070719     C                   adddur    1:*D          TodayISO
177600070719     C     *ISO          Move      TodayISO      Tomorrow
177700070905     C                   Time                    HHMMSS            6 0
177800070718     C                   Endsr
