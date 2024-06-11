000100080618     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200080618     H option(*SRCSTMT: *NODEBUGIO)
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500070717    ? *  Description:  BUILD PW FILES "A" RECORDS
000600070806    ? *
000700070806    ? *  MUST RUN BEFORE *MID-NIGHT*
000800000000    ? *
000900061129    ? *  (c)Copyright 2006 by GBS, Inc.
001000200422    ? *
001100200422    ? * 04.22.2020 J.Allen  pas1
001200200422    ? *    Updated password rules
001300200422    ? *
001400000000    ? *___________________________________________________________________
001500070718     FACCOSP    UP   E           K DISK
001600120606     FOEUSER    UF   E           K Disk
001700130524     FACCMST    IF   E           K Disk
001800130524     FACCMSP    IF   E           K Disk
001900080424     FHISTLF    IF   E           K Disk
002000070723     FOEREPOSL2 IF   E           K Disk
002100070723     FPWINFOLF  UF A E           K Disk
002200070718     FPWGRID    UF A E           K Disk
002300070718
002400080618      * Prototypes
002500080618      /COPY *LIBL/QMODSRC,#PROTO
002600080618
002700070719     D Today           s              8S 0 inz
002800070719     D Tomorrow        s              8S 0 inz
002900070719    ?D  TodayISO       S               D   datfmt(*ISO)
003000070720
003100120606     D WWEMAL          s            100    inz
003200070720     D TranFlag        s              1    inz
003300080618     D Tic             s              1a   inz(x'7D')
003400080618     D Pos             s              3s 0 inz
003500200422pas1 D pwhigh          s              2    inz
003600200422pas1 D pwlow           s              2    inz
003700080424
003800070718     D OETSA           DS
003900070718     D OE                      1      2    Inz('OE')
004000070718     D Trst                    3      5    Inz
004100070718     D Sub#                    6      8    Inz
004200070718     D Acct                    9     12    Inz
004300200422
004400200422pas1 D lo              c                   'abcdefghijklmnopqrstuvwxyz'
004500200422pas1 D up              c                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
004600070718
004700070718      *---------------------------------------------------------------*
004800160308     C*******            If        AOTRST = 590 and
004900160308     C*******                      AOSUB# = 008 and
005000160308     C*******                      AOACCT = 0002
005100130524
005200130524
005300130524      * Get payroll code
005400130524     C     AKey          Chain     ACCMSP
005500130524     C                   If        not %found(ACCMSP)
005600130524     C                   Clear                   AMPAYR
005700130524     C                   End
005800120817
005900111017      * If changing from 2-6 or 3-7 - ReSend users to Kevin
006000111017     C                   If        AODTDT = *Zeros  and
006100111017     C                             AOBEDT <> AOENDT and
006200111017     C                             AOBEDT >= Today  and
006300111017     C                             %trim(AOLMXGRP) = 'CHANGE'
006400111017     C     AKey          Setll     OEUSER
006500111017     C     AKey          Reade     OEUSER
006600111017    ?C                   Dow       Not %Eof(OEUSER)
006700111017     C                   If        OUENDT = 0
006800111017     C                   Eval      OUESNT = 0
006900111017     C                   Update    OEUSERR
007000111017     C                   End
007100111017     C     AKey          Reade     OEUSER
007200111017     C                   Enddo
007300111017     C                   End
007400080506
007500070720     C                   eval      TranFlag = 'N'
007600070718      * Process records equal to Today
007700070718     C                   Select
007800100921      *
007900100921      * Activation New Logic send same day entered into system. Per Dave A.
008000100921      * Per Dave A. Cindy, Kathy. 9/21/2010
008100100921     C                   When      AODTDT = *Zeros  and
008200120712     C                             AOBEDT <> AOENDT and
008300120712     C                             AOENDT =  0      and
008400120921     C                             AOBEDT >= Today  or
008500120921     C                             AODTDT = *Zeros  and
008600120921     C                             AOBEDT <> AOENDT and
008700120921     C                             AOENDT =  0      and
008800120921     C                             AOBEDT <  Today
008900100921     C                   Exsr      PWreset
009000100921     C                   Exsr      Activate
009100120831
009200120831      * Same Day Terms - Do nothing
009300120831     C                   When      AOBEDT = AOENDT
009400100921
009500080424      * Same Day Terms - Check for email sent
009600080507     C                   When      AOBEDT = AOENDT  and
009700080507     C                             AOBEDT = Today
009800080424     C                   Exsr      CheckHist
009900070718      * Activate
010000121107     C*****              When      AOBEDT = Tomorrow and
010100121107     C*****                        AOENDT =  0      and
010200121107     C*****                        AOBEDT <> AOENDT
010300121107     C*****              Exsr      PWreset
010400121107     C*****              Exsr      Activate
010500070718      * Terminate
010600121107     C                   When      AOENDT = Tomorrow and
010700121107     C                             AODTDT = *Zeros
010800070718     C                   Exsr      PWreset
010900070718     C                   Exsr      Terminate
011000080513      * Daily 1
011100070718     C                   When      Today  > AOBEDT and
011200070718     C                             Today  < AOENDT
011300070718     C                   Exsr      PWreset
011400070718     C                   Exsr      CheckDaily
011500080513      * Daily 2
011600080513     C                   When      Today  > AOBEDT and
011700080513     C                             AOENDT = 0
011800080513     C                   Exsr      PWreset
011900080513     C                   Exsr      CheckDaily
012000070718     C                   Endsl
012100070720
012200070720      * Check for Transmission
012300070720     C                   Exsr      Transmit
012400120817
012500160308     C*******            End
012600070718      *---------------------------------------------------------------*
012700070718     C     Activate      Begsr
012800070718     C     AKey          Setll     OEUSER
012900070718     C     AKey          Reade     OEUSER
013000070718    ?C                   Dow       Not %Eof(OEUSER)
013100121015     C                   If        OUENDT = 0  and
013200110713     C                             OUESNT = 0
013300121015
013400120606      * Save email
013500120606     C                   Eval      WWEMAL = %trim(OUEMAL)
013600111017
013700111017      * If changing from 2-6 or 3-7 - Do Not Send Emails
013800130218      * per Cindy 02.18.2013 allow emails to go out.
013900130218     C*******            If        %trim(AOLMXGRP) = 'CHANGE'
014000130218     C*******            Eval      WWEMAL = *blanks
014100130218     C*******            End
014200070828
014300110316     C                   Eval      PKID   = Trst + Sub# + Acct
014400110316     C                   Eval      PKAL   = %trim(OUUSER)
014500110316
014600100921     C*** Per Dave A.    If        Tomorrow >= OUBEDT and
014700100921     C*** Per Cindy                OUENDT = 0       or
014800100921     C*** Per Kathy                Tomorrow >= OUBEDT and
014900100921     C***                          Tomorrow <= OUENDT
015000070723
015100070718     C                   Select
015200070718     C                   When      AOCODE = 01
015300070718     C                   Exsr      CODE01
015400070718     C                   When      AOCODE = 02
015500070718     C                   Exsr      CODE02
015600070718     C                   When      AOCODE = 03
015700070718     C                   Exsr      CODE03
015800110412     C                   When      AOCODE = 04
015900110412     C                   Exsr      CODE04
016000110412     C                   When      AOCODE = 05
016100110412     C                   Exsr      CODE05
016200111017     C                   When      AOCODE = 06
016300111017     C                   Exsr      CODE06
016400111017     C                   When      AOCODE = 07
016500111017     C                   Exsr      CODE07
016600150422     C                   When      AOCODE = 08
016700150422     C                   Exsr      CODE08
016800150422     C                   When      AOCODE = 09
016900150422     C                   Exsr      CODE09
017000070718     C                   Endsl
017100070724
017200100921     C***                End
017300120606
017400120606     C                   Eval      OUESNT = Today
017500120606     C                   Update    OEUSERR
017600110713
017700110713     C                   End
017800070718     C     AKey          Reade     OEUSER
017900070718     C                   Enddo
018000070718
018100070718      * Create OE Generic Login
018200070720     C                   If        AOCODE   = 03  and
018300070720     C                             TranFlag = 'Y'
018400070718     C                   Exsr      OE03
018500070718     C                   End
018600120828
018700110412     C                   If        AOCODE   = 05  and
018800110412     C                             TranFlag = 'Y'
018900110817     C** No Screen 2     Exsr      OE05
019000110412     C                   End
019100120828
019200120828     C                   If        AOCODE   = 07  and
019300120828     C                             TranFlag = 'Y'
019400120828     C                   Exsr      OE07
019500120828     C                   End
019600070718
019700070718     C                   Endsr
019800070718      *---------------------------------------------------------------*
019900070718     C     Terminate     Begsr
020000070718     C     AKey          Setll     OEUSER
020100070718     C     AKey          Reade     OEUSER
020200070718    ?C                   Dow       Not %Eof(OEUSER)
020300121015
020400121015      * If "A" skip Kevin process
020500160309     C***                If        %trim(OUEMEX) = 'A'
020600160309     C***                LeaveSR
020700160309     C***                End
020800110316
020900110316     C                   Eval      PKID   = Trst + Sub# + Acct
021000110316     C                   Eval      PKAL   = %trim(OUUSER)
021100120625
021200130607      * Terminating = no email to user
021300130607     C                   Eval      WWEMAL = *blanks
021400070718
021500070718     C                   If        Today >= OUBEDT and
021600070718     C                             OUENDT = 0       or
021700070718     C                             Today >= OUBEDT and
021800070718     C                             Today <= OUENDT
021900070723
022000070718     C                   Select
022100070718     C                   When      AOCODE = 01
022200070718     C                   Exsr      CODE01T
022300070718     C                   When      AOCODE = 02
022400070718     C                   Exsr      CODE02T
022500070718     C                   When      AOCODE = 03
022600070718     C                   Exsr      CODE03T
022700110412     C                   When      AOCODE = 04
022800110412     C                   Exsr      CODE04T
022900110412     C                   When      AOCODE = 05
023000110412     C                   Exsr      CODE05T
023100111017     C                   When      AOCODE = 06
023200111017     C                   Exsr      CODE06T
023300111017     C                   When      AOCODE = 07
023400111017     C                   Exsr      CODE07T
023500150422     C                   When      AOCODE = 08
023600150422     C                   Exsr      CODE08T
023700150422     C                   When      AOCODE = 09
023800150422     C                   Exsr      CODE09T
023900070718     C                   Endsl
024000120606
024100121009      * DO NOT UPDATE the SENT Date on a Term
024200121009      * otherwise the ADD that follows will not send (leave it alone)
024300121009     C****               Eval      OUESNT = Today
024400121009
024500120606     C                   Update    OEUSERR
024600070724
024700070718     C                   End
024800070718
024900070718     C     AKey          Reade     OEUSER
025000070718     C                   Enddo
025100070718
025200070718      * Create OE Generic Login
025300070720     C                   If        AOCODE   = 03  and
025400070720     C                             TranFlag = 'Y'
025500070718     C                   Exsr      OE03T
025600070718     C                   End
025700110412     C                   If        AOCODE   = 05  and
025800110412     C                             TranFlag = 'Y'
025900110817     C** No Screen 2     Exsr      OE05T
026000110412     C                   End
026100120828     C                   If        AOCODE   = 07  and
026200120828     C                             TranFlag = 'Y'
026300120828     C                   Exsr      OE07T
026400120828     C                   End
026500070718
026600070718     C                   Endsr
026700080424      *---------------------------------------------------------------*
026800080424     C     CheckHist     Begsr
026900080424      *
027000080424      * If email was sent already for this same day term, then
027100080424      * we do want to process this term.
027200080512
027300080512     C                   Movel     AOTRST        Trst
027400080512     C                   Movel     AOSUB#        Sub#
027500080512     C                   Movel     AOACCT        Acct
027600080424      *
027700080424     C                   Eval      HKEY   = Trst + Sub# + Acct
027800080424      *
027900080508     C     HKEY          Setll     HISTLF
028000080508     C     HKEY          Reade     HISTLF
028100080424     C                   Dow       not %eof(HISTLF)
028200080424     C                   Select
028300080508     C                   When      TRCODE = 'U44' and
028400080508     C                             COVTDT = AOBEDT
028500080424     C                   Exsr      PWreset
028600080424     C                   Exsr      Terminate
028700080508     C                   When      TRCODE = 'U45' and
028800080508     C                             COVTDT = AOBEDT
028900080424     C                   Exsr      PWreset
029000080424     C                   Exsr      Terminate
029100080508     C                   When      TRCODE = 'U46' and
029200080508     C                             COVTDT = AOBEDT
029300080424     C                   Exsr      PWreset
029400080424     C                   Exsr      Terminate
029500080508     C                   When      TRCODE = 'U47' and
029600080508     C                             COVTDT = AOBEDT
029700080424     C                   Exsr      PWreset
029800080424     C                   Exsr      Terminate
029900080508     C                   When      TRCODE = 'U48' and
030000080508     C                             COVTDT = AOBEDT
030100080424     C                   Exsr      PWreset
030200080424     C                   Exsr      Terminate
030300080508     C                   When      TRCODE = 'U49' and
030400080508     C                             COVTDT = AOBEDT
030500080424     C                   Exsr      PWreset
030600080424     C                   Exsr      Terminate
030700080424     C                   Endsl
030800080508     C     HKEY          Reade     HISTLF
030900080424     C                   Enddo
031000080424
031100080424     C                   Endsr
031200070718      *---------------------------------------------------------------*
031300070718     C     CheckDaily    Begsr
031400070718     C     AKey          Setll     OEUSER
031500070718     C     AKey          Reade     OEUSER
031600070718    ?C                   Dow       Not %Eof(OEUSER)
031700121015
031800121015      * If "A" skip Kevin process
031900160309     C***                If        %trim(OUEMEX) = 'A'
032000160309     C***                LeaveSR
032100160309     C***                End
032200110316
032300110316     C                   Eval      PKID   = Trst + Sub# + Acct
032400110316     C                   Eval      PKAL   = %trim(OUUSER)
032500120625
032600120625      * Save email
032700120625     C                   Eval      WWEMAL = %trim(OUEMAL)
032800070718
032900070718      * If Starting Today
033000110713     C                   If        Today  = OUBEDT  and
033100110713     C                             OUENDT = 0       and
033200110713     C                             OUESNT = 0
033300070723
033400070718     C                   Select
033500070718     C                   When      AOCODE = 01
033600070718     C                   Exsr      CODE01
033700070718     C                   When      AOCODE = 02
033800070718     C                   Exsr      CODE02
033900070719     C                   When      AOCODE = 03
034000070719     C                   Exsr      CODE03
034100110412     C                   When      AOCODE = 04
034200110412     C                   Exsr      CODE04
034300110412     C                   When      AOCODE = 05
034400110412     C                   Exsr      CODE05
034500111017     C                   When      AOCODE = 06
034600111017     C                   Exsr      CODE06
034700111017     C                   When      AOCODE = 07
034800111017     C                   Exsr      CODE07
034900150422     C                   When      AOCODE = 08
035000150422     C                   Exsr      CODE08
035100150422     C                   When      AOCODE = 09
035200150422     C                   Exsr      CODE09
035300070718     C                   Endsl
035400120606
035500120606     C                   Eval      OUESNT = Today
035600120606     C                   Update    OEUSERR
035700070724
035800070718     C                   End
035900070718
036000100512      * If user is terming today create pwinfo record, no email.
036100070718     C                   If        Today  = OUENDT
036200070724
036300100512     C                   Select
036400100512     C                   When      AOCODE = 01
036500100512     C                   Exsr      CODE01U
036600100512     C                   When      AOCODE = 02
036700100512     C                   Exsr      CODE02U
036800100512     C                   When      AOCODE = 03
036900100512     C                   Exsr      CODE03U
037000110412     C                   When      AOCODE = 04
037100110412     C                   Exsr      CODE04U
037200110412     C                   When      AOCODE = 05
037300110412     C                   Exsr      CODE05U
037400111017     C                   When      AOCODE = 06
037500111017     C                   Exsr      CODE06U
037600111017     C                   When      AOCODE = 07
037700111017     C                   Exsr      CODE07U
037800150422     C                   When      AOCODE = 08
037900150422     C                   Exsr      CODE08U
038000150422     C                   When      AOCODE = 09
038100150422     C                   Exsr      CODE09U
038200100512     C                   Endsl
038300070724
038400070718     C                   End
038500070718
038600070718     C     AKey          Reade     OEUSER
038700070718     C                   Enddo
038800070718     C                   Endsr
038900070718      *---------------------------------------------------------------*
039000070718     C     Code01        Begsr
039100070723     C     PKEY          Chain     PWINFOLF
039200070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
039300070718     C                   Eval      PWALUS = %trim(OUUSER)
039400070718     C                   Eval      PWROLE = 'act_'
039500070718     C                   Eval      PWDESC = %trim(ACNAM1)
039600120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
039700070718     C                   Eval      PWCODE = AOCODE
039800070718     C                   Eval      PWUBDT = OUBEDT
039900070718     C                   Eval      PWAACD = %trim(AACODE)
040000070718     C                   Eval      PWULNM = %trim(OULNAM)
040100070720     C                   Eval      PWUFNM = %trim(OUFNAM)
040200070720     C                   Eval      PWDTDT = TODAY
040300070718     C                   Exsr      GenPW
040400070723     C                   If        %found(PWINFOLF)
040500070723     C                   Update    PWINFOR
040600070723     C                   Else
040700070718     C                   Write     PWINFOR
040800070723     C                   End
040900070720     C                   eval      TranFlag = 'Y'
041000080307
041100070718      * 01
041200070718     C                   Eval      GRALUS = %trim(PWALUS)
041300070718     C                   Eval      GRGRPID = 100002
041400070718     C                   Eval      GRACTCD = 'A'
041500070720     C                   Eval      GRDTDT = TODAY
041600070723     C                   Eval      GRCODE = AOCODE
041700070718     C                   Write     PWGRIDR
041800070718
041900070718     C                   Endsr
042000070718      *---------------------------------------------------------------*
042100070718     C     Code02        Begsr
042200070723     C     PKEY          Chain     PWINFOLF
042300070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
042400070718     C                   Eval      PWALUS = %trim(OUUSER)
042500070718     C                   Eval      PWROLE = 'act_'
042600070718     C                   Eval      PWDESC = %trim(ACNAM1)
042700120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
042800070718     C                   Eval      PWCODE = AOCODE
042900070718     C                   Eval      PWUBDT = OUBEDT
043000070718     C                   Eval      PWAACD = %trim(AACODE)
043100070718     C                   Eval      PWULNM = %trim(OULNAM)
043200070718     C                   Eval      PWUFNM = %trim(OUFNAM)
043300070720     C                   Eval      PWDTDT = TODAY
043400070718     C                   Exsr      GenPW
043500070723     C                   If        %found(PWINFOLF)
043600070723     C                   Update    PWINFOR
043700070723     C                   Else
043800070723     C                   Write     PWINFOR
043900070723     C                   End
044000070720     C                   eval      TranFlag = 'Y'
044100070718
044200070718      * 01
044300070718     C                   Eval      GRALUS = %trim(PWALUS)
044400070718     C                   Eval      GRGRPID = 100002
044500070718     C                   Eval      GRACTCD = 'A'
044600070720     C                   Eval      GRDTDT = TODAY
044700070723     C                   Eval      GRCODE = AOCODE
044800070718     C                   Write     PWGRIDR
044900070718
045000070718      * 02
045100070718     C                   Eval      GRALUS = %trim(PWALUS)
045200070718     C                   Eval      GRGRPID = 100115
045300070718     C                   Eval      GRACTCD = 'A'
045400070720     C                   Eval      GRDTDT = TODAY
045500070723     C                   Eval      GRCODE = AOCODE
045600070718     C                   Write     PWGRIDR
045700070718
045800070718     C                   Endsr
045900070718      *---------------------------------------------------------------*
046000070718     C     Code03        Begsr
046100070723     C     PKEY          Chain     PWINFOLF
046200070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
046300070718     C                   Eval      PWALUS = %trim(OUUSER)
046400070723     C                   Eval      PWROLE = 'act_'
046500070718     C                   Eval      PWDESC = %trim(ACNAM1)
046600120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
046700070718     C                   Eval      PWCODE = AOCODE
046800070718     C                   Eval      PWUBDT = OUBEDT
046900070718     C                   Eval      PWAACD = %trim(AACODE)
047000070718     C                   Eval      PWULNM = %trim(OULNAM)
047100070718     C                   Eval      PWUFNM = %trim(OUFNAM)
047200070720     C                   Eval      PWDTDT = TODAY
047300070718     C                   Exsr      GenPW
047400070723     C                   If        %found(PWINFOLF)
047500070723     C                   Update    PWINFOR
047600070723     C                   Else
047700070723     C                   Write     PWINFOR
047800070723     C                   End
047900070720     C                   eval      TranFlag = 'Y'
048000070718
048100070718      * 01
048200070718     C                   Eval      GRALUS = %trim(PWALUS)
048300070718     C                   Eval      GRGRPID = 100002
048400070718     C                   Eval      GRACTCD = 'A'
048500070720     C                   Eval      GRDTDT = TODAY
048600070723     C                   Eval      GRCODE = AOCODE
048700070718     C                   Write     PWGRIDR
048800070718
048900070718      * 02
049000070718     C                   Eval      GRALUS = %trim(PWALUS)
049100070718     C                   Eval      GRGRPID = 100115
049200070718     C                   Eval      GRACTCD = 'A'
049300070720     C                   Eval      GRDTDT = TODAY
049400070723     C                   Eval      GRCODE = AOCODE
049500070718     C                   Write     PWGRIDR
049600070731
049700070731      * 03
049800070731     C                   Eval      GRALUS = %trim(PWALUS)
049900070731     C                   Eval      GRGRPID = 100130
050000070731     C                   Eval      GRACTCD = 'A'
050100070731     C                   Eval      GRDTDT = TODAY
050200070731     C                   Eval      GRCODE = AOCODE
050300070731     C                   Write     PWGRIDR
050400130110      * 04
050500130110     C                   Eval      GRALUS = %trim(PWALUS)
050600130110     C                   Eval      GRGRPID = 100140
050700130110     C                   Eval      GRACTCD = 'A'
050800130110     C                   Eval      GRDTDT = TODAY
050900130110     C                   Eval      GRCODE = AOCODE
051000130110     C                   Write     PWGRIDR
051100070718
051200070718     C                   Endsr
051300110412      *---------------------------------------------------------------*
051400110412     C     Code04        Begsr
051500110412     C     PKEY          Chain     PWINFOLF
051600110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
051700110412     C                   Eval      PWALUS = %trim(OUUSER)
051800110412     C                   Eval      PWROLE = 'act_'
051900110412     C                   Eval      PWDESC = %trim(ACNAM1)
052000120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
052100110412     C                   Eval      PWCODE = AOCODE
052200110412     C                   Eval      PWUBDT = OUBEDT
052300110412     C                   Eval      PWAACD = %trim(AACODE)
052400110412     C                   Eval      PWULNM = %trim(OULNAM)
052500110412     C                   Eval      PWUFNM = %trim(OUFNAM)
052600110412     C                   Eval      PWDTDT = TODAY
052700110412     C                   Exsr      GenPW
052800110412     C                   If        %found(PWINFOLF)
052900110412     C                   Update    PWINFOR
053000110412     C                   Else
053100110412     C                   Write     PWINFOR
053200110412     C                   End
053300110412     C                   eval      TranFlag = 'Y'
053400110412
053500110412      * 01
053600110412     C                   Eval      GRALUS = %trim(PWALUS)
053700110412     C                   Eval      GRGRPID = 100002
053800110412     C                   Eval      GRACTCD = 'A'
053900110412     C                   Eval      GRDTDT = TODAY
054000110412     C                   Eval      GRCODE = AOCODE
054100110412     C                   Write     PWGRIDR
054200110412
054300110412      * 02
054400130524     C                   Eval      GRGRPID = 102115
054500110412     C                   Eval      GRALUS = %trim(PWALUS)
054600110412     C                   Eval      GRACTCD = 'A'
054700110412     C                   Eval      GRDTDT = TODAY
054800110412     C                   Eval      GRCODE = AOCODE
054900110412     C                   Write     PWGRIDR
055000110412
055100110412     C                   Endsr
055200110412      *---------------------------------------------------------------*
055300110412     C     Code05        Begsr
055400110412     C     PKEY          Chain     PWINFOLF
055500110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
055600110412     C                   Eval      PWALUS = %trim(OUUSER)
055700110412     C                   Eval      PWROLE = 'act_'
055800110412     C                   Eval      PWDESC = %trim(ACNAM1)
055900120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
056000110412     C                   Eval      PWCODE = AOCODE
056100110412     C                   Eval      PWUBDT = OUBEDT
056200110412     C                   Eval      PWAACD = %trim(AACODE)
056300110412     C                   Eval      PWULNM = %trim(OULNAM)
056400110412     C                   Eval      PWUFNM = %trim(OUFNAM)
056500110412     C                   Eval      PWDTDT = TODAY
056600110412     C                   Exsr      GenPW
056700110412     C                   If        %found(PWINFOLF)
056800110412     C                   Update    PWINFOR
056900110412     C                   Else
057000110412     C                   Write     PWINFOR
057100110412     C                   End
057200110412     C                   eval      TranFlag = 'Y'
057300110412
057400110412      * 01
057500110412     C                   Eval      GRALUS = %trim(PWALUS)
057600110412     C                   Eval      GRGRPID = 100002
057700110412     C                   Eval      GRACTCD = 'A'
057800110412     C                   Eval      GRDTDT = TODAY
057900110412     C                   Eval      GRCODE = AOCODE
058000110412     C                   Write     PWGRIDR
058100110412
058200110412      * 02
058300130524     C                   Eval      GRGRPID = 102115
058400110412     C                   Eval      GRALUS = %trim(PWALUS)
058500110412     C                   Eval      GRACTCD = 'A'
058600110412     C                   Eval      GRDTDT = TODAY
058700110412     C                   Eval      GRCODE = AOCODE
058800110412     C                   Write     PWGRIDR
058900110412
059000110412      * 03
059100110412     C                   Eval      GRALUS = %trim(PWALUS)
059200130110     C                   Eval      GRGRPID = 100140
059300110412     C                   Eval      GRACTCD = 'A'
059400110412     C                   Eval      GRDTDT = TODAY
059500110412     C                   Eval      GRCODE = AOCODE
059600110412     C                   Write     PWGRIDR
059700110412
059800110412     C                   Endsr
059900111017      *---------------------------------------------------------------*
060000111017     C     Code06        Begsr
060100111017     C     PKEY          Chain     PWINFOLF
060200111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
060300111017     C                   Eval      PWALUS = %trim(OUUSER)
060400111017     C                   Eval      PWROLE = 'act_'
060500111017     C                   Eval      PWDESC = %trim(ACNAM1)
060600120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
060700111017     C                   Eval      PWCODE = AOCODE
060800111017     C                   Eval      PWUBDT = OUBEDT
060900111017     C                   Eval      PWAACD = %trim(AACODE)
061000111017     C                   Eval      PWULNM = %trim(OULNAM)
061100111017     C                   Eval      PWUFNM = %trim(OUFNAM)
061200111017     C                   Eval      PWDTDT = TODAY
061300111017     C                   Exsr      GenPW
061400111017     C                   If        %found(PWINFOLF)
061500111017     C                   Update    PWINFOR
061600111017     C                   Else
061700111017     C                   Write     PWINFOR
061800111017     C                   End
061900111017     C                   eval      TranFlag = 'Y'
062000111017
062100111017      * 01
062200111017     C                   Eval      GRALUS = %trim(PWALUS)
062300111017     C                   Eval      GRGRPID = 100002
062400111017     C                   Eval      GRACTCD = 'A'
062500111017     C                   Eval      GRDTDT = TODAY
062600111017     C                   Eval      GRCODE = AOCODE
062700111017     C                   Write     PWGRIDR
062800111017
062900111017      * 02
063000111017     C                   Eval      GRALUS = %trim(PWALUS)
063100130524     C                   Eval      GRGRPID = 102115
063200111017     C                   Eval      GRACTCD = 'A'
063300111017     C                   Eval      GRDTDT = TODAY
063400111017     C                   Eval      GRCODE = AOCODE
063500111017     C                   Write     PWGRIDR
063600111017
063700111017     C                   Endsr
063800111017      *---------------------------------------------------------------*
063900111017     C     Code07        Begsr
064000111017     C     PKEY          Chain     PWINFOLF
064100111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
064200111017     C                   Eval      PWALUS = %trim(OUUSER)
064300111017     C                   Eval      PWROLE = 'act_'
064400111017     C                   Eval      PWDESC = %trim(ACNAM1)
064500120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
064600111017     C                   Eval      PWCODE = AOCODE
064700111017     C                   Eval      PWUBDT = OUBEDT
064800111017     C                   Eval      PWAACD = %trim(AACODE)
064900111017     C                   Eval      PWULNM = %trim(OULNAM)
065000111017     C                   Eval      PWUFNM = %trim(OUFNAM)
065100111017     C                   Eval      PWDTDT = TODAY
065200111017     C                   Exsr      GenPW
065300111017     C                   If        %found(PWINFOLF)
065400111017     C                   Update    PWINFOR
065500111017     C                   Else
065600111017     C                   Write     PWINFOR
065700111017     C                   End
065800111017     C                   eval      TranFlag = 'Y'
065900111017
066000111017      * 01
066100111017     C                   Eval      GRALUS = %trim(PWALUS)
066200111017     C                   Eval      GRGRPID = 100002
066300111017     C                   Eval      GRACTCD = 'A'
066400111017     C                   Eval      GRDTDT = TODAY
066500111017     C                   Eval      GRCODE = AOCODE
066600111017     C                   Write     PWGRIDR
066700111017
066800111017      * 02
066900111017     C                   Eval      GRALUS = %trim(PWALUS)
067000111017     C                   Eval      GRGRPID = 102115
067100111017     C                   Eval      GRACTCD = 'A'
067200111017     C                   Eval      GRDTDT = TODAY
067300111017     C                   Eval      GRCODE = AOCODE
067400111017     C                   Write     PWGRIDR
067500111017
067600111017      * 03
067700111017     C                   Eval      GRALUS = %trim(PWALUS)
067800130110     C                   Eval      GRGRPID = 100140
067900111017     C                   Eval      GRACTCD = 'A'
068000111017     C                   Eval      GRDTDT = TODAY
068100111017     C                   Eval      GRCODE = AOCODE
068200111017     C                   Write     PWGRIDR
068300111017
068400111017     C                   Endsr
068500150422      *---------------------------------------------------------------*
068600150422     C     Code08        Begsr
068700150422     C     PKEY          Chain     PWINFOLF
068800150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
068900150422     C                   Eval      PWALUS = %trim(OUUSER)
069000150422     C                   Eval      PWROLE = 'act_'
069100150422     C                   Eval      PWDESC = %trim(ACNAM1)
069200150422     C                   Eval      PWEMAIL = %trim(WWEMAL)
069300150422     C                   Eval      PWCODE = AOCODE
069400150422     C                   Eval      PWUBDT = OUBEDT
069500150422     C                   Eval      PWAACD = %trim(AACODE)
069600150422     C                   Eval      PWULNM = %trim(OULNAM)
069700150422     C                   Eval      PWUFNM = %trim(OUFNAM)
069800150422     C                   Eval      PWDTDT = TODAY
069900150422     C                   Exsr      GenPW
070000150422     C                   If        %found(PWINFOLF)
070100150422     C                   Update    PWINFOR
070200150422     C                   Else
070300150422     C                   Write     PWINFOR
070400150422     C                   End
070500150422     C                   eval      TranFlag = 'Y'
070600150422
070700150422      * 01
070800150422     C                   Eval      GRALUS = %trim(PWALUS)
070900150715     C                   Eval      GRGRPID = 100003
071000150422     C                   Eval      GRACTCD = 'A'
071100150422     C                   Eval      GRDTDT = TODAY
071200150422     C                   Eval      GRCODE = AOCODE
071300150422     C                   Write     PWGRIDR
071400150422
071500150422      * 02
071600150422     C                   Eval      GRGRPID = 100115
071700150422     C                   Eval      GRALUS = %trim(PWALUS)
071800150422     C                   Eval      GRACTCD = 'A'
071900150422     C                   Eval      GRDTDT = TODAY
072000150422     C                   Eval      GRCODE = AOCODE
072100150422     C                   Write     PWGRIDR
072200150422
072300150422     C                   Endsr
072400150422      *---------------------------------------------------------------*
072500150422     C     Code09        Begsr
072600150422     C     PKEY          Chain     PWINFOLF
072700150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
072800150422     C                   Eval      PWALUS = %trim(OUUSER)
072900150422     C                   Eval      PWROLE = 'act_'
073000150422     C                   Eval      PWDESC = %trim(ACNAM1)
073100150422     C                   Eval      PWEMAIL = %trim(WWEMAL)
073200150422     C                   Eval      PWCODE = AOCODE
073300150422     C                   Eval      PWUBDT = OUBEDT
073400150422     C                   Eval      PWAACD = %trim(AACODE)
073500150422     C                   Eval      PWULNM = %trim(OULNAM)
073600150422     C                   Eval      PWUFNM = %trim(OUFNAM)
073700150422     C                   Eval      PWDTDT = TODAY
073800150422     C                   Exsr      GenPW
073900150422     C                   If        %found(PWINFOLF)
074000150422     C                   Update    PWINFOR
074100150422     C                   Else
074200150422     C                   Write     PWINFOR
074300150422     C                   End
074400150422     C                   eval      TranFlag = 'Y'
074500150422
074600150422      * 01
074700150422     C                   Eval      GRALUS = %trim(PWALUS)
074800150715     C                   Eval      GRGRPID = 100003
074900150422     C                   Eval      GRACTCD = 'A'
075000150422     C                   Eval      GRDTDT = TODAY
075100150422     C                   Eval      GRCODE = AOCODE
075200150422     C                   Write     PWGRIDR
075300150422
075400150422      * 02
075500150422     C                   Eval      GRGRPID = 100115
075600150422     C                   Eval      GRALUS = %trim(PWALUS)
075700150422     C                   Eval      GRACTCD = 'A'
075800150422     C                   Eval      GRDTDT = TODAY
075900150422     C                   Eval      GRCODE = AOCODE
076000150422     C                   Write     PWGRIDR
076100150422
076200150422      * 03
076300150422     C                   Eval      GRALUS = %trim(PWALUS)
076400150422     C                   Eval      GRGRPID = 100140
076500150422     C                   Eval      GRACTCD = 'A'
076600150422     C                   Eval      GRDTDT = TODAY
076700150422     C                   Eval      GRCODE = AOCODE
076800150422     C                   Write     PWGRIDR
076900150422
077000150422     C                   Endsr
077100070718      *---------------------------------------------------------------*
077200070718     C     Code01T       Begsr
077300070723     C     PKEY          Chain     PWINFOLF
077400070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
077500070718     C                   Eval      PWALUS = %trim(OUUSER)
077600070718     C                   Eval      PWROLE = 'act_'
077700070718     C                   Eval      PWDESC = %trim(ACNAM1)
077800120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
077900070718     C                   Eval      PWCODE = AOCODE
078000070718     C                   Eval      PWUBDT = OUBEDT
078100070718     C                   Eval      PWAACD = %trim(AACODE)
078200070718     C                   Eval      PWULNM = %trim(OULNAM)
078300070718     C                   Eval      PWUFNM = %trim(OUFNAM)
078400130607     C                   Eval      PWOLPW = *BLANKS
078500070720     C                   Eval      PWDTDT = TODAY
078600070723     C                   If        %found(PWINFOLF)
078700070723     C                   Update    PWINFOR
078800070723     C                   Else
078900070723     C                   Write     PWINFOR
079000070723     C                   End
079100070720     C                   eval      TranFlag = 'Y'
079200070718
079300070718      * 01
079400070718     C                   Eval      GRALUS = %trim(PWALUS)
079500070718     C                   Eval      GRGRPID = 100002
079600070718     C                   Eval      GRACTCD = 'D'
079700070720     C                   Eval      GRDTDT = TODAY
079800070723     C                   Eval      GRCODE = AOCODE
079900070718     C                   Write     PWGRIDR
080000070718
080100070718     C                   Endsr
080200070718      *---------------------------------------------------------------*
080300070718     C     Code02T       Begsr
080400070723     C     PKEY          Chain     PWINFOLF
080500070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
080600070718     C                   Eval      PWALUS = %trim(OUUSER)
080700070718     C                   Eval      PWROLE = 'act_'
080800070718     C                   Eval      PWDESC = %trim(ACNAM1)
080900120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
081000070718     C                   Eval      PWCODE = AOCODE
081100070718     C                   Eval      PWUBDT = OUBEDT
081200070718     C                   Eval      PWAACD = %trim(AACODE)
081300070718     C                   Eval      PWULNM = %trim(OULNAM)
081400070718     C                   Eval      PWUFNM = %trim(OUFNAM)
081500130607     C                   Eval      PWOLPW = *BLANKS
081600070720     C                   Eval      PWDTDT = TODAY
081700070723     C                   If        %found(PWINFOLF)
081800070723     C                   Update    PWINFOR
081900070723     C                   Else
082000070723     C                   Write     PWINFOR
082100070723     C                   End
082200070720     C                   eval      TranFlag = 'Y'
082300080307
082400070718      * 01
082500070718     C                   Eval      GRALUS = %trim(PWALUS)
082600070718     C                   Eval      GRGRPID = 100002
082700070718     C                   Eval      GRACTCD = 'D'
082800070720     C                   Eval      GRDTDT = TODAY
082900070723     C                   Eval      GRCODE = AOCODE
083000070718     C                   Write     PWGRIDR
083100070718
083200070718      * 02
083300070718     C                   Eval      GRALUS = %trim(PWALUS)
083400070718     C                   Eval      GRGRPID = 100115
083500070718     C                   Eval      GRACTCD = 'D'
083600070720     C                   Eval      GRDTDT = TODAY
083700070723     C                   Eval      GRCODE = AOCODE
083800070718     C                   Write     PWGRIDR
083900070718
084000070718     C                   Endsr
084100070718      *---------------------------------------------------------------*
084200070718     C     Code03T       Begsr
084300070723     C     PKEY          Chain     PWINFOLF
084400070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
084500070718     C                   Eval      PWALUS = %trim(OUUSER)
084600070723     C                   Eval      PWROLE = 'act_'
084700070718     C                   Eval      PWDESC = %trim(ACNAM1)
084800120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
084900070718     C                   Eval      PWCODE = AOCODE
085000070718     C                   Eval      PWUBDT = OUBEDT
085100070718     C                   Eval      PWAACD = %trim(AACODE)
085200070718     C                   Eval      PWULNM = %trim(OULNAM)
085300070718     C                   Eval      PWUFNM = %trim(OUFNAM)
085400130607     C                   Eval      PWOLPW = *BLANKS
085500070720     C                   Eval      PWDTDT = TODAY
085600070723     C                   If        %found(PWINFOLF)
085700070723     C                   Update    PWINFOR
085800070723     C                   Else
085900070723     C                   Write     PWINFOR
086000070723     C                   End
086100070720     C                   eval      TranFlag = 'Y'
086200070718
086300070718      * 01
086400070718     C                   Eval      GRALUS = %trim(PWALUS)
086500070718     C                   Eval      GRGRPID = 100002
086600070718     C                   Eval      GRACTCD = 'D'
086700070720     C                   Eval      GRDTDT = TODAY
086800070723     C                   Eval      GRCODE = AOCODE
086900070718     C                   Write     PWGRIDR
087000070718
087100070718      * 02
087200070718     C                   Eval      GRALUS = %trim(PWALUS)
087300070718     C                   Eval      GRGRPID = 100115
087400070718     C                   Eval      GRACTCD = 'D'
087500070720     C                   Eval      GRDTDT = TODAY
087600070723     C                   Eval      GRCODE = AOCODE
087700070718     C                   Write     PWGRIDR
087800070731
087900070731      * 03
088000070731     C                   Eval      GRALUS = %trim(PWALUS)
088100070731     C                   Eval      GRGRPID = 100130
088200070731     C                   Eval      GRACTCD = 'D'
088300070731     C                   Eval      GRDTDT = TODAY
088400070731     C                   Eval      GRCODE = AOCODE
088500070731     C                   Write     PWGRIDR
088600130110
088700130110      * 03
088800130110     C                   Eval      GRALUS = %trim(PWALUS)
088900130110     C                   Eval      GRGRPID = 100140
089000130110     C                   Eval      GRACTCD = 'D'
089100130110     C                   Eval      GRDTDT = TODAY
089200130110     C                   Eval      GRCODE = AOCODE
089300130110     C                   Write     PWGRIDR
089400070718
089500070718     C                   Endsr
089600110412      *---------------------------------------------------------------*
089700110412     C     Code04T       Begsr
089800110412     C     PKEY          Chain     PWINFOLF
089900110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
090000110412     C                   Eval      PWALUS = %trim(OUUSER)
090100110412     C                   Eval      PWROLE = 'act_'
090200110412     C                   Eval      PWDESC = %trim(ACNAM1)
090300120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
090400110412     C                   Eval      PWCODE = AOCODE
090500110412     C                   Eval      PWUBDT = OUBEDT
090600110412     C                   Eval      PWAACD = %trim(AACODE)
090700110412     C                   Eval      PWULNM = %trim(OULNAM)
090800110412     C                   Eval      PWUFNM = %trim(OUFNAM)
090900130607     C                   Eval      PWOLPW = *BLANKS
091000110412     C                   Eval      PWDTDT = TODAY
091100110412     C                   If        %found(PWINFOLF)
091200110412     C                   Update    PWINFOR
091300110412     C                   Else
091400110412     C                   Write     PWINFOR
091500110412     C                   End
091600110412     C                   eval      TranFlag = 'Y'
091700110412
091800110412      * 01
091900110412     C                   Eval      GRALUS = %trim(PWALUS)
092000110412     C                   Eval      GRGRPID = 100002
092100110412     C                   Eval      GRACTCD = 'D'
092200110412     C                   Eval      GRDTDT = TODAY
092300110412     C                   Eval      GRCODE = AOCODE
092400110412     C                   Write     PWGRIDR
092500110412
092600110412      * 02
092700130524     C                   Eval      GRGRPID = 102115
092800110412     C                   Eval      GRALUS = %trim(PWALUS)
092900110412     C                   Eval      GRACTCD = 'D'
093000110412     C                   Eval      GRDTDT = TODAY
093100110412     C                   Eval      GRCODE = AOCODE
093200110412     C                   Write     PWGRIDR
093300110412
093400110412     C                   Endsr
093500110412      *---------------------------------------------------------------*
093600110412     C     Code05T       Begsr
093700110412     C     PKEY          Chain     PWINFOLF
093800110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
093900110412     C                   Eval      PWALUS = %trim(OUUSER)
094000110412     C                   Eval      PWROLE = 'act_'
094100110412     C                   Eval      PWDESC = %trim(ACNAM1)
094200120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
094300110412     C                   Eval      PWCODE = AOCODE
094400110412     C                   Eval      PWUBDT = OUBEDT
094500110412     C                   Eval      PWAACD = %trim(AACODE)
094600110412     C                   Eval      PWULNM = %trim(OULNAM)
094700110412     C                   Eval      PWUFNM = %trim(OUFNAM)
094800130607     C                   Eval      PWOLPW = *BLANKS
094900110412     C                   Eval      PWDTDT = TODAY
095000110412     C                   If        %found(PWINFOLF)
095100110412     C                   Update    PWINFOR
095200110412     C                   Else
095300110412     C                   Write     PWINFOR
095400110412     C                   End
095500110412     C                   eval      TranFlag = 'Y'
095600110412
095700110412      * 01
095800110412     C                   Eval      GRALUS = %trim(PWALUS)
095900110412     C                   Eval      GRGRPID = 100002
096000110412     C                   Eval      GRACTCD = 'D'
096100110412     C                   Eval      GRDTDT = TODAY
096200110412     C                   Eval      GRCODE = AOCODE
096300110412     C                   Write     PWGRIDR
096400110412
096500110412      * 02
096600130524     C                   Eval      GRGRPID = 102115
096700110412     C                   Eval      GRALUS = %trim(PWALUS)
096800110412     C                   Eval      GRACTCD = 'D'
096900110412     C                   Eval      GRDTDT = TODAY
097000110412     C                   Eval      GRCODE = AOCODE
097100110412     C                   Write     PWGRIDR
097200110412
097300110412      * 03
097400110412     C                   Eval      GRALUS = %trim(PWALUS)
097500130110     C                   Eval      GRGRPID = 100140
097600110412     C                   Eval      GRACTCD = 'D'
097700110412     C                   Eval      GRDTDT = TODAY
097800110412     C                   Eval      GRCODE = AOCODE
097900110412     C                   Write     PWGRIDR
098000110412
098100110412     C                   Endsr
098200111017      *---------------------------------------------------------------*
098300111017     C     Code06T       Begsr
098400111017     C     PKEY          Chain     PWINFOLF
098500111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
098600111017     C                   Eval      PWALUS = %trim(OUUSER)
098700111017     C                   Eval      PWROLE = 'act_'
098800111017     C                   Eval      PWDESC = %trim(ACNAM1)
098900120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
099000111017     C                   Eval      PWCODE = AOCODE
099100111017     C                   Eval      PWUBDT = OUBEDT
099200111017     C                   Eval      PWAACD = %trim(AACODE)
099300111017     C                   Eval      PWULNM = %trim(OULNAM)
099400111017     C                   Eval      PWUFNM = %trim(OUFNAM)
099500130607     C                   Eval      PWOLPW = *BLANKS
099600111017     C                   Eval      PWDTDT = TODAY
099700111017     C                   If        %found(PWINFOLF)
099800111017     C                   Update    PWINFOR
099900111017     C                   Else
100000111017     C                   Write     PWINFOR
100100111017     C                   End
100200111017     C                   eval      TranFlag = 'Y'
100300111017
100400111017      * 01
100500111017     C                   Eval      GRALUS = %trim(PWALUS)
100600111017     C                   Eval      GRGRPID = 100002
100700111017     C                   Eval      GRACTCD = 'D'
100800111017     C                   Eval      GRDTDT = TODAY
100900111017     C                   Eval      GRCODE = AOCODE
101000111017     C                   Write     PWGRIDR
101100111017
101200111017      * 02
101300111017     C                   Eval      GRALUS = %trim(PWALUS)
101400111017     C                   Eval      GRGRPID = 102115
101500111017     C                   Eval      GRACTCD = 'D'
101600111017     C                   Eval      GRDTDT = TODAY
101700111017     C                   Eval      GRCODE = AOCODE
101800111017     C                   Write     PWGRIDR
101900111017
102000111017     C                   Endsr
102100111017      *---------------------------------------------------------------*
102200111017     C     Code07T       Begsr
102300111017     C     PKEY          Chain     PWINFOLF
102400111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
102500111017     C                   Eval      PWALUS = %trim(OUUSER)
102600111017     C                   Eval      PWROLE = 'act_'
102700111017     C                   Eval      PWDESC = %trim(ACNAM1)
102800120606     C                   Eval      PWEMAIL = %trim(WWEMAL)
102900111017     C                   Eval      PWCODE = AOCODE
103000111017     C                   Eval      PWUBDT = OUBEDT
103100111017     C                   Eval      PWAACD = %trim(AACODE)
103200111017     C                   Eval      PWULNM = %trim(OULNAM)
103300111017     C                   Eval      PWUFNM = %trim(OUFNAM)
103400130607     C                   Eval      PWOLPW = *BLANKS
103500111017     C                   Eval      PWDTDT = TODAY
103600111017     C                   If        %found(PWINFOLF)
103700111017     C                   Update    PWINFOR
103800111017     C                   Else
103900111017     C                   Write     PWINFOR
104000111017     C                   End
104100111017     C                   eval      TranFlag = 'Y'
104200111017
104300111017      * 01
104400111017     C                   Eval      GRALUS = %trim(PWALUS)
104500111017     C                   Eval      GRGRPID = 100002
104600111017     C                   Eval      GRACTCD = 'D'
104700111017     C                   Eval      GRDTDT = TODAY
104800111017     C                   Eval      GRCODE = AOCODE
104900111017     C                   Write     PWGRIDR
105000111017
105100111017      * 02
105200111017     C                   Eval      GRALUS = %trim(PWALUS)
105300111017     C                   Eval      GRGRPID = 102115
105400111017     C                   Eval      GRACTCD = 'D'
105500111017     C                   Eval      GRDTDT = TODAY
105600111017     C                   Eval      GRCODE = AOCODE
105700111017     C                   Write     PWGRIDR
105800111017
105900111017      * 03
106000111017     C                   Eval      GRALUS = %trim(PWALUS)
106100130110     C                   Eval      GRGRPID = 100140
106200111017     C                   Eval      GRACTCD = 'D'
106300111017     C                   Eval      GRDTDT = TODAY
106400111017     C                   Eval      GRCODE = AOCODE
106500111017     C                   Write     PWGRIDR
106600111017
106700111017     C                   Endsr
106800150422      *---------------------------------------------------------------*
106900150422     C     Code08T       Begsr
107000150422     C     PKEY          Chain     PWINFOLF
107100150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
107200150422     C                   Eval      PWALUS = %trim(OUUSER)
107300150422     C                   Eval      PWROLE = 'act_'
107400150422     C                   Eval      PWDESC = %trim(ACNAM1)
107500150422     C                   Eval      PWEMAIL = %trim(WWEMAL)
107600150422     C                   Eval      PWCODE = AOCODE
107700150422     C                   Eval      PWUBDT = OUBEDT
107800150422     C                   Eval      PWAACD = %trim(AACODE)
107900150422     C                   Eval      PWULNM = %trim(OULNAM)
108000150422     C                   Eval      PWUFNM = %trim(OUFNAM)
108100150422     C                   Eval      PWOLPW = *BLANKS
108200150422     C                   Eval      PWDTDT = TODAY
108300150422     C                   If        %found(PWINFOLF)
108400150422     C                   Update    PWINFOR
108500150422     C                   Else
108600150422     C                   Write     PWINFOR
108700150422     C                   End
108800150422     C                   eval      TranFlag = 'Y'
108900150422
109000150422      * 01
109100150422     C                   Eval      GRALUS = %trim(PWALUS)
109200150715     C                   Eval      GRGRPID = 100003
109300150422     C                   Eval      GRACTCD = 'D'
109400150422     C                   Eval      GRDTDT = TODAY
109500150422     C                   Eval      GRCODE = AOCODE
109600150422     C                   Write     PWGRIDR
109700150422
109800150422      * 02
109900150422     C                   Eval      GRGRPID = 100115
110000150422     C                   Eval      GRALUS = %trim(PWALUS)
110100150422     C                   Eval      GRACTCD = 'D'
110200150422     C                   Eval      GRDTDT = TODAY
110300150422     C                   Eval      GRCODE = AOCODE
110400150422     C                   Write     PWGRIDR
110500150422
110600150422     C                   Endsr
110700150422      *---------------------------------------------------------------*
110800150422     C     Code09T       Begsr
110900150422     C     PKEY          Chain     PWINFOLF
111000150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
111100150422     C                   Eval      PWALUS = %trim(OUUSER)
111200150422     C                   Eval      PWROLE = 'act_'
111300150422     C                   Eval      PWDESC = %trim(ACNAM1)
111400150422     C                   Eval      PWEMAIL = %trim(WWEMAL)
111500150422     C                   Eval      PWCODE = AOCODE
111600150422     C                   Eval      PWUBDT = OUBEDT
111700150422     C                   Eval      PWAACD = %trim(AACODE)
111800150422     C                   Eval      PWULNM = %trim(OULNAM)
111900150422     C                   Eval      PWUFNM = %trim(OUFNAM)
112000150422     C                   Eval      PWOLPW = *BLANKS
112100150422     C                   Eval      PWDTDT = TODAY
112200150422     C                   If        %found(PWINFOLF)
112300150422     C                   Update    PWINFOR
112400150422     C                   Else
112500150422     C                   Write     PWINFOR
112600150422     C                   End
112700150422     C                   eval      TranFlag = 'Y'
112800150422
112900150422      * 01
113000150422     C                   Eval      GRALUS = %trim(PWALUS)
113100150715     C                   Eval      GRGRPID = 100003
113200150422     C                   Eval      GRACTCD = 'D'
113300150422     C                   Eval      GRDTDT = TODAY
113400150422     C                   Eval      GRCODE = AOCODE
113500150422     C                   Write     PWGRIDR
113600150422
113700150422      * 02
113800150422     C                   Eval      GRGRPID = 100115
113900150422     C                   Eval      GRALUS = %trim(PWALUS)
114000150422     C                   Eval      GRACTCD = 'D'
114100150422     C                   Eval      GRDTDT = TODAY
114200150422     C                   Eval      GRCODE = AOCODE
114300150422     C                   Write     PWGRIDR
114400150422
114500150422      * 03
114600150422     C                   Eval      GRALUS = %trim(PWALUS)
114700150422     C                   Eval      GRGRPID = 100140
114800150422     C                   Eval      GRACTCD = 'D'
114900150422     C                   Eval      GRDTDT = TODAY
115000150422     C                   Eval      GRCODE = AOCODE
115100150422     C                   Write     PWGRIDR
115200150422
115300150422     C                   Endsr
115400100512      *---------------------------------------------------------------*
115500100512     C     Code01U       Begsr
115600100512     C     PKEY          Chain     PWINFOLF
115700100512     C                   Eval      PWIDEN = Trst + Sub# + Acct
115800100512     C                   Eval      PWALUS = %trim(OUUSER)
115900100512     C                   Eval      PWROLE = 'act_'
116000100512     C                   Eval      PWDESC = %trim(ACNAM1)
116100100512     C                   Eval      PWEMAIL = 'TERM_USER'
116200100512     C                   Eval      PWCODE = AOCODE
116300100512     C                   Eval      PWUBDT = OUBEDT
116400100512     C                   Eval      PWAACD = %trim(AACODE)
116500100512     C                   Eval      PWULNM = %trim(OULNAM)
116600100512     C                   Eval      PWUFNM = %trim(OUFNAM)
116700130607     C                   Eval      PWOLPW = *BLANKS
116800100512     C                   Eval      PWDTDT = TODAY
116900100512     C                   If        %found(PWINFOLF)
117000100512     C                   Update    PWINFOR
117100100512     C                   Else
117200100512     C                   Write     PWINFOR
117300100512     C                   End
117400100512     C                   eval      TranFlag = 'Y'
117500100512
117600100512      * 01
117700100512     C                   Eval      GRALUS = %trim(PWALUS)
117800100512     C                   Eval      GRGRPID = 100002
117900100512     C                   Eval      GRACTCD = 'D'
118000100512     C                   Eval      GRDTDT = TODAY
118100100512     C                   Eval      GRCODE = AOCODE
118200100512     C                   Write     PWGRIDR
118300100512
118400100512     C                   Endsr
118500100512      *---------------------------------------------------------------*
118600100512     C     Code02U       Begsr
118700100512     C     PKEY          Chain     PWINFOLF
118800100512     C                   Eval      PWIDEN = Trst + Sub# + Acct
118900100512     C                   Eval      PWALUS = %trim(OUUSER)
119000100512     C                   Eval      PWROLE = 'act_'
119100100512     C                   Eval      PWDESC = %trim(ACNAM1)
119200100512     C                   Eval      PWEMAIL = 'TERM_USER'
119300100512     C                   Eval      PWCODE = AOCODE
119400100512     C                   Eval      PWUBDT = OUBEDT
119500100512     C                   Eval      PWAACD = %trim(AACODE)
119600100512     C                   Eval      PWULNM = %trim(OULNAM)
119700100512     C                   Eval      PWUFNM = %trim(OUFNAM)
119800130607     C                   Eval      PWOLPW = *BLANKS
119900100512     C                   Eval      PWDTDT = TODAY
120000100512     C                   If        %found(PWINFOLF)
120100100512     C                   Update    PWINFOR
120200100512     C                   Else
120300100512     C                   Write     PWINFOR
120400100512     C                   End
120500100512     C                   eval      TranFlag = 'Y'
120600100512
120700100512      * 01
120800100512     C                   Eval      GRALUS = %trim(PWALUS)
120900100512     C                   Eval      GRGRPID = 100002
121000100512     C                   Eval      GRACTCD = 'D'
121100100512     C                   Eval      GRDTDT = TODAY
121200100512     C                   Eval      GRCODE = AOCODE
121300100512     C                   Write     PWGRIDR
121400100512
121500100512      * 02
121600100512     C                   Eval      GRALUS = %trim(PWALUS)
121700100512     C                   Eval      GRGRPID = 100115
121800100512     C                   Eval      GRACTCD = 'D'
121900100512     C                   Eval      GRDTDT = TODAY
122000100512     C                   Eval      GRCODE = AOCODE
122100100512     C                   Write     PWGRIDR
122200100512
122300100512     C                   Endsr
122400100512      *---------------------------------------------------------------*
122500100512     C     Code03U       Begsr
122600100512     C     PKEY          Chain     PWINFOLF
122700100512     C                   Eval      PWIDEN = Trst + Sub# + Acct
122800100512     C                   Eval      PWALUS = %trim(OUUSER)
122900100512     C                   Eval      PWROLE = 'act_'
123000100512     C                   Eval      PWDESC = %trim(ACNAM1)
123100100512     C                   Eval      PWEMAIL = 'TERM_USER'
123200100512     C                   Eval      PWCODE = AOCODE
123300100512     C                   Eval      PWUBDT = OUBEDT
123400100512     C                   Eval      PWAACD = %trim(AACODE)
123500100512     C                   Eval      PWULNM = %trim(OULNAM)
123600100512     C                   Eval      PWUFNM = %trim(OUFNAM)
123700130607     C                   Eval      PWOLPW = *BLANKS
123800100512     C                   Eval      PWDTDT = TODAY
123900100512     C                   If        %found(PWINFOLF)
124000100512     C                   Update    PWINFOR
124100100512     C                   Else
124200100512     C                   Write     PWINFOR
124300100512     C                   End
124400100512     C                   eval      TranFlag = 'Y'
124500100512
124600100512      * 01
124700100512     C                   Eval      GRALUS = %trim(PWALUS)
124800100512     C                   Eval      GRGRPID = 100002
124900100512     C                   Eval      GRACTCD = 'D'
125000100512     C                   Eval      GRDTDT = TODAY
125100100512     C                   Eval      GRCODE = AOCODE
125200100512     C                   Write     PWGRIDR
125300100512
125400100512      * 02
125500100512     C                   Eval      GRALUS = %trim(PWALUS)
125600100512     C                   Eval      GRGRPID = 100115
125700100512     C                   Eval      GRACTCD = 'D'
125800100512     C                   Eval      GRDTDT = TODAY
125900100512     C                   Eval      GRCODE = AOCODE
126000100512     C                   Write     PWGRIDR
126100100512
126200100512      * 03
126300100512     C                   Eval      GRALUS = %trim(PWALUS)
126400100512     C                   Eval      GRGRPID = 100130
126500100512     C                   Eval      GRACTCD = 'D'
126600100512     C                   Eval      GRDTDT = TODAY
126700100512     C                   Eval      GRCODE = AOCODE
126800100512     C                   Write     PWGRIDR
126900130110
127000130110      * 03
127100130110     C                   Eval      GRALUS = %trim(PWALUS)
127200130110     C                   Eval      GRGRPID = 100140
127300130110     C                   Eval      GRACTCD = 'D'
127400130110     C                   Eval      GRDTDT = TODAY
127500130110     C                   Eval      GRCODE = AOCODE
127600130110     C                   Write     PWGRIDR
127700100512
127800100512     C                   Endsr
127900110412      *---------------------------------------------------------------*
128000110412     C     Code04U       Begsr
128100110412     C     PKEY          Chain     PWINFOLF
128200110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
128300110412     C                   Eval      PWALUS = %trim(OUUSER)
128400110412     C                   Eval      PWROLE = 'act_'
128500110412     C                   Eval      PWDESC = %trim(ACNAM1)
128600110412     C                   Eval      PWEMAIL = 'TERM_USER'
128700110412     C                   Eval      PWCODE = AOCODE
128800110412     C                   Eval      PWUBDT = OUBEDT
128900110412     C                   Eval      PWAACD = %trim(AACODE)
129000110412     C                   Eval      PWULNM = %trim(OULNAM)
129100110412     C                   Eval      PWUFNM = %trim(OUFNAM)
129200130607     C                   Eval      PWOLPW = *BLANKS
129300110412     C                   Eval      PWDTDT = TODAY
129400110412     C                   If        %found(PWINFOLF)
129500110412     C                   Update    PWINFOR
129600110412     C                   Else
129700110412     C                   Write     PWINFOR
129800110412     C                   End
129900110412     C                   eval      TranFlag = 'Y'
130000110412
130100110412      * 01
130200110412     C                   Eval      GRALUS = %trim(PWALUS)
130300110412     C                   Eval      GRGRPID = 100002
130400110412     C                   Eval      GRACTCD = 'D'
130500110412     C                   Eval      GRDTDT = TODAY
130600110412     C                   Eval      GRCODE = AOCODE
130700110412     C                   Write     PWGRIDR
130800110412
130900110412      * 02
131000130524     C                   Eval      GRGRPID = 102115
131100110412     C                   Eval      GRALUS = %trim(PWALUS)
131200110412     C                   Eval      GRACTCD = 'D'
131300110412     C                   Eval      GRDTDT = TODAY
131400110412     C                   Eval      GRCODE = AOCODE
131500110412     C                   Write     PWGRIDR
131600110412
131700110412     C                   Endsr
131800110412      *---------------------------------------------------------------*
131900110412     C     Code05U       Begsr
132000110412     C     PKEY          Chain     PWINFOLF
132100110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
132200110412     C                   Eval      PWALUS = %trim(OUUSER)
132300110412     C                   Eval      PWROLE = 'act_'
132400110412     C                   Eval      PWDESC = %trim(ACNAM1)
132500110412     C                   Eval      PWEMAIL = 'TERM_USER'
132600110412     C                   Eval      PWCODE = AOCODE
132700110412     C                   Eval      PWUBDT = OUBEDT
132800110412     C                   Eval      PWAACD = %trim(AACODE)
132900110412     C                   Eval      PWULNM = %trim(OULNAM)
133000110412     C                   Eval      PWUFNM = %trim(OUFNAM)
133100130607     C                   Eval      PWOLPW = *BLANKS
133200110412     C                   Eval      PWDTDT = TODAY
133300110412     C                   If        %found(PWINFOLF)
133400110412     C                   Update    PWINFOR
133500110412     C                   Else
133600110412     C                   Write     PWINFOR
133700110412     C                   End
133800110412     C                   eval      TranFlag = 'Y'
133900110412
134000110412      * 01
134100110412     C                   Eval      GRALUS = %trim(PWALUS)
134200110412     C                   Eval      GRGRPID = 100002
134300110412     C                   Eval      GRACTCD = 'D'
134400110412     C                   Eval      GRDTDT = TODAY
134500110412     C                   Eval      GRCODE = AOCODE
134600110412     C                   Write     PWGRIDR
134700110412
134800110412      * 02
134900130524     C                   Eval      GRGRPID = 102115
135000110412     C                   Eval      GRALUS = %trim(PWALUS)
135100110412     C                   Eval      GRACTCD = 'D'
135200110412     C                   Eval      GRDTDT = TODAY
135300110412     C                   Eval      GRCODE = AOCODE
135400110412     C                   Write     PWGRIDR
135500110412
135600110412      * 03
135700110412     C                   Eval      GRALUS = %trim(PWALUS)
135800130110     C                   Eval      GRGRPID = 100140
135900110412     C                   Eval      GRACTCD = 'D'
136000110412     C                   Eval      GRDTDT = TODAY
136100110412     C                   Eval      GRCODE = AOCODE
136200110412     C                   Write     PWGRIDR
136300110412
136400110412     C                   Endsr
136500111017      *---------------------------------------------------------------*
136600111017     C     Code06U       Begsr
136700111017     C     PKEY          Chain     PWINFOLF
136800111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
136900111017     C                   Eval      PWALUS = %trim(OUUSER)
137000111017     C                   Eval      PWROLE = 'act_'
137100111017     C                   Eval      PWDESC = %trim(ACNAM1)
137200111017     C                   Eval      PWEMAIL = 'TERM_USER'
137300111017     C                   Eval      PWCODE = AOCODE
137400111017     C                   Eval      PWUBDT = OUBEDT
137500111017     C                   Eval      PWAACD = %trim(AACODE)
137600111017     C                   Eval      PWULNM = %trim(OULNAM)
137700111017     C                   Eval      PWUFNM = %trim(OUFNAM)
137800130607     C                   Eval      PWOLPW = *BLANKS
137900111017     C                   Eval      PWDTDT = TODAY
138000111017     C                   If        %found(PWINFOLF)
138100111017     C                   Update    PWINFOR
138200111017     C                   Else
138300111017     C                   Write     PWINFOR
138400111017     C                   End
138500111017     C                   eval      TranFlag = 'Y'
138600111017
138700111017      * 01
138800111017     C                   Eval      GRALUS = %trim(PWALUS)
138900111017     C                   Eval      GRGRPID = 100002
139000111017     C                   Eval      GRACTCD = 'D'
139100111017     C                   Eval      GRDTDT = TODAY
139200111017     C                   Eval      GRCODE = AOCODE
139300111017     C                   Write     PWGRIDR
139400111017
139500111017      * 02
139600111017     C                   Eval      GRALUS = %trim(PWALUS)
139700111017     C                   Eval      GRGRPID = 102115
139800111017     C                   Eval      GRACTCD = 'D'
139900111017     C                   Eval      GRDTDT = TODAY
140000111017     C                   Eval      GRCODE = AOCODE
140100111017     C                   Write     PWGRIDR
140200111017
140300111017     C                   Endsr
140400111017      *---------------------------------------------------------------*
140500111017     C     Code07U       Begsr
140600111017     C     PKEY          Chain     PWINFOLF
140700111017     C                   Eval      PWIDEN = Trst + Sub# + Acct
140800111017     C                   Eval      PWALUS = %trim(OUUSER)
140900111017     C                   Eval      PWROLE = 'act_'
141000111017     C                   Eval      PWDESC = %trim(ACNAM1)
141100111017     C                   Eval      PWEMAIL = 'TERM_USER'
141200111017     C                   Eval      PWCODE = AOCODE
141300111017     C                   Eval      PWUBDT = OUBEDT
141400111017     C                   Eval      PWAACD = %trim(AACODE)
141500111017     C                   Eval      PWULNM = %trim(OULNAM)
141600111017     C                   Eval      PWUFNM = %trim(OUFNAM)
141700130607     C                   Eval      PWOLPW = *BLANKS
141800111017     C                   Eval      PWDTDT = TODAY
141900111017     C                   If        %found(PWINFOLF)
142000111017     C                   Update    PWINFOR
142100111017     C                   Else
142200111017     C                   Write     PWINFOR
142300111017     C                   End
142400111017     C                   eval      TranFlag = 'Y'
142500111017
142600111017      * 01
142700111017     C                   Eval      GRALUS = %trim(PWALUS)
142800111017     C                   Eval      GRGRPID = 100002
142900111017     C                   Eval      GRACTCD = 'D'
143000111017     C                   Eval      GRDTDT = TODAY
143100111017     C                   Eval      GRCODE = AOCODE
143200111017     C                   Write     PWGRIDR
143300111017
143400111017      * 02
143500111017     C                   Eval      GRALUS = %trim(PWALUS)
143600111017     C                   Eval      GRGRPID = 102115
143700111017     C                   Eval      GRACTCD = 'D'
143800111017     C                   Eval      GRDTDT = TODAY
143900111017     C                   Eval      GRCODE = AOCODE
144000111017     C                   Write     PWGRIDR
144100111017
144200111017      * 03
144300111017     C                   Eval      GRALUS = %trim(PWALUS)
144400130110     C                   Eval      GRGRPID = 100140
144500111017     C                   Eval      GRACTCD = 'D'
144600111017     C                   Eval      GRDTDT = TODAY
144700111017     C                   Eval      GRCODE = AOCODE
144800111017     C                   Write     PWGRIDR
144900111017
145000111017     C                   Endsr
145100150422      *---------------------------------------------------------------*
145200150422     C     Code08U       Begsr
145300150422     C     PKEY          Chain     PWINFOLF
145400150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
145500150422     C                   Eval      PWALUS = %trim(OUUSER)
145600150422     C                   Eval      PWROLE = 'act_'
145700150422     C                   Eval      PWDESC = %trim(ACNAM1)
145800150422     C                   Eval      PWEMAIL = 'TERM_USER'
145900150422     C                   Eval      PWCODE = AOCODE
146000150422     C                   Eval      PWUBDT = OUBEDT
146100150422     C                   Eval      PWAACD = %trim(AACODE)
146200150422     C                   Eval      PWULNM = %trim(OULNAM)
146300150422     C                   Eval      PWUFNM = %trim(OUFNAM)
146400150422     C                   Eval      PWOLPW = *BLANKS
146500150422     C                   Eval      PWDTDT = TODAY
146600150422     C                   If        %found(PWINFOLF)
146700150422     C                   Update    PWINFOR
146800150422     C                   Else
146900150422     C                   Write     PWINFOR
147000150422     C                   End
147100150422     C                   eval      TranFlag = 'Y'
147200150422
147300150422      * 01
147400150422     C                   Eval      GRALUS = %trim(PWALUS)
147500150715     C                   Eval      GRGRPID = 100003
147600150422     C                   Eval      GRACTCD = 'D'
147700150422     C                   Eval      GRDTDT = TODAY
147800150422     C                   Eval      GRCODE = AOCODE
147900150422     C                   Write     PWGRIDR
148000150422
148100150422      * 02
148200150422     C                   Eval      GRGRPID = 100115
148300150422     C                   Eval      GRALUS = %trim(PWALUS)
148400150422     C                   Eval      GRACTCD = 'D'
148500150422     C                   Eval      GRDTDT = TODAY
148600150422     C                   Eval      GRCODE = AOCODE
148700150422     C                   Write     PWGRIDR
148800150422
148900150422     C                   Endsr
149000150422      *---------------------------------------------------------------*
149100150422     C     Code09U       Begsr
149200150422     C     PKEY          Chain     PWINFOLF
149300150422     C                   Eval      PWIDEN = Trst + Sub# + Acct
149400150422     C                   Eval      PWALUS = %trim(OUUSER)
149500150422     C                   Eval      PWROLE = 'act_'
149600150422     C                   Eval      PWDESC = %trim(ACNAM1)
149700150422     C                   Eval      PWEMAIL = 'TERM_USER'
149800150422     C                   Eval      PWCODE = AOCODE
149900150422     C                   Eval      PWUBDT = OUBEDT
150000150422     C                   Eval      PWAACD = %trim(AACODE)
150100150422     C                   Eval      PWULNM = %trim(OULNAM)
150200150422     C                   Eval      PWUFNM = %trim(OUFNAM)
150300150422     C                   Eval      PWOLPW = *BLANKS
150400150422     C                   Eval      PWDTDT = TODAY
150500150422     C                   If        %found(PWINFOLF)
150600150422     C                   Update    PWINFOR
150700150422     C                   Else
150800150422     C                   Write     PWINFOR
150900150422     C                   End
151000150422     C                   eval      TranFlag = 'Y'
151100150422
151200150422      * 01
151300150422     C                   Eval      GRALUS = %trim(PWALUS)
151400150715     C                   Eval      GRGRPID = 100003
151500150422     C                   Eval      GRACTCD = 'D'
151600150422     C                   Eval      GRDTDT = TODAY
151700150422     C                   Eval      GRCODE = AOCODE
151800150422     C                   Write     PWGRIDR
151900150422
152000150422      * 02
152100150422     C                   Eval      GRGRPID = 100115
152200150422     C                   Eval      GRALUS = %trim(PWALUS)
152300150422     C                   Eval      GRACTCD = 'D'
152400150422     C                   Eval      GRDTDT = TODAY
152500150422     C                   Eval      GRCODE = AOCODE
152600150422     C                   Write     PWGRIDR
152700150422
152800150422      * 03
152900150422     C                   Eval      GRALUS = %trim(PWALUS)
153000150422     C                   Eval      GRGRPID = 100140
153100150422     C                   Eval      GRACTCD = 'D'
153200150422     C                   Eval      GRDTDT = TODAY
153300150422     C                   Eval      GRCODE = AOCODE
153400150422     C                   Write     PWGRIDR
153500150422
153600150422     C                   Endsr
153700070718      *---------------------------------------------------------------*
153800070718     C     OE03          Begsr
153900070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
154000070718     C                   Eval      PWALUS = %trim(OETSA)
154100080331
154200080331     C                   Eval      PKID   = %trim(PWIDEN)
154300080331     C                   Eval      PKAL   = %trim(PWALUS)
154400080331
154500070718     C                   Eval      PWROLE = 'aoe_'
154600070718     C                   Eval      PWDESC = %trim(ACNAM1)
154700070718     C                   Eval      PWEMAIL = *blanks
154800070718     C                   Eval      PWCODE = AOCODE
154900070718     C                   Eval      PWUBDT = Today
155000070718     C                   Eval      PWAACD = %trim(AACODE)
155100070720     C                   Eval      PWULNM = %trim(ACNAM1)
155200070720     C                   Eval      PWUFNM = 'GENERIC OE'
155300070720     C                   Exsr      GenPW
155400070720     C                   Eval      PWDTDT = TODAY
155500070723     C                   Write     PWINFOR
155600070720     C                   eval      TranFlag = 'Y'
155700070718
155800070718      * 03
155900070718     C                   Eval      GRALUS = %trim(PWALUS)
156000070718     C                   Eval      GRGRPID = 100126
156100070718     C                   Eval      GRACTCD = 'A'
156200070720     C                   Eval      GRDTDT = TODAY
156300070723     C                   Eval      GRCODE = AOCODE
156400070718     C                   Write     PWGRIDR
156500070718
156600070718     C                   Endsr
156700110412      *---------------------------------------------------------------*
156800110412     C     OE05          Begsr
156900110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
157000110412     C                   Eval      PWALUS = %trim(OETSA)
157100110412
157200110412     C                   Eval      PKID   = %trim(PWIDEN)
157300110412     C                   Eval      PKAL   = %trim(PWALUS)
157400110412
157500110412     C                   Eval      PWROLE = 'aoe_'
157600110412     C                   Eval      PWDESC = %trim(ACNAM1)
157700110412     C                   Eval      PWEMAIL = *blanks
157800110412     C                   Eval      PWCODE = AOCODE
157900110412     C                   Eval      PWUBDT = Today
158000110412     C                   Eval      PWAACD = %trim(AACODE)
158100110412     C                   Eval      PWULNM = %trim(ACNAM1)
158200110412     C                   Eval      PWUFNM = 'GENERIC OE'
158300110412     C                   Exsr      GenPW
158400110412     C                   Eval      PWDTDT = TODAY
158500110412     C                   Write     PWINFOR
158600110412     C                   eval      TranFlag = 'Y'
158700110412
158800110412      * 03
158900110412     C                   Eval      GRALUS = %trim(PWALUS)
159000110412     C                   Eval      GRGRPID = 100126
159100110412     C                   Eval      GRACTCD = 'A'
159200110412     C                   Eval      GRDTDT = TODAY
159300110412     C                   Eval      GRCODE = AOCODE
159400110412     C                   Write     PWGRIDR
159500110412
159600110412     C                   Endsr
159700120828      *---------------------------------------------------------------*
159800120828     C     OE07          Begsr
159900120828     C                   Eval      PWIDEN = Trst + Sub# + Acct
160000120828     C                   Eval      PWALUS = %trim(OETSA)
160100120828
160200120828     C                   Eval      PKID   = %trim(PWIDEN)
160300120828     C                   Eval      PKAL   = %trim(PWALUS)
160400120828
160500120828     C                   Eval      PWROLE = 'aoe_'
160600120828     C                   Eval      PWDESC = %trim(ACNAM1)
160700120828     C                   Eval      PWEMAIL = *blanks
160800120828     C                   Eval      PWCODE = AOCODE
160900120828     C                   Eval      PWUBDT = Today
161000120828     C                   Eval      PWAACD = %trim(AACODE)
161100120828     C                   Eval      PWULNM = %trim(ACNAM1)
161200120828     C                   Eval      PWUFNM = 'GENERIC OE'
161300120828     C                   Exsr      GenPW
161400120828     C                   Eval      PWDTDT = TODAY
161500120828     C                   Write     PWINFOR
161600120828     C                   eval      TranFlag = 'Y'
161700120828
161800120828      * 07
161900120828     C                   Eval      GRALUS = %trim(PWALUS)
162000120828     C                   Eval      GRGRPID = 100126
162100120828     C                   Eval      GRACTCD = 'A'
162200120828     C                   Eval      GRDTDT = TODAY
162300120828     C                   Eval      GRCODE = AOCODE
162400120828     C                   Write     PWGRIDR
162500120828
162600120828     C                   Endsr
162700070718      *---------------------------------------------------------------*
162800070718     C     OE03T         Begsr
162900070718     C                   Eval      PWIDEN = Trst + Sub# + Acct
163000070718     C                   Eval      PWALUS = %trim(OETSA)
163100080331
163200080331     C                   Eval      PKID   = %trim(PWIDEN)
163300080331     C                   Eval      PKAL   = %trim(PWALUS)
163400080331
163500070718     C                   Eval      PWROLE = 'aoe_'
163600070718     C                   Eval      PWDESC = %trim(ACNAM1)
163700070718     C                   Eval      PWEMAIL = *blanks
163800070718     C                   Eval      PWCODE = AOCODE
163900070718     C                   Eval      PWUBDT = Today
164000070718     C                   Eval      PWAACD = %trim(AACODE)
164100070720     C                   Eval      PWULNM = %trim(ACNAM1)
164200070720     C                   Eval      PWUFNM = 'GENERIC OE'
164300130607     C                   Eval      PWOLPW = *blanks
164400070720     C                   Eval      PWDTDT = TODAY
164500070723     C                   Write     PWINFOR
164600070720     C                   eval      TranFlag = 'Y'
164700070718
164800070718      * 03
164900070718     C                   Eval      GRALUS = %trim(PWALUS)
165000070718     C                   Eval      GRGRPID = 100126
165100070718     C                   Eval      GRACTCD = 'D'
165200070720     C                   Eval      GRDTDT = TODAY
165300070723     C                   Eval      GRCODE = AOCODE
165400070718     C                   Write     PWGRIDR
165500070718
165600070718     C                   Endsr
165700110412      *---------------------------------------------------------------*
165800110412     C     OE05T         Begsr
165900110412     C                   Eval      PWIDEN = Trst + Sub# + Acct
166000110412     C                   Eval      PWALUS = %trim(OETSA)
166100110412
166200110412     C                   Eval      PKID   = %trim(PWIDEN)
166300110412     C                   Eval      PKAL   = %trim(PWALUS)
166400110412
166500110412     C                   Eval      PWROLE = 'aoe_'
166600110412     C                   Eval      PWDESC = %trim(ACNAM1)
166700110412     C                   Eval      PWEMAIL = *blanks
166800110412     C                   Eval      PWCODE = AOCODE
166900110412     C                   Eval      PWUBDT = Today
167000110412     C                   Eval      PWAACD = %trim(AACODE)
167100110412     C                   Eval      PWULNM = %trim(ACNAM1)
167200110412     C                   Eval      PWUFNM = 'GENERIC OE'
167300130607     C                   Eval      PWOLPW = *blanks
167400110412     C                   Eval      PWDTDT = TODAY
167500110412     C                   Write     PWINFOR
167600110412     C                   eval      TranFlag = 'Y'
167700110412
167800110412      * 03
167900110412     C                   Eval      GRALUS = %trim(PWALUS)
168000110412     C                   Eval      GRGRPID = 100126
168100110412     C                   Eval      GRACTCD = 'D'
168200110412     C                   Eval      GRDTDT = TODAY
168300110412     C                   Eval      GRCODE = AOCODE
168400110412     C                   Write     PWGRIDR
168500110412
168600110412     C                   Endsr
168700120828      *---------------------------------------------------------------*
168800120828     C     OE07T         Begsr
168900120828     C                   Eval      PWIDEN = Trst + Sub# + Acct
169000120828     C                   Eval      PWALUS = %trim(OETSA)
169100120828
169200120828     C                   Eval      PKID   = %trim(PWIDEN)
169300120828     C                   Eval      PKAL   = %trim(PWALUS)
169400120828
169500120828     C                   Eval      PWROLE = 'aoe_'
169600120828     C                   Eval      PWDESC = %trim(ACNAM1)
169700120828     C                   Eval      PWEMAIL = *blanks
169800120828     C                   Eval      PWCODE = AOCODE
169900120828     C                   Eval      PWUBDT = Today
170000120828     C                   Eval      PWAACD = %trim(AACODE)
170100120828     C                   Eval      PWULNM = %trim(ACNAM1)
170200120828     C                   Eval      PWUFNM = 'GENERIC OE'
170300130607     C                   Eval      PWOLPW = *blanks
170400120828     C                   Eval      PWDTDT = TODAY
170500120828     C                   Write     PWINFOR
170600120828     C                   eval      TranFlag = 'Y'
170700120828
170800120828      * 07
170900120828     C                   Eval      GRALUS = %trim(PWALUS)
171000120828     C                   Eval      GRGRPID = 100126
171100120828     C                   Eval      GRACTCD = 'D'
171200120828     C                   Eval      GRDTDT = TODAY
171300120828     C                   Eval      GRCODE = AOCODE
171400120828     C                   Write     PWGRIDR
171500120828
171600120828     C                   Endsr
171700070718      *---------------------------------------------------------------*
171800070718     C     PWreset       Begsr
171900070718
172000070718     C                   Clear                   PWINFOR
172100070718     C                   Clear                   PWGRIDR
172200070718
172300070718     C                   Movel     AOTRST        Trst
172400070718     C                   Movel     AOSUB#        Sub#
172500070718     C                   Movel     AOACCT        Acct
172600070723
172700070718     C     AKey          klist
172800070718     C                   Kfld                    AOTRST
172900070718     C                   Kfld                    AOSUB#
173000070718     C                   Kfld                    AOACCT
173100070718
173200070718     C     AKey          Chain     ACCMST
173300070718     C                   If        not %found(ACCMST)
173400070718     C                   Eval      ACNAM1 = *blanks
173500070718     C                   Eval      AACODE = *blanks
173600070718     C                   End
173700070718
173800070723     C     PKey          klist
173900070723     C                   Kfld                    PKID             40
174000070723     C                   Kfld                    PKAL             40
174100070723
174200070718     C                   Endsr
174300070718      *---------------------------------------------------------------*
174400070718     C     Transmit      Begsr
174500070720     C                   If        TranFlag = 'Y'
174600070718     C                   Z-add     Today         AODTDT
174700070718    ?C                   Update    ACCOSPR                              99
174800070720     C                   End
174900070718     C                   Endsr
175000070718    ? *___________________________________________________________________
175100070718    ? * Generate Password
175200070718    ? *___________________________________________________________________
175300070718    ?C     GenPW         Begsr
175400120605
175500120605      * If user/pass sent from green screen use it.
175600120605     C                   If        %trim(OUUSPW) <> *blanks
175700120605     C                   Eval      PWOLPW = %trim(OUUSPW)
175800120605     C                   Else
175900120605
176000120605      * otherwise generate it.
176100070723     C     PKey          Chain     OEREPOSL2
176200070723     C                   If        %found(OEREPOSL2)
176300070723     C                   Eval      PWOLPW = %trim(RPASS)
176400070723     C                   Else
176500070905     C                   eval      HHMMSS = HHMMSS + 3
176600070720     C                   Movel     HHMMSS        WTIME             6
176700200422pas1 C                   Move      *blanks       PW10             10
176800200422     C                   Move      *blanks       PW4               4
176900080618      *
177000200422pas1 C                   Eval      PW10 = #randstr()
177100200422      *
177200200422      * New password format.
177300200422pas1 C                   movel     PW10          PW4
177400200422pas1 C                   movel     PW4           pwhigh
177500200422pas1 C                   move      PW4           pwlow
177600200422pas1 C     up:lo         xlate     pwlow         pwlow
177700200422pas1 C                   eval      PW4 = pwhigh + pwlow
177800200422      *
177900200422pas1 C                   eval      PWOLPW = %trim(PW4) +
178000200422     C                                      %trim(wtime) + '!'
178100130607     C                   Eval      OUUSPW = %trim(PWOLPW)
178200080618      *
178300070723     C                   End
178400120605     C                   End
178500120605      *
178600080618    ?C                   Endsr
178700070718      *---------------------------------------------------------------*
178800070718     C     *inzsr        Begsr
178900070718     C     *Entry        Plist
179000070718     C                   Parm                    Wtoday            8
179100070718     C                   move      wtoday        Today
179200070719     C     *ISO          Move      Today         TodayISO
179300070719     C                   adddur    1:*D          TodayISO
179400070719     C     *ISO          Move      TodayISO      Tomorrow
179500070905     C                   Time                    HHMMSS            6 0
179600070718     C                   Endsr
