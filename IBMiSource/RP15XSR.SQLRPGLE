000100171220      *========================================================================
000200220425     H option(*noDebugIo)  DftActGrp(*no)  bnddir('GBSBIND')
000300171220      *========================================================================
000400171220      *  RP15XSR - Employee/Dependent Turning Age Letter - 65
000500171220      *========================================================================
000600171220      * Date     Int   Description
000700171220      * -------- ---   --------------------------------------------------------
000800171220      *  3/25/03 SZZ
000900171220      *  5/20/04 SZZ   Move zeros to history dep seq#, invoic date and receive
001000171220      *                date to avoid data decimal errors.
001100171220      * 03/01/10 szz   Exclude On-site Dental (Trust Category Code N) per
001200171220      *                Shelly R. and Dave A.
001300171220      * 04/11/13 szz   Changes to spacing based on page sements
001400171220      * 09/25/13 dpb   Add CC:broker to PRTF, write to RP15WWK so we can
001500130925      *                generate a mailing label for the broker
001600171220      * 10/17/17 jt    Updated code
001700180109      * 01/09/17 jt  - Added changes for Advanced Mobile
001800200113      * 01/13/20 jt  - Added changes for CMS
001900210430      * 02/16/21 jt  - check for zero zipcode
002000210727      * 04/30/21 JA  - update dependent seq# in HIST
002100210727      * 07/27/21 JA  - Include Mailing Address page MAILR
002200210728      * 07/28/21 JA  - Amwins Branding
002300220330      * 03/30/22 JA  - Amwins Legal update to letters
002400220329
002500220329      *========================================================================
002600220329      * PAGSEG Location:  i:/mis/AS400PageSegments/Turning Age Letters/
002700220329      *
002800220330      * As of 03.30.2022     - TA65P01_2022.docx
002900220330      *                      - TA65P02_2022.docx
003000220330      *                      - TA65P03_2022.docx
003100220330      *                      - TA65P04_2022.docx
003200220425      *
003300220425      * 04/25/22 JA  - Convert to full PDF (printing issues)
003400220329      *
003500220329      *========================================================================
003600200113
003700171017      *========================================================================
003800171017
003900171220     Facmunique if   e           k disk    rename(accmsr:acmu)
004000171019     f                                     prefix(acm_)
004100171017
004200210430     Fmember    if   e           k disk    extfile('F.MEMBER')
004300210430
004400210430     Fdepend    if   e           k disk    extfile('F.DEPEND') prefix(J_)
004500171017
004600171220     ftrmunique if   e           k disk
004700171220
004800171220     fsmanuniqueif   e           k disk
004900171017
005000171220     faacode    if   e           k disk    rename(aacodr:aaFile)
005100220427     f                                     extfile('QS36F/AACODE')
005200171017
005300171220     fhist      o    e             disk    extfile('F.HIST')
005400171017
005500171220     frp15wwk   o    e             disk    usropn
005600220425
005700220425       dcl-f TURNLET65P usage( *output ) usropn;
005800171017
005900171017      //=======================================================================
006000130925
006100130925     d rp15xwk       e ds                  inz
006200171019
006300210817
006400210817     D @date           ds
006500210817     D  todayN                 1      8s 0 inz
006600210817     D  todayA                 1      8    inz
006700210817
006800210817     D @time           ds
006900210817     D  clockN                 1      6s 0 inz
007000210817     D  clockA                 1      6    inz
007100210817
007200171220     d                uds
007300171220     d tyear                  21     24
007400130925
007500171220     d                 ds
007600171220     d xMBSSNO                             Inz(*zeros)
007700171220     d  SSNO1_DS                      3    Overlay(xMBSSNO)
007800171220     d  SSNO2_DS                      2    Overlay(xMBSSNO:4)
007900171220     d  SSNO3_DS                      4    Overlay(xMBSSNO:6)
008000130925
008100171220     d hkey            ds
008200171220     d  BlankSpace                    1    Inz(*blanks)
008300171220     d  MemberNo                      9
008400171017
008500171220     d                 ds
008600171220     d cfssno                        11    Inz('XXX-XX-    ')
008700171220     d  SSNO6_DS                      4    Overlay(CFSSNO:8)
008800130925
008900171220     d                 ds
009000171220     d LDDate                              INZ(*zeros)
009100171220     d  LCCYY                         4  0 Overlay(LDDate)
009200171220     d  LMM                           2  0 Overlay(LDDate:5)
009300171220     d  LDD                           2  0 Overlay(LDdate:7)
009400130925
009500171220     d                 ds
009600171220     d CalcDt                              INZ(*ZEROS)
009700171220     d  CMM                           2  0 Overlay(CalcDt)
009800171220     d  CDD                           2  0 Overlay(CalcDt:3)
009900171220     d  CCCYY                         4  0 Overlay(CalcDt:5)
010000130925
010100171220    ?d DsDate          ds
010200171220     d  CC                     1      2
010300171220     d  DSyy                   3      4
010400171220     d  DSmm                   5      6
010500171220     d  DSdd                   7      8
010600130925
010700171220    ?d DsDate8         ds
010800171220     d  DSCompDate             1      8  0
010900171220     d  DSmmdd8                1      4  0
011000171220     d  DSmm8                  1      2
011100171220     d  DSdd8                  3      4
011200171220     d  CC8                    5      6
011300171220     d  DSyy8                  7      8
011400130925
011500171220     d                 ds
011600171220    ?d Month65                 1      8  0
011700171220     d  M65mm                  1      2  0
011800171220     d  M65dd                  3      4  0
011900171220     d  M65ccyy                5      8  0
012000131017
012100171220     d iopgmd        esds
012200130925
012300220330     d Attmsg          c                   ' Attaining Age 65'
012400171220     d Turmsg          c                   'Turning 65 - '
012500171017
012600171220    ?d WWdate          s              8  0
012700171220    ?d WDDATE1         s               D   Datfmt(*ISO)
012800171220     d WDATE8          s              8  0
012900171220     d MCY65           s             18
013000171017     d trust           s              3  0
013100171017     d sub             s              3  0
013200171017     d acct            s              4  0
013300171017     d rec#            s              2  0
013400171017     d tyearn          s              4  0
013500171017     d thisyear        s              4  0
013600171018     d thirty#         s              8  0
013700171018     d in_date         s             32
013800171018     d in_format       s             32
013900171018     d out_format      s             32
014000220330     d out_date        s             32
014100220330     d top_date        s             32
014200171018     d out_error       s             10
014300171019     d csz             s             30
014400171019     d mcsz            s             25
014500210430     d wwseq#          s              2  0
014600171019     d hdseq#          s              2  0
014700171019     d md65mmdd        s              4  0
014800171220     d my65m           s              2  0
014900171220     d my65y           s              7  0
015000220425
015100220425     d actrst          s              3  0
015200220425     d acsub#          s              3  0
015300220425     d acacct          s              4  0
015400220425     d aname           s             45
015500220425     d directdial      s             20
015600220425     d firstmt1        s             75
015700220425     d firstmt2        s             75
015800220425     d mname           s             25
015900220425     d turning         s             30
016000220425     d wpemail         s             75
016100220425     d xxname          s             50
016200220425     d xxadr1          s             50
016300220425     d xxadr2          s             50
016400220425     d xxadr3          s             50
016500220425     D RTVMSGF         S             20A   inz
016600220425     d xline           s             75
016700171017
016800171220     d sql_stmt        s            512
016900220425
017000220425     D OutSpool        s             10a   inz
017100220425     D OutLetName      s             80a   inz
017200171017
017300171220     d fmtDate         pr                  extpgm('FMTDATE')
017400171018     d  in_date                      32    const
017500171018     d  in_format                    32    const
017600171018     d  out_format                   32    const
017700171018     d  out_date                     32    const
017800171018     d  out_error                    10    const
017900220425
018000220425       Dcl-S RtnMsg varchar(1000);
018100220425       Dcl-S Line01X varchar(200);
018200220425
018300220425       dcl-s d_Space Zoned(3:2) inz(.32);
018400220425       dcl-s s_Space Zoned(3:2) inz(.16);
018500220425
018600220425      //-------------------------------------------------------------------------
018700220425       //
018800220425       // Procedures
018900220425       //
019000220425      //-------------------------------------------------------------------------
019100220425
019200220425       Dcl-DS APIErrorCode Qualified;
019300220425         BytesProvided Int(10) INZ(%size(APIErrorCode));
019400220425         BytesAvailable Int(10) INZ(0);
019500220425         ExceptionID Char(7);
019600220425         Reserved Char(1);
019700220425         ExceptionData char(32767);
019800220425       END-DS;
019900220425
020000220425
020100220425
020200220425       Dcl-PR QMHRTVM ExtPgm;
020300220425         MsgInfo char(9999999) options(*varsize);
020400220425         MsgInfoLen Int(10) const;
020500220425         FormatName Char(8) const;
020600220425         MsgID char(7) const;
020700220425         MsgFileName char(20) const;
020800220425         ReplData char(10000) options(*varsize) const;
020900220425         ReplDataLen Int(10) const;
021000220425         ReplSubVal Char(10) const;
021100220425         ReplFormatChar Char(10) const;
021200220425         ErrorCode LikeDS(APIErrorCode);
021300220425
021400220425         // Option Group 1
021500220425         RetrieveOption Char(10) options(*nopass);
021600220425         CCSIdentifier Int(10) options(*nopass);
021700220425         CCSReplData Int(10) options(*nopass);
021800220425       END-PR;
021900220425
022000220425
022100220425
022200220425       // Message format data structures
022300220425       Dcl-DS RTVM0100 Qualified INZ;
022400220425         BytRtn Int(10);
022500220425         BytAvl Int(10);
022600220425         RtnMsgLen Int(10);
022700220425         RtnMsgAvl Int(10);
022800220425         RtnHlpLen Int(10);
022900220425         RtnHlpAvl Int(10);
023000220425         Buffer char(32767);
023100220425       END-DS;
023200130925
023300171017      //=======================================================================
023400171017    ? // mainline
023500171017      //=======================================================================
023600220425     C     *Entry        PLIST
023700220425     C                   parm                    UserID           10
023800220425     C                   parm                    Broker_copy       1
023900220425
024000220425         if  not %open(TURNLET65P);
024100220425         open TURNLET65P;
024200220425         endif;
024300130925
024400171017       exsr init;
024500171017       exsr main;
024600171017       exsr exit;
024700171017
024800171017      //=======================================================================
024900171017    ? // main
025000171017      //=======================================================================
025100130925
025200171017       begsr main;
025300171017
025400130925       //?If broker copy - sort by smancd then t/s/a.  Else sort by t/s/a
025500130925       sql_stmt = 'select rp15xwk.* from rp15xwk ' ;
025600130925       if broker_copy = 'Y' ;
025700130925        open rp15wwk ;
025800171019        sql_stmt = %trim(sql_stmt) + ' inner join acmunique on ' +
025900220425         'trustc = actrst and subc = acsub# and acctc = acacct ' +
026000171019         'order by smancd, trustc, subc, acctc' ;
026100130925       else ;
026200130925        sql_stmt = %trim(sql_stmt) + ' order by trustc, subc, acctc ' ;
026300130925       endif ;
026400130925
026500130925       sql_stmt = %trim(sql_stmt) + ' for fetch only ' ;
026600130925
026700130925       //?now prepare the variable sql stmt and open the cursor
026800130925       exec sql prepare p1 from :sql_stmt ;
026900130925       exec sql declare c1 cursor for p1  ;
027000130925       exec sql open c1 ;
027100130925
027200130925       //?fetch until eof...
027300130925       dou sqlcod <> *zeros ;
027400130925        exec sql fetch c1 into :rp15xwk ;
027500130925
027600130925        if sqlcod <> *zeros ;
027700130925         leave ;
027800130925        endif ;
027900130925
028000130925        trtrst = %int(trustc) ;
028100130925        chain trtrst trmunique ;
028200200113        if %found and tscode <> 'O N' or %found and tscode <> 'O M'
028300200113         or %found and tscode <> 'O D';
028400180109         exsr process ;
028500180109          if %open(rp15wwk) ;
028600180109           wsmancd = acm_smancd ;
028700180109          write rp15wr ;
028800180109         endif ;
028900180109        endif ;
029000130925       enddo ;
029100130925
029200130925       exec sql close c1 ;
029300130925       if %open (rp15wwk) ;
029400130925        close rp15wwk ;
029500130925       endif ;
029600130925
029700171017       endsr;
029800130925
029900130925       //-------------------------------------------------------------------
030000130925       //get_broker_rcd: get broker master record from SMANUNIQUE - we need
030100130925       //                the name and address
030200130925       //-------------------------------------------------------------------
030300130925       begsr get_broker_rcd ;
030400130925
030500171122        if acm_smancd <> *blanks ;
030600171122         chain acm_smancd smanunique ;
030700130925
030800171108         if %found ;
030900130925          wbname = %trim(sfname) + ' ' + %trim(slname) ;
031000130925          wbaddr1 = saddr ;
031100130925          wbcsz = %trim(scity) + ', ' + sstate +
031200130925                  '  ' + %subst(%editc(szipcd:'X'):1:5) ;
031300220405
031400220405           if broker_copy = 'Y' ;
031500220405          xxname = %trim(sfname) + ' ' + %trim(slname) ;
031600220405          xxadr1 = saddr ;
031700220405          xxadr2 = %trim(scity) + ', ' + sstate +
031800220405                  '  ' + %subst(%editc(szipcd:'X'):1:5) ;
031900220405          xxadr3 = *blanks;
032000220405           endif ;
032100220405
032200130925         endif ;
032300130925
032400130925        endif ;
032500130925
032600171122        actrst = acm_actrst;
032700171122        acsub# = acm_acsub#;
032800171122        acacct = acm_acacct;
032900171122
033000130925       endsr ;
033100130925
033200171018      //=======================================================================
033300171018      // process
033400171018      //=======================================================================
033500171018
033600171018       begsr process;
033700130925
033800220330        TodayN = %int(%char(%date : *iso0));
033900220330        in_date = %char(TodayN);
034000220330        fmtDate(in_date:'YYYYMMDD':'Mmmmmmmmmz DD, YYYY':out_date:out_error);
034100220330        top_date = %trim(out_date);
034200220330
034300171019        xmbssno = %editc(mbssno:'X');
034400171019
034500171019        exsr determMonth;
034600171018        reset cfssno;
034700171019        ssno6_ds = ssno3_DS;
034800171018        trust = %dec(trustc:3:0);
034900171018        sub = %dec(subc:3:0);
035000171018        acct = %dec(acctc:4:0);
035100171017
035200171019        chain (trust : sub : acct) acmunique;
035300171019        if %found;
035400171018         acname = ' ';
035500171020         acname = %trim(acm_acnam1) + ' ' + %trim(acm_acnam2);
035600171122         aaddr1 = acm_aaddr1;
035700171019         csz = %trim(acm_acity) + %trim(',') +  ' ' + %trim(acm_astate) +
035800171019               '  ' + %subst(%char(acm_azip):1:5);
035900171019
036000171018         vl1 = ' ';
036100171018         vl2 = ' ';
036200171019         if acm_aaddr2 = ' ';
036300171018          vl1 = csz;
036400171018          vl2 = ' ';
036500171018         else;
036600171019          vl1 = acm_aaddr2;
036700171018          vl2 = csz;
036800171018         endif;
036900171018
037000171019         if mmi <> ' ';
037100171020          relin1 = ' ';
037200171019          relin1 = %trim('RE:') + '  ' + %trim(mfname) + ' ' +
037300171019                   %trim(mmi) + %trim('. ') + ' ' + %trim(mlname) + '  ' +
037400171019                   %trim(cfssno);
037500171019         else;
037600171019          relin1 = %trim('RE:') + '  ' + %trim(mfname) + ' ' +
037700171019                    %trim(mlname) + '  ' + %trim(cfssno);
037800171019         endif;
037900171019
038000171019         md65mmdd = %int(%subst(%char(month65):5:4));
038100171019         my65m = %int(%subst(%char(month65):5:2));
038200171019         my65y = %int(%subst(%char(month65):1:4));
038300171019         mcy65 = %trim(%char(my65m)) + '/' + %trim(%char(my65y));
038400171020
038500171020         relin2 = ' ';
038600220330         // relin2 = '       ' + %trim(attmsg) + ' ' + %trim(tyear);
038700220330         relin2 = '        ' + %trim(attmsg);
038800171020         month65 = %dec( %char( %date(month65 : *iso) : *usa0) : 8 : 0);
038900171019
039000171020         relin3 = ' ';
039100220330         relin3 = '        ' + %trim(turning);
039200171018
039300171129         contac = acm_contac;
039400171020         dear = ' ';
039500171019         dear = %trim('Dear') + ' ' + %trim(acm_contac) + %trim(':');
039600171018
039700171019         chain mbssno member;
039800171019         if %found(MEMBER);
039900171020          memberno = %editc(mbssno:'X');
040000171019
040100171019          if mmi <> ' ';
040200171020           mname = ' ';
040300171019           mname = %trim(mfname) + ' ' + %trim(mmi) + %trim('. ') +
040400171019                   %trim(mlname);
040500171019          else;
040600171019           mname = %trim(mfname) + ' ' + %trim(mlname);
040700171019          endif;
040800171019
040900171020          mcsz = ' ';
041000210216          if zip > 0;
041100210216           mcsz = %trim(city) + %trim(',') +  ' ' + %trim(state) +
041200171019                 ' ' + %subst(%char(zip):1:5);
041300210216          else;
041400210216           mcsz = %trim(city) + %trim(',') +  ' ' + %trim(state);
041500210216          endif;
041600210727
041700210727         xxadr1 = *blanks;
041800210727         xxadr2 = *blanks;
041900210727         xxadr3 = *blanks;
042000210727         xxname = %trim(mname);
042100210727         xxadr1 = %trim(addr1);
042200210727          if   %trim(addr2) = *blanks;
042300210727         xxadr2 = %trim(mcsz);
042400210727          else;
042500210727         xxadr2 = %trim(addr2);
042600210727         xxadr3 = %trim(mcsz);
042700210727          endif;
042800210727
042900210216
043000171019         endif;
043100171019
043200171019        endif;
043300171019
043400171019        chain (acm_aacode : rec#) aaFile;
043500171019        if %found;
043600171018         aname = ' ';
043700171129          aname = %trim(afnam) + ' ' + %trim(alnam);
043800220425          directdial = %editw(addial:'0(   )&   -    ');
043900220330          wpemail = %trim(AEMLA);
044000171018        endif;
044100030320
044200220330        // acnam1 = acm_acnam1;
044300220330        WPNAM1 = acm_acnam1;
044400171122
044500171018        exsr get_broker_rcd;
044600220425
044700220425      * MSGF - TURNAGE02
044800220425       RTVMSGF = 'TURNAGE02 RPG_WORD  ';
044900171122
045000220405        if  Broker_copy <> 'A';
045100220425
045200220425       write HEADER1;
045300220425
045400220425       write HEADER2;
045500220425
045600220425       POS_X = 1.95;
045700220425
045800220425       Line01 = %trim(XXNAME);
045900220425       pos_x = pos_x + s_space;
046000220425       write Data;
046100220425
046200220425       Line01 = %trim(XXADR1);
046300220425       pos_x = pos_x + s_space;
046400220425       write Data;
046500220425
046600220425     C                   If        %trim(XXADR2) <> *Blanks
046700220425
046800220425       Line01 = %trim(XXADR2);
046900220425       pos_x = pos_x + s_space;
047000220425       write Data;
047100220425
047200220425       Line01 = %trim(XXADR3);
047300220425       pos_x = pos_x + s_space;
047400220425       write Data;
047500220425
047600220425     C                   Else
047700220425
047800220425       Line01 = %trim(XXADR3);
047900220425       pos_x = pos_x + s_space;
048000220425       write Data;
048100220425
048200220425     C                   End
048300220425
048400220425       Line01 =  *blanks;
048500220425       pos_x = pos_x + d_Space;
048600220425       write Data;
048700220425
048800220425       Line01 =  *blanks;
048900220425       pos_x = pos_x + d_Space;
049000220425       write Data;
049100220425
049200220405        endif;
049300220425
049400220425       write HEADER1;
049500220425
049600220425       write HEADER2;
049700220425
049800220425       Line01 = Top_Date;
049900220425       POS_X = 1.95;
050000220425       write Data;
050100220425
050200220425       Line01 =  *blanks;
050300220425       pos_x = pos_x + d_Space;
050400220425       write Data;
050500220425
050600220425       Line01 = %trim(ACNAME);
050700220425       pos_x = pos_x + s_space;
050800220425       write Data;
050900220425
051000220425       Line01 = %trim(AADDR1);
051100220425       pos_x = pos_x + s_space;
051200220425       write Data;
051300220425
051400220425       Line01 = %trim(VL1);
051500220425       pos_x = pos_x + s_space;
051600220425       write Data;
051700220425
051800220425       Line01 = %trim(VL2);
051900220425       pos_x = pos_x + s_space;
052000220425       write Data;
052100220425
052200220425       Line01 = 'Attention: ' + %trim(CONTAC);
052300220425       pos_x = pos_x + s_space;
052400220425       write Data;
052500220425
052600220425       Line01 =  *blanks;
052700220425       pos_x = pos_x + s_Space;
052800220425       write Data;
052900220425
053000220425       Line01 = %trim(RELIN1);
053100220425       pos_x = pos_x + s_space;
053200220425       write Data;
053300220425
053400220517       Line01 = RELIN2;
053500220425       pos_x = pos_x + s_space;
053600220425       write Data;
053700220425
053800220517       Line01 = RELIN3;
053900220425       pos_x = pos_x + s_space;
054000220425       write Data;
054100220425
054200220425       Line01 =  *blanks;
054300220425       pos_x = pos_x + s_Space;
054400220425       write Data;
054500220425
054600220425       Line01 = %trim(DEAR);
054700220425       pos_x = pos_x + s_space;
054800220425       write Data;
054900220425
055000220425       Line01 =  *blanks;
055100220425       pos_x = pos_x + s_Space;
055200220425       write Data;
055300220425
055400220425       write lethdol;
055500220425
055600220425       Line01 = getmessage('MSG0001');
055700220425       pos_x = pos_x + s_Space;
055800220425       write Data;
055900220425
056000220425       Line01 = getmessage('MSG0002');
056100220425       pos_x = pos_x + s_Space;
056200220425       write Data;
056300220425
056400220425       Line01 = getmessage('MSG0003');
056500220425       pos_x = pos_x + s_Space;
056600220425       write Data;
056700220425
056800220425       Line01 = getmessage('MSG0004');
056900220425       pos_x = pos_x + s_Space;
057000220425       write Data;
057100220425
057200220425       Line01 =  *blanks;
057300220425       pos_x = pos_x + s_Space;
057400220425       write Data;
057500220425
057600220425       Line01 = getmessage('MSG0005');
057700220425       pos_x = pos_x + s_Space;
057800220425       write Data;
057900220425
058000220425       Line01 = getmessage('MSG0006');
058100220425       pos_x = pos_x + s_Space;
058200220425       write Data;
058300220425
058400220425       Line01 =  *blanks;
058500220425       pos_x = pos_x + s_Space;
058600220425       write Data;
058700220425
058800220425       Line01 = getmessage('MSG0007');
058900220425       pos_x = pos_x + s_Space;
059000220425       write Data;
059100220425
059200220425       Line01 = getmessage('MSG0008');
059300220425       pos_x = pos_x + s_Space;
059400220425       write Data;
059500220425
059600220425       Line01 = getmessage('MSG0009');
059700220425       pos_x = pos_x + s_Space;
059800220425       write Data;
059900220425
060000220425       Line01 =  *blanks;
060100220425       pos_x = pos_x + s_Space;
060200220425       write Data;
060300220425
060400220425       Line01 = getmessage('MSG0010');
060500220425       pos_x = pos_x + s_Space;
060600220425       write Bold;
060700220425
060800220425       Line01 =  *blanks;
060900220425       pos_x = pos_x + s_Space;
061000220425       write Data;
061100220425
061200220425       Line01 = getmessage('MSG0011');
061300220425       pos_x = pos_x + s_Space;
061400220425       write Bold;
061500220425
061600220425       Line01 = getmessage('MSG0012');
061700220425       pos_x = pos_x + s_Space;
061800220425       write Bold;
061900220425
062000220425       Line01 =  *blanks;
062100220425       pos_x = pos_x + s_Space;
062200220425       write Data;
062300220425
062400220425       Line01 = getmessage('MSG0013');
062500220425       pos_x = pos_x + s_Space;
062600220425       write Data;
062700220425
062800220425       Line01 = getmessage('MSG0014');
062900220425       pos_x = pos_x + s_Space;
063000220425       write Data;
063100220425
063200220425       Line01 = getmessage('MSG0015');
063300220425       pos_x = pos_x + s_Space;
063400220425       write Data;
063500220425
063600220425       Line01 =  *blanks;
063700220425       pos_x = pos_x + s_Space;
063800220425       write Data;
063900220425
064000220425       Line01 = getmessage('MSG0016');
064100220425       pos_x = pos_x + s_Space;
064200220425       write Bold;
064300220425
064400220425       Line01 =  *blanks;
064500220425       pos_x = pos_x + s_Space;
064600220425       write Data;
064700220425
064800220425       Line01 = getmessage('MSG0017');
064900220425       Line01 = %ScanRpl( '@A' : %trim(FIRSTMT1) : Line01);
065000220425       pos_x = pos_x + s_Space;
065100220425       write Data;
065200220425
065300220425       Line01 =  *blanks;
065400220425       pos_x = pos_x + s_Space;
065500220425       write Data;
065600220425
065700220517       // Per Shelly 05.17.2022 - omit this sentence
065800220517       // Line01 = getmessage('MSG0018');
065900220517       // pos_x = pos_x + s_Space;
066000220517       // write Bold;
066100220425
066200220517       // Line01 = getmessage('MSG0019');
066300220517       // pos_x = pos_x + s_Space;
066400220517       // write Bold;
066500220425
066600220425       write HEADER1;
066700220425
066800220425       Line01 = *blanks;
066900220425       POS_X = 0.95;
067000220425       write Data;
067100220425
067200220425       Line01 = getmessage('MSG0020');
067300220425       pos_x = pos_x + s_Space;
067400220425       write Bold;
067500220425
067600220425       Line01 = getmessage('MSG0021');
067700220425       pos_x = pos_x + s_Space;
067800220425       write Bold;
067900220425
068000220425       Line01 =  *blanks;
068100220425       pos_x = pos_x + s_Space;
068200220425       write Data;
068300220425
068400220425       Line01 = getmessage('MSG0022');
068500220425       pos_x = pos_x + s_Space;
068600220425       write Data;
068700220425
068800220425       Xline  = getmessage('MSG0023');
068900220425       Line01 = getmessage('MSG0024');
069000220425       Line01 = %trim(Xline) + ' ' + %trim(Line01);
069100220425       pos_x = pos_x + s_Space;
069200220425       write Data;
069300220425
069400220425       Line01 =  *blanks;
069500220425       pos_x = pos_x + s_Space;
069600220425       write Data;
069700220425
069800220425       Line01 = getmessage('MSG0025');
069900220425       pos_x = pos_x + s_Space;
070000220425       write Bold;
070100220425
070200220425       Line01 =  *blanks;
070300220425       pos_x = pos_x + s_Space;
070400220425       write Data;
070500220425
070600220425       Line01 = getmessage('MSG0026');
070700220425       pos_x = pos_x + s_Space;
070800220425       write Data;
070900220425
071000220425       Line01 = getmessage('MSG0027');
071100220425       pos_x = pos_x + s_Space;
071200220425       write Data;
071300220425
071400220425       Line01 =  *blanks;
071500220425       pos_x = pos_x + s_Space;
071600220425       write Data;
071700220425
071800220425       Line01 = getmessage('MSG0028');
071900220425       Line01 = %ScanRpl( '@B' : %trim(FIRSTMT1) : Line01);
072000220425       pos_x = pos_x + s_Space;
072100220425       write Data;
072200220425
072300220425       Line01 =  *blanks;
072400220425       pos_x = pos_x + s_Space;
072500220425       write Data;
072600220425
072700220425       Line01 = getmessage('MSG0029');
072800220425       pos_x = pos_x + s_Space;
072900220425       write Bold;
073000220425
073100220425       Line01 = getmessage('MSG0030');
073200220425       Line01 = %ScanRpl( '@C' : %trim(DIRECTDIAL) : Line01);
073300220425       Line01 = %ScanRpl( '@D' : %trim(WPEMAIL) : Line01);
073400220425       pos_x = pos_x + s_Space;
073500220425       write Bold;
073600220425
073700220425       Line01 =  *blanks;
073800220425       pos_x = pos_x + s_Space;
073900220425       write Data;
074000220425
074100220425       Line01 = getmessage('MSG0031');
074200220425       pos_x = pos_x + s_Space;
074300220425       write Bold;
074400220425
074500220425       Line01 =  *blanks;
074600220425       pos_x = pos_x + s_Space;
074700220425       write Data;
074800220425
074900220425       Line01 =  %trim(ANAME);
075000220425       pos_x = pos_x + s_Space;
075100220425       write Data;
075200220425
075300220425       Line01 =  'Account Administrator';
075400220425       pos_x = pos_x + s_Space;
075500220425       write Data;
075600220425
075700220425       Line01 =  *blanks;
075800220425       pos_x = pos_x + s_Space;
075900220425       write Data;
076000220425
076100220425       Line01 = 'Account No: ' + %editc(ACTRST:'X') + '-' +
076200220425                %editc(ACSUB#:'X') + '-' +  %editc(ACACCT:'X');
076300220425       pos_x = pos_x + s_Space;
076400220425       write Data;
076500220425
076600220425       Line01 =  *blanks;
076700220425       pos_x = pos_x + s_Space;
076800220425       write Data;
076900220425
077000220425       Line01 =  'Enclosure';
077100220425       pos_x = pos_x + s_Space;
077200220425       write Data;
077300220425
077400220425       Line01 =  *blanks;
077500220425       pos_x = pos_x + s_Space;
077600220425       write Data;
077700220425
077800220517     C                   select
077900220517     C                   when      broker_copy = ' '
078000220517
078100220517       Line01 =  'cc: ' + %trim(ACNAME);
078200220517       pos_x = pos_x + s_Space;
078300220517       write Data;
078400220517
078500220517       Line01 =  '      ' + %trim(WBNAME);
078600220517       pos_x = pos_x + s_Space;
078700220517       write Data;
078800220517
078900220517     C                   when      broker_copy = 'A'
079000220517
079100220517       Line01 =  'cc: ' + %trim(WBNAME);
079200220517       pos_x = pos_x + s_Space;
079300220517       write Data;
079400220517
079500220517       Line01 =  '      ' + %trim(CONTAC);
079600220517       pos_x = pos_x + s_Space;
079700220517       write Data;
079800220517     C                   when      broker_copy = 'Y'
079900220517
080000220517       Line01 =  'cc: ' + %trim(ACNAME);
080100220517       pos_x = pos_x + s_Space;
080200220517       write Data;
080300220517
080400220517       Line01 =  '      ' + %trim(CONTAC);
080500220517       pos_x = pos_x + s_Space;
080600220517       write Data;
080700220517
080800220517     C                   endsl
080900220425
081000220517       // Line01 =  '     ' + %trim(WBADDR1);
081100220517       // pos_x = pos_x + s_Space;
081200220517       // write Data;
081300220425
081400220517       // Line01 =  '     ' + %trim(WBCSZ);
081500220517       // pos_x = pos_x + s_Space;
081600220517       // write Data;
081700220425
081800220425       write FORM01R;
081900220425
082000220425       Line01 =  *blanks;
082100220425       POS_X = 2.95;
082200220425       write Data;
082300220425
082400220425       Line01 = *blanks;
082500220425       pos_x = pos_x + d_Space;
082600220425       write Data;
082700220425
082800220425       COL01 = getmessage('MSG0032');
082900220425       COL02 = %trim(WPNAM1);
083000220425       COL03 = getmessage('MSG0033');
083100220425       COL04 = %editc(ACTRST:'X') + %editc(ACSUB#:'X') + %editc(ACACCT:'X');
083200220425       write FormData;
083300220425
083400220425       Line01 =  *blanks;
083500220425       pos_x = pos_x + s_Space;
083600220425       write Data;
083700220425
083800220425       COL01 = getmessage('MSG0034');
083900220425       COL02 = %trim(MNAME);
084000220425       COL03 = *blanks;
084100220425       COL04 = *blanks;
084200220425       write FormData;
084300220425
084400220425       Line01 =  *blanks;
084500220425       pos_x = pos_x + s_Space;
084600220425       write Data;
084700220425
084800220425       COL01 = getmessage('MSG0035');
084900220425       COL02 = %trim(CFSSNO);
085000220425       COL03 = *blanks;
085100220425       COL04 = *blanks;
085200220425       write FormData;
085300220425
085400220425       Line01 =  *blanks;
085500220425       write Data;
085600220425
085700220517       COL01A = getmessage('MSG0036');
085800220517       COL02A = %trim(TURNING);
085900220517       COL03A = getmessage('MSG0037');
086000220517       write FormData1;
086100220425
086200220517       Line01 = getmessage('MSG0073');
086300220425       pos_x = pos_x + s_Space;
086400220425       write Bold;
086500220517
086600220517       Line01 =  *blanks;
086700220517       pos_x = pos_x + s_Space;
086800220517       write Data;
086900220517
087000220517       Line01 = getmessage('MSG0038');
087100220517       pos_x = pos_x + s_Space;
087200220517       write Bold;
087300220425
087400220425       Line01 =  *blanks;
087500220425       pos_x = pos_x + s_Space;
087600220425       write Data;
087700220425
087800220425       Line01 = getmessage('MSG0039');
087900220425       pos_x = pos_x + s_Space;
088000220425       write Data;
088100220425
088200220425       Line01 = getmessage('MSG0040');
088300220425       pos_x = pos_x + s_Space;
088400220425       write Data;
088500220425
088600220425       Line01 = getmessage('MSG0041');
088700220425       pos_x = pos_x + s_Space;
088800220425       write Data;
088900220425
089000220425       Line01 = getmessage('MSG0042');
089100220425       pos_x = pos_x + s_Space;
089200220425       write Data;
089300220425
089400220425       Line01 =  *blanks;
089500220425       pos_x = pos_x + s_Space;
089600220425       write Data;
089700220425
089800220425       Line01 = getmessage('MSG0043');
089900220425       pos_x = pos_x + s_Space;
090000220425       write Bold;
090100220425
090200220425       Line01 =  *blanks;
090300220425       pos_x = pos_x + s_Space;
090400220425       write Data;
090500220425
090600220425       Line01 = getmessage('MSG0044');
090700220425       pos_x = pos_x + s_Space;
090800220425       write Data;
090900220425
091000220425       Line01 = getmessage('MSG0045');
091100220425       pos_x = pos_x + s_Space;
091200220425       write Data;
091300220425
091400220425       Line01 = getmessage('MSG0046');
091500220425       pos_x = pos_x + s_Space;
091600220425       write Data;
091700220425
091800220425       Line01 =  *blanks;
091900220425       pos_x = pos_x + s_Space;
092000220425       write Data;
092100220425
092200220425       Line01 = getmessage('MSG0047');
092300220425       pos_x = pos_x + s_Space;
092400220425       write Data;
092500220425
092600220425       Line01 =  *blanks;
092700220425       pos_x = pos_x + s_Space;
092800220425       write Data;
092900220425
093000220425       Line01 = getmessage('MSG0072');
093100220425       pos_x = pos_x + s_Space;
093200220425       write Bold;
093300220425
093400220425       Line01 =  *blanks;
093500220425       pos_x = pos_x + s_Space;
093600220425       write Data;
093700220425
093800220425       Line01 = getmessage('MSG0048');
093900220425       pos_x = pos_x + s_Space;
094000220425       write Bold;
094100220425
094200220425       Line01 =  *blanks;
094300220425       pos_x = pos_x + s_Space;
094400220425       write Data;
094500220425
094600220425       Line01 = getmessage('MSG0049');
094700220425       pos_x = pos_x + s_Space;
094800220425       write Data;
094900220425
095000220425       Line01 = getmessage('MSG0050');
095100220425       pos_x = pos_x + s_Space;
095200220425       write Data;
095300220425
095400220425       Line01 = getmessage('MSG0051');
095500220425       pos_x = pos_x + s_Space;
095600220425       write Data;
095700220425
095800220425       Line01 = getmessage('MSG0052');
095900220425       pos_x = pos_x + s_Space;
096000220425       write Data;
096100220425
096200220425       Line01 =  *blanks;
096300220425       pos_x = pos_x + s_Space;
096400220425       write Data;
096500220425
096600220425       Line01 = getmessage('MSG0053');
096700220425       pos_x = pos_x + s_Space;
096800220425       write Bold;
096900220425
097000220425       Line01 =  *blanks;
097100220425       pos_x = pos_x + s_Space;
097200220425       write Data;
097300220425
097400220425       Line01 = getmessage('MSG0054');
097500220425       pos_x = pos_x + s_Space;
097600220425       write Data;
097700220425
097800220425       Line01 = getmessage('MSG0055');
097900220425       pos_x = pos_x + s_Space;
098000220425       write Data;
098100220425
098200220425       Line01 = getmessage('MSG0056');
098300220425       pos_x = pos_x + s_Space;
098400220425       write Data;
098500220425
098600220425       Line01 =  *blanks;
098700220425       pos_x = pos_x + s_Space;
098800220425       write Data;
098900220425
099000220425       Line01 = getmessage('MSG0057');
099100220425       pos_x = pos_x + s_Space;
099200220425       write Bold;
099300220425
099400220425       Line01 = getmessage('MSG0058');
099500220425       pos_x = pos_x + s_Space;
099600220425       write Bold;
099700220425
099800220425       Line01 =  *blanks;
099900220425       pos_x = pos_x + s_Space;
100000220425       write Data;
100100220518
100200220518       Line01 = getmessage('MSG0074');
100300220518       pos_x = pos_x + 0.5;
100400220518       pos_x = pos_x + s_Space;
100500220518       write Bold;
100600220518
100700220518       Line01 = getmessage('MSG0075');
100800220518       pos_x = pos_x + s_Space;
100900220518       write Bold;
101000220425
101100220518       // write SIGNR;
101200220425
101300220425       write FORM02R;
101400220425
101500220425       Line01 =  *blanks;
101600220425       POS_X = 2.95;
101700220425       write Data;
101800220425
101900220425       Line01 =  *blanks;
102000220425       pos_x = pos_x + s_Space;
102100220425       write Data;
102200220425
102300220425       COL01 = getmessage('MSG0032');
102400220425       COL02 = %trim(WPNAM1);
102500220425       COL03 = getmessage('MSG0033');
102600220425       COL04 = %editc(ACTRST:'X') + %editc(ACSUB#:'X') + %editc(ACACCT:'X');
102700220425       write FormData;
102800220425
102900220425       Line01 =  *blanks;
103000220425       pos_x = pos_x + s_Space;
103100220425       write Data;
103200220425
103300220425       COL01 = getmessage('MSG0034');
103400220425       COL02 = %trim(MNAME);
103500220425       COL03 = *blanks;
103600220425       COL04 = *blanks;
103700220425       write FormData;
103800220425
103900220425       Line01 =  *blanks;
104000220425       pos_x = pos_x + s_Space;
104100220425       write Data;
104200220425
104300220425       COL01 = getmessage('MSG0035');
104400220425       COL02 = %trim(CFSSNO);
104500220425       COL03 = *blanks;
104600220425       COL04 = *blanks;
104700220425       write FormData;
104800220425
104900220425       Line01 =  *blanks;
105000220425       pos_x = pos_x + s_Space;
105100220425       write Data;
105200220517
105300220517       COL01A = getmessage('MSG0036');
105400220517       COL02A = %trim(TURNING);
105500220517       COL03A = getmessage('MSG0037');
105600220517       write FormData1;
105700220517
105800220517       Line01 = getmessage('MSG0073');
105900220517       pos_x = pos_x + s_Space;
106000220517       write Bold;
106100220517
106200220517       Line01 =  *blanks;
106300220517       pos_x = pos_x + s_Space;
106400220517       write Data;
106500220425
106600220425       Line01 = getmessage('MSG0059');
106700220425       pos_x = pos_x + s_Space;
106800220425       write Bold;
106900220425
107000220425       Line01 =  *blanks;
107100220425       pos_x = pos_x + s_Space;
107200220425       write Data;
107300220425
107400220425       Line01 = getmessage('MSG0060');
107500220425       pos_x = pos_x + s_Space;
107600220425       write Data;
107700220425
107800220425       Line01 = getmessage('MSG0061');
107900220425       pos_x = pos_x + s_Space;
108000220425       write Data;
108100220425
108200220425       Line01 =  *blanks;
108300220425       pos_x = pos_x + s_Space;
108400220425       write Data;
108500220425
108600220425       Line01 = getmessage('MSG0062');
108700220425       pos_x = pos_x + s_Space;
108800220425       write Bold;
108900220425
109000220425       Line01 =  *blanks;
109100220425       pos_x = pos_x + s_Space;
109200220425       write Data;
109300220425
109400220425       Line01 = getmessage('MSG0063');
109500220425       pos_x = pos_x + s_Space;
109600220425       write Data;
109700220425
109800220425       Line01 = getmessage('MSG0064');
109900220425       pos_x = pos_x + s_Space;
110000220425       write Data;
110100220425
110200220425       Line01 = getmessage('MSG0065');
110300220425       pos_x = pos_x + s_Space;
110400220425       write Data;
110500220425
110600220425       Line01 =  *blanks;
110700220425       pos_x = pos_x + s_Space;
110800220425       write Data;
110900220425
111000220425       Line01 = getmessage('MSG0072');
111100220425       pos_x = pos_x + s_Space;
111200220425       write Bold;
111300220425
111400220425       Line01 =  *blanks;
111500220425       pos_x = pos_x + s_Space;
111600220425       write Data;
111700220425
111800220425       Line01 = getmessage('MSG0066');
111900220425       pos_x = pos_x + s_Space;
112000220425       write Bold;
112100220425
112200220425       Line01 =  *blanks;
112300220425       pos_x = pos_x + s_Space;
112400220425       write Data;
112500220425
112600220425       Line01 = getmessage('MSG0067');
112700220425       pos_x = pos_x + s_Space;
112800220425       write Data;
112900220425
113000220425       Line01 = getmessage('MSG0068');
113100220425       pos_x = pos_x + s_Space;
113200220425       write Data;
113300220425
113400220425       Line01 =  *blanks;
113500220425       pos_x = pos_x + s_Space;
113600220425       write Data;
113700220425
113800220425       Line01 = getmessage('MSG0069');
113900220425       pos_x = pos_x + s_Space;
114000220425       write Bold;
114100220425
114200220425       Line01 =  *blanks;
114300220425       pos_x = pos_x + s_Space;
114400220425       write Data;
114500220425
114600220425       Line01 = getmessage('MSG0070');
114700220425       pos_x = pos_x + s_Space;
114800220425       write Data;
114900220425
115000220425       Line01 = getmessage('MSG0071');
115100220425       pos_x = pos_x + s_Space;
115200220425       write Data;
115300220425
115400220425       Line01 =  *blanks;
115500220425       pos_x = pos_x + s_Space;
115600220425       write Data;
115700220425
115800220425       Line01 = getmessage('MSG0057');
115900220425       pos_x = pos_x + s_Space;
116000220425       write Bold;
116100220425
116200220425       Line01 = getmessage('MSG0058');
116300220425       pos_x = pos_x + s_Space;
116400220425       write Bold;
116500220425
116600220425       Line01 =  *blanks;
116700220425       pos_x = pos_x + s_Space;
116800220425       write Data;
116900220518
117000220518       Line01 = getmessage('MSG0074');
117100220518       pos_x = pos_x + 1.5;
117200220518       pos_x = pos_x + s_Space;
117300220518       write Bold;
117400220518
117500220518       Line01 = getmessage('MSG0075');
117600220518       pos_x = pos_x + s_Space;
117700220518       write Bold;
117800220518
117900220518       // write SIGNR;
118000131017
118100171020        month65 = %dec( %char( %date(month65 : *usa) : *iso0) : 8 : 0);
118200171018        hstrst = mbtrst;
118300171018        hssub# = mbsub#;
118400171018        hsacct = mbacct;
118500171020
118600171020        covtdt = month65;
118700220520
118800220520     C                   select
118900220520     C                   when      broker_copy = ' '
119000220520     C                   eval      NOTE2 = 'EMPLOYEE'
119100220520     C                   when      broker_copy = 'A'
119200220520     C                   eval      NOTE2 = 'ACCOUNT '
119300220520     C                   when      broker_copy = 'Y'
119400220520     C                   eval      NOTE2 = 'BROKER  '
119500220520     C                   endsl
119600220520
119700171019        write histr;
119800131017
119900171019       endsr;
120000171018
120100171018      //=======================================================================
120200171018    ? // Determine if it's the member or the dependent turning 65.
120300171018      //=======================================================================
120400171018
120500171019       begsr determMonth;
120600030320
120700171019        turning = ' ';
120800171019        if dbirth <> 0;
120900210430         exsr finddseq#;
121000171019          month65 = %dec( %char( %date(dbirth : *iso) : *usa0) : 8 : 0);
121100171019
121200171019         if dmi <> ' ';
121300171019          turning = %trim(dfname) + ' ' + %trim(dmi) + %trim('. ') + ' ' +
121400171019                   %trim(dlname);
121500171019         else;
121600171019          turning = %trim(dfname) + ' ' + %trim(dlname);
121700171019         endif;
121800171019
121900171019         ck#not = turmsg + ' ' + %trim(dfname) + ' ' + %trim(dlname);
122000171019
122100171019        else;
122200171019         hdseq# = 0;
122300171019         month65 = %dec( %char( %date(birth : *iso) : *usa0) : 8 : 0);
122400171019         if mmi <> ' ';
122500220330         // turning = %trim(mfname) + ' ' + %trim(mmi) + %trim('. ') + ' ' +
122600220330         //        %trim(mlname);
122700171019         else;
122800220330         // turning = %trim(mfname) + ' ' + %trim(mlname);
122900171019         endif;
123000171019
123100171115         ck#not = turmsg + ' ' + %trim(mfname) + ' ' + %trim(mlname);
123200171019        endif;
123300171019
123400171019        m65dd = 1;
123500180115        m65ccyy = %subdt(%date:*YEARS);
123600180115        //m65ccyy = %dec(%subst(%char(wdate8):5:4):4:0);
123700171018
123800171019      // Determine if date is past.  If so use thirty-days date...
123900171019        if month65 < DSCompDate;
124000171023         in_date = %editc(thirty#:'X');
124100171019        else;
124200171023         in_date = %editc(month65:'X');
124300171019        endif;
124400171018
124500171018        fmtDate(in_date:'MMDDYYYY':'Mmmmmmmmmz DD, YYYY':out_date:out_error);
124600171019        FirstMT1 = %trim(out_Date);
124700171019        FirstMT2 = %trim(out_Date);
124800171018
124900171019        month65 = %dec( %char( %date(month65 : *usa) : *iso0) : 8 : 0);
125000171019        turning = %trim(turning);
125100171018
125200171019       endsr;
125300210430
125400210430      //=======================================================================
125500210430    ? // Determine dependent sequence.
125600210430      //=======================================================================
125700210430
125800210430       begsr finddseq#;
125900210430
126000210430         WWSEQ# = 0;
126100210430         setll mbssno depend;
126200210430         reade mbssno depend;
126300210430         dow   not %eof(depend);
126400210430
126500210430         if    %trim(DLNAME) = %trim(J_DLNAME) and
126600210430               %trim(DFNAME) = %trim(J_DFNAME) and
126700210430               %trim(DMI) = %trim(J_DMI)       and
126800210430               %trim(DRELCD) = %trim(J_DRELCD) and
126900210430               DBIRTH = J_DBIRTH;
127000210430          WWSEQ# = J_DPSEQ#;
127100210430          Leave;
127200210430        endif;
127300210430
127400210430         reade mbssno depend;
127500210430         enddo;
127600210430
127700210430         hdseq# = wwseq#;
127800210430
127900210430       endsr;
128000171018
128100171017      //=======================================================================
128200171017      // exit
128300171017      //=======================================================================
128400171017
128500171017       begsr exit;
128600210817
128700220425         if  %open(TURNLET65P);
128800220425         close TURNLET65P;
128900220425
129000210817     C                   time                    clockn
129100210817     C                   eval      TodayN = %int(%char(%date : *iso0))
129200220425     C                   eval      outSpool = 'TURNLET65P'
129300220405     C                   select
129400220405     C                   when      broker_copy = 'Y'
129500220427     C                   eval      outLetName = 'EE_DEP_TURNING_AGE_65_BROKER_'
129600220330     C                   eval      outLetName = %trim(outLetName)
129700220405     C                   when      broker_copy = ' '
129800220427     C                   eval      outLetName = 'EE_DEP_TURNING_AGE_65_' +
129900220427     C                                          'EMPLOYEE_'
130000220330     C                   eval      outLetName = %trim(outLetName)
130100220405     C                   when      broker_copy = 'A'
130200220427     C                   eval      outLetName = 'EE_DEP_TURNING_AGE_65_ACCOUNT_'
130300220405     C                   eval      outLetName = %trim(outLetName)
130400220405     C                   endsl
130500210817     C                   eval      outLetName = %trim(outLetName) +
130600220427     C                             %trim(WQUSRN) + '_' +
130700210817     C                             TodayA + '_' + clockA + '.pdf'
130800210817
130900210817     C                   call      'CRTPDFIFSC'
131000210817     C                   parm                    OutSpool         10
131100210817     C                   parm                    OutLetName       80
131200210817         endif;
131300171017
131400171017        *inlr = '1';
131500171017        return;
131600171017
131700171017       endsr;
131800171017
131900171017      //=======================================================================
132000171017    ? // init
132100171017      //=======================================================================
132200171017
132300171019       begsr init;
132400180115
132500171017        tyearn = %dec(tyear:4:0);
132600030320
132700171017        wdate8 = %dec(%date);
132800171018        wwdate = %dec(%date);
132900171018        wddate1 = %date;
133000171017        thisyear = %dec(%subst(%char(wdate8):1:4):4:0);
133100171017        wdate8 = %dec( %char( %date(wdate8 : *iso) : *usa0) : 8 : 0);
133200171017        trdate = %dec(%date);
133300171017
133400171018        in_date = %char(wdate8);
133500171018        fmtDate(in_date:'MMDDYYYY':'Mmmmmmmmmz DD, YYYY':out_date:out_error);
133600171018        tdate = %trim(out_Date);
133700171018
133800180115        dsdate8 = %editc(wdate8:'X');
133900171023        dsdd = dsdd8;
134000171023        dsmm = dsmm8;
134100171023        cc = cc8;
134200171023        dsyy = dsyy8;
134300171018        thirty# = %dec( (wddate1 + %days(30))  : *usa);
134400171017
134500171017        trcode = 'U37';
134600171017        hprgnm = wqpgmn;
134700171017        hsdltd = 'A';
134800171017        hoper = userid;
134900171017        hstrtime = %time();
135000171017
135100171017       endsr;
135200171017
135300171017      //=======================================================================
135400220425       // ----------------------------------------------------------------
135500220425       dcl-proc GetMessage export;
135600220425
135700220425         dcl-pi *n char(125) ;
135800220425           inLine char(7) value ;
135900220425         end-pi ;
136000220425
136100220425
136200220425         QMHRTVM( RTVM0100 :%SIZE(RTVM0100):'RTVM0100'
136300220425           :inLIne
136400220425           :RTVMSGF :'' :0 :'*NO' :'*NO'
136500220425           : APIErrorCode );
136600220425
136700220425
136800220425         RtnMsg = %subst( RTVM0100.Buffer
136900220425           : 1
137000220425           : RTVM0100.RtnMsgLen);
137100220425
137200220425         Return RtnMsg;
137300220425
137400220425
137500220425       end-proc;
137600220425
137700220425       // ----------------------------------------------------------------
137800220425       dcl-proc GetHeader export;
137900220425
138000220425         dcl-pi *n char(125) ;
138100220425           inLine char(7) value ;
138200220425         end-pi ;
138300220425
138400220425
138500220425         QMHRTVM( RTVM0100 :%SIZE(RTVM0100):'RTVM0100'
138600220425           :inLIne
138700220425           :'SDENHEADERRPG_WORD  ' :'' :0 :'*NO' :'*NO'
138800220425           : APIErrorCode );
138900220425
139000220425
139100220425         RtnMsg = %subst( RTVM0100.Buffer
139200220425           : 1
139300220425           : RTVM0100.RtnMsgLen);
139400220425
139500220425         Return RtnMsg;
139600220425
139700220425
139800220425       end-proc;
139900220425
