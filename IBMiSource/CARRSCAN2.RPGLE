000100160311      *========================================================================
000200160311     H option(*noDebugIo)
000300160311      *========================================================================
000400160311      *
000500160311      *  Description: Aetna, Highmark, & Guardian Scan
000600160311      *  Programmer.:
000700160311      *  Date.......:
000800160311      *
000900160311      *-------------------------------------------------------------------------
001000160311      * Modifications
001100160311      *
001200160311      * Date         Programmer    Description
001300160311      * ---------    ----------    ---------------------------------------------
001400160311      * 03/11/2016   J. Torres     Added history and diary files records when
001500160311      *                            transmisson is changed to 'N'.
001600160316      * 03/16/2016   J. Torres     Added grouper code 'VS' per Brandon S.
001700180821      * 08/21/2018   J. Torres     Added call to new send/not send program that
001800180821      *                            maintains new file.
001900181101      * 03/11/2016   J. Torres     Added history and diary files records when
002000181101      *                            transmisson is changed to 'N' for Guardian
002100191018      * 10/18/2019   J. Torres     Removed Kaiser
002200191205      * 10/18/2019   J. Torres     Added UHC (UNET)
002300191205      * 12/13/2019   J. Torres     Added VSP to "Do Not Send" file.
002400191224      * 12/13/2019   J. Torres     Eliminated NVA (by commenting code in case
002500191224      *                            it is needed in the future).
002600200214      * 02/13/2020   J. Torres     Added UH/PRIME
002700200214      * 02/14/2020   J. Torres     Added file to create plans for UHC-Prime
002800200219      * 02/20/2020   J. Torres     Eliminated some carrier codes from UHC.
002900200414      * 04/15/2020   J. Torres     Changed history logical
003000210110      * 01/10/2021   b.Rees        Added Guardian Transmission Log File.
003100210827      * 08/27/2021   J. Torres     Added Avesis
003200211011      * 10/08/2021   b.Rees        Added: Stop Guardian from Turning Off
003300211011      *   Ticket: CR000412     Mod id:  BR01
003301220118      * 12/23/2021   J. Torres     Recompiled for CARRSCANAA email field increase
003302220118      * 01/18/2022   jt            Eliminated CARRSCANAA, use AACODE instead.
003400160311      *=========================================================================
003500220118     FACMUNIQUE IF   E           K DISK    prefix(m_)
003501220118
003600120517     FCOMCTUNIQ IF   E           K DISK
003601220118
003700120517     FPLNUNIQUE IF   E           K DISK
003701220118
003800120517     FCARUNIQUE IF   E           K DISK
003801220118
003900120517     FMCOVAPSE  IF   E           K DISK
003901220118
004000120517     FCARPTRKP  UF A E           K DISK
004001220118
004100120517     FGRATEINQ  IF   E           K DISK
004101220118
004200220118     faacode    if   e           k disk
004201220118
004300120806     FCARACCX   UF   E           K DISK
004301220118
004400120806     FCARXPTP   IF   E           K DISK
004401220118
004500160314     FDIARYHD1  if a E           K DISK    EXTFILE('F.DIARYHD1')
004501220118
004600200414     FHISTL11   if a E           K DISK    EXTFILE('F.HISTL11')
004700210110
004800210110       dcl-f Guartlogp keyed usage(*output);
004900210110
005000200214     fuhcplancrtif a e           k disk    rename(uhcpcr:createPlan)
005100160311
005200120517     FT500      O  A F  500        DISK
005300200214
005400150514      *------------------------------------------------------------
005500120517     D X               S            500A   INZ
005600111005     D A               S              1A   INZ('1')
005700220118     D H_TRST          S                   LIKE(m_ACTRST)
005800220118     D H_SUB#          S                   LIKE(m_ACSUB#)
005900220118     D H_ACCT          S                   LIKE(M_ACACCT)
006000120517     D H_PLAN          S                   LIKE(CMPLAN)
006100181228     d nhkey2          s             10
006200181228     d nhaddt2         s              8  0
006300181228     d nhadti2         s              6  0
006400181228     d hkey2           s             10
006500160311
006600160509     D holdStatus      s              1
006700180821     d incarrier       s              2  0
006800180821     d option          s              1
006900181101     d subject         s             30
007000160509
007100180821     d dltadd          pr                  ExtPgm('TROFF3')
007200180821     d  catrst                        3  0
007300180821     d  casub#                        3  0
007400180821     d  caacct                        4  0
007500180821     d  incarrier                     2  0
007600180821     d  option                        1
007700200214
007800200214     d createPlans     pr                  ExtPgm('UHCPLANC')
007900180821
008000160311      *=====================================================================
008100120517     C                   DOU       A = 'X'
008200120517     C     A             CASEQ     '1'           $1
008300120517     C     A             CASEQ     '2'           $2
008400120517     C     A             CASEQ     '3'           $3
008500120517     C                   ENDCS
008600120517     C                   ENDDO
008700150514     C
008800120517     C                   EVAL      *INLR = *ON
008900150514      *------------------------------------------------------------
009000120517     C     $1            BEGSR
009100150514     C
009200120517     C     KL#TSAP       KLIST
009300220118     C                   KFLD                    m_ACTRST
009400220118     C                   KFLD                    m_ACSUB#
009500220118     C                   KFLD                    m_ACACCT
009600120517     C                   KFLD                    CMPLAN
009700150514     C
009800120517     C     KL#TSA        KLIST
009900220118     C                   KFLD                    m_ACTRST
010000220118     C                   KFLD                    m_ACSUB#
010100220118     C                   KFLD                    m_ACACCT
010200150514     C
010300120517     C     KL#TSP        KLIST
010400120517     C                   KFLD                    CMTRST
010500120517     C                   KFLD                    CSUBDV
010600120517     C                   KFLD                    CMPLAN
010700150514     C
010800120517     C                   EVAL      X = '"TRUST","SUB","ACCT","ACCT NAME","PLA' +
010900120517     C                             'N","PLAN NAME","RATE FROM","RATE TO","CAR' +
011000120517     C                             'R CODE","CARR NAME","GROUP NBR","LIVES","' +
011100120719     C                             'NOTES","AA CODE"'
011200120517     C                   EXCEPT    OUTF
011300150514     C
011400120517     C                   EVAL      A = '2'
011500150514     C
011600120517     C                   ENDSR
011700150514      *------------------------------------------------------------
011800120517     C     $2            BEGSR
011900150514     C
012000120517     C                   READ      ACCMSR
012100120517     C                   IF        %EOF(ACMUNIQUE)
012200120517     C                   EVAL      A = 'X'
012300120517     C                   LEAVESR
012400120517     C                   ENDIF
012500150514     C
012600220118     C                   IF        m_ATRMDT <> 0
012700120517     C                   LEAVESR
012800120517     C                   ENDIF
012900150514     C
013000120517     C     KL#TSA        CHAIN     COMCXR
013100120517     C                   IF        NOT %FOUND(COMCTUNIQ)
013200120517     C                   LEAVESR
013300150514     C                   ENDIF
013400150514     C
013500120517     C     KL#TSA        SETLL     COMCXR
013600120517     C                   EVAL      A = '3'
013700150514     C
013800120517     C                   ENDSR
013900150514      *------------------------------------------------------------
014000150514     C     $3            BEGSR
014100150514     C
014200120517     C     KL#TSA        READE     COMCXR
014300120517     C                   IF        %EOF(COMCTUNIQ)
014400120517     C                   EVAL      A = '2'
014500120517     C                   LEAVESR
014600120517     C                   ENDIF
014700150514     C
014800120517     C                   IF        CMCAN <> 0
014900120517     C                   LEAVESR
015000120517     C                   ENDIF
015100150514     C
015200220118          if H_TRST <> m_ACTRST OR
015300220118           H_SUB# <> m_ACSUB# OR
015400220118           H_ACCT <> m_ACACCT OR
015500220118          H_PLAN <> CMPLAN;
015600220118     C                   EVAL      H_TRST = m_ACTRST
015700220118     C                   EVAL      H_SUB# = m_ACSUB#
015800220118     C                   EVAL      H_ACCT = m_ACACCT
015900120517     C                   EVAL      H_PLAN = CMPLAN
016000120517     C                   ELSE
016100120517     C                   LEAVESR
016200120517     C                   ENDIF
016300150514     C
016400120517     C     KL#TSP        CHAIN     PLNMSR
016500120517     C                   IF        NOT %FOUND(PLNUNIQUE)
016600120517     C                   LEAVESR
016700120517     C                   ENDIF
016800150514     C
016900120517     C     PCARR         CHAIN     CARMSR
017000120517     C                   IF        NOT %FOUND(CARUNIQUE)
017100120517     C                   LEAVESR
017200120517     C                   ENDIF
017300150514     C
017400140429     C                   IF        CGRPCD <> 'AH' AND
017500160316     C                             CGRPCD <> 'GA' AND
017600140429     C                             CGRPCD <> 'HU' AND
017700150514     C                             CGRPCD <> 'HI' AND
017800191205     C                             CGRPCD <> 'CI' AND
017900191205     C                             CGRPCD <> 'VS' AND
018000191205     C                             CGRPCD <> 'NV' AND
018100210827     C                             CGRPCD <> 'AV' AND
018200191205     C                             CGRPCD <> 'UH'
018300150514     C                   LEAVESR
018400150514     C                   ENDIF
018500191205
018600200219        //if cgrpcd = 'UH';
018700200219        // if carrcd <> 'ULH' and
018800200219        //  carrcd <> 'ULP' and
018900200219        //   carrcd <> 'ULD' and
019000200219        //  carrcd <> 'ULV';
019100200219        //  leavesr;
019200200219        // endif;
019300200219        //endif;
019400200214
019500200219        if cgrpcd = 'UH';
019600200219         if carrcd = 'UHL' or carrcd = 'UH2'
019700200219          or carrcd = 'UHC' or carrcd = 'UHO';
019800200219          leavesr;
019900200219         endif;
020000200219        endif;
020100200214
020200200214        if cgrpcd = 'UH';
020300200219         exsr create_primePlans;
020400200214        endif;
020500150514     C
020600150514     C                   MOVE      *BLANKS       @CHGS           300
020700150514     C                   MOVE      *BLANKS       @MSG            100
020800150514     C
020900150514     C                   EXSR      $RATE
021000150514     C
021100150514     C                   EXSR      $COUNT
021200150514     C
021300120517     C     KL#TSAP       CHAIN     FCRT
021400120517     C                   IF        %FOUND(CARPTRKP)
021500120517     C                   EXSR      $CHKIT
021600120517     C                   ELSE
021700120517     C                   EXSR      $MAKEIT
021800120517     C                   ENDIF
021900150514     C
022000120517     C                   ENDSR
022100150514     C
022200150514      *------------------------------------------------------------
022300150514     C     $CHKIT        BEGSR
022400150514     C
022500150514     C                   IF        FCGRP <> @G
022600150514     C                   EVAL      @MSG = 'GROUP # CHANGED'
022700150514     C                   EXSR      $AD2CHGS
022800150514     C                   ENDIF
022900150514     C
023000150514     C                   IF        #FR <> FCRFR
023100150514     C                   EVAL      @MSG = 'NEW RATES ADDED'
023200150514     C                   EXSR      $AD2CHGS
023300150514     C                   ENDIF
023400150514     C
023500150514     C                   IF        #FR = FCRFR AND #TO <> FCRTO
023600150514     C                   EVAL      @MSG = 'RATES EXTENDED'
023700150514     C                   EXSR      $AD2CHGS
023800150514     C                   ENDIF
023900150514     C
024000150514     C                   IF        PDESCR <> FCDESC
024100150514     C                   EVAL      @MSG = 'PLAN DESC CHANGED'
024200150514     C                   EXSR      $AD2CHGS
024300150514     C                   ENDIF
024400150514     C
024500150514     C                   IF        @CHGS <> *BLANKS
024600150514     C                   EVAL      FCGRP = @G
024700150514     C                   EVAL      FCRFR = #FR
024800150514     C                   EVAL      FCRTO = #TO
024900150514     C                   EVAL      FCDESC = PDESCR
025000190404     C                   UPDATE    FCRT
025100190404
025200150514     C                   EXSR      $PRINTIT
025300150514     C                   ENDIF
025400150514     C
025500120517     C                   ENDSR
025600150514     C
025700150514      *------------------------------------------------------------
025800150514     C     $AD2CHGS      BEGSR
025900150514     C
026000150514     C                   MOVE      *ZEROS        #3                3 0
026100150514     C                   EVAL      #3 = %LEN(@CHGS)
026200150514     C
026300150514     C                   IF        #3 = 0
026400150514     C                   EVAL      @CHGS = %TRIM(@MSG)
026500150514     C                   LEAVESR
026600150514     C                   ENDIF
026700150514     C
026800150514     C                   IF        @CHGS = *BLANKS
026900150514     C                   EVAL      @CHGS = %TRIM(@MSG)
027000150514     C                   ELSE
027100150514     C                   EVAL      @CHGS = %TRIM(@CHGS) +
027200150514     C                             '; ' + %TRIM(@MSG)
027300150514     C                   ENDIF
027400150514     C
027500120517     C                   ENDSR
027600150514      *------------------------------------------------------------
027700150514     C     $MAKEIT       BEGSR
027800150514     C
027900150514     C                   CLEAR                   FCRT
028000150514     C
028100220118     C                   EVAL      FCTRS = m_ACTRST
028200220118     C                   EVAL      FCSUB = m_ACSUB#
028300220118     C                   EVAL      FCACC = m_ACACCT
028400150514     C                   EVAL      FCPLN = CMPLAN
028500150514     C                   EVAL      FCGRP = @G
028600150514     C                   EVAL      FCRFR = #FR
028700150514     C                   EVAL      FCRTO = #TO
028800150514     C
028900190404     C                   WRITE     FCRT
029000150514     C
029100150514     C                   EVAL      @MSG = 'NEW ACCOUNT/PLAN'
029200150514     C                   EXSR      $AD2CHGS
029300150514     C
029400150514     C     KL#TSA        CHAIN     CARACCR
029500150514     C                   IF        %FOUND(CARACCX)
029600150514     C                   EXSR      $SHUTOFF
029700190610     C                   ENDIF
029800181213
029900150514     C                   EXSR      $PRINTIT
030000150514     C
030100150514     C                   ENDSR
030200150514      *------------------------------------------------------------
030300150514     C     $SHUTOFF      BEGSR
030400150514     C
030500150514     C     KL#TSA        SETLL     CARACCR
030600150514     C                   DOU       %EOF(CARACCX)
030700150514     C     KL#TSA        READE     CARACCR
030800150514     C                   IF        NOT %EOF(CARACCX)
030900150514     C
031000150514     C     CAUNIQ        CHAIN     CARXPTR
031100150514     C                   IF        NOT %FOUND(CARXPTP)
031200150514     C                   ITER
031300150514     C                   ENDIF
031400150514     C
031500211008br01     // Dont Turn off Guardian!
031600211008 |          if cgrpcd = 'GA';
031700211008 |             iter;
031800211008 |          endif;
031900211008 |
032000211008
032100211008     C
032200160509     c                   eval      holdStatus = CASTATUS
032300160509
032400150514     C                   IF        CXGRPD = CGRPCD
032500150514     C                   EVAL      CASTATUS = 'N'
032600150514     C                   EVAL      @MSG  = '**PRIORITY** TRAN' +
032700150514     C                             'SMISSION SHUTOFF, RESEARCH IMMEDIATELY!'
032800150514     C                   EXSR      $AD2CHGS
032900190404     C                   UPDATE    CARACCR
033000160509
033100210110          if cgrpcd = 'GA';
033200210110            // Write to Transmission Log File.
033300210110            glUniq = cauniq;
033400220118            glTrst = m_acTrst;
033500220118            glSub# = m_acSub#;
033600220118            glacct = m_acAcct;
033700210110            glStatus = caStatus;
033800210110            glNotes = 'Turned off with CarrScan';
033900210110            glPgm = 'CARRSCAN2';
034000210110            glUser = 'CARRSCAN2';
034100210110            glDate = %Dec(%Date);
034200210110            glTime = %Dec(%Time);
034300210110
034400210110            write GuartLogr;
034500210110
034600210110          EndIf;
034700210110
034800210110
034900210110
035000160509     c                   if        holdStatus = 'Y'
035100160509     c                   exsr      diaryNote
035200160509     c                   endif
035300160509
035400180821       exsr turnOn_Off;
035500180821
035600150514     C                   LEAVESR
035700150514     C                   ENDIF
035800150514     C
035900150514     C                   ENDIF
036000150514     C                   ENDDO
036100150514     C
036200150514     C                   ENDSR
036300160311
036400200214       //=======================================================================
036500200214       // create plans for UHC-Prime
036600200214       //=======================================================================
036700200214
036800200214       begsr create_primePlans;
036900200214
037000200214        if carrcd = 'AUM'
037100200219         or carrcd = 'UHD'
037200200219          or carrcd = 'UHH'
037300200219          or carrcd = 'UHP'
037400200214         or carrcd = 'UHV';
037500200214
037600220118         chain (m_actrst : m_acsub# : m_acacct : cmplan) createPlan;
037700200214         if not %found;
037800220118          ptrst = m_actrst;
037900220118           psub# = m_acsub#;
038000220118            pacct = m_acacct;
038100200214             pplan = cmplan;
038200200214            pcarcd = carrcd;
038300200214           pprocessed = ' ';
038400200214          write createPlan;
038500200214
038600200219          //createPlans();
038700200214
038800200214         endif;
038900200214
039000200214        endif;
039100200214
039200200214       endsr;
039300200214
039400160311       //=======================================================================
039500160311       // Diary Note
039600160311       //=======================================================================
039700160311
039800160311       begsr diaryNote;
039900160311
040000181101        if cgrpcd = 'AH'
040100181212         or cgrpcd = 'GA'
040200191205          or cgrpcd = 'HI'
040300191205           or cgrpcd = 'UH'
040400191205            or cgrpcd = 'VS'
040500191224             //or cgrpcd = 'NV'
040600191205              or cgrpcd = 'CI'
040700210827               or cgrpcd = 'HU'
040800210827               or cgrpcd = 'AV';
040900160401
041000181101         select;
041100181101          when cgrpcd = 'AH';
041200181101           subject = 'AETNA-TRANSMISSION TURNED OFF';
041300181101          when cgrpcd = 'GA';
041400181101           subject = 'GUARDN-TRANSMISSION TURNED OFF';
041500181212          when cgrpcd = 'HI';
041600181212           subject = 'HGHMRK-TRANSMISSION TURNED OFF';
041700191205          when cgrpcd = 'UH';
041800191205           subject = 'UHC-TRANSMISSION TURNED OFF';
041900191205          when cgrpcd = 'VS';
042000191205           subject = 'VSP-TRANSMISSION TURNED OFF';
042100191224          //when cgrpcd = 'NV';
042200191224          // subject = 'NVA-TRANSMISSION TURNED OFF';
042300191205          when cgrpcd = 'HU';
042400191205           subject = 'HUM-TRANSMISSION TURNED OFF';
042500191205          when cgrpcd = 'CI';
042600191205           subject = 'CIGNA-TRANSMISSION TURNED OFF';
042700210827          when cgrpcd = 'AV';
042800210827           subject = 'AVESIS-TRANSMISSION TURNED OFF';
042900181101         endsl;
043000181101
043100220118         nhkey2 = %editc(m_actrst:'X') + %editc(m_acsub#:'X') +
043101220118                  %editc(m_acacct:'X');
043200181228         nhaddt2 = %dec(%date);
043300181228         nhadti2 = %dec(%time);
043400160311
043500181228         chain (nhkey2 : nhaddt2 : nhadti2) rdiaryhd;
043600181101         if not %found;
043700181228          clear rdiaryhd;
043800181228           nhkey = nhkey2;
043900181228            nhcode = 'WFT';
044000181228             nhsubj = subject;
044100181228             nhaddt = nhaddt2;
044200181228            nhadti = nhadti2;
044300181228           nhadus = 'CARRSCAN2';
044400190404          write rdiaryhd;
044500181101         endif;
044600160311
044700220118         hkey2 = %editc(m_actrst:'X') + %editc(m_acsub#:'X') +
044701220118                 %editc(m_acacct:'X');
044800200414         chain (hkey2 : 'UHM' : %dec(%date) : subject) histr;
044900181214         if not %found;
045000181214          clear histr;
045100181228           hkey = hkey2;
045200181228            trcode = 'UHM';
045300181228             ck#not = subject;
045400181228              hprgnm = 'CARRSCAN2';
045500181228               hstrst = catrst;
045600181228                hssub# = casub#;
045700181228               hsacct = caacct;
045800181228              hsdltd = 'A';
045900181228             trdate = %dec(%date);
046000181228            hstrtime = %time;
046100181228           hoper = 'ROBOT';
046200190404          write histr;
046300181214         endif;
046400181101
046500181101        endif;
046600160311
046700160311       endsr;
046800160311
046900180821       //=======================================================================
047000180821       // turn on/off
047100160311       //=======================================================================
047200160311
047300180821       begsr turnOn_Off;
047400180821
047500180821        select;
047600180821         when holdStatus = 'N';
047700180821          option = 'A';
047800180821
047900180821         when holdStatus = 'Y';
048000180821          option = 'D';
048100180821        endsl;
048200180821
048300180821        select;
048400180821         when cgrpcd = 'AH';
048500180821          if cauniq = '0000000011';
048600180821           incarrier = 6;
048700180821          endif;
048800180821
048900180821          if cauniq = '0000000127';
049000180821           incarrier = 7;
049100180821          endif;
049200180821
049300180821         when cgrpcd = 'HU';
049400180821          incarrier = 3;
049500180821
049600180821         when cgrpcd = 'HI';
049700181212          incarrier = 12;
049800180821
049900180821         when cgrpcd = 'CI';
050000180821          incarrier = 8;
050100180821
050200180821         when cgrpcd = 'VS';
050300180821          incarrier = 9;
050400180821
050500191224         //when cgrpcd = 'NV';
050600191224         // incarrier = 11;
050700191205
050800181107         when cgrpcd = 'GA';
050900181107          incarrier = 13;
051000191205
051100191205         when cgrpcd = 'UH';
051200191205          incarrier = 17;
051300210827
051400210827         when cgrpcd = 'AV';
051500210827          incarrier = 10;
051600180821        endsl;
051700180821
051800180821        dltadd(catrst : casub# : caacct : incarrier : option);
051900180821
052000180821       endsr;
052100180821
052200180821       //=======================================================================
052300150514     C     $COUNT        BEGSR
052400150514     C
052500150514     C                   MOVE      *ZEROS        #C                9 0
052600150514     C
052700150514     C     KL#TSAP       CHAIN     MCOVR
052800150514     C                   IF        NOT %FOUND(MCOVAPSE)
052900120517     C                   LEAVESR
053000150514     C                   ENDIF
053100150514     C
053200150514     C     KL#TSAP       SETLL     MCOVR
053300150514     C                   DOU       %EOF(MCOVAPSE)
053400150514     C     KL#TSAP       READE     MCOVR
053500150514     C                   IF        NOT %EOF(MCOVAPSE) AND
053600150514     C                             CANDT = 0
053700150514     C
053800150514     C                   ADD       1             #C
053900150514     C
054000150514     C                   ENDIF
054100150514     C                   ENDDO
054200150514     C
054300120517     C                   ENDSR
054400150514      *------------------------------------------------------------
054500120517     C     $RATE         BEGSR
054600150514     C
054700150514     C                   MOVE      *ZEROS        #FR               8 0
054800150514     C                   MOVE      *ZEROS        #TO               8 0
054900150514     C                   MOVE      *BLANKS       @G               15
055000150514     C
055100150514     C     KL#TSP        CHAIN     GRATER
055200150514     C                   IF        NOT %FOUND(GRATEINQ)
055300150514     C                   LEAVESR
055400150514     C                   ENDIF
055500150514     C
055600150514     C     KL#TSP        SETGT     GRATER
055700150514     C     KL#TSP        READPE    GRATER
055800150514     C                   EVAL      #FR = FRMDAT
055900150514     C                   EVAL      #TO = TODAT
056000150514     C                   EVAL      @G = GROUP#
056100150514     C
056200120517     C                   ENDSR
056300150514      *------------------------------------------------------------
056400120517     C     $PRINTIT      BEGSR
056500150514     C
056600220118     C     m_AACODE      CHAIN     AACODR
056700150514     C
056800150514     C                   EVAL      X = '"' + %CHAR(FCTRS) + '","' +
056900150514     C                             %CHAR(FCSUB) + '","' + %CHAR(FCACC) + '","' +
057000220118     C                             %TRIM(m_ACNAM1) + '","' + FCPLN + '","' +
057100150514     C                             %TRIM(PDESCR) + '","' +
057200150514     C                             %EDITW(FCRFR:'    /  /  ') + '","' +
057300150514     C                             %EDITW(FCRTO:'    /  /  ') + '","' +
057400150514     C                             PCARR + '","' + %TRIM(CNAME) + '","' +
057500150514     C                             %TRIM(FCGRP) + '","' + %CHAR(#C) +
057600150514     C                             '","' + %TRIM(@CHGS) + '","'
057700150514     C                             + %TRIM(AFNAM) + ' ' + %TRIM(ALNAM) + '"'
057800150514     C
057900150514     C                   EXCEPT    OUTF
058000150514     C
058100150514     C                   ENDSR
058200150514     C*------------------------------------------------------------
058300120517     OT500      EADD         OUTF
058400120517     O                       X              B   500
