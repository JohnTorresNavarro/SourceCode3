000100230206          Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200230206                           DftActGrp(*no)
000300230206                           bnddir('GBSBDIR' )   ;
000400230206
000500000000      *_________________________________________________________________________
000600000000      *
000700000000      *  Description:  Print OLE Forms by AA
000800000000      *
000900000000      *  (c)Copyright 2023 by Innovative Outsourcing, Inc.
001000000000      *
001100000000      *    Created by:  JALLEN - February 06, 2023
001200230901      *
001300230901      *   09.01.2023 - Add EDT(5) - Jon Allen
001400230901      *
001500231020      *   10.20.2023 - Change Sort Order to be by TSA, AACOLOR
001600231020      *              - L1 by FOACCNBR, AACOLOR, Select FOCRTDT = 0
001700000000      *_________________________________________________________________________
001800231020       Dcl-f oeforml1 usage(*input : *update) keyed;
001900230428
002000230428       dcl-f oeformbatp usage( *input : *output ) ;
002100230428
002200230428       dcl-s Envir  Char(10);
002300230428       dcl-s FileNamePDF Char(100);
002400230428       dcl-c q '''';
002500230428
002600230428       dcl-s LinkB  Char(32766);
002700230428       dcl-s LinkO  Char(32766);
002800230428       dcl-s LinkR  Char(32766);
002900230428       dcl-s LinkP  Char(32766);
003000230428       dcl-s LinkY  Char(32766);
003100231007       dcl-s LinkE  Char(32766);
003200231007       dcl-s LinkOTHER Char(32766);
003300230428
003400230428       dcl-s w80date Zoned(8);
003500230428       dcl-s w80dateUSA Zoned(8);
003600230428       dcl-s w80dateCHAR char(8);
003700230626
003800230626       dcl-s wRed    Zoned(3);
003900230626       dcl-s wBlu    Zoned(3);
004000230626       dcl-s wYel    Zoned(3);
004100230626       dcl-s wOrg    Zoned(3);
004200230901       dcl-s wPur    Zoned(3);
004300231007       dcl-s wEDT    Zoned(3);
004400231007       dcl-s wOTHER  Zoned(3);
004500230626
004600230626       dcl-s wR      Zoned(2);
004700230626       dcl-s wB      Zoned(2);
004800230626       dcl-s wY      Zoned(2);
004900230626       dcl-s wO      Zoned(2);
005000230901       dcl-s wP      Zoned(2);
005100231007       dcl-s wE      Zoned(2);
005200231007       dcl-s wOTH    Zoned(2);
005300230428
005400230428       dcl-ds pgmd
005500230428         ExtName('IOPGMD') PSDS;
005600230428         @pgmq *proc;
005700230428       end-ds;
005800230428
005900230428      *-------------------------------------------------------------------------
006000230428      *
006100230428      * *Entry Procedure
006200230428      *
006300230428      *-------------------------------------------------------------------------
006400230428       Dcl-pr Main ExtPgm;
006500230428         *N  Char(1);
006600230428       End-Pr;
006700230428
006800230428       dcl-pi Main;
006900230428         RunFlag  Char(1);
007000230428       End-Pi;
007100230428
007200230428      *-------------------------------------------------------------------------
007300231007      * Process only 0 dates, these 0 dates get updated in the
007400231007      * Batch Generate program PRTOLEFRM2.
007500231007      *-------------------------------------------------------------------------
007600231007                w80date = 0;
007700231007
007800230428                w80dateUSA = %int(%char(%date : *usa0));
007900230428                w80dateCHAR = %editc(w80dateUSA : 'X');
008000230428
008100230428                select;
008200230428                when   %trim(RunFlag) = '1';
008300230428                ENVIR = 'BETA';
008400230428                when   %trim(RunFlag) = '2';
008500230428                ENVIR = 'DASHBOARD';
008600230428                when   %trim(RunFlag) = '3';
008700230601                ENVIR = 'NON-PAYROLL';
008800230428                when   %trim(RunFlag) = '4';
008900230601                ENVIR = 'PAYROLL';
009000230901                when   %trim(RunFlag) = '5';
009100230901                ENVIR = 'EDT';
009200230428                endsl;
009300230428
009400230626                wRed = 0;
009500230626                wBlu = 0;
009600230626                wOrg = 0;
009700230626                wYel = 0;
009800230626                wPur = 0;
009900231007                wEDT = 0;
010000231007                wOTHER = 0;
010100230626
010200230626                wR = 0;
010300230626                wB = 0;
010400230626                wO = 0;
010500230626                wY = 0;
010600230901                wP = 0;
010700231007                wE = 0;
010800231007                wOTH = 0;
010900230428
011000231020                setll (*loval) oeforml1;
011100231020                read  oeforml1;
011200231020                dow not %eof(oeforml1);
011300231009
011400231009      * skip trans history
011500231009                if %trim(FOCRTBY) <> 'X';
011600230428
011700230428                select;
011800230906                when     %trim(AACOLOR) = 'BLUE' and
011900230906                         %trim(RunFlag) <> '5';
012000230428                If        %trim(LinkB) = *blanks;
012100230428                linkB = %trim(linkB) + %trim(FOSSID);
012200230626                wBlu = wBlu+1;
012300231007                FOCRTBY = 'PRTOLEFRM2';
012400231007                FOCRTDT = %int(%char(%date : *iso0));
012500231007                FOCRTTM = %Dec(%Time);
012600231007                update OE_FORMR;
012700230428                else;
012800230428                linkB = %trim(linkB) + '|' + %trim(FOSSID);
012900230626                wBlu = wBlu+1;
013000231007                FOCRTBY = 'PRTOLEFRM2';
013100231007                FOCRTDT = %int(%char(%date : *iso0));
013200231007                FOCRTTM = %Dec(%Time);
013300231007                update OE_FORMR;
013400230428                endif;
013500230906                when     %trim(AACOLOR) = 'ORANGE' and
013600230906                         %trim(RunFlag) <> '5';
013700230428                If        %trim(LinkO) = *blanks;
013800230428                linkO = %trim(linkO) + %trim(FOSSID);
013900230626                wOrg = wOrg+1;
014000231007                FOCRTBY = 'PRTOLEFRM2';
014100231007                FOCRTDT = %int(%char(%date : *iso0));
014200231007                FOCRTTM = %Dec(%Time);
014300231007                update OE_FORMR;
014400230428                else;
014500230428                linkO = %trim(linkO) + '|' + %trim(FOSSID);
014600230626                wOrg = wOrg+1;
014700231007                FOCRTBY = 'PRTOLEFRM2';
014800231007                FOCRTDT = %int(%char(%date : *iso0));
014900231007                FOCRTTM = %Dec(%Time);
015000231007                update OE_FORMR;
015100230428                endif;
015200230906                when     %trim(AACOLOR) = 'RED' and
015300230906                         %trim(RunFlag) <> '5';
015400230428                If        %trim(LinkR) = *blanks;
015500230428                linkR = %trim(linkR) + %trim(FOSSID);
015600230626                wRed = wRed+1;
015700231007                FOCRTBY = 'PRTOLEFRM2';
015800231007                FOCRTDT = %int(%char(%date : *iso0));
015900231007                FOCRTTM = %Dec(%Time);
016000231007                update OE_FORMR;
016100230428                else;
016200230428                linkR = %trim(linkR) + '|' + %trim(FOSSID);
016300230626                wRed = wRed+1;
016400231007                FOCRTBY = 'PRTOLEFRM2';
016500231007                FOCRTDT = %int(%char(%date : *iso0));
016600231007                FOCRTTM = %Dec(%Time);
016700231007                update OE_FORMR;
016800230428                endif;
016900230906                when     %trim(AACOLOR) = 'PURPLE' and
017000230906                         %trim(RunFlag) <> '5';
017100230428                If        %trim(LinkP) = *blanks;
017200230428                linkP = %trim(linkP) + %trim(FOSSID);
017300230626                wPur = wPur+1;
017400231007                FOCRTBY = 'PRTOLEFRM2';
017500231007                FOCRTDT = %int(%char(%date : *iso0));
017600231007                FOCRTTM = %Dec(%Time);
017700231007                update OE_FORMR;
017800230428                else;
017900230428                linkP = %trim(linkP) + '|' + %trim(FOSSID);
018000230626                wPur = wPur+1;
018100231007                FOCRTBY = 'PRTOLEFRM2';
018200231007                FOCRTDT = %int(%char(%date : *iso0));
018300231007                FOCRTTM = %Dec(%Time);
018400231007                update OE_FORMR;
018500230428                endif;
018600230906                when     %trim(AACOLOR) = 'YELLOW' and
018700230906                         %trim(RunFlag) <> '5';
018800230428                If        %trim(LinkY) = *blanks;
018900230428                linkY = %trim(linkY) + %trim(FOSSID);
019000230626                wYel = wYel+1;
019100231007                FOCRTBY = 'PRTOLEFRM2';
019200231007                FOCRTDT = %int(%char(%date : *iso0));
019300231007                FOCRTTM = %Dec(%Time);
019400231007                update OE_FORMR;
019500230428                else;
019600230428                linkY = %trim(linkY) + '|' + %trim(FOSSID);
019700230626                wYel = wYel+1;
019800231007                FOCRTBY = 'PRTOLEFRM2';
019900231007                FOCRTDT = %int(%char(%date : *iso0));
020000231007                FOCRTTM = %Dec(%Time);
020100231007                update OE_FORMR;
020200230428                endif;
020300230906                when     %trim(AACOLOR) = 'AMWINS' and
020400230906                         %trim(RunFlag) = '5';
020500230901                If        %trim(LinkE) = *blanks;
020600230906                linkE = %trim(linkE) + %trim(FOSSID);
020700230901                wEDT = wEDT+1;
020800231007                FOCRTBY = 'PRTOLEFRM2';
020900231007                FOCRTDT = %int(%char(%date : *iso0));
021000231007                FOCRTTM = %Dec(%Time);
021100231007                update OE_FORMR;
021200230901                else;
021300230901                linkE = %trim(linkE) + '|' + %trim(FOSSID);
021400230901                wEDT = wEDT+1;
021500231007                FOCRTBY = 'PRTOLEFRM2';
021600231007                FOCRTDT = %int(%char(%date : *iso0));
021700231007                FOCRTTM = %Dec(%Time);
021800231007                update OE_FORMR;
021900230901                endif;
022000231012                When     %trim(AACOLOR) <> 'AMWINS' and
022100231012                         %trim(RunFlag) <> '5';
022200231007                If        %trim(LinkOther) = *blanks;
022300231007                linkOTHER = %trim(linkOTHER) + %trim(FOSSID);
022400231007                wOTHER = wOTHER+1;
022500231007                FOCRTBY = 'PRTOLEFRM2';
022600231007                FOCRTDT = %int(%char(%date : *iso0));
022700231007                FOCRTTM = %Dec(%Time);
022800231007                update OE_FORMR;
022900231007                else;
023000231007                linkOTHER = %trim(linkOTHER) + '|' + %trim(FOSSID);
023100231007                wOTHER = wOTHER+1;
023200231007                FOCRTBY = 'PRTOLEFRM2';
023300231007                FOCRTDT = %int(%char(%date : *iso0));
023400231007                FOCRTTM = %Dec(%Time);
023500231007                update OE_FORMR;
023600231007                endif;
023700230428                endsl;
023800230626
023900230626                select;
024000230821                when    wRed = 25;
024100230626                exsr    Create_Red;
024200230821                when    wBlu = 25;
024300230626                exsr    Create_Blu;
024400230821                when    wYel = 25;
024500230626                exsr    Create_Yel;
024600230821                when    wOrg = 25;
024700230626                exsr    Create_Org;
024800230821                when    wPur = 25;
024900230626                exsr    Create_Pur;
025000230901                when    wEDT = 25;
025100230901                exsr    Create_EDT;
025200231007                when    wOTHER = 25;
025300231007                exsr    Create_OTHER;
025400230626                endsl;
025500230428
025600231009                endif;
025700231020                read  oeforml1;
025800230428                enddo;
025900230626
026000230626                exsr    Create_Red;
026100230626                exsr    Create_Blu;
026200230626                exsr    Create_Yel;
026300230626                exsr    Create_Org;
026400230901                exsr    Create_Pur;
026500231007                exsr    Create_EDT;
026600231007                exsr    Create_OTHER;
026700230428
026800230206     C                   eval      *inlr = *on
026900230206     C                   return
027000230626      *___________________________________________________________________
027100230626      * Red
027200230626      *___________________________________________________________________
027300230626     C     Create_Red    BEGSR
027400230626
027500230626       If      %trim(LinkR) <> *blanks;
027600230626          clear BABATCH;
027700230626                wR = wR+1;
027800230626          FileNamePDF = 'BatchPrint_' + %trim(ENVIR) + '_RED_' +
027900230626          %trim(w80dateCHAR) + '_' + %char(wR) + '.PDF';
028000230626          BABATCH = q + %trim(LinkR) + q + ',' + %trim(RunFlag) + ',' +
028100230626                    q + %trim(FileNamePDF) + q;
028200230626          write OE_BATCHR;
028300230626       endif;
028400230626
028500230626                wRed = 0;
028600230626                LinkR = *blanks;
028700230626
028800230626     C                   ENDSR
028900230626      *___________________________________________________________________
029000230626      * Blue
029100230626      *___________________________________________________________________
029200230626     C     Create_Blu    BEGSR
029300230626
029400230626       If      %trim(LinkB) <> *blanks;
029500230626          clear BABATCH;
029600230626                wB = wB+1;
029700230626          FileNamePDF = 'BatchPrint_' + %trim(ENVIR) + '_BLUE_' +
029800230626          %trim(w80dateCHAR) + '_' + %char(wB) + '.PDF';
029900230626          BABATCH = q + %trim(LinkB) + q + ',' + %trim(RunFlag) + ',' +
030000230626                    q + %trim(FileNamePDF) + q;
030100230626          write OE_BATCHR;
030200230626       endif;
030300230626
030400230626                wBlu = 0;
030500230626                LinkB = *blanks;
030600230626
030700230626     C                   ENDSR
030800230626      *___________________________________________________________________
030900230626      * Purple
031000230626      *___________________________________________________________________
031100230626     C     Create_Pur    BEGSR
031200230626
031300230626       If      %trim(LinkP) <> *blanks;
031400230626          clear BABATCH;
031500230626                wP = wP+1;
031600230626          FileNamePDF = 'BatchPrint_' + %trim(ENVIR) + '_PURPLE_' +
031700230626          %trim(w80dateCHAR) + '_' + %char(wP) + '.PDF';
031800230626          BABATCH = q + %trim(LinkP) + q + ',' + %trim(RunFlag) + ',' +
031900230626                    q + %trim(FileNamePDF) + q;
032000230626          write OE_BATCHR;
032100230626       endif;
032200230626
032300230626                wPur = 0;
032400230626                LinkP = *blanks;
032500230626
032600230626     C                   ENDSR
032700000000      *___________________________________________________________________
032800230626      * Yellow
032900230626      *___________________________________________________________________
033000230626     C     Create_Yel    BEGSR
033100230626
033200230626       If      %trim(LinkY) <> *blanks;
033300230626          clear BABATCH;
033400230626                wY = wY+1;
033500230626          FileNamePDF = 'BatchPrint_' + %trim(ENVIR) + '_YELLOW_' +
033600230626          %trim(w80dateCHAR) + '_' + %char(wY) + '.PDF';
033700230626          BABATCH = q + %trim(LinkY) + q + ',' + %trim(RunFlag) + ',' +
033800230626                    q + %trim(FileNamePDF) + q;
033900230626          write OE_BATCHR;
034000230626       endif;
034100230626
034200230626                wYel = 0;
034300230626                LinkY = *blanks;
034400230626
034500230626     C                   ENDSR
034600230626      *___________________________________________________________________
034700230626      * Orange
034800230626      *___________________________________________________________________
034900230626     C     Create_Org    BEGSR
035000230626
035100230626       If      %trim(LinkO) <> *blanks;
035200230626          clear BABATCH;
035300230626                wO = wO+1;
035400230626          FileNamePDF = 'BatchPrint_' + %trim(ENVIR) + '_ORANGE_' +
035500230626          %trim(w80dateCHAR) + '_' + %char(wO) + '.PDF';
035600230626          BABATCH = q + %trim(LinkO) + q + ',' + %trim(RunFlag) + ',' +
035700230626                    q + %trim(FileNamePDF) + q;
035800230626          write OE_BATCHR;
035900230626       endif;
036000230626
036100230626                wOrg = 0;
036200230626                LinkO = *blanks;
036300230626
036400230626     C                   ENDSR
036500230901      *___________________________________________________________________
036600230914      * EDT - force dashboard(2)
036700230901      *___________________________________________________________________
036800230901     C     Create_EDT    BEGSR
036900230901
037000230901       If      %trim(LinkE) <> *blanks;
037100230901          clear BABATCH;
037200230901                wE = wE+1;
037300230906          FileNamePDF = 'BatchPrint_' + %trim(ENVIR) + '_AMWINS_' +
037400230901          %trim(w80dateCHAR) + '_' + %char(wE) + '.PDF';
037500230907          BABATCH = q + %trim(LinkE) + q + ',2,' +
037600230901                    q + %trim(FileNamePDF) + q;
037700230901          write OE_BATCHR;
037800230901       endif;
037900230901
038000230901                wEDT = 0;
038100230901                LinkE = *blanks;
038200230901
038300230901     C                   ENDSR
038400231007      *___________________________________________________________________
038500231007      * OTHER - new AA group?
038600231007      *___________________________________________________________________
038700231007     C     Create_OTHER  BEGSR
038800231007
038900231007       If      %trim(LinkOTHER) <> *blanks;
039000231007          clear BABATCH;
039100231007                wOTH = wOTH+1;
039200231007          FileNamePDF = 'BatchPrint_' + %trim(ENVIR) + '_OTHER_' +
039300231007          %trim(w80dateCHAR) + '_' + %char(wOTH) + '.PDF';
039400231007          BABATCH = q + %trim(LinkOTHER) + q + ',2,' +
039500231007                    q + %trim(FileNamePDF) + q;
039600231007          write OE_BATCHR;
039700231007       endif;
039800231007
039900231007                wOTHER = 0;
040000231007                LinkOTHER = *blanks;
040100231007
040200231007     C                   ENDSR
040300230626      *___________________________________________________________________
040400000000      * Key Lists
040500000000      *___________________________________________________________________
040600000000     C     KLIST         BEGSR
040700000000     C                   ENDSR
040800000000      *___________________________________________________________________
040900000000      * Program open
041000000000      *___________________________________________________________________
041100000000     C     *INZSR        BEGSR
041200000000     C                   ENDSR
041300000000      *___________________________________________________________________
041400000000      * Program error handler
041500000000      *___________________________________________________________________
041600000000     C     *PSSR         BEGSR
041700000000     C                   CALL      'SNDRPGM'                            50
041800000000     C                   PARM                    WQPGMN
041900000000     C                   PARM                    WQSTSC
042000000000     C                   PARM                    WQRPGS
042100000000     C                   PARM                    WQMSG
042200000000     C                   ENDSR     '*CANCL'
