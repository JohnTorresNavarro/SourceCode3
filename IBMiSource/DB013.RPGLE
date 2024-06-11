0001009102150002 F******************************************************************  DB0121
0002001201310003 F* DB013      GROUP BENEFIT SERVICES SOFTWARE                     *  DB0121
0003009102150004 F*                                                                *  DB0121
0004009102150005 F*            WRITTEN BY - DAVID KETTERMAN                        *  DB0121
0005001201310006 F*            DATE - 11/16/11                                     *  DB0121
0006009102150007 F*                                                                *  DB0121
0007009102150008 F*  DESCRIPTION - THIS PROGRAM WILL FOLLOW DB010 IT CHECKS        *  DB0121
0008001201310009 F*                FOR DEPENDENTS WITHOUT ACTIVE COVERAGE.         *  DB0121
0009009808200014 F*                                                                *
0010001201310015 F* 01/31/12 dlk - convert to csv output                           *
0011001305290014 F* 05/29/2013 SSK - CHANGE MESSAGE FOR FUTURE TERMS
0012001310150014 F* 10/15/2013 SSK - QUANTIFY MESSAGE TO IGNORE SENIOR DENTAL ACCTS
0013001801090014 F* 01/09/2018 RLJ - Add code for Adv Mbl - TSCODE
0014002006050014 F* 01/30/2020 RLJ - Add code for CSMi - TSCODE = O D
0015002106250014 F* 06/05/2020 JVA - Check Spouse SSN for coverage - SP01
0016002007170014 F* 07/17/2020 JVA - Spouse SSN report - SP02
0017002012210014 F* 12/21/2020 B.Rees  br01                                        *
001800201221     C* The Member / Dependent maybe enrollment, but not selecting
001900201221     C* any plans.  ( Waived )   Skip those people on this report.
0020002106250014 F* 04/29/2021 JVA - Fix logic - SP03
0021002106250014 F* 06/25/2021 JVA - Added Prefix to files of SP01
0022002111290014 F* 11/29/2021 JVA - Must exist in MEMMEM - moved chain - SP04
002300201221     F*
0024009102150011 F******************************************************************  DB0121
002500111115     Fdb013j    ip   e           k DISK
0026001111160014 Fdcovc     IF   e           k DISK
002700111114     FAACODE    IF   e           k DISK
002800200721     FTRSMST    IF   e           k DISK
002900200721     FMEMMEM    IF   e           k DISK
003000210625SP01 fmember    if   e           K disk    ExtFile('F.MEMBER') prefix(X_)
003100210625SP01 fdepend    if   e           K disk    ExtFile('F.DEPEND') prefix(Y_)
003200210625SP01 fmcov22    if   e           K disk    ExtFile('F.MCOV22') prefix(Z_)
003300200717SP01 faccmst    if   e           K disk    ExtFile('F.ACCMST') prefix(J_)
0034002007170017 Fdb013xl   o  a e             DISK
003500200717SP02 Fdb013xls  o  a e             DISK
003600200717SP02 Fdb013sxl  if a e           k DISK
0037001201310015 F*EPORT    O    F  132        PRINTER OFLIND(*INOF)
0038001201310125 Dcsv              c                   const('","')
003900120131     derrorout         s             50    inz('DEPEND RECORD WITHOUT ACTIVE -
004000120131     d                                     COVERAGE.')
004100130529     d ERROR2          s             50    inz('DEPEND RECD W/ FUTURE TERM; N-
004200130529     d                                     O ACT COV')
004300130529     D LATEST          S              8S 0
004400130529     D #TODAY          S              8S 0
004500130529     D #ISO            S               D   DATFMT(*ISO)
004600200605
004700210429SP01 d spsfnd          s              1a   inz
004800210429SP03 d spsact          s              1a   inz
004900210429SP03 d depact          s              1a   inz
005000200605SP01 d wwssn           s              9s 0 inz
005100200605SP01 d xxssn           s              9a   inz
005200200605SP01 d ssn4            s              4a   inz
005300200605
0054001201310055 D                 DS
0055001201310056 D  tsa                    1     10  0
0056001201310056 D  mbtrst                 1      3  0
0057001201310056 D  mbsub#                 4      6  0
0058001201310056 D  mbacct                 7     10  0
0059009102150023 D                UDS                                                       DB012
0060009102150024 D  CONAME               201    240                                         DB012
0061009102150025 D  TIME                 242    247  0                                      DB012
006200201221
006300201221br01     dcl-s Skip Char(1);
006400201221
006500201221
0066001111150030 Idb013r
006700111114     I              aacode                      acaacode
006800930209     C*
0069001111140026 C* FOR ONLY ACTIVE DEPEND RECORDS
0070001111160027 C* WHEN NO active COVERAGE RECORD IS FOUND, WRITE OUT ERROR REPORT
0071009102150028 C*
007200201221     C*
007300201221     C* The Member / Dependent maybe enrollment, but not selecting
007400201221     C* any plans.  ( Waived )   Skip those people on this report.
007500201221     C*   B.Rees  12/21/2020
007600201221
007700201221           Skip = 'N';
007800201221           chain dssno Member;
007900201221           if %Found( Member );
008000210625             if x_empst = 'W';
008100201221               Skip = 'Y';
008200201221             EndIf;
008300201221           EndIf;
008400201221
008500201221br01                     if Skip = 'N';
008600201221
008700111114     C                   if        dpdltd = 'A'
008800111116
008900111116     c                   clear                   active            1
009000130529     C                   EVAL      LATEST = 0
0091001111160029 C     dcovkey       setll     dCOVc
009200111116     c                   dou       %eof(dcovc)
009300111116     c     dcovkey       reade     dcovc
009400111116     c                   if        (not %eof(dcovc)) and (ccandt = 0)
009500111116     c                   eval      active = 'Y'
009600111116     c                   leave
009700130529     C                   ELSE
009800130529     C                   IF        LATEST < CCANDT
009900130529     C                   EVAL      LATEST = CCANDT
010000130529     C                   ENDIF
010100111116     c                   end
010200111116     c                   enddo
010300200605
010400200605SP01 c                   if        active <> 'Y'
010500200605SP01 C                   exsr      ChkSpouse
010600200605SP01 C                   end
010700111116
010800111116      * if no active plans, error
010900111116     c                   if        active <> 'Y'
011000111114     c                   add       1             toterr            7 0
011100111116     C                   clear                   AANAM            30
011200111114     C     AAKEY         CHAIN     AACODE
0113001111140030 C                   if        %found(aacode)
011400111114     C     AFNAM         CAT       ALNAM:1       AANAM
011500111114     C                   END
011600120131     c*                  except    error
011700180109      *   Change logic below to look for dental trusts using TSCODE
011800180109     C**********         IF        MBTRST > 24 AND MBTRST < 76
011900180109     C     mbtrst        CHAIN     TRSMST
012000200130     C                   IF        tscode = 'O N' or tscode = 'O M' or
012100200130     C                             tscode = 'O D'
012200131015     C                   exsr      writexldet
012300131015     C                   ELSE
012400130529     C                   IF        #TODAY < LATEST
012500130529     C                   exsr      writexldT2
012600130529     C                   ELSE
012700120131     C                   exsr      writexldet
012800130529     C                   ENDIF
012900131015     C                   ENDIF
013000131015
013100111114     C                   END
013200111114
013300111114     C                   END
013400201221 br01                    endif;
013500201221
013600120131
0137001201310164 C*************************************************************
0138001201310164 C*                                                           *
0139001201310164 C* Write Spreadsheet Detail                                  *
0140001201310164 C*                                                           *
0141001201310164 C*************************************************************
014200120131     C     Writexldet    BEGSR
014300120131
014400120131     c                   clear                   db013fld
014500120131     C                   Eval      db013fld  = '"' +
014600120131     C                             %trim(%editw(dssno:'0   -  -    ')) + csv +
014700120131     C                             %char(dpseq#)                        + csv +
014800120131     C                             %trim(dfname)                        + csv +
014900120131     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
015000120131     C                             %trim(errorout)                      + csv +
015100120131     C                             %trim(acaacode)                      + csv +
015200120131     C                             %trim(aanam)                         + csv +
015300120131     C                             ' '                                  + '",'
015400120131     C*
015500120131     C                   Write     db013xr
0156001201310320 C                   ENDSR
015700120131     C*
0158001305290164 C*************************************************************
0159001305290164 C*                                                           *
0160001305290164 C* Write Spreadsheet Detail                                  *
0161001305290164 C*                                                           *
0162001305290164 C*************************************************************
016300130529     C     WritexldT2    BEGSR
016400130529
016500130529     c                   clear                   db013fld
016600130529     C                   Eval      db013fld  = '"' +
016700130529     C                             %trim(%editw(dssno:'0   -  -    ')) + csv +
016800130529     C                             %char(dpseq#)                        + csv +
016900130529     C                             %trim(dfname)                        + csv +
017000130529     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
017100130529     C                             %trim(error2)                      + csv +
017200130529     C                             %trim(acaacode)                      + csv +
017300130529     C                             %trim(aanam)                         + csv +
017400130529     C                             ' '                                  + '",'
017500130529     C*
017600130529     C                   Write     db013xr
0177001305290320 C                   ENDSR
017800130529     C*
017900130529
018000120131     C*************************************************************
018100120131     C*                                                           *
018200120131     C* Write Spreadsheet heading                                 *
018300120131     C*                                                           *
018400120131     C*************************************************************
018500120131     C     Writexlhead   BEGSR
018600120131
018700120131     c                   clear                   db013fld
018800120131     C                   Eval      db013fld = '"' + 'SS #'              + csv +
018900120131     C                                              'SEQ'               + csv +
019000120131     C                                              'NAME'              + csv +
019100120131     C                                              'ACCOUNT'           + csv +
019200120131     C                                              'ERROR'             + csv +
019300120131     C                                              'AA CODE'           + csv +
019400120131     C                                              'AA NAME'           + csv +
019500120131     C                                              ' '                 + '",'
019600120131     C                   Write     db013xr
019700120131     C*
0198001201310320 C                   ENDSR
019900120131
020000200717     C*************************************************************
020100200717     C*                                                           *
020200200717     C* Write Spreadsheet heading                                 *
020300200717     C*                                                           *
020400200717     C*************************************************************
020500200717     C     Writesphead   BEGSR
020600200717
020700200717     c                   clear                   db013flds
020800200717     C                   Eval      db013flds= '"' + 'SS #'              + csv +
020900200717     C                                              'SEQ'               + csv +
021000200724     C                                              'DEPENDENT NAME'    + csv +
021100200717     C                                              'ACCOUNT'           + csv +
021200200724     C                                              'ACCOUNT NAME'      + csv +
021300200717     C                                              'AA CODE'           + csv +
021400200721     C                                              'AA NAME'           + csv +
021500200724     C                                              'EMPLOYEE SSN '     + csv +
021600200724     C                                              'EMPLOYEE NAME'     + csv +
021700200717     C                                              ' '                 + '",'
021800200717     C                   Write     db013xsr
021900200717     C*
0220002007170320 C                   ENDSR
022100200605SP01  *****************************************************
022200200605SP01 C     ChkSpouse     BEGSR
022300200605
022400210429     C                   eval      spsfnd = *blanks
022500210429SP03 C                   eval      spsact = *blanks
022600210429SP03 C                   eval      depact = *blanks
022700200605     C                   move      dssno         ssn4
022800200605
022900200605     C                   eval      xxssn = '00000' + ssn4
023000200605     C                   move      xxssn         wwssn
023100200605     C     wwssn         chain     member
023200200605     C                   if        %found(member)
023300200605     C                   eval      spsfnd = 'Y'
023400200605     C                   end
023500200605     C                   if        spsfnd = ' '
023600200605     C                   eval      xxssn = '11111' + ssn4
023700200605     C                   move      xxssn         wwssn
023800200605     C     wwssn         chain     member
023900200605     C                   if        %found(member)
024000200605     C                   eval      spsfnd = 'Y'
024100200605     C                   end
024200200605     C                   end
024300200605     C                   if        spsfnd = ' '
024400200605     C                   eval      xxssn = '22222' + ssn4
024500200605     C                   move      xxssn         wwssn
024600200605     C     wwssn         chain     member
024700200605     C                   if        %found(member)
024800200605     C                   eval      spsfnd = 'Y'
024900200605     C                   end
025000200605     C                   end
025100200605     C                   if        spsfnd = ' '
025200200605     C                   eval      xxssn = '33333' + ssn4
025300200605     C                   move      xxssn         wwssn
025400200605     C     wwssn         chain     member
025500200605     C                   if        %found(member)
025600200605     C                   eval      spsfnd = 'Y'
025700200605     C                   end
025800200605     C                   end
025900200605
026000210429      * active only - 111 for coverage
026100200605     C                   if        spsfnd = 'Y'
026200200605     C     SpsKey        Setgt     MCOV22
026300200605     C     SpsKey        Readpe    MCOV22
026400200605     C                   Dow       not %eof(MCOV22)
026500210625     C                   If        Z_CANDT = 0
026600210429SP03 C                   eval      spsact = 'Y'
026700210430SP03 C                   Leave
026800200605     C                   End
026900200605     C     SpsKey        Readpe    MCOV22
027000200605     C                   Enddo
027100210429     C                   end
027200210429
027300210429SP03  * Always setup as dep 01 for 11111*
027400210429SP03 C                   If        spsact = 'Y'
027500210429SP03 C     wwssn         setll     dCOVc
027600210429Sp03 c                   dou       %eof(dcovc)
027700210429Sp03 c     wwssn         reade     dcovc
027800210429Sp03 c                   if        (not %eof(dcovc)) and (ccandt = 0)
027900210430SP03 C                   if        DRELCD = 'RWI' or
028000210430SP03 C                             DRELCD = 'RHU'
028100210429Sp03 C                   eval      depact = 'Y'
028200210430SP03 C                   leave
028300210429Sp03 c                   end
028400210429Sp03 c                   end
028500210429Sp03 c                   enddo
028600210429Sp03 c                   end
028700210429
028800210429sp03  * if missing either one, report it.
028900210429sp03 C                   if        spsact <> 'Y' or
029000210429sp03 C                             depact <> 'Y'
029100210429sp03 C                   exsr      wrtSpouse
029200210429sp03 c                   end
029300200605
029400200717SP01 C                   ENDSR
029500200717SP02 C     wrtSpouse     BEGSR
029600200717     C     ackey         klist
029700200717     c                   kfld                    MBTRST
029800200717     c                   kfld                    MBSUB#
029900200717     c                   kfld                    MBACCT
030000200717     C     wwkey         klist
030100200717     c                   kfld                    wwssn
030200210430     c                   kfld                    dseq#
030300200717     C     ackey         chain     accmst
030400200717     C                   if        not %found(accmst)
030500200717     c                   clear                   J_ACNAM1
030600200717     C                   end
030700200717     C     wwkey         chain     db013sxl
030800200717     C                   eval      d3ssn = wwssn
030900210430     C                   eval      d3seq = dseq#
031000200722     C                   exsr      getSpouse
031100200717     C                   eval      d3tsa = %editc(MBTRST:'X') + '-' +
031200200717     C                                     %editc(MBSUB#:'X') + '-' +
031300200717     C                                     %editc(MBACCT:'X')
031400200717     C                   eval      d3aname = %trim(J_ACNAM1)
031500200717     C                   eval      d3aa    = acaacode
031600200717     C     AAKEY         CHAIN     AACODE
031700200717     C                   if        %found(aacode)
031800200717     C     AFNAM         CAT       ALNAM:1       D3AANAME
031900200717     C                   END
032000200721     C                   clear                   d3mssn
032100200721     C                   clear                   d3mname
032200211129
032300200717     C                   if        not %found(db013sxl)
032400211129
032500211129SP04 C     wwssn         chain     memmem
032600211129 |   C                   if        %found(memmem)
032700211129 |   C     mmorssn       chain     member
032800211129 |   C                   if        %found(member)
032900211129 |   C                   eval      d3mssn  = mmorssn
033000211129 |   C                   eval      d3mname = %trim(mfname) + ' ' +
033100211129 |   C                                       %trim(mmi) + ' ' +
033200211129SP04 C                                       %trim(mlname)
033300200717     C                   write     db013sxr
033400200717
033500200721      * accum report so always write them here
033600200717     c                   clear                   db013flds
033700200717     C                   Eval      db013flds = '"' +
033800200717     C                             %trim(%editw(wwssn:'0   -  -    ')) + csv +
033900200717     C                             %char(D3SEQ)                         + csv +
034000200717     C                             %trim(D3DNAME)                       + csv +
034100200717     C                             %trim(%editw(TSA:'0   -   -    '))   + csv +
034200200717     C                             %trim(D3ANAME)                      + csv +
034300200717     C                             %trim(D3AA)                          + csv +
034400200717     C                             %trim(D3AANAME)                      + csv +
034500200721     C                             %trim(%editw(D3MSSN:'0   -  -    ')) + csv +
034600200721     C                             %trim(D3MNAME)                       + csv +
034700200717     C                             ' '                                  + '",'
034800200717     C*
034900200717     C                   Write     db013xsr
035000210430      * test
035100211129SP04 C                   end
035200211129SP04 C                   end
035300211129     C                   end
035400200717
035500200722SP02 C                   ENDSR
035600200722SP01  *****************************************************
035700200722     C     GetSpouse     BEGSR
035800200722     C                   clear                   d3dname
035900200722     C     wwssn         Setll     DEPEND
036000200722     C     wwssn         Reade     DEPEND
036100200722     C                   Dow       not %eof(DEPEND)
036200210625     C                   If        Y_DRELCD = 'RHU' or
036300210625     C                             Y_DRELCD = 'RWI'
036400210625     C                   eval      d3dname = %trim(Y_dfname) + ' ' +
036500210625     C                                       %trim(Y_dmi) + ' ' +
036600210625     C                                       %trim(Y_dlname)
036700200722     C                   Leave
036800200722     C                   End
036900200722     C     wwssn         Reade     DEPEND
037000200722     C                   Enddo
037100200717SP02 C                   ENDSR
037200200605SP01  *****************************************************
037300111114
037400111114     C     *INZSR        BEGSR
037500130529     C                   EVAL      #ISO = %DATE
037600130529     C                   MOVE      #ISO          #TODAY
0377001111140210 C                   MOVE      *ZEROS        ZERO2
037800111114     C     aakey         KLIST
037900111114     C                   KFLD                    acaacode
038000111114     C                   KFLD                    ZERO2             2 0
038100111116
038200111116     C     dcovkey       KLIST
038300111116     C                   KFLD                    dssno
038400111116     C                   KFLD                    dpseq#
038500210429
038600210429     C     wssnkey       KLIST
038700210429     C                   KFLD                    wwssn
038800210429     C                   KFLD                    dpseq#
038900200605
039000200605SP01 C     SpsKey        Klist
039100210625SP01 C                   Kfld                    X_MBTRST
039200210625SP01 C                   Kfld                    X_MBSUB#
039300210625SP01 C                   Kfld                    X_MBACCT
039400200605SP01 C                   Kfld                    wwSSN
039500120131
039600200717     C                   Exsr      Writexlhead
039700200717     C                   Exsr      Writesphead
039800111114     C                   endsr
039900111114
0400001201310031 O*EPORT    H    1P                  2    03                                DB012
0401001201310032 O*        OR    OF                                                         DB012
0402001201310034 O*                      CONAME              84                             DB012
0403001201310036 O*         H    1P                  2                                      DB012
0404001201310037 O*        OR    OF                                                         DB012
0405001201310038 O*                      UDATE         Y     14                             DB012
0406001201310039 O*                                          76 'DCOV/DEPENDENT AUDIT'
0407001201310041 O*                                         120 'PAGE :'                    DB012
0408001201310042 O*                      PAGE          Z    126                             DB012
0409001201310043 O*         H    1P                  1                                      DB012
0410001201310044 O*        OR    OF                                                         DB012
0411001201310045 O*                                          17 'PROG: DB013'               DB012
0412001201310046 O*                                         120 'TIME :'                    DB012
0413001201310047 O*                      TIME               130 '  :  :  '                  DB012
0414001201310048 O*         H    1P                  1                                      DB012
0415001201310049 O*        OR    OF                                                         DB012
0416001201310050 O*                                          24 '------------------------'  DB012
0417001201310051 O*                                          48 '------------------------'  DB012
0418001201310052 O*                                          72 '------------------------'  DB012
0419001201310053 O*                                          96 '------------------------'  DB012
0420001201310054 O*                                         120 '------------------------'  DB012
0421001201310055 O*                                         132 '------------'              DB012
0422001201310056 O*         H    1P                  1                                      DB012
0423001201310057 O*        OR    OF                                                         DB012
0424001201310058 O*                                           8 'SS #'                      DB012
0425001201310058 O*                                          17 'SEQ'                       DB012
0426001201310058 O*                                          24 'NAME'                      DB012
0427001201310059 O*                                          41 'ACCOUNT'
0428001201310060 O*                                          53 'ERROR'                     DB012
042900120131     O*                                          95 'AA NAME'
0430001201310061 O*         H    1P                  1  1                                   DB012
0431001201310062 O*        OR    OF                                                         DB012
0432001201310063 O*                                          24 '------------------------'  DB012
0433001201310064 O*                                          48 '------------------------'  DB012
0434001201310065 O*                                          72 '------------------------'  DB012
0435001201310066 O*                                          96 '------------------------'  DB012
0436001201310067 O*                                         120 '------------------------'  DB012
0437001201310068 O*                                         132 '------------'              DB012
0438001201310069 O*         e            error          1                                   DB012
0439001201310070 O*                      dssno               12 '0   -  -    '
0440001201310070 O*                      dpseq#              17
0441001201310070 O*                      dfname              32
0442001201310071 O*                      MBTRST              37
0443001201310071 O*                                          38 '-'
0444001201310071 O*                      MBSUB#              41
0445001201310071 O*                                          42 '-'
0446001201310071 O*                      MBACCT              46
0447001201310072 O*                                          69 'DEPEND RECORD WITHOUT'     DB012
0448001201310073 O*                                          85 ' ACTIVE COVERAGE'          DB012
044900120131     O*                      acaacode            91
045000120131     O*                                          93 '-'
045100120131     O*                      AANAM              125
0452001201310135 O*         T    LR                  1  1
0453001201310136 O*                                          13 'TOTAL ERRORS:'
045400120131     O*                      toterr        1     +2
